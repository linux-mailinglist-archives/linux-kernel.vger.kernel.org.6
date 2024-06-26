Return-Path: <linux-kernel+bounces-230065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0480E9177FD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 348C41C22485
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 05:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9A113E3EA;
	Wed, 26 Jun 2024 05:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nd0q91II"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23AC22089
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 05:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719379279; cv=none; b=YMLoj4mvZ6nu+DCrqRMxX2qULefGKVjt3+23mC3e/s3Xe7wnHhez2rdkIr9M2zmGIokzDwpyd3f6SAcW6H6E1sBxDT3hUkJbQcJU8TRoz6xCEgGjLsTuEZu7p8cfLTJvvLDzddUZ+/MnyIPTAPQL+1HBwYqXXAK87JBmftJMoHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719379279; c=relaxed/simple;
	bh=Q0hWDt4zE27Rj2D6bN9KOTwTIc5PcuUNZEBfQRM6GZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ge43Q8kL2X05NnBW10DEpzCHff/GeMTPCTFJXUUhegS9gyNrc2CY5B7T+y45GHtE4tEX/C02E2zu/eqUfC8ggpPZyJSDsBcPseBUxkh6fpMd9QgPkxyn3iRpVQTl9G6IE7+k9iQuvx82L0It3mBY7dE7ngGFqNPoOLfcvGiPvqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nd0q91II; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A66C2BD10;
	Wed, 26 Jun 2024 05:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719379279;
	bh=Q0hWDt4zE27Rj2D6bN9KOTwTIc5PcuUNZEBfQRM6GZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nd0q91IIMz+3OW5axqN85K344gsfTXOgKnLYjbn+z3faFnuobgQDLaBjKFyXOmNfH
	 18x9BcEVkAiASpvuXBWjzoK4gHvxLipKO2baYDFTkuGxLibckjSOS9ZuRAVGnX+O44
	 qmA+QhvHj+YtgEIB5pS8d0tXd2i2xM1q+UMqdviu7a4SLWtCkmOCNu7X2N/aEZFQPP
	 pXDvL/7B0oa1XiRvLfCRsIE0zZcsj8aG6Zdw1fuB+MOe+1QvZDD2YVL1p18mWCTYRF
	 srvXZOARXrLwI7oMEIpp37XJHqI/ZohfeVCMuxQAGJ5tG+zMJWuAfiWWsp05dl7krr
	 sScKqHkrHbIlA==
Date: Tue, 25 Jun 2024 22:21:17 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Nikolay Borisov <nik.borisov@suse.com>
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
	KP Singh <kpsingh@kernel.org>, Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v5 1/3] x86/syscall: Mark exit[_group] syscall handlers
 __noreturn
Message-ID: <20240626052117.tej46l7koshgk3hb@treble>
References: <cover.1715059256.git.jpoimboe@kernel.org>
 <9ad251f6258adde596fb1f4d6826309b9f239ed3.1715059256.git.jpoimboe@kernel.org>
 <b77e5491-77ec-4a4f-8ea9-4842b6923bfa@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b77e5491-77ec-4a4f-8ea9-4842b6923bfa@suse.com>

On Mon, May 27, 2024 at 02:15:57PM +0300, Nikolay Borisov wrote:
> 
> 
> On 7.05.24 г. 8:30 ч., Josh Poimboeuf wrote:
> > The direct-call syscall dispatch function doesn't know that the exit()
> > and exit_group() syscall handlers don't return, so the call sites aren't
> > optimized accordingly.
> > 
> > Fix that by marking those exit syscall declarations __noreturn.
> > 
> > Fixes the following warnings:
> > 
> >    vmlinux.o: warning: objtool: x64_sys_call+0x2804: __x64_sys_exit() is missing a __noreturn annotation
> >    vmlinux.o: warning: objtool: ia32_sys_call+0x29b6: __ia32_sys_exit_group() is missing a __noreturn annotation
> > 
> > Fixes: 7390db8aea0d ("x86/bhi: Add support for clearing branch history at syscall entry")
> > Reported-by: "Paul E. McKenney" <paulmck@kernel.org>
> > Closes: https://lkml.kernel.org/lkml/6dba9b32-db2c-4e6d-9500-7a08852f17a3@paulmck-laptop
> > Tested-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > ---
> >   arch/x86/entry/syscall_32.c            | 10 ++++++----
> >   arch/x86/entry/syscall_64.c            |  9 ++++++---
> >   arch/x86/entry/syscall_x32.c           |  7 +++++--
> >   arch/x86/entry/syscalls/syscall_32.tbl |  6 +++---
> >   arch/x86/entry/syscalls/syscall_64.tbl |  6 +++---
> >   arch/x86/um/sys_call_table_32.c        | 10 ++++++----
> >   arch/x86/um/sys_call_table_64.c        | 11 +++++++----
> >   scripts/syscalltbl.sh                  | 18 ++++++++++++++++--
> >   tools/objtool/noreturns.h              |  4 ++++
> >   9 files changed, 56 insertions(+), 25 deletions(-)
> > 
> > diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
> > index c2235bae17ef..8cc9950d7104 100644
> > --- a/arch/x86/entry/syscall_32.c
> > +++ b/arch/x86/entry/syscall_32.c
> > @@ -14,9 +14,12 @@
> >   #endif
> >   #define __SYSCALL(nr, sym) extern long __ia32_##sym(const struct pt_regs *);
> > -
> > +#define __SYSCALL_NORETURN(nr, sym) extern long __noreturn __ia32_##sym(const struct pt_regs *);
> >   #include <asm/syscalls_32.h>
> > -#undef __SYSCALL
> > +#undef  __SYSCALL
> > +
> > +#undef  __SYSCALL_NORETURN
> > +#define __SYSCALL_NORETURN __SYSCALL
> >   /*
> >    * The sys_call_table[] is no longer used for system calls, but
> > @@ -28,11 +31,10 @@
> >   const sys_call_ptr_t sys_call_table[] = {
> >   #include <asm/syscalls_32.h>
> >   };
> > -#undef __SYSCALL
> > +#undef  __SYSCALL
> 
> nit: Am I blind or all the __SYSCALL lines have an extra whitespace?
> 
> <snip>

That was a small readability tweak to make '__SYSCALL' vertically aligned:

#define __SYSCALL(nr, sym) extern long __ia32_##sym(const struct pt_regs *);
#define __SYSCALL_NORETURN(nr, sym) extern long __noreturn __ia32_##sym(const struct pt_regs *);
#include <asm/syscalls_32.h>
#undef  __SYSCALL

-- 
Josh

