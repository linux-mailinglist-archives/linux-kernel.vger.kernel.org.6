Return-Path: <linux-kernel+bounces-522158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9127A3C6CD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 342B0189C38A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28D92147FE;
	Wed, 19 Feb 2025 17:55:25 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985901F61C
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 17:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987725; cv=none; b=PnEcfM8i95glDsJdYpi1boa2WYKF6gBgwN5xY5Fozf1IVTTXTraOXc0YarodjwFzneYxgLrrRjxSf6LARPYewQ0iPaoYhllxbJ+qclqPU3MCbPFVLEX6i1RDa8aEJaTYHbVgoDOYu6zK4ux1h9jLVznE+EZg/9nqdLLQjiJsrJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987725; c=relaxed/simple;
	bh=E2Ms2pbjUGWhkeqoWiLqRScsd0rM2hpKWGJH2iAeGtk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PwcpUSDIhjKOl4xOieAiQiNqFh9maJKdGkk1bKjpgtsOJQuH5IX7O60ChGBYnxDWzocx4r4aFWSsz38F1FWW7+B5oXhjKIZCfbsE6gN2nV0/W6twtg+Rka4DbaUNeRJMbF8LiXsnxwwXJ5RbtYna/DrrfwwpWF6cPz0rANu7dLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tkoFk-000000003Xr-0mcr;
	Wed, 19 Feb 2025 12:52:56 -0500
Message-ID: <b749384b7dea020880057359d06d4e9172c7aaec.camel@surriel.com>
Subject: Re: [PATCH v11 04/12] x86/mm: get INVLPGB count max from CPUID
From: Rik van Riel <riel@surriel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org, 
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
 nadav.amit@gmail.com, 	thomas.lendacky@amd.com, kernel-team@meta.com,
 linux-mm@kvack.org, 	akpm@linux-foundation.org, jackmanb@google.com,
 jannh@google.com, 	mhklinux@outlook.com, andrew.cooper3@citrix.com, Manali
 Shukla	 <Manali.Shukla@amd.com>
Date: Wed, 19 Feb 2025 12:52:56 -0500
In-Reply-To: <20250219115626.GMZ7XG6s-5ftg1XLoZ@fat_crate.local>
References: <20250213161423.449435-1-riel@surriel.com>
	 <20250213161423.449435-5-riel@surriel.com>
	 <20250219115626.GMZ7XG6s-5ftg1XLoZ@fat_crate.local>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33A
 eo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47
 Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/
 lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdY
 dIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gU
 mllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986o
 gEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/
 r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHV
 WjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o
 6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635
 Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE
 +BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTe
 g4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/jddPx
 KRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/Ne
 fO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z
 3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0Mm
 G1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tP
 okBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznneko
 TE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44N
 cQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhI
 omYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0Ip
 QrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkE
 c4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: riel@surriel.com

On Wed, 2025-02-19 at 12:56 +0100, Borislav Petkov wrote:
> On Thu, Feb 13, 2025 at 11:13:55AM -0500, Rik van Riel wrote:
> > The CPU advertises the maximum number of pages that can be shot
> > down
> > with one INVLPGB instruction in the CPUID data.
> >=20
> > Save that information for later use.
> >=20
> > Signed-off-by: Rik van Riel <riel@surriel.com>
> > Tested-by: Manali Shukla <Manali.Shukla@amd.com>
> > Tested-by: Brendan Jackman <jackmanb@google.com>
> > Tested-by: Michael Kelley <mhklinux@outlook.com>
> > ---
> > =C2=A0arch/x86/Kconfig.cpu=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 5 +++++
> > =C2=A0arch/x86/include/asm/cpufeatures.h | 1 +
> > =C2=A0arch/x86/include/asm/tlbflush.h=C2=A0=C2=A0=C2=A0 | 7 +++++++
> > =C2=A0arch/x86/kernel/cpu/amd.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 8 ++++++++
> > =C2=A04 files changed, 21 insertions(+)
> >=20
> > diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
> > index 2a7279d80460..abe013a1b076 100644
> > --- a/arch/x86/Kconfig.cpu
> > +++ b/arch/x86/Kconfig.cpu
> > @@ -395,6 +395,10 @@ config X86_VMX_FEATURE_NAMES
> > =C2=A0	def_bool y
> > =C2=A0	depends on IA32_FEAT_CTL
> > =C2=A0
> > +config X86_BROADCAST_TLB_FLUSH
> > +	def_bool y
> > +	depends on CPU_SUP_AMD && 64BIT
> > +
> > =C2=A0menuconfig PROCESSOR_SELECT
> > =C2=A0	bool "Supported processor vendors" if EXPERT
> > =C2=A0	help
> > @@ -431,6 +435,7 @@ config CPU_SUP_CYRIX_32
> > =C2=A0config CPU_SUP_AMD
> > =C2=A0	default y
> > =C2=A0	bool "Support AMD processors" if PROCESSOR_SELECT
> > +	select X86_BROADCAST_TLB_FLUSH
>=20
> CPU_SUP_AMD selects X86_BROADCAST_TLB_FLUSH which depends on
> CPU_SUP_AMD which
> selects X86_BROADCAST_TLB_FLUSH which depends on CPU_SUP_AMD...
>=20
> Why do you really need yet another Kconfig symbol? Just whack
> X86_BROADCAST_TLB_FLUSH - it'll be enabled by default on everything
> anyway.

Dave specifically asked me to do things that way.

>=20
> > @@ -1139,6 +1141,12 @@ static void cpu_detect_tlb_amd(struct
> > cpuinfo_x86 *c)
> > =C2=A0		tlb_lli_2m[ENTRIES] =3D eax & mask;
> > =C2=A0
> > =C2=A0	tlb_lli_4m[ENTRIES] =3D tlb_lli_2m[ENTRIES] >> 1;
> > +
> > +	/* Max number of pages INVLPGB can invalidate in one shot
> > */
> > +	if (boot_cpu_has(X86_FEATURE_INVLPGB)) {
> > +		cpuid(0x80000008, &eax, &ebx, &ecx, &edx);
> > +		invlpgb_count_max =3D (edx & 0xffff) + 1;
> > +	}
>=20
> get_cpu_cap() already reads that leaf. You don't need to do it here
> again.
>=20
Should I modify get_cpu_cap() to store
c->x86_capabilities[CPUID_8000_0008_EDX] ?

Currently only the EBX data is stored there,
while invlpgb_count_max comes from EDX.

--=20
All Rights Reversed.

