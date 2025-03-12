Return-Path: <linux-kernel+bounces-558113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A62A5E1D8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E63E23B9BAD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7001C5F1E;
	Wed, 12 Mar 2025 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="En93nVVO"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1D380604
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741797178; cv=none; b=ELNatUpF29hyCGhgtyRLjbFaDvQdmffJZtZjZW7GG9onsSDkVVOx6okEDyaqTrGokO98MB4VpmSAaJUzkUBc0Oo25bn9hf4jFHS583iqssq/12JmEeFT3IZPI1zUw/15/fag2smjvJF7nnzSqveFh5mU6Q9aKei/8Sc2n2wiQXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741797178; c=relaxed/simple;
	bh=UtKTl8zW8/TKMKet8umEND9uMK0IljbspkAV0zwOS6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZdultD7wdO+vGzAk9N80yF37vyaZhjrRSoiawfJHXKPuBtP+FeyniNNmrCPD3orF8/odEib0tjJNnuqqDGQ5eo8fb9Or//6r9lpIcyXfO+CUw+jX+nW34qCJ2QlNjMJIOLp+Kv1Chb9bKvGrbTq5KszYNwUOfouW/oaeMMBjm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=En93nVVO; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E9AAB40E0238;
	Wed, 12 Mar 2025 16:32:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id yNnISorkGF2r; Wed, 12 Mar 2025 16:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741797167; bh=h1POj48N8pm8xGDGYwVgpJ08fqB2QQZLDHlCHmWebP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=En93nVVOSX3YDTgnSDTTXAEPEBj5Dhv1+I5nuhyc0CxXQfi6rYadVtObKXb29snxJ
	 mxwxOe5/rPgjC8Npc9Olc/eoffp+TJ97eo5GoUL7eEYMMDPy22EI0bbCLhLVBNg9mt
	 3o7aVZ/Lwh/5S0kMizrpy2+Q8ksdmqRGETvZsa6PBH9Cxc4a0Fw73jSoOw1dPVo527
	 gmnUx/VNxn/nuVXbusW2haFPr4+nojjPsu6Od9TUVbh34SEMMZXYh0snnX4DU93vSO
	 ADiPyZx8NiT3EcmutgED2m0I7LCc1c5CQ/Ht4lPcGVMw5g72YDKinZHCFn2Md/6PEy
	 fd1JVsyjLt/OTO/k5+lQLN44FNF81cy74wV1CmHXR6beJdGKA5lrxAy0kSjPw3rIzV
	 HkoIrShEHL7Fy1O7Sptt71zpGwk91s/ChN5NgTHP6iDpyxLkY2DkFTjoWCrGhX1jJT
	 c1Ha0uQVTWdSMYpMo8XFvLHtle/Kw5bAbTp/SLZq/OQegPFVsZiDeLRFiTQTN4yZdX
	 2DkhwGtp+5INp3H67oTWk3n04H+D1lStgTnQYd9qYNNJnwTmNmEs5EqajZttmJMgfS
	 373nt8IihxsNxkVz18kSOXpxxyNvaDzMFraVOyW0QDmrPIBEcj4IY1RUB+pfDdTkvV
	 JbpTs0A7k95+6lcQl1V8Dgt8=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4767040E0202;
	Wed, 12 Mar 2025 16:32:41 +0000 (UTC)
Date: Wed, 12 Mar 2025 17:32:34 +0100
From: Borislav Petkov <bp@alien8.de>
To: Mikhail Paulyshka <me@mixaill.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/rdrand: implement sanity check for RDSEED
Message-ID: <20250312163234.GEZ9G3IsDW1wxGWs7f@fat_crate.local>
References: <20250312123130.8290-1-me@mixaill.net>
 <20250312123130.8290-2-me@mixaill.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250312123130.8290-2-me@mixaill.net>

On Wed, Mar 12, 2025 at 03:31:29PM +0300, Mikhail Paulyshka wrote:
> +/*
> + * RDSEED has Built-In-Self-Test (BIST) that runs on every invocation.
> + * Run the instruction a few times as a sanity check. Also make sure
> + * it's not outputting the same value over and over, which has happened
> + * as a result of past CPU bugs.
> + *
> + * If it fails, it is simple to disable RDSEED here.
> + */
> +
> +void x86_init_rdseed(struct cpuinfo_x86 *c)
> +{
> +	unsigned long sample, prev;
> +	bool failure = false;
> +	size_t i, changed;
> +
> +	if (!cpu_has(c, X86_FEATURE_RDSEED))
> +		return;
> +
> +	for (changed = 0, i = 0; i < SAMPLES; ++i) {
> +		if (!rdseed_long(&sample)) {
> +			failure = true;
> +			break;
> +		}
> +		changed += i && sample != prev;
> +		prev = sample;
> +	}
> +	if (changed < MIN_CHANGE)
> +		failure = true;
> +
> +	if (failure) {
> +		clear_cpu_cap(c, X86_FEATURE_RDSEED);
> +		pr_emerg("RDSEED is not reliable on this platform; disabling.\n");
> +	}
> +}

This one basically duplicates x86_init_rdrand() and I'm sure you can use
a single function to test both.

But more importantly, lemme ask around internally whether that is even
a reliable test to detect RDSEED performs properly or not.

Stay tuned...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

