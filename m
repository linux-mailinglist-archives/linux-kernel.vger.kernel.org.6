Return-Path: <linux-kernel+bounces-538870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26887A49E10
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAA3618994AA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F7E270EA9;
	Fri, 28 Feb 2025 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYrYhf5p"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2675A1EF360;
	Fri, 28 Feb 2025 15:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740758133; cv=none; b=B7VbJPw+PPfUoqH71TP8MLrUP0PuC+zYifpz4p44WKTtbhVl9Oe/tNWcnDCxXkNbCyUAlkCnbrlPl9Kojb+lD/1BHv+F99fxUyBvOZelWUV3c0nX+87Wb6i5M1olRFxJ7xujL9kxPZhArfKTTcmk6nlHgcXZgLYX7YAYc6gefdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740758133; c=relaxed/simple;
	bh=akg3hfMrj8rJseZvQS4QHjk5DvDzbMeTuCXtQ3LNr1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KAWxUU9W2BczSgKAFm9KfbTf0KnYWJVEJP5K4MsW1NEgBeUE9fzqfUMFpVVbooszgNuxMfxS3axclT7/HOPi+1eUTwYnfFDWwa82KlPBQqJZBax4DRGObbpnbgIZsKjhrUvaiaE+14xHkBHxTeXFmFpdGXoDlDOyT1PqMo16j98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYrYhf5p; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-307bc125e2eso25039641fa.3;
        Fri, 28 Feb 2025 07:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740758129; x=1741362929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHn0qaSarOO5nkT/BqsOGpUW4y3+EJjr5cHJDOEs+kg=;
        b=XYrYhf5pg2IuBS7p5Pno1ffiW2tH6VHdJ8PsVsXvB5ebEJfV/bPXjy7tR/0bwZCnk4
         aFGn68CVO1uCQkXWy60eLjyGv6FESczL+26dmEPcKaMSyXDm74kwho+KNaKmtDwhRLs6
         w0qZ60ncu++t8r+UDvSjzJ1uBhmq1GFaKBQKtM0qrYiD7aEFKdlBxmU1/OIISVKQ1AXf
         xpLCdYM31U87MLheByncD16sY6hOuA0zc99BsC6i+R7MUB5UsqQ9mh+kDzxiRYrfaAmZ
         dtO0DLo+6TL3TCXjHJlUfdEsU5S7QUDawuE1vQ63PTkNji1CwQ8Lv6fCKMrnFzO/XALX
         G2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740758129; x=1741362929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bHn0qaSarOO5nkT/BqsOGpUW4y3+EJjr5cHJDOEs+kg=;
        b=Rcee7ykayfwqOvm8SFdhflSDb/hhxq7SFK3pDYT2dBe/0XV0PWmOC9BFJSGPLEnnBf
         hdDz983m8WVMgcm2acSFvlWb3m6wxA2Xe3vlyt/JwrB882NjRyE9XDljDVMUFTuuCHOm
         vWhTWHpKxaPFSje+S9bnTTthXVaBOi4MV0gaV50kEPeZkUcN+q6v0wgqB+WWEtVyWXEy
         GyLY4ANfFU+rybCeprlH7jJywZx15VjstEmEiscMa8G01K9QqYhiPbiEr2TVNmrq5aEi
         LNX8ijPmroFQeus9SQBtlGbtBp3ytwRT6KIPo3grtJPwPQJ3SeJLdoA8l2TtqKKFK31B
         OW+w==
X-Forwarded-Encrypted: i=1; AJvYcCWm9c8T1q/KXCSBxPvocjCSNgayMD0TOubN0628oNTUSCjBP4xZTIInyy7+MextXp61JF4t4TcaotK02ZmzF+A=@vger.kernel.org, AJvYcCXiLAMgg63mpFG2xXqF81BNwpbKUm4nzCfA15Bx3eaPqIussEVQg/q8ogFZ/fqC0KnGjq1zUPZ4PJs3lc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFdf4oNzBxtNIRsLXhbOGz3Z6Q6sfB0zS1zxHcz1jnE3G+TwGR
	t9EDAB5OWwoUQC+scn1m7S58o/K/kdtgu2XDNp1R7TbRJLuRrJ8nKJfHDJwH2ZSPJ8TAI5AIniT
	PYRTSZJtCeWv5obkkQx6zqokS4wI=
X-Gm-Gg: ASbGncseeFPuU/AUOqlSKII3r041gg5Dh6Yb1/7M1b1hyHMsr6/b+aIBlg9rf24xklx
	eezRLiN1O4ntAc0GaWt/6yeev/Mu1OHx6haIhLsNmDgvEVXElOy0C6883IxXjLN+XqgS8CaTcjD
	4coEuV5omLEM95W9TPXOlBl9ZvaaTYRwf4UWItGr6C
X-Google-Smtp-Source: AGHT+IH4TnWs7AAWR6mSZJGzeTPP/IV0kwlekYfbQHJwIpvtqQS+Igon57DpTKr3TLAm0ffmLUtfQbT9lsn73QyqZdk=
X-Received: by 2002:a05:651c:555:b0:308:eb34:103a with SMTP id
 38308e7fff4ca-30b932f6d82mr16293581fa.28.1740758128998; Fri, 28 Feb 2025
 07:55:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228-export-macro-v2-0-569cc7e8926c@google.com> <20250228-export-macro-v2-5-569cc7e8926c@google.com>
In-Reply-To: <20250228-export-macro-v2-5-569cc7e8926c@google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 28 Feb 2025 10:54:53 -0500
X-Gm-Features: AQ5f1Jr5a2e-MB7tbyFJrVeNND-UBub9gCfxNxl1epYDa4dtBuxZ-xEM_hkDrMo
Message-ID: <CAJ-ks9k4rZdpL5dDfwMHuiKFdyYdY00YioYxdtsqszpcbhzjHQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] panic_qr: use new #[export] macro
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
> This validates at compile time that the signatures match what is in the
> header file. It highlights one annoyance with the compile-time check,
> which is that it can only be used with functions marked unsafe.
>
> If the function is not unsafe, then this error is emitted:
>
> error[E0308]: `if` and `else` have incompatible types
>    --> <linux>/drivers/gpu/drm/drm_panic_qr.rs:987:19
>     |
> 986 | #[export]
>     | --------- expected because of this
> 987 | pub extern "C" fn drm_panic_qr_max_data_size(version: u8, url_len: =
usize) -> usize {
>     |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^ expected unsafe fn, fo=
und safe fn
>     |
>     =3D note: expected fn item `unsafe extern "C" fn(_, _) -> _ {kernel::=
bindings::drm_panic_qr_max_data_size}`
>                found fn item `extern "C" fn(_, _) -> _ {drm_panic_qr_max_=
data_size}`
>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  drivers/gpu/drm/drm_panic.c     |  5 -----
>  drivers/gpu/drm/drm_panic_qr.rs | 15 +++++++++++----
>  include/drm/drm_panic.h         |  7 +++++++
>  rust/bindings/bindings_helper.h |  4 ++++
>  4 files changed, 22 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index f128d345b16d..dee5301dd729 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -486,11 +486,6 @@ static void drm_panic_qr_exit(void)
>         stream.workspace =3D NULL;
>  }
>
> -extern size_t drm_panic_qr_max_data_size(u8 version, size_t url_len);
> -
> -extern u8 drm_panic_qr_generate(const char *url, u8 *data, size_t data_l=
en, size_t data_size,
> -                               u8 *tmp, size_t tmp_size);
> -
>  static int drm_panic_get_qr_code_url(u8 **qr_image)
>  {
>         struct kmsg_dump_iter iter;
> diff --git a/drivers/gpu/drm/drm_panic_qr.rs b/drivers/gpu/drm/drm_panic_=
qr.rs
> index bcf248f69252..d055655aa0cd 100644
> --- a/drivers/gpu/drm/drm_panic_qr.rs
> +++ b/drivers/gpu/drm/drm_panic_qr.rs
> @@ -27,7 +27,10 @@
>  //! * <https://github.com/bjguillot/qr>
>
>  use core::cmp;
> -use kernel::str::CStr;
> +use kernel::{
> +    prelude::*,
> +    str::CStr,
> +};
>
>  #[derive(Debug, Clone, Copy, PartialEq, Eq, Ord, PartialOrd)]
>  struct Version(usize);
> @@ -929,7 +932,7 @@ fn draw_all(&mut self, data: impl Iterator<Item =3D u=
8>) {
>  /// * `tmp` must be valid for reading and writing for `tmp_size` bytes.
>  ///
>  /// They must remain valid for the duration of the function call.
> -#[no_mangle]
> +#[export]
>  pub unsafe extern "C" fn drm_panic_qr_generate(
>      url: *const kernel::ffi::c_char,
>      data: *mut u8,
> @@ -980,8 +983,12 @@ fn draw_all(&mut self, data: impl Iterator<Item =3D =
u8>) {
>  /// * If `url_len` > 0, remove the 2 segments header/length and also cou=
nt the
>  ///   conversion to numeric segments.
>  /// * If `url_len` =3D 0, only removes 3 bytes for 1 binary segment.
> -#[no_mangle]
> -pub extern "C" fn drm_panic_qr_max_data_size(version: u8, url_len: usize=
) -> usize {
> +///
> +/// # Safety
> +///
> +/// Always safe to call.

This should explain why it's marked unsafe, since it's always safe to call.


> +#[export]
> +pub unsafe extern "C" fn drm_panic_qr_max_data_size(version: u8, url_len=
: usize) -> usize {
>      #[expect(clippy::manual_range_contains)]
>      if version < 1 || version > 40 {
>          return 0;
> diff --git a/include/drm/drm_panic.h b/include/drm/drm_panic.h
> index f4e1fa9ae607..2a1536e0229a 100644
> --- a/include/drm/drm_panic.h
> +++ b/include/drm/drm_panic.h
> @@ -163,4 +163,11 @@ static inline void drm_panic_unlock(struct drm_devic=
e *dev, unsigned long flags)
>
>  #endif
>
> +#if defined(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
> +extern size_t drm_panic_qr_max_data_size(u8 version, size_t url_len);
> +
> +extern u8 drm_panic_qr_generate(const char *url, u8 *data, size_t data_l=
en, size_t data_size,
> +                               u8 *tmp, size_t tmp_size);
> +#endif
> +
>  #endif /* __DRM_PANIC_H__ */
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 55354e4dec14..5345aa93fb8a 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -36,6 +36,10 @@
>  #include <linux/workqueue.h>
>  #include <trace/events/rust_sample.h>
>
> +#if defined(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
> +#include <drm/drm_panic.h>
> +#endif

Why the guard here?

It'd be nice to have a comment here explaining the atypical need for
this include.

> +
>  /* `bindgen` gets confused at certain things. */
>  const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN =3D ARCH_SLAB_MINALIGN=
;
>  const size_t RUST_CONST_HELPER_PAGE_SIZE =3D PAGE_SIZE;
>
> --
> 2.48.1.711.g2feabab25a-goog

With Andy's comment about extern addressed:

Reviewed-by: Tamir Duberstein <tamird@gmail.com>

