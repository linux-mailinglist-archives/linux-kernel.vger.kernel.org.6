Return-Path: <linux-kernel+bounces-409645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 743FF9C9066
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C8BFB605E9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504FB157465;
	Thu, 14 Nov 2024 16:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="E1CkytfR"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D56D17A583
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 16:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601227; cv=none; b=OuO0RdrZbWSDrlg4UwsHlXvQgI/f9qcFceC0nzHtNHKwKM9FtJd3jqiHlrIY8zU3fEZqkxn6ksUBof9hvSkuTqHvLHN3UVPGdMKFPOU6lsNH1/NV37cZFhUCl474KVczwWZwCbaoSynLZpVq8ykIJ/2cR+C4SjHqT+y2pUYItVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601227; c=relaxed/simple;
	bh=EeL1GAxyHmFMaSZ7myAfX7UxFp3sNKBOB4azcS2HbjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nn+QrvW2CaUuqKx+LYind73uT5WDM4LW325k1MHBYx3NyY0kJ6i9Mhw6cAmtqvWHhujphaCt6G16Y7m/997BvLfnM8GbhsnPC+741xnKw6WloCKpadxLbqTcOtyNlpjvAc9pm49Pmxn2sosM8xEOhVvLCgp3B1Gv/N9CWVZSU2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=E1CkytfR; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9641240E0276;
	Thu, 14 Nov 2024 16:20:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id iPjM_A2w-ltm; Thu, 14 Nov 2024 16:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1731601217; bh=y5VRPzaV64Q2tLFYn2ihl6Rg2kn3Yqk0WdNzhetZWMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E1CkytfRwFuzq1eMKRVkV2B1UOYBB5HeStHO8lJ0dJHpCvu/i70iLM9wgP6wmWq2n
	 6N20AkeaJIhaQWzEDYJrHsVeSjTISImH4HGuhOiBYQPxdRivPg649eHGpb2dbkb5Kr
	 wr2/gtMX7F2c89tkn6SpPJxWkr0SuEsRe1tfXAzhcKLN9CdTTi68wTZWLip3/SEpYY
	 c1vNiMiFgiZ/O8jtYfCBorWwIwgqJ619q/onDeisjmrMek27EOsaENYyKwIOt6FSb4
	 g5g2eRtIlP4gYyVZSKLUjs7EcLNC9Hk5KKC8gbjp1Rd1Qf1iZA8u1ba7GHLIcO7fCi
	 ZP15gCLh3HXeDoXrzKOgHygXcCKSILv4n/cw96qwZeoYOvPMcdXt29XCqVKsZ2UVQQ
	 Ph01sp4Y7a/dm9je7O87FuzCo3oMV0iNahTdS6cXjpEDYCOTsU1tdYBXmzEG2DLrAK
	 75kWCuue9yyxR5MlKTr4newwt7rX4S6c82wPgKqpAp3nNltEeYx+SytI7PeiC/wghx
	 m2jEJO/re0rhf19seu3qbGhjzHreHgKb00AEXxRCq7HE0QiZsz6bimG89ArlOGJGKF
	 NlBTT9ZoKLGwOaH3d7ZeJH7PpSVv8m40rV6c9jqM4GMxSDfaGnxjAaXux750viteCn
	 doy73q5JAZoxlUNv93gIeYS8=
Received: from zn.tnic (p200300ea973a314f329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:973a:314f:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E168240E015E;
	Thu, 14 Nov 2024 16:20:06 +0000 (UTC)
Date: Thu, 14 Nov 2024 17:19:58 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Kaplan, David" <David.Kaplan@amd.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 11/35] x86/bugs: Restructure spectre_v1 mitigation
Message-ID: <20241114161958.GIZzYjLgooyYCECCl0@fat_crate.local>
References: <20241105215455.359471-1-david.kaplan@amd.com>
 <20241105215455.359471-12-david.kaplan@amd.com>
 <20241114064001.v6ogsiaptrh6oixc@desk>
 <LV3PR12MB9265747DB95F1F54E826A971945B2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <LV3PR12MB92654B44C7BDB16BA140D342945B2@LV3PR12MB9265.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <LV3PR12MB92654B44C7BDB16BA140D342945B2@LV3PR12MB9265.namprd12.prod.outlook.com>

On Thu, Nov 14, 2024 at 03:49:42PM +0000, Kaplan, David wrote:
> Actually looks like the existing code wasn't always consistent here.  For
> srbds, ssb, and gds, it would still print a message about the system being
> vulnerable even if mitigations=off was passed.  But for the others it would
> not print a message.  I think I'm going to suppress the message for all
> cases, but if people feel it should be the other way, let me know.

Yeah, we probably should fix this in a pre-patch. I.e., if mitigations=off,
not issue any "Vulnerable" message because this is the "master switch", so to
speak.

Or do we want to issue a bunch of "Vulnerable" in dmesg?

I gravitate towards former because if user supplies mitigations=off, then she
probably knows what she's doing...?

Hmm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

