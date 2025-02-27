Return-Path: <linux-kernel+bounces-536130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B99FA47BE3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B38381893648
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4A322ACF3;
	Thu, 27 Feb 2025 11:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNc5JKJ+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAC422836C;
	Thu, 27 Feb 2025 11:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740655103; cv=none; b=VgwUdy0GwsKuHxOzFeFZTiRdEHFiEKw12PKPIFN+nm9+ajO0jOmHlLWo5LejV8FSjp8Mtqk4EvRpv1H9KMMyUq1tJSVWv8Eu8Nmoa7GGjyJGVVRfV5pIqPQZqDH3wmVIGK8CJ/o53f5ep6I70DfdibVXNBL+YZmpuBaXB4Z/z/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740655103; c=relaxed/simple;
	bh=HwJuWx8Nf/PIQoAnSuy/X4P4bQyMoCoT8i47rFriK5k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qxL0BJtT6D2dGaNXSf3UqKMUGRuLuukhF+3FK2c2+q9PEOui2KIzEjexWE1BXbK3w28zbxkYuiE1PDgsJO7CMqcsr0siphNcsfvoI4txY/GPrjjQFBv4fYs9rftOMSj/d2AklkanCYjG1f0pQqvrP+sJtZ0tEwynMgA7o2rwtf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNc5JKJ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1700C4CEE4;
	Thu, 27 Feb 2025 11:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740655102;
	bh=HwJuWx8Nf/PIQoAnSuy/X4P4bQyMoCoT8i47rFriK5k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DNc5JKJ+1ZwMIrH+Ur0TeOKp9aSVxWU/QlALZxlMf+IdcADLEvDjLVgD+YLFH1RDb
	 P9csNhfAe7evI/GSXitFDlEruKCvG4/wptowKeauaV5N3RM2pfhX6vUjl2Ag7zll3E
	 7kF6kLppG8wJ1OPsuil/s3TfxL4rBthLYLswe1UDjUx392yAkyHM5Uw2E1rXNqGHyj
	 5MEwnRISJIH/6izWC4I6QbFvOFeLClMXiQGE6K1TExbDcZIA3WpeNpkf+G5TwDtvbn
	 bgCDSX2tNgjUJdx0/g0whBzLtS328IlTRyCh+Y4Lzj2n1sDG7viW0JNm0d2/qt8mtX
	 tPokK0AYOItWA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Thomas Gleixner" <tglx@linutronix.de>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>,  "Frederic Weisbecker" <frederic@kernel.org>,
  "Danilo Krummrich" <dakr@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,
  "Trevor Gross" <tmgross@umich.edu>,  "Lyude Paul" <lyude@redhat.com>,
  "Guangbo Cui" <2407018371@qq.com>,  "Dirk Behme" <dirk.behme@gmail.com>,
  "Daniel Almeida" <daniel.almeida@collabora.com>,  "Tamir Duberstein"
 <tamird@gmail.com>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 01/13] rust: hrtimer: introduce hrtimer support
In-Reply-To: <87o6yneqkz.ffs@tglx> (Thomas Gleixner's message of "Thu, 27 Feb
	2025 09:31:40 +0100")
References: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
	<20250224-hrtimer-v3-v6-12-rc2-v9-1-5bd3bf0ce6cc@kernel.org>
	<E8XLZ6FldwY2IfhcR5euCuRF3pVvyrjEknSOWtj_RyWxSpZ3SW8NZnDJtDLd4nA5UcxMhp97lnaBlfEIFq45ow==@protonmail.internalid>
	<87o6yneqkz.ffs@tglx>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 27 Feb 2025 11:44:51 +0100
Message-ID: <87bjunr7j0.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Thomas Gleixner" <tglx@linutronix.de> writes:

> On Mon, Feb 24 2025 at 13:03, Andreas Hindborg wrote:
>> This patch adds support for intrusive use of the hrtimer system. For
>> now,
>
> git grep 'This patch' Documentation/process/

I was made aware and have change the mood to imperative for next spin.

>
>> only one timer can be embedded in a Rust struct.
>>
>> +//! ## State Diagram
>> +//!
>> +//! ```text
>> +//!                                                   Return NoRestart
>> +//!                       +---------------------------------------------------------------------+
>> +//!                       |                                                                     |
>> +//!                       |                                                                     |
>> +//!                       |                                                                     |
>> +//!                       |                                         Return Restart              |
>> +//!                       |                                      +------------------------+     |
>> +//!                       |                                      |                        |     |
>> +//!                       |                                      |                        |     |
>> +//!                       v                                      v                        |     |
>> +//!           +-----------------+      Start      +------------------+           +--------+-----+--+
>> +//!           |                 +---------------->|                  |           |                 |
>> +//! Init      |                 |                 |                  |  Expire   |                 |
>> +//! --------->|    Stopped      |                 |      Started     +---------->|     Running     |
>> +//!           |                 |     Cancel      |                  |           |                 |
>> +//!           |                 |<----------------+                  |           |                 |
>> +//!           +-----------------+                 +---------------+--+           +-----------------+
>> +//!                                                     ^         |
>> +//!                                                     |         |
>> +//!                                                     +---------+
>> +//!                                                      Restart
>> +//! ```
>> +//!
>> +//!
>> +//! A timer is initialized in the **stopped** state. A stopped timer can be
>> +//! **started** by the `start` operation, with an **expiry** time. After the
>> +//! `start` operation, the timer is in the **started** state. When the timer
>> +//! **expires**, the timer enters the **running** state and the handler is
>> +//! executed. After the handler has finished executing, the timer may enter the
>> +//! **started* or **stopped** state, depending on the return value of the
>> +//! handler. A running timer can be **canceled** by the `cancel` operation. A
>> +//! timer that is cancelled enters the **stopped** state.
>> +//!
>> +//! A `cancel` or `restart` operation on a timer in the **running** state takes
>> +//! effect after the handler has finished executing and the timer has transitioned
>> +//! out of the **running** state.
>> +//!
>> +//! A `restart` operation on a timer in the **stopped** state is equivalent to a
>> +//! `start` operation.
>
> Nice explanation!

Thanks.

>
>> +    /// Cancel an initialized and potentially running timer.
>> +    ///
>> +    /// If the timer handler is running, this will block until the handler is
>> +    /// finished.
>> +    ///
>> +    /// Users of the `HrTimer` API would not usually call this method directly.
>> +    /// Instead they would use the safe [`HrTimerHandle::cancel`] on the handle
>> +    /// returned when the timer was started.
>> +    ///
>> +    /// This function does not create any references.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// `self_ptr` must point to a valid `Self`.
>> +    #[allow(dead_code)]
>> +    pub(crate) unsafe fn raw_cancel(self_ptr: *const Self) -> bool {
>> +        // SAFETY: timer_ptr points to an allocation of at least `HrTimer` size.
>> +        let c_timer_ptr = unsafe { HrTimer::raw_get(self_ptr) };
>> +
>> +        // If the handler is running, this will wait for the handler to finish
>> +        // before returning.
>> +        // SAFETY: `c_timer_ptr` is initialized and valid. Synchronization is
>> +        // handled on C side.
>
> You might want to be more explicit about the provided synchronization.
> The hrtimer core only guarantees that operations on the hrtimer object
> are strictly serialized. But it does not provide any guarantee about
> external concurrency. The following case cannot be handled by the core:
>
>          T0                         T1
>          cancel()                   start()
>            lock()
>            ....                     lock() <- contended
>            dequeue()
>            unlock()
>                                     enqueue()
>                                     unlock()
>
> So there is no guarantee for T0 that the timer is actually canceled in
> this case. The hrtimer core can do nothing about this, that's a problem
> of the call sites.

Right, this was also my understanding. I can add a note about this race.

> We've implemented timer_shutdown() for the timer wheel timers, which
> prevents that the timer can be started after shutdown() succeeds. It
> might be a good thing to implement this for hrtimers as well.

Sounds like that would be useful.



Best regards,
Andreas Hindborg





