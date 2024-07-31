Return-Path: <linux-kernel+bounces-269399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A69B194326B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B87B1F20F04
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79D21BBBC5;
	Wed, 31 Jul 2024 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="EbxWVyvi"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99983611E;
	Wed, 31 Jul 2024 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722437331; cv=none; b=TCEzBdJv4czD4yGulk5RoUkeB9kfFLDPZUJx+OFA2vU2c5N7CmCZURTKrG76KTnxKjwETEec3vgF+Gt2cCMYCTtlyBAoQMCbDZgf2uMs/WgRCOW+0Y8aOwazApFKOpSkTyJlQQlodARxDPN0360+apjssgoXlG6TYSLDXY/eM6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722437331; c=relaxed/simple;
	bh=Vawp62FULKBA3dCF5MI+TAT+Dpj7YqVUAAoe599LNfw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hlelE9VokXndE1imZLJwtcPkWcRyH2zmMtqzzk3EGm9I1nFQFDmRx8X1wryuo1ldjFQbIhFvcAPn4OuFchlSmg/MiE0I0kW5YsQ0QQPKVl0xUoCdIstZhEzKg6af5RKEmDTRw8TdwvPqDE9nTjMaa1YGeiNYwOvhUy1Ma48JCYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=EbxWVyvi; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722437322; x=1722696522;
	bh=RzXi2xAm5ag+0eW5UgNGGENUHE//qEaGWyg1913ArEw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=EbxWVyvie+M4gw3ZApE3+GGv07WI6wtPc978p39s72PYzDMkNKMgMlGXZ/dNxaPEk
	 8g6i31UUSxM57An6i10FBZpO4EvorwQDjITLUJDeaDqNUiRZQ1p3nCtoZOWT9tWDBy
	 0ctuP+jv3lKToT7Zrf/pio3WRyeYVec/ZZAaOotDwFRuu0LsZhxClZ/iuXMPpQsHXq
	 xcjmqOoYKHqI4e5HPFYAGPP5CoH3sb7xhjybizgi3srsv7OWYb0BKPfzvgDqU7OM84
	 /133e4qeJeyS+EnLJUQY6AhqABRvh/nauZw9PKBOhorEEV1dYUf+NX+pSfuSpVd3+w
	 j7mTx7C4Hj25Q==
Date: Wed, 31 Jul 2024 14:48:32 +0000
To: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Boqun Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Jonathan Corbet <corbet@lwn.net>, Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@redhat.com>, Trevor Gross <tmgross@umich.edu>, gregkh@linuxfoundation.org
Subject: Re: [RFC PATCH] rust: types: Add explanation for ARef pattern
Message-ID: <373fa545-004a-41a8-97a8-d8a7632562c2@proton.me>
In-Reply-To: <CAH5fLgijqHoKrWmHBb+FQntPDgR2qA_r4y0gyib21AHU+mscNw@mail.gmail.com>
References: <20240710032447.2161189-1-boqun.feng@gmail.com> <ZqK1l05zcCwGforV@boqun-archlinux> <beaf1fa3-eebe-443c-bc51-abd9348a411d@proton.me> <ZqOyMbi7xl67UfjY@Boquns-Mac-mini.home> <81ceeca9-8ae5-4a82-9a46-f47767e60f75@proton.me> <ZqO9j1dCiHm3r-pz@Boquns-Mac-mini.home> <8641453e-664d-4290-b9bc-4a2567ddc3fe@proton.me> <ZqPMpNNq0Q0S-M2P@cassiopeiae> <CAH5fLgijqHoKrWmHBb+FQntPDgR2qA_r4y0gyib21AHU+mscNw@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 81bde7f2fb0fbe04ab82c747ad33b45df681d53c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.07.24 13:31, Alice Ryhl wrote:
> On Fri, Jul 26, 2024 at 6:20=E2=80=AFPM Danilo Krummrich <dakr@kernel.org=
> wrote:
>>
>> On Fri, Jul 26, 2024 at 03:54:37PM +0000, Benno Lossin wrote:
>>> On 26.07.24 17:15, Boqun Feng wrote:
>>>> On Fri, Jul 26, 2024 at 02:42:36PM +0000, Benno Lossin wrote:
>>>>> On 26.07.24 16:26, Boqun Feng wrote:
>>>>>> On Fri, Jul 26, 2024 at 01:43:38PM +0000, Benno Lossin wrote:
>>>>>> [...]
>>>>>>>>>
>>>>>>>>> You can always get a `&T` from `ARef<T>`, since it implements `De=
ref`.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Yeah, but this is unrelated. I was talking about that API provider=
s can
>>>>>>>> decide whether they want to only provide a `raw_ptr` -> `ARef<Self=
>` if
>>>>>>>> they don't need to provide a `raw_ptr` -> `&Self`.
>>>>>>>>
>>>>>>>>>> Overall, I feel like we don't necessarily make a preference betw=
een
>>>>>>>>>> `->&Self` and `->ARef<Self>` functions here, since it's up to th=
e users'
>>>>>>>>>> design?
>>>>>>>>>
>>>>>>>>> I would argue that there should be a clear preference for functio=
ns
>>>>>>>>> returning `&Self` when possible (ie there is a parameter that the
>>>>>>>>
>>>>>>>> If "possible" also means there's going to be `raw_ptr` -> `&Self`
>>>>>>>> function (as the same publicity level) anyway, then agreed. In oth=
er
>>>>>>>> words, if the users only need the `raw_ptr` -> `ARef<Self>`
>>>>>>>> functionality, we don't want to force people to provide a `raw_ptr=
` ->
>>>>>>>> `&Self` just because, right?
>>>>>>>
>>>>>>> I see... I am having a hard time coming up with an example where us=
ers
>>>>>>> would exclusively want `ARef<Self>` though... What do you have in m=
ind?
>>>>>>> Normally types wrapped by `ARef` have `&self` methods.
>>>>>>>
>>>>>>
>>>>>> Having `&self` methods doesn't mean the necessarity of a `raw_ptr` -=
>
>>>>>> `&Self` function, for example, a `Foo` is wrapped as follow:
>>>>>>
>>>>>>   struct Foo(Opaque<foo>);
>>>>>>   impl Foo {
>>>>>>       pub fn bar(&self) -> Bar { ... }
>>>>>>       pub unsafe fn get_foo(ptr: *mut foo) -> ARef<Foo> { ... }
>>>>>>   }
>>>>>>
>>>>>> in this case, the abstration provider may not want user to get a
>>>>>> `raw_ptr` -> `&Self` function, so no need to have it.
>>>>>
>>>>> I don't understand this, why would the abstraction provider do that? =
The
>>>>
>>>> Because no user really needs to convert a `raw_ptr` to a `&Self` whose
>>>> lifetime is limited to a scope?
>>>
>>> What if you have this:
>>>
>>>     unsafe extern "C" fn called_from_c_via_vtable(foo: *mut bindings::f=
oo) {
>>>         // SAFETY: ...
>>>         let foo =3D unsafe { Foo::from_raw(foo) };
>>>         foo.bar();
>>>     }
>>>
>>> In this case, there is no need to take a refcount on `foo`.
>>>
>>>> Why do we provide a function if no one needs and the solely purpose is
>>>> to just avoid providing another function?
>>>
>>> I don't think that there should be a lot of calls to that function
>>> anyways and thus I don't think there is value in providing two function=
s
>>> for almost the same behavior. Since one can be derived by the other, I
>>> would go for only implementing the first one.
>>
>> I don't think there should be a rule saying that we can't provide a wrap=
per
>> function for deriving an `ARef<T>`. `Device` is a good example:
>>
>> `let dev: ARef<Device> =3D unsafe { Device::from_raw(raw_dev) }.into();`
>>
>> vs.
>>
>> `let dev =3D unsafe { Device::get(raw_dev) };`
>>
>> To me personally, the latter looks quite a bit cleaner.
>>
>> Besides that, I think every kernel engineer (even without Rust backgroun=
d) will
>> be able to decode the meaning of this call. And if we get the chance to =
make
>> things obvious to everyone *without* the need to make a compromise, we s=
hould
>> clearly take it.
>=20
> I think I've come around on this question. I think it's fine to have
> raw_ptr->ARef methods that increment the refcount, but we should make
> a naming convention clear. I propose:
>=20
> * Functions named things like from_raw_file or from_raw_mm do not
> increment the refcount.
> * Functions named things like get_file or or mmget do increment the
> refcount, just like the C function of the same name.

I have thought about this a bit and I think that we can try to do it. I
like the name `Device::get` and `Device::from_raw`. I would not
duplicate the name ie `Device::get_device` (nor would I do that with
`from_raw`).

One of my bigger problems was the naming, so it's good to see this.

---
Cheers,
Benno


