Return-Path: <linux-kernel+bounces-546870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BC1A4FFC2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B01D173156
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B8C24501D;
	Wed,  5 Mar 2025 13:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="keg2ctqU"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDBA24BBF4
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 13:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741180024; cv=none; b=RQSxVErxez7pJaUXiGJJHix+NAMLQOu/OeOf8irXGOCUd1umj6VOhbHls5eb8S6mogyRWt5MLLvSaKyQMdL7yW+cqYptOKT07/VDkLINnFS5Bg/iH5vYTSvWsR9ErXi5kkYYrAoerZQ5JSMZcuCiKO1fDjBqy7UJDg7a5egV+Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741180024; c=relaxed/simple;
	bh=M7ELt2/bqUBtQfSHUosFiW+IHomsZKrTJudyA0W+Gbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kYQaRpIQ6I/o8VPIKkohtwUqwOlqt3sDfdVvmN7cjV7bcxZ+VQv7pwHBdUYUDfynS3Y5kluGT2d3Vm4+Y/TNXgvQYHIBwvQK1YGd1HUKu1cT+bC7fbkgI/3IqB8s/I4qvgwNFIAgNU6Or/n/E7uM9RlGUKaQ6/+Nfisht68Ztzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=keg2ctqU; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e4ce6e3b8cso1311715a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 05:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741180019; x=1741784819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6L88VawgT5clB6S0hOB/yQKL6Af309OnWxwlD6cmBU=;
        b=keg2ctqUTnf0M2AATzG9Jh8ZWU6kBfhvMppX6u7ea3LGQJkct/xzMyaPzfDmSfUKTA
         ulfNx5o0Mh40BZ7lhgXatozqMuwxModkl366NSUGnfluZSnDou0Ql6hhgYA2r8FIJW7p
         TNDBIoT5KZY+CdWBOi677cEWkH27Lhd0bz2yz0anJJ4a3bl2/DnPA5+oIngmJlFc97hq
         gGY+PMAf9jjYs3THgax/qw6ssU6YxOtB/2Olhz1aNOeDbX0kszgQsWUU9/gYapc8NYh+
         Nt1Vc4Fk1UU+RK8MVzd2ZenL65Yiwnvb5jFBZqCZ0d1qebwxNp0VNaahWgf3/+XeujBo
         4Msg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741180019; x=1741784819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+6L88VawgT5clB6S0hOB/yQKL6Af309OnWxwlD6cmBU=;
        b=qXj0IM7dbeDUR3gk/7pEnH+RbiNbyDsWjs1s+hupYhFkSx+ItuLA8A2C5IFCFHarPf
         PI/eN1HCs9IXNC9CsQwRQLOr/uru267oDRyNqtcxe3cRHwGKYmEVnp3O/ZdMYj4GHlgK
         9QolNUPnmz2ktDljDMXvbaLMfzmu4LogQi5C/QcD6gNeJDPgrzfJ0ihN+kxC33DmfQFX
         DER3I5f5jwRgIa0IetxkMdqK86wWKHOX5PyGoy8CZDroOjuREGtjrsn+WQd2lHbg3Wgp
         /hHSzZkk4VKS2Uc8D0XtDa24tLq5wnvriZHzAjmn6+NPg6eJ7c1P/5EGRmoGOyxu+7ld
         ss8Q==
X-Gm-Message-State: AOJu0YwC7DqqV51d/tj2v/omQgWU4SEAeK6OLZlaAn5iQFN1j+RTS0hY
	x0vS/asBmv/b40QFKElUG/gk4yOwJ0JHIOoo/msyOO51m8E+YsFRrcl2G+ZvUBNeF9sTaVk9n4u
	JleE=
X-Gm-Gg: ASbGncsA+WZiErBWzRuhI/XwI3jqRFH/JJ1wIRBz0Y6RMAmYeQdm3+oerScEasMNx6u
	2YDw070c4SHZ7ilJpZh5vqybPCHzur5g8/fR8rHVDL3ioVbrzmN+eyLogzoi6EEEiWMZ2owaArE
	erY+i5ck6Cl21ChOZTR2x09MyC9zq2jLfjMuvSL2t7gBqyTk6zN3kPjYaHoWOn3zNQ6u/IsK59H
	Kwp9F1b5sKFboYYmkflGUS2t0qi+rjogqNmNLq1VB0ifVFY3lV93e1M8LhaqXSFM/xYhEhP5YYQ
	RdwiSGFk6raiGmsu6WknCXdrM864czjEnqBuq+4if/+cCmCK13luWgtpImFA7fd3IzST8HfOa2u
	p5sDsyC7QrF0xUf9UCcYwmg==
X-Google-Smtp-Source: AGHT+IEAmgkcE8RyjO1pJJHrKqdAmUGw9vFkZJI7+m0/4SoKqcFz7yQm/3SS6AjKMMHXW07x446SxQ==
X-Received: by 2002:a05:6402:4309:b0:5e4:d52b:78a2 with SMTP id 4fb4d7f45d1cf-5e584f51077mr7080244a12.15.1741180019316;
        Wed, 05 Mar 2025 05:06:59 -0800 (PST)
Received: from rayden.urgonet (h-98-128-140-123.A175.priv.bahnhof.se. [98.128.140.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5bcd1595bsm65714a12.42.2025.03.05.05.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 05:06:57 -0800 (PST)
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
Subject: [PATCH v6 07/10] tee: add tee_shm_alloc_cma_phys_mem()
Date: Wed,  5 Mar 2025 14:04:13 +0100
Message-ID: <20250305130634.1850178-8-jens.wiklander@linaro.org>
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

Add tee_shm_alloc_cma_phys_mem() to allocate a physical memory using
from the default CMA pool. The memory is represented by a tee_shm object
using the new flag TEE_SHM_CMA_BUF to identify it as physical memory
from CMA.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/tee_shm.c    | 55 ++++++++++++++++++++++++++++++++++++++--
 include/linux/tee_core.h |  4 +++
 2 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 8b79918468b5..8d8341f8ebd7 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -3,8 +3,11 @@
  * Copyright (c) 2015-2017, 2019-2021 Linaro Limited
  */
 #include <linux/anon_inodes.h>
+#include <linux/cma.h>
 #include <linux/device.h>
 #include <linux/dma-buf.h>
+#include <linux/dma-map-ops.h>
+#include <linux/highmem.h>
 #include <linux/idr.h>
 #include <linux/io.h>
 #include <linux/mm.h>
@@ -13,7 +16,6 @@
 #include <linux/tee_core.h>
 #include <linux/uaccess.h>
 #include <linux/uio.h>
-#include <linux/highmem.h>
 #include "tee_private.h"
 
 /* extra references appended to shm object for registered shared memory */
@@ -59,7 +61,14 @@ static void tee_shm_release(struct tee_device *teedev, struct tee_shm *shm)
 	struct tee_shm *parent_shm = NULL;
 	void *p = shm;
 
-	if (shm->flags & TEE_SHM_DMA_BUF) {
+	if (shm->flags & TEE_SHM_CMA_BUF) {
+#if !IS_MODULE(CONFIG_TEE) && IS_ENABLED(CONFIG_CMA)
+		struct page *page = phys_to_page(shm->paddr);
+		struct cma *cma = dev_get_cma_area(&shm->ctx->teedev->dev);
+
+		cma_release(cma, page, shm->size / PAGE_SIZE);
+#endif
+	} else if (shm->flags & TEE_SHM_DMA_BUF) {
 		struct tee_shm_dmabuf_ref *ref;
 
 		ref = container_of(shm, struct tee_shm_dmabuf_ref, shm);
@@ -341,6 +350,48 @@ struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t size)
 }
 EXPORT_SYMBOL_GPL(tee_shm_alloc_priv_buf);
 
+struct tee_shm *tee_shm_alloc_cma_phys_mem(struct tee_context *ctx,
+					   size_t page_count, size_t align)
+{
+#if !IS_MODULE(CONFIG_TEE) && IS_ENABLED(CONFIG_CMA)
+	struct tee_device *teedev = ctx->teedev;
+	struct cma *cma = dev_get_cma_area(&teedev->dev);
+	struct tee_shm *shm;
+	struct page *page;
+
+	if (!tee_device_get(teedev))
+		return ERR_PTR(-EINVAL);
+
+	page = cma_alloc(cma, page_count, align, true/*no_warn*/);
+	if (!page)
+		goto err_put_teedev;
+
+	shm = kzalloc(sizeof(*shm), GFP_KERNEL);
+	if (!shm)
+		goto err_cma_crelease;
+
+	refcount_set(&shm->refcount, 1);
+	shm->ctx = ctx;
+	shm->paddr = page_to_phys(page);
+	shm->size = page_count * PAGE_SIZE;
+	shm->flags = TEE_SHM_CMA_BUF;
+
+	teedev_ctx_get(ctx);
+
+	return shm;
+
+err_cma_crelease:
+	cma_release(cma, page, page_count);
+err_put_teedev:
+	tee_device_put(teedev);
+
+	return ERR_PTR(-ENOMEM);
+#else
+	return ERR_PTR(-EINVAL);
+#endif
+}
+EXPORT_SYMBOL_GPL(tee_shm_alloc_cma_phys_mem);
+
 int tee_dyn_shm_alloc_helper(struct tee_shm *shm, size_t size, size_t align,
 			     int (*shm_register)(struct tee_context *ctx,
 						 struct tee_shm *shm,
diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
index 6bd833b6d0e1..b6727d9a3556 100644
--- a/include/linux/tee_core.h
+++ b/include/linux/tee_core.h
@@ -29,6 +29,7 @@
 #define TEE_SHM_POOL		BIT(2)  /* Memory allocated from pool */
 #define TEE_SHM_PRIV		BIT(3)  /* Memory private to TEE driver */
 #define TEE_SHM_DMA_BUF		BIT(4)	/* Memory with dma-buf handle */
+#define TEE_SHM_CMA_BUF		BIT(5)	/* CMA allocated memory */
 
 #define TEE_DEVICE_FLAG_REGISTERED	0x1
 #define TEE_MAX_DEV_NAME_LEN		32
@@ -307,6 +308,9 @@ void *tee_get_drvdata(struct tee_device *teedev);
  */
 struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t size);
 
+struct tee_shm *tee_shm_alloc_cma_phys_mem(struct tee_context *ctx,
+					   size_t page_count, size_t align);
+
 int tee_dyn_shm_alloc_helper(struct tee_shm *shm, size_t size, size_t align,
 			     int (*shm_register)(struct tee_context *ctx,
 						 struct tee_shm *shm,
-- 
2.43.0


