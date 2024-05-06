Return-Path: <linux-kernel+bounces-170508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A868BD834
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 01:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F1F01C21251
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 23:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA5C15B0ED;
	Mon,  6 May 2024 23:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KsFFjHCe"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F7C158A27
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 23:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715038402; cv=none; b=ii9DcrhhBwQDpH3EMJ7ElRS0aOQJW0ofcusQOvDVgcWDVxOB2NMxvMQh8NxnX4XpsKYSbS1ROX1BlX22VvaGsk9MJAy8v2GHLEfWSWms4iIzo9j/KOCGB59D1TWoCbAH4hpJoR+emi0hB3EBzCguwhHOYsKZWk2B1ASea+a0xSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715038402; c=relaxed/simple;
	bh=eYF/5LBlojZTPQk7R6ARo4QRGpN0U8rhB702OyWsxic=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LsL0VivX0iVMyA0CDwu8ShVwgvvi5G4BGGTjOsJlhvKVElqUXmN7AH5NNsPrPMcTbYXXcKtBeRW1p8b/LuyXLUrWGf/TSm0qaa9xsyzET/PFe1Kxi/vkn4k6pma8NkvFpBmznyVFTVEnqm7Yl3apb6whvpLFa+nJA/vWGNfV0ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KsFFjHCe; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2b4330e57b6so2947368a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 16:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715038399; x=1715643199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=naRWxGi0DISf7tT9GtjLPuvLnh/f9UY/0yCGnr5vVNE=;
        b=KsFFjHCett/cyiLbo77Bl4y2+hlSJWzdbJK+h9kEUy0IkFkvT8gEdJDnd7wcUbxU5y
         hGbmmuPSQ9kMkhXnjJ4NQGhtM1NO1JT3UixX4eIrwCN0Fwb3YLUujXa/9uyVwJNBuftK
         tKAg/TXALwPWJmt24Myx3M0Vthb4Exf8YcUgelqBf134/46yenxU1uCstiliMYgl2y9q
         rcQzlxFkkkjTZuAQ/T1NjoXTFlvBmx5mVUMggZqxx67vVBPL8dtL//cnK2pZMmI8DWxg
         Wq7HJyWnbACIAHAyodF22vKlgHlI94QpgflbqQGUH3vrv0XMRvlVcqyl9A2Tv/l4fleC
         MahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715038399; x=1715643199;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=naRWxGi0DISf7tT9GtjLPuvLnh/f9UY/0yCGnr5vVNE=;
        b=fWTg1k5jRt4diKi1Kcs5q3biJye1TrR/E8Ud5/T+sdYsLhnWiRT5AY07aE1bMn3JBO
         rKafvjpuxHOL9vutG3xWlKbVTJHTCWxpMtPOJY451yo18eMGHg2YFORY4v1NktbgLCyy
         +5z9HXwmomYKa71md8ib/Tc1A9Rgl/f5kCSgEH1ANtpkWvNuIl/90EDt2MsBqgyrAIgE
         iyWNVQUCv9YhHbohmSnD2X2urhfgHCLI4sol28dH6RoK2YoD6khg6a43fOZaT9aJCXef
         pjuAjE+6gnC+d5vpZ+i7y7GIBY47z4X6IRgfPhua/YJktDxXtBN+hZAEU1/vAm0x4aY1
         bt9A==
X-Forwarded-Encrypted: i=1; AJvYcCWY4PX2wNyhG7mbymjL86Vl/EAdiEIFkejdfVjt6Emv0DjwsVLNCQRiJLHSXnEbk2yGnBk38m8jCC7Hh+pLArtgnDLISaFjvy3bB/Sc
X-Gm-Message-State: AOJu0YxfpQYtQAElac9ebnlIT1fQMhLuPLiuXNeZJJ9+F8mp9EOfhVyb
	i9nWKZZVXKN6cWyqcKhQYy5UJfYtspd26l5IKGrMqLV379VafJp8pHWQTQwo1ZGOxI3sSeAGY+y
	14g==
X-Google-Smtp-Source: AGHT+IFVdGY0Y8CICjJjkQNm8G7tr0LJBvFQGZgnwAzw3Vs3/H1kG0dT3dJGoY8axS4Ic1zPBmJpOeSP2u8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:3685:b0:2b2:9855:2852 with SMTP id
 mj5-20020a17090b368500b002b298552852mr32798pjb.5.1715038399442; Mon, 06 May
 2024 16:33:19 -0700 (PDT)
Date: Mon, 6 May 2024 16:33:17 -0700
In-Reply-To: <038379acaf26dd942a744290bde0fc772084dbe9.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240219074733.122080-1-weijiang.yang@intel.com>
 <20240219074733.122080-25-weijiang.yang@intel.com> <ZjLNEPwXwPFJ5HJ3@google.com>
 <e39f609f-314b-43c7-b297-5c01e90c023a@intel.com> <038379acaf26dd942a744290bde0fc772084dbe9.camel@intel.com>
Message-ID: <ZjlovaBlLicFb6Z_@google.com>
Subject: Re: [PATCH v10 24/27] KVM: x86: Enable CET virtualization for VMX and
 advertise to userspace
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: Weijiang Yang <weijiang.yang@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Dave Hansen <dave.hansen@intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "john.allen@amd.com" <john.allen@amd.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2024, Rick P Edgecombe wrote:
> On Mon, 2024-05-06 at 17:19 +0800, Yang, Weijiang wrote:
> > On 5/2/2024 7:15 AM, Sean Christopherson wrote:
> > > On Sun, Feb 18, 2024, Yang Weijiang wrote:
> > > > @@ -696,6 +697,20 @@ void kvm_set_cpu_caps(void)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kvm_cpu_cap_set(X86_FEATURE_INTEL_STIBP);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (boot_cpu_has(X8=
6_FEATURE_AMD_SSBD))
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kvm_cpu_cap_set(X86_FEATURE_SPEC_CTRL_SSBD);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Don't use boot_cpu_ha=
s() to check availability of IBT because
> > > > the
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * feature bit is cleare=
d in boot_cpu_data when ibt=3Doff is applied
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * in host cmdline.
> > > I'm not convinced this is a good reason to diverge from the host kern=
el.=C2=A0
> > > E.g.  PCID and many other features honor the host setup, I don't see =
what
> > > makes IBT special.
> >=20
> > This is mostly based on our user experience and the hypothesis for clou=
d
> > computing: When we evolve host kernels, we constantly encounter issues =
when
> > kernel IBT is on, so we have to disable kernel IBT by adding ibt=3Doff.=
 But
> > we need to test the CET features in VM, if we just simply refer to host
> > boot cpuid data, then IBT cannot be enabled in VM which makes CET featu=
res
> > incomplete in guest.
> >=20
> > I guess in cloud computing, it could run into similar dilemma. In this
> > case, the tenant cannot benefit the feature just because of host SW
> > problem. I know currently KVM except LA57 always honors host feature
> > configurations, but in CET case, there could be divergence wrt honoring
> > host configuration as long as there's no quirk for the feature.
> >=20
> > But I think the issue is still open for discussion...
>=20
> I think the back and forth I remembered was actually around SGX IBT, but =
I did
> find this thread:
> https://lore.kernel.org/lkml/20231128085025.GA3818@noisy.programming.kick=
s-ass.net/
>=20
> Disabling kernel IBT enforcement without disabling KVM IBT seems worthwhi=
le. But
> the solution is to not to not honor host support. It is to have kernel IB=
T not
> clear the feature flag and instead clear something else. This can be done
> independently of the KVM series.

Hmm, I don't disagree, but I'm not sure it makes sense to wait on that disc=
ussion
to exempt IBT from the "it must be supported in the host" rule.  I suspect =
that
tweaking the handling X86_FEATURE_IBT of will open a much larger can of wor=
ms,
as overhauling feature flag handling is very much on the x86 maintainers to=
do
list.

IMO, the odds of there being a hardware bug that necessitates hard disablin=
g IBT
are lower than the odds of KVM support for CET landing well before the feat=
ure
stuff is sorted out.

