Return-Path: <linux-kernel+bounces-555001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8520DA5A456
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2511C188659C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CBF1D8DF6;
	Mon, 10 Mar 2025 20:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOlp2Hms"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACEA4437C;
	Mon, 10 Mar 2025 20:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741637028; cv=none; b=fYTHupiDC3BjC73x1tJIehapSKPyWtGhhyKfWvFNnCleJXAYu8ENk3qoMwTSThlQ/EJ16eAh8nuMCHLA+g177AM7upAFS1/T5snYmaYDQ6zyaqn88J0weJASx3FZpXSyhPGxPldYr6I2q5RdC8SfiqRCGGTy8PoFl6EWdVmFkSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741637028; c=relaxed/simple;
	bh=RWZJoGTDKHzXEF1K2irWthYcXXJXmfncWeKho9RnFdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADpVGVHGPh77go/JxOxP+x7PPYygda7PI9ik9+bfCZpqj6/wWlKpNa5gC7dX30rLsfjAmFyu5PBbM1gx/w6Ze0rmw3tUsQXJfZF9fngyIF0W08dUUMZjOmhDGnanG8Q5QgdNCiehOZXREC5ONhOHkDUVV8+TDh9raNOJqlLOXQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOlp2Hms; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24299C4CEE5;
	Mon, 10 Mar 2025 20:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741637028;
	bh=RWZJoGTDKHzXEF1K2irWthYcXXJXmfncWeKho9RnFdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rOlp2Hms9DgUM2sz/lJJ+G1gnWScDmZ0ctw4U8wTAQ6lO8Axm3HeCgHQeoQ69+YCS
	 9Hi+54dbjslufZSeImGTTGQRFdqQxkSqrWGsJl0kx8D/kUf4jP71KKJ7czk97PV5ND
	 rDeZ+1Ss2m0MTc1HimNSfggIocFOgiPNiBiYMEA2fTb5rA/nQWA3Jv/1Hshjwa33JN
	 EM6we6rl8XEEiPdLy6TWTWMfzW3nEJ2GWhO9epqwHWQ4rLISPs/o9+vRIHd9zG9AfU
	 kSS0Pw6n2KIrkJ3Rcujp5rgmAibWzf9IF5ia5IzrIXqnA8/u2t1V/fSYLBuvjAbuUB
	 +mQrD/atlbbeQ==
Date: Mon, 10 Mar 2025 21:03:41 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?us-ascii?B?PT91dGYtOD9xP0JqPUMzPUI2cm5fUm95X0Jhcm9uPz0=?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v2] rust/kernel/faux: mark Registration methods inline
Message-ID: <Z89Fne9Yn6zIBJ-L@cassiopeiae>
References: <jesg4yu7m6fvzmgg5tlsktrrjm36l4qsranto5mdmnucx4pvf3@nhvt4juw5es3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jesg4yu7m6fvzmgg5tlsktrrjm36l4qsranto5mdmnucx4pvf3@nhvt4juw5es3>

On Mon, Mar 10, 2025 at 03:51:38PM -0400, Ethan Carter Edwards wrote:
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

Acked-by: Danilo Krummrich <dakr@kernel.org>

