Return-Path: <linux-kernel+bounces-546872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0069DA4FFC4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D10CA17656E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C272500AA;
	Wed,  5 Mar 2025 13:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P+KP1+ev"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B4C24EF93
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 13:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741180029; cv=none; b=JaaxVbSXkMVHabSXVPCtqJ5TeI7EWkUbdfGggmJmuQGXRHGI/93P2YbNQSm/b8KkMGSUaMhwtiTbznxn3cKni/KbIfMWN/RVEo2eh0UPjve/6XBQ/F2Z85zBwviWCZWe1rT6H5CmRrUd+qwIB6Wy82lYyqDiEmO1dc3vO3OwDRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741180029; c=relaxed/simple;
	bh=uaDU2c9FCb/hwcEUY5xm+kLs30U+GgsVCYpLCod7Kyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pwvwnf+UmUU5bmAFsrshNP6EGduLJgrGL4Mpez0IHGMioMSCeGK/jh3x8fqN9uqNyuXIjYX0gvRPYeyS1J919MoHvQX3q75L/1Gy09d9rYftIKXbTeJy1H9mg+7nWhJYJavPL4nmwKzieJPW5X6bciErLgenZg9C1wM9gAl7s/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P+KP1+ev; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e5491eb37dso5912548a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 05:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741180024; x=1741784824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqKSZBP+OJWF5gJmf7xM2I9adV5PGtGazVdFpn+CQSw=;
        b=P+KP1+evO9rFH5oD0uOVeHXfbVXLyll/N4qVNuH3ZwSQQAonKxxSbMOosgx/bFKqPx
         FqTE1hu5d9FOK+B4czE1hADtj/sb0myM3OlSsBOy1BA8JN23hOHH6ghyhHOOSR/S/RDY
         NVHIPCZtur49aVaMxHpXRh67Wn9EgtJB32sgrXPpUrbyQCHYA5ikDiK0GMZIc6EHXHeO
         JcLuCgeqb4+thGeubZJi7L//Bm8T9Nstr4H382txg05nqAwn1rtdILBikQgJbN1mwJ8z
         K/Yk0a7Ap9bPZkUPIvs3dzZrTD3FdGrC+d95N2ubzG31soID1c5S56qoRak6FKnKT3ex
         3tuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741180024; x=1741784824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqKSZBP+OJWF5gJmf7xM2I9adV5PGtGazVdFpn+CQSw=;
        b=ET4CMNBhRLYYOFdJRajA6S4C1miAMaykXywNKhMRxy/31MpBEdPQCi58GobbJU+tnI
         lp70RXhDCy1krsSMqVxlqL6B+4GY3HAZc+jXAkKlilsPNN2uA4FcYEVA93Jri/QPNRLG
         dC6IVc0rympoJYxQh8xjFRALurTn6DiSLOFyPjEkNmPcvsSEkqMJp/oyo3bCq8jmxx/S
         I/zJFXnz7fTV0DfCnGtJ70vVa8Li8hQ9y3JWvII6Bo1L4CQKc1g3XA4sDN0HZ5fpuLCf
         VU/oVv2TB0g2Lbjve12hP+A9xPFaDenEFlm5ljxopAjGn6g06/nKSMBwSXRPPUpuT5A0
         nTtQ==
X-Gm-Message-State: AOJu0YzPY9N+4Ag7eVNGC1tcmE86UWArPRunw0yEPCX12UKIXHD99uKx
	UwcDJQoWXEiCKRat2zR1eblBbbs6T4slzGvZyFoOTwVVoJe5crGYu0JQHsSLAYxXdb6J/fDOkbh
	jcFo=
X-Gm-Gg: ASbGncs1NQodfZg2fZ4TUSAdI/fkTzfckZFctI0cxD3a4SK1XJOe3y08QwYF6FLCUqM
	KdjN29gXT+WjIP3WvuDX19zP1UbsTck2wLTzR+d7S2LHw9ydxnoVqMQmGBioaYOODJ57bxgcayQ
	HXYmjJ1RIwTXCYZo2Qdonm+rcqblr+wb0LVDM18+1bRG63t1ER802awlSAnjaFWOrrNQpRKVxHW
	QRade1+54dZKGEXwqMtpNsMQroF+GbQ7vIxkin8ccYltLY8A3xa8WFc8TEogC92bypuP/NXOGny
	OX6kcNrypY5/m5hBw21bHMyXHhDafejBdM8N3Zkc5plOgThnHj7539YTq2HGrXwUWFmOrJ5t8iw
	KRYgo5YmwKVKrwHS0JCZnHQ==
X-Google-Smtp-Source: AGHT+IE15Fnv9zCGL44EN+x0x28iZKYTfWnu4C8Tigs1ik2W/BgqyNM9ZszaJHzYmQDtEqzGDoT2bw==
X-Received: by 2002:a05:6402:2344:b0:5e5:827d:bb1c with SMTP id 4fb4d7f45d1cf-5e59f471818mr2458803a12.25.1741180024315;
        Wed, 05 Mar 2025 05:07:04 -0800 (PST)
Received: from rayden.urgonet (h-98-128-140-123.A175.priv.bahnhof.se. [98.128.140.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5bcd1595bsm65714a12.42.2025.03.05.05.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 05:07:03 -0800 (PST)
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
Subject: [PATCH v6 09/10] optee: FF-A: dynamic restricted memory allocation
Date: Wed,  5 Mar 2025 14:04:15 +0100
Message-ID: <20250305130634.1850178-10-jens.wiklander@linaro.org>
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

Add support in the OP-TEE backend driver dynamic restricted memory
allocation with FF-A.

The restricted memory pools for dynamically allocated restrict memory
are instantiated when requested by user-space. This instantiation can
fail if OP-TEE doesn't support the requested use-case of restricted
memory.

Restricted memory pools based on a static carveout or dynamic allocation
can coexist for different use-cases. We use only dynamic allocation with
FF-A.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/Makefile        |   1 +
 drivers/tee/optee/ffa_abi.c       | 143 ++++++++++++-
 drivers/tee/optee/optee_private.h |  13 +-
 drivers/tee/optee/rstmem.c        | 329 ++++++++++++++++++++++++++++++
 4 files changed, 483 insertions(+), 3 deletions(-)
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
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index e4b08cd195f3..6a55114232ef 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -672,6 +672,123 @@ static int optee_ffa_do_call_with_arg(struct tee_context *ctx,
 	return optee_ffa_yielding_call(ctx, &data, rpc_arg, system_thread);
 }
 
+static int do_call_lend_rstmem(struct optee *optee, u64 cookie, u32 use_case)
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
+	msg_arg->cmd = OPTEE_MSG_CMD_ASSIGN_RSTMEM;
+	msg_arg->params[0].attr = OPTEE_MSG_ATTR_TYPE_VALUE_INPUT;
+	msg_arg->params[0].u.value.a = cookie;
+	msg_arg->params[0].u.value.b = use_case;
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
+static int optee_ffa_lend_rstmem(struct optee *optee, struct tee_shm *rstmem,
+				 u16 *end_points, unsigned int ep_count,
+				 u32 use_case)
+{
+	struct ffa_device *ffa_dev = optee->ffa.ffa_dev;
+	const struct ffa_mem_ops *mem_ops = ffa_dev->ops->mem_ops;
+	const struct ffa_msg_ops *msg_ops = ffa_dev->ops->msg_ops;
+	struct ffa_send_direct_data data;
+	struct ffa_mem_region_attributes *mem_attr;
+	struct ffa_mem_ops_args args = {
+		.use_txbuf = true,
+		.tag = use_case,
+	};
+	struct page *page;
+	struct scatterlist sgl;
+	unsigned int n;
+	int rc;
+
+	mem_attr = kcalloc(ep_count, sizeof(*mem_attr), GFP_KERNEL);
+	for (n = 0; n < ep_count; n++) {
+		mem_attr[n].receiver = end_points[n];
+		mem_attr[n].attrs = FFA_MEM_RW;
+	}
+	args.attrs = mem_attr;
+	args.nattrs = ep_count;
+
+	page = phys_to_page(rstmem->paddr);
+	sg_init_table(&sgl, 1);
+	sg_set_page(&sgl, page, rstmem->size, 0);
+
+	args.sg = &sgl;
+	rc = mem_ops->memory_lend(&args);
+	kfree(mem_attr);
+	if (rc)
+		return rc;
+
+	rc = do_call_lend_rstmem(optee, args.g_handle, use_case);
+	if (rc)
+		goto err_reclaim;
+
+	rc = optee_shm_add_ffa_handle(optee, rstmem, args.g_handle);
+	if (rc)
+		goto err_unreg;
+
+	rstmem->sec_world_id = args.g_handle;
+
+	return 0;
+
+err_unreg:
+	data = (struct ffa_send_direct_data){
+		.data0 = OPTEE_FFA_RELEASE_RSTMEM,
+		.data1 = (u32)args.g_handle,
+		.data2 = (u32)(args.g_handle >> 32),
+	};
+	msg_ops->sync_send_receive(ffa_dev, &data);
+err_reclaim:
+	mem_ops->memory_reclaim(args.g_handle, 0);
+	return rc;
+}
+
+static int optee_ffa_reclaim_rstmem(struct optee *optee, struct tee_shm *rstmem)
+{
+	struct ffa_device *ffa_dev = optee->ffa.ffa_dev;
+	const struct ffa_msg_ops *msg_ops = ffa_dev->ops->msg_ops;
+	const struct ffa_mem_ops *mem_ops = ffa_dev->ops->mem_ops;
+	u64 global_handle = rstmem->sec_world_id;
+	struct ffa_send_direct_data data = {
+		.data0 = OPTEE_FFA_RELEASE_RSTMEM,
+		.data1 = (u32)global_handle,
+		.data2 = (u32)(global_handle >> 32)
+	};
+	int rc;
+
+	optee_shm_rem_ffa_handle(optee, global_handle);
+	rstmem->sec_world_id = 0;
+
+	rc = msg_ops->sync_send_receive(ffa_dev, &data);
+	if (rc)
+		pr_err("Release SHM id 0x%llx rc %d\n", global_handle, rc);
+
+	rc = mem_ops->memory_reclaim(global_handle, 0);
+	if (rc)
+		pr_err("mem_reclaim: 0x%llx %d", global_handle, rc);
+
+	return rc;
+}
+
 /*
  * 6. Driver initialization
  *
@@ -833,6 +950,8 @@ static const struct optee_ops optee_ffa_ops = {
 	.do_call_with_arg = optee_ffa_do_call_with_arg,
 	.to_msg_param = optee_ffa_to_msg_param,
 	.from_msg_param = optee_ffa_from_msg_param,
+	.lend_rstmem = optee_ffa_lend_rstmem,
+	.reclaim_rstmem = optee_ffa_reclaim_rstmem,
 };
 
 static void optee_ffa_remove(struct ffa_device *ffa_dev)
@@ -941,7 +1060,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 				  optee->pool, optee);
 	if (IS_ERR(teedev)) {
 		rc = PTR_ERR(teedev);
-		goto err_free_pool;
+		goto err_free_shm_pool;
 	}
 	optee->teedev = teedev;
 
@@ -988,6 +1107,24 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 			       rc);
 	}
 
+	if (IS_ENABLED(CONFIG_CMA) && !IS_MODULE(CONFIG_OPTEE) &&
+	    (sec_caps & OPTEE_FFA_SEC_CAP_RSTMEM)) {
+		enum tee_dma_heap_id id = TEE_DMA_HEAP_SECURE_VIDEO_PLAY;
+		struct tee_rstmem_pool *pool;
+
+		pool = optee_rstmem_alloc_cma_pool(optee, id);
+		if (IS_ERR(pool)) {
+			rc = PTR_ERR(pool);
+			goto err_notif_uninit;
+		}
+
+		rc = tee_device_register_dma_heap(optee->teedev, id, pool);
+		if (rc) {
+			pool->ops->destroy_pool(pool);
+			goto err_notif_uninit;
+		}
+	}
+
 	rc = optee_enumerate_devices(PTA_CMD_GET_DEVICES);
 	if (rc)
 		goto err_unregister_devices;
@@ -1001,6 +1138,8 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 
 err_unregister_devices:
 	optee_unregister_devices();
+	tee_device_unregister_all_dma_heaps(optee->teedev);
+err_notif_uninit:
 	if (optee->ffa.bottom_half_value != U32_MAX)
 		notif_ops->notify_relinquish(ffa_dev,
 					     optee->ffa.bottom_half_value);
@@ -1018,7 +1157,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	tee_device_unregister(optee->supp_teedev);
 err_unreg_teedev:
 	tee_device_unregister(optee->teedev);
-err_free_pool:
+err_free_shm_pool:
 	tee_shm_pool_free(pool);
 err_free_optee:
 	kfree(optee);
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index 20eda508dbac..faab31ad7c52 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -174,9 +174,14 @@ struct optee;
  * @do_call_with_arg:	enters OP-TEE in secure world
  * @to_msg_param:	converts from struct tee_param to OPTEE_MSG parameters
  * @from_msg_param:	converts from OPTEE_MSG parameters to struct tee_param
+ * @lend_rstmem:	lends physically contiguous memory as restricted
+ *			memory, inaccessible by the kernel
+ * @reclaim_rstmem:	reclaims restricted memory previously lent with
+ *			@lend_rstmem() and makes it accessible by the
+ *			kernel again
  *
  * These OPs are only supposed to be used internally in the OP-TEE driver
- * as a way of abstracting the different methogs of entering OP-TEE in
+ * as a way of abstracting the different methods of entering OP-TEE in
  * secure world.
  */
 struct optee_ops {
@@ -191,6 +196,10 @@ struct optee_ops {
 			      size_t num_params,
 			      const struct optee_msg_param *msg_params,
 			      bool update_out);
+	int (*lend_rstmem)(struct optee *optee, struct tee_shm *rstmem,
+			   u16 *end_points, unsigned int ep_count,
+			   u32 use_case);
+	int (*reclaim_rstmem)(struct optee *optee, struct tee_shm *rstmem);
 };
 
 /**
@@ -285,6 +294,8 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
 void optee_supp_init(struct optee_supp *supp);
 void optee_supp_uninit(struct optee_supp *supp);
 void optee_supp_release(struct optee_supp *supp);
+struct tee_rstmem_pool *optee_rstmem_alloc_cma_pool(struct optee *optee,
+						    enum tee_dma_heap_id id);
 
 int optee_supp_recv(struct tee_context *ctx, u32 *func, u32 *num_params,
 		    struct tee_param *param);
diff --git a/drivers/tee/optee/rstmem.c b/drivers/tee/optee/rstmem.c
new file mode 100644
index 000000000000..ea27769934d4
--- /dev/null
+++ b/drivers/tee/optee/rstmem.c
@@ -0,0 +1,329 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025, Linaro Limited
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/errno.h>
+#include <linux/genalloc.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/tee_core.h>
+#include <linux/types.h>
+#include "optee_private.h"
+
+struct optee_rstmem_cma_pool {
+	struct tee_rstmem_pool pool;
+	struct gen_pool *gen_pool;
+	struct optee *optee;
+	size_t page_count;
+	u16 *end_points;
+	u_int end_point_count;
+	u_int align;
+	refcount_t refcount;
+	u32 use_case;
+	struct tee_shm *rstmem;
+	/* Protects when initializing and tearing down this struct */
+	struct mutex mutex;
+};
+
+static struct optee_rstmem_cma_pool *
+to_rstmem_cma_pool(struct tee_rstmem_pool *pool)
+{
+	return container_of(pool, struct optee_rstmem_cma_pool, pool);
+}
+
+static int init_cma_rstmem(struct optee_rstmem_cma_pool *rp)
+{
+	int rc;
+
+	rp->rstmem = tee_shm_alloc_cma_phys_mem(rp->optee->ctx, rp->page_count,
+						rp->align);
+	if (IS_ERR(rp->rstmem)) {
+		rc = PTR_ERR(rp->rstmem);
+		goto err_null_rstmem;
+	}
+
+	/*
+	 * TODO unmap the memory range since the physical memory will
+	 * become inaccesible after the lend_rstmem() call.
+	 */
+	rc = rp->optee->ops->lend_rstmem(rp->optee, rp->rstmem, rp->end_points,
+					 rp->end_point_count, rp->use_case);
+	if (rc)
+		goto err_put_shm;
+	rp->rstmem->flags |= TEE_SHM_DYNAMIC;
+
+	rp->gen_pool = gen_pool_create(PAGE_SHIFT, -1);
+	if (!rp->gen_pool) {
+		rc = -ENOMEM;
+		goto err_reclaim;
+	}
+
+	rc = gen_pool_add(rp->gen_pool, rp->rstmem->paddr,
+			  rp->rstmem->size, -1);
+	if (rc)
+		goto err_free_pool;
+
+	refcount_set(&rp->refcount, 1);
+	return 0;
+
+err_free_pool:
+	gen_pool_destroy(rp->gen_pool);
+	rp->gen_pool = NULL;
+err_reclaim:
+	rp->optee->ops->reclaim_rstmem(rp->optee, rp->rstmem);
+err_put_shm:
+	tee_shm_put(rp->rstmem);
+err_null_rstmem:
+	rp->rstmem = NULL;
+	return rc;
+}
+
+static int get_cma_rstmem(struct optee_rstmem_cma_pool *rp)
+{
+	int rc = 0;
+
+	if (!refcount_inc_not_zero(&rp->refcount)) {
+		mutex_lock(&rp->mutex);
+		if (rp->gen_pool) {
+			/*
+			 * Another thread has already initialized the pool
+			 * before us, or the pool was just about to be torn
+			 * down. Either way we only need to increase the
+			 * refcount and we're done.
+			 */
+			refcount_inc(&rp->refcount);
+		} else {
+			rc = init_cma_rstmem(rp);
+		}
+		mutex_unlock(&rp->mutex);
+	}
+
+	return rc;
+}
+
+static void release_cma_rstmem(struct optee_rstmem_cma_pool *rp)
+{
+	gen_pool_destroy(rp->gen_pool);
+	rp->gen_pool = NULL;
+
+	rp->optee->ops->reclaim_rstmem(rp->optee, rp->rstmem);
+	rp->rstmem->flags &= ~TEE_SHM_DYNAMIC;
+
+	WARN(refcount_read(&rp->rstmem->refcount) != 1, "Unexpected refcount");
+	tee_shm_put(rp->rstmem);
+	rp->rstmem = NULL;
+}
+
+static void put_cma_rstmem(struct optee_rstmem_cma_pool *rp)
+{
+	if (refcount_dec_and_test(&rp->refcount)) {
+		mutex_lock(&rp->mutex);
+		if (rp->gen_pool)
+			release_cma_rstmem(rp);
+		mutex_unlock(&rp->mutex);
+	}
+}
+
+static int rstmem_pool_op_cma_alloc(struct tee_rstmem_pool *pool,
+				    struct sg_table *sgt, size_t size,
+				    size_t *offs)
+{
+	struct optee_rstmem_cma_pool *rp = to_rstmem_cma_pool(pool);
+	size_t sz = ALIGN(size, PAGE_SIZE);
+	phys_addr_t pa;
+	int rc;
+
+	rc = get_cma_rstmem(rp);
+	if (rc)
+		return rc;
+
+	pa = gen_pool_alloc(rp->gen_pool, sz);
+	if (!pa) {
+		rc = -ENOMEM;
+		goto err_put;
+	}
+
+	rc = sg_alloc_table(sgt, 1, GFP_KERNEL);
+	if (rc)
+		goto err_free;
+
+	sg_set_page(sgt->sgl, phys_to_page(pa), size, 0);
+	*offs = pa - rp->rstmem->paddr;
+
+	return 0;
+err_free:
+	gen_pool_free(rp->gen_pool, pa, size);
+err_put:
+	put_cma_rstmem(rp);
+
+	return rc;
+}
+
+static void rstmem_pool_op_cma_free(struct tee_rstmem_pool *pool,
+				    struct sg_table *sgt)
+{
+	struct optee_rstmem_cma_pool *rp = to_rstmem_cma_pool(pool);
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sgtable_sg(sgt, sg, i)
+		gen_pool_free(rp->gen_pool, sg_phys(sg), sg->length);
+	sg_free_table(sgt);
+	put_cma_rstmem(rp);
+}
+
+static int rstmem_pool_op_cma_update_shm(struct tee_rstmem_pool *pool,
+					 struct sg_table *sgt, size_t offs,
+					 struct tee_shm *shm,
+					 struct tee_shm **parent_shm)
+{
+	struct optee_rstmem_cma_pool *rp = to_rstmem_cma_pool(pool);
+
+	*parent_shm = rp->rstmem;
+
+	return 0;
+}
+
+static void pool_op_cma_destroy_pool(struct tee_rstmem_pool *pool)
+{
+	struct optee_rstmem_cma_pool *rp = to_rstmem_cma_pool(pool);
+
+	mutex_destroy(&rp->mutex);
+	kfree(rp);
+}
+
+static struct tee_rstmem_pool_ops rstmem_pool_ops_cma = {
+	.alloc = rstmem_pool_op_cma_alloc,
+	.free = rstmem_pool_op_cma_free,
+	.update_shm = rstmem_pool_op_cma_update_shm,
+	.destroy_pool = pool_op_cma_destroy_pool,
+};
+
+static int get_rstmem_config(struct optee *optee, u32 use_case,
+			     size_t *min_size, u_int *min_align,
+			     u16 *end_points, u_int *ep_count)
+{
+	struct tee_param params[2] = {
+		[0] = {
+			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT,
+			.u.value.a = use_case,
+		},
+		[1] = {
+			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT,
+		},
+	};
+	struct optee_shm_arg_entry *entry;
+	struct tee_shm *shm_param = NULL;
+	struct optee_msg_arg *msg_arg;
+	struct tee_shm *shm;
+	u_int offs;
+	int rc;
+
+	if (end_points && *ep_count) {
+		params[1].u.memref.size = *ep_count * sizeof(*end_points);
+		shm_param = tee_shm_alloc_priv_buf(optee->ctx,
+						   params[1].u.memref.size);
+		if (IS_ERR(shm_param))
+			return PTR_ERR(shm_param);
+		params[1].u.memref.shm = shm_param;
+	}
+
+	msg_arg = optee_get_msg_arg(optee->ctx, ARRAY_SIZE(params), &entry,
+				    &shm, &offs);
+	if (IS_ERR(msg_arg)) {
+		rc = PTR_ERR(msg_arg);
+		goto out_free_shm;
+	}
+	msg_arg->cmd = OPTEE_MSG_CMD_GET_RSTMEM_CONFIG;
+
+	rc = optee->ops->to_msg_param(optee, msg_arg->params,
+				      ARRAY_SIZE(params), params,
+				      false /*!update_out*/);
+	if (rc)
+		goto out_free_msg;
+
+	rc = optee->ops->do_call_with_arg(optee->ctx, shm, offs, false);
+	if (rc)
+		goto out_free_msg;
+	if (msg_arg->ret && msg_arg->ret != TEEC_ERROR_SHORT_BUFFER) {
+		rc = -EINVAL;
+		goto out_free_msg;
+	}
+
+	rc = optee->ops->from_msg_param(optee, params, ARRAY_SIZE(params),
+					msg_arg->params, true /*update_out*/);
+	if (rc)
+		goto out_free_msg;
+
+	if (!msg_arg->ret && end_points &&
+	    *ep_count < params[1].u.memref.size / sizeof(u16)) {
+		rc = -EINVAL;
+		goto out_free_msg;
+	}
+
+	*min_size = params[0].u.value.a;
+	*min_align = params[0].u.value.b;
+	*ep_count = params[1].u.memref.size / sizeof(u16);
+
+	if (msg_arg->ret == TEEC_ERROR_SHORT_BUFFER) {
+		rc = -ENOSPC;
+		goto out_free_msg;
+	}
+
+	if (end_points)
+		memcpy(end_points, tee_shm_get_va(shm_param, 0),
+		       params[1].u.memref.size);
+
+out_free_msg:
+	optee_free_msg_arg(optee->ctx, entry, offs);
+out_free_shm:
+	if (shm_param)
+		tee_shm_free(shm_param);
+	return rc;
+}
+
+struct tee_rstmem_pool *optee_rstmem_alloc_cma_pool(struct optee *optee,
+						    enum tee_dma_heap_id id)
+{
+	struct optee_rstmem_cma_pool *rp;
+	u32 use_case = id;
+	size_t min_size;
+	int rc;
+
+	rp = kzalloc(sizeof(*rp), GFP_KERNEL);
+	if (!rp)
+		return ERR_PTR(-ENOMEM);
+	rp->use_case = use_case;
+
+	rc = get_rstmem_config(optee, use_case, &min_size, &rp->align, NULL,
+			       &rp->end_point_count);
+	if (rc) {
+		if (rc != -ENOSPC)
+			goto err;
+		rp->end_points = kcalloc(rp->end_point_count,
+					 sizeof(*rp->end_points), GFP_KERNEL);
+		if (!rp->end_points) {
+			rc = -ENOMEM;
+			goto err;
+		}
+		rc = get_rstmem_config(optee, use_case, &min_size, &rp->align,
+				       rp->end_points, &rp->end_point_count);
+		if (rc)
+			goto err_kfree_eps;
+	}
+
+	rp->pool.ops = &rstmem_pool_ops_cma;
+	rp->optee = optee;
+	rp->page_count = min_size / PAGE_SIZE;
+	mutex_init(&rp->mutex);
+
+	return &rp->pool;
+
+err_kfree_eps:
+	kfree(rp->end_points);
+err:
+	kfree(rp);
+	return ERR_PTR(rc);
+}
-- 
2.43.0


