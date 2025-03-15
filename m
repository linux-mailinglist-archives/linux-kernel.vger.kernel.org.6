Return-Path: <linux-kernel+bounces-562525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F9CA62A8E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 10:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ED463B54D7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 09:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EE71F76A5;
	Sat, 15 Mar 2025 09:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="bNzQlWKF"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDEE2F3B
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 09:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742032702; cv=none; b=CpIRjz3kQcIKUSyoAb8Z4wSViiZmjZT0bUFBaw/OxJOQTOnhdWdF0wJEcb/GZpXNXDXGctZle7MKvBLjJ4nCX1T5T0TWs+oWMuEgqqQz7vDBZAUVXpeXo0H22dm0mMY0w5CGBDeb5v3373acNEIvxrLRsVCiDF0Tv8DDlKvOn3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742032702; c=relaxed/simple;
	bh=wn09jwc2pBQvduyxyPV+H5IbnwLWYqsOUtLidwfnmGk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AAu4HdR4p2nSge2yTtjkhZY0H58TMLGjWBPFSb6XMJjrWU9f2YDg0+PRHEJ+HnBc/VNlAtXw1gxMtxNqiL9kykvQDj7TPLQgEGRLuxm4xS2zpu+cEKjl3hMw6/QBCPH2pFrx3VrGSR9ohapRqHoN7KbXK+yUyPmI0d2Z8RfPVes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=bNzQlWKF; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742032699; x=1742291899;
	bh=TafzxovLbJfIiyPOpoOK0R8B3/B2rBQqxlLBlZOQQFg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=bNzQlWKFQOr5ggqj3s+k51vZAIABzZKOV0oLqg/kr+zsfPqTbaFd9/czExISgzYyq
	 /YOSfzbiRm1T/8+M+mIA70Cl1brniXLT894gORZkpaX+gHSj5BOK4/lz2oKQ9OcqiW
	 kv1GTPmNZfiQMPgUvrgRLpdvYLrOtu/RsfozjisFXwAZGzvp+Z8GiTqTDuhaXJbamE
	 DU+yFkHkLgv1UxQpOnINMSuvf3iuf8YLT2eYi6Jq4+vuOEibAxH2xuB5wJAQ3Rw+4r
	 soBOaA7Q/IHww2q+s1ep2rUjFVWPKTuosEDvzxLEE1ckMNgG4zm0NTPnshhT0iWYWS
	 46SSqozNPvf9g==
Date: Sat, 15 Mar 2025 09:58:11 +0000
To: Antonio Hickey <contact@antoniohickey.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Benno Lossin <y86-dev@protonmai.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] rust: enable `raw_ref_op` feature
Message-ID: <D8GR1RC32370.2EJN57V2ZYA7R@proton.me>
In-Reply-To: <0100019597091f92-cb55b6cd-4d06-4d14-8d9c-1a1314949a00-000000@email.amazonses.com>
References: <20250314234148.599196-1-contact@antoniohickey.com> <0100019597091f92-cb55b6cd-4d06-4d14-8d9c-1a1314949a00-000000@email.amazonses.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: c8e8ddaef7ed051886a41c3dc5bd2993a44271c4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat Mar 15, 2025 at 12:41 AM CET, Antonio Hickey wrote:
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

This still has my old email, please use <benno.lossin@proton.me>.

---
Cheers,
Benno

> Link: https://github.com/Rust-for-Linux/linux/issues/1148
> Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
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



