Return-Path: <linux-kernel+bounces-572794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7E3A6CECD
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 11:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A742A3AF7D4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 10:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F25203719;
	Sun, 23 Mar 2025 10:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Jt5PFHyQ"
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E98B86329
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 10:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742726119; cv=none; b=qvXNFK2/651vkJxiZmJ3E4iqI1npwiAw8/lwcCJVaH6JTWEzGqXc1pCEmsq6ZCkgPS8pdGLEeCHOVwUsD3bMSeUtiY3VNcxp/Md51Bof5YQMsKgWvp3QjGtTJUbRGoPsW3nNIED4eoNrZJJihxYNLEx/IMO6w09jGE1XlbYGUvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742726119; c=relaxed/simple;
	bh=iKcEen7u/7Tfjt9OVU4zyJKUnx1oCzu4A2QiOQuYyfE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y6sJRlhQQBsMvP19K94kUiBo5CN+P5f9ABZs/BaFIDbpQdiiZ2o9AIVMOLMOl+oIPalQC5Z26T2lTDkDquSZM3LOYJx9p2T21RTbFQoFeGDxmAj/ycZRHmbqoNM9x4oZFn/JiyBRCDa4okWbc282GoDaiLo4HJj8zyYCIwSy8hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Jt5PFHyQ; arc=none smtp.client-ip=109.224.244.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742726115; x=1742985315;
	bh=nYMFHupUn/jV70jAZ2sD+P8J70Z7CH1o+fFdzvXoAaA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Jt5PFHyQOJYNtVnwuyeq/wNDzCp3nxtUKcn48DOxC+v0VtNjZdfWP+0lFXA6Hf5+j
	 GmvTGjCKM9YMxPjUa9yg+glKmfDhsLR1Fc25VEkM5iId/DE7WuajOZ8dKF4KUGUvXg
	 LK8NrRBBAUnxnMjgRUB6CXNMV219UrIZUnW2ZR+KKO+e2Oh5QkXuvwdVTBAHpHmBbK
	 KYnV4FuxdCafeygj2nl7GTHTvnOSj8AH1atHdgxh6XyJXY9DJD4BH3vVkKedngF0b8
	 tHrJuqcd0VOwc5njoExsVe6twBf3U1rt6o9PLZi/VDWY+vaAXVbljQYpsOgqyvl+fH
	 aHWQYOrCqvvyw==
Date: Sun, 23 Mar 2025 10:35:08 +0000
To: Antonio Hickey <contact@antoniohickey.com>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 08/17] rust: kunit: refactor to use `&raw [const|mut]`
Message-ID: <D8NKUFCPHC91.20JI7LRXRRGV8@proton.me>
In-Reply-To: <20250320020740.1631171-9-contact@antoniohickey.com>
References: <20250320020740.1631171-1-contact@antoniohickey.com> <20250320020740.1631171-9-contact@antoniohickey.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 71dd91e4cf8b297238bf26f7f22fe199980746c0
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

Again.

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
>  rust/kernel/kunit.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)


