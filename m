Return-Path: <linux-kernel+bounces-242989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BFE928FED
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 03:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B9691C22261
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 01:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A673479F0;
	Sat,  6 Jul 2024 01:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="mrutgC/o"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BEA36B
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 01:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720228456; cv=none; b=PEPQZPgD9KzWzxXOViOiBpxhy+U9z5/JV3L02vwxHvtJdZeNkzfP8wxAGBNcWPOOoafQ7YTWY7y3msXv1PwPC8r5RgDzSMQY1r3gnSNECUJsMEUkNf66lnnXQ5+vQLQT58BmPGgPrQrDW2jyRdYGqabomNikgS14ws70o9GYQCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720228456; c=relaxed/simple;
	bh=flu6Cr86ErxZXaxqXXd8WXwiDF9i/Q4d3w7tQMWBRnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qyUg5cLTf0CKoA95nQRGSihW5IBcQkFS6fLJ/qkhAL3f+qwZTImesa9Sn2mfehFC7kjEYmOF1F9OJ4eEqTjnWEZZPEAD7E/pV+nUoti2HXXfEPKvzums7eCD60vLzFZqfX3MISk5YTXedQjqyxlLh7Cg/Z5LPh/zIb5CWAdG+Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=mrutgC/o; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1720228444;
	bh=flu6Cr86ErxZXaxqXXd8WXwiDF9i/Q4d3w7tQMWBRnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mrutgC/oIIG1x6L+nWBp83DvZIBPqhtR99Z78T9RLEHhXgpcVPqBeUR+p0H1Wstfw
	 SEbjnag65aOI6PQ6wH+V91YL/h69GjdEHknMgqiOx+DNRuecUP//Ps7dk/N+erA4XV
	 ElRZ3yxnUCiOQ8Eo3y+Cz/nWOo69tTB4QqFYsVPyE9wbRV+V2KE8YiX2RbcVY0sNHX
	 8xi53CfFQ8PRJJLAs73ILZq4i2TYrwglb3/cdGtSq4X3okZt7tGpV/SxudWKHw6rGM
	 RiLwR4CKG8g6apoX7Ihd/d1gBEzjqs2PzJoLuPYGXI0LWOL6aELPPL4QllOMwGlKpe
	 Xtzi9RSO690qg==
Received: from localhost.localdomain (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4WGC8D4j0cz18p9;
	Fri,  5 Jul 2024 21:14:04 -0400 (EDT)
Date: Fri, 5 Jul 2024 21:14:03 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, jolsa@kernel.org,
	mhiramat@kernel.org, cgzones@googlemail.com, brauner@kernel.org,
	linux-kernel@vger.kernel.org, arnd@arndb.de,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Zack Weinberg <zack@owlfolio.org>,
	Cristian =?iso-8859-1?Q?Rodr=EDguez?= <cristian@rodriguez.im>,
	Florian Weimer <fweimer@redhat.com>,
	Wilco Dijkstra <Wilco.Dijkstra@arm.com>
Subject: Re: deconflicting new syscall numbers for 6.11
Message-ID: <ZoiaWz9mG9rb0QND@localhost.localdomain>
References: <ZobXdDCYBi8OM-Fo@zx2c4.com>
 <CAHk-=wiGk+1eNy4Vk6QsEgM=Ru3jE40qrDwgq_CSKgqwLgMdRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiGk+1eNy4Vk6QsEgM=Ru3jE40qrDwgq_CSKgqwLgMdRg@mail.gmail.com>

On 04-Jul-2024 10:21:34 AM, Linus Torvalds wrote:
> On Thu, 4 Jul 2024 at 10:10, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > The three of us all have new syscalls planned for 6.11. Arnd suggested
> > that we coordinate to deconflict, to make the merge easier.
> 
> Nobody has explained to me what has changed since your last vdso
> getrandom, and I'm not planning on pulling it unless that fundamental
> flaw is fixed.
> 
> Why is this _so_ critical that it needs a vdso?
> 
> Why isn't user space just doing it itself?
> 
> What's so magical about this all?
> 
> This all seems entirely pointless to me still, because it's optimizing
> something that nobody seems to care about, adding new VM
> infrastructure, new magic system calls, yadda yadda.
> 
> I was very sceptical last time, and absolutely _nothing_ has changed.
> Not a peep on why it's now suddenly so hugely important again.
> 
> We don't add stuff "just because we can". We need to have a damn good
> reason for it. And I still don't see the reason, and I haven't seen
> anybody even trying to explain the reason.

[ Note: as I wrote down this email, I notice that you are heading
  towards the same conclusions I'm reaching on other sub-threads of this
  discussion. But I'm providing this feedback because it adds relevant
  information based on earlier discussions with libc developers. ]

Earlier this year in March, I've jumped into the discussion on the
libc-alpha mailing list to understand the userspace RNG seeding
requirements better. The interesting bits that explain how the kernel
can play an important role start here:

https://sourceware.org/pipermail/libc-alpha/2024-March/155534.html

From an absolutely-not-security-expert perspective, here is how I see
the desiderata breakdown:

- There appears to be a need to make sure the random seed is not exposed
  across fork, core dump and other similar scenarios. This can be
  achieved by simply letting userspace use the appropriate madvise(2)
  advices on a memory mapping created through mmap(2). I don't see why
  there would be any need to create any RNG-centric ABI for this. If
  new madvise(2) advices are needed, they can simply be added there.

- There appears to be interest in having a RNG faster than a system call
  for various reasons I'm not familiar with. A vDSO appears to be one
  way to do this. Another way would be to let userspace implement it
  all, which raises the following question: what is the minimal state
  known only by the kernel currently unknown from userspace ? This
  brings the following point.

- Based on the libc-alpha discussion, I understand that the main thing
  the kernel knows about which is unknown from userspace is a sort-of
  generation counter, which tracks for instance the fact that the kernel
  was migrated to a different VM, or suspended and then resumed, and
  hence the current seed should be discarded and re-seeded entirely.
  I suspect that is the _key_ information that is currently missing from
  a purely userspace RNG perspective today. I hinted at extending the
  rseq(2) ABI for that purpose: exposing a generation counter for the
  RNG in a thread area shared between kernel and user-space. The
  per-thread area is already there and the hard work of integrating it
  with libc is mostly complete. Another alternative would be, as you
  hint elsewhere in this thread
(https://lore.kernel.org/lkml/CAHk-=wgqD9h0Eb-n94ZEuK9SugnkczXvX497X=OdACVEhsw5xQ@mail.gmail.com/)
  to create a vDSO to expose exactly this kind of generation counter.
  Given this is not a thread-specific thing, it might be a better
  approach that the rseq per-thread area.

So either I'm missing something important (please enlighten me), or we
could achieve all those end-goals with a small fraction of the ABI
complexity introduced by the vDSO as it is initially proposed.

I don't think that just because there happens to be bad userspace RNG
implementations out there we should give up on userspace and maintain
this all complexity in the kernel. This is just working around userspace
ecosystem issues by moving the implementation and maintainance burden
into the kernel.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

