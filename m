Return-Path: <linux-kernel+bounces-367404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 003629A01CC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83FB71F25FEE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 06:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FAC1C07C7;
	Wed, 16 Oct 2024 06:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="V/ZcWRUU"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9B71B393A
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 06:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729061556; cv=none; b=eeKlPXiZcN5qiYecZ36KTL4t5/wY6ERPd8WTMEo7V5GQbSY7qpRJkmx1x52BgUBzI5iijVUeewWRQjd11UZhCOQzHFy5jjERWgQmdZ+/a87+gUhUakTE6eZgFEh+vcr+B3/f/M5YRt09YLJFYfQ8+/bq+/g4N28efUMdeIvQlB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729061556; c=relaxed/simple;
	bh=AYdXzOi/+3MhvKkKsxvMYJSyqlyNTjNbRw7I9TePmTg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JNesH0utsBzK67w7peRWLJTNEFAFcARYryX3Wm0Fpnxq4/26MZaZU5exAcbXxlWzUSerl2K9A83q1b9/Fs+iJpSJNFnEDsPgC6SdtUAa3t1PjzQRTPGgpHWmrcyCgdn2Yl6+cL9sBEhcFoCl8DdMktNNKfgeDZcbGO1Bx4918ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=V/ZcWRUU; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-656d8b346d2so4058917a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 23:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1729061554; x=1729666354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4qXMlGpKFmKsrTG7a5LCbQMsXJowMadHB0xL9z/+TE=;
        b=V/ZcWRUUtEeRKRFfzUj5K0aVce5U+1Y/61s0ZZpkAaAZDp2xe6gWscNlpszCEk9p8+
         nGQITeRK7U/mdw1sw4WnpffJfQsP8BL7sy4h0Si0Ma8Vq8PiOpw71cJH4UzSSd06spZJ
         mckIfkVH0xEy/uV01OKg221ET7Nk7gFoqyTDKKc5q2r2QlMvu+AciUt7pRIqKhi5Wbh8
         jODAJVewzqetSGV7fT9IFlby01YlVibmibkVppjqBpIEwiQqni1+uVSTsEfEcx5MZ2Fp
         geq6ZD6ajILrCLAbQ1kZlfkvZ/5Nh8IXwwpCYmUx8N26LWb3KVzcZpIQXAquk2ep/iwh
         0W0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729061554; x=1729666354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4qXMlGpKFmKsrTG7a5LCbQMsXJowMadHB0xL9z/+TE=;
        b=vnNRvZiB8XPmNHt7EhA7Xv184cHsuwANdRmSE1dtQfSrP87mtJ3pbALTY4WRCA/2u4
         rbgWwVZOE5USb39xyVWhYMkpTAjwPABpMSE+Uwl9x3fr9h1Cnxzu5HL5zSzQgdE+jhfa
         HmHZu/7OOIRvnpK2PmOJFfi2aii4QsUCUZantOVT5ErEGiI2NQ8ejPJOFqxwVZdlP0gf
         khLWNoYuuRdq37j9OEfaPYYPsc4dI/MFZyAJgHAMXsVpMMMUdtfHcXGWbPzCW2bAskdq
         LU2XdxMhTu3YKtLybTuCN8C7Xk5ns/aw9h66rgKxo7UwXzTWZ8uXepGSDCeNrDv3aymr
         9+wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFWYLtagWN37dv0DzdU4/vPg+uFkYm8AfpTgG+JS06SbJn38jy5EXjOQHpEclmb/yHtbynFH4vCDfPZ+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiXBoLS5WULBD0DbMXPSprmM0W81z5vqnY3eyJ/9/e8oCW+HBK
	0B9Da1MrBjtbPqNcYOMBKesVf+v30iuBNUq1q0yraxy6YqoDy0XT6CrJogLnIDM=
X-Google-Smtp-Source: AGHT+IEd3jNYTkKRaM58YopA7EHkB163xeeSgYuRuYoGHjtlDsyU6B1dsT/WH1axodH/Titr0Y0Jsg==
X-Received: by 2002:a05:6a21:9d83:b0:1d2:eb9d:9972 with SMTP id adf61e73a8af0-1d8c9587e1bmr20287472637.20.1729061554057;
        Tue, 15 Oct 2024 23:52:34 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e77370a83sm2410762b3a.5.2024.10.15.23.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 23:52:33 -0700 (PDT)
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
Subject: [PATCH v10 4/7] iommu/riscv: Enable IOMMU registration and device probe.
Date: Tue, 15 Oct 2024 23:52:16 -0700
Message-Id: <ba79c8eb9c7f1cd9a8961a1b048e3991ee9a2b05.1729059707.git.tjeznach@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1729059707.git.tjeznach@rivosinc.com>
References: <cover.1729059707.git.tjeznach@rivosinc.com>
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


