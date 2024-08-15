Return-Path: <linux-kernel+bounces-288087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5389533D9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96B001F270D3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71501A00F5;
	Thu, 15 Aug 2024 14:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="aRv6qiIY"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFFC1AC896;
	Thu, 15 Aug 2024 14:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731589; cv=none; b=UAuO2D2VrhPmo9S8B4kbSrGBxxteSkypn6oo/so1YXrMVHRxngi5tAvSEX5d2jFick/jdiRPnHvUuQnTGnu+wBTFZ/UJCCXcr+cfLPoaeC7HYLzxEfyw9IlsZwcI7LeeyjMfDKZNu6LP/UyGbufcoim3Jx8VlPa7HyeT3AIuQKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731589; c=relaxed/simple;
	bh=KbqX/GkBzJQQ/bunYBrYIXbPXPT0lC7rAtpJ178aIKo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bIhWptl6YmRiJynyRtaqYNI6iOd5o+bWhYsQFCjeb5ZqhmpLWnaZnXq4SqNQCwZA0Ks8DnUBSiSP2WYrnF7fp62Iut4dq2M+PqqxQXs2pKOV11JiS6Qhnkwva4+7neuDmwS42E12oxS3+sER6Np81yx7iw1qMegnIcmTJdPE/S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=aRv6qiIY; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=gxr7zbezencsjmbcyyqdpmg2aa.protonmail; t=1723731585; x=1723990785;
	bh=UqgtoJLouKx1iQTjqXRDGDK4zBAgDS774E+gg2Yq3mQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=aRv6qiIYOKxr6XQFzLh4lyWHeVOo4C4FkfR4mNcwxlhMyOmZ03dM01iXRSvMuJQ0i
	 EVEbDCaeps7o38gDrXZXa1BaBKFK9a7L/zCbCrFF5cm7d6YahkSFTl2K7ZPGF0jjrA
	 aa1UcTRdMc9MnPg/wKbngMeCYDZ2xEOQdaB8tfhaaCX62am2OPE6gxNyZQaqKOyXmQ
	 LWWf/x1uVSsXzMcyHX8te1qV6ecb4XycAl/1C3p4bzBW8FEHvUlGs1nFe/3gIPjK5T
	 gTH9bpon1WYrdtF3Ve5wop6a6naCuybDJTGYIAAFSdlUesHuYdaLIyISddKHeQuoTa
	 gwszo8yUJzyYA==
Date: Thu, 15 Aug 2024 14:19:41 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 00/26] Generic `Allocator` support for Rust
Message-ID: <62e9af7b-df5a-495b-8fb5-27cf852293b4@proton.me>
In-Reply-To: <Zr4MEPlbYGrx6BbO@cassiopeiae>
References: <20240812182355.11641-1-dakr@kernel.org> <Zr0GP0OXliPRqx4C@boqun-archlinux> <Zr1teqjuOHeeFO4Z@cassiopeiae> <CAH5fLgjvuE5uU00u4y+HyHTkQU_OBYvHe6NS5ohAhrLntTX1zQ@mail.gmail.com> <Zr31jqnA2b3qHK5l@cassiopeiae> <CAH5fLgjzNpeVVurPqVS=tMkKQOhXz08EsXRO4s9wYsNBuT6eVw@mail.gmail.com> <Zr4DpPSjDqSoMh0j@cassiopeiae> <e0b0bffb-c240-4d23-bf4d-0c1c19608f60@proton.me> <Zr4MEPlbYGrx6BbO@cassiopeiae>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 82454498d143298b0af31e2a5c089cc31de5f112
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15.08.24 16:09, Danilo Krummrich wrote:
> On Thu, Aug 15, 2024 at 01:39:05PM +0000, Benno Lossin wrote:
>> On 15.08.24 15:33, Danilo Krummrich wrote:
>>> On Thu, Aug 15, 2024 at 02:34:50PM +0200, Alice Ryhl wrote:
>>>> On Thu, Aug 15, 2024 at 2:33=E2=80=AFPM Danilo Krummrich <dakr@kernel.=
org> wrote:
>>>>>
>>>>> On Thu, Aug 15, 2024 at 11:20:32AM +0200, Alice Ryhl wrote:
>>>>>> On Thu, Aug 15, 2024 at 4:52=E2=80=AFAM Danilo Krummrich <dakr@kerne=
l.org> wrote:
>>>>>>>
>>>>>>> On Wed, Aug 14, 2024 at 12:32:15PM -0700, Boqun Feng wrote:
>>>>>>>> Hi Danilo,
>>>>>>>>
>>>>>>>> I'm trying to put your series on rust-dev, but I hit a few conflic=
ts due
>>>>>>>> to the conflict with `Box::drop_contents`, which has been in rust-=
dev
>>>>>>>> for a while. And the conflict is not that trivial for me to resolv=
e.
>>>>>>>> So just a head-up, that's a requirement for me to put it on rust-d=
ev for
>>>>>>>> more tests from my end ;-)
>>>>>>>
>>>>>>> I rebased everything and you can fetch them from [1].
>>>>>>>
>>>>>>> I resolved the following conflicts:
>>>>>>>
>>>>>>>   - for `Box`, implement
>>>>>>>     - `drop_contents`
>>>>>>>     - `manually_drop_contents` [2]
>>>>>>
>>>>>> Not sure I like this name. It sounds like something that runs the
>>>>>> destructor, but it does the exact opposite.
>>>>>
>>>>> I thought it kinda makes sense, since it's analogous to `ManuallyDrop=
::new`.
>>>>>
>>>>> What about `Box::forget_contents` instead?
>>>>
>>>> One option is `into_manually_drop`. This uses the convention of using
>>>> the `into_*` prefix for conversions that take ownership of the
>>>> original value.
>>>
>>> The signature of the current `Box::manually_drop_contents` is the same =
as for
>>> `Box::drop_contents`, namely
>>> `fn manually_drop_contents(this: Self) -> Box<MaybeUninit<T>, A>`.
>>>
>>> `into_manually_drop` seems misleading for for returning a
>>> `Box<MaybeUninit<T>, A>`.
>>>
>>> I still think `forget_contents` hits it quite well. Just as `drop_conte=
nts`
>>> drops the value, `forget_contents` makes the `Box` forget the value.
>>
>> I think `forget_contents` sounds good. Can you please add some more docs
>> to that function though? Like an example and change "Manually drops the
>> contents, but keeps the allocation" to "Forgets the contents (does not
>> run the destructor), but keeps the allocation.".
>=20
> I can't really think of a good real world example other than moving out o=
f a
> `Box`, can you? Otherwise, maybe it just shouldn't be public?

Oh I thought you had a user for that function. In that case making it
private makes a lot of sense.

Also, `drop_contents` can be implemented with `forget_contents`, but
that might be a good follow up as a good-first-issue.

>> Another thing that I spotted while looking at the patch, `move_out`
>> doesn't need the `transmute_copy`, you should be able to just call
>> `read` on the pointer.
>=20
> While technically it's the same I thought `transmute_copy` is considered =
better,
> since it has less stict safety requirements?

I would avoid `transmute_copy` as much as possible, transmuting
signifies to me that you somehow need to change the type and
`transmute_copy` means that the compiler isn't even able to figure out
that the two types have the same size (they are allowed to have
different size [only `Src` larger than `Dst` though], but I most often
have used this with generics where it was guaranteed to be the same
type, but the compiler failed to notice it.).

> For `transmute_copy` we only need to say, that dst has the same type as s=
rc,
> whereas for `read` the pointer must be valid for reads, properly aligned =
and
> point to an initialized value.

You can input a reference, so you get pointer validity for free, though
you still need to put that in the SAFETY comment.

---
Cheers,
Benno


