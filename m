Return-Path: <linux-kernel+bounces-359971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6E2999321
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3194B1F26A24
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CADE1D0E10;
	Thu, 10 Oct 2024 19:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1lsuJVXT"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096D11EABA8
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 19:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589717; cv=none; b=tJieUATeWcE7oUU9XubZ0S24UlsTN9e69cHIl4whx2+P4zrEOGTVWkzKZWvs8Bdb9ydazH1eZzSg0SIODH5g3BhzheXNnX88/EuF44Za3tYUX2LLqzzhkGHaA8Zi488GuKGxBNG5N2/aP+HBQ7iY1z4vc0qcSDlcbpiXzUt4/ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589717; c=relaxed/simple;
	bh=AYdXzOi/+3MhvKkKsxvMYJSyqlyNTjNbRw7I9TePmTg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T8mn2dB8Tl8pYr2nMoap50Z2aKu6p97w7OsM9q4sReCydCX1BBaoGwxWzkttxkAQhLMpGTmlDJtoNGVV74FRBsbe3WPBE8DzF2DI1tSEYWFiBLmDZpeKqzn54e7pJWDwsHApkHCyBFXUFXBZe9Em/CE0T2Wz6FnyG/pJquyz9PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=1lsuJVXT; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e2cc469c62so947837a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728589715; x=1729194515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4qXMlGpKFmKsrTG7a5LCbQMsXJowMadHB0xL9z/+TE=;
        b=1lsuJVXTN9H0xygMtI9SsoFW7ZV51G1NGESWRUwNCBZpDUwTN4IId3Gjm4HWTmuUiC
         GaA3sMIJ7ZRJzVAPfa1kT1M1xiBhgYEgCcjiu/u0+LX2gW/RNUoiP+moTeV3LdKTF1rc
         fNuRIrus0Q10qrOxucfXHNdZLimsL3CeWCit5yhcjHFYUzP0p3pMHyLzjdAWKxBEVdA0
         ga8uBgJ2QttPIFWNe1dKrvz2OwSuZl5uk5D3gFc/uj4eyYOSsvzYbVQyAQVKGJoqKJnm
         G1D9tmkGS2O1HGPYLDmIhQlUh+QlsJsTNkw4lQJAgwKoaaHevB5L1QgbNbX6iQhIPmEh
         1DeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728589715; x=1729194515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4qXMlGpKFmKsrTG7a5LCbQMsXJowMadHB0xL9z/+TE=;
        b=YliRhUwyfu/2uNHl+ghJ9txgLCOl6R2lbwIfixkSGFzcB6uALOyn7vG80eXSP2rQkr
         /JNrbDrPEZ0RJDLEKErNj32+0HhE3zhM2S7Qvx5JchY1P1Qi/fGU+dfGQZ5J73sy35B8
         Y/0zldPHr0wa5AmlAhKub8N/Vjd532PJpUT2bCzAYabGtw3iuESe0dy9prKLanYAU4b4
         sArNQq7tZQFoaid4WBJ/6eIiRElQsdiwY7kmz163VCXlpxbORv3I05hjIq8p38tuZoMl
         9BuKOLnrb8bOjK00E379gIspI80dcc00IO050x5YAn0JdBZBKDHxgbSCBtGhJM5PIWP7
         Uhjg==
X-Forwarded-Encrypted: i=1; AJvYcCVfGy0p71E7fbLC8WUGmatWvg7OkbuovC5wNwB3Y7iBKmZwUHPCpm6QZ/2n7gyaWrqcWbvaZ7gqHZtZQNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdSHaI/qqZ5jSGUVHbPm6wjIpc8ZljYItNsQYO/iU7NnFhRYOu
	2mFS52yKWqax7vlSMpjgg9jTZL8f0iDN8GTIBaCsIcWlTAgUvcVZQ13ngQp/eI0=
X-Google-Smtp-Source: AGHT+IEj2/u7FZghPaHL/5IsGO3x2HI0qsFfKZzSP1hLJLyUDJRIVNLcwKObyPH44KTPhNFh55uSHQ==
X-Received: by 2002:a17:90a:f683:b0:2e2:e2f8:104 with SMTP id 98e67ed59e1d1-2e2f0a1736emr355701a91.8.1728589715386;
        Thu, 10 Oct 2024 12:48:35 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2e6ef1ad0sm749135a91.49.2024.10.10.12.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 12:48:34 -0700 (PDT)
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
Subject: [PATCH v9 4/7] iommu/riscv: Enable IOMMU registration and device probe.
Date: Thu, 10 Oct 2024 12:48:07 -0700
Message-Id: <79d1846e13a99b27b24a988126b528291a6766be.1728579958.git.tjeznach@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1728579958.git.tjeznach@rivosinc.com>
References: <cover.1728579958.git.tjeznach@rivosinc.com>
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


