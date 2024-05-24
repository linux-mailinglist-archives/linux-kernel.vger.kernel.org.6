Return-Path: <linux-kernel+bounces-189052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF0A8CEA5B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 21:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5004D1F2380E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 19:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FC65F870;
	Fri, 24 May 2024 19:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="DQHXzLMJ"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FB97D417
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 19:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716579309; cv=none; b=nXaDd+nqMeNIdVlac5VldAEjysYW1TT0SoU1jDUsfKmUUs4CxfxUXBKw9k01SODS6sikEnfCX0j2UuwcLpccgCWZeGANYPOxFiDVsmQWEHYY/dT+GKwnwXHxdK0GsgaZrsxkQlrgKQpO4WEHFs787mHqAxdLuucO+ILPFLl7vrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716579309; c=relaxed/simple;
	bh=oKJItKnsBP2MoFoXF4GEbrlNHgVit/cPojwa15Gmbkk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BZ6NtislaAfDb+2rzqFgh+S/aoAkS76/qcZ0IfWN4NF/7kOHzUd9B2Rt5C1ZcrT+7+P/koa0IDnEb3QgKZHniJ38AjaaqBegLM+/Aqn6IIMUETlVKyHLIpCYOa0atRASu2KNHPfLXt2ysAd5x+zqicuCJiNT97wn5dx8eND9h18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=DQHXzLMJ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f8edddf756so1071327b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 12:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716579308; x=1717184108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gxi9dSsEt2UtDDs3loOHfKu3ofWZQsX1GUiGzyjfiYM=;
        b=DQHXzLMJYdmoS88LYBvmcb3/liFNJBZ3RrUeu1vQNsaXolAgN4/EbM/AwEiWtUlxZV
         dJkobvBLnX3ogDJDY1YnrvT6MYbdxxYhnbPZE+CStbjG8461sM7JrRy8K+p0owOYeMip
         YB44FY8gsMV75op1YmV0DTs5RBt7CrfbESKY64ZJfQbRVjxmxQcDjQAZYrcF7HbR6QaJ
         R5Ms0qf0uNwGqJIK+KFGjDYrC50jlHmClRJFwIATo4ZYEV+21nl3Ty85nxJXe+q7AdL6
         7zzIkGy/JNqE4KHjdvUPXlHMgiHiA34k4J7g8grgHizGtvfd7MMHBP1cJd8LTrPuP2PY
         0wGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716579308; x=1717184108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gxi9dSsEt2UtDDs3loOHfKu3ofWZQsX1GUiGzyjfiYM=;
        b=A0qJ/kaLz14dBsA/u2E9Wk+vP1lvMBOPxR8QrNP3fq5wdY27kP6i+o8b/Jbt9/WfzO
         mkvHkZZD/q+Qq1dgD2bDWoJ6Oj5oTKg6rXRioP5x8Oa7AGi0kF83HrfDn9Z56pRuv9RU
         w8MeY0mmjZ5/CmpTzSSNiRzrWhpNm8hvzZvJcXEsBfQVHuKFrMb6WjjZywm8Mbc1xriz
         0BlYp0MxpWzRWVlc/bba3w3m3Ky2BYUaXdG03UqsNl9UdJ2zaWx97qsHWUhbBGn7Q7jZ
         oodzPimKusm3uhNAESRRHT6S89hh2hTQ91cFpZUY/oYoYYlwfL1WY8bEPXUWj9+WWAp/
         o6QA==
X-Forwarded-Encrypted: i=1; AJvYcCUf1VqEb6L3PsBjbuI6qatyR8OKiB0Qmw0jGtPIfJRcj4knv0rf7wnqEBblO+u0GJqJ1Ggyf4AUqMpJE39rvBTmiPiocLMCdKPjxmdd
X-Gm-Message-State: AOJu0YxDmk8UQJz9pQOKUvflqXjkTjhMOLVIelYrs+Za2NxXFw06N8aC
	ja2a5pZxA/LFG8lR6gF7ZHEY/11HELpTzoQ235H175zwGiovzPI8a3SeVrdkI4o=
X-Google-Smtp-Source: AGHT+IEKtH6lrV41abiEeh8RWadoLdBF/iUtxB4SdAAAJTxupc9rXQotcI4G9k/vIwOqmlUrKhX+fA==
X-Received: by 2002:a05:6a00:2a0f:b0:6f8:b1dc:d980 with SMTP id d2e1a72fcca58-6f8f3f9074fmr3718630b3a.31.1716579307705;
        Fri, 24 May 2024 12:35:07 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fd4d878esm1441684b3a.190.2024.05.24.12.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 12:35:07 -0700 (PDT)
From: Tomasz Jeznach <tjeznach@rivosinc.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Sebastien Boeuf <seb@rivosinc.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@rivosinc.com,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Zong Li <zong.li@sifive.com>
Subject: [PATCH v6 4/7] iommu/riscv: Enable IOMMU registration and device probe.
Date: Fri, 24 May 2024 12:34:44 -0700
Message-Id: <0a2b572a22247cf3af3a790dc9277cb48ed37430.1716578450.git.tjeznach@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1716578450.git.tjeznach@rivosinc.com>
References: <cover.1716578450.git.tjeznach@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Advertise IOMMU device and its core API.
Only minimal implementation for single identity domain type, without
per-group domain protection.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
---
 drivers/iommu/riscv/iommu.c | 66 +++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 3c5a6b49669d..b8e0e4b62585 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/iommu.h>
 #include <linux/kernel.h>
+#include <linux/pci.h>
 
 #include "iommu-bits.h"
 #include "iommu.h"
@@ -36,6 +37,60 @@ static void riscv_iommu_disable(struct riscv_iommu_device *iommu)
 	riscv_iommu_writel(iommu, RISCV_IOMMU_REG_PQCSR, 0);
 }
 
+static int riscv_iommu_attach_identity_domain(struct iommu_domain *iommu_domain,
+					      struct device *dev)
+{
+	/* Global pass-through already enabled, do nothing for now. */
+	return 0;
+}
+
+static struct iommu_domain riscv_iommu_identity_domain = {
+	.type = IOMMU_DOMAIN_IDENTITY,
+	.ops = &(const struct iommu_domain_ops) {
+		.attach_dev = riscv_iommu_attach_identity_domain,
+	}
+};
+
+static int riscv_iommu_device_domain_type(struct device *dev)
+{
+	return IOMMU_DOMAIN_IDENTITY;
+}
+
+static struct iommu_group *riscv_iommu_device_group(struct device *dev)
+{
+	if (dev_is_pci(dev))
+		return pci_device_group(dev);
+	return generic_device_group(dev);
+}
+
+static int riscv_iommu_of_xlate(struct device *dev, const struct of_phandle_args *args)
+{
+	return iommu_fwspec_add_ids(dev, args->args, 1);
+}
+
+static struct iommu_device *riscv_iommu_probe_device(struct device *dev)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct riscv_iommu_device *iommu;
+
+	if (!fwspec || !fwspec->iommu_fwnode->dev || !fwspec->num_ids)
+		return ERR_PTR(-ENODEV);
+
+	iommu = dev_get_drvdata(fwspec->iommu_fwnode->dev);
+	if (!iommu)
+		return ERR_PTR(-ENODEV);
+
+	return &iommu->iommu;
+}
+
+static const struct iommu_ops riscv_iommu_ops = {
+	.of_xlate = riscv_iommu_of_xlate,
+	.identity_domain = &riscv_iommu_identity_domain,
+	.def_domain_type = riscv_iommu_device_domain_type,
+	.device_group = riscv_iommu_device_group,
+	.probe_device = riscv_iommu_probe_device,
+};
+
 static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
 {
 	u64 ddtp;
@@ -71,6 +126,7 @@ static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
 
 void riscv_iommu_remove(struct riscv_iommu_device *iommu)
 {
+	iommu_device_unregister(&iommu->iommu);
 	iommu_device_sysfs_remove(&iommu->iommu);
 }
 
@@ -95,5 +151,15 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 		return dev_err_probe(iommu->dev, rc,
 				     "cannot register sysfs interface\n");
 
+	rc = iommu_device_register(&iommu->iommu, &riscv_iommu_ops, iommu->dev);
+	if (rc) {
+		dev_err_probe(iommu->dev, rc, "cannot register iommu interface\n");
+		goto err_remove_sysfs;
+	}
+
 	return 0;
+
+err_remove_sysfs:
+	iommu_device_sysfs_remove(&iommu->iommu);
+	return rc;
 }
-- 
2.34.1


