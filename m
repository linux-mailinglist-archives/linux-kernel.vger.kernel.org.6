Return-Path: <linux-kernel+bounces-267999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B5A941F2F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D800B2574F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA7E189BBB;
	Tue, 30 Jul 2024 18:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="mlCg+bct"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B744017D8BB
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 18:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722362796; cv=none; b=MBYquJ7D5Pc8q3xm5Int8D0M8NVU4m5nawNNKWdmoGxqARK8j0Vii6+qYMqukLMmOYnA6sz2cBTrArtXcDWIoTD4agW8GMO/Shoy4bFVHhE7svVqx0MN46slbU7D/YEmL0Kap17jFZvp+y5ltpQ5jpGtJu/AZik/jzOEZwgmncs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722362796; c=relaxed/simple;
	bh=IfON4uBqEKOf2xcMASP8BDONDtL4WQ0cJawE3iEfHRI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UYEkg7KPRCOSh3wSJ35grLL5uDY3neRBijQFNVNks5HpYjmAbfM3rmz72Mc+FxQfR2mQxbA3zqduaC/u0GblmyBOBptgBjB/H0RMZ+Es/y7K7lYs2YzaaBLmWCKI6DnXR2EJlCrF81OGRTcJ0Q49RZyh4zhQF6qFhTIOc09zLfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=mlCg+bct; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722362786; x=1722621986;
	bh=mP8pPR7V7GOEbvgnQ3Hkpe5+bVYgYFu8/oCcIpUDYGY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=mlCg+bctF5dxmG58f3kM8tbwGVBPxm9/xZlgY1XUEkCPSvWCKa6gjZLRI0b9MgHhx
	 dsBEMt7RtV1zCo+ks8HO/eQRN+YEct4mRYtxAgKsMMRfBCI11OJmtNYYnlyhZNm0Gh
	 ZTJuXEgFzojCNJk7rxTEXpCppQV/zyouyo6NZEsi7/bHrZDkiZT3ZWBhqSwdTdhDHB
	 mFyVBw/kP0Cud63CH4kE8ZS0MCXb3wbVmGO7km0kvGEjoXpXDV+nxn/YpXPtqcHlj2
	 JBp2FfuvS8GTjQ47+gNU1h70yWIs8PnAHp7c26kpxwaoHZoGNMK6ijMBxGC2sb0xN3
	 ktVuyabmio5eg==
Date: Tue, 30 Jul 2024 18:06:20 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: implement ForeignOwnable for Pin<Box<T>>
Message-ID: <6cfa426b-4ffe-41bc-9de5-ba7c7c70d610@proton.me>
In-Reply-To: <CAH5fLghN8L4cJsRuH-eqU4E5GaTJRUhw0cAStjHAj1RNJA-vhg@mail.gmail.com>
References: <20240730-foreign-ownable-pin-box-v1-1-b1d70cdae541@google.com> <5c49f604-34c1-414f-bf9a-92837c6e07b3@proton.me> <CAH5fLghN8L4cJsRuH-eqU4E5GaTJRUhw0cAStjHAj1RNJA-vhg@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 65c413bde632019c722f6d70d12b0831868560f6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30.07.24 19:50, Alice Ryhl wrote:
> On Tue, Jul 30, 2024 at 7:14=E2=80=AFPM Benno Lossin <benno.lossin@proton=
.me> wrote:
>>
>> On 30.07.24 15:06, Alice Ryhl wrote:
>>> @@ -89,6 +90,32 @@ unsafe fn from_foreign(ptr: *const core::ffi::c_void=
) -> Self {
>>>      }
>>>  }
>>>
>>> +impl<T: 'static> ForeignOwnable for Pin<Box<T>> {
>>> +    type Borrowed<'a> =3D Pin<&'a T>;
>>> +
>>> +    fn into_foreign(self) -> *const core::ffi::c_void {
>>> +        // SAFETY: We are still treating the box as pinned.
>>
>> I don't think that we have the guarantee that the pointee at the pointer
>> that is returned by `into_foreign` is not moved.
>=20
> That doesn't seem like the kind of thing we need a guarantee for.
> Rather, unless we give anyone a guarantee that dereferencing it is
> okay, it seems reasonable to assume that it won't be dereferenced.
> Right now, it's just an opaque pointer, so C really shouldn't be
> touching it. We already implement the trait for Arc which is also
> pinned and also doesn't even point at a value of type T.

Hmm, I don't have any rational concerns with this, but it doesn't _feel_
right...

When I replace the return type by `OpaquePtr(*const core::ffi::c_void)`
that is `repr(transparent)` I don't feel like this is a problem any
more.
So I guess your argument is fine.

I think it shouldn't hurt to add this to the docs, will send a patch for
that. Anyways,

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

>> AFAIU `ForeignOwnable` is used to store these pointers in C structures
>> and never to actually access the value behind the returned pointer. So
>> we could add the requirement to `into_foreign` (thus making it `unsafe`)
>> that the pointer should not be dereferenced/used aside from `borrow` and
>> `from_foreign`. Otherwise I don't see how the call below can be OK.
>> What do you think?
>=20
> Dereferencing the void pointer is unsafe in itself, so I don't see why
> `into_foreign` has to be unsafe too.

Oh yes, you are right.

---
Cheers,
Benno


