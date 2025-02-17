Return-Path: <linux-kernel+bounces-517482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E78E2A38163
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 081113A3418
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F5F216E3D;
	Mon, 17 Feb 2025 11:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Co8ZHdfb"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59502192B71;
	Mon, 17 Feb 2025 11:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739790649; cv=none; b=eu72kvjb/Rb6fit+TiJ8U6BJI2Af9TBaocTX21f3b3YUywZLkZnD0bJJB0C+8s00Z2qp8M1CLmg4JS1DVmekoRKWTqArjZIFvxadNhLGJ6yaS+xxgXKHL1AEH/b5S3cQ4VbVPMIVppQVovKBA6FTvBpi+W/gnFH1ViRSk5kmAps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739790649; c=relaxed/simple;
	bh=RaNMkzPUKH55P0ue/TW9YA+vTz4Djw3jHd6XdzluhRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=riNjWqa80kBNij5/gPcelA43hLykhQ7o1v2hhdeURCuo0AomTphky6gmyLO7RPvsK6THyO3vXPq9lGNrgJPy/113btjLtliK6OHA/nKEZMRMpGYf/YH8i8MRp3T1Ba85FjoyFV7uILs4r7NkBsS+c/BvptUUTd1r4CRhZrnRY1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Co8ZHdfb; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B00B740E0191;
	Mon, 17 Feb 2025 11:10:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vDZTFrYPUGkR; Mon, 17 Feb 2025 11:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739790640; bh=F6JnE8QkoFXQpkAYcY//uc3UNHxxRKBnsdxJosKiaj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Co8ZHdfbhiBhr1KZpW26veMq+CzcsXJEEp5730iFbHw3wMe062lnUQTC+wE1oiBOS
	 sEkU77E+NAh0mj/hwMELDIrrufGnqJrEmxqAPPERcbCGAdvu1vpzGzugoPs2yITVqR
	 Koqg/gmmryoBDvYUWabKP3FWv9aFX8l8GdRFfQzvfXMwW+ty3D/fyEAM2oE95jzaCD
	 XBBBEPopqEBv7/MHirKbRpV6JLSC18SkTg66ldExc9emEbWjdSosM4tdKVVePChP2T
	 1TAewfcyRMKRGGOFPTSEI1yp15N9Ej43WGhd33DcHKjbQCfgVRtOg7cNBzrYzWLAvp
	 j6JEW7Z7n84o2SeL7GdPR0Vt92fc+weOX0RVsAGp7B9H/Y9eU6YY7olhEWiWMM0Uj9
	 YZuJQI0nNTU3zIxNoRpdBbcQTszNo7uChDomRBnuRNIdee97NOAZTME2mF7PIUdfOv
	 p/HqUkXC3klVZc1oe//+WSHOCuVKsndIAnZ4eocOyMfxD89pyB/RY7lsZEBSsTkVrL
	 qZpa6g1syTqsRE4ZU/aCW5WvBSi3cIb4oahq3BRV4F64ziy4wlwfFIayueI8OzU3vY
	 Hn3nA/jVfTVQGQoKKC0HU0yPtoA4tb8Djbz+L/UyxasaXCi9btqwufzgwn/K2RAA7y
	 YxLwMyFR7qLJwdVlnYh2WTZo=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A584540E0176;
	Mon, 17 Feb 2025 11:10:30 +0000 (UTC)
Date: Mon, 17 Feb 2025 12:10:29 +0100
From: Borislav Petkov <bp@alien8.de>
To: Brendan Jackman <jackmanb@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 3/3] x86/cpu: Enable modifying bug flags with
 {clear,set}puid
Message-ID: <20250217111029.GIZ7MZJUGJRoeiScgn@fat_crate.local>
References: <20250129-force-cpu-bug-v2-0-5637b337b443@google.com>
 <20250129-force-cpu-bug-v2-3-5637b337b443@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250129-force-cpu-bug-v2-3-5637b337b443@google.com>

On Wed, Jan 29, 2025 at 03:35:41PM +0000, Brendan Jackman wrote:
> Sometimes it can be very useful to run CPU vulnerability mitigations on
> systems where they aren't known to mitigate any real-world
> vulnerabilities. This can be handy for mundane reasons like debugging
> HW-agnostic logic on whatever machine is to hand, but also for research
> reasons: while some mitigations are focused on individual vulns and
> uarches, others are fairly general, and it's strategically useful to
> have an idea how they'd perform on systems where they aren't currently
> needed.
> 
> As evidence for this being useful, a flag specifically for Retbleed was
> added in commit 5c9a92dec323 ("x86/bugs: Add retbleed=force").
> 
> Since CPU bugs are tracked using the same basic mechanism as features,
> and there are already parameters for manipulating them by hand, extend
> that mechanism to support bug as well as capabilities.
> 
> With this patch and setcpuid=srso, a QEMU guest running on an Intel host
> will boot with Safe-RET enabled.

As before. Move that sentence ...

> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---

... here.

>  arch/x86/include/asm/cpufeature.h |  1 +
>  arch/x86/kernel/cpu/common.c      | 16 ++++++++++++----
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
> index 0b9611da6c53f19ae6c45d85d1ee191118ad1895..6e17f47ab0521acadb7db38ce5934c4717d457ba 100644
> --- a/arch/x86/include/asm/cpufeature.h
> +++ b/arch/x86/include/asm/cpufeature.h
> @@ -50,6 +50,7 @@ extern const char * const x86_power_flags[32];
>   * X86_BUG_<name> - NCAPINTS*32.
>   */
>  extern const char * const x86_bug_flags[NBUGINTS*32];
> +#define x86_bug_flag(flag) x86_bug_flags[flag]

Why?

>  #define test_cpu_cap(c, bit)						\
>  	 arch_test_bit(bit, (unsigned long *)((c)->x86_capability))
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index e26cf8789f0e1a27ad126f531e05afee0fdebbb8..d94d7ebff42dadae30f77af1ef675d1a83ba6c3f 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1492,7 +1492,8 @@ static inline void parse_set_clear_cpuid(char *arg, bool set)
>  
>  		/*
>  		 * Handle naked numbers first for feature flags which don't
> -		 * have names.
> +		 * have names. It doesn't make sense for a bug not to have a
> +		 * name so don't handle bug flags here.
>  		 */
>  		if (!kstrtouint(opt, 10, &bit)) {
>  			if (bit < NCAPINTS * 32) {

It did but after

  7583e8fbdc49 ("x86/cpu: Remove X86_FEATURE_NAMES")

this chunk can be whacked now. Please do that in a pre-patch.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

