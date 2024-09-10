Return-Path: <linux-kernel+bounces-322529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C596E972A51
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F53628625B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E17A17BEC5;
	Tue, 10 Sep 2024 07:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="FVmCFbzn"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DFE12B143;
	Tue, 10 Sep 2024 07:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725952256; cv=none; b=Qjk6CjMvgjcbheHq287DoPVHWerCOj0tt1s7sVuySwypRj+t8XmgRKB1AdeqSy9YgKGcRM4OLiwd8l1AGABmOWUAljlJ5IuoIQt0e4h5aaUv2wJhHmI11xBJH1kvhLpSEtB6EsRqm+bdAQ6VhG0QselfSELwQpNngzh94KjEKDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725952256; c=relaxed/simple;
	bh=Lj5Sd8urnV5cGR8bCaMgOHsQZWxqX/08qozA/Wp5OfI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WQhxYVkP/KEktgH6xXIW44FnespZ5zSspwAdHjrBHqSeBuLRJ0udo7EeJrLJwCF/Jk83/JqCsWzjbwE3AdXIY5lVlg+VpHeBxwwQX9FQY9kiikztf4BV9bJbmVFrauKdNo/EddkV4juy2x+Vorir9m83KWRhtO6yAd0f0Uc7lVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=FVmCFbzn; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1725952252; x=1726211452;
	bh=Tvk63EWKIJfcsR9nu+1LRzzHViUVxsD4efOy36kxKd8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=FVmCFbznzGpr7Y6VsJ4XEHMtK7KafwMwU22GdtiSxiZ4xKfo1GYPqBf7guIqQjSlz
	 xLHzc7RKrhS+WUba9zRPpdcmrK97rz1/ka0pYkCASavn5fW30E5+erV1y9TPR28u3T
	 3esTtHcVseRda3Jgu0knzSkXDCRMkXKldCfIiBl1v23+DEws5w/y9Go7B/th19VQ/A
	 GcrkMOrjsj0AT1mp8r5rxRwZZUFFzwAWdGIFw2MZgLWp0WH8hb7VpwqDbSSwSxWHmc
	 tlaGoKlbXkBcRzYuDQ8Y8j+Kl8nn7l585Q6wawIwjvwInpLtubSFVpd79Q+/zy00zt
	 0Ot/1lDksIY9w==
Date: Tue, 10 Sep 2024 07:10:46 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: add global lock support
Message-ID: <3c471d06-d8c4-47a2-b29b-4faa5d61d25d@proton.me>
In-Reply-To: <CAH5fLgh9kHm4XbcH2X4y6nwZ9VLYuUeu3hNmQBcdZ+Vx1H1L9w@mail.gmail.com>
References: <20240827-static-mutex-v2-1-17fc32b20332@google.com> <10453342-d269-4b78-8962-821ef53d3cb5@proton.me> <CAH5fLgh-DYvXobXQVaQ9txYS4Rx8QhjyVvfTphk6vvnUOGzPnw@mail.gmail.com> <3b557f61-cead-4568-b2b4-4a56c4cbff52@proton.me> <CAH5fLggE-fWDuZXH_F3ixDSo7sQEFwnUV3cd+9_rpFH+XmnA2Q@mail.gmail.com> <CAH5fLgiZt3uVZiU1xXPcvYNR-Em2V3y+-C9EbsqrNvkScbiAYA@mail.gmail.com> <0030a292-49f4-4575-846f-424b098c7f1a@proton.me> <CAH5fLgh9kHm4XbcH2X4y6nwZ9VLYuUeu3hNmQBcdZ+Vx1H1L9w@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: fff6e56f1003443a7083231ea76ea55439635c5b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04.09.24 12:32, Alice Ryhl wrote:
> On Tue, Sep 3, 2024 at 12:17=E2=80=AFAM Benno Lossin <benno.lossin@proton=
.me> wrote:
>>
>> On 02.09.24 13:42, Alice Ryhl wrote:
>>> On Mon, Sep 2, 2024 at 1:37=E2=80=AFPM Alice Ryhl <aliceryhl@google.com=
> wrote:
>>>>
>>>> On Fri, Aug 30, 2024 at 3:22=E2=80=AFPM Benno Lossin <benno.lossin@pro=
ton.me> wrote:
>>>>>
>>>>> On 30.08.24 07:34, Alice Ryhl wrote:
>>>>>> On Thu, Aug 29, 2024 at 8:17=E2=80=AFPM Benno Lossin <benno.lossin@p=
roton.me> wrote:
>>>>>>>
>>>>>>> On 27.08.24 10:41, Alice Ryhl wrote:
>>>>>>>> For architectures that don't use all-zeros for the unlocked case, =
we
>>>>>>>> will most likely have to hard-code the correct representation on t=
he
>>>>>>>> Rust side.
>>>>>>>
>>>>>>> You mean in `unsafe_const_init`?
>>>>>>
>>>>>> No, I mean we would have `unsafe_const_new` directly set `state` to
>>>>>> the right value and let `unsafe_const_init` be a no-op.
>>>>>
>>>>> But how do you set the right value of a list_head? The value will be
>>>>> moved.
>>>>
>>>> Right ... we probably can't get around needing a macro. Can statics
>>>> even reference themselves?
>>>
>>> Looks like they can:
>>>
>>> use std::ptr::addr_of;
>>>
>>> struct MyStruct {
>>>     ptr: *const MyStruct,
>>> }
>>>
>>> static mut MY_STRUCT: MyStruct =3D MyStruct {
>>>     ptr: addr_of!(MY_STRUCT),
>>> };
>>
>> That's useful to know...
>> But I don't see a way to get pinned-init to work with this. I would need
>> a lot of currently experimental features (const closures, const traits)
>> and a way to initialize a static without providing a direct value, since
>> I can't just do
>>
>>     static mut MY_STRUCT: MyStruct =3D {
>>         unsafe { __pinned_init(addr_of_mut!(MY_STRUCT), /* initializer *=
/) };
>>         unsafe { addr_of!(MY_STRUCT).read() }
>>     };
>>
>> It (rightfully) complains that I am initializing the static with itself.
>>
>> We /might/ be able to do something special for `Mutex`/ other locks, but
>> I haven't tried yet. So the unsafe approach seems the best at the moment=
.
>=20
> It sounds like we'll just want a macro that generates a global wrapped
> in a Mutex/SpinLock for now ...

Yeah.

> If we're going to do that, we could take the extra step and have it
> generate special Guard and LockedBy types so that you can have a
> LockedBy that doesn't need to make any runtime checks.

Oh that is a good idea!

---
Cheers,
Benno


