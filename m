Return-Path: <linux-kernel+bounces-530782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DD7A4384D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FFF03B867E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 08:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D02266EFF;
	Tue, 25 Feb 2025 08:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CE2nzS2t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91D0261365;
	Tue, 25 Feb 2025 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473549; cv=none; b=pvn3UyQlkcuP5NZQ/nnkJU3x4gGTr9S0Ayj8kNHg8G5V1nuyyrAykXqQPUVrqT31OaGjuo+vJcVO93bsSrjs8KqaZiLNfnhRvy2i2jV82ml7rKucv+8YoC2U7+6Gma3SgaxKvNlRUDaJzzy4Tp5OlP838fcNgyYe7/qXWsOMa2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473549; c=relaxed/simple;
	bh=EBmfRbsxMA5uwXmqzQWQqgBcAKGST1B4nJzT0rp6Ylw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C6f4ioMQuR3KZfTs5K7+AEOwkBaJgwmN5fo8273h48NZ2KvVEOk+pUpdTNw0YUBZrGA7i5F99IjL9Y6WJYZy/h7U1KQl2/Yf1XSLg8lUTpCi+osUfkmZbcmct5CzP7AMzc1v7bro7xJcpdB1/o5X4LAYw5Ftu0c9ePjJKKvb0t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CE2nzS2t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09881C4CEE8;
	Tue, 25 Feb 2025 08:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740473549;
	bh=EBmfRbsxMA5uwXmqzQWQqgBcAKGST1B4nJzT0rp6Ylw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CE2nzS2tpcB49MjhbEkNav1wI2RdhEZpRSTRfUjzbJGQ5tU595fjLWoXZPkdoBRR2
	 UGtI5r5eQ+N4DJurCF947okZ3n1uSmVlKXVHdRVngf0DuvEoaK4Jo9zPemesH5vrcG
	 Y+VSbiwVszXAYDxqLLw7PCiQMVIrlmriKqkXBW9u+qexpHhewvcXKS9sHtdTnzo4Lw
	 QsgXIAW89ypomwmco68vcVWNge2h7iFQwYh32wzG97/wlSIjQSARnsXkeFgWOyHZVl
	 TfXSIzCSEK4yex0HX1RtvGoBoqeuHUkCtFzk0pz6degl7HrE+VoeLy7V/6TFjF+dQg
	 G3hzfhGO9SJMQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>,  "Frederic Weisbecker" <frederic@kernel.org>,
  "Thomas Gleixner" <tglx@linutronix.de>,  "Danilo Krummrich"
 <dakr@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Lyude Paul" <lyude@redhat.com>,  "Guangbo Cui" <2407018371@qq.com>,
  "Dirk Behme" <dirk.behme@gmail.com>,  "Daniel Almeida"
 <daniel.almeida@collabora.com>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 01/13] rust: hrtimer: introduce hrtimer support
In-Reply-To: <CAJ-ks9nj8+fXM_oo0LJo4O6Q=skFRcHwz8TLxw-yB3QTcDF9GA@mail.gmail.com>
 (Tamir
	Duberstein's message of "Mon, 24 Feb 2025 15:04:57 -0500")
References: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
	<20250224-hrtimer-v3-v6-12-rc2-v9-1-5bd3bf0ce6cc@kernel.org>
	<q5sIYQbnCqKmdnZZy-eaKvSUY7O5pOy2-QzwWwCo9VoormFcKS6RS3OVIIby-Pf5PDpTRh67txem3sXQKSB1JQ==@protonmail.internalid>
	<CAJ-ks9nj8+fXM_oo0LJo4O6Q=skFRcHwz8TLxw-yB3QTcDF9GA@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 25 Feb 2025 09:52:19 +0100
Message-ID: <87cyf6xv7g.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Tamir Duberstein" <tamird@gmail.com> writes:

> Hi Andreas, mostly grammar and prose clarity comments below.
>
> I still think HasHrTimer::OFFSET is less clear and more fragile than
> just generating compiler-checked implementations in the macro (you're
> already generating OFFSET and one method implementation rather than
> generating 2 method implementations).

I don't agree with you assessment. My argument is that I would rather
generate as little code as possible in the macro, and the trait would in
practice never be implemented by hand.

>
> On Mon, Feb 24, 2025 at 7:06=E2=80=AFAM Andreas Hindborg <a.hindborg@kern=
el.org> wrote:
>>

[...]

>> +//! # Vocabulary
>> +//!
>> +//! States:
>> +//!
>> +//! - Stopped: initialized but not started, or cancelled, or not restar=
ted.
>> +//! - Started: initialized and started or restarted.
>> +//! - Running: executing the callback.
>> +//!
>> +//! Operations:
>> +//!
>> +//! * Start
>> +//! * Cancel
>> +//! * Restart
>> +//!
>> +//! Events:
>> +//!
>> +//! * Expire
>> +//!
>> +//! ## State Diagram
>> +//!
>> +//! ```text
>> +//!                                                   Return NoRestart
>> +//!                       +--------------------------------------------=
-------------------------+
>> +//!                       |                                            =
                         |
>> +//!                       |                                            =
                         |
>> +//!                       |                                            =
                         |
>> +//!                       |                                         Ret=
urn Restart              |
>> +//!                       |                                      +-----=
-------------------+     |
>> +//!                       |                                      |     =
                   |     |
>> +//!                       |                                      |     =
                   |     |
>> +//!                       v                                      v     =
                   |     |
>> +//!           +-----------------+      Start      +------------------+ =
          +--------+-----+--+
>> +//!           |                 +---------------->|                  | =
          |                 |
>> +//! Init      |                 |                 |                  | =
 Expire   |                 |
>> +//! --------->|    Stopped      |                 |      Started     +-=
--------->|     Running     |
>> +//!           |                 |     Cancel      |                  | =
          |                 |
>> +//!           |                 |<----------------+                  | =
          |                 |
>> +//!           +-----------------+                 +---------------+--+ =
          +-----------------+
>> +//!                                                     ^         |
>> +//!                                                     |         |
>> +//!                                                     +---------+
>> +//!                                                      Restart
>> +//! ```
>> +//!
>> +//!
>> +//! A timer is initialized in the **stopped** state. A stopped timer ca=
n be
>> +//! **started** by the `start` operation, with an **expiry** time. Afte=
r the
>> +//! `start` operation, the timer is in the **started** state. When the =
timer
>> +//! **expires**, the timer enters the **running** state and the handler=
 is
>> +//! executed. After the handler has finished executing, the timer may e=
nter the
>> +//! **started* or **stopped** state, depending on the return value of t=
he
>> +//! handler. A running timer can be **canceled** by the `cancel` operat=
ion. A
>> +//! timer that is cancelled enters the **stopped** state.
>
> This is a bit confusing because it sounds like you're describing a
> *started* timer. After reading the next paragraph I think this wording
> applies to both *started* and *running*, but it isn't unambiguous.

Right, I think I understand. It's a mistake. Last sentence should be:

  A timer in the **started** or **running** state be **canceled** by the
  `cancel` operation. A timer that is cancelled enters the **stopped**
  state.

>
>> +//!
>> +//! A `cancel` or `restart` operation on a timer in the **running** sta=
te takes
>> +//! effect after the handler has finished executing and the timer has t=
ransitioned
>> +//! out of the **running** state.
>
> There's no external restart, right?

There will be, eventually. Conceptually there is, because the state
diagram and this text describe the operation.

> I think this wording is confused
> by the unification of cancel and restart under operations, though they
> are not isomorphic.

Hmm, I am not following. Can you elaborate? The set of operations is
start, cancel, restart.

> Restart (as I understand it) can only happen from
> the handler, and cancel can only happen via a call to hrtimer_cancel.

This text introduces the restart operation. There is no code path to
reach it from rust at the moment, but I am inclined to add the function
due to this confusion. It would be dead code for now though.

> It's also a bit strange that start isn't mentioned whenever cancel and
> restart are mentioned.

Why is that?

>
>> +//!
>> +//! A `restart` operation on a timer in the **stopped** state is equiva=
lent to a
>> +//! `start` operation.
>> +
>> +use crate::{init::PinInit, prelude::*, time::Ktime, types::Opaque};
>> +use core::marker::PhantomData;
>> +
>> +/// A timer backed by a C `struct hrtimer`.
>> +///
>> +/// # Invariants
>> +///
>> +/// * `self.timer` is initialized by `bindings::hrtimer_setup`.
>> +#[pin_data]
>> +#[repr(C)]
>> +pub struct HrTimer<T> {
>> +    #[pin]
>> +    timer: Opaque<bindings::hrtimer>,
>> +    _t: PhantomData<T>,
>> +}
>> +
>> +// SAFETY: Ownership of an `HrTimer` can be moved to other threads and
>> +// used/dropped from there.
>> +unsafe impl<T> Send for HrTimer<T> {}
>> +
>> +// SAFETY: Timer operations are locked on C side, so it is safe to oper=
ate on a
>> +// timer from multiple threads
>
> nit: missing article ("the" C side) and missing period.

Thanks.

>
>> +unsafe impl<T> Sync for HrTimer<T> {}
>> +
>> +impl<T> HrTimer<T> {
>> +    /// Return an initializer for a new timer instance.
>> +    pub fn new() -> impl PinInit<Self>
>> +    where
>> +        T: HrTimerCallback,
>> +    {
>> +        pin_init!(Self {
>> +            // INVARIANTS: We initialize `timer` with `hrtimer_setup` b=
elow.
>
> Why plural INVARIANTS?

Mistake, will fix.

>
>> +            timer <- Opaque::ffi_init(move |place: *mut bindings::hrtim=
er| {
>> +                // SAFETY: By design of `pin_init!`, `place` is a point=
er to a
>> +                // live allocation. hrtimer_setup will initialize `plac=
e` and
>> +                // does not require `place` to be initialized prior to =
the call.
>> +                unsafe {
>> +                    bindings::hrtimer_setup(
>> +                        place,
>> +                        Some(T::Pointer::run),
>> +                        bindings::CLOCK_MONOTONIC as i32,
>> +                        bindings::hrtimer_mode_HRTIMER_MODE_REL,
>> +                    );
>> +                }
>> +            }),
>> +            _t: PhantomData,
>> +        })
>> +    }
>> +
>> +    /// Get a pointer to the contained `bindings::hrtimer`.
>> +    ///
>> +    /// This function do not create any references.
>
> s/do/does/

Thanks.

>
> But maybe this should use the same wording from Opaque::raw_get?
>
>     /// This function is useful to get access to the value without
> creating intermediate
>     /// references.

To me those two wordings have the same effect. I don't mind changing the
wording if you feel strongly about it.

>
> If so, consider also naming the argument "this" for consistency. Same
> for other methods below.

Sure.

>
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// `ptr` must point to a live allocation of at least the size of `=
Self`.
>> +    unsafe fn raw_get(ptr: *const Self) -> *mut bindings::hrtimer {
>> +        // SAFETY: The field projection to `timer` does not go out of b=
ounds,
>> +        // because the caller of this function promises that `ptr` poin=
ts to an
>> +        // allocation of at least the size of `Self`.
>> +        unsafe { Opaque::raw_get(core::ptr::addr_of!((*ptr).timer)) }
>> +    }
>> +
>> +    /// Cancel an initialized and potentially running timer.
>> +    ///
>> +    /// If the timer handler is running, this will block until the hand=
ler is
>> +    /// finished.
>
> nit: s/is finished/returns/ and maybe clarify the ordering, namely
> that the timer is definitely in a stopped state after this returns.

    /// If the timer handler is running, this function will block until the
    /// handler returns. Before this function returns, the timer will be in=
 the
    /// stopped state.

If we have a concurrent call to start, the timer might actually be in
the started state when this function returns. But this function will
transition the timer to the stopped state.

>
>> +    ///
>> +    /// Users of the `HrTimer` API would not usually call this method d=
irectly.
>> +    /// Instead they would use the safe [`HrTimerHandle::cancel`] on th=
e handle
>> +    /// returned when the timer was started.
>> +    ///
>> +    /// This function does not create any references.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// `self_ptr` must point to a valid `Self`.
>
> Why use different phrasing here than on raw_get? The parameter name is
> also different. Would be nice to be consistent.

They are different requirements, one is stronger than the other. I
construct safety requirements based on the unsafe operations in the
function. The unsafe operations in these two functions have different
requirements. I would not impose a stronger requirement than I have to.

>
>> +    #[allow(dead_code)]
>> +    pub(crate) unsafe fn raw_cancel(self_ptr: *const Self) -> bool {
>> +        // SAFETY: timer_ptr points to an allocation of at least `HrTim=
er` size.
>> +        let c_timer_ptr =3D unsafe { HrTimer::raw_get(self_ptr) };
>> +
>> +        // If the handler is running, this will wait for the handler to=
 finish
>> +        // before returning.
>> +        // SAFETY: `c_timer_ptr` is initialized and valid. Synchronizat=
ion is
>> +        // handled on C side.
>
> missing article here.

=F0=9F=91=8D

>
>> +        unsafe { bindings::hrtimer_cancel(c_timer_ptr) !=3D 0 }
>> +    }
>> +}
>> +
>> +/// Implemented by pointer types that point to structs that embed a [`H=
rTimer`].
>> +///
>> +/// Target (pointee) must be [`Sync`] because timer callbacks happen in=
 another
>> +/// thread of execution (hard or soft interrupt context).
>
> Is this explaining the bound on the trait, or something that exists
> outside the type system? If it's the former, isn't the Sync bound on
> the trait going to apply to the pointer rather than the pointee?

It is explaining the bound on the trait, and as you say it is not
correct. Pointer types that do not apply synchronization internally can
only be `Sync` when their target is `Sync`, which was probably my line
of thought.

I will rephrase:

  `Self` must be [`Sync`] because timer callbacks happen in another
  thread of execution (hard or soft interrupt context).

>
>> +///
>> +/// Starting a timer returns a [`HrTimerHandle`] that can be used to ma=
nipulate
>> +/// the timer. Note that it is OK to call the start function repeatedly=
, and
>> +/// that more than one [`HrTimerHandle`] associated with a [`HrTimerPoi=
nter`] may
>> +/// exist. A timer can be manipulated through any of the handles, and a=
 handle
>> +/// may represent a cancelled timer.
>> +pub trait HrTimerPointer: Sync + Sized {
>> +    /// A handle representing a started or restarted timer.
>> +    ///
>> +    /// If the timer is running or if the timer callback is executing w=
hen the
>> +    /// handle is dropped, the drop method of [`HrTimerHandle`] should =
not return
>> +    /// until the timer is stopped and the callback has completed.
>> +    ///
>> +    /// Note: When implementing this trait, consider that it is not uns=
afe to
>> +    /// leak the handle.
>
> What does leak mean in this context?

The same as in all other contexts (I think?). Leave the object alive for
'static and forget the address. Thus never drop it and thus never run
the drop method.

>
>> +    type TimerHandle: HrTimerHandle;
>> +
>> +    /// Start the timer with expiry after `expires` time units. If the =
timer was
>> +    /// already running, it is restarted with the new expiry time.
>> +    fn start(self, expires: Ktime) -> Self::TimerHandle;
>> +}
>> +
>> +/// Implemented by [`HrTimerPointer`] implementers to give the C timer =
callback a
>> +/// function to call.
>> +// This is split from `HrTimerPointer` to make it easier to specify tra=
it bounds.
>> +pub trait RawHrTimerCallback {
>> +    /// This type is passed to [`HrTimerCallback::run`]. It may be a bo=
rrow of
>> +    /// [`Self::CallbackTarget`], or it may be `Self::CallbackTarget` i=
f the
>> +    /// implementation can guarantee correct access (exclusive or shared
>> +    /// depending on the type) to the target during timer handler execu=
tion.
>> +    type CallbackTarget<'a>;
>> +
>> +    /// Callback to be called from C when timer fires.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// Only to be called by C code in `hrtimer` subsystem. `ptr` must =
point to
>
> missing article, should be "...in the `hrtimer`..."

English is difficult =F0=9F=98=85

>
>> +    /// the `bindings::hrtimer` structure that was used to start the ti=
mer.
>> +    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::=
hrtimer_restart;
>> +}
>> +
>> +/// Implemented by structs that can be the target of a timer callback.
>> +pub trait HrTimerCallback {
>> +    /// The type whose [`RawHrTimerCallback::run`] method will be invok=
ed when
>> +    /// the timer expires.
>> +    type Pointer<'a>: RawHrTimerCallback;
>> +
>> +    /// Called by the timer logic when the timer fires.
>> +    fn run(this: <Self::Pointer<'_> as RawHrTimerCallback>::CallbackTar=
get<'_>)
>> +    where
>> +        Self: Sized;
>> +}
>> +
>> +/// A handle representing a potentially running timer.
>> +///
>> +/// More than one handle representing the same timer might exist.
>> +///
>> +/// # Safety
>> +///
>> +/// When dropped, the timer represented by this handle must be cancelle=
d, if it
>> +/// is running. If the timer handler is running when the handle is drop=
ped, the
>> +/// drop method must wait for the handler to finish before returning.
>> +///
>> +/// Note: One way to satisfy the safety requirement is to call `Self::c=
ancel` in
>> +/// the drop implementation for `Self.`
>> +pub unsafe trait HrTimerHandle {
>> +    /// Cancel the timer, if it is running. If the timer handler is run=
ning, block
>> +    /// till the handler has finished.
>
> Here's another case where "running" is confusingly used to refer to
> the timer being in the state before the handler has begun to execute,
> and also to the state after the handler has begun to execute.

Thanks for catching this. How is this:

    /// Cancel the timer, if it is in the started or running state. If the =
timer
    /// is in the running state, block till the handler has finished execut=
ing.



Thanks for the comments!


Best regards,
Andreas Hindborg



