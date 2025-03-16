Return-Path: <linux-kernel+bounces-562934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C528A634DF
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 10:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925AF1890201
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 09:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA57019E96A;
	Sun, 16 Mar 2025 09:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="FQ8oIfsE"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2B639ACC
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 09:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742118667; cv=none; b=LBQTUQPkLVsGLXYgXv0T0o7AqtKzEXN9sIh87Of90Xj9JvL+QZ2HKQUYTflxVmlVBy+0t0caJw/Aw5hIAuZIlf7Zh/xreeuJuPdgnbDAbmDycNyECZHUq4Lfv+XJVkQTGOuYMjUYtlj6djVcALSt7vKteWPT2SWAX9GU3MxWoBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742118667; c=relaxed/simple;
	bh=6kayc2r8eJVIEoEew7NeuDUXed7Dx09O1AhD97Wu7tc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mIFOdy+CmNfKHpbleRWLWYpcBzgZoZCb7bfE5f8A5YQE19BKhT12SOPPSiEytyEDixdnhNV1NcogCyWNutBmJu3qp2GniFmYEP/WYwgA1kApNNppv7bNJs6QLTR9brmNBHpt4s6RhO+Nxay2shjrPNw/iHlcv0lNCKIKbJoBI1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=FQ8oIfsE; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742118662; x=1742377862;
	bh=AdWXIraUGutx1L6OwpS74BqKCyD2D2IKT8sz7HNyUxw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=FQ8oIfsE+1C3dHh0cloLbCrOHKtONy6S7fDBrzJoVsd+i500udlPR1jH4Lh/WDLqH
	 ShrzDnbHBadDorujbNmiEptB514Hf5PgFwpQv9i+R7lWLcHZzW6GXJSJnSqScbOhKI
	 sCiaSyzgGBorRqn17sF7J970AxEaF3wTwnUZFJrrzBqxCse0X80VFbD1kM0tKxQj8h
	 4PX0dqdEuXkyRzGQnPBQ/IagkFok9AicSzXXKHdqSbgWPrKlSqSE29G9gBtg6huu6Z
	 valIs+nrTYtxHRhWiLfR/MBSZ4PJA8uo+BviTXZa171CgQRyXVIy+d9W22yoCWUXMj
	 SOwEUn/sPbPhQ==
Date: Sun, 16 Mar 2025 09:50:55 +0000
To: Antonio Hickey <contact@byte-forge.io>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Antonio Hickey <contact@antoniohickey.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 16/16] rust: clippy: disable `addr_of[_mut]!` macros
Message-ID: <D8HLIR6LSOYB.1RC5ESP2Y0HWG@proton.me>
In-Reply-To: <20250316061429.817126-17-contact@antoniohickey.com>
References: <20250316061429.817126-1-contact@antoniohickey.com> <20250316061429.817126-17-contact@antoniohickey.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 845761705b6e8bce4c2d3d60a940b717accc5672
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun Mar 16, 2025 at 7:14 AM CET, Antonio Hickey wrote:
> With the `raw_ref_op` feature enabled we no longer want to
> allow use of `addr_of!` and `addr_of_mut!` macros.
>
> We instead want to use `&raw` and `&raw mut` to get raw

`&raw const`

> pointers to a place.
>
> Note that this lint isn't currently reliable, but we enable
> it nevertheless because:
> 1. Document that one shouldn't use the `addr_of[_mut]!` macros.
> 2. When the lint becomes useful we will already have it enabled.
>
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://github.com/Rust-for-Linux/linux/issues/1148
> Link: https://github.com/rust-lang/rust-clippy/issues/11431
> Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
> ---
>  .clippy.toml | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/.clippy.toml b/.clippy.toml
> index 815c94732ed7..95c73959f039 100644
> --- a/.clippy.toml
> +++ b/.clippy.toml
> @@ -8,4 +8,8 @@ disallowed-macros =3D [
>      # The `clippy::dbg_macro` lint only works with `std::dbg!`, thus we =
simulate
>      # it here, see: https://github.com/rust-lang/rust-clippy/issues/1130=
3.
>      { path =3D "kernel::dbg", reason =3D "the `dbg!` macro is intended a=
s a debugging tool" },
> +    # With `raw_ref_op` feature enabled we no longer want to allow use o=
f `addr_of!`
> +    # and `addr_of_mut!` macros, but instead use `&raw` or `&raw mut`.
> +    { path =3D "core::ptr::addr_of_mut", reason =3D "use `&raw mut` inst=
ead `addr_of_mut!`" },
> +    { path =3D "core::ptr::addr_of", reason =3D "use `&raw` instead `add=
r_of!`" },

`&raw const`

---
Cheers,
Benno

>  ]



