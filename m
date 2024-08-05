Return-Path: <linux-kernel+bounces-274568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B887C947A2F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 13:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C75E2820F3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 11:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC0E155753;
	Mon,  5 Aug 2024 11:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X8XbUcHx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142A3155398
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 11:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722855725; cv=none; b=Umvgp6QuPPEx29zw2oJPLUGB+N8Ow5isWBXQGibRfgygOfKIKozQw82bxi0SCTYhd/0EKQfMZ1Hl0VDhtzToRrv/O2wQJrgZlIshx6FVMR+ruiEJTIYqovMI/wwadIUsaBbNpYrsOCxYiFNyHbeJvxudQY1SKo4MsmxLFcEBZog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722855725; c=relaxed/simple;
	bh=G7hIw5DQap7/Uxwmajw9I0ojj7evPe/PRReMsbNwUUA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=elzHE7j/ZFHc4LgTets942EKHu3MeL7EL3PQYU9dHDgdJQIDdSafVocfWOBQ8ecfjdb1rz1sJi1ZHyE0RsM9p2PQyinCSstOM/wFGTdXl6Fc2gCaOF4Ab7vB4IM9iUze29kzYRCnmJICP2WZawNfj0hrWMEnkMPvaqAuhVgMUPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X8XbUcHx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722855722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G7hIw5DQap7/Uxwmajw9I0ojj7evPe/PRReMsbNwUUA=;
	b=X8XbUcHxR2jn7huH1xewEdjl1gYFmg+9FnemXQuAdEzUWieRvgizDznBDD/QKtkaXwNozY
	4SLI/LaJTT0I+kOzJvrZTpvBZdBY6B8p+xNxU0pxBVVd61quPZm9EHnbmQMgY+TnyrdYY4
	dc/xrLlYRjlcHj5bg8uVQiEpqhgPpUQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-goWTCuuXNuGY1QwXzbI7VQ-1; Mon, 05 Aug 2024 07:01:58 -0400
X-MC-Unique: goWTCuuXNuGY1QwXzbI7VQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-36848f30d39so5512070f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 04:01:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722855718; x=1723460518;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G7hIw5DQap7/Uxwmajw9I0ojj7evPe/PRReMsbNwUUA=;
        b=rc9npoXhchSjMfB/5WcKhZTVcg6OxqxyUIBmKS53zSFfeI6WBxelikaYQQa0GkHkDX
         tOI581DV+4ev2+XORmz+DKOPWIARexxpemNIQlyC2lEjiCVO8wuGpuqY9Q2o23nobM05
         Zlgy79dCuqG40o7RxdN2gDuxLw8fnTlpbKM5BVGExdaTck0+dbREaOrl/e8uvzZTF/MS
         zbPWUnk233nTbzkg53cj6LLdjGsxGrkqFoA9HV7aHApURqtgELyfBbMbNP34WueSsybe
         YP/OHjVcDM2o2RxRsmRYLORnWuhvSuZUEzFfftMEtVpYIdHw+/TFJ5Zjspdp/d0RIr5i
         m+jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwl4v2rG8A3IeNLASu84V4bnYufxU1fUy2iHXHO2evp/v5q14qpy8MzTBwLOtGdUullqZa2wpQ91xH9Tax0NpqH11B/9n2DPoCl48S
X-Gm-Message-State: AOJu0YxpNT2GL2S9+2zZGg26DxoL+exAOpKiwXaIKW+XJvugvsedbn51
	S1DE42yCTBfUZifKEMtRx74NuRkoc0WPEzU90VM1Ze6cEUA5IO22vkQSzGgVqkUvSmtpmNFEfjr
	clvHCDq7xBvNHWOVXKLtcYFLLdiFnuRmf0sbkHZDOFj40fIlwcoHsPbgibV1cmg==
X-Received: by 2002:a5d:61c9:0:b0:362:8ec2:53d6 with SMTP id ffacd0b85a97d-36bbc1a9030mr5995831f8f.61.1722855717618;
        Mon, 05 Aug 2024 04:01:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGC/NOydqGM1A2UtoB5cGpNbusbj2cvkw/DqyImsQTR1a2JluxngmkJ8X11HM9OeeEsxn04SQ==
X-Received: by 2002:a5d:61c9:0:b0:362:8ec2:53d6 with SMTP id ffacd0b85a97d-36bbc1a9030mr5995806f8f.61.1722855717069;
        Mon, 05 Aug 2024 04:01:57 -0700 (PDT)
Received: from intellaptop.lan ([2a06:c701:778d:5201:3e8a:4c9c:25dd:6ccc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbcd02563sm9551837f8f.0.2024.08.05.04.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 04:01:56 -0700 (PDT)
Message-ID: <cdb61fa7cc5cfe69b030493ea566cbf40f3ec2e1.camel@redhat.com>
Subject: Re: [PATCH v2 1/2] KVM: x86: relax canonical check for some x86
 architectural msrs
From: mlevitsk@redhat.com
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov
 <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, Chao Gao <chao.gao@intel.com>
Date: Mon, 05 Aug 2024 14:01:54 +0300
In-Reply-To: <Zq0A9R5R_MAFrqTP@google.com>
References: <20240802151608.72896-1-mlevitsk@redhat.com>
	 <20240802151608.72896-2-mlevitsk@redhat.com> <Zq0A9R5R_MAFrqTP@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

=D0=A3 =D0=BF=D1=82, 2024-08-02 =D1=83 08:53 -0700, Sean Christopherson =D0=
=BF=D0=B8=D1=88=D0=B5:
> > > > On Fri, Aug 02, 2024, Maxim Levitsky wrote:
> > > > > > > > Several architectural msrs (e.g MSR_KERNEL_GS_BASE) must co=
ntain
> > > > > > > > a canonical address, and according to Intel PRM, this is en=
forced
> > > > > > > > by a #GP canonical check during MSR write.
> > > > > > > >=20
> > > > > > > > However as it turns out, the supported address width
> > > > > > > > used for this canonical check is determined only
> > > > > > > > by host cpu model:
> > > >=20
> > > > Please try to wrap consistently and sanely, this is unnecessarily h=
ard to read
> > > > because every paragraph manages to wrap at a different column.
I'll take a note.

> > > >=20
> > > > > > > > if CPU *supports* 5 level paging, the width will be 57
> > > > > > > > regardless of the state of CR4.LA57.
> > > > > > > >=20
> > > > > > > > Experemental tests on a Sapphire Rapids CPU and on a Zen4 C=
PU
> > > > > > > > confirm this behavior.
> > > > > > > >=20
> > > > > > > > In addition to that, the Intel ISA extension manual mention=
s that this might
> > > > > > > > be the architectural behavior:
> > > > > > > >=20
> > > > > > > > Architecture Instruction Set Extensions and Future Features=
 Programming Reference [1].
> > > > > > > > Chapter 6.4:
> > > > > > > >=20
> > > > > > > > "CANONICALITY CHECKING FOR DATA ADDRESSES WRITTEN TO CONTRO=
L REGISTERS AND
> > > > > > > > MSRS"
> > > > > > > >=20
> > > > > > > > "In Processors that support LAM continue to require the add=
resses written to
> > > > > > > > control registers or MSRs to be 57-bit canonical if the pro=
cessor _supports_
> > > > > > > > 5-level paging or 48-bit canonical if it supports only 4-le=
vel paging"
> > > > > > > >=20
> > > > > > > > [1]: https://cdrdv2.intel.com/v1/dl/getContent/671368
> > > > > > > >=20
> > > > > > > > Suggested-by: Chao Gao <chao.gao@intel.com>
> > > > > > > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > > > > > > ---
> > > > > > > > =C2=A0arch/x86/kvm/x86.c | 11 ++++++++++-
> > > > > > > > =C2=A01 file changed, 10 insertions(+), 1 deletion(-)
> > > > > > > >=20
> > > > > > > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > > > > > > index a6968eadd418..3582f0bb7644 100644
> > > > > > > > --- a/arch/x86/kvm/x86.c
> > > > > > > > +++ b/arch/x86/kvm/x86.c
> > > > > > > > @@ -1844,7 +1844,16 @@ static int __kvm_set_msr(struct kvm_=
vcpu *vcpu, u32 index, u64 data,
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case MSR_KE=
RNEL_GS_BASE:
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case MSR_CS=
TAR:
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case MSR_LS=
TAR:
> > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (is_noncanonical_address(data, vcpu))
> > > > > > > > +
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Both AMD and Intel cpus allow values wh=
ich
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * are canonical in the 5 level paging mod=
e but are not
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * canonical in the 4 level paging mode to=
 be written
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * to the above MSRs, as long as the host =
CPU supports
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * 5 level paging, regardless of the state=
 of the CR4.LA57.
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!__is_canonical_address(data,
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0kvm_cpu_cap_has(X86_FEATURE_LA57) ? 57 : 48))
> > > >=20
> > > > Please align indentation.
> > > >=20
> > > > Checking kvm_cpu_cap_has() is wrong.=C2=A0 What the _host_ supports=
 is irrelevant,
> > > > what matters is what the guest CPU supports, i.e. this should check=
 guest CPUID.
> > > > Ah, but for safety, KVM also needs to check kvm_cpu_cap_has() to pr=
event faulting
> > > > on a bad load into hardware.=C2=A0 Which means adding a "governed" =
feature until my
> > > > CPUID rework lands.

Well the problem is that we passthrough these MSRs, and that means that the=
 guest
can modify them at will, and only ucode can prevent it from doing so.

So even if the 5 level paging is disabled in the guest's CPUID, but host su=
pports it,
nothing will prevent the guest to write non canonical value to one of those=
 MSRs,=C2=A0
and later KVM during migration or just KVM_SET_SREGS will fail.

Thus I used kvm_cpu_cap_has on purpose to make KVM follow the actual ucode
behavior.

> > > >=20
> > > > And I'm pretty sure this fix is incomplete, as nVMX's consistency c=
hecks on MSRs
> > > > that are loaded via dedicated VMCS fields likely need the same trea=
tment, e.g.
> > > > presumably these checks should follow the MSR handling.
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (CC(is_noncanoni=
cal_address(vmcs12->host_ia32_sysenter_esp, vcpu)) ||
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
CC(is_noncanonical_address(vmcs12->host_ia32_sysenter_eip, vcpu)))
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
> > > >=20
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
(CC(is_noncanonical_address(vmcs12->guest_bndcfgs & PAGE_MASK, vcpu)) ||
> > > >=20
> > > > So I think we probably need a dedicated helper for MSRs.

This is a long story - I didn't want to make this patch explode in size,
especially since it wasn't clear if this is architectural behavior.

Even now I can't be sure that it is architectural behavior - I haven't
found anything in the latest official PRM of either AMD nor Intel.

I'll add a separate patch to fix the nested code path in the next version o=
f the patches.

> > > >=20
> > > > Hmm, and I suspect these are wrong too, but in a different way.=C2=
=A0 Toggling host
> > > > LA57 on VM-Exit is legal[*], so logically, KVM should use CR4.LA57 =
from
> > > > vmcs12->host_cr4, not the vCPU's current CR4 value.=C2=A0 Which mak=
es me _really_
> > > > curious if Intel CPUs actually get that right.
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (CC(is_noncanoni=
cal_address(vmcs12->host_fs_base, vcpu)) ||
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
CC(is_noncanonical_address(vmcs12->host_gs_base, vcpu)) ||
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
CC(is_noncanonical_address(vmcs12->host_gdtr_base, vcpu)) ||
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
CC(is_noncanonical_address(vmcs12->host_idtr_base, vcpu)) ||
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
CC(is_noncanonical_address(vmcs12->host_tr_base, vcpu)) ||
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
CC(is_noncanonical_address(vmcs12->host_rip, vcpu)))
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;

This is a good question, I'll check this on bare metal.

Best regards,
 Maxim Levitsky

> > > >=20
> > > > [*] https://lore.kernel.org/all/20210622211124.3698119-1-seanjc@goo=
gle.com
> > > >=20


