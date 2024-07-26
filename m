Return-Path: <linux-kernel+bounces-263465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C6A93D672
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08DFA1F24EB6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB3017C21C;
	Fri, 26 Jul 2024 15:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="X3TBhKzR"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7F5200AF
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 15:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722009289; cv=none; b=diLLqlHI7Qylz1C8VZuHPMCKCK1xywW6S+9G0zeBf0ftCf5y73w6OM1+JiPgoi+g2WUluMj+werruJjemjCttssFWS8M53nS6h9JM3aBcxV9gS25hCLZ9RR9kK4p4GzblbtOHi4LYBIodwFDzs/RQIFxrkRzBYywqRpSBcg7Za0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722009289; c=relaxed/simple;
	bh=YTTkDFAXVglN4v44mHQV0lUT6gXOegEaaIGaVD3vLxc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T/wEkHo1nnuoVyZbyFIt77NJbPGA43Xvp7+irQWfT1VJH0w6bklYOBiEFDWmFm+PeT6TdD2FX5l+t5A7pSseUhqW9rJGXlSE0+cD9+4bC3Ao50+qGL57by5UUzQ4SKBrTl/auvTc2aADbG6cz65Sdh+8R1sjt3RaqwNYMOycyEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=X3TBhKzR; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722009284; x=1722268484;
	bh=PNehUS/FjC6MuBbMsm8QCFATrShoDfiQh3B/wLKyLZE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=X3TBhKzR/gJk20IHe/R33SdAJRRsUuYfTYbOV3BaLdgkIMON40Pmz2uUKH5Q3bhE1
	 ShCehdJHGOE/j0CHP0S5zr22rjv4WZe0jsjBr4XO3ja3YwSsFsynX9ILnwlRnmTUh0
	 WNaysJNuD7fyoHEpIFEgdP2DIfXpzzpRvnGdcfDaMLXdzTme4XAXlQtFvFICcx6Y3M
	 6E8K3xf7feIgLNhTjvlwDPh1/o9cBefuISzPNrtLSLbeAw1swWArh0rSn/FwxFoFF9
	 bj4yeolhSfDE2LaDQ4LP3gzT1PSD4lyLW6a/FQEx9zCPTdzSgF3AYYsb0AM9d6h7Gb
	 7m2kr+jCz+mlg==
Date: Fri, 26 Jul 2024 15:54:37 +0000
To: Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Jonathan Corbet <corbet@lwn.net>, Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@redhat.com>, Trevor Gross <tmgross@umich.edu>, gregkh@linuxfoundation.org
Subject: Re: [RFC PATCH] rust: types: Add explanation for ARef pattern
Message-ID: <8641453e-664d-4290-b9bc-4a2567ddc3fe@proton.me>
In-Reply-To: <ZqO9j1dCiHm3r-pz@Boquns-Mac-mini.home>
References: <20240710032447.2161189-1-boqun.feng@gmail.com> <CAH5fLgjat2Y6RT957BhdOjJHt7rPs0DvZYC6JZ+pHFiP=yDNgA@mail.gmail.com> <ZqE9dzfNrE3Xg3tV@boqun-archlinux> <bcdd74f3-d0c0-4366-976a-5a935081a704@proton.me> <ZqK1l05zcCwGforV@boqun-archlinux> <beaf1fa3-eebe-443c-bc51-abd9348a411d@proton.me> <ZqOyMbi7xl67UfjY@Boquns-Mac-mini.home> <81ceeca9-8ae5-4a82-9a46-f47767e60f75@proton.me> <ZqO9j1dCiHm3r-pz@Boquns-Mac-mini.home>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: cfe45fe6408aa7bb0816cb7b284ee42f182d9338
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26.07.24 17:15, Boqun Feng wrote:
> On Fri, Jul 26, 2024 at 02:42:36PM +0000, Benno Lossin wrote:
>> On 26.07.24 16:26, Boqun Feng wrote:
>>> On Fri, Jul 26, 2024 at 01:43:38PM +0000, Benno Lossin wrote:
>>> [...]
>>>>>>
>>>>>> You can always get a `&T` from `ARef<T>`, since it implements `Deref=
`.
>>>>>>
>>>>>
>>>>> Yeah, but this is unrelated. I was talking about that API providers c=
an
>>>>> decide whether they want to only provide a `raw_ptr` -> `ARef<Self>` =
if
>>>>> they don't need to provide a `raw_ptr` -> `&Self`.
>>>>>
>>>>>>> Overall, I feel like we don't necessarily make a preference between
>>>>>>> `->&Self` and `->ARef<Self>` functions here, since it's up to the u=
sers'
>>>>>>> design?
>>>>>>
>>>>>> I would argue that there should be a clear preference for functions
>>>>>> returning `&Self` when possible (ie there is a parameter that the
>>>>>
>>>>> If "possible" also means there's going to be `raw_ptr` -> `&Self`
>>>>> function (as the same publicity level) anyway, then agreed. In other
>>>>> words, if the users only need the `raw_ptr` -> `ARef<Self>`
>>>>> functionality, we don't want to force people to provide a `raw_ptr` -=
>
>>>>> `&Self` just because, right?
>>>>
>>>> I see... I am having a hard time coming up with an example where users
>>>> would exclusively want `ARef<Self>` though... What do you have in mind=
?
>>>> Normally types wrapped by `ARef` have `&self` methods.
>>>>
>>>
>>> Having `&self` methods doesn't mean the necessarity of a `raw_ptr` ->
>>> `&Self` function, for example, a `Foo` is wrapped as follow:
>>>
>>> =09struct Foo(Opaque<foo>);
>>> =09impl Foo {
>>> =09    pub fn bar(&self) -> Bar { ... }
>>> =09    pub unsafe fn get_foo(ptr: *mut foo) -> ARef<Foo> { ... }
>>> =09}
>>>
>>> in this case, the abstration provider may not want user to get a
>>> `raw_ptr` -> `&Self` function, so no need to have it.
>>
>> I don't understand this, why would the abstraction provider do that? The
>=20
> Because no user really needs to convert a `raw_ptr` to a `&Self` whose
> lifetime is limited to a scope?

What if you have this:

    unsafe extern "C" fn called_from_c_via_vtable(foo: *mut bindings::foo) =
{
        // SAFETY: ...
        let foo =3D unsafe { Foo::from_raw(foo) };
        foo.bar();
    }

In this case, there is no need to take a refcount on `foo`.

> Why do we provide a function if no one needs and the solely purpose is
> to just avoid providing another function?

I don't think that there should be a lot of calls to that function
anyways and thus I don't think there is value in providing two functions
for almost the same behavior. Since one can be derived by the other, I
would go for only implementing the first one.

>> user can already get a `&Foo` reference, so what's the harm having a
>> function supplying that directly?
>=20
> Getting a `&Foo` from a `ARef<Foo>` is totally different than getting a
> `&Foo` from a pointer, right? And it's OK for an abstraction provider to
> want to avoid that.
>=20
> Another example that you may not want to provide a `-> &Self` function
> is:
>  =09struct Foo(Opaque<foo>);
>  =09impl Foo {
>  =09    pub fn bar(&self) -> Bar { ... }
>  =09    pub fn find_foo(idx: u32) -> ARef<Foo> { ... }
>  =09}
>=20
> in other words, you have a query function (idx -> *mut foo), and I think
> in this case, you would avoid `find_foo(idx: u32) -> &Foo`, right?

Yes, this is the exception I had in mind with "if possible (ie there is
a parameter that the lifetime can bind to)" (in this case there wouldn't
be such a parameter).

> Honestly, this discussion has been going to a rabit hole. I will mention
> and already mentioned the conversion `&Self` -> `ARef<Self>`. Leaving
> the preference part blank is fine to me, since if it's a good practice,
> then everybody will follow, otherwise, we are missing something here.
> Just trying to not make a descision for the users...

Sure.

---
Cheers,
Benno


