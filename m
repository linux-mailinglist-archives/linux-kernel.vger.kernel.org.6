Return-Path: <linux-kernel+bounces-521169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8423A3B60F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14BB2162768
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB8E1DE2BE;
	Wed, 19 Feb 2025 08:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGpH9mTb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04461F3BB6;
	Wed, 19 Feb 2025 08:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739954820; cv=none; b=nIcKfiayTjaqL+j4vRr3zqjjYQRXPzKQH34m/mIFXM/p4vJ8rZtKTvlrqumEQimG52HEm820hcNgs+6RZKHmZ0D1hS0+7DduXjo3JDB52a6e6czsl9jYqBOhxy+w+PGq4MxfrHh6PwgnkykLHywQ5fKoQg9y2e7GIRixE7GtksY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739954820; c=relaxed/simple;
	bh=/m2FmsbmklUHkDMFAYB5nNLniP8aogv96FU1XtosaoY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rthxJmemKI3jT/Bnjb+9rsap3k5/zm3/UjqI/sydYO/IGawXTqqqhngWv7ATCzUIumBIUC/AAnI05EauYCHeKmeJy9lBsSUXVqD9m3oPGbzXbdFBI0aPDQ1Cd+5z+JxvxvmfY48C5MAFcrneZQWFNeND9ojj0qkjKYLHUFWzlbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pGpH9mTb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B27C4CED1;
	Wed, 19 Feb 2025 08:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739954819;
	bh=/m2FmsbmklUHkDMFAYB5nNLniP8aogv96FU1XtosaoY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pGpH9mTbVX6yzKBAb2dDLu93MENVlPzYABTAkvNa9uIIMk7Z96wUtZhWHVUiSAA+p
	 A2lNQWSOIY3pBZJpMZR++14HdwIlAhn2MIuKbUaoFYpvPfm3msEIPXj7FVK7gtHsRe
	 ruhURUC1P05+9YlbKJf0CP4XfVx6wOn29qQcqxCXtJq4ywmg2hcxbNdC2Rm6QsrI2Q
	 6mOUAuMTVzI64JjfnzNTWI0veUhHMPOpfZSW5SjbWKyuG5XooySMxLZurFXMvcx2ty
	 CQWEjRIXutcYN+lqlN6aYGRc+ZFOM95/sfjolTrS98C+NfRaTY6fHLc4uX3BUQ0ARe
	 zTlfruthpWphA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Asahi Lina" <lina@asahilina.net>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,
  "Trevor Gross" <tmgross@umich.edu>,  "Jann Horn" <jannh@google.com>,
  "Matthew Wilcox" <willy@infradead.org>,  "Paolo Bonzini"
 <pbonzini@redhat.com>,  "Danilo Krummrich" <dakr@kernel.org>,  "Wedson
 Almeida Filho" <wedsonaf@gmail.com>,  "Valentin Obst"
 <kernel@valentinobst.de>,  "Andrew Morton" <akpm@linux-foundation.org>,
  <linux-mm@kvack.org>,  <airlied@redhat.com>,  "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <asahi@lists.linux.dev>
Subject: Re: [PATCH 2/6] rust: page: Convert to Ownable
In-Reply-To: <20250202-rust-page-v1-2-e3170d7fe55e@asahilina.net> (Asahi
	Lina's message of "Sun, 02 Feb 2025 22:05:44 +0900")
References: <20250202-rust-page-v1-0-e3170d7fe55e@asahilina.net>
	<MbcmURUJ_wZdg4knkI3W95ZyOnefwXlfV2hkOjh8CS8MeRBBMtRzqO_ghFNp8nnMD4DrIw1sxWBVH5Pkqkr08Q==@protonmail.internalid>
	<20250202-rust-page-v1-2-e3170d7fe55e@asahilina.net>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 19 Feb 2025 09:46:45 +0100
Message-ID: <87bjuye2yy.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Asahi Lina" <lina@asahilina.net> writes:

> This allows Page references to be returned as borrowed references,
> without necessarily owning the struct page.
>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
>  rust/kernel/page.rs | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
> index fdac6c375fe46e1ba589f1640afeae3e001e39ae..0b6cbe02522ab6e6e1810288a=
d23af4e4aa587d8 100644
> --- a/rust/kernel/page.rs
> +++ b/rust/kernel/page.rs
> @@ -7,6 +7,7 @@
>      bindings,
>      error::code::*,
>      error::Result,
> +    types::{Opaque, Ownable, Owned},
>      uaccess::UserSliceReader,
>  };
>  use core::ptr::{self, NonNull};
> @@ -30,13 +31,10 @@ pub const fn page_align(addr: usize) -> usize {
>      (addr + (PAGE_SIZE - 1)) & PAGE_MASK
>  }
>
> -/// A pointer to a page that owns the page allocation.
> -///
> -/// # Invariants
> -///
> -/// The pointer is valid, and has ownership over the page.
> +/// An object representing a memory page in the kernel (`struct page`).

Can you  link to the header file containing `struct page`?

.. memory page in the kernel ([`struct page`]).

[`struct page`]: srctree/include/linux/mm_types.h

Otherwise looks good =F0=9F=91=8D


Best regards,
Andreas Hindborg




