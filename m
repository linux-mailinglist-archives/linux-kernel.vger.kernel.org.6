Return-Path: <linux-kernel+bounces-392799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D58A69B983E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C0601F20FFE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1F01D0499;
	Fri,  1 Nov 2024 19:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cpP66Lqc"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C79A1D0141
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730488500; cv=none; b=FTZHEF4z1qdWTnkNDkdFutIRqIcL90pR1t49GXnMSdhENu53VLwYKariOmrp62niNE8rw7r6e1uxfdsnW86BKhWi1UoIqKTGsDRxz+QmoEcaWFynveo9NNb+G7iMlPhqFAjFvMg3e7XdssBgkENXfUby1WHqKDymLdweUQ7Fi6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730488500; c=relaxed/simple;
	bh=jxo9Um4MNyRp6WJPIZhGVnb1qXFxFmLRqxQh0eevjEE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z9OXNF8FtTFmBMksrCPMqEoOKLiQgZZHJl574eRsMl/7EIhFiAlmceyEgGvbNISbnJVfv7l9RSH8QfF5PrUP3/kyGFgbxmtLX6Grra6lYg/2ejLpI76Yt4XrweAnQAYI0yJUhMcYHwgI1o4a/RCTs5GwCZgGs3JYeycJSjmvz9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cpP66Lqc; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-71e6241c002so2293644b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 12:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730488498; x=1731093298; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=EBjQChsQkGdvyBMJ4mZedLs9/EtB6ki+0LIpNzc1JfM=;
        b=cpP66Lqcvzu6DgaQMrk4QQb6+98To8U76187ywYqr9RGdt7fsA/cM7IT7RfVgJCIXK
         UiVrcWkYxZhyqf7+gJKnqtD57IMtItXARBUfMThyGlvVm8a5tA9xMBkOuSv5vrpSqUPb
         jZ0UZKBMDj1o5NGKFRkbHV55XdRSYCtWxtJ9Ky9P3WkMcZcZu8LLyt2A+T6iSYyk64fy
         bNLsZMQSRcr4V//ZQmHETXw5TEzxdSHebqq2ORLhkFMMNuVbM63qJcMHsT3p8YUj5sYX
         GKCPEna8u3gQgYyxf1hwUXwcQqQxfBB7iR44DgUYjS44KZI4FIoRroP5twW6emen5u3w
         l1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730488498; x=1731093298;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EBjQChsQkGdvyBMJ4mZedLs9/EtB6ki+0LIpNzc1JfM=;
        b=kfn1O2/qxOyQWmIqaTTFeaRsY/jJb120hkgAs4lVCIswfvuPlIEAZ1t1WB5YyAk62b
         ML0WE88TO2QMPhtySO1VtXqqlahKtA6O0eDLSEhBWlU4bIzb/Ou8tvG3C6wfqVEBvLjh
         oMBd6BUOsMoGpXUeZcepyeirdd8qlzBBDw/JCSHmKtpmM25y/7fWa5aqbuGgRSJeoI07
         j7XDtKW2AXhbbHpQQPf7anT8PlnOyhy9hhNz2X2UuIzF8ux0ytQnXve64orW6duOkG6u
         DGVIDAB4m/eInlmvL/MOQkWjDkJ1VJ2gJckfwnOKppDiqgZxU89Znq5e352OBvNt40PQ
         zO2g==
X-Forwarded-Encrypted: i=1; AJvYcCU4JwTJ6Ln+gPvsDYCmk6+B8SV7sRpSL4jLAfHB+Zb5gAJTN4vCnoCQ67VSfENjPt1/LGEv3VGQVyCK1cM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJJ2WDoRIXv3M57ZbxeQtSEZeKxr+rglLmit7McXKk9dxiKDg3
	DHwhkgtouy9fGLxGBTMY7J2HH4KtIUPk+0WyhyE2bz+d7Tv/7r4eA8DPNW4E3dd7Nu0Jwu6SECS
	cPQ==
X-Google-Smtp-Source: AGHT+IHfw1GQRMnZPA8VfH9+KSaVs33bq1UNe4WX1/RW4FnvMArjWdJh1n6jjxhCzBGh/CGN8O4meR5kuDc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:aa7:8183:0:b0:71e:4df8:a3e7 with SMTP id
 d2e1a72fcca58-720bc86b580mr19190b3a.2.1730488498550; Fri, 01 Nov 2024
 12:14:58 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  1 Nov 2024 12:14:46 -0700
In-Reply-To: <20241101191447.1807602-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241101191447.1807602-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241101191447.1807602-5-seanjc@google.com>
Subject: [PATCH 4/5] KVM: nVMX: Use vmcs01's controls shadow to check for
 IRQ/NMI windows at VM-Enter
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chao Gao <chao.gao@intel.com>
Content-Type: text/plain; charset="UTF-8"

Use vmcs01's execution controls shadow to check for IRQ/NMI windows after
a successful nested VM-Enter, instead of snapshotting the information prior
to emulating VM-Enter.  It's quite difficult to see that the entire reason
controls are snapshot prior nested VM-Enter is to read them from vmcs01
(vmcs02 is loaded if nested VM-Enter is successful).

That could be solved with a comment, but explicitly using vmcs01's shadow
makes the code self-documenting to a certain extent.

No functional change intended (vmcs01's execution controls must not be
modified during emulation of nested VM-Enter).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 4d20ab647876..0540faef0c85 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3486,7 +3486,6 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 	enum vm_entry_failure_code entry_failure_code;
-	bool evaluate_pending_interrupts;
 	union vmx_exit_reason exit_reason = {
 		.basic = EXIT_REASON_INVALID_STATE,
 		.failed_vmentry = 1,
@@ -3505,9 +3504,6 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 
 	kvm_service_local_tlb_flush_requests(vcpu);
 
-	evaluate_pending_interrupts = exec_controls_get(vmx) &
-		(CPU_BASED_INTR_WINDOW_EXITING | CPU_BASED_NMI_WINDOW_EXITING);
-
 	if (!vmx->nested.nested_run_pending ||
 	    !(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_DEBUG_CONTROLS))
 		vmx->nested.pre_vmenter_debugctl = vmcs_read64(GUEST_IA32_DEBUGCTL);
@@ -3590,9 +3586,11 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 	 * Re-evaluate pending events if L1 had a pending IRQ/NMI/INIT/SIPI
 	 * when it executed VMLAUNCH/VMRESUME, as entering non-root mode can
 	 * effectively unblock various events, e.g. INIT/SIPI cause VM-Exit
-	 * unconditionally.
+	 * unconditionally.  Take care to pull data from vmcs01 as appropriate,
+	 * e.g. when checking for interrupt windows, as vmcs02 is now loaded.
 	 */
-	if (unlikely(evaluate_pending_interrupts) ||
+	if ((__exec_controls_get(&vmx->vmcs01) & (CPU_BASED_INTR_WINDOW_EXITING |
+						  CPU_BASED_NMI_WINDOW_EXITING)) ||
 	    kvm_apic_has_pending_init_or_sipi(vcpu) ||
 	    kvm_apic_has_interrupt(vcpu))
 		kvm_make_request(KVM_REQ_EVENT, vcpu);
-- 
2.47.0.163.g1226f6d8fa-goog


