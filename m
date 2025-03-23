Return-Path: <linux-kernel+bounces-572795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 621B8A6CECF
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 11:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209E31898E6A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 10:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698F5202C31;
	Sun, 23 Mar 2025 10:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="M4XO4mhE"
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B660273FD
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 10:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742726167; cv=none; b=UWhMPVhnFHX+2TvDXmVTQ6a0Ucq/Zfh0VFdRn32Kj6t6Z/cWWCA3ORGPucNKT2BTb0xWfuMvMiZfRk8KLiHDwA/bWRZ0o6zamfYgQCNLqzGiKWTjDv1DIk31UTdM++I6j/Q7VlIYxx8J2/pA5zIA/EkF4TEOzawckgQvVMZtcQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742726167; c=relaxed/simple;
	bh=af0dtqoBDLs2xccBZP+m72nAb6E5O1q7jPkR5VicH5k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TDyG76NtQW8SxYV9txPf1pYhtmvkv7V8OvxQRavqFylpFl9WKXy7rQ1jAZ3i70ep4HpN0AoD/ATgRSMezn47iJa0OYfVZcBgpVzyToNcaI77KeVo0kWedWZHkljKZCP53qanIDQW3vkmIuK3h+rHKxHIhRDu1AyPJIYR/lfOu0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=M4XO4mhE; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742726164; x=1742985364;
	bh=Z9kQ6MZqNbMDjWH1BakuG235h8cGVfZgV58Rwk+EqC4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=M4XO4mhEOTUif9BNnvKcYLFwK69mN5iomc4/50DsPYd/3DkBTeyVrH1FPqULdZBlC
	 bKaN7VlO934Um0TymABGIahxrAu8FoKkzMaM5vFxF8BwhTmn/mD/iwnUn0F/amtFc3
	 ECcKwuh97AxvzCVaKhks8LZB50yu2swLER1Waha7g3m84lzBWQCyboh9nTiwcweGC+
	 Mr6S4zqSedieOjDYsXKEpd6y+nQHWhJC8psY58ygpiPLijhoZ0d7R8y6a5vpK83IBC
	 V6CJ0VHFonQS+iT87GSQ841uKDxFT4jEG//1/3hmQynBEKJpMUROB4SXa50CozDeZv
	 M/0tSrITnq8xg==
Date: Sun, 23 Mar 2025 10:36:00 +0000
To: Antonio Hickey <contact@antoniohickey.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 09/17] rust: workqueue: refactor to use `&raw [const|mut]`
Message-ID: <D8NKV3G8KNDG.1B8FEM4ZAC00C@proton.me>
In-Reply-To: <20250320020740.1631171-10-contact@antoniohickey.com>
References: <20250320020740.1631171-1-contact@antoniohickey.com> <20250320020740.1631171-10-contact@antoniohickey.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: d27c9812b511c152bbbf85afe8ce5b22131f5e2e
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
>  rust/kernel/workqueue.rs | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)


