Return-Path: <linux-kernel+bounces-429261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2609E198A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 223ED162FCC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435501E230F;
	Tue,  3 Dec 2024 10:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XEhFgN8K"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594321E5712
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 10:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733222297; cv=none; b=GojEPCszvqjsIl88lYlp7oV4ZhbaRGmit2gl0kjJIFpZDUuqeKspDVI2jcG4HFPOJoB9JtZqq44jVtqJ+geYX/pTE5AhKXp3ad2S0H0NUz/gYqENTpFSGJjihKSeKIAeFzXgHHVg4q1NSrZMr7nc5WeqGhLzUDo/OHGuqN3oqNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733222297; c=relaxed/simple;
	bh=F/yNQTmFUQEBYRLPGTFATVfLxosAW3eQh4YzmLblsa0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tsIQlaHD+eiZUTJ/8WHN1GPfGnSP1a4UFZZLDVTyyYWI+8q+OnB8XpNTzmHQnljOBMirGfGf4VDp7g1GvbnxRDtGG4ufFMUHcilFDsjkpk3WY32vB55IpyE8/xdTH9GWdrdp+uOsEoUyMB6JUxHIt42KjgRWlY2QyHzjoZ2F+MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XEhFgN8K; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5d0d7b5c86cso716153a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 02:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733222294; x=1733827094; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CyANWLQ0Nrz1zThfCRFFyoV42B/jdyXda0aXqdJ1iuE=;
        b=XEhFgN8KjpguZ5x40YYvM+fNpSbtxS5JCQgczbvtffiKDuxM2aBD0N+EL61pPcCtxJ
         QHLBSD29yVEK4ATFUsVwACCjwXMJBq7exaUt61yjR5k/y2xB8PBeD+6uOzQztZFnPRiS
         XBd1XfayCSkgy4UlPULnB/yLIfokoHDIfhQ8hMxrlwklmu47P7piBaGY9WIdzZDknaip
         2yMV0URicXcCs7Rt1tGlw26v2Ewi4M7Wv/bY5ANRgL+MDBsn/ECMGOoK4ztABwlNLk9G
         Ji1udJVJ2Hwx4gXZKtMDcEFBwd/RlgPi7z1fxCKlRT6ZcSu8z0QwrCMo2i9YU33ZN5qq
         MjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733222294; x=1733827094;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CyANWLQ0Nrz1zThfCRFFyoV42B/jdyXda0aXqdJ1iuE=;
        b=UjxVCQnRyvGhRpTdeImdxwJuaIpkjXrypuq/r6HCYF6p72BpQPrbzcuAyDwfJGTVQR
         ojAqHOmJmnt5iPOQ78nWZpsOdgmcTIXYKOgAzcCiAazKoD1TVXGuEiBE9eQE9p4n29v1
         DkgI0dibvFUAuH5ZOtCE0DeflpEbXs8+HVjFhSZnbh98LX12C1plrqE33YjkInnHo57I
         82lJIxnLwTE/uymSK/JJxPN2LmVQYGfh9PfUYxqFti73FMHT+2Vrcpwd05bOcN5/d282
         8eUB2y0UmX6KQ7PzRdXMxEZYOoOXll4VJVEasrqlFSEFkzQP3Zq69wy2kVTzBFgUjSSp
         YqAA==
X-Forwarded-Encrypted: i=1; AJvYcCXuxsPSnGcUR9cy7NTwp7OUVwOtfL5DUm2coq/3GCkpJOh3S/SBBwz1kuGwIO0D35JQRATnoCK0RKKieoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHfsuUAdRY8Nyli8OEeorT6Wz2etG/fLQxwhCe9NawTLDKsaZG
	9cM5mV4Sn04LanLQ1GJnbzia1bXmIjtNTFqA5xFLjp0Cn5o7YEfEqg8asa2l7XunKKWKGhCs87d
	tGEtaJA==
X-Google-Smtp-Source: AGHT+IHFD7wNw7SnPt9sR/c1Yw3V2XviIZN7nLFcTVtzbHAE65P8Ps78iKqgqLfIRYUjjGhKRJ3w/oQiHMFW
X-Received: from edfa42.prod.google.com ([2002:a50:9ead:0:b0:5cf:aae5:54ce])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:3506:b0:5d0:9054:b119
 with SMTP id 4fb4d7f45d1cf-5d10cb80133mr1667289a12.21.1733222293753; Tue, 03
 Dec 2024 02:38:13 -0800 (PST)
Date: Tue,  3 Dec 2024 10:37:34 +0000
In-Reply-To: <20241203103735.2267589-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241203103735.2267589-1-qperret@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241203103735.2267589-18-qperret@google.com>
Subject: [PATCH v2 17/18] KVM: arm64: Introduce the EL1 pKVM MMU
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

The embedded union inside struct kvm_pgtable is arguably a bit horrible
currently... I considered making the pgt argument to all kvm_pgtable_*()
functions an opaque void * ptr, and moving the definition of
struct kvm_pgtable to pgtable.c and the pkvm version into pkvm.c. Given
that the allocation of that data-structure is done by the caller, that
means we'd need to expose kvm_pgtable_get_pgd_size() or something that
each MMU (pgtable.c and pkvm.c) would have to implement and things like
that. But that felt like a bigger surgery, so I went with the simpler
option. Thoughts welcome :-)

Similarly, happy to drop the mappings_lock if we want to teach
user_mem_abort() about taking a write lock on the mmu_lock in the pKVM
case, but again this implementation is the least invasive into normal
KVM so that felt like a reasonable starting point.
---
 arch/arm64/include/asm/kvm_host.h    |   1 +
 arch/arm64/include/asm/kvm_pgtable.h |  27 ++--
 arch/arm64/include/asm/kvm_pkvm.h    |  28 ++++
 arch/arm64/kvm/pkvm.c                | 195 +++++++++++++++++++++++++++
 4 files changed, 242 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index f75988e3515b..05936b57a3a4 100644
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
index 04418b5e3004..d24d18874015 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -412,15 +412,24 @@ static inline bool kvm_pgtable_walk_lock_held(void)
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
+		struct {
+			u32					ia_bits;
+			s8					start_level;
+			kvm_pteref_t				pgd;
+			struct kvm_pgtable_mm_ops		*mm_ops;
+
+			/* Stage-2 only */
+			struct kvm_s2_mmu			*mmu;
+			enum kvm_pgtable_stage2_flags		flags;
+			kvm_pgtable_force_pte_cb_t		force_pte_cb;
+		};
+		struct {
+			struct kvm				*kvm;
+			struct rb_root				mappings;
+			rwlock_t				mappings_lock;
+		} pkvm;
+	};
 };
 
 /**
diff --git a/arch/arm64/include/asm/kvm_pkvm.h b/arch/arm64/include/asm/kvm_pkvm.h
index cd56acd9a842..84211d5daf87 100644
--- a/arch/arm64/include/asm/kvm_pkvm.h
+++ b/arch/arm64/include/asm/kvm_pkvm.h
@@ -11,6 +11,12 @@
 #include <linux/scatterlist.h>
 #include <asm/kvm_pgtable.h>
 
+struct pkvm_mapping {
+	u64 gfn;
+	u64 pfn;
+	struct rb_node node;
+};
+
 /* Maximum number of VMs that can co-exist under pKVM. */
 #define KVM_MAX_PVMS 255
 
@@ -137,4 +143,26 @@ static inline size_t pkvm_host_sve_state_size(void)
 			SVE_SIG_REGS_SIZE(sve_vq_from_vl(kvm_host_sve_max_vl)));
 }
 
+static inline pkvm_handle_t pkvm_pgt_to_handle(struct kvm_pgtable *pgt)
+{
+	return pgt->pkvm.kvm->arch.pkvm.handle;
+}
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
index 85117ea8f351..9c648a510671 100644
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
@@ -268,3 +269,197 @@ static int __init finalize_pkvm(void)
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
+#define for_each_mapping_in_range(pgt, start_ipa, end_ipa, mapping, tmp)				\
+	for (tmp = find_first_mapping_node(&pgt->pkvm.mappings, ((start_ipa) >> PAGE_SHIFT));		\
+	     tmp && ({ mapping = rb_entry(tmp, struct pkvm_mapping, node); tmp = rb_next(tmp); 1; });)	\
+		if (mapping->gfn < ((start_ipa) >> PAGE_SHIFT))						\
+			continue;									\
+		else if (mapping->gfn >= ((end_ipa) >> PAGE_SHIFT))					\
+			break;										\
+		else
+
+int pkvm_pgtable_init(struct kvm_pgtable *pgt, struct kvm_s2_mmu *mmu, struct kvm_pgtable_mm_ops *mm_ops)
+{
+	pgt->pkvm.kvm		= kvm_s2_mmu_to_kvm(mmu);
+	pgt->pkvm.mappings	= RB_ROOT;
+	rwlock_init(&pgt->pkvm.mappings_lock);
+
+	return 0;
+}
+
+void pkvm_pgtable_destroy(struct kvm_pgtable *pgt)
+{
+	pkvm_handle_t handle = pkvm_pgt_to_handle(pgt);
+	struct pkvm_mapping *mapping;
+	struct rb_node *node;
+
+	if (!handle)
+		return;
+
+	node = rb_first(&pgt->pkvm.mappings);
+	while (node) {
+		mapping = rb_entry(node, struct pkvm_mapping, node);
+		kvm_call_hyp_nvhe(__pkvm_host_unshare_guest, handle, mapping->gfn);
+		node = rb_next(node);
+		rb_erase(&mapping->node, &pgt->pkvm.mappings);
+		kfree(mapping);
+	}
+}
+
+int pkvm_pgtable_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
+			   u64 phys, enum kvm_pgtable_prot prot,
+			   void *mc, enum kvm_pgtable_walk_flags flags)
+{
+	struct pkvm_mapping *mapping = NULL;
+	struct kvm_hyp_memcache *cache = mc;
+	u64 gfn = addr >> PAGE_SHIFT;
+	u64 pfn = phys >> PAGE_SHIFT;
+	int ret;
+
+	if (size != PAGE_SIZE)
+		return -EINVAL;
+
+	write_lock(&pgt->pkvm.mappings_lock);
+	ret = kvm_call_hyp_nvhe(__pkvm_host_share_guest, pfn, gfn, prot);
+	if (ret) {
+		/* Is the gfn already mapped due to a racing vCPU? */
+		if (ret == -EPERM)
+			ret = -EAGAIN;
+		goto unlock;
+	}
+
+	swap(mapping, cache->mapping);
+	mapping->gfn = gfn;
+	mapping->pfn = pfn;
+	WARN_ON(rb_find_add(&mapping->node, &pgt->pkvm.mappings, cmp_mappings));
+unlock:
+	write_unlock(&pgt->pkvm.mappings_lock);
+
+	return ret;
+}
+
+int pkvm_pgtable_unmap(struct kvm_pgtable *pgt, u64 addr, u64 size)
+{
+	pkvm_handle_t handle = pkvm_pgt_to_handle(pgt);
+	struct pkvm_mapping *mapping;
+	struct rb_node *tmp;
+	int ret = 0;
+
+	write_lock(&pgt->pkvm.mappings_lock);
+	for_each_mapping_in_range(pgt, addr, addr + size, mapping, tmp) {
+		ret = kvm_call_hyp_nvhe(__pkvm_host_unshare_guest, handle, mapping->gfn);
+		if (WARN_ON(ret))
+			break;
+
+		rb_erase(&mapping->node, &pgt->pkvm.mappings);
+		kfree(mapping);
+	}
+	write_unlock(&pgt->pkvm.mappings_lock);
+
+	return ret;
+}
+
+int pkvm_pgtable_wrprotect(struct kvm_pgtable *pgt, u64 addr, u64 size)
+{
+	pkvm_handle_t handle = pkvm_pgt_to_handle(pgt);
+	struct pkvm_mapping *mapping;
+	struct rb_node *tmp;
+	int ret = 0;
+
+	read_lock(&pgt->pkvm.mappings_lock);
+	for_each_mapping_in_range(pgt, addr, addr + size, mapping, tmp) {
+		ret = kvm_call_hyp_nvhe(__pkvm_host_wrprotect_guest, handle, mapping->gfn);
+		if (WARN_ON(ret))
+			break;
+	}
+	read_unlock(&pgt->pkvm.mappings_lock);
+
+	return ret;
+}
+
+int pkvm_pgtable_flush(struct kvm_pgtable *pgt, u64 addr, u64 size)
+{
+	struct pkvm_mapping *mapping;
+	struct rb_node *tmp;
+
+	read_lock(&pgt->pkvm.mappings_lock);
+	for_each_mapping_in_range(pgt, addr, addr + size, mapping, tmp)
+		__clean_dcache_guest_page(pfn_to_kaddr(mapping->pfn), PAGE_SIZE);
+	read_unlock(&pgt->pkvm.mappings_lock);
+
+	return 0;
+}
+
+bool pkvm_pgtable_test_clear_young(struct kvm_pgtable *pgt, u64 addr, u64 size, bool mkold)
+{
+	pkvm_handle_t handle = pkvm_pgt_to_handle(pgt);
+	struct pkvm_mapping *mapping;
+	struct rb_node *tmp;
+	bool young = false;
+
+	read_lock(&pgt->pkvm.mappings_lock);
+	for_each_mapping_in_range(pgt, addr, addr + size, mapping, tmp)
+		young |= kvm_call_hyp_nvhe(__pkvm_host_test_clear_young_guest, handle, mapping->gfn,
+					   mkold);
+	read_unlock(&pgt->pkvm.mappings_lock);
+
+	return young;
+}
+
+int pkvm_pgtable_relax_perms(struct kvm_pgtable *pgt, u64 addr, enum kvm_pgtable_prot prot,
+			     enum kvm_pgtable_walk_flags flags)
+{
+	return kvm_call_hyp_nvhe(__pkvm_host_relax_guest_perms, addr >> PAGE_SHIFT, prot);
+}
+
+void pkvm_pgtable_mkyoung(struct kvm_pgtable *pgt, u64 addr, enum kvm_pgtable_walk_flags flags)
+{
+	WARN_ON(kvm_call_hyp_nvhe(__pkvm_host_mkyoung_guest, addr >> PAGE_SHIFT));
+}
+
+void pkvm_pgtable_free_unlinked(struct kvm_pgtable_mm_ops *mm_ops, void *pgtable, s8 level)
+{
+	WARN_ON(1);
+}
+
+kvm_pte_t *pkvm_pgtable_create_unlinked(struct kvm_pgtable *pgt, u64 phys, s8 level,
+					enum kvm_pgtable_prot prot, void *mc, bool force_pte)
+{
+	WARN_ON(1);
+	return NULL;
+}
+
+int pkvm_pgtable_split(struct kvm_pgtable *pgt, u64 addr, u64 size, struct kvm_mmu_memory_cache *mc)
+{
+	WARN_ON(1);
+	return -EINVAL;
+}
-- 
2.47.0.338.g60cca15819-goog


