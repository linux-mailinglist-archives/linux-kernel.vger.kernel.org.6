Return-Path: <linux-kernel+bounces-443663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAC39EFA8C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 450A2166631
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CF423EA61;
	Thu, 12 Dec 2024 18:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fk1hBHGN"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4BD23DE9A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026769; cv=none; b=WLGxG2T2to+mnAR8BFe41TfVZb++6FjEI2EzisKT8JKN4mrMME6nUxAGqPMe/0rTjCqkKXXKU+AlK16sNRslijC6/NNQDsrcI02qhK+h1YoW8EuKUHVqp+h5oM9/MseQbhZef9QMLgYf+Ytjmt+KEr8KjxBKW13yRAt/29SMvXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026769; c=relaxed/simple;
	bh=XHk9s5KgEnNMUGLMGLhFngN3D3QuPGl/2qoxo6DFT74=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pBmziNH+UxLq4DEEA1P1AMJ1JmXMtYyt9WaoLIbgi9LJXc+J81Un69We+kmXPZoHxV19aahJ/QRRfNQlnvmOweTzOwX/q1EUnWo0akljiFYJfOukKegiPT4HNDEDNnqFW9CiNzBpLJrBguxEL7gHiRBwAGuZwFR6RawYHCfkL4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fk1hBHGN; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4359206e1e4so9240555e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026766; x=1734631566; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rqPsJB88kXVR+TaQlcSaWv/z9lPFdx9zLwQbYqyNGLA=;
        b=fk1hBHGNVf4AoPNf5QHHwiyI6sX/YZPPUZUQ4Jgshz5bZjaai9WrLdWfXavRIBkRMv
         iC3ElxRf4KzujnSZnidLwEqomrBaQkVpio3DB3jA+Y0UsjagqOGZYZSvRsdcYKhAeExJ
         R3jrkb/ZJ+h1JT32yXGrWZ/6fUpIupXB1H+sHEaRxNMOx1PIGh1OrbeM0oMPdvRdk22Y
         v7aNt4jUB1Z/U+8NhhmipZEfslKhfAhipyxDQDuLk1eTTrSAP57//RyG+geanoUi56ry
         pVKRSIgcd2MCk+Rc/oYYB4QxeWSXS0tQKxyOSpD09R7RRWEaDHaUVc4C7NNDRBPalt+/
         IrcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026766; x=1734631566;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rqPsJB88kXVR+TaQlcSaWv/z9lPFdx9zLwQbYqyNGLA=;
        b=R0tFNYFpsVtNGI6gD0lg9Rw6t17aU5B91+IMeNVUxweldj7kzsaTaMoQ+/2oEmmR6M
         u+lChB9WE0aV7b7Kxr9TURRS1G5GiPjXTWt1t6VeNqZEQg7Rb6suNOS1wiTUaafAqWhb
         4uWq71Ia/+ozMfKK7oCwqo8v09/xuEjBpGFif/zDXSHBI1nqqBTY0/fNStR8TRMDeX7X
         fj+jUG8vrM+8qXjSvkt/Qh9HlRyvaEm37GzcjQ9EwdeldDBx8OTHxK+IlhMpQEqrvUAh
         j2GEO8oNiRqwXjDwv3GOB60vCmsjUcTzJBPvKs+4dfVOugCRqJ2zwn6HRWuLV0LDMQKj
         AgDw==
X-Forwarded-Encrypted: i=1; AJvYcCX7qF+EC5OVZ1j+eOUdWVCCncUyJwlAWJQgzwjPnYC6LacRMlFR+F2lcqqhVbSRVzki8J3fwuyuJxhuC9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTdTIWlRz0tc4bcaHU5KuVGMVeOEV7F8Ws7qALYJBh/iS7HMqV
	6y2CzJr4D+G9fa17EkzOSTHLLr+m+ItL9JrNh2QK5G3LGm8ZGHhk4DTMrDyTwlDpr1tM4B0xyft
	oZa99lWOtRQ==
X-Google-Smtp-Source: AGHT+IEsi+4ZjdjaE64e2fAsGHvL3ha82aYz7MzT70dGqsLuOIBzlVogt+pct6VgpmBHvLpi6wagEZsN2iELKw==
X-Received: from wmos10.prod.google.com ([2002:a05:600c:45ca:b0:434:fa72:f1bf])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4450:b0:434:f5c0:329f with SMTP id 5b1f17b1804b1-4361c3bd9e8mr84507805e9.14.1734026765211;
 Thu, 12 Dec 2024 10:06:05 -0800 (PST)
Date: Thu, 12 Dec 2024 18:04:03 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-40-smostafa@google.com>
Subject: [RFC PATCH v2 39/58] drivers/iommu: io-pgtable: Add IO_PGTABLE_QUIRK_UNMAP_INVAL
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, robdclark@gmail.com, joro@8bytes.org, 
	robin.murphy@arm.com, jean-philippe@linaro.org, jgg@ziepe.ca, 
	nicolinc@nvidia.com, vdonnefort@google.com, qperret@google.com, 
	tabba@google.com, danielmentz@google.com, tzukui@google.com, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Only invalidate PTE without clearing it.

For io-pgtable-armm that also leaves the table allocated after an
unmap as they can't be freed.

This quirk also will allow the page table walker to traverse through
tables invalidated by an unmap, allowing the caller to doing any
booking keeping and freeing the table after.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/io-pgtable-arm-common.c | 50 +++++++++++++++++++--------
 include/linux/io-pgtable-arm.h        |  7 +++-
 include/linux/io-pgtable.h            |  5 ++-
 3 files changed, 45 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-common.c b/drivers/iommu/io-pgtable-arm-common.c
index 076240eaec19..89be1aa72a6b 100644
--- a/drivers/iommu/io-pgtable-arm-common.c
+++ b/drivers/iommu/io-pgtable-arm-common.c
@@ -42,7 +42,10 @@ static phys_addr_t iopte_to_paddr(arm_lpae_iopte pte,
 static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct io_pgtable_cfg *cfg, int num_entries)
 {
 	for (int i = 0; i < num_entries; i++)
-		ptep[i] = 0;
+		if (cfg->quirks & IO_PGTABLE_QUIRK_UNMAP_INVAL)
+			ptep[i] &= ~ARM_LPAE_PTE_VALID;
+		else
+			ptep[i] = 0;
 
 	if (!cfg->coherent_walk && num_entries)
 		__arm_lpae_sync_pte(ptep, num_entries, cfg);
@@ -170,7 +173,7 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
 
 	/* Grab a pointer to the next level */
 	pte = READ_ONCE(*ptep);
-	if (!pte) {
+	if (!iopte_valid(pte)) {
 		cptep = __arm_lpae_alloc_pages(tblsz, gfp, cfg, data->iop.cookie);
 		if (!cptep)
 			return -ENOMEM;
@@ -182,9 +185,9 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
 		__arm_lpae_sync_pte(ptep, 1, cfg);
 	}
 
-	if (pte && !iopte_leaf(pte, lvl, data->iop.fmt)) {
+	if (iopte_valid(pte) && !iopte_leaf(pte, lvl, data->iop.fmt)) {
 		cptep = iopte_deref(pte, data);
-	} else if (pte) {
+	} else if (iopte_valid(pte)) {
 		/* We require an unmap first */
 		return arm_lpae_unmap_empty();
 	}
@@ -316,7 +319,7 @@ void __arm_lpae_free_pgtable(struct arm_lpae_io_pgtable *data, int lvl,
 	while (ptep != end) {
 		arm_lpae_iopte pte = *ptep++;
 
-		if (!pte || iopte_leaf(pte, lvl, data->iop.fmt))
+		if (!iopte_valid(pte) || iopte_leaf(pte, lvl, data->iop.fmt))
 			continue;
 
 		__arm_lpae_free_pgtable(data, lvl + 1, iopte_deref(pte, data));
@@ -401,7 +404,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 	unmap_idx_start = ARM_LPAE_LVL_IDX(iova, lvl, data);
 	ptep += unmap_idx_start;
 	pte = READ_ONCE(*ptep);
-	if (WARN_ON(!pte))
+	if (WARN_ON(!iopte_valid(pte)))
 		return 0;
 
 	/* If the size matches this level, we're in the right place */
@@ -412,7 +415,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 		/* Find and handle non-leaf entries */
 		for (i = 0; i < num_entries; i++) {
 			pte = READ_ONCE(ptep[i]);
-			if (WARN_ON(!pte))
+			if (WARN_ON(!iopte_valid(pte)))
 				break;
 
 			if (!iopte_leaf(pte, lvl, iop->fmt)) {
@@ -421,7 +424,9 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 				/* Also flush any partial walks */
 				io_pgtable_tlb_flush_walk(iop, iova + i * size, size,
 							  ARM_LPAE_GRANULE(data));
-				__arm_lpae_free_pgtable(data, lvl + 1, iopte_deref(pte, data));
+				if (!(iop->cfg.quirks & IO_PGTABLE_QUIRK_UNMAP_INVAL))
+					__arm_lpae_free_pgtable(data, lvl + 1,
+								iopte_deref(pte, data));
 			}
 		}
 
@@ -523,9 +528,12 @@ static int visit_pgtable_walk(struct io_pgtable_walk_data *walk_data, int lvl,
 	return 0;
 }
 
-static void visit_pgtable_post_table(struct arm_lpae_io_pgtable_walk_data *data,
+static void visit_pgtable_post_table(struct io_pgtable_walk_data *walk_data,
 				     arm_lpae_iopte *ptep, int lvl)
 {
+	struct io_pgtable_walk_common *walker = walk_data->data;
+	struct arm_lpae_io_pgtable_walk_data *data = walker->data;
+
 	if (data->visit_post_table)
 		data->visit_post_table(data, ptep, lvl);
 }
@@ -550,30 +558,41 @@ static int io_pgtable_visit(struct arm_lpae_io_pgtable *data,
 			    arm_lpae_iopte *ptep, int lvl)
 {
 	struct io_pgtable *iop = &data->iop;
+	struct io_pgtable_cfg *cfg = &iop->cfg;
 	arm_lpae_iopte pte = READ_ONCE(*ptep);
 	struct io_pgtable_walk_common *walker = walk_data->data;
+	arm_lpae_iopte *old_ptep = ptep;
+	bool is_leaf, is_table;
 
 	size_t size = ARM_LPAE_BLOCK_SIZE(lvl, data);
 	int ret = walk_data->visit(walk_data, lvl, ptep, size);
 	if (ret)
 		return ret;
 
-	if (iopte_leaf(pte, lvl, iop->fmt)) {
+	if (cfg->quirks & IO_PGTABLE_QUIRK_UNMAP_INVAL) {
+		/* Visitng invalid tables as it still have enteries. */
+		is_table = pte && iopte_table(pte | ARM_LPAE_PTE_VALID, lvl);
+		is_leaf = pte && iopte_leaf(pte | ARM_LPAE_PTE_VALID, lvl, iop->fmt);
+	} else {
+		is_table = iopte_table(pte, lvl);
+		is_leaf = iopte_leaf(pte, lvl, iop->fmt);
+	}
+
+	if (is_leaf) {
 		if (walker->visit_leaf)
 			walker->visit_leaf(iopte_to_paddr(pte, data), size, walker, ptep);
 		walk_data->addr += size;
 		return 0;
 	}
 
-	if (!iopte_table(pte, lvl)) {
+	if (!is_table)
 		return -EINVAL;
-	}
 
 	ptep = iopte_deref(pte, data);
 	ret = __arm_lpae_iopte_walk(data, walk_data, ptep, lvl + 1);
 
 	if (walk_data->visit_post_table)
-		walk_data->visit_post_table(data, ptep, lvl);
+		walk_data->visit_post_table(walk_data, old_ptep, lvl);
 
 	return ret;
 }
@@ -744,7 +763,8 @@ int arm_lpae_init_pgtable_s1(struct io_pgtable_cfg *cfg,
 	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS |
 			    IO_PGTABLE_QUIRK_ARM_TTBR1 |
 			    IO_PGTABLE_QUIRK_ARM_OUTER_WBWA |
-			    IO_PGTABLE_QUIRK_ARM_HD))
+			    IO_PGTABLE_QUIRK_ARM_HD |
+			    IO_PGTABLE_QUIRK_UNMAP_INVAL))
 		return -EINVAL;
 
 	ret = arm_lpae_init_pgtable(cfg, data);
@@ -830,7 +850,7 @@ int arm_lpae_init_pgtable_s2(struct io_pgtable_cfg *cfg,
 	typeof(&cfg->arm_lpae_s2_cfg.vtcr) vtcr = &cfg->arm_lpae_s2_cfg.vtcr;
 
 	/* The NS quirk doesn't apply at stage 2 */
-	if (cfg->quirks)
+	if (cfg->quirks & ~IO_PGTABLE_QUIRK_UNMAP_INVAL)
 		return -EINVAL;
 
 	ret = arm_lpae_init_pgtable(cfg, data);
diff --git a/include/linux/io-pgtable-arm.h b/include/linux/io-pgtable-arm.h
index c00eb0cb7e43..407f05fb300a 100644
--- a/include/linux/io-pgtable-arm.h
+++ b/include/linux/io-pgtable-arm.h
@@ -21,7 +21,7 @@ struct io_pgtable_walk_data {
 	struct io_pgtable_walk_common	*data;
 	int (*visit)(struct io_pgtable_walk_data *walk_data, int lvl,
 		     arm_lpae_iopte *ptep, size_t size);
-	void (*visit_post_table)(struct arm_lpae_io_pgtable_walk_data *data,
+	void (*visit_post_table)(struct io_pgtable_walk_data *walk_data,
 				 arm_lpae_iopte *ptep, int lvl);
 	unsigned long			flags;
 	u64				addr;
@@ -193,6 +193,11 @@ static inline bool iopte_table(arm_lpae_iopte pte, int lvl)
 	return iopte_type(pte) == ARM_LPAE_PTE_TYPE_TABLE;
 }
 
+static inline bool iopte_valid(arm_lpae_iopte pte)
+{
+	return pte & ARM_LPAE_PTE_VALID;
+}
+
 #ifdef __KVM_NVHE_HYPERVISOR__
 #include <nvhe/memory.h>
 #define __arm_lpae_virt_to_phys	hyp_virt_to_phys
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 86226571cdb8..ce0aed9c87d2 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -89,6 +89,8 @@ struct io_pgtable_cfg {
 	 *	attributes set in the TCR for a non-coherent page-table walker.
 	 *
 	 * IO_PGTABLE_QUIRK_ARM_HD: Enables dirty tracking in stage 1 pagetable.
+	 *
+	 * IO_PGTABLE_QUIRK_UNMAP_INVAL: Only invalidate PTE on unmap, don't clear it.
 	 */
 	#define IO_PGTABLE_QUIRK_ARM_NS			BIT(0)
 	#define IO_PGTABLE_QUIRK_NO_PERMS		BIT(1)
@@ -97,6 +99,7 @@ struct io_pgtable_cfg {
 	#define IO_PGTABLE_QUIRK_ARM_TTBR1		BIT(5)
 	#define IO_PGTABLE_QUIRK_ARM_OUTER_WBWA		BIT(6)
 	#define IO_PGTABLE_QUIRK_ARM_HD			BIT(7)
+	#define IO_PGTABLE_QUIRK_UNMAP_INVAL		BIT(8)
 	unsigned long			quirks;
 	unsigned long			pgsize_bitmap;
 	unsigned int			ias;
@@ -194,7 +197,7 @@ struct arm_lpae_io_pgtable_walk_data {
 	int level;
 	void *cookie;
 	void (*visit_post_table)(struct arm_lpae_io_pgtable_walk_data *data,
-				 arm_lpae_iopte *ptep, int lvl);
+				 u64 *ptep, int lvl);
 };
 
 /**
-- 
2.47.0.338.g60cca15819-goog


