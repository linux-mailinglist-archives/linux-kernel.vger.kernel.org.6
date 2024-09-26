Return-Path: <linux-kernel+bounces-339789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19BF986A8D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 03:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 010EF1C2478D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 01:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C481A3BC1;
	Thu, 26 Sep 2024 01:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0izLu6WE"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3722317ADFF
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 01:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727314529; cv=none; b=fScx4L9zFGhuKlxP4SnQQJkYx3aeMtpdqBP+A0nTAsSq73QJuh9YsGkya0ruUMXtiWY456rmFclifz0jRVomzaKN0T+50CxEztBxi/0MvtluPaoDfF1n0Vj/7wXrkoyk7cXHno5dgVvuQZv7pvnkgiYkHQqA79Echd/EHk53IYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727314529; c=relaxed/simple;
	bh=E9AQ6b+xH0X6/PhVwSlcvCw/vsOlfjn0RvQXxr2pYnI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qZ8SRY+nP8y95TC0Kk1YgFSE8C85DvCm5BD9mhA3pPndA/XFX8p5sY9ZvzJgqCK55lRiIbV3WR05kueSRJUztO2FxENAPGNMzBLivktyeVO/R65dGcmBIW/cvUJc03A5nSYwZFa0pokZ2bSiie72xtvROK0Nex2n0z283GAMJiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0izLu6WE; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6db791c42e3so8792987b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 18:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727314527; x=1727919327; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/OnVwOE5c+4OTD3Iw61tcspb9ex9OyShqju36BWGlvg=;
        b=0izLu6WEdFEPHrK/MbRSe9pZuZy4p0cKedOL1sv1PuE2bbREDrC481Ox9J+4niq0xq
         v49/Ld2Loax18tzQHKvCS94xKcy4PFvbee6ZzAQWTKhPoTiMlO9T0a+eqZlOUkY1gdje
         bTf6yOM5DVXF/J1yDnLgXRLGjaiUBKgl3O7OoN9WQ4XiOo/SHkcUSA2DGauqtOn80CjQ
         dbIHMeZ8pBQsySmgS6ekGHDwf+i06pv/G4Iee79JfNhMuCBqrXeVwjA6ZkMg9NnKA7lN
         FD6dMdhIkWNg+yjV4tPG305pRHCjliH3d+iGG6LJcdn2X0JSG6DFZl0qslgSyMoVaaey
         D0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727314527; x=1727919327;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/OnVwOE5c+4OTD3Iw61tcspb9ex9OyShqju36BWGlvg=;
        b=bwkwPMK9wKEmO4uUYIxZUhG9prsOjlcDthjuT94UIRk8Z5ZN2aGO7Z2vZ3Ni7EqEm6
         azQ7tJEiNA5p+VjPa1rh6Y5nx4PeJHnH6iJi9X2X5JV9MNZt7Jt2S4GzK9ZyZzBd9QQL
         UAqc0wGBjm5tuEj9+tPK6wlkdDOLLxXuQF8Lxm85cMxsa4yWenGNALD8KdwB4hLGFen9
         OQ1WJwlsyg5NBbvb7eFEye+Tsu+RRVhP/hK2Ot2aLTGhR2yhkFNc56fxDMyvIR5myCV1
         Ozp2h1jnSnTZT5DA3Jt/Gml86cmPZaF/hGUwK41CdO5Cm5d00UpjfqynMYrFhBOcCtHK
         biug==
X-Forwarded-Encrypted: i=1; AJvYcCWLkQVgFo7NEqkMmetIICa86U4rBzhsfsZi2oTvwgafW3SthzPbIGJehTuCWdNiSgaw94Jtix7N5pwjzok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6rOfcaF9gIG+R57bXOCY/tR329B+mrkbZ1pgurUfpuz6vLCEg
	g7MtYZ3HY3z1kjJ/SxSsQ8Qlvkq5R1PHzj+KTDMku9xp3I2LEpPDVrmgwrpR0XBARctiQVM2hZA
	mm+8S0zwOjt1DfFqyyg==
X-Google-Smtp-Source: AGHT+IFP6wbu5d5xFxibAPH1VEJb74N56TVg2vvH80n5yLYaLmdn9VnaHIq1SmzVQiXoW0zSRxLWmsPWaG4W/Pg1
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:13d:fb22:ac12:a84b])
 (user=jthoughton job=sendgmr) by 2002:a25:74cc:0:b0:e25:cced:3e3f with SMTP
 id 3f1490d57ef6-e25cced3f41mr11837276.4.1727314527042; Wed, 25 Sep 2024
 18:35:27 -0700 (PDT)
Date: Thu, 26 Sep 2024 01:34:58 +0000
In-Reply-To: <20240926013506.860253-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926013506.860253-1-jthoughton@google.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240926013506.860253-11-jthoughton@google.com>
Subject: [PATCH v7 10/18] KVM: x86/mmu: Support rmap walks without holding
 mmu_lock when aging gfns
From: James Houghton <jthoughton@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, James Houghton <jthoughton@google.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Wei Xu <weixugc@google.com>, Yu Zhao <yuzhao@google.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

From: Sean Christopherson <seanjc@google.com>

Because an L1 KVM can disable A/D bits for its L2, even if
kvm_ad_enabled() in L0, we cannot always locklessly age, as aging
requires marking non-A/D sptes for access tracking, which is not
supported locklessly yet.

We can always gather age information locklessly though.

Signed-off-by: Sean Christopherson <seanjc@google.com>
[jthoughton: Added changelog, adjusted conditional]
Signed-off-by: James Houghton <jthoughton@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 66 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 72c682fa207a..a63497bbcc61 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1014,13 +1014,11 @@ static unsigned long kvm_rmap_get(struct kvm_rmap_head *rmap_head)
  * locking is the same, but the caller is disallowed from modifying the rmap,
  * and so the unlock flow is a nop if the rmap is/was empty.
  */
-__maybe_unused
 static unsigned long kvm_rmap_lock_readonly(struct kvm_rmap_head *rmap_head)
 {
 	return __kvm_rmap_lock(rmap_head);
 }
 
-__maybe_unused
 static void kvm_rmap_unlock_readonly(struct kvm_rmap_head *rmap_head,
 				     unsigned long old_val)
 {
@@ -1736,8 +1734,53 @@ static void rmap_add(struct kvm_vcpu *vcpu, const struct kvm_memory_slot *slot,
 	__rmap_add(vcpu->kvm, cache, slot, spte, gfn, access);
 }
 
-static bool kvm_rmap_age_gfn_range(struct kvm *kvm,
-				   struct kvm_gfn_range *range, bool test_only)
+static bool kvm_rmap_age_gfn_range_lockless(struct kvm *kvm,
+					    struct kvm_gfn_range *range,
+					    bool test_only)
+{
+	struct kvm_rmap_head *rmap_head;
+	struct rmap_iterator iter;
+	unsigned long rmap_val;
+	bool young = false;
+	u64 *sptep;
+	gfn_t gfn;
+	int level;
+	u64 spte;
+
+	for (level = PG_LEVEL_4K; level <= KVM_MAX_HUGEPAGE_LEVEL; level++) {
+		for (gfn = range->start; gfn < range->end;
+		     gfn += KVM_PAGES_PER_HPAGE(level)) {
+			rmap_head = gfn_to_rmap(gfn, level, range->slot);
+			rmap_val = kvm_rmap_lock_readonly(rmap_head);
+
+			for_each_rmap_spte_lockless(rmap_head, &iter, sptep, spte) {
+				if (!is_accessed_spte(spte))
+					continue;
+
+				if (test_only) {
+					kvm_rmap_unlock_readonly(rmap_head, rmap_val);
+					return true;
+				}
+
+				/*
+				 * Marking SPTEs for access tracking outside of
+				 * mmu_lock is unsupported.  Report the page as
+				 * young, but otherwise leave it as-is.
+				 */
+				if (spte_ad_enabled(spte))
+					clear_bit((ffs(shadow_accessed_mask) - 1),
+						  (unsigned long *)sptep);
+				young = true;
+			}
+
+			kvm_rmap_unlock_readonly(rmap_head, rmap_val);
+		}
+	}
+	return young;
+}
+
+static bool __kvm_rmap_age_gfn_range(struct kvm *kvm,
+				     struct kvm_gfn_range *range, bool test_only)
 {
 	struct slot_rmap_walk_iterator iterator;
 	struct rmap_iterator iter;
@@ -1776,6 +1819,21 @@ static bool kvm_rmap_age_gfn_range(struct kvm *kvm,
 	return young;
 }
 
+static bool kvm_rmap_age_gfn_range(struct kvm *kvm,
+				   struct kvm_gfn_range *range, bool test_only)
+{
+	/*
+	 * We can always locklessly test if an spte is young. Because marking
+	 * non-A/D sptes for access tracking without holding the mmu_lock is
+	 * not currently supported, we cannot always locklessly clear.
+	 */
+	if (test_only)
+		return kvm_rmap_age_gfn_range_lockless(kvm, range, test_only);
+
+	lockdep_assert_held_write(&kvm->mmu_lock);
+	return __kvm_rmap_age_gfn_range(kvm, range, test_only);
+}
+
 static bool kvm_has_shadow_mmu_sptes(struct kvm *kvm)
 {
 	return !tdp_mmu_enabled || READ_ONCE(kvm->arch.indirect_shadow_pages);
-- 
2.46.0.792.g87dc391469-goog


