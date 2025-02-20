Return-Path: <linux-kernel+bounces-524068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA3CA3DEC2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A4D58601E0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8961FF1A7;
	Thu, 20 Feb 2025 15:30:36 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0F71FDE3B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740065436; cv=none; b=R/zh5842r261qHOncuWp3wUoht8ksJ0w92KMqzmj4wlXrDwY7zu15rVkAfhETr0/K8Kwhem7HCBZpz8H/IdYL8XDb/DFJgXWOydF+hpi+A1GY9NEJYC932pEGuelr3TfNKL0OI7sbT5IJoEea0X/et1N3aZpefM90mGRnB2Rrw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740065436; c=relaxed/simple;
	bh=qm9WvDuYycYiuUHaVWaVaDQf7WgjRQcqpsklGSqFdck=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q/9PHyVG1B7rtcf5rwdANDSMD4INrJ9hSYiPtQxb8ZEqg9jdZXFVTe/ZclbDN71rwU55NLVjm/Zng/SE9z3N8T/WZi9pd45579B11/IkSdq1CTa0xMRm9jSWfIO383Ws2Jz1s2XRlByPf0lRSALf9jbxBz8vrw4D5G2NC4wOtq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tl8Qv-000000002GQ-09SX;
	Thu, 20 Feb 2025 10:25:49 -0500
Message-ID: <2d1168630e5c25d0cd28f0de3104ada9ceda168f.camel@surriel.com>
Subject: Re: [PATCH v11 09/12] x86/mm: enable broadcast TLB invalidation for
 multi-threaded processes
From: Rik van Riel <riel@surriel.com>
To: Dave Hansen <dave.hansen@intel.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, bp@alien8.de, peterz@infradead.org, 
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
 nadav.amit@gmail.com, 	thomas.lendacky@amd.com, kernel-team@meta.com,
 linux-mm@kvack.org, 	akpm@linux-foundation.org, jackmanb@google.com,
 jannh@google.com, 	mhklinux@outlook.com, andrew.cooper3@citrix.com, Manali
 Shukla	 <Manali.Shukla@amd.com>
Date: Thu, 20 Feb 2025 10:25:48 -0500
In-Reply-To: <b067a9fc-ff5f-4baa-a1ff-3fa749ae4d44@intel.com>
References: <20250213161423.449435-1-riel@surriel.com>
	 <20250213161423.449435-10-riel@surriel.com>
	 <b067a9fc-ff5f-4baa-a1ff-3fa749ae4d44@intel.com>
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

On Fri, 2025-02-14 at 11:53 -0800, Dave Hansen wrote:
> On 2/13/25 08:14, Rik van Riel wrote:
>=20
>=20

> > +#ifdef CONFIG_X86_BROADCAST_TLB_FLUSH
>=20
> How cleanly could we throw this hunk in a new file? I always dislike
> big
> #ifdefs like this. They seem like magnets for causing weird compile
> problems.

It looks like if we compile the X86_FEATURE_INVLPGB
out through arch/x86/include/asm/disabled-features.h,
the compiler can be smart enough to elide the no
longer necessary code ... but only if we have these
functions in the same compilation unit as their
callers.

That means we should be able to get rid of the ifdef,=C2=A0
if we keep these functions in arch/x86/mm/tlb.c

>=20
> > +/*
> > + * Logic for broadcast TLB invalidation.
> > + */
> > +static DEFINE_RAW_SPINLOCK(global_asid_lock);
>=20
> The global lock definitely needs some discussion in the changelog.
>=20
> > +static u16 last_global_asid =3D MAX_ASID_AVAILABLE;
> > +static DECLARE_BITMAP(global_asid_used, MAX_ASID_AVAILABLE) =3D { 0
> > };
> > +static DECLARE_BITMAP(global_asid_freed, MAX_ASID_AVAILABLE) =3D { 0
> > };
>=20
> Isn't the initialization to all 0's superfluous for a global
> variable?
>=20
I'll remove that, and will add documentation for
the spinlock.


> > +static int global_asid_available =3D MAX_ASID_AVAILABLE -
> > TLB_NR_DYN_ASIDS - 1;
> > +
> > +static void reset_global_asid_space(void)
> > +{
> > +	lockdep_assert_held(&global_asid_lock);
> > +
> > +	/*
> > +	 * A global TLB flush guarantees that any stale entries
> > from
> > +	 * previously freed global ASIDs get flushed from the TLB
> > +	 * everywhere, making these global ASIDs safe to reuse.
> > +	 */
> > +	invlpgb_flush_all_nonglobals();
>=20
> Ugh, my suggestion to use the term "global ASID" really doesn't work
> here, does it?
>=20
> Also, isn't a invlpgb_flush_all_nonglobals() _relatively_ slow? It
> has
> to go out and talk over the fabric to every CPU, right? This is also
> holding a global lock.
>=20
> That's seems worrisome.

This only happens on ASID rollover, when we have
reached the end of global ASID space, and are
about to restart the search from the beginning.

We do not do a flush at every allocation, but
only once every few thousand global ASID allocations.

>=20
> > +static bool needs_global_asid_reload(struct mm_struct *next, u16
> > prev_asid)
> > +{
> > +	u16 global_asid =3D mm_global_asid(next);
> > +
> > +	/* Process is transitioning to a global ASID */
> > +	if (global_asid && prev_asid !=3D global_asid)
> > +		return true;
> > +
> > +	/* Transition from global->local ASID does not currently
> > happen. */
> > +	if (!global_asid && is_global_asid(prev_asid))
> > +		return true;
> > +
> > +	return false;
> > +}
> I'm going to throw in the towel at this point. This patch needs to
> get
> broken up. It's more at once than my poor little brain can handle.
>=20
> The _least_ it can do is introduce the stub functions and injection
> into
> existing code changes, first. Then, in a second patch, introduce the
> real implementation.
>=20
> I also suspect that a big chunk of the ASID allocator could be broken
> out and introduced separately.
>=20
> Another example is broadcast_tlb_flush(). To reduce complexity in
> _this_
> patch, it could do something suboptimal like always do a
> invlpgb_flush_all_nonglobals() regardless of the kind of flush it
> gets.
> Then, in a later patch, you could optimize it.
>=20
With the config option and ifdefs (mostly) gone, I
think the split would probably have to be in two
patches:
1) Modify existing code to call non-functional
   stub functions.
2) Modify the stub functions to then do something.

I'm not sure quite how much this will help with review,
since to review the second patch you'll have to go back
to the first patch, but I might as well try...

--=20
All Rights Reversed.

