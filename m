Return-Path: <linux-kernel+bounces-572802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2B8A6CEDC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 11:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 279D1189A4E5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 10:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494ED204098;
	Sun, 23 Mar 2025 10:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="TTmvV+Gs"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CE820408E;
	Sun, 23 Mar 2025 10:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742726484; cv=none; b=jFdrprNfA/9RHK2Xo1ckRSOTLB+RyCXzpuRGvGigjTpS+sPdTN6o08SCHJ6ao/tMGiEj1K98BrHph7CjrclmUNERJcCXtWFXRfSK+ODpQPKmhETUTuH9TJqGwQ3uQZyHmg9qu3/r25QKJPSOgk5dcLnookDZYey3b2PdbxruH7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742726484; c=relaxed/simple;
	bh=D9FG83W7r5TxBFLDxRnSAvDRZ6RfonFlGRJBxGVi2Wo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V3wUbu08lLqBkhchycxrkpSIbKeEdTXZzxjZdl8Rhk5sxSlrJ6uxNNLw2u2KRoYEAcUHqJYHogCo9cQhJIqWn+HUDSgbgnVT+O59b8PfKfTA0mSd9Ox1QBwUSLtHuHtYg5+Uje6pCB2aOoCE1ElnDe6yqq9vRlD8ZSIKqUs341s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=TTmvV+Gs; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742726480; x=1742985680;
	bh=PRxNXP2NgOp0g0TB5sEjkaBK0klzY+T40T/rPgqBxcI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=TTmvV+GsxBIh6BSYQBNhKtUQsHD4CBZRsZSfLxRmAFD5nfhJDkSxHigFeG8pAah1g
	 v2/FVgz4n4+2BiYtH6RWEWj4TIyJztuAkKQqaGiJq1bNlVGyAp3ZEnyQgPngNk23pz
	 EQ2tW4yny7ylzKVAoQ3Pcu8zF2bciPrB8DG5FOmAqXz1QnqPE4SqAEq1Z2HrQpb8pc
	 Fqz+GhW4oa5B+t7if14iBmF1Z1tO27WRebeOq0mEO7YQfJ6hP6jxU7Arj96rn0Pt8r
	 UMywzp8SKO2oHtOyZwuvCGEYsL1pwWRyTzlNGRGxDPtA4vsMQSd5KFf48Xj91eTzgh
	 azDvPNOxORS8w==
Date: Sun, 23 Mar 2025 10:41:15 +0000
To: Antonio Hickey <contact@antoniohickey.com>, Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 16/17] rust: block: refactor to use `&raw [const|mut]`
Message-ID: <D8NKZ4ANU4RS.2P8IKSUDD1XYJ@proton.me>
In-Reply-To: <20250320020740.1631171-17-contact@antoniohickey.com>
References: <20250320020740.1631171-1-contact@antoniohickey.com> <20250320020740.1631171-17-contact@antoniohickey.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 8f43702ab6a093fecae89e301c8e21763b23483d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 20, 2025 at 3:07 AM CET, Antonio Hickey wrote:
> Replacing all occurrences of `addr_of_mut!(place)` with
> `&raw mut place`.
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
>  rust/kernel/block/mq/request.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)


