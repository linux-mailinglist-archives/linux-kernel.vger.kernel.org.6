Return-Path: <linux-kernel+bounces-328289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE33978179
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 15:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E25231F2538B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 13:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5E51DB93B;
	Fri, 13 Sep 2024 13:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="bdDo9gnE"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25F51BDA85;
	Fri, 13 Sep 2024 13:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726235243; cv=none; b=R+GNnOIf+Wybpmyetm0SGapYdIEkKtb9NHrSWXxBBMKO54fW3uPsdqxkjgJTgaYE8jg+4J9BlykkW4z83Xzyl9HJ7YZNOcHnFxihzsnrcFJ30k1M2yo4LR7jwzJ3PdX+N7tAGDngGmw4LUPzr2cdo8YtPTnW/pkvEcZJOao9xeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726235243; c=relaxed/simple;
	bh=WYyA5Vp4yB2SzAq5FgsNLkWXyhNzcdO7XMVLMGkAFZE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gfBqMFN8kXF/Pz9Jcauwss8NyHJwW0zIyNC81Ydn2Jzh5AATJ2rW5wXZccSdGYcwxK9w+G3TVdScv0KdAtvwFxVuSOxIADlU2NN0UDgtQDtUqbBATxm8rVLCokjSz0EjxGK+bnUD8JNzoHTHL6Xn8TdLsQGib66DztgVwlrVFH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=bdDo9gnE; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=t23qmclnbfdk7ikjffltxnilny.protonmail; t=1726235239; x=1726494439;
	bh=SL3UlF5etkuUcpUbBrRU6HGec8qwa3J9DFhxx6wKbmg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=bdDo9gnE0o/bZQrzRUryK5khH6tmq6pRw9ow7rtComZG5xYF5MofCkMkRo6s+400+
	 KOW+nAfCyf9TTWTPnjlmcwwbCn6mZzRfKnVBqTTO0u9Qo1Kma5GcwfqFbf6rQWTxhq
	 ZUvM7jhMawYmJuvZO9LgwQ21IhKXBY/oCCSd2IbsPvq2IHKC0m5lk28qtHzVcDAJjq
	 fFfLXH+Z2MBynPPx9gAwQogl6tkC2Mat1sY0JZLi9fkxu/TjOyRKsqNjhZijGXIDRr
	 7X9zF7ZbWCj6kTlGgT0wthPdu2+Jvm7APrns1QuThmXZS5UIHDsXESoNq+f9MNgQ5E
	 JWux13PkN42VQ==
Date: Fri, 13 Sep 2024 13:47:15 +0000
To: Finn Behrens <me@kloenk.dev>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Greg KH <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] rust: add untrusted data abstraction
Message-ID: <5f60a885-733e-4434-ac5e-a70005f11382@proton.me>
In-Reply-To: <EE2A76E7-58E6-40E5-9075-48A169292250@kloenk.dev>
References: <20240913112643.542914-1-benno.lossin@proton.me> <20240913112643.542914-2-benno.lossin@proton.me> <EE2A76E7-58E6-40E5-9075-48A169292250@kloenk.dev>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: dcd4c3c2fd7e5b9edafd8fb86ab173433798d0dc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13.09.24 15:41, Finn Behrens wrote:
> On 13 Sep 2024, at 13:26, Benno Lossin wrote:
>> +pub trait Validator {
>> +    /// Type of the input data that is untrusted.
>> +    type Input: ?Sized;
>=20
> I would like to explore this trait with being generic over Input, instead=
 of having Input as an associated type. Might be nicer to have Validators f=
or different input types if the valid data is always the same?

I think I have changed my opinion on this from Kangrejos, I like the
idea. Then we would also be able to do something like this:

    impl<I> Validator<I> for Foo
    where
        I: Deref<Target =3D [u8]>,
    {
        /* ... */
    }

---
Cheers,
Benno

>> +    /// Type of the validated data.
>> +    type Output;
>> +    /// Validation error.
>> +    type Err;
>> +
>> +    /// Validate the given untrusted data and parse it into the output =
type.
>> +    ///
>> +    /// When implementing this function, you can use [`Untrusted::untru=
sted()`] to get access to
>> +    /// the raw untrusted data.
>> +    fn validate(untrusted: &Untrusted<Self::Input>) -> Result<Self::Out=
put, Self::Err>;
>> +}
>> --
>> 2.46.0


