Return-Path: <linux-kernel+bounces-572790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35258A6CEC8
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 11:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C68B16B642
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 10:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414A52040B5;
	Sun, 23 Mar 2025 10:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="fVn6Dv33"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2F348CFC;
	Sun, 23 Mar 2025 10:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742726012; cv=none; b=lcQCWKRM0xhDPHE4ImV9bjUEI8MsNU2d+IlkFsXYkKdI3dJ5b997WOOtfw+p0lEaxcrBZqCkashXncJ+L2gW8tM0bWXcrd96vERx/nSdLCvVdqTiu49qSXY7frBhLWgl7oxiVm+vCPaHLL7GPeTKYJVbqR6x20GTwnfOc4dSZPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742726012; c=relaxed/simple;
	bh=ojwCJlaJNkBkDqt/q55hzD1cDqXmXzMPNEqR10c3NxM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t2SpuYUpFytXUCP7E/fsjnbhd4RUc+3zmCwh6QZKU5j0VisoONbcj3mWUkEZIGV3moRiV/LzNfHVnNtkoBGrxG4ZQvILwoyt2OoosL9Gb+JLs0c+/m90LvzBgmgqiY30Ez29Pmyn7Wsfxdt8u8PnqBoKgyfRQoicwBeADqp8dLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=fVn6Dv33; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742726009; x=1742985209;
	bh=oZsUgrUW5VD5eWiBvUUGdqpMAZFTSIHHL+KckUkfTlE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=fVn6Dv33ipOhltygwzQi5zeWuV4soWwiUq1yzdp3HwPOktsJGXZeIGXKgfVTHTwNk
	 1Hf/JTWYEwxyyJ60S1BjfDQ9gBZvkJAS7mQhsKbjDELMbWQKjam0U/w+/gAsxaoTax
	 WmEVmcBHSxN/SOdwtgIGY4ezjQZt2B50OJHj7S+zEL09wffMPOrQIleyUaCU+nJ1kr
	 95vwNDE5HCVLjfZPjwyhycVBTkc9ATUmCqtugnrfn/T9/FzPBNm1HAz6AIO7gSWNZA
	 NM/Q8grFxCB6YqS7QtpZ9tFgdVUIVYSeR2MRwjupNQTn6C6b+11Xrn65yVJFPKH69H
	 S7zF5OS/3x1ig==
Date: Sun, 23 Mar 2025 10:33:26 +0000
To: Antonio Hickey <contact@antoniohickey.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 05/17] rust: faux: refactor to use `&raw [const|mut]`
Message-ID: <D8NKT5LVWLVJ.5OB13K601J1R@proton.me>
In-Reply-To: <20250320020740.1631171-6-contact@antoniohickey.com>
References: <20250320020740.1631171-1-contact@antoniohickey.com> <20250320020740.1631171-6-contact@antoniohickey.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 0f9d087fd5b6d817e9161e78a02f928f08f39719
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 20, 2025 at 3:07 AM CET, Antonio Hickey wrote:
> Replacing all occurrences of `addr_of_mut!(place)`
> with `&raw mut place`.

This text wrapping looks strange, if you send a new version, please fix
it, otherwise Miguel will do it.

> This will allow us to reduce macro complexity, and improve consistency
> with existing reference syntax as `&raw mut` is similar to `&mut`
> making it fit more naturally with other existing code.
>
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://github.com/Rust-for-Linux/linux/issues/1148
> Signed-off-by: Antonio Hickey <contact@antoniohickey.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> ---
>  rust/kernel/faux.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)


