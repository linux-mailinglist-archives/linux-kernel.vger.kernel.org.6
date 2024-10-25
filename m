Return-Path: <linux-kernel+bounces-380960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D6C9AF846
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 05:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59630286925
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 03:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8335018C017;
	Fri, 25 Oct 2024 03:36:17 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4FF81727
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 03:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729827377; cv=none; b=S4X6DnmA7YGza9YkQOvK+vNhKRJVM0fqwLgvXq/DzFJhth6NaoCtikL5sVGpjnMTXSeYPs+aZoTX3zk3CGW+RHK/S0QWIIUgn1wf/Jvv8nzJcB74n3zcHRmKrhDHbtJ26WPt6jIF/DCG3vkK5z7ijLXg60fJdzeYE47INl1UYcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729827377; c=relaxed/simple;
	bh=osaZmL7c3w886roQtoHVPyCRI9X5Wu/zdoQpxSW6enw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FH0YTlcOgKLSie59kr1CQUH2S+kCorOvipClLQuU6qvUY9aTsoTy9MWzDG3TAAtPuhnM2c5aZiyL+9RvQJ6tZw2GBIRXURBA+WGJesdrQ5sdaUugTfkRJ4mDzXRJezTCsFQXKiqNsxAnXK++Gh52DzjnG66AFHSdUfID14LUlEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 49P3N2ot016616;
	Thu, 24 Oct 2024 22:23:02 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 49P3Mr9D016605;
	Thu, 24 Oct 2024 22:22:53 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Thu, 24 Oct 2024 22:22:53 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Nysal Jan K.A." <nysal@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linuxppc-dev@lists.ozlabs.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] sched/membarrier: Fix redundant load of membarrier_state
Message-ID: <20241025032253.GN29862@gate.crashing.org>
References: <20241007053936.833392-1-nysal@linux.ibm.com> <87frolja8d.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87frolja8d.fsf@mail.lhotse>
User-Agent: Mutt/1.4.2.3i

Hi!

On Fri, Oct 25, 2024 at 11:29:38AM +1100, Michael Ellerman wrote:
> [To += Mathieu]
> 
> "Nysal Jan K.A." <nysal@linux.ibm.com> writes:
> > From: "Nysal Jan K.A" <nysal@linux.ibm.com>
> >
> > On architectures where ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
> > is not selected, sync_core_before_usermode() is a no-op.
> > In membarrier_mm_sync_core_before_usermode() the compiler does not
> > eliminate redundant branches and the load of mm->membarrier_state
> > for this case as the atomic_read() cannot be optimized away.
> 
> I was wondering if this was caused by powerpc's arch_atomic_read() which
> uses asm volatile.
> 
> But replacing arch_atomic_read() with READ_ONCE() makes no difference,
> presumably because the compiler still can't see that the READ_ONCE() is
> unnecessary (which is kind of by design).

Exactly.

> > GCC 12.2.1:
> > -----------
> > add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-32 (-32)
> > Function                                     old     new   delta
> > finish_task_switch.isra                      852     820     -32
> 
> GCC 12 is a couple of years old, I assume GCC 14 behaves similarly?

GCC 12 is still being actively developed.  There will be a 12.5
probably halfway next year (and that will be the last 12.x release,
yes).  The GCC homepage (<https://gcc.gnu.org>) will tell you what
releases are still maintained/supported, and sometimes you can derive
our planned plans from there as well :-)

But yes, 14 is similar (I did not test, but I feel confident making that
assertion :-) )

> >  static inline void membarrier_mm_sync_core_before_usermode(struct mm_struct *mm)
> >  {
> > +	if (!IS_ENABLED(CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE))
> > +		return;
> >  	if (current->mm != mm)
> >  		return;
> >  	if (likely(!(atomic_read(&mm->membarrier_state) &
> 
> The other option would be to have a completely separate stub, eg:
> 
>   #ifdef CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
>   static inline void membarrier_mm_sync_core_before_usermode(struct mm_struct *mm)
>   {
>           if (current->mm != mm)
>                   return;
>           if (likely(!(atomic_read(&mm->membarrier_state) &
>                        MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE)))
>                   return;
>           sync_core_before_usermode();
>   }
>   #else
>   static inline void membarrier_mm_sync_core_before_usermode(struct mm_struct *mm) { }
>   #endif
> 
> Not sure what folks prefer.
> 
> In either case I think it's probably worth a short comment explaining
> why it's worth the trouble (ie. that the atomic_read() prevents the
> compiler from doing DCE).

Since you ask, I like the proposed change (the inline one) best.  But
yeah, comment please!

(And it is not about DCE -- just the definition of __READ_ONCE makes it
directly impossible to CSE any expressions with this, it (standards-
violatingly) casts the pointers to pointers to volatile, and you cannot
CSE any accesses to volatile objects!)

So what are the actual semantics the kernel wants from its READ_ONCE,
and from its atomics in general?  GCC has perfectly fine in-compiler
support for such things, there is no need for making a second rate
manual implementation of parts of this, when you can use a good
implementation of everything instead!


Segher

