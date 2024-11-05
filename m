Return-Path: <linux-kernel+bounces-396982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC04D9BD539
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 19:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D7CA1F2679E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 18:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941321F666C;
	Tue,  5 Nov 2024 18:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kHW6y1S0"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACED1F131B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 18:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730832230; cv=none; b=bwMh6Kp8lUwLCpsTTfp/IaJUt49vWpCpKHqu4wKJfiGxV4InT8UTiX5WwehcjZ1P5AOeOl4RGGIQ7xKqSeMDnUQ3VsiC425ZbPJcHiIQdann5IqUa5febwvz4tcD6AvJDQk/d21qbzt7z61Odw2QTGwWJQd5UDr1m+zbOOTRrI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730832230; c=relaxed/simple;
	bh=rGtastp5MUVjDZjrcFpzQhgzR3WKxIrGkFIwnsizN4o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XeQfMaG1HDImICTXCG6yAU21ZNzSXN+T+XJnT6rs8g0A9LXzIM17F0TzyfceL6OalK/T1595URWJ+hh9IRk/3xNjJTvYkaLZdqkQR6IL6Wtd9ttaP0SUHelAuD1BgWvwsQMQUJVj6BGDZKgSiYNRG2KLJv8kQuqk3IhgwkdrAB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kHW6y1S0; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e5bdb9244eso93984167b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 10:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730832227; x=1731437027; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q/zpmmxBLNRk9p52ALn0nSRYK7DaOpkC3JwFDj1wmZI=;
        b=kHW6y1S0/yUuIDu8VsV94vgNPGy075vDWiOJPb3qJon6Y9ZHyCStnfKOjvc0THAYJ7
         cs8bmpUD6on66Gt3xeSQ2lIbhVyD9N7q/By9nDZif7ff+4VFV8v6rP8T3S0dZrMo7hg0
         FeJ24cxXlKP7/KwL4UvMrqDEyJmRSJLBMxZy4kEoqpSNmesDVfQJbjdqId+5bfP1BRJ3
         YyJY/Dg71qm5oFyYnoudWJ88hys9avuFRa5kPpYOV9VRSCFvapOndl1LAsfhfbtsgLT1
         c/BZ8VTbfAyBNBXb8GKwxhZ3gsJ0U2jEk8lwTZohQAFPZxnQ1w/qqpoU0d9TYTkTEPLN
         1qfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730832227; x=1731437027;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/zpmmxBLNRk9p52ALn0nSRYK7DaOpkC3JwFDj1wmZI=;
        b=U6a/DH6V9xfEMT0I0yTbxyKVvEpe4EIAJkPTvQ7i1ET07tKWRmkFj56cC9JF98OPJW
         uV92tpDjYBwH0yFF7dCKv1Qq+ETTPJgorFtcM1Bk5PzG1AKTvk9IyBKc4qT9PDbzpO2j
         B/gsFEIF56Jv0h/uB1Omr14ZXyN2E4cjvhQhLbyvwTrQNs287pC1EnsNeQh3M1UVVyvD
         YqiPRdIam5Dt0FDR3tGUJzsc5DpL9FxMg4jzun8C7wEReVT7SvGii9PhBHm8Zpti6hD3
         xsn/KTwqE1yNrPuUn4IaUP0uYrOwFvDgOfQczkoHNVfUHJLZNdv1TYQgbK/4w9HE3KlB
         vMlw==
X-Forwarded-Encrypted: i=1; AJvYcCXn8sVpZLe2thQq1y6YnzW7HH5SKmZSbl8pZGLHYsN6OM4HfU4Jn7Hua+kB45Qwfr/hWGwY82Q0BilJUn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRrxOD1b4oZqSci/WW7wJB7OYx+PHNCdvfiqypK97TkvGCtTtC
	EAGQP6hgJ0K5q/xgKg4rrGaqwbDbItJOi8XQFXSn8eWk2tkbyHMxl6aDU2psGZv0hNLQx9AkTsk
	s61EDf8Zz8+MyQHvBcw==
X-Google-Smtp-Source: AGHT+IFa1K4sYqOl+dXQ0E88Fydq2dUpDP40xAUJNd8RbWVqJfYPpP7dUIrWr/dF77HO82K1mA4Eg4a/ON1+iLKE
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:13d:fb22:ac12:a84b])
 (user=jthoughton job=sendgmr) by 2002:a25:83c3:0:b0:e30:c79e:16bc with SMTP
 id 3f1490d57ef6-e30c79e1861mr26074276.8.1730832226917; Tue, 05 Nov 2024
 10:43:46 -0800 (PST)
Date: Tue,  5 Nov 2024 18:43:26 +0000
In-Reply-To: <20241105184333.2305744-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241105184333.2305744-1-jthoughton@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241105184333.2305744-5-jthoughton@google.com>
Subject: [PATCH v8 04/11] KVM: x86/mmu: Relax locking for kvm_test_age_gfn and kvm_age_gfn
From: James Houghton <jthoughton@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	James Houghton <jthoughton@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Wei Xu <weixugc@google.com>, Yu Zhao <yuzhao@google.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Walk the TDP MMU in an RCU read-side critical section without holding
mmu_lock when harvesting and potentially updating age information on
sptes. This requires a way to do RCU-safe walking of the tdp_mmu_roots;
do this with a new macro. The PTE modifications are now done atomically,
and kvm_tdp_mmu_spte_need_atomic_write() has been updated to account for
the fact that kvm_age_gfn can now locklessly update the accessed bit and
the W/R/X bits).

If the cmpxchg for marking the spte for access tracking fails, leave it
as is and treat it as if it were young, as if the spte is being actively
modified, it is most likely young.

Harvesting age information from the shadow MMU is still done while
holding the MMU write lock.

Suggested-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: James Houghton <jthoughton@google.com>
Reviewed-by: David Matlack <dmatlack@google.com>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/Kconfig            |  1 +
 arch/x86/kvm/mmu/mmu.c          | 10 ++++++++--
 arch/x86/kvm/mmu/tdp_iter.h     | 12 ++++++------
 arch/x86/kvm/mmu/tdp_mmu.c      | 23 ++++++++++++++++-------
 5 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 70c7ed0ef184..84ee08078686 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1455,6 +1455,7 @@ struct kvm_arch {
 	 * tdp_mmu_page set.
 	 *
 	 * For reads, this list is protected by:
+	 *	RCU alone or
 	 *	the MMU lock in read mode + RCU or
 	 *	the MMU lock in write mode
 	 *
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 1ed1e4f5d51c..97f747d60fe9 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -23,6 +23,7 @@ config KVM_X86
 	select KVM_COMMON
 	select KVM_GENERIC_MMU_NOTIFIER
 	select KVM_ELIDE_TLB_FLUSH_IF_YOUNG
+	select KVM_MMU_NOTIFIER_YOUNG_LOCKLESS
 	select HAVE_KVM_IRQCHIP
 	select HAVE_KVM_PFNCACHE
 	select HAVE_KVM_DIRTY_RING_TSO
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 443845bb2e01..26797ccd34d8 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1586,8 +1586,11 @@ bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
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
@@ -1599,8 +1602,11 @@ bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
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
index a24fca3f9e7f..f26d0b60d2dd 100644
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
+ * Dirty bits can be set by the CPU, and the Accessed and W/R/X bits can be
+ * cleared by age_gfn_range().
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
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 4508d868f1cd..f5b4f1060fff 100644
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
 
@@ -1168,16 +1177,16 @@ static void kvm_tdp_mmu_age_spte(struct tdp_iter *iter)
 	u64 new_spte;
 
 	if (spte_ad_enabled(iter->old_spte)) {
-		iter->old_spte = tdp_mmu_clear_spte_bits(iter->sptep,
-							 iter->old_spte,
-							 shadow_accessed_mask,
-							 iter->level);
+		iter->old_spte = tdp_mmu_clear_spte_bits_atomic(iter->sptep,
+						shadow_accessed_mask);
 		new_spte = iter->old_spte & ~shadow_accessed_mask;
 	} else {
 		new_spte = mark_spte_for_access_track(iter->old_spte);
-		iter->old_spte = kvm_tdp_mmu_write_spte(iter->sptep,
-							iter->old_spte, new_spte,
-							iter->level);
+		/*
+		 * It is safe for the following cmpxchg to fail. Leave the
+		 * Accessed bit set, as the spte is most likely young anyway.
+		 */
+		(void)__tdp_mmu_set_spte_atomic(iter, new_spte);
 	}
 
 	trace_kvm_tdp_mmu_spte_changed(iter->as_id, iter->gfn, iter->level,
-- 
2.47.0.199.ga7371fff76-goog


