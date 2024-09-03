Return-Path: <linux-kernel+bounces-312675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D521C9699A4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F0941F23C65
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7311AD242;
	Tue,  3 Sep 2024 09:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="mJf03Zln"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555831A3AA2
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 09:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725357486; cv=none; b=eu8W6yWDlT3PnD8gVecFqMWTRMSXgqEbz22ZEL+FzGOh1a2yRHqY9TM99kIGSWVk5myOxvI2zMbJ3hlrMwAT0im3QHidO5ISpHzTPsJOfvM23aENAFGqKooFJOd8KrJws5Xa2DMTJ3Y9QfbWNAgvkjXfBbUaDpYbMZw3fQ8kYAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725357486; c=relaxed/simple;
	bh=JpqUEURrVrtIG+qV2DIJf8rEzT0OhRvDn4t/5r7SbP0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VF32Ty1nRI4yY9y7uZRUy+OARUT0RFTSCCKa3gYsuJc3StjrGVTtgjL5zrS7wH4ibQ6ZhwUEScNVElsw3QsJoguAVhEzqjtjj7GFrW/Ylrs0xzE6qT1MbSEv32cJt0PfOdAbwK0kakX23Ocm7ZZG8oejPmqP+WaadWpAM4/oZHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=mJf03Zln; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1725357482; x=1725616682;
	bh=JpqUEURrVrtIG+qV2DIJf8rEzT0OhRvDn4t/5r7SbP0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=mJf03Zln/4TaruErEIo8kyEXoJ493h/c3qXFTlOdd1LDFucS+2oLEAk699lcYjw0D
	 8eCX6ZlU0jrIk0xDEKvEMsn1vyqanVMJfK1DkpiAINXngIOhGQpPebU9W+ScPMmIjd
	 R/gwtb7izGSjsH9vROHLdoz+wSfLruKNcxTRVwBS3SFmT1Lq97S7ZJiT7Hv6s6EtdJ
	 Xd8r0CQJrcqM8Aaeu+4EIMgUl5UPdlfJtnbsjH6ulPz33bOQwLxktLIhX5OHCuNT0I
	 cwRnBYHT2rldsVtyri1YPf2vaJdx64UPfJbzxX9Z++haMQSkDpbYFOMso1Qt05wbpF
	 Z7bYaq8HgnNlA==
Date: Tue, 03 Sep 2024 09:57:58 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rust: sync: require `Send` and `Sync` for `Backend::State`
Message-ID: <c86fdb23-497c-4f5e-9dc3-1683fb494dc5@proton.me>
In-Reply-To: <CAH5fLgihM6OeuVrAhSXAqb9RDKBa8p7+EOsFuuqkGu-OzoapZw@mail.gmail.com>
References: <20240903091700.172734-1-benno.lossin@proton.me> <CAH5fLgihM6OeuVrAhSXAqb9RDKBa8p7+EOsFuuqkGu-OzoapZw@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 2a6a3ca701125dc3fbec0550c3a493562316a39c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03.09.24 11:30, Alice Ryhl wrote:
> On Tue, Sep 3, 2024 at 11:17=E2=80=AFAM Benno Lossin <benno.lossin@proton=
.me> wrote:
>>
>> `Lock<T, B>` implements `Send` and `Sync` when `T` is `Send` or `Sync`
>> respectively. Since this does not depend on `B`, creating a `Lock` that
>> is `Send` and `Sync`, but with a `!Sync` or `!Send` state is possible.
>> This is a soundness issue, thus add the bounds to the respective impls.
>>
>> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
>=20
> Currently, B::State is set directly to `bindings::spinlock_t` or
> `bindings::mutex` and these types are pretty unlikely to be Send/Sync
> on all kernel configurations. If you're going to make this change, you
> will need to change these types.

Oh yeah you are correct. I did try to compile it, but maybe I missed
some config options, since it didn't complain?

> Considering that B::State is already stored in Opaque meaning that we
> don't run its destructor either, it's not really treated as a normal
> field right now. Perhaps it would be better to change the safety
> requirements of the `Backend` trait to impose restrictions on the
> thread safety of B::State?

Yes that sounds like a better idea.

---
Cheers,
Benno


