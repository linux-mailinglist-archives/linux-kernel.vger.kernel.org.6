Return-Path: <linux-kernel+bounces-552191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA389A576A3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 01:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D88177A423A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 00:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C4E1FC8;
	Sat,  8 Mar 2025 00:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BF0SjhcM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100D4634;
	Sat,  8 Mar 2025 00:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741392703; cv=none; b=PvdI7bIHwqsi8e/EMWwH5rNCrjjkOe13uhAaxbihCnlGk7MdhrMTcwZE7U58HeRVfKzHRzkScEaL+tFz7MvKQpFv4AZO64jW6haxyfJyZzQ55Tm+fhsNALYr5M5S3u30hoPIub4vOKEvRnc3vDKiXzjApf3gTGumVUcBD/BzUj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741392703; c=relaxed/simple;
	bh=bsZO6tCi5kADEBIGZaCJS15XrxYgcY2gtufMF54xFc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JE9TwOgOQzLg9W9hdz2rtFEUYAoBgCAu4FIFZurKIAsdzhqFALxTcP6qssTZ1Jd5/pYo/Oj5LT41vZ/OKAA6NqkhZcgkZTEDm00WADv2hNS67gjem/eyTxMRFOGjpztgHhnIVM7em0EGbc7iaMlJobd87B47SjpJmKlxa0/3QHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BF0SjhcM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C46C4CED1;
	Sat,  8 Mar 2025 00:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741392702;
	bh=bsZO6tCi5kADEBIGZaCJS15XrxYgcY2gtufMF54xFc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BF0SjhcMkmIaNpT05kyE8jsxW4NSGfoNSF7PvG+WgedAd2P36zY4z3sRzcQX9xkA4
	 Zhdhkic+J5fVYEOMFWpEJlMA/ntuMC6Zx+coxWKn0oR1HkX3ZcSyiL30vTBOMwOwWF
	 V+2dHTC4gKwVsDLVlm+LTam3gBD2/FXi4Gm/7s9MME6Q6beTBy8xDSoQzFtJEm2fLy
	 5kaSgqbInBIn1wyiX/P+aoNGr63xTCUHQAVvMpS1oI5Udv18kFyN7cXtGWoB0q0ssa
	 is9jA3zqbu9PMfIaIA2MkVZLfI/fdRRScT+egUiU9Ik06Ocq0Q4NzWhtSxio/nnHYu
	 mge6gpwQY6RHA==
Date: Sat, 8 Mar 2025 01:11:36 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	"open list:RUST:Keyword:b(?i:rust)b" <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH locking 00/11] LOCKDEP and Rust locking changes for v6.15
Message-ID: <Z8uLOFLbq-EqAUfJ@gmail.com>
References: <Z76Uk1d4SHPwVD6n@Mac.home>
 <20250307232717.1759087-1-boqun.feng@gmail.com>
 <Z8uI6aOd79xe32CS@gmail.com>
 <Z8uJoFsfvdeOmAiH@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8uJoFsfvdeOmAiH@boqun-archlinux>


* Boqun Feng <boqun.feng@gmail.com> wrote:

> On Sat, Mar 08, 2025 at 01:01:45AM +0100, Ingo Molnar wrote:
> > 
> > * Boqun Feng <boqun.feng@gmail.com> wrote:
> > 
> > > Hi Ingo & Peter,
> > > 
> > > As discussed, I'm resending the pull request for lockdep and Rust
> > > locking for v6.15 in the format of email patches. I dropped one patch
> > > and will postpone it for v6.16 because of a bug [1], and I think the fix
> > > [2] needs more reviews.
> > > 
> > > [1]: https://lore.kernel.org/lkml/20250306122413.GBZ8mT7Z61Tmgnh5Y9@fat_crate.local/
> > > [2]: https://lore.kernel.org/lkml/Z8t8imzJVhWyDvhC@boqun-archlinux/
> > > 
> > > Regards,
> > > Boqun
> > > 
> > > Alice Ryhl (2):
> > >   rust: sync: Add accessor for the lock behind a given guard
> > >   rust: sync: condvar: Add wait_interruptible_freezable()
> > > 
> > > Boqun Feng (1):
> > >   rust: sync: lock: Add an example for Guard::lock_ref()
> > > 
> > > Mitchell Levy (2):
> > >   rust: lockdep: Remove support for dynamically allocated LockClassKeys
> > >   rust: lockdep: Use Pin for all LockClassKey usages
> > > 
> > > Randy Dunlap (1):
> > >   locking/rtmutex: Use struct keyword in kernel-doc comment
> > > 
> > > Waiman Long (5):
> > >   locking/semaphore: Use wake_q to wake up processes outside lock
> > >     critical section
> > >   locking/lock_events: Add locking events for rtmutex slow paths
> > >   locking/lock_events: Add locking events for lockdep
> > >   locking/lockdep: Disable KASAN instrumentation of lockdep.c
> > >   locking/lockdep: Add kasan_check_byte() check in lock_acquire()
> > 
> > Thanks Boqun!
> > 
> 
> Thanks.
> 
> > I've applied these 3 patches to the tip:locking/urgent tree:
> > 
> >   locking/semaphore: Use wake_q to wake up processes outside lock critical section
> >   locking/rtmutex: Use the 'struct' keyword in kernel-doc comment
> >   rust: lockdep: Remove support for dynamically allocated LockClassKeys
> > 
> > As a general rule, if a patch is marked Cc: stable, it must also be 
> > applied to current upstream.
> > 
> 
> Do you prefer a separate pull request for the future? I can send one for
> urgent and one for locking/core.

One tree is fine - maybe indicate which ones are urgent material and 
keep them at the head of the tree?

Thanks,

	Ingo

