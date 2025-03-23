Return-Path: <linux-kernel+bounces-572797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E312A6CED2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 11:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 824657A55FF
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 10:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B155B20408E;
	Sun, 23 Mar 2025 10:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="EhtcXJiZ"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21661FECA3
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 10:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742726342; cv=none; b=XQeEwclLEX49yLDYhrgnp2remuRAYL2hLwnfkXxlpX1c8yqEut0IuxjnJwSFC2ON9JLZTwwP6bOnSPtSps+wXsB5EKZf9VADetNPe6BS5tcFOyeCHvfm02QRiUVwS/26e2TwI+hQPjbZAN9xscJAf6GsEnLk45umdevwiB+WjfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742726342; c=relaxed/simple;
	bh=oMcbht4Qs7Z/lsIyggDKMZRC5JfG6lRFD7TyuPjZL8Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=euX43I9AupUvi2X7RbF/4D9BCQ3wa3m9rOwX+8mrL+5gHg0ijnmxv3HEpGMbfW1ulLikknoQAi/UBfncx0k5U9S6QV6rbP0o+gVjGoBXG0vQiGyoaQFvy+sqk2HChJkfTjFVJmfBFYfQgGJ9IO7XaLV0+21tQeN2nvdmdB4rBJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=EhtcXJiZ; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742726338; x=1742985538;
	bh=JhWYioR0TnMhs+2LvrIpLH4Vufg6hj1LMtCyz37NSE8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=EhtcXJiZ38oMVRNHVdbysktqCST4lKoj4zEHSFhSTY8ybUD1VI8Iys+dMtmv2ZP1K
	 mJhOB9cOh+5ddKS7FpBynOG8GAMXS1Xdk03UL5SkBu93wF4mYDwPmFgh7ZN/zlPCqX
	 CK5/EIE5OJgjObzNrJ7sqFNCW3w3/1MCyd17dT+uimUXQVa4qTrZwmlk4eMGHlcaoM
	 ot+so1MZvDI281/lrNLHmRZRl68nXB1uq+pHCqRtf9IP4Z4Vpmhbn0LcWGeRRvNVVK
	 rFlGAme44Buy/hQg2EYv+B6DsOYeU5c4/rjNbUikdfq3FcTOy+XDNjiLaqyjEx7yrm
	 UcKnznWj40QFQ==
Date: Sun, 23 Mar 2025 10:38:55 +0000
To: Antonio Hickey <contact@antoniohickey.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 11/17] rust: rbtree: refactor to use `&raw [const|mut]`
Message-ID: <D8NKXBX3CQGT.1MR9MKL6H4G86@proton.me>
In-Reply-To: <20250320020740.1631171-12-contact@antoniohickey.com>
References: <20250320020740.1631171-1-contact@antoniohickey.com> <20250320020740.1631171-12-contact@antoniohickey.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 34e1fbc301c389088d279158285f5073652bef37
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
>
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
>  rust/kernel/rbtree.rs | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)


