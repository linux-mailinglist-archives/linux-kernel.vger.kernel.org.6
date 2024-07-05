Return-Path: <linux-kernel+bounces-242718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5393D928C25
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 18:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEC362864AC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 16:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F8416C6B3;
	Fri,  5 Jul 2024 16:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="fIM+LCB3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02CC16A399
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 16:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720196300; cv=none; b=k9hHb7yPitjez23r+qaNLHsSElCs80g2ggLNgnLrF6juasy8/NzjtXSyv9puNvSw6W2KJLkcF9Sj17g0W7/7RrBiH5dgfjniODB4DcZ8/7ZKRLYCa51UwbEW/6ds/FRNjF+bNOD71kL+NNKaiezlAHy3rUpI1yaSLQR73NrPvVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720196300; c=relaxed/simple;
	bh=IWpBjUokMdn/Ngo/69Tqn6Juhm7vdRge77p2EqIS6Q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTBP0zshxW3xgr+6/UdeX68vfMB5tzwfzS4W5VkrM9gOQcCBI9F0T4pma0asWChy3tHgH9Ofrer0kNzLeCOmDTRk521az3j5k0MAg7QZx71KwVAoaHRpHswsTdhZYvE4/XdrvuLubIvZBNGZW8NCFVJ1dFkhPLmNrmSKY6NNIs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=fIM+LCB3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F963C116B1;
	Fri,  5 Jul 2024 16:18:19 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="fIM+LCB3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720196297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GCqVVLW8PLBZR8elFJ+ozu9ss6exYxAGVAohwCOoV5Q=;
	b=fIM+LCB3i+uOx+CVoe+p6ZC+Dh6EEjnNvVklOM9GE/MMHHy3xAOK3peTvCcA2gSB2jf6H7
	7IY61d86BlYVwGqdWtJDPSNe+yuyJOOQguL8uwpY5Fw2WpMx92p9HmEj+uYAtnTtnfb6UI
	H0lRDdAT19CFxjdwUAthxJK3+q0Z+Vg=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2b2e034c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 5 Jul 2024 16:18:17 +0000 (UTC)
Date: Fri, 5 Jul 2024 18:18:14 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: jolsa@kernel.org, mhiramat@kernel.org, cgzones@googlemail.com,
	brauner@kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de
Subject: Re: deconflicting new syscall numbers for 6.11
Message-ID: <ZogcxjLv3NAeQYvA@zx2c4.com>
References: <Zobf3fZOuvOJOGPN@zx2c4.com>
 <CAHk-=whf2Pb8fSmUsLRSn6CnYvQoyUkLikKpFDWN_xnTJqix=A@mail.gmail.com>
 <CAHmME9pm+ZE2_qf1DNxukB6ufPrjTAsnwin05-VX_gS03Yq-ag@mail.gmail.com>
 <CAHk-=whTjdO6szgRKp51ZeDLDmA1+YYSbg+vEUt9OsxTMDUtjQ@mail.gmail.com>
 <CAHk-=wgqD9h0Eb-n94ZEuK9SugnkczXvX497X=OdACVEhsw5xQ@mail.gmail.com>
 <Zobt_M91PEnVobML@zx2c4.com>
 <CAHk-=wh47WSNQYuSWqdu_8XeRzfpWbozzTDL6KtkGbSmLrWU4g@mail.gmail.com>
 <CAHmME9pgFXhSdWpTwt_x51pFu2Qm878dhcQjG9WhPXV_XFXm9w@mail.gmail.com>
 <CAHk-=wjCmw1L42W-o=pW7_i=nJK5r0_HFQTWD_agKWGt4hE7JQ@mail.gmail.com>
 <CAHk-=win2mesMNEfL-KZQ_jk1YH8N8dL9r=7XOLp28_WMazpVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=win2mesMNEfL-KZQ_jk1YH8N8dL9r=7XOLp28_WMazpVg@mail.gmail.com>

Hi Linus,

On Thu, Jul 04, 2024 at 02:07:41PM -0700, Linus Torvalds wrote:
> On Thu, 4 Jul 2024 at 12:19, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Bah. I guess I'll have to walk through the patch series once again.

Thanks for having a look. I really appreciate it.

> Ok, I went through it once. First comments:
> 
> The system call additions look really random. You don't add them to
> all architectures, but the ones you *do* add them to seem positively
> pointless:
> 
>  - I don't think you should introduce the system all on 32-bit
> architectures, and that includes as a compat call on 64-bit.
> 
>     The VM_DROPPABLE infrastructure doesn't even exist on 32-bit, and
> while that might not be technically a requirement, it does seem to
> argue against doing this on 32-bit architectures. Plus nobody sane
> cares.
> 
>     You didn't even enable it on 32-bit x86 in the vdso, so why did
> you enable it as a syscall?
> 
>  - even 64-bit architectures don't necessarily have anything like a
> vdso, eg alpha.
> 
> It looks like you randomly just picked the architectures that have a
> syscall.tbl file, rather than architectures where this made sense. I
> thin kyou should drop all of them except possibly arm64, s390 and
> powerpc.

The first versions of my series actually only enabled it on x86.
(Somebody also wrote an arm64 implementation of all this already, but
that's for later.) But after I posted that, people (Arnd, I think?) told
me I should add it to all architectures to "reserve" the number. That
was a lot of annoying busy work to do, but I did it, and not just random
archs, but *all* of them.

I'd be happy to revert all this and just enable it on x86. I'll do that
for the v+1 patch. It's less work for me and would make this series one
patch less.

But there might be a conversation to have (that I think you've begun
with Arnd) about what the expectations are for this, because the "enable
it on all of them" seems to be something I've heard on more than one
occasion.


> I'm very ambivalent about the VM_DROPPABLE code.
> 
> On one hand, it's something we've discussed many times, and I don't
> hate it. On the other hand, the discussions have always been about
> actually exposing it to user space as a MAP_DROPPABLE so that user
> space can do caching.
> 
> In fact, I'm almost certain that *because* you didn't expose it to
> mmap(), people will now then instead mis-use vgetrandom_alloc()
> instead to allocate random MAP_DROPPABLE pages. That is going to be a
> nightmare.

VM_DROPPABLE *is* actually a very useful feature. Or it at least seems
like it could be one. One can imagine various database caches that do a
memory vs cpu trade off using it. (But, to be clear, I've never actually
spoken with database developers about it.)

There are some other improvements for it I have in mind that I was
considering posting in some time when this work here has settled.

And then, indeed, it'd make sense to eventually expose this properly to
mmap() and let people use it. (Or if you want to do that in reverse,
adding it to mmap() first, so that people don't misuse
vgetrandom_alloc(), that's fine.)


> And that nightmare has to be avoided. Which in turn means that I think
> vgetrandom_alloc() has to go, and you just need to expose
> MAP_DROPPABLE instead that obly works for private anonymous mappings,
> and make sure glibc uses that.
> 
> Because as your patch series stands now, the semantics are unacceptable.
> 
> This is a non-starter. When I see a new system call where my reaction
> is not just "this should have been just a mmap()", but then
> immediately followed by "Oh, and people will mis-use this as a cool
> mmap", I'm not merging that system call.
> 
> So I don't hate VM_DROPPABLE per se, but the interface is simply not
> ok. vgetrandom_alloc() absolutely *has* to go, and needs to just be a
> user-space wrapper around regular mmap.

So I'm not wedded to adding a syscall for this and am pretty open to
other ways of doing it, but I actually think given the requirements,
this kind of makes sense. I was talking about this problem with tglx or
with Greg a while back, kind of frustrated, and one of them suggested,
"well just make it a syscall; that's what those are for," and it
immediately made sense, and so that's what I've done. Here are the
requirements:

- The "mechanism" needs to return allocated memory to userspace that can
  be chunked up on a per-thread basis, with no state straddling pages,
  which means it also needs to return the size of each state, and the
  number of states that were allocated.

- The size of each state might change kernel version to kernel version.

- In an effort to match the behaviors of syscall getrandom() as much as
  possible, it needs to be mapped with various flags (the ones in the
  current vgetrandom_alloc() implementation).

- Which flags are needed might change kernel version to kernel version.

- Future memory tagging CPU extensions might allow us to prevent the
  memory from being accessed unless the accesses are coming from vDSO
  code, which would avoid heartbleed-like bugs. This is very appealing.

So, the memory that's returned, and the parameters about it are sort of
tied to the actual [v]getrandom() implementation. That sounds to me like
this should be done by a function that the kernel is in charge of. Hence
the syscall. (Or a vDSO function, but then it wouldn't correspond with
an equivalent syscall, which might not be appealing to tglx, and it
starts to smell like "library code" which we really don't want.)

Given this, it seemed like a syscall was the cleanest most cromulent
solution. But if you have other suggestions, I'm open to it.

Maybe, though, the best way of assuaging your concerns would be to
expose MAP_DROPPABLE in mmap() in the same series as the rest, so that
there *isn't* a chance that vgetrandom_alloc() will be abused when
people realize it's a handy feature to have.

Thoughts?

Jason

