Return-Path: <linux-kernel+bounces-263392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E4193D544
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47F721C22638
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39011CD39;
	Fri, 26 Jul 2024 14:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="IKzf9aZR"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC16517583;
	Fri, 26 Jul 2024 14:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722004967; cv=none; b=T9OE6/GvUZLGgSHaQFdUIFMB5wmsDQaREOozYZrtv2PlC9csfD9E+Ui4yT2B8dUsnBArC/ud9xqT+CEeQqVDs5vHyWwmMzRwKSuoPO6zPeaQQSt1LsnPUxo0nw1vT0t+3CtjYbdC8fCIsWg3psQjBRoPl5tcEk5auxtJXTx00Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722004967; c=relaxed/simple;
	bh=KmX35yzBqMS0v4e/eT5iIrqFxi5t5yRXghCZNnL/0nI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R9IU/GyvH3fSYoR4BNSPrewo2K484UjIOYKEF0JtX02GiLMca2HDrqAUtk9bx8iGPVeeG45ONxyRcQzm0vVE8uk/2B0//xRDDAFgbOmjKBTcMfKGIMDtjw0SiDR1MLrxcYucG9+mLANpaj6FFH5xeo5JVEb0A+cu6SjD0CkJCsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=IKzf9aZR; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722004962; x=1722264162;
	bh=qfPCyI7CmwBloWyyycsNCbxx2dM+kYGYgYSdvUIOX5I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=IKzf9aZRdisOebDvseLFeEbvej4xs3gWF9f7HhNG42I8hHpYowQYo24Zs348Qa+Io
	 6jrwSmvAcXvuISmG06ktEvUsPIC6Os/Jags6N3SglSHxEQy3n/g6aeYmW3Jer7jrUG
	 yFodyxikHFbCm5grsX6Xu9IFpK+D2lTyWyJMR9eSj3OM1gEjA6rzSg9lfrU2/EW/kK
	 BB+0sKvkhuJYPN9VnVjeljpatBsovNQ5E4gR8WXmOCsr18OQkGjShtYgAvmetlnEMZ
	 nuxRmmf8fXQ45Wp2X+gQJMISeqRP3uz13rSffV0RtmjRkD8H9Ew6KDLr7SOMg4cNbK
	 Hf8Ylod4ayzqQ==
Date: Fri, 26 Jul 2024 14:42:36 +0000
To: Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Jonathan Corbet <corbet@lwn.net>, Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@redhat.com>, Trevor Gross <tmgross@umich.edu>, gregkh@linuxfoundation.org
Subject: Re: [RFC PATCH] rust: types: Add explanation for ARef pattern
Message-ID: <81ceeca9-8ae5-4a82-9a46-f47767e60f75@proton.me>
In-Reply-To: <ZqOyMbi7xl67UfjY@Boquns-Mac-mini.home>
References: <20240710032447.2161189-1-boqun.feng@gmail.com> <CAH5fLgjat2Y6RT957BhdOjJHt7rPs0DvZYC6JZ+pHFiP=yDNgA@mail.gmail.com> <ZqE9dzfNrE3Xg3tV@boqun-archlinux> <bcdd74f3-d0c0-4366-976a-5a935081a704@proton.me> <ZqK1l05zcCwGforV@boqun-archlinux> <beaf1fa3-eebe-443c-bc51-abd9348a411d@proton.me> <ZqOyMbi7xl67UfjY@Boquns-Mac-mini.home>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 1721790b364aab39b88a43c425bf2ba1a5522476
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26.07.24 16:26, Boqun Feng wrote:
> On Fri, Jul 26, 2024 at 01:43:38PM +0000, Benno Lossin wrote:
> [...]
>>>>
>>>> You can always get a `&T` from `ARef<T>`, since it implements `Deref`.
>>>>
>>>
>>> Yeah, but this is unrelated. I was talking about that API providers can
>>> decide whether they want to only provide a `raw_ptr` -> `ARef<Self>` if
>>> they don't need to provide a `raw_ptr` -> `&Self`.
>>>
>>>>> Overall, I feel like we don't necessarily make a preference between
>>>>> `->&Self` and `->ARef<Self>` functions here, since it's up to the use=
rs'
>>>>> design?
>>>>
>>>> I would argue that there should be a clear preference for functions
>>>> returning `&Self` when possible (ie there is a parameter that the
>>>
>>> If "possible" also means there's going to be `raw_ptr` -> `&Self`
>>> function (as the same publicity level) anyway, then agreed. In other
>>> words, if the users only need the `raw_ptr` -> `ARef<Self>`
>>> functionality, we don't want to force people to provide a `raw_ptr` ->
>>> `&Self` just because, right?
>>
>> I see... I am having a hard time coming up with an example where users
>> would exclusively want `ARef<Self>` though... What do you have in mind?
>> Normally types wrapped by `ARef` have `&self` methods.
>>
>=20
> Having `&self` methods doesn't mean the necessarity of a `raw_ptr` ->
> `&Self` function, for example, a `Foo` is wrapped as follow:
>=20
> =09struct Foo(Opaque<foo>);
> =09impl Foo {
> =09    pub fn bar(&self) -> Bar { ... }
> =09    pub unsafe fn get_foo(ptr: *mut foo) -> ARef<Foo> { ... }
> =09}
>=20
> in this case, the abstration provider may not want user to get a
> `raw_ptr` -> `&Self` function, so no need to have it.

I don't understand this, why would the abstraction provider do that? The
user can already get a `&Foo` reference, so what's the harm having a
function supplying that directly?
I get the argument that you need to always convert to `ARef` if users
only use that, but when `Foo` provides `&self` methods, you're not
required to have an `ARef`.

---
Cheers,
Benno


