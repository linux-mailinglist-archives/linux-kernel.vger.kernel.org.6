Return-Path: <linux-kernel+bounces-361335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EF899A6F6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9728F1C21068
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C25183CA5;
	Fri, 11 Oct 2024 14:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YO+fT6gm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B4217BA2;
	Fri, 11 Oct 2024 14:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728658334; cv=none; b=j8q6/E0eGOHnXe7n/jP22wP4px0ZFl3PbM2MVRlwvhLCbIN2i1lwuBwX1bxV+5ENb9+iR3c+2rQKYesI828jW26OV3Y28GnH9dW68BfTHjgscT6qvL4rH9OktiHFaVfC9RjHh0Uae7e017fp7YTdCK4BRFJp2Lqkmh0kWFjQB/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728658334; c=relaxed/simple;
	bh=jWxMRywxKLspmxj8Bv+GBBNjHfb5fG8hz1FVCACo2o8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sgyXmwU/DccPyKG2pr8R4/gsEz7WDcRIvZDqY2VGctNHPt2r1kfH8m3jHu0uW4h45vQIodsDyxyUOT5VkWr1U1uc0U2RQQL8GdxXfe8L8sa1lJRgVzRLONwT0CopkJoJiX4px2Ud5+QogDmXTbsHwTcDu2G+P4Qrmguz82FZPw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YO+fT6gm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91C2C4CEC3;
	Fri, 11 Oct 2024 14:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728658334;
	bh=jWxMRywxKLspmxj8Bv+GBBNjHfb5fG8hz1FVCACo2o8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YO+fT6gmDKEDYedrrg4GwZj5TZ3Yo4tfD+vUeweWiql5yijc7wAFAKWA6wpAqfcWY
	 eS7vyNeH92arJMI9L9/y01ueypOUv/TCf1JQRM1IYEwn2WyIP05DVaTbzojLhDJ0NX
	 QIZWk4aEwf7ZcraWFgja4gxlpP9b5bExsxGpcldwJAwfO/5i4D/s7XxGBL2l3Bup4p
	 WcrUp2H7wpi1UyVn8LflJprD2CGWxpBSw1ZWXC+hRScAy+d0Dju/xua3weL3cfOl4J
	 Z9nafw3na0BOja8ohKk/aNIUdS6QO9/vj6dFba54YQEoxT19ps/YRRi8dKmuPrDLRR
	 6WcffIGAzws3g==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Lyude Paul <lyude@redhat.com>
Cc: Dirk Behme <dirk.behme@de.bosch.com>,  Miguel Ojeda <ojeda@kernel.org>,
  Alex Gaynor <alex.gaynor@gmail.com>,  Anna-Maria Behnsen
 <anna-maria@linutronix.de>,  Frederic Weisbecker <frederic@kernel.org>,
  Thomas Gleixner <tglx@linutronix.de>,  Gary Guo <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,  Benno Lossin
 <benno.lossin@proton.me>,  Alice Ryhl <aliceryhl@google.com>,
  rust-for-linux@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/14] hrtimer Rust API
In-Reply-To: <ZvwKTinnLckZm8aQ@boqun-archlinux> (Boqun Feng's message of "Tue,
	1 Oct 2024 07:42:22 -0700")
References: <20240917222739.1298275-1-a.hindborg@kernel.org>
	<e644aec7-02b3-4faf-9a80-629055c5a27a@de.bosch.com>
	<ZvwKTinnLckZm8aQ@boqun-archlinux>
Date: Fri, 11 Oct 2024 16:52:01 +0200
Message-ID: <87a5falmjy.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Dirk, thanks for reporting!

Boqun Feng <boqun.feng@gmail.com> writes:

> On Tue, Oct 01, 2024 at 02:37:46PM +0200, Dirk Behme wrote:
>> On 18.09.2024 00:27, Andreas Hindborg wrote:
>> > Hi!
>> > 
>> > This series adds support for using the `hrtimer` subsystem from Rust code.
>> > 
>> > I tried breaking up the code in some smaller patches, hopefully that will
>> > ease the review process a bit.
>> 
>> Just fyi, having all 14 patches applied I get [1] on the first (doctest)
>> Example from hrtimer.rs.
>> 
>> This is from lockdep:
>> 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/locking/lockdep.c#n4785
>> 
>> Having just a quick look I'm not sure what the root cause is. Maybe mutex in
>> interrupt context? Or a more subtle one?
>
> I think it's calling mutex inside an interrupt context as shown by the
> callstack:
>
> ]  __mutex_lock+0xa0/0xa4
> ] ...
> ]  hrtimer_interrupt+0x1d4/0x2ac
>
> , it is because:
>
> +//! struct ArcIntrusiveTimer {
> +//!     #[pin]
> +//!     timer: Timer<Self>,
> +//!     #[pin]
> +//!     flag: Mutex<bool>,
> +//!     #[pin]
> +//!     cond: CondVar,
> +//! }
>
> has a Mutex<bool>, which actually should be a SpinLockIrq [1]. Note that
> irq-off is needed for the lock, because otherwise we will hit a self
> deadlock due to interrupts:
>
> 	spin_lock(&a);
> 	> timer interrupt
> 	  spin_lock(&a);
>
> Also notice that the IrqDisabled<'_> token can be simply created by
> ::new(), because irq contexts should guarantee interrupt disabled (i.e.
> we don't support nested interrupts*).

I updated the example based on the work in [1]. I think we need to
update `CondVar::wait` to support waiting with irq disabled. Without
this, when we get back from `bindings::schedule_timeout` in
`CondVar::wait_internal`, interrupts are enabled:

```rust
use kernel::{
    hrtimer::{Timer, TimerCallback, TimerPointer, TimerRestart},
    impl_has_timer, new_condvar, new_spinlock, new_spinlock_irq,
    irq::IrqDisabled,
    prelude::*,
    sync::{Arc, ArcBorrow, CondVar, SpinLock, SpinLockIrq},
    time::Ktime,
};

#[pin_data]
struct ArcIntrusiveTimer {
    #[pin]
    timer: Timer<Self>,
    #[pin]
    flag: SpinLockIrq<u64>,
    #[pin]
    cond: CondVar,
}

impl ArcIntrusiveTimer {
    fn new() -> impl PinInit<Self, kernel::error::Error> {
        try_pin_init!(Self {
            timer <- Timer::new(),
            flag <- new_spinlock_irq!(0),
            cond <- new_condvar!(),
        })
    }
}

impl TimerCallback for ArcIntrusiveTimer {
    type CallbackTarget<'a> = Arc<Self>;
    type CallbackTargetParameter<'a> = ArcBorrow<'a, Self>;

    fn run(this: Self::CallbackTargetParameter<'_>, irq: IrqDisabled<'_>) -> TimerRestart {
        pr_info!("Timer called\n");
        let mut guard = this.flag.lock_with(irq);
        *guard += 1;
        this.cond.notify_all();
        if *guard == 5 {
            TimerRestart::NoRestart
        }
        else {
            TimerRestart::Restart

        }
    }
}

impl_has_timer! {
    impl HasTimer<Self> for ArcIntrusiveTimer { self.timer }
}


let has_timer = Arc::pin_init(ArcIntrusiveTimer::new(), GFP_KERNEL)?;
let _handle = has_timer.clone().schedule(Ktime::from_ns(200_000_000));

kernel::irq::with_irqs_disabled(|irq| {
  let mut guard = has_timer.flag.lock_with(irq);

  while *guard != 5 {
      pr_info!("Not 5 yet, waiting\n");
      has_timer.cond.wait(&mut guard); // <-- we arrive back here with interrupts enabled!
  }
});
```

I think an update of `CondVar::wait` should be part of the patch set [1]. 


Best regards,
Andreas


[1] https://lore.kernel.org/rust-for-linux/20240916213025.477225-1-lyude@redhat.com/


