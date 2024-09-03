Return-Path: <linux-kernel+bounces-312679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A952B9699B5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5DE21C21E76
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C04E1A4E88;
	Tue,  3 Sep 2024 10:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="gpQg/DYF"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0884C1A0BF7;
	Tue,  3 Sep 2024 10:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725357987; cv=none; b=q1FEs9pFGK4km9OA7kB3Gw2ifKjGm4nKcAKSiYVhg2g2IAty/WydiLDLLH9CCiQdWYIls4UOS3J/kJg/n1CxoXSvmi2iPv0fLdmphJ+zzjkndg8/ZfD2IHHDVaQvwklyVlSz3SsD0stAXi7j/FuoO/gR8jNu08U5pDCyeTHoLZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725357987; c=relaxed/simple;
	bh=KV21/ik3Jm18GV7wwEWiBlSC71Oxh9A34Pib2Xed/GM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dmZ0t3ukAvjhPCz70pkhiSsSLaDpk+6vktRP1RIgud6GsKE5ygOxHtIzjYBmpG33ERD3NHttC19xnYWLyQVXMLEiHf2mHdPE2PaqsCd1yO7gGTTLQq+SueJENINytjJ4FxmAR9tqyqM+0YolklQxKfZMjTWsDBSx6aApT2cqKHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=gpQg/DYF; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1725357982; x=1725617182;
	bh=KV21/ik3Jm18GV7wwEWiBlSC71Oxh9A34Pib2Xed/GM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=gpQg/DYFnoTcnW9v0uhP3YReAVtz9hwYtm1vJPVFHABwVy0DUQcUZf6tDhrbr7dlf
	 U5mIdKbo9SlcB+FA5q6rfs0germUGiCZVoqhuxHOVHaB5Bqxwi/wfsAF9qnzEzo4Iz
	 G8GuWo7cmFbPeLjRWVLXBgl+Ty7ElaLPumnh64SxxXYUelBbO5V14KeoCzmhwxNMdp
	 6YFH53n9JhvpaFzvISBEjcasj/BGE7GIItPAib9PWyTsEO0tMvImuGslOg60O4RJwh
	 4EWT9ue7qZypE7bYc6VoMbZj/uO4suB/MnKena///MVfqqPQKuixtjnQJnP1bBQXXt
	 4Q8VmCZbNmVQg==
Date: Tue, 03 Sep 2024 10:06:18 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: sync: require `Sync` for `Backend::GuardState`
Message-ID: <ca2e865a-f0a2-488e-ab0b-53ef5c4e95b3@proton.me>
In-Reply-To: <CAH5fLgjicT5O77UviXUPxc0-O7nQO4J+M3Nfo+6Mm-DVGQBhMg@mail.gmail.com>
References: <20240903091700.172734-1-benno.lossin@proton.me> <20240903091700.172734-2-benno.lossin@proton.me> <CAH5fLgjicT5O77UviXUPxc0-O7nQO4J+M3Nfo+6Mm-DVGQBhMg@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: d64e1e0d3e51bf0c9eb219a1e35f34a8f230e242
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03.09.24 11:32, Alice Ryhl wrote:
> On Tue, Sep 3, 2024 at 11:17=E2=80=AFAM Benno Lossin <benno.lossin@proton=
.me> wrote:
>>
>> `Guard<T, B>` implements `Sync` when `T` is `Sync`. Since this does not
>> depend on `B`, creating a `Guard` that is `Sync`, but with `!Sync` state
>> is possible. This is a soundness issue, thus add the bounds to the
>> respective impls.
>>
>> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
>=20
> Right now, a `&Guard<T, B>` has exactly the same powers as &T, as the
> only thing you can do on the guard with only a shared reference is
> deref to a &T. So the bounds are correct as they are, unless new APIs
> are added (which seems unlikely?).=20

Right, but I thought it was strange not to require that. Since that
would be the default behavior of the `Sync` auto-trait. And the only
reason why we have to implement `Sync` is because we want it to be
`!Send` with the `PhantomData<*mut ()>`.

All of our locks currently use `()` as the guard state, so we don't lose
anything.

Maybe it might make sense to instead have a marker type that is `!Send`
but `Sync` that can be used here instead, since then we could avoid the
`unsafe impl Sync`.

> But the safety comment could certainly be improved.

That's why I stumbled on this :)

---
Cheers,
Benno


