Return-Path: <linux-kernel+bounces-263334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A6F93D46E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B2B41F25895
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E357B17C7C0;
	Fri, 26 Jul 2024 13:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="OSB9SSV9"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871A317C22E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 13:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722001427; cv=none; b=PK4HakWGSGYl5UQgddZDMGkeZbmmHvQY3z7A39AbDXydS2ycSUWxex0vw00Ua+rRukeMVW7zveJ7ifFEM+fP6W8jEZp6biLfy7okfJzxwZZ4HeU2lcU6bQM/oJD1JyQwGYCfXnEFj2kEGPuls8lLKbKtCiLPiUMgEecKJVeT/HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722001427; c=relaxed/simple;
	bh=LpmTpst9tCOw77A57JCy7v0ELdCC5+ZAdYNsqWRsD3A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g0agavYecbZ5rXY3vDKhqWkYWhqBKA9j9vj49xr9YQ8gNqVEdqNhTw/cCgi6gY8DxQ7iC2yAX0DeU20sIyW2RCoaFFXdYGtsmnGQGzSYl28qWmzUViewN7LbhUDeZeMeIp9pLJhHxuPpf9NrjY4ZinIFWW6GQPnKH/ZbMFKC18Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=OSB9SSV9; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722001423; x=1722260623;
	bh=YGvFGgwYypuNV9H/Bzk9WCSdRPbec4gTm6JXzoCZIaU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=OSB9SSV9388drZ8Fu8+t9OWBxkDFtazQ9Ke0aq1EmH5uNneZdAbm73JXkR76jGXQq
	 thMHYii0+768P+tRY8GykXzTW9s0iPum3ROcVPJYkCyBUxUp23T0L1i72JCE0bCpH5
	 CNpSoMETqu8/z+a3gCjDW2VBpewTvK4lB8UyfjcEePQTmPutQEU+kBD2VM7R90eQY7
	 xe5FJSzW+iB4oOuSogTcmvvAPDBh4vTIJakRrQ06qWKcJr4C+1KEdx701fkFKKMnnw
	 M9zjdCY4OqcN4/N6mK4LcLHQ72CQ88ipMvPObzWRy6uAOslLbVDq4L8h8MtOf7kwM/
	 1F33F74rytbzw==
Date: Fri, 26 Jul 2024 13:43:38 +0000
To: Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Jonathan Corbet <corbet@lwn.net>, Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@redhat.com>, Trevor Gross <tmgross@umich.edu>, gregkh@linuxfoundation.org
Subject: Re: [RFC PATCH] rust: types: Add explanation for ARef pattern
Message-ID: <beaf1fa3-eebe-443c-bc51-abd9348a411d@proton.me>
In-Reply-To: <ZqK1l05zcCwGforV@boqun-archlinux>
References: <20240710032447.2161189-1-boqun.feng@gmail.com> <CAH5fLgjat2Y6RT957BhdOjJHt7rPs0DvZYC6JZ+pHFiP=yDNgA@mail.gmail.com> <ZqE9dzfNrE3Xg3tV@boqun-archlinux> <bcdd74f3-d0c0-4366-976a-5a935081a704@proton.me> <ZqK1l05zcCwGforV@boqun-archlinux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 978f8f08559271b0ce9f750c86bab903fa4f9c00
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25.07.24 22:29, Boqun Feng wrote:
> On Thu, Jul 25, 2024 at 06:12:56PM +0000, Benno Lossin wrote:
>> On 24.07.24 19:44, Boqun Feng wrote:
>>> On Tue, Jul 23, 2024 at 11:14:29AM +0200, Alice Ryhl wrote:
>>>>> +/// However `&Self` represents a reference to the object, and the li=
fetime of the **reference** is
>>>>> +/// known at compile-time. E.g. the `Foo::as_ref()` above.
>>>>> +///
>>>>> +/// ## `impl Drop` of an `impl AlwaysRefCounted` should not touch th=
e refcount
>>>>> +///
>>>>> +/// [`ARef`] descreases the refcount automatically (in [`ARef::drop`=
]) when it goes out of the
>>>>> +/// scope, therefore there's no need to `impl Drop` for the type of =
objects (e.g. `Foo`) to decrease
>>>>> +/// the refcount.
>>>>>  pub struct ARef<T: AlwaysRefCounted> {
>>>>>      ptr: NonNull<T>,
>>>>>      _p: PhantomData<T>,
>>>>> --
>>>>> 2.45.2
>>>>>
>>>>
>>>> I think this is missing some basic information related to `&Self` ->
>>>> `ARef<Self>` conversions. We should explain that these conversions are
>>>> possible, and that you usually don't want `raw_ptr` -> `ARef<Self>` to
>>>> increment the refcount - instead provide a `raw_ptr` -> `&Self` and
>>>> convert the `&Self` to `ARef<Self>`.
>>>>
>>>
>>> I could be more explicit on this, but could there be a case where a `T`
>>> only wants to return `ARef<T>` as a public API? In other words, the
>>> author of `T` doesn't want to expose an `-> &T` function, therefore a
>>> `-> ARef<T>` function makes more sense? If all the users of `T` want to
>>> operate on an `ARef<T>` other than `&T`, I think it makes sense, right?
>>
>> You can always get a `&T` from `ARef<T>`, since it implements `Deref`.
>>
>=20
> Yeah, but this is unrelated. I was talking about that API providers can
> decide whether they want to only provide a `raw_ptr` -> `ARef<Self>` if
> they don't need to provide a `raw_ptr` -> `&Self`.
>=20
>>> Overall, I feel like we don't necessarily make a preference between
>>> `->&Self` and `->ARef<Self>` functions here, since it's up to the users=
'
>>> design?
>>
>> I would argue that there should be a clear preference for functions
>> returning `&Self` when possible (ie there is a parameter that the
>=20
> If "possible" also means there's going to be `raw_ptr` -> `&Self`
> function (as the same publicity level) anyway, then agreed. In other
> words, if the users only need the `raw_ptr` -> `ARef<Self>`
> functionality, we don't want to force people to provide a `raw_ptr` ->
> `&Self` just because, right?

I see... I am having a hard time coming up with an example where users
would exclusively want `ARef<Self>` though... What do you have in mind?
Normally types wrapped by `ARef` have `&self` methods.

Cheers,
Benno


