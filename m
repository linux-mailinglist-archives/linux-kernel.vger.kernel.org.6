Return-Path: <linux-kernel+bounces-360135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A9399950C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 00:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDCCC284E25
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 22:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D928F1E573C;
	Thu, 10 Oct 2024 22:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="VeJQGZ+G"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89DD1E32C5;
	Thu, 10 Oct 2024 22:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728598910; cv=none; b=PUNgcEZgl/ACDhCOLZcAeq4aEzydyjCcemSEftLNZCEoutj8go8utBRL8Ys3d/BmkgM7HEZLGwKLCw0rkIFL/uLR43TYLCnWa3zYpz+2H7nljmVm66WJjTHSGTHwNCblBSc/l6cxePfPlLVmWtub5tTn5PQU3pz1cVrMXtYpO5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728598910; c=relaxed/simple;
	bh=1oz99yS4RcrK4IXNqU16/mIzAMENLRg4ngdxPPKm4sU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ne5dHC86hOQnjl92Z/f2Xt7QTOKiI1gRgE4zkylGvlnR9sun34CyANoEvcmHDac3SdDjFzYQWjDECFQDJfC8tb6KaIHtm4JLfbipKWeWeVE/YfryyxbhbJn1WdRr9RMAGsPZDZXAQ6QG8QxLzauLp2nKYtCPlFL3chZ9cuTVPgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=VeJQGZ+G; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1728598906; x=1728858106;
	bh=rp/P/5HH2+ZaFWkr9AvBU2PKX4NqLTmJGAGtg0jpa3k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=VeJQGZ+G2gcOOra5KFYtPTDrP5sV1oiJa/Gv1N1IZ6BfrarIirGOakgulpfhMZ2Ch
	 /gAkFhhZ+85PO9V/rB8zBmCZfcpA4zGWAlKB2psDOX9I8EN0ljJNCCMTZpDFxL1z0q
	 CbxhblZGh6/Utk/iNqqOmb4J1ZEuqedA5ptwPLqVJxxQ6u9UmrfgRrc71U6XuX3reP
	 vDfoTTnp/namp71vwC2dd/0z2oO9Ig8YP+pn4pQIP4pQrNbH6I6zUFZ1qeqGHuKhkW
	 wxxUaNhPKTnexo75hDD+KxFF2clg+Acm4k2jPv81KWQdcN0OOoFRf4oo4rRS0Wx9Mp
	 Te2aSTm1dtmBA==
Date: Thu, 10 Oct 2024 22:21:41 +0000
To: Boqun Feng <boqun.feng@gmail.com>, Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v4] rust: add global lock support
Message-ID: <3e7832f7-8806-41e0-8e36-6f178df2eaef@proton.me>
In-Reply-To: <ZwgB39dXLdFWQkHz@boqun-archlinux>
References: <20240930-static-mutex-v4-1-c59555413127@google.com> <1f688070-66bd-450b-ba5d-b929de64ecf0@proton.me> <CAH5fLghsozD0qeTygBM0-WDgXRwtGcsc6B3bT1794QMx3=vSTg@mail.gmail.com> <Zwfcwg23tfrKIyrq@boqun-archlinux> <CAH5fLgjhTWjmYqxcTRRv6FTpv7Vg9nnVCGGWbSKPqOSjJ5XyQA@mail.gmail.com> <ZwfkzKz5mz6UvZfK@boqun-archlinux> <ZwgB39dXLdFWQkHz@boqun-archlinux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: ee1ea3d47b7bb8278ecd414affae5dc91a2fd1fd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10.10.24 18:33, Boqun Feng wrote:
> On Thu, Oct 10, 2024 at 07:29:32AM -0700, Boqun Feng wrote:
>> On Thu, Oct 10, 2024 at 03:58:07PM +0200, Alice Ryhl wrote:
>>> On Thu, Oct 10, 2024 at 3:55=E2=80=AFPM Boqun Feng <boqun.feng@gmail.co=
m> wrote:
>>>>
>>>> On Thu, Oct 10, 2024 at 12:53:00PM +0200, Alice Ryhl wrote:
>>>> [...]
>>>>>>> +#[macro_export]
>>>>>>> +macro_rules! global_lock {
>>>>>>> +    {
>>>>>>> +        $(#[$meta:meta])* $pub:vis static $name:ident: $kind:ident=
<$valuety:ty> =3D unsafe { uninit };
>>>>>>> +        value: $value:expr;
>>>>>>
>>>>>> I would find it more natural to use `=3D` instead of `:` here, since=
 then
>>>>>> it would read as a normal statement with the semicolon at the end.
>>>>>> Another alternative would be to use `,` instead of `;`, but that doe=
sn't
>>>>>> work nicely with the static keyword above (although you could make t=
he
>>>>>> user write it in another {}, but that also isn't ideal...).
>>>>>>
>>>>>> Using `=3D` instead of `:` makes my editor put the correct amount of
>>>>>> indentation there, `:` adds a lot of extra spaces.
>>>>>
>>>>> That seems sensible.
>>>>>
>>>>
>>>> While we are at it, how about we make the syntax:
>>>>
>>>>         global_lock!{
>>>>             static MY_LOCK: Mutex<u32> =3D unsafe { 0 };
>>>>         }
>>>>
>>>> or
>>>>
>>>>         global_lock!{
>>>>             static MY_LOCK: Mutex<u32> =3D unsafe { uninit { 0 } };
>>>>         }
>>>>
>>>> ?
>>>>
>>>> i.e. instead of a "value" field, we put it in the "initialization
>>>> expression". To me, this make it more clear that "value" is the
>>>> initialized value protected by the lock. Thoughts?
>>>
>>> `uninit { 0 }` looks pretty terrible IMO. Can we come up with something=
 better?
>>>
>>
>=20
> how about:
>=20
>         global_lock!{
>             static MY_LOCK: Mutex<u32> =3D unsafe { data: 0 };

I dislike this, since there is no `uninit` anywhere, but the mutex needs
to be initialized.

>         }
>=20
> ?
>=20
> "data: " will make it clear that the value is not for the lock state.
> "uninit" is dropped because the "unsafe" already requires the global
> variable to be initialised first. Or "unsafe { uninit, data: 0 }" if you
> want to keep the "uninit" part?

That also looks weird to me...

But I haven't come up with a good alternative

---
Cheers,
Benno


