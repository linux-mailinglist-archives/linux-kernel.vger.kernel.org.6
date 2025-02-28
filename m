Return-Path: <linux-kernel+bounces-537988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E51AA4934C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 611183B584D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AD62441A1;
	Fri, 28 Feb 2025 08:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfhi+k5P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59B7241CB5;
	Fri, 28 Feb 2025 08:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740730821; cv=none; b=VhpMNNPbuqn0U908GKgyUL6lBjXnfzp3/4qPCSxX3RKfayQPSiz4ZCeeYQi2cPPqeJIm7W1XNDQp4QsKuWw8fZTYuMAmAQ32PvPfE38s9jWq9NFmoJCKuNHd7uBREmPS+rNATGyNq4UMEdeJbCu0Z10ZoAjdqJiwh58cKi3gpJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740730821; c=relaxed/simple;
	bh=OEgpyMB4mVz6xatqE7RFgUZeG48lXrAMDdUyOzv9uoM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dzt5vySpp42MzKBX+fyQY2vTMdVYX5/Byqn0mSQD/9gtP7u9CGEg7E/iy8ByDIZYOytgx+tRuYRER4hvn6gZUdplwZO1fFoHi3jri0Qg840EV4PxpV0dOnkeUYQTUEAZTEqGEAwq1nH30UcG1j59B80FsQtvdI2NFdXLpR40m9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfhi+k5P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70BCFC4CED6;
	Fri, 28 Feb 2025 08:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740730819;
	bh=OEgpyMB4mVz6xatqE7RFgUZeG48lXrAMDdUyOzv9uoM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bfhi+k5PGKHOytnaDgogFOZMKWU/7OkKnKF5XpK9xc3sMCy8q6/MocZmU5zn3yeHd
	 P5Kq6xcPKMQGEtjUzq/XWfSPzrJbCRLdZkziAosodf+AKzgR1Xcz5MYsIj0HoTL7Hz
	 gFT8JUGfzxz4EI4CTjNVoISrmdH2UeovZSpVoy2P8dKR698GA8HrBdmsCnX3Bc2RTt
	 HuXY6Y7LYKOarTLmv/YK2M9bbaJpJRXMWkyAn05Fr7psuZ+edeIMcDMx3Lw8H0U8e8
	 3nZVIeuQo95PgyQgn7VCgm0xb+UvpA5+a1+qVkA9D1oYT/tmZ3buhInqUzUSNphHkt
	 xIIf0/3TL36Vg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Petr Mladek" <pmladek@suse.com>,  "Steven Rostedt"
 <rostedt@goodmis.org>,  "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>,  "Rasmus Villemoes"
 <linux@rasmusvillemoes.dk>,  "Sergey Senozhatsky"
 <senozhatsky@chromium.org>,  "Andrew Morton" <akpm@linux-foundation.org>,
  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,  "Benno
 Lossin"
 <benno.lossin@proton.me>,  "Trevor Gross" <tmgross@umich.edu>,  "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>,  "Maxime Ripard"
 <mripard@kernel.org>,  "Thomas Zimmermann" <tzimmermann@suse.de>,  "David
 Airlie" <airlied@gmail.com>,  "Simona Vetter" <simona@ffwll.ch>,
  <linux-kernel@vger.kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 1/4] rust: fix signature of rust_fmt_argument
In-Reply-To: <20250227-export-macro-v1-1-948775fc37aa@google.com> (Alice
	Ryhl's message of "Thu, 27 Feb 2025 17:01:59 +0000")
References: <20250227-export-macro-v1-0-948775fc37aa@google.com>
	<qxbD5y-rJZMJDMN1wtODJBCAdNtNdQFsYIDhZUex7KcbPiUvABElh5V8c9EFoAPZ7xQe_L8JS6MzAIqciAb12w==@protonmail.internalid>
	<20250227-export-macro-v1-1-948775fc37aa@google.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 28 Feb 2025 09:13:25 +0100
Message-ID: <87v7suo5ay.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> Without this change, the rest of this series will emit the following
> error message:
>
> error[E0308]: `if` and `else` have incompatible types
>   --> <linux>/rust/kernel/print.rs:22:22
>    |
> 21 | #[export]
>    | --------- expected because of this
> 22 | unsafe extern "C" fn rust_fmt_argument(
>    |                      ^^^^^^^^^^^^^^^^^ expected `u8`, found `i8`
>    |
>    = note: expected fn item `unsafe extern "C" fn(*mut u8, *mut u8, *mut c_void) -> *mut u8 {bindings::rust_fmt_argument}`
>               found fn item `unsafe extern "C" fn(*mut i8, *mut i8, *const c_void) -> *mut i8 {print::rust_fmt_argument}`
>
> The error may be different depending on the architecture.
>
> Fixes: 787983da7718 ("vsprintf: add new `%pA` format specifier")
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  lib/vsprintf.c       | 2 +-
>  rust/kernel/print.rs | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 56fe96319292..a8ac4c4fffcf 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -2285,7 +2285,7 @@ int __init no_hash_pointers_enable(char *str)
>  early_param("no_hash_pointers", no_hash_pointers_enable);
>
>  /* Used for Rust formatting ('%pA'). */
> -char *rust_fmt_argument(char *buf, char *end, void *ptr);
> +char *rust_fmt_argument(char *buf, char *end, const void *ptr);
>
>  /*
>   * Show a '%p' thing.  A kernel extension is that the '%p' is followed
> diff --git a/rust/kernel/print.rs b/rust/kernel/print.rs
> index b19ee490be58..8551631dedf1 100644
> --- a/rust/kernel/print.rs
> +++ b/rust/kernel/print.rs
> @@ -6,13 +6,13 @@
>  //!
>  //! Reference: <https://docs.kernel.org/core-api/printk-basics.html>
>
> -use core::{
> +use core::fmt;
> +
> +use crate::{
>      ffi::{c_char, c_void},
> -    fmt,
> +    str::RawFormatter,
>  };
>
> -use crate::str::RawFormatter;
> -
>  // Called from `vsprintf` with format specifier `%pA`.
>  #[expect(clippy::missing_safety_doc)]
>  #[no_mangle]

The changes in this last hunk is not mentioned in the commit message.


Best regards,
Andreas Hindborg



