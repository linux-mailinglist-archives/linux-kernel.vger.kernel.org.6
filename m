Return-Path: <linux-kernel+bounces-318121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F94196E8B0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 06:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D6621C222BA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 04:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BBC13D251;
	Fri,  6 Sep 2024 04:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="21Ht/jGS"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A12A139580
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 04:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725597267; cv=none; b=AJVq9S3w6FxTQL5kp4hNrofByJoKKlKnSwa2XOSIerySYWezMqtZV0fsA0i7F0sVQHq/glaq2Zid3uapRGZEWPfoJSXeyvgzAP1GuJvELATtbFFyDYLPqlHZcfAUYMavDAeSl1sM9P6B9O5Lk23AX3NbsdVp0b/L+mJ5ngLvSl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725597267; c=relaxed/simple;
	bh=4MxbT7g3aljkXYP/fW+/iJXROczzlwmWrxw5houVUTk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DD4JhNSaOEZCAkAA6Ts7R7RRtmY6i2ilGC/NkcgZ6nNFpCFda37lGKBpjVhCHwadJ2wi+p4ImziTo2CbwliFlTUrcfSkU2bzDi4FB6nGOo2MHcH0TbLB5dCkkbEazekELRnWu9abUBuMt4eC7I3zzAniNx4ZOqwLS6kSVvxnxuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=21Ht/jGS; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2053fd6240aso22031475ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 21:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725597265; x=1726202065; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=uJLB+hmA2IZBXvwBsppVhdrlAWLw+G5oD+o2j3BJ3I4=;
        b=21Ht/jGSmKnW6fbOPcXoEZImpHcwhBDCzwC8KNC53hqCtes7lW461AbgeVAA1VvBfa
         qkCj9+2Db9Bnlobh3vKKVl8P9LJgRapazgBmPtM2Pzqakw/Rz9qAAYxcdd8428h34WCk
         tvEs9d0geclRNyBXKxU/KtpkReDECOtnf8XBpwXBPntuBCNrouu4LnC+REuCR9NEw2Ib
         wvj0RDXc8/irtd0/zrxOMuJzub1NxB7580WvpjQyPRF/Ly7a0vHa7wq7LtTOMEsIMcGp
         B56M/+T+feZ7w+/Z09ywbFMc7TKy5gz4z2L5pMDYHQxej3K8cMoVkrF/5P0a2PAg1z5G
         zB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725597265; x=1726202065;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJLB+hmA2IZBXvwBsppVhdrlAWLw+G5oD+o2j3BJ3I4=;
        b=od1haSZRg+sNXEHKIxZWA7M2wgLUQCkfACgL+iDSGjrN2/pfb+RGNIz+iRAUsTW2X4
         OfQQzKgjKzAh3JgyXRTb930v1vi/Z6OxVeYmnVNCZYCqc2UNuuGBHw/JjaeEvC6P9T9g
         BybJalEjQLrpRH5Xlw3f2c605++B6uhivNwfUGx7PApv63vtlE2OPFY6qBjjtaD4pIcZ
         m9xePOCxE7E/gR3LpO8o3AAAPwWGAZt34oP0qh2O/k2UrfsTiTjfiqzcV0M1cSauLRJi
         n+6KGP1A9EkhYkwhLBMObj3ujzPUIRkkZe3q6DOAcdR/Thj7BMIv3Z6J2cYHZ8gaLPQN
         3mZA==
X-Forwarded-Encrypted: i=1; AJvYcCVJN5bUymxkDVCEWy2Gdll0MiVo/pyabGZg7mUoR1VKtJsK+OyUz8jRE/cNd6q467oErdu1COf94Y5YLxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzobnhDASQZ2ab7XI22M69FTlZrr3PVKmnL2ZNva4iuQORNmWw
	FTl9mW2XLaR68RbcKc0/Tz3AB1EW3l231WZsKrJeZXSLBz7+AiDFA0C6kPBjrr7FkqX8CN0DON9
	HeA==
X-Google-Smtp-Source: AGHT+IFNTtl3T3l+R72HDbqkIu5QcO5e1kVK+nJKPwOJDH0/aHbtdFACRdueBtk9SPJKGw5qbvPZQZGqRD0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:1ca:b0:206:aa07:b62 with SMTP id
 d9443c01a7336-206f05148abmr1064025ad.5.1725597264616; Thu, 05 Sep 2024
 21:34:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  5 Sep 2024 21:34:10 -0700
In-Reply-To: <20240906043413.1049633-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240906043413.1049633-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240906043413.1049633-5-seanjc@google.com>
Subject: [PATCH v2 4/7] KVM: nVMX: Detect nested posted interrupt NV at nested
 VM-Exit injection
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Chao Gao <chao.gao@intel.com>, 
	Zeng Guang <guang.zeng@intel.com>
Content-Type: text/plain; charset="UTF-8"

When synthensizing a nested VM-Exit due to an external interrupt, pend a
nested posted interrupt if the external interrupt vector matches L2's PI
notification vector, i.e. if the interrupt is a PI notification for L2.
This fixes a bug where KVM will incorrectly inject VM-Exit instead of
processing nested posted interrupt when IPI virtualization is enabled.

Per the SDM, detection of the notification vector doesn't occur until the
interrupt is acknowledge and deliver to the CPU core.

  If the external-interrupt exiting VM-execution control is 1, any unmasked
  external interrupt causes a VM exit (see Section 26.2). If the "process
  posted interrupts" VM-execution control is also 1, this behavior is
  changed and the processor handles an external interrupt as follows:

    1. The local APIC is acknowledged; this provides the processor core
       with an interrupt vector, called here the physical vector.
    2. If the physical vector equals the posted-interrupt notification
       vector, the logical processor continues to the next step. Otherwise,
       a VM exit occurs as it would normally due to an external interrupt;
       the vector is saved in the VM-exit interruption-information field.

For the most part, KVM has avoided problems because a PI NV for L2 that
arrives will L2 is active will be processed by hardware, and KVM checks
for a pending notification vector during nested VM-Enter.  Thus, to hit
the bug, the PI NV interrupt needs to sneak its way into L1's vIRR while
L2 is active.

Without IPI virtualization, the scenario is practically impossible to hit,
modulo L1 doing weird things (see below), as the ordering between
vmx_deliver_posted_interrupt() and nested VM-Enter effectively guarantees
that either the sender will see the vCPU as being in_guest_mode(), or the
receiver will see the interrupt in its vIRR.

With IPI virtualization, introduced by commit d588bb9be1da ("KVM: VMX:
enable IPI virtualization"), the sending CPU effectively implements a rough
equivalent of vmx_deliver_posted_interrupt(), sans the nested PI NV check.
If the target vCPU has a valid PID, the CPU will send a PI NV interrupt
based on _L1's_ PID, as the sender's because IPIv table points at L1 PIDs.

  PIR := 32 bytes at PID_ADDR;
  // under lock
  PIR[V] := 1;
  store PIR at PID_ADDR;
  // release lock

  NotifyInfo := 8 bytes at PID_ADDR + 32;
  // under lock
  IF NotifyInfo.ON = 0 AND NotifyInfo.SN = 0; THEN
    NotifyInfo.ON := 1;
    SendNotify := 1;
  ELSE
    SendNotify := 0;
  FI;
  store NotifyInfo at PID_ADDR + 32;
  // release lock

  IF SendNotify = 1; THEN
    send an IPI specified by NotifyInfo.NDST and NotifyInfo.NV;
  FI;

As a result, the target vCPU ends up receiving an interrupt on KVM's
POSTED_INTR_VECTOR while L2 is running, with an interrupt in L1's PIR for
L2's nested PI NV.  The POSTED_INTR_VECTOR interrupt triggers a VM-Exit
from L2 to L0, KVM moves the interrupt from L1's PIR to vIRR, triggers a
KVM_REQ_EVENT prior to re-entry to L2, and calls vmx_check_nested_events(),
effectively bypassing all of KVM's "early" checks on nested PI NV.

Without IPI virtualization, the bug can likely be hit only if L1 programs
an assigned device to _post_ an interrupt to L2's notification vector, by
way of L1's PID.PIR.  Doing so would allow the interrupt to get into L1's
vIRR without KVM checking vmcs12's NV.  Which is architecturally allowed,
but unlikely behavior for a hypervisor.

Cc: Zeng Guang <guang.zeng@intel.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 6b7e0ab0e45e..238c26155c2a 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4307,6 +4307,20 @@ static int vmx_check_nested_events(struct kvm_vcpu *vcpu)
 		if (WARN_ON_ONCE(irq < 0))
 			goto no_vmexit;
 
+		/*
+		 * If the IRQ is L2's PI notification vector, process posted
+		 * interrupts for L2 instead of injecting VM-Exit, as the
+		 * detection/morphing architecturally occurs when the IRQ is
+		 * delivered to the CPU.  Note, only interrupts that are routed
+		 * through the local APIC trigger posted interrupt processing,
+		 * and enabling posted interrupts requires ACK-on-exit.
+		 */
+		if (irq == vmx->nested.posted_intr_nv) {
+			vmx->nested.pi_pending = true;
+			kvm_apic_clear_irr(vcpu, irq);
+			goto no_vmexit;
+		}
+
 		nested_vmx_vmexit(vcpu, EXIT_REASON_EXTERNAL_INTERRUPT,
 				  INTR_INFO_VALID_MASK | INTR_TYPE_EXT_INTR | irq, 0);
 
-- 
2.46.0.469.g59c65b2a67-goog


