Return-Path: <linux-kernel+bounces-447894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0099F3854
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF7F816CB17
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3F521170D;
	Mon, 16 Dec 2024 17:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3aw7CJWu"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABB5211484
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 17:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371924; cv=none; b=TmNwBULFDh1lQdzru8cxBNdPBTdFQl9rtl8q5ZAKJweEZvjw4SR0rGEO5JObXQrhnU9Y12ZqHStesJw8Gj6kg7iENgcszZ3HKpWABkE5jtfN/MvIL9sCsdwPAVUiQ2RVlEUIzZpgvgwvuV55/T2awoqlU+zzYY+cNgYpiLhmztg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371924; c=relaxed/simple;
	bh=EpMiEdTx+L6LwtUfMkakJOBnHaVnLxop3EqsIxmJhfg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UtLfptYlgAQMo4Ix8Qb8avYOU29abKVSXCqjJoAwnkiK78KyBhKs3cbK9KfxSXeLi5HYvLTZ5KNEgK+2JGBtoTM2yClgsW8oKHZI6Fx06/BmAnUpSvxzSaL9eC0yeAC3Q/3XuiS81r6UFqlc8iuILd6MYNR/n06V09nfzrz7WHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3aw7CJWu; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5d3cb2e6c42so5070247a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 09:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734371921; x=1734976721; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QHTtHFS5HwQp5yZdDtuGaqFCf7n78KGed6qmJTmvD8M=;
        b=3aw7CJWuqrxNanHF0F4wA3ngsMrH1/bzGoNslUa4MDJ9/t3r4zLZiXh2bYtN7pMfYk
         wq9zrDFpYTUv9Ave4Vlai93/5t/zqK0bFGixnGPwP54M7lHZQyyBe2r8XXXvCt3Yr0vY
         NU9MB6/1MFtICZhhQRub1Yc3c/GKMJCSIBsQ1xtZXuytAWVuDjKvqEPXFQMMX5Flae0M
         qAcehf36zhREfLC4INykLGd07qXYlTpr+n385z2d1dG/gXj3Lb7y2pSEgtcTgiCCjMOh
         NLSImg0X5EwxKByqvApus9Po7CPoncLtPRvDrcdgu4GZOf4LFl4A0XN5MfBcAeMQdmQD
         f2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734371921; x=1734976721;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QHTtHFS5HwQp5yZdDtuGaqFCf7n78KGed6qmJTmvD8M=;
        b=Awb96Nxjh3e1JExmD7GwnovIfcnUAMDbxz+FOQZHvdseRSDou/JxBCkQePW0tl+/Wr
         1wdoSjWtbIBLRljo2aCjM7rc97OREORZkACR5VMv3QLxLCT8WoSgqNe/mChQOk2zukBr
         a5G/9oY2vFFFDYiRXPJ3EvfBpKXkSIzQrj2YHXUAjKaQoi0hxld2bOC76NFF9xTGpZBf
         6JrwyxZGvetXu541ADXQodFmJAkaUz+n0zUgemjQGvTn5S2teZmGduCO+QeNGNIaMngh
         9I7Rx/80gija1nEpkhWNZapDACkSWTR63hjZneKXnRzdMFql4cN1r/DHxE5YANXE7d+m
         J1eQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWR0F5akOHD8pniMxLAJKAUlTVecs+5k/AwwgbmrC9mAjCkkfHUMEUq3OZcj3k1XCiBLvRbJF4DcQrHig=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXFmiNcxrFnY1RGochfkGA5S12+c1sCXwclJUzxf8IQ+qSPNt/
	tnWy+fu93lFa/cMjbt4BNmo3aG2w0VoGN88eqM9EfuDinHGqZgdDHZ5E6KeB0YH9yPqov3yHyiV
	1rS6E+Q==
X-Google-Smtp-Source: AGHT+IHPbTD8KaiYcFmXHQWnggpBPrsvUFvz8/+wp3Al0bflSEL8Fx1IyM4sfmVOB6RApaHAK0UEo7YC5GBv
X-Received: from edcp13.prod.google.com ([2002:a05:6402:43cd:b0:5d0:1dc6:40e5])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:5193:b0:5d1:22c2:6c56
 with SMTP id 4fb4d7f45d1cf-5d7d4092d1fmr554063a12.17.1734371921520; Mon, 16
 Dec 2024 09:58:41 -0800 (PST)
Date: Mon, 16 Dec 2024 17:58:02 +0000
In-Reply-To: <20241216175803.2716565-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241216175803.2716565-1-qperret@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241216175803.2716565-18-qperret@google.com>
Subject: [PATCH v3 17/18] KVM: arm64: Introduce the EL1 pKVM MMU
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: Fuad Tabba <tabba@google.com>, Vincent Donnefort <vdonnefort@google.com>, 
	Sebastian Ene <sebastianene@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Introduce a set of helper functions allowing to manipulate the pKVM
guest stage-2 page-tables from EL1 using pKVM's HVC interface.

Each helper has an exact one-to-one correspondance with the traditional
kvm_pgtable_stage2_*() functions from pgtable.c, with a strictly
matching prototype. This will ease plumbing later on in mmu.c.

These callbacks track the gfn->pfn mappings in a simple rb_tree indexed
by IPA in lieu of a page-table. This rb-tree is kept in sync with pKVM's
state and is protected by a new rwlock -- the existing mmu_lock
protection does not suffice in the map() path where the tree must be
modified while user_mem_abort() only acquires a read_lock.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_host.h    |   1 +
 arch/arm64/include/asm/kvm_pgtable.h |  23 ++--
 arch/arm64/include/asm/kvm_pkvm.h    |  23 ++++
 arch/arm64/kvm/pkvm.c                | 198 +++++++++++++++++++++++++++
 4 files changed, 236 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 1246f1d01dbf..f23f4ea9ec8b 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -85,6 +85,7 @@ void kvm_arm_vcpu_destroy(struct kvm_vcpu *vcpu);
 struct kvm_hyp_memcache {
 	phys_addr_t head;
 	unsigned long nr_pages;
+	struct pkvm_mapping *mapping; /* only used from EL1 */
 };
 
 static inline void push_hyp_memcache(struct kvm_hyp_memcache *mc,
diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 04418b5e3004..6b9d274052c7 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -412,15 +412,20 @@ static inline bool kvm_pgtable_walk_lock_held(void)
  *			be used instead of block mappings.
  */
 struct kvm_pgtable {
-	u32					ia_bits;
-	s8					start_level;
-	kvm_pteref_t				pgd;
-	struct kvm_pgtable_mm_ops		*mm_ops;
-
-	/* Stage-2 only */
-	struct kvm_s2_mmu			*mmu;
-	enum kvm_pgtable_stage2_flags		flags;
-	kvm_pgtable_force_pte_cb_t		force_pte_cb;
+	union {
+		struct rb_root					pkvm_mappings;
+		struct {
+			u32					ia_bits;
+			s8					start_level;
+			kvm_pteref_t				pgd;
+			struct kvm_pgtable_mm_ops		*mm_ops;
+
+			/* Stage-2 only */
+			enum kvm_pgtable_stage2_flags		flags;
+			kvm_pgtable_force_pte_cb_t		force_pte_cb;
+		};
+	};
+	struct kvm_s2_mmu					*mmu;
 };
 
 /**
diff --git a/arch/arm64/include/asm/kvm_pkvm.h b/arch/arm64/include/asm/kvm_pkvm.h
index cd56acd9a842..76a8b70176a6 100644
--- a/arch/arm64/include/asm/kvm_pkvm.h
+++ b/arch/arm64/include/asm/kvm_pkvm.h
@@ -137,4 +137,27 @@ static inline size_t pkvm_host_sve_state_size(void)
 			SVE_SIG_REGS_SIZE(sve_vq_from_vl(kvm_host_sve_max_vl)));
 }
 
+struct pkvm_mapping {
+	struct rb_node node;
+	u64 gfn;
+	u64 pfn;
+};
+
+int pkvm_pgtable_init(struct kvm_pgtable *pgt, struct kvm_s2_mmu *mmu, struct kvm_pgtable_mm_ops *mm_ops);
+void pkvm_pgtable_destroy(struct kvm_pgtable *pgt);
+int pkvm_pgtable_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
+			   u64 phys, enum kvm_pgtable_prot prot,
+			   void *mc, enum kvm_pgtable_walk_flags flags);
+int pkvm_pgtable_unmap(struct kvm_pgtable *pgt, u64 addr, u64 size);
+int pkvm_pgtable_wrprotect(struct kvm_pgtable *pgt, u64 addr, u64 size);
+int pkvm_pgtable_flush(struct kvm_pgtable *pgt, u64 addr, u64 size);
+bool pkvm_pgtable_test_clear_young(struct kvm_pgtable *pgt, u64 addr, u64 size, bool mkold);
+int pkvm_pgtable_relax_perms(struct kvm_pgtable *pgt, u64 addr, enum kvm_pgtable_prot prot,
+			     enum kvm_pgtable_walk_flags flags);
+void pkvm_pgtable_mkyoung(struct kvm_pgtable *pgt, u64 addr, enum kvm_pgtable_walk_flags flags);
+int pkvm_pgtable_split(struct kvm_pgtable *pgt, u64 addr, u64 size, struct kvm_mmu_memory_cache *mc);
+void pkvm_pgtable_free_unlinked(struct kvm_pgtable_mm_ops *mm_ops, void *pgtable, s8 level);
+kvm_pte_t *pkvm_pgtable_create_unlinked(struct kvm_pgtable *pgt, u64 phys, s8 level,
+					enum kvm_pgtable_prot prot, void *mc, bool force_pte);
+
 #endif	/* __ARM64_KVM_PKVM_H__ */
diff --git a/arch/arm64/kvm/pkvm.c b/arch/arm64/kvm/pkvm.c
index 85117ea8f351..9de9159afa5a 100644
--- a/arch/arm64/kvm/pkvm.c
+++ b/arch/arm64/kvm/pkvm.c
@@ -7,6 +7,7 @@
 #include <linux/init.h>
 #include <linux/kmemleak.h>
 #include <linux/kvm_host.h>
+#include <asm/kvm_mmu.h>
 #include <linux/memblock.h>
 #include <linux/mutex.h>
 #include <linux/sort.h>
@@ -268,3 +269,200 @@ static int __init finalize_pkvm(void)
 	return ret;
 }
 device_initcall_sync(finalize_pkvm);
+
+static int cmp_mappings(struct rb_node *node, const struct rb_node *parent)
+{
+	struct pkvm_mapping *a = rb_entry(node, struct pkvm_mapping, node);
+	struct pkvm_mapping *b = rb_entry(parent, struct pkvm_mapping, node);
+
+	if (a->gfn < b->gfn)
+		return -1;
+	if (a->gfn > b->gfn)
+		return 1;
+	return 0;
+}
+
+static struct rb_node *find_first_mapping_node(struct rb_root *root, u64 gfn)
+{
+	struct rb_node *node = root->rb_node, *prev = NULL;
+	struct pkvm_mapping *mapping;
+
+	while (node) {
+		mapping = rb_entry(node, struct pkvm_mapping, node);
+		if (mapping->gfn == gfn)
+			return node;
+		prev = node;
+		node = (gfn < mapping->gfn) ? node->rb_left : node->rb_right;
+	}
+
+	return prev;
+}
+
+/*
+ * __tmp is updated to rb_next(__tmp) *before* entering the body of the loop to allow freeing
+ * of __map inline.
+ */
+#define for_each_mapping_in_range_safe(__pgt, __start, __end, __map)					\
+	for (struct rb_node *__tmp = find_first_mapping_node(&(__pgt)->pkvm_mappings,			\
+							     ((__start) >> PAGE_SHIFT));		\
+	     __tmp && ({										\
+				__map = rb_entry(__tmp, struct pkvm_mapping, node);			\
+				__tmp = rb_next(__tmp);							\
+				true;									\
+		       });										\
+	    )												\
+		if (__map->gfn < ((__start) >> PAGE_SHIFT))						\
+			continue;									\
+		else if (__map->gfn >= ((__end) >> PAGE_SHIFT))						\
+			break;										\
+		else
+
+int pkvm_pgtable_init(struct kvm_pgtable *pgt, struct kvm_s2_mmu *mmu, struct kvm_pgtable_mm_ops *mm_ops)
+{
+	pgt->pkvm_mappings	= RB_ROOT;
+	pgt->mmu		= mmu;
+
+	return 0;
+}
+
+void pkvm_pgtable_destroy(struct kvm_pgtable *pgt)
+{
+	struct kvm *kvm = kvm_s2_mmu_to_kvm(pgt->mmu);
+	pkvm_handle_t handle = kvm->arch.pkvm.handle;
+	struct pkvm_mapping *mapping;
+	struct rb_node *node;
+
+	if (!handle)
+		return;
+
+	node = rb_first(&pgt->pkvm_mappings);
+	while (node) {
+		mapping = rb_entry(node, struct pkvm_mapping, node);
+		kvm_call_hyp_nvhe(__pkvm_host_unshare_guest, handle, mapping->gfn);
+		node = rb_next(node);
+		rb_erase(&mapping->node, &pgt->pkvm_mappings);
+		kfree(mapping);
+	}
+}
+
+int pkvm_pgtable_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
+			   u64 phys, enum kvm_pgtable_prot prot,
+			   void *mc, enum kvm_pgtable_walk_flags flags)
+{
+	struct kvm *kvm = kvm_s2_mmu_to_kvm(pgt->mmu);
+	struct pkvm_mapping *mapping = NULL;
+	struct kvm_hyp_memcache *cache = mc;
+	u64 gfn = addr >> PAGE_SHIFT;
+	u64 pfn = phys >> PAGE_SHIFT;
+	int ret;
+
+	if (size != PAGE_SIZE)
+		return -EINVAL;
+
+	lockdep_assert_held_write(&kvm->mmu_lock);
+	ret = kvm_call_hyp_nvhe(__pkvm_host_share_guest, pfn, gfn, prot);
+	if (ret) {
+		/* Is the gfn already mapped due to a racing vCPU? */
+		if (ret == -EPERM)
+			return -EAGAIN;
+	}
+
+	swap(mapping, cache->mapping);
+	mapping->gfn = gfn;
+	mapping->pfn = pfn;
+	WARN_ON(rb_find_add(&mapping->node, &pgt->pkvm_mappings, cmp_mappings));
+
+	return ret;
+}
+
+int pkvm_pgtable_unmap(struct kvm_pgtable *pgt, u64 addr, u64 size)
+{
+	struct kvm *kvm = kvm_s2_mmu_to_kvm(pgt->mmu);
+	pkvm_handle_t handle = kvm->arch.pkvm.handle;
+	struct pkvm_mapping *mapping;
+	int ret = 0;
+
+	lockdep_assert_held_write(&kvm->mmu_lock);
+	for_each_mapping_in_range_safe(pgt, addr, addr + size, mapping) {
+		ret = kvm_call_hyp_nvhe(__pkvm_host_unshare_guest, handle, mapping->gfn);
+		if (WARN_ON(ret))
+			break;
+		rb_erase(&mapping->node, &pgt->pkvm_mappings);
+		kfree(mapping);
+	}
+
+	return ret;
+}
+
+int pkvm_pgtable_wrprotect(struct kvm_pgtable *pgt, u64 addr, u64 size)
+{
+	struct kvm *kvm = kvm_s2_mmu_to_kvm(pgt->mmu);
+	pkvm_handle_t handle = kvm->arch.pkvm.handle;
+	struct pkvm_mapping *mapping;
+	int ret = 0;
+
+	lockdep_assert_held(&kvm->mmu_lock);
+	for_each_mapping_in_range_safe(pgt, addr, addr + size, mapping) {
+		ret = kvm_call_hyp_nvhe(__pkvm_host_wrprotect_guest, handle, mapping->gfn);
+		if (WARN_ON(ret))
+			break;
+	}
+
+	return ret;
+}
+
+int pkvm_pgtable_flush(struct kvm_pgtable *pgt, u64 addr, u64 size)
+{
+	struct kvm *kvm = kvm_s2_mmu_to_kvm(pgt->mmu);
+	struct pkvm_mapping *mapping;
+
+	lockdep_assert_held(&kvm->mmu_lock);
+	for_each_mapping_in_range_safe(pgt, addr, addr + size, mapping)
+		__clean_dcache_guest_page(pfn_to_kaddr(mapping->pfn), PAGE_SIZE);
+
+	return 0;
+}
+
+bool pkvm_pgtable_test_clear_young(struct kvm_pgtable *pgt, u64 addr, u64 size, bool mkold)
+{
+	struct kvm *kvm = kvm_s2_mmu_to_kvm(pgt->mmu);
+	pkvm_handle_t handle = kvm->arch.pkvm.handle;
+	struct pkvm_mapping *mapping;
+	bool young = false;
+
+	lockdep_assert_held(&kvm->mmu_lock);
+	for_each_mapping_in_range_safe(pgt, addr, addr + size, mapping)
+		young |= kvm_call_hyp_nvhe(__pkvm_host_test_clear_young_guest, handle, mapping->gfn,
+					   mkold);
+
+	return young;
+}
+
+int pkvm_pgtable_relax_perms(struct kvm_pgtable *pgt, u64 addr, enum kvm_pgtable_prot prot,
+			     enum kvm_pgtable_walk_flags flags)
+{
+	return kvm_call_hyp_nvhe(__pkvm_host_relax_perms_guest, addr >> PAGE_SHIFT, prot);
+}
+
+void pkvm_pgtable_mkyoung(struct kvm_pgtable *pgt, u64 addr, enum kvm_pgtable_walk_flags flags)
+{
+	WARN_ON(kvm_call_hyp_nvhe(__pkvm_host_mkyoung_guest, addr >> PAGE_SHIFT));
+}
+
+void pkvm_pgtable_free_unlinked(struct kvm_pgtable_mm_ops *mm_ops, void *pgtable, s8 level)
+{
+	WARN_ON_ONCE(1);
+}
+
+kvm_pte_t *pkvm_pgtable_create_unlinked(struct kvm_pgtable *pgt, u64 phys, s8 level,
+					enum kvm_pgtable_prot prot, void *mc, bool force_pte)
+{
+	WARN_ON_ONCE(1);
+	return NULL;
+}
+
+int pkvm_pgtable_split(struct kvm_pgtable *pgt, u64 addr, u64 size, struct kvm_mmu_memory_cache *mc)
+{
+	WARN_ON_ONCE(1);
+	return -EINVAL;
+}
-- 
2.47.1.613.gc27f4b7a9f-goog


