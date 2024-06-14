Return-Path: <linux-kernel+bounces-215015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BFF908D4D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD11628A26B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34C539AD6;
	Fri, 14 Jun 2024 14:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="RVMZ0TJV"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BBE28DC7
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 14:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374947; cv=none; b=ZuBdkJhsKWpRXC1akUY85GJChkOCbyOodQBmG7/P6fQ5CcbEjfoJXNMNLzVFCP10Ey7pYPeBr10iH+iOLzk3O24OJc5u4gv/kteeoejeJ31OmYo7gISMwV/6KsrZiC2aisVE5vbXVIHf+NkLdrLRH76N32SX979SB8DeEELvqPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374947; c=relaxed/simple;
	bh=nU8H57vWK8w7/x5rQqwOK9kd4fm89ZlCq3T7oTy5L6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=hAyaGM2zHHN5t+y63isKVEDVwtBmXc2OUmN9k8F/0gweW1jyDlSryDzqnw97wFj+riEkT/RMixHp/MK2FCnUy2aMXNxFLxRXNXyW3+l5wSWAb+GMEmjZ/OINvZX/1WPgnKAw77BTpFwB3MjT9FHVfZTBMHKXGbtHmUbyvEE7pfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=RVMZ0TJV; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f480624d0fso17251525ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 07:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718374945; x=1718979745; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E4t/LszTGtZ4bHNAAc59INUfcR6I2TK1LJsq3cDy7I4=;
        b=RVMZ0TJViWdUPG8q2gDzh/t4LCRvUs4BVbZoyP1TqBec4pa91/bls5dXfOwUgdcChc
         Osy1wCXRKRIbFG0c/7zNdHknmnJBSvBmigFOPjqNLl+lIX0lsluu2zQyDzIolAT+HePL
         rqLwGAqGka7SrGj4hkGnSViBrAB7cUt78Kyf254jH3iHLU8t8zUH7GOZ7gY/+T1BunOF
         qdp8FXh4395BMwnSZDLA3nz0xTNEdT2+U7yMCROQiShmYAauEGPE7utir95NMZG31IjV
         eBDDUVfe87tAgMM32DYv69fhe2CvtEE5IqbswuMZZkqxo0khH8/UuBCZXpH7AR+rYFC9
         8zKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718374945; x=1718979745;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E4t/LszTGtZ4bHNAAc59INUfcR6I2TK1LJsq3cDy7I4=;
        b=g42iE3CKyVhoHj02eD3ScsFIoKrJcMFlvqFrykUJj89eBfGcIYX6dRtj2F374S7Qa5
         NyB2Iy9kmgC5UAzVaIbkmEoKr5binvnQ3xnUCVqIQ7EzuX+kZPIzIyEPtOHXFR3UU4cQ
         d3KnbXgwmXJIUo/7tZLNnCdVgodRbGmvNXtp5XRiBfix8IxfgX3Pzvhh9fRuFMyYZp6c
         9skug2g+wYVWNtk2QB8G3q0RyeRcWCN1TBi96zNAtLrEErxL9MwxrSg14LckXo+X7mgP
         g9dxYsUmLLiEZ7sNeheOQ+9jqriS9AFUXRO5laBxuVePBlYMbE3TfZoiSRkbG6q8PmW7
         qo1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXBfY3dgmQKemHhX+HoM1kkD40rr7uFiz3q/xOcDKf4YJnakItwF8j7l6CoPjhIqy/qkULV00gYT/6Cr3VL+sdQnlPAfO+zx1KmUSQt
X-Gm-Message-State: AOJu0Yx2hELgJVdACe8etcAcOCOP+YA4pn7otSQF0SU/km0a2FzoBpj+
	TP7Gxb+w2ZpPojun6AII166TlOLxOZVi4kSMuR+s9w4AHZZFu5n14Fl1vw4UWqLVcR5iX1GRyBZ
	7X9c=
X-Google-Smtp-Source: AGHT+IEUOmCzKpXiteK6r7fTuiEwyVLmZFa6bNiW2D8099v/kAcWiUtRw3i/QaJjtdfif4s5IWfWAw==
X-Received: by 2002:a17:902:f78b:b0:1f8:70d7:d7ee with SMTP id d9443c01a7336-1f870d7dc6bmr4584665ad.46.1718374945100;
        Fri, 14 Jun 2024 07:22:25 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e559d9sm32522005ad.35.2024.06.14.07.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 07:22:24 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	tjeznach@rivosinc.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org
Cc: Zong Li <zong.li@sifive.com>
Subject: [RFC PATCH v2 06/10] iommu/riscv: support nested iommu for getting iommu hardware information
Date: Fri, 14 Jun 2024 22:21:52 +0800
Message-Id: <20240614142156.29420-7-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240614142156.29420-1-zong.li@sifive.com>
References: <20240614142156.29420-1-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This patch implements .hw_info operation and the related data
structures for passing the IOMMU hardware capabilities for iommufd.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/iommu/riscv/iommu.c  | 20 ++++++++++++++++++++
 include/uapi/linux/iommufd.h | 18 ++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 45309bd096e5..2130106e421f 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -19,6 +19,7 @@
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
+#include <uapi/linux/iommufd.h>
 
 #include "../iommu-pages.h"
 #include "iommu-bits.h"
@@ -1567,6 +1568,24 @@ static struct iommu_domain riscv_iommu_identity_domain = {
 	}
 };
 
+static void *riscv_iommu_hw_info(struct device *dev, u32 *length, u32 *type)
+{
+	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
+	struct iommu_hw_info_riscv_iommu *info;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return ERR_PTR(-ENOMEM);
+
+	info->capability = iommu->caps;
+	info->fctl = riscv_iommu_readl(iommu, RISCV_IOMMU_REG_FCTL);
+
+	*length = sizeof(*info);
+	*type = IOMMU_HW_INFO_TYPE_RISCV_IOMMU;
+
+	return info;
+}
+
 static int riscv_iommu_device_domain_type(struct device *dev)
 {
 	return 0;
@@ -1644,6 +1663,7 @@ static void riscv_iommu_release_device(struct device *dev)
 static const struct iommu_ops riscv_iommu_ops = {
 	.pgsize_bitmap = SZ_4K,
 	.of_xlate = riscv_iommu_of_xlate,
+	.hw_info = riscv_iommu_hw_info,
 	.identity_domain = &riscv_iommu_identity_domain,
 	.blocked_domain = &riscv_iommu_blocking_domain,
 	.release_domain = &riscv_iommu_blocking_domain,
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 1dfeaa2e649e..736f4408b5e0 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -475,15 +475,33 @@ struct iommu_hw_info_vtd {
 	__aligned_u64 ecap_reg;
 };
 
+/**
+ * struct iommu_hw_info_riscv_iommu - RISCV IOMMU hardware information
+ *
+ * @capability: Value of RISC-V IOMMU capability register defined in
+ *              RISC-V IOMMU spec section 5.3 IOMMU capabilities
+ * @fctl: Value of RISC-V IOMMU feature control register defined in
+ *              RISC-V IOMMU spec section 5.4 Features-control register
+ *
+ * Don't advertise ATS support to the guest because driver doesn't support it.
+ */
+struct iommu_hw_info_riscv_iommu {
+	__aligned_u64 capability;
+	__u32 fctl;
+	__u32 __reserved;
+};
+
 /**
  * enum iommu_hw_info_type - IOMMU Hardware Info Types
  * @IOMMU_HW_INFO_TYPE_NONE: Used by the drivers that do not report hardware
  *                           info
  * @IOMMU_HW_INFO_TYPE_INTEL_VTD: Intel VT-d iommu info type
+ * @IOMMU_HW_INFO_TYPE_RISCV_IOMMU: RISC-V iommu info type
  */
 enum iommu_hw_info_type {
 	IOMMU_HW_INFO_TYPE_NONE,
 	IOMMU_HW_INFO_TYPE_INTEL_VTD,
+	IOMMU_HW_INFO_TYPE_RISCV_IOMMU,
 };
 
 /**
-- 
2.17.1


