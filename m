Return-Path: <linux-kernel+bounces-212235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DDC905D1A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 22:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4DDE284143
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3609B84FAC;
	Wed, 12 Jun 2024 20:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EWfrPZnM"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEB443144
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 20:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718225270; cv=none; b=pVTnOmOwJQOfE5cMxu0SVH2i6HBLb7/QykRk4ZVC3D/Wbs4Lo/Wlgzy/0kRrDe46JrCHhrFij9KF2pUkshMSvU1KdtKVh33bTl0N+oRDXrbmHc8QffGQfMWoBR+EjdZK0/NFLddQK9VuzA1siQl599L1jIWS3AIsdpSvGnNiuMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718225270; c=relaxed/simple;
	bh=aC5PaSjQFR+x1s9oqkemFF89YR3d70O6ds2KXWq0yGc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eENfCFPlYaRoe+2h5QyZyTxmHNOToWQxMv5b2jydzlkO7aO5HdiKXTSvw6tny4ZCcRGw8NrCvvlAiCuOeSPrTGY0fly5lFeBHo7mUwb4qyvd/L9ri5ejeCWsaWzfowLJlZOFzGQmjmqgFOSwFNLWW1eiZNB8mqSenQUBr7Q+WSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EWfrPZnM; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfeac23fe6eso543804276.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 13:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718225268; x=1718830068; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=15xNRufoy8zQ0ly/BFY7+H/LjnHWUIf8CQqsanVt6QU=;
        b=EWfrPZnM3JZTkWFkiVNf3uQvHcmRhN4wFSzZg4GmwLeK6QJ4qx6DrqbaJ4Xixi3FJa
         /A/YuZYQsyImpdVA8MLTI+z8rp+c8U4Q7JLtk/FxSi9t6f4Ra3YbpTkjUReJN+g9vp3T
         x1sbYkcTKGnNmzij9kB0aJaS6A0jgHgG6G0FspmbG3abFwQZncvaS4pMR/1srs5FflCD
         zjS9HyeiWLQMk0Iu7FaPStGxSbfPvmgDb28enQlXSE9yqj7iyENsQ8ftS82uAW7lN7Fa
         MRqVrOtKrWtKdLB5iboQ3oHREzsgzi1BHw82CEHzA3BQACUv4ykM75pwao4gVsIKgMdO
         OKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718225268; x=1718830068;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=15xNRufoy8zQ0ly/BFY7+H/LjnHWUIf8CQqsanVt6QU=;
        b=HDgwiY1HHIyRlB5ItS6dFI14LRQTvVecMJl41iQY7cpJtzddQH3BrhpWLp63uF4kmm
         pJ3ssxz2Torxm14YQCTkb8FXbu0uasnNv5MLhaOEVIVXj0oz043DqxguHU+KYwjWTPTb
         4E3HEBs51cL3swNVH6UyPP9jW5OkLOg3CUCk+fQG/QHz3sj9tctGXw4aSRVa3MvOp8y0
         bIZvuTioaCwv1pjd0JfUwQQLiRZYZg0l2FjVmJsdiBDynvyi/G5ZCAUcx4zmxGIq9KsK
         2qvXKPGZpjQVBd15++LQ4mrPT5wCo4uu7v8/rX4xdAFcsXGRabGelUzj8BoW0GGKRYfO
         DnQw==
X-Forwarded-Encrypted: i=1; AJvYcCWv8zhgeqHRHavznZWur301e2OQH2Q+Wvg7pfkdTH99YUxeDU5IcetymyL2CfwRnL1XX7I1mobIopTFpyn5SMcTN8jhXCxxJIqL7SJ5
X-Gm-Message-State: AOJu0Yy6rfZeQdYDUX2bRNTHQjofO1FSNr/Ub8uD2MsfW36FlR1SUjxG
	RuizZu5BiEYIxx2+ZSq5g6ErVTaPZ/+PI2Sh1rc3WU3lB5GeW434eL+uyvDOmdOU+6aTy9UFBMs
	nWw==
X-Google-Smtp-Source: AGHT+IFWA3DPmtvbwokGO6/4cy3yrfWAzwswtvxH000akBt4qO6CwDNwUoiUsaOPjGaCUrlzkGUbk8LJtck=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1544:b0:dfb:20e:2901 with SMTP id
 3f1490d57ef6-dfe6676c7cfmr707011276.6.1718225267795; Wed, 12 Jun 2024
 13:47:47 -0700 (PDT)
Date: Wed, 12 Jun 2024 13:47:46 -0700
In-Reply-To: <9477c21a-4b18-4539-9f82-11046e43063c@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240419085927.3648704-1-pbonzini@redhat.com> <20240419085927.3648704-4-pbonzini@redhat.com>
 <9477c21a-4b18-4539-9f82-11046e43063c@intel.com>
Message-ID: <ZmoJciFSN_SALA1s@google.com>
Subject: Re: [PATCH 3/6] KVM: x86/mmu: Extract __kvm_mmu_do_page_fault()
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	isaku.yamahata@intel.com, binbin.wu@linux.intel.com, 
	rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Apr 22, 2024, Xiaoyao Li wrote:
> On 4/19/2024 4:59 PM, Paolo Bonzini wrote:
> > From: Isaku Yamahata <isaku.yamahata@intel.com>
> > 
> > Extract out __kvm_mmu_do_page_fault() from kvm_mmu_do_page_fault().  The
> > inner function is to initialize struct kvm_page_fault and to call the fault
> > handler, and the outer function handles updating stats and converting
> > return code.
> 
> I don't see how the outer function converts return code.
> 
> > KVM_PRE_FAULT_MEMORY will call the KVM page fault handler.
> 
> I assume it means the inner function will be used by KVM_PRE_FAULT_MEMORY.
> 
> > This patch makes the emulation_type always set irrelevant to the return
> > code.  kvm_mmu_page_fault() is the only caller of kvm_mmu_do_page_fault(),
> > and references the value only when PF_RET_EMULATE is returned.  Therefore,
> > this adjustment doesn't affect functionality.
> 
> This paragraph needs to be removed, I think. It's not true.

It's oddly worded, but I do think it's correct.  kvm_arch_async_page_ready()
doesn't pass emulation_type, and kvm_mmu_page_fault() bails early for all other
return values:

	if (r < 0)
		return r;
	if (r != RET_PF_EMULATE)
		return 1;

That said, this belongs in a separate patch (if it's actually necessary). 

And _that_ said, rather than add an inner version, what if we instead shuffle the
stats code?  pf_taken, pf_spurious, and pf_emulate should _only_ ever be bumped
by kvm_mmu_page_fault(), i.e. should only track page faults that actually happened
in the guest.  And so handling them in kvm_mmu_do_page_fault() doesn't make any
sense, because there should only ever be one caller that passes prefetch=false.

Compile tested only, and kvm_mmu_page_fault() is a bit ugly (but that's solvable),
but I think this would provide better separation of concerns.

--
From: Sean Christopherson <seanjc@google.com>
Date: Wed, 12 Jun 2024 12:51:38 -0700
Subject: [PATCH 1/2] KVM: x86/mmu: Bump pf_taken stat only in the "real" page
 fault handler

Account stat.pf_taken in kvm_mmu_page_fault(), i.e. the actual page fault
handler, instead of conditionally bumping it in kvm_mmu_do_page_fault().
The "real" page fault handler is the only path that should ever increment
the number of taken page faults, as all other paths that "do page fault"
are by definition not handling faults that occurred in the guest.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c          | 2 ++
 arch/x86/kvm/mmu/mmu_internal.h | 8 --------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index f2c9580d9588..3461b8c4aba2 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5928,6 +5928,8 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
 	}
 
 	if (r == RET_PF_INVALID) {
+		vcpu->stat.pf_taken++;
+
 		r = kvm_mmu_do_page_fault(vcpu, cr2_or_gpa, error_code, false,
 					  &emulation_type);
 		if (KVM_BUG_ON(r == RET_PF_INVALID, vcpu->kvm))
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index ce2fcd19ba6b..8efd31b3856b 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -318,14 +318,6 @@ static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 		fault.slot = kvm_vcpu_gfn_to_memslot(vcpu, fault.gfn);
 	}
 
-	/*
-	 * Async #PF "faults", a.k.a. prefetch faults, are not faults from the
-	 * guest perspective and have already been counted at the time of the
-	 * original fault.
-	 */
-	if (!prefetch)
-		vcpu->stat.pf_taken++;
-
 	if (IS_ENABLED(CONFIG_MITIGATION_RETPOLINE) && fault.is_tdp)
 		r = kvm_tdp_page_fault(vcpu, &fault);
 	else

base-commit: b7bc82a015e237862837bd1300d6ba1f5cd17466
-- 
2.45.2.505.gda0bf45e8d-goog

From 1dc69d38a8d51c9d8ad833475938cb925f7ea4cf Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Wed, 12 Jun 2024 12:59:06 -0700
Subject: [PATCH 2/2] KVM: x86/mmu: Account pf_{fixed,emulate,spurious} in
 callers of "do page fault"

Move the accounting of the result of kvm_mmu_do_page_fault() to its
callers, as only pf_fixed is common to guest page faults and async #PFs,
and upcoming support KVM_PRE_FAULT_MEMORY won't bump _any_ stats.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c          | 19 ++++++++++++++++++-
 arch/x86/kvm/mmu/mmu_internal.h | 13 -------------
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 3461b8c4aba2..56373577a197 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4291,7 +4291,16 @@ void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu, struct kvm_async_pf *work)
 	      work->arch.cr3 != kvm_mmu_get_guest_pgd(vcpu, vcpu->arch.mmu))
 		return;
 
-	kvm_mmu_do_page_fault(vcpu, work->cr2_or_gpa, work->arch.error_code, true, NULL);
+	r = kvm_mmu_do_page_fault(vcpu, work->cr2_or_gpa, work->arch.error_code,
+				  true, NULL);
+
+	/*
+	 * Account fixed page faults, otherwise they'll never be counted, but
+	 * ignore stats for all other return times.  Page-ready "faults" aren't
+	 * truly spurious and never trigger emulation
+	 */
+	if (r == RET_PF_FIXED)
+		vcpu->stat.pf_fixed++;
 }
 
 static inline u8 kvm_max_level_for_order(int order)
@@ -5938,6 +5947,14 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
 
 	if (r < 0)
 		return r;
+
+	if (r == RET_PF_FIXED)
+		vcpu->stat.pf_fixed++;
+	else if (r == RET_PF_EMULATE)
+		vcpu->stat.pf_emulate++;
+	else if (r == RET_PF_SPURIOUS)
+		vcpu->stat.pf_spurious++;
+
 	if (r != RET_PF_EMULATE)
 		return 1;
 
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index 8efd31b3856b..444f55a5eed7 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -337,19 +337,6 @@ static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 	if (fault.write_fault_to_shadow_pgtable && emulation_type)
 		*emulation_type |= EMULTYPE_WRITE_PF_TO_SP;
 
-	/*
-	 * Similar to above, prefetch faults aren't truly spurious, and the
-	 * async #PF path doesn't do emulation.  Do count faults that are fixed
-	 * by the async #PF handler though, otherwise they'll never be counted.
-	 */
-	if (r == RET_PF_FIXED)
-		vcpu->stat.pf_fixed++;
-	else if (prefetch)
-		;
-	else if (r == RET_PF_EMULATE)
-		vcpu->stat.pf_emulate++;
-	else if (r == RET_PF_SPURIOUS)
-		vcpu->stat.pf_spurious++;
 	return r;
 }
 
-- 

