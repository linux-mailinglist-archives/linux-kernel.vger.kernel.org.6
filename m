Return-Path: <linux-kernel+bounces-532293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0773A44B22
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4316F7A6EAB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E12E1C84D8;
	Tue, 25 Feb 2025 19:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyvWGhuF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DBC21ABC6;
	Tue, 25 Feb 2025 19:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740510772; cv=none; b=fyRzAFx/g6jJjLXY8V1rZeSMWXlHyb3ULpgCmC5H+jXlGvbFAZHzO2IPTh6PjHMymsIUnS2kbPk77UWrK2/eH1PN8dN4t6U1BWTzLugRsh3ywwoE8rqkUU4qplleY7Z4fiLLE9VpW/MoLhCVYNd+0rwaTpXaPvuLWmo2940OqqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740510772; c=relaxed/simple;
	bh=qPbSmshp41FTFt/PIHGXVaM5JtY3yEQ5bjSxdIguvwM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ld7EoQzU7VvoMfksiYqB/BGqbexNHNetDVdv34qA5bJvfcUEOlmJsMXJx6cSYTZVYwalSyPt6YqYbclHZD7hXnUR8Pw7cu89CD6aHjqULZACGQCTpmR6tq1PAtY/M4DQBTfefw3r5gdp9c6bdKOdd/8fLTaEohnW0WBsBVyr3is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyvWGhuF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F00C4CEDD;
	Tue, 25 Feb 2025 19:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740510772;
	bh=qPbSmshp41FTFt/PIHGXVaM5JtY3yEQ5bjSxdIguvwM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ZyvWGhuF76dw8YwPH8Q3I/aHO83xZqelFAss9SH/is1NAnbAOpife1OZmCXvyV7AP
	 uJI0xacoCno0LK9yzZRTscF+BMflQpjZAiH6HE2NS8kOU5lAXJwdV3pbXqxSi0aLgP
	 UKfcZFDpJwdCsRrUvaNgdR+E28z3CCjzq1SU+TjRHBS9aW54RNSVPIxFP7TZDBY2Pb
	 0TZogaSXmUadJOLVfvWuAIvdVlzLBIaeZ9BE2BGaCo+nbgYaIae5JC0d/OwtMXy3JZ
	 av+GXVikergJ9TArYfcS7rJu7uKp/zv0j4ed+qxU1bLR6a4u7zrZiUdZhZiKLZpVbK
	 uhdXO0B7D2/0g==
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
In-Reply-To: <CAJ-ks9=PR-Laj37NqG5s_TbKddONWxp4-Cf3C57AMk9z92mfDQ@mail.gmail.com>
 (Tamir
	Duberstein's message of "Tue, 25 Feb 2025 10:37:46 -0500")
References: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
	<20250224-hrtimer-v3-v6-12-rc2-v9-1-5bd3bf0ce6cc@kernel.org>
	<q5sIYQbnCqKmdnZZy-eaKvSUY7O5pOy2-QzwWwCo9VoormFcKS6RS3OVIIby-Pf5PDpTRh67txem3sXQKSB1JQ==@protonmail.internalid>
	<CAJ-ks9nj8+fXM_oo0LJo4O6Q=skFRcHwz8TLxw-yB3QTcDF9GA@mail.gmail.com>
	<87cyf6xv7g.fsf@kernel.org>
	<Wy3wqzRK5qG3GyHC7oEg3NR3tv9-Uv7m_tmgKZTHNEU6aZX5hxrIXLudLfzQvuZNvIz1Av2fKzH5eTvomny1Vg==@protonmail.internalid>
	<CAJ-ks9=PR-Laj37NqG5s_TbKddONWxp4-Cf3C57AMk9z92mfDQ@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 25 Feb 2025 20:12:39 +0100
Message-ID: <87r03lvnx4.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Tamir Duberstein" <tamird@gmail.com> writes:

> On Tue, Feb 25, 2025 at 3:52=E2=80=AFAM Andreas Hindborg <a.hindborg@kern=
el.org> wrote:
>>
>> "Tamir Duberstein" <tamird@gmail.com> writes:
>>
>> > Hi Andreas, mostly grammar and prose clarity comments below.
>> >
>> > I still think HasHrTimer::OFFSET is less clear and more fragile than
>> > just generating compiler-checked implementations in the macro (you're
>> > already generating OFFSET and one method implementation rather than
>> > generating 2 method implementations).
>>
>> I don't agree with you assessment. My argument is that I would rather
>> generate as little code as possible in the macro, and the trait would in
>> practice never be implemented by hand.
>
> In the current patch, the trait:
> - provides raw_get_timer
> - provides timer_container_of
> and the macro:
> - defines OFFSET
> - defines raw_get_timer
>
> The justification for the redundancy is that without defining
> raw_get_timer in the macro the user might invoke the macro
> incorrectly.

It's not that they might invoke the macro incorrectly, it's that we
would not be able to make the macro safe. The way it is implemented now,
it will only compile if it is safe.

> But why is that better than defining both methods in the
> macro?

Because it is generating less code. I would rather write the library code t=
han
have the macro generate the code for us on every invocation.

> Either way the macro provides 2 items. The key benefit of
> defining both methods in the macro is that there's no dead-code
> implementation of raw_get_pointer in the trait. It also reduces the
> surface of the trait, which is always a benefit due to Hyrum's law.

When you say that the surface would be smaller, you mean that by
dropping OFFSET entirely, the trait would have fewer items?

I'm not familiar with Hyrum's law.

>
>>
>> >
>> > On Mon, Feb 24, 2025 at 7:06=E2=80=AFAM Andreas Hindborg <a.hindborg@k=
ernel.org> wrote:
>> >>
>>
>> [...]
>>
>> >> +//! # Vocabulary
>> >> +//!
>> >> +//! States:
>> >> +//!
>> >> +//! - Stopped: initialized but not started, or cancelled, or not res=
tarted.
>> >> +//! - Started: initialized and started or restarted.
>> >> +//! - Running: executing the callback.
>> >> +//!
>> >> +//! Operations:
>> >> +//!
>> >> +//! * Start
>> >> +//! * Cancel
>> >> +//! * Restart
>> >> +//!
>> >> +//! Events:
>> >> +//!
>> >> +//! * Expire
>> >> +//!
>> >> +//! ## State Diagram
>> >> +//!
>> >> +//! ```text
>> >> +//!                                                   Return NoResta=
rt
>> >> +//!                       +-----------------------------------------=
----------------------------+
>> >> +//!                       |                                         =
                            |
>> >> +//!                       |                                         =
                            |
>> >> +//!                       |                                         =
                            |
>> >> +//!                       |                                         =
Return Restart              |
>> >> +//!                       |                                      +--=
----------------------+     |
>> >> +//!                       |                                      |  =
                      |     |
>> >> +//!                       |                                      |  =
                      |     |
>> >> +//!                       v                                      v  =
                      |     |
>> >> +//!           +-----------------+      Start      +-----------------=
-+           +--------+-----+--+
>> >> +//!           |                 +---------------->|                 =
 |           |                 |
>> >> +//! Init      |                 |                 |                 =
 |  Expire   |                 |
>> >> +//! --------->|    Stopped      |                 |      Started    =
 +---------->|     Running     |
>> >> +//!           |                 |     Cancel      |                 =
 |           |                 |
>> >> +//!           |                 |<----------------+                 =
 |           |                 |
>> >> +//!           +-----------------+                 +---------------+-=
-+           +-----------------+
>> >> +//!                                                     ^         |
>> >> +//!                                                     |         |
>> >> +//!                                                     +---------+
>> >> +//!                                                      Restart
>> >> +//! ```
>> >> +//!
>> >> +//!
>> >> +//! A timer is initialized in the **stopped** state. A stopped timer=
 can be
>> >> +//! **started** by the `start` operation, with an **expiry** time. A=
fter the
>> >> +//! `start` operation, the timer is in the **started** state. When t=
he timer
>> >> +//! **expires**, the timer enters the **running** state and the hand=
ler is
>> >> +//! executed. After the handler has finished executing, the timer ma=
y enter the
>> >> +//! **started* or **stopped** state, depending on the return value o=
f the
>> >> +//! handler. A running timer can be **canceled** by the `cancel` ope=
ration. A
>> >> +//! timer that is cancelled enters the **stopped** state.
>> >
>> > This is a bit confusing because it sounds like you're describing a
>> > *started* timer. After reading the next paragraph I think this wording
>> > applies to both *started* and *running*, but it isn't unambiguous.
>>
>> Right, I think I understand. It's a mistake. Last sentence should be:
>>
>>   A timer in the **started** or **running** state be **canceled** by the
>>   `cancel` operation. A timer that is cancelled enters the **stopped**
>>   state.
>
> I think you meant "*may* be canceled"? I assume this replaces the last
> two sentences?

Yes and yes.


> I noticed below I had suggested talking about the handler as
> "returning" rather than "finishing execution"; please consider that
> throughout.

I do not prefer one over the other. Do you care strongly about this one?

>
>>
>> >
>> >> +//!
>> >> +//! A `cancel` or `restart` operation on a timer in the **running** =
state takes
>> >> +//! effect after the handler has finished executing and the timer ha=
s transitioned
>> >> +//! out of the **running** state.
>> >
>> > There's no external restart, right?
>>
>> There will be, eventually. Conceptually there is, because the state
>> diagram and this text describe the operation.
>
> OK.
>
>>
>> > I think this wording is confused
>> > by the unification of cancel and restart under operations, though they
>> > are not isomorphic.
>>
>> Hmm, I am not following. Can you elaborate? The set of operations is
>> start, cancel, restart.
>
> I wrote this when I thought there was no external restart. By the way,
> what is the difference between restart and start? Can a running timer
> not be started, or does that do something other than reset it to the
> new expiry time?

That is good question. I will add the following to address that
question:

//! When a type implements both `HrTimerPointer` and `Clone`, it is possibl=
e to
//! issue the `start` operation while the timer is in the **started** state=
 In
//! this case the `start` operation is equivalent to the `restart` operatio=
n.

>> > Restart (as I understand it) can only happen from
>> > the handler, and cancel can only happen via a call to hrtimer_cancel.
>>
>> This text introduces the restart operation. There is no code path to
>> reach it from rust at the moment, but I am inclined to add the function
>> due to this confusion. It would be dead code for now though.
>>
>> > It's also a bit strange that start isn't mentioned whenever cancel and
>> > restart are mentioned.
>>
>> Why is that?
>
> See above - I think I am confused about the difference between start
> and restart when called on a running timer.

OK.

[...]

>> >
>> > But maybe this should use the same wording from Opaque::raw_get?
>> >
>> >     /// This function is useful to get access to the value without
>> > creating intermediate
>> >     /// references.
>>
>> To me those two wordings have the same effect. I don't mind changing the
>> wording if you feel strongly about it.
>
> Yeah, I would prefer the wording be the exact same if it is intended
> to have the same meaning. Using different wording may trigger Chekov's
> Gun in the reader's mind (as it did for me).

I'm not familiar with any guns =F0=9F=98=85

I'll apply your suggestion.

[...]

>> >
>> >> +    ///
>> >> +    /// # Safety
>> >> +    ///
>> >> +    /// `ptr` must point to a live allocation of at least the size o=
f `Self`.
>> >> +    unsafe fn raw_get(ptr: *const Self) -> *mut bindings::hrtimer {
>> >> +        // SAFETY: The field projection to `timer` does not go out o=
f bounds,
>> >> +        // because the caller of this function promises that `ptr` p=
oints to an
>> >> +        // allocation of at least the size of `Self`.
>> >> +        unsafe { Opaque::raw_get(core::ptr::addr_of!((*ptr).timer)) }
>> >> +    }
>> >> +
>> >> +    /// Cancel an initialized and potentially running timer.
>> >> +    ///
>> >> +    /// If the timer handler is running, this will block until the h=
andler is
>> >> +    /// finished.
>> >
>> > nit: s/is finished/returns/ and maybe clarify the ordering, namely
>> > that the timer is definitely in a stopped state after this returns.
>>
>>     /// If the timer handler is running, this function will block until =
the
>>     /// handler returns. Before this function returns, the timer will be=
 in the
>>     /// stopped state.
>>
>> If we have a concurrent call to start, the timer might actually be in
>> the started state when this function returns. But this function will
>> transition the timer to the stopped state.
>
> Got it. Consider dropping the last sentence ("before this function
> returns..."), I don't think it makes this clearer.

OK.

>
>>
>> >
>> >> +    ///
>> >> +    /// Users of the `HrTimer` API would not usually call this metho=
d directly.
>> >> +    /// Instead they would use the safe [`HrTimerHandle::cancel`] on=
 the handle
>> >> +    /// returned when the timer was started.
>> >> +    ///
>> >> +    /// This function does not create any references.
>> >> +    ///
>> >> +    /// # Safety
>> >> +    ///
>> >> +    /// `self_ptr` must point to a valid `Self`.
>> >
>> > Why use different phrasing here than on raw_get? The parameter name is
>> > also different. Would be nice to be consistent.
>>
>> They are different requirements, one is stronger than the other. I
>> construct safety requirements based on the unsafe operations in the
>> function. The unsafe operations in these two functions have different
>> requirements. I would not impose a stronger requirement than I have to.
>
> Ah, the requirement is stronger here than on `raw_get`. Thanks for clarif=
ying.
>
> How about the parameter name bit? Can we be consistent?
> Opaque::raw_get calls it "this".

Yes, I applied this throughout where a pointer to `Self` is passed.

>
>>
>> >
>> >> +    #[allow(dead_code)]
>> >> +    pub(crate) unsafe fn raw_cancel(self_ptr: *const Self) -> bool {
>> >> +        // SAFETY: timer_ptr points to an allocation of at least `Hr=
Timer` size.
>> >> +        let c_timer_ptr =3D unsafe { HrTimer::raw_get(self_ptr) };
>> >> +
>> >> +        // If the handler is running, this will wait for the handler=
 to finish
>> >> +        // before returning.
>> >> +        // SAFETY: `c_timer_ptr` is initialized and valid. Synchroni=
zation is
>> >> +        // handled on C side.
>> >
>> > missing article here.
>>
>> =F0=9F=91=8D
>>
>> >
>> >> +        unsafe { bindings::hrtimer_cancel(c_timer_ptr) !=3D 0 }
>> >> +    }
>> >> +}
>> >> +
>> >> +/// Implemented by pointer types that point to structs that embed a =
[`HrTimer`].
>
> This comment says "embed a [`HrTimer`]" but in `trait HrTimer` the
> wording is "Implemented by structs that contain timer nodes."

I don't follow. There is no `trait HrTimer`, there is a `struct
HrTimer`, but it has no such wording.

> Is the difference significant?

No, I would say they are semantically the same. Whether a struct
contains a field of a type or it embeds another struct - I would say
that is the same.

> Also the naming of the two traits feels inconsistent; one contains
> "Has" and the other doesn't.

One is not a trait, not sure if you are looking on another item than
`struct HrTimer`?

>
>> >> +///
>> >> +/// Target (pointee) must be [`Sync`] because timer callbacks happen=
 in another
>> >> +/// thread of execution (hard or soft interrupt context).
>> >
>> > Is this explaining the bound on the trait, or something that exists
>> > outside the type system? If it's the former, isn't the Sync bound on
>> > the trait going to apply to the pointer rather than the pointee?
>>
>> It is explaining the bound on the trait, and as you say it is not
>> correct. Pointer types that do not apply synchronization internally can
>> only be `Sync` when their target is `Sync`, which was probably my line
>> of thought.
>>
>> I will rephrase:
>>
>>   `Self` must be [`Sync`] because timer callbacks happen in another
>>   thread of execution (hard or soft interrupt context).
>
> How about "...because it is passed to timer callbacks in another
> thread of execution ..."?

OK.

>
>> >
>> >> +///
>> >> +/// Starting a timer returns a [`HrTimerHandle`] that can be used to=
 manipulate
>> >> +/// the timer. Note that it is OK to call the start function repeate=
dly, and
>> >> +/// that more than one [`HrTimerHandle`] associated with a [`HrTimer=
Pointer`] may
>> >> +/// exist. A timer can be manipulated through any of the handles, an=
d a handle
>> >> +/// may represent a cancelled timer.
>> >> +pub trait HrTimerPointer: Sync + Sized {
>> >> +    /// A handle representing a started or restarted timer.
>> >> +    ///
>> >> +    /// If the timer is running or if the timer callback is executin=
g when the
>> >> +    /// handle is dropped, the drop method of [`HrTimerHandle`] shou=
ld not return
>> >> +    /// until the timer is stopped and the callback has completed.
>> >> +    ///
>> >> +    /// Note: When implementing this trait, consider that it is not =
unsafe to
>> >> +    /// leak the handle.
>> >
>> > What does leak mean in this context?
>>
>> The same as in all other contexts (I think?). Leave the object alive for
>> 'static and forget the address. Thus never drop it and thus never run
>> the drop method.
>
> Got it. Is leaking memory generally allowed in the kernel? In other
> words, is there nothing that will complain about such memory never
> being reclaimed?

Leaking is generally unacceptable in the kernel. However, leaking is
considered safe in rust and is possible within the safe subset of rust.

The first time I implemented this trait, it was unsound in the face of
the handle being leaked. Of curse this is no different than any other
code, and we can generally not hinge soundness on things not being
leaked. But after I foot gunned myself with this, I put the comment.

[...]

>> >> +/// A handle representing a potentially running timer.
>> >> +///
>> >> +/// More than one handle representing the same timer might exist.
>> >> +///
>> >> +/// # Safety
>> >> +///
>> >> +/// When dropped, the timer represented by this handle must be cance=
lled, if it
>> >> +/// is running. If the timer handler is running when the handle is d=
ropped, the
>> >> +/// drop method must wait for the handler to finish before returning.
>> >> +///
>> >> +/// Note: One way to satisfy the safety requirement is to call `Self=
::cancel` in
>> >> +/// the drop implementation for `Self.`
>> >> +pub unsafe trait HrTimerHandle {
>> >> +    /// Cancel the timer, if it is running. If the timer handler is =
running, block
>> >> +    /// till the handler has finished.
>> >
>> > Here's another case where "running" is confusingly used to refer to
>> > the timer being in the state before the handler has begun to execute,
>> > and also to the state after the handler has begun to execute.
>>
>> Thanks for catching this. How is this:
>>
>>     /// Cancel the timer, if it is in the started or running state. If t=
he timer
>>     /// is in the running state, block till the handler has finished exe=
cuting.
>
> Certainly better. Consider dropping "if it is in the started or running s=
tate".

OK.


Best regards,
Andreas Hindborg



