Return-Path: <linux-kernel+bounces-231923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D09A91A065
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D0BDB212D4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2CE4D9FB;
	Thu, 27 Jun 2024 07:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DLzFQX2I"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED31A4D8C3
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 07:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719473231; cv=none; b=ayOpXOsoBjokkbgFWD3YF4EcJQk90sT/La91BZ3u8373cy/aaLO2aVI0Hp/4EX7RWDSVd+7Lm+nTBQi4TOvVIKGNgN/rwvOWmwGO88v8e5XJFcRF0f/mJDzJbUG21qv4PgbKAYY4U1uF/kr16LNU+Tfv4CCsNLuzGXPOiKhyL8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719473231; c=relaxed/simple;
	bh=QE1kYNeLouscu8HFqw3OTgK2pBsH1z0Kk5zkasfLXvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTbnfN07i/FZCb/nVLc8ra1/G/980hgfXAAqjcKs356dMppn1eSmqbzodm06SabefU9jcayMiXDhwF8T3HZOq6bcroEDDtRrxhSFhB3qNg5X6+5j5UdaYOVMZohpkTnHtFsrFtkU35Og28GdAfu0M9wCgH/q4sUebMLWxysf8Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DLzFQX2I; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4B4FE40E0187;
	Thu, 27 Jun 2024 07:27:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sCsF5u5zh7N2; Thu, 27 Jun 2024 07:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719473219; bh=J2BIhifwOifAop8D3YwWmk6Kw+mQtPUl556teaLsoyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DLzFQX2IdX3FUf+ClNlL9lZSUgu7EEdUdr7pmMYW60KCnU49/q2Zw5RojhNXXDhBY
	 85tM7+9gJrdbXRoToTsN4xrUGzTh2oYzL2MmYoYi1onp5zkkujVmvvp/xRfxReI5l/
	 ubrR0G+WJc65vghO3KA30s15M8kdA0dMlnCuP930ru3xTf8yWh2tWICO/q9aqSy9V6
	 u8RVhc2Sd8hNAEz6IIgPTuOw1dAg0HuqHmzO9RzcCmwXtzkiruObkNIFxMDXHQO8xW
	 NaNBFEDoviOMQUpK0fn5TCNmE3aYUPYisg8ltVyTmbsOwZDYIDxuwHJDM2ZtGh5sWn
	 D9A2dj2rrEl2rwcfIGPz+yFrqV10PTN4h6TPnBy/X8udYD8JWdhaU0SiPKDjp75fyT
	 nkz3i2sLbGcJsg4e3JN9sBJJHg9EnYzCK9rWhXskpU8E9hCtHBHP9XR/0maMMxCewU
	 1QbzQa76ukG2ezbB/Rh41nzea3+5pWMODG70VsWH0xToqlBSZzw2MCEOD37kc3z6lj
	 TYo+Chh1SyQAujZOsertn1Enq6RSCIuXKTu1G+yrwk/bODB9ofVvq/ac8NsNazIrAF
	 xMfAYeGWZOZ+Bz6ORdEfBuAImxsX0nb7FvaKV3WlNQWwUJPGIF83Ezs5rTGOZx48Y2
	 F4yvgAYNf0tg8QMJgGcbGxVw=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 46F1B40E0185;
	Thu, 27 Jun 2024 07:26:40 +0000 (UTC)
Date: Thu, 27 Jun 2024 09:26:34 +0200
From: Borislav Petkov <bp@alien8.de>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	KP Singh <kpsingh@kernel.org>, Waiman Long <longman@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v6 1/3] x86/syscall: Mark exit[_group] syscall handlers
 __noreturn
Message-ID: <20240627072634.GAZn0UKqtwqwQhWr4q@fat_crate.local>
References: <cover.1719381528.git.jpoimboe@kernel.org>
 <5d8882bc077d8eadcc7fd1740b56dfb781f12288.1719381528.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5d8882bc077d8eadcc7fd1740b56dfb781f12288.1719381528.git.jpoimboe@kernel.org>

On Tue, Jun 25, 2024 at 11:02:00PM -0700, Josh Poimboeuf wrote:
> The direct-call syscall dispatch function doesn't know that the exit()
> and exit_group() syscall handlers don't return, so the call sites aren't
> optimized accordingly.
> 
> Fix that by marking the exit syscall declarations __noreturn.
> 
> Fixes the following warnings:
> 
>   vmlinux.o: warning: objtool: x64_sys_call+0x2804: __x64_sys_exit() is missing a __noreturn annotation
>   vmlinux.o: warning: objtool: ia32_sys_call+0x29b6: __ia32_sys_exit_group() is missing a __noreturn annotation
> 
> Fixes: 7390db8aea0d ("x86/bhi: Add support for clearing branch history at syscall entry")
> Reported-by: "Paul E. McKenney" <paulmck@kernel.org>
> Closes: https://lkml.kernel.org/lkml/6dba9b32-db2c-4e6d-9500-7a08852f17a3@paulmck-laptop

This here talks about

1e3ad78334a6 ("x86/syscall: Don't force use of indirect calls for system calls")

being the culprit.

But Fixes points to something unrelated...?

In any case, I won't send this to Linus now as urgent material unless someone
presents a reasonable argument for it...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

