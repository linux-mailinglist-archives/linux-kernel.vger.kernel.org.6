Return-Path: <linux-kernel+bounces-339783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F87986A7C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 03:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68A841C21B48
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 01:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4D3173357;
	Thu, 26 Sep 2024 01:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1NHxNoe7"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC50117ADFF
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 01:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727314522; cv=none; b=SO+G2G8/q6sdPA9cH2UnIYAlSt8g7A7KkpXJar3kNTEeUo0UFXHd8f3i8cdDeS6YuC/DWtVI9RGct8dI9GYww9O+bmpGUX0zWYcQiN5BXvsytOmpX+bBe+YlTXJfklO9zrH9qYyBtx366GDSqxf+8hKq6GO3k97dCJF0/9uhHDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727314522; c=relaxed/simple;
	bh=YSy/E4lmu4BnYYPKkFBN9wiRlocJQas8/7ToGEk8u2o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MnpkdV8JWeJA84EsOJOdIGEUlKXdekeUVAFZqlLx4eW0sw0EoSEYyC5qAhBecsx9CFpmR1Yz8efL1v4QrwdQg2xLVokebvJ++5wTrGJddMSWFbAAbGGaQKtqAQQiw7pDXTo+R9J+EfpQPY0efJM4ieIPuIvv2KBlAm5JXHcb2/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1NHxNoe7; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6dbbeee08f0so23490087b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 18:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727314520; x=1727919320; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E9ikx7qvh9LLa0/zOZpb6K1KXC0ViYbLtiviLVHMlqE=;
        b=1NHxNoe7nF/p3+NCSIYn2UiXNf5lrc/OzXSoXFoxy/Hwvd1DdU0idCvNhHJogjHcHI
         d8YR8K8uheaU/7HuNMMGVr8AwHc7an+XHiEAkDki432BxDHKiDSr06XC9Tc8MELWgKQT
         1+k1xtowZ0rTHc5vGUowQ6UwhLaY17+uIc9oXzGtvkR0UGi/llSIEl8lMAIHHRvZfhzN
         qti8wrPA2RLziqV9x2jjUqHSK8i2HBG+PXpyfuJUOH8YwoU1VpEeZP94+ynAlQgPpMVd
         riRRgfIN+TaX0bdrzZdk6ygdpn6vLtGJ5uWEpW4z4/W59YvDKX2tQcXyywj5VTPU3lIf
         kSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727314520; x=1727919320;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E9ikx7qvh9LLa0/zOZpb6K1KXC0ViYbLtiviLVHMlqE=;
        b=nRhf4T+/FcGStV1bcVR6T00dC9fXgsBsONmtwMMDMBc/BN1Ui9cbBSueS1i/0xGyxU
         f1QAvvl86vJkJB5SKCOm2bX8ZKHV6ZAm6I7BZKS5xORhKmcjd/2wPK5OF5HanxDsO7Eu
         bXbjWuYPFi1mqHvSKIxW9FNzWk4puW2lcH4DZ91T84J5uzxFyP8z8y2ws+uJ70GhIsHx
         QsX9DrBD1S/Ful7ur3AjgmA/JXeY/vCutLkVyPiXNS6TKeh9/q4msuvoD6q+pPMNIqIS
         wX2mebvCjGPxNSPswpkCaQllhnB76/LvaaN/9tjOAb/2DnApTo/x4sQCzZH0uCBQVdr2
         /h1w==
X-Forwarded-Encrypted: i=1; AJvYcCXJpSPzSEf9iy/Tfl+P7RKHasL0bhMeyUZYKoVxjqAbnIQyQ4dabOgvksvcB6j1nRu/SwY/oamKaNAw8t0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3sJ7bkTG+ewFOoVk1EeGwZgEexIkhs09kqQTHXR2C+qRzdymj
	mInvvio8rhlhpK4FVaTjobkWik2KlKSsEZcdWb6pB3ckLHEjMEfvnHd4Tgttd028RFJJSoqdESN
	FBtqO5n81BeUOeHAsew==
X-Google-Smtp-Source: AGHT+IH0FiQjxyLo+JfGazQOCkHrPRgPRywE06mMVfat9iBHnlYATt5rsXjVLhFjPfx7L1BClqPZPXX/no7MzpGQ
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:13d:fb22:ac12:a84b])
 (user=jthoughton job=sendgmr) by 2002:a05:690c:2b92:b0:6dd:bb6e:ec89 with
 SMTP id 00721157ae682-6e22efd31b8mr137077b3.2.1727314519545; Wed, 25 Sep 2024
 18:35:19 -0700 (PDT)
Date: Thu, 26 Sep 2024 01:34:52 +0000
In-Reply-To: <20240926013506.860253-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926013506.860253-1-jthoughton@google.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240926013506.860253-5-jthoughton@google.com>
Subject: [PATCH v7 04/18] KVM: x86/mmu: Relax locking for kvm_test_age_gfn and kvm_age_gfn
From: James Houghton <jthoughton@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, James Houghton <jthoughton@google.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Wei Xu <weixugc@google.com>, Yu Zhao <yuzhao@google.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Walk the TDP MMU in an RCU read-side critical section without holding
mmu_lock when harvesting and potentially updating age information on
sptes. This requires a way to do RCU-safe walking of the tdp_mmu_roots;
do this with a new macro. The PTE modifications are now done atomically,
and kvm_tdp_mmu_spte_need_atomic_write() has been updated to account for
the fact that kvm_age_gfn can now lockless update the accessed bit and
the W/R/X bits).

If the cmpxchg for marking the spte for access tracking fails, leave it
as is and treat it as if it were young, as if the spte is being actively
modified, it is most likely young.

Harvesting age information from the shadow MMU is still done while
holding the MMU write lock.

Suggested-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: James Houghton <jthoughton@google.com>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/Kconfig            |  1 +
 arch/x86/kvm/mmu/mmu.c          | 10 ++++--
 arch/x86/kvm/mmu/tdp_iter.h     | 14 ++++----
 arch/x86/kvm/mmu/tdp_mmu.c      | 57 ++++++++++++++++++++++++---------
 5 files changed, 58 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 46e0a466d7fb..adc814bad4bb 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1454,6 +1454,7 @@ struct kvm_arch {
 	 * tdp_mmu_page set.
 	 *
 	 * For reads, this list is protected by:
+	 *	RCU alone or
 	 *	the MMU lock in read mode + RCU or
 	 *	the MMU lock in write mode
 	 *
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index faed96e33e38..3928e9b2d84a 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -23,6 +23,7 @@ config KVM
 	depends on X86_LOCAL_APIC
 	select KVM_COMMON
 	select KVM_GENERIC_MMU_NOTIFIER
+	select KVM_MMU_NOTIFIER_YOUNG_LOCKLESS
 	select HAVE_KVM_IRQCHIP
 	select HAVE_KVM_PFNCACHE
 	select HAVE_KVM_DIRTY_RING_TSO
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 0d94354bb2f8..355a66c26517 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1649,8 +1649,11 @@ bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 {
 	bool young = false;
 
-	if (kvm_memslots_have_rmaps(kvm))
+	if (kvm_memslots_have_rmaps(kvm)) {
+		write_lock(&kvm->mmu_lock);
 		young = kvm_rmap_age_gfn_range(kvm, range, false);
+		write_unlock(&kvm->mmu_lock);
+	}
 
 	if (tdp_mmu_enabled)
 		young |= kvm_tdp_mmu_age_gfn_range(kvm, range);
@@ -1662,8 +1665,11 @@ bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 {
 	bool young = false;
 
-	if (kvm_memslots_have_rmaps(kvm))
+	if (kvm_memslots_have_rmaps(kvm)) {
+		write_lock(&kvm->mmu_lock);
 		young = kvm_rmap_age_gfn_range(kvm, range, true);
+		write_unlock(&kvm->mmu_lock);
+	}
 
 	if (tdp_mmu_enabled)
 		young |= kvm_tdp_mmu_test_age_gfn(kvm, range);
diff --git a/arch/x86/kvm/mmu/tdp_iter.h b/arch/x86/kvm/mmu/tdp_iter.h
index ec171568487c..510936a8455a 100644
--- a/arch/x86/kvm/mmu/tdp_iter.h
+++ b/arch/x86/kvm/mmu/tdp_iter.h
@@ -39,10 +39,11 @@ static inline void __kvm_tdp_mmu_write_spte(tdp_ptep_t sptep, u64 new_spte)
 }
 
 /*
- * SPTEs must be modified atomically if they are shadow-present, leaf
- * SPTEs, and have volatile bits, i.e. has bits that can be set outside
- * of mmu_lock.  The Writable bit can be set by KVM's fast page fault
- * handler, and Accessed and Dirty bits can be set by the CPU.
+ * SPTEs must be modified atomically if they have bits that can be set outside
+ * of the mmu_lock. This can happen for any shadow-present leaf SPTEs, as the
+ * Writable bit can be set by KVM's fast page fault handler, the Accessed and
+ * Dirty bits can be set by the CPU, and the Accessed and R/X bits can be
+ * cleared by age_gfn_range.
  *
  * Note, non-leaf SPTEs do have Accessed bits and those bits are
  * technically volatile, but KVM doesn't consume the Accessed bit of
@@ -53,8 +54,7 @@ static inline void __kvm_tdp_mmu_write_spte(tdp_ptep_t sptep, u64 new_spte)
 static inline bool kvm_tdp_mmu_spte_need_atomic_write(u64 old_spte, int level)
 {
 	return is_shadow_present_pte(old_spte) &&
-	       is_last_spte(old_spte, level) &&
-	       spte_has_volatile_bits(old_spte);
+	       is_last_spte(old_spte, level);
 }
 
 static inline u64 kvm_tdp_mmu_write_spte(tdp_ptep_t sptep, u64 old_spte,
@@ -70,8 +70,6 @@ static inline u64 kvm_tdp_mmu_write_spte(tdp_ptep_t sptep, u64 old_spte,
 static inline u64 tdp_mmu_clear_spte_bits(tdp_ptep_t sptep, u64 old_spte,
 					  u64 mask, int level)
 {
-	atomic64_t *sptep_atomic;
-
 	if (kvm_tdp_mmu_spte_need_atomic_write(old_spte, level))
 		return tdp_mmu_clear_spte_bits_atomic(sptep, mask);
 
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 3b996c1fdaab..4477201c2d53 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -178,6 +178,15 @@ static struct kvm_mmu_page *tdp_mmu_next_root(struct kvm *kvm,
 		     ((_only_valid) && (_root)->role.invalid))) {		\
 		} else
 
+/*
+ * Iterate over all TDP MMU roots in an RCU read-side critical section.
+ */
+#define for_each_valid_tdp_mmu_root_rcu(_kvm, _root, _as_id)			\
+	list_for_each_entry_rcu(_root, &_kvm->arch.tdp_mmu_roots, link)		\
+		if ((_as_id >= 0 && kvm_mmu_page_as_id(_root) != _as_id) ||	\
+		    (_root)->role.invalid) {					\
+		} else
+
 #define for_each_tdp_mmu_root(_kvm, _root, _as_id)			\
 	__for_each_tdp_mmu_root(_kvm, _root, _as_id, false)
 
@@ -1222,6 +1231,26 @@ static __always_inline bool kvm_tdp_mmu_handle_gfn(struct kvm *kvm,
 	return ret;
 }
 
+static __always_inline bool kvm_tdp_mmu_handle_gfn_lockless(struct kvm *kvm,
+							    struct kvm_gfn_range *range,
+							    tdp_handler_t handler)
+{
+	struct kvm_mmu_page *root;
+	struct tdp_iter iter;
+	bool ret = false;
+
+	rcu_read_lock();
+
+	for_each_valid_tdp_mmu_root_rcu(kvm, root, range->slot->as_id) {
+		tdp_root_for_each_leaf_pte(iter, root, range->start, range->end)
+			ret |= handler(kvm, &iter, range);
+	}
+
+	rcu_read_unlock();
+
+	return ret;
+}
+
 /*
  * Mark the SPTEs range of GFNs [start, end) unaccessed and return non-zero
  * if any of the GFNs in the range have been accessed.
@@ -1240,23 +1269,21 @@ static bool age_gfn_range(struct kvm *kvm, struct tdp_iter *iter,
 		return false;
 
 	if (spte_ad_enabled(iter->old_spte)) {
-		iter->old_spte = tdp_mmu_clear_spte_bits(iter->sptep,
-							 iter->old_spte,
-							 shadow_accessed_mask,
-							 iter->level);
+		iter->old_spte = tdp_mmu_clear_spte_bits_atomic(iter->sptep,
+						shadow_accessed_mask);
 		new_spte = iter->old_spte & ~shadow_accessed_mask;
 	} else {
-		/*
-		 * Capture the dirty status of the page, so that it doesn't get
-		 * lost when the SPTE is marked for access tracking.
-		 */
+		new_spte = mark_spte_for_access_track(iter->old_spte);
+		if (__tdp_mmu_set_spte_atomic(iter, new_spte))
+			/*
+			 * The cmpxchg failed. Even if we had cleared the
+			 * Accessed bit, it likely would have been set again,
+			 * so this spte is probably young.
+			 */
+			return true;
+
 		if (is_writable_pte(iter->old_spte))
 			kvm_set_pfn_dirty(spte_to_pfn(iter->old_spte));
-
-		new_spte = mark_spte_for_access_track(iter->old_spte);
-		iter->old_spte = kvm_tdp_mmu_write_spte(iter->sptep,
-							iter->old_spte, new_spte,
-							iter->level);
 	}
 
 	trace_kvm_tdp_mmu_spte_changed(iter->as_id, iter->gfn, iter->level,
@@ -1266,7 +1293,7 @@ static bool age_gfn_range(struct kvm *kvm, struct tdp_iter *iter,
 
 bool kvm_tdp_mmu_age_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
 {
-	return kvm_tdp_mmu_handle_gfn(kvm, range, age_gfn_range);
+	return kvm_tdp_mmu_handle_gfn_lockless(kvm, range, age_gfn_range);
 }
 
 static bool test_age_gfn(struct kvm *kvm, struct tdp_iter *iter,
@@ -1277,7 +1304,7 @@ static bool test_age_gfn(struct kvm *kvm, struct tdp_iter *iter,
 
 bool kvm_tdp_mmu_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 {
-	return kvm_tdp_mmu_handle_gfn(kvm, range, test_age_gfn);
+	return kvm_tdp_mmu_handle_gfn_lockless(kvm, range, test_age_gfn);
 }
 
 /*
-- 
2.46.0.792.g87dc391469-goog


