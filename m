Return-Path: <linux-kernel+bounces-279009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 228D094B7C0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBB031F21A87
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4FD188006;
	Thu,  8 Aug 2024 07:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="lZuqVuBA"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A514443D
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 07:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101825; cv=none; b=D8sGrURqxbaw+VpgdNm4/uR/9by8AqmXT1vFS2OD2a0cgRtbjXtkGxCwsAC2ZywMHoL+cr/XL1Th0V+AxJ2iAPdOOJ2sBTz6xC2VZ9VSVEUeyEXXsoFrE5h09+yxQt8ey3eiZGsBAf+yz+0vu91YTlTMhxbvNeAnWBuemKBCwyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101825; c=relaxed/simple;
	bh=D6RiyQPc6iIE+hdVJNJNeUNwAVhfVqgT+Pe+C9Y1kmk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=upzoYnJCHMeWkiCpY6CHNBpdo1nwkrSHy8Ydj9ZbQ5aNw0TL3SlwB6ioirOh1vandx4OA/Z0fzrA+FzJ8C24943dpmUmxAonJ7oCCDuxc0frYbsbDWYMifEXa8q7rOjV0wn8ZFtYkFoY+ZY+ZEgmHN8ef008VEkynqe4ByEeXuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=lZuqVuBA; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723101816; x=1723361016;
	bh=VDBYMTYmF1oXsP8HDVQe5zY6DMj6ZP0pIwM8+fNBqu0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=lZuqVuBAlvTTtYmY28LYemK0HAMsVfDzFKp8f7Q9WapEZ9ANpdXXTjB+k+fVNE9gR
	 ceCbdKh2+Ymuji6sqBryLB0x7zLqitrp7qHOCVzxVcbs7OeH+iWkWhGdYIKNHe+mTJ
	 LD+p6edh5Se02bSAi2fk0zzgqZZ2i4p/jaqliAXBclCtv2UMa6g71nCeuRm6Vdp2Km
	 xD4Esi0N2U6YRud2mblDCfAZMf00U53u7yfdeEZdW1ZRa9/cjRnDMnxPvNgH3HzNmN
	 KvJYcbOd2ytlR1/5ZwVpqlnoVclKh3ya/3eqdt0kQhhlElb/NdhXBkDxYn9RMZCrM7
	 JlBWoP2RaOpiA==
Date: Thu, 08 Aug 2024 07:22:48 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 26/28] rust: str: test: replace `alloc::format`
Message-ID: <51d38447-9906-42fd-9e5e-b43983d3a366@proton.me>
In-Reply-To: <20240805152004.5039-27-dakr@kernel.org>
References: <20240805152004.5039-1-dakr@kernel.org> <20240805152004.5039-27-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: fbf5fad7a5e932020ec3969eec09c8bfb6ad1b62
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05.08.24 17:19, Danilo Krummrich wrote:
> The current implementation of tests in str.rs use `format!` to format
> strings for comparison, which, internally, creates a new `String`.
>=20
> In order to prepare for getting rid of Rust's alloc crate, we have to
> cut this dependency. Instead, implement `format!` for `CString`.
>=20
> Note that for userspace tests, `Kmalloc`, which is backing `CString`'s
> memory, is just a type alias to `Cmalloc`.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/str.rs | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>=20
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index 0b6ffbade521..8f234224cbf5 100644
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

Don't actually think we need this newtype.

> +
> +    macro_rules! format {
> +        ($($f:tt)*) =3D> ({
> +            &*String::from_fmt(kernel::fmt!($($f)*))

We could just do this:

    CString::try_from_fmt(kernel::fmt!($(f)*)).unwrap().to_str().unwrap()

---
Cheers,
Benno

> +        })
> +    }
>=20
>      const ALL_ASCII_CHARS: &'static str =3D
>          "\\x01\\x02\\x03\\x04\\x05\\x06\\x07\\x08\\x09\\x0a\\x0b\\x0c\\x=
0d\\x0e\\x0f\
> --
> 2.45.2
>=20


