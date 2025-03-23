Return-Path: <linux-kernel+bounces-572800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1EFA6CED9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 11:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D70FD189AA77
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 10:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1DF20408E;
	Sun, 23 Mar 2025 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="R72Zxehe"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1EC202992
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 10:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742726427; cv=none; b=LooB9kOLdz9iySy8ujOYBHgD1tdiAnYeQGv+hXfhFD7nnIcHoj+8gK/cVJVqxYYXobTqg38rolRUNb5gdXgHD+sMpoV2hiPCkbXvIfvM1F0prmIgqIu2rEqIIuzSz9tGiqVAMbdc/MgVxJwZ7xYdctZCFur9fIZvLB9oCcL6BXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742726427; c=relaxed/simple;
	bh=jVnCbpRqo5fVx7Brc3ihvmH5MoHHZ1WXqpJTF+1iujM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MVnqeFW80ntWByR0lcg+xLkNE2AmrFmmXv4Ohd4Go/mBwLNt7LpzIOV79Buu+ELVKKcxldSgRgdIuvKNh7Owut83qgIS4OjWdPWBrMANt1ld7q3de0K1jAr+IHedSihZEzT67fB0wHYL1lR4DM7jZi2TMaSOMDs8MDdOCfJLJYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=R72Zxehe; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742726424; x=1742985624;
	bh=jIN///kHi7Ez3PRMpIDTM6lBoNugyv58OA3cu60h5EE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=R72ZxeheT536IJXMCPdY389s5bCnZSv8Trs2YeHhCQvptBCqzV+AhAUNvr2C0Dmqe
	 twTzQyh+gYuY1gZgs0ldVe4wmk4QKxzAaAN8GhH5zIPSoEQowrR90SLXyJk457DKSD
	 sHCirrTO5TVNviLLLFrqzSp9NSgKGuUNFYbirAGeoAhYBQVEmumDNrNrrfp99Res3v
	 Xxo2lleiFf7McqjKVyg+iLzX+0NmewsUaix5UxKPnHldE1UjX46Qns7NJiEOxqnPY+
	 IXQL9b6OGaXHporHHz4gHFUO1uXvGti5vx3EQmhIjis+PnNW4OsMqjuko8NDji8aZn
	 bI5N52vBd6YYg==
Date: Sun, 23 Mar 2025 10:40:17 +0000
To: Antonio Hickey <contact@antoniohickey.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 14/17] rust: jump_label: refactor to use `&raw [const|mut]`
Message-ID: <D8NKYDSWAU9R.2DT55WN5X47PS@proton.me>
In-Reply-To: <20250320020740.1631171-15-contact@antoniohickey.com>
References: <20250320020740.1631171-1-contact@antoniohickey.com> <20250320020740.1631171-15-contact@antoniohickey.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 74166b5187d5a56bed13a52da9d4bf4ec79da6cf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 20, 2025 at 3:07 AM CET, Antonio Hickey wrote:
> Replacing all occurrences of `addr_of!(place)` with
> `&raw const place`.
>
> This will allow us to reduce macro complexity, and improve consistency
> with existing reference syntax as `&raw const` is similar to `&` making
> it fit more naturally with other existing code.
>
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://github.com/Rust-for-Linux/linux/issues/1148
> Signed-off-by: Antonio Hickey <contact@antoniohickey.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> ---
>  rust/kernel/jump_label.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)


