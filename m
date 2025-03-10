Return-Path: <linux-kernel+bounces-553763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6469A58E8A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CD213AA4F5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F9D224885;
	Mon, 10 Mar 2025 08:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="G+9J5a2A"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE57221F13
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 08:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741596464; cv=none; b=koWFt5PkzaK7sds4kAoo6w0FDxiVs5HPQ3nh4Y73OrlwZNrPqvhnLEzjXsTk3wIQ28N9A5vI7J7NaicpvaFBXcRK40f5G3Sg7XJ3E4sma/uKodjmx2Wc8jXydSo4Gf73m5Gtney+476w+IOsy884FT7tG2mdYCuI7U7YKQqPaKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741596464; c=relaxed/simple;
	bh=9n63M6cGbaQkIaHcgWry9bP+ZAoZDm95prcdWNr1ukM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IoW10qMskgC56ayJIOgq1mLWcb88lIHx3dP1JU1Bq6MGFI+XBdTaTNAxcEFCiUvPfNJTctYhgq4XdeXhT/zKC8gANS05+ZD+RIXsH/KLf26Zm+sDq84n1eLuswpgaLllWoNbqiQ7P6bQ5cIn0t5hxJx3WEoO+nIbrmqwTmv2Gqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=G+9J5a2A; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 011D6240104
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:47:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1741596454; bh=9n63M6cGbaQkIaHcgWry9bP+ZAoZDm95prcdWNr1ukM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=G+9J5a2AmEu2U3PA9Uggm4nu1BXtvQO2OSi4VVvhhBLEfg2qRRQSR0HYLsIa6DsoG
	 3lVqqIut4R84iZCn6rriy+YbJVCYpcI7MSenj/ruoaQiSjsa8oZm9LV14e4FzEpsxy
	 nKKDUbn+enwCK3YOCh4qGyBy12BcQ5UJJh2aLwvYFbg/VTDH6bXParUvRdkVg8nupU
	 UjvPUjJr06mgDUAQvlTHxhLQVzayEpNyOya2qRuqg2kJvR2E/yWZIZM7hnJ0+D7flY
	 ZHU/VObmCfSLIqIeEUyP1+pyV8jzK79Bhmf3gd600GSbDnNsAp5qHxyPEdZlvksAEf
	 n1r2wpCtIhPWA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4ZB9WQ523pz9rxc;
	Mon, 10 Mar 2025 09:47:30 +0100 (CET)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  "Rafael J. Wysocki"
 <rafael@kernel.org>,  Danilo Krummrich <dakr@kernel.org>,  Miguel Ojeda
 <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,  Boqun Feng
 <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6?=
 =?utf-8?Q?rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  Benno Lossin <benno.lossin@proton.me>,
  Andreas Hindborg <a.hindborg@kernel.org>,  Alice Ryhl
 <aliceryhl@google.com>,  Trevor Gross <tmgross@umich.edu>,  Nathan
 Chancellor <nathan@kernel.org>,  Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>,  Bill Wendling <morbo@google.com>,
  Justin Stitt <justinstitt@google.com>,  rust-for-linux@vger.kernel.org,
  linux-kernel@vger.kernel.org,  llvm@lists.linux.dev
Subject: Re: [PATCH] rust/kernel/faux: mark Registration methods inline
In-Reply-To: <20250309-faux-inline-v1-1-c1b692862433@ethancedwards.com> (Ethan
	Carter Edwards's message of "Sun, 09 Mar 2025 22:14:36 -0400")
References: <20250309-faux-inline-v1-1-c1b692862433@ethancedwards.com>
Date: Mon, 10 Mar 2025 08:47:29 +0000
Message-ID: <m27c4x2rxa.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ethan Carter Edwards <ethan@ethancedwards.com> writes:

> When building the kernel on Arch Linux using on x86_64 with tools:
> $ rustc --version
> rustc 1.84.0 (9fc6b4312 2025-01-07)
> $ cargo --version
> cargo 1.84.0 (66221abde 2024-11-19)

Hi Ethan,

I think stating your Cargo version is unnecessary, we don't use cargo
(atleast not anymore).

> $ clang --version
> clang version 19.1.7
> Target: x86_64-pc-linux-gnu
>
> The following symbols are generated:
> $ nm vmlinux | rg ' _R' | rustfilt | rg faux
> ffffffff81959ae0 T <kernel::faux::Registration>::new
> ffffffff81959b40 T <kernel::faux::Registration as core::ops::drop::Drop>::drop
>
> However, these Rust symbols are wrappers around bindings in the C faux
> code. Inlining these functions removes the middle-man wrapper function
> After applying this patch, the above function signatures disappear.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/1145
> Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
> ---
>  rust/kernel/faux.rs | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/rust/kernel/faux.rs b/rust/kernel/faux.rs
> index 5acc0c02d451f6d5a26b837d509374d508f26368..5fdd85ea64398130066d38e42f7c7485673f290c 100644
> --- a/rust/kernel/faux.rs
> +++ b/rust/kernel/faux.rs
> @@ -24,6 +24,7 @@
>  
>  impl Registration {
>      /// Create and register a new faux device with the given name.
> +    #[inline]
>      pub fn new(name: &CStr) -> Result<Self> {
>          // SAFETY:
>          // - `name` is copied by this function into its own storage
> @@ -50,6 +51,7 @@ fn as_ref(&self) -> &device::Device {
>  }
>  
>  impl Drop for Registration {
> +    #[inline]
>      fn drop(&mut self) {
>          // SAFETY: `self.0` is a valid registered faux_device via our type invariants.
>          unsafe { bindings::faux_device_destroy(self.as_raw()) }
>
> ---
> base-commit: fc2f191f850d9a2fb1b78c51d49076e60fb42c49
> change-id: 20250309-faux-inline-6c8eead1bcd0
>
> Best regards,

