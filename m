Return-Path: <linux-kernel+bounces-311923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AFE968F7C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 00:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F091F235D1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 22:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D52187345;
	Mon,  2 Sep 2024 22:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="KQU1n7pW"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5AE1A4E8A
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 22:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725315422; cv=none; b=MT4alc4h+uV6f26oNtvFvnHcMfomW6BtSJABsTr3v+TQFDhbtAlXq2EQo/lT/TPU0G3BOqQWBxcJk8KsB075DH7Ynyj1r0Iw0vjpapx80DMNRIS9sCqFr2nVDkiEf35iI5Vj1XGzr/uv1JVVX/Lu8ws5XGJLEx6Ho19Pa9Iamac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725315422; c=relaxed/simple;
	bh=GoZUV7MbGKxynSZJAs4RLzAgBLkhjJMLw+Qx0MG8NqU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KXZuYFIARysZt0Zo9mDz6lJSZJYA0B0+YiZ/BZXRaAxhRxyYM34sprmtStqCL1qD5j8Z1Jc5gGQokG9SceWtN/nCiwJfklNCFs2mCcqRZ1Kalwgg1h/E9UEWcEJYdyWToWWOZi3OvKu03DtaeGxlvgIgQjcBFagVflI4/P1gZb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=KQU1n7pW; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=kg5d4ngctfdqleapdipdatsrty.protonmail; t=1725315418; x=1725574618;
	bh=rkU7GkFKBBZdLeXW1ZCyj0xGWBwOQjsIL44iRqw36m8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=KQU1n7pWn/R1Cps4tWhCR51wQB9JR6VDb3HKRiHGhJm+1JrpuuVj8Ml45xx05FKTM
	 4xNFDpPn8+52PbOMpEpCqT0WdS2wNA/XxQ9D6q52bmCbcjfp7NWWWFLGMjot/tViM5
	 0Ndt/Pko7g9NcG/nytB0OPWbguNutmw/sr7ibhCnCv59sTy8Hal70RDVXywa6WdC6R
	 Vb9J1XXgy0fkkK2rtVpaog6EhpO3xnCXx/8jxQa2uNsoLwe9vu5TpycdOpmkEZSwdu
	 fjkqMUm51FtMeX7CIdK5GY3HEY+zcWV5VBdL2eqdMiinOps9PSKUzQDmrOf+hx3apS
	 pWfCCatUgL08Q==
Date: Mon, 02 Sep 2024 22:16:53 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: add global lock support
Message-ID: <0030a292-49f4-4575-846f-424b098c7f1a@proton.me>
In-Reply-To: <CAH5fLgiZt3uVZiU1xXPcvYNR-Em2V3y+-C9EbsqrNvkScbiAYA@mail.gmail.com>
References: <20240827-static-mutex-v2-1-17fc32b20332@google.com> <10453342-d269-4b78-8962-821ef53d3cb5@proton.me> <CAH5fLgh-DYvXobXQVaQ9txYS4Rx8QhjyVvfTphk6vvnUOGzPnw@mail.gmail.com> <3b557f61-cead-4568-b2b4-4a56c4cbff52@proton.me> <CAH5fLggE-fWDuZXH_F3ixDSo7sQEFwnUV3cd+9_rpFH+XmnA2Q@mail.gmail.com> <CAH5fLgiZt3uVZiU1xXPcvYNR-Em2V3y+-C9EbsqrNvkScbiAYA@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 46805cf17ac8bb15ea0c3908e21dc9e2229b3150
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02.09.24 13:42, Alice Ryhl wrote:
> On Mon, Sep 2, 2024 at 1:37=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> =
wrote:
>>
>> On Fri, Aug 30, 2024 at 3:22=E2=80=AFPM Benno Lossin <benno.lossin@proto=
n.me> wrote:
>>>
>>> On 30.08.24 07:34, Alice Ryhl wrote:
>>>> On Thu, Aug 29, 2024 at 8:17=E2=80=AFPM Benno Lossin <benno.lossin@pro=
ton.me> wrote:
>>>>>
>>>>> On 27.08.24 10:41, Alice Ryhl wrote:
>>>>>> For architectures that don't use all-zeros for the unlocked case, we
>>>>>> will most likely have to hard-code the correct representation on the
>>>>>> Rust side.
>>>>>
>>>>> You mean in `unsafe_const_init`?
>>>>
>>>> No, I mean we would have `unsafe_const_new` directly set `state` to
>>>> the right value and let `unsafe_const_init` be a no-op.
>>>
>>> But how do you set the right value of a list_head? The value will be
>>> moved.
>>
>> Right ... we probably can't get around needing a macro. Can statics
>> even reference themselves?
>=20
> Looks like they can:
>=20
> use std::ptr::addr_of;
>=20
> struct MyStruct {
>     ptr: *const MyStruct,
> }
>=20
> static mut MY_STRUCT: MyStruct =3D MyStruct {
>     ptr: addr_of!(MY_STRUCT),
> };

That's useful to know...
But I don't see a way to get pinned-init to work with this. I would need
a lot of currently experimental features (const closures, const traits)
and a way to initialize a static without providing a direct value, since
I can't just do

    static mut MY_STRUCT: MyStruct =3D {
        unsafe { __pinned_init(addr_of_mut!(MY_STRUCT), /* initializer */) =
};
        unsafe { addr_of!(MY_STRUCT).read() }
    };

It (rightfully) complains that I am initializing the static with itself.

We /might/ be able to do something special for `Mutex`/ other locks, but
I haven't tried yet. So the unsafe approach seems the best at the moment.

---
Cheers,
Benno


