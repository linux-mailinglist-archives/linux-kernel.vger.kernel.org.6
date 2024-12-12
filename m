Return-Path: <linux-kernel+bounces-443652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8459EFA82
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A64AC1884C6B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E72237FE4;
	Thu, 12 Dec 2024 18:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pGBXhW1U"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78893223E8D
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026746; cv=none; b=CjAMX0mMZ//1ZOol/VRcalEVvxYSYuXCEdD2eq72nCLECF6bJKlYETRGSgUtZmwlPvQCyEvlmys6Iw9dGeJFvjirsRVb56P0cQKB1Au7RY4/u1Nrbd8CB+o6Ekax60J+iHPOj//kNmYGRzkDbTTMKC/Y5IBpsCniheUwfHSC/os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026746; c=relaxed/simple;
	bh=vYlQF/00jW9GBGXp+yQV9E45uql11nRB0ar6n3dkdhQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N0mTQ0kkt6KuUXHHU+7Gu4rZsJXrZgF0yB0NlrtFwwtCB47zqIK6ZyrfEPnA6ZD5hKQEhijiP5CzDbB/tJAyxWiRUNg9hn5UZNlC8cJQSEG/qf0bodNNeMd6rQZ5uxWeajD7L8szEyTN3+QsUsiXKSYMwGHi5FLNPuX7dssQ1GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pGBXhW1U; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-385dfa9b758so421156f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026742; x=1734631542; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1LMxyNsNja8u4zNmyLLENTRCKJqkK6QgSakPe49cILk=;
        b=pGBXhW1UVJlJhXEUh4paFObJOkfV6CAdrnd+3L2Dtqaf2sK690XVxWDRCOGCTZYKeS
         dEIk5lBXMlkoFR0d6ippYiahrg11gVYzRkaKBIsxcNzwtR0xbG6jYA533Z5FzbWSq8tJ
         fkY2xfksg0xiPIa5OOQT1JKdFBeOgTXAidz1f8w+zrVpIOcfDwUYLjjXS6LapzCtzpZM
         L5vgRWILCxiEaqMFJhfAvuWew8bwfx8QkeUdvW4gGcy0FVRMQKJtieL+zonoO6YZEkqg
         meWJ7S8ifeE8MV7T4vCQxm4PZZle2mqPqzjoHaK6txG2XcdNVO3BeMSManIXF3mLrl8O
         D6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026742; x=1734631542;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1LMxyNsNja8u4zNmyLLENTRCKJqkK6QgSakPe49cILk=;
        b=RFokc9wH9K/IMVfEl4UoP50ytlWwomPSr22at18Uob4KBmkwBt5d+dj1h3ORs6dAal
         bfLK1NOyN24OUnXH7JPtRH/GRoBn2GqZ1+QFTk2+inUiAoh9Qw/s/mzt0IWPQvZzxlvk
         WKEAiK4iVWgYkxyr0ZFVLrIXE9u2syK+ItoqEqPB8F5r9W7gF/ujD5NPOBH2g6FYUu6v
         dITgtmmLGzlg7MF1UXZjjS/uWUv2xILa7WAFbyMGkBz3kCJhS4a1oGFI3hUvTibRBQVb
         1oVNxRGSEf6zwPouxppbrjHTLJNRsU5oEF/htyMbXP0xDorITtmDKku3P4oj6VKIs3f1
         x8CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjRWYqfnYfjaCVMD80vEWquZ+1OxrAJwPCaddDgf1Aesv4HqiooD6LosvDVIAW/HTNvp+ZDnUoM4FN1GI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGKVyRPkQS8oYoycHz3+t/n9vVn/m8cG271pmGZnMz80IaZ8JM
	pFiXmb1fUVehcRmROW6LfQXCtjc75pyxAE8C4Xy20DguzIKzqjR9LAO/IbMIHIZpshY9k+lD+9f
	CWtkj20cs/w==
X-Google-Smtp-Source: AGHT+IFPY+N9wTZ2tcFqUmavonh5uuqwBF4VmdeOBIMSWGf8ApdTWlq6S7L/pJ7JZxynPwo+SB3rplDprL91sA==
X-Received: from wmbdx10.prod.google.com ([2002:a05:600c:63ca:b0:436:1a60:654e])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5f47:0:b0:382:6f3:a20f with SMTP id ffacd0b85a97d-3864ce8956dmr7667344f8f.11.1734026741969;
 Thu, 12 Dec 2024 10:05:41 -0800 (PST)
Date: Thu, 12 Dec 2024 18:03:52 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-29-smostafa@google.com>
Subject: [RFC PATCH v2 28/58] KVM: arm64: smmu-v3: Setup stream table
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

Map the stream table allocated by the host into the hypervisor address
space. When the host mappings are finalized, the table is unmapped from
the host. Depending on the host configuration, the stream table may have
one or two levels. Populate the level-2 stream table lazily.

Also, add accessors for STEs.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c | 157 +++++++++++++++++++-
 include/kvm/arm_smmu_v3.h                   |   3 +
 2 files changed, 159 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c b/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
index e15356509424..43d2ce7828c1 100644
--- a/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
+++ b/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
@@ -174,7 +174,6 @@ static int smmu_sync_cmd(struct hyp_arm_smmu_v3_device *smmu)
 	return smmu_wait_event(smmu, smmu_cmdq_empty(smmu));
 }
 
-__maybe_unused
 static int smmu_send_cmd(struct hyp_arm_smmu_v3_device *smmu,
 			 struct arm_smmu_cmdq_ent *cmd)
 {
@@ -186,6 +185,94 @@ static int smmu_send_cmd(struct hyp_arm_smmu_v3_device *smmu,
 	return smmu_sync_cmd(smmu);
 }
 
+__maybe_unused
+static int smmu_sync_ste(struct hyp_arm_smmu_v3_device *smmu, u32 sid)
+{
+	struct arm_smmu_cmdq_ent cmd = {
+		.opcode = CMDQ_OP_CFGI_STE,
+		.cfgi.sid = sid,
+		.cfgi.leaf = true,
+	};
+
+	return smmu_send_cmd(smmu, &cmd);
+}
+
+static int smmu_alloc_l2_strtab(struct hyp_arm_smmu_v3_device *smmu, u32 sid)
+{
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+	struct arm_smmu_strtab_l1 *l1_desc;
+	dma_addr_t l2ptr_dma;
+	struct arm_smmu_strtab_l2 *l2table;
+	size_t l2_order = get_order(sizeof(struct arm_smmu_strtab_l2));
+	int flags = 0;
+
+	l1_desc = &cfg->l2.l1tab[arm_smmu_strtab_l1_idx(sid)];
+	if (l1_desc->l2ptr)
+		return 0;
+
+	if (!(smmu->features & ARM_SMMU_FEAT_COHERENCY))
+		flags |= IOMMU_PAGE_NOCACHE;
+
+	l2table = kvm_iommu_donate_pages(l2_order, flags);
+	if (!l2table)
+		return -ENOMEM;
+
+	l2ptr_dma = hyp_virt_to_phys(l2table);
+
+	if (l2ptr_dma & (~STRTAB_L1_DESC_L2PTR_MASK | ~PAGE_MASK)) {
+		kvm_iommu_reclaim_pages(l2table, l2_order);
+		return -EINVAL;
+	}
+
+	/* Ensure the empty stream table is visible before the descriptor write */
+	wmb();
+
+	arm_smmu_write_strtab_l1_desc(l1_desc, l2ptr_dma);
+	return 0;
+}
+
+static struct arm_smmu_ste *
+smmu_get_ste_ptr(struct hyp_arm_smmu_v3_device *smmu, u32 sid)
+{
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+
+	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
+		struct arm_smmu_strtab_l1 *l1_desc =
+					&cfg->l2.l1tab[arm_smmu_strtab_l1_idx(sid)];
+		struct arm_smmu_strtab_l2 *l2ptr;
+
+		if (arm_smmu_strtab_l1_idx(sid) > cfg->l2.num_l1_ents)
+			return NULL;
+		/* L2 should be allocated before calling this. */
+		if (WARN_ON(!l1_desc->l2ptr))
+			return NULL;
+
+		l2ptr = hyp_phys_to_virt(l1_desc->l2ptr & STRTAB_L1_DESC_L2PTR_MASK);
+		/* Two-level walk */
+		return &l2ptr->stes[arm_smmu_strtab_l2_idx(sid)];
+	}
+
+	if (sid > cfg->linear.num_ents)
+		return NULL;
+	/* Simple linear lookup */
+	return &cfg->linear.table[sid];
+}
+
+__maybe_unused
+static struct arm_smmu_ste *
+smmu_get_alloc_ste_ptr(struct hyp_arm_smmu_v3_device *smmu, u32 sid)
+{
+	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
+		int ret = smmu_alloc_l2_strtab(smmu, sid);
+
+		if (ret) {
+			WARN_ON(ret != -ENOMEM);
+			return NULL;
+		}
+	}
+	return smmu_get_ste_ptr(smmu, sid);
+}
+
 static int smmu_init_registers(struct hyp_arm_smmu_v3_device *smmu)
 {
 	u64 val, old;
@@ -255,6 +342,70 @@ static int smmu_init_cmdq(struct hyp_arm_smmu_v3_device *smmu)
 	return 0;
 }
 
+static int smmu_init_strtab(struct hyp_arm_smmu_v3_device *smmu)
+{
+	int ret;
+	u64 strtab_base;
+	size_t strtab_size;
+	u32 strtab_cfg, fmt;
+	int split, log2size;
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+	enum kvm_pgtable_prot prot = PAGE_HYP;
+
+	if (!(smmu->features & ARM_SMMU_FEAT_COHERENCY))
+		prot |= KVM_PGTABLE_PROT_NORMAL_NC;
+
+	strtab_base = readq_relaxed(smmu->base + ARM_SMMU_STRTAB_BASE);
+	if (strtab_base & ~(STRTAB_BASE_ADDR_MASK | STRTAB_BASE_RA))
+		return -EINVAL;
+
+	strtab_cfg = readl_relaxed(smmu->base + ARM_SMMU_STRTAB_BASE_CFG);
+	if (strtab_cfg & ~(STRTAB_BASE_CFG_FMT | STRTAB_BASE_CFG_SPLIT |
+			   STRTAB_BASE_CFG_LOG2SIZE))
+		return -EINVAL;
+
+	fmt = FIELD_GET(STRTAB_BASE_CFG_FMT, strtab_cfg);
+	split = FIELD_GET(STRTAB_BASE_CFG_SPLIT, strtab_cfg);
+	log2size = FIELD_GET(STRTAB_BASE_CFG_LOG2SIZE, strtab_cfg);
+	strtab_base &= STRTAB_BASE_ADDR_MASK;
+
+	switch (fmt) {
+	case STRTAB_BASE_CFG_FMT_LINEAR:
+		if (split)
+			return -EINVAL;
+		cfg->linear.num_ents = 1 << log2size;
+		strtab_size = cfg->linear.num_ents * sizeof(struct arm_smmu_ste);
+		cfg->linear.ste_dma = strtab_base;
+		ret = ___pkvm_host_donate_hyp_prot(strtab_base >> PAGE_SHIFT,
+						   PAGE_ALIGN(strtab_size) >> PAGE_SHIFT,
+						   false, prot);
+		if (ret)
+			return -EINVAL;
+		cfg->linear.table = hyp_phys_to_virt(strtab_base);
+		/* Disable all STEs */
+		memset(cfg->linear.table, 0, strtab_size);
+		break;
+	case STRTAB_BASE_CFG_FMT_2LVL:
+		if (split != STRTAB_SPLIT)
+			return -EINVAL;
+		cfg->l2.num_l1_ents = 1 << max(0, log2size - split);
+		strtab_size = cfg->l2.num_l1_ents * sizeof(struct arm_smmu_strtab_l1);
+		cfg->l2.l1_dma = strtab_base;
+		ret = ___pkvm_host_donate_hyp_prot(strtab_base >> PAGE_SHIFT,
+						   PAGE_ALIGN(strtab_size) >> PAGE_SHIFT,
+						   false, prot);
+		if (ret)
+			return -EINVAL;
+		cfg->l2.l1tab = hyp_phys_to_virt(strtab_base);
+		/* Disable all STEs */
+		memset(cfg->l2.l1tab, 0, strtab_size);
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int smmu_init_device(struct hyp_arm_smmu_v3_device *smmu)
 {
 	int ret;
@@ -278,6 +429,10 @@ static int smmu_init_device(struct hyp_arm_smmu_v3_device *smmu)
 	if (ret)
 		return ret;
 
+	ret = smmu_init_strtab(smmu);
+	if (ret)
+		return ret;
+
 	return kvm_iommu_init_device(&smmu->iommu);
 }
 
diff --git a/include/kvm/arm_smmu_v3.h b/include/kvm/arm_smmu_v3.h
index 393a1a04edba..352c1b2dc72a 100644
--- a/include/kvm/arm_smmu_v3.h
+++ b/include/kvm/arm_smmu_v3.h
@@ -2,6 +2,7 @@
 #ifndef __KVM_ARM_SMMU_V3_H
 #define __KVM_ARM_SMMU_V3_H
 
+#include <asm/arm-smmu-v3-common.h>
 #include <asm/kvm_asm.h>
 #include <kvm/iommu.h>
 
@@ -22,6 +23,8 @@ struct hyp_arm_smmu_v3_device {
 	u32			cmdq_prod;
 	u64			*cmdq_base;
 	size_t			cmdq_log2size;
+	/* strtab_cfg.l2.l2ptrs is not used, instead computed from L1 */
+	struct arm_smmu_strtab_cfg strtab_cfg;
 };
 
 extern size_t kvm_nvhe_sym(kvm_hyp_arm_smmu_v3_count);
-- 
2.47.0.338.g60cca15819-goog


