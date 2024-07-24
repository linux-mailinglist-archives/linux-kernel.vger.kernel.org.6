Return-Path: <linux-kernel+bounces-261541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F13393B88C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 23:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 716861C2360A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 21:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D04613BAC2;
	Wed, 24 Jul 2024 21:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Ca5JPoC1"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6612A78C60;
	Wed, 24 Jul 2024 21:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721856523; cv=none; b=LoBFxFrdsKkN2/w7LJabxOqUn+z61eM0UyikELZ6OASmpG80wWoBLVabem1dwCR0yAKxD2icKDvNToNOPywj2yphMjQZBKt+E9wEo223pWvoUzZzkbbw7fET/AdBapHlB65SRW4RiDpve8M2YPWFaUSvmYEDRVW4u1EWTYM22DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721856523; c=relaxed/simple;
	bh=Vf3fE+rgeh4sr487bcYXxqmFeTCgoLgW3Kvu4Og1Hds=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IqiiLDB3JXxvCeCewK0P2VxTnyKvty6dkwlaAhClNeJ4uhl3hPtvHSy8midb7BSHGqErEa7f0/68HXnYcIgC56hkwWJMU8LZP+9re8PCLUBC0ryFNsqmhVHKyXof2KwWxrrG6zaCx1OFMtqG9a6QJ2fExfIeHeVGXAiYLmxXt2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Ca5JPoC1; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=3kbbsbbzunfqhimqqqhd3ddn64.protonmail; t=1721856518; x=1722115718;
	bh=xXiLed6ergozXPp2PcN9hocDnmxtkzfsDWa1YRl/GEc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Ca5JPoC1gKXatVg0Bwjrh4JRk8ssm/TcNMU090bqro84sRvAmNKfRYWic46EFIE3D
	 y3Cmmw7Abv6BYE8OoJXK23e+bE0+5+9LEBIJJ0mnf5cJxqSVZ3iFh5Wt/3XmuF9MQU
	 5IANEJHXzP3FcTUeIUHNqdvQ9BxEJ5r4dJw6emH5tngd4rTLyM8RZoMbLaMJb6D250
	 ZcaOXYKGfIaoEptWHPJxNyeP/QdePI2pdbXrXYLMq84NNIQLpY0D92d/9oWQ3ZoDx/
	 mOJVNF2e4h8rSput5BeF5KuIAq/tp0bGLuZDD2ctClF1nLNNEY47s1KUpOl/XQIIuq
	 1rBemHvArs1ug==
Date: Wed, 24 Jul 2024 21:28:34 +0000
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] doc: rust: create safety standard
Message-ID: <3bc99919-6658-43f2-986a-6d75c4e86ae1@proton.me>
In-Reply-To: <CANiq72nFo2qBpKfZp5vcsT3PHdrfP8WukTkpC4jCnYW7h9A6OQ@mail.gmail.com>
References: <20240717221133.459589-1-benno.lossin@proton.me> <20240717221133.459589-2-benno.lossin@proton.me> <99DF6A0F-BAE9-4341-8B42-6C1F1C69E2C6@collabora.com> <a5afc0ed-2193-42f2-a7ef-50fba68980a6@proton.me> <CANiq72nFo2qBpKfZp5vcsT3PHdrfP8WukTkpC4jCnYW7h9A6OQ@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: a52f517c4310b10a17d89dc202c77eac776563a5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 24.07.24 23:20, Miguel Ojeda wrote:
> On Wed, Jul 24, 2024 at 10:32=E2=80=AFPM Benno Lossin <benno.lossin@proto=
n.me> wrote:
>>
>> There are also several clippy lints [1] that we could start using:
>> - missing_safety_doc
>> - multiple_unsafe_ops_per_block
>> - undocumented_unsafe_blocks
>> - unnecessary_safety_comment
>> - unnecessary_safety_doc
>>
>> I personally think we should enable all of them.
>=20
> We briefly talked about it today -- others agreed on going ahead with
> something like the diff I sent the other day, so I will send a formal
> patch -- it has been a while since we wanted to do this (long enough
> that we were the ones requesting one of those lints, and it got
> implemented since then... :)

Perfect :)

> And we can keep the `TODO`s as "good first issue"s (I already updated
> some days ago our good first issue about it:
> https://github.com/Rust-for-Linux/linux/issues/351).

That sounds like a good idea.

> We can also enable the others easily, most are essentially clean
> already anyway, so I will send that as well.

Sounds good.

> The only one that may be more "annoying" is
> `multiple_unsafe_ops_per_block`. On the other hand, it could in fact
> force people to think about every "bullet point" of the requirements
> (the lint highlights nicely the different operations).

Oh yeah, that might be annoying if we have

    unsafe {
        (*ptr).a =3D 0;
        (*ptr).b =3D 0;
    }

So it probably is better to leave that one disabled.

---
Cheers,
Benno


