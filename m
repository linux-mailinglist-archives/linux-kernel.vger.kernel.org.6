Return-Path: <linux-kernel+bounces-206544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7737D900B36
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 19:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039DC1F23A98
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 17:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1216419DF68;
	Fri,  7 Jun 2024 17:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mby5aok0"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C4519D08B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 17:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717781184; cv=none; b=o/zvn8FU+tmeFF8JYLXd6IC2vzgDog8KWFufjwhI3CECqGbvb2NYIsRQ28Wiw2B+sVQhpOmRlQbve3nvs9E6l+4ENfJNyAwoUaD/6Qz8hS2ms+MEFXRPDKiaAOGgX7FL4TtFbYwMZ8tfoRTlay+UhUtG6GsHSBdgoQ63qxSK8K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717781184; c=relaxed/simple;
	bh=uwYtophU5hm1OXjOu+1eRsZ49jJfW6mqic9Ov3GeFFE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hLx+WxH9YFYADsM5odiC3zW6d3/H8W/O7prqneVUEYYQWFdQ6hQcMJe6KyQN3grfeEjyAfosJvtsNQWRI9Z2kwDu3TQ8e9xx8FRNrvFDtA1SD5rr2ulJMvb9YmYzSJ1Dj/jGw1YP+mLBBP45V7mes/6UgLLxUs23uHVeKK8Neuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mby5aok0; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-627956be166so44480087b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 10:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717781182; x=1718385982; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=I8tZ/gmYA7GBl7bf0FH2ZDf6II4rZkd3AyeJSBhZjy0=;
        b=Mby5aok0y7hgq4pYmKe9N0ihp3Nzrg6BLSfwbSRdDnjrwuC10bhVu2MLLvZ3LTV4Dg
         f1zj6jX131aH1je4+1YHSngGY7QYBd6u/MwubS/iQcHGPEvrW+bskEqpW2TZplPoTNek
         OfciX3x/uLBGJbgcZdRO7y7gkCGlpXqljT27ldw2HJ0kbPM+oB+c4IhlU8nT2GOGpDt2
         dklzwajAnisneEorQVi/5EaTn93+eVqFtGJHrYbdk0iWdcx3yRVlQyj3bKTGA7SkZBkO
         tEm2pEyzZWEgFaa/cNh029Y5VaSbk+3VX598P2kU7Roccua8xAaoRMeAQuSwA26hqzKa
         xzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717781182; x=1718385982;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I8tZ/gmYA7GBl7bf0FH2ZDf6II4rZkd3AyeJSBhZjy0=;
        b=rsvG900Lx+2eXsX3pRwrDASMNh3opB/jAyY7BRUDW/CkjVfdiUpDjb4Pqz1SE/37gx
         +QupjybXwBso/u5HiLgFFheCMvXI9ySkACr/rEdonk2ynXMX4fLlsBZbJqF9ealFjYO5
         rlwT4irTQeQz/7jeQh8IQHrZdvRNdTomq4QgYzwoJV/cZrVeM4uw6nGojWBGutE88msa
         XV3oWHG+UXurdFvsbJEEobNM5hf7D4lPSGRJ7Shd7xfUfnccOmsZAUcFQa2unoawV9ba
         WDRk9qHc57VuzkQuFofNPjthOFL4BjyHXs2WmKk3EM15peUxQbYa5XY+TjEpcUOp7hti
         BuNA==
X-Forwarded-Encrypted: i=1; AJvYcCWyMkPOzuAKCnQVGPqm0THBnAu+hlxoGvwkwjnxewR8zFIG2RAi74n4B/1qhXYOLBJzHy6Bj/5G5qZxsuaJNYpBKGt0+aovEc59wZbg
X-Gm-Message-State: AOJu0Yyu+cJNDB6EdS7SfUUwMibf665wAh7r/e4+4jBPsSi8fMWe+1Km
	djTYgwxegTlDIF0X/Cy7MghW/uMnbswVP0z23BKs8GlKbE4ZhwkvIUxDEHt4SP+TSeXroEuiMXi
	4LQ==
X-Google-Smtp-Source: AGHT+IHq6Ghjo627j1Ecg2DhQ0n1iZ2HoaZY1uPibDZ9DVJi3CFE2EBpX4AmWstOchENiKKMUNfrl6GA3KM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:6410:b0:62c:c56c:94c3 with SMTP id
 00721157ae682-62cd546f5e8mr8160437b3.0.1717781181722; Fri, 07 Jun 2024
 10:26:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  7 Jun 2024 10:26:08 -0700
In-Reply-To: <20240607172609.3205077-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240607172609.3205077-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240607172609.3205077-6-seanjc@google.com>
Subject: [PATCH 5/6] KVM: nVMX: Fold requested virtual interrupt check into has_nested_events()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Check for a Requested Virtual Interrupt, i.e. a virtual interrupt that is
pending delivery, in vmx_has_nested_events() and drop the one-off
kvm_x86_ops.guest_apic_has_interrupt() hook.

In addition to dropping a superfluous hook, this fixes a bug where KVM
would incorrectly treat virtual interrupts _for L2_ as always enabled due
to kvm_arch_interrupt_allowed(), by way of vmx_interrupt_blocked(),
treating IRQs as enabled if L2 is active and vmcs12 is configured to exit
on IRQs, i.e. KVM would treat a virtual interrupt for L2 as a valid wake
event based on L1's IRQ blocking status.

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |  1 -
 arch/x86/include/asm/kvm_host.h    |  1 -
 arch/x86/kvm/vmx/main.c            |  1 -
 arch/x86/kvm/vmx/nested.c          |  4 ++++
 arch/x86/kvm/vmx/vmx.c             | 20 --------------------
 arch/x86/kvm/vmx/x86_ops.h         |  1 -
 arch/x86/kvm/x86.c                 | 10 +---------
 7 files changed, 5 insertions(+), 33 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 566d19b02483..f91d413d7de1 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -85,7 +85,6 @@ KVM_X86_OP_OPTIONAL(update_cr8_intercept)
 KVM_X86_OP(refresh_apicv_exec_ctrl)
 KVM_X86_OP_OPTIONAL(hwapic_irr_update)
 KVM_X86_OP_OPTIONAL(hwapic_isr_update)
-KVM_X86_OP_OPTIONAL_RET0(guest_apic_has_interrupt)
 KVM_X86_OP_OPTIONAL(load_eoi_exitmap)
 KVM_X86_OP_OPTIONAL(set_virtual_apic_mode)
 KVM_X86_OP_OPTIONAL(set_apic_access_page_addr)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 473f7e1d245c..f2336c646088 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1728,7 +1728,6 @@ struct kvm_x86_ops {
 	void (*refresh_apicv_exec_ctrl)(struct kvm_vcpu *vcpu);
 	void (*hwapic_irr_update)(struct kvm_vcpu *vcpu, int max_irr);
 	void (*hwapic_isr_update)(int isr);
-	bool (*guest_apic_has_interrupt)(struct kvm_vcpu *vcpu);
 	void (*load_eoi_exitmap)(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap);
 	void (*set_virtual_apic_mode)(struct kvm_vcpu *vcpu);
 	void (*set_apic_access_page_addr)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index d0e1a5b5c915..7e846a842443 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -97,7 +97,6 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 	.required_apicv_inhibits = VMX_REQUIRED_APICV_INHIBITS,
 	.hwapic_irr_update = vmx_hwapic_irr_update,
 	.hwapic_isr_update = vmx_hwapic_isr_update,
-	.guest_apic_has_interrupt = vmx_guest_apic_has_interrupt,
 	.sync_pir_to_irr = vmx_sync_pir_to_irr,
 	.deliver_interrupt = vmx_deliver_interrupt,
 	.dy_apicv_has_pending_interrupt = pi_has_pending_interrupt,
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 3bac65591f20..2392a7ef254d 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4060,6 +4060,10 @@ static bool vmx_has_nested_events(struct kvm_vcpu *vcpu, bool for_injection)
 
 	vppr = *((u32 *)(vapic + APIC_PROCPRI));
 
+	max_irr = vmx_get_rvi();
+	if ((max_irr & 0xf0) > (vppr & 0xf0))
+		return true;
+
 	if (vmx->nested.pi_pending && vmx->nested.pi_desc &&
 	    pi_test_on(vmx->nested.pi_desc)) {
 		max_irr = pi_find_highest_vector(vmx->nested.pi_desc);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index d8d9e1f6c340..c7558bcb0241 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4106,26 +4106,6 @@ void pt_update_intercept_for_msr(struct kvm_vcpu *vcpu)
 	}
 }
 
-bool vmx_guest_apic_has_interrupt(struct kvm_vcpu *vcpu)
-{
-	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	void *vapic_page;
-	u32 vppr;
-	int rvi;
-
-	if (WARN_ON_ONCE(!is_guest_mode(vcpu)) ||
-		!nested_cpu_has_vid(get_vmcs12(vcpu)) ||
-		WARN_ON_ONCE(!vmx->nested.virtual_apic_map.gfn))
-		return false;
-
-	rvi = vmx_get_rvi();
-
-	vapic_page = vmx->nested.virtual_apic_map.hva;
-	vppr = *((u32 *)(vapic_page + APIC_PROCPRI));
-
-	return ((rvi & 0xf0) > (vppr & 0xf0));
-}
-
 void vmx_msr_filter_changed(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index 502704596c83..d404227c164d 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -49,7 +49,6 @@ void vmx_apicv_pre_state_restore(struct kvm_vcpu *vcpu);
 bool vmx_check_apicv_inhibit_reasons(enum kvm_apicv_inhibit reason);
 void vmx_hwapic_irr_update(struct kvm_vcpu *vcpu, int max_irr);
 void vmx_hwapic_isr_update(int max_isr);
-bool vmx_guest_apic_has_interrupt(struct kvm_vcpu *vcpu);
 int vmx_sync_pir_to_irr(struct kvm_vcpu *vcpu);
 void vmx_deliver_interrupt(struct kvm_lapic *apic, int delivery_mode,
 			   int trig_mode, int vector);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 5ec24d9cb231..82442960b499 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13133,12 +13133,6 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 		kvm_arch_free_memslot(kvm, old);
 }
 
-static inline bool kvm_guest_apic_has_interrupt(struct kvm_vcpu *vcpu)
-{
-	return (is_guest_mode(vcpu) &&
-		static_call(kvm_x86_guest_apic_has_interrupt)(vcpu));
-}
-
 static inline bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)
 {
 	if (!list_empty_careful(&vcpu->async_pf.done))
@@ -13172,9 +13166,7 @@ static inline bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)
 	if (kvm_test_request(KVM_REQ_UPDATE_PROTECTED_GUEST_STATE, vcpu))
 		return true;
 
-	if (kvm_arch_interrupt_allowed(vcpu) &&
-	    (kvm_cpu_has_interrupt(vcpu) ||
-	    kvm_guest_apic_has_interrupt(vcpu)))
+	if (kvm_arch_interrupt_allowed(vcpu) && kvm_cpu_has_interrupt(vcpu))
 		return true;
 
 	if (kvm_hv_has_stimer_pending(vcpu))
-- 
2.45.2.505.gda0bf45e8d-goog


