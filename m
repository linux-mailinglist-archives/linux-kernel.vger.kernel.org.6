Return-Path: <linux-kernel+bounces-371598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CF99A3D20
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A74571C23562
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16472010EF;
	Fri, 18 Oct 2024 11:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCX1TYnH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2879615CD74;
	Fri, 18 Oct 2024 11:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729250223; cv=none; b=C7Vn9aGah9hPLIllFbYTgUkzsy5XOXJGIGvlA2LcZ+E8hPKLe267RMKvKDD287/YQcEQUv7UDjYPqTQVtNZkc4ztb/n3mCgHL2yA8koGhPBvvGrrCB/3gYbBgA9LYqkhhap3IBUkORfFSuaQKS9jK9zDZk9rSvJVCNVazWpXmV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729250223; c=relaxed/simple;
	bh=TyKBE7MoQqoiy5Ox7Q0k5Y+ZjkzhA38Eo1JU4Sc2i/c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QVwzU/A44DE5p9lHbFPfDk1P3/e2dd6jGPZ3o+HZ7a2oFdWqtC7dp2YjeVCkM8R11AQ5ONltDjo0mvUVH9GRjX27l2m4WuErjJICurIUoI6hscjBZSJoqK4Ax2l9sxa6QTvGgd8cH0QrZOcgx5eAmcLcmyvY5diDqDkIC6Gsi0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCX1TYnH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06FD4C4CEC3;
	Fri, 18 Oct 2024 11:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729250222;
	bh=TyKBE7MoQqoiy5Ox7Q0k5Y+ZjkzhA38Eo1JU4Sc2i/c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cCX1TYnHS7uJ1XWUQmu993BANGY01CW9anDUPilRpbLH3HJiH97nt/wyi7+VbLTSd
	 P9AnIk0oaIZFpdpLv73ClS8Sley/tonPfeVdJXvIfPT61NX8qcxpTiCkOVtDpXRT44
	 zn6HS53RcXi8W49c//UyEaQ2S16rgXLk3v8Tdwjv1eTbsnvpfP+XsfcSyWH9Q8H9bJ
	 yDB6A17DFvfVGVQFWqpXgMxyZdgzcHDKFCl5AZD0gRDaPIw5p1NH+WYv5PtDrp3pch
	 9rEplNMbOuyt//rSMhvmPiTHsaSfz43Ozgdam9sa1OMkUuObwm8kZII4jnhElcu2dP
	 Nu7PVoNITBAow==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: "Thomas Gleixner" <tglx@linutronix.de>,  Dirk Behme
 <dirk.behme@gmail.com>,  Lyude Paul <lyude@redhat.com>,
  rust-for-linux@vger.kernel.org,  Danilo Krummrich <dakr@redhat.com>,
  airlied@redhat.com,  Ingo Molnar <mingo@redhat.com>,  will@kernel.org,
  Waiman Long <longman@redhat.com>,  Peter Zijlstra <peterz@infradead.org>,
  linux-kernel@vger.kernel.org,  Miguel Ojeda <ojeda@kernel.org>,  Alex
 Gaynor <alex.gaynor@gmail.com>,  wedsonaf@gmail.com,  Gary Guo
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  Benno
 Lossin <benno.lossin@proton.me>,  Andreas Hindborg
 <a.hindborg@samsung.com>,  aliceryhl@google.com,  Trevor Gross
 <tmgross@umich.edu>
Subject: Re: [POC 0/6] Allow SpinLockIrq to use a normal Guard interface
In-Reply-To: <20241018055125.2784186-1-boqun.feng@gmail.com> (Boqun Feng's
	message of "Thu, 17 Oct 2024 22:51:19 -0700")
References: <1eaf7f61-4458-4d15-bbe6-7fd2e34723f4@app.fastmail.com>
	<20241018055125.2784186-1-boqun.feng@gmail.com>
Date: Fri, 18 Oct 2024 13:16:43 +0200
Message-ID: <87r08dr78k.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Boqun Feng <boqun.feng@gmail.com> writes:

> Hi Thomas,
>
> So this series is what I proposed, previously, because the nested
> interrupt API in C is local_irq_save() and local_irq_restore(), the
> following Rust code has the problem of enabling interrupt earlier:
>
> 	// l1 and l2 are interrupt disabling locks, their guards (i.e.
> 	// return of lock()) can be used to track interrupt state.
>
> 	// interrupts are enabled in the beginning.
> 	
> 	let g1 = l1.lock(); // previous interrupt state is enabled.
> 	let g2 = l2.lock(); // previous interrupt state is disabled.
>
> 	drop(g1); // release l1, if we use g1's state, interrupt will be
> 		  // enabled. But this is obviously wrong. Because g2
> 		  // can only exist with interrupt disabled.
>
> With the new interrupt disable and enable API, instead of a "unsigned
> long", a percpu variable is used to track the outermost interrupt state
> and the nested level, so that "drop(g1);" above won't enable interrupts.
>
> Although this requires extra cost, but I think it might be worth paying,
> because this could make Rust's SpinLockIrq simply use a guard interface
> as SpinLock.
>
> Of course, looking for any comments and suggestions.
>
> Boqun Feng (3):
>   irq & spin_lock: Add counted interrupt disabling/enabling
>   rust: helper: Add spin_{un,}lock_irq_{enable,disable}() helpers
>   rust: sync: lock: Add `Backend::BackendInContext`
>
> Lyude Paul (3):
>   rust: Introduce interrupt module
>   rust: sync: Add SpinLockIrq
>   rust: sync: Introduce lock::Backend::Context
>
>  include/linux/irqflags.h          |  32 +++++++++-
>  include/linux/irqflags_types.h    |   6 ++
>  include/linux/spinlock.h          |  13 ++++
>  include/linux/spinlock_api_smp.h  |  29 +++++++++
>  include/linux/spinlock_rt.h       |  10 +++
>  kernel/locking/spinlock.c         |  16 +++++
>  kernel/softirq.c                  |   3 +
>  rust/helpers/helpers.c            |   1 +
>  rust/helpers/interrupt.c          |  18 ++++++
>  rust/helpers/spinlock.c           |  10 +++
>  rust/kernel/interrupt.rs          |  64 +++++++++++++++++++
>  rust/kernel/lib.rs                |   1 +
>  rust/kernel/sync.rs               |   2 +-
>  rust/kernel/sync/lock.rs          |  33 +++++++++-
>  rust/kernel/sync/lock/mutex.rs    |   2 +
>  rust/kernel/sync/lock/spinlock.rs | 103 ++++++++++++++++++++++++++++++
>  16 files changed, 340 insertions(+), 3 deletions(-)
>  create mode 100644 rust/helpers/interrupt.c
>  create mode 100644 rust/kernel/interrupt.rs


Tested-by: Andreas Hindborg <a.hindborg@kernel.org>

I ran the `hrtimer` examples on top of this, and it seems to work [1].

Best regards,
Andreas


[1] git git://git.kernel.org/pub/scm/linux/kernel/git/a.hindborg/linux.git hrtimer-boqun-poc


