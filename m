Return-Path: <linux-kernel+bounces-271106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A05EE9449A5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55BEF1F266A9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9801187FFE;
	Thu,  1 Aug 2024 10:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Ni9i99QM"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1862187FF4
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 10:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722509157; cv=none; b=oTG/bE1Sc5Bjf6eIQj3pba5MOeXirEfU/sx8OFWBIMEsUZXFqNxVeKIvrHi6DUN+I464+1+bStngv/XzCzXY36IsS0k7Fb2vGmfQA4P+OpkD9TkI/J4GZXkdQ62A/mUCp+EIcV/orhf0qnqcAPwHbghz6Ntqj1wP/bmvZUyBO7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722509157; c=relaxed/simple;
	bh=OJkyzqx3t2GYinRJNuHGE+/bKdbTJ2jz9M4I0r0WeJA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=egxpTTwNKQ5+/65slMDLxUxPTWb8SF2+7+bOlL79aY28yEtTWeKLht4e6ln4ZsuqUYRvC7nflwKLdEtQNBqC/Vxj1+7Sy4ylaccLBVJeF1XFF9WShDiX79svJB9dGEr8HnAaFFRgw96tXME+Ykisrmi4EauiCl+CtcM0DEpBl1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Ni9i99QM; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722509152; x=1722768352;
	bh=BhLH0JV4jQRV3Mkf3cPdmRoDQ862eb/6hIEDVcpjNRs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Ni9i99QMuHCnpBa/k4F7kX9pm1KT0JzyYWJNnUpV5GDJLkE1HMoek0a8w6Xzwj3Zm
	 SL8q2HJFUD4+HJ8rBoriTaG4CNjz46YoC4rXq0hSySbrsKLUqOPnFEF4AdVMcrxV9I
	 j1lC2Q1dGqpyuGpDR1w5lxR71vscA8xFVeJRKVos/NoZgd8ByryDBm12EAwTcD5btv
	 4LOi3iSvzBbKKWk26TQmKpHMQZemoLSuCpO0UG6roiFNEDeEcJch6oLf0G4akkQQbw
	 437uztPAPyjSrF2HyL1JWD5w01zAQgjiVIQOa8k9ho5a0Z2ENZJlGShGDeDXmIlP1U
	 Hp2+IpjeuQUmg==
Date: Thu, 01 Aug 2024 10:45:49 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 04/10] rust: list: add struct with prev/next pointers
Message-ID: <5b13793c-3ec8-40c2-b0c6-e7b10883d0cb@proton.me>
In-Reply-To: <CAH5fLggKphE3f=Jv+pfXc+_qjsGBVpXw_F4fOJiAi6vNtJ5x+Q@mail.gmail.com>
References: <20240723-linked-list-v3-0-89db92c7dbf4@google.com> <20240723-linked-list-v3-4-89db92c7dbf4@google.com> <1b2078d8-d93b-4626-a73f-edc5616a2357@proton.me> <CAH5fLggKphE3f=Jv+pfXc+_qjsGBVpXw_F4fOJiAi6vNtJ5x+Q@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: e842064c9be3211abfa42f4b108cfb15b7b56416
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.08.24 11:42, Alice Ryhl wrote:
> On Wed, Jul 31, 2024 at 8:41=E2=80=AFPM Benno Lossin <benno.lossin@proton=
.me> wrote:
>>
>> On 23.07.24 10:22, Alice Ryhl wrote:
>>> +/// The prev/next pointers for an item in a linked list.
>>> +///
>>> +/// # Invariants
>>> +///
>>> +/// The fields are null if and only if this item is not in a list.
>>> +#[repr(transparent)]
>>> +pub struct ListLinks<const ID: u64 =3D 0> {
>>> +    #[allow(dead_code)]
>>> +    inner: Opaque<ListLinksFields>,
>>
>> Do you really need `Opaque`? Or would `UnsafeCell` be enough? (If it is
>> enough and you change this, be aware that `Opaque` is `!Unpin`, so if
>> you intend for `ListLinks` to also be `!Unpin`, then you need a
>> `PhantomPinned`)
>=20
> I need the `!Unpin` part for aliasing.

Oh good point, do you mind adding a comment for that?

>>> +}
>>> +
>>> +// SAFETY: The next/prev fields of a ListLinks can be moved across thr=
ead boundaries.
>>
>> Why? This is not a justification.
>=20
> What would you say?

While trying to come up with a safety comment I thought about the
following: this impl does not depend on the type that is behind the
pointer (ie the type containing the `ListLinks`). Thus this `ListLinks`
will always implement `Send` even if the pointed-to value does not.
What we could do (and what definitely would be correct) is this:
`List` can only be used with `Send` types, then we could implement
`Send` for `ListLinks`. But I haven't actually come up with a problem,
so there might a more permissive solution.
Do you have a use-case where you need `!Send` types in a list?

Here is a part of my reasoning: If the pointed-to value is `!Send`, then
the `List` item type must also be `!Send`. Thus all list operations take
place on the same thread (since the `List` will be `!Send`). Therefore
nobody can access the `prev`/`next` pointers from another thread.

But this does not justify that `ListLinks` can be made `Send`. (although
there isn't actually a problem)

>>> +unsafe impl<const ID: u64> Send for ListLinks<ID> {}
>>> +// SAFETY: The type is opaque so immutable references to a ListLinks a=
re useless. Therefore, it's
>>> +// okay to have immutable access to a ListLinks from several threads a=
t once.
>>
>> You don't need to argue via `Opaque`, the type doesn't expose any
>> `&self` functions, so there are no functions to consider.
>=20
> I'm not arguing via the `Opaque` type. I'm just using "opaque" as a
> normal english word with its normal meaning.

Oh I see, then it's fine.

---
Cheers,
Benno


