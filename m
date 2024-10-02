Return-Path: <linux-kernel+bounces-347991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 873DE98E12E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00A9C1F23A5D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1181D0F4D;
	Wed,  2 Oct 2024 16:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fkm6espU"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F4C1D0B98
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 16:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727887802; cv=none; b=K7lPvapRt/hELKCoSMmmBbPIfCXu6AsSIr0nivlh2s+iWj3q+iuUGys10IKfT0PmKcippu/Zsdv95+kXDX3OwJgV16HZrLrncemBoi6FPt49nlDZ0PgFokNCQblvU3o6YUz6vaXgHdQesE0xjfYImgyDdxNrrSg9USFSo5I3tBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727887802; c=relaxed/simple;
	bh=K873MHSQWHn9mjrShCG25Yd6WRHcahAZtnWnZUIq/sc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bxyryLg5BBLoya9BEdoU0sUkEuc5D7ZmekJry/i3zl9h+8nb2VJEJi858YJ8YqqkzY2tlfp5EWtdd0/tKYxKlxJYZNhExfjWQDpvMDWKPX4xHUWXITLZ2WYEfa71n5cW6reKB832CnE7X+QeldAwDevvloHBQlu1goGP2mglCAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fkm6espU; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7db8197d431so9085616a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 09:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727887800; x=1728492600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hIqwXeyjP9MJQRYeejRN1c0C1pY6a32a5uDybdpX5pc=;
        b=fkm6espUHVp8RpRGpd4DhKw9zPX4fXDWZDP6kRDZLxFY96k3Z1FEsheAyomeSPWHML
         +jvNPQqYdlyYUXTywpEnCJwFeuw1wkDRvjl/kfSlaffPKY0zmlq3P/EwoB2R3qtVDO6c
         jP6nzvVSkESqzJ9V0DUbxaKZewZpcJU3I29tsayInV7vMzhyHUKaAbmrB2BREl6LSCkM
         wUrM4GIRZi0IW8sk8tSNVt2mUHUR9ZOqDuOesUn//0Lkhlah/tm4QrS+1i5eLpNfp9ve
         idX1VOQQT0e0iemwMa46u3hokbgA57b6FG/kONEgVW6Ue5/cL7swVIfRpzJzn2gMrdlM
         I8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727887800; x=1728492600;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hIqwXeyjP9MJQRYeejRN1c0C1pY6a32a5uDybdpX5pc=;
        b=O+C3Pz5mrS8Ss+Eh1QROczOIbl/YPZ2ZecqskuydKXaK8M0qokpTpPI6ommzGnJ9kM
         x1m/TXZK0FU8vGq05l0mLQ9ku/FhAmvY8g247Jx5cmc94NR6hFC+YYKlp1b7v2xn192r
         /bjKEpOCbK7CRn6kzNIHtAaPcN7JmdLj2ZRblffhm9JwPRSSr5fPwY0cooeYe8maSC4T
         HIUM8+Eg/w7SIpJCGtMq+xlgwG4ZwfDPYvvTDHre7fwyZEwh/MYCSdsYNsYN2Bju4e8u
         zvCj4sf9edNOM4wt+5iAVzYJxBbth6A93UImxXFBVrgc+bFmhwkPiwmPUBt4Xyh8ZWgT
         9iCA==
X-Forwarded-Encrypted: i=1; AJvYcCW1ADJxEWRlvMchAmw4fl/hhGsMEEkAubuT8Prx5DipNLZPvHyQlIdGRaGpfgoQllc3xmx0V660IG2fozY=@vger.kernel.org
X-Gm-Message-State: AOJu0YznObxIPM7Krv55eF3DOVy5CDhD0ZAhinQcdSavfVcYZCRP9jJr
	VeCKQ8I6uhQ3LCXD/DLl5uvGLIVkowth+ShWL1IcTMc+rSyNjjohow2Zqox4yyGfrrmdIHcfiD1
	tTw==
X-Google-Smtp-Source: AGHT+IFrOqWgw1xk/EQhViPAGb+ZtaEY8tZrNM22UnUqKPHUIGndZdYGOBUa7P9HyNw+yXtIxV1jexF4xvU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d2d1:b0:20b:7ece:3225 with SMTP id
 d9443c01a7336-20bc54bcf15mr686235ad.0.1727887800165; Wed, 02 Oct 2024
 09:50:00 -0700 (PDT)
Date: Wed, 2 Oct 2024 09:49:58 -0700
In-Reply-To: <Zv1gbzT1KTYpNgY1@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <Zu0vvRyCyUaQ2S2a@google.com> <20241002124324.14360-1-mankku@gmail.com>
 <Zv1gbzT1KTYpNgY1@google.com>
Message-ID: <Zv15trTQIBxxiSFy@google.com>
Subject: Re: [PATCH 1/1] KVM: nVMX: update VPPR on vmlaunch/vmresume
From: Sean Christopherson <seanjc@google.com>
To: "Markku =?utf-8?Q?Ahvenj=C3=A4rvi?=" <mankku@gmail.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	janne.karhunen@gmail.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, pbonzini@redhat.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02, 2024, Sean Christopherson wrote:
> On Wed, Oct 02, 2024, Markku Ahvenj=C3=A4rvi wrote:
> > Hi Sean,
> >=20
> > > On Fri, Sep 20, 2024, Markku Ahvenj=C3=A4rvi wrote:
> > > > Running certain hypervisors under KVM on VMX suffered L1 hangs afte=
r
> > > > launching a nested guest. The external interrupts were not processe=
d on
> > > > vmlaunch/vmresume due to stale VPPR, and L2 guest would resume with=
out
> > > > allowing L1 hypervisor to process the events.
> > > >=20
> > > > The patch ensures VPPR to be updated when checking for pending
> > > > interrupts.
> > >
> > > This is architecturally incorrect, PPR isn't refreshed at VM-Enter.
> >=20
> > I looked into this and found the following from Intel manual:
> >=20
> > "30.1.3 PPR Virtualization
> >=20
> > The processor performs PPR virtualization in response to the following
> > operations: (1) VM entry; (2) TPR virtualization; and (3) EOI virtualiz=
ation.
> >=20
> > ..."
> >=20
> > The section "27.3.2.5 Updating Non-Register State" further explains the=
 VM
> > enter:
> >=20
> > "If the =E2=80=9Cvirtual-interrupt delivery=E2=80=9D VM-execution contr=
ol is 1, VM entry loads
> > the values of RVI and SVI from the guest interrupt-status field in the =
VMCS
> > (see Section 25.4.2). After doing so, the logical processor first cause=
s PPR
> > virtualization (Section 30.1.3) and then evaluates pending virtual inte=
rrupts
> > (Section 30.2.1). If a virtual interrupt is recognized, it may be deliv=
ered in
> > VMX non-root operation immediately after VM entry (including any specif=
ied
> > event injection) completes; ..."
> >=20
> > According to that, PPR is supposed to be refreshed at VM-Enter, or am I
> > missing something here?
>=20
> Huh, I missed that.  It makes sense I guess; VM-Enter processes pending v=
irtual
> interrupts, so it stands that VM-Enter would refresh PPR as well.
>=20
> Ugh, and looking again, KVM refreshes PPR every time it checks for a pend=
ing
> interrupt, including the VM-Enter case (via kvm_apic_has_interrupt()) whe=
n nested
> posted interrupts are in use:
>=20
> 	/* Emulate processing of posted interrupts on VM-Enter. */
> 	if (nested_cpu_has_posted_intr(vmcs12) &&
> 	    kvm_apic_has_interrupt(vcpu) =3D=3D vmx->nested.posted_intr_nv) {
> 		vmx->nested.pi_pending =3D true;
> 		kvm_make_request(KVM_REQ_EVENT, vcpu);
> 		kvm_apic_clear_irr(vcpu, vmx->nested.posted_intr_nv);
> 	}
>=20
> I'm still curious as to what's different about your setup, but certainly =
not
> curious enough to hold up a fix.

Actually, none of the above is even relevant.  PPR virtualization in the ne=
sted
VM-Enter case would be for _L2's_ vPRR, not L1's.  And that virtualization =
is
performed by hardware (vmcs02 has the correct RVI, SVI, and vAPIC informati=
on
for L2).

Which means my initial instinct that KVM is missing a PPR update somewhere =
is
likely correct.

That said, I'm inclined to go with the below fix anyways, because KVM updat=
es
PPR _constantly_, e.g. every time kvm_vcpu_has_events() is invoked with IRQ=
s
enabled.  Which means that trying to avoid a PPR update on VM-Enter just to=
 be
pedantically accurate is ridiculous.

> So, for an immediate fix, I _think_ we can do:
>=20
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index a8e7bc04d9bf..784b61c9810b 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -3593,7 +3593,8 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_=
mode(struct kvm_vcpu *vcpu,
>          * effectively unblock various events, e.g. INIT/SIPI cause VM-Ex=
it
>          * unconditionally.
>          */
> -       if (unlikely(evaluate_pending_interrupts))
> +       if (unlikely(evaluate_pending_interrupts) ||
> +           kvm_apic_has_interrupt(vcpu))
>                 kvm_make_request(KVM_REQ_EVENT, vcpu);
> =20
>         /*

