Return-Path: <linux-kernel+bounces-562526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E4EA62A8F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 10:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 433DB7AD0AF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 09:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA211F76CA;
	Sat, 15 Mar 2025 09:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="PwFmLOnI"
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA1615098F
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 09:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742032769; cv=none; b=CTIAv3UnrAB1AbxgkfIfZbmfvqrtaphivuBt3fsW5rr0GxHDQbPdDMzG4oAuzqN0CnhEf6Sl8pcBU6H84gims9bj7u75FcmBvkxsubBVo3Ul3hUPxC64xZ8lv4KL/hdPqUuq21XOdYwIiR+U3ChRzIEM2FgV4W377uleb2Lv1PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742032769; c=relaxed/simple;
	bh=ceK+2LHucScSesExkMNpKWtYIeHc8VxmKVdHDkRAwmM=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=hwEzxQRa7dOpPeSeeF/rf8T98+bnjlPhrmpxr0IuZwi6jtyl8zHewbwJWSzHc1o6AbtJTUoZT52W83ZAeYOwio11TfWVKSR3tvtspB/Jc2B3RQDYB/oq4823aKJJqIblC53zZPTyULQfmuDhFOMNlNPSwoI3TXzCQVgfW8XzfCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=PwFmLOnI; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742032765; x=1742291965;
	bh=umMDDdD/DyhUTEkQ9Mzw36CyII6AjHon398barZQATU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=PwFmLOnIk1oLvtD/s1l/Z0z6/DrlDDLrcETg8uo5OyVQlz4ESsVTGuUG+xmqd2JyM
	 HzHJVEGcekIEqix1HAHzqBCrKmVjfz2lsDADWR5RCepL4fldxdOsrXvNjUMDWeDrRF
	 Bf40rIYx9LvL/U6fgp6eR/OB8FsetJOcoddEEUFeI8dgvgPShAFfgOR4x4dRRSuh1o
	 5MfanuoUWsPzbH2MA3Tl0PoK/DJ+zEuTwK4V0eG9vo47Qa4juZvqMZPbaxIix19cIc
	 zvES/yTOHthPmj6m5ARzQ5XC/n4I2EQjmM4OYzIZSSslOm2xm8dU3m+E+6KinK8C8P
	 IL1dQgxW7N3cg==
Date: Sat, 15 Mar 2025 09:59:19 +0000
To: Antonio Hickey <contact@antoniohickey.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Benno Lossin <y86-dev@protonmail.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] rust: clippy: disable `addr_of!` and `addr_of_mut` macros
Message-ID: <D8GR2N2YKX3C.OCX0JXEJ5T@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: e5ce109781cd7969ba316c8197dad415ad27a8ba
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat Mar 15, 2025 at 12:41 AM CET, Antonio Hickey wrote:
> With the `raw_ref_op` feature enabled we no longer want to
> allow use of `addr_of!` and `addr_of_mut!` macros.
>
> We instead want to use `&raw` and `&raw mut` to get raw
> pointers to a place.

To what line length are you wrapping this commit message? I usually do
72 (and I think checkpatch also checks for that?).

Also it would be useful if you could link to
https://github.com/rust-lang/rust-clippy/issues/11431
and note that the lint isn't currently reliable, but we enable it
nevertheless to 1) document that one shouldn't use the `addr_of!` macros
and 2) when the lint becomes useful, we already have it enabled.

> Suggested-by: Benno Lossin <y86-dev@protonmail.com>

Please change my email to <benno.lossin@proton.me>.

> Link: https://github.com/Rust-for-Linux/linux/issues/1148
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

This should be `&raw const`. With this and the above changes done, you
may add:

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno


