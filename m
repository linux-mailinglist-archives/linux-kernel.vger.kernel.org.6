Return-Path: <linux-kernel+bounces-215012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 466B9908D49
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEE4AB27920
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8FC17BBF;
	Fri, 14 Jun 2024 14:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="VUJ1YZyo"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E10A15E8C
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 14:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374939; cv=none; b=AmDusqUs9VKh4dx9o7kURE8d1keK0Xw8qAQBlThboUtQRn7kTwGLM3Ie9kDVQRyTIGCKxP7QdfyORZG1JtLxNYXAwB5u9Pzn/70xd2E5YsM7P6gFeGQjFqHHvU/1DGoXhMELkcWYj74JzEi9Xhm9XfmzyMDtBCx3sbjhGanRjsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374939; c=relaxed/simple;
	bh=7AgwP/NIXpZI892UfooA/8JyK1Fg8ru9MhfleWRh558=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ZOQbn9bbJI40NgcbMjGCD6q3Ya2duiC/hIdzwG8uEpkqBEbki7lKgemJWAAMC48h80ri5tzBRtVWFPIyPCLa+2hU3ieVBKAfa5eaA9pDC2QJxfOtR/rqH6JbudrQJd9oByXPhX30zK6vC8suQ+RDBi/S0VryJR7eDC7v5Oqnn8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=VUJ1YZyo; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f47f07acd3so20009895ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 07:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718374937; x=1718979737; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KYeKWdSVxdzca9c5AXktAohba5fPqz4T3QpSza6gBEI=;
        b=VUJ1YZyoCENRRAriz7QBLtDYfasGYEx2JRCb9349aNy3Jcvqs/fqb53l2O7dlHArIC
         34H0FC2fW6ucuXVRSuUbWYFXOM8Vy20XfcuW6lhlm300aDStAn5zKD1QO0HwQAWfHmTK
         kgseWgafRniQ1Pm/MLnmODJBa2tN6/lOW1LBVDitW/N7Sid7OfVlAhkGg9QZkgbXigwl
         kWvKgV23n4mrzcyVOVu6dDvXJ0IpMRZA+j+7Fa+zfggvQEQvzNkte/1pGzc1arYZKF50
         UdK1SYhvzUGMPAsagqG9T2aOtkLyEQyQ53On9eidKiDEy7aFtAUsTYE/aXjKl//SQt7s
         F7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718374937; x=1718979737;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KYeKWdSVxdzca9c5AXktAohba5fPqz4T3QpSza6gBEI=;
        b=atXRRG0Xez4r3X2UKVjAMrz7TU0dgD43wQm7iYufYLXlp2LYuNPmR0zK+Vbmceb9lp
         9gksLZJYLHu9OZSJQEVQOQgW6IkFZ2ZNtiitnRNs3nxx7YJjyyEjwp5n0406jJQhv8zC
         5CZG/7599ARVlOi2LbctnQPMn4Zwobr4hZwwcpex4t8tk2Mfkq7DYlN6Q9PJFn7FQzvl
         ltAGIedQ/HqcfYxGd/TJFFpyRVTRoJnms6k5vcpGuNMYu27a2zLGIYZuE9oaHWWm8d5Q
         QI160CY/iWkJq9PCdCvRtCmUugkJkyIxklUhMiSi4KA2esZLurkbhuwDDjWiozXriAL0
         sKzg==
X-Forwarded-Encrypted: i=1; AJvYcCXRnJAV0S83IvVMurPLEjetR3xiSo9qeqX1+Fp8xJZjop/x+1pa3F5+T0vkVU4oN4OkWPSHosD818sI53NcdPN3nFoRl9lBh3BHj0Hy
X-Gm-Message-State: AOJu0YyqeDJ7NMF98QpOWY7GPEpOUbgudS+BkOaSHIPZDn0zuvmPEfHd
	YI0+3ir7ypQ7egEo466cu0IRQSrDx8O1u6Ih5YJQVZJ1WADOSOGZdGK3VDa1LYQ=
X-Google-Smtp-Source: AGHT+IEaapuErqClzYkwdWIAoziKliaNOF4tmsWVaA2CtvzOJToxjwlNEcROXRtWO3Y8fdwM3JdA+g==
X-Received: by 2002:a17:903:1250:b0:1f7:2050:9a76 with SMTP id d9443c01a7336-1f8625c0d68mr33773445ad.8.1718374937555;
        Fri, 14 Jun 2024 07:22:17 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e559d9sm32522005ad.35.2024.06.14.07.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 07:22:17 -0700 (PDT)
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
Subject: [RFC PATCH v2 03/10] iommu/riscv: use data structure instead of individual values
Date: Fri, 14 Jun 2024 22:21:49 +0800
Message-Id: <20240614142156.29420-4-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240614142156.29420-1-zong.li@sifive.com>
References: <20240614142156.29420-1-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The parameter will be increased when we need to set up more
bit fields in the device context. Use a data structure to
wrap them up.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/iommu/riscv/iommu.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 1716b2251f38..9aeb4b20c145 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1045,7 +1045,7 @@ static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
  * interim translation faults.
  */
 static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
-				     struct device *dev, u64 fsc, u64 ta)
+				     struct device *dev, struct riscv_iommu_dc *new_dc)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct riscv_iommu_dc *dc;
@@ -1079,10 +1079,10 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
 	for (i = 0; i < fwspec->num_ids; i++) {
 		dc = riscv_iommu_get_dc(iommu, fwspec->ids[i]);
 		tc = READ_ONCE(dc->tc);
-		tc |= ta & RISCV_IOMMU_DC_TC_V;
+		tc |= new_dc->ta & RISCV_IOMMU_DC_TC_V;
 
-		WRITE_ONCE(dc->fsc, fsc);
-		WRITE_ONCE(dc->ta, ta & RISCV_IOMMU_PC_TA_PSCID);
+		WRITE_ONCE(dc->fsc, new_dc->fsc);
+		WRITE_ONCE(dc->ta, new_dc->ta & RISCV_IOMMU_PC_TA_PSCID);
 		/* Update device context, write TC.V as the last step. */
 		dma_wmb();
 		WRITE_ONCE(dc->tc, tc);
@@ -1369,20 +1369,20 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
-	u64 fsc, ta;
+	struct riscv_iommu_dc dc = {0};
 
 	if (!riscv_iommu_pt_supported(iommu, domain->pgd_mode))
 		return -ENODEV;
 
-	fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, domain->pgd_mode) |
-	      FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, virt_to_pfn(domain->pgd_root));
-	ta = FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, domain->pscid) |
-	     RISCV_IOMMU_PC_TA_V;
+	dc.fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, domain->pgd_mode) |
+		 FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, virt_to_pfn(domain->pgd_root));
+	dc.ta = FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, domain->pscid) |
+			   RISCV_IOMMU_PC_TA_V;
 
 	if (riscv_iommu_bond_link(domain, dev))
 		return -ENOMEM;
 
-	riscv_iommu_iodir_update(iommu, dev, fsc, ta);
+	riscv_iommu_iodir_update(iommu, dev, &dc);
 	riscv_iommu_bond_unlink(info->domain, dev);
 	info->domain = domain;
 
@@ -1484,9 +1484,12 @@ static int riscv_iommu_attach_blocking_domain(struct iommu_domain *iommu_domain,
 {
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
+	struct riscv_iommu_dc dc = {0};
+
+	dc.fsc = RISCV_IOMMU_FSC_BARE;
 
 	/* Make device context invalid, translation requests will fault w/ #258 */
-	riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, 0);
+	riscv_iommu_iodir_update(iommu, dev, &dc);
 	riscv_iommu_bond_unlink(info->domain, dev);
 	info->domain = NULL;
 
@@ -1505,8 +1508,12 @@ static int riscv_iommu_attach_identity_domain(struct iommu_domain *iommu_domain,
 {
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
+	struct riscv_iommu_dc dc = {0};
+
+	dc.fsc = RISCV_IOMMU_FSC_BARE;
+	dc.ta = RISCV_IOMMU_PC_TA_V;
 
-	riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, RISCV_IOMMU_PC_TA_V);
+	riscv_iommu_iodir_update(iommu, dev, &dc);
 	riscv_iommu_bond_unlink(info->domain, dev);
 	info->domain = NULL;
 
-- 
2.17.1


