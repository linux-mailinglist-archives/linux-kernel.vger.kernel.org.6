Return-Path: <linux-kernel+bounces-532418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCDCA44D74
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A09153B6516
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DAC212B3B;
	Tue, 25 Feb 2025 20:23:02 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA62D210180
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 20:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740514982; cv=none; b=sUBmMWA96LfAQywLrTbCL4AuK3QztQyH8+amX8EjmBUz/ObPGby/1Om0N9PKW9Dk5T+LWnWqjbeyNNLtTT3GqfsDDqSB6UrF6P64Mnj3OGxm98/NCpZqMl+hJ2lW4+F0Xk87Av6HzR+w/ZGSE/OgurdGIoMRdjRQV5LL/VHg37U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740514982; c=relaxed/simple;
	bh=/c7M8LOhrTFQYrkCQvXBLQJ6ku0jlywQflSi1BFyCd8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=stQQK6G4Ao5v/lmMGeNpwMB2k7ATEKww7WumF7r2RIrXDoxA8nrzS01S/jOCd4yU2Z808c9aUe0deM7ZOm0D/VXYTosatgnFesrUTsumplzKTijt8WB6ZTbwhuxnHhudZLMQ/Zqw6NVerzbdgps+j2McQTPiuews3G9FaHiRtn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tn1Rm-000000007sa-2iZv;
	Tue, 25 Feb 2025 15:22:30 -0500
Message-ID: <b24e6e4dbf4b4f51fb564b848c01156237bd663c.camel@surriel.com>
Subject: Re: [PATCH v13 07/14] x86/mm: global ASID allocation helper
 functions
From: Rik van Riel <riel@surriel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org, 
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
 nadav.amit@gmail.com, 	thomas.lendacky@amd.com, kernel-team@meta.com,
 linux-mm@kvack.org, 	akpm@linux-foundation.org, jackmanb@google.com,
 jannh@google.com, 	mhklinux@outlook.com, andrew.cooper3@citrix.com,
 Manali.Shukla@amd.com, 	mingo@kernel.org
Date: Tue, 25 Feb 2025 15:22:30 -0500
In-Reply-To: <20250224141601.GIZ7x_IXs-wla5BRsd@fat_crate.local>
References: <20250223194943.3518952-1-riel@surriel.com>
	 <20250223194943.3518952-8-riel@surriel.com>
	 <20250224141601.GIZ7x_IXs-wla5BRsd@fat_crate.local>
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

On Mon, 2025-02-24 at 15:16 +0100, Borislav Petkov wrote:
> On Sun, Feb 23, 2025 at 02:48:57PM -0500, Rik van Riel wrote:
> >=20
> > =C2=A0arch/x86/include/asm/mmu.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
11 +++
> > =C2=A0arch/x86/include/asm/tlbflush.h |=C2=A0 43 ++++++++++
> > =C2=A0arch/x86/mm/tlb.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 144
> > +++++++++++++++++++++++++++++++-
> > =C2=A03 files changed, 195 insertions(+), 3 deletions(-)
>=20
> arch/x86/mm/tlb.c:378:6: warning: no previous prototype for
> =E2=80=98destroy_context_free_global_asid=E2=80=99 [-Wmissing-prototypes]
> =C2=A0 378 | void destroy_context_free_global_asid(struct mm_struct *mm)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~
> arch/x86/mm/tlb.c:355:13: warning: =E2=80=98use_global_asid=E2=80=99 defi=
ned but not
> used [-Wunused-function]
> =C2=A0 355 | static void use_global_asid(struct mm_struct *mm)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~
> arch/x86/mm/tlb.c:327:13: warning: =E2=80=98mm_active_cpus_exceeds=E2=80=
=99 defined
> but not used [-Wunused-function]
> =C2=A0 327 | static bool mm_active_cpus_exceeds(struct mm_struct *mm, int
> threshold)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~~~~~~
>=20
> If those functions are going to remain global they better get a
> proper prefix
> like "tlb_".
>=20
I've renamed the global function to=20
tlb_destroy_context_free_global_asid

> And add the functions with their first use - no need to pre-add them.

That's what I originally had. Dave requested I split
out the patch into multiple ones.

That means either introducing helper functions in a
separate patch, or coming up with one version of the
code in one patch, and then replacing that code in
the next, resulting in a bunch of extra code to review.

https://lore.kernel.org/linux-kernel/b067a9fc-ff5f-4baa-a1ff-3fa749ae4d44@i=
ntel.com/
>=20
> >=20
> > +static inline void assign_mm_global_asid(struct mm_struct *mm, u16
> > asid)
>=20
> mm_assign_global_asid()

Done.

> > +/*
> > + * Global ASIDs are allocated for multi-threaded processes that
> > are
> > + * active on multiple CPUs simultaneously, giving each of those
> > + * processes the same PCIDs on every CPU, for use with hardware-
> > assisted
>=20
> "the same PCID" or "the same PCIDs"?
>=20
> Does a multithreaded process get one or more than one PCIDs? I'd
> expect only
> one ofc.

It's only one. Fixed the commment.

>=20
> > +	asid =3D find_next_zero_bit(global_asid_used,
> > MAX_ASID_AVAILABLE, last_global_asid);
> > +
> > +	if (asid >=3D MAX_ASID_AVAILABLE) {
>=20
> 	if (asid >=3D MAX_ASID_AVAILABLE && !global_asid_available)

Done.

> > +/*
> > + * Check whether a process is currently active on more than
> > "threshold" CPUs.
>=20
> @threshold - then it is clear that you mean the function argument.
>=20
Done. Thank you.

> > + * This is a cheap estimation on whether or not it may make sense
> > to assign
> > + * a global ASID to this process, and use broadcast TLB
> > invalidation.
> > + */
> > +static bool mm_active_cpus_exceeds(struct mm_struct *mm, int
> > threshold)
> > +{
> > +	int count =3D 0;
> > +	int cpu;
>=20
> Is this function supposed to hold some sort of a lock?

I don't think we care too much about total accuracy here.

Not holding up other CPUs is probably more important.

>=20
> > +
> > +	/* This quick check should eliminate most single threaded
> > programs. */
> > +	if (cpumask_weight(mm_cpumask(mm)) <=3D threshold)
> > +		return false;
> > +
> > +	/* Slower check to make sure. */
> > +	for_each_cpu(cpu, mm_cpumask(mm)) {
>=20
> Needs CPU hotplug protection?

I don't see CPU hotplug protection in most other loops
that iterate over CPUs and do nothing but read some
per-CPU data.

What are we trying to protect against?

What kind of protection do we need?

>=20
> > +	/* The last global ASID was consumed while waiting for the
> > lock. */
> > +	if (!global_asid_available) {
> > +		VM_WARN_ONCE(1, "Ran out of global ASIDs\n");
>=20
> And? Why do we want to warn here? We need to reset global ASIDs
> anyway.

This warning prints if we run out of global ASIDs,
but have more processes in the system that want one.

This basically helps us figure out whether or not
we should bother implementing more aggressive ASID
re-use (like ARM and RISCV have), which might
require us to figure out how to make that re-use
more scalable than it is today.

>=20
> > +		return;
> > +	}
> > +
> > +	asid =3D allocate_global_asid();
> > +	if (!asid)
> > +		return;
> > +
> > +	assign_mm_global_asid(mm, asid);
> > +}
> > +
> > +void destroy_context_free_global_asid(struct mm_struct *mm)
>=20
> That name is a mouthful. mm_free_global_asid() is just fine.
>=20
Done.

--=20
All Rights Reversed.

