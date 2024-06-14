Return-Path: <linux-kernel+bounces-215018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6E3908D50
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E3D81F21770
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF42A49626;
	Fri, 14 Jun 2024 14:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dDYAguRs"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6846245C1C
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 14:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374954; cv=none; b=YBz4UD83+7niSp/I26vBRPoIsIHGNooazwjBrwzIrn16InfM9syyynvueval1bcaqYdVFSaeCw1P9fExuzkantt7yiFIuIKPZoWb6GGP0Cs4dgdcoEfFlohPPcobqVV/6luAH8E0xsJh3baXHRY8smuneXHRFcmgxtq0cwfO03s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374954; c=relaxed/simple;
	bh=7Yb/SMMlZn1tJaUWC6e7+SVPbq9JvQRpG9Rr2Zf6yls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=tSgocYckwoR79WRgrmnbuxNWFuradj0OH4VqqBpl47CeoFUllwRiUiKMq0xmgE+7CuMILydhEFmEAJuUFSWZXw43u1RgJjC7RW9wWmVRmQ0Rr3Z+IX4Og4YmUcWp6rJWflZEbaSM1tUefirRPiPhHRmEDhl3mAypSaY01/ePu+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=dDYAguRs; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f717b3f2d8so24110005ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 07:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718374953; x=1718979753; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BxtO7IOLUtPSQ+XdcXJ6pDuSrhddnSGqhgchDX3PwwI=;
        b=dDYAguRsw8WcaLPhDDOYTwPKPYmtkKlK2A+JfqrrJpzbeiMoaimHR7Jra1LJ9QI9eM
         ks6gfiAmHgv5bHqoA/trlNQn0Utxp69J8U4T7fuPH63pmca6pcBdDQ99kRM/5+AjjKgV
         msZmYp0xmu1OgyatdmIwnbf8Oo1WAmPRDp6tCqvuLCdEpk73dD76kTdPj75fdogK3IpB
         QTZTPl9AJ1QwrH95ta4S52swvFjLFBanAAjPkWw8uypbCB51s+VbUFTjj1YmfHVpo/Cc
         GY6IoiMvciKlcik8QZW8lAk2jiymWnh+n/+wUGdXKGCuQgWnvZa0QExiMhnBhLevGqZs
         TycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718374953; x=1718979753;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BxtO7IOLUtPSQ+XdcXJ6pDuSrhddnSGqhgchDX3PwwI=;
        b=cYam5ZlqYNOr9cLnqxXkDIOlqUgycH3RSX7zKxMwFzs3RNYtDrcs38TPgsr2r9INU1
         MO13sJ/CDqZSoJT5v6HLzmZ+A9sO6yfeBBr4WfdLpwg0oZC7L9/Xr+mCKSQCJa3CIGfm
         ho5V8Xk2WaRjG3Cs8jF7ZWZaO+PTPowKgIdY1EPMUN4Wf13v1ZPT3vUtPUFyRpa4VRYE
         D0WtESMrGiiVViu3mZlGgzWkKFubfKgDPl86xJEU+7nip2lJiOmoQKvbXMc5SKLfsi6j
         TZXiGS+FAqaBO1b///rsWRkR9Ll6VHE8FTDoQGQfTXE2fRVK8RhX4FS35FxyJaNp/b9N
         bQiw==
X-Forwarded-Encrypted: i=1; AJvYcCUxec5GIzaqeJ/SZKnh395QNDgydztICYVa6pZ8kT+qhjAmuLTnzD9QtG3oBXks5VU5847iOpBIjIy7jryfDRZF0iGOSxEYtu6db02Z
X-Gm-Message-State: AOJu0Yx8gay2HJqN7SyChmPZxw9l+16LLaMFF8PSs1fJRe8zyVJrE34s
	6ilFObRGQJB+m04xXtNeTeYD+wrONkaJ+n2PlBiDJoZucHLvBWcOElttnsSpEek=
X-Google-Smtp-Source: AGHT+IG11s4ZHx3p3pdh0/8168TEMxbmtzHZ+b6vnWRUAkFpilwyNQyd4ZLsjbcQgl8XVHvD/vsepw==
X-Received: by 2002:a17:902:cccc:b0:1f7:126:5ba7 with SMTP id d9443c01a7336-1f84e42e7bamr92287235ad.21.1718374952848;
        Fri, 14 Jun 2024 07:22:32 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e559d9sm32522005ad.35.2024.06.14.07.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 07:22:32 -0700 (PDT)
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
Cc: Nicolin Chen <nicolinc@nvidia.com>
Subject: [RFC PATCH v2 09/10] iommu/dma: Support MSIs through nested domains
Date: Fri, 14 Jun 2024 22:21:55 +0800
Message-Id: <20240614142156.29420-10-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240614142156.29420-1-zong.li@sifive.com>
References: <20240614142156.29420-1-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Robin Murphy <robin.murphy@arm.com>

Currently, iommu-dma is the only place outside of IOMMUFD and drivers
which might need to be aware of the stage 2 domain encapsulated within
a nested domain. This would be in the legacy-VFIO-style case where we're
using host-managed MSIs with an identity mapping at stage 1, where it is
the underlying stage 2 domain which owns an MSI cookie and holds the
corresponding dynamic mappings. Hook up the new op to resolve what we
need from a nested domain.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/dma-iommu.c | 18 ++++++++++++++++--
 include/linux/iommu.h     |  4 ++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f731e4b2a417..d4235bb0a427 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1806,6 +1806,20 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	return NULL;
 }
 
+/*
+ * Nested domains may not have an MSI cookie or accept mappings, but they may
+ * be related to a domain which does, so we let them tell us what they need.
+ */
+static struct iommu_domain *iommu_dma_get_msi_mapping_domain(struct device *dev)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	if (domain && domain->type == IOMMU_DOMAIN_NESTED &&
+	    domain->ops->get_msi_mapping_domain)
+		domain = domain->ops->get_msi_mapping_domain(domain);
+	return domain;
+}
+
 /**
  * iommu_dma_prepare_msi() - Map the MSI page in the IOMMU domain
  * @desc: MSI descriptor, will store the MSI page
@@ -1816,7 +1830,7 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 {
 	struct device *dev = msi_desc_to_dev(desc);
-	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	struct iommu_domain *domain = iommu_dma_get_msi_mapping_domain(dev);
 	struct iommu_dma_msi_page *msi_page;
 	static DEFINE_MUTEX(msi_prepare_lock); /* see below */
 
@@ -1849,7 +1863,7 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 void iommu_dma_compose_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 {
 	struct device *dev = msi_desc_to_dev(desc);
-	const struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	const struct iommu_domain *domain = iommu_dma_get_msi_mapping_domain(dev);
 	const struct iommu_dma_msi_page *msi_page;
 
 	msi_page = msi_desc_get_iommu_cookie(desc);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 7bc8dff7cf6d..400df9ae7012 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -629,6 +629,8 @@ struct iommu_ops {
  * @enable_nesting: Enable nesting
  * @set_pgtable_quirks: Set io page table quirks (IO_PGTABLE_QUIRK_*)
  * @free: Release the domain after use.
+ * @get_msi_mapping_domain: Return the related iommu_domain that should hold the
+ *                          MSI cookie and accept mapping(s).
  */
 struct iommu_domain_ops {
 	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
@@ -659,6 +661,8 @@ struct iommu_domain_ops {
 				  unsigned long quirks);
 
 	void (*free)(struct iommu_domain *domain);
+	struct iommu_domain *
+		(*get_msi_mapping_domain)(struct iommu_domain *domain);
 };
 
 /**
-- 
2.17.1


