Return-Path: <linux-kernel+bounces-559814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4A7A5FA27
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28D16420408
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61B3268FFA;
	Thu, 13 Mar 2025 15:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="DVdP3ZaL"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8B726739D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 15:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741880345; cv=none; b=JFFLkVeMTmb5xqw6eYRLvo6J7/1GhRhBumD0ApxCoP/vfe10RuBiJsCAql4p8LqY/XOWTJkPjNkzDeViD4a8l+cxbKcPvDV6pEbPFzFlCJ1XcuiLaQ7Mu3KUP9QSJlhHx0dN05QXLU5mNcwDJpRnBVWw/Fj2fGdFPO69Regxoqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741880345; c=relaxed/simple;
	bh=u/DqT7WsvW5y3HPapc4o8ENLn/k/lws31ASQPvKv24o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tip1W4swgCWvyXuUaX8rR2ZcM0QCun0Pj/BywUmlgDveWG89CVAmhr6ky0o63y4iZ5ulWLC2gg+Rt22lz+hmD6RL81E7ph08uevQO5kD5nMlmHIoYbQyyw48P0keCja0nY6U97E9R48Dsnw6ltmA2ZciOUr7t+W7njNMjax04DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=DVdP3ZaL; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741880341; x=1742139541;
	bh=8q+SZJUpgQ03dKvuHkjBJKCWHfj+BfWFT9znt1M8GMk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=DVdP3ZaLkw3Ju+EqzzH3DrBILU9AC6DTt5VZSb2IazfyIg8NbLV+3ws2/fKPICCWE
	 kxA42d5DkysRz4l6QDhsQCZGk4u+WSRZF/pmPvpMbVzw2qOQ4wc4guIxff+OQRFNKt
	 IZ9e1YtupYuzCQej8c8FeAuCDnUd9toHuErm0OYilZMDa5ahMomTGhgIad9t4oSQ5K
	 MGTT1RWf7pSo0+N0mY8l8CvuhYK2l8F7g0TWfUkn7RVzM9ybuazwdh4DhHzBppHUjI
	 y+pS5rD3pVF0hyZKoWFivTgQfG9UNGwlBMawcC9l3Klo+8G/siwi7I8mPviFuMhKAE
	 C6dFyHgRugasg==
Date: Thu, 13 Mar 2025 15:38:55 +0000
To: Alexandre Courbot <acourbot@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, Danilo Krummrich <dakr@kernel.org>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust/revocable: add try_with() convenience method
Message-ID: <D8F91L51P2EA.2FBHGJYSV06HY@proton.me>
In-Reply-To: <D8F8E4PBHK7O.399Y83M1L3XK3@nvidia.com>
References: <20250313-try_with-v1-1-adcae7ed98a9@nvidia.com> <D8F7D2RPRVAO.2EF39MZXM6FPR@proton.me> <D8F8E4PBHK7O.399Y83M1L3XK3@nvidia.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 60d3158b1274c71f57645e115fd565706d6d5414
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 13, 2025 at 4:08 PM CET, Alexandre Courbot wrote:
> On Thu Mar 13, 2025 at 11:19 PM JST, Benno Lossin wrote:
>> Would it make sense to not use `Result` here and continue with `Option`?
>
> We would have to return an Option<Result<R>> in this case. The current
> code folds the closure's Result into the one of the guard's acquisition
> for convenience.
>
> Actually, I don't think I have ever used try_access() a single time
> without converting its returned Option into a Result. Wouldn't it make
> sense to do the opposite, i.e. make try_access() return Err(ENXIO) when
> the guard cannot be acquired and document this behavior?

Sure, if you're always doing

    let guard =3D rev.try_access().ok_or(ENXIO)?;

Then it makes sense from my view, maybe Danilo has some other argument
for why `Option` is better.

---
Cheers,
Benno


