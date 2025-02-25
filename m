Return-Path: <linux-kernel+bounces-531769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A2EA4448D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C504D18884BB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4195F1547F8;
	Tue, 25 Feb 2025 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gE/10YWL"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C044F21ABBB;
	Tue, 25 Feb 2025 15:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740497908; cv=none; b=AltkWkS+KYnqqoop0y0MGkcGKSqDwwUlefnX8CH41Hfks8I7cZb3khtIXHACBUN1Xp1SDdbV0yZ3P1lutxNFZbpc9pm+6jhB3BM389NONAP0tNVZ8ilK+uumDlWCIldlt0f0thLwbpg0I6yE+4d6leD4V5NqnwqX9xydi38gjDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740497908; c=relaxed/simple;
	bh=Avrt1xuRqXbLSJBbfx7E9b6duYNk+pwVqbEES2gAkQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dFUMx/F/tpcFbOboFe0wiJ/7dWaI4ZDfJT3vRUVyDGNrZ3m4y3ulhJOAVvGt4Eu+DBUOYxa/XqGICPRMrGAhfrnNIOUWJfcSYp8KV8gZP/SNFSyh96aChJURaP3IZz+40Ubw3j7QMQT2+rE7JcEVks7Pnrs181XxqyAf29jirGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gE/10YWL; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5452e6f2999so6120870e87.3;
        Tue, 25 Feb 2025 07:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740497904; x=1741102704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBuo4ZTGAcZmPD8DoAibx5cCZyo1ymbz6F2ATMcusrI=;
        b=gE/10YWLy8ufxGr8Jc4l9fudBGsi2VkHw0ocqh5aODI5VB3R82XYGym5doNmmbvxCE
         cnsRB9ka3i/PfJBJbZE4b2QRJ6hh4qbzQFqAB1F1lN4eCZeIiffDoKxRjOBaSObNdIuq
         w+UMe8rr1JBMTRKFLO1XFEPPE6w5BVwJhtlyRg/zn/h8fOPYD5z1p8V0gTmqoI3YW+r+
         V37hg1eZRsqV6/HOQ7Mnb0+kPQE3Kx2/PH0oZBR7YPuZky1IZrlDa86JTOqdvc3Ur+MB
         5r6FFnMOPYcqtb66oi6fMxAW4HX6V5esg4G/8hF9U5LidYoivn4d/xOeVdofydnUkTgF
         V96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740497904; x=1741102704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HBuo4ZTGAcZmPD8DoAibx5cCZyo1ymbz6F2ATMcusrI=;
        b=chyBH+GxFwmbqWkGjuHviJcoS3cghSrjeSJDVd2poiz+Q0dniwuEK2PJ3NTSiGlqaU
         8S49LTzTNf5MlAdFLHG9ZSZeR6rdFuHUOlId8FP3C3fuSxi1211E1qYSGKAducdRHIBr
         umBZh6WVz6VnKkcePfLpJ/5xBAvNu8gGZt9Wm5UuA3zL4vl2b1BYQZqLmF3rdH80AmQa
         pjAboikeZ618OqdOKpMTni2ah7NJc/ztQMy0vjeJyB+DZ6Fnrhxk1EaarDWEfwhuYath
         ks9DSeM2Q4RztWUKw12nDyNVHvf5waGhfr6Z4pEruFqMYyGWWdec3vK2nFLVYH47tzhx
         hbUA==
X-Forwarded-Encrypted: i=1; AJvYcCWa7Zbwah+QezdOrql4mNkqMEvCFv49tyw85lzCaawa0J3zkK3TP5fryWsvkfnUy2g+cGtssnzOejpQVcc=@vger.kernel.org, AJvYcCX3pulPegnBvm/x1e1WLhV0h5wwzs7VTsbfXIM7wBQU6a0Pd1cG9h0l++76ndEgq2KywFZFbAZ0nRn9swYZlEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHhffbt/8N8SnGyH7I0OTSUVM1N1hI9sOhGKWW1c8sNDd08Qqo
	To6n38NdoGu9XNXROA4+G+sC/UMijd133ltaHsfGxa05Oqj31vQoWcI2lY0I+YYXP5gu21SsBhT
	xkTwEfD5oaqypwtYvHq8foV/XUrY=
X-Gm-Gg: ASbGnct3pYQb4JcJgzwtl6G7LO3k8t30P0XX5JUjpOalDGMTj0HfNGLY9r+lmc+iioc
	E3j4rgGO7PK27o08ij82IehqPVm08ZTTUtj/bR3VYWPDSCxE9S+36EfV4CwjdlXYrM2NJdWpgOO
	W6joJHJIT3rILgS2IvU++pblg=
X-Google-Smtp-Source: AGHT+IEK+FzquFRHTZXLLVboqMuRIg7h+sTJlcrH03aedHhMzXPWNGWSk3drw7eGDyrrXe4yw4ASyJQTepJYDgPd5qw=
X-Received: by 2002:a05:6512:1293:b0:544:12b8:d9bc with SMTP id
 2adb3069b0e04-548510c9954mr1616388e87.8.1740497903298; Tue, 25 Feb 2025
 07:38:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
 <20250224-hrtimer-v3-v6-12-rc2-v9-1-5bd3bf0ce6cc@kernel.org>
 <q5sIYQbnCqKmdnZZy-eaKvSUY7O5pOy2-QzwWwCo9VoormFcKS6RS3OVIIby-Pf5PDpTRh67txem3sXQKSB1JQ==@protonmail.internalid>
 <CAJ-ks9nj8+fXM_oo0LJo4O6Q=skFRcHwz8TLxw-yB3QTcDF9GA@mail.gmail.com> <87cyf6xv7g.fsf@kernel.org>
In-Reply-To: <87cyf6xv7g.fsf@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 25 Feb 2025 10:37:46 -0500
X-Gm-Features: AQ5f1Jr38hwriyw3KxvZTEeZAMvKFJLqGqGC1dwLOb9nYyCEjaurBMQ_Vom4Rjc
Message-ID: <CAJ-ks9=PR-Laj37NqG5s_TbKddONWxp4-Cf3C57AMk9z92mfDQ@mail.gmail.com>
Subject: Re: [PATCH v9 01/13] rust: hrtimer: introduce hrtimer support
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Danilo Krummrich <dakr@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, 
	Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 3:52=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> "Tamir Duberstein" <tamird@gmail.com> writes:
>
> > Hi Andreas, mostly grammar and prose clarity comments below.
> >
> > I still think HasHrTimer::OFFSET is less clear and more fragile than
> > just generating compiler-checked implementations in the macro (you're
> > already generating OFFSET and one method implementation rather than
> > generating 2 method implementations).
>
> I don't agree with you assessment. My argument is that I would rather
> generate as little code as possible in the macro, and the trait would in
> practice never be implemented by hand.

In the current patch, the trait:
- provides raw_get_timer
- provides timer_container_of
and the macro:
- defines OFFSET
- defines raw_get_timer

The justification for the redundancy is that without defining
raw_get_timer in the macro the user might invoke the macro
incorrectly. But why is that better than defining both methods in the
macro? Either way the macro provides 2 items. The key benefit of
defining both methods in the macro is that there's no dead-code
implementation of raw_get_pointer in the trait. It also reduces the
surface of the trait, which is always a benefit due to Hyrum's law.

>
> >
> > On Mon, Feb 24, 2025 at 7:06=E2=80=AFAM Andreas Hindborg <a.hindborg@ke=
rnel.org> wrote:
> >>
>
> [...]
>
> >> +//! # Vocabulary
> >> +//!
> >> +//! States:
> >> +//!
> >> +//! - Stopped: initialized but not started, or cancelled, or not rest=
arted.
> >> +//! - Started: initialized and started or restarted.
> >> +//! - Running: executing the callback.
> >> +//!
> >> +//! Operations:
> >> +//!
> >> +//! * Start
> >> +//! * Cancel
> >> +//! * Restart
> >> +//!
> >> +//! Events:
> >> +//!
> >> +//! * Expire
> >> +//!
> >> +//! ## State Diagram
> >> +//!
> >> +//! ```text
> >> +//!                                                   Return NoRestar=
t
> >> +//!                       +------------------------------------------=
---------------------------+
> >> +//!                       |                                          =
                           |
> >> +//!                       |                                          =
                           |
> >> +//!                       |                                          =
                           |
> >> +//!                       |                                         R=
eturn Restart              |
> >> +//!                       |                                      +---=
---------------------+     |
> >> +//!                       |                                      |   =
                     |     |
> >> +//!                       |                                      |   =
                     |     |
> >> +//!                       v                                      v   =
                     |     |
> >> +//!           +-----------------+      Start      +------------------=
+           +--------+-----+--+
> >> +//!           |                 +---------------->|                  =
|           |                 |
> >> +//! Init      |                 |                 |                  =
|  Expire   |                 |
> >> +//! --------->|    Stopped      |                 |      Started     =
+---------->|     Running     |
> >> +//!           |                 |     Cancel      |                  =
|           |                 |
> >> +//!           |                 |<----------------+                  =
|           |                 |
> >> +//!           +-----------------+                 +---------------+--=
+           +-----------------+
> >> +//!                                                     ^         |
> >> +//!                                                     |         |
> >> +//!                                                     +---------+
> >> +//!                                                      Restart
> >> +//! ```
> >> +//!
> >> +//!
> >> +//! A timer is initialized in the **stopped** state. A stopped timer =
can be
> >> +//! **started** by the `start` operation, with an **expiry** time. Af=
ter the
> >> +//! `start` operation, the timer is in the **started** state. When th=
e timer
> >> +//! **expires**, the timer enters the **running** state and the handl=
er is
> >> +//! executed. After the handler has finished executing, the timer may=
 enter the
> >> +//! **started* or **stopped** state, depending on the return value of=
 the
> >> +//! handler. A running timer can be **canceled** by the `cancel` oper=
ation. A
> >> +//! timer that is cancelled enters the **stopped** state.
> >
> > This is a bit confusing because it sounds like you're describing a
> > *started* timer. After reading the next paragraph I think this wording
> > applies to both *started* and *running*, but it isn't unambiguous.
>
> Right, I think I understand. It's a mistake. Last sentence should be:
>
>   A timer in the **started** or **running** state be **canceled** by the
>   `cancel` operation. A timer that is cancelled enters the **stopped**
>   state.

I think you meant "*may* be canceled"? I assume this replaces the last
two sentences?

I noticed below I had suggested talking about the handler as
"returning" rather than "finishing execution"; please consider that
throughout.

>
> >
> >> +//!
> >> +//! A `cancel` or `restart` operation on a timer in the **running** s=
tate takes
> >> +//! effect after the handler has finished executing and the timer has=
 transitioned
> >> +//! out of the **running** state.
> >
> > There's no external restart, right?
>
> There will be, eventually. Conceptually there is, because the state
> diagram and this text describe the operation.

OK.

>
> > I think this wording is confused
> > by the unification of cancel and restart under operations, though they
> > are not isomorphic.
>
> Hmm, I am not following. Can you elaborate? The set of operations is
> start, cancel, restart.

I wrote this when I thought there was no external restart. By the way,
what is the difference between restart and start? Can a running timer
not be started, or does that do something other than reset it to the
new expiry time?


> > Restart (as I understand it) can only happen from
> > the handler, and cancel can only happen via a call to hrtimer_cancel.
>
> This text introduces the restart operation. There is no code path to
> reach it from rust at the moment, but I am inclined to add the function
> due to this confusion. It would be dead code for now though.
>
> > It's also a bit strange that start isn't mentioned whenever cancel and
> > restart are mentioned.
>
> Why is that?

See above - I think I am confused about the difference between start
and restart when called on a running timer.

>
> >
> >> +//!
> >> +//! A `restart` operation on a timer in the **stopped** state is equi=
valent to a
> >> +//! `start` operation.
> >> +
> >> +use crate::{init::PinInit, prelude::*, time::Ktime, types::Opaque};
> >> +use core::marker::PhantomData;
> >> +
> >> +/// A timer backed by a C `struct hrtimer`.
> >> +///
> >> +/// # Invariants
> >> +///
> >> +/// * `self.timer` is initialized by `bindings::hrtimer_setup`.
> >> +#[pin_data]
> >> +#[repr(C)]
> >> +pub struct HrTimer<T> {
> >> +    #[pin]
> >> +    timer: Opaque<bindings::hrtimer>,
> >> +    _t: PhantomData<T>,
> >> +}
> >> +
> >> +// SAFETY: Ownership of an `HrTimer` can be moved to other threads an=
d
> >> +// used/dropped from there.
> >> +unsafe impl<T> Send for HrTimer<T> {}
> >> +
> >> +// SAFETY: Timer operations are locked on C side, so it is safe to op=
erate on a
> >> +// timer from multiple threads
> >
> > nit: missing article ("the" C side) and missing period.
>
> Thanks.
>
> >
> >> +unsafe impl<T> Sync for HrTimer<T> {}
> >> +
> >> +impl<T> HrTimer<T> {
> >> +    /// Return an initializer for a new timer instance.
> >> +    pub fn new() -> impl PinInit<Self>
> >> +    where
> >> +        T: HrTimerCallback,
> >> +    {
> >> +        pin_init!(Self {
> >> +            // INVARIANTS: We initialize `timer` with `hrtimer_setup`=
 below.
> >
> > Why plural INVARIANTS?
>
> Mistake, will fix.
>
> >
> >> +            timer <- Opaque::ffi_init(move |place: *mut bindings::hrt=
imer| {
> >> +                // SAFETY: By design of `pin_init!`, `place` is a poi=
nter to a
> >> +                // live allocation. hrtimer_setup will initialize `pl=
ace` and
> >> +                // does not require `place` to be initialized prior t=
o the call.
> >> +                unsafe {
> >> +                    bindings::hrtimer_setup(
> >> +                        place,
> >> +                        Some(T::Pointer::run),
> >> +                        bindings::CLOCK_MONOTONIC as i32,
> >> +                        bindings::hrtimer_mode_HRTIMER_MODE_REL,
> >> +                    );
> >> +                }
> >> +            }),
> >> +            _t: PhantomData,
> >> +        })
> >> +    }
> >> +
> >> +    /// Get a pointer to the contained `bindings::hrtimer`.
> >> +    ///
> >> +    /// This function do not create any references.
> >
> > s/do/does/
>
> Thanks.
>
> >
> > But maybe this should use the same wording from Opaque::raw_get?
> >
> >     /// This function is useful to get access to the value without
> > creating intermediate
> >     /// references.
>
> To me those two wordings have the same effect. I don't mind changing the
> wording if you feel strongly about it.

Yeah, I would prefer the wording be the exact same if it is intended
to have the same meaning. Using different wording may trigger Chekov's
Gun in the reader's mind (as it did for me).

> >
> > If so, consider also naming the argument "this" for consistency. Same
> > for other methods below.
>
> Sure.
>
> >
> >> +    ///
> >> +    /// # Safety
> >> +    ///
> >> +    /// `ptr` must point to a live allocation of at least the size of=
 `Self`.
> >> +    unsafe fn raw_get(ptr: *const Self) -> *mut bindings::hrtimer {
> >> +        // SAFETY: The field projection to `timer` does not go out of=
 bounds,
> >> +        // because the caller of this function promises that `ptr` po=
ints to an
> >> +        // allocation of at least the size of `Self`.
> >> +        unsafe { Opaque::raw_get(core::ptr::addr_of!((*ptr).timer)) }
> >> +    }
> >> +
> >> +    /// Cancel an initialized and potentially running timer.
> >> +    ///
> >> +    /// If the timer handler is running, this will block until the ha=
ndler is
> >> +    /// finished.
> >
> > nit: s/is finished/returns/ and maybe clarify the ordering, namely
> > that the timer is definitely in a stopped state after this returns.
>
>     /// If the timer handler is running, this function will block until t=
he
>     /// handler returns. Before this function returns, the timer will be =
in the
>     /// stopped state.
>
> If we have a concurrent call to start, the timer might actually be in
> the started state when this function returns. But this function will
> transition the timer to the stopped state.

Got it. Consider dropping the last sentence ("before this function
returns..."), I don't think it makes this clearer.

>
> >
> >> +    ///
> >> +    /// Users of the `HrTimer` API would not usually call this method=
 directly.
> >> +    /// Instead they would use the safe [`HrTimerHandle::cancel`] on =
the handle
> >> +    /// returned when the timer was started.
> >> +    ///
> >> +    /// This function does not create any references.
> >> +    ///
> >> +    /// # Safety
> >> +    ///
> >> +    /// `self_ptr` must point to a valid `Self`.
> >
> > Why use different phrasing here than on raw_get? The parameter name is
> > also different. Would be nice to be consistent.
>
> They are different requirements, one is stronger than the other. I
> construct safety requirements based on the unsafe operations in the
> function. The unsafe operations in these two functions have different
> requirements. I would not impose a stronger requirement than I have to.

Ah, the requirement is stronger here than on `raw_get`. Thanks for clarifyi=
ng.

How about the parameter name bit? Can we be consistent?
Opaque::raw_get calls it "this".

>
> >
> >> +    #[allow(dead_code)]
> >> +    pub(crate) unsafe fn raw_cancel(self_ptr: *const Self) -> bool {
> >> +        // SAFETY: timer_ptr points to an allocation of at least `HrT=
imer` size.
> >> +        let c_timer_ptr =3D unsafe { HrTimer::raw_get(self_ptr) };
> >> +
> >> +        // If the handler is running, this will wait for the handler =
to finish
> >> +        // before returning.
> >> +        // SAFETY: `c_timer_ptr` is initialized and valid. Synchroniz=
ation is
> >> +        // handled on C side.
> >
> > missing article here.
>
> =F0=9F=91=8D
>
> >
> >> +        unsafe { bindings::hrtimer_cancel(c_timer_ptr) !=3D 0 }
> >> +    }
> >> +}
> >> +
> >> +/// Implemented by pointer types that point to structs that embed a [=
`HrTimer`].

This comment says "embed a [`HrTimer`]" but in `trait HrTimer` the
wording is "Implemented by structs that contain timer nodes." Is the
difference significant?

Also the naming of the two traits feels inconsistent; one contains
"Has" and the other doesn't.

> >> +///
> >> +/// Target (pointee) must be [`Sync`] because timer callbacks happen =
in another
> >> +/// thread of execution (hard or soft interrupt context).
> >
> > Is this explaining the bound on the trait, or something that exists
> > outside the type system? If it's the former, isn't the Sync bound on
> > the trait going to apply to the pointer rather than the pointee?
>
> It is explaining the bound on the trait, and as you say it is not
> correct. Pointer types that do not apply synchronization internally can
> only be `Sync` when their target is `Sync`, which was probably my line
> of thought.
>
> I will rephrase:
>
>   `Self` must be [`Sync`] because timer callbacks happen in another
>   thread of execution (hard or soft interrupt context).

How about "...because it is passed to timer callbacks in another
thread of execution ..."?

> >
> >> +///
> >> +/// Starting a timer returns a [`HrTimerHandle`] that can be used to =
manipulate
> >> +/// the timer. Note that it is OK to call the start function repeated=
ly, and
> >> +/// that more than one [`HrTimerHandle`] associated with a [`HrTimerP=
ointer`] may
> >> +/// exist. A timer can be manipulated through any of the handles, and=
 a handle
> >> +/// may represent a cancelled timer.
> >> +pub trait HrTimerPointer: Sync + Sized {
> >> +    /// A handle representing a started or restarted timer.
> >> +    ///
> >> +    /// If the timer is running or if the timer callback is executing=
 when the
> >> +    /// handle is dropped, the drop method of [`HrTimerHandle`] shoul=
d not return
> >> +    /// until the timer is stopped and the callback has completed.
> >> +    ///
> >> +    /// Note: When implementing this trait, consider that it is not u=
nsafe to
> >> +    /// leak the handle.
> >
> > What does leak mean in this context?
>
> The same as in all other contexts (I think?). Leave the object alive for
> 'static and forget the address. Thus never drop it and thus never run
> the drop method.

Got it. Is leaking memory generally allowed in the kernel? In other
words, is there nothing that will complain about such memory never
being reclaimed?

>
> >
> >> +    type TimerHandle: HrTimerHandle;
> >> +
> >> +    /// Start the timer with expiry after `expires` time units. If th=
e timer was
> >> +    /// already running, it is restarted with the new expiry time.
> >> +    fn start(self, expires: Ktime) -> Self::TimerHandle;
> >> +}
> >> +
> >> +/// Implemented by [`HrTimerPointer`] implementers to give the C time=
r callback a
> >> +/// function to call.
> >> +// This is split from `HrTimerPointer` to make it easier to specify t=
rait bounds.
> >> +pub trait RawHrTimerCallback {
> >> +    /// This type is passed to [`HrTimerCallback::run`]. It may be a =
borrow of
> >> +    /// [`Self::CallbackTarget`], or it may be `Self::CallbackTarget`=
 if the
> >> +    /// implementation can guarantee correct access (exclusive or sha=
red
> >> +    /// depending on the type) to the target during timer handler exe=
cution.
> >> +    type CallbackTarget<'a>;
> >> +
> >> +    /// Callback to be called from C when timer fires.
> >> +    ///
> >> +    /// # Safety
> >> +    ///
> >> +    /// Only to be called by C code in `hrtimer` subsystem. `ptr` mus=
t point to
> >
> > missing article, should be "...in the `hrtimer`..."
>
> English is difficult =F0=9F=98=85
>
> >
> >> +    /// the `bindings::hrtimer` structure that was used to start the =
timer.
> >> +    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings=
::hrtimer_restart;
> >> +}
> >> +
> >> +/// Implemented by structs that can be the target of a timer callback=
.
> >> +pub trait HrTimerCallback {
> >> +    /// The type whose [`RawHrTimerCallback::run`] method will be inv=
oked when
> >> +    /// the timer expires.
> >> +    type Pointer<'a>: RawHrTimerCallback;
> >> +
> >> +    /// Called by the timer logic when the timer fires.
> >> +    fn run(this: <Self::Pointer<'_> as RawHrTimerCallback>::CallbackT=
arget<'_>)
> >> +    where
> >> +        Self: Sized;
> >> +}
> >> +
> >> +/// A handle representing a potentially running timer.
> >> +///
> >> +/// More than one handle representing the same timer might exist.
> >> +///
> >> +/// # Safety
> >> +///
> >> +/// When dropped, the timer represented by this handle must be cancel=
led, if it
> >> +/// is running. If the timer handler is running when the handle is dr=
opped, the
> >> +/// drop method must wait for the handler to finish before returning.
> >> +///
> >> +/// Note: One way to satisfy the safety requirement is to call `Self:=
:cancel` in
> >> +/// the drop implementation for `Self.`
> >> +pub unsafe trait HrTimerHandle {
> >> +    /// Cancel the timer, if it is running. If the timer handler is r=
unning, block
> >> +    /// till the handler has finished.
> >
> > Here's another case where "running" is confusingly used to refer to
> > the timer being in the state before the handler has begun to execute,
> > and also to the state after the handler has begun to execute.
>
> Thanks for catching this. How is this:
>
>     /// Cancel the timer, if it is in the started or running state. If th=
e timer
>     /// is in the running state, block till the handler has finished exec=
uting.

Certainly better. Consider dropping "if it is in the started or running sta=
te".

>
>
>
> Thanks for the comments!

You're welcome!

