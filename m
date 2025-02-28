Return-Path: <linux-kernel+bounces-539233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C53A4A249
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D64AF172775
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E205A1F4CA5;
	Fri, 28 Feb 2025 18:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpCy+tlI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439A427700E;
	Fri, 28 Feb 2025 18:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740769121; cv=none; b=PytRgLq0so0LLeDlY9yMZklHs2OCF/0GXDM/uM3mPP3dIXW90UTFcpPkado7DMD14oEwtalCG8rtWHX3xr/76HqAKa/w6G/ZLmuSFmmbL05RR5a6IGIN9/N1qHKhHgmU2otxDW7zRFD2KPtrREZ/mvKYjhNVkLNGrgLEcS9teY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740769121; c=relaxed/simple;
	bh=0CWAFx3at7Ov80r+klQBiRHBMyocMZNWKTji/2lWbWo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wfj27SCscqKIsmZxOUC8TZKMuzVFE98Up/VszlCeuQMIdAKk6hH1q6e1ncOSFGWEFR1V/T0Lu/QuNP7fgupC7t3KFwfb94dpHOq4D7ZkqYZYjhq1kN3mByeIEQbMrxzvkMSLJ9WIKZAbKCa7jiy0W+h2FiVux6hlTgKG2ufjXug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpCy+tlI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9309C4CEE5;
	Fri, 28 Feb 2025 18:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740769120;
	bh=0CWAFx3at7Ov80r+klQBiRHBMyocMZNWKTji/2lWbWo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hpCy+tlIL/WiH8sIXrgw1CU9Iu7kCns02O5uwQNuWa+pDA5b8HsPwx7OVt0GpDHqI
	 +Kn2pMfpWYk7v8zHZolQ/YqFAbVdzknKNL+qBy9nBz/bAYz5BmBd10QrN6tVfmrHCd
	 v3M/fqA96zdyp4cKGpCQxrvmm+sVNAwYxkrqDoD2R422Bj7nqO7byGzOz22K7Edhap
	 cMmhxdV2uqpP7GlJcf2k636Iij0TcRh+fcO5+EUxr3QzMQMMWmZjF2D4MmXkBVtrIs
	 yHvsduUnQRZaoqdGTaua9jkMpB5EuwpZSX2EoxZX7/Op270jrlu2/9jjtRbNb4uu1D
	 aS7wZjmBj+S4w==
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
Subject: Re: [PATCH v2 3/5] rust: add #[export] macro
In-Reply-To: <20250228-export-macro-v2-3-569cc7e8926c@google.com> (Alice
	Ryhl's message of "Fri, 28 Feb 2025 12:39:32 +0000")
References: <20250228-export-macro-v2-0-569cc7e8926c@google.com>
	<fSc95Xx2hPhD6YoRZ9J69-yHCdUg6S-frMHo1td_JsVpE2Tw3HmgDeteQR1SN-XwdpLwAnhS9jBzq-JCh8aoVw==@protonmail.internalid>
	<20250228-export-macro-v2-3-569cc7e8926c@google.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 28 Feb 2025 19:53:31 +0100
Message-ID: <87y0xplx3o.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> Rust has two different tools for generating function declarations to
> call across the FFI boundary:
>
> * bindgen. Generates Rust declarations from a C header.
> * cbindgen. Generates C headers from Rust declarations.
>
> In the kernel, we only use bindgen. This is because cbindgen assumes a
> cargo-based buildsystem, so it is not compatible with the kernel's build
> system. This means that when C code calls a Rust function by name, its
> signature must be duplicated in both Rust code and a C header, and the
> signature needs to be kept in sync manually.
>
> To eliminate this manual checking, introduce a new macro that verifies
> at compile time that the two function declarations use the same
> signature. The idea is to run the C declaration through bindgen, and
> then have rustc verify that the function pointers have the same type.
>
> The signature must still be written twice, but at least you can no
> longer get it wrong. If the signatures don't match, you will get errors
> that look like this:
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
> It is unfortunate that the error message starts out by saying "`if` and
> `else` have incompatible types", but I believe the rest of the error
> message is reasonably clear and not too confusing.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>


Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg




