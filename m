Return-Path: <linux-kernel+bounces-171574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE94C8BE5DF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D5721C236B5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E2D160865;
	Tue,  7 May 2024 14:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fojrQ+mI"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFD41607A7
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 14:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091979; cv=none; b=eEeT1Fxl7Cko7UB5kRs/L8t5kTgll4jW1jy1BK+PmHqDe52DS6WrEE1ehMVkk7YYofwIDivgwVkLVmM/dFf64dA/cv/yS9ft+JoVdZm648ICqmDT8O4PuKcTIP46im0RlmJx1qoWRVEw7C/VeJYQVeo2l/vk2QU5WL9z8ENLM/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091979; c=relaxed/simple;
	bh=/u32NxJwpRrssHruSux3ZSYrSazvMyTW+Oc6RuusvT4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=lbUzRn7AE4+UBXLFNVlM/EmCzXndGTjlmtj/8vw3lTK4CUpVHIvN2/2QVcpAvZeGc6heQahp3s80mRii8XUQNmqZo30KtBSov72FXw3EYUGFrsm6KNW/t4F5TF3FnP8qMIgDU1MIIhouzVObAGmfBUxAczQAAsnsGHCfp2C70V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=fojrQ+mI; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f467fb2e66so2476159b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 07:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715091977; x=1715696777; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b+b6a14h4JCjFlQP6t364i5UnYTPW3CwsNAJ2Ic+YBk=;
        b=fojrQ+mIqtbTkZGc4i7aWVVypJyxH8rfo4xAJbiJdDHCsmRxPS01loIMfOV+aEpIB8
         q1TKP7qGi5ApGajtePpAtpU4y+bySFitIfzglloy+R5ayyHqCzYI9CdKswAGhgcxVQ9s
         h8yqwN9r9wdWkf5fHCLItpxohECdBeXbYlpu0fxCIK6cqREoTBiexjO71pLdlpaclJCV
         ITl4ZI5KgGvJqhF2xjjvlF/yzPiQ6e1y7RIFMm325US09wRXpmjZeMCFq5N68/IeaUw6
         OxsrmQBcjmAJpyrD7SGYq9jDfmOQcnTMPRtGQ9YqxOyf7Qh/PzGDRRLXk6E/7FCwcVZM
         zCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715091977; x=1715696777;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b+b6a14h4JCjFlQP6t364i5UnYTPW3CwsNAJ2Ic+YBk=;
        b=Ni5HnPXD08DyG6s0dBEyFz+ucIktuBYSOjU8ppmefoJPvakZlnt20igtseJPl2c48p
         Haztj1NLvkJGD72s3a8LIk+JEpLBTT4TaaUGmmwBSnsBO/FbSBsbR3+3XGU8SSfkDpvC
         QCEw8VpfOHcqmiaY7yQz0SLybK8a4dda6lfWbAJDUY+YRP8Pf855oSAHeqEYgHFfOX0d
         Z0KAPZC+uRY0la6sqIn86YqVLkoHJD+eD5mcIFQpPmcJDccidG1RX9wmeFyC12+w82r2
         acEYM0+QzdUA4UapvC0RERei7oAhn7TlBzvxBD6n9QBq4pgdIIf9SQR6/6/H1PYWd9ub
         Ek8w==
X-Forwarded-Encrypted: i=1; AJvYcCWz52gCYlv+o6hxrtXnTn4f/UU5wJgDyyunfU36EcEfN12qW4QA2d8Pk4lPJLNLHnfHZN0JqEjKx3vwyZMZaPZHN7U0F/4tGFwO79UK
X-Gm-Message-State: AOJu0YyH3T87Na7RDca9TVQKgy/Oxra1CUQzTz4j8LtcT8gO8S+kSgA2
	kwZgKsGMiE4lpyc897Zz1Juy1YH2pKeZZBZ767kqTwW4VF4j1yotELYLUkX/1ps=
X-Google-Smtp-Source: AGHT+IGGpKiuhFlm6XAxN2dekhHNztwFPkYH1wk0fi2F0H3c/gi7fQ/EHQEjzLAwbTOOSYiKwoJeKg==
X-Received: by 2002:a05:6a00:843:b0:6ea:86f2:24fb with SMTP id q3-20020a056a00084300b006ea86f224fbmr15303975pfk.25.1715091976310;
        Tue, 07 May 2024 07:26:16 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id i22-20020aa79096000000b006f44bcbe7e3sm7687554pfa.201.2024.05.07.07.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 07:26:16 -0700 (PDT)
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
Subject: [PATCH RFC RESEND 4/6] iommu/riscv: support nested iommu for getting iommu hardware information
Date: Tue,  7 May 2024 22:25:58 +0800
Message-Id: <20240507142600.23844-5-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240507142600.23844-1-zong.li@sifive.com>
References: <20240507142600.23844-1-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This patch implements .hw_info operation and the related data
structures for passing the IOMMU hardware capabilities for iommufd.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/iommu/riscv/iommu.c  | 23 +++++++++++++++++++++++
 include/uapi/linux/iommufd.h | 13 +++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index d38e09b138b6..072251f6ad85 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -19,6 +19,7 @@
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
+#include <uapi/linux/iommufd.h>
 
 #include "../iommu-pages.h"
 #include "iommu-bits.h"
@@ -1485,6 +1486,27 @@ static struct iommu_domain riscv_iommu_identity_domain = {
 	}
 };
 
+static void *riscv_iommu_hw_info(struct device *dev, u32 *length, u32 *type)
+{
+	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
+	struct iommu_hw_info_riscv_iommu *info;
+
+	if (!iommu)
+		return ERR_PTR(-ENODEV);
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
@@ -1560,6 +1582,7 @@ static void riscv_iommu_release_device(struct device *dev)
 static const struct iommu_ops riscv_iommu_ops = {
 	.pgsize_bitmap = SZ_4K,
 	.of_xlate = riscv_iommu_of_xlate,
+	.hw_info = riscv_iommu_hw_info,
 	.identity_domain = &riscv_iommu_identity_domain,
 	.blocked_domain = &riscv_iommu_blocking_domain,
 	.release_domain = &riscv_iommu_blocking_domain,
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 1dfeaa2e649e..ec9aafd7d373 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -475,15 +475,28 @@ struct iommu_hw_info_vtd {
 	__aligned_u64 ecap_reg;
 };
 
+/**
+ * struct iommu_hw_info_riscv_iommu - RISCV IOMMU hardware information
+ *
+ * @capability: Value of RISC-V IOMMU capability register
+ * @fctl: Value of RISC-V IOMMU feature control register
+ */
+struct iommu_hw_info_riscv_iommu {
+	__aligned_u64 capability;
+	__u32 fctl;
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


