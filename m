Return-Path: <linux-kernel+bounces-559353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AABAA5F296
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CEE0179779
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056941F12F2;
	Thu, 13 Mar 2025 11:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="eGWykFwb"
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8AE264629;
	Thu, 13 Mar 2025 11:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741865987; cv=none; b=FDXLOXZQ8uIoauMeG1diYw1L5Xu0UgMqHXnF6rSi5FCMpo+QAqTMoWBT0HAtDSQ4CUUI3L3UP5B4XfwPIvAah0UhkNF1aOXLZl3Ji17G6Fc64VmPptDOFgkdSEDhlfXK9IkPXEwtEeTpwW03Jb29A3wRThtCJawCFN3l9USA8aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741865987; c=relaxed/simple;
	bh=kjPQTH3jmGE1bdx3XzKZIHD6CJvQt9dlm3QSLxEzwNY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OebRKDxUpAO2zxL9BBxxW5xUE1YJjLAJU3vAZrPo5/npwy+F6cQNk4g5/qKHe89xDw1dee2WQORvawFdzVx7OJsJZQ4aYockzThJJuvswredqS0rpcmqyyTAZbqne3x7/D9X6BtpeFOG8KOlYeG2PNJaULAfekfP4Glu7naSuVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=eGWykFwb; arc=none smtp.client-ip=79.135.106.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=a3ddv3s2hbg63kxaoeus6owxju.protonmail; t=1741865980; x=1742125180;
	bh=x73ydIXTpd2BoKW5LA0pRFgZnl6GVbYuK58EoMI/guA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=eGWykFwbfanaWdwAD94DLH0p/7ZdTkLXGZ94O0AiF67jqi5v0l3veGwW2kaITN/6L
	 PSXQSIjxybYdz8gJwLW2nAQKYofZ0FZpZPdxOsLlldGz+DyM+VdGj4v2sOlQk8SB/5
	 9ISeVgKxttE7obbAs0A5GAypsDfdd3laMdz3jY49V0xzmCRJGkp55lWtlxFnSLt1yQ
	 tgIQBXzJWoAqcWBILpJu2YgkEZRjL+hlabBapRBeMdNIJK2Vqaq0n1jOyvZjc3aexs
	 rR56sUyDHlHs20OhD/omn9zsb9FSiUrsr7XSip/gEagoqum99+66q3kHTRqxE+Xytl
	 8Z2k8a1ctwKLA==
Date: Thu, 13 Mar 2025 11:39:34 +0000
To: Antonio Hickey <contact@antoniohickey.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Benno Lossin <y86-dev@protonmai.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] rust: enable `raw_ref_op` feature
Message-ID: <D8F3YBA8CJKP.1JGZ1QAD3SBY4@proton.me>
In-Reply-To: <010001958dfeacb5-9039aaab-6114-494a-9f1d-f13982091169-000000@email.amazonses.com>
References: <20250313053340.405979-1-contact@antoniohickey.com> <010001958dfeacb5-9039aaab-6114-494a-9f1d-f13982091169-000000@email.amazonses.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 09d5d277dd7a2d14de514290a2a51e3276738f91
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 13, 2025 at 6:33 AM CET, Antonio Hickey wrote:
> Since Rust 1.82.0 the `raw_ref_op` feature is stable.
>
> By enabling this feature we can use `&raw place` and `&raw mut place`
> instead of using `addr_of!(place)` and `addr_of_mut!(place)` macros.
>
> This will allow us to reduce macro complexity, and improve consistency
> with existing reference syntax as `&raw`, `&raw mut` is very similar to
> `&`, `&mut` making it fit more naturally with other existing code.
>
> Suggested-by: Benno Lossin <y86-dev@protonmai.com>

Please use this email instead: <benno.lossin@proton.me>.

Thanks!

> Link: https://github.com/Rust-for-Linux/linux/issues/1148
> Signed-off-by: Antonio Hickey <contact@antoniohickey.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> ---
>  rust/kernel/lib.rs | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 398242f92a96..1d078f69bb19 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -19,6 +19,8 @@
>  #![cfg_attr(not(CONFIG_RUSTC_HAS_COERCE_POINTEE), feature(unsize))]
>  #![feature(inline_const)]
>  #![feature(lint_reasons)]
> +// Stable in Rust 1.82
> +#![feature(raw_ref_op)]
>  // Stable in Rust 1.83
>  #![feature(const_maybe_uninit_as_mut_ptr)]
>  #![feature(const_mut_refs)]



