Return-Path: <linux-kernel+bounces-289504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0489546D6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25B6A283D9B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66901922FB;
	Fri, 16 Aug 2024 10:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IbRZp2C7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DAB13B783
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 10:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723804856; cv=none; b=ViCmp/xSrKmz2ZCgSfpHgFpplGyjCJNrcl9GF1S/W0t87G1m0lhXpfU24pD/tU/9puN/3IbvDiWe+/2NFRbxMd/WFdIkVByuOn1RHEvckIfOffPySETAJWBcKtKelkOod/Um5KLPdy+gPfqIA/bB4JHiYy3ezkgpUKSD1lNUxqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723804856; c=relaxed/simple;
	bh=AOXCO+gO5CgShIZ7CshbaSet0p0IhOG0WbsSMcT71tU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iDao+ltW8z7AQM4L+ADqRYy9ySW9e5xV4weZHrGxrNEKkzI9Yg21lo+y188ld6NdAS9dYyvecgGmyXCvb6DGhyfOyW6kMIphsgD5ktP6ASIStI3rkHjeyk+BqRFoR87o9qUYpsGT9VEH50hVVYmWl14fdv6M37wCTCInabUg0WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IbRZp2C7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723804852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7JgR5EMLHmaVR7qbyXU0gJ7Rk3GvEx4rWFbGheyQQCM=;
	b=IbRZp2C7hCjO2SR44Cmx2LNryLOgp8cSbBauI5g8Y3z/l4CU6dEAhcRF/YrCmLiOfK/kwS
	Pj/aRZH8DWsRPICvi8u3O0D2p3R9aygTuaVvEcolWbbr3/sJhxYqpPcdv0smqwVPwddQQ2
	mxstnTKkjvMNbGXjXDy22aAX/GBaKsQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-Q5zjBJVkPHaK_wPgzHn4hA-1; Fri, 16 Aug 2024 06:40:51 -0400
X-MC-Unique: Q5zjBJVkPHaK_wPgzHn4hA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-36873a449dfso1656926f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 03:40:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723804850; x=1724409650;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7JgR5EMLHmaVR7qbyXU0gJ7Rk3GvEx4rWFbGheyQQCM=;
        b=vOP60EBb9Ui3UkcCTYQQMzdjmEWh9wcALaESv7UIhUCXfFq7KTEtZ0ZL30NsSfujUS
         95irQMnyvgiFEbx0kfPNdJnNMozm1DCUGUYJ6zfKUoDIrs+WCQrV6Td3wWad5f28bh+6
         86CpOeB7jh/dEWsaRhnBZMwreVCa9NIMNYk0aGPNUO1Fp9aoFYHY6fZJxk5CI6A1RTIj
         dn3CGX+5ey+SbdB/PetiBPPsZnPmgoQdGf8vbtdUzioYmQzcF/noDT/p+UjT6VqTaty3
         zygm+e10W4VnlRkKofJBD5qpFck/5W1rSFZ8f9GilrC1IOaIH5HBt3gOmmkQ8KuCIZNB
         inxw==
X-Forwarded-Encrypted: i=1; AJvYcCUEpVKi4pAri2+5/KIo8dBiL1HCf1rynW71Z0LaG1Pdp5hE6lPJyX55Vz9qz6HJNbXre84Wud7mfRFVRdp9PmpN4H9JAxGxbiC0IXOn
X-Gm-Message-State: AOJu0YzQEBofJA5zSY65UNcpj74e054UMfX8dgVIuGLROyqo56NedVxM
	5fDpO3jTXPG99KeFZgd36c2zPHhsQ8YXblPxIxp33CIl8IEfK5voKM7TjknuWerphs6SgTQlaDL
	RhW2/Y83WQWamBMjA7m8GW4xnKM8Z5ys3A8XdAUdmQdLrQmaEaYQjCRn2Ur5vaA==
X-Received: by 2002:a5d:46cb:0:b0:367:9049:da2e with SMTP id ffacd0b85a97d-37194badde1mr1627100f8f.8.1723804850145;
        Fri, 16 Aug 2024 03:40:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWeIVwxkTqApNBVM8LC1LWsvulwA5ev/6tZFq7bIW+DUr9acYZd2PDpfOddEbdm4s5NLYj5w==
X-Received: by 2002:a5d:46cb:0:b0:367:9049:da2e with SMTP id ffacd0b85a97d-37194badde1mr1627080f8f.8.1723804849621;
        Fri, 16 Aug 2024 03:40:49 -0700 (PDT)
Received: from intellaptop.lan ([2a06:c701:77ab:3101:d6e6:2b8f:46b:7344])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898ac79esm3363061f8f.110.2024.08.16.03.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 03:40:49 -0700 (PDT)
Message-ID: <4d292a92016c65ae7521edec2cc0e9842c033e26.camel@redhat.com>
Subject: Re: [PATCH v3 3/4] KVM: nVMX: relax canonical checks on some x86
 registers in vmx host state
From: mlevitsk@redhat.com
To: kvm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Paolo Bonzini
 <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Thomas
 Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org, "H. Peter
 Anvin" <hpa@zytor.com>
Date: Fri, 16 Aug 2024 13:40:47 +0300
In-Reply-To: <20240815123349.729017-4-mlevitsk@redhat.com>
References: <20240815123349.729017-1-mlevitsk@redhat.com>
	 <20240815123349.729017-4-mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

=D0=A3 =D1=87=D1=82, 2024-08-15 =D1=83 15:33 +0300, Maxim Levitsky =D0=BF=
=D0=B8=D1=88=D0=B5:
> Several x86's architecture registers contain a linear base, and thus must
> contain a canonical address.
>=20
> This includes segment and segment like bases (FS/GS base, GDT,IDT,LDT,TR)=
,
> addresses used for SYSENTER and SYSCALL instructions and probably more.
>=20
> As it turns out, when x86 architecture was updated to 5 level paging /
> 57 bit virtual addresses, these fields were allowed to contain a full
> 57 bit address regardless of the state of CR4.LA57.
>=20
> The main reason behind this decision is that 5 level paging, and even
> paging itself can be temporarily disabled (e.g by SMM entry) leaving non
> canonical values in these fields.
> Another reason is that OS might prepare these fields before it switches t=
o
> 5 level paging.

Hi,

Note that I haven't included a fix for HOST_RIP. I did today a bare metal c=
heck
and indeed the microcode does check CR4.LA57, the one that is stored in the=
 vmcs
as you suspected.

I add a patch to this patch series with this mostly theoretical fix, when I=
 send a new revision.

Second thing, I kept the canonical check on 'vmcs12->guest_bndcfgs because =
Intel
deprecated this feature and none of CPUs which support 5 level paging suppo=
rt MPX.

Also I think that since this is a guest state field, it might be possible t=
o just
remove the check, because the value of this field is copied to vmcs02 and t=
he
CPU's microcode should do the same check that KVM does.

Best regards,
	Maxim Levitsky


>=20
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
> =C2=A0arch/x86/kvm/vmx/nested.c | 30 +++++++++++++++++++++++-------
> =C2=A01 file changed, 23 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 2392a7ef254d..3f18edff80ac 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -2969,6 +2969,22 @@ static int nested_vmx_check_address_space_size(str=
uct kvm_vcpu *vcpu,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> =C2=A0}
> =C2=A0
> +static bool is_l1_noncanonical_address_static(u64 la, struct kvm_vcpu *v=
cpu)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 max_guest_address_bits =3D =
guest_can_use(vcpu, X86_FEATURE_LA57) ? 57 : 48;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Most x86 arch registers whi=
ch contain linear addresses like
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * segment bases, addresses th=
at are used in instructions (e.g SYSENTER),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * have static canonicality ch=
ecks,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * size of whose depends only =
on CPU's support for 5-level
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * paging, rather than state o=
f CR4.LA57.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * In other words the check on=
ly depends on the CPU model,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * rather than on runtime stat=
e.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return !__is_canonical_address=
(la, max_guest_address_bits);
> +}
> +
> =C2=A0static int nested_vmx_check_host_state(struct kvm_vcpu *vcpu,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 struct vmcs12 *vmcs12)
> =C2=A0{
> @@ -2979,8 +2995,8 @@ static int nested_vmx_check_host_state(struct kvm_v=
cpu *vcpu,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CC(!kv=
m_vcpu_is_legal_cr3(vcpu, vmcs12->host_cr3)))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (CC(is_noncanonical_address=
(vmcs12->host_ia32_sysenter_esp, vcpu)) ||
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CC(is_nonca=
nonical_address(vmcs12->host_ia32_sysenter_eip, vcpu)))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (CC(is_l1_noncanonical_addr=
ess_static(vmcs12->host_ia32_sysenter_esp, vcpu)) ||
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CC(is_l1_no=
ncanonical_address_static(vmcs12->host_ia32_sysenter_eip, vcpu)))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if ((vmcs12->vm_exit_cont=
rols & VM_EXIT_LOAD_IA32_PAT) &&
> @@ -3014,11 +3030,11 @@ static int nested_vmx_check_host_state(struct kvm=
_vcpu *vcpu,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CC(vmc=
s12->host_ss_selector =3D=3D 0 && !ia32e))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (CC(is_noncanonical_address=
(vmcs12->host_fs_base, vcpu)) ||
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CC(is_nonca=
nonical_address(vmcs12->host_gs_base, vcpu)) ||
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CC(is_nonca=
nonical_address(vmcs12->host_gdtr_base, vcpu)) ||
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CC(is_nonca=
nonical_address(vmcs12->host_idtr_base, vcpu)) ||
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CC(is_nonca=
nonical_address(vmcs12->host_tr_base, vcpu)) ||
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (CC(is_l1_noncanonical_addr=
ess_static(vmcs12->host_fs_base, vcpu)) ||
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CC(is_l1_no=
ncanonical_address_static(vmcs12->host_gs_base, vcpu)) ||
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CC(is_l1_no=
ncanonical_address_static(vmcs12->host_gdtr_base, vcpu)) ||
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CC(is_l1_no=
ncanonical_address_static(vmcs12->host_idtr_base, vcpu)) ||
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CC(is_l1_no=
ncanonical_address_static(vmcs12->host_tr_base, vcpu)) ||
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CC(is_=
noncanonical_address(vmcs12->host_rip, vcpu)))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
> =C2=A0


