Return-Path: <linux-kernel+bounces-516438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BDBA3717F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 01:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58C5B167FA7
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 00:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D8DEC0;
	Sun, 16 Feb 2025 00:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="RNnOCkw0"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1A17FD
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 00:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739664785; cv=none; b=fCm6lwbSbpNvRX1ljFODVqSgyR/SAXJQkvd+qW+yKluZGgKLrlozUoxsK1DxQv4NWq68drdqNQzxkme9Zhca/BDvy0ZozJ+uQxFiuY0x12SvQBn8sqC6TQmI267Q08jziX3ZJzYo/vl3WzYRUSp98iEB/zWYegtph7dwMSKwtmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739664785; c=relaxed/simple;
	bh=QD486JtHs8u4Im9A2uDBFVUZyQYd+1OFyI8EK2WxMjk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZCT+quSd6Yd3gvYqJxNKR0Ndg+L6IMbA/lJFkpMyUdNH9YGjJMwceFuBVHw3sYaAPOWeUHEdZrFtS/k2xfrSbpSgJ8yHmhZ2DAt41NeXeWz5TJ0bDro6HA+rhGc+pnsAub6pHBP8emtUXv8lQPsk9g0le7GxFVIDson1+I9Yt/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=RNnOCkw0; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id BEA9C240029
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 01:12:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1739664775; bh=QD486JtHs8u4Im9A2uDBFVUZyQYd+1OFyI8EK2WxMjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=RNnOCkw0uNRjupc/nm0BJgO5kYWMwJZ/MiSMmDwvvovBzEGI+kX8YwWRxUq6UJzdr
	 7kYee5Ln9Kkppr8r7ROGbXxT6yuwcis4S8HSkASKqh716m6WqdKHM6h6ZFREOLsl7I
	 mE9CVU8tx98D+mkrW2yaKMe+TFrQ1jNczOwjC4usrHFb5Gtp9H0aXQWYVsqve5w1Or
	 2GMBwX+WKnePPaaCA29WTsAVFiOChPWe19EDfjSjmWOl28JNNk3tRqt90xvwkxEppc
	 bJ0q7FL9aIqE0kBJxvTNpseJWJTdrf25JGIRnQL4eSlVohGlPUYmYyh1l7VboyVBmb
	 tASdYUopKQG6A==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4YwR7m2ZDqz6ty8;
	Sun, 16 Feb 2025 01:12:52 +0100 (CET)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  "Rafael J. Wysocki"
 <rafael@kernel.org>,  Danilo Krummrich <dakr@kernel.org>,  Miguel Ojeda
 <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,  Boqun Feng
 <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6?=
 =?utf-8?Q?rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  Andreas Hindborg <a.hindborg@kernel.org>,
  Alice Ryhl <aliceryhl@google.com>,  Trevor Gross <tmgross@umich.edu>,
  Nathan Chancellor <nathan@kernel.org>,  Nick Desaulniers
 <ndesaulniers@google.com>,  Bill Wendling <morbo@google.com>,  Justin
 Stitt <justinstitt@google.com>,  Wedson Almeida Filho
 <wedsonaf@gmail.com>,  rust-for-linux@vger.kernel.org,
  linux-kernel@vger.kernel.org,  llvm@lists.linux.dev
Subject: Re: [PATCH] rust: fix clippy::too-long-first-doc-paragraph
In-Reply-To: <20250215223106.2346285-1-benno.lossin@proton.me>
References: <20250215223106.2346285-1-benno.lossin@proton.me>
Date: Sun, 16 Feb 2025 00:12:51 +0000
Message-ID: <m21pvy927w.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Benno Lossin <benno.lossin@proton.me> writes:

> When running `make LLVM=1 CLIPPY=1` on my machine, I get this error:
>
>     error: first doc comment paragraph is too long
>       --> rust/kernel/driver.rs:13:1
>        |
>     13 | / /// The [`RegistrationOps`] trait serves as generic interface for subsystems (e.g., PCI, Platform,
>     14 | | /// Amba, etc.) to provide the corresponding subsystem specific implementation to register /
>     15 | | /// unregister a driver of the particular type (`RegType`).
>     16 | | ///
>     17 | | /// For instance, the PCI subsystem would set `RegType` to `bindings::pci_driver` and call
>        | |_
>        |
>        = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#too_long_first_doc_paragraph
>        = note: `-D clippy::too-long-first-doc-paragraph` implied by `-D warnings`
>        = help: to override `-D warnings` add `#[allow(clippy::too_long_first_doc_paragraph)]`
>
> Thus add a short one-line description.
>
> Fixes: ea7e18289f44 ("rust: implement generic driver registration")
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
> The error also occurs in v6.14-rc1, so it must have slipped through our
> testing, which I find a bit strange. Also nobody reported it for rc1, so
> maybe this is only something that I encountered?
> ---
>  rust/kernel/driver.rs | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
> index 2a16d5e64e6c..65c9c1776556 100644
> --- a/rust/kernel/driver.rs
> +++ b/rust/kernel/driver.rs
> @@ -10,6 +10,8 @@
>  use core::pin::Pin;
>  use macros::{pin_data, pinned_drop};
>  
> +/// Generic interface for subsystem driver registrations.
> +///
>  /// The [`RegistrationOps`] trait serves as generic interface for subsystems (e.g., PCI, Platform,
>  /// Amba, etc.) to provide the corresponding subsystem specific implementation to register /
>  /// unregister a driver of the particular type (`RegType`).
>
> base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3

Hi,

I cannot reproduce this as-is, but adding
"-Wclippy::too_long_first_doc_paragraph" to the "rust_common_flags" in
the Makefile reproduces it. Maybe try adding it there in your patch?

diff --git a/Makefile b/Makefile
index 89628e354..e1b14fb68 100644
--- a/Makefile
+++ b/Makefile
@@ -486,6 +486,7 @@ export rust_common_flags := --edition=2021 \
 			    -Wclippy::undocumented_unsafe_blocks \
 			    -Wclippy::unnecessary_safety_comment \
 			    -Wclippy::unnecessary_safety_doc \
+			    -Wclippy::too_long_first_doc_paragraph \
 			    -Wrustdoc::missing_crate_level_docs \
 			    -Wrustdoc::unescaped_backticks
 

