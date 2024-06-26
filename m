Return-Path: <linux-kernel+bounces-229926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA1491761B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 04:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3044D28498C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 02:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADA41D699;
	Wed, 26 Jun 2024 02:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwALYdhK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC29312E6A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 02:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719368495; cv=none; b=OaIXtVfJVPBz3gn9SCfmZdbOmzv2CCIpAeMJmRBsxiov73I/vgDnsEhnk3kd6LKtcY43a0tSwFSBl9TTAiKKLhvrhQj6oOGh1Hh2GPWg3hIGAQwy83/MCiJXX88m8veqNK6mQlTde3AObOBzkPaj4xs+d7aTQRhiifPR1aY8SsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719368495; c=relaxed/simple;
	bh=BORz9BcJgVq0MKOsxg35FBIiw3P5yh3U01s07tG+uag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bd6Lx18JD8Ix61v1D/jaP9MJWM8SpTzdw7oZwL0C1k7e9hATAhDsZACFye8SzAeJ9qgZfKiM/ne/AALN92u1iYJF/5QB2tlpnTyL6p148pt4GcarwibLZ9BEbeCHCuhlVLZ+sbsjS8aj2T0hwz49toSPnPzXiFiDDpaM2N3bVFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwALYdhK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52FFAC32781;
	Wed, 26 Jun 2024 02:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719368495;
	bh=BORz9BcJgVq0MKOsxg35FBIiw3P5yh3U01s07tG+uag=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=lwALYdhKaig9CekJ9CkAxl1MM1wCHvBv2csOJqjwPli2b3P+0IjuJS25CKSzdEET/
	 3gW9uRVB0sq/tjE9bNJsuhtChPs1U/S9WxhwsJefDfZzMbivnsxutFZQz89c+gThBB
	 k309VIqTLSDw7iScmaqValfOgvhLmmVyZkdFcTInX4WEVNgRkW/sLIDoX/p6EB80C2
	 KzhrD0UZO6tRlkSnkWYh5SYfeVrepMkwc+HFEejjxaD4Yn/gm5mEvZpLtenU6N4/Mb
	 oefHgKfVekTxH0rh8HLsm2t5cTsCJf+7rSp7S9reo7f2XJQEIQSDW+d5vkxbBCFfQw
	 KiS4iK7cs+CRQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4FF64CE08FF; Tue, 25 Jun 2024 19:21:34 -0700 (PDT)
Date: Tue, 25 Jun 2024 19:21:34 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
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
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v5 1/3] x86/syscall: Mark exit[_group] syscall handlers
 __noreturn
Message-ID: <4b97c5c8-73ac-417d-8b1c-61ccd0768bda@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <cover.1715059256.git.jpoimboe@kernel.org>
 <9ad251f6258adde596fb1f4d6826309b9f239ed3.1715059256.git.jpoimboe@kernel.org>
 <31af8226-8357-493e-a280-465f91b58d35@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31af8226-8357-493e-a280-465f91b58d35@paulmck-laptop>

On Tue, May 07, 2024 at 07:38:32AM -0700, Paul E. McKenney wrote:
> On Mon, May 06, 2024 at 10:30:04PM -0700, Josh Poimboeuf wrote:
> > The direct-call syscall dispatch function doesn't know that the exit()
> > and exit_group() syscall handlers don't return, so the call sites aren't
> > optimized accordingly.
> > 
> > Fix that by marking those exit syscall declarations __noreturn.
> > 
> > Fixes the following warnings:
> > 
> >   vmlinux.o: warning: objtool: x64_sys_call+0x2804: __x64_sys_exit() is missing a __noreturn annotation
> >   vmlinux.o: warning: objtool: ia32_sys_call+0x29b6: __ia32_sys_exit_group() is missing a __noreturn annotation
> > 
> > Fixes: 7390db8aea0d ("x86/bhi: Add support for clearing branch history at syscall entry")
> > Reported-by: "Paul E. McKenney" <paulmck@kernel.org>
> > Closes: https://lkml.kernel.org/lkml/6dba9b32-db2c-4e6d-9500-7a08852f17a3@paulmck-laptop
> > Tested-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Just reaffirming my Tested-by, and thank you!

And just following up, given that I do not yet see this in -next.  Any
chance of this making the upcoming merge window?

							Thanx, Paul

> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > ---
> >  arch/x86/entry/syscall_32.c            | 10 ++++++----
> >  arch/x86/entry/syscall_64.c            |  9 ++++++---
> >  arch/x86/entry/syscall_x32.c           |  7 +++++--
> >  arch/x86/entry/syscalls/syscall_32.tbl |  6 +++---
> >  arch/x86/entry/syscalls/syscall_64.tbl |  6 +++---
> >  arch/x86/um/sys_call_table_32.c        | 10 ++++++----
> >  arch/x86/um/sys_call_table_64.c        | 11 +++++++----
> >  scripts/syscalltbl.sh                  | 18 ++++++++++++++++--
> >  tools/objtool/noreturns.h              |  4 ++++
> >  9 files changed, 56 insertions(+), 25 deletions(-)
> > 
> > diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
> > index c2235bae17ef..8cc9950d7104 100644
> > --- a/arch/x86/entry/syscall_32.c
> > +++ b/arch/x86/entry/syscall_32.c
> > @@ -14,9 +14,12 @@
> >  #endif
> >  
> >  #define __SYSCALL(nr, sym) extern long __ia32_##sym(const struct pt_regs *);
> > -
> > +#define __SYSCALL_NORETURN(nr, sym) extern long __noreturn __ia32_##sym(const struct pt_regs *);
> >  #include <asm/syscalls_32.h>
> > -#undef __SYSCALL
> > +#undef  __SYSCALL
> > +
> > +#undef  __SYSCALL_NORETURN
> > +#define __SYSCALL_NORETURN __SYSCALL
> >  
> >  /*
> >   * The sys_call_table[] is no longer used for system calls, but
> > @@ -28,11 +31,10 @@
> >  const sys_call_ptr_t sys_call_table[] = {
> >  #include <asm/syscalls_32.h>
> >  };
> > -#undef __SYSCALL
> > +#undef  __SYSCALL
> >  #endif
> >  
> >  #define __SYSCALL(nr, sym) case nr: return __ia32_##sym(regs);
> > -
> >  long ia32_sys_call(const struct pt_regs *regs, unsigned int nr)
> >  {
> >  	switch (nr) {
> > diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
> > index 33b3f09e6f15..ba8354424860 100644
> > --- a/arch/x86/entry/syscall_64.c
> > +++ b/arch/x86/entry/syscall_64.c
> > @@ -8,8 +8,12 @@
> >  #include <asm/syscall.h>
> >  
> >  #define __SYSCALL(nr, sym) extern long __x64_##sym(const struct pt_regs *);
> > +#define __SYSCALL_NORETURN(nr, sym) extern long __noreturn __x64_##sym(const struct pt_regs *);
> >  #include <asm/syscalls_64.h>
> > -#undef __SYSCALL
> > +#undef  __SYSCALL
> > +
> > +#undef  __SYSCALL_NORETURN
> > +#define __SYSCALL_NORETURN __SYSCALL
> >  
> >  /*
> >   * The sys_call_table[] is no longer used for system calls, but
> > @@ -20,10 +24,9 @@
> >  const sys_call_ptr_t sys_call_table[] = {
> >  #include <asm/syscalls_64.h>
> >  };
> > -#undef __SYSCALL
> > +#undef  __SYSCALL
> >  
> >  #define __SYSCALL(nr, sym) case nr: return __x64_##sym(regs);
> > -
> >  long x64_sys_call(const struct pt_regs *regs, unsigned int nr)
> >  {
> >  	switch (nr) {
> > diff --git a/arch/x86/entry/syscall_x32.c b/arch/x86/entry/syscall_x32.c
> > index 03de4a932131..fb77908f44f3 100644
> > --- a/arch/x86/entry/syscall_x32.c
> > +++ b/arch/x86/entry/syscall_x32.c
> > @@ -8,11 +8,14 @@
> >  #include <asm/syscall.h>
> >  
> >  #define __SYSCALL(nr, sym) extern long __x64_##sym(const struct pt_regs *);
> > +#define __SYSCALL_NORETURN(nr, sym) extern long __noreturn __x64_##sym(const struct pt_regs *);
> >  #include <asm/syscalls_x32.h>
> > -#undef __SYSCALL
> > +#undef  __SYSCALL
> > +
> > +#undef  __SYSCALL_NORETURN
> > +#define __SYSCALL_NORETURN __SYSCALL
> >  
> >  #define __SYSCALL(nr, sym) case nr: return __x64_##sym(regs);
> > -
> >  long x32_sys_call(const struct pt_regs *regs, unsigned int nr)
> >  {
> >  	switch (nr) {
> > diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> > index 5f8591ce7f25..9e9a908cd50d 100644
> > --- a/arch/x86/entry/syscalls/syscall_32.tbl
> > +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> > @@ -2,7 +2,7 @@
> >  # 32-bit system call numbers and entry vectors
> >  #
> >  # The format is:
> > -# <number> <abi> <name> <entry point> <compat entry point>
> > +# <number> <abi> <name> <entry point> [<compat entry point> [noreturn]]
> >  #
> >  # The __ia32_sys and __ia32_compat_sys stubs are created on-the-fly for
> >  # sys_*() system calls and compat_sys_*() compat system calls if
> > @@ -12,7 +12,7 @@
> >  # The abi is always "i386" for this file.
> >  #
> >  0	i386	restart_syscall		sys_restart_syscall
> > -1	i386	exit			sys_exit
> > +1	i386	exit			sys_exit			-			noreturn
> >  2	i386	fork			sys_fork
> >  3	i386	read			sys_read
> >  4	i386	write			sys_write
> > @@ -263,7 +263,7 @@
> >  249	i386	io_cancel		sys_io_cancel
> >  250	i386	fadvise64		sys_ia32_fadvise64
> >  # 251 is available for reuse (was briefly sys_set_zone_reclaim)
> > -252	i386	exit_group		sys_exit_group
> > +252	i386	exit_group		sys_exit_group			-			noreturn
> >  253	i386	lookup_dcookie
> >  254	i386	epoll_create		sys_epoll_create
> >  255	i386	epoll_ctl		sys_epoll_ctl
> > diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> > index 7e8d46f4147f..5ea7387c1aa1 100644
> > --- a/arch/x86/entry/syscalls/syscall_64.tbl
> > +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> > @@ -2,7 +2,7 @@
> >  # 64-bit system call numbers and entry vectors
> >  #
> >  # The format is:
> > -# <number> <abi> <name> <entry point>
> > +# <number> <abi> <name> <entry point> [<compat entry point> [noreturn]]
> >  #
> >  # The __x64_sys_*() stubs are created on-the-fly for sys_*() system calls
> >  #
> > @@ -68,7 +68,7 @@
> >  57	common	fork			sys_fork
> >  58	common	vfork			sys_vfork
> >  59	64	execve			sys_execve
> > -60	common	exit			sys_exit
> > +60	common	exit			sys_exit			-			noreturn
> >  61	common	wait4			sys_wait4
> >  62	common	kill			sys_kill
> >  63	common	uname			sys_newuname
> > @@ -239,7 +239,7 @@
> >  228	common	clock_gettime		sys_clock_gettime
> >  229	common	clock_getres		sys_clock_getres
> >  230	common	clock_nanosleep		sys_clock_nanosleep
> > -231	common	exit_group		sys_exit_group
> > +231	common	exit_group		sys_exit_group			-			noreturn
> >  232	common	epoll_wait		sys_epoll_wait
> >  233	common	epoll_ctl		sys_epoll_ctl
> >  234	common	tgkill			sys_tgkill
> > diff --git a/arch/x86/um/sys_call_table_32.c b/arch/x86/um/sys_call_table_32.c
> > index 89df5d89d664..51655133eee3 100644
> > --- a/arch/x86/um/sys_call_table_32.c
> > +++ b/arch/x86/um/sys_call_table_32.c
> > @@ -9,6 +9,10 @@
> >  #include <linux/cache.h>
> >  #include <asm/syscall.h>
> >  
> > +extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long,
> > +				      unsigned long, unsigned long,
> > +				      unsigned long, unsigned long);
> > +
> >  /*
> >   * Below you can see, in terms of #define's, the differences between the x86-64
> >   * and the UML syscall table.
> > @@ -22,15 +26,13 @@
> >  #define sys_vm86 sys_ni_syscall
> >  
> >  #define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, native)
> > +#define __SYSCALL_NORETURN __SYSCALL
> >  
> >  #define __SYSCALL(nr, sym) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
> >  #include <asm/syscalls_32.h>
> > +#undef  __SYSCALL
> >  
> > -#undef __SYSCALL
> >  #define __SYSCALL(nr, sym) sym,
> > -
> > -extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
> > -
> >  const sys_call_ptr_t sys_call_table[] ____cacheline_aligned = {
> >  #include <asm/syscalls_32.h>
> >  };
> > diff --git a/arch/x86/um/sys_call_table_64.c b/arch/x86/um/sys_call_table_64.c
> > index b0b4cfd2308c..943d414f2109 100644
> > --- a/arch/x86/um/sys_call_table_64.c
> > +++ b/arch/x86/um/sys_call_table_64.c
> > @@ -9,6 +9,10 @@
> >  #include <linux/cache.h>
> >  #include <asm/syscall.h>
> >  
> > +extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long,
> > +				      unsigned long, unsigned long,
> > +				      unsigned long, unsigned long);
> > +
> >  /*
> >   * Below you can see, in terms of #define's, the differences between the x86-64
> >   * and the UML syscall table.
> > @@ -18,14 +22,13 @@
> >  #define sys_iopl sys_ni_syscall
> >  #define sys_ioperm sys_ni_syscall
> >  
> > +#define __SYSCALL_NORETURN __SYSCALL
> > +
> >  #define __SYSCALL(nr, sym) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
> >  #include <asm/syscalls_64.h>
> > +#undef  __SYSCALL
> >  
> > -#undef __SYSCALL
> >  #define __SYSCALL(nr, sym) sym,
> > -
> > -extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
> > -
> >  const sys_call_ptr_t sys_call_table[] ____cacheline_aligned = {
> >  #include <asm/syscalls_64.h>
> >  };
> > diff --git a/scripts/syscalltbl.sh b/scripts/syscalltbl.sh
> > index 6abe143889ef..6a903b87a7c2 100755
> > --- a/scripts/syscalltbl.sh
> > +++ b/scripts/syscalltbl.sh
> > @@ -54,7 +54,7 @@ nxt=0
> >  
> >  grep -E "^[0-9]+[[:space:]]+$abis" "$infile" | {
> >  
> > -	while read nr abi name native compat ; do
> > +	while read nr abi name native compat noreturn; do
> >  
> >  		if [ $nxt -gt $nr ]; then
> >  			echo "error: $infile: syscall table is not sorted or duplicates the same syscall number" >&2
> > @@ -66,7 +66,21 @@ grep -E "^[0-9]+[[:space:]]+$abis" "$infile" | {
> >  			nxt=$((nxt + 1))
> >  		done
> >  
> > -		if [ -n "$compat" ]; then
> > +		if [ "$compat" = "-" ]; then
> > +			unset compat
> > +		fi
> > +
> > +		if [ -n "$noreturn" ]; then
> > +			if [ "$noreturn" != "noreturn" ]; then
> > +				echo "error: $infile: invalid string \"$noreturn\" in 'noreturn' column"
> > +				exit 1
> > +			fi
> > +			if [ -n "$compat" ]; then
> > +				echo "__SYSCALL_COMPAT_NORETURN($nr, $native, $compat)"
> > +			else
> > +				echo "__SYSCALL_NORETURN($nr, $native)"
> > +			fi
> > +		elif [ -n "$compat" ]; then
> >  			echo "__SYSCALL_WITH_COMPAT($nr, $native, $compat)"
> >  		elif [ -n "$native" ]; then
> >  			echo "__SYSCALL($nr, $native)"
> > diff --git a/tools/objtool/noreturns.h b/tools/objtool/noreturns.h
> > index 7ebf29c91184..1e8141ef1b15 100644
> > --- a/tools/objtool/noreturns.h
> > +++ b/tools/objtool/noreturns.h
> > @@ -7,12 +7,16 @@
> >   * Yes, this is unfortunate.  A better solution is in the works.
> >   */
> >  NORETURN(__fortify_panic)
> > +NORETURN(__ia32_sys_exit)
> > +NORETURN(__ia32_sys_exit_group)
> >  NORETURN(__kunit_abort)
> >  NORETURN(__module_put_and_kthread_exit)
> >  NORETURN(__reiserfs_panic)
> >  NORETURN(__stack_chk_fail)
> >  NORETURN(__tdx_hypercall_failed)
> >  NORETURN(__ubsan_handle_builtin_unreachable)
> > +NORETURN(__x64_sys_exit)
> > +NORETURN(__x64_sys_exit_group)
> >  NORETURN(arch_cpu_idle_dead)
> >  NORETURN(bch2_trans_in_restart_error)
> >  NORETURN(bch2_trans_restart_error)
> > -- 
> > 2.44.0
> > 

