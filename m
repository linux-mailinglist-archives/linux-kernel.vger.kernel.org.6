Return-Path: <linux-kernel+bounces-527410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E044A40AEF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 19:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72D963BFF14
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 18:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7CC20B1FA;
	Sat, 22 Feb 2025 18:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZ+WvHtW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4694433A8;
	Sat, 22 Feb 2025 18:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740248768; cv=none; b=VAMqEzdynKF59rLnNniD9G1oyEfLir2QrfHtBdbZjT2wkDw1SDsJfMHyS3CsptqgyDwDMfdGX0Mkvi0OJQGOGp5yagymg1TBWmW1U+YBiQpCXmEs14OIKEqv1zb6kRmRG3u7Y3IKdQ2hBnH25wjCy2K7o3MdT+L9vNO3PGfbKPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740248768; c=relaxed/simple;
	bh=Ll5rBv+g/tB5EVHHJARLnz1+gDcYymcrgifMDHDztbA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sQoSysiH1YuVqOmhpHn3kS6GTE4Z/g6vDW1T/Dtrj1mlNoazmznRSSwvCAofAxGkWSMULBT3T+5p0muCb277x6h2Ih32wZx0jhq5x3vu7gkyCAA5dQpWKdyH/tIwtrKNUWvo0A7/cjdoN8pZfnvxYbtfl8C/eJ84lx2h5l6x+Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZ+WvHtW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8DAEC4CED1;
	Sat, 22 Feb 2025 18:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740248767;
	bh=Ll5rBv+g/tB5EVHHJARLnz1+gDcYymcrgifMDHDztbA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kZ+WvHtWb48zB8PWZfic0+zVwMJTnfSxX75jSQL6ZYiBdIfVYqCbrIG15yD0hzXpN
	 cGCFpS/qJNHnF25/CO1fZIKEuWaR2uytGGOxug6RibzxHfPhYdInz2DeThRDtsYc6x
	 xLC8W4olpNR7FGAMY5Nb+o8F+dyczYDxVy+oGtZ2NT0+XL8fG2ZT+oR0nPeST0oRjI
	 G1jhgfmeb3AvlKxn3RUTAQ9ltl2G0X7wVVJAYJMbpOchu9IRPMGltN0tiwFIvCRuja
	 Zxag6P0WRK92jDpAkVVZio6oQxCdzgd2+QnTreAXpg7gxg4hKagEEGtP+zZJEwoNnS
	 iUVk5QJk9Or0w==
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
In-Reply-To: <CAJ-ks9kLZ7LCTW+W4jhUqmF1ypJ7i56oSizdFV-1Ks5DiCoKsA@mail.gmail.com>
 (Tamir
	Duberstein's message of "Fri, 21 Feb 2025 09:21:14 -0500")
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
	<20250218-hrtimer-v3-v6-12-rc2-v8-2-48dedb015eb3@kernel.org>
	<KDmrJnQA2_Ojf67mD8WA_UafgVCACRRleB9t-D_1yl_bua8e1VWdGQAUvmMGHscqRHu1gzPJCKe_BfotutZm5Q==@protonmail.internalid>
	<CAJ-ks9ncOyGyQsDFOBxg-7wmXkrQYiZr6H6eEFWsFstk=p1uAA@mail.gmail.com>
	<87wmdkgvr0.fsf@kernel.org>
	<djAeSx8DNZwss2-UqXGmhVPqYm2z4LhKWC70jPHPisd1w70qmpmOfVbHfhqJErhoFwVFM8IpbTv4MKkk_BIpQw==@protonmail.internalid>
	<CAJ-ks9mNidHZvWkFJE1jExc2oVk_bbJpiO_DRMrWu5nYhTpKgg@mail.gmail.com>
	<87ldtzhexi.fsf@kernel.org> <87cyfbe89x.fsf@kernel.org>
	<SGJdAUqcAKv4KQX4f0wlLJtusvoK2zk7V_R6njD97VbfqqpS7ppRcIpCtSOtKbkDBNecXiJlQS9NcsuILxNCfA==@protonmail.internalid>
	<CAJ-ks9kLZ7LCTW+W4jhUqmF1ypJ7i56oSizdFV-1Ks5DiCoKsA@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Sat, 22 Feb 2025 19:25:51 +0100
Message-ID: <87bjutdefk.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Tamir Duberstein" <tamird@gmail.com> writes:

> On Fri, Feb 21, 2025 at 8:29=E2=80=AFAM Andreas Hindborg <a.hindborg@kern=
el.org> wrote:
>>
>> Andreas Hindborg <a.hindborg@kernel.org> writes:
>>
>> > "Tamir Duberstein" <tamird@gmail.com> writes:
>> >
>> >> On Thu, Feb 20, 2025 at 4:19=E2=80=AFPM Andreas Hindborg <a.hindborg@=
kernel.org> wrote:
>> >>>
>> >>> "Tamir Duberstein" <tamird@gmail.com> writes:
>> >>>
>> >>> > On Tue, Feb 18, 2025 at 8:29=E2=80=AFAM Andreas Hindborg <a.hindbo=
rg@kernel.org> wrote:
>>
>> [...]
>>
>> >>> >> +    /// Get a pointer to the contained `bindings::hrtimer`.
>> >>> >> +    ///
>> >>> >> +    /// # Safety
>> >>> >> +    ///
>> >>> >> +    /// `ptr` must point to a live allocation of at least the si=
ze of `Self`.
>> >>> >> +    unsafe fn raw_get(ptr: *const Self) -> *mut bindings::hrtime=
r {
>> >>> >> +        // SAFETY: The field projection to `timer` does not go o=
ut of bounds,
>> >>> >> +        // because the caller of this function promises that `pt=
r` points to an
>> >>> >> +        // allocation of at least the size of `Self`.
>> >>> >> +        unsafe { Opaque::raw_get(core::ptr::addr_of!((*ptr).time=
r)) }
>> >>> >> +    }
>> >>> >
>> >>> > Can you help me understand why the various functions here operate =
on
>> >>> > *const Self? I understand the need to obtain a C pointer to intera=
ct
>> >>> > with bindings, but I don't understand why we're dealing in raw
>> >>> > pointers to the abstraction rather than references.
>> >>>
>> >>> We cannot reference the `bindings::hrtimer` without wrapping it in
>> >>> `Opaque`. This would be the primary reason. At other times, we cannot
>> >>> produce references because we might not be able to prove that we sat=
isfy
>> >>> the safety requirements for turning a pointer into a reference. If we
>> >>> are just doing offset arithmetic anyway, we don't need a reference.
>> >>
>> >> Why do we have a pointer, rather than a reference, to Self in the
>> >> first place? I think this is the key thing I don't understand.
>> >
>> > Perhaps it makes more sense if you look at the context. One of the ent=
ry
>> > points to `HrTimer::raw_get` is via `<ArcHrTimerHandle as
>> > HrTimerHandle>::cancel`. This user facing method takes `&mut self`. The
>> > handle contains an arc to a type that contains a `Timer` and implements
>> > `HasHrTImer`. To get to the timer, we need to do pointer manipulation.
>> > We only know how to get the `Timer` field via the `OFFSET`. The natural
>> > return value from the offset operation is a raw pointer. Rather than
>> > convert back to a reference, we stay in pointer land when we call
>> > `HrTimer::raw_cancel`, because we need a pointer to the
>> > `bindings::hrtimer` anyway, not a reference.
>>
>> I changed `HasHrTimer::start` to take a reference, and I think that
>> makes sense =F0=9F=91=8D Taking an `impl AsRef` does not work out when `=
Self` is
>> `Pin<&T>`. I'll go over the whole thing and see of other places could
>> benefit.
>
> Can you elaborate please? Pin<&T>::get_ref returns &T, which gets you
> to the AsRef you need, no?

Right, that works. But if I pass in &self it's not really needed. You
can see for yourself in next version.

Hopefully I did not break any provenance rules.


Best regards,
Andreas Hindborg



