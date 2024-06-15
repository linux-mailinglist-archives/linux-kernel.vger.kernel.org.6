Return-Path: <linux-kernel+bounces-215710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 868CB909628
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 07:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 063561F20DD2
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 05:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF58E18EA2;
	Sat, 15 Jun 2024 05:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="SXoUcfpj"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5561B17BCA
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 05:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718429279; cv=none; b=Hzoz5PNuzQgItt7He5wQqMCpb+nvTKhYeJHd86VM40roRIWsDoNK3Xr/QHhXySOjX7FrizjvPLmeguvGhVG6NpSLo6Rz8TyV9bSZrtoMMLdCDCapD0oEcQXNecCi9ElL5/K/4QSEvwMU6ubp/iQAFX0ZfcBj4RtHCdOyQl0AX2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718429279; c=relaxed/simple;
	bh=AYdXzOi/+3MhvKkKsxvMYJSyqlyNTjNbRw7I9TePmTg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LDVpqg4HXuG5wGUZrkW7gzupPyjhGo7pn+TGd15chrjk1HKXNpJWjBYk6rmC6L+YiKJTe29FnwA3OoawmmsnsM1IfLllQVB/TF0EBH0/0ijQ6UKey+Kr04DzVQWmRW2CXw0FdTm/YrUQ2pyCRU+7ezA9BLdzS/2dQlcfTwacets=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=SXoUcfpj; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7042cb2abc8so2139203b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 22:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718429276; x=1719034076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4qXMlGpKFmKsrTG7a5LCbQMsXJowMadHB0xL9z/+TE=;
        b=SXoUcfpj5+QqzerEETDpgw1D37zIl6kCDJTZje7pqTHoMvd4wTac9eV8fPhJ8iyXzD
         nnPvBdjJDlQzDWjFHJ6zRHcR4fuawa/6fg41XyiIAkrTvNAIVAYFsAihHNc+U7S5z9SY
         EYi4Hk8vKvb+Rry1Js8dOmYb6qrmgmT+4TZpG7VF5eMLALQovAWMvIcdyBXWpVQtkBKE
         z2CLSoFOtxotIPngmnuoWLL+eY4qiqAm7jLbRqaDFW+03W+MP2HD75iB9x8WIOEl+ar1
         tRtGSSjU5XRSF1hcDT0/3lWileGkAWJaL0+di6R/CzqxLhwcYECsqRVxGQ+ldsMUU+sK
         I0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718429276; x=1719034076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4qXMlGpKFmKsrTG7a5LCbQMsXJowMadHB0xL9z/+TE=;
        b=Gg9R3a8P31Wdwxbh2EAlVp64MRf7tCfIS/I5H6QBMOJ6uGzgXY+29Jcx/SFvhMApOv
         pd27WaCvXRdqGqCesl1cVPXJ61zvABxncWor2h9/s0ytkQ+SB/hsGwcSf4eaMqmK61hl
         mZN1vVrqUVQi/14WUNXkNfG2BHsWSKGMzu6TfPb90X9ENfW4QY6d50DCI32Pg0HJuUCj
         phIs0i8IarAxurq0Gpzy03ASYZ9jB0NSbYMMLP5ncxe5h3Gj7Puir3yA3HqjrvSjBwab
         wc0/Sy2q7jV2wpj4MncCMPbUrOfvVoIeyL5sBdK3BpXaRnHsKdv80U5BRkl71AHsJ/sS
         MYzA==
X-Forwarded-Encrypted: i=1; AJvYcCVYMTfBh0Jq87+llm32HvQ7J3nnNcYGZQokN9Nu5Wi7Sh8GHI/O53Vy8GDvC9OBHTEFPv12+hyBFG7wuo60KInfLoT5eP0lQyzOhO7/
X-Gm-Message-State: AOJu0YxFq/aJuMUGH9hwW4o4yUTJVzLgf7Pnh3qjg7S2Mqt9IzaBet51
	Y5y/mTSJ2OSlhfiGXk2BWjtlPIuUtHXAKSkkJwmkRDWR5hCDAKu6uBSaG07x8pU=
X-Google-Smtp-Source: AGHT+IEKpMgRh5o3BPdhB1zSaaF7P6cYldcO4nlZCU/wDi4yPmPqCBmYu3hIUuni889NHwpJ7VajVw==
X-Received: by 2002:a05:6a00:4d17:b0:704:2f2b:a2a9 with SMTP id d2e1a72fcca58-705d721837amr4438399b3a.32.1718429275577;
        Fri, 14 Jun 2024 22:27:55 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb6b99bsm4081578b3a.143.2024.06.14.22.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 22:27:54 -0700 (PDT)
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
Subject: [PATCH v8 4/7] iommu/riscv: Enable IOMMU registration and device probe.
Date: Fri, 14 Jun 2024 22:27:34 -0700
Message-Id: <f2158ca381e04af699ab4c66dc7168269df1f95c.1718388909.git.tjeznach@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718388908.git.tjeznach@rivosinc.com>
References: <cover.1718388908.git.tjeznach@rivosinc.com>
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
index 223314f7ed0a..c54088bf138f 100644
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
@@ -74,6 +129,7 @@ static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
 
 void riscv_iommu_remove(struct riscv_iommu_device *iommu)
 {
+	iommu_device_unregister(&iommu->iommu);
 	iommu_device_sysfs_remove(&iommu->iommu);
 }
 
@@ -99,5 +155,15 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
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


