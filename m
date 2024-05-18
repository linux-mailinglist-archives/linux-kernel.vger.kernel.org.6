Return-Path: <linux-kernel+bounces-182715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C44D28C8EC6
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 02:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BB13281F72
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 00:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204372A1D6;
	Sat, 18 May 2024 00:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F9/Y6jJF"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5C422079
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 00:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715990690; cv=none; b=Lm71bAAtCaDiP99JWygQ6osI4E7+ZrbIyeo4mRm2AY5KBF1ngL4+0zN+A6gNsXIkuqLlofWITjwUYLvyRbeknxqSsljBjwsHq4g7LKZtsMv4VXEolCozC4rPcd5H2+lWb+hCa9eLOIGGRgi0xV82eB9YNJyGi+Ylf2w5MybrCcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715990690; c=relaxed/simple;
	bh=G0H1ZribibIRAeIPrcFsCyVZimPoXaBX2C7zZ9WKf10=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s5r9wYF34XMMmX6BtRej6oZwIz+WRO90x6H7ljQ5QbNSxUJlf4++MRiF7BltoeCEY7pArgwqEiA8QSUmXfUw3FyRWNzvCdY9yeUhCpXTSV6LeMCzjgBxFYlyVspH2iw+tOgY0hUlc6LuCvcUd4zZ2SGWZsNipaj8FeEULu3pHqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F9/Y6jJF; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2b4330e5119so7983238a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 17:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715990688; x=1716595488; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=F6tFR9z1vs8c6u2WtnRiVVbIp33RqmLFmChD3Ch8F40=;
        b=F9/Y6jJFhzewat4Cg4F+eQuIev0srhsroVkR8wbo1PmWIPhlRju6kAQkd2PzSkbUBz
         L3gYIcwPIFifCEn+9BgkbCv9ZHKKd/Qa6suXuu22bOWt/2Ev0MxEqzq6FUXnz/2mnlCq
         ZZD2z+xqNZ0xjnBWi7J7vK9lK611m6jtwKdNr0h3anFylsax9XOYwq8pMdq7osHyKzoZ
         gQbxapf4HX9Fp0AM+01Z1EmaVd76TN0QvN/Q53M/bFIktm1dCn4HrsGm1RTBMI4rwN9v
         SMSQzQXvsMm6YqD7Mm1RXT+pmAZ2oxp4SNJechiyHd/PoHdvlNu/kzTk5A7mI3x7tlR4
         wLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715990688; x=1716595488;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F6tFR9z1vs8c6u2WtnRiVVbIp33RqmLFmChD3Ch8F40=;
        b=FwGzOHvuQ/j+1jec74bGXCB+8pZxpf0z5/rjdYU9uR09sEGUlzTY5bLiseJTLBf6LU
         ZzmkMtgWgr/IiT0DxDhZouSqN8QPzDJeHXPYxtZWSFcRFf2XQCbE2GA7o7Un8w9nxbS+
         mMzctTr2OWDnNibX0huyoE/eNC2IJfG4O/nRaL1JSkxWNJQFKb9qEfPtCHVjzcDnjxDN
         Ffj3w/4AoD56Jo+cu93NVQdnLVbRJRycIlECvx7Jev2K8+lplXJi0hKwm01KTlgdZDkY
         7WBC3KdCnFReG3chfd1QvnbhqJXbN9S1+pb6zntaaRfhcnjLV57oLu3CHoVUwpFXAiXQ
         hMcw==
X-Forwarded-Encrypted: i=1; AJvYcCVa3bm4mRMyO83JOwgET69e2zzeHENPWf0ScdwSvpc+Aws0FFXqVzXZzq2oZVOn0eQMhs7SPkaeu1nxz55c/VwUEBJy7htmPSpiMH8l
X-Gm-Message-State: AOJu0YykuAM6VYZmimaZMOkoYSkeFjZSux/eGJHgT6n2gVgoQvBfsQmR
	85qUT/8PAJPHT4u95I5h1LkzuJyH35mz4g/2SQ+l7W5CSiBbDu/UYS6R5kXGIVw8o9Y+3HB4UH7
	SYA==
X-Google-Smtp-Source: AGHT+IHcIhWQz88cxjQfIWr9QqPrvA4yvrV/FRAF27BDNzjGzBtgW0NQ5/zWEknFAvdFH63hTP7V0CPnMDs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:9309:b0:2b2:ad92:da6d with SMTP id
 98e67ed59e1d1-2b6ccc73bbemr63870a91.4.1715990688132; Fri, 17 May 2024
 17:04:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 17 May 2024 17:04:27 -0700
In-Reply-To: <20240518000430.1118488-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240518000430.1118488-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240518000430.1118488-7-seanjc@google.com>
Subject: [PATCH 6/9] KVM: x86/mmu: Print SPTEs on unexpected #VE
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Print the SPTEs that correspond to the faulting GPA on an unexpected EPT
Violation #VE to help the user debug failures, e.g. to pinpoint which SPTE
didn't have SUPPRESS_VE set.

Opportunistically assert that the underlying exit reason was indeed an EPT
Violation, as the CPU has *really* gone off the rails if a #VE occurs due
to a completely unexpected exit reason.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/mmu/mmu.c          | 42 ++++++++++++++++++++++++++-------
 arch/x86/kvm/vmx/vmx.c          |  5 ++++
 3 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index aabf1648a56a..9bb2e164c523 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2159,6 +2159,7 @@ int kvm_emulate_hypercall(struct kvm_vcpu *vcpu);
 
 int kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 error_code,
 		       void *insn, int insn_len);
+void kvm_mmu_print_sptes(struct kvm_vcpu *vcpu, gpa_t gpa, const char *msg);
 void kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva);
 void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 			     u64 addr, unsigned long roots);
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index d2af077d8b34..f2c9580d9588 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4124,6 +4124,22 @@ static int get_walk(struct kvm_vcpu *vcpu, u64 addr, u64 *sptes, int *root_level
 	return leaf;
 }
 
+static int get_sptes_lockless(struct kvm_vcpu *vcpu, u64 addr, u64 *sptes,
+			      int *root_level)
+{
+	int leaf;
+
+	walk_shadow_page_lockless_begin(vcpu);
+
+	if (is_tdp_mmu_active(vcpu))
+		leaf = kvm_tdp_mmu_get_walk(vcpu, addr, sptes, root_level);
+	else
+		leaf = get_walk(vcpu, addr, sptes, root_level);
+
+	walk_shadow_page_lockless_end(vcpu);
+	return leaf;
+}
+
 /* return true if reserved bit(s) are detected on a valid, non-MMIO SPTE. */
 static bool get_mmio_spte(struct kvm_vcpu *vcpu, u64 addr, u64 *sptep)
 {
@@ -4132,15 +4148,7 @@ static bool get_mmio_spte(struct kvm_vcpu *vcpu, u64 addr, u64 *sptep)
 	int root, leaf, level;
 	bool reserved = false;
 
-	walk_shadow_page_lockless_begin(vcpu);
-
-	if (is_tdp_mmu_active(vcpu))
-		leaf = kvm_tdp_mmu_get_walk(vcpu, addr, sptes, &root);
-	else
-		leaf = get_walk(vcpu, addr, sptes, &root);
-
-	walk_shadow_page_lockless_end(vcpu);
-
+	leaf = get_sptes_lockless(vcpu, addr, sptes, &root);
 	if (unlikely(leaf < 0)) {
 		*sptep = 0ull;
 		return reserved;
@@ -5963,6 +5971,22 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_page_fault);
 
+void kvm_mmu_print_sptes(struct kvm_vcpu *vcpu, gpa_t gpa, const char *msg)
+{
+	u64 sptes[PT64_ROOT_MAX_LEVEL + 1];
+	int root_level, leaf, level;
+
+	leaf = get_sptes_lockless(vcpu, gpa, sptes, &root_level);
+	if (unlikely(leaf < 0))
+		return;
+
+	pr_err("%s %llx", msg, gpa);
+	for (level = root_level; level >= leaf; level--)
+		pr_cont(", spte[%d] = 0x%llx", level, sptes[level]);
+	pr_cont("\n");
+}
+EXPORT_SYMBOL_GPL(kvm_mmu_print_sptes);
+
 static void __kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 				      u64 addr, hpa_t root_hpa)
 {
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 0c68643d982b..2a3fce61c785 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5218,7 +5218,12 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu)
 		return handle_ud(vcpu);
 
 	if (KVM_BUG_ON(is_ve_fault(intr_info), vcpu->kvm)) {
+		struct vmx_ve_information *ve_info = vmx->ve_info;
+
+		WARN_ONCE(ve_info->exit_reason != EXIT_REASON_EPT_VIOLATION,
+			  "Unexpected #VE on VM-Exit reason 0x%x", ve_info->exit_reason);
 		dump_vmcs(vcpu);
+		kvm_mmu_print_sptes(vcpu, ve_info->guest_physical_address, "#VE");
 		return -EIO;
 	}
 
-- 
2.45.0.215.g3402c0e53f-goog


