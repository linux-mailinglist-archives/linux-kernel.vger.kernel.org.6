Return-Path: <linux-kernel+bounces-572787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 535C4A6CEB8
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 11:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A1F33B444F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 10:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4242F20408D;
	Sun, 23 Mar 2025 10:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="gtLjuS0O"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AEB1A83E4
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 10:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742725915; cv=none; b=PzSwnK6wVxrFzPkqpWDwMasBmoKXFqgN4/4XWs+0fQ/zilddB8RsA/4zjTOmkJtnk+MLqOUj0oiiW6TOaCFvbO0NW5Cw+V/711aaMmii4D5H8bH7tPgoLO4KEHco74zAW6wwH9IEvSRxUW+eas5yP9ntsGUqVhNVBgWZ4YdwDRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742725915; c=relaxed/simple;
	bh=55nNheuxwighvJJtye1aLs775mgpl+RwATACEKBvtbw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZvWzgDaeKGK1UQr3c9lTt8x2X4nnNM8meWOjLvWcPVzsdxDW4uAYZxzqnP8mdeb97qZjoPA0o9OXODYoDxigcSJsiDHNC5nIwlEwJZQV+ZoRnAQDAmKcdf1OHbrb3iAHnkE31Yh+z+Ay/f8EN/320lEpWJWaIUPJafoUdqMPbxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=gtLjuS0O; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742725911; x=1742985111;
	bh=3HnCqEYfVz9tGyk/ujqrF4/JHfRLbmYi1i3YjJoCR74=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=gtLjuS0OrFvq9Pczol+eCXqqTrbVTG13dPwPf9FFDEUF8P0BTDZB1T0oy/uroaYgM
	 0NLUBVtJTJ3gftVIvwtwV5oDdxJkX5ZqqNXmoTsaXOYpv154mm/yi/qwCmXsBBQd1t
	 p6zIMGeJEwHYD12MPiiLkR3PyCfy+oM9hKiodSxXkjZF86rav8jZP3y+6vg6fxIoUK
	 C34fTp7Yj4AvtnvLAnkucyodU/zx8mFjsu9VnOcU4Clf3vrqYEbm9XtxUm8Ghah4gq
	 qHuIBTv3BoMRBtQYE7YhgNNJ0w1lO8+iVS7eKJ9G5s6vqmDE0CTiIVijaukPP0lXN/
	 oT2Noe63Rj2uA==
Date: Sun, 23 Mar 2025 10:31:44 +0000
To: Antonio Hickey <contact@antoniohickey.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 03/17] rust: list: refactor to use `&raw [const|mut]`
Message-ID: <D8NKRTW2HB2H.3PHK4DVWSV2OJ@proton.me>
In-Reply-To: <20250320020740.1631171-4-contact@antoniohickey.com>
References: <20250320020740.1631171-1-contact@antoniohickey.com> <20250320020740.1631171-4-contact@antoniohickey.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: b56a39f33cb2af22bcc38dff8d0c9121d28a7d0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 20, 2025 at 3:07 AM CET, Antonio Hickey wrote:
> Replacing all occurrences of `addr_of!(place)` and `addr_of_mut!(place)`
> with `&raw const place` and `&raw mut place` respectively.
>
> This will allow us to reduce macro complexity, and improve consistency
> with existing reference syntax as `&raw const`, `&raw mut` are similar
> to `&`, `&mut` making it fit more naturally with other existing code.
>
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://github.com/Rust-for-Linux/linux/issues/1148
> Signed-off-by: Antonio Hickey <contact@antoniohickey.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> ---
>  rust/kernel/list.rs                    | 2 +-
>  rust/kernel/list/impl_list_item_mod.rs | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)


