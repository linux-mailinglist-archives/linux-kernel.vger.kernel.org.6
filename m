Return-Path: <linux-kernel+bounces-532378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B79E6A44C38
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC0B5164DD4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3582E20E71E;
	Tue, 25 Feb 2025 20:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0g3S9AB"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0ED220E31D;
	Tue, 25 Feb 2025 20:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740514472; cv=none; b=AHWioTBcm5PzyPyguvfAik2vhAwM1/L1qlLTEEnPhS4qeJQE2gRmV5KtfMMZivoq5bi+A5CtMV2aUNlzSUnmDxc/eXPJovmjmCJdqEIqF0z/O8UCrcCXGYUBN2qQhb+47wu2kxG0bOdCbjFPMB3j5m4sCeOI+JyTDBslZ8Pp7tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740514472; c=relaxed/simple;
	bh=WSHJRS/WC9a7DJlTNESaXrfIaBnqS3djb5rLi0rbv5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eio1jmroeDCqTxmnryAUZNYSFl86lAU7oUiotZbFlP0HkS2ixWmx0UIi2FjLyXO4x+ZhleF3B3OhEb59uPBMqSkHyZU1yalm+KJcUKhER81LpqKg00my37ZYj7bOFjK637URRdgL6N+u6rS1EAqX3N+cUJ1UzmNLWuIzxtV84uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0g3S9AB; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30797730cbdso60029361fa.3;
        Tue, 25 Feb 2025 12:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740514468; x=1741119268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FEhVEVpaHkHund2Wz0G88JG3mgB9gPu0MlqcSXuEYL8=;
        b=N0g3S9ABvbIx3RzAaNVYk+UB7gVU6CcYuhApab6REoMLnjJXiXflTH7fJSvkxNKNuU
         1P+fS7o1wGpid3CpnjZpg35TTsM0s7136/QlSjsqsn1RSVYLQ5FuuzKMQ4z38eaEfWDU
         GzI/Sr2uxbcmYo+kve7fi5KPWrd7YLcU3pACQQHwTCqyxywp/Aan4MdH7vjFReSlCbpq
         ghdoQeWjzwKJfUwolery/1PO6aRfnRAXwLy1PjTK+2rtVp5zVwwAUBxYDdzIyucDo5Yg
         jDy8GOYZKj79G4Msa4tApAITgFfQVoX/iOq5BTbxNpBY9d2uAnUD4gGxr7qCDNTai0ux
         SlPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740514468; x=1741119268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FEhVEVpaHkHund2Wz0G88JG3mgB9gPu0MlqcSXuEYL8=;
        b=FXoInT11kou6/daHxtI/f3AjoIaMoljFWQ0hKj5fY2bzzzpYlw+tVb3NAf2RRW7Q4U
         oMmcHorVqiPQTFEsbqXTiOUTVUXg3ViPMwWBeTc4Emheop7ybitbRLTVmhN5LlIyJ/UY
         BT34dk8BUYb+xDKzvypmqS0/WFmrxFxfhiHCe74J0TjNR/56puaWY+cLUA3zGzlX/CIs
         evgkg5sFVHa5QLKe29C92hPxpFoh8x2adnpWFPVWorRwH8fSevAPr4EAiUeLuG90bcYb
         CLeYgxNmRn2iWymkAtoq6BXUN4tfpgozZsklOXAq5mZMt9O9FDUWULzt5BMyaHDo8X6H
         HwYw==
X-Forwarded-Encrypted: i=1; AJvYcCUb9x/ht4aNX8drfAVWNECtNRgg/YgB/WCpgova0N2H90Xu6MvYrurL7c7tHOyKpJpf4OL3yjb51tKvcboMBwA=@vger.kernel.org, AJvYcCV+jXQHZDjj0elro/Sy51vuBSwldxUuk6g5D3VeAAymHksizox0ksDLPDvf2XUnH8t9dkZp+6sJx+it+uE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Yc//n5g49DoXDgPGOmHf8ScuFExcjGe4xxdgWx9idS8YesRP
	Uzdp8wNkVreXtz9A2XqUoyt55vPyYbuuJbK/QxsWCF1eq+LE5PIKsf3EpV8nQBUs683UYxIr4MP
	7NeH91xFOAw5UgjVFoCsW/k4Fids=
X-Gm-Gg: ASbGnct1GdACh31lgQyGgZ3KJxGUZvpau494b3olnpbXdzkSMFxmr41VnShELxoCXfL
	ZwMOhzhhrOb4Si4eznKYxIX9PPUOdyRzExhYrAbqOetYkMN5qqYCGr3Jo0GejrGGCZm838eTn8K
	UmkXh/6Xq8gDWOks8UBJm3jHg=
X-Google-Smtp-Source: AGHT+IGg1HymmDyvV39MYw065HEhKfYhO2zJbyrhmvmZNM434Hw3OFuENFsqzPWKGMwMFGZSIGNN7H/64Uw41jijoIM=
X-Received: by 2002:a2e:91d6:0:b0:308:f01f:182c with SMTP id
 38308e7fff4ca-30b79163ee6mr10051851fa.12.1740514467273; Tue, 25 Feb 2025
 12:14:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
 <20250224-hrtimer-v3-v6-12-rc2-v9-1-5bd3bf0ce6cc@kernel.org>
 <q5sIYQbnCqKmdnZZy-eaKvSUY7O5pOy2-QzwWwCo9VoormFcKS6RS3OVIIby-Pf5PDpTRh67txem3sXQKSB1JQ==@protonmail.internalid>
 <CAJ-ks9nj8+fXM_oo0LJo4O6Q=skFRcHwz8TLxw-yB3QTcDF9GA@mail.gmail.com>
 <87cyf6xv7g.fsf@kernel.org> <Wy3wqzRK5qG3GyHC7oEg3NR3tv9-Uv7m_tmgKZTHNEU6aZX5hxrIXLudLfzQvuZNvIz1Av2fKzH5eTvomny1Vg==@protonmail.internalid>
 <CAJ-ks9=PR-Laj37NqG5s_TbKddONWxp4-Cf3C57AMk9z92mfDQ@mail.gmail.com> <87r03lvnx4.fsf@kernel.org>
In-Reply-To: <87r03lvnx4.fsf@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 25 Feb 2025 15:13:51 -0500
X-Gm-Features: AQ5f1JoiXix8JuxqvWmqdLNwLeWM5j9G_9j1nyNzWq6OiI7HVR0zn_pVQuY-9bs
Message-ID: <CAJ-ks9mCvGJoeLhkGHLU-7Q-=g_4XHfX4DBX9w=ZcP4jpWXsPQ@mail.gmail.com>
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

On Tue, Feb 25, 2025 at 2:12=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> "Tamir Duberstein" <tamird@gmail.com> writes:
>
> > On Tue, Feb 25, 2025 at 3:52=E2=80=AFAM Andreas Hindborg <a.hindborg@ke=
rnel.org> wrote:
> >>
> >> "Tamir Duberstein" <tamird@gmail.com> writes:
> >>
> >> > Hi Andreas, mostly grammar and prose clarity comments below.
> >> >
> >> > I still think HasHrTimer::OFFSET is less clear and more fragile than
> >> > just generating compiler-checked implementations in the macro (you'r=
e
> >> > already generating OFFSET and one method implementation rather than
> >> > generating 2 method implementations).
> >>
> >> I don't agree with you assessment. My argument is that I would rather
> >> generate as little code as possible in the macro, and the trait would =
in
> >> practice never be implemented by hand.
> >
> > In the current patch, the trait:
> > - provides raw_get_timer
> > - provides timer_container_of
> > and the macro:
> > - defines OFFSET
> > - defines raw_get_timer
> >
> > The justification for the redundancy is that without defining
> > raw_get_timer in the macro the user might invoke the macro
> > incorrectly.
>
> It's not that they might invoke the macro incorrectly, it's that we
> would not be able to make the macro safe. The way it is implemented now,
> it will only compile if it is safe.
>
> > But why is that better than defining both methods in the
> > macro?
>
> Because it is generating less code. I would rather write the library code=
 than
> have the macro generate the code for us on every invocation.

How is it less code? It's the same amount, just harder to reason about
because you're doing pointer arithmetic rather than relying on
existing macros like container_of.

>
> > Either way the macro provides 2 items. The key benefit of
> > defining both methods in the macro is that there's no dead-code
> > implementation of raw_get_pointer in the trait. It also reduces the
> > surface of the trait, which is always a benefit due to Hyrum's law.
>
> When you say that the surface would be smaller, you mean that by
> dropping OFFSET entirely, the trait would have fewer items?

Yes.


> I'm not familiar with Hyrum's law.

TL;DR is that anything that can become load bearing will. So even if
the intent is that OFFSET is an implementation detail, there's no way
to enforce that, and so someone will misuse it.

> >
> >>
> >> >
> >> > On Mon, Feb 24, 2025 at 7:06=E2=80=AFAM Andreas Hindborg <a.hindborg=
@kernel.org> wrote:
> >> >>
> >>
> >> [...]
> >>
> >> >> +//! # Vocabulary
> >> >> +//!
> >> >> +//! States:
> >> >> +//!
> >> >> +//! - Stopped: initialized but not started, or cancelled, or not r=
estarted.
> >> >> +//! - Started: initialized and started or restarted.
> >> >> +//! - Running: executing the callback.
> >> >> +//!
> >> >> +//! Operations:
> >> >> +//!
> >> >> +//! * Start
> >> >> +//! * Cancel
> >> >> +//! * Restart
> >> >> +//!
> >> >> +//! Events:
> >> >> +//!
> >> >> +//! * Expire
> >> >> +//!
> >> >> +//! ## State Diagram
> >> >> +//!
> >> >> +//! ```text
> >> >> +//!                                                   Return NoRes=
tart
> >> >> +//!                       +---------------------------------------=
------------------------------+
> >> >> +//!                       |                                       =
                              |
> >> >> +//!                       |                                       =
                              |
> >> >> +//!                       |                                       =
                              |
> >> >> +//!                       |                                       =
  Return Restart              |
> >> >> +//!                       |                                      +=
------------------------+     |
> >> >> +//!                       |                                      |=
                        |     |
> >> >> +//!                       |                                      |=
                        |     |
> >> >> +//!                       v                                      v=
                        |     |
> >> >> +//!           +-----------------+      Start      +---------------=
---+           +--------+-----+--+
> >> >> +//!           |                 +---------------->|               =
   |           |                 |
> >> >> +//! Init      |                 |                 |               =
   |  Expire   |                 |
> >> >> +//! --------->|    Stopped      |                 |      Started  =
   +---------->|     Running     |
> >> >> +//!           |                 |     Cancel      |               =
   |           |                 |
> >> >> +//!           |                 |<----------------+               =
   |           |                 |
> >> >> +//!           +-----------------+                 +---------------=
+--+           +-----------------+
> >> >> +//!                                                     ^         =
|
> >> >> +//!                                                     |         =
|
> >> >> +//!                                                     +---------=
+
> >> >> +//!                                                      Restart
> >> >> +//! ```
> >> >> +//!
> >> >> +//!
> >> >> +//! A timer is initialized in the **stopped** state. A stopped tim=
er can be
> >> >> +//! **started** by the `start` operation, with an **expiry** time.=
 After the
> >> >> +//! `start` operation, the timer is in the **started** state. When=
 the timer
> >> >> +//! **expires**, the timer enters the **running** state and the ha=
ndler is
> >> >> +//! executed. After the handler has finished executing, the timer =
may enter the
> >> >> +//! **started* or **stopped** state, depending on the return value=
 of the
> >> >> +//! handler. A running timer can be **canceled** by the `cancel` o=
peration. A
> >> >> +//! timer that is cancelled enters the **stopped** state.
> >> >
> >> > This is a bit confusing because it sounds like you're describing a
> >> > *started* timer. After reading the next paragraph I think this wordi=
ng
> >> > applies to both *started* and *running*, but it isn't unambiguous.
> >>
> >> Right, I think I understand. It's a mistake. Last sentence should be:
> >>
> >>   A timer in the **started** or **running** state be **canceled** by t=
he
> >>   `cancel` operation. A timer that is cancelled enters the **stopped**
> >>   state.
> >
> > I think you meant "*may* be canceled"? I assume this replaces the last
> > two sentences?
>
> Yes and yes.
>
>
> > I noticed below I had suggested talking about the handler as
> > "returning" rather than "finishing execution"; please consider that
> > throughout.
>
> I do not prefer one over the other. Do you care strongly about this one?

I prefer return since it's more obvious but don't feel strongly about
the choice, only that the usage is consistent.

>
> >
> >>
> >> >
> >> >> +//!
> >> >> +//! A `cancel` or `restart` operation on a timer in the **running*=
* state takes
> >> >> +//! effect after the handler has finished executing and the timer =
has transitioned
> >> >> +//! out of the **running** state.
> >> >
> >> > There's no external restart, right?
> >>
> >> There will be, eventually. Conceptually there is, because the state
> >> diagram and this text describe the operation.
> >
> > OK.
> >
> >>
> >> > I think this wording is confused
> >> > by the unification of cancel and restart under operations, though th=
ey
> >> > are not isomorphic.
> >>
> >> Hmm, I am not following. Can you elaborate? The set of operations is
> >> start, cancel, restart.
> >
> > I wrote this when I thought there was no external restart. By the way,
> > what is the difference between restart and start? Can a running timer
> > not be started, or does that do something other than reset it to the
> > new expiry time?
>
> That is good question. I will add the following to address that
> question:
>
> //! When a type implements both `HrTimerPointer` and `Clone`, it is possi=
ble to
> //! issue the `start` operation while the timer is in the **started** sta=
te In
> //! this case the `start` operation is equivalent to the `restart` operat=
ion.
>
> >> > Restart (as I understand it) can only happen from
> >> > the handler, and cancel can only happen via a call to hrtimer_cancel=
.
> >>
> >> This text introduces the restart operation. There is no code path to
> >> reach it from rust at the moment, but I am inclined to add the functio=
n
> >> due to this confusion. It would be dead code for now though.
> >>
> >> > It's also a bit strange that start isn't mentioned whenever cancel a=
nd
> >> > restart are mentioned.
> >>
> >> Why is that?
> >
> > See above - I think I am confused about the difference between start
> > and restart when called on a running timer.
>
> OK.
>
> [...]
>
> >> >
> >> > But maybe this should use the same wording from Opaque::raw_get?
> >> >
> >> >     /// This function is useful to get access to the value without
> >> > creating intermediate
> >> >     /// references.
> >>
> >> To me those two wordings have the same effect. I don't mind changing t=
he
> >> wording if you feel strongly about it.
> >
> > Yeah, I would prefer the wording be the exact same if it is intended
> > to have the same meaning. Using different wording may trigger Chekov's
> > Gun in the reader's mind (as it did for me).
>
> I'm not familiar with any guns =F0=9F=98=85
>
> I'll apply your suggestion.
>
> [...]
>
> >> >
> >> >> +    ///
> >> >> +    /// # Safety
> >> >> +    ///
> >> >> +    /// `ptr` must point to a live allocation of at least the size=
 of `Self`.
> >> >> +    unsafe fn raw_get(ptr: *const Self) -> *mut bindings::hrtimer =
{
> >> >> +        // SAFETY: The field projection to `timer` does not go out=
 of bounds,
> >> >> +        // because the caller of this function promises that `ptr`=
 points to an
> >> >> +        // allocation of at least the size of `Self`.
> >> >> +        unsafe { Opaque::raw_get(core::ptr::addr_of!((*ptr).timer)=
) }
> >> >> +    }
> >> >> +
> >> >> +    /// Cancel an initialized and potentially running timer.
> >> >> +    ///
> >> >> +    /// If the timer handler is running, this will block until the=
 handler is
> >> >> +    /// finished.
> >> >
> >> > nit: s/is finished/returns/ and maybe clarify the ordering, namely
> >> > that the timer is definitely in a stopped state after this returns.
> >>
> >>     /// If the timer handler is running, this function will block unti=
l the
> >>     /// handler returns. Before this function returns, the timer will =
be in the
> >>     /// stopped state.
> >>
> >> If we have a concurrent call to start, the timer might actually be in
> >> the started state when this function returns. But this function will
> >> transition the timer to the stopped state.
> >
> > Got it. Consider dropping the last sentence ("before this function
> > returns..."), I don't think it makes this clearer.
>
> OK.
>
> >
> >>
> >> >
> >> >> +    ///
> >> >> +    /// Users of the `HrTimer` API would not usually call this met=
hod directly.
> >> >> +    /// Instead they would use the safe [`HrTimerHandle::cancel`] =
on the handle
> >> >> +    /// returned when the timer was started.
> >> >> +    ///
> >> >> +    /// This function does not create any references.
> >> >> +    ///
> >> >> +    /// # Safety
> >> >> +    ///
> >> >> +    /// `self_ptr` must point to a valid `Self`.
> >> >
> >> > Why use different phrasing here than on raw_get? The parameter name =
is
> >> > also different. Would be nice to be consistent.
> >>
> >> They are different requirements, one is stronger than the other. I
> >> construct safety requirements based on the unsafe operations in the
> >> function. The unsafe operations in these two functions have different
> >> requirements. I would not impose a stronger requirement than I have to=
.
> >
> > Ah, the requirement is stronger here than on `raw_get`. Thanks for clar=
ifying.
> >
> > How about the parameter name bit? Can we be consistent?
> > Opaque::raw_get calls it "this".
>
> Yes, I applied this throughout where a pointer to `Self` is passed.
>
> >
> >>
> >> >
> >> >> +    #[allow(dead_code)]
> >> >> +    pub(crate) unsafe fn raw_cancel(self_ptr: *const Self) -> bool=
 {
> >> >> +        // SAFETY: timer_ptr points to an allocation of at least `=
HrTimer` size.
> >> >> +        let c_timer_ptr =3D unsafe { HrTimer::raw_get(self_ptr) };
> >> >> +
> >> >> +        // If the handler is running, this will wait for the handl=
er to finish
> >> >> +        // before returning.
> >> >> +        // SAFETY: `c_timer_ptr` is initialized and valid. Synchro=
nization is
> >> >> +        // handled on C side.
> >> >
> >> > missing article here.
> >>
> >> =F0=9F=91=8D
> >>
> >> >
> >> >> +        unsafe { bindings::hrtimer_cancel(c_timer_ptr) !=3D 0 }
> >> >> +    }
> >> >> +}
> >> >> +
> >> >> +/// Implemented by pointer types that point to structs that embed =
a [`HrTimer`].
> >
> > This comment says "embed a [`HrTimer`]" but in `trait HrTimer` the
> > wording is "Implemented by structs that contain timer nodes."
>
> I don't follow. There is no `trait HrTimer`, there is a `struct
> HrTimer`, but it has no such wording.
>
> > Is the difference significant?
>
> No, I would say they are semantically the same. Whether a struct
> contains a field of a type or it embeds another struct - I would say
> that is the same.

Can we use the same wording in both places then?

>
> > Also the naming of the two traits feels inconsistent; one contains
> > "Has" and the other doesn't.
>
> One is not a trait, not sure if you are looking on another item than
> `struct HrTimer`?

Sorry, I meant HasHrTimer and HrTimerPointer rather than HrTimer and
HrTimerPointer.

> >
> >> >> +///
> >> >> +/// Target (pointee) must be [`Sync`] because timer callbacks happ=
en in another
> >> >> +/// thread of execution (hard or soft interrupt context).
> >> >
> >> > Is this explaining the bound on the trait, or something that exists
> >> > outside the type system? If it's the former, isn't the Sync bound on
> >> > the trait going to apply to the pointer rather than the pointee?
> >>
> >> It is explaining the bound on the trait, and as you say it is not
> >> correct. Pointer types that do not apply synchronization internally ca=
n
> >> only be `Sync` when their target is `Sync`, which was probably my line
> >> of thought.
> >>
> >> I will rephrase:
> >>
> >>   `Self` must be [`Sync`] because timer callbacks happen in another
> >>   thread of execution (hard or soft interrupt context).
> >
> > How about "...because it is passed to timer callbacks in another
> > thread of execution ..."?
>
> OK.
>
> >
> >> >
> >> >> +///
> >> >> +/// Starting a timer returns a [`HrTimerHandle`] that can be used =
to manipulate
> >> >> +/// the timer. Note that it is OK to call the start function repea=
tedly, and
> >> >> +/// that more than one [`HrTimerHandle`] associated with a [`HrTim=
erPointer`] may
> >> >> +/// exist. A timer can be manipulated through any of the handles, =
and a handle
> >> >> +/// may represent a cancelled timer.
> >> >> +pub trait HrTimerPointer: Sync + Sized {
> >> >> +    /// A handle representing a started or restarted timer.
> >> >> +    ///
> >> >> +    /// If the timer is running or if the timer callback is execut=
ing when the
> >> >> +    /// handle is dropped, the drop method of [`HrTimerHandle`] sh=
ould not return
> >> >> +    /// until the timer is stopped and the callback has completed.
> >> >> +    ///
> >> >> +    /// Note: When implementing this trait, consider that it is no=
t unsafe to
> >> >> +    /// leak the handle.
> >> >
> >> > What does leak mean in this context?
> >>
> >> The same as in all other contexts (I think?). Leave the object alive f=
or
> >> 'static and forget the address. Thus never drop it and thus never run
> >> the drop method.
> >
> > Got it. Is leaking memory generally allowed in the kernel? In other
> > words, is there nothing that will complain about such memory never
> > being reclaimed?
>
> Leaking is generally unacceptable in the kernel. However, leaking is
> considered safe in rust and is possible within the safe subset of rust.
>
> The first time I implemented this trait, it was unsound in the face of
> the handle being leaked. Of curse this is no different than any other
> code, and we can generally not hinge soundness on things not being
> leaked. But after I foot gunned myself with this, I put the comment.
>
> [...]
>
> >> >> +/// A handle representing a potentially running timer.
> >> >> +///
> >> >> +/// More than one handle representing the same timer might exist.
> >> >> +///
> >> >> +/// # Safety
> >> >> +///
> >> >> +/// When dropped, the timer represented by this handle must be can=
celled, if it
> >> >> +/// is running. If the timer handler is running when the handle is=
 dropped, the
> >> >> +/// drop method must wait for the handler to finish before returni=
ng.
> >> >> +///
> >> >> +/// Note: One way to satisfy the safety requirement is to call `Se=
lf::cancel` in
> >> >> +/// the drop implementation for `Self.`
> >> >> +pub unsafe trait HrTimerHandle {
> >> >> +    /// Cancel the timer, if it is running. If the timer handler i=
s running, block
> >> >> +    /// till the handler has finished.
> >> >
> >> > Here's another case where "running" is confusingly used to refer to
> >> > the timer being in the state before the handler has begun to execute=
,
> >> > and also to the state after the handler has begun to execute.
> >>
> >> Thanks for catching this. How is this:
> >>
> >>     /// Cancel the timer, if it is in the started or running state. If=
 the timer
> >>     /// is in the running state, block till the handler has finished e=
xecuting.
> >
> > Certainly better. Consider dropping "if it is in the started or running=
 state".
>
> OK.
>
>
> Best regards,
> Andreas Hindborg
>
>

