Return-Path: <linux-kernel+bounces-443626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFD19EFA5E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F5D9166C93
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C77223E99;
	Thu, 12 Dec 2024 18:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SfmpS9BE"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC148223C7A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026693; cv=none; b=pNkt2Rh2aj/cOU/M//xH6JBH7kpIH1VeNPCVepJvWF5vI1SOzUHN7PhfJuulAATagCR74tcD1hUXKur/MbXCuXh1gYy0DVmdEi/cOt//YDGEqLKgZZOtpigb8XqXe/pVyolMcZ71iix7eY4n+qPIsi+GMFK9BdwFwYVDSQ5clys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026693; c=relaxed/simple;
	bh=gp+CHgCT6MfjzlV3G7e67wFLwUFxHaGVgOQC7Dq+A54=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ptug+UBk3iokSPTcqVaT3r0gq8PBLhTkhP0Q8iL8lef9sFtWgcsCqpwr1kK3dh6xJPLYVdeO+ctadRWNoGgqav3GR0ivxejEmveTxQl5tEggxhM67WnDf0SctkM2PC7rFDqAPnv6tRxZWS/+uRKkydH/QXSlz4AO+kbBCY6HJNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SfmpS9BE; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4361efc9d1fso8309595e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026690; x=1734631490; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fZxQMQu4cbyziwIooPRheQAiraNBUGRcC5SFKfDzOkk=;
        b=SfmpS9BEfOoaqYIHMFXJ3HTcb4xQlwgh61ekRXq+j9dmJSrC7s79whxHdmJHqrwoyk
         AEITO9SRsigGWuH1YsWbh5E5aenwVUgPsEtkAbfHQB+1ejwDgmsmuI5euuPX/6PTc8H/
         J2NZ8ISw9UPO/fIs4XIduouAxYawiy/yt+u+RNUkBOHT9a3W8R8R8BtsRpr9G+NWCPoU
         lmmjzfdE2cxF+4ULPt/DuolH88JOF30KjOzCox8y2553xBGdu0lPK8GkSk7vsagQMLb+
         k49r4Vjt84WbHHyS5sQc6xSuS6d9/xr1ImUA3MtbaL/OXS2aq50gzsRU0+C6C5diaQe1
         BDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026690; x=1734631490;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fZxQMQu4cbyziwIooPRheQAiraNBUGRcC5SFKfDzOkk=;
        b=TX8FWv+OvMc5LG+kJauOY/XDQ80h24rY3lkqfWVhi2z/mVeKPqAhZMGQdVGCxZaabp
         aRT4ERLQJi+KoYwTYnByN52zMjLqd9chskx4mP0CxSlnPwYJNDMYJaJrmCzy6WVCu5hD
         XQrdglwCQn9oihMG/wiW7/3/b80GY+5bYzprckFwnCreHNa6NtiU7ev0wME0SWmNR8Lp
         LoCbW9M5FqOgeqY6B6W61UqFsLZqCKRZVS0e/ztnpr/9vRlsKDnpV/EtdKN0XGaq2UIH
         hSexu252PND0AuuSvuxmOiiZQYSgfpE64rwPGelYTmOeDe9r3k9IGJAHlaZAbP01P4eJ
         ozTw==
X-Forwarded-Encrypted: i=1; AJvYcCWHR0MKQE0/SqWPFi7MFdJGW/tMpg2+Z8WTDO4GTaaNxfSS+arFwt7DDd14trKj8g9Vl/wolTC6UzK1dlE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj7/K6o81dG2dzfvwv7AtfI9Py5snxm4nPpSg2Di3oxraVSphI
	/3MYiIpN0WfA4KaIHII5vFypiudyyhWZ9cVF/wfnOgV2sDKZZHwZDmXHXindWaURonrflNZ0NkX
	bIoV26JxGSg==
X-Google-Smtp-Source: AGHT+IFzpfMVwcRrV2/gqjEcPWIIertEvfaFJMhjw3EeYh/NSeVQCIM7XVIoTxUlYOdKn5XnKjOATZ6q1zompA==
X-Received: from wmbay15.prod.google.com ([2002:a05:600c:1e0f:b0:434:ff52:1c7])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a011:b0:434:f623:a004 with SMTP id 5b1f17b1804b1-4361c3a157cmr72244495e9.16.1734026690208;
 Thu, 12 Dec 2024 10:04:50 -0800 (PST)
Date: Thu, 12 Dec 2024 18:03:27 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-4-smostafa@google.com>
Subject: [RFC PATCH v2 03/58] iommu/io-pgtable: Add configure() operation
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, robdclark@gmail.com, joro@8bytes.org, 
	robin.murphy@arm.com, jean-philippe@linaro.org, jgg@ziepe.ca, 
	nicolinc@nvidia.com, vdonnefort@google.com, qperret@google.com, 
	tabba@google.com, danielmentz@google.com, tzukui@google.com, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Allow IOMMU drivers to create the io-pgtable configuration without
allocating any tables. This will be used by the SMMUv3-KVM driver to
initialize a config and pass it to KVM.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/io-pgtable-arm.c | 16 ++++++++++++++++
 drivers/iommu/io-pgtable.c     | 15 +++++++++++++++
 include/linux/io-pgtable.h     | 15 +++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 8d435a5bcd9a..e85866c90290 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -148,6 +148,13 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
 	return NULL;
 }
 
+static int arm_64_lpae_configure_s1(struct io_pgtable_cfg *cfg)
+{
+	struct arm_lpae_io_pgtable data = {};
+
+	return arm_lpae_init_pgtable_s1(cfg, &data);
+}
+
 static struct io_pgtable *
 arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
 {
@@ -178,6 +185,13 @@ arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
 	return NULL;
 }
 
+static int arm_64_lpae_configure_s2(struct io_pgtable_cfg *cfg)
+{
+	struct arm_lpae_io_pgtable data = {};
+
+	return arm_lpae_init_pgtable_s2(cfg, &data);
+}
+
 static struct io_pgtable *
 arm_32_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
 {
@@ -264,12 +278,14 @@ struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s1_init_fns = {
 	.caps	= IO_PGTABLE_CAP_CUSTOM_ALLOCATOR,
 	.alloc	= arm_64_lpae_alloc_pgtable_s1,
 	.free	= arm_lpae_free_pgtable,
+	.configure	= arm_64_lpae_configure_s1,
 };
 
 struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s2_init_fns = {
 	.caps	= IO_PGTABLE_CAP_CUSTOM_ALLOCATOR,
 	.alloc	= arm_64_lpae_alloc_pgtable_s2,
 	.free	= arm_lpae_free_pgtable,
+	.configure	= arm_64_lpae_configure_s2,
 };
 
 struct io_pgtable_init_fns io_pgtable_arm_32_lpae_s1_init_fns = {
diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
index 8841c1487f00..be65f70ec2a6 100644
--- a/drivers/iommu/io-pgtable.c
+++ b/drivers/iommu/io-pgtable.c
@@ -99,3 +99,18 @@ void free_io_pgtable_ops(struct io_pgtable_ops *ops)
 	io_pgtable_init_table[iop->fmt]->free(iop);
 }
 EXPORT_SYMBOL_GPL(free_io_pgtable_ops);
+
+int io_pgtable_configure(struct io_pgtable_cfg *cfg)
+{
+	const struct io_pgtable_init_fns *fns;
+
+	if (cfg->fmt >= IO_PGTABLE_NUM_FMTS)
+		return -EINVAL;
+
+	fns = io_pgtable_init_table[cfg->fmt];
+	if (!fns || !fns->configure)
+		return -EOPNOTSUPP;
+
+	return fns->configure(cfg);
+}
+EXPORT_SYMBOL_GPL(io_pgtable_configure);
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index d7bfbf351975..f789234c703b 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -49,6 +49,7 @@ struct iommu_flush_ops {
 /**
  * struct io_pgtable_cfg - Configuration data for a set of page tables.
  *
+ * @fmt:	       Format used for these page tables
  * @quirks:        A bitmap of hardware quirks that require some special
  *                 action by the low-level page table allocator.
  * @pgsize_bitmap: A bitmap of page sizes supported by this set of page
@@ -62,6 +63,7 @@ struct iommu_flush_ops {
  *                 page table walker.
  */
 struct io_pgtable_cfg {
+	enum io_pgtable_fmt		fmt;
 	/*
 	 * IO_PGTABLE_QUIRK_ARM_NS: (ARM formats) Set NS and NSTABLE bits in
 	 *	stage 1 PTEs, for hardware which insists on validating them
@@ -241,6 +243,17 @@ struct io_pgtable_ops *alloc_io_pgtable_ops(enum io_pgtable_fmt fmt,
  */
 void free_io_pgtable_ops(struct io_pgtable_ops *ops);
 
+/**
+ * io_pgtable_configure - Create page table config
+ *
+ * @cfg:	The page table configuration.
+ *
+ * Initialize @cfg in the same way as alloc_io_pgtable_ops(), without allocating
+ * anything.
+ *
+ * Not all io_pgtable drivers implement this operation.
+ */
+int io_pgtable_configure(struct io_pgtable_cfg *cfg);
 
 /*
  * Internal structures for page table allocator implementations.
@@ -301,11 +314,13 @@ enum io_pgtable_caps {
  *
  * @alloc: Allocate a set of page tables described by cfg.
  * @free:  Free the page tables associated with iop.
+ * @configure: Create the configuration without allocating anything. Optional.
  * @caps:  Combination of @io_pgtable_caps flags encoding the backend capabilities.
  */
 struct io_pgtable_init_fns {
 	struct io_pgtable *(*alloc)(struct io_pgtable_cfg *cfg, void *cookie);
 	void (*free)(struct io_pgtable *iop);
+	int (*configure)(struct io_pgtable_cfg *cfg);
 	u32 caps;
 };
 
-- 
2.47.0.338.g60cca15819-goog


