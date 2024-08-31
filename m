Return-Path: <linux-kernel+bounces-309592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B43CA966D40
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 02:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68BF3284E30
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 00:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0611C6B5;
	Sat, 31 Aug 2024 00:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PNhw/taa"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A340817545
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 00:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725063352; cv=none; b=o/ZpozqMWQdao6diZQJdOPGfjO33WkyVoK9c+mBQgIM3VICJjRgMjnkWXgwPsJpn05bCC1Ucz+rkEQpnNFvN1zOajhSVuqyAaDTJmXqemiXokZwFsF8LSkudhAZ78YdNrlv3C/PbYxoh1IxHwacq8JelUdW28TFKzzvSndRgo9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725063352; c=relaxed/simple;
	bh=Vfn4sap7F12KSn6gEqe3OjOMjrYNlixw+DuYUTSraC8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uHzvLBhlJKXxJahlIf9rsUIbMFFSxeoqlqPX8gLRMa5UgTfm1+YgDVvAldEHMYpMfLEVV73KL4R6ozFrUHlZYmtKyiCQhDCgRX503f1hyy+C6ccJnBwoveTw0GAz//FY++hCET5SgGRcVs+oqHq6aDB9YUZrssLMwT+17PEguEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PNhw/taa; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6b3fec974e5so45078897b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 17:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725063348; x=1725668148; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=r3dfY8/fDEjK6mVegBOh3Hcv+cOkuxjVRlEEYnL1bxw=;
        b=PNhw/taaNcf5TffgHlDIn99eeOHOCbf7GefvwEfAWI+G3nSOnzSbFzIm7vyt70zKEW
         8yPck86N6nOHfU7fFxvwlJCfc/bJb9TmvW+gO4JI2YrN5X3J8a6+p3AcBh/R8FV6TyjZ
         Ym3g1U5uAGZgRTtpoQsbNEqU5ZBqL4On0KxoTpYcLRtK5+uqwwOQ8i1LuyLA60y0RJ7K
         A8ro/5/XCz3YQ82AgVduK6JCGKDoCOoLTyeFZKr7nO7j16xXBxRbOfEdeJpK1IyjBMbN
         xVOvcv/xdi+8VbOS+OkvIKconJF+wtqhc+uOsMnXokdxXik6e+GaYgdwtpXFWDeJYtNV
         sSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725063348; x=1725668148;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r3dfY8/fDEjK6mVegBOh3Hcv+cOkuxjVRlEEYnL1bxw=;
        b=s/nX69jJq1BZYiZnsR5enbfhRCSy2szKmkdlDxuDXvGClIk4MlPKfBcQGKSVCyOJad
         ePgctcu07PfrMMqavAXgYtsZ2FYzkPR3XBfzJggWEwGfEKnlDZMCEw9jCTXCSA/TZMJ+
         yDhTrSlFH9PjJTsK7haoIG/VvZx2/2MLcoSVUvZQcTxGsbNc3hIHutqtcpntjok7pWkF
         8EKJWjtUJz7+FBHy+hAVlRF7gs8lEk9/3+48feRiPR1BUjGJfIU4NgW9J9KJ8VS2nwC4
         ADCXmAptyzSECgRZVvVKT1OhByc8xyu9J8C2XNbKt3vjXm4LtSjhG7myYxcY3JEb4aIL
         fl2A==
X-Forwarded-Encrypted: i=1; AJvYcCWk70qvMksO44fVLrwZzskEHztipC9Ii37dO5H4vIY5/zabGoVLfltKjXkCBr3afO3LsQ97C+k+QIqMnqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXGvu7S42vmWPSM/REG5T+RERvBOEsf458ehPZnlNkOk9ivNYA
	QDyr1PNYITb0SRIdBhXSwKKUqd+y5f/uzvR65EwX0xQst3OGYhnUFBaDToxBCUhSRPtLd1JEtCh
	ctQ==
X-Google-Smtp-Source: AGHT+IEX38k43fNniAUT9zZ10fu//L1yrfO75qcNhigMQXRQOpLzwXTrY/RTolEek0hddCoQ2pigQLcJwJ0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:2884:b0:6b2:6cd4:7f98 with SMTP id
 00721157ae682-6d4102f7068mr572167b3.8.1725063348631; Fri, 30 Aug 2024
 17:15:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Aug 2024 17:15:19 -0700
In-Reply-To: <20240831001538.336683-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240831001538.336683-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240831001538.336683-5-seanjc@google.com>
Subject: [PATCH v2 04/22] KVM: x86/mmu: Skip emulation on page fault iff 1+
 SPs were unprotected
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yuan Yao <yuan.yao@intel.com>, Yuan Yao <yuan.yao@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

When doing "fast unprotection" of nested TDP page tables, skip emulation
if and only if at least one gfn was unprotected, i.e. continue with
emulation if simply resuming is likely to hit the same fault and risk
putting the vCPU into an infinite loop.

Note, it's entirely possible to get a false negative, e.g. if a different
vCPU faults on the same gfn and unprotects the gfn first, but that's a
relatively rare edge case, and emulating is still functionally ok, i.e.
saving a few cycles by avoiding emulation isn't worth the risk of putting
the vCPU into an infinite loop.

Opportunistically rewrite the relevant comment to document in gory detail
exactly what scenario the "fast unprotect" logic is handling.

Fixes: 147277540bbc ("kvm: svm: Add support for additional SVM NPF error codes")
Cc: Yuan Yao <yuan.yao@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 57692d873f76..6b5f80f38a95 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5959,16 +5959,37 @@ static int kvm_mmu_write_protect_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 	bool direct = vcpu->arch.mmu->root_role.direct;
 
 	/*
-	 * Before emulating the instruction, check if the error code
-	 * was due to a RO violation while translating the guest page.
-	 * This can occur when using nested virtualization with nested
-	 * paging in both guests. If true, we simply unprotect the page
-	 * and resume the guest.
+	 * Before emulating the instruction, check to see if the access was due
+	 * to a read-only violation while the CPU was walking non-nested NPT
+	 * page tables, i.e. for a direct MMU, for _guest_ page tables in L1.
+	 * If L1 is sharing (a subset of) its page tables with L2, e.g. by
+	 * having nCR3 share lower level page tables with hCR3, then when KVM
+	 * (L0) write-protects the nested NPTs, i.e. npt12 entries, KVM is also
+	 * unknowingly write-protecting L1's guest page tables, which KVM isn't
+	 * shadowing.
+	 *
+	 * Because the CPU (by default) walks NPT page tables using a write
+	 * access (to ensure the CPU can do A/D updates), page walks in L1 can
+	 * trigger write faults for the above case even when L1 isn't modifying
+	 * PTEs.  As a result, KVM will unnecessarily emulate (or at least, try
+	 * to emulate) an excessive number of L1 instructions; because L1's MMU
+	 * isn't shadowed by KVM, there is no need to write-protect L1's gPTEs
+	 * and thus no need to emulate in order to guarantee forward progress.
+	 *
+	 * Try to unprotect the gfn, i.e. zap any shadow pages, so that L1 can
+	 * proceed without triggering emulation.  If one or more shadow pages
+	 * was zapped, skip emulation and resume L1 to let it natively execute
+	 * the instruction.  If no shadow pages were zapped, then the write-
+	 * fault is due to something else entirely, i.e. KVM needs to emulate,
+	 * as resuming the guest will put it into an infinite loop.
+	 *
+	 * Note, this code also applies to Intel CPUs, even though it is *very*
+	 * unlikely that an L1 will share its page tables (IA32/PAE/paging64
+	 * format) with L2's page tables (EPT format).
 	 */
-	if (direct && is_write_to_guest_page_table(error_code)) {
-		kvm_mmu_unprotect_page(vcpu->kvm, gpa_to_gfn(cr2_or_gpa));
+	if (direct && is_write_to_guest_page_table(error_code) &&
+	    kvm_mmu_unprotect_page(vcpu->kvm, gpa_to_gfn(cr2_or_gpa)))
 		return RET_PF_RETRY;
-	}
 
 	/*
 	 * The gfn is write-protected, but if emulation fails we can still
-- 
2.46.0.469.g59c65b2a67-goog


