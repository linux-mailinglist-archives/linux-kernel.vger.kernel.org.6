Return-Path: <linux-kernel+bounces-360373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F02999A29
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 04:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 549061F23BF0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 02:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6931FAC20;
	Fri, 11 Oct 2024 02:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dNaVsba2"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21451FA25B
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 02:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728612681; cv=none; b=c9ZjTS5pOHqhKHf8/pc1vUMKbt/52k3zeAW+eN4lmznnOutFShK5bkLfen+vvahgYhoFd9ynmc5ziUfhf10WVHEK0RITugtogADXPefoKHr2h5+Rt9dpBpwKBjB6vPt6rt6Msq6HDUhU5NPO38XLbNNMWRwrlSm0tun/80I6dyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728612681; c=relaxed/simple;
	bh=2l/4Exb4i+z5I5WlQFCs9q8cTS9KUprPX2RvYEEUZlk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X1xaOpdNxIVXdrCeq9G7WQqQTTcQUQt508eUyJNXsuIHHj1CcOYyK6NDPSYPUJljFZLpDid3uZ7e9BCwD92hS3txH7/G4zQKeS0jplcZzU78wj15KR0oTZoC9+ZgTmWBIKLCJMQdFFqYrdJVS7aiHhTW7AfDvxFEUofJYcNfHUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dNaVsba2; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-207510f3242so20306235ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 19:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728612677; x=1729217477; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=swbcLNUhlO+Z3x5j0iArPCyFfm9nB4ZdSOpt0u+BRiM=;
        b=dNaVsba2yMFVWf0wZyQTBbH4NTDwleWChlrKE53UQKNjNA5Yw6xXhT1oMavj92mvrK
         hROvdPEWLNajwQcFxBhu9Sid8+byTTn2eQVxMTDMn9bNP8rydbWAV7tIO2GCez3k2mUl
         M/1p/Vhiz6ghe2Yh9XXbFivonf7dp6qGqH7HNO7HheXhAMjkJKXODvf34AtRHx4yoD0m
         /huSs46IuuP3py8sBelqjaOy5olKInvBa85dMPmMwyUCQjDKV4/d0lV0MyyQq7WGUNze
         wJVKojKsQsRYWHdb82IJxLtFJ0rS0WqDHiWeEarRTIJ7A2EXUzsr2G7N+gttgmmsgOM1
         mqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728612677; x=1729217477;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=swbcLNUhlO+Z3x5j0iArPCyFfm9nB4ZdSOpt0u+BRiM=;
        b=tCTmvC/0tIIkRV4syMYrrLUkFlmKXx9iUCTgUaL7EQvyRLEeO/Zrm30mURMyipv5Wi
         6Q2GvTLAqc2/tktXyUINZZwRVbNaJVvo0OPwK4hXFf9svYlxikcT1JjOqJFYRbWrJZ8Z
         M1ITQ1Pqt50jYiR7Rnecjbacb28UTJCQJ9gV6woqUACLSEsrsq5YpagmF6pOWJEDuurC
         9mxKChoNgMfVR0WjsXRVZ4R4LNeJi0b1H/30Orp1aFUMWhA7+90TSXoMowFbhUe/2b6u
         WUraSdkUp1y3qtUWnMy9PNuJW3rd2Y46OLak+/T0YhWV2IzdtLy73bdVFshpEevGOYeL
         zfdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUa8WfD5dEVE0z3wUrRO1rWLHRUbrOdHKb7lysIGX89dtkgrq/xSnwFOVCROYS8mrwDC1hL9nTxnTDsYtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxazLo9f+Xzc6zkYNTwcNcLJ6MlgYuKzst+ZsXDxitL7aMI/ts
	Vw8dsvnwtDQqlEHsw+PQaT/uWSoHtzsXRBrndqJi9QbDuefLOeQosftd6byWkmvSXeZZI4DL6PT
	uCg==
X-Google-Smtp-Source: AGHT+IGBcUZAIBFhERfMhmqeQCLgWZgdChjmWr3g6PLndUtixM7vUgJQznL7pe9JB9jYv/yodxK5GriG5ZU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:902:d2c8:b0:20b:7ece:3225 with SMTP id
 d9443c01a7336-20ca130a1b1mr320995ad.0.1728612676949; Thu, 10 Oct 2024
 19:11:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 10 Oct 2024 19:10:44 -0700
In-Reply-To: <20241011021051.1557902-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011021051.1557902-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241011021051.1557902-13-seanjc@google.com>
Subject: [PATCH 12/18] KVM: x86/mmu: Use Accessed bit even when _hardware_ A/D
 bits are disabled
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Sagi Shahar <sagis@google.com>, 
	"=?UTF-8?q?Alex=20Benn=C3=A9e?=" <alex.bennee@linaro.org>, David Matlack <dmatlack@google.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Use the Accessed bit in SPTEs even when A/D bits are disabled in hardware,
i.e. propagate accessed information to SPTE.Accessed even when KVM is
doing manual tracking by making SPTEs not-present.  In addition to
eliminating a small amount of code in is_accessed_spte(), this also paves
the way for preserving Accessed information when a SPTE is zapped in
response to a mmu_notifier PROTECTION event, e.g. if a SPTE is zapped
because NUMA balancing kicks in.

Note, EPT is the only flavor of paging in which A/D bits are conditionally
enabled, and the Accessed (and Dirty) bit is software-available when A/D
bits are disabled.

Note #2, there are currently no concrete plans to preserve Accessed
information.  Explorations on that front were the initial catalyst, but
the cleanup is the motivation for the actual commit.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c  |  3 ++-
 arch/x86/kvm/mmu/spte.c |  4 ++--
 arch/x86/kvm/mmu/spte.h | 11 +----------
 3 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 06fb0fd3f87d..5be3b5f054f1 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3486,7 +3486,8 @@ static int fast_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 		 * enabled, the SPTE can't be an access-tracked SPTE.
 		 */
 		if (unlikely(!kvm_ad_enabled) && is_access_track_spte(spte))
-			new_spte = restore_acc_track_spte(new_spte);
+			new_spte = restore_acc_track_spte(new_spte) |
+				   shadow_accessed_mask;
 
 		/*
 		 * To keep things simple, only SPTEs that are MMU-writable can
diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index 54d8c9b76050..617479efd127 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -175,7 +175,7 @@ bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 
 	spte |= shadow_present_mask;
 	if (!prefetch || synchronizing)
-		spte |= spte_shadow_accessed_mask(spte);
+		spte |= shadow_accessed_mask;
 
 	/*
 	 * For simplicity, enforce the NX huge page mitigation even if not
@@ -346,7 +346,7 @@ u64 mark_spte_for_access_track(u64 spte)
 
 	spte |= (spte & SHADOW_ACC_TRACK_SAVED_BITS_MASK) <<
 		SHADOW_ACC_TRACK_SAVED_BITS_SHIFT;
-	spte &= ~shadow_acc_track_mask;
+	spte &= ~(shadow_acc_track_mask | shadow_accessed_mask);
 
 	return spte;
 }
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 908cb672c4e1..c8dc75337c8b 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -316,12 +316,6 @@ static inline bool spte_ad_need_write_protect(u64 spte)
 	return (spte & SPTE_TDP_AD_MASK) != SPTE_TDP_AD_ENABLED;
 }
 
-static inline u64 spte_shadow_accessed_mask(u64 spte)
-{
-	KVM_MMU_WARN_ON(!is_shadow_present_pte(spte));
-	return spte_ad_enabled(spte) ? shadow_accessed_mask : 0;
-}
-
 static inline u64 spte_shadow_dirty_mask(u64 spte)
 {
 	KVM_MMU_WARN_ON(!is_shadow_present_pte(spte));
@@ -355,10 +349,7 @@ static inline kvm_pfn_t spte_to_pfn(u64 pte)
 
 static inline bool is_accessed_spte(u64 spte)
 {
-	u64 accessed_mask = spte_shadow_accessed_mask(spte);
-
-	return accessed_mask ? spte & accessed_mask
-			     : !is_access_track_spte(spte);
+	return spte & shadow_accessed_mask;
 }
 
 static inline u64 get_rsvd_bits(struct rsvd_bits_validate *rsvd_check, u64 pte,
-- 
2.47.0.rc1.288.g06298d1525-goog


