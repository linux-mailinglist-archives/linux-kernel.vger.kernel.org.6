Return-Path: <linux-kernel+bounces-267949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8AA941D6D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18412B2872C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0759718A6AA;
	Tue, 30 Jul 2024 17:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="RQSi7w7m"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8827E18454A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 17:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359690; cv=none; b=SlpJv9e1tu146GQEp6lps3PLGbXQZNT06BFxb18/QCpzHyMrGgLjKimAchk8IIOgbK4VnERm0g1RRlCFjzLnI/4QdaPcaH/QBBYb0Cbs8YwD9nMAGPSGWpot5chtu6TVo/oxAGdrD/IbEeDZrnkpxgZq79oLVrMx5XrC4c2KhmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359690; c=relaxed/simple;
	bh=KDWE+vS3sKHAOFqWjXQLBPxwh9m0A/9p2hkTp6D+Bko=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eao4cy6h6zxeskTTGmzvvn15KOWLt1P2Ec1ReFjq045/+AFjAbXQ6JtIJLtdXlb8fielfJ2arZ4bm32d3l86UKxpx9/a2WEmqIc4Iplb40Jei5rnmGOoBHx4BYwu//65ZVSl/O/JW7Iz48flLWgD9+sjzb5gp8jLEkcW5DyNDGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=RQSi7w7m; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722359685; x=1722618885;
	bh=NGinwHKyoFpi7Py4DC1kYgOPoqTKF5dlqT9ieC+Ma0g=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=RQSi7w7mKrGo6aZxTcLyfyob2Imgwdse4PYvKvU65m+RdoXZA00U9st25nr1cQ67B
	 zzF8SX+DH2RKVSzuTGD4PLvCLbfUwKDgLxlV5kbX03+SpMBwRgrE1Nrqx87ROCZBxQ
	 yPib0a1fCXBhGnZCI2ITdxFdej4TwnSzzKXknH8OtPJ+hduxhUasyeWZyXgTUpqxmH
	 1oe35T6Q9KiiBX6ncADVQWwx4OVVti7fpiRX0de4W48fw28x8G+vaRmw7MCb+9us7Z
	 tNypGDAWHAjw1UemNKbLKeHGfworYpQF+fv++7B1VgNV1xHIriMX+d4GprbXYE+uLv
	 ddTQ/NL7HPYmw==
Date: Tue, 30 Jul 2024 17:14:39 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: implement ForeignOwnable for Pin<Box<T>>
Message-ID: <5c49f604-34c1-414f-bf9a-92837c6e07b3@proton.me>
In-Reply-To: <20240730-foreign-ownable-pin-box-v1-1-b1d70cdae541@google.com>
References: <20240730-foreign-ownable-pin-box-v1-1-b1d70cdae541@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 17966ed4ed650d191ff32ffbc5e393127d9a199e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30.07.24 15:06, Alice Ryhl wrote:
> @@ -89,6 +90,32 @@ unsafe fn from_foreign(ptr: *const core::ffi::c_void) =
-> Self {
>      }
>  }
>=20
> +impl<T: 'static> ForeignOwnable for Pin<Box<T>> {
> +    type Borrowed<'a> =3D Pin<&'a T>;
> +
> +    fn into_foreign(self) -> *const core::ffi::c_void {
> +        // SAFETY: We are still treating the box as pinned.

I don't think that we have the guarantee that the pointee at the pointer
that is returned by `into_foreign` is not moved.
AFAIU `ForeignOwnable` is used to store these pointers in C structures
and never to actually access the value behind the returned pointer. So
we could add the requirement to `into_foreign` (thus making it `unsafe`)
that the pointer should not be dereferenced/used aside from `borrow` and
`from_foreign`. Otherwise I don't see how the call below can be OK.
What do you think?

---
Cheers,
Benno

> +        Box::into_raw(unsafe { Pin::into_inner_unchecked(self) }) as _
> +    }


