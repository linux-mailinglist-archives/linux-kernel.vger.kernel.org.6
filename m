Return-Path: <linux-kernel+bounces-525807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D17BA3F5C4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72B57427F15
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DAD12F399;
	Fri, 21 Feb 2025 13:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWD+vHdj"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E9F20E6F6;
	Fri, 21 Feb 2025 13:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143716; cv=none; b=tbyAso7/QwR1Fi/LwSN5Kmf63Jn+dNjr8swadgQuUmH/X6pT9Y1gybkgLJfNa0YGaMpHztCQwy17p2AcWCk/uVOLP5WX91oDy3EIJ9/fhnb8VUr9lRCZoWvRO3fznjQudLhCwuDgBaI25Pf9tpT0URDEi6FPUczPtpYotY0/PD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143716; c=relaxed/simple;
	bh=WVkw0EfLG0h1QRaszXDyqz/pFg2qmB1ca245bP/ClmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UQXvaSHIAMAYFauHVSJBfNakJPGXtpIdan8eHKWoOizxqiFuwFcMhd/2ZQMjPqj2ZK/eEvK/erxL/rxL0l6024hXsMhp7gQ5mRQqmbpARAj4peP7p5XGLvADARpcb9+0llEcG65LZA2eHX1jzmatJPLFVTnHr41CgydBOHU96Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWD+vHdj; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30a2dfcfd83so20408411fa.1;
        Fri, 21 Feb 2025 05:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740143712; x=1740748512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZOU7cQ5eA770gfcRvDUou8JrrcrztuXzXTAS+uqGiY=;
        b=WWD+vHdjol8QHw1QBFDpmccAjOf+IBIkAEnHokh7h4iBrKBQncqSmy7dmrYMiDENQc
         7d671AMZ92XHkbkEy5CsVcMFHm9xtGGdaRWP5rcfc0Wo0XiQJMeBQqf9QQ6KN5G9AqM6
         cj734pzIVGDgef124Qbt5lRuTII+I/4yfdPILAzmbhhYYvCZlz9t5gSPHk+JsTdpF4O7
         rcP+X/DK6QoWZnHG3YNzxdr7o/gjS3z1+gsfOehV8oWdgAoJz3I7MY0gBKUXNB3w4zjJ
         Rk4jqe59ub9BffUMYh1CFiJQ56TePqalOR1DFrlyYIY/skZFNz05av4ky68J2ChuzC9e
         2H0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740143712; x=1740748512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ZOU7cQ5eA770gfcRvDUou8JrrcrztuXzXTAS+uqGiY=;
        b=NWE3yq3TsEj7KnyeuEeu29N4p35yM4yrM33DygT1my42mTEVZfS3jIok/6eeJ5C7wq
         2lzbQaQzBnzh4rEWorHYkulZJiC/IASaDeyDGzZswkLCzyiRMsIP74rbYBb9Uonx0mb6
         f6Rt97UVrDdYjPgE3mecLdyxDDJJKfuUGP959aNrrOWtzBi3vjkpiXMuSf8ogHR4KLri
         qxdkIpV5BWpEeVJy3E/VdO4tV7Zzb7bfgR5r9uaqm2frRMN8z4dsII6mmkLtiYTLtBCj
         26y+TVwaD5EW5KsVLPNV6sQTRC9WbbsSmvODoplwm9d3/BJL5V5M1RhfKpG4+9aE9xEG
         HhBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDkwrPevyW2ZFr/E+u4TQ80seJGWhJEVj9ycMbLRQ/cyQ4hRh36a2w6VGw50f93qUMQcSrKI9KTlI0Ws8=@vger.kernel.org, AJvYcCXv76hah6G/RSuvFKzKFsu+r+J/YBGxtuJmAHODY6vrfC25LOXMwLobQAsKkUZdmFsgaM/NIhNCZLgnBAHXSIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBHqNn5vJ3dqVn8T+HJQfGgFPEJ1AqWMHz4XU1GFplYwD9MNFE
	OyFe52egl0EPRm8B5gieYBWwWmugK9c7jUFZk1X9GLfWLp/+NfvS49yO+Hov0d5wXhXVeYph9F/
	hz/uUcZ/U9DK5/tO22CPkjXtg0Lxsv7iZEkU=
X-Gm-Gg: ASbGncsRwca45BdYxyP8K7fRO2y8wg/d1jiyfvlzRCR5WLU2Wy5z6f5JtPR9CNFXLoK
	urcP5VC4QOstr82dFo3pUgVBCjjP6DtUVaBC3G2C8bI3HsFVGzaCzTS9vMAzIfMcJGDpZJ+ls/h
	DffWgMXqxg9ZXE+Fm8CKRe8kmvD2p7U0DdTJaRnIwM
X-Google-Smtp-Source: AGHT+IHu4rdGltHRvQpUf2yAxQrbVxyruveleQ4pb3W5jDsEDRBjWf8r4OsEExwvO+zIz33X0fK6i9mo6aLj7D0be/A=
X-Received: by 2002:a2e:b047:0:b0:302:1fce:3956 with SMTP id
 38308e7fff4ca-30a5985e17emr9076531fa.4.1740143711865; Fri, 21 Feb 2025
 05:15:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
 <20250218-hrtimer-v3-v6-12-rc2-v8-2-48dedb015eb3@kernel.org>
 <KDmrJnQA2_Ojf67mD8WA_UafgVCACRRleB9t-D_1yl_bua8e1VWdGQAUvmMGHscqRHu1gzPJCKe_BfotutZm5Q==@protonmail.internalid>
 <CAJ-ks9ncOyGyQsDFOBxg-7wmXkrQYiZr6H6eEFWsFstk=p1uAA@mail.gmail.com>
 <87wmdkgvr0.fsf@kernel.org> <djAeSx8DNZwss2-UqXGmhVPqYm2z4LhKWC70jPHPisd1w70qmpmOfVbHfhqJErhoFwVFM8IpbTv4MKkk_BIpQw==@protonmail.internalid>
 <CAJ-ks9mNidHZvWkFJE1jExc2oVk_bbJpiO_DRMrWu5nYhTpKgg@mail.gmail.com> <87ldtzhexi.fsf@kernel.org>
In-Reply-To: <87ldtzhexi.fsf@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 21 Feb 2025 08:14:35 -0500
X-Gm-Features: AWEUYZk31UsyOnLnQiHWmIME9hUZUE-wGnxYWwTkcTd8XSjlZRPxNfcPEfHyhis
Message-ID: <CAJ-ks9nCDd4cX2pdaBu6P9Kq6mq3++z6KPj2pZSuUtC9MuQ_sA@mail.gmail.com>
Subject: Re: [PATCH v8 02/14] rust: hrtimer: introduce hrtimer support
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

On Fri, Feb 21, 2025 at 3:37=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> "Tamir Duberstein" <tamird@gmail.com> writes:
>
> > On Thu, Feb 20, 2025 at 4:19=E2=80=AFPM Andreas Hindborg <a.hindborg@ke=
rnel.org> wrote:
> >>
> >> "Tamir Duberstein" <tamird@gmail.com> writes:
> >>
> >> > On Tue, Feb 18, 2025 at 8:29=E2=80=AFAM Andreas Hindborg <a.hindborg=
@kernel.org> wrote:
> >> >>
> >>
> >> [...]
> >>
> >> >> +//! ## State Diagram
> >> >> +//!
> >> >> +//! ```text
> >> >> +//!                  <-- Stop ----
> >> >> +//!                  <-- Cancel --
> >> >> +//!                  --- Start -->
> >> >> +//!        +---------+        +---------+
> >> >> +//!   O--->| Stopped |        | Running |---o
> >> >> +//!        +---------+        +---------+   |
> >> >> +//!                                  ^      |
> >> >> +//!                  <- Expire --    |      |
> >> >> +//!                                  o------o
> >> >> +//!                                   Restart
> >> >> +//! ```
> >> >> +//!
> >> >> +//! A timer is initialized in the **stopped** state. A stopped tim=
er can be
> >> >> +//! **started** with an **expiry** time. After the timer is starte=
d, it is
> >> >> +//! **running**. When the timer **expires**, the timer handler is =
executed.
> >> >> +//! After the handler has executed, the timer may be **restarted**=
 or
> >> >> +//! **stopped**. A running timer can be **canceled** before it's h=
andler is
> >> >
> >> > "it's" =3D it is. This should be "its" (possessive).
> >>
> >> Thanks =F0=9F=91=8D
> >>
> >> > Just to be clear, after the handler has executed and before the time=
r
> >> > has been **restarted** or **stopped** the timer is still in the
> >> > **running** state?
> >>
> >> It depends on the return value of the handler. If the handler returns =
restart,
> >> the timer the timer does not enter the stopped state. If the handler
> >> returns stop, the timer enters the stopped state.
> >>
> >> The timer is still considered to be in running state the handler is
> >> running.
> >>
> >> I can add this info to the section.
> >
> > Yeah, some clarification here would be useful.
>
> I'll add a paragraph =F0=9F=91=8D
>
> [...]
>
> >> >> +    /// Get a pointer to the contained `bindings::hrtimer`.
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
> >> >
> >> > Can you help me understand why the various functions here operate on
> >> > *const Self? I understand the need to obtain a C pointer to interact
> >> > with bindings, but I don't understand why we're dealing in raw
> >> > pointers to the abstraction rather than references.
> >>
> >> We cannot reference the `bindings::hrtimer` without wrapping it in
> >> `Opaque`. This would be the primary reason. At other times, we cannot
> >> produce references because we might not be able to prove that we satis=
fy
> >> the safety requirements for turning a pointer into a reference. If we
> >> are just doing offset arithmetic anyway, we don't need a reference.
> >
> > Why do we have a pointer, rather than a reference, to Self in the
> > first place? I think this is the key thing I don't understand.
>
> Perhaps it makes more sense if you look at the context. One of the entry
> points to `HrTimer::raw_get` is via `<ArcHrTimerHandle as
> HrTimerHandle>::cancel`. This user facing method takes `&mut self`. The
> handle contains an arc to a type that contains a `Timer` and implements
> `HasHrTImer`. To get to the timer, we need to do pointer manipulation.

This is the part I don't entirely understand. Why can't we chase
references all the way to the Timer? AFAICT the reason is that the
HasHrTimer trait is in terms of pointers, but couldn't it be in terms
of references? At least for getting the timer, not necessarily for
getting the timer's container.

> We only know how to get the `Timer` field via the `OFFSET`. The natural
> return value from the offset operation is a raw pointer. Rather than
> convert back to a reference, we stay in pointer land when we call
> `HrTimer::raw_cancel`, because we need a pointer to the
> `bindings::hrtimer` anyway, not a reference.

Sure, but this is breaking encapsulation in a way. Rather than having
a Timer type that owns the raw pointer and is responsible for all
operations on it, a variety of callers are allowed to get the raw
pointer and interact with the bindings.

>
> >
> >>
> >>
> >> > This extends to
> >> > HrTimerPointer, which is intended to be implemented by *pointers to*
> >> > structs that embed `HrTimer`; why isn't it implemented on by the
> >> > embedder itself?
> >>
> >> Not sure what you mean here. If you refer to for instance the
> >> implementation of `HrTimerPointer for Arc<T>`, I get why you might
> >> wonder, why does `HasHrTimer::start` not take a reference instead of a
> >> pointer? We could do that, but we would just immediately break it down
> >> again in the implementation of `HasHrTimer::start`. Might still be a
> >> good idea though.
> >
> > I was trying to say that my question (which I clarified above,
> > hopefully) extends to the description and name of this trait.
> > Specifically for this trait I don't understand why its semantics are
> > described in terms of pointers rather than references (and AsRef, to
> > allow for Arc and friends).
>
> All user facing APIs use references, not pointers. The raw pointer
> interfaces are for internal use only. I don't think we would gain
> anything from using `AsRef` internally. Perhaps you could clarify a bit m=
ore?

It's hard to prove the counter-factual, I don't know exactly what the
code would look like if we went with references everywhere. It just
seems to me that we're writing quite C-like Rust here, which implies
to me that we're not leveraging the compiler as much as we could.

>
> >
> >> >
> >> > I realize we discussed this on v6, sorry for not keeping up there.
> >>
> >> No worries, it is good that we discuss this.
> >>
> >> [...]
> >>
> >> >> +
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
> >> >
> >> > Between this comment and the comment on cancel we say "if it is
> >> > running" 3 times. Can we say it just once, on the method, and here s=
ay
> >> > that cancel must be called in Drop?
> >>
> >> Well, the comment on `cancel` is just a description of what the functi=
on
> >> does. This piece of text is a safety requirement.
> >>
> >> We could make the safety requirement for implementing the trait "Imple=
ment
> >> the methods according to their documentation". But that would not help=
 with
> >> the drop requirement.
> >
> > My suggestion is that the safety comment read: when dropped,
> > [Self::cancel] must be called. Something like that.
>
> We don't care how the timer is canceled, it just has to be canceled. It
> does not have to be by calling `Self::cancel`.

I understand. I'm only suggesting that we could reduce the repetition a bit=
.

