Return-Path: <linux-kernel+bounces-517556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD08A3824F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AFE81889181
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9074B219A97;
	Mon, 17 Feb 2025 11:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jpaey1Ql"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8B0C2EF;
	Mon, 17 Feb 2025 11:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739793206; cv=none; b=jWOvN8RbMWMv31HFBfYUHuIlbp/4BEfhBbAm8sWxzERdoZvfxbJGYhK+4ucvce0ivacE9iM8HROxjPo0UMvilSeAwJXfh2MptDGTYHdpGo6g+Ymj38MJsYalWaLPMFil8bE5GnbkIDzrfiH2qT4ji6Gq/Mej7BLlTklBo0ZLMkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739793206; c=relaxed/simple;
	bh=z916Iychd0HXvtnRM3OHyA0sbxakqNjaFWHUwy3J6NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNjPtxsfNiizpFItlSMldz4zg4Oe/NlofzUapQm2sYHwVs16T0iMVlDpWGY3QVWeQ+E0IOcXrb1bfaxp5XNSOhBvcXuEIeoMZJiRYUIHwSQFDikJnfXfDD48hcNt+VC5fMxeNF8Y7BJsIPV62mGZStmTNvPd5VK01pcQPEflk8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jpaey1Ql; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F216740E020E;
	Mon, 17 Feb 2025 11:53:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 45Y3Va-akyTW; Mon, 17 Feb 2025 11:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739793198; bh=mu2JhVmxy63GluxBqerd8rHfP64lHZxl8HGv85HSA9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jpaey1Qlofx5B5A6UjTWUEnnX5SODXDyEzBNLUn2O40Rg+E3ikzN3h7wG0JqaC4e8
	 gavOw+YUzjYaalNtknzHni1KeUgVuWfLVpJ4wGTubd1ihYUin16rHpChPAQbTbSco7
	 KsuWtvfyAATo7hOxZDffYyQEiLbEJe3pxV4hfq+7mSM+Pbx4pCqzl8AWoQe8hGRID9
	 ayx0873at2NnfB05sD2YzZIBqvG8ifRo9SYjsUa3g3bp9DsxswcfLGwRPCq1/wDA7C
	 xmdLmk6dDeARqTX4prObNAH66ps/ybnQmU1sU6oSWQ4x6LXdeto3YhA1jDfj7kXD9t
	 PENrcWvsIhR8NeY87tW7ZsZGP8LJ4VZc0NbAaSBkWCi9LzA7agnJo360geaFN4NGPf
	 FZuagVkucd23TJNqgmvz1aF7tfSf4uyC77fhWJZLR+7kMP90R15hBxplNAl319RCgK
	 P4Dsq2WGZ16UbbIaxh2PqpSEqo2i+5gaTH//+r8MRRmIVXnkzZkp8o27EnO9ycjniE
	 hgNQuoniRCsG3AX8P6tArOT/1Q8UT0iKOi70FLoZrP/tG2QSscRIrq+RaHiKXDu+DV
	 W0/mJkMZWAliOkiXqIenfTYcn9R3wxGoKWHIw9w2/nddvYvl9TZJ+j9EmCUS6EH66f
	 CyM0SBWt1fpffoell8zyDwtk=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D51FC40E0191;
	Mon, 17 Feb 2025 11:53:07 +0000 (UTC)
Date: Mon, 17 Feb 2025 12:53:06 +0100
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
Message-ID: <20250217115306.GBZ7MjIoLsvwK3Qqho@fat_crate.local>
References: <20250129-force-cpu-bug-v2-0-5637b337b443@google.com>
 <20250129-force-cpu-bug-v2-3-5637b337b443@google.com>
 <20250217111029.GIZ7MZJUGJRoeiScgn@fat_crate.local>
 <CA+i-1C2GF=5VE5Bfq_znG1nVU6K5orzhOohBatc64ghX7mW6FA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+i-1C2GF=5VE5Bfq_znG1nVU6K5orzhOohBatc64ghX7mW6FA@mail.gmail.com>

On Mon, Feb 17, 2025 at 12:20:56PM +0100, Brendan Jackman wrote:
> On Mon, 17 Feb 2025 at 12:10, Borislav Petkov <bp@alien8.de> wrote:
> >
> > >  extern const char * const x86_bug_flags[NBUGINTS*32];
> > > +#define x86_bug_flag(flag) x86_bug_flags[flag]
> >
> > Why?
> 
> That's just for consistency with x86_cap_flag().
> 
> I don't remember seeing any reason why that indirection exists. Maybe
> it's vestigial. Shall I just remove it?

Wondering the same. Both arrays are automatically generated into capflags.c as 

const char * const x86_cap_flags[NCAPINTS*32] = {
const char * const x86_bug_flags[NBUGINTS*32] = {

so it's not like something is going to change them at runtime so what's the
point of the wrapper I dunno...

/me greps some...

Oh, I know:

-#ifdef CONFIG_X86_FEATURE_NAMES
 extern const char * const x86_cap_flags[NCAPINTS*32];
 extern const char * const x86_power_flags[32];
 #define X86_CAP_FMT "%s"
 #define x86_cap_flag(flag) x86_cap_flags[flag]
-#else
-#define X86_CAP_FMT X86_CAP_FMT_NUM
-#define x86_cap_flag x86_cap_flag_num
-#endif

from 7583e8fbdc49a4dbd916d14863cf1deeddb982f9

So yeah, it is a useless leftover now. So please remove.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

