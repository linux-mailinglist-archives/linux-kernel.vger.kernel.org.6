Return-Path: <linux-kernel+bounces-572792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 274E6A6CECA
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 11:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB36F16F940
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 10:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252052045AC;
	Sun, 23 Mar 2025 10:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="LdbAsO+6"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D6E2046BE;
	Sun, 23 Mar 2025 10:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742726046; cv=none; b=Rzf+gjbUZQoqcEzHXddFQ8E6ZEGdFike47Y42CbOYkoBLa2m/u435wJAi4QAA1WBtYf/XnDOdOt1VXadhqcd7+QEwaz7nGA9iMqTW9I7f2ZEsOkNJDg0nd+Qz6UcERc6Szqwns4uyrUr9K7LNT9NLVRuxfceAKx5103CyMFy4Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742726046; c=relaxed/simple;
	bh=+n+2/CeEl7YposnqUPN/kLVekCYsY58th/9SuO8+B9w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HU6xHTBZc4fBb5EjpjYAJ/fvIwRN1dFbOXsbqkVOk6IXu1oCYRIALvgQXxZSw1vdrLs6syKhPVH3RpDnjjs+lO/v7HvKIMTAi3J46wCjR4Jmj/2MeJ4skFt6BMr8eTIiEUw1kPnpy5LJ6gQhqg1beaHmOnZ5vkRMPW/oOOkKHKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=LdbAsO+6; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742726043; x=1742985243;
	bh=gI1a669A4dh2fW+ekZ6eGSzu5VKg02pRET8orrOG2mU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=LdbAsO+6v1QaNag0ur+RB0kkg2l219Twy3i7W9BVdCMKHGZMcYOtKC2TbVpHLheHO
	 q+aXOkXbzG3uq7PVnJVNf3w70tx5oET1zKEkFUCZtEFZk79LMAjUkYbOZCs+kuEUDg
	 hcnBCL6wD/cu9r/NnuG7jB6FzGlMa70Rn2ItSIkhQYUAQDan5pHiP8uAP56pq0DxxR
	 pOAicOAHLL3vKQSuTmuspRwM2y3LVtwCzflEM0SBnDpy/7PUay0kx4cnjWisJ0sMM1
	 nuOZIATSFdWD073jkGWii49E8GNp4/ZxTWqC9k9wKeK3Noz/HsoetVFlyFxiWoOoNn
	 ItsWo+KOzXfdg==
Date: Sun, 23 Mar 2025 10:33:59 +0000
To: Antonio Hickey <contact@antoniohickey.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 06/17] rust: platform: refactor to use `&raw [const|mut]`
Message-ID: <D8NKTL66HF7T.16MCWO8TPQSD5@proton.me>
In-Reply-To: <20250320020740.1631171-7-contact@antoniohickey.com>
References: <20250320020740.1631171-1-contact@antoniohickey.com> <20250320020740.1631171-7-contact@antoniohickey.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: bfeee9c12f326fc1b0952be72c4abf0b1a77447a
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

Similar wrapping issue here.

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
>  rust/kernel/platform.rs | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)


