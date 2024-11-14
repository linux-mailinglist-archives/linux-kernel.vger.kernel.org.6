Return-Path: <linux-kernel+bounces-409640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D9D9C90D3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 226B5B47FAD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6E818132F;
	Thu, 14 Nov 2024 16:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="A4X/nqPm"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9711AAE23
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 16:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601151; cv=none; b=Ye21ttvDIZGm6rV6ZGIuFJEyaU9Yf09XCTNshKNttFJuh0ELiFw/pWQ40A4Hl/Ls5bwX8zdNE4Wa86Jmn6y/NTZGnBdie1yxszJ+J1aMYfFcLGo2o2FwUEzy6WVRimqUaV857qfboL59/yZw/Xr09Pa4PGT58hTtafZ8mIID08M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601151; c=relaxed/simple;
	bh=TFtkar47iRvavG7LpOfAS59Gk/J7yKNnx1BiLzNhwhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z1jOi1WMBidhz4W1WTPEDPfj+YhRwn5lyQku6f5vHP3+2clW38vqF46hC2dLi4PVRD+tc791aIj4shGPbEnWGiw/OyXjDJ/ST/vIOICsMQDV2DmbfYGGnRi4gaVBESn42sTE6vFXH0qe9G6ysHMo30BNjafqiQddCaCA+1wjXYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=A4X/nqPm; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4315c1c7392so7767745e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 08:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1731601147; x=1732205947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+uTuyHOKGUnE3VHWBJ7LYW/wszuVbaF5PQNKaXjnEr8=;
        b=A4X/nqPms2mqzeEN8bCdMwJ7VrdUuhdRMDBevZ1teUFRb15Zz6gUVroQep235Cgp0l
         d/c9yEx2lyl2PTPlaDqIo4vl0HrNY1IoPD7iWGYkyYHKBRM8F51lp7/DRWFl0aGl8KmD
         wK3zoKKsQKplorDb2XRnwv8cpUwyd0i4Y1uu3rsYptB87LulN5mENL3Vlll26vpRSRdG
         p4Onza33DjBnAs2xsQEKsTj7HLXUwBk9jjUslyaurnj1i3sPb8+yBKq5hH1Fo1EU8/4r
         153gXU46g/2Mf3s9QNQV4GXhbO82XpOIrBfIdL8q7lzZFhN7AxzQ5hQD1sErngJ/hITG
         CZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731601147; x=1732205947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+uTuyHOKGUnE3VHWBJ7LYW/wszuVbaF5PQNKaXjnEr8=;
        b=icntyIAV2sut+qF1Iu/6QHLFoKLbb90s8YJd9XSo6qMDi342dkvwUsgORxFKiII2Fu
         zKNGKONFNlkF/SlorTrJ2yrCBfr10f12m/1fP/uq0znSJN1y6RWDkTkcJ/8jcQbRj4lb
         PAP8KYHAvoN+pCdX6779CwQWbsBiV2IYpalnRGIf5K5xH1KZb4y8jt3tz1f4Lh/v9pV2
         DX49sxkRgIxmX+8h4iTqlR457aWDN6dWNIF1pCqPHTxZPoRx6EGVGkiFhsRggPDxyz3f
         78yViFl1Rv9ezO29KMrswAohEjmt3ZmzawNz8SML7jGPApHwkEEPQU0F5NBEgOF+9ek9
         Tm3w==
X-Forwarded-Encrypted: i=1; AJvYcCW0tGrUy5xGrj1s1zqThTmJSRB6dl1D+BHmAk7/UgIC7kKeZtH4jsJtsHlwqphNk5MCYZMSL5sG74IXlLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhH1/QI84YiH3S3lOrX18peTuS3NowttArF7drJcqSnB3ni608
	kEeJY/vo1NoKRROfO4RYpilgEKCBU9mBcwjDGb6SMwozAw7OcEmEuIDdcIPng1A=
X-Google-Smtp-Source: AGHT+IF+dux3jioiQujAjXbkRVUUE8HYuaL/Pb+N/XvgW2ONJ3mvlvI5/3yMLnI7JF+vXby3PurS7Q==
X-Received: by 2002:a05:6000:156b:b0:37d:498a:a233 with SMTP id ffacd0b85a97d-382185391demr2252298f8f.43.1731601147550;
        Thu, 14 Nov 2024 08:19:07 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ada4076sm1858965f8f.16.2024.11.14.08.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:19:07 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: tjeznach@rivosinc.com,
	zong.li@sifive.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	anup@brainfault.org,
	atishp@atishpatra.org,
	tglx@linutronix.de,
	alex.williamson@redhat.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Subject: [RFC PATCH 12/15] iommu/riscv: Add guest file irqbypass support
Date: Thu, 14 Nov 2024 17:18:57 +0100
Message-ID: <20241114161845.502027-29-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114161845.502027-17-ajones@ventanamicro.com>
References: <20241114161845.502027-17-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement irq_set_vcpu_affinity() in the RISCV IOMMU driver.
irq_set_vcpu_affinity() is the channel from a hypervisor to the
IOMMU needed to ensure that assigned devices which direct MSIs to
guest IMSIC addresses will have those MSI writes redirected to
their corresponding guest interrupt files.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/iommu/riscv/iommu-ir.c | 151 +++++++++++++++++++++++++++++++++
 drivers/iommu/riscv/iommu.c    |   4 +-
 drivers/iommu/riscv/iommu.h    |   3 +
 3 files changed, 156 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/riscv/iommu-ir.c b/drivers/iommu/riscv/iommu-ir.c
index c177e064b205..958270450ec1 100644
--- a/drivers/iommu/riscv/iommu-ir.c
+++ b/drivers/iommu/riscv/iommu-ir.c
@@ -7,6 +7,8 @@
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
 
+#include <asm/irq.h>
+
 #include "../iommu-pages.h"
 #include "iommu.h"
 
@@ -52,10 +54,159 @@ static size_t riscv_iommu_ir_nr_msiptes(struct riscv_iommu_domain *domain)
 	return max_idx + 1;
 }
 
+static void riscv_iommu_ir_msitbl_inval(struct riscv_iommu_domain *domain,
+					struct riscv_iommu_msipte *pte)
+{
+	struct riscv_iommu_bond *bond;
+	struct riscv_iommu_device *iommu, *prev;
+	struct riscv_iommu_command cmd;
+	u64 addr;
+
+	addr = pfn_to_phys(FIELD_GET(RISCV_IOMMU_MSIPTE_PPN, pte->pte));
+	riscv_iommu_cmd_inval_gvma(&cmd);
+	riscv_iommu_cmd_inval_set_addr(&cmd, addr);
+
+	/* Like riscv_iommu_iotlb_inval(), synchronize with riscv_iommu_bond_link() */
+	smp_mb();
+
+	rcu_read_lock();
+
+	prev = NULL;
+	list_for_each_entry_rcu(bond, &domain->bonds, list) {
+		iommu = dev_to_iommu(bond->dev);
+
+		if (iommu == prev)
+			continue;
+
+		riscv_iommu_cmd_send(iommu, &cmd);
+		riscv_iommu_cmd_sync(iommu, RISCV_IOMMU_IOTINVAL_TIMEOUT);
+		prev = iommu;
+	}
+
+	rcu_read_unlock();
+}
+
+static void riscv_iommu_ir_msitbl_update(struct riscv_iommu_domain *domain,
+					 struct riscv_iommu_msiptp_state *msiptp)
+{
+	struct riscv_iommu_bond *bond;
+	struct riscv_iommu_device *iommu, *prev;
+	struct riscv_iommu_command cmd;
+	struct iommu_fwspec *fwspec;
+	struct riscv_iommu_dc *dc;
+	int i;
+
+	/* Like riscv_iommu_ir_msitbl_inval(), synchronize with riscv_iommu_bond_link() */
+	smp_mb();
+	rcu_read_lock();
+
+	prev = NULL;
+	list_for_each_entry_rcu(bond, &domain->bonds, list) {
+		iommu = dev_to_iommu(bond->dev);
+		fwspec = dev_iommu_fwspec_get(bond->dev);
+
+		for (i = 0; i < fwspec->num_ids; i++) {
+			dc = riscv_iommu_get_dc(iommu, fwspec->ids[i]);
+			WRITE_ONCE(dc->msiptp, msiptp->msiptp);
+			WRITE_ONCE(dc->msi_addr_mask, msiptp->msi_addr_mask);
+			WRITE_ONCE(dc->msi_addr_pattern, msiptp->msi_addr_pattern);
+		}
+
+		dma_wmb();
+
+		if (iommu == prev)
+			continue;
+
+		riscv_iommu_cmd_inval_gvma(&cmd);
+		riscv_iommu_cmd_send(iommu, &cmd);
+		riscv_iommu_cmd_sync(iommu, RISCV_IOMMU_IOTINVAL_TIMEOUT);
+		prev = iommu;
+	}
+
+	rcu_read_unlock();
+}
+
+static int riscv_iommu_ir_msitbl_init(struct riscv_iommu_domain *domain,
+				      struct riscv_iommu_vcpu_info *vcpu_info)
+{
+	domain->msiptp.msi_addr_pattern = vcpu_info->msi_addr_pattern;
+	domain->msiptp.msi_addr_mask = vcpu_info->msi_addr_mask;
+	domain->group_index_bits = vcpu_info->group_index_bits;
+	domain->group_index_shift = vcpu_info->group_index_shift;
+
+	if (riscv_iommu_ir_nr_msiptes(domain) * sizeof(*domain->msi_root) > PAGE_SIZE * 2)
+		return -ENOMEM;
+
+	domain->msiptp.msiptp = virt_to_pfn(domain->msi_root) |
+				FIELD_PREP(RISCV_IOMMU_DC_MSIPTP_MODE,
+					   RISCV_IOMMU_DC_MSIPTP_MODE_FLAT);
+
+	riscv_iommu_ir_msitbl_update(domain, &domain->msiptp);
+
+	return 0;
+}
+
+static int riscv_iommu_irq_set_vcpu_affinity(struct irq_data *data, void *info)
+{
+	struct riscv_iommu_vcpu_info *vcpu_info = info;
+	struct riscv_iommu_domain *domain = data->domain->host_data;
+	struct riscv_iommu_msipte *pte;
+	int ret = -EINVAL;
+	u64 pteval;
+
+	if (WARN_ON(domain->domain.type != IOMMU_DOMAIN_UNMANAGED))
+		return ret;
+
+	spin_lock(&domain->msi_lock);
+
+	if (!domain->msiptp.msiptp) {
+		if (WARN_ON(!vcpu_info))
+			goto out_unlock;
+
+		ret = riscv_iommu_ir_msitbl_init(domain, vcpu_info);
+		if (ret)
+			goto out_unlock;
+	} else if (!vcpu_info) {
+		/*
+		 * Nothing to do here since we don't track host_irq <=> msipte mappings
+		 * nor reference count the ptes. If we did do that tracking then we would
+		 * decrement the reference count of the pte for the host_irq and possibly
+		 * clear its valid bit if it was the last one mapped.
+		 */
+		ret = 0;
+		goto out_unlock;
+	} else if (WARN_ON(vcpu_info->msi_addr_pattern != domain->msiptp.msi_addr_pattern ||
+			   vcpu_info->msi_addr_mask != domain->msiptp.msi_addr_mask ||
+			   vcpu_info->group_index_bits != domain->group_index_bits ||
+			   vcpu_info->group_index_shift != domain->group_index_shift)) {
+		goto out_unlock;
+	}
+
+	pte = riscv_iommu_ir_get_msipte(domain, vcpu_info->gpa);
+	if (!pte)
+		goto out_unlock;
+
+	pteval = FIELD_PREP(RISCV_IOMMU_MSIPTE_M, 3) |
+		 riscv_iommu_phys_to_ppn(vcpu_info->hpa) |
+		 FIELD_PREP(RISCV_IOMMU_MSIPTE_V, 1);
+
+	if (pte->pte != pteval) {
+		pte->pte = pteval;
+		riscv_iommu_ir_msitbl_inval(domain, pte);
+	}
+
+	ret = 0;
+
+out_unlock:
+	spin_unlock(&domain->msi_lock);
+	return ret;
+}
+
 static struct irq_chip riscv_iommu_irq_chip = {
 	.name			= "IOMMU-IR",
 	.irq_mask		= irq_chip_mask_parent,
 	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_set_vcpu_affinity	= riscv_iommu_irq_set_vcpu_affinity,
 };
 
 static int riscv_iommu_irq_domain_alloc_irqs(struct irq_domain *irqdomain,
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index c4a47b21c58f..46ac228ba7ac 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -544,8 +544,8 @@ static irqreturn_t riscv_iommu_fltq_process(int irq, void *data)
 }
 
 /* Lookup and initialize device context info structure. */
-static struct riscv_iommu_dc *riscv_iommu_get_dc(struct riscv_iommu_device *iommu,
-						 unsigned int devid)
+struct riscv_iommu_dc *riscv_iommu_get_dc(struct riscv_iommu_device *iommu,
+					  unsigned int devid)
 {
 	const bool base_format = !(iommu->caps & RISCV_IOMMU_CAPABILITIES_MSI_FLAT);
 	unsigned int depth;
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 6ce71095781c..2ca76edf48f5 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -127,6 +127,9 @@ struct riscv_iommu_bond {
 int riscv_iommu_init(struct riscv_iommu_device *iommu);
 void riscv_iommu_remove(struct riscv_iommu_device *iommu);
 
+struct riscv_iommu_dc *riscv_iommu_get_dc(struct riscv_iommu_device *iommu,
+					  unsigned int devid);
+
 void riscv_iommu_cmd_send(struct riscv_iommu_device *iommu,
 			  struct riscv_iommu_command *cmd);
 void riscv_iommu_cmd_sync(struct riscv_iommu_device *iommu,
-- 
2.47.0


