Return-Path: <linux-kernel+bounces-572803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FA3A6CEDB
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 11:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C86F170426
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 10:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8828202C46;
	Sun, 23 Mar 2025 10:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="CW1kWy9G"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5AE20370D
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 10:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742726514; cv=none; b=qp4XuzWzAswCKp9tK0XEwrdUP5TzdGP+iHD3PHLt793aRDR+0FV2lVFGUdR/rV65udvPJ8VCIZSmvRwjzRmM3PSQMcob8fNlSEni/hkA8cIHZI2QCdcE89PinzibUrZvRRqRWYS9w88PHZDARUr4E658lYMYbnPFhsD2PWwZpQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742726514; c=relaxed/simple;
	bh=sdF7VhGK5QqartT25xz0XzktC1JwQlwKTCSiMXSOwdU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E69TTUbgMXmrJ8AS8bLHQ44+a2Krez31jcAST/nz/4vXsoI6TFi/TnpYSIyW4yvh1AUcQTtM54QPMdQaWLlnTGWUXJ5rIhMpWlrmFQB0s0SHmqXbxgbDwZjgQZ7ijzd/e64o1XOMdyZorjTLyL81kKm1pphq0oV56PVBqECWN3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=CW1kWy9G; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742726510; x=1742985710;
	bh=RDroXS8EH8dxs+A85SlVDo0XJpIxHTrGJsgkqKqGlTQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=CW1kWy9G4bTMURoeqYgOkAYYELZ7eyf7W0CJXDDzrrdakHHKVDbjl1NA6YwezVa+j
	 HzFlW4zxLB/COTGJUsGmCqoq+ti/iLHnP23e/vUAEGNzS5OgpcJRHoECV5obQBctZL
	 oCeB7qQaFKrO1Jiolab75opwuBfWxFGor/CsXnlE2YZ6dkjSgi6IeFpGQFOgWZrnpm
	 HDJnJJo39a9J4t8yncZWbNYHvd88JgSTDw5gd12Rztn3dh5kX7gPp+E0rFsj4VCmFO
	 mdki1TbWndaQKbM/qDSGRwORHG73T1d/Mi9xzosWsz7LLpoECmKWW+7AZHyHRec8fh
	 yO03eRKy4tT1Q==
Date: Sun, 23 Mar 2025 10:41:46 +0000
To: Antonio Hickey <contact@antoniohickey.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 17/17] rust: clippy: disallow `addr_of[_mut]!` macros
Message-ID: <D8NKZI8Y820Y.2HLCWKHV2GYN@proton.me>
In-Reply-To: <20250320020740.1631171-18-contact@antoniohickey.com>
References: <20250320020740.1631171-1-contact@antoniohickey.com> <20250320020740.1631171-18-contact@antoniohickey.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 3d923fc74ccefd9a0655bdc81c763d3190c31943
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 20, 2025 at 3:07 AM CET, Antonio Hickey wrote:
> With the `raw_ref_op` feature enabled we no longer want to
> allow use of the `addr_of!` and `addr_of_mut!` macros.
>
> We instead want to use `&raw const` and `&raw mut` to get raw
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

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> ---
>  .clippy.toml | 4 ++++
>  1 file changed, 4 insertions(+)


