Return-Path: <linux-kernel+bounces-365520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D737B99E39B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22AAAB21AA8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA5E1E378F;
	Tue, 15 Oct 2024 10:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RHvuskLd"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D981E5717
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728987461; cv=none; b=rbQZpZiUEmW68iukilx2h/DNA9AGgcfD0rFLkHDUiagBgW7T/QG+ZhgJWd8ebEal/7kN82CKhky0wSpllMfLxheQtMsZN9PeWGahPitHVzweX4PEHeP7AdD5NEy0ib+kdMvFLb4qdQ0sfHcaK1KwPSkCeLP4TqBLRHQTUpWvRGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728987461; c=relaxed/simple;
	bh=Oi2LR3jBP5oxOS+dy+PbLeHxSnVWqC/5xMH9twvRmu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vaz2bn0SmIVBHOmvYNsVJCY3+K9ZVZkxn7GQw5G5DlVYIHKm4a5b8nngIA7MEHndinkPhuOGoq5IupxslICg+MtD9/FztxbNKe/nsJ535ITJjfGRduekuaABtQxpOJN861REtQb2sS6Kuk1TAGy9kSNmFYaIbHwq3YhinfqjpmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RHvuskLd; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb5a9c7420so8142791fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 03:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728987457; x=1729592257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2ibku35XfRoL4gdWqARoGjujLJu475s8gK+je/2VF8=;
        b=RHvuskLdRdHOjeO7aUuYqdXed0/l747nrpZwZbx80JnmeGw6CQ1YpQMiM47kTNP6J4
         gfi4CezZxL2fKQezITOPhBO6Ii0PJ0fqgwOHm+gq40BJXcfWH9u6fuyGnxnPQyhD2IwZ
         7c3y72arkUy6ANl57ZpFeOJCnbxXOh7QeWJxQHsZJcWgODDx1YZ5dYAFaY1pK0IH9Lgy
         mxR4DxeV+QgjYRNVv+xYSnqp66nmgC5A8DvWdpBMq+rWrbo119N50SHqhk2DPH4ok12/
         bbbTvC24ynhxC30sIEPq7aD8e2Za6X/GBzOBsHKP0SYsMAWw80mdkSH3fHVPVk5RziEi
         UDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728987457; x=1729592257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2ibku35XfRoL4gdWqARoGjujLJu475s8gK+je/2VF8=;
        b=JiQ0LH9zgKDmdPobThzz5GpGJsFTRGtPLA6OB5qZsmVWansk891Yc9bojKS9ij/Ufy
         p7f6tjIwj0O/OZ+Cm+PFE6LJDhk4itOQbkifT3JN5CRpAJ7EWabu9v+i247ygWgwreTI
         9fqlr/yK8gDU57Ntb5XG4po7vQ9MrbXGl+8lMV8AfzkPxJa7kcU+gx7P+2EPhpINr+lg
         KNeWTuq9X8nldek8CC+FNrdIxgGrDAA9PZSbEUdJb6uDfH4dEEJ6XylSZYCsQIOt2J5b
         Yr7XOE2nfYEeBMjRU6OnfP3HpNhQsRDr582RO5fN3XamTfT0sqVVSCJCnnvC5p4U9C6K
         oy8Q==
X-Gm-Message-State: AOJu0YwgHz53NYPSdgOsF+fJ5Q+fQn6jZ5LhVunPdbEuN5rsZ9WATJ5n
	3pg2MpdoGdyf2Cb2pM1f4gAvUKHC8LdRA5KedbiDepHDQ3rafQ0hmCaxxHWZQPE9WPO6OLzgPiP
	8
X-Google-Smtp-Source: AGHT+IF1icYPKVUi+ffxNCNwQ/1dlOgggGFAfeclFmEIheFtkq+viYW9Qa/IQJvlG2RlfXfT8I8gJw==
X-Received: by 2002:a2e:4609:0:b0:2f7:64b9:ff90 with SMTP id 38308e7fff4ca-2fb3f16fad9mr36545921fa.9.1728987457330;
        Tue, 15 Oct 2024 03:17:37 -0700 (PDT)
Received: from rayden.urgonet (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d778b80sm519581a12.78.2024.10.15.03.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 03:17:36 -0700 (PDT)
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
Subject: [RFC PATCH v2 2/2] optee: support restricted memory allocation
Date: Tue, 15 Oct 2024 12:15:34 +0200
Message-ID: <20241015101716.740829-3-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241015101716.740829-1-jens.wiklander@linaro.org>
References: <20241015101716.740829-1-jens.wiklander@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support in the OP-TEE backend driver for restricted memory
allocation. The support is limited to only the SMC ABI and for secure
video buffers.

OP-TEE is probed for the range of restricted physical memory and a
memory pool allocator is initialized if OP-TEE have support for such
memory.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/core.c          | 21 +++++++++++++++
 drivers/tee/optee/optee_private.h |  6 +++++
 drivers/tee/optee/optee_smc.h     | 35 ++++++++++++++++++++++++
 drivers/tee/optee/smc_abi.c       | 45 ++++++++++++++++++++++++++++---
 4 files changed, 104 insertions(+), 3 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 39e688d4e974..b6d5cbc6728d 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -95,6 +95,25 @@ void optee_release_supp(struct tee_context *ctx)
 	optee_supp_release(&optee->supp);
 }
 
+int optee_rstmem_alloc(struct tee_context *ctx, struct tee_shm *shm,
+		       u32 flags, size_t size)
+{
+	struct optee *optee = tee_get_drvdata(ctx->teedev);
+
+	if (!optee->sdp_pool)
+		return -EINVAL;
+	if (flags != TEE_IOC_FLAG_SECURE_VIDEO)
+		return -EINVAL;
+	return optee->sdp_pool->ops->alloc(optee->sdp_pool, shm, size, 0);
+}
+
+void optee_rstmem_free(struct tee_context *ctx, struct tee_shm *shm)
+{
+	struct optee *optee = tee_get_drvdata(ctx->teedev);
+
+	optee->sdp_pool->ops->free(optee->sdp_pool, shm);
+}
+
 void optee_remove_common(struct optee *optee)
 {
 	/* Unregister OP-TEE specific client devices on TEE bus */
@@ -111,6 +130,8 @@ void optee_remove_common(struct optee *optee)
 	tee_device_unregister(optee->teedev);
 
 	tee_shm_pool_free(optee->pool);
+	if (optee->sdp_pool)
+		optee->sdp_pool->ops->destroy_pool(optee->sdp_pool);
 	optee_supp_uninit(&optee->supp);
 	mutex_destroy(&optee->call_queue.mutex);
 }
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index 424898cdc4e9..1f6b2cc992a9 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -200,6 +200,7 @@ struct optee_ops {
  * @notif:		notification synchronization struct
  * @supp:		supplicant synchronization struct for RPC to supplicant
  * @pool:		shared memory pool
+ * @sdp_pool:		restricted memory pool for secure data path
  * @rpc_param_count:	If > 0 number of RPC parameters to make room for
  * @scan_bus_done	flag if device registation was already done.
  * @scan_bus_work	workq to scan optee bus and register optee drivers
@@ -218,6 +219,7 @@ struct optee {
 	struct optee_notif notif;
 	struct optee_supp supp;
 	struct tee_shm_pool *pool;
+	struct tee_shm_pool *sdp_pool;
 	unsigned int rpc_param_count;
 	bool   scan_bus_done;
 	struct work_struct scan_bus_work;
@@ -340,6 +342,10 @@ void optee_rpc_cmd(struct tee_context *ctx, struct optee *optee,
 int optee_do_bottom_half(struct tee_context *ctx);
 int optee_stop_async_notif(struct tee_context *ctx);
 
+int optee_rstmem_alloc(struct tee_context *ctx, struct tee_shm *shm,
+		       u32 flags, size_t size);
+void optee_rstmem_free(struct tee_context *ctx, struct tee_shm *shm);
+
 /*
  * Small helpers
  */
diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
index 7d9fa426505b..c3b8a1c204af 100644
--- a/drivers/tee/optee/optee_smc.h
+++ b/drivers/tee/optee/optee_smc.h
@@ -234,6 +234,39 @@ struct optee_smc_get_shm_config_result {
 	unsigned long settings;
 };
 
+/*
+ * Get Secure Data Path memory config
+ *
+ * Returns the Secure Data Path memory config.
+ *
+ * Call register usage:
+ * a0   SMC Function ID, OPTEE_SMC_GET_SDP_CONFIG
+ * a2-6 Not used, must be zero
+ * a7   Hypervisor Client ID register
+ *
+ * Have config return register usage:
+ * a0   OPTEE_SMC_RETURN_OK
+ * a1   Physical address of start of SDP memory
+ * a2   Size of SDP memory
+ * a3   Not used
+ * a4-7 Preserved
+ *
+ * Not available register usage:
+ * a0   OPTEE_SMC_RETURN_ENOTAVAIL
+ * a1-3 Not used
+ * a4-7 Preserved
+ */
+#define OPTEE_SMC_FUNCID_GET_SDP_CONFIG	20
+#define OPTEE_SMC_GET_SDP_CONFIG \
+	OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_GET_SDP_CONFIG)
+
+struct optee_smc_get_sdp_config_result {
+	unsigned long status;
+	unsigned long start;
+	unsigned long size;
+	unsigned long flags;
+};
+
 /*
  * Exchanges capabilities between normal world and secure world
  *
@@ -278,6 +311,8 @@ struct optee_smc_get_shm_config_result {
 #define OPTEE_SMC_SEC_CAP_ASYNC_NOTIF		BIT(5)
 /* Secure world supports pre-allocating RPC arg struct */
 #define OPTEE_SMC_SEC_CAP_RPC_ARG		BIT(6)
+/* Secure world supports Secure Data Path */
+#define OPTEE_SMC_SEC_CAP_SDP			BIT(7)
 
 #define OPTEE_SMC_FUNCID_EXCHANGE_CAPABILITIES	9
 #define OPTEE_SMC_EXCHANGE_CAPABILITIES \
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index 844285d4f03c..05068c70c791 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -1164,6 +1164,8 @@ static void optee_get_version(struct tee_device *teedev,
 		v.gen_caps |= TEE_GEN_CAP_REG_MEM;
 	if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_MEMREF_NULL)
 		v.gen_caps |= TEE_GEN_CAP_MEMREF_NULL;
+	if (optee->sdp_pool)
+		v.gen_caps |= TEE_GEN_CAP_RSTMEM;
 	*vers = v;
 }
 
@@ -1186,6 +1188,8 @@ static const struct tee_driver_ops optee_clnt_ops = {
 	.cancel_req = optee_cancel_req,
 	.shm_register = optee_shm_register,
 	.shm_unregister = optee_shm_unregister,
+	.rstmem_alloc = optee_rstmem_alloc,
+	.rstmem_free = optee_rstmem_free,
 };
 
 static const struct tee_desc optee_clnt_desc = {
@@ -1202,6 +1206,8 @@ static const struct tee_driver_ops optee_supp_ops = {
 	.supp_send = optee_supp_send,
 	.shm_register = optee_shm_register_supp,
 	.shm_unregister = optee_shm_unregister_supp,
+	.rstmem_alloc = optee_rstmem_alloc,
+	.rstmem_free = optee_rstmem_free,
 };
 
 static const struct tee_desc optee_supp_desc = {
@@ -1582,6 +1588,32 @@ static inline int optee_load_fw(struct platform_device *pdev,
 }
 #endif
 
+static int optee_sdp_pool_init(struct optee *optee)
+{
+	struct tee_shm_pool *pool;
+	union {
+		struct arm_smccc_res smccc;
+		struct optee_smc_get_sdp_config_result result;
+	} res;
+
+	if (!(optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_SDP))
+		return 0;
+
+	optee->smc.invoke_fn(OPTEE_SMC_GET_SDP_CONFIG, 0, 0, 0, 0, 0, 0, 0,
+			     &res.smccc);
+	if (res.result.status != OPTEE_SMC_RETURN_OK) {
+		pr_err("Secure Data Path service not available\n");
+		return 0;
+	}
+
+	pool = tee_rstmem_gen_pool_alloc(res.result.start, res.result.size);
+	if (IS_ERR(pool))
+		return PTR_ERR(pool);
+	optee->sdp_pool = pool;
+
+	return 0;
+}
+
 static int optee_probe(struct platform_device *pdev)
 {
 	optee_invoke_fn *invoke_fn;
@@ -1677,7 +1709,7 @@ static int optee_probe(struct platform_device *pdev)
 	optee = kzalloc(sizeof(*optee), GFP_KERNEL);
 	if (!optee) {
 		rc = -ENOMEM;
-		goto err_free_pool;
+		goto err_free_shm_pool;
 	}
 
 	optee->ops = &optee_ops;
@@ -1685,10 +1717,14 @@ static int optee_probe(struct platform_device *pdev)
 	optee->smc.sec_caps = sec_caps;
 	optee->rpc_param_count = rpc_param_count;
 
+	rc = optee_sdp_pool_init(optee);
+	if (rc)
+		goto err_free_optee;
+
 	teedev = tee_device_alloc(&optee_clnt_desc, NULL, pool, optee);
 	if (IS_ERR(teedev)) {
 		rc = PTR_ERR(teedev);
-		goto err_free_optee;
+		goto err_sdp_pool_uninit;
 	}
 	optee->teedev = teedev;
 
@@ -1786,9 +1822,12 @@ static int optee_probe(struct platform_device *pdev)
 	tee_device_unregister(optee->supp_teedev);
 err_unreg_teedev:
 	tee_device_unregister(optee->teedev);
+err_sdp_pool_uninit:
+	if (optee->sdp_pool)
+		optee->sdp_pool->ops->destroy_pool(optee->sdp_pool);
 err_free_optee:
 	kfree(optee);
-err_free_pool:
+err_free_shm_pool:
 	tee_shm_pool_free(pool);
 	if (memremaped_shm)
 		memunmap(memremaped_shm);
-- 
2.43.0


