Return-Path: <linux-kernel+bounces-425877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC07F9DEC1D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 19:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59B18B23286
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 18:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CF41A0724;
	Fri, 29 Nov 2024 18:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OHriYdHF"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD7E19F419
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 18:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732904891; cv=none; b=pb+RHKGmohXzRFpJcrIDkYqk4BeoGXzsMtthIi6ggFfMAvE1VR2nhm0L/xOpSu5HAdqGTOTqMZqlFg5M1gWbT6QsN3BpmtclzjAQ3rhW3xG1QSuYdyf4m3jYsFzVc9dn5rSdSmU/uQq/PcHZ21dtONEiCXMgW805svzBuTasnK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732904891; c=relaxed/simple;
	bh=zRcV5bDSxF/M+5TaGh3ukz48FbdYXTj7Lm8A4GHlQ0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oL6oqz4HkcpYABPCb8HRpTqi/yMGOKY4DO9Ev9qfd6bvZ4fdXR3q8E46WJytGINX5dMzQAcAHvcs7YQcDauAa2Rq74DliJKEFes7ltHVJ9CQNStLSomP9PfptI0cwGLJxA8S5qqko2f+jKKzTYtUiJhkUxIwdf+UY/VL2P/51q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=OHriYdHF; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 25F8B40E0275;
	Fri, 29 Nov 2024 18:28:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id LOcvsIyd_nIw; Fri, 29 Nov 2024 18:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1732904882; bh=uvak+YnW0f/P6nUZMSTvl2AZMSmth6P3XsNSPppOVdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OHriYdHFn/O8bmepA4U3lvbLeLl9jJyOQc/q4lUVgEhH6nx2lYdswMNKiSb3siz1f
	 v0kwckQe7oltZ0Nj7UGs70QIi7ye0O69ocx1+fmUYowcGuO5QiYsUKqL+VeaF1pUJ8
	 sw28VEYYIV+W5eyK85FSxWTGkv0bAHprNX438ntVAubUNCLH1HZbUZ/NOghlkmuEDc
	 camkZWqNiCVuSiAwwKEy74l3NHRy41o7Mr+WpJ1onL6rMtctmgE16PLZ5PU1e1k63w
	 wi3/lEQhLnOOSH+mvV2+nGFJA9Puwo/VHaeliBLF+hFa9P+aS4j3htM2CNAj2yCIij
	 4PLFVZfi+LCz9AP2G4upxF8wdK88HmrHdjxATek2ME651mS9R41dYDS37CyzWBdSj8
	 gZGQrBadH5E16LyY7zxI3k64NQiONt3HtA/5kGtR+aG6EXGEf4xYS91NrRzzoFr4A6
	 5oQibWNiaBwhYnt3CbeuaGqHCc64Fw25/pdTSaz9x5s/sGyQTkvNNqSDvg+suuvwqy
	 CtzRY+Z2Tp1H27XDUs8MADdWNsJt9e+ErglGyLwInrveSHP0giNGJjwDsXmWrH89ne
	 a+XY62dm/VtDNpaEQqv8+I4tF9BABEW2WT9N+fBD30+3sngvmznKbwp9wRGyFSRP0h
	 ByuTaq8Hb3FaCXJmBkpZwjCY=
Received: from zn.tnic (p200300Ea9736a103329C23fFfEa6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9736:a103:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 082F140E0200;
	Fri, 29 Nov 2024 18:27:54 +0000 (UTC)
Date: Fri, 29 Nov 2024 19:27:47 +0100
From: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, tglx@linutronix.de, rafael@kernel.org,
	lenb@kernel.org
Subject: Re: [PATCH 11/11] x86/cpu: Make all all CPUID leaf names consistent
Message-ID: <20241129182747.GEZ0oHo1eR0l7sREJY@fat_crate.local>
References: <20241030213310.C4861EC0@davehans-spike.ostc.intel.com>
 <20241030213329.3253F5F3@davehans-spike.ostc.intel.com>
 <20241031101834.GGZyNZejzr5A9bNL8J@fat_crate.local>
 <4d606240-a8c8-40e5-80da-57c9b4d48179@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4d606240-a8c8-40e5-80da-57c9b4d48179@intel.com>

On Thu, Oct 31, 2024 at 10:19:37AM -0700, Dave Hansen wrote:
> >> -#define CPUID_MWAIT_LEAF	0x5
> >> -#define CPUID_DCA_LEAF		0x9
> >> -#define XSTATE_CPUID		0x0d
> >> -#define CPUID_TSC_LEAF		0x15
> >> -#define CPUID_FREQ_LEAF		0x16
> >> -#define TILE_CPUID		0x1d
> >> +#define CPUID_LEAF_MWAIT	0x5
> >> +#define CPUID_LEAF_DCA		0x9
> >> +#define CPUID_LEAF_XSTATE	0x0d
> >> +#define CPUID_LEAF_TSC		0x15
> >> +#define CPUID_LEAF_FREQ		0x16
> >> +#define CPUID_LEAF_TILE		0x1d
> > 
> > ... and just to confuse things even more, there's enum cpuid_leafs too which
> > start with the "CPUID_" prefix too.
> > 
> > Pfff.
> 
> Yeah, lovely.  'enum cpuid_leafs' does appear misnamed though.  It is a
> list of *words*, not actual leaf numbers.  There's also very little
> overlap between those leafs and the newly-renamed ones in this series.
> I think that's because most of the leaves we dump into the CPU caps have
> random feature bits that aren't logically grouped and resist naming.
> 
> The one exception to that is the CPUID_D_1_EAX aka. CPUID_LEAF_XSTATE.
> We could do something like the attached patch, but I don't think it
> really helps much.
> 
> > I'd like to unify them and I *think* kvm_cpu_cap_mask() should be able to
> > stomach that (or fixed if not)...
> 
> Do you mean we could unify the CPUID_8000_0001_EDX enum values and the
> CPUID_LEAF_* defines from this series?

Well, enum cpuid_leafs as it is now is the *indices* into the cap flags array:

struct cpuinfo_x86 {

	...

	__u32           x86_capability[NCAPINTS + NBUGINTS];

And having a "CPUID_" prefixed thing and a "CPUID_LEAF_" prefixed other thing
is going to cause confusion.

And renaming enum cpuid_leafs is going to cause a massive churn...

IOW:

[ Rock ]	<-- us --> 	[ Hard Place ]

:-\

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

