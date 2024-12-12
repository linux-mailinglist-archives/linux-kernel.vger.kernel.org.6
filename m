Return-Path: <linux-kernel+bounces-443624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E839EFA4C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E07AC28A39B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559AE166F1A;
	Thu, 12 Dec 2024 18:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dUzMwJhf"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DCE2066F0
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026691; cv=none; b=iOiCpDBKD6Vd/PxUXmncyl8wQE0g4Dd6iffel4UpltDRW0W8fPhAL0cbs4wcpKAE0F8F4UX5Gl1ikG41aQPzmKzGTAJBj1x9ad4333vGuU76128PBnc8rJh36PH7QGHiBxQdiPS/m1Pl445elQk3ozpC30hT1DQ+uogIjdS8m6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026691; c=relaxed/simple;
	bh=vfbb86YcYEgZqQ/dchSXygjWqWPD+rH+ReEN0boaKbs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sCigrKNvHJdggCSDaBVE4pyocyjedYaa3LQCidbDsXCZ4CnQKcjGNauZ+3rsNnZzGQm76oZ28mCGkWLCz2zRECqbSIdGRNry9iJjK9hPzjpzNQxDUzFjtiun6gSR9THnhdukG/lbySf0zKDg0bPXEvAKa/q47KwRgUiNdubpXLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dUzMwJhf; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-436219070b4so5740615e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026686; x=1734631486; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kkEsLZ3YG2EoaXRLgImhrTKrYW+rAcMzbCNnb5CgHBQ=;
        b=dUzMwJhfj4LnvEwInKvML1UepFasxoQMx0wb1BFrbUepRa34agByVK/G8FTy+p4k3q
         bM9emgkklpqu2NRowEeoBFiB+WVHaKkQYrlUD6ugt2s+uHfMEQDwg742AxdGzv8DBwkP
         3CoxtVXhVJ8ql2YKu8XOhCy2Wk1fuoyf1wLPuEy/qhOEstxTZ4dAHW+lptN2cVDpimAJ
         EVzjyeus6zwJD8snwsQgWokeAIBPg/l+YRgXSA+YGyV9u7ZNkG/zFuRfDDkIQHa6rBFt
         u8H6+e4518NKAHGifiEj+iWxX7c/g+GNATIk+IaJiJCameMyNtHHy//s0rVZ43x7BYpq
         dCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026686; x=1734631486;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kkEsLZ3YG2EoaXRLgImhrTKrYW+rAcMzbCNnb5CgHBQ=;
        b=fF8ZbkyHtguGZjGd7lTQAVQKe6ZhnhyX9pgTid8mngFQ8QTC310eS1rbgtGPqOirqk
         PunN5UN6iIg/HRjZoB9ED1wM3+JgqnQh2h54FjdLdRMKtBLza/uqO5EfyPVpkxSZKZYC
         QPWrgFLNAMws3Mzt/G9Clh5ZHmJ0E2fwuQANUfFF1X8fTO5NKHP+6IfFOUY9X4l6DDPz
         H2WqBM/n2nfi5Lie2fobOFbex47VQM+Y67OhMZSv6dDUS8eeISR6tNCqOh26bZ4/p9ly
         kJCXm8gWOessFlnEEGAvcSigJ9bVBXggPCEj+1ea9kHsczbxR/I7w90/apDIbwTn1ekl
         V1kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZ2TedFmUarbpVr2R9WR4ofPz1zuu6ZLUZW9IHMJLw0mpDyz/RVconbIc9M9OREHfeweS+u8H75HZyxC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8gBgJ3EGGuxoaHRTrpIybU1zXYh09b39PmRD8iAmJZzMpZoxu
	rBe3s934lpbD5ZYVU07+07GN6pBFJ68hb+bKQN/UaiOf/OV5rMLhQUk3PyCSJ+dyZTkR20TpGSR
	+G6jvNcjA0Q==
X-Google-Smtp-Source: AGHT+IGH2nFuU5HXupcAxEHWWusoSGCjWEWIjCmRhz0s1hM3QaxPgYYSUV0qNHoc7zrLJETy3m6PooUfkGDCIA==
X-Received: from wmbg15.prod.google.com ([2002:a05:600c:a40f:b0:436:1534:b059])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:468a:b0:434:f0df:a14 with SMTP id 5b1f17b1804b1-4361c34623dmr70607635e9.2.1734026686221;
 Thu, 12 Dec 2024 10:04:46 -0800 (PST)
Date: Thu, 12 Dec 2024 18:03:25 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-2-smostafa@google.com>
Subject: [RFC PATCH v2 01/58] iommu/io-pgtable-arm: Split the page table driver
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

To allow the KVM IOMMU driver to populate page tables using the
io-pgtable-arm code, move the shared bits into io-pgtable-arm-common.c.

Here we move the bulk of the common code, and a subsequent patch handles
the bits that require more care. phys_to_virt() and virt_to_phys() do
need special handling here because the hypervisor will have its own
version. It will also implement its own version of
__arm_lpae_alloc_pages(), __arm_lpae_free_pages() and
__arm_lpae_sync_pte() since the hypervisor needs some assistance for
allocating pages.

Some other minor changes around mapping existing or unmapping empty
PTEs as WARN_ON is fatal in the hypervisor.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/Makefile                |   2 +-
 drivers/iommu/io-pgtable-arm-common.c | 625 ++++++++++++++++++++
 drivers/iommu/io-pgtable-arm.c        | 795 +-------------------------
 drivers/iommu/io-pgtable-arm.h        |  30 -
 include/linux/io-pgtable-arm.h        | 223 ++++++++
 5 files changed, 866 insertions(+), 809 deletions(-)
 create mode 100644 drivers/iommu/io-pgtable-arm-common.c
 delete mode 100644 drivers/iommu/io-pgtable-arm.h
 create mode 100644 include/linux/io-pgtable-arm.h

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 542760d963ec..70c5386ce298 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -7,7 +7,7 @@ obj-$(CONFIG_IOMMU_DEBUGFS) += iommu-debugfs.o
 obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
-obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
+obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o io-pgtable-arm-common.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_DART) += io-pgtable-dart.o
 obj-$(CONFIG_IOMMU_IOVA) += iova.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
diff --git a/drivers/iommu/io-pgtable-arm-common.c b/drivers/iommu/io-pgtable-arm-common.c
new file mode 100644
index 000000000000..ef14a1b50d32
--- /dev/null
+++ b/drivers/iommu/io-pgtable-arm-common.c
@@ -0,0 +1,625 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * CPU-agnostic ARM page table allocator.
+ * A copy of this library is embedded in the KVM nVHE image.
+ *
+ * Copyright (C) 2022 Arm Limited
+ *
+ * Author: Will Deacon <will.deacon@arm.com>
+ */
+
+#include <linux/io-pgtable-arm.h>
+
+#include <linux/sizes.h>
+#include <linux/types.h>
+
+#define iopte_deref(pte, d) __arm_lpae_phys_to_virt(iopte_to_paddr(pte, d))
+
+static arm_lpae_iopte paddr_to_iopte(phys_addr_t paddr,
+				     struct arm_lpae_io_pgtable *data)
+{
+	arm_lpae_iopte pte = paddr;
+
+	/* Of the bits which overlap, either 51:48 or 15:12 are always RES0 */
+	return (pte | (pte >> (48 - 12))) & ARM_LPAE_PTE_ADDR_MASK;
+}
+
+static phys_addr_t iopte_to_paddr(arm_lpae_iopte pte,
+				  struct arm_lpae_io_pgtable *data)
+{
+	u64 paddr = pte & ARM_LPAE_PTE_ADDR_MASK;
+
+	if (ARM_LPAE_GRANULE(data) < SZ_64K)
+		return paddr;
+
+	/* Rotate the packed high-order bits back to the top */
+	return (paddr | (paddr << (48 - 12))) & (ARM_LPAE_PTE_ADDR_MASK << 4);
+}
+
+static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct io_pgtable_cfg *cfg, int num_entries)
+{
+	for (int i = 0; i < num_entries; i++)
+		ptep[i] = 0;
+
+	if (!cfg->coherent_walk && num_entries)
+		__arm_lpae_sync_pte(ptep, num_entries, cfg);
+}
+
+static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
+			       struct iommu_iotlb_gather *gather,
+			       unsigned long iova, size_t size, size_t pgcount,
+			       int lvl, arm_lpae_iopte *ptep);
+
+static void __arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
+				phys_addr_t paddr, arm_lpae_iopte prot,
+				int lvl, int num_entries, arm_lpae_iopte *ptep)
+{
+	arm_lpae_iopte pte = prot;
+	struct io_pgtable_cfg *cfg = &data->iop.cfg;
+	size_t sz = ARM_LPAE_BLOCK_SIZE(lvl, data);
+	int i;
+
+	if (data->iop.fmt != ARM_MALI_LPAE && lvl == ARM_LPAE_MAX_LEVELS - 1)
+		pte |= ARM_LPAE_PTE_TYPE_PAGE;
+	else
+		pte |= ARM_LPAE_PTE_TYPE_BLOCK;
+
+	for (i = 0; i < num_entries; i++)
+		ptep[i] = pte | paddr_to_iopte(paddr + i * sz, data);
+
+	if (!cfg->coherent_walk)
+		__arm_lpae_sync_pte(ptep, num_entries, cfg);
+}
+
+static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
+			     unsigned long iova, phys_addr_t paddr,
+			     arm_lpae_iopte prot, int lvl, int num_entries,
+			     arm_lpae_iopte *ptep)
+{
+	int i;
+
+	for (i = 0; i < num_entries; i++)
+		if (iopte_leaf(ptep[i], lvl, data->iop.fmt)) {
+			/* We require an unmap first */
+			return arm_lpae_map_exists();
+		} else if (iopte_type(ptep[i]) == ARM_LPAE_PTE_TYPE_TABLE) {
+			/*
+			 * We need to unmap and free the old table before
+			 * overwriting it with a block entry.
+			 */
+			arm_lpae_iopte *tblp;
+			size_t sz = ARM_LPAE_BLOCK_SIZE(lvl, data);
+
+			tblp = ptep - ARM_LPAE_LVL_IDX(iova, lvl, data);
+			if (__arm_lpae_unmap(data, NULL, iova + i * sz, sz, 1,
+					     lvl, tblp) != sz) {
+				WARN_ON(1);
+				return -EINVAL;
+			}
+		}
+
+	__arm_lpae_init_pte(data, paddr, prot, lvl, num_entries, ptep);
+	return 0;
+}
+
+static arm_lpae_iopte arm_lpae_install_table(arm_lpae_iopte *table,
+					     arm_lpae_iopte *ptep,
+					     arm_lpae_iopte curr,
+					     struct arm_lpae_io_pgtable *data)
+{
+	arm_lpae_iopte old, new;
+	struct io_pgtable_cfg *cfg = &data->iop.cfg;
+
+	new = paddr_to_iopte(__arm_lpae_virt_to_phys(table), data) |
+			     ARM_LPAE_PTE_TYPE_TABLE;
+	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NS)
+		new |= ARM_LPAE_PTE_NSTABLE;
+
+	/*
+	 * Ensure the table itself is visible before its PTE can be.
+	 * Whilst we could get away with cmpxchg64_release below, this
+	 * doesn't have any ordering semantics when !CONFIG_SMP.
+	 */
+	dma_wmb();
+
+	old = cmpxchg64_relaxed(ptep, curr, new);
+
+	if (cfg->coherent_walk || (old & ARM_LPAE_PTE_SW_SYNC))
+		return old;
+
+	/* Even if it's not ours, there's no point waiting; just kick it */
+	__arm_lpae_sync_pte(ptep, 1, cfg);
+	if (old == curr)
+		WRITE_ONCE(*ptep, new | ARM_LPAE_PTE_SW_SYNC);
+
+	return old;
+}
+
+static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
+			  phys_addr_t paddr, size_t size, size_t pgcount,
+			  arm_lpae_iopte prot, int lvl, arm_lpae_iopte *ptep,
+			  gfp_t gfp, size_t *mapped)
+{
+	arm_lpae_iopte *cptep, pte;
+	size_t block_size = ARM_LPAE_BLOCK_SIZE(lvl, data);
+	size_t tblsz = ARM_LPAE_GRANULE(data);
+	struct io_pgtable_cfg *cfg = &data->iop.cfg;
+	int ret = 0, num_entries, max_entries, map_idx_start;
+
+	/* Find our entry at the current level */
+	map_idx_start = ARM_LPAE_LVL_IDX(iova, lvl, data);
+	ptep += map_idx_start;
+
+	/* If we can install a leaf entry at this level, then do so */
+	if (size == block_size) {
+		max_entries = ARM_LPAE_PTES_PER_TABLE(data) - map_idx_start;
+		num_entries = min_t(int, pgcount, max_entries);
+		ret = arm_lpae_init_pte(data, iova, paddr, prot, lvl, num_entries, ptep);
+		if (!ret)
+			*mapped += num_entries * size;
+
+		return ret;
+	}
+
+	/* We can't allocate tables at the final level */
+	if (WARN_ON(lvl >= ARM_LPAE_MAX_LEVELS - 1))
+		return -EINVAL;
+
+	/* Grab a pointer to the next level */
+	pte = READ_ONCE(*ptep);
+	if (!pte) {
+		cptep = __arm_lpae_alloc_pages(tblsz, gfp, cfg, data->iop.cookie);
+		if (!cptep)
+			return -ENOMEM;
+
+		pte = arm_lpae_install_table(cptep, ptep, 0, data);
+		if (pte)
+			__arm_lpae_free_pages(cptep, tblsz, cfg, data->iop.cookie);
+	} else if (!cfg->coherent_walk && !(pte & ARM_LPAE_PTE_SW_SYNC)) {
+		__arm_lpae_sync_pte(ptep, 1, cfg);
+	}
+
+	if (pte && !iopte_leaf(pte, lvl, data->iop.fmt)) {
+		cptep = iopte_deref(pte, data);
+	} else if (pte) {
+		/* We require an unmap first */
+		return arm_lpae_unmap_empty();
+	}
+
+	/* Rinse, repeat */
+	return __arm_lpae_map(data, iova, paddr, size, pgcount, prot, lvl + 1,
+			      cptep, gfp, mapped);
+}
+
+static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
+					   int prot)
+{
+	arm_lpae_iopte pte;
+
+	if (data->iop.fmt == ARM_64_LPAE_S1 ||
+	    data->iop.fmt == ARM_32_LPAE_S1) {
+		pte = ARM_LPAE_PTE_nG;
+		if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
+			pte |= ARM_LPAE_PTE_AP_RDONLY;
+		else if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_HD)
+			pte |= ARM_LPAE_PTE_DBM;
+		if (!(prot & IOMMU_PRIV))
+			pte |= ARM_LPAE_PTE_AP_UNPRIV;
+	} else {
+		pte = ARM_LPAE_PTE_HAP_FAULT;
+		if (prot & IOMMU_READ)
+			pte |= ARM_LPAE_PTE_HAP_READ;
+		if (prot & IOMMU_WRITE)
+			pte |= ARM_LPAE_PTE_HAP_WRITE;
+	}
+
+	/*
+	 * Note that this logic is structured to accommodate Mali LPAE
+	 * having stage-1-like attributes but stage-2-like permissions.
+	 */
+	if (data->iop.fmt == ARM_64_LPAE_S2 ||
+	    data->iop.fmt == ARM_32_LPAE_S2) {
+		if (prot & IOMMU_MMIO)
+			pte |= ARM_LPAE_PTE_MEMATTR_DEV;
+		else if (prot & IOMMU_CACHE)
+			pte |= ARM_LPAE_PTE_MEMATTR_OIWB;
+		else
+			pte |= ARM_LPAE_PTE_MEMATTR_NC;
+	} else {
+		if (prot & IOMMU_MMIO)
+			pte |= (ARM_LPAE_MAIR_ATTR_IDX_DEV
+				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
+		else if (prot & IOMMU_CACHE)
+			pte |= (ARM_LPAE_MAIR_ATTR_IDX_CACHE
+				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
+	}
+
+	/*
+	 * Also Mali has its own notions of shareability wherein its Inner
+	 * domain covers the cores within the GPU, and its Outer domain is
+	 * "outside the GPU" (i.e. either the Inner or System domain in CPU
+	 * terms, depending on coherency).
+	 */
+	if (prot & IOMMU_CACHE && data->iop.fmt != ARM_MALI_LPAE)
+		pte |= ARM_LPAE_PTE_SH_IS;
+	else
+		pte |= ARM_LPAE_PTE_SH_OS;
+
+	if (prot & IOMMU_NOEXEC)
+		pte |= ARM_LPAE_PTE_XN;
+
+	if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_NS)
+		pte |= ARM_LPAE_PTE_NS;
+
+	if (data->iop.fmt != ARM_MALI_LPAE)
+		pte |= ARM_LPAE_PTE_AF;
+
+	return pte;
+}
+
+int arm_lpae_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
+		       phys_addr_t paddr, size_t pgsize, size_t pgcount,
+		       int iommu_prot, gfp_t gfp, size_t *mapped)
+{
+	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
+	struct io_pgtable_cfg *cfg = &data->iop.cfg;
+	arm_lpae_iopte *ptep = data->pgd;
+	int ret, lvl = data->start_level;
+	arm_lpae_iopte prot;
+	long iaext = (s64)iova >> cfg->ias;
+
+	if (WARN_ON(!pgsize || (pgsize & cfg->pgsize_bitmap) != pgsize))
+		return -EINVAL;
+
+	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1)
+		iaext = ~iaext;
+	if (WARN_ON(iaext || paddr >> cfg->oas))
+		return -ERANGE;
+
+	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
+		return -EINVAL;
+
+	prot = arm_lpae_prot_to_pte(data, iommu_prot);
+	ret = __arm_lpae_map(data, iova, paddr, pgsize, pgcount, prot, lvl,
+			     ptep, gfp, mapped);
+	/*
+	 * Synchronise all PTE updates for the new mapping before there's
+	 * a chance for anything to kick off a table walk for the new iova.
+	 */
+	wmb();
+
+	return ret;
+}
+
+void __arm_lpae_free_pgtable(struct arm_lpae_io_pgtable *data, int lvl,
+			     arm_lpae_iopte *ptep)
+{
+	arm_lpae_iopte *start, *end;
+	unsigned long table_size;
+
+	if (lvl == data->start_level)
+		table_size = ARM_LPAE_PGD_SIZE(data);
+	else
+		table_size = ARM_LPAE_GRANULE(data);
+
+	start = ptep;
+
+	/* Only leaf entries at the last level */
+	if (lvl == ARM_LPAE_MAX_LEVELS - 1)
+		end = ptep;
+	else
+		end = (void *)ptep + table_size;
+
+	while (ptep != end) {
+		arm_lpae_iopte pte = *ptep++;
+
+		if (!pte || iopte_leaf(pte, lvl, data->iop.fmt))
+			continue;
+
+		__arm_lpae_free_pgtable(data, lvl + 1, iopte_deref(pte, data));
+	}
+
+	__arm_lpae_free_pages(start, table_size, &data->iop.cfg, data->iop.cookie);
+}
+
+static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
+				       struct iommu_iotlb_gather *gather,
+				       unsigned long iova, size_t size,
+				       arm_lpae_iopte blk_pte, int lvl,
+				       arm_lpae_iopte *ptep, size_t pgcount)
+{
+	struct io_pgtable_cfg *cfg = &data->iop.cfg;
+	arm_lpae_iopte pte, *tablep;
+	phys_addr_t blk_paddr;
+	size_t tablesz = ARM_LPAE_GRANULE(data);
+	size_t split_sz = ARM_LPAE_BLOCK_SIZE(lvl, data);
+	int ptes_per_table = ARM_LPAE_PTES_PER_TABLE(data);
+	int i, unmap_idx_start = -1, num_entries = 0, max_entries;
+
+	if (WARN_ON(lvl == ARM_LPAE_MAX_LEVELS))
+		return 0;
+
+	tablep = __arm_lpae_alloc_pages(tablesz, GFP_ATOMIC, cfg, data->iop.cookie);
+	if (!tablep)
+		return 0; /* Bytes unmapped */
+
+	if (size == split_sz) {
+		unmap_idx_start = ARM_LPAE_LVL_IDX(iova, lvl, data);
+		max_entries = ptes_per_table - unmap_idx_start;
+		num_entries = min_t(int, pgcount, max_entries);
+	}
+
+	blk_paddr = iopte_to_paddr(blk_pte, data);
+	pte = iopte_prot(blk_pte);
+
+	for (i = 0; i < ptes_per_table; i++, blk_paddr += split_sz) {
+		/* Unmap! */
+		if (i >= unmap_idx_start && i < (unmap_idx_start + num_entries))
+			continue;
+
+		__arm_lpae_init_pte(data, blk_paddr, pte, lvl, 1, &tablep[i]);
+	}
+
+	pte = arm_lpae_install_table(tablep, ptep, blk_pte, data);
+	if (pte != blk_pte) {
+		__arm_lpae_free_pages(tablep, tablesz, cfg, data->iop.cookie);
+		/*
+		 * We may race against someone unmapping another part of this
+		 * block, but anything else is invalid. We can't misinterpret
+		 * a page entry here since we're never at the last level.
+		 */
+		if (iopte_type(pte) != ARM_LPAE_PTE_TYPE_TABLE)
+			return 0;
+
+		tablep = iopte_deref(pte, data);
+	} else if (unmap_idx_start >= 0) {
+		for (i = 0; i < num_entries; i++)
+			io_pgtable_tlb_add_page(&data->iop, gather, iova + i * size, size);
+
+		return num_entries * size;
+	}
+
+	return __arm_lpae_unmap(data, gather, iova, size, pgcount, lvl, tablep);
+}
+
+static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
+			       struct iommu_iotlb_gather *gather,
+			       unsigned long iova, size_t size, size_t pgcount,
+			       int lvl, arm_lpae_iopte *ptep)
+{
+	arm_lpae_iopte pte;
+	struct io_pgtable *iop = &data->iop;
+	int i = 0, num_entries, max_entries, unmap_idx_start;
+
+	/* Something went horribly wrong and we ran out of page table */
+	if (WARN_ON(lvl == ARM_LPAE_MAX_LEVELS))
+		return 0;
+
+	unmap_idx_start = ARM_LPAE_LVL_IDX(iova, lvl, data);
+	ptep += unmap_idx_start;
+	pte = READ_ONCE(*ptep);
+	if (WARN_ON(!pte))
+		return 0;
+
+	/* If the size matches this level, we're in the right place */
+	if (size == ARM_LPAE_BLOCK_SIZE(lvl, data)) {
+		max_entries = ARM_LPAE_PTES_PER_TABLE(data) - unmap_idx_start;
+		num_entries = min_t(int, pgcount, max_entries);
+
+		/* Find and handle non-leaf entries */
+		for (i = 0; i < num_entries; i++) {
+			pte = READ_ONCE(ptep[i]);
+			if (WARN_ON(!pte))
+				break;
+
+			if (!iopte_leaf(pte, lvl, iop->fmt)) {
+				__arm_lpae_clear_pte(&ptep[i], &iop->cfg, 1);
+
+				/* Also flush any partial walks */
+				io_pgtable_tlb_flush_walk(iop, iova + i * size, size,
+							  ARM_LPAE_GRANULE(data));
+				__arm_lpae_free_pgtable(data, lvl + 1, iopte_deref(pte, data));
+			}
+		}
+
+		/* Clear the remaining entries */
+		__arm_lpae_clear_pte(ptep, &iop->cfg, i);
+
+		if (gather && !iommu_iotlb_gather_queued(gather))
+			for (int j = 0; j < i; j++)
+				io_pgtable_tlb_add_page(iop, gather, iova + j * size, size);
+
+		return i * size;
+	} else if (iopte_leaf(pte, lvl, iop->fmt)) {
+		/*
+		 * Insert a table at the next level to map the old region,
+		 * minus the part we want to unmap
+		 */
+		return arm_lpae_split_blk_unmap(data, gather, iova, size, pte,
+						lvl + 1, ptep, pgcount);
+	}
+
+	/* Keep on walkin' */
+	ptep = iopte_deref(pte, data);
+	return __arm_lpae_unmap(data, gather, iova, size, pgcount, lvl + 1, ptep);
+}
+
+size_t arm_lpae_unmap_pages(struct io_pgtable_ops *ops, unsigned long iova,
+			    size_t pgsize, size_t pgcount,
+			    struct iommu_iotlb_gather *gather)
+{
+	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
+	struct io_pgtable_cfg *cfg = &data->iop.cfg;
+	arm_lpae_iopte *ptep = data->pgd;
+	long iaext = (s64)iova >> cfg->ias;
+
+	if (WARN_ON(!pgsize || (pgsize & cfg->pgsize_bitmap) != pgsize || !pgcount))
+		return 0;
+
+	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1)
+		iaext = ~iaext;
+	if (WARN_ON(iaext))
+		return 0;
+
+	return __arm_lpae_unmap(data, gather, iova, pgsize, pgcount,
+				data->start_level, ptep);
+}
+
+static int __arm_lpae_iopte_walk(struct arm_lpae_io_pgtable *data,
+				 struct io_pgtable_walk_data *walk_data,
+				 arm_lpae_iopte *ptep,
+				 int lvl);
+
+struct iova_to_phys_data {
+	arm_lpae_iopte pte;
+	int lvl;
+};
+
+static int visit_iova_to_phys(struct io_pgtable_walk_data *walk_data, int lvl,
+			      arm_lpae_iopte *ptep, size_t size)
+{
+	struct iova_to_phys_data *data = walk_data->data;
+	data->pte = *ptep;
+	data->lvl = lvl;
+	return 0;
+}
+
+phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
+				  unsigned long iova)
+{
+	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
+	struct iova_to_phys_data d;
+	struct io_pgtable_walk_data walk_data = {
+		.data = &d,
+		.visit = visit_iova_to_phys,
+		.addr = iova,
+		.end = iova + 1,
+	};
+	int ret;
+
+	ret = __arm_lpae_iopte_walk(data, &walk_data, data->pgd, data->start_level);
+	if (ret)
+		return 0;
+
+	iova &= (ARM_LPAE_BLOCK_SIZE(d.lvl, data) - 1);
+	return iopte_to_paddr(d.pte, data) | iova;
+}
+
+static int visit_pgtable_walk(struct io_pgtable_walk_data *walk_data, int lvl,
+			      arm_lpae_iopte *ptep, size_t size)
+{
+	struct arm_lpae_io_pgtable_walk_data *data = walk_data->data;
+	data->ptes[data->level++] = *ptep;
+	return 0;
+}
+
+int arm_lpae_pgtable_walk(struct io_pgtable_ops *ops, unsigned long iova, void *wd)
+{
+	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
+	struct io_pgtable_walk_data walk_data = {
+		.data = wd,
+		.visit = visit_pgtable_walk,
+		.addr = iova,
+		.end = iova + 1,
+	};
+
+	((struct arm_lpae_io_pgtable_walk_data *)wd)->level = 0;
+
+	return __arm_lpae_iopte_walk(data, &walk_data, data->pgd, data->start_level);
+}
+
+static int io_pgtable_visit(struct arm_lpae_io_pgtable *data,
+			    struct io_pgtable_walk_data *walk_data,
+			    arm_lpae_iopte *ptep, int lvl)
+{
+	struct io_pgtable *iop = &data->iop;
+	arm_lpae_iopte pte = READ_ONCE(*ptep);
+
+	size_t size = ARM_LPAE_BLOCK_SIZE(lvl, data);
+	int ret = walk_data->visit(walk_data, lvl, ptep, size);
+	if (ret)
+		return ret;
+
+	if (iopte_leaf(pte, lvl, iop->fmt)) {
+		walk_data->addr += size;
+		return 0;
+	}
+
+	if (!iopte_table(pte, lvl)) {
+		return -EINVAL;
+	}
+
+	ptep = iopte_deref(pte, data);
+	return __arm_lpae_iopte_walk(data, walk_data, ptep, lvl + 1);
+}
+
+static int __arm_lpae_iopte_walk(struct arm_lpae_io_pgtable *data,
+				 struct io_pgtable_walk_data *walk_data,
+				 arm_lpae_iopte *ptep,
+				 int lvl)
+{
+	u32 idx;
+	int max_entries, ret;
+
+	if (WARN_ON(lvl == ARM_LPAE_MAX_LEVELS))
+		return -EINVAL;
+
+	if (lvl == data->start_level)
+		max_entries = ARM_LPAE_PGD_SIZE(data) / sizeof(arm_lpae_iopte);
+	else
+		max_entries = ARM_LPAE_PTES_PER_TABLE(data);
+
+	for (idx = ARM_LPAE_LVL_IDX(walk_data->addr, lvl, data);
+	     (idx < max_entries) && (walk_data->addr < walk_data->end); ++idx) {
+		ret = io_pgtable_visit(data, walk_data, ptep + idx, lvl);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int visit_dirty(struct io_pgtable_walk_data *walk_data, int lvl,
+		       arm_lpae_iopte *ptep, size_t size)
+{
+	struct iommu_dirty_bitmap *dirty = walk_data->data;
+
+	if (!iopte_leaf(*ptep, lvl, walk_data->iop->fmt))
+		return 0;
+
+	if (iopte_writeable_dirty(*ptep)) {
+		iommu_dirty_bitmap_record(dirty, walk_data->addr, size);
+		if (!(walk_data->flags & IOMMU_DIRTY_NO_CLEAR))
+			iopte_set_writeable_clean(ptep);
+	}
+
+	return 0;
+}
+
+int arm_lpae_read_and_clear_dirty(struct io_pgtable_ops *ops,
+				  unsigned long iova, size_t size,
+				  unsigned long flags,
+				  struct iommu_dirty_bitmap *dirty)
+{
+	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
+	struct io_pgtable_cfg *cfg = &data->iop.cfg;
+	struct io_pgtable_walk_data walk_data = {
+		.iop = &data->iop,
+		.data = dirty,
+		.visit = visit_dirty,
+		.flags = flags,
+		.addr = iova,
+		.end = iova + size,
+	};
+	arm_lpae_iopte *ptep = data->pgd;
+	int lvl = data->start_level;
+
+	if (WARN_ON(!size))
+		return -EINVAL;
+	if (WARN_ON((iova + size - 1) & ~(BIT(cfg->ias) - 1)))
+		return -EINVAL;
+	if (data->iop.fmt != ARM_64_LPAE_S1)
+		return -EINVAL;
+
+	return __arm_lpae_iopte_walk(data, &walk_data, ptep, lvl);
+}
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 6739e1fa54ec..cb4eb513adbf 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * CPU-agnostic ARM page table allocator.
+ * Host-specific functions. The rest is in io-pgtable-arm-common.c.
  *
  * Copyright (C) 2014 ARM Limited
  *
@@ -11,7 +12,7 @@
 
 #include <linux/atomic.h>
 #include <linux/bitops.h>
-#include <linux/io-pgtable.h>
+#include <linux/io-pgtable-arm.h>
 #include <linux/kernel.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
@@ -20,195 +21,33 @@
 
 #include <asm/barrier.h>
 
-#include "io-pgtable-arm.h"
 #include "iommu-pages.h"
 
 #define ARM_LPAE_MAX_ADDR_BITS		52
 #define ARM_LPAE_S2_MAX_CONCAT_PAGES	16
-#define ARM_LPAE_MAX_LEVELS		4
 
-/* Struct accessors */
-#define io_pgtable_to_data(x)						\
-	container_of((x), struct arm_lpae_io_pgtable, iop)
-
-#define io_pgtable_ops_to_data(x)					\
-	io_pgtable_to_data(io_pgtable_ops_to_pgtable(x))
-
-/*
- * Calculate the right shift amount to get to the portion describing level l
- * in a virtual address mapped by the pagetable in d.
- */
-#define ARM_LPAE_LVL_SHIFT(l,d)						\
-	(((ARM_LPAE_MAX_LEVELS - (l)) * (d)->bits_per_level) +		\
-	ilog2(sizeof(arm_lpae_iopte)))
-
-#define ARM_LPAE_GRANULE(d)						\
-	(sizeof(arm_lpae_iopte) << (d)->bits_per_level)
-#define ARM_LPAE_PGD_SIZE(d)						\
-	(sizeof(arm_lpae_iopte) << (d)->pgd_bits)
-
-#define ARM_LPAE_PTES_PER_TABLE(d)					\
-	(ARM_LPAE_GRANULE(d) >> ilog2(sizeof(arm_lpae_iopte)))
-
-/*
- * Calculate the index at level l used to map virtual address a using the
- * pagetable in d.
- */
-#define ARM_LPAE_PGD_IDX(l,d)						\
-	((l) == (d)->start_level ? (d)->pgd_bits - (d)->bits_per_level : 0)
-
-#define ARM_LPAE_LVL_IDX(a,l,d)						\
-	(((u64)(a) >> ARM_LPAE_LVL_SHIFT(l,d)) &			\
-	 ((1 << ((d)->bits_per_level + ARM_LPAE_PGD_IDX(l,d))) - 1))
-
-/* Calculate the block/page mapping size at level l for pagetable in d. */
-#define ARM_LPAE_BLOCK_SIZE(l,d)	(1ULL << ARM_LPAE_LVL_SHIFT(l,d))
-
-/* Page table bits */
-#define ARM_LPAE_PTE_TYPE_SHIFT		0
-#define ARM_LPAE_PTE_TYPE_MASK		0x3
-
-#define ARM_LPAE_PTE_TYPE_BLOCK		1
-#define ARM_LPAE_PTE_TYPE_TABLE		3
-#define ARM_LPAE_PTE_TYPE_PAGE		3
-
-#define ARM_LPAE_PTE_ADDR_MASK		GENMASK_ULL(47,12)
-
-#define ARM_LPAE_PTE_NSTABLE		(((arm_lpae_iopte)1) << 63)
-#define ARM_LPAE_PTE_XN			(((arm_lpae_iopte)3) << 53)
-#define ARM_LPAE_PTE_DBM		(((arm_lpae_iopte)1) << 51)
-#define ARM_LPAE_PTE_AF			(((arm_lpae_iopte)1) << 10)
-#define ARM_LPAE_PTE_SH_NS		(((arm_lpae_iopte)0) << 8)
-#define ARM_LPAE_PTE_SH_OS		(((arm_lpae_iopte)2) << 8)
-#define ARM_LPAE_PTE_SH_IS		(((arm_lpae_iopte)3) << 8)
-#define ARM_LPAE_PTE_NS			(((arm_lpae_iopte)1) << 5)
-#define ARM_LPAE_PTE_VALID		(((arm_lpae_iopte)1) << 0)
-
-#define ARM_LPAE_PTE_ATTR_LO_MASK	(((arm_lpae_iopte)0x3ff) << 2)
-/* Ignore the contiguous bit for block splitting */
-#define ARM_LPAE_PTE_ATTR_HI_MASK	(ARM_LPAE_PTE_XN | ARM_LPAE_PTE_DBM)
-#define ARM_LPAE_PTE_ATTR_MASK		(ARM_LPAE_PTE_ATTR_LO_MASK |	\
-					 ARM_LPAE_PTE_ATTR_HI_MASK)
-/* Software bit for solving coherency races */
-#define ARM_LPAE_PTE_SW_SYNC		(((arm_lpae_iopte)1) << 55)
-
-/* Stage-1 PTE */
-#define ARM_LPAE_PTE_AP_UNPRIV		(((arm_lpae_iopte)1) << 6)
-#define ARM_LPAE_PTE_AP_RDONLY_BIT	7
-#define ARM_LPAE_PTE_AP_RDONLY		(((arm_lpae_iopte)1) << \
-					   ARM_LPAE_PTE_AP_RDONLY_BIT)
-#define ARM_LPAE_PTE_AP_WR_CLEAN_MASK	(ARM_LPAE_PTE_AP_RDONLY | \
-					 ARM_LPAE_PTE_DBM)
-#define ARM_LPAE_PTE_ATTRINDX_SHIFT	2
-#define ARM_LPAE_PTE_nG			(((arm_lpae_iopte)1) << 11)
-
-/* Stage-2 PTE */
-#define ARM_LPAE_PTE_HAP_FAULT		(((arm_lpae_iopte)0) << 6)
-#define ARM_LPAE_PTE_HAP_READ		(((arm_lpae_iopte)1) << 6)
-#define ARM_LPAE_PTE_HAP_WRITE		(((arm_lpae_iopte)2) << 6)
-#define ARM_LPAE_PTE_MEMATTR_OIWB	(((arm_lpae_iopte)0xf) << 2)
-#define ARM_LPAE_PTE_MEMATTR_NC		(((arm_lpae_iopte)0x5) << 2)
-#define ARM_LPAE_PTE_MEMATTR_DEV	(((arm_lpae_iopte)0x1) << 2)
-
-/* Register bits */
-#define ARM_LPAE_VTCR_SL0_MASK		0x3
-
-#define ARM_LPAE_TCR_T0SZ_SHIFT		0
-
-#define ARM_LPAE_VTCR_PS_SHIFT		16
-#define ARM_LPAE_VTCR_PS_MASK		0x7
-
-#define ARM_LPAE_MAIR_ATTR_SHIFT(n)	((n) << 3)
-#define ARM_LPAE_MAIR_ATTR_MASK		0xff
-#define ARM_LPAE_MAIR_ATTR_DEVICE	0x04
-#define ARM_LPAE_MAIR_ATTR_NC		0x44
-#define ARM_LPAE_MAIR_ATTR_INC_OWBRWA	0xf4
-#define ARM_LPAE_MAIR_ATTR_WBRWA	0xff
-#define ARM_LPAE_MAIR_ATTR_IDX_NC	0
-#define ARM_LPAE_MAIR_ATTR_IDX_CACHE	1
-#define ARM_LPAE_MAIR_ATTR_IDX_DEV	2
-#define ARM_LPAE_MAIR_ATTR_IDX_INC_OCACHE	3
-
-#define ARM_MALI_LPAE_TTBR_ADRMODE_TABLE (3u << 0)
-#define ARM_MALI_LPAE_TTBR_READ_INNER	BIT(2)
-#define ARM_MALI_LPAE_TTBR_SHARE_OUTER	BIT(4)
-
-#define ARM_MALI_LPAE_MEMATTR_IMP_DEF	0x88ULL
-#define ARM_MALI_LPAE_MEMATTR_WRITE_ALLOC 0x8DULL
-
-/* IOPTE accessors */
-#define iopte_deref(pte,d) __va(iopte_to_paddr(pte, d))
-
-#define iopte_type(pte)					\
-	(((pte) >> ARM_LPAE_PTE_TYPE_SHIFT) & ARM_LPAE_PTE_TYPE_MASK)
-
-#define iopte_prot(pte)	((pte) & ARM_LPAE_PTE_ATTR_MASK)
-
-#define iopte_writeable_dirty(pte)				\
-	(((pte) & ARM_LPAE_PTE_AP_WR_CLEAN_MASK) == ARM_LPAE_PTE_DBM)
-
-#define iopte_set_writeable_clean(ptep)				\
-	set_bit(ARM_LPAE_PTE_AP_RDONLY_BIT, (unsigned long *)(ptep))
-
-struct arm_lpae_io_pgtable {
-	struct io_pgtable	iop;
-
-	int			pgd_bits;
-	int			start_level;
-	int			bits_per_level;
-
-	void			*pgd;
-};
-
-typedef u64 arm_lpae_iopte;
-
-static inline bool iopte_leaf(arm_lpae_iopte pte, int lvl,
-			      enum io_pgtable_fmt fmt)
-{
-	if (lvl == (ARM_LPAE_MAX_LEVELS - 1) && fmt != ARM_MALI_LPAE)
-		return iopte_type(pte) == ARM_LPAE_PTE_TYPE_PAGE;
-
-	return iopte_type(pte) == ARM_LPAE_PTE_TYPE_BLOCK;
-}
+static bool selftest_running = false;
 
-static inline bool iopte_table(arm_lpae_iopte pte, int lvl)
+int arm_lpae_map_exists(void)
 {
-	if (lvl == (ARM_LPAE_MAX_LEVELS - 1))
-		return false;
-	return iopte_type(pte) == ARM_LPAE_PTE_TYPE_TABLE;
+	WARN_ON(!selftest_running);
+	return -EEXIST;
 }
 
-static arm_lpae_iopte paddr_to_iopte(phys_addr_t paddr,
-				     struct arm_lpae_io_pgtable *data)
+int arm_lpae_unmap_empty(void)
 {
-	arm_lpae_iopte pte = paddr;
-
-	/* Of the bits which overlap, either 51:48 or 15:12 are always RES0 */
-	return (pte | (pte >> (48 - 12))) & ARM_LPAE_PTE_ADDR_MASK;
+	WARN_ON(!selftest_running);
+	return -EEXIST;
 }
 
-static phys_addr_t iopte_to_paddr(arm_lpae_iopte pte,
-				  struct arm_lpae_io_pgtable *data)
-{
-	u64 paddr = pte & ARM_LPAE_PTE_ADDR_MASK;
-
-	if (ARM_LPAE_GRANULE(data) < SZ_64K)
-		return paddr;
-
-	/* Rotate the packed high-order bits back to the top */
-	return (paddr | (paddr << (48 - 12))) & (ARM_LPAE_PTE_ADDR_MASK << 4);
-}
-
-static bool selftest_running = false;
-
 static dma_addr_t __arm_lpae_dma_addr(void *pages)
 {
 	return (dma_addr_t)virt_to_phys(pages);
 }
 
-static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
-				    struct io_pgtable_cfg *cfg,
-				    void *cookie)
+void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
+			     struct io_pgtable_cfg *cfg,
+			     void *cookie)
 {
 	struct device *dev = cfg->iommu_dev;
 	int order = get_order(size);
@@ -253,9 +92,9 @@ static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
 	return NULL;
 }
 
-static void __arm_lpae_free_pages(void *pages, size_t size,
-				  struct io_pgtable_cfg *cfg,
-				  void *cookie)
+void __arm_lpae_free_pages(void *pages, size_t size,
+			   struct io_pgtable_cfg *cfg,
+			   void *cookie)
 {
 	if (!cfg->coherent_walk)
 		dma_unmap_single(cfg->iommu_dev, __arm_lpae_dma_addr(pages),
@@ -267,300 +106,13 @@ static void __arm_lpae_free_pages(void *pages, size_t size,
 		iommu_free_pages(pages, get_order(size));
 }
 
-static void __arm_lpae_sync_pte(arm_lpae_iopte *ptep, int num_entries,
-				struct io_pgtable_cfg *cfg)
+void __arm_lpae_sync_pte(arm_lpae_iopte *ptep, int num_entries,
+			 struct io_pgtable_cfg *cfg)
 {
 	dma_sync_single_for_device(cfg->iommu_dev, __arm_lpae_dma_addr(ptep),
 				   sizeof(*ptep) * num_entries, DMA_TO_DEVICE);
 }
 
-static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct io_pgtable_cfg *cfg, int num_entries)
-{
-	for (int i = 0; i < num_entries; i++)
-		ptep[i] = 0;
-
-	if (!cfg->coherent_walk && num_entries)
-		__arm_lpae_sync_pte(ptep, num_entries, cfg);
-}
-
-static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
-			       struct iommu_iotlb_gather *gather,
-			       unsigned long iova, size_t size, size_t pgcount,
-			       int lvl, arm_lpae_iopte *ptep);
-
-static void __arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
-				phys_addr_t paddr, arm_lpae_iopte prot,
-				int lvl, int num_entries, arm_lpae_iopte *ptep)
-{
-	arm_lpae_iopte pte = prot;
-	struct io_pgtable_cfg *cfg = &data->iop.cfg;
-	size_t sz = ARM_LPAE_BLOCK_SIZE(lvl, data);
-	int i;
-
-	if (data->iop.fmt != ARM_MALI_LPAE && lvl == ARM_LPAE_MAX_LEVELS - 1)
-		pte |= ARM_LPAE_PTE_TYPE_PAGE;
-	else
-		pte |= ARM_LPAE_PTE_TYPE_BLOCK;
-
-	for (i = 0; i < num_entries; i++)
-		ptep[i] = pte | paddr_to_iopte(paddr + i * sz, data);
-
-	if (!cfg->coherent_walk)
-		__arm_lpae_sync_pte(ptep, num_entries, cfg);
-}
-
-static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
-			     unsigned long iova, phys_addr_t paddr,
-			     arm_lpae_iopte prot, int lvl, int num_entries,
-			     arm_lpae_iopte *ptep)
-{
-	int i;
-
-	for (i = 0; i < num_entries; i++)
-		if (iopte_leaf(ptep[i], lvl, data->iop.fmt)) {
-			/* We require an unmap first */
-			WARN_ON(!selftest_running);
-			return -EEXIST;
-		} else if (iopte_type(ptep[i]) == ARM_LPAE_PTE_TYPE_TABLE) {
-			/*
-			 * We need to unmap and free the old table before
-			 * overwriting it with a block entry.
-			 */
-			arm_lpae_iopte *tblp;
-			size_t sz = ARM_LPAE_BLOCK_SIZE(lvl, data);
-
-			tblp = ptep - ARM_LPAE_LVL_IDX(iova, lvl, data);
-			if (__arm_lpae_unmap(data, NULL, iova + i * sz, sz, 1,
-					     lvl, tblp) != sz) {
-				WARN_ON(1);
-				return -EINVAL;
-			}
-		}
-
-	__arm_lpae_init_pte(data, paddr, prot, lvl, num_entries, ptep);
-	return 0;
-}
-
-static arm_lpae_iopte arm_lpae_install_table(arm_lpae_iopte *table,
-					     arm_lpae_iopte *ptep,
-					     arm_lpae_iopte curr,
-					     struct arm_lpae_io_pgtable *data)
-{
-	arm_lpae_iopte old, new;
-	struct io_pgtable_cfg *cfg = &data->iop.cfg;
-
-	new = paddr_to_iopte(__pa(table), data) | ARM_LPAE_PTE_TYPE_TABLE;
-	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NS)
-		new |= ARM_LPAE_PTE_NSTABLE;
-
-	/*
-	 * Ensure the table itself is visible before its PTE can be.
-	 * Whilst we could get away with cmpxchg64_release below, this
-	 * doesn't have any ordering semantics when !CONFIG_SMP.
-	 */
-	dma_wmb();
-
-	old = cmpxchg64_relaxed(ptep, curr, new);
-
-	if (cfg->coherent_walk || (old & ARM_LPAE_PTE_SW_SYNC))
-		return old;
-
-	/* Even if it's not ours, there's no point waiting; just kick it */
-	__arm_lpae_sync_pte(ptep, 1, cfg);
-	if (old == curr)
-		WRITE_ONCE(*ptep, new | ARM_LPAE_PTE_SW_SYNC);
-
-	return old;
-}
-
-static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
-			  phys_addr_t paddr, size_t size, size_t pgcount,
-			  arm_lpae_iopte prot, int lvl, arm_lpae_iopte *ptep,
-			  gfp_t gfp, size_t *mapped)
-{
-	arm_lpae_iopte *cptep, pte;
-	size_t block_size = ARM_LPAE_BLOCK_SIZE(lvl, data);
-	size_t tblsz = ARM_LPAE_GRANULE(data);
-	struct io_pgtable_cfg *cfg = &data->iop.cfg;
-	int ret = 0, num_entries, max_entries, map_idx_start;
-
-	/* Find our entry at the current level */
-	map_idx_start = ARM_LPAE_LVL_IDX(iova, lvl, data);
-	ptep += map_idx_start;
-
-	/* If we can install a leaf entry at this level, then do so */
-	if (size == block_size) {
-		max_entries = ARM_LPAE_PTES_PER_TABLE(data) - map_idx_start;
-		num_entries = min_t(int, pgcount, max_entries);
-		ret = arm_lpae_init_pte(data, iova, paddr, prot, lvl, num_entries, ptep);
-		if (!ret)
-			*mapped += num_entries * size;
-
-		return ret;
-	}
-
-	/* We can't allocate tables at the final level */
-	if (WARN_ON(lvl >= ARM_LPAE_MAX_LEVELS - 1))
-		return -EINVAL;
-
-	/* Grab a pointer to the next level */
-	pte = READ_ONCE(*ptep);
-	if (!pte) {
-		cptep = __arm_lpae_alloc_pages(tblsz, gfp, cfg, data->iop.cookie);
-		if (!cptep)
-			return -ENOMEM;
-
-		pte = arm_lpae_install_table(cptep, ptep, 0, data);
-		if (pte)
-			__arm_lpae_free_pages(cptep, tblsz, cfg, data->iop.cookie);
-	} else if (!cfg->coherent_walk && !(pte & ARM_LPAE_PTE_SW_SYNC)) {
-		__arm_lpae_sync_pte(ptep, 1, cfg);
-	}
-
-	if (pte && !iopte_leaf(pte, lvl, data->iop.fmt)) {
-		cptep = iopte_deref(pte, data);
-	} else if (pte) {
-		/* We require an unmap first */
-		WARN_ON(!selftest_running);
-		return -EEXIST;
-	}
-
-	/* Rinse, repeat */
-	return __arm_lpae_map(data, iova, paddr, size, pgcount, prot, lvl + 1,
-			      cptep, gfp, mapped);
-}
-
-static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
-					   int prot)
-{
-	arm_lpae_iopte pte;
-
-	if (data->iop.fmt == ARM_64_LPAE_S1 ||
-	    data->iop.fmt == ARM_32_LPAE_S1) {
-		pte = ARM_LPAE_PTE_nG;
-		if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
-			pte |= ARM_LPAE_PTE_AP_RDONLY;
-		else if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_HD)
-			pte |= ARM_LPAE_PTE_DBM;
-		if (!(prot & IOMMU_PRIV))
-			pte |= ARM_LPAE_PTE_AP_UNPRIV;
-	} else {
-		pte = ARM_LPAE_PTE_HAP_FAULT;
-		if (prot & IOMMU_READ)
-			pte |= ARM_LPAE_PTE_HAP_READ;
-		if (prot & IOMMU_WRITE)
-			pte |= ARM_LPAE_PTE_HAP_WRITE;
-	}
-
-	/*
-	 * Note that this logic is structured to accommodate Mali LPAE
-	 * having stage-1-like attributes but stage-2-like permissions.
-	 */
-	if (data->iop.fmt == ARM_64_LPAE_S2 ||
-	    data->iop.fmt == ARM_32_LPAE_S2) {
-		if (prot & IOMMU_MMIO)
-			pte |= ARM_LPAE_PTE_MEMATTR_DEV;
-		else if (prot & IOMMU_CACHE)
-			pte |= ARM_LPAE_PTE_MEMATTR_OIWB;
-		else
-			pte |= ARM_LPAE_PTE_MEMATTR_NC;
-	} else {
-		if (prot & IOMMU_MMIO)
-			pte |= (ARM_LPAE_MAIR_ATTR_IDX_DEV
-				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
-		else if (prot & IOMMU_CACHE)
-			pte |= (ARM_LPAE_MAIR_ATTR_IDX_CACHE
-				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
-	}
-
-	/*
-	 * Also Mali has its own notions of shareability wherein its Inner
-	 * domain covers the cores within the GPU, and its Outer domain is
-	 * "outside the GPU" (i.e. either the Inner or System domain in CPU
-	 * terms, depending on coherency).
-	 */
-	if (prot & IOMMU_CACHE && data->iop.fmt != ARM_MALI_LPAE)
-		pte |= ARM_LPAE_PTE_SH_IS;
-	else
-		pte |= ARM_LPAE_PTE_SH_OS;
-
-	if (prot & IOMMU_NOEXEC)
-		pte |= ARM_LPAE_PTE_XN;
-
-	if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_NS)
-		pte |= ARM_LPAE_PTE_NS;
-
-	if (data->iop.fmt != ARM_MALI_LPAE)
-		pte |= ARM_LPAE_PTE_AF;
-
-	return pte;
-}
-
-static int arm_lpae_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
-			      phys_addr_t paddr, size_t pgsize, size_t pgcount,
-			      int iommu_prot, gfp_t gfp, size_t *mapped)
-{
-	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
-	struct io_pgtable_cfg *cfg = &data->iop.cfg;
-	arm_lpae_iopte *ptep = data->pgd;
-	int ret, lvl = data->start_level;
-	arm_lpae_iopte prot;
-	long iaext = (s64)iova >> cfg->ias;
-
-	if (WARN_ON(!pgsize || (pgsize & cfg->pgsize_bitmap) != pgsize))
-		return -EINVAL;
-
-	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1)
-		iaext = ~iaext;
-	if (WARN_ON(iaext || paddr >> cfg->oas))
-		return -ERANGE;
-
-	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
-		return -EINVAL;
-
-	prot = arm_lpae_prot_to_pte(data, iommu_prot);
-	ret = __arm_lpae_map(data, iova, paddr, pgsize, pgcount, prot, lvl,
-			     ptep, gfp, mapped);
-	/*
-	 * Synchronise all PTE updates for the new mapping before there's
-	 * a chance for anything to kick off a table walk for the new iova.
-	 */
-	wmb();
-
-	return ret;
-}
-
-static void __arm_lpae_free_pgtable(struct arm_lpae_io_pgtable *data, int lvl,
-				    arm_lpae_iopte *ptep)
-{
-	arm_lpae_iopte *start, *end;
-	unsigned long table_size;
-
-	if (lvl == data->start_level)
-		table_size = ARM_LPAE_PGD_SIZE(data);
-	else
-		table_size = ARM_LPAE_GRANULE(data);
-
-	start = ptep;
-
-	/* Only leaf entries at the last level */
-	if (lvl == ARM_LPAE_MAX_LEVELS - 1)
-		end = ptep;
-	else
-		end = (void *)ptep + table_size;
-
-	while (ptep != end) {
-		arm_lpae_iopte pte = *ptep++;
-
-		if (!pte || iopte_leaf(pte, lvl, data->iop.fmt))
-			continue;
-
-		__arm_lpae_free_pgtable(data, lvl + 1, iopte_deref(pte, data));
-	}
-
-	__arm_lpae_free_pages(start, table_size, &data->iop.cfg, data->iop.cookie);
-}
-
 static void arm_lpae_free_pgtable(struct io_pgtable *iop)
 {
 	struct arm_lpae_io_pgtable *data = io_pgtable_to_data(iop);
@@ -569,319 +121,6 @@ static void arm_lpae_free_pgtable(struct io_pgtable *iop)
 	kfree(data);
 }
 
-static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
-				       struct iommu_iotlb_gather *gather,
-				       unsigned long iova, size_t size,
-				       arm_lpae_iopte blk_pte, int lvl,
-				       arm_lpae_iopte *ptep, size_t pgcount)
-{
-	struct io_pgtable_cfg *cfg = &data->iop.cfg;
-	arm_lpae_iopte pte, *tablep;
-	phys_addr_t blk_paddr;
-	size_t tablesz = ARM_LPAE_GRANULE(data);
-	size_t split_sz = ARM_LPAE_BLOCK_SIZE(lvl, data);
-	int ptes_per_table = ARM_LPAE_PTES_PER_TABLE(data);
-	int i, unmap_idx_start = -1, num_entries = 0, max_entries;
-
-	if (WARN_ON(lvl == ARM_LPAE_MAX_LEVELS))
-		return 0;
-
-	tablep = __arm_lpae_alloc_pages(tablesz, GFP_ATOMIC, cfg, data->iop.cookie);
-	if (!tablep)
-		return 0; /* Bytes unmapped */
-
-	if (size == split_sz) {
-		unmap_idx_start = ARM_LPAE_LVL_IDX(iova, lvl, data);
-		max_entries = ptes_per_table - unmap_idx_start;
-		num_entries = min_t(int, pgcount, max_entries);
-	}
-
-	blk_paddr = iopte_to_paddr(blk_pte, data);
-	pte = iopte_prot(blk_pte);
-
-	for (i = 0; i < ptes_per_table; i++, blk_paddr += split_sz) {
-		/* Unmap! */
-		if (i >= unmap_idx_start && i < (unmap_idx_start + num_entries))
-			continue;
-
-		__arm_lpae_init_pte(data, blk_paddr, pte, lvl, 1, &tablep[i]);
-	}
-
-	pte = arm_lpae_install_table(tablep, ptep, blk_pte, data);
-	if (pte != blk_pte) {
-		__arm_lpae_free_pages(tablep, tablesz, cfg, data->iop.cookie);
-		/*
-		 * We may race against someone unmapping another part of this
-		 * block, but anything else is invalid. We can't misinterpret
-		 * a page entry here since we're never at the last level.
-		 */
-		if (iopte_type(pte) != ARM_LPAE_PTE_TYPE_TABLE)
-			return 0;
-
-		tablep = iopte_deref(pte, data);
-	} else if (unmap_idx_start >= 0) {
-		for (i = 0; i < num_entries; i++)
-			io_pgtable_tlb_add_page(&data->iop, gather, iova + i * size, size);
-
-		return num_entries * size;
-	}
-
-	return __arm_lpae_unmap(data, gather, iova, size, pgcount, lvl, tablep);
-}
-
-static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
-			       struct iommu_iotlb_gather *gather,
-			       unsigned long iova, size_t size, size_t pgcount,
-			       int lvl, arm_lpae_iopte *ptep)
-{
-	arm_lpae_iopte pte;
-	struct io_pgtable *iop = &data->iop;
-	int i = 0, num_entries, max_entries, unmap_idx_start;
-
-	/* Something went horribly wrong and we ran out of page table */
-	if (WARN_ON(lvl == ARM_LPAE_MAX_LEVELS))
-		return 0;
-
-	unmap_idx_start = ARM_LPAE_LVL_IDX(iova, lvl, data);
-	ptep += unmap_idx_start;
-	pte = READ_ONCE(*ptep);
-	if (WARN_ON(!pte))
-		return 0;
-
-	/* If the size matches this level, we're in the right place */
-	if (size == ARM_LPAE_BLOCK_SIZE(lvl, data)) {
-		max_entries = ARM_LPAE_PTES_PER_TABLE(data) - unmap_idx_start;
-		num_entries = min_t(int, pgcount, max_entries);
-
-		/* Find and handle non-leaf entries */
-		for (i = 0; i < num_entries; i++) {
-			pte = READ_ONCE(ptep[i]);
-			if (WARN_ON(!pte))
-				break;
-
-			if (!iopte_leaf(pte, lvl, iop->fmt)) {
-				__arm_lpae_clear_pte(&ptep[i], &iop->cfg, 1);
-
-				/* Also flush any partial walks */
-				io_pgtable_tlb_flush_walk(iop, iova + i * size, size,
-							  ARM_LPAE_GRANULE(data));
-				__arm_lpae_free_pgtable(data, lvl + 1, iopte_deref(pte, data));
-			}
-		}
-
-		/* Clear the remaining entries */
-		__arm_lpae_clear_pte(ptep, &iop->cfg, i);
-
-		if (gather && !iommu_iotlb_gather_queued(gather))
-			for (int j = 0; j < i; j++)
-				io_pgtable_tlb_add_page(iop, gather, iova + j * size, size);
-
-		return i * size;
-	} else if (iopte_leaf(pte, lvl, iop->fmt)) {
-		/*
-		 * Insert a table at the next level to map the old region,
-		 * minus the part we want to unmap
-		 */
-		return arm_lpae_split_blk_unmap(data, gather, iova, size, pte,
-						lvl + 1, ptep, pgcount);
-	}
-
-	/* Keep on walkin' */
-	ptep = iopte_deref(pte, data);
-	return __arm_lpae_unmap(data, gather, iova, size, pgcount, lvl + 1, ptep);
-}
-
-static size_t arm_lpae_unmap_pages(struct io_pgtable_ops *ops, unsigned long iova,
-				   size_t pgsize, size_t pgcount,
-				   struct iommu_iotlb_gather *gather)
-{
-	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
-	struct io_pgtable_cfg *cfg = &data->iop.cfg;
-	arm_lpae_iopte *ptep = data->pgd;
-	long iaext = (s64)iova >> cfg->ias;
-
-	if (WARN_ON(!pgsize || (pgsize & cfg->pgsize_bitmap) != pgsize || !pgcount))
-		return 0;
-
-	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1)
-		iaext = ~iaext;
-	if (WARN_ON(iaext))
-		return 0;
-
-	return __arm_lpae_unmap(data, gather, iova, pgsize, pgcount,
-				data->start_level, ptep);
-}
-
-struct io_pgtable_walk_data {
-	struct io_pgtable		*iop;
-	void				*data;
-	int (*visit)(struct io_pgtable_walk_data *walk_data, int lvl,
-		     arm_lpae_iopte *ptep, size_t size);
-	unsigned long			flags;
-	u64				addr;
-	const u64			end;
-};
-
-static int __arm_lpae_iopte_walk(struct arm_lpae_io_pgtable *data,
-				 struct io_pgtable_walk_data *walk_data,
-				 arm_lpae_iopte *ptep,
-				 int lvl);
-
-struct iova_to_phys_data {
-	arm_lpae_iopte pte;
-	int lvl;
-};
-
-static int visit_iova_to_phys(struct io_pgtable_walk_data *walk_data, int lvl,
-			      arm_lpae_iopte *ptep, size_t size)
-{
-	struct iova_to_phys_data *data = walk_data->data;
-	data->pte = *ptep;
-	data->lvl = lvl;
-	return 0;
-}
-
-static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
-					 unsigned long iova)
-{
-	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
-	struct iova_to_phys_data d;
-	struct io_pgtable_walk_data walk_data = {
-		.data = &d,
-		.visit = visit_iova_to_phys,
-		.addr = iova,
-		.end = iova + 1,
-	};
-	int ret;
-
-	ret = __arm_lpae_iopte_walk(data, &walk_data, data->pgd, data->start_level);
-	if (ret)
-		return 0;
-
-	iova &= (ARM_LPAE_BLOCK_SIZE(d.lvl, data) - 1);
-	return iopte_to_paddr(d.pte, data) | iova;
-}
-
-static int visit_pgtable_walk(struct io_pgtable_walk_data *walk_data, int lvl,
-			      arm_lpae_iopte *ptep, size_t size)
-{
-	struct arm_lpae_io_pgtable_walk_data *data = walk_data->data;
-	data->ptes[data->level++] = *ptep;
-	return 0;
-}
-
-static int arm_lpae_pgtable_walk(struct io_pgtable_ops *ops, unsigned long iova,
-				 void *wd)
-{
-	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
-	struct io_pgtable_walk_data walk_data = {
-		.data = wd,
-		.visit = visit_pgtable_walk,
-		.addr = iova,
-		.end = iova + 1,
-	};
-
-	((struct arm_lpae_io_pgtable_walk_data *)wd)->level = 0;
-
-	return __arm_lpae_iopte_walk(data, &walk_data, data->pgd, data->start_level);
-}
-
-static int io_pgtable_visit(struct arm_lpae_io_pgtable *data,
-			    struct io_pgtable_walk_data *walk_data,
-			    arm_lpae_iopte *ptep, int lvl)
-{
-	struct io_pgtable *iop = &data->iop;
-	arm_lpae_iopte pte = READ_ONCE(*ptep);
-
-	size_t size = ARM_LPAE_BLOCK_SIZE(lvl, data);
-	int ret = walk_data->visit(walk_data, lvl, ptep, size);
-	if (ret)
-		return ret;
-
-	if (iopte_leaf(pte, lvl, iop->fmt)) {
-		walk_data->addr += size;
-		return 0;
-	}
-
-	if (!iopte_table(pte, lvl)) {
-		return -EINVAL;
-	}
-
-	ptep = iopte_deref(pte, data);
-	return __arm_lpae_iopte_walk(data, walk_data, ptep, lvl + 1);
-}
-
-static int __arm_lpae_iopte_walk(struct arm_lpae_io_pgtable *data,
-				 struct io_pgtable_walk_data *walk_data,
-				 arm_lpae_iopte *ptep,
-				 int lvl)
-{
-	u32 idx;
-	int max_entries, ret;
-
-	if (WARN_ON(lvl == ARM_LPAE_MAX_LEVELS))
-		return -EINVAL;
-
-	if (lvl == data->start_level)
-		max_entries = ARM_LPAE_PGD_SIZE(data) / sizeof(arm_lpae_iopte);
-	else
-		max_entries = ARM_LPAE_PTES_PER_TABLE(data);
-
-	for (idx = ARM_LPAE_LVL_IDX(walk_data->addr, lvl, data);
-	     (idx < max_entries) && (walk_data->addr < walk_data->end); ++idx) {
-		ret = io_pgtable_visit(data, walk_data, ptep + idx, lvl);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
-static int visit_dirty(struct io_pgtable_walk_data *walk_data, int lvl,
-		       arm_lpae_iopte *ptep, size_t size)
-{
-	struct iommu_dirty_bitmap *dirty = walk_data->data;
-
-	if (!iopte_leaf(*ptep, lvl, walk_data->iop->fmt))
-		return 0;
-
-	if (iopte_writeable_dirty(*ptep)) {
-		iommu_dirty_bitmap_record(dirty, walk_data->addr, size);
-		if (!(walk_data->flags & IOMMU_DIRTY_NO_CLEAR))
-			iopte_set_writeable_clean(ptep);
-	}
-
-	return 0;
-}
-
-static int arm_lpae_read_and_clear_dirty(struct io_pgtable_ops *ops,
-					 unsigned long iova, size_t size,
-					 unsigned long flags,
-					 struct iommu_dirty_bitmap *dirty)
-{
-	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
-	struct io_pgtable_cfg *cfg = &data->iop.cfg;
-	struct io_pgtable_walk_data walk_data = {
-		.iop = &data->iop,
-		.data = dirty,
-		.visit = visit_dirty,
-		.flags = flags,
-		.addr = iova,
-		.end = iova + size,
-	};
-	arm_lpae_iopte *ptep = data->pgd;
-	int lvl = data->start_level;
-
-	if (WARN_ON(!size))
-		return -EINVAL;
-	if (WARN_ON((iova + size - 1) & ~(BIT(cfg->ias) - 1)))
-		return -EINVAL;
-	if (data->iop.fmt != ARM_64_LPAE_S1)
-		return -EINVAL;
-
-	return __arm_lpae_iopte_walk(data, &walk_data, ptep, lvl);
-}
-
 static void arm_lpae_restrict_pgsizes(struct io_pgtable_cfg *cfg)
 {
 	unsigned long granule, page_sizes;
diff --git a/drivers/iommu/io-pgtable-arm.h b/drivers/iommu/io-pgtable-arm.h
deleted file mode 100644
index ba7cfdf7afa0..000000000000
--- a/drivers/iommu/io-pgtable-arm.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-#ifndef IO_PGTABLE_ARM_H_
-#define IO_PGTABLE_ARM_H_
-
-#define ARM_LPAE_TCR_TG0_4K		0
-#define ARM_LPAE_TCR_TG0_64K		1
-#define ARM_LPAE_TCR_TG0_16K		2
-
-#define ARM_LPAE_TCR_TG1_16K		1
-#define ARM_LPAE_TCR_TG1_4K		2
-#define ARM_LPAE_TCR_TG1_64K		3
-
-#define ARM_LPAE_TCR_SH_NS		0
-#define ARM_LPAE_TCR_SH_OS		2
-#define ARM_LPAE_TCR_SH_IS		3
-
-#define ARM_LPAE_TCR_RGN_NC		0
-#define ARM_LPAE_TCR_RGN_WBWA		1
-#define ARM_LPAE_TCR_RGN_WT		2
-#define ARM_LPAE_TCR_RGN_WB		3
-
-#define ARM_LPAE_TCR_PS_32_BIT		0x0ULL
-#define ARM_LPAE_TCR_PS_36_BIT		0x1ULL
-#define ARM_LPAE_TCR_PS_40_BIT		0x2ULL
-#define ARM_LPAE_TCR_PS_42_BIT		0x3ULL
-#define ARM_LPAE_TCR_PS_44_BIT		0x4ULL
-#define ARM_LPAE_TCR_PS_48_BIT		0x5ULL
-#define ARM_LPAE_TCR_PS_52_BIT		0x6ULL
-
-#endif /* IO_PGTABLE_ARM_H_ */
diff --git a/include/linux/io-pgtable-arm.h b/include/linux/io-pgtable-arm.h
new file mode 100644
index 000000000000..1f56dabca18c
--- /dev/null
+++ b/include/linux/io-pgtable-arm.h
@@ -0,0 +1,223 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef IO_PGTABLE_H_
+#define IO_PGTABLE_H_
+
+#include <linux/io-pgtable.h>
+
+typedef u64 arm_lpae_iopte;
+
+struct arm_lpae_io_pgtable {
+	struct io_pgtable	iop;
+
+	int			pgd_bits;
+	int			start_level;
+	int			bits_per_level;
+
+	void			*pgd;
+};
+
+struct io_pgtable_walk_data {
+	struct io_pgtable		*iop;
+	void				*data;
+	int (*visit)(struct io_pgtable_walk_data *walk_data, int lvl,
+		     arm_lpae_iopte *ptep, size_t size);
+	unsigned long			flags;
+	u64				addr;
+	const u64			end;
+};
+
+/* Struct accessors */
+#define io_pgtable_to_data(x)						\
+	container_of((x), struct arm_lpae_io_pgtable, iop)
+
+#define io_pgtable_ops_to_data(x)					\
+	io_pgtable_to_data(io_pgtable_ops_to_pgtable(x))
+
+/*
+ * Calculate the right shift amount to get to the portion describing level l
+ * in a virtual address mapped by the pagetable in d.
+ */
+#define ARM_LPAE_LVL_SHIFT(l,d)						\
+	(((ARM_LPAE_MAX_LEVELS - (l)) * (d)->bits_per_level) +		\
+	ilog2(sizeof(arm_lpae_iopte)))
+
+#define ARM_LPAE_GRANULE(d)						\
+	(sizeof(arm_lpae_iopte) << (d)->bits_per_level)
+#define ARM_LPAE_PGD_SIZE(d)						\
+	(sizeof(arm_lpae_iopte) << (d)->pgd_bits)
+
+#define ARM_LPAE_PTES_PER_TABLE(d)					\
+	(ARM_LPAE_GRANULE(d) >> ilog2(sizeof(arm_lpae_iopte)))
+
+/*
+ * Calculate the index at level l used to map virtual address a using the
+ * pagetable in d.
+ */
+#define ARM_LPAE_PGD_IDX(l,d)						\
+	((l) == (d)->start_level ? (d)->pgd_bits - (d)->bits_per_level : 0)
+
+#define ARM_LPAE_LVL_IDX(a,l,d)						\
+	(((u64)(a) >> ARM_LPAE_LVL_SHIFT(l,d)) &			\
+	 ((1 << ((d)->bits_per_level + ARM_LPAE_PGD_IDX(l,d))) - 1))
+
+/* Calculate the block/page mapping size at level l for pagetable in d. */
+#define ARM_LPAE_BLOCK_SIZE(l,d)	(1ULL << ARM_LPAE_LVL_SHIFT(l,d))
+
+/* Page table bits */
+#define ARM_LPAE_PTE_TYPE_SHIFT		0
+#define ARM_LPAE_PTE_TYPE_MASK		0x3
+
+#define ARM_LPAE_PTE_TYPE_BLOCK		1
+#define ARM_LPAE_PTE_TYPE_TABLE		3
+#define ARM_LPAE_PTE_TYPE_PAGE		3
+
+#define ARM_LPAE_PTE_ADDR_MASK		GENMASK_ULL(47,12)
+
+#define ARM_LPAE_PTE_NSTABLE		(((arm_lpae_iopte)1) << 63)
+#define ARM_LPAE_PTE_XN			(((arm_lpae_iopte)3) << 53)
+#define ARM_LPAE_PTE_DBM		(((arm_lpae_iopte)1) << 51)
+#define ARM_LPAE_PTE_AF			(((arm_lpae_iopte)1) << 10)
+#define ARM_LPAE_PTE_SH_NS		(((arm_lpae_iopte)0) << 8)
+#define ARM_LPAE_PTE_SH_OS		(((arm_lpae_iopte)2) << 8)
+#define ARM_LPAE_PTE_SH_IS		(((arm_lpae_iopte)3) << 8)
+#define ARM_LPAE_PTE_NS			(((arm_lpae_iopte)1) << 5)
+#define ARM_LPAE_PTE_VALID		(((arm_lpae_iopte)1) << 0)
+
+#define ARM_LPAE_PTE_ATTR_LO_MASK	(((arm_lpae_iopte)0x3ff) << 2)
+/* Ignore the contiguous bit for block splitting */
+#define ARM_LPAE_PTE_ATTR_HI_MASK	(ARM_LPAE_PTE_XN | ARM_LPAE_PTE_DBM)
+#define ARM_LPAE_PTE_ATTR_MASK		(ARM_LPAE_PTE_ATTR_LO_MASK |	\
+					 ARM_LPAE_PTE_ATTR_HI_MASK)
+/* Software bit for solving coherency races */
+#define ARM_LPAE_PTE_SW_SYNC		(((arm_lpae_iopte)1) << 55)
+
+/* Stage-1 PTE */
+#define ARM_LPAE_PTE_AP_UNPRIV		(((arm_lpae_iopte)1) << 6)
+#define ARM_LPAE_PTE_AP_RDONLY_BIT	7
+#define ARM_LPAE_PTE_AP_RDONLY		(((arm_lpae_iopte)1) << \
+					   ARM_LPAE_PTE_AP_RDONLY_BIT)
+#define ARM_LPAE_PTE_AP_WR_CLEAN_MASK	(ARM_LPAE_PTE_AP_RDONLY | \
+					 ARM_LPAE_PTE_DBM)
+#define ARM_LPAE_PTE_ATTRINDX_SHIFT	2
+#define ARM_LPAE_PTE_nG			(((arm_lpae_iopte)1) << 11)
+
+/* Stage-2 PTE */
+#define ARM_LPAE_PTE_HAP_FAULT		(((arm_lpae_iopte)0) << 6)
+#define ARM_LPAE_PTE_HAP_READ		(((arm_lpae_iopte)1) << 6)
+#define ARM_LPAE_PTE_HAP_WRITE		(((arm_lpae_iopte)2) << 6)
+#define ARM_LPAE_PTE_MEMATTR_OIWB	(((arm_lpae_iopte)0xf) << 2)
+#define ARM_LPAE_PTE_MEMATTR_NC		(((arm_lpae_iopte)0x5) << 2)
+#define ARM_LPAE_PTE_MEMATTR_DEV	(((arm_lpae_iopte)0x1) << 2)
+
+/* Register bits */
+#define ARM_LPAE_VTCR_SL0_MASK		0x3
+
+#define ARM_LPAE_TCR_T0SZ_SHIFT		0
+
+#define ARM_LPAE_VTCR_PS_SHIFT		16
+#define ARM_LPAE_VTCR_PS_MASK		0x7
+
+#define ARM_LPAE_MAIR_ATTR_SHIFT(n)	((n) << 3)
+#define ARM_LPAE_MAIR_ATTR_MASK		0xff
+#define ARM_LPAE_MAIR_ATTR_DEVICE	0x04
+#define ARM_LPAE_MAIR_ATTR_NC		0x44
+#define ARM_LPAE_MAIR_ATTR_INC_OWBRWA	0xf4
+#define ARM_LPAE_MAIR_ATTR_WBRWA	0xff
+#define ARM_LPAE_MAIR_ATTR_IDX_NC	0
+#define ARM_LPAE_MAIR_ATTR_IDX_CACHE	1
+#define ARM_LPAE_MAIR_ATTR_IDX_DEV	2
+#define ARM_LPAE_MAIR_ATTR_IDX_INC_OCACHE	3
+
+#define ARM_MALI_LPAE_TTBR_ADRMODE_TABLE (3u << 0)
+#define ARM_MALI_LPAE_TTBR_READ_INNER	BIT(2)
+#define ARM_MALI_LPAE_TTBR_SHARE_OUTER	BIT(4)
+
+#define ARM_MALI_LPAE_MEMATTR_IMP_DEF	0x88ULL
+#define ARM_MALI_LPAE_MEMATTR_WRITE_ALLOC 0x8DULL
+
+#define ARM_LPAE_MAX_LEVELS		4
+
+#define ARM_LPAE_TCR_TG0_4K		0
+#define ARM_LPAE_TCR_TG0_64K		1
+#define ARM_LPAE_TCR_TG0_16K		2
+
+#define ARM_LPAE_TCR_TG1_16K		1
+#define ARM_LPAE_TCR_TG1_4K		2
+#define ARM_LPAE_TCR_TG1_64K		3
+
+#define ARM_LPAE_TCR_SH_NS		0
+#define ARM_LPAE_TCR_SH_OS		2
+#define ARM_LPAE_TCR_SH_IS		3
+
+#define ARM_LPAE_TCR_RGN_NC		0
+#define ARM_LPAE_TCR_RGN_WBWA		1
+#define ARM_LPAE_TCR_RGN_WT		2
+#define ARM_LPAE_TCR_RGN_WB		3
+
+#define ARM_LPAE_TCR_PS_32_BIT		0x0ULL
+#define ARM_LPAE_TCR_PS_36_BIT		0x1ULL
+#define ARM_LPAE_TCR_PS_40_BIT		0x2ULL
+#define ARM_LPAE_TCR_PS_42_BIT		0x3ULL
+#define ARM_LPAE_TCR_PS_44_BIT		0x4ULL
+#define ARM_LPAE_TCR_PS_48_BIT		0x5ULL
+#define ARM_LPAE_TCR_PS_52_BIT		0x6ULL
+
+/* IOPTE accessors */
+#define iopte_type(pte)					\
+	(((pte) >> ARM_LPAE_PTE_TYPE_SHIFT) & ARM_LPAE_PTE_TYPE_MASK)
+
+#define iopte_prot(pte)	((pte) & ARM_LPAE_PTE_ATTR_MASK)
+
+#define iopte_writeable_dirty(pte)				\
+	(((pte) & ARM_LPAE_PTE_AP_WR_CLEAN_MASK) == ARM_LPAE_PTE_DBM)
+
+#define iopte_set_writeable_clean(ptep)				\
+	set_bit(ARM_LPAE_PTE_AP_RDONLY_BIT, (unsigned long *)(ptep))
+
+
+static inline bool iopte_leaf(arm_lpae_iopte pte, int lvl,
+			      enum io_pgtable_fmt fmt)
+{
+	if (lvl == (ARM_LPAE_MAX_LEVELS - 1) && fmt != ARM_MALI_LPAE)
+		return iopte_type(pte) == ARM_LPAE_PTE_TYPE_PAGE;
+
+	return iopte_type(pte) == ARM_LPAE_PTE_TYPE_BLOCK;
+}
+
+static inline bool iopte_table(arm_lpae_iopte pte, int lvl)
+{
+	if (lvl == (ARM_LPAE_MAX_LEVELS - 1))
+		return false;
+	return iopte_type(pte) == ARM_LPAE_PTE_TYPE_TABLE;
+}
+
+#define __arm_lpae_virt_to_phys	__pa
+#define __arm_lpae_phys_to_virt	__va
+
+/* Generic functions */
+int arm_lpae_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
+		       phys_addr_t paddr, size_t pgsize, size_t pgcount,
+		       int iommu_prot, gfp_t gfp, size_t *mapped);
+size_t arm_lpae_unmap_pages(struct io_pgtable_ops *ops, unsigned long iova,
+			    size_t pgsize, size_t pgcount,
+			    struct iommu_iotlb_gather *gather);
+phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
+				  unsigned long iova);
+void __arm_lpae_free_pgtable(struct arm_lpae_io_pgtable *data, int lvl,
+			     arm_lpae_iopte *ptep);
+
+int arm_lpae_read_and_clear_dirty(struct io_pgtable_ops *ops,
+				  unsigned long iova, size_t size,
+				  unsigned long flags,
+				  struct iommu_dirty_bitmap *dirty);
+
+int arm_lpae_pgtable_walk(struct io_pgtable_ops *ops, unsigned long iova, void *wd);
+
+/* Host/hyp-specific functions */
+void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp, struct io_pgtable_cfg *cfg, void *cookie);
+void __arm_lpae_free_pages(void *pages, size_t size, struct io_pgtable_cfg *cfg, void *cookie);
+void __arm_lpae_sync_pte(arm_lpae_iopte *ptep, int num_entries,
+			 struct io_pgtable_cfg *cfg);
+int arm_lpae_map_exists(void);
+int arm_lpae_unmap_empty(void);
+#endif /* IO_PGTABLE_H_ */
-- 
2.47.0.338.g60cca15819-goog


