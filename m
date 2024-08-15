Return-Path: <linux-kernel+bounces-288010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB1695301D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C29851C24DB0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 13:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85DF19EED0;
	Thu, 15 Aug 2024 13:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="CCObtL38"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646181714A8
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 13:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729153; cv=none; b=nyD6oHieH2d+AMUn+Z6wdfvbQdeo0gqhDKzUoTMCA8jGmO3vDXfhAidoigeCneijxQiHWLKZUCc5f27mj1bzZfvWlPYP0RQ7mjZkjP+tgg6/HXTvkxQ9tj1CuuFUQBzQJNWEx7X+FfNz8ZGbhSjban0MFBhQdXAz+LuZNl429ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729153; c=relaxed/simple;
	bh=nokUy4SHF39XRwI3OPkHLurJXww6mSnTAY3AffIpiXw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G9Dx9XezwsI9hFQuuI4tyORt87NeK6CGAFOGd1Zrm1jbfl51HAubAfmt0XBxkGjC3xxhdon+/a3fy06sNoLELmOHdr3SwNY5HU5NjIvFU50Vk3aDxyIs3qDpiKI/84W1/7MwsYsKTmK7jkwtW3HpBARsrU19BMYKV5eZnAug3Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=CCObtL38; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723729148; x=1723988348;
	bh=4KOOqAhDO4ZFOzpad7+VhAff7zaPU1/74FXUVL+elaU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=CCObtL38d0Coq+We8Xj0kaBUjG3dRDjJIMu6fyvpjTKqgkohBsyZySwWtYFx/3Lxw
	 M1Z4QNZkJNETFpuLe13BdAa4OJ7CHhz3OCGOG2f9J6r+FfSUTTDYdok6Gi63mkm91I
	 hAAocKzFR6J/m9N+R4IU/JbWEM/NBqHnrsRwJPUNCkZxZQhVrpZRTqf9Xb+ajYoSYu
	 DGfYUNqhgMN0jTnljODXYy11wZIUX3SDfyoKeOfA2m23Ut51c4v9Sqi3WNuqk7b6Sy
	 ovSrJ5NGdOorSFnn8Uze5tEkCfjN0oBbVMe+SSdMtdnPXvy7XX6zjfbQ9gyLFFO9O6
	 mKqFq28FKr+/A==
Date: Thu, 15 Aug 2024 13:39:05 +0000
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Boqun Feng <boqun.feng@gmail.com>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 00/26] Generic `Allocator` support for Rust
Message-ID: <e0b0bffb-c240-4d23-bf4d-0c1c19608f60@proton.me>
In-Reply-To: <Zr4DpPSjDqSoMh0j@cassiopeiae>
References: <20240812182355.11641-1-dakr@kernel.org> <Zr0GP0OXliPRqx4C@boqun-archlinux> <Zr1teqjuOHeeFO4Z@cassiopeiae> <CAH5fLgjvuE5uU00u4y+HyHTkQU_OBYvHe6NS5ohAhrLntTX1zQ@mail.gmail.com> <Zr31jqnA2b3qHK5l@cassiopeiae> <CAH5fLgjzNpeVVurPqVS=tMkKQOhXz08EsXRO4s9wYsNBuT6eVw@mail.gmail.com> <Zr4DpPSjDqSoMh0j@cassiopeiae>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 37da0818d01e8d58e689de0b12c5023f70729564
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15.08.24 15:33, Danilo Krummrich wrote:
> On Thu, Aug 15, 2024 at 02:34:50PM +0200, Alice Ryhl wrote:
>> On Thu, Aug 15, 2024 at 2:33=E2=80=AFPM Danilo Krummrich <dakr@kernel.or=
g> wrote:
>>>
>>> On Thu, Aug 15, 2024 at 11:20:32AM +0200, Alice Ryhl wrote:
>>>> On Thu, Aug 15, 2024 at 4:52=E2=80=AFAM Danilo Krummrich <dakr@kernel.=
org> wrote:
>>>>>
>>>>> On Wed, Aug 14, 2024 at 12:32:15PM -0700, Boqun Feng wrote:
>>>>>> Hi Danilo,
>>>>>>
>>>>>> I'm trying to put your series on rust-dev, but I hit a few conflicts=
 due
>>>>>> to the conflict with `Box::drop_contents`, which has been in rust-de=
v
>>>>>> for a while. And the conflict is not that trivial for me to resolve.
>>>>>> So just a head-up, that's a requirement for me to put it on rust-dev=
 for
>>>>>> more tests from my end ;-)
>>>>>
>>>>> I rebased everything and you can fetch them from [1].
>>>>>
>>>>> I resolved the following conflicts:
>>>>>
>>>>>   - for `Box`, implement
>>>>>     - `drop_contents`
>>>>>     - `manually_drop_contents` [2]
>>>>
>>>> Not sure I like this name. It sounds like something that runs the
>>>> destructor, but it does the exact opposite.
>>>
>>> I thought it kinda makes sense, since it's analogous to `ManuallyDrop::=
new`.
>>>
>>> What about `Box::forget_contents` instead?
>>
>> One option is `into_manually_drop`. This uses the convention of using
>> the `into_*` prefix for conversions that take ownership of the
>> original value.
>=20
> The signature of the current `Box::manually_drop_contents` is the same as=
 for
> `Box::drop_contents`, namely
> `fn manually_drop_contents(this: Self) -> Box<MaybeUninit<T>, A>`.
>=20
> `into_manually_drop` seems misleading for for returning a
> `Box<MaybeUninit<T>, A>`.
>=20
> I still think `forget_contents` hits it quite well. Just as `drop_content=
s`
> drops the value, `forget_contents` makes the `Box` forget the value.

I think `forget_contents` sounds good. Can you please add some more docs
to that function though? Like an example and change "Manually drops the
contents, but keeps the allocation" to "Forgets the contents (does not
run the destructor), but keeps the allocation.".

Another thing that I spotted while looking at the patch, `move_out`
doesn't need the `transmute_copy`, you should be able to just call
`read` on the pointer.

---
Cheers,
Benno


