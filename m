Return-Path: <linux-kernel+bounces-273539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C7F946A60
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 17:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1BAE281D74
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 15:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E7D4964E;
	Sat,  3 Aug 2024 15:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="QkHTUNQE"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C0220EB
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 15:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722699136; cv=none; b=mxAq1Ef9ARkCBiokYsBxcTqGYDYUnK5V5kdCxLnHryP2+qmxoRp097+6vLmIFpIwtf7MXca/QjaIv/xVuEBp28FcdCw6BsbkFIs4rkU8R0XvkjjqnPiex1O8wQ6iDda5oMVavTvxAUrT5imnsrKARNPsrKdsB4onfA2oQzaXFF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722699136; c=relaxed/simple;
	bh=kvRdR/26rwhLE20T0zAexdvxtaI6oG8+wf/y1lZS0Bo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eRQmMDNcaCLJZCHCb1cztoTJa/ZOqo0NEtKAcuOZe9Q3rFDss/2cwiYDR2QZWgje1dC3I0F/n+lkkASefNpN9D6UeKr/fcD33TgAaTJ8MqnMEIHuP5BSMdSajv2CBym7aOC1ddvkHGi0jeK1yEjqg1wkMhyct3Kb2HQBUhyXCf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=QkHTUNQE; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722699131; x=1722958331;
	bh=AeJI2mhbDMG9r6SMmS8ccSTcOy7Nh+NZq8w/QpDLJgc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=QkHTUNQEf4A+H2nqLjGLKi+hH0vypGTJdN8HVvSyf67Ha2nqWJ6fGVxDJ+WD/guBY
	 xWd1ps7MOMA0TlY/LeGObBK1d8WTPzOSyCPsUvyOrE5yuqpBGszFxKD/09fwG/HbQx
	 UuQLDn0o23UegTR+UobqdxlaWEFlcorqM3HPGvuUJRl2aYP6/41VwuN2CLjHNePe/K
	 M5f4qWyoE3sLn596w8Tt/HoLWK1tZXU6PJC0SG9Rtud5ivNIvhMq/5snn1V/A39uun
	 hO+Rgb0BKXKRkAVuZzJFODvyZrp/qRNvwLS93kwqahdylnQUglA5a+BjYsGCFMKu7H
	 CPWFPPPICH1Zw==
Date: Sat, 03 Aug 2024 15:32:06 +0000
To: Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] rust: kernel: add `drop_contents` to `BoxExt`
Message-ID: <7a145166-cfe0-48b0-994b-6c6a4ff6744b@proton.me>
In-Reply-To: <Zq5Io6tKgczUYcf3@boqun-archlinux>
References: <20240803141639.3237686-1-benno.lossin@proton.me> <241c994e-28fb-448c-aa4f-b96154988bf6@proton.me> <Zq5Io6tKgczUYcf3@boqun-archlinux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 27383144ed380a104bff8bb95cf884f8022cfbfd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03.08.24 17:11, Boqun Feng wrote:
> On Sat, Aug 03, 2024 at 02:23:42PM +0000, Benno Lossin wrote:
>> On 03.08.24 16:16, Benno Lossin wrote:
>>> @@ -53,4 +69,12 @@ fn new_uninit(flags: Flags) -> Result<Box<MaybeUnini=
t<T>>, AllocError> {
>>>          // zero-sized types, we use `NonNull::dangling`.
>>>          Ok(unsafe { Box::from_raw(ptr) })
>>>      }
>>> +
>>> +    fn drop_contents(this: Self) -> Box<MaybeUninit<T>> {
>>> +        let ptr =3D Box::into_raw(this);
>>> +        // SAFETY: `ptr` is valid, because it came from `Box::into_raw=
`.
>>> +        unsafe { ptr::drop_in_place(ptr) };
>>> +        // SAFETY: `ptr` is valid, because it came from `Box::into_raw=
`.
>>
>> I just noticed that I missed another comment from Boqun here. Got
>> confused with the two mails. I would replace the comment above with
>>
>>     // CAST: `T` and `MaybeUninit<T>` have the same layout.
>>     let ptr =3D ptr.cast::<MaybeUninit<T>>();
>>     // SAFETY: `ptr` is valid for writes, because it came from `Box::int=
o_raw` and it is valid for
>>     // reads, since the pointer came from `Box::into_raw` and the type i=
s `MaybeUninit<T>`.
>>
>> Let me know if you want another version.
>=20
> Looks good to me, please do send an updated version.
>=20
> Although, I would expect the "CAST" comment already explains that if
> `ptr` is a valid, then the casting result is also valid, i.e. we put
> "CAST" comments on the casting that matters to safety. But that seems
> not matching what you use CAST for?

Well the pointer is no longer valid for reads, since the value has been
dropped. Only through the cast, it becomes again read-valid.

CAST comments must justify why the layouts are the same. On that note,
this comment might be better:

    // CAST: `MaybeUninit<T>` is a transparent wrapper of `T`.

---
Cheers,
Benno


