Return-Path: <linux-kernel+bounces-348015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BEE98E18D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 19:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D0D61F25445
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 17:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C160D1D0F6F;
	Wed,  2 Oct 2024 17:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IbjqXHK2"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5857C1D0BB0
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 17:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727889616; cv=none; b=siyfrEfIZCZy5bw5EzPSx5v5p8norsCQY21cuu50HA/cie1zCxXOl1X/LKHtNxKOGHoOeeKRfL3agG3r217X8WVlGid/vMaDTqtKaZLmmX8mPvrhmlX/HTlnL5yIYePLNThwZr3lMv03lTHWxgtlQDcwWTJPfHlAY9atuK/o20c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727889616; c=relaxed/simple;
	bh=R4SspyOREhpRqw0U0DoPB6rQ4u2LCvhJhBxstmn19aA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Zr7qfrAMD2oPWgDiidWqoze1qZfUAyzPeBnHxbdaabFK+4BFpXlKsk5W3GMqD0we7JAbrvwGYU+ZQLrBZ/RHewLVJmz2lgkU1lbx3g++UOdEG+M7qw8C6yUo9Bg8SUyRGfCBY8KtK1qXD4n9V/mBrx6MtuFgwsZym+ZplV+PqtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IbjqXHK2; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d9e31e66eeso771617b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 10:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727889613; x=1728494413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/uCdyI8jS804JsslUk1rsNaBCSgvYPSl8E/59XMS004=;
        b=IbjqXHK2IqOJvbeX0/jsAiW2p1r8MrC/YTHti0scEkDGLLm+2xhtge1b3VdB7Tnjz9
         hFqfU+QSTaRQftwOW4avGPnerfuTDK/Gw6D023FNn2rTCYh3HZuI2GQr0v/LvpVGeqo/
         /4gWJ0WkGSWggjNXfc2yHyhM4FIZtJZDqL3lxZIYzJn/FdG6GgFZNVG5Ouw7DgtgzlYd
         SMLg2Vl4wY17ckIGA9VuuJjMdVECyeHs6ef1V2P9UbzBdux1EFVo4HhWVAUm6KZjIPo0
         GH2KNPN1ZACLVouohUyl4G85A4qNSR2m6REEujxU+g5nzphvmGaJSbHHUY9T4DTsCAvs
         geAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727889613; x=1728494413;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/uCdyI8jS804JsslUk1rsNaBCSgvYPSl8E/59XMS004=;
        b=jw9sbljhL2yJQEcLd5eIPOH9bE9jpmb7Jy4utQ6AJQCGmQ+rDgS+j7SJ+5Fe6U32S7
         jGJpC2DEAV8stMJEVwihkmSya4jz7nhxNJPidherlhnFmnFmxtn6fSfO12yPu8ZVSmLV
         mcOvwDsrPHnulcxAl82PKHI/dBdxkv9LSWXS4x22MX3XtRi9xJCKVaEAWN2WW1bmEIW/
         miizDE9BsyLZODl/04H6k0+eoDopFP/ZZTG4o+pfT8WMPcM5GYrl3kxJmpSZPAIXs43p
         UujNQCnpoRGI6yP6XMeL9BhNLyJzg5z6nlP3e0nZDwuha6oVwiBFAU0Zsa3BfTtcRFpy
         JcPg==
X-Forwarded-Encrypted: i=1; AJvYcCV5f37KkFMY9L4dqlHgccDPsKEX4nPrUMih6RTBUOF9hPBM1Q2uPkQGg1xP0Mw6KOKxWwHjL5DhvMRoBWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoVZzG1lzUdP5zPcxdzuCuK+ujCH3soO24ZLr1zJ3MbnO7rGuN
	YWIuyAIx1nyen8Dr1t1GcIEftvY4dfS5ZqN9XFTAPsis7tqN5m60C06RlFlyGBBMfpIgjdN9//i
	jYg==
X-Google-Smtp-Source: AGHT+IHTxB/8VT06nMzewGt7WwSwpKYJ7w64wy6nIv6mhyMEe5hYfA0MoR0becM2jWbBgW7TTsSnyvHcxIc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:10c7:b0:e24:a00a:518e with SMTP id
 3f1490d57ef6-e263840d766mr18373276.7.1727889613028; Wed, 02 Oct 2024 10:20:13
 -0700 (PDT)
Date: Wed, 2 Oct 2024 10:20:11 -0700
In-Reply-To: <Zv15trTQIBxxiSFy@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <Zu0vvRyCyUaQ2S2a@google.com> <20241002124324.14360-1-mankku@gmail.com>
 <Zv1gbzT1KTYpNgY1@google.com> <Zv15trTQIBxxiSFy@google.com>
Message-ID: <Zv2Ay9Y3TswTwW_B@google.com>
Subject: Re: [PATCH 1/1] KVM: nVMX: update VPPR on vmlaunch/vmresume
From: Sean Christopherson <seanjc@google.com>
To: "Markku =?utf-8?Q?Ahvenj=C3=A4rvi?=" <mankku@gmail.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	janne.karhunen@gmail.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, pbonzini@redhat.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02, 2024, Sean Christopherson wrote:
> On Wed, Oct 02, 2024, Sean Christopherson wrote:
> > On Wed, Oct 02, 2024, Markku Ahvenj=C3=A4rvi wrote:
> > > Hi Sean,
> > >=20
> > > > On Fri, Sep 20, 2024, Markku Ahvenj=C3=A4rvi wrote:
> > > > > Running certain hypervisors under KVM on VMX suffered L1 hangs af=
ter
> > > > > launching a nested guest. The external interrupts were not proces=
sed on
> > > > > vmlaunch/vmresume due to stale VPPR, and L2 guest would resume wi=
thout
> > > > > allowing L1 hypervisor to process the events.
> > > > >=20
> > > > > The patch ensures VPPR to be updated when checking for pending
> > > > > interrupts.
> > > >
> > > > This is architecturally incorrect, PPR isn't refreshed at VM-Enter.
> > >=20
> > > I looked into this and found the following from Intel manual:
> > >=20
> > > "30.1.3 PPR Virtualization
> > >=20
> > > The processor performs PPR virtualization in response to the followin=
g
> > > operations: (1) VM entry; (2) TPR virtualization; and (3) EOI virtual=
ization.
> > >=20
> > > ..."
> > >=20
> > > The section "27.3.2.5 Updating Non-Register State" further explains t=
he VM
> > > enter:
> > >=20
> > > "If the =E2=80=9Cvirtual-interrupt delivery=E2=80=9D VM-execution con=
trol is 1, VM entry loads
> > > the values of RVI and SVI from the guest interrupt-status field in th=
e VMCS
> > > (see Section 25.4.2). After doing so, the logical processor first cau=
ses PPR
> > > virtualization (Section 30.1.3) and then evaluates pending virtual in=
terrupts
> > > (Section 30.2.1). If a virtual interrupt is recognized, it may be del=
ivered in
> > > VMX non-root operation immediately after VM entry (including any spec=
ified
> > > event injection) completes; ..."
> > >=20
> > > According to that, PPR is supposed to be refreshed at VM-Enter, or am=
 I
> > > missing something here?
> >=20
> > Huh, I missed that.  It makes sense I guess; VM-Enter processes pending=
 virtual
> > interrupts, so it stands that VM-Enter would refresh PPR as well.
> >=20
> > Ugh, and looking again, KVM refreshes PPR every time it checks for a pe=
nding
> > interrupt, including the VM-Enter case (via kvm_apic_has_interrupt()) w=
hen nested
> > posted interrupts are in use:
> >=20
> > 	/* Emulate processing of posted interrupts on VM-Enter. */
> > 	if (nested_cpu_has_posted_intr(vmcs12) &&
> > 	    kvm_apic_has_interrupt(vcpu) =3D=3D vmx->nested.posted_intr_nv) {
> > 		vmx->nested.pi_pending =3D true;
> > 		kvm_make_request(KVM_REQ_EVENT, vcpu);
> > 		kvm_apic_clear_irr(vcpu, vmx->nested.posted_intr_nv);
> > 	}
> >=20
> > I'm still curious as to what's different about your setup, but certainl=
y not
> > curious enough to hold up a fix.
>=20
> Actually, none of the above is even relevant.  PPR virtualization in the =
nested
> VM-Enter case would be for _L2's_ vPRR, not L1's.  And that virtualizatio=
n is
> performed by hardware (vmcs02 has the correct RVI, SVI, and vAPIC informa=
tion
> for L2).
>=20
> Which means my initial instinct that KVM is missing a PPR update somewher=
e is
> likely correct.

Talking to myself :-)

Assuming it actually fixes your issue, this is what I'm planning on posting=
.  I
suspect KVM botches something when the deprivileged host is active, but giv=
en
that the below will allow for additional cleanups, and practically speaking=
 doesn't
have any downsides, I don't see any reason to withhold the hack-a-fix.  Tho=
ugh
hopefully we'll someday figure out exactly what's broken.

---
From: Sean Christopherson <seanjc@google.com>
Date: Wed, 2 Oct 2024 08:53:23 -0700
Subject: [PATCH] KVM: nVMX: Explicitly update vPPR on successful nested
 VM-Enter
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Request pending event evaluation after successful nested VM-Enter if L1
has a pending IRQ, which in turn refreshes vPPR based on vTPR and vISR.
This fixes an issue where KVM will fail to deliver a pending IRQ to L1
when running an atypical hypervisor in L1, e.g. the pKVM port to VMX.

Odds are very good that refreshing L1's vPPR is papering over a missed
PPR update somewhere, e.g. the underlying bug likely related to the fact
that pKVM passes through its APIC to the depriveleged host (which is an
L2 guest from KVM's perspective).

However, KVM updates PPR _constantly_, even when PPR technically shouldn't
be refreshed, e.g. kvm_vcpu_has_events() re-evaluates PPR if IRQs are
unblocked, by way of the same kvm_apic_has_interrupt() check.  Ditto for
nested VM-Enter itself, when nested posted interrupts are enabled.  Thus,
trying to avoid a PPR update on VM-Enter just to be pedantically accurate
is ridiculous, given the behavior elsewhere in KVM.

Unconditionally checking for interrupts will also allow for additional
cleanups, e.g. the manual RVI check earlier in VM-Enter emulation by
by vmx_has_apicv_interrupt() can be dropped, and the aforementioned nested
posted interrupt logic can be massaged to better honor priority between
concurrent events.

Link: https://lore.kernel.org/kvm/20230312180048.1778187-1-jason.cj.chen@in=
tel.com
Reported-by: Markku Ahvenj=C3=A4rvi <mankku@gmail.com>
Closes: https://lore.kernel.org/all/20240920080012.74405-1-mankku@gmail.com
Suggested-by: Markku Ahvenj=C3=A4rvi <mankku@gmail.com>
Cc: Janne Karhunen <janne.karhunen@gmail.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index a8e7bc04d9bf..784b61c9810b 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3593,7 +3593,8 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mo=
de(struct kvm_vcpu *vcpu,
 	 * effectively unblock various events, e.g. INIT/SIPI cause VM-Exit
 	 * unconditionally.
 	 */
-	if (unlikely(evaluate_pending_interrupts))
+	if (unlikely(evaluate_pending_interrupts) ||
+	    kvm_apic_has_interrupt(vcpu))
 		kvm_make_request(KVM_REQ_EVENT, vcpu);
=20
 	/*

base-commit: e32cde8d2bd7d251a8f9b434143977ddf13dcec6
--=20

