Return-Path: <linux-kernel+bounces-548861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEDBA54A3C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AC913AC4D6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B90C2066C8;
	Thu,  6 Mar 2025 12:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="f9MpQjXO"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616231FC7FF
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 12:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741262617; cv=none; b=SQ4kSFINBnWpT6G8I5rmCd17pY1ymjS0lx6gkmUaVEeFstQC2ls61A1Ww7R/+KDaELBLGIt9uFq/4zyNbk6+EE1HBBm3VVDTH1jx4/m8MoaifmrhcdO46G8YsELmWVkKshHr0+aakwRe6SyZmCjA/a9z/RFuHK/u+YTvf72I3vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741262617; c=relaxed/simple;
	bh=EKN1Aec042lfCLYffY+qogNf06FDM+J+RkLkqOv5eOs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Muwtz0msSZ14B/PtSnASXHwyeJSbcqsYLNhiQAotfyCSsQEs8lku+8dhbbKfGoKrTSJ7mRHqZq8S8OkZvdG71n5MdPgcGm1uH/AYP5gstxm8mSRm7hvf3wYG4vVvl5W46AeCJqpAOSJrtUve65O6GFgdP/wCSSyetMl6wib0tLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=f9MpQjXO; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1741262608; x=1741521808;
	bh=E9ndBuSbaPlC91uSyBn2kvl1hGQxUxmwYxtPLheGNC4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=f9MpQjXOr3Ph0OkDMzDvotuaC9dgnPDLFsAPUXktv+R9AOUWzzCOi6iaVanU6Nql2
	 KOz8YRF85N9LyCdS5diahpOo71BWIs9AECTs7icBikKcwmwc2E4iylJ8Aqp+oZy1yi
	 Ie61iMmlhI2otCjyQ0mQ4R3jpuOWtY+IiX4BGmJS3NmInx/7BFcKs+plFfeVXYNZXs
	 AZ+tFPZKaoq0d4SuviQLjbwGys6m/74GmObbwC1PNM6YKYXVm4Zvh23f113N8imb0D
	 N75okFfK5mAH+HgI4jUp1bu5YJjqJ4kviNmrYo1QfiafUxGQdNw2ey9+LYMEMeNUF5
	 5irvkmqxL3WTA==
Date: Thu, 06 Mar 2025 12:03:23 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] rust: adding UniqueRefCounted and UniqueRef types
Message-ID: <Z8mPBvL--zUxBpYN@mango>
In-Reply-To: <Z8mHgyNxb6rv6Vhm@google.com>
References: <Z8hUIPtE_9P60fAf@google.com> <CAH5fLgjFBknTmhxQBPUdB-iNMjEkcyuLiu22-Nj-DGB1Gb7NkA@mail.gmail.com> <87ldtj8p2m.fsf@kernel.org> <JPqvzrz3Zy0HgwNoHh2psup7imFItiN_j_VmmjVPBfwJzf040DTvZAwUDjNv1FQiLXFiSAANIxc2IegeKGCJvA==@protonmail.internalid> <CAH5fLgirYTV6K2QoH9LLwhHxJzz=h1R0jB4G2kpKQ_pBtBgePg@mail.gmail.com> <875xkn8k5z.fsf@kernel.org> <Z8lsetLbHvn-6cai@google.com> <Z8l1Zt3ibanzBhnX@mango> <Z8mHgyNxb6rv6Vhm@google.com>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: 9457a7d51cc28f552195fcc7feca8b2f81565b22
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 250306 1131, Alice Ryhl wrote:
>=20
> How about this:
>=20
> * Rename AlwaysRefCounted to RefCounted.
> * Introduce a new AlwaysRefCounted trait with no methods and gate
>   `From<&T>` on it. It has RefCounted as a sub-trait.
> * Introduce an Ownable trait with an Owned type like in [1].
> * Given an Owned<T> where T:RefCounted you can convert from Owned<T> to
>   ARef<T>.
>=20
> And there needs to be a safety requirement on Ownable or
> AlwaysRefCounted which requires that a type cannot implement both
> traits. Alternatively, if a type implements both, it needs to be safe to
> have both Owned<T> and ARef<T> references at the same time, which could
> make sense for a type that has one "special" reference and many normal
> references.
>=20
> If you want conversions ARef<T> to Owned<T>, you should add a new trait
> TryIntoOwned that's a super-trait of both RefCounted and Owned and has
> the `try` method for the conversion.
>=20
> Thoughts?
>=20
Yes. Sounds good to me. Basically what I had in mind. Only the naming
is different.

I will build an implementation like this and post it as v5.
I won't change the names of UniqueRef and UniqueRefCounted for now,
but more out of laziness than because of having strong feelings about it.
I like UniqueRef a bit better as our focus is on pointing out that
it is unique. But if you or other prefers Owned I can change it.
>=20
> [1]: https://lore.kernel.org/rust-for-linux/20250202-rust-page-v1-1-e3170=
d7fe55e@asahilina.net/

Oh, really very similar.


