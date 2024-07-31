Return-Path: <linux-kernel+bounces-268769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66502942910
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD837B2168C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BEB1A7F85;
	Wed, 31 Jul 2024 08:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CmEXqBA/"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAFC1A7F7D
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 08:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722414104; cv=none; b=YyKEElY7EPXrw82NQetk4UynwRltkIMxBAbq90mbD/cxG9fSlL2iyw2Wh0DKpw+OuNHkV0ZVCP24uUlOcJnNlxex7koh3N7HwJPlJvaJC9S0rWkLK9SYxCONnx6kosS4+7+1MQy4oqECmBgOCgDkZTy4Nnt4xQd280HUKWSnBjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722414104; c=relaxed/simple;
	bh=MGO6ubfczA25U+KnhcsQDBZTCyjd18cOyiBRtMO64UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjgLkSc3bGcGXrs9vnXyHOEbJJUrAy9J5P7qFKP2wYCQC6ses/GtbBRdS5Sq8F72p6WCCuFlEqHlbhxyEdkFb+Ec37NoPmtSCwwX0MXd99zP1IrWYxi+EiEPq2u3DbqGePZCJoh9BYnj76rwM/Y5MrnfGIZ3T0huFvyxDnc+rvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CmEXqBA/; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7910540E026B;
	Wed, 31 Jul 2024 08:21:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NM4xCoY2kykP; Wed, 31 Jul 2024 08:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1722414089; bh=cgdR6WtioQUyjA8OItc5Ou8uF3KV5sZ9eQ/hMkyQ8BE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CmEXqBA/XFv+cLGzUIDkZGbo53DfEQx+Sn6DQ2mbP1pUtZXPvn+z1IvIsv2thRq08
	 /6GI/AsnvGejxPfyo1jr9JJW6MIlN0823hwdojvnUHsoopwzCWtP552H4hxeV4eimR
	 oku30JGoOH+iSCTgG68I2KJnFpfrbYk1oeODRS2XdEZJaajsR3FMJP6jg6Oa1j1NR7
	 B9/a6ANgbTK+5Fu6jmVSdX/UHjjQ9bk5VFZplt5bMSyFtaLNjNrUUkrvEriqoWnfQL
	 bCvdujqhZCjPKlzjjTyUS3x3P8iogue72a3L44rLClrICd0OAJaM12jE11qGWB0xQY
	 SL2owYsCmD0sg7M+wpSCF9kYcJcC7tsSHSx8whyhTwwDNtlt1vmj9poI9WGnViUCze
	 Itg0P2dGwpXVk5laer2Zc/BJYDmv+Fx7mtmXeLf4D6WOg3UkAd24fhO7hr/WYJasm6
	 r99EVU+v8sWvFY96cTy4xXgQjWrrDdFtn+uFyadVsJyoFVtQ+z+4G05/t+afq1S2/1
	 J7iyWNhDE/UHqnnaOodUbqSRVb0hIIe2iqsgTSUALqdkCpwvLyWRnfDMBh9KEHRNjZ
	 yORvKZcwQvLNui2kh+uVCslqQvw7kYalJAu40CIhdfNOh7M8JnZsUsQsKBB31+ONOV
	 CVwBw6nPPVgAcPa/5ThVlDOU=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5508040E0263;
	Wed, 31 Jul 2024 08:21:20 +0000 (UTC)
Date: Wed, 31 Jul 2024 10:21:11 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Peter Zijlstra <peterz@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Anvin <hpa@zytor.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	the arch/x86 maintainers <x86@kernel.org>
Subject: Re: Linux 6.11-rc1
Message-ID: <20240731082111.GAZqnz97mCll6rDyV-@fat_crate.local>
References: <f8677c93-a76d-473c-8abc-8dc7b4403691@roeck-us.net>
 <b7ecddb7-4486-4b2d-9179-82250cf830e7@roeck-us.net>
 <CAHk-=wj2BYPvYQAQa-pyT3hERcd2pVw+rL5kw7Y=-8PA3JTDAg@mail.gmail.com>
 <20240730192237.GR33588@noisy.programming.kicks-ass.net>
 <231e7a2e-7e2e-4b82-b084-8943b2236de0@kernel.dk>
 <20240730193841.GS33588@noisy.programming.kicks-ass.net>
 <f395b9d1-9515-434b-8ea5-c3bcaac10fd1@roeck-us.net>
 <20240730200947.GT33588@noisy.programming.kicks-ass.net>
 <e791c078-a821-4636-b44d-e02c22c046cc@roeck-us.net>
 <CAHk-=wgnmrbQhnXdpi=sY68m4OJff+qSiOUY-L8SF_u8JkHe8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgnmrbQhnXdpi=sY68m4OJff+qSiOUY-L8SF_u8JkHe8A@mail.gmail.com>

On Tue, Jul 30, 2024 at 04:54:43PM -0700, Linus Torvalds wrote:
> You also seemed to say that it only happened with some CPU selections.
> Maybe there's something wrong with the ALTERNATIVE() cleanups - I'm
> looking at that new "nested alternatives macros" thing, and the odd
> games we play with the origin and replacement lengths etc.
> 
> That all looks entirely crazy. That file was hard to read before, now
> it's just incomprehensible to me.

I'm sorry to hear that. The reason we did it is because it was starting to
become really unwieldy to add a yet another alternative choice N in an
ALTERNATIVE_N call...

Anyway, I'll try to reproduce here. In the meantime, can anyone who can
reproduce - Guenter, Jens - boot that failing kernel with

  debug-alternative=-1

and copy dmesg and vmlinux somewhere for me?

It is a lot of output so make sure to catch it all.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

