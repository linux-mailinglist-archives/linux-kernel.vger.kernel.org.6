Return-Path: <linux-kernel+bounces-241550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EC8927C77
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 876B0B219A6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA1A4962A;
	Thu,  4 Jul 2024 17:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="HaaaI559"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CC73D97F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 17:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720115171; cv=none; b=Wux7rauQ1DjgtXmPH6UwX8cZPMkbPHJWM3fkxVYB1Mq/jECsBYfI6niVH8HiWWEcuygm7e3kgc4n3kvdfiPAtt9oTRTgehvWTJB/lH5EQxkA5UG5QWnpuzWqyoPXUqPKv54c5fYpWG1ztcDwjMEbJ+ucBNpYojA2cUB7BNT+E5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720115171; c=relaxed/simple;
	bh=8bFwUULAnMeSdCGnsqaBkZdIz2KulTG3Sn00lHqMa44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOXE78qhZNQHMhkBCUOOAhi9oi04erIRxlpHtEqldtF5DKKAtsHjrzr0ocNjbrWaQBh9CC9c/UzM2XPc+yG0b1qVV0r8ERCn4WXJrWzu9jNgNdtyyHyyR/mG5g9IrMvx5NYvqpFNZ2fZlK1yayFK2C1t8Een1hbANiL+H58Otm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=HaaaI559; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F38C3277B;
	Thu,  4 Jul 2024 17:46:09 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="HaaaI559"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720115167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R2mNOONS7BIHJlKmGVX9T1qMVuQ+XxtgDeiJEUwEq9k=;
	b=HaaaI559co+IFQDYSeRiXcPkdpd85zjBUPjoioMh829Z0VfWPPccLtMpAGqlUsfCMu9HwM
	xoAumcbGl3yW4U1U6pXzDAgRJ7oojXKMclruLDU381Fp1FazZNTVYnbs7EK5GRZnCZrjy4
	pqs+TCMccRrUHE6m7of/VL78oGvyL68=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id efbd4fcc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Jul 2024 17:46:07 +0000 (UTC)
Date: Thu, 4 Jul 2024 19:46:05 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: jolsa@kernel.org, mhiramat@kernel.org, cgzones@googlemail.com,
	brauner@kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de
Subject: Re: deconflicting new syscall numbers for 6.11
Message-ID: <Zobf3fZOuvOJOGPN@zx2c4.com>
References: <ZobXdDCYBi8OM-Fo@zx2c4.com>
 <CAHk-=wiGk+1eNy4Vk6QsEgM=Ru3jE40qrDwgq_CSKgqwLgMdRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiGk+1eNy4Vk6QsEgM=Ru3jE40qrDwgq_CSKgqwLgMdRg@mail.gmail.com>

Hi Linus,

On Thu, Jul 04, 2024 at 10:21:34AM -0700, Linus Torvalds wrote:
> On Thu, 4 Jul 2024 at 10:10, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > The three of us all have new syscalls planned for 6.11. Arnd suggested
> > that we coordinate to deconflict, to make the merge easier.
> 
> Nobody has explained to me what has changed since your last vdso
> getrandom, and I'm not planning on pulling it unless that fundamental
> flaw is fixed.

Oh. That's an unpleasant surprise. I've been hard at work on bringing
everything up to snuff. That's pretty much been my sole focus.

Changes since the last time I worked on this are explained in large at
the top of this:

https://lore.kernel.org/lkml/20240703183115.1075219-1-Jason@zx2c4.com/

The big issue before was that the mm additions were too insane. I've
paired those down and made them really minimal. Then the mm people piped
up and it became even more minimal. Now I think it's pretty alright.

But I think, perhaps evidently barring you, the use case of this in the
first place and need for it is well understood and appreciated at large
by now. So to answer that,

> Why is this _so_ critical that it needs a vdso?
> 
> Why isn't user space just doing it itself?
> 
> What's so magical about this all?
> 
> This all seems entirely pointless to me still, because it's optimizing
> something that nobody seems to care about
>
> IOW, I want to see actual *users* piping up and saying "this is a
> problem, here's my real load that spends 10% of time on getrandom(),
> and this fixes it".
>
> I'm not AT ALL interested in microbenchmarks or theoretical "if users
> need high-performance random numbers".
>
> I need a real actual live user that says "I can't just use rdrand and
> my own chacha mixing on top" and explains why having a SSE2 chachacha
> in kernel code exposed as a vdso is so critical, and a magical buffer
> maintained by the kernel.

As far as speed goes, there are many legitimate applications that cannot
make a syscall every time. TLS nonces and keys come to mind as a huge
one. "Make getrandom() fast enough that the TLS library can use it" is
something that's come up over and over. There's now also arc4random() in
glibc, whose addition is what sparked this whole patchset two years ago.
That's not a micro benchmark thing either. I too don't really care for
microbenchmarks with the random driver. But I do want it to be actually
useable, so that people use it, because it is the best facility for the
task. With regards to why VDSO, the cover letter lays that out in
detail. Userspace does not have access to the information in a timely
manner that the kernel does, and the particulars of the kernel's
accounting are bound to change, especially as all this matures with VMs.
The RNG in the vDSO needs to be tightly coupled with the RNG in the
kernel; these are part of the same thing.

Anyway, those actual users exist, and the partial solutions and hacks
required to workaround this shortcoming are kind of grotesque and in one
way or another bad. This isn't theoretical. I'm not working on this for
"fun".

Jason

