Return-Path: <linux-kernel+bounces-563088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 718AAA636DA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 18:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A01423ADCED
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 17:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9821DDA15;
	Sun, 16 Mar 2025 17:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="g3xkZXDX"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355141A238D;
	Sun, 16 Mar 2025 17:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742147270; cv=none; b=JekoDbHpzREmW12dKojC5RZzK6UW6wGOtNQlLElRgS1Z04P/3n7tdc0x0r0fWb7TGRKUOvxy2Hclitl1UiX5HxSDdTFPMaBSEwBDKcsXEeRnuSVH5yd/YbLVKW9A2FHw7DtOT0lDYUAoX+Iu/FQWeAlgbgdGd5zJF0K+25IX+0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742147270; c=relaxed/simple;
	bh=oKk+mNkr7TImnO+pZms2+BwrQ4/orsyoRd0HOVQxBic=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dkXJLvi5kQkKgLWhAxvrjwC3OcgswMjK8atV6X5EYjqgyPB5BN6JzeRVTZTSLLRCXTxlYpxZ/BeJtB3QklsvMWB9nTKo+fubTNSwEpOp5Cgc/jqwx+WaLjfQg26dBVAyvqQ8NJG7a7vrDUQkRlQmpOeWhBw5f0OZc+3BG4X1Ges=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=g3xkZXDX; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742147266; x=1742406466;
	bh=oKk+mNkr7TImnO+pZms2+BwrQ4/orsyoRd0HOVQxBic=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=g3xkZXDXTk5WQKjuHAdYt9KRAQl0q5TQYYKI1ohng0cYo+itwmQObd8zT1+IeUNuW
	 FSYp8SVw7Oxy8cY+Pj/V/nQmAWr+AtgrNIlNwUb3/eUbky7pBp7Qcwwy6aFTDQnT+K
	 W2mtTxeNQ3b8XiQS29FXGGjLqb58pIWClsP8ZO+LYvmOo+PDIcUujAlqDMI8HHU9Qf
	 rpJXALeShbR1Xab1jk9JRiovJeBDErTs/ePyIKfgXm9lhTvJm5TwybCbKcdkRN9NfB
	 8ziq2TJUUTfK+JBBbJeWH4y66s50gh/Sn/+zTp6i7tHcBUMYLlyXsQj051ASNVWAJM
	 50MmS6gGEaihQ==
Date: Sun, 16 Mar 2025 17:47:40 +0000
To: Antonio Hickey <contact@antoniohickey.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2] rust: uaccess: mark UserSliceWriter method inline
Message-ID: <D8HVNR3Q3UL8.1007IZIZTQ0XB@proton.me>
In-Reply-To: <010001958d6f36b2-fb0a1710-a581-4002-889e-e489004bb72d-000000@email.amazonses.com>
References: <010001958d69ed91-0ccd9e4f-cd18-4451-a982-426b951d2e0c-000000@email.amazonses.com> <010001958d6f36b2-fb0a1710-a581-4002-889e-e489004bb72d-000000@email.amazonses.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 6b724233661c78c865ac9c2b86a9dc05d801c517
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 13, 2025 at 3:57 AM CET, Antonio Hickey wrote:
> When you build the kernel using the llvm-19.1.4-rust-1.83.0-x86_64
> toolchain provided by kernel.org with ARCH=3Dx86_64, the following symbol
> is generated:
>
> $nm vmlinux | grep ' _R' | rustfilt | rg UserSliceWriter
> ffffffff817c3390 T <kernel::uaccess::UserSliceWriter>::write_slice
>
> However, this Rust symbol is a trivial wrapper around the function
> copy_to_user. It doesn't make sense to go through a trivial wrapper
> for this function, so mark it inline.
>
> After applying this patch, the above command will produce no output.
>
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Link: https://github.com/Rust-for-Linux/linux/issues/1145
> Signed-off-by: Antonio Hickey <contact@antoniohickey.com>

What about the other methods (like `write` and `read`?) in this file?

---
Cheers,
Benno


