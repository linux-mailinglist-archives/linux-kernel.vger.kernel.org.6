Return-Path: <linux-kernel+bounces-449016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 741C89F488A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 429B51683EF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF001E283C;
	Tue, 17 Dec 2024 10:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="II8KO7Yt"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F391E47B7
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 10:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734430111; cv=none; b=LFRSEgrRckeuHTlreeqSYWJcIuPP0Mwy0/SZTxJ3Ys4zyPU+e1m1VlltJhElWyEvwB5DM/alvZtdBOB9Nn7+liIPMm7ACp/546B64ly9hcwch0DiZY67JtH9VXeB1HDqSSIsD3jriAKfB0NJUjQAH/QqzlP3f6nplIjIN1WDNPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734430111; c=relaxed/simple;
	bh=B9UtVMLOgv6N+g5CkEuENw3Nh8qiEtR1bncXWV/nVhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R6cGYdVb/k4FfCBqq9c30iOcipmh4eKZhkNhnzmoEimn6BLYQibFhK4oOCHj27a3DWope7RidzUlbskEgRSHleZwIPcqlwMmO5bJwRT9/m0u9xi/ok8Z2Oczf9wJuy+wi4iFx7DNmrDkQeV0MfhlzrA/Fbv+tKMJBZKCjExeZ9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=II8KO7Yt; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30227c56b11so50928801fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 02:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734430107; x=1735034907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZsHfNNOgspKsrUQD+qKEISSMRmQtLOnKljJs9VS4jY4=;
        b=II8KO7YtEZ1RuBER/eg8l2RRp9HAuG4U3WNQ9gWYGgea6JfFx69C+JBXHbjVpo3//Q
         FAtG31pXBEFKMZaywza4cuUReTzvAJfdF/fmm39+SVk6yJBfBEWlkGX7qC4sLtUv7NpL
         Qxxx77CNH7dB84W8TCH2NoE6YtBvMdU+HjsECriUr6QlDLF0TWqbCpIbSw5e8zd/aTVk
         YfPn+oQQU4uKxDiMRAigPZ2jin8FcsSrxDMn46JVLz3FaZlsFd7WTTBK82CvXg0hpK0I
         gyEWeN8KvXeeRx9Clj+Kzlbx9aOkYxaptoPBEn8s/+oW1cc+5UwA9r5VtY7kFVX+mnw5
         +VvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734430107; x=1735034907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZsHfNNOgspKsrUQD+qKEISSMRmQtLOnKljJs9VS4jY4=;
        b=BcI+heuNT5y6LLeS8TRN4pIqhnl9yEclYWrOdulQrXyie5y+UOR7LxhCo5Pg+OVRqD
         XdYzkhrm5HqbNHuEgnNIwophPdrJV7TuU5UGWKmbQaICiUymcEUbYKf4/kObfUFMYdiK
         OJ9SMD0BHXtTkDHcDKPR5nt+yGHaxtLEHIljBancrYQd9lSBBnS01bwViiSRHe/sViXQ
         JiNcAOWpbU6OGLz6TFwuVnr+iSpf3NS6KvqJJcz2AUNCAq5soVRkPGP2fmOPyAued2ZM
         o1ZdT5WreHCy3w+5VjtyL128hvVPHeqW7YNrxAOLtgRuFpBUe2q4+Nf0+6JlFexsjqsB
         hDmA==
X-Gm-Message-State: AOJu0YxzZmMl/q2B2EfCw9ZrLs0e3biSGBZxo20GJvxOj5QRYhXtR9g+
	ELskW+8xwLg1TFvdJTZ/Fx6IRxGafCh1xXW4f3ryronnMSKMnrKmjdUksGHxgK8bArfo8YKR6VW
	R
X-Gm-Gg: ASbGnctTo2Tv5mk2NTzduZhiBLKHnjVS0XSvG2djuqV8ljqT3KJyQpasFeQpPnGrsRU
	K0ZI4hAxNL19OfA7WINgumESYDCHed5Le7g7BHa1TIwozBIyaFhZf+aTW8Lzxx3i9uoAkKBDuKH
	oXEmry1sQV+Qg17B85cakRg0fxlX0JIrcR/FB2TrI6+RqMVh725J5o3IZzoGXBEF6+KA+dJZVuh
	8i6Tt2tXtTBs4M/tbSxJK7MDEQabI8QZmKUSeBckG1ra6L8KC72rLJXGeN45JKmZEAGGhgVNFQA
	5qiyTWo9qCVBHYKor8JJ+iTP05DDnuEnaw==
X-Google-Smtp-Source: AGHT+IGDOkQVBaM/y6DukXghEAM34NJKr73J8WRGV4NrI9jkGGB6d/Wycr2K7m3r8PvaIOQNbzWNGw==
X-Received: by 2002:a2e:b8cb:0:b0:302:4115:b69 with SMTP id 38308e7fff4ca-304434d9f6dmr11314101fa.8.1734430106896;
        Tue, 17 Dec 2024 02:08:26 -0800 (PST)
Received: from rayden.urgonet (h-98-128-140-123.A175.priv.bahnhof.se. [98.128.140.123])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-303441a69ecsm12122681fa.111.2024.12.17.02.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 02:08:25 -0800 (PST)
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
Subject: [PATCH v4 4/6] optee: support restricted memory allocation
Date: Tue, 17 Dec 2024 11:07:40 +0100
Message-ID: <20241217100809.3962439-5-jens.wiklander@linaro.org>
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

Add support in the OP-TEE backend driver for restricted memory
allocation. The support is limited to only the SMC ABI and for secure
video buffers.

OP-TEE is probed for the range of restricted physical memory and a
memory pool allocator is initialized if OP-TEE have support for such
memory.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/Makefile        |  1 +
 drivers/tee/optee/core.c          |  1 +
 drivers/tee/optee/optee_private.h | 23 ++++++++++
 drivers/tee/optee/rstmem.c        | 76 +++++++++++++++++++++++++++++++
 drivers/tee/optee/smc_abi.c       | 69 ++++++++++++++++++++++++++--
 5 files changed, 167 insertions(+), 3 deletions(-)
 create mode 100644 drivers/tee/optee/rstmem.c

diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
index a6eff388d300..498969fb8e40 100644
--- a/drivers/tee/optee/Makefile
+++ b/drivers/tee/optee/Makefile
@@ -4,6 +4,7 @@ optee-objs += core.o
 optee-objs += call.o
 optee-objs += notif.o
 optee-objs += rpc.o
+optee-objs += rstmem.o
 optee-objs += supp.o
 optee-objs += device.o
 optee-objs += smc_abi.o
diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index c75fddc83576..f4fa494789a4 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -182,6 +182,7 @@ void optee_remove_common(struct optee *optee)
 	tee_device_unregister(optee->teedev);
 
 	tee_shm_pool_free(optee->pool);
+	optee_rstmem_pools_uninit(optee);
 	optee_supp_uninit(&optee->supp);
 	mutex_destroy(&optee->call_queue.mutex);
 	rpmb_dev_put(optee->rpmb_dev);
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index 20eda508dbac..0491889e5b0e 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -193,6 +193,20 @@ struct optee_ops {
 			      bool update_out);
 };
 
+/**
+ * struct optee_rstmem_pools - restricted memory pools
+ * @mutex:	serializes write access to @xa when adding a new pool.
+ * @xa:		XArray of struct tee_shm_pool where the index is the
+ *		use case ID TEE_IOC_UC_* supplied for TEE_IOC_RSTMEM_ALLOC.
+ */
+struct optee_rstmem_pools {
+	/*
+	 * Serializes write access to @xa when adding a new pool.
+	 */
+	struct mutex mutex;
+	struct xarray xa;
+};
+
 /**
  * struct optee - main service struct
  * @supp_teedev:	supplicant device
@@ -206,6 +220,7 @@ struct optee_ops {
  * @notif:		notification synchronization struct
  * @supp:		supplicant synchronization struct for RPC to supplicant
  * @pool:		shared memory pool
+ * @rstmem_pool:	restricted memory pool for secure data path
  * @mutex:		mutex protecting @rpmb_dev
  * @rpmb_dev:		current RPMB device or NULL
  * @rpmb_scan_bus_done	flag if device registation of RPMB dependent devices
@@ -230,6 +245,7 @@ struct optee {
 	struct optee_notif notif;
 	struct optee_supp supp;
 	struct tee_shm_pool *pool;
+	struct optee_rstmem_pools *rstmem_pools;
 	/* Protects rpmb_dev pointer */
 	struct mutex rpmb_dev_mutex;
 	struct rpmb_dev *rpmb_dev;
@@ -286,6 +302,9 @@ void optee_supp_init(struct optee_supp *supp);
 void optee_supp_uninit(struct optee_supp *supp);
 void optee_supp_release(struct optee_supp *supp);
 
+int optee_rstmem_pools_init(struct optee *optee);
+void optee_rstmem_pools_uninit(struct optee *optee);
+
 int optee_supp_recv(struct tee_context *ctx, u32 *func, u32 *num_params,
 		    struct tee_param *param);
 int optee_supp_send(struct tee_context *ctx, u32 ret, u32 num_params,
@@ -378,6 +397,10 @@ void optee_rpc_cmd(struct tee_context *ctx, struct optee *optee,
 int optee_do_bottom_half(struct tee_context *ctx);
 int optee_stop_async_notif(struct tee_context *ctx);
 
+int optee_rstmem_alloc(struct tee_context *ctx, struct tee_shm *shm,
+		       u32 flags, u32 use_case, size_t size);
+void optee_rstmem_free(struct tee_context *ctx, struct tee_shm *shm);
+
 /*
  * Small helpers
  */
diff --git a/drivers/tee/optee/rstmem.c b/drivers/tee/optee/rstmem.c
new file mode 100644
index 000000000000..01456bc3e2f6
--- /dev/null
+++ b/drivers/tee/optee/rstmem.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024, Linaro Limited
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/dma-map-ops.h>
+#include <linux/errno.h>
+#include <linux/genalloc.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/tee_core.h>
+#include <linux/types.h>
+#include "optee_private.h"
+
+int optee_rstmem_alloc(struct tee_context *ctx, struct tee_shm *shm,
+		       u32 flags, u32 use_case, size_t size)
+{
+	struct optee *optee = tee_get_drvdata(ctx->teedev);
+	struct tee_shm_pool *pool;
+
+	if (!optee->rstmem_pools)
+		return -EINVAL;
+	if (flags)
+		return -EINVAL;
+
+	pool = xa_load(&optee->rstmem_pools->xa, use_case);
+	if (!pool)
+		return -EINVAL;
+
+	return pool->ops->alloc(pool, shm, size, 0);
+}
+
+void optee_rstmem_free(struct tee_context *ctx, struct tee_shm *shm)
+{
+	struct optee *optee = tee_get_drvdata(ctx->teedev);
+	struct tee_shm_pool *pool;
+
+	pool = xa_load(&optee->rstmem_pools->xa, shm->use_case);
+	if (pool)
+		pool->ops->free(pool, shm);
+	else
+		pr_err("Can't find pool for use_case %u\n", shm->use_case);
+}
+
+int optee_rstmem_pools_init(struct optee *optee)
+{
+	struct optee_rstmem_pools *pools;
+
+	pools = kmalloc(sizeof(*pools), GFP_KERNEL);
+	if (!pools)
+		return -ENOMEM;
+
+	mutex_init(&pools->mutex);
+	xa_init(&pools->xa);
+	optee->rstmem_pools = pools;
+	return 0;
+}
+
+void optee_rstmem_pools_uninit(struct optee *optee)
+{
+	if (optee->rstmem_pools) {
+		struct tee_shm_pool *pool;
+		u_long idx;
+
+		xa_for_each(&optee->rstmem_pools->xa, idx, pool) {
+			xa_erase(&optee->rstmem_pools->xa, idx);
+			pool->ops->destroy_pool(pool);
+		}
+
+		xa_destroy(&optee->rstmem_pools->xa);
+		mutex_destroy(&optee->rstmem_pools->mutex);
+		kfree(optee->rstmem_pools);
+		optee->rstmem_pools = NULL;
+	}
+}
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index 788919a473d6..f5fd5f1d9a6b 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -1201,6 +1201,8 @@ static void optee_get_version(struct tee_device *teedev,
 		v.gen_caps |= TEE_GEN_CAP_REG_MEM;
 	if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_MEMREF_NULL)
 		v.gen_caps |= TEE_GEN_CAP_MEMREF_NULL;
+	if (optee->rstmem_pools)
+		v.gen_caps |= TEE_GEN_CAP_RSTMEM;
 	*vers = v;
 }
 
@@ -1223,6 +1225,8 @@ static const struct tee_driver_ops optee_clnt_ops = {
 	.cancel_req = optee_cancel_req,
 	.shm_register = optee_shm_register,
 	.shm_unregister = optee_shm_unregister,
+	.rstmem_alloc = optee_rstmem_alloc,
+	.rstmem_free = optee_rstmem_free,
 };
 
 static const struct tee_desc optee_clnt_desc = {
@@ -1239,6 +1243,8 @@ static const struct tee_driver_ops optee_supp_ops = {
 	.supp_send = optee_supp_send,
 	.shm_register = optee_shm_register_supp,
 	.shm_unregister = optee_shm_unregister_supp,
+	.rstmem_alloc = optee_rstmem_alloc,
+	.rstmem_free = optee_rstmem_free,
 };
 
 static const struct tee_desc optee_supp_desc = {
@@ -1619,6 +1625,57 @@ static inline int optee_load_fw(struct platform_device *pdev,
 }
 #endif
 
+static int optee_sdp_pool_init(struct optee *optee)
+{
+	bool sdp = optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_SDP;
+	struct tee_shm_pool *pool;
+	int rc;
+
+	/*
+	 * optee_sdp_pools_init() must be called if secure world has any
+	 * SDP capability. If the static carvout is available initialize
+	 * and add a pool for that.
+	 */
+	if (!sdp)
+		return 0;
+
+	rc = optee_rstmem_pools_init(optee);
+	if (rc)
+		return rc;
+
+	if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_SDP) {
+		union {
+			struct arm_smccc_res smccc;
+			struct optee_smc_get_sdp_config_result result;
+		} res;
+
+		optee->smc.invoke_fn(OPTEE_SMC_GET_SDP_CONFIG, 0, 0, 0, 0, 0, 0,
+				     0, &res.smccc);
+		if (res.result.status != OPTEE_SMC_RETURN_OK) {
+			pr_err("Secure Data Path service not available\n");
+			goto err;
+		}
+
+		pool = tee_rstmem_gen_pool_alloc(res.result.start,
+						 res.result.size);
+		if (IS_ERR(pool)) {
+			rc = PTR_ERR(pool);
+			goto err;
+		}
+		rc = xa_insert(&optee->rstmem_pools->xa,
+			       TEE_IOC_UC_SECURE_VIDEO_PLAY, pool, GFP_KERNEL);
+		if (rc) {
+			pool->ops->destroy_pool(pool);
+			goto err;
+		}
+	}
+
+	return 0;
+err:
+	optee_rstmem_pools_uninit(optee);
+	return rc;
+}
+
 static int optee_probe(struct platform_device *pdev)
 {
 	optee_invoke_fn *invoke_fn;
@@ -1714,7 +1771,7 @@ static int optee_probe(struct platform_device *pdev)
 	optee = kzalloc(sizeof(*optee), GFP_KERNEL);
 	if (!optee) {
 		rc = -ENOMEM;
-		goto err_free_pool;
+		goto err_free_shm_pool;
 	}
 
 	optee->ops = &optee_ops;
@@ -1726,10 +1783,14 @@ static int optee_probe(struct platform_device *pdev)
 	    (sec_caps & OPTEE_SMC_SEC_CAP_RPMB_PROBE))
 		optee->in_kernel_rpmb_routing = true;
 
+	rc = optee_sdp_pool_init(optee);
+	if (rc)
+		goto err_free_optee;
+
 	teedev = tee_device_alloc(&optee_clnt_desc, NULL, pool, optee);
 	if (IS_ERR(teedev)) {
 		rc = PTR_ERR(teedev);
-		goto err_free_optee;
+		goto err_rstmem_pools_uninit;
 	}
 	optee->teedev = teedev;
 
@@ -1836,9 +1897,11 @@ static int optee_probe(struct platform_device *pdev)
 	tee_device_unregister(optee->supp_teedev);
 err_unreg_teedev:
 	tee_device_unregister(optee->teedev);
+err_rstmem_pools_uninit:
+	optee_rstmem_pools_uninit(optee);
 err_free_optee:
 	kfree(optee);
-err_free_pool:
+err_free_shm_pool:
 	tee_shm_pool_free(pool);
 	if (memremaped_shm)
 		memunmap(memremaped_shm);
-- 
2.43.0


