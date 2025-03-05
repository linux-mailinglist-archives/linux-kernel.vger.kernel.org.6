Return-Path: <linux-kernel+bounces-546873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D72A4FFC8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE7D4176B30
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87572500D0;
	Wed,  5 Mar 2025 13:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YSAVbsum"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2075424BC11
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 13:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741180032; cv=none; b=fbnaU4fjmvw4GWisIV/aU72jHh8bkq1UZpxr38DAS0s1dJ4bXquSe39nBi++u3McDU5jVEWYpJvwUraK7Y/W4enlouPg0y8zDgVOQY4kAOM79jkMscBnENGbRDSIsq0ExGaqsOdwTCROuJZH2G8morAc0nd4W0n2thN+q+QGyUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741180032; c=relaxed/simple;
	bh=XAtG5u7idPVpuMFTd9Koq5IM2tTyJz37vBrZlH8EmTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VBVX5mnpvSkRd1NO5iAs9D0tdCTP0wgR6N+NH2tWTtB80/SbPm5bLQvJnTaFojtK7xGSY+TMM0VwYEtHlnGHskH0qi8KtvrDIDcZzW0D1V0ifDqjkgg0HB+oz4k7inCskOGs30MpPezwSE2kgIPigywqlwpW08j6XyPXYWYKEW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YSAVbsum; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e4bed34bccso9604999a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 05:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741180028; x=1741784828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZWcwQgxJYl5xqresVhiMdi9+ZPx9Y4Kk8m/1lcEjeM=;
        b=YSAVbsum5y6ZoMUHvf6pcru8XH33NDSgO/v/BmUbbtawygmXjUwd0psizBuMUEcE6e
         t8uBf6igQyQqOBBcaZ4H50NrxJ3w+rw/Zqxn0cjO5ThpGBsKJRmcL2u6BX+pLK32ZUXH
         8rwc7LLeaB2TXGMWZ2Iza32IqSsyHlifFPedFToWDDjvdry6nxLuI2IeqLzg9ZB0T/ft
         uO2YSeiD3IrIo1s37fPn9NLn0r3tGrp2EMR2t186lIaqd/PWpY8aXxz7OQwXOGOnRoqU
         m39BB1tHYvAb6BlMxW4LHcox9UYfZ7MEhm/4ZJGW4wGMkT86gxvLS1LQIHNNCBKdvyoc
         aWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741180028; x=1741784828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZWcwQgxJYl5xqresVhiMdi9+ZPx9Y4Kk8m/1lcEjeM=;
        b=VYiNEwjmFsIKyhc8UwJXKKKZzvcPY8mqyVW0uNr1byCyJY84eRgu7D5vfJzOqe75+S
         IXkmsShdPNJWITkzsgQHFZeQmBNs+mcIlMaBVyhhNBX2UCEnOs7UGJYTqmQg/ltg2hEM
         Ogzt59AVDPh3VTjJX/V0mcJgsS3049hBMXcGvTI5ttjSZkMWWd0Wr5ji+695G1wAVYtB
         qyH1R9GV8vB9LNSB1eoSVzG7A/5T0u/mOyjgQGUulf6ru1whtWFjE+qUetxIXGtSZgRY
         hoNKcoWjRRAXzEUEU3m9BLbSxb7f3K68m+0PAUp69TNr6c2R8S0MMwRCoS8lqgU12g3l
         631g==
X-Gm-Message-State: AOJu0YwoH2hWHOsmGZrBxFgOFQc5xsmADBdAVSATP2bTG/0fmV7e43dT
	XuaAHSFLvLT3s0MR9FOT5YRiqFhaEEpEfyj++GApzz09vbV3xdrrwGS09AZoPLCK5esTqtH9R/J
	BC9I=
X-Gm-Gg: ASbGnctn+KezXjtXlLgVghejA2bgkMRjBaMvRk9027haDGJ5D7Zz0nXrxKodl6llRxs
	2/ftRJQJ4P8B0DIltv6A4A7JHKTWXdrq2cV2bSTvsNjUxQhtHV0GDzqLR54kJRVzLHw4EjoPGxm
	qIfYWswrLlCnScoHLZ5CoPBrlFJkLWvdZjLwghAy22wL36hw/3vyb+ChgopqRZqfFO6yDpIZiyn
	fsKfqYZ9N7Rkae+Gg3iyePiEJb/RO6MZ0MR8z5NH+37xMccY7EdT1O7ZSYmt3QzKlUeouD69Db4
	ZDQ6gft9UWxgG/3TuYwSoTYpyibTzjJa9rJA6Z1liF7oPn9GMMuECNVeHGmZoNA3nb3eOiaJCrt
	jqi5qcus0yDUeZ5WWPVRIxw==
X-Google-Smtp-Source: AGHT+IEU8qhj3jZr5pC33H3BKUPYoPOJwyx39WdATtL+5/RDhfCQ1+ckzcmgDPihiiWE9zWeUGcUMw==
X-Received: by 2002:a05:6402:13d1:b0:5e4:99af:b7c with SMTP id 4fb4d7f45d1cf-5e59f384aebmr3091724a12.9.1741180027839;
        Wed, 05 Mar 2025 05:07:07 -0800 (PST)
Received: from rayden.urgonet (h-98-128-140-123.A175.priv.bahnhof.se. [98.128.140.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5bcd1595bsm65714a12.42.2025.03.05.05.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 05:07:06 -0800 (PST)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	op-tee@lists.trustedfirmware.org,
	linux-arm-kernel@lists.infradead.org
Cc: Olivier Masse <olivier.masse@nxp.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Yong Wu <yong.wu@mediatek.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	"T . J . Mercier" <tjmercier@google.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sumit Garg <sumit.garg@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	azarrabi@qti.qualcomm.com,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Daniel Stone <daniel@fooishbar.org>,
	Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v6 10/10] optee: smc abi: dynamic restricted memory allocation
Date: Wed,  5 Mar 2025 14:04:16 +0100
Message-ID: <20250305130634.1850178-11-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250305130634.1850178-1-jens.wiklander@linaro.org>
References: <20250305130634.1850178-1-jens.wiklander@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support in the OP-TEE backend driver for dynamic restricted memory
allocation using the SMC ABI.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/smc_abi.c | 96 +++++++++++++++++++++++++++++++------
 1 file changed, 81 insertions(+), 15 deletions(-)

diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index a14ff0b7d3b3..aa574ee6e277 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -1001,6 +1001,69 @@ static int optee_smc_do_call_with_arg(struct tee_context *ctx,
 	return rc;
 }
 
+static int optee_smc_lend_rstmem(struct optee *optee, struct tee_shm *rstmem,
+				 u16 *end_points, unsigned int ep_count,
+				 u32 use_case)
+{
+	struct optee_shm_arg_entry *entry;
+	struct optee_msg_arg *msg_arg;
+	struct tee_shm *shm;
+	u_int offs;
+	int rc;
+
+	msg_arg = optee_get_msg_arg(optee->ctx, 2, &entry, &shm, &offs);
+	if (IS_ERR(msg_arg))
+		return PTR_ERR(msg_arg);
+
+	msg_arg->cmd = OPTEE_MSG_CMD_LEND_RSTMEM;
+	msg_arg->params[0].attr = OPTEE_MSG_ATTR_TYPE_VALUE_INPUT;
+	msg_arg->params[0].u.value.a = use_case;
+	msg_arg->params[1].attr = OPTEE_MSG_ATTR_TYPE_TMEM_INPUT;
+	msg_arg->params[1].u.tmem.buf_ptr = rstmem->paddr;
+	msg_arg->params[1].u.tmem.size = rstmem->size;
+	msg_arg->params[1].u.tmem.shm_ref = (u_long)rstmem;
+
+	rc = optee->ops->do_call_with_arg(optee->ctx, shm, offs, false);
+	if (rc)
+		goto out;
+	if (msg_arg->ret != TEEC_SUCCESS) {
+		rc = -EINVAL;
+		goto out;
+	}
+	rstmem->sec_world_id = (u_long)rstmem;
+
+out:
+	optee_free_msg_arg(optee->ctx, entry, offs);
+	return rc;
+}
+
+static int optee_smc_reclaim_rstmem(struct optee *optee, struct tee_shm *rstmem)
+{
+	struct optee_shm_arg_entry *entry;
+	struct optee_msg_arg *msg_arg;
+	struct tee_shm *shm;
+	u_int offs;
+	int rc;
+
+	msg_arg = optee_get_msg_arg(optee->ctx, 1, &entry, &shm, &offs);
+	if (IS_ERR(msg_arg))
+		return PTR_ERR(msg_arg);
+
+	msg_arg->cmd = OPTEE_MSG_CMD_RECLAIM_RSTMEM;
+	msg_arg->params[0].attr = OPTEE_MSG_ATTR_TYPE_RMEM_INPUT;
+	msg_arg->params[0].u.rmem.shm_ref = (u_long)rstmem;
+
+	rc = optee->ops->do_call_with_arg(optee->ctx, shm, offs, false);
+	if (rc)
+		goto out;
+	if (msg_arg->ret != TEEC_SUCCESS)
+		rc = -EINVAL;
+
+out:
+	optee_free_msg_arg(optee->ctx, entry, offs);
+	return rc;
+}
+
 /*
  * 5. Asynchronous notification
  */
@@ -1252,6 +1315,8 @@ static const struct optee_ops optee_ops = {
 	.do_call_with_arg = optee_smc_do_call_with_arg,
 	.to_msg_param = optee_to_msg_param,
 	.from_msg_param = optee_from_msg_param,
+	.lend_rstmem = optee_smc_lend_rstmem,
+	.reclaim_rstmem = optee_smc_reclaim_rstmem,
 };
 
 static int enable_async_notif(optee_invoke_fn *invoke_fn)
@@ -1622,11 +1687,13 @@ static inline int optee_load_fw(struct platform_device *pdev,
 
 static int optee_sdp_pool_init(struct optee *optee)
 {
+	bool sdp = optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_SDP;
+	bool dyn_sdp = optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_RSTMEM;
 	enum tee_dma_heap_id heap_id = TEE_DMA_HEAP_SECURE_VIDEO_PLAY;
-	struct tee_rstmem_pool *pool;
-	int rc;
+	struct tee_rstmem_pool *pool = ERR_PTR(-EINVAL);
+	int rc = -EINVAL;
 
-	if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_SDP) {
+	if (sdp) {
 		union {
 			struct arm_smccc_res smccc;
 			struct optee_smc_get_sdp_config_result result;
@@ -1634,25 +1701,24 @@ static int optee_sdp_pool_init(struct optee *optee)
 
 		optee->smc.invoke_fn(OPTEE_SMC_GET_SDP_CONFIG, 0, 0, 0, 0, 0, 0,
 				     0, &res.smccc);
-		if (res.result.status != OPTEE_SMC_RETURN_OK) {
-			pr_err("Secure Data Path service not available\n");
-			return 0;
-		}
+		if (res.result.status == OPTEE_SMC_RETURN_OK)
+			pool = tee_rstmem_static_pool_alloc(res.result.start,
+							    res.result.size);
+	}
 
-		pool = tee_rstmem_static_pool_alloc(res.result.start,
-						    res.result.size);
-		if (IS_ERR(pool))
-			return PTR_ERR(pool);
+	if (dyn_sdp && IS_ERR(pool))
+		pool = optee_rstmem_alloc_cma_pool(optee, heap_id);
 
+	if (!IS_ERR(pool)) {
 		rc = tee_device_register_dma_heap(optee->teedev, heap_id, pool);
 		if (rc)
-			goto err;
+			pool->ops->destroy_pool(pool);
 	}
 
+	if (rc && (sdp || dyn_sdp))
+		pr_err("Secure Data Path service not available\n");
+
 	return 0;
-err:
-	pool->ops->destroy_pool(pool);
-	return rc;
 }
 
 static int optee_probe(struct platform_device *pdev)
-- 
2.43.0


