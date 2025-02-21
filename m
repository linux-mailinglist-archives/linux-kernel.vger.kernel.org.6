Return-Path: <linux-kernel+bounces-525813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20259A3F5D7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 428E6169648
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1273D20CCD1;
	Fri, 21 Feb 2025 13:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9UxkfVn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5022B9BC;
	Fri, 21 Feb 2025 13:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143860; cv=none; b=qhi4V0f+Yh0gzIZ/5rfYsRk/9bn2r6DrfR/cKK9dCDDI2FQ8PEuepq22AkzMTQrhdwg+GaGusLa4uOAAFZAyJ/pccwBLjQyGSrX6+9xKEpnFIp+2Ta/VSOTKuvEAfakmNQmtJ3FaQyTu5yD9rFtaw4nRA+EbPA7Yfjw0K2e6wRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143860; c=relaxed/simple;
	bh=5cvYvAHUz4xhfZ0K/Zz/P7LVxYvka8wZVGyvuq7QIzY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qMhfTKng87qCDz8l2pXY/8gbwUfFF9UzuxO+QYFdtu2fTNdjuNmElVwnAXFQK9GSGn4fHxyVJQtAf60KmAYcydzvDsKov/RnC11WuuRnyNYImCIBnHCSyMXUv2UehChsji3K4L0AbGUwHP1FUg+jdCXwZr1HGzJ4bA1qrJFBp3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9UxkfVn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F831C4CED6;
	Fri, 21 Feb 2025 13:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740143859;
	bh=5cvYvAHUz4xhfZ0K/Zz/P7LVxYvka8wZVGyvuq7QIzY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=q9UxkfVnWC453l0sV9IJT712ytaO7hRzXGgnclEAzRipeN+wIpNuO7euYraHaFQKO
	 GCkhutX/Rf9KbPoC4JFzyBKcUsTbbaVc9t0aByaH8jM55/CdG4RLKpJKgFvKEqcLsH
	 7uH0BsQUeWkojmFCHHIgxTu0tmmqMvGE/mm/x8iQ0pWHUpb6l/crCVAB1mpJUoCAzz
	 xBUmaT2fUVM+m0UMBM4ZCdKnu+vLIZPh4efCQLh2Xo70W+RC/auwbPZYv0DUwcCPeA
	 bn9tCXumXnTIsc8X5Ky21GoggBXGoO8LFy+sxVkUsdQF5BmVybJuzv9KUmYmVKXRod
	 i2QKkA1bGpxPw==
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
In-Reply-To: <CAJ-ks9mfe3JBVALO6RJPie6Ae1afH7jsE5jR1jWo_sK266_XPQ@mail.gmail.com>
 (Tamir
	Duberstein's message of "Fri, 21 Feb 2025 08:04:40 -0500")
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
	<20250218-hrtimer-v3-v6-12-rc2-v8-2-48dedb015eb3@kernel.org>
	<KDmrJnQA2_Ojf67mD8WA_UafgVCACRRleB9t-D_1yl_bua8e1VWdGQAUvmMGHscqRHu1gzPJCKe_BfotutZm5Q==@protonmail.internalid>
	<CAJ-ks9ncOyGyQsDFOBxg-7wmXkrQYiZr6H6eEFWsFstk=p1uAA@mail.gmail.com>
	<87wmdkgvr0.fsf@kernel.org>
	<djAeSx8DNZwss2-UqXGmhVPqYm2z4LhKWC70jPHPisd1w70qmpmOfVbHfhqJErhoFwVFM8IpbTv4MKkk_BIpQw==@protonmail.internalid>
	<CAJ-ks9mNidHZvWkFJE1jExc2oVk_bbJpiO_DRMrWu5nYhTpKgg@mail.gmail.com>
	<87r03rhfpu.fsf@kernel.org>
	<mEsEoJuiP_lEKsnf8nfVaquySinIsovqCT5_TxJD_22KTGqOgH7NO9jKYy1W-q95uiGd50brnTE13ydtRZgioA==@protonmail.internalid>
	<CAJ-ks9mfe3JBVALO6RJPie6Ae1afH7jsE5jR1jWo_sK266_XPQ@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 21 Feb 2025 14:17:25 +0100
Message-ID: <87ikp3e8t6.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Tamir Duberstein" <tamird@gmail.com> writes:

> On Fri, Feb 21, 2025 at 3:20=E2=80=AFAM Andreas Hindborg <a.hindborg@kern=
el.org> wrote:
>>
>> "Tamir Duberstein" <tamird@gmail.com> writes:
>>
>> > On Thu, Feb 20, 2025 at 4:19=E2=80=AFPM Andreas Hindborg <a.hindborg@k=
ernel.org> wrote:
>>
>> [...]
>>
>> >> >> +pub unsafe trait HrTimerHandle {
>> >> >> +    /// Cancel the timer, if it is running. If the timer handler =
is running, block
>> >> >> +    /// till the handler has finished.
>> >> >> +    fn cancel(&mut self) -> bool;
>> >> >> +}
>> >> >> +
>> >> >> +/// Implemented by structs that contain timer nodes.
>> >> >> +///
>> >> >> +/// Clients of the timer API would usually safely implement this =
trait by using
>> >> >> +/// the [`crate::impl_has_hr_timer`] macro.
>> >> >> +///
>> >> >> +/// # Safety
>> >> >> +///
>> >> >> +/// Implementers of this trait must ensure that the implementer h=
as a [`HrTimer`]
>> >> >> +/// field at the offset specified by `OFFSET` and that all trait =
methods are
>> >> >> +/// implemented according to their documentation.
>> >> >> +///
>> >> >> +/// [`impl_has_timer`]: crate::impl_has_timer
>> >> >> +pub unsafe trait HasHrTimer<T> {
>> >> >> +    /// Offset of the [`HrTimer`] field within `Self`
>> >> >> +    const OFFSET: usize;
>> >> >
>> >> > Does this need to be part of the trait? As an alternative the provi=
ded
>> >> > methods could be generated in the macro below and reduce the
>> >> > opportunity to implement this trait incorrectly.
>> >>
>> >> There is no risk of implementing the trait wrong, because it is usual=
ly
>> >> derived by a macro.
>> >
>> > There's no risk when it's implemented by the macro, but you used the
>> > word usually,  which means there is a risk.
>> >
>> >> We need at least one of the methods to be able to have the type system
>> >> verify that the type for which we implement `HasHrTImer` actually has=
 a
>> >> field with the name we specify, and that this field has the right typ=
e.
>> >> And to have that, we need the OFFSET.
>> >
>> > I don't follow this logic. OFFSET is calculated in the body of the
>> > macro. I'm suggesting that the macro generate the method
>> > implementations (which would no longer be provided). In effect I'm
>> > saying: keep OFFSET private.
>> >
>> > I'm also noticing now that the macro generates an implementation of
>> > raw_get_timer *in addition to* the provided implementation. Why are
>> > both needed?
>>
>> HasHrTimer is unsafe, because it would be unsound to implement, if the
>> type it is implemented on does not have a `Timer` at the specified
>> offset.
>>
>> To be able to implement it safely with a macro, the macro must verify
>> that the type we implement the trait on satisfies the safety
>> requirement. That is, we have to have the macro verify that the type
>> indeed has a field of type `Timer` with the given name. If that is the
>> case, the macro can calculate OFFSET.
>>
>> The way we achieve this is we re-implement on of the trait methods in
>> such a way that it only compiles if the type we reimplement trait
>> on actually have the field of the right type.
>>
>> I want to generate as little code as possible in the macro, and I would
>> rather rely on the default implementations given in the trait, than have
>> the macro generate implementations for all the methods. Generated code
>> are more difficult to reason about.
>
> Again, I don't follow. The provided implementation of raw_get_timer is
> either not used (in the presence of the macro) or it relies on the
> implementer correctly setting OFFSET, which the compiler cannot check
> and which can break at a distance.
>
> Wouldn't it be simpler to just generate both functions that rely on
> OFFSET? They're both one-liners that delegate to other existing
> macros.

No, I would rather generate as little code as possible. The only reason
I am generating `raw_get_timer` is to be able to type check that the
field name given to the macro has the right type.


Best regards,
Andreas Hindborg



