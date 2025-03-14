Return-Path: <linux-kernel+bounces-561207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F1DA60EC8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D22A4188A343
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326A01F3BAE;
	Fri, 14 Mar 2025 10:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Cm5QjtWb"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65181F3BBA
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741947960; cv=none; b=KVk4vv4uI3YO5+cs1rpmjgg+6v/CynxQWI7nDpaDHyfV2hp6o8PETrHElw3ku9Y5yk9vZLo3g6jZjJul5PMX7KEmAH60hFb7eCGYx9pcyGrYBeruBit3CCdNBRfJaHL+7pYpj284tahfSRcqVCIMfOcLLsZyJDpsbcOpgex13/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741947960; c=relaxed/simple;
	bh=gYqLASBJWp7lKKB+wKpO55ak9ZSRt6st4jHwIQSkJck=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lL2E1CdHH5lQ0ObQtx7R6shR1+LP7OVjkPcUqHeGFssx0qq7/WONjAZYdnZmx/3SHKLgh06z6GTlwfzFx+uT9TlLI8JjXmcenMotKxwRWIC2SF6i/JSzSlj4T3fhVpYNkovKBZIe28zZYk2NJIkOc/6Qeq4fSOwr1Whm17iwmSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Cm5QjtWb; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741947956; x=1742207156;
	bh=4mIkyzXkCTSZba7X1wr3G/CQrEkzemtSQxmn8eJlyXQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Cm5QjtWbd0ZnDKEV8/EkpkV807ESbd4pvoIVpXg4pSh8UhYKlROj5EnNcMWf8mYFy
	 /i4TZFAYpQz+RM5F/ZxnAjKxkaiU4+cjZ29ISzJ6+5WtzZaqE7Q7sEgOcRk+IWLzjj
	 VCWUwRxWQ6eTj5B5mA5RI3EsI6nIE75cA7krCVuQZ4khm5WrAozno3fVFNCS+NcVQ5
	 pdtmBpmErEO4PCAyMeEaWRMrsHb6OnOQJgSCtejn3uCz+XLa++I8L/Fq9sWo9qyBxx
	 3qDGyGnyMubQrtJQInYToGiB8pF7+k4Pjmj4u2BU0Dl13JB7/IcF4n3AGHRti+CuMd
	 yZGmVASPsTPKA==
Date: Fri, 14 Mar 2025 10:25:52 +0000
To: Antonio Hickey <contact@antoniohickey.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] rust: clippy: disable `addr_of!`, `addr_of_mut!` macros
Message-ID: <D8FX0ETYS1IR.2ZEPASOQMIOVW@proton.me>
In-Reply-To: <0100019592c26506-b2399cba-7bdb-4c0b-9888-393a0576a127-000000@email.amazonses.com>
References: <010001958dfeacb5-9039aaab-6114-494a-9f1d-f13982091169-000000@email.amazonses.com> <0100019592c26506-b2399cba-7bdb-4c0b-9888-393a0576a127-000000@email.amazonses.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 9c53b29ec43a576bb3887b4f480f3b41bf955824
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Mar 14, 2025 at 4:46 AM CET, Antonio Hickey wrote:
> With the `raw_ref_op` feature enabled we no longer want to
> allow use of `addr_of!` and `addr_of_mut!` macros.
>
> We instead want to use `&raw const` and `&raw mut` to get raw
> pointers to a place.
>
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
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
>  ]

This patch still needs to be done *after* the third one in order to
avoid warnings (since you're removing the usages of `addr_of[_mut]!` in
the next patch).

---
Cheers,
Benno


