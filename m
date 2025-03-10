Return-Path: <linux-kernel+bounces-554871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 599CBA5A2D7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B41E172F68
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828812343D4;
	Mon, 10 Mar 2025 18:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I901CpS6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2A8156861;
	Mon, 10 Mar 2025 18:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741631072; cv=none; b=FnrkozQIgw+dYeCPu+0B3q0sSwRF0967ANc0WFF+OX7bh0w+MzR4B5SoARWR+K5B/3IErOTdwirnYdD/BLH1nMMNaq+Z0uyGFBddTrbndX5aLTXUy/KfCq85W/W/un/W7mquhb8i9hDcMN1QteTYlXRThkHivik++ADdY5THPhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741631072; c=relaxed/simple;
	bh=I9v83gD5FScUmGVEHRSB9QRMjjO35gmukcVxbPouQhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWTI0sWXOo/avJnKAIaV6Yq31mjJHGqCQBx+WuO2qSJ9hl7IDFNbiugA6c8V59j+ykTiL1lX1vQ1dkxFrIEGtkj48QD/OBZS7GCR3620aR5SJwpvSv0VJxY1Szru6t2x751h7IdfDOCS25mkeuUaxeZ8G0Sge2OjovnBQorlegc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I901CpS6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7F1C4CEE5;
	Mon, 10 Mar 2025 18:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741631071;
	bh=I9v83gD5FScUmGVEHRSB9QRMjjO35gmukcVxbPouQhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I901CpS6Vdf3DtNpDgEiDxTsFlIlx7rAUEWgjN2Ufo/lo9UJGZDFf3ywzXYuX1FiF
	 Bcn+Sf16FRLMQTryJA297F3fT3341P3BA+P9ialV3qSwkBbox4ybZ7Lz4gcAK17sTQ
	 lJ8mN9QWBAyJ8yEgTCtpFCMk79fFOez7EO4lZyX0=
Date: Mon, 10 Mar 2025 19:19:36 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] rust/kernel/faux: mark Registration methods inline
Message-ID: <2025031053-tribute-crudely-0e1d@gregkh>
References: <20250309-faux-inline-v1-1-c1b692862433@ethancedwards.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309-faux-inline-v1-1-c1b692862433@ethancedwards.com>

On Sun, Mar 09, 2025 at 10:14:36PM -0400, Ethan Carter Edwards wrote:
> When building the kernel on Arch Linux using on x86_64 with tools:
> $ rustc --version
> rustc 1.84.0 (9fc6b4312 2025-01-07)
> $ cargo --version
> cargo 1.84.0 (66221abde 2024-11-19)
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

This does not apply to my tree.  Can you regenerate it against either
the driver-core.git driver-core-next branch, or the linux-next tree and
resend it?

What release/branch did you make this against?

thanks,

greg k-h

