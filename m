Return-Path: <linux-kernel+bounces-552171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C16CA5767B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 01:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 639387A8E8D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 00:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD80C2556E;
	Sat,  8 Mar 2025 00:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHxX1YN6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0984DAD4B;
	Sat,  8 Mar 2025 00:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741392112; cv=none; b=aES1pYA+rfT0uENzi4o4KNoAwfGgmtYDWHDNBW7IsxWJGK0LWft9ZcGFuw4gSKv8sf5+4azGrhASuu5Sor93oWQvluuPphpc4xACcotlBaCouRnpe2uUIc/pVP41Lwp8j56H8NLw9EUoVjd4LkN8NbAtSk2wgPk3N0+bSEk/ZbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741392112; c=relaxed/simple;
	bh=CvcOzcHYZdNnB3mh1G+GBqKxyf26qLvuGTb6WCYhDKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJa89MuZd/3ATwDeUPy5TMm1Sbyzmo2LfT92cNB7PL7dyIOFmngoa9F4KBqbf8dSuBwwoccIG69f+5mEjAZiHqzv7wJ6dztlkvivqWUqMQ+UjhSojwTSAVtqL6cw8oFe/5gTIUCDBHW8CMvB8JXdgBYbyNnLJIODycMfu+fqsdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHxX1YN6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3197FC4CED1;
	Sat,  8 Mar 2025 00:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741392111;
	bh=CvcOzcHYZdNnB3mh1G+GBqKxyf26qLvuGTb6WCYhDKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BHxX1YN6/iaOtx4wMoR/Hj4eGamzCNyeUK257LVH979ty6/vVRN8Rols++9lXxwsy
	 +6NMqt4Q5xaxjd15KWYviRvzJbwSZO2Hxg3YxYb1pC+z537tHO1prwqoKqaxLTIa2W
	 y7v/dePLxRx/P3KttKFBlA6LPF/J6w9JOL6uAA84yRXLoQRXlDB/zLTzZZDtozQ4/C
	 2jDzpBlxb6//t8/kdhIP1C91HtYT9iToauB7cKS6KQ1dDH2olZzpQ7IpjS7BlIgUlp
	 wgv1Uji+aeyEtNjFj3xvI2uE2/OhGpugb6p83Bh1JOa45780jrIGtW5LG980r1TCCZ
	 V5qKmm07w5w0w==
Date: Sat, 8 Mar 2025 01:01:45 +0100
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
Message-ID: <Z8uI6aOd79xe32CS@gmail.com>
References: <Z76Uk1d4SHPwVD6n@Mac.home>
 <20250307232717.1759087-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307232717.1759087-1-boqun.feng@gmail.com>


* Boqun Feng <boqun.feng@gmail.com> wrote:

> Hi Ingo & Peter,
> 
> As discussed, I'm resending the pull request for lockdep and Rust
> locking for v6.15 in the format of email patches. I dropped one patch
> and will postpone it for v6.16 because of a bug [1], and I think the fix
> [2] needs more reviews.
> 
> [1]: https://lore.kernel.org/lkml/20250306122413.GBZ8mT7Z61Tmgnh5Y9@fat_crate.local/
> [2]: https://lore.kernel.org/lkml/Z8t8imzJVhWyDvhC@boqun-archlinux/
> 
> Regards,
> Boqun
> 
> Alice Ryhl (2):
>   rust: sync: Add accessor for the lock behind a given guard
>   rust: sync: condvar: Add wait_interruptible_freezable()
> 
> Boqun Feng (1):
>   rust: sync: lock: Add an example for Guard::lock_ref()
> 
> Mitchell Levy (2):
>   rust: lockdep: Remove support for dynamically allocated LockClassKeys
>   rust: lockdep: Use Pin for all LockClassKey usages
> 
> Randy Dunlap (1):
>   locking/rtmutex: Use struct keyword in kernel-doc comment
> 
> Waiman Long (5):
>   locking/semaphore: Use wake_q to wake up processes outside lock
>     critical section
>   locking/lock_events: Add locking events for rtmutex slow paths
>   locking/lock_events: Add locking events for lockdep
>   locking/lockdep: Disable KASAN instrumentation of lockdep.c
>   locking/lockdep: Add kasan_check_byte() check in lock_acquire()

Thanks Boqun!

I've applied these 3 patches to the tip:locking/urgent tree:

  locking/semaphore: Use wake_q to wake up processes outside lock critical section
  locking/rtmutex: Use the 'struct' keyword in kernel-doc comment
  rust: lockdep: Remove support for dynamically allocated LockClassKeys

As a general rule, if a patch is marked Cc: stable, it must also be 
applied to current upstream.

I have applied the others to tip:locking/core:

  locking/lock_events: Add locking events for rtmutex slow pathsa94d32446ab5 locking/lock_events: Add locking events for lockdep
  locking/lockdep: Disable KASAN instrumentation of lockdep.c
  locking/lockdep: Add kasan_check_byte() check in lock_acquire()
  rust: sync: Add accessor for the lock behind a given guard
  rust: sync: lock: Add an example for Guard:: Lock_ref()
  rust: sync: condvar: Add wait_interruptible_freezable()
  rust: lockdep: Use Pin for all LockClassKey usages

I cleaned up changelogs where necessary - for example we generally 
don't include printk timestamps in changelogs, unless it's relevant, 
plus there were a number of typos and grammar mistakes left in some of 
the changelogs.

Thanks,

	Ingo

