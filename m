Return-Path: <linux-kernel+bounces-277506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B7C94A250
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A1AF1C2257F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 08:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD5C1C462C;
	Wed,  7 Aug 2024 08:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="l8rcU5Bv"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1646F2E3
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 08:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723017715; cv=none; b=SJfTSVlFTSZyzE4BWPbaXzqwQHX91RrfuVOyRm6E1x7wf1OyJODHpofpWh9E14uRdVTOLvDoYnCXdQRfA91oifF5WGHyaGHFQaBD6/nyTmtWuIA0Gx17hoPo9x/iLFCjqcweb9IVb17KTP1XWT08GAfcmG3k+iJS3WmFiQNide4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723017715; c=relaxed/simple;
	bh=uNRTxLMAMpcbQn5DCRpAhvTpZAl9kCTly36CTOVae9Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ITUuVozH/QkX2dmYIQ/nSSWMYCRRuHyFKa8YKYj8hqmPZAdfrEKWDp3uQM8ni4QpmbsbCRNdpxgdcWSPVOK68jy7nAzoWPasj2P91MAW4SnNVAvI6lTqsZhUkTyUlkpATFCg5NOCAkah18c06SPMP5kyP715kquCAJWbn17JhIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=l8rcU5Bv; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723017710; x=1723276910;
	bh=RWY8n2kwMXBw5zg65jaQElb79dGDUP5Ex7AXip/oERA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=l8rcU5BvXbczBsQdlGiFBhu8cJLjhgult7+F8YRsB+mLN7KS9etyd76yw12rwQWRP
	 WkJ5TLzFT12bFC38v9QINztgQABrLkPVZMy9FnRyxRxgv9NEgn/7J+xN71ciGt+gFH
	 Xvv0i5DopHNmb4LGRIjj10NVew/q/cbi1h0U4Bivvsl2M6/HPS/dY+CwxZFq7vjXRK
	 73aUdYTFlzoyiOibjcmTI2BDUDR/SJscWdYXp7owOffV3Nl2RPecyMdwLpxeVgyVkK
	 FEIpbnsB3acccPGsSazAG9xRczo3De1vjnzYFsk/InMH3BUpieB7fJxxhGENLBCwgB
	 izZk6TjmLfUkw==
Date: Wed, 07 Aug 2024 08:01:00 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 09/28] rust: alloc: implement kernel `Box`
Message-ID: <7f3a4ea5-79c6-4068-9a5f-0aa3a55e38cb@proton.me>
In-Reply-To: <CAH5fLggiSU9Ossy5gc+S_rSiX8v-JCDKPL_tRDYdjMYGfOt-0w@mail.gmail.com>
References: <20240805152004.5039-1-dakr@kernel.org> <20240805152004.5039-10-dakr@kernel.org> <a1c1e273-2d40-4114-b3b9-f27c73e3d122@proton.me> <ZrKrMrg5E85y7jkj@pollux> <012f5a12-2408-4658-8318-55fa8d4285e1@proton.me> <CAH5fLggiSU9Ossy5gc+S_rSiX8v-JCDKPL_tRDYdjMYGfOt-0w@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 5e675f3e5db637a98548d3886b70d1e75fe812f2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07.08.24 09:51, Alice Ryhl wrote:
> On Wed, Aug 7, 2024 at 9:49=E2=80=AFAM Benno Lossin <benno.lossin@proton.=
me> wrote:
>> On 07.08.24 01:01, Danilo Krummrich wrote:
>>> On Tue, Aug 06, 2024 at 07:47:17PM +0000, Benno Lossin wrote:
>>>> On 05.08.24 17:19, Danilo Krummrich wrote:
>>>>> +impl<T, A> Box<T, A>
>>>>> +where
>>>>> +    T: ?Sized,
>>>>> +    A: Allocator,
>>>>> +{
>>>>> +    /// Constructs a `Box<T, A>` from a raw pointer.
>>>>> +    ///
>>>>> +    /// # Safety
>>>>> +    ///
>>>>> +    /// `raw` must point to valid memory, previously allocated with =
`A`, and at least the size of
>>>>> +    /// type `T`.
>>>>
>>>> With this requirement and the invariant on `Box`, I am lead to believe
>>>> that you can't use this for ZSTs, since they are not allocated with `A=
`.
>>>> One solution would be to adjust this requirement. But I would rather u=
se
>>>> a different solution: we move the dangling pointer stuff into the
>>>> allocator and also call it when `T` is a ZST (ie don't special case th=
em
>>>> in `Box` but in the impls of `Allocator`). That way this can stay as-i=
s
>>>> and the part about ZSTs in the invariant can be removed.
>>>
>>> Actually, we already got that. Every zero sized allocation will return =
a
>>> dangling pointer. However, we can't call `Allocator::free` with (any) d=
angling
>>> pointer though.
>>
>> The last part is rather problematic in my opinion, since the safety
>> requirements of the functions in `Allocator` don't ensure that you're
>> not allowed to do it. We should make it possible to free dangling
>> pointers that were previously "allocated" by the allocator (ie returned
>> by `realloc`).
>> Maybe we do need an `old_layout` parameter for that (that way we can
>> also `debug_assert_eq!(old_layout.align(), new_layout.align())`).
>=20
> The std allocators generally prohibit zero sized allocations, so it
> seems sensible for us to do the same?

I never understood why they do that, the stdlib `Allocator` trait has
all the information it needs to detect zero-sized allocations, so it
could just return dangling pointers. I don't see the point of
duplicating the zero-sized logic in `Box` and `Vec`...

---
Cheers,
Benno


