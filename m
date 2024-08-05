Return-Path: <linux-kernel+bounces-275174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6618948166
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 20:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A08528DBE0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED58E165F06;
	Mon,  5 Aug 2024 18:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QwHVKvTA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F532165EF1
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 18:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722881239; cv=none; b=SeIeuSb2J1+cBzfJa6GDQoO8Za+BVt5evdRr7ElBfA4z9Aiaprh8iOaBLGKL9gV546E7bQ5ASjosAuRHDalNajj+Zsc29ac/N8AkfxW5vaNUdMvXv/r+9uCyW/rKD9U4OIqm/hooQ49f51RegEHGL/wZ1rQ8sj8j1uV+6k5EX3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722881239; c=relaxed/simple;
	bh=XeOBDs5g9+DWZr0nMNt+q5yDm4Jet7kwvUmtNMeNbbw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WERxXZ2TEdSsJ56TaP9a3aeq/Y2U742+p8Yr7aN5YcmJ4/TECzuKxktAI1+RVJQ+5+rYc2ZQBmypDpI++Qav4sSFcvzdBtlEgo0CClWmBOjUw78f+nhk3twiHPIW9bq7ggDrzOfI05Z6Tsu3DTM2caUeq+uLqAMM7wsOGD6N2es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QwHVKvTA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722881236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EV382HJ7V4LKcf7jIUzsTiCcxB+Fb1tK9cfeDpSD6y0=;
	b=QwHVKvTAhT0tS/0ci32I4uExFoZrL/z2zy6t1AA4CRFIltUGbsqMNyEh/CRXD7UFdRk577
	qmRRdAjVNI5o2+2cnTLSfaRNxNRKaEPeRBUHoTlh9eklQjiXj5d1pdNIzLquOeKpiPIfoL
	gttlJr2o/3RDzy9Ywq8yZF5/kEg0tu0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-A-ygLtkoOD2xIHDCiBYoWA-1; Mon, 05 Aug 2024 14:07:14 -0400
X-MC-Unique: A-ygLtkoOD2xIHDCiBYoWA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-36873a449dfso2881647f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 11:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722881233; x=1723486033;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EV382HJ7V4LKcf7jIUzsTiCcxB+Fb1tK9cfeDpSD6y0=;
        b=QBBELrrxR14lmz/ULNtlM8RdquulG7d+YBd0jYlO6lC9lgAnFbtKW6sKa2VNHWKj03
         JTzEY/C5pDzvpoS3Jkd7HR7RZxlip1FSzVKLT1fkQ7rT0zkaEbBSaGrgbOM76HkO1tno
         DqdyCwCmb7G8HeJ48fMre6Cgi/bFIOQc6GJSuJzvW1Hx2DrVNuJUVtHSLFsBZi4Q4/w1
         3NcTBBAW71sz8Diblx4yLCT9pcxhSdX4H4ImPSp0RCRRda3r7LkNOKK1O3FZ9pWUrsNm
         MeuczPcyCQuPCyQ+b4/Hc6fnVI1U+dDvluk/C2n4BZBpMFHzxgQayqHKI9UFqyd4es4L
         +WJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJMzos5qqUqXqggdWCBOxbAnsOkwI/+QuCBZ7ZwvVXldjAqeQ2s/FAiHNPZ9TLPKPDfQwUwpE7s+DFj2QCXtE7GAlQ3xJCUqX8vNEB
X-Gm-Message-State: AOJu0YxyAGz36W/17Vv1Q3IfXPz039+Wt0k+yTII1Mtv5A3PtCFG4HTO
	/Ki8ZEp+NbQ+dCNJCEoHe7GSTdD8tKqU+qj/0SgoMSWPn8jyoRSUa9Nn6oE14m0MlKy+ZKd5weW
	lZFj/4CTVBs6UGLCoFacv/Bqj2BlrHs5ht4RCxiZ7uS8TZvN03Odl/Lqo8CeZNQ==
X-Received: by 2002:adf:ee41:0:b0:36b:bb99:d7f0 with SMTP id ffacd0b85a97d-36bbbe1a4bfmr8355551f8f.2.1722881233327;
        Mon, 05 Aug 2024 11:07:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQTeOsWdSC6WQUfpcDIzGoAFVnMw1c1hQTEw/m+WMBul5UlRqgqCuosR9sXFjORB5Q1VcF7A==
X-Received: by 2002:adf:ee41:0:b0:36b:bb99:d7f0 with SMTP id ffacd0b85a97d-36bbbe1a4bfmr8355531f8f.2.1722881232758;
        Mon, 05 Aug 2024 11:07:12 -0700 (PDT)
Received: from intellaptop.lan ([2a06:c701:778d:5201:3e8a:4c9c:25dd:6ccc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd26f913sm10630748f8f.111.2024.08.05.11.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 11:07:12 -0700 (PDT)
Message-ID: <b6569c6d40317e957cff9309dcfe943d72544b60.camel@redhat.com>
Subject: Re: [PATCH v2 1/2] KVM: x86: relax canonical check for some x86
 architectural msrs
From: mlevitsk@redhat.com
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov
 <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, Chao Gao <chao.gao@intel.com>
Date: Mon, 05 Aug 2024 21:07:10 +0300
In-Reply-To: <ZrEAXVhH3w6Q0tIy@google.com>
References: <20240802151608.72896-1-mlevitsk@redhat.com>
	 <20240802151608.72896-2-mlevitsk@redhat.com> <Zq0A9R5R_MAFrqTP@google.com>
	 <cdb61fa7cc5cfe69b030493ea566cbf40f3ec2e1.camel@redhat.com>
	 <ZrEAXVhH3w6Q0tIy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

=D0=A3 =D0=BF=D0=BD, 2024-08-05 =D1=83 09:39 -0700, Sean Christopherson =D0=
=BF=D0=B8=D1=88=D0=B5:
> On Mon, Aug 05, 2024, mlevitsk@redhat.com=C2=A0wrote:
> > =D0=A3 =D0=BF=D1=82, 2024-08-02 =D1=83 08:53 -0700, Sean Christopherson=
 =D0=BF=D0=B8=D1=88=D0=B5:
> > > > > > > > > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > > > > > > > > index a6968eadd418..3582f0bb7644 100644
> > > > > > > > > > --- a/arch/x86/kvm/x86.c
> > > > > > > > > > +++ b/arch/x86/kvm/x86.c
> > > > > > > > > > @@ -1844,7 +1844,16 @@ static int __kvm_set_msr(struct =
kvm_vcpu *vcpu, u32 index, u64 data,
> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case MS=
R_KERNEL_GS_BASE:
> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case MS=
R_CSTAR:
> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case MS=
R_LSTAR:
> > > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (is_noncanonical_address(data, vcpu)=
)
> > > > > > > > > > +
> > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Both AMD and Intel cpus allow values=
 which
> > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * are canonical in the 5 level paging =
mode but are not
> > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * canonical in the 4 level paging mode=
 to be written
> > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * to the above MSRs, as long as the ho=
st CPU supports
> > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * 5 level paging, regardless of the st=
ate of the CR4.LA57.
> > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!__is_canonical_address(data,
> > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0kvm_cpu_cap_has(X86_FEATURE_LA57) ? 57 : 48))
> > > > > >=20
> > > > > > Please align indentation.
> > > > > >=20
> > > > > > Checking kvm_cpu_cap_has() is wrong.=C2=A0 What the _host_ supp=
orts is irrelevant,
> > > > > > what matters is what the guest CPU supports, i.e. this should c=
heck guest CPUID.
> > > > > > Ah, but for safety, KVM also needs to check kvm_cpu_cap_has() t=
o prevent faulting
> > > > > > on a bad load into hardware.=C2=A0 Which means adding a "govern=
ed" feature until my
> > > > > > CPUID rework lands.
> >=20
> > Well the problem is that we passthrough these MSRs, and that means that=
 the guest
> > can modify them at will, and only ucode can prevent it from doing so.
> >=20
> > So even if the 5 level paging is disabled in the guest's CPUID, but hos=
t supports it,
> > nothing will prevent the guest to write non canonical value to one of t=
hose MSRs,=C2=A0
> > and later KVM during migration or just KVM_SET_SREGS will fail.
> =C2=A0
> Ahh, and now I recall the discussions around the virtualization holes wit=
h LA57.
>=20
> > Thus I used kvm_cpu_cap_has on purpose to make KVM follow the actual uc=
ode
> > behavior.
>=20
> I'm leaning towards having KVM do the right thing when emulation happens =
to be
> triggered.=C2=A0 If KVM checks kvm_cpu_cap_has() instead of guest_cpu_cap=
_has() (looking
> at the future), then KVM will extend the virtualization hole to MSRs that=
 are
> never passed through, and also to the nested VMX checks.=C2=A0 Or I suppo=
se we could
> add separate helpers for passthrough MSRs vs. non-passthrough, but that s=
eems
> like it'd add very little value and a lot of maintenance burden.
>=20
> Practically speaking, outside of tests, I can't imagine the guest will ev=
er care
> if there is inconsistent behavior with respect to loading non-canonical v=
alues
> into MSRs.
>=20

Hi,

If we weren't allowing the guest (and even nested guest assuming that L1 hy=
pervisor allows it) to write
these MSRs directly, I would have agreed with you, but we do allow this.

This means that for example a L2, even a malicious L2, can on purpose write=
 non canonical value to one of these
MSRs, and later on, KVM could kill the L0 due to canonical check.

Or L1 (not Linux, because it only lets canonical GS_BASE/FS_BASE), allow th=
e untrusted userspace to=C2=A0
write any value to say GS_BASE, thus allowing
malicious L1 userspace to crash L1 (also a security violation).

IMHO if we really want to do it right, we need to disable pass-though of th=
ese MSRs if ucode check is more lax than
our check, that is if L1 is running without 5 level paging enabled but L0 d=
oes have it supported.

I don't know if this configuration is common, and thus how much this will a=
ffect performance.

Best regards,
	Maxim Levitsky



