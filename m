Return-Path: <linux-kernel+bounces-242828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99161928DA6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 20:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DD481F22BCC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 18:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1152E16D305;
	Fri,  5 Jul 2024 18:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Aspb08I2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F7E5465B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 18:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720205808; cv=none; b=LPLPWpeZY6uOaxY+ybwmL36S9L+8G6aBqHqD4Wd31/62aXdt5S3k3KDtrsXsIRFoRkCI8lEcoU+SztFKD78DAuI8Q94vzr7sY47ie/txEjCygCmheSu4dGOT/EDPiH0d1aU89vpsyC6iXv0JmwmmdYT7OHW/6Ae6boh4nznH8RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720205808; c=relaxed/simple;
	bh=EZfUd9sNUGKFqJ6f4a08R6Mkz2FIMMSN/NpFH6eY5YE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXE7qXNgSdEjoK83b/nEav1gqvm2xDIEF6xdrb1VPxy/Kods4nl4XPAWVUymjykiM8PdjM1f5tObWNeKmymJXMN52vlHdKP73QUuXaevrCraG3Vl3EfWoBByYTjxsMQvKs86vsFRfEj7m7lpkwJL5Cg3iEHARdE2sZVTmGsYRCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=Aspb08I2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F28C116B1;
	Fri,  5 Jul 2024 18:56:47 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Aspb08I2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720205805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sbKYiW4dbcStlzjQsMbP++gHwA8jtJwdE2r5MY2Q0fI=;
	b=Aspb08I2pT+CVSltgb7jecfEfFQ4BFPMneqd7GsLIBRcktvTJEZmiqKS2yFnPRV7r50ev0
	OiPucHyZqYHojncGQhSAA6tutwehI7Pz3f4jiuMviOpUjLR1W1UQZASZTCBOptIeDAY2JR
	l98cpY7CjMc+pGdY379odEzCk0wIGs0=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 50c0c9f7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 5 Jul 2024 18:56:44 +0000 (UTC)
Date: Fri, 5 Jul 2024 20:56:42 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: jolsa@kernel.org, mhiramat@kernel.org, cgzones@googlemail.com,
	brauner@kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de
Subject: Re: deconflicting new syscall numbers for 6.11
Message-ID: <ZohB6uPAVX03Sc96@zx2c4.com>
References: <CAHk-=wgqD9h0Eb-n94ZEuK9SugnkczXvX497X=OdACVEhsw5xQ@mail.gmail.com>
 <Zobt_M91PEnVobML@zx2c4.com>
 <CAHk-=wh47WSNQYuSWqdu_8XeRzfpWbozzTDL6KtkGbSmLrWU4g@mail.gmail.com>
 <CAHmME9pgFXhSdWpTwt_x51pFu2Qm878dhcQjG9WhPXV_XFXm9w@mail.gmail.com>
 <CAHk-=wjCmw1L42W-o=pW7_i=nJK5r0_HFQTWD_agKWGt4hE7JQ@mail.gmail.com>
 <CAHk-=win2mesMNEfL-KZQ_jk1YH8N8dL9r=7XOLp28_WMazpVg@mail.gmail.com>
 <ZogcxjLv3NAeQYvA@zx2c4.com>
 <CAHk-=whRpLyY+U9mkKo8O=2_BXNk=7sjYeObzFr3fGi0KLjLJw@mail.gmail.com>
 <ZogzJCb66vwxwSLN@zx2c4.com>
 <CAHk-=wgH=d8MUzJ32QNW_=KDQz7U5g_1Mm9sR9zB1iNUpxft7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgH=d8MUzJ32QNW_=KDQz7U5g_1Mm9sR9zB1iNUpxft7Q@mail.gmail.com>

On Fri, Jul 05, 2024 at 11:08:03AM -0700, Linus Torvalds wrote:
> On Fri, 5 Jul 2024 at 10:53, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > That sounds not so good: the current state is 144 bytes, and it's
> > expected that there'll be one of these per thread. Mapping 16k or 4k per
> > thread seems pretty bad. At least it certainly seems that way? Wasting
> > 16240 bytes per thread + a new vmap I can't imagine is okay.
> 
> Well, I guess the simple solution would be "just pick a size that is
> guaranteed to be at most a page, and a power-of-two, and big enough".
> 
> You really don't have that many choices. Presumably we won't have
> per-architecture random states anyway, so the smallest supported page
> size is the upper limit, and if the current size is 144 bytes, we know
> that 256 is the lower limit.
> 
> IOW, we pretty much know that the number is _always_ going to be 2**n
> where 8 <= n <= 12.
> 
> Just pick one.

And if we want to exceed that size in the future, then what? Just seems
like hard coding it locks us in.

Also, pow2 is still wasteful - 28 states for a 4k page at optimal size
versus 16 states for a 4k page at rounding up to current pow2. That's
not a huge difference at small scale. But also, why? Seems like we could
do this a lot better.

> 
> > | - Future memory tagging CPU extensions might allow us to prevent the
> > |   memory from being accessed unless the accesses are coming from vDSO
> > |   code, which would avoid heartbleed-like bugs. This is very appealing.
> 
> No. Stop this idiocy.
> 
> Now you are getting into cray-cray land. Nobody cares about random
> numbers so much that they'd worry about leaking them from other
> sources thanks to hardware bugs.
> 
> Seriously. This is the kind of "crazy random number" talk that makes
> me go "I don't want to touch this".
> 
> Get your act together. There is *NO* way we care about this kind of
> garbage, and just bringing it up makes me doubt that you have the
> right mindset.
> 
> You claimed to not be one of the crazy people. SHOW IT.

I'm pretty sure you just misunderstood what I'm referring to.
"Heartbleed-like" refers to remote info leak. Like, some server process
spits out a bunch of memory onto the network. If the rng pages can only
be accessed when the caller is at some specified address range, then
those kinds of bugs are mitigated. Anyway, just an idea, but doesn't
seem like an impossible one.


There were also those two other unrelated points I raised, trimmed from
the context. To repaste them all from before:

| Here are the requirements:
|
| - The "mechanism" needs to return allocated memory to userspace that can
|   be chunked up on a per-thread basis, with no state straddling pages,
|   which means it also needs to return the size of each state, and the
|   number of states that were allocated.
| 
| - The size of each state might change kernel version to kernel version.

Your suggestion is to hard code the state size to a power of 2, which
will lock us in to having that as an upper bound forever, and also waste
memory because it's not ideally sized.

| 
| - In an effort to match the behaviors of syscall getrandom() as much as
|   possible, it needs to be mapped with various flags (the ones in the
|   current vgetrandom_alloc() implementation).
| 
| - Which flags are needed might change kernel version to kernel version.

Unaddressed.

| 
| - Future memory tagging CPU extensions might allow us to prevent the
|   memory from being accessed unless the accesses are coming from vDSO
|   code, which would avoid heartbleed-like bugs. This is very appealing.

I think you misunderstood me as referring to "hardware bugs", but that's
not what I was talking about, as I described above. Anyway, regardless,
if your take on this is, "I don't care about making certain rng memory
harder to leak than other memory," then so be it and I'll drop this
point.

| So, the memory that's returned, and the parameters about it are sort of
| tied to the actual [v]getrandom() implementation. That sounds to me like
| this should be done by a function that the kernel is in charge of. Hence
| the syscall.

I'm having a hard time seeing how, "let the user guess and pass
whatever flags were decided at one moment" is preferable to, "have a
syscall/function/ioctl/whatever communicate to userspace what it needs
to do and to set up the mapping in exactly the way it's needed." I'm
sorry to keep belaboring this, but I'm actually just sort of surprised
by your take.

I get the part about, "users will abuse vgetrandom_alloc() for something
uncouth," which seems very real, but the solution to that is to just
expose this to mmap() first. Once that's there, vgetrandom_alloc()
becomes kind of similar to, say, map_shadow_stack().

But okay, spit-balling further, there are the current ideas proposed,
and I'll add two more to the bottom:

0) Syscall.

1) /dev/random ioctl. Downside: needs filesystem node, fd.

2) Hard coding 256 and set of mmap flags. Downside: discussed above.

3) Expose /proc/sys/kernel/random/vgetrandom_info, which gives one field
   of the state size and another of the flags needed for mmap. Downside:
   still less flexible than the kernel doing the allocation, like if
   it'd be nice in the future for some additional step to be taken on
   the memory after mmap(). Downside: needs filesystem node, fd.

4) Same as (3), but expose this through passing -1 as opaque_len to
   vgetrandom(). Downside: kinda ugly, adds branch.

I think of these, (3) is preferable to (2). (0) still seems best, but
I'm not sure you'll agree yet. (4) might be preferable to (3) because no
filesystem stuff.

If (0) and (1) are still sounding bad to you, do (3) or (4) sound
better?

Also, I'm just brainstorming here; if you find these deranged, that's
okay.

Jason

