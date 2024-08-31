Return-Path: <linux-kernel+bounces-309602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0110B966D55
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 02:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC0E9285231
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 00:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D278CAD2D;
	Sat, 31 Aug 2024 00:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jHFiApLp"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50B25C8FC
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 00:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725063372; cv=none; b=rAb3D6sjElAJymryBcX0WiNeCksPIg2R112J1kTRVaJ1xY6lXdwEXl7PS/bICZfVJlaYoHi2poR914od6AsjNgakgarSBklsrH8mMG2gm3EhDWI7v2cV5fDCKxVlzHnzDc5UTEBAOBM+6l6cKSGDGhAUAb/e//KzxsN96ro1WnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725063372; c=relaxed/simple;
	bh=uB8TtNeHx27Ad7EM5biaxlZheZEshJ2mMvs5MEtYNi4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KlPymuLhtGko8fSx3dcQqXF9O0akIj8km86HCeupbFDv7jKFllGUWcU/eMt49gvLNUf1vwpUDKo5GXOD4EwkK9coFGIGVYmNXV+qP1cjpPlKWgxVTMdJaROGyRgaLHfLivbFsXl1aqaxA9OH+dxEQp/3cm6IW33F/xrtT5URhCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jHFiApLp; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-714290c2b34so2321128b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 17:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725063370; x=1725668170; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=9O4VEwldMzhpZYdn76eUeYyG7aK2ZiOdW5UELJTylQg=;
        b=jHFiApLpCRUo8xRYDgJtKyqNk7XnmPjUX4PCYfQuEKViL5h4HT6fkJwUzJ2Qm9uA61
         a+jKdWS8ZREMNT9XJy9Opvm1HTYAnUshHZqLd66vYKp4oJPBLEBfcjr31nL6sKcTn8Df
         tDceGS7gVkbaEyqxPpOK5pzDNrsSktjEo1ScIp0QqqGsy52m1z8x+iEtKcbKHGZQj9rQ
         8WEJTfARdI++iMlO3awEhNJRKcg7JM4w/BgNarqHRcXSI2ymivZF8TTh8x09zVgBy0vx
         9hB6fkrIjaIAX5FftWDWy6jCpPsqzOxQBQKTbzcOCmVHm8dbmmTWcJtCJoD4rDNKem/4
         W7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725063370; x=1725668170;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9O4VEwldMzhpZYdn76eUeYyG7aK2ZiOdW5UELJTylQg=;
        b=cktaQD7rtybJlzXC7Sy1vyyY6jG1E02N438QqSHrhDzLXr32Cq40Qh+r85evlmA9Wo
         turt2asm5ae9u26S9a7+50VuJ+uUqegCuPTQa1uoHIDmpEPQTj5briDTLNkgjRk+7nZG
         idlufVhAxYCHZS6zRkny8+Ye+5f/oZFRF5tNlGTVYcEAvMlxddFd6hFVpRuUOOTdQQdt
         sh32S+4KbMgtCGLgQLG+fHXv94x8z5E+BPLH0USZe+8kj+d91UCOhZFtNlZpbklvQx9L
         yFG+ewkSn4iAHUGsAYh0O95u07pKYUOL0GuctLM0Y9x6ynodjvPQmaOJEWY/Pa659XQc
         U8qA==
X-Forwarded-Encrypted: i=1; AJvYcCVnP68gNGtf8I+i01cCaSII+w1gz60tcNMfmrO/6PWJJKG6lHltmssRd21OuVS5Eh8TeorjVsk464g9lsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4mi3e939dGZl88Z5uPCHyMoDuzv4HTjjZ6kqwbd1pyWrFQA6A
	3RadS6PBdoiFT9diQNJefUIjQePct/jt36oy/z2CrAXJojqIg/SNUI/J1rrrEjvEZ6JGg5DDQZ+
	2Rg==
X-Google-Smtp-Source: AGHT+IGVv3c3jcB0r49a4HwlSnaEQWbUvEgEsWoVSM9vX8DyBoJnaCsk9OSnitGCy817N8L5rs5wpa/NxsM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:aa7:9383:0:b0:714:184b:b2de with SMTP id
 d2e1a72fcca58-7170677fd42mr15341b3a.1.1725063369831; Fri, 30 Aug 2024
 17:16:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Aug 2024 17:15:29 -0700
In-Reply-To: <20240831001538.336683-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240831001538.336683-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240831001538.336683-15-seanjc@google.com>
Subject: [PATCH v2 14/22] KVM: x86/mmu: Move event re-injection
 unprotect+retry into common path
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yuan Yao <yuan.yao@intel.com>, Yuan Yao <yuan.yao@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Move the event re-injection unprotect+retry logic into
kvm_mmu_write_protect_fault(), i.e. unprotect and retry if and only if
the #PF actually hit a write-protected gfn.  Note, there is a small
possibility that the gfn was unprotected by a different tasking between
hitting the #PF and acquiring mmu_lock, but in that case, KVM will resume
the guest immediately anyways because KVM will treat the fault as spurious.

As a bonus, unprotecting _after_ handling the page fault also addresses the
case where the installing a SPTE to handle fault encounters a shadowed PTE,
i.e. *creates* a read-only SPTE.

Opportunstically add a comment explaining what on earth the intent of the
code is, as based on the changelog from commit 577bdc496614 ("KVM: Avoid
instruction emulation when event delivery is pending").

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index b89e2c63b435..4910ac3d7f83 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2743,23 +2743,6 @@ bool kvm_mmu_unprotect_gfn_and_retry(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa)
 	return r;
 }
 
-static int kvm_mmu_unprotect_page_virt(struct kvm_vcpu *vcpu, gva_t gva)
-{
-	gpa_t gpa;
-	int r;
-
-	if (vcpu->arch.mmu->root_role.direct)
-		return 0;
-
-	gpa = kvm_mmu_gva_to_gpa_write(vcpu, gva, NULL);
-	if (gpa == INVALID_GPA)
-		return 0;
-
-	r = kvm_mmu_unprotect_page(vcpu->kvm, gpa >> PAGE_SHIFT);
-
-	return r;
-}
-
 static void kvm_unsync_page(struct kvm *kvm, struct kvm_mmu_page *sp)
 {
 	trace_kvm_mmu_unsync_page(sp);
@@ -4630,8 +4613,6 @@ int kvm_handle_page_fault(struct kvm_vcpu *vcpu, u64 error_code,
 	if (!flags) {
 		trace_kvm_page_fault(vcpu, fault_address, error_code);
 
-		if (kvm_event_needs_reinjection(vcpu))
-			kvm_mmu_unprotect_page_virt(vcpu, fault_address);
 		r = kvm_mmu_page_fault(vcpu, fault_address, error_code, insn,
 				insn_len);
 	} else if (flags & KVM_PV_REASON_PAGE_NOT_PRESENT) {
@@ -6039,8 +6020,15 @@ static int kvm_mmu_write_protect_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 	 * Note, this code also applies to Intel CPUs, even though it is *very*
 	 * unlikely that an L1 will share its page tables (IA32/PAE/paging64
 	 * format) with L2's page tables (EPT format).
+	 *
+	 * For indirect MMUs, i.e. if KVM is shadowing the current MMU, try to
+	 * unprotect the gfn and retry if an event is awaiting reinjection.  If
+	 * KVM emulates multiple instructions before completing event injection,
+	 * the event could be delayed beyond what is architecturally allowed,
+	 * e.g. KVM could inject an IRQ after the TPR has been raised.
 	 */
-	if (direct && is_write_to_guest_page_table(error_code) &&
+	if (((direct && is_write_to_guest_page_table(error_code)) ||
+	     (!direct && kvm_event_needs_reinjection(vcpu))) &&
 	    kvm_mmu_unprotect_gfn_and_retry(vcpu, cr2_or_gpa))
 		return RET_PF_RETRY;
 
-- 
2.46.0.469.g59c65b2a67-goog


