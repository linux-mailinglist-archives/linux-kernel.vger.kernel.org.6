Return-Path: <linux-kernel+bounces-396986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D73F19BD542
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 19:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96E16281D2D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 18:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60771F76C9;
	Tue,  5 Nov 2024 18:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="huBeBKNP"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A9C1F706F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 18:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730832234; cv=none; b=NgUhATtqW5T7BftNNfgFT/lGD3aXMtZ/BrJHb+sx2S/uJSe6NU/VhE7klW09FHTPR4wXqzzD4cOaIxreF6uhpFMG+2sIEtHAmj3b60Kh1qaNdCW5jbWbK1XP7g+gePKkKrlkvC1QoXF1bl0sTZb/p0daes4qr26zzRFs+TToOZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730832234; c=relaxed/simple;
	bh=jDUR0fdf4pyrS1yb6Btzmah8mkW5NwE4XOL0ct91PhM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=krTAD1d7IzeDG8m/JZZuup1V362+QmdUHyiiiw9PYfNN21ViDFTZVHQ35YMwIySNUbof/k5UgPfIOO3Uu9jfWvWb1knVmJ+D071MpZYp7XF7pQTofsyby2schdUCwzf6sXkkDpMzIg7Qw4jKorVLbzKVPLZBUUgHRBi2qBoMHDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=huBeBKNP; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e38fabff35so102508197b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 10:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730832232; x=1731437032; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1iBajr2tvBcG6zm00BdC5Rt5Uo5VkPVaG6KrnUwYASM=;
        b=huBeBKNPPZNkN4sodNz4itHauoF/PQnTwiysZ7d7fRxrjl+UuOI9/yvK05quanVlhS
         zMjSmsBWaPb+8algPi/2mSu2fmrxtorWiftgiOK1v/9rzni/7uBvxJcQh37WaZ32ixwf
         z3mAGyQtO+FxEj4GsrOEJJoYgUT463x/26ehbWyxq6+lfPNY9DjGFhXW4qbAM2lXRb1t
         8PPbU26VnMCzndvqducwtqPm6B1DGApdWTaTkSM0jjoL1j7EzLCF9Ebp5TebkV4iavnG
         hZg5SJg1XMeNzjvJK8Qtdv1pkwQ9a9EilDbC2g0kPqP0RUn+6vO54iofc9myyxsN8szW
         9lMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730832232; x=1731437032;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1iBajr2tvBcG6zm00BdC5Rt5Uo5VkPVaG6KrnUwYASM=;
        b=QuHn7q9MRAV1svDR42JbOZLXU7cpcIgyVQ1fAi9IFCp0jZCYE5Mav2WW+j3muQOQvz
         ea23YLuQkcMoWq9KxrPvi0gHZaYXaw+KhbkWHz5JJUizGrNCJCaeSHGiBBGX2Y7xnQaT
         3gp/LG8w/R7KZVxWuTdX7vBi9+hR5Ehey0c7ETQUa+fC+A/paVxRe8lEd/9uPdZLGohx
         +zCE9nnZR+u6CKJdF04BSufb4h4DG4jOYkKSjOH+u77b+00ESOBFHMNhHb6cKz1jNwyr
         Ep98ZlsKFM3PGD/gznfQyopan5fAqOdkKEIUJ19c0hUISyJCdbQG8oQu7VXmN6AAoshG
         idKw==
X-Forwarded-Encrypted: i=1; AJvYcCU2s7m3rlwzRQtwNPn38lVrsAuOhN0bI92mPjAzuuRnXyI8JQzg/hWHKDi1q2d4IhNCjvmUmevrBSzl/iA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtW7Z4LKrz3ECTIwNcC25ij8swtgHOquIhJy3j0+ZiG3umn/QX
	lUDJzkqtZ7LjqUohMXFSPX3/eUqwVfAI0nOnxeSaJ4URUhONfb4LRN5BvTV5j5keoPIrIIJUL6F
	Esd8Fh8KouJEM5R0joQ==
X-Google-Smtp-Source: AGHT+IEQCTYc5Qjt+z/Hb6r7J4If+mjo7L20fqiQ08ClH2OP7hcg4Onkoc+dim/QgXCvgp8uIzQynwLDxF2eMifJ
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:13d:fb22:ac12:a84b])
 (user=jthoughton job=sendgmr) by 2002:a05:690c:7091:b0:6ea:3c62:17c1 with
 SMTP id 00721157ae682-6ea3c621d20mr5673717b3.1.1730832232160; Tue, 05 Nov
 2024 10:43:52 -0800 (PST)
Date: Tue,  5 Nov 2024 18:43:31 +0000
In-Reply-To: <20241105184333.2305744-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241105184333.2305744-1-jthoughton@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241105184333.2305744-10-jthoughton@google.com>
Subject: [PATCH v8 09/11] KVM: x86/mmu: Add support for lockless walks of rmap SPTEs
From: James Houghton <jthoughton@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	James Houghton <jthoughton@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Wei Xu <weixugc@google.com>, Yu Zhao <yuzhao@google.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Sean Christopherson <seanjc@google.com>

Add a lockless version of for_each_rmap_spte(), which is pretty much the
same as the normal version, except that it doesn't BUG() the host if a
non-present SPTE is encountered.  When mmu_lock is held, it should be
impossible for a different task to zap a SPTE, _and_ zapped SPTEs must
be removed from their rmap chain prior to dropping mmu_lock.  Thus, the
normal walker BUG()s if a non-present SPTE is encountered as something is
wildly broken.

When walking rmaps without holding mmu_lock, the SPTEs pointed at by the
rmap chain can be zapped/dropped, and so a lockless walk can observe a
non-present SPTE if it runs concurrently with a different operation that
is zapping SPTEs.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: James Houghton <jthoughton@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 75 +++++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 33 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 1cdb77df0a4d..71019762a28a 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -870,7 +870,7 @@ static struct kvm_memory_slot *gfn_to_memslot_dirty_bitmap(struct kvm_vcpu *vcpu
  */
 #define KVM_RMAP_LOCKED	BIT(1)
 
-static unsigned long kvm_rmap_lock(struct kvm_rmap_head *rmap_head)
+static unsigned long __kvm_rmap_lock(struct kvm_rmap_head *rmap_head)
 {
 	unsigned long old_val, new_val;
 
@@ -914,14 +914,25 @@ static unsigned long kvm_rmap_lock(struct kvm_rmap_head *rmap_head)
 	 */
 	} while (!atomic_long_try_cmpxchg_acquire(&rmap_head->val, &old_val, new_val));
 
-	/* Return the old value, i.e. _without_ the LOCKED bit set. */
+	/*
+	 * Return the old value, i.e. _without_ the LOCKED bit set.  It's
+	 * impossible for the return value to be 0 (see above), i.e. the read-
+	 * only unlock flow can't get a false positive and fail to unlock.
+	 */
 	return old_val;
 }
 
+static unsigned long kvm_rmap_lock(struct kvm *kvm,
+				   struct kvm_rmap_head *rmap_head)
+{
+	lockdep_assert_held_write(&kvm->mmu_lock);
+	return __kvm_rmap_lock(rmap_head);
+}
+
 static void kvm_rmap_unlock(struct kvm_rmap_head *rmap_head,
 			    unsigned long new_val)
 {
-	WARN_ON_ONCE(new_val & KVM_RMAP_LOCKED);
+	KVM_MMU_WARN_ON(new_val & KVM_RMAP_LOCKED);
 	/*
 	 * Ensure that all accesses to the rmap have completed
 	 * before we actually unlock the rmap.
@@ -961,14 +972,14 @@ static void kvm_rmap_unlock_readonly(struct kvm_rmap_head *rmap_head,
 /*
  * Returns the number of pointers in the rmap chain, not counting the new one.
  */
-static int pte_list_add(struct kvm_mmu_memory_cache *cache, u64 *spte,
-			struct kvm_rmap_head *rmap_head)
+static int pte_list_add(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
+			u64 *spte, struct kvm_rmap_head *rmap_head)
 {
 	unsigned long old_val, new_val;
 	struct pte_list_desc *desc;
 	int count = 0;
 
-	old_val = kvm_rmap_lock(rmap_head);
+	old_val = kvm_rmap_lock(kvm, rmap_head);
 
 	if (!old_val) {
 		new_val = (unsigned long)spte;
@@ -1048,7 +1059,7 @@ static void pte_list_remove(struct kvm *kvm, u64 *spte,
 	unsigned long rmap_val;
 	int i;
 
-	rmap_val = kvm_rmap_lock(rmap_head);
+	rmap_val = kvm_rmap_lock(kvm, rmap_head);
 	if (KVM_BUG_ON_DATA_CORRUPTION(!rmap_val, kvm))
 		goto out;
 
@@ -1092,7 +1103,7 @@ static bool kvm_zap_all_rmap_sptes(struct kvm *kvm,
 	unsigned long rmap_val;
 	int i;
 
-	rmap_val = kvm_rmap_lock(rmap_head);
+	rmap_val = kvm_rmap_lock(kvm, rmap_head);
 	if (!rmap_val)
 		return false;
 
@@ -1184,23 +1195,18 @@ static u64 *rmap_get_first(struct kvm_rmap_head *rmap_head,
 			   struct rmap_iterator *iter)
 {
 	unsigned long rmap_val = kvm_rmap_get(rmap_head);
-	u64 *sptep;
 
 	if (!rmap_val)
 		return NULL;
 
 	if (!(rmap_val & KVM_RMAP_MANY)) {
 		iter->desc = NULL;
-		sptep = (u64 *)rmap_val;
-		goto out;
+		return (u64 *)rmap_val;
 	}
 
 	iter->desc = (struct pte_list_desc *)(rmap_val & ~KVM_RMAP_MANY);
 	iter->pos = 0;
-	sptep = iter->desc->sptes[iter->pos];
-out:
-	BUG_ON(!is_shadow_present_pte(*sptep));
-	return sptep;
+	return iter->desc->sptes[iter->pos];
 }
 
 /*
@@ -1210,14 +1216,11 @@ static u64 *rmap_get_first(struct kvm_rmap_head *rmap_head,
  */
 static u64 *rmap_get_next(struct rmap_iterator *iter)
 {
-	u64 *sptep;
-
 	if (iter->desc) {
 		if (iter->pos < PTE_LIST_EXT - 1) {
 			++iter->pos;
-			sptep = iter->desc->sptes[iter->pos];
-			if (sptep)
-				goto out;
+			if (iter->desc->sptes[iter->pos])
+				return iter->desc->sptes[iter->pos];
 		}
 
 		iter->desc = iter->desc->more;
@@ -1225,20 +1228,24 @@ static u64 *rmap_get_next(struct rmap_iterator *iter)
 		if (iter->desc) {
 			iter->pos = 0;
 			/* desc->sptes[0] cannot be NULL */
-			sptep = iter->desc->sptes[iter->pos];
-			goto out;
+			return iter->desc->sptes[iter->pos];
 		}
 	}
 
 	return NULL;
-out:
-	BUG_ON(!is_shadow_present_pte(*sptep));
-	return sptep;
 }
 
-#define for_each_rmap_spte(_rmap_head_, _iter_, _spte_)			\
-	for (_spte_ = rmap_get_first(_rmap_head_, _iter_);		\
-	     _spte_; _spte_ = rmap_get_next(_iter_))
+#define __for_each_rmap_spte(_rmap_head_, _iter_, _sptep_)	\
+	for (_sptep_ = rmap_get_first(_rmap_head_, _iter_);	\
+	     _sptep_; _sptep_ = rmap_get_next(_iter_))
+
+#define for_each_rmap_spte(_rmap_head_, _iter_, _sptep_)			\
+	__for_each_rmap_spte(_rmap_head_, _iter_, _sptep_)			\
+		if (!WARN_ON_ONCE(!is_shadow_present_pte(*(_sptep_))))	\
+
+#define for_each_rmap_spte_lockless(_rmap_head_, _iter_, _sptep_, _spte_)	\
+	__for_each_rmap_spte(_rmap_head_, _iter_, _sptep_)			\
+		if (is_shadow_present_pte(_spte_ = mmu_spte_get_lockless(sptep)))
 
 static void drop_spte(struct kvm *kvm, u64 *sptep)
 {
@@ -1324,12 +1331,13 @@ static bool __rmap_clear_dirty(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
 	struct rmap_iterator iter;
 	bool flush = false;
 
-	for_each_rmap_spte(rmap_head, &iter, sptep)
+	for_each_rmap_spte(rmap_head, &iter, sptep) {
 		if (spte_ad_need_write_protect(*sptep))
 			flush |= test_and_clear_bit(PT_WRITABLE_SHIFT,
 						    (unsigned long *)sptep);
 		else
 			flush |= spte_clear_dirty(sptep);
+	}
 
 	return flush;
 }
@@ -1650,7 +1658,7 @@ static void __rmap_add(struct kvm *kvm,
 	kvm_update_page_stats(kvm, sp->role.level, 1);
 
 	rmap_head = gfn_to_rmap(gfn, sp->role.level, slot);
-	rmap_count = pte_list_add(cache, spte, rmap_head);
+	rmap_count = pte_list_add(kvm, cache, spte, rmap_head);
 
 	if (rmap_count > kvm->stat.max_mmu_rmap_size)
 		kvm->stat.max_mmu_rmap_size = rmap_count;
@@ -1796,13 +1804,14 @@ static unsigned kvm_page_table_hashfn(gfn_t gfn)
 	return hash_64(gfn, KVM_MMU_HASH_SHIFT);
 }
 
-static void mmu_page_add_parent_pte(struct kvm_mmu_memory_cache *cache,
+static void mmu_page_add_parent_pte(struct kvm *kvm,
+				    struct kvm_mmu_memory_cache *cache,
 				    struct kvm_mmu_page *sp, u64 *parent_pte)
 {
 	if (!parent_pte)
 		return;
 
-	pte_list_add(cache, parent_pte, &sp->parent_ptes);
+	pte_list_add(kvm, cache, parent_pte, &sp->parent_ptes);
 }
 
 static void mmu_page_remove_parent_pte(struct kvm *kvm, struct kvm_mmu_page *sp,
@@ -2492,7 +2501,7 @@ static void __link_shadow_page(struct kvm *kvm,
 
 	mmu_spte_set(sptep, spte);
 
-	mmu_page_add_parent_pte(cache, sp, sptep);
+	mmu_page_add_parent_pte(kvm, cache, sp, sptep);
 
 	/*
 	 * The non-direct sub-pagetable must be updated before linking.  For
-- 
2.47.0.199.ga7371fff76-goog


