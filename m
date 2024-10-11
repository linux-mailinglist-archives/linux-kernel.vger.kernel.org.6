Return-Path: <linux-kernel+bounces-360621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2091999D56
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2E2A1C22900
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719F4BA2D;
	Fri, 11 Oct 2024 07:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="cT38qK70"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5443D1C1756;
	Fri, 11 Oct 2024 07:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728630082; cv=none; b=X06v83h19vR1b65XTUU8cDxMvlOmJs0jmzyYitqx0QFsKizSdUFpsBEaWRqzMFf8egIMUMrv4MxEc+L2OXlUqEFSn9WIYfN/+5hZlaQTyIpFKQZYRkCFOq1hjowUAsnduODfzntAGkREio4tA1yjg6ByUJimRepvfh77INO2Dlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728630082; c=relaxed/simple;
	bh=HCqZwzAk09GT5UPDqNEaN0FyisnY3+WGNoIb8DZaB9U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tk37o7oz64gB2XNN3K/GzW6BWf3wDw90yANL1uXaSZmh457Wlcf72ljuRSZaiYw1X0ecclr4RcfqENVM4PdUcA7JnmXXiaIguZgdZhNXsWKU8C/3LEwFTxxfbnO/XtBlKb/Ec083ENEnHmoTddY/OyU8hgSKGhO2AOoIAIboFSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=cT38qK70; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1728630071; x=1728889271;
	bh=vENrMvJyxPneGl6xdvV28EbXdQvt6S5P8ra/4eY8Dkg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=cT38qK70Oo/HnUyJr1t3ELZWncTzUG2eR84HdG/MXrEPbHSldX6flKrURiInI+j+2
	 0h704oXdyta3hkOGWl2BJj9gWk7JUycU8F8WN+bx1hnyEKlimvOZPRaZ4XkgDhYe2e
	 vzUrzafAzg+Abw96p5r9cu+RIeTiu8QIJmEZVCy+pgPVAG/9O9wL6KfLH5JnwOfGBF
	 De6ok9XDZw8OQRf7kvnus8vWwueZAb9bIhn2zNuY3QsRyHvfFT3m7lFajDaprdGBrA
	 KgwFGH8LyV852lg0Sj5YddmqYQUOI8WsVt/FF/FDNkLyY8DYiV/cHIf31gFCYWOlJl
	 uJcbgi84XzDmQ==
Date: Fri, 11 Oct 2024 07:01:09 +0000
To: Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v4] rust: add global lock support
Message-ID: <b91dd35f-78be-4848-a4cf-b82914e742ad@proton.me>
In-Reply-To: <Zwhd-Eu_1oB9CIYd@boqun-archlinux>
References: <20240930-static-mutex-v4-1-c59555413127@google.com> <1f688070-66bd-450b-ba5d-b929de64ecf0@proton.me> <CAH5fLghsozD0qeTygBM0-WDgXRwtGcsc6B3bT1794QMx3=vSTg@mail.gmail.com> <Zwfcwg23tfrKIyrq@boqun-archlinux> <CAH5fLgjhTWjmYqxcTRRv6FTpv7Vg9nnVCGGWbSKPqOSjJ5XyQA@mail.gmail.com> <ZwfkzKz5mz6UvZfK@boqun-archlinux> <ZwgB39dXLdFWQkHz@boqun-archlinux> <3e7832f7-8806-41e0-8e36-6f178df2eaef@proton.me> <Zwhd-Eu_1oB9CIYd@boqun-archlinux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: dcef549524a6e89979755868095c49ddb29c2bcc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11.10.24 01:06, Boqun Feng wrote:
> On Thu, Oct 10, 2024 at 10:21:41PM +0000, Benno Lossin wrote:
>> On 10.10.24 18:33, Boqun Feng wrote:
>>> On Thu, Oct 10, 2024 at 07:29:32AM -0700, Boqun Feng wrote:
>>>> On Thu, Oct 10, 2024 at 03:58:07PM +0200, Alice Ryhl wrote:
>>>>> On Thu, Oct 10, 2024 at 3:55=E2=80=AFPM Boqun Feng <boqun.feng@gmail.=
com> wrote:
>>>>>>
>>>>>> On Thu, Oct 10, 2024 at 12:53:00PM +0200, Alice Ryhl wrote:
>>>>>> [...]
>>>>>>>>> +#[macro_export]
>>>>>>>>> +macro_rules! global_lock {
>>>>>>>>> +    {
>>>>>>>>> +        $(#[$meta:meta])* $pub:vis static $name:ident: $kind:ide=
nt<$valuety:ty> =3D unsafe { uninit };
>>>>>>>>> +        value: $value:expr;
>>>>>>>>
>>>>>>>> I would find it more natural to use `=3D` instead of `:` here, sin=
ce then
>>>>>>>> it would read as a normal statement with the semicolon at the end.
>>>>>>>> Another alternative would be to use `,` instead of `;`, but that d=
oesn't
>>>>>>>> work nicely with the static keyword above (although you could make=
 the
>>>>>>>> user write it in another {}, but that also isn't ideal...).
>>>>>>>>
>>>>>>>> Using `=3D` instead of `:` makes my editor put the correct amount =
of
>>>>>>>> indentation there, `:` adds a lot of extra spaces.
>>>>>>>
>>>>>>> That seems sensible.
>>>>>>>
>>>>>>
>>>>>> While we are at it, how about we make the syntax:
>>>>>>
>>>>>>         global_lock!{
>>>>>>             static MY_LOCK: Mutex<u32> =3D unsafe { 0 };
>>>>>>         }
>>>>>>
>>>>>> or
>>>>>>
>>>>>>         global_lock!{
>>>>>>             static MY_LOCK: Mutex<u32> =3D unsafe { uninit { 0 } };
>>>>>>         }
>>>>>>
>>>>>> ?
>>>>>>
>>>>>> i.e. instead of a "value" field, we put it in the "initialization
>>>>>> expression". To me, this make it more clear that "value" is the
>>>>>> initialized value protected by the lock. Thoughts?
>>>>>
>>>>> `uninit { 0 }` looks pretty terrible IMO. Can we come up with somethi=
ng better?
>>>>>
>>>>
>>>
>>> how about:
>>>
>>>         global_lock!{
>>>             static MY_LOCK: Mutex<u32> =3D unsafe { data: 0 };
>>
>> I dislike this, since there is no `uninit` anywhere, but the mutex needs
>> to be initialized.
>>
>>>         }
>>>
>>> ?
>>>
>>> "data: " will make it clear that the value is not for the lock state.
>>> "uninit" is dropped because the "unsafe" already requires the global
>>> variable to be initialised first. Or "unsafe { uninit, data: 0 }" if yo=
u
>>> want to keep the "uninit" part?
>>
>> That also looks weird to me...
>>
>> But I haven't come up with a good alternative
>>
>=20
> How about a "fake" MaybyUninit:
>=20
> =09global_lock!{
>             static MY_LOCK: Mutex<u32> =3D unsafe { MaybeUninit::new(0).a=
ssume_init() };
> =09}
>=20
> ?

That still suggests to the user, that the contents are initialized.

> I feel like we need to put the data in the initialization expression
> because if we resolve the initialization issues and can skip the extra
> init step, we pretty much want to use the macro like:
>=20
> =09global_lock!{
>             static MY_LOCK: Mutex<u32> =3D { data: 0 };
> =09    // maybe even
>             // static MY_LOCK: Mutex<u32> =3D { 0 };
> =09}
>=20
> instead of
>=20
> =09global_lock!{
>             static MY_LOCK: Mutex<u32> =3D init;
> =09    value =3D 0;
> =09}
>=20
> , right?
>=20
> So we need to think about providing a smooth way for users to transfer.
> Not just adjust the changes (which I believe is a good practice for
> coccinelle), but also the conceptual model "oh now I don't need to
> provide a 'value=3D' field?".=20

I think we can just use a multiline regex to find `global_lock!` and
then change the current way. It shouldn't be that difficult to change.

> Hence even though the above proposals may look weird, but I think
> that's still better?

Do you think that we will have 1000s of users by the time we change it?
I don't think so, but I don't know how often drivers use global locks. I
think we should discourage them. People still can have a "global" lock
by putting it inside of their Module struct (they need access to the
module, but maybe we should have a function that gives them the module
for the `ThisModule` pointer?)

---
Cheers,
Benno


