Return-Path: <linux-kernel+bounces-538783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D19A49D03
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77538176008
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125631EF39F;
	Fri, 28 Feb 2025 15:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSxaWLjj"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798351EF381;
	Fri, 28 Feb 2025 15:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740755665; cv=none; b=ZAslo4Xf8J0GOA/tNVJnYL8b3sysJxQolezsSLtZ0NLrXMkpgsD7YKLNtcvmYDioQuIALXfDbM/OK72HnPziZn8OvrOJDq9vKBBlxvhj4msGQOXGlLivxKOK1Efua/e43SiNB+zwd4c3u0MfNmX5ok99Hs6roh66C8epU+jhkuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740755665; c=relaxed/simple;
	bh=DI0hC9zhDvh4I4bhUn5+gweNWh8TFwtPZH7NWOoJHco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OQ96PTMk3SsWl9OUKJBkoriMjAHXZJ2apBt18YVy05myZAp1TfzT9I7ayxkhSHjB2/6nQ07K0svYF1FM5taz3g6HNtKTvdVJeoxaGbd+N+kB0J7S7Vn+75HfKsHGf2DJYyefL9lje1KZCRfZ7dwHB+qzSHhGnjvbBSD7QohIYhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSxaWLjj; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-307bc125e2eso24529181fa.3;
        Fri, 28 Feb 2025 07:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740755661; x=1741360461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=grkPIIqnkl1tYy4u7pVLzybcjKkdicYzst48mzoDrY4=;
        b=DSxaWLjjpMKCmxLsn7PvZX3syGU1/IKlSQzo1UYJKN8dUd6fnbTbqW1RYIGIEP7/+m
         o52XP2kIp7FWHaRjCjNTykOD5QmXLrYdDWIxtlTks9vF4AXFjKtxIQsnhLE8hl2hKAVJ
         WyQOpA7SuW62JeBzfj49cm9IcIS1QExJiuGoS3hJRrcgzjTxAJltsmyUlRnWMT7g60X5
         HKE/R/VohpI+prDx6xxKCE7CPT1JJkGlT49xL+bFMQM/KOIVM44/w/uhq+5BvzCgvx2j
         iel0zrgftsR09cMURAVYsSnYdtJEFz2WHfkVpMa6+qJhviargQgTL+CsAQzcq46yFp6n
         IZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740755661; x=1741360461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=grkPIIqnkl1tYy4u7pVLzybcjKkdicYzst48mzoDrY4=;
        b=B0K3pdxR0ErFOr+FIwYVeYZywb4+4raM0S+2xjqPofiS2YvtG4UYbw6T+qCjKMxNLy
         JxWKruQlAicDw65wzuwtRWIdhF2cim51LM9sKhKJhhltJjdtFyopoE0ufvH8/1BAgHbq
         oYUXQq8MjtfRAUpuydDo+fwqbMOJpX5jM8pYVxVNazfnyGdrDo9E+YABynY2xawbw0+S
         cAE1IkiKU9BiBD4s6uHGpOPwD+oSFL5bAI2dUCuYvps4q03vlUn+xp2yv+D5W7uDXqyn
         4gelvXay1K5XyG1Kd50y18WvgvXif97y1s1aarEHOBeynscxX0Kw2wvjBkQlW0lUm05/
         C8qg==
X-Forwarded-Encrypted: i=1; AJvYcCUb3lSN9NqOHw3U3dnGvj1OzTESlUwfNgW7Rp/1JoziBXwKiVLaYquoCQQEHBJryE98GKom1eMU96fE7Fc=@vger.kernel.org, AJvYcCXNhRjQTT6aP6OdCIpMJPt7Nhl6ewZ/mTaTAhR8ev0p9sAz0H1VQsdnmSTZ+FVRigQjKcUuaZZ0Hn5mdlK9hFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg9qkubYV/OfJHX3+9JfhcUo2lJntsArRUfqz0MOllZv3G05ou
	9CCx/RuHCmj+h0ND3Ov4h6TokICi65lxq89FIs8dmQCVgUZ+WTttvBKK4zeymIx6vLiFmXA06Nz
	IjdWT3d0xVJLSrzgWyAxAp/15xDY=
X-Gm-Gg: ASbGncueoqmYae37hq1/7m0HJ6TOv8TpLKjkGK2CD2EIE4iBRix4xPUD0dZN93icu52
	hf1GPnePgSPbvk5p/YZLnsnaCx1u4Lards0Qz4W0NmOEz0DW1dL3sBnsHfSLMesMx4z3T/90Wrv
	pgB8B6HjayjGTSNMaq+mU0XuXkThhrxl/dtT+sKHgn
X-Google-Smtp-Source: AGHT+IG3PHPW7yEWyg9Nw7TQmjbaY2VbuXr0nAloJvWb506WO/YmCO9PC2FjjLDMuvJBNhfArD3zPEOrkBENci+r6jE=
X-Received: by 2002:a2e:b60b:0:b0:306:1524:4a65 with SMTP id
 38308e7fff4ca-30b932435c7mr11345361fa.20.1740755660982; Fri, 28 Feb 2025
 07:14:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228-export-macro-v2-0-569cc7e8926c@google.com> <20250228-export-macro-v2-1-569cc7e8926c@google.com>
In-Reply-To: <20250228-export-macro-v2-1-569cc7e8926c@google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 28 Feb 2025 10:13:44 -0500
X-Gm-Features: AQ5f1Jqj0UjIh923vMoZYOcwXSYHASRuQN-dYsI28FEvaRmHFLu_NCNyw0Ju9ZI
Message-ID: <CAJ-ks9nmFDqsBrmxC0nCPQB=OTeKKUucs4AqJSRN4hsGkSPwEg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] rust: fix signature of rust_fmt_argument
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
>    =3D note: expected fn item `unsafe extern "C" fn(*mut u8, *mut u8, *mu=
t c_void) -> *mut u8 {bindings::rust_fmt_argument}`
>               found fn item `unsafe extern "C" fn(*mut i8, *mut i8, *cons=
t c_void) -> *mut i8 {print::rust_fmt_argument}`
>
> The error may be different depending on the architecture.
>
> To fix this, change the void pointer argument to use a const pointer,
> and change the imports to use crate::ffi instead of core::ffi for
> integer types.
>
> Fixes: 787983da7718 ("vsprintf: add new `%pA` format specifier")
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  lib/vsprintf.c       | 2 +-
>  rust/kernel/print.rs | 7 +++----
>  2 files changed, 4 insertions(+), 5 deletions(-)
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
> index b19ee490be58..61ee36c5e5f5 100644
> --- a/rust/kernel/print.rs
> +++ b/rust/kernel/print.rs
> @@ -6,12 +6,11 @@
>  //!
>  //! Reference: <https://docs.kernel.org/core-api/printk-basics.html>
>
> -use core::{
> +use crate::{
>      ffi::{c_char, c_void},
> -    fmt,
> +    str::RawFormatter,
>  };
> -
> -use crate::str::RawFormatter;
> +use core::fmt;
>
>  // Called from `vsprintf` with format specifier `%pA`.
>  #[expect(clippy::missing_safety_doc)]
>
> --
> 2.48.1.711.g2feabab25a-goog

Reviewed-by: Tamir Duberstein <tamird@gmail.com>

