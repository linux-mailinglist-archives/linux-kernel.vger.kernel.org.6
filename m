Return-Path: <linux-kernel+bounces-559466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 822BBA5F411
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606B63AA762
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F0D266F0B;
	Thu, 13 Mar 2025 12:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="GnjXo0pp"
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2701F152C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741868203; cv=none; b=lX5p8MQqtRCI4i1CJMaRwLK9a8IZn9x3vR4FepkMPLdEuFWaFjhQ/ObepbfDUEKjbbSVeheYCGYBnHyvod2X/wnoW0Y0duvYbsCwmtAzcs7ALUB0JjbG68HcCWa2kqO2kx7BGmNTIpwVQRuC2Ov5/24mWAOKB4to8lQ2sK5QmBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741868203; c=relaxed/simple;
	bh=6Ihq3TRneJiNAk4QFLA5VesY1pTHSk2FgEMblmXa4Do=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=qr8qHCDKPLEGu8vMtyJK1int11/Lf2u7BQsJ9SY7fK68kfUi5dEweeXrvxF/5QHSi7b4UiUocUJMSvbIxkOUGex6BOgp78E4XGY2Gs2uP9ziM4UU9MsMU35dmeBg5N2L/waiJOjQfLlaNnbfpgHgHF6hsLeKmZr1ZziPe9kvMDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=GnjXo0pp; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741868199; x=1742127399;
	bh=dirxnGmWiiGKujQvdv1ZgPNJZJGFDcn3EI/aHCniaEs=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=GnjXo0ppoNIVUZ1RzT/Tju6bWRSUMczKXpu2GK3cE3eRl7gAMiHY1ForNuH1sL2Nt
	 g9ozrsheCoAzpD4XqWH2Z8aPU32zFEX/EhFsRRQDdz/Bhg1evD96Ci7PpvZheh41PP
	 zbvMz7DRL6AXjYzzVvcdlHpU26sc7vznsW7QD2W3PdDaRQJQhvK+krzfT2zA4wjOL8
	 0KBW+XQEVI6lk+99pQpCnDxdeoJLwKVPwJwV/7NtV6Cep6Nq0pup+M74j6qNF4ZFyQ
	 l2vEVlnCdCyF2Jmplhc02fURlQ5YHqIQcP4AUjAbowiGiCcRcQjgDjDqDcYNYzs177
	 L5fLQlor9h/4A==
Date: Thu, 13 Mar 2025 12:16:32 +0000
To: Antonio Hickey <contact@antoniohickey.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Benno Lossin <y86-dev@protonmail.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] rust: clippy: disable `addr_of!` and `addr_of_mut` macros
Message-ID: <D8F4QM62027Y.1EP8OGGCCSAB4@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 279bb71198b426891d487c2477662d9cfa09ebf7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 13, 2025 at 6:33 AM CET, Antonio Hickey wrote:
> With the `raw_ref_op` feature enabled we no longer want to
> allow use of `addr_of!` and `addr_of_mut!` macros.
>
> We instead want to use `&raw` and `&raw mut` to get raw
> pointers to a place.
>
> Suggested-by: Benno Lossin <y86-dev@protonmail.com>
> Link: https://github.com/Rust-for-Linux/linux/issues/1148
> Signed-off-by: Antonio Hickey <contact@antoniohickey.com>

This patch needs to be done after changing all occurrences of
`addr_of[_mut]!`, ie the next one (otherwise it would warn about them).

I also noticed that this feature sadly doesn't work very well, see

    https://rust-for-linux.zulipchat.com/#narrow/channel/291565-Help/topic/=
.2Eclippy.2Etoml.20has.20no.20effect

and

    https://github.com/rust-lang/rust-clippy/issues/11431

---
Cheers,
Benno

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



