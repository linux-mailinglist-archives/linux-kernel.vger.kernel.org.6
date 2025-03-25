Return-Path: <linux-kernel+bounces-575439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 328A3A702B7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 696AC845E2D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342642580C3;
	Tue, 25 Mar 2025 13:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Y2mCk6Bs"
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443EA2566FB;
	Tue, 25 Mar 2025 13:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742909669; cv=none; b=jJgM3Gyjk+8cOR+VAf8TSVJqkuW58trC4o8/YS+3d4/jvi/GPW5CtcUFjWH1rMUMG6z9/prwf6ze5RUty+00IV1QaL5vppTFKDWEGsqCqvHoQAYwrTfVriue/ORVtoL5d/ut6EJIOnUXOcrC8rt/Uda/yxGnHFqxjUYb0Z037iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742909669; c=relaxed/simple;
	bh=Y6ohaXZofpcbNJmvladlvZbrb57HSiO9YoS6iQ6shPs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GT05Dr6BWT+WDHbwQjr5fN33l1aoAqxHGPXWR5kVUAPrcXl8bdjQrVb8gPOneiv3ANgpYQj8wxVtPFN4sCYjASSucd5UUXpWDuL7AE3lCpB/plVt9CvpIMJayhJr9G92eR7tQwl1VxBb9hTTDT2hnDNJAsCwDqUx4igvLwsfDew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Y2mCk6Bs; arc=none smtp.client-ip=109.224.244.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742909665; x=1743168865;
	bh=fBZCEDHAcSL+1EbOgZxoUlg+Dt3iseMvxCTdjaU5e2k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Y2mCk6Bsht9m4LjOmW4sD+suqGIEUvFB756jiYzHmc5Bl8t+AGhghMMNSW+S63j+1
	 3LYAheh7+xAhJCaq8VDAEPoMmAGGT60aiIlX5JE+vl8+2d83bicwl0KJEqFjQUPZ0a
	 KYrl1NdezKacZcngfg/2ojIB7S3hkzo8dnuVOdZpEShTlHrBBlbClcReXQLzAWKxED
	 48L/uQxWukjWmIyvW0h0cdlJR6YB+apubucGAyNik6vIM/WPvlRwq5QgdLQqUAOY6j
	 DCHbZ4V+Zm+gWvZEbDT/+LGR8OXwksoSVSuzwm8ibZvKU9/FoWMo61VmxEgISLg5G6
	 wrwOkurY1tfeA==
Date: Tue, 25 Mar 2025 13:34:20 +0000
To: Filipe Xavier <felipeaggger@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, rust-for-linux@vger.kernel.org, felipe_life@live.com, linux-kernel@vger.kernel.org, Lyude Paul <lyude@redhat.com>
Subject: Re: [PATCH v2] rust: add new macro for common bitmap operations
Message-ID: <D8PDWRH06U1X.3JGHP1311BPPY@proton.me>
In-Reply-To: <20250325-feat-add-bitmask-macro-v2-1-d3beabdad90f@gmail.com>
References: <20250325-feat-add-bitmask-macro-v2-1-d3beabdad90f@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 1a89859a739abc0b62f06d31b08d5c5e735c24cf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue Mar 25, 2025 at 2:10 PM CET, Filipe Xavier wrote:
> +#[macro_export]
> +macro_rules! impl_flags {
> +    (
> +        $(#[$outer_flags:meta])* $vis_flags:vis $flags:ident,
> +        $(#[$outer_flag:meta])* $vis_flag:vis $flag:ident,
> +        $ty:ty
> +    ) =3D> {
> +        $(#[$outer_flags])*
> +        #[repr(transparent)]
> +        #[derive(Copy, Clone, Default, PartialEq, Eq)]
> +        $vis_flags struct $flags($ty);
> +
> +        $(#[$outer_flag])*
> +        #[derive(Copy, Clone, PartialEq, Eq)]
> +        $vis_flag struct $flag($ty);
> +
> +        impl From<$flag> for $flags {

Please use absolute paths to refer to items, in this case
`::core::convert::From` (note the leading `::`). More cases below.

I filed an issue to add a new clippy lint to catch this:

    https://github.com/rust-lang/rust-clippy/issues/14472

---
Cheers,
Benno

> +            #[inline]
> +            fn from(value: $flag) -> Self {
> +                Self(value.0)
> +            }
> +        }


