Return-Path: <linux-kernel+bounces-275340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0B09483AA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 22:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 839191F23505
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 20:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D6516B3BC;
	Mon,  5 Aug 2024 20:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="h3DIZW2F"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB37F13D50E;
	Mon,  5 Aug 2024 20:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722890400; cv=none; b=fVTs8yvuIny7sn4E50fLguCWMjZwRgFqBrxBRb4Gz1oTcbwdzLCoaa7HSZdAYHDNis4OEuMmEdVKlyk+8V46ft6k5hqAABnmUbdmKgBHIMMsAv8uv4sewjxy0t65kK6tH4geilHcbZqyUYjbRd3VCmjYy95TLQV7HZrdravcC7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722890400; c=relaxed/simple;
	bh=7W5xHgy45tCntLC1JcWmP2nktJxacoFxKfv9znwxpd0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sShjXblT7paVuh9R6MZnO5mgoHinfDTcznLjWwcuZxEciopDd+IvC4+SqYDFMxE6fm1EbEUcq2DJ9+uLYEqq88A2XxfmklfJOR7sDsEjGkyXwujjM0Yn2T4ExdsSooLbBe8jYnHUWUIfUmTBWseu4+zQtvZCudeFt80JkOipaiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=h3DIZW2F; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722890396; x=1723149596;
	bh=7W5xHgy45tCntLC1JcWmP2nktJxacoFxKfv9znwxpd0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=h3DIZW2F4OYeUC4u04RIhNnDJxtFFi2RPLCZq4a5dfvdwxyf79Odld0864yHpC/h+
	 BoHRSuC7bIiCK3nNcDydhbRywW9l4QjbxG/9gn2LYdnASJknrgRygGWPr7mfe20Cq/
	 YVULAlTHmZogyqWI48gAoa25ZEQOvCn/q0AkgNIttJT5J/uPBo71Eq/79V0eqqQmKU
	 27zTCRe+f61K7YSkSs2gZ6n5Ryvh2rcv3VhdFFawymKTMzjIWH457oUNaXnXF5FL4A
	 Ok9H2bUmSwD34dsS5sV82zVPsF98oOyN86JN8BAwQycOf7/xogtwSZJC2NVNIJYGZb
	 3vzUwAdPPrRCw==
Date: Mon, 05 Aug 2024 20:39:46 +0000
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] rust: kernel: add `drop_contents` to `BoxExt`
Message-ID: <24a8d381-dd13-4d19-a736-689b8880dbe1@proton.me>
In-Reply-To: <ZrCWXmvCF9L24TdO@pollux>
References: <20240803141639.3237686-1-benno.lossin@proton.me> <2ddc08c1-ac38-4cc6-a102-2ad336d6b617@kernel.org> <CAH5fLgj2urZ6OD2ki6E=6EuPqW3Z8BGg8jd6Bgo4OOrNiptnDw@mail.gmail.com> <ZrCWXmvCF9L24TdO@pollux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 8290f0f28ae1e586c318ab798cc40f873ec893e1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05.08.24 11:07, Danilo Krummrich wrote:
> On Mon, Aug 05, 2024 at 10:43:57AM +0200, Alice Ryhl wrote:
>> On Sun, Aug 4, 2024 at 1:22=E2=80=AFAM Danilo Krummrich <dakr@kernel.org=
> wrote:
>>>
>>> On 8/3/24 4:16 PM, Benno Lossin wrote:
>>>> Sometimes (see [1]) it is necessary to drop the value inside of a
>>>> `Box<T>`, but retain the allocation. For example to reuse the allocati=
on
>>>> in the future.
>>>> Introduce a new function `drop_contents` that turns a `Box<T>` into
>>>> `Box<MaybeUninit<T>>` by dropping the value.
>>>
>>> Is this (and the stuff in patch 2) used somewhere? Otherwise, I think i=
t
>>> would probably make sense to base this work on top of my allocator work=
.
>>
>> Yes, please see the red/black tree.
>> https://lore.kernel.org/rust-for-linux/20240727-b4-rbtree-v8-0-951600ada=
434@google.com/
>=20
> Ok, unless preferred otherwise, I'll pick it up in the corresponding patc=
hes of
> my allocator series then.

I am not sure if we want to do that, since the allocator series is
already rather long and the red-black tree has been in review since
February...
Another way of fixing this would be if you base your allocator series on
top of this one, then you can just include it when you remove the
`BoxExit` trait.

---
Cheers,
Benno


