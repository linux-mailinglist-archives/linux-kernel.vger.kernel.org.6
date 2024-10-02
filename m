Return-Path: <linux-kernel+bounces-348239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1470098E474
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 464571C22DE6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD892217320;
	Wed,  2 Oct 2024 20:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YToWXhU5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X4u6fAi5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93DD18C36;
	Wed,  2 Oct 2024 20:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727902416; cv=none; b=S/LV53AcSAM+8FgwdJx368IHsO19cbwSLiTp+m8jX/Pp5RfETyjve2P8hi5QHPiLNBac3VoRAZXeWY9LKzdG+AzJG0xEfuCaUHIPy3TXatJ+bC8TrMtqm6H+PU8pnO7Wov3b0qUECh+S8ioxIa5qN/rKALjL4dB5UHgsQqETnSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727902416; c=relaxed/simple;
	bh=KOxHC2xygN7XeegWtA7pBukAszMHdm7sdx2xpNeTuoA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d/Rhr+2/B9vmQ7Wil4dUuRIYn6qOUZGovEsUV6QmV8jOSL0N7yhn7+5fSwopqegiKIq1ReRnPT4XoKQFsIWte9vyWV1Uj9SHZCIhaMO64rBo0u1XURYiGiMeAjBMwAK2GLedXKV+YmJNvDBSFRFxYOIRyTCs4syHitWMJJe+gdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YToWXhU5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X4u6fAi5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727902412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PmTzQy16DUQzEFj/EiHIBye2ttpg+QQXAILmfnqL2ls=;
	b=YToWXhU5CsiZMuY2wuCcuqvsnJHYCBZWGmwIOIRtBH5fF/FFhhc03xFTuoTA3zzBhicyfU
	A3muC1kGf7IKm3n0kIVFT+FcvuiqByd6au1Y6UpAK3FfXde0Ib0kx4KXD+vknRb9UygCoH
	DPMH4Sy8mjqpWDMOkmiWbFpmFxJo3Y/gg/OYTr3qdXk5R9cY8Qtg5gZkoWzJzYWpdZ57mD
	66s7z3FjhvG4/qjNY/j2xeZ25LX+hxzn2hCobKRTzcuTJqMpWj0UJ06rK8rJZb6d6DqiUG
	5YLdpmv9vsLkLXkgT6+1TVP1cGIRw1hS9RKP/t0j8Mlwk1leSGNMsfTe0qK0kQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727902412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PmTzQy16DUQzEFj/EiHIBye2ttpg+QQXAILmfnqL2ls=;
	b=X4u6fAi5nzT8aMuUrTuERwc4d/Lra1W8HskEGcqi7xpPTG7xUfHGNbXUACWXAvtUgx8hGp
	cJ4PuUlwVomO18Bw==
To: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org
Cc: Danilo Krummrich <dakr@redhat.com>, airlied@redhat.com, Ingo Molnar
 <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long
 <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, Benno Lossin <benno.lossin@proton.me>,
 Daniel Almeida <daniel.almeida@collabora.com>, Gary Guo
 <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun
 Feng <boqun.feng@gmail.com>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Martin Rodriguez
 Reboredo <yakoyoku@gmail.com>, Valentin Obst <kernel@valentinobst.de>
Subject: Re: [PATCH v6 3/3] rust: sync: Add SpinLockIrq
In-Reply-To: <20240916213025.477225-4-lyude@redhat.com>
References: <20240916213025.477225-1-lyude@redhat.com>
 <20240916213025.477225-4-lyude@redhat.com>
Date: Wed, 02 Oct 2024 22:53:32 +0200
Message-ID: <8734lew7jn.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 16 2024 at 17:28, Lyude Paul wrote:
> A variant of SpinLock that is expected to be used in noirq contexts, and
> thus requires that the user provide an kernel::irq::IrqDisabled to prove
> they are in such a context upon lock acquisition. This is the rust
> equivalent of spin_lock_irqsave()/spin_lock_irqrestore().

This fundamentally does not work with CONFIG_PREEMPT_RT. See:

   https://www.kernel.org/doc/html/latest/locking/locktypes.html

for further information. TLDR:

On RT enabled kernels spin/rw_lock are substituted by sleeping locks. So
you _cannot_ disable interrupts before taking the lock on RT enabled
kernels. That will result in a 'might_sleep()' splat.

There is a reason why the kernel has two distinct spinlock types:

    raw_spinlock_t and spinlock_t

raw_spinlock_t is a real spinning lock independent of CONFIG_PREEMPT_RT,
spinlock_t is mapped to raw_spinlock_t on CONFIG_PREEMPT_RT=n and to a
rtmutex based implementation for CONFIG_PREEMPT_RT=y.

As a consequence spin_lock_irq() and spin_lock_irqsave() will _NOT_
disable interrupts on a CONFIG_PREEMPT_RT=y kernel.

The proposed rust abstraction is not suitable for that.

At this phase of rust integration there is no need to wrap
raw_spinlock_t, so you have two options to solve that:

   1) Map Rust's SpinLockIrq() to spin_lock_irqsave() and
      spin_unlock_irqrestore() which does the right thing

   2) Play all the PREEMPT_RT games in the local irq disable abstraction

#1 is the right thing to do because no driver should rely on actually
disabling interrupts on the CPU. If there is a driver which does that,
then it's not compatible with RT and should use a local lock instead.

local locks aside of being RT compatible have the benefit that they give
scope to the protected region/data, while a plain local_irq_disable()
does not.

Don't even think about exposing this 'with_irq_disabled' interface
unless you are trying to move actual core code like the scheduler or low
level interrupt handling to rust.

Create explicit interrupt safe interfaces which map to the underlying
locking primitives instead.

Thanks,

        tglx



