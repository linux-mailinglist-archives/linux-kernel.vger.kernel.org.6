Return-Path: <linux-kernel+bounces-537989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB95CA49352
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E02DB7A71D7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F30A245027;
	Fri, 28 Feb 2025 08:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEjJXe7L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE78241CB5;
	Fri, 28 Feb 2025 08:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740730825; cv=none; b=f+nyh9ZzWXXmQIidi+TNM+YcdFX0SrQW/zACwfkD/TQQWoE5u6HriNKWv+S1jIQxvFBgU0wEhMXmU/3wWtGpH7FiITKz0IymEflt7hk5NwhSCz8EIbs+WcWApBPBKOP+y1ywTxZPCuVY+mu7SK9EGwuac+JpcLe+qYd2cUtGiYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740730825; c=relaxed/simple;
	bh=07PaF1z2XapagVOUVls3LNjkNVKmOgxjvsYJxQn7wG8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J1BR0jzfGuLOGw0CMK9LLlIkrXQdMFe9QcIfcfPUJh9e7lwpsVN+FlumkNcQheJHKYvzMA8W7oyYJxVFGq+95G8tkkzRzX5hSTo4T9XS3LDxyJwka03FNW7pxu4Ym01MvsjZWlLR/aJgHaTuJrKaX5sWJayEOZYMOz3NIHaxhg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEjJXe7L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88C4C4CEE4;
	Fri, 28 Feb 2025 08:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740730824;
	bh=07PaF1z2XapagVOUVls3LNjkNVKmOgxjvsYJxQn7wG8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=iEjJXe7LbIrkINX5hp0Sgal0JU1zlp0qgi4Kd9CHEWE0Gkk7pcuXRiHXZvYNrsA23
	 n3trDI8u5ZVZFp0k+U/kBYctkJHaYCk+Bf9BhG61gSxtCYl2GZq3eusrNsonAWqHkX
	 5R83pyMHwTfHA8BxYDf3A6HR+4t1ohHRctB+QTliOM1+Q4NtwMRG4/zG+BBO5Tn8a8
	 FAAfhsJt3y11eHAiRfkDJrSjtTnTXQd2ivf1bb99U/vArwQV2qm8tQeLPjPjaqCt8J
	 rDh1okfNwoGmkQW2KQKz1HpMCs+Y/Q7nmcP9uaeepaBlweEFnf/oeToi8SRZ6Z2z1i
	 es14H5VYpVKmg==
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
Subject: Re: [PATCH 4/4] panic_qr: use new #[export] macro
In-Reply-To: <20250227-export-macro-v1-4-948775fc37aa@google.com> (Alice
	Ryhl's message of "Thu, 27 Feb 2025 17:02:02 +0000")
References: <20250227-export-macro-v1-0-948775fc37aa@google.com>
	<4cDCLbcJEQ7swGgJXKHMNNEKJT-zVTUP2Y__b8FvtuRWnKrlLV89Sa3hVF4Xh0t9QzFGm0yZ3f8gaIss-fGNng==@protonmail.internalid>
	<20250227-export-macro-v1-4-948775fc37aa@google.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 28 Feb 2025 09:19:59 +0100
Message-ID: <87jz9ao500.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> This validates at compile time that the signatures match what is in the
> header file. It highlights one annoyance with the compile-time check,
> which is that it can only be used with functions marked unsafe.

It would indeed be nice if there was a way to mark some functions to be
emitted as safe by bindgen.

>
> If the function is not unsafe, then this error is emitted:
>
> error[E0308]: `if` and `else` have incompatible types
>    --> <linux>/drivers/gpu/drm/drm_panic_qr.rs:987:19
>     |
> 986 | #[export]
>     | --------- expected because of this
> 987 | pub extern "C" fn drm_panic_qr_max_data_size(version: u8, url_len: usize) -> usize {
>     |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^ expected unsafe fn, found safe fn
>     |
>     = note: expected fn item `unsafe extern "C" fn(_, _) -> _ {kernel::bindings::drm_panic_qr_max_data_size}`
>                found fn item `extern "C" fn(_, _) -> _ {drm_panic_qr_max_data_size}`
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>


Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



