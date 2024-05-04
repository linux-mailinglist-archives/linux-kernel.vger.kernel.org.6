Return-Path: <linux-kernel+bounces-168735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2708BBCE2
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 17:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F521C20EF4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 15:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF454CB55;
	Sat,  4 May 2024 15:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="US+DjQxE"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EC4225D0;
	Sat,  4 May 2024 15:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714837861; cv=none; b=YLh9LflR3Y6gAsrSTC1+lYZcVm1isfVdrX+lTDN8fxS5ESf6jCw4tDTVwPbfkHZ62zEban8Iiqk8l4zUBMjQtRPfvu3GpznJHdqr4Kiy38NfzlcwsGHoVoNy0bEmrB4r9B7Pj7D3oCWVOYyOlrn2iCr7EwFySTdjB6wC+iZZtCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714837861; c=relaxed/simple;
	bh=8Y5j+hHY5H5LYn2tND6jFGfaH8F4/fR8Qtsmq+cOp/A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fobw+QDH3MVDeOO3Qhtdqykc5OcU5yXH6Mn/ur8qb3+hGtCRbXEJ8SF5SSm5M0DPDQdWhWQjiD4dlsbOIzds7xSLIWvQGOg+/iASyEpZd/B3UZGYJQW1pVOUjwwEA9m/TpN2CSDkEEXCFJT5KxMTT4MO+OBVpskkZdwgqccYino=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=US+DjQxE; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1714837856; x=1715097056;
	bh=yDG0Dga8SN4IPSIg58hp6EWOUt/e8hhjmCWy38atFF0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=US+DjQxEAntVV0nXuFezrp71IoYp+ILzZOPBboCUyQ/P7cwQgUqX5lms+XVzHjyrC
	 Wo4WTY66spY6a6ftoNLM8YOrrJNA4L2yW/QRFx2WhIwY2RmGglrtZayAvsEdNC+Nrk
	 ci98hu+rbBHjuskMs8EDZ57aaN8PtaTNoxcDdeomNWsu9AF0VgaJpm4AaF/InwkPNf
	 Kp6Vp2b7L8ahF6ilBMWWvIrRpVG0GpcAhqQxBKmD8jCj96quZTzlSIu4lb0HkfwVn0
	 UPJSnM+IH5GVCvjjkyHVhDgE2TQ+wXtE8pdkYynnJeryy0xYE8+bsGB7SJzzlju5Nh
	 nkyX53feZA78Q==
Date: Sat, 04 May 2024 15:50:51 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Kees Cook <keescook@chromium.org>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 1/9] rust: list: add ListArc
Message-ID: <ec5ae5ba-85eb-4dad-af4b-bd85fa189043@proton.me>
In-Reply-To: <CAH5fLgj49zs2=O-e3h=VqkRDDzhozvV6p=-5AKN_Q9-caT++cQ@mail.gmail.com>
References: <20240402-linked-list-v1-0-b1c59ba7ae3b@google.com> <20240402-linked-list-v1-1-b1c59ba7ae3b@google.com> <2f25f21e-fad8-48bb-aa2b-d61bf8909a41@proton.me> <CAH5fLgjqyfExjckh7KnSLnT+Ok+yjcoJ+DpDkj0gUZRmoz=M8Q@mail.gmail.com> <CAH5fLgj49zs2=O-e3h=VqkRDDzhozvV6p=-5AKN_Q9-caT++cQ@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: dd5e738b4551f3eb7829e604d9e22de8d31b309c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03.05.24 16:36, Alice Ryhl wrote:
> On Thu, Apr 4, 2024 at 4:00=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> =
wrote:
>>
>> On Wed, Apr 3, 2024 at 5:51=E2=80=AFPM Benno Lossin <benno.lossin@proton=
me> wrote:
>>>
>>> On 02.04.24 14:16, Alice Ryhl wrote:
>>>> +impl<T: ListArcSafe<ID>, const ID: u64> ListArc<T, ID> {
>>>> +    /// Constructs a new reference counted instance of `T`.
>>>> +    pub fn try_new(contents: T) -> Result<Self, AllocError> {
>>>> +        Ok(Self::from_unique(UniqueArc::try_new(contents)?))
>>>> +    }
>>>> +
>>>> +    /// Use the given initializer to in-place initialize a `T`.
>>>> +    ///
>>>> +    /// If `T: !Unpin` it will not be able to move afterwards.
>>>> +    pub fn pin_init<E>(init: impl PinInit<T, E>) -> error::Result<Sel=
f>
>>>> +    where
>>>> +        Error: From<E>,
>>>> +    {
>>>> +        Ok(Self::from_pin_unique(UniqueArc::pin_init(init)?))
>>>> +    }
>>>
>>> pin-init has a general trait for this: InPlaceInit. I don't know if the
>>> other functions that it provides would help you.
>>
>> I will use that.
>=20
> Turns out it's not possible to use the trait in this case, for the
> same reasons as why Arc isn't using them either.

Ugh that is annoying, I think we can change `InPlaceInit` to have a
`PinnedSelf` associated type. I will create a good-first-issue.

--=20
Cheers,
Benno


