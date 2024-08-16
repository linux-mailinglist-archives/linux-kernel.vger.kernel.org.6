Return-Path: <linux-kernel+bounces-290372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AB1955305
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 00:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4915286C0B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 22:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7196F1420CC;
	Fri, 16 Aug 2024 22:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l4wcb5Bk"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155D520E3
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 22:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723845815; cv=none; b=YZrf4NoQgjHd7bj0imjGoKkuefMuR3+zb6k3ibJeW6Icla3U/+gN0yZ/ziKm6qjQwJ4jGXiF0l1d4U2n0wAk7OegrFtOE7JoY/liNXvn0LoQij7fyFjWPcuus+6xRsNZE0ymMIKx1EabnxSp5dEoFrP8XbxIPr5xGgH1A+EtvOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723845815; c=relaxed/simple;
	bh=urfXUbAOu7E9g3v50QErvwDMupII/UkjeKbAyN6Ee0o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QUJCh49njU+5wxil8JN8xLiDx5fEKOQhxFFSIferJTmTYFwl619OMimDt5INDvPNCwaJXnXGfAe5kKxOE6XLHy05GbQ0UtLsgQVJPe6OaB9Fqep5VymZmhgZbAQdQkKVm3DBXEHXfBLlmdqnuo8SfbIrBMwbZkohw/0v1Qmtl3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l4wcb5Bk; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6acf8ac7569so46996147b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 15:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723845813; x=1724450613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=urfXUbAOu7E9g3v50QErvwDMupII/UkjeKbAyN6Ee0o=;
        b=l4wcb5BkQAYQ1DfaVqVw3Z0FgoqxXcflajoojzqgTqp/+o4NNqWDnagdAwaDTSxPp0
         gMftfcQOU/7xDjreJRievqrBfVJMGv+baVbmUTPPbYkiUdEOSV943ffJ8loisSZ01ERZ
         pNGnaHNPtNcdXUaRYg66ja9QCKJzG6HHhS175WCbbi6r9suPN4PTqKQwPgcy0ltHpJCt
         Tji0RdvzJ1/CRJaEfMmjddisoCTG8EU+cbvhlIPtSJK6LkY4sWIeu6OJioD5w6rEDVr8
         CZiH9eNLIEAHNFzl5e7xg3x+4Wo1XnaRZd1U/iqorrREnZ+JsZlctt1r0zLSW777rmaW
         Zjgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723845813; x=1724450613;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=urfXUbAOu7E9g3v50QErvwDMupII/UkjeKbAyN6Ee0o=;
        b=Q0UDmHi34DiEXvF9wuFOfMGm0yp+NTky1KGjwntSBsqcicTCgF8YH2p1EuR7iJRtcs
         LKffdOXeSJ/tfvp2LLtGtmISLDgGOQ7xzsH9jg3ALwa/q7FMjSyV40FwTI1/JXkYYHsr
         dW81th4yyCK1c+RyhNcRNRdP7ozgwPUDPhbvoGM6a/VUEtT9SzN2syFF4E7egi95Dn9A
         0NFBJ349yY16QxRD9F1kcY0PyGS+MuuNTKc5nct5GbiBLok5mw1oAfUJhyyJiyYfLrVp
         fn2GfY7QhAABnO5OUT3pwVDNjYML2YxS4/DCuK9oIlNQkKx9JGeg5/aR7KuTtAp0E96R
         +wdA==
X-Forwarded-Encrypted: i=1; AJvYcCWLK+4yTX7nSeHxt1mhtHfLDT7FX9u3fRjBoO64awZzpmXPn4iRZu6CjCJXz1Rei8Zf+vjZk9C7kup+faf9iFEiF/dX4ae1Sx8XO5ae
X-Gm-Message-State: AOJu0Yz+DBObymxSvRVmdWuxo2v89m2VxZ6W/h9q+VSCnjhoITZvbBPz
	mY/hMScRNr6VQfhfuSrhuUm+fmvuh4QIsNdfm9HS04mA1PBWqgkzJEQl//Ht/Cra68p+Gm5x6PT
	o3w==
X-Google-Smtp-Source: AGHT+IGga5+2zHl5cUHcKwgjDnA98j6UFf8RXinc6Ui+a4Hm3pv+VnOhpcqlp1g4CIw05pB6mfFrQ7gsiYE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:6784:b0:681:8b2d:81ae with SMTP id
 00721157ae682-6b1bb85ee4bmr1011737b3.9.1723845813082; Fri, 16 Aug 2024
 15:03:33 -0700 (PDT)
Date: Fri, 16 Aug 2024 15:03:31 -0700
In-Reply-To: <4d292a92016c65ae7521edec2cc0e9842c033e26.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240815123349.729017-1-mlevitsk@redhat.com> <20240815123349.729017-4-mlevitsk@redhat.com>
 <4d292a92016c65ae7521edec2cc0e9842c033e26.camel@redhat.com>
Message-ID: <Zr_Ms-7IpzINzmc7@google.com>
Subject: Re: [PATCH v3 3/4] KVM: nVMX: relax canonical checks on some x86
 registers in vmx host state
From: Sean Christopherson <seanjc@google.com>
To: mlevitsk@redhat.com
Cc: kvm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024, mlevitsk@redhat.com wrote:
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> > =C2=A0arch/x86/kvm/vmx/nested.c | 30 +++++++++++++++++++++++-------
> > =C2=A01 file changed, 23 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> > index 2392a7ef254d..3f18edff80ac 100644
> > --- a/arch/x86/kvm/vmx/nested.c
> > +++ b/arch/x86/kvm/vmx/nested.c
> > @@ -2969,6 +2969,22 @@ static int nested_vmx_check_address_space_size(s=
truct kvm_vcpu *vcpu,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > =C2=A0}
> > =C2=A0
> > +static bool is_l1_noncanonical_address_static(u64 la, struct kvm_vcpu =
*vcpu)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 max_guest_address_bits =
=3D guest_can_use(vcpu, X86_FEATURE_LA57) ? 57 : 48;

I don't see any reason to use LA57 support from guest CPUID for the VMCS ch=
ecks.
The virtualization hole exists can't be safely plugged for all cases, so wh=
y
bother trying to plug it only for some cases?

It'd be very odd that an L1 could set a "bad" value via WRMSR, but then cou=
ldn't
load that same value on VM-Exit, e.g. if L1 gets the VMCS value by doing RD=
MSR.

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Most x86 arch registers w=
hich contain linear addresses like
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * segment bases, addresses =
that are used in instructions (e.g SYSENTER),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * have static canonicality =
checks,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * size of whose depends onl=
y on CPU's support for 5-level
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * paging, rather than state=
 of CR4.LA57.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * In other words the check =
only depends on the CPU model,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * rather than on runtime st=
ate.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return !__is_canonical_addre=
ss(la, max_guest_address_bits);
> > +}
> > +
> > =C2=A0static int nested_vmx_check_host_state(struct kvm_vcpu *vcpu,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 struct vmcs12 *vmcs12)
> > =C2=A0{
> > @@ -2979,8 +2995,8 @@ static int nested_vmx_check_host_state(struct kvm=
_vcpu *vcpu,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CC(!=
kvm_vcpu_is_legal_cr3(vcpu, vmcs12->host_cr3)))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (CC(is_noncanonical_addre=
ss(vmcs12->host_ia32_sysenter_esp, vcpu)) ||
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CC(is_non=
canonical_address(vmcs12->host_ia32_sysenter_eip, vcpu)))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (CC(is_l1_noncanonical_ad=
dress_static(vmcs12->host_ia32_sysenter_esp, vcpu)) ||
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CC(is_l1_=
noncanonical_address_static(vmcs12->host_ia32_sysenter_eip, vcpu)))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if ((vmcs12->vm_exit_co=
ntrols & VM_EXIT_LOAD_IA32_PAT) &&
> > @@ -3014,11 +3030,11 @@ static int nested_vmx_check_host_state(struct k=
vm_vcpu *vcpu,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CC(v=
mcs12->host_ss_selector =3D=3D 0 && !ia32e))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (CC(is_noncanonical_addre=
ss(vmcs12->host_fs_base, vcpu)) ||
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CC(is_non=
canonical_address(vmcs12->host_gs_base, vcpu)) ||
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CC(is_non=
canonical_address(vmcs12->host_gdtr_base, vcpu)) ||
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CC(is_non=
canonical_address(vmcs12->host_idtr_base, vcpu)) ||
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CC(is_non=
canonical_address(vmcs12->host_tr_base, vcpu)) ||
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (CC(is_l1_noncanonical_ad=
dress_static(vmcs12->host_fs_base, vcpu)) ||
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CC(is_l1_=
noncanonical_address_static(vmcs12->host_gs_base, vcpu)) ||
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CC(is_l1_=
noncanonical_address_static(vmcs12->host_gdtr_base, vcpu)) ||
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CC(is_l1_=
noncanonical_address_static(vmcs12->host_idtr_base, vcpu)) ||
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CC(is_l1_=
noncanonical_address_static(vmcs12->host_tr_base, vcpu)) ||

If loads via LTR, LLDT, and LGDT are indeed exempt, then we need to update
emul_is_noncanonical_address() too.

The best idea I have is to have a separate flow for system registers (not a=
 great
name, but I can't think of anything better), and the

E.g. s/is_host_noncanonical_msr_value/is_non_canonical_system_reg, and then
wire that up to the emulator.

> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CC(i=
s_noncanonical_address(vmcs12->host_rip, vcpu)))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
> > =C2=A0
>=20

