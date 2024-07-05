Return-Path: <linux-kernel+bounces-242790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C92928D2E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 19:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83D671C22E3A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 17:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D0216D31C;
	Fri,  5 Jul 2024 17:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pGE/M6sr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21AE14A4C1
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 17:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720202025; cv=none; b=GkpTDEEmwZrBE+93gfacl1sSK7hhR14T3q8Oncq1M6i4W4wKezVjayz4dm3EpAaxiEs2LzF1Tjacz+Hu7n4DHqbKacXfgR0QQ97alytPAc48o6jHbAukQ5cqW31x1ZGXzJUbx4ans/EPInxI1mkJx7D4iWLDRnJ7v1PnkKKH0c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720202025; c=relaxed/simple;
	bh=Cp0IJ17jnfnktwi9iVEwqyB4oBrs3H4WWIPrsBN5eEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8UAQuZC5wGRKcyEPbnrzqEH6PwQCNUboQiCqDNiPo9Atdj+o0VgDIqF6qm5r/z+hkI0Jr5o0v8/8lK+E6PcxFM9scu7g6sxdLXJ3TUiJ3oJIOAgrrpa+wsp2thwNw/iMfBVw/24lODI0f03/PXPmsiySFoQjKozCyU9eWoUAdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=pGE/M6sr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9513C116B1;
	Fri,  5 Jul 2024 17:53:43 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pGE/M6sr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720202022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yEIqcaBhjzZ0Ujk5DWiBooLG+n3C54+PAc5baPVzfxU=;
	b=pGE/M6srW1GtYg3CEMNBVyYroOjzVh9mF91ToJyq4lNak64JxdBU0r4uGlTK1gxNolzEqV
	wWD1CNK9H6gbPYgnlUk2hqWshyfLNbWzGozXqZD2fP5QNTHYud0MM3+LoLqUJqwEjvsR4+
	RFjdmAEajm/A0fE0G0d4xfRjmdJio0Q=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3ead16b0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 5 Jul 2024 17:53:42 +0000 (UTC)
Date: Fri, 5 Jul 2024 19:53:40 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: jolsa@kernel.org, mhiramat@kernel.org, cgzones@googlemail.com,
	brauner@kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de
Subject: Re: deconflicting new syscall numbers for 6.11
Message-ID: <ZogzJCb66vwxwSLN@zx2c4.com>
References: <CAHmME9pm+ZE2_qf1DNxukB6ufPrjTAsnwin05-VX_gS03Yq-ag@mail.gmail.com>
 <CAHk-=whTjdO6szgRKp51ZeDLDmA1+YYSbg+vEUt9OsxTMDUtjQ@mail.gmail.com>
 <CAHk-=wgqD9h0Eb-n94ZEuK9SugnkczXvX497X=OdACVEhsw5xQ@mail.gmail.com>
 <Zobt_M91PEnVobML@zx2c4.com>
 <CAHk-=wh47WSNQYuSWqdu_8XeRzfpWbozzTDL6KtkGbSmLrWU4g@mail.gmail.com>
 <CAHmME9pgFXhSdWpTwt_x51pFu2Qm878dhcQjG9WhPXV_XFXm9w@mail.gmail.com>
 <CAHk-=wjCmw1L42W-o=pW7_i=nJK5r0_HFQTWD_agKWGt4hE7JQ@mail.gmail.com>
 <CAHk-=win2mesMNEfL-KZQ_jk1YH8N8dL9r=7XOLp28_WMazpVg@mail.gmail.com>
 <ZogcxjLv3NAeQYvA@zx2c4.com>
 <CAHk-=whRpLyY+U9mkKo8O=2_BXNk=7sjYeObzFr3fGi0KLjLJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whRpLyY+U9mkKo8O=2_BXNk=7sjYeObzFr3fGi0KLjLJw@mail.gmail.com>

Hi Linus,

On Fri, Jul 05, 2024 at 10:39:48AM -0700, Linus Torvalds wrote:
> Yes. And it should be pretty trivial.
> 
> We just at least initially have to be very careful to limit it to
> MAP_ANONYMOUS and MAP_PRIVATE. Because dropping dirty bits on shared
> mappings sounds insane and like a possible source of confusion (and
> thus bugs and maybe even security issues).
> 
> It's possible that we might even use a MAP_TYPE flag for this. Or make
> it a PROT_xyz bit rather than a MAP_xyz.
> 
> So there's some trivial sanity checks and some UI issues to just pick,
> but apart from "just pick something sane", exposing this for mmap() is
> _not_ hard, and I do think it needs to be done first.

I can take a stab at it.

> > - The "mechanism" needs to return allocated memory to userspace that can
> >   be chunked up on a per-thread basis, with no state straddling pages,
> >   which means it also needs to return the size of each state, and the
> >   number of states that were allocated.
> >
> > - The size of each state might change kernel version to kernel version.
> 
> Just pick a size large enough.
> 
> And why would that size not  be one page?
> 
> Considering that you really don't want to rely on page-crossing state
> *ANYWAY* because of the whole "one page can go away while another one
> sticks around" issue, I would expect that states over one page per
> thread would be a *very* questionable idea to begin with.
> 
> I don't think we'll ever see systems with page sizes smaller than 4k.
> They have existed in the past, but they're not making a comeback.
> People want larger pages, not smaller ones.

That sounds not so good: the current state is 144 bytes, and it's
expected that there'll be one of these per thread. Mapping 16k or 4k per
thread seems pretty bad. At least it certainly seems that way? Wasting
16240 bytes per thread + a new vmap I can't imagine is okay.

Also, these points still stand:

| - In an effort to match the behaviors of syscall getrandom() as much as
|   possible, it needs to be mapped with various flags (the ones in the
|   current vgetrandom_alloc() implementation).
|
| - Which flags are needed might change kernel version to kernel version.
|
| - Future memory tagging CPU extensions might allow us to prevent the
|   memory from being accessed unless the accesses are coming from vDSO
|   code, which would avoid heartbleed-like bugs. This is very appealing.

It seems like leaving it just up to mmap() will not only result in users
doing it wrong, but kind of limits our options moving forward. And
there's this whole issue of communicating sizes so as not to be
wasteful.

Another idea I had, if you hate the syscall, is I could just add this as
(another) private ioctl() on the /dev/random node. This sounds worse
than a syscall worse because it means that node has to exist and the fd
has to be opened -- and concerns about this were what lead to the
getrandom() syscall being introduced in the first place -- but it would
at least avoid the syscall. I'm not crazy about that though.

Maybe the winning solution is MAP_DROPPABLE (or PROT_DROPPABLE) in
mmap(), and then in the following commit, add the vgetrandom_alloc()
syscall, and then we'll avoid vgetrandom_alloc() getting abused, but
still have a nice interface that isn't too constraining.

Jason

