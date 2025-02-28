Return-Path: <linux-kernel+bounces-538863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E582BA49E00
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 316D81706B1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7B5271281;
	Fri, 28 Feb 2025 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeMnWqQE"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B4E1B4250;
	Fri, 28 Feb 2025 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740757735; cv=none; b=s5Qeh2UOx4GitOoH6ck3MOasGokDeIo7MwHWZNTv38T0Ay0uicOX4Y/8z487TAzCl/9AednEp8FPZ6PJsNnbbqk15oG430xLGGmibhsNqzc42uQW5Z6rYf51u3PQiP5sqJJ5yHA/1UlqKXT+9iY65TtKbtdT956lmoJ9nDnaPtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740757735; c=relaxed/simple;
	bh=CTk8fv5WgSfiSrxecdOucC7vO2EdIJV4LHk7BL/WOFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q8EAHWFTaNWCUa0jixpX6sJnRgvZehpXWS5HJ3V1ySrD28fhD0VqbfL/QnpxuHvs5eq2DX1RZa8aIvNb6wjuY1J7qAvxN4Icrtfo76G2DHZEmHPikJnjXaT0i6HlP9CrwfsskVlO36q8t3jH20ZhrdXeB+YuyTbj+5YHL6RnUCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GeMnWqQE; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30a3092a9ebso24220181fa.1;
        Fri, 28 Feb 2025 07:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740757732; x=1741362532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQ4fegw5GEt8O8KL4/rvOxBAV+1hbqKfbwK90U7ORtA=;
        b=GeMnWqQEpfG6W2FwVljFzWRCwh8itWIy5cMeTcoe26Esnn2ccvXe45Dt+QqepOCiCx
         YAKdb0xi04tseNVHNJpsUGvRAPdr+Uf4cnsnDWszR0URZLrl/igNojOnR3rNk2Vbl8ke
         8Tpyhga/rfLlcWN1zwOST/cHimspOBxHDpdcvhQRaaSEVaDpU/DAEsfkNKM7M1l1i5fr
         5yEJ3TMrUuejlDBuMd/u0YfFJ/YKydwXlPxzRcqgAFs5eU3hYtAKcdk0nIygShA1c+0+
         Xr9fEmtiB44EP4XI6Dr7gKnaTXz6AwQjzbw3OUhbsOxEId5OcDI67ajzM6r0NBwbKdIB
         Wi/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740757732; x=1741362532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQ4fegw5GEt8O8KL4/rvOxBAV+1hbqKfbwK90U7ORtA=;
        b=hvfXVDd6opCYD0b2CdhdeXZKiyplxCzvrEam3wyIyTOzwuOVWepdOB4MxARYIfyKmT
         POrQTWmimWBnPP2HjZk/pOt2ILcQrFA9o37CaxflAjFRKroikmqrqfaD/AfNWPxYpXDN
         BJKuYUNrgmQf1jvN1I+CzHRWylDG7NS9CbPJymvm9UTNELfcSz+aXi/kf42NA7mYLxgN
         iuWuf8Trw8e9Ev+6QRcwnhoBNEN0TCzLST86bgTT4Jmc61VGb620VkX5yXNcQRuMl6tU
         Z6gy8qAN+p3wMX4VZyfNcHr/fsHGuaKO9U5iXXXHjZl4joZ9IO/XG7mIW9GItJNGLWfi
         oM4g==
X-Forwarded-Encrypted: i=1; AJvYcCUEhpstwhWDDjqgV1ayhWIUQ64/9mBZfK01C8mYnuABvZ5uWlSOXQ+Ma4J9irPxsCLWFpdgHC3MG6T2B31SwY0=@vger.kernel.org, AJvYcCXf444rL558z2MZ1Ex6l5wyXfasvLJhqXjBLOnkAugQmor78obXeCP4NsppjXLH+Xn+Y045AepiIUiKT20=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCetgf2dlaXwkFaJQX5kadPVcMnmIkG8D/FA0B/inGJzyb/1Xx
	b/lMzFmhehBW89R+531FcYJ9nyPKTyXl1H4p3OMaOrsXggtXVb04LDz4AhuSCjndm0+KcH24IVH
	08P8kKIB/ZlgOMev8qBX9nUhntJ8=
X-Gm-Gg: ASbGncvTfZVZjJPtB+Qi5Li9+718cNAcsypBtg3ZJg6orJpLoqjS6oGCIOTLhhp/ORR
	N4soTm3Epavx8tuka+j92MwZ2Er3XZFwEGBuqBrofswFSUm/8WLcW79hoCTyFY/czInSY5ET4dA
	sTH8kDDcYoBXOX/zKZI9F+DUbp0Ph1kTaKiElOnv/+
X-Google-Smtp-Source: AGHT+IH2mhDeR5Hvpiui7B9KmAUAyh41BNAkMj//f9oIevNwFxBXsUZSbVEKS0GLWxYFKbJGvd4IMaFIKRaVnZp82CY=
X-Received: by 2002:a2e:9252:0:b0:309:2653:5dc9 with SMTP id
 38308e7fff4ca-30b9331a3f3mr12205581fa.37.1740757731517; Fri, 28 Feb 2025
 07:48:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228-export-macro-v2-0-569cc7e8926c@google.com> <20250228-export-macro-v2-4-569cc7e8926c@google.com>
In-Reply-To: <20250228-export-macro-v2-4-569cc7e8926c@google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 28 Feb 2025 10:48:14 -0500
X-Gm-Features: AQ5f1JpzhY8OhWnuglzKNAfIJM2SCJNThQnH062kfucBfcLsGRF11ll6ypb922c
Message-ID: <CAJ-ks9mUXf2XNRaeftmfGPUvu9Lv3t_Ye+DoVuRhiTxQ5-C7Qw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] print: use new #[export] macro for rust_fmt_argument
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 7:41=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> This moves the rust_fmt_argument function over to use the new #[export]
> macro, which will verify at compile-time that the function signature
> matches what is in the header file.
>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> I'm not sure which header file to put this in. Any advice?
> ---
>  include/linux/sprintf.h | 3 +++
>  lib/vsprintf.c          | 3 ---
>  rust/kernel/print.rs    | 3 ++-
>  3 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/sprintf.h b/include/linux/sprintf.h
> index 33dcbec71925..029ad83efd74 100644
> --- a/include/linux/sprintf.h
> +++ b/include/linux/sprintf.h
> @@ -24,4 +24,7 @@ __scanf(2, 0) int vsscanf(const char *, const char *, v=
a_list);
>  extern bool no_hash_pointers;
>  int no_hash_pointers_enable(char *str);
>
> +/* Used for Rust formatting ('%pA'). */
> +char *rust_fmt_argument(char *buf, char *end, const void *ptr);
> +
>  #endif /* _LINUX_KERNEL_SPRINTF_H */
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index a8ac4c4fffcf..1da61c3e011f 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -2284,9 +2284,6 @@ int __init no_hash_pointers_enable(char *str)
>  }
>  early_param("no_hash_pointers", no_hash_pointers_enable);
>
> -/* Used for Rust formatting ('%pA'). */
> -char *rust_fmt_argument(char *buf, char *end, const void *ptr);
> -
>  /*
>   * Show a '%p' thing.  A kernel extension is that the '%p' is followed
>   * by an extra set of alphanumeric characters that are extended format
> diff --git a/rust/kernel/print.rs b/rust/kernel/print.rs
> index 61ee36c5e5f5..cf4714242e14 100644
> --- a/rust/kernel/print.rs
> +++ b/rust/kernel/print.rs
> @@ -8,13 +8,14 @@
>
>  use crate::{
>      ffi::{c_char, c_void},
> +    prelude::*,
>      str::RawFormatter,
>  };
>  use core::fmt;
>
>  // Called from `vsprintf` with format specifier `%pA`.
>  #[expect(clippy::missing_safety_doc)]
> -#[no_mangle]
> +#[export]
>  unsafe extern "C" fn rust_fmt_argument(
>      buf: *mut c_char,
>      end: *mut c_char,
>
> --
> 2.48.1.711.g2feabab25a-goog

Reviewed-by: Tamir Duberstein <tamird@gmail.com>

