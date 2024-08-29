Return-Path: <linux-kernel+bounces-307472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D886C964DED
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76C87B21895
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B677F1B9B26;
	Thu, 29 Aug 2024 18:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="j1+mGw1p"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873381B8E99
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 18:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724957009; cv=none; b=LLkDK/sR4g7ZEVLLYVaxqSlU4x7brrBHkJH/sgHadnTefodz6tKugzcAbE/eENS6CkwNTGE2LMpStyXpakvQoGUuS+HLHJTHA5oI82B0l5XkSuXRvsdLOeIXpfQBY/3CT4shmfBiDBBsRCbG5mt+ixck0j1zLK4BRyqFpss5ZQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724957009; c=relaxed/simple;
	bh=b5iYG9c3pe2iQ/IrNCJUWEzqa3Q76JEhhDwYWKGw9aA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BZZ0mkyEtdu7peh9l4Xz6Unc6U0OraF7gEyNrt3BaanAkp14MpokfZwH1HIuR1D2dyBMVY6NGXY50Gh+xT6AmHPoQxzMfgv6TPULtOq46lg5ntovTqnyrQKYYvlnSTvmB1jzCD1HkNTnxLjpQzIVW2sXLXxClYcbOeQKLxzhjHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=j1+mGw1p; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1724957005; x=1725216205;
	bh=PrOIXUmPfGYqq2ocopMHRuco9LPY6PWH9M8dhHPmIts=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=j1+mGw1pPF4UxjdWVxpIsSVII1MPS73G2KyaNUae/ktsbUVLOVOxfW7h333MmzjSN
	 S4Bj0GTw4F4FU2t6uTa/tW2o8+ePc9v/scJybd29px4EMfKNADnEYoT0Q+HXi+g/aP
	 GuJmMs2dlDX0tm09MkS2/tCFjUybkZRu2VnUR6uylydH+D2vG3YfHH1+PiRdHYTrHA
	 PQSPSxUFza/b4RdcSoJ49PDlGJkC2CaUn1VjVaxBPPM4uD6h+SV3EDJgFRxJlPU4jj
	 L7w+Djw5CcBl1Hs64XXDfLK9VvL8D34Dx6HEGmNqXYgtVAcMWJNWBK5fhWVYPzJbec
	 4cxrwtu3pGfrg==
Date: Thu, 29 Aug 2024 18:43:20 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 23/26] rust: str: test: replace `alloc::format`
Message-ID: <1e36b27c-fea6-44a1-9956-14916e5cd3f9@proton.me>
In-Reply-To: <20240816001216.26575-24-dakr@kernel.org>
References: <20240816001216.26575-1-dakr@kernel.org> <20240816001216.26575-24-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 63d698293bc76c54053ea8df5e5851aebf3e9acb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.08.24 02:11, Danilo Krummrich wrote:
> The current implementation of tests in str.rs use `format!` to format
> strings for comparison, which, internally, creates a new `String`.
>=20
> In order to prepare for getting rid of Rust's alloc crate, we have to
> cut this dependency. Instead, implement `format!` for `CString`.
>=20
> Note that for userspace tests, `Kmalloc`, which is backing `CString`'s
> memory, is just a type alias to `Cmalloc`.
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> ---
>  rust/kernel/str.rs | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>=20
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index 209ad1bb1a49..726329530338 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -523,7 +523,28 @@ macro_rules! c_str {
>  #[cfg(test)]
>  mod tests {
>      use super::*;
> -    use alloc::format;
> +
> +    struct String(CString);
> +
> +    impl String {
> +        fn from_fmt(args: fmt::Arguments<'_>) -> Self {
> +            String(CString::try_from_fmt(args).unwrap())
> +        }
> +    }
> +
> +    impl Deref for String {
> +        type Target =3D str;
> +
> +        fn deref(&self) -> &str {
> +            self.0.to_str().unwrap()
> +        }
> +    }
> +
> +    macro_rules! format {
> +        ($($f:tt)*) =3D> ({
> +            &*String::from_fmt(kernel::fmt!($($f)*))
> +        })
> +    }
>=20
>      const ALL_ASCII_CHARS: &'static str =3D
>          "\\x01\\x02\\x03\\x04\\x05\\x06\\x07\\x08\\x09\\x0a\\x0b\\x0c\\x=
0d\\x0e\\x0f\
> --
> 2.46.0
>=20


