Return-Path: <linux-kernel+bounces-281513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C46294D7A4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28C671F251A5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AD6199E9D;
	Fri,  9 Aug 2024 19:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3qlLhUcC"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580FD19939E
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 19:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723232650; cv=none; b=GO4OHUGJETDvZtRpGUxkuMt+J/mccA5kG2EJ0LIQ6d0PnMZxdNP89GVxbp8P+3tUdZK09Seaz0TUqt9HBXfKvzHXsuWXbac35dImnoKUihDUtxExTRXo4fioD3FzVKeSO7C9WOnoMV/BxWh1pS/Wp3wDBDELkEGgMoBtejsnoIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723232650; c=relaxed/simple;
	bh=VG0ehnLRBNQjGjdZ62CiB3/PrgwQ8Ke9eyr0F1VXaGU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lD+bOJdwCx5XeSs2dLoKWN9Zn+preR2HDgHQvVkYqnKSUgNPikRgmkY/2yngs3xraHE6cEXFbs39ZsKujLbyMuBwAk4AoLc0ciqOsFBgij44lVJs2m+olQ5HY/tHhff38YFWMdVAiYjhiy5d3g9i6vb5tGsTE7OsbcTHk+47Jqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3qlLhUcC; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-71050384c9aso2463665b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 12:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723232648; x=1723837448; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Ai8EH7U6wTbiOPvc4tDQEcYQ+E/EtVyC6HGLhPebPF8=;
        b=3qlLhUcC97lB6vCpdUPWtkuyd4ObXkDIAeSa+M9klnKyX5L6H2S67M6HxaE6pIJQV6
         VHdblS5NGUk7ROWxOvP08JH655dAuNTTe8bDHkbjBLuLlJWNHZOvNYsedBgMLnZ3Ih42
         Ad+pyOTzngUWy5i90jrJOZ0+SSHdUBuePexfbsgSQEV1H8ND7msrLyv0YAvH8y7jBIWm
         oFzpkQT2F+GqtzX8yg8tr1Ydq6lDdvbJZAY+TqklSgsy00ybax5BxOMqpTSelcGvuWzp
         oWOsMgmdN5ioNYnLAAavhTjP8buGZ16QCyHZ6whtp79/Xf2+Tfxio2j6bc0BV9nowmCY
         BmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723232648; x=1723837448;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ai8EH7U6wTbiOPvc4tDQEcYQ+E/EtVyC6HGLhPebPF8=;
        b=kO4wp274WAzHlqakQIXWo767dueYbhJNHkm/DIQHiPr0IqJma0+twmUwX+FmgHtPDq
         SUiSB2gb2oeogHZdanFL3Nx1Ty6VYrEuf0w1s6glRiTwYxMyR2MNGsrxfQWKcJF/c6L5
         FBThAzFemca70VVjSkOiDkA3boi3yN9lEdImfjJZ0r1e5OLFTqwH+2eF9CXL6ROqqaNw
         X4lahBzhVGfTzcF0RhMj8S/a9aFg+OzGeAqYl9pmTy5PvdKmzk//A25m40NSPJUW0i02
         Q/2GIs3VTakAY8Wabhwp/rbqT8RK1N9MoTXanvNC53SeuvXy4+lHFvVHDwcmq0K8CbCt
         ESuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXbqoAwkAScxQvEDq68nomIoKkMT1DNLD+5egkASTbcfqd3fHsrhCUQc+RtQOpddQxCFbyuYaW9rfMlIYRNE1G7iTJZGPFBy/EgdHd
X-Gm-Message-State: AOJu0Yxdvd7MVxmVK6EoNn+EID/NgYVnk1L4UOWlFJ+zrphtOYVD23+u
	VoRktP8J18kS4COdyir4uX7WhS5BAZhRRBcbnjKgq8Cqi2UurughJLY1gfny+ZCVkmx8lCA6Q5t
	p2g==
X-Google-Smtp-Source: AGHT+IHNNFbniYTOQTi7bihux9iGSGXPTBj4ES/WY0YDfyXV3hzhWFmxyp3a86iRwwurPT1lphBR34jXitQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:9167:b0:70d:1b0d:a15d with SMTP id
 d2e1a72fcca58-710ccb04a71mr122147b3a.3.1723232648511; Fri, 09 Aug 2024
 12:44:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  9 Aug 2024 12:43:27 -0700
In-Reply-To: <20240809194335.1726916-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240809194335.1726916-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240809194335.1726916-16-seanjc@google.com>
Subject: [PATCH 15/22] KVM: x86/mmu: Fold mmu_spte_age() into kvm_rmap_age_gfn_range()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>, Peter Xu <peterx@redhat.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Fold mmu_spte_age() into its sole caller now that aging and testing for
young SPTEs is handled in a common location, i.e. doesn't require more
helpers.

Opportunistically remove the use of mmu_spte_get_lockless(), as mmu_lock
is held (for write!), and marking SPTEs for access tracking outside of
mmu_lock is unsafe (at least, as written).  I.e. using the lockless
accessor is quite misleading.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 50 +++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 88b656a1453d..c536a069d6b9 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -614,32 +614,6 @@ static u64 mmu_spte_get_lockless(u64 *sptep)
 	return __get_spte_lockless(sptep);
 }
 
-/* Returns the Accessed status of the PTE and resets it at the same time. */
-static bool mmu_spte_age(u64 *sptep)
-{
-	u64 spte = mmu_spte_get_lockless(sptep);
-
-	if (!is_accessed_spte(spte))
-		return false;
-
-	if (spte_ad_enabled(spte)) {
-		clear_bit((ffs(shadow_accessed_mask) - 1),
-			  (unsigned long *)sptep);
-	} else {
-		/*
-		 * Capture the dirty status of the page, so that it doesn't get
-		 * lost when the SPTE is marked for access tracking.
-		 */
-		if (is_writable_pte(spte))
-			kvm_set_pfn_dirty(spte_to_pfn(spte));
-
-		spte = mark_spte_for_access_track(spte);
-		mmu_spte_update_no_track(sptep, spte);
-	}
-
-	return true;
-}
-
 static inline bool is_tdp_mmu_active(struct kvm_vcpu *vcpu)
 {
 	return tdp_mmu_enabled && vcpu->arch.mmu->root_role.direct;
@@ -1660,10 +1634,30 @@ static bool kvm_rmap_age_gfn_range(struct kvm *kvm,
 	for_each_slot_rmap_range(range->slot, PG_LEVEL_4K, KVM_MAX_HUGEPAGE_LEVEL,
 				 range->start, range->end - 1, &iterator) {
 		for_each_rmap_spte(iterator.rmap, &iter, sptep) {
-			if (test_only && is_accessed_spte(*sptep))
+			u64 spte = *sptep;
+
+			if (!is_accessed_spte(spte))
+				continue;
+
+			if (test_only)
 				return true;
 
-			young = mmu_spte_age(sptep);
+			if (spte_ad_enabled(spte)) {
+				clear_bit((ffs(shadow_accessed_mask) - 1),
+					(unsigned long *)sptep);
+			} else {
+				/*
+				 * Capture the dirty status of the page, so that
+				 * it doesn't get lost when the SPTE is marked
+				 * for access tracking.
+				 */
+				if (is_writable_pte(spte))
+					kvm_set_pfn_dirty(spte_to_pfn(spte));
+
+				spte = mark_spte_for_access_track(spte);
+				mmu_spte_update_no_track(sptep, spte);
+			}
+			young = true;
 		}
 	}
 	return young;
-- 
2.46.0.76.ge559c4bf1a-goog


