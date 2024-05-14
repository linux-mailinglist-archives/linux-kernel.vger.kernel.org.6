Return-Path: <linux-kernel+bounces-179048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC61B8C5AEC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 20:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1B79281850
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 18:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A77B18133B;
	Tue, 14 May 2024 18:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="OzXmyPit"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59371802C7
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 18:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715710626; cv=none; b=eHy/azAQD+7OzdeQsbM+B1CRKkxRj4obm74+nm4NwMbqJE8bxIJV2JZdEKuQ+eQpsfoskxTCtGvUeIyzevf7RxJGsQTe3mtcuuHavDyTGzDPRrRcXWDNc9xKkLnFduyiGi+Gu8YFDlu7YNyEIXmHFYMnFsJVohSmbfBndcqdS4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715710626; c=relaxed/simple;
	bh=1ldkbdNjozovTFgJayE4MPhVnciMvoQfBKYgpqQwePk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LSwmVVw0CH4DtFf3/mhPA4mnFFKdJh7827OG3rgZRf3wEAqBKRHIZAZUeejuH1VbivbgIuRGY+acdh27S2g8vKbCJVjwbYVvQoztkoR8ABeo3DbPO0gu2r55DAMXfic0AuyuuXRRzymTkiHJLbHJN3W0LYMi4VPlXIcD/Z4owvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=OzXmyPit; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1ec4dc64c6cso42074935ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 11:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715710624; x=1716315424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Ov4N0BiYWMCzHOD82syI7y8HSpVewpJ8aAIenCzP8c=;
        b=OzXmyPityPnZtfUiNxMUqf1ObJT1NnkzNS7w8TzNUtTms3hExnn5iA3/mVJAcidWnd
         pYVFzI5WJ7lT9rgViKdEXytlanKQYrloYKlnLYW6RoFlOqY7dWd7mWG1wGMMHN2j1RIA
         8n9XtR8zm8ZZm5v3+cwr7+p2tAPLlPd0DVBAx5X1dgjo24vaqazveH+dVw7QhlUoFP0k
         ZrGHuavZs8LgLC3HfGGFrUpS21hVdJt8I6SiiT0Q9qc9Al+EJVSq76VRnzG2dyCT9qq+
         +EtMZ0TsKAoOk0+DtLaq7PNMn8pq1fUtYe0M1pNSyLaCz8eRuWN3Clgrg2meFuGibms2
         4R5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715710624; x=1716315424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Ov4N0BiYWMCzHOD82syI7y8HSpVewpJ8aAIenCzP8c=;
        b=ICq8H0PJe95Ug3QIiDnFTkxiuQIxHOxS60ZAKyyYoZOCenYS1GLEGYWTFYPdY1nssZ
         x+alAbSRtVMmFBAS3VOAasANHCsutLK3EPhlU7qfECxL0Adgd32JjyRAGEw3b2tx0ga4
         T0P9XMBNGEyLLvt1vtjg7UngbcScdsL9UDChFDUX5vZiI1O8lvFZdYTgcYc+E2XEkFEA
         w83JOjMvXlUpoIGL/c8qzHlkfJ6ZtaA4sN7WiWouWJ93ysw/m5eqJthy+vgdl/MQDOfL
         ZVdgL6pW/Uacg8HpLVsPSpFg/I9EHsvGm1bPZGYD90gToR20QBjqHkwUjb4H0wHlHDbC
         cu4w==
X-Forwarded-Encrypted: i=1; AJvYcCXsANn4Qt+anOAIGSzf/w3ihONfcGjkGXBo4M6uWsDxPjsk9I1+fAxryqav3UCmJdK7mFmbmXQzGv5MWiCrlnfcHWzs+54VlexrTCv/
X-Gm-Message-State: AOJu0YyasA+iteLaYuhNGd6mjR0GIkYrx/Q7tx5Dwpwz4r3rExMM/oa/
	Ue5nL3as51K1WP8W2+1toOxbtmA9PJo5IRUum77TK4BPmZS9i37n/9gDt3Wl+5o=
X-Google-Smtp-Source: AGHT+IFJNfqQMUbFyTbFk6O7qQproU4On+Ok9bCbTsa1ZgcHcdnvAZUcFLklw8fSte40jza5wuIs+w==
X-Received: by 2002:a17:902:ba8a:b0:1eb:acff:63bf with SMTP id d9443c01a7336-1ef43e26591mr125704035ad.37.1715710624155;
        Tue, 14 May 2024 11:17:04 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad6386sm100993625ad.80.2024.05.14.11.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 11:17:03 -0700 (PDT)
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
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v5 4/7] iommu/riscv: Enable IOMMU registration and device probe.
Date: Tue, 14 May 2024 11:16:16 -0700
Message-Id: <518a4b0bf651707a9508c169fe3868e669ec2c6d.1715708679.git.tjeznach@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715708679.git.tjeznach@rivosinc.com>
References: <cover.1715708679.git.tjeznach@rivosinc.com>
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


