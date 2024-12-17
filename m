Return-Path: <linux-kernel+bounces-449018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 896749F4890
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58FEF16DFB5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FDD1DFE05;
	Tue, 17 Dec 2024 10:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TuJzgY4Z"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A15C1EE00E
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 10:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734430116; cv=none; b=E7PvTTY9UihKf9twxNHW4VG/3+4lyZL5MoRxXo+DLCOObE6Xf2Sv6/PlhtmpGSNiZj0pRM+V4A2okFEKP1VkroD9NKK7RNwDJIMojVz/y2hpDWaOH7GOFAMMK7KYs1rMNxyfI/YTWdNuNosTkeqERdDJgMd+IZhi1R7WFnJ6nm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734430116; c=relaxed/simple;
	bh=4KxUi4p1DATCF1nyixe6Uc20IjjJk8/zJCMWNhf7eDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZeYyU1iMbqPhvgOmM4h81wKe0mjw7faxbGTuYBxlY/kIFft01QI2eIlhGLotcR2PS5LCzxZIFFyqkx00uMASeM0Dcty67F/HvIjr0MNVMfEQmLAduxblAdplodbkm2bTv074jqn3ZDoOV7EnDAOfYAe6xMZpAuHCBIRy+10V9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TuJzgY4Z; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3011c7b39c7so56030951fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 02:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734430112; x=1735034912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pvK2dryYlnCmix3/yimTZ2hrNh+UDq3X0M3uPxCWwA=;
        b=TuJzgY4Z+iS4w2iH8vFOtBwuxukbHCu3dDE1MEuFqU37iJ3GutOo5uYcX3nBxbbU6B
         ePe3v3Eqz6ynbOEj3ytsEsTFTpDzu6d6R+GMEdm8dzL/az5biwkbUlW+TNrRYL9Pg8Eu
         hX6hhQszqfFO3A0mp93SCzd7x/yGCWYsv4RjB/UzCl4pk63ekD6SizhNNB5HXhlhN3og
         KetTaHdjaHtdYfsA4qsCCbsugOcFLzXAJIxOzUo/ZESl9TNQA5fHldjhadqkH2F/HYeW
         yO7pOsEz9GYBVhGvQkYXhJapVmGQ3YqLZRHMtLkUsHebjDPZ0g/bIT4hDUi6ceNSfD0Z
         4lWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734430112; x=1735034912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pvK2dryYlnCmix3/yimTZ2hrNh+UDq3X0M3uPxCWwA=;
        b=LXVoR0kaEu5NjnC4JweNTRIzdKEukAxftbYCynHcvJct50IW+oDuRFqRN67ILfn9oW
         4vD0P8LokUa/6iw8OU0hSxs2b32tTyZJwE40fq+M5H7Hf+foPJaAKBVBjkzS0duKsZwH
         lmnCPXsNSN4uWDmbzisTFmFGpGmsNdds6bkzJauKed0nxq18wGAER2AWPWwF+h8Juwtc
         50DYfNFPgx6MeZGdjxqk9T4ovk3Vh/WiDemfnfMSmJV2AFyY4uJTTkprFcF6hwfg/0Cy
         /ivtqwd4RUwPoQokYVwkqQrisdrs2gNCFdBQ2s4G9UAvXP7OsQwngXU6eAApuKCEbBUY
         IE9g==
X-Gm-Message-State: AOJu0Yw3eb+3HaQoPTntSDfKVht/3a0r2ET1wM2UyIS4pmixHz1DK2e1
	0fplKsQ2sz4KgR1eI1pjPWXLYKB8xCuyKlppM134jW5Muz6lLl25daSsLYSYxH12yP3W60+mHC1
	s
X-Gm-Gg: ASbGncucLW+2dfAlwVp2qvEP9Mskg7hxRaNC+MhrwuYrz6SliXDI8hllBgD4wY9+p7t
	qr3/b5/KAfl5jdXg7AqDU4ZFncTgVp6WSf7JlRTJSG6Tbf4gjqWXk0QzTim5aYx+4TNtfQ1HZb7
	HgIwHL1dogUsoyqCdUNj5AW6FXezMP31MisdccZHdoYIftwxlbmAFbVtXU/0aZWCVuP2VKH+NCH
	zhzN4+IZ7msC9at0pajenzXFiWuSbz2vvkk6+uGCXRNJ2I6mHv39VuLy/plA9xt+v2XNLUyCt92
	5mfP/XdGh7dgdci/XZSTFG3b4jfPrSEAqw==
X-Google-Smtp-Source: AGHT+IFUOf8R3oSz8XVmOSk4m+OqhuOXE2suAkhuB1hb+UqdPUyHZKSAPIv6wONSSMTF4nNdh4CWRw==
X-Received: by 2002:a05:651c:1a0a:b0:303:41ea:7910 with SMTP id 38308e7fff4ca-30341ea798bmr37947871fa.34.1734430111988;
        Tue, 17 Dec 2024 02:08:31 -0800 (PST)
Received: from rayden.urgonet (h-98-128-140-123.A175.priv.bahnhof.se. [98.128.140.123])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-303441a69ecsm12122681fa.111.2024.12.17.02.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 02:08:31 -0800 (PST)
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
	Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v4 6/6] optee: smc abi: dynamic restricted memory allocation
Date: Tue, 17 Dec 2024 11:07:42 +0100
Message-ID: <20241217100809.3962439-7-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241217100809.3962439-1-jens.wiklander@linaro.org>
References: <20241217100809.3962439-1-jens.wiklander@linaro.org>
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
 drivers/tee/optee/smc_abi.c | 74 +++++++++++++++++++++++++++++++++++--
 1 file changed, 71 insertions(+), 3 deletions(-)

diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index f5fd5f1d9a6b..25b02dbbc76e 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -1001,6 +1001,67 @@ static int optee_smc_do_call_with_arg(struct tee_context *ctx,
 	return rc;
 }
 
+static int optee_smc_lend_rstmem(struct optee *optee, struct tee_shm *rstmem,
+				 u16 *end_points, unsigned int ep_count)
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
+	msg_arg->params[0].u.value.a = OPTEE_MSG_RSTMEM_SECURE_VIDEO_PLAY;
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
@@ -1258,6 +1319,8 @@ static const struct optee_ops optee_ops = {
 	.do_call_with_arg = optee_smc_do_call_with_arg,
 	.to_msg_param = optee_to_msg_param,
 	.from_msg_param = optee_from_msg_param,
+	.lend_rstmem = optee_smc_lend_rstmem,
+	.reclaim_rstmem = optee_smc_reclaim_rstmem,
 };
 
 static int enable_async_notif(optee_invoke_fn *invoke_fn)
@@ -1627,6 +1690,7 @@ static inline int optee_load_fw(struct platform_device *pdev,
 
 static int optee_sdp_pool_init(struct optee *optee)
 {
+	bool dyn_sdp = optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_RSTMEM;
 	bool sdp = optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_SDP;
 	struct tee_shm_pool *pool;
 	int rc;
@@ -1634,9 +1698,11 @@ static int optee_sdp_pool_init(struct optee *optee)
 	/*
 	 * optee_sdp_pools_init() must be called if secure world has any
 	 * SDP capability. If the static carvout is available initialize
-	 * and add a pool for that.
+	 * and add a pool for that. If there's an error from secure world
+	 * we complain but don't call optee_sdp_pools_uninit() unless we
+	 * know that there is no SDP capability left.
 	 */
-	if (!sdp)
+	if (!dyn_sdp && !sdp)
 		return 0;
 
 	rc = optee_rstmem_pools_init(optee);
@@ -1653,7 +1719,9 @@ static int optee_sdp_pool_init(struct optee *optee)
 				     0, &res.smccc);
 		if (res.result.status != OPTEE_SMC_RETURN_OK) {
 			pr_err("Secure Data Path service not available\n");
-			goto err;
+			if (!dyn_sdp)
+				goto err;
+			return 0;
 		}
 
 		pool = tee_rstmem_gen_pool_alloc(res.result.start,
-- 
2.43.0


