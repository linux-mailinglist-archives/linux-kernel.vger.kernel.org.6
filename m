Return-Path: <linux-kernel+bounces-525345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F85A3EECD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28ECE3B9801
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 08:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EAB201028;
	Fri, 21 Feb 2025 08:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNvPRWu0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60AA1B0406;
	Fri, 21 Feb 2025 08:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740127027; cv=none; b=YimP81dOeJLWQFftKyof0OiE4m06T2pOTLeQkhdaKdoS7xyqoIr28u627UHzabC8QBhbFJHKPOuVjFY1xNS/+OUBDJSqi6sd7zFuEXrJy9h/dnJMsejqEVw6//W21sYwUdk24IFQa+zf5dxQ9RzQ/R69NVxHWeWYuBlSSdZRlHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740127027; c=relaxed/simple;
	bh=Ye+aypySTGZoFKRZuyvmrFq8zKJQvD+3wytveh8qUHE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AejBw5IGimHJhU49KHBUDNqXyDhsZ9hl+iJbsq6kHCOvL8Sk1HmmqmfZNH2eKSuoyU8Y3AsG5EakExZRAGVmoYin98xGNkVtReF1n+fPA0+TkS//FAC8lcFmsW7WaGE0bx67hfFkeS7zhn2E8O8k4gW8+YZt2bcJWSoAveQqLjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNvPRWu0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A03C4CED6;
	Fri, 21 Feb 2025 08:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740127027;
	bh=Ye+aypySTGZoFKRZuyvmrFq8zKJQvD+3wytveh8qUHE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gNvPRWu0NplUrzQGG9GqnLi+3Q6K8r8mVfISF9BQP9eTMkSIr2U57Gh87x7Z3nZ+k
	 T2YXmf40W05Wanwpup3fS5QrDmS5CemjKrS4MJ5OwrDycBnHXXczZoq1ZmgAEUUGoX
	 lAEB/yC2hC76DyXcl+8nk//GbUhSisT1OA4q7eG+IS0m5IEZD0E4VzANiA854u2oe4
	 POh043EgB/eZIo7E2IjTTs++UP2CdgtMiUZE9jxFpJ6lm1SCzQ1+C7QH1ngp5/fkTx
	 UQWJfPtEQKivBpxZz2FH2OKBeyrLKwCXkiosmPIaDHKKcpwWaR+nwUo+XQVgWrZQ6J
	 5KRsCFsJq7kkQ==
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
Subject: Re: [PATCH v8 02/14] rust: hrtimer: introduce hrtimer support
In-Reply-To: <CAJ-ks9mNidHZvWkFJE1jExc2oVk_bbJpiO_DRMrWu5nYhTpKgg@mail.gmail.com>
 (Tamir
	Duberstein's message of "Thu, 20 Feb 2025 16:37:13 -0500")
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
	<20250218-hrtimer-v3-v6-12-rc2-v8-2-48dedb015eb3@kernel.org>
	<KDmrJnQA2_Ojf67mD8WA_UafgVCACRRleB9t-D_1yl_bua8e1VWdGQAUvmMGHscqRHu1gzPJCKe_BfotutZm5Q==@protonmail.internalid>
	<CAJ-ks9ncOyGyQsDFOBxg-7wmXkrQYiZr6H6eEFWsFstk=p1uAA@mail.gmail.com>
	<87wmdkgvr0.fsf@kernel.org>
	<djAeSx8DNZwss2-UqXGmhVPqYm2z4LhKWC70jPHPisd1w70qmpmOfVbHfhqJErhoFwVFM8IpbTv4MKkk_BIpQw==@protonmail.internalid>
	<CAJ-ks9mNidHZvWkFJE1jExc2oVk_bbJpiO_DRMrWu5nYhTpKgg@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 21 Feb 2025 09:36:57 +0100
Message-ID: <87ldtzhexi.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Tamir Duberstein" <tamird@gmail.com> writes:

> On Thu, Feb 20, 2025 at 4:19=E2=80=AFPM Andreas Hindborg <a.hindborg@kern=
el.org> wrote:
>>
>> "Tamir Duberstein" <tamird@gmail.com> writes:
>>
>> > On Tue, Feb 18, 2025 at 8:29=E2=80=AFAM Andreas Hindborg <a.hindborg@k=
ernel.org> wrote:
>> >>
>>
>> [...]
>>
>> >> +//! ## State Diagram
>> >> +//!
>> >> +//! ```text
>> >> +//!                  <-- Stop ----
>> >> +//!                  <-- Cancel --
>> >> +//!                  --- Start -->
>> >> +//!        +---------+        +---------+
>> >> +//!   O--->| Stopped |        | Running |---o
>> >> +//!        +---------+        +---------+   |
>> >> +//!                                  ^      |
>> >> +//!                  <- Expire --    |      |
>> >> +//!                                  o------o
>> >> +//!                                   Restart
>> >> +//! ```
>> >> +//!
>> >> +//! A timer is initialized in the **stopped** state. A stopped timer=
 can be
>> >> +//! **started** with an **expiry** time. After the timer is started,=
 it is
>> >> +//! **running**. When the timer **expires**, the timer handler is ex=
ecuted.
>> >> +//! After the handler has executed, the timer may be **restarted** or
>> >> +//! **stopped**. A running timer can be **canceled** before it's han=
dler is
>> >
>> > "it's" =3D it is. This should be "its" (possessive).
>>
>> Thanks =F0=9F=91=8D
>>
>> > Just to be clear, after the handler has executed and before the timer
>> > has been **restarted** or **stopped** the timer is still in the
>> > **running** state?
>>
>> It depends on the return value of the handler. If the handler returns re=
start,
>> the timer the timer does not enter the stopped state. If the handler
>> returns stop, the timer enters the stopped state.
>>
>> The timer is still considered to be in running state the handler is
>> running.
>>
>> I can add this info to the section.
>
> Yeah, some clarification here would be useful.

I'll add a paragraph =F0=9F=91=8D

[...]

>> >> +    /// Get a pointer to the contained `bindings::hrtimer`.
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
>> >
>> > Can you help me understand why the various functions here operate on
>> > *const Self? I understand the need to obtain a C pointer to interact
>> > with bindings, but I don't understand why we're dealing in raw
>> > pointers to the abstraction rather than references.
>>
>> We cannot reference the `bindings::hrtimer` without wrapping it in
>> `Opaque`. This would be the primary reason. At other times, we cannot
>> produce references because we might not be able to prove that we satisfy
>> the safety requirements for turning a pointer into a reference. If we
>> are just doing offset arithmetic anyway, we don't need a reference.
>
> Why do we have a pointer, rather than a reference, to Self in the
> first place? I think this is the key thing I don't understand.

Perhaps it makes more sense if you look at the context. One of the entry
points to `HrTimer::raw_get` is via `<ArcHrTimerHandle as
HrTimerHandle>::cancel`. This user facing method takes `&mut self`. The
handle contains an arc to a type that contains a `Timer` and implements
`HasHrTImer`. To get to the timer, we need to do pointer manipulation.
We only know how to get the `Timer` field via the `OFFSET`. The natural
return value from the offset operation is a raw pointer. Rather than
convert back to a reference, we stay in pointer land when we call
`HrTimer::raw_cancel`, because we need a pointer to the
`bindings::hrtimer` anyway, not a reference.

>
>>
>>
>> > This extends to
>> > HrTimerPointer, which is intended to be implemented by *pointers to*
>> > structs that embed `HrTimer`; why isn't it implemented on by the
>> > embedder itself?
>>
>> Not sure what you mean here. If you refer to for instance the
>> implementation of `HrTimerPointer for Arc<T>`, I get why you might
>> wonder, why does `HasHrTimer::start` not take a reference instead of a
>> pointer? We could do that, but we would just immediately break it down
>> again in the implementation of `HasHrTimer::start`. Might still be a
>> good idea though.
>
> I was trying to say that my question (which I clarified above,
> hopefully) extends to the description and name of this trait.
> Specifically for this trait I don't understand why its semantics are
> described in terms of pointers rather than references (and AsRef, to
> allow for Arc and friends).

All user facing APIs use references, not pointers. The raw pointer
interfaces are for internal use only. I don't think we would gain
anything from using `AsRef` internally. Perhaps you could clarify a bit mor=
e?

>
>> >
>> > I realize we discussed this on v6, sorry for not keeping up there.
>>
>> No worries, it is good that we discuss this.
>>
>> [...]
>>
>> >> +
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
>> >
>> > Between this comment and the comment on cancel we say "if it is
>> > running" 3 times. Can we say it just once, on the method, and here say
>> > that cancel must be called in Drop?
>>
>> Well, the comment on `cancel` is just a description of what the function
>> does. This piece of text is a safety requirement.
>>
>> We could make the safety requirement for implementing the trait "Impleme=
nt
>> the methods according to their documentation". But that would not help w=
ith
>> the drop requirement.
>
> My suggestion is that the safety comment read: when dropped,
> [Self::cancel] must be called. Something like that.

We don't care how the timer is canceled, it just has to be canceled. It
does not have to be by calling `Self::cancel`.


Best regards,
Andreas Hindborg



