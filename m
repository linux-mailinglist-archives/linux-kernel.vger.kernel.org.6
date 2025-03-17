Return-Path: <linux-kernel+bounces-564909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A38A65CCC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F6D117E794
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCE31BD03F;
	Mon, 17 Mar 2025 18:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="QWSE59tV"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277AE1F8ADB
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 18:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742236491; cv=none; b=VnCWGuNqnxLQpgv70PkSRK05xdlU8tZtBu2M1yIXgypTAieFXpfBiEsco1xCyCu3D1XsgtD/WvFMs2zaCf9Xex2E/VGX0TbXKEDfl8vLKsSMIGhCQ0QMGKGtlIvLX8eWAga/jm408e3+72uQPlMcmvs0FlK1ch44Y89ZXc4mv+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742236491; c=relaxed/simple;
	bh=ei2t9uLg9jDunByFc5vR6shBpPAMZENbWKSnqaqDcGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJtkSDX2f+mB8Tbbk0GRWa6M32cODx1aU9hpnZI7kBQoLvuAX+nuwzmkpo50kQZIt+72ifSjhZEojy09+D4vEiZ7SwixObYa3AptJyw2gkv5nogr5FFoHUFAIpwBBdbrSnrTIfBtot4ggm5KyfKiutizxPCoFAdoonGllgkAIJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=QWSE59tV reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 87E9540E0169;
	Mon, 17 Mar 2025 18:34:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ziQELmCnSNxZ; Mon, 17 Mar 2025 18:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742236480; bh=7M+5C/kkJLWSJmZSgvviBA/mAKEw54Lz/C8EIst1COQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QWSE59tVRGQLt83VAzt9wvvwKPCbx7/TbiQnjB2R/u5lR4GDU4aNOxjGg/JKfaJPE
	 w6rG4jHhfZn23S9A71I5MI/op/LXlXKZ9m9wDerQhgJC/ACORSdULJLFTdOR8wyaBG
	 OyDC5bZvb6SZW44NIckL7l8mn/WRkP5PJxREkFCptsTGKDwIVJCeOKSP3ELeMaaSbQ
	 1J6MGnnNbHBbk3/p4+nwgmPzVDcnDYJbXasBuP2FVCqKCWSD0Mbgt/RRavkhLIQn8R
	 6biDTgzsnKyMQRKyL/giPCDu0IRBdc0gSyJYfywtAt2KRAXdJX4gdeXvfiqZcVs70l
	 yu2w499Kmps0BlPlfX+vYCyGEZIwbJccheMviv3Gv2rLqh6Wu8lClqDOPmbRYgAkAp
	 hftpswjRGaL+eFT2zJKTt5qDQz4VUN0glPd544U5ZGKEjH/lmYbBRZ0mSbTNeGaXx4
	 IsikTx5W/3oXYHWYFA0WnvU4wMyNQp0x0bbN13vEvSanOp2cI5AHeFJDbO5AIiA2FG
	 SUxzj9sjat/cI9g8vWuCAY6DI6SV/8bzjFKn0o7qL1n5ir5GOPxMjURxiTtUZ+Nmd9
	 Py2c86aiZuWdR9TLwP6xeZoIeEiBicNPJzFyLJUzwshSDdSCYw1KVd1hjgaB02q8Yc
	 Pg/FzqRmeJq+OZemN1by2ZZc=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8521F40E0214;
	Mon, 17 Mar 2025 18:34:28 +0000 (UTC)
Date: Mon, 17 Mar 2025 19:34:21 +0100
From: Borislav Petkov <bp@alien8.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/29] x86: treewide: Introduce
 x86_vendor_amd_or_hygon()
Message-ID: <20250317183421.GHZ9hrLZbBCBqOGXtL@fat_crate.local>
References: <20250317164745.4754-1-darwi@linutronix.de>
 <20250317164745.4754-2-darwi@linutronix.de>
 <20250317173216.GGZ9hcoDICYl1fBtBG@fat_crate.local>
 <20250317174848.GJ6888@noisy.programming.kicks-ass.net>
 <0f1b3c76-5430-437d-aa9f-27c1dbf9cf01@intel.com>
 <3ABF7C7E-748C-40BF-BFDC-F1B676DB4F4D@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3ABF7C7E-748C-40BF-BFDC-F1B676DB4F4D@zytor.com>
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 11:21:41AM -0700, H. Peter Anvin wrote:
> On March 17, 2025 11:11:11 AM PDT, Dave Hansen <dave.hansen@intel.com> =
wrote:
> >On 3/17/25 10:48, Peter Zijlstra wrote:
> >> On Mon, Mar 17, 2025 at 06:32:16PM +0100, Borislav Petkov wrote:
> >>> On Mon, Mar 17, 2025 at 05:47:17PM +0100, Ahmed S. Darwish wrote:
> >>>> The pattern to check if an x86 vendor is AMD or HYGON (or not both=
) is
> >>>> pretty common.  Introduce x86_vendor_amd_or_hygon() at <asm/proces=
sor.h>
> >>> So if we need to check "intel too", we do
> >>>
> >>> x86_vendor_amd_or_hygon_or_intel?
> >>>
> >>> Nah, this is silly.
> >> Would it make more sense to have a Zen1 feature and check that inste=
ad?
> >>=20
> >> Because, IIRC Hygon is simply a Zen1 copy.
> >
> >Some of them can just go away, I think. This, for instance:
> >
> >        if (boot_cpu_data.x86_vendor !=3D X86_VENDOR_AMD &&
> >            boot_cpu_data.x86_vendor !=3D X86_VENDOR_HYGON)
> >                return false;
> >
> >        if (cpu_feature_enabled(X86_FEATURE_ZEN))
> >                return false;
> >
> >Do we even need a vendor check if we're checking X86_FEATURE_ZEN? Is
> >someone setting X86_FEATURE_ZEN on Intel? ;)
>=20
> Maybe having a vendor bitmask instead of (or as an alternative to) an e=
numeration wouldn't be a horrible idea. That way multiple arbitrary vendo=
rs can be tested with a single test instruction. It would be pretty crazy=
 to have 32 x86 vendors, never mind 64, without a *dramatic* shift in the=
 ecosystem (there are currently fewer than 32 registered RISC-V G impleme=
ntations; that doesn't include the myriad of microcontroller class implem=
entations that don't implement the full G [general purpose] feature set =E2=
=80=93 but those are irrelevant for Linux.)

All y'all - you do realize that all that is a bit too much.

What's the problem with having a two-vendor test instead of a silly wrapp=
er
around it?

Or is the need for such a wrapper so important that we absolutely need it=
?

Did that thing cause a bug somewhere I didn't catch or so and we absolute=
ly
need a wrapper so that we don't forget one or the other?

Also, no one has Hygon hw so we can't just lump those together, strictly
speaking. Whoever lumps them, needs to test on both.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

