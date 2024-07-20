Return-Path: <linux-kernel+bounces-257740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D8E937E56
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 02:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FF291F2517D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 00:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0104A20;
	Sat, 20 Jul 2024 00:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XtFm8MyP"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B96168A8
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 00:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721433708; cv=none; b=I8e3O0LqcKPbDrBUvNoX+AdSBLAmVjuUJ/YSHZwQiPlgak0Mws+K38eVZ8E4ezXIYbSHQHlNskS6RFaRo2asZs5lrhMU8V9ZdkJy6QAdwgJOmWQWkdWuQEjULQtubEdYrqlghpLjx5sa86bCJxHuiWtbcthaOjwrdtbqDXAa6uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721433708; c=relaxed/simple;
	bh=7mQTa61PZtBwiRxGctia5whN8AZ0Ed/jRJUe6bo2Il4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GiHrU2PDpm30qAE/JMxkNSxdXEdzqiq9blW/gOB6jYagZsEkkOKUU8KEMOGBa+6F57Iy9fBiRmQND3d70nzxSmGoawjS7vcz96Hv55qRTICQ2F3shQQ15hmKW808iEWBtTNvzmGZVIMWu1t1UvlVz9vUC3tMcF86KA1LuxAvGIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XtFm8MyP; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-70af09a7393so1268938b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 17:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721433706; x=1722038506; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8nEJGUTtQkRbHuCUQxI9jEBCLpYOzXNb1LzkzPL7F0=;
        b=XtFm8MyPT54gy4ttbL4SVBI11dZjEOhP6wr0HUo/gRVqZ09nLfZPXG/NOM1rf67WmY
         lGOzvETBmvjpYsZ1vdOLMhSeO6FEUFG6z6eQopCgBPM2Za5xNbGMQLE6kbzh2hyUoM1J
         MF+CCAy19EqZ4qAf6FgkwzeppckCCvi9ojkvVuBaNWtFDl+IOkzj6A9M/cZxRkxLF6VM
         thEuZdI6bJRmBfNM3mjAgT8OdoeMESGz8h05fTQvfO5cYLg/ypajVey6GPSfg27Tvvma
         a/jznlTKO3uUwZ1sEewfcGL4yu/NYDxc8E3kJdzxEMz8Aj6HC2wtd625dRhEFfsBayDd
         bwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721433706; x=1722038506;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z8nEJGUTtQkRbHuCUQxI9jEBCLpYOzXNb1LzkzPL7F0=;
        b=azB91cdSBCHmRQ2o5hmrqhWdkhgTXQvcENUnvvMhKqjeSBmuCxCI2w713WN06zWUF0
         /YCKcyuIpTrnovk1GILsP540sXaRw4Lpal1fUK4OD63xIpa4UhZM/VcdAElKrJbQr4Hx
         R1uS2s3vLm1PMCSRackEPwz6U21DcMXEkRuBIVZe3qYUqd7l/vQ6A87vwlLZr8xY8Xzw
         AeoULzumNVCd1Nk1KDMvj9kozOQAhNLUijiGZ7CUl/Ua92kI8wSg9f4euRrh3eu2HGTx
         HDQw9WTYl3gw2wGwesJZgBk8l3egmYu+rfe3Rs36+eU+0/k17UKe4WNL6bxKfwa4KhdK
         mQgw==
X-Forwarded-Encrypted: i=1; AJvYcCVjjuy9HFHP9V1FUbwCg78DTJUpJ9FuYLJtf0PrES5rFRgXlrR7kwg4DxpAMrb7MJ1a/8pj/zmUWT39vvcAUnbXyyjESNEZ+VSN/Waw
X-Gm-Message-State: AOJu0YyanNaPzMEajF3hIQ5TCuo4l0FUph6NC7NMZR3YL6mvZ+u2qceL
	ptX9XYA4++aN19pZf8TVnXcpCajT9nSaol3/3E17IEsV7fo20n3H8xvKPxpNCZ7nEhJTvsEsjvp
	fgg==
X-Google-Smtp-Source: AGHT+IHBNdDWmftYOoI5/TwktwN/tsSwZnPxe85iyDJlZC8uIE6OS/b9FRsmrRoEzAgV+Vv2N6MWQZrt4Ys=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a62:b51a:0:b0:70a:ffa2:bb14 with SMTP id
 d2e1a72fcca58-70d0861f930mr6498b3a.2.1721433705873; Fri, 19 Jul 2024 17:01:45
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Jul 2024 17:01:35 -0700
In-Reply-To: <20240720000138.3027780-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240720000138.3027780-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240720000138.3027780-4-seanjc@google.com>
Subject: [PATCH 3/6] KVM: x86: Don't move VMX's nested PI notification vector
 from IRR to ISR
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chao Gao <chao.gao@intel.com>, Zeng Guang <guang.zeng@intel.com>
Content-Type: text/plain; charset="UTF-8"

When getting an IRQ from the local APIC, don't move the vector to the ISR
and skip the PPR update if the found vector is the vCPU's nested posted
interrupt notification vector, i.e. if the IRQ should trigger posted
interrupt processing in L2 instead of being deliver to L1.

For now, pass in -1 from all callers and defer passing the actual nested
notification vector to a separate patch, as more prep work is needed.

Functionally, this should be a glorified nop, i.e. no true functional
change intended.

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/irq.c              |  6 +++---
 arch/x86/kvm/lapic.c            | 12 ++++++++++--
 arch/x86/kvm/lapic.h            |  2 +-
 arch/x86/kvm/vmx/nested.c       |  2 +-
 arch/x86/kvm/x86.c              |  2 +-
 6 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 950a03e0181e..b40703f05b27 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2251,7 +2251,7 @@ int kvm_cpu_has_injectable_intr(struct kvm_vcpu *v);
 int kvm_cpu_has_interrupt(struct kvm_vcpu *vcpu);
 int kvm_cpu_has_extint(struct kvm_vcpu *v);
 int kvm_arch_interrupt_allowed(struct kvm_vcpu *vcpu);
-int kvm_cpu_get_interrupt(struct kvm_vcpu *v);
+int kvm_cpu_get_interrupt(struct kvm_vcpu *v, int nested_pi_nv);
 void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event);
 
 int kvm_pv_send_ipi(struct kvm *kvm, unsigned long ipi_bitmap_low,
diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index 3d7eb11d0e45..69d04d80f143 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -135,13 +135,13 @@ static int kvm_cpu_get_extint(struct kvm_vcpu *v)
 /*
  * Read pending interrupt vector and intack.
  */
-int kvm_cpu_get_interrupt(struct kvm_vcpu *v)
+int kvm_cpu_get_interrupt(struct kvm_vcpu *v, int nested_pi_nv)
 {
 	int vector = kvm_cpu_get_extint(v);
 	if (vector != -1)
-		return vector;			/* PIC */
+		return vector;				/* PIC */
 
-	return kvm_get_apic_interrupt(v);	/* APIC */
+	return kvm_get_apic_interrupt(v, nested_pi_nv);	/* APIC */
 }
 EXPORT_SYMBOL_GPL(kvm_cpu_get_interrupt);
 
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index a7172ba59ad2..c5c4473f50f6 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2924,7 +2924,7 @@ void kvm_inject_apic_timer_irqs(struct kvm_vcpu *vcpu)
 	}
 }
 
-int kvm_get_apic_interrupt(struct kvm_vcpu *vcpu)
+int kvm_get_apic_interrupt(struct kvm_vcpu *vcpu, int nested_pi_nv)
 {
 	int vector = kvm_apic_has_interrupt(vcpu);
 	struct kvm_lapic *apic = vcpu->arch.apic;
@@ -2939,8 +2939,16 @@ int kvm_get_apic_interrupt(struct kvm_vcpu *vcpu)
 	 * on exit" mode.  Then we cannot inject the interrupt via RVI,
 	 * because the process would deliver it through the IDT.
 	 */
-
 	apic_clear_irr(vector, apic);
+
+	/*
+	 * If the vector is L2's posted interrupt notification vector, return
+	 * without moving the vector to the ISR, as notification interrupts
+	 * trigger processing in L2, i.e. aren't delivered to L1.
+	 */
+	if (vector == nested_pi_nv)
+		return vector;
+
 	if (kvm_hv_synic_auto_eoi_set(vcpu, vector)) {
 		/*
 		 * For auto-EOI interrupts, there might be another pending
diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index 7ef8ae73e82d..c8ff3bd2ce2c 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -89,7 +89,7 @@ void kvm_free_lapic(struct kvm_vcpu *vcpu);
 
 int kvm_apic_has_interrupt(struct kvm_vcpu *vcpu);
 int kvm_apic_accept_pic_intr(struct kvm_vcpu *vcpu);
-int kvm_get_apic_interrupt(struct kvm_vcpu *vcpu);
+int kvm_get_apic_interrupt(struct kvm_vcpu *vcpu, int nested_pi_nv);
 int kvm_apic_accept_events(struct kvm_vcpu *vcpu);
 void kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init_event);
 u64 kvm_lapic_get_cr8(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index b042b70560f2..7e0a944088eb 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4294,7 +4294,7 @@ static int vmx_check_nested_events(struct kvm_vcpu *vcpu)
 		if (nested_exit_intr_ack_set(vcpu)) {
 			int irq;
 
-			irq = kvm_cpu_get_interrupt(vcpu);
+			irq = kvm_cpu_get_interrupt(vcpu, -1);
 			if (WARN_ON_ONCE(irq < 0))
 				goto no_vmexit;
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index af6c8cf6a37a..4c14ea000e89 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10548,7 +10548,7 @@ static int kvm_check_and_inject_events(struct kvm_vcpu *vcpu,
 		if (r < 0)
 			goto out;
 		if (r) {
-			int irq = kvm_cpu_get_interrupt(vcpu);
+			int irq = kvm_cpu_get_interrupt(vcpu, -1);
 
 			if (!WARN_ON_ONCE(irq == -1)) {
 				kvm_queue_interrupt(vcpu, irq, false);
-- 
2.45.2.1089.g2a221341d9-goog


