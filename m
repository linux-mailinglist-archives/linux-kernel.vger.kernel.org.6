Return-Path: <linux-kernel+bounces-539009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 481DCA49FC8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73D58174CCC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC45126FDB1;
	Fri, 28 Feb 2025 17:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="N2cJHHC2"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27591274269
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 17:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762401; cv=none; b=RiPL4ew5XQPZTCLbbM2x/7yTxtxA+UkxFXj3Y1O+qRtwsxdhvdPFgdEol9X4vzLHzLxCMPQ59rkzAhM/Yb5Bz+4ddog8fi04W4uohe5JCfMPySHROwc7v+h4nMQrk6ZORnXD8IFdW5b0dqFtwkp+j06YD4Q7W/vqUuV7mzuBNJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762401; c=relaxed/simple;
	bh=LqJp79I0SHXn+9V1u2EorjeF8j76dBe151E56tdKop8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDYPdlmE84cKi1TBhC/ykliJELPMtYChMSqbXqlLtuCxsBCoSy8r8Ip07qfCb9zEJJq9kNr5pKHvJQUaMWsLlOZw9d34dtSElO9boUcOoQz/BOPUnAfgzBVahJ5wSt5ke3ceSISfHDV0nLBa4VApAmdZATwtuys3rp7IPhrA7r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=N2cJHHC2; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-390dd3403fdso2058777f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1740762398; x=1741367198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k6qlfwUD5FmpL5nB2hYAi8mBfOK4uG+dWSAYbDiUuBI=;
        b=N2cJHHC2auvPVki7p3n9w7zEb1fPwmpjYxYtLo4Tbl8pjY04ibkjnpKoKgWnjibB7+
         SHjKK27CTFkUpui4f1uvSpz0Rz9cjGqOlRL57gWdnWqSyLx/AyEnYSXmo0K8+JEqUMdT
         pB40D/HTvpEmJ9s+e7kHcVhY/ynoL/sF0CSiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740762398; x=1741367198;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k6qlfwUD5FmpL5nB2hYAi8mBfOK4uG+dWSAYbDiUuBI=;
        b=TY8UI+hFm7Hi4FAW6Hp1VB1sMNHtxLR4Hlqt4AjbW7vBaivGhGobrl7qxEdVK6F2tL
         iwSZwlZhq87d6/ZylI3qf9dX2WK43mEouxtVcHHkpGyrAQGAiW2povWwA3ibhvjFeMHq
         2bE9pPNYqbo3atFhfJkm/e9b6adAxJC/grS1mR36o8pzGR4nFJqteVrPXwbEeeh/pbhC
         5qaHV0kNeHnZotzDMLybPi7Em+lkbiETGqIEcB6KzD8tvvL4X6NL44t8PfKJtb4tI+mY
         qB7T0USnEbjwd5FkHVOY9MtiN5FMJZVWFjbqyCO3bAqITAWfKeaO9D4WarqfnFRlOxn3
         J4mw==
X-Forwarded-Encrypted: i=1; AJvYcCV8Jgtx3yY+D8ZGzU8kJlb0vW+hcLfBiR/74GfO0lq8Awvy3aNsGxrTqFwiA9okLDDVzvY9v/j6dZT64Zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdrkmMyOFRbt9p2gikpjGF8jKNDkPnzsCsU/gp4r8gFgQRkMAz
	W7kU6IysHjusRKX2efEfqTdKux0LFXSuXgYYQk1ql/fORvU/9rGw4Xmgbut5hrk=
X-Gm-Gg: ASbGncvdLZSrB3y9Cp9aOklhlaWUa9ZaFVXKOhrDz8bnvPJwpfHfhASkw5kQ108dCPD
	LslrcMlCNqzRM5JzGHyrXAKgSFBDRfC4CuymXDVK4vXHLU81PIcJ+nAf88vHKDcORxHGgDVygS9
	6QmCATEeppS6YWt0GaDFUAbxgyUPb4HX40fIjNXwgJj/bgWwR+jlohGGHIh8oFXE2NDzOMaVGH/
	DBYSD2IIssc7WPnXBGWHexYKHPnioAKJZAnAuBjm3Y7fr2LFGshgU5yTL13L8PGSoYQFG/qHYte
	heCyrf4PAbuGRLJEIt7llncoxyuLkZKdpNRsCg==
X-Google-Smtp-Source: AGHT+IEHSdLntqA4vJ+k4vNL6cpNL9OkNh+/n1fHS6Zb4QIdLy5PGjtmFk+o+TY+g7KnCy/4qXM9Cg==
X-Received: by 2002:a05:6000:4027:b0:38d:bccf:f342 with SMTP id ffacd0b85a97d-390eca5b1c2mr3470538f8f.43.1740762398130;
        Fri, 28 Feb 2025 09:06:38 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b6cd8sm5684867f8f.44.2025.02.28.09.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 09:06:37 -0800 (PST)
Date: Fri, 28 Feb 2025 18:06:35 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 5/5] panic_qr: use new #[export] macro
Message-ID: <Z8HtG8fMSfdewkep@phenom.ffwll.local>
Mail-Followup-To: Alice Ryhl <aliceryhl@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	dri-devel@lists.freedesktop.org
References: <20250228-export-macro-v2-0-569cc7e8926c@google.com>
 <20250228-export-macro-v2-5-569cc7e8926c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228-export-macro-v2-5-569cc7e8926c@google.com>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Fri, Feb 28, 2025 at 12:39:34PM +0000, Alice Ryhl wrote:
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
> 987 | pub extern "C" fn drm_panic_qr_max_data_size(version: u8, url_len: usize) -> usize {
>     |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^ expected unsafe fn, found safe fn
>     |
>     = note: expected fn item `unsafe extern "C" fn(_, _) -> _ {kernel::bindings::drm_panic_qr_max_data_size}`
>                found fn item `extern "C" fn(_, _) -> _ {drm_panic_qr_max_data_size}`
> 
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

I guess makes most sense to land this all through a rust tree, for that:

Acked-by: Simona Vetter <simona.vetter@ffwll.ch>

The rust macro magic definitely flies above my head, so no revivew from
me.

Cheers, Sima

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
>  	stream.workspace = NULL;
>  }
>  
> -extern size_t drm_panic_qr_max_data_size(u8 version, size_t url_len);
> -
> -extern u8 drm_panic_qr_generate(const char *url, u8 *data, size_t data_len, size_t data_size,
> -				u8 *tmp, size_t tmp_size);
> -
>  static int drm_panic_get_qr_code_url(u8 **qr_image)
>  {
>  	struct kmsg_dump_iter iter;
> diff --git a/drivers/gpu/drm/drm_panic_qr.rs b/drivers/gpu/drm/drm_panic_qr.rs
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
> @@ -929,7 +932,7 @@ fn draw_all(&mut self, data: impl Iterator<Item = u8>) {
>  /// * `tmp` must be valid for reading and writing for `tmp_size` bytes.
>  ///
>  /// They must remain valid for the duration of the function call.
> -#[no_mangle]
> +#[export]
>  pub unsafe extern "C" fn drm_panic_qr_generate(
>      url: *const kernel::ffi::c_char,
>      data: *mut u8,
> @@ -980,8 +983,12 @@ fn draw_all(&mut self, data: impl Iterator<Item = u8>) {
>  /// * If `url_len` > 0, remove the 2 segments header/length and also count the
>  ///   conversion to numeric segments.
>  /// * If `url_len` = 0, only removes 3 bytes for 1 binary segment.
> -#[no_mangle]
> -pub extern "C" fn drm_panic_qr_max_data_size(version: u8, url_len: usize) -> usize {
> +///
> +/// # Safety
> +///
> +/// Always safe to call.
> +#[export]
> +pub unsafe extern "C" fn drm_panic_qr_max_data_size(version: u8, url_len: usize) -> usize {
>      #[expect(clippy::manual_range_contains)]
>      if version < 1 || version > 40 {
>          return 0;
> diff --git a/include/drm/drm_panic.h b/include/drm/drm_panic.h
> index f4e1fa9ae607..2a1536e0229a 100644
> --- a/include/drm/drm_panic.h
> +++ b/include/drm/drm_panic.h
> @@ -163,4 +163,11 @@ static inline void drm_panic_unlock(struct drm_device *dev, unsigned long flags)
>  
>  #endif
>  
> +#if defined(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
> +extern size_t drm_panic_qr_max_data_size(u8 version, size_t url_len);
> +
> +extern u8 drm_panic_qr_generate(const char *url, u8 *data, size_t data_len, size_t data_size,
> +				u8 *tmp, size_t tmp_size);
> +#endif
> +
>  #endif /* __DRM_PANIC_H__ */
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
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
> +
>  /* `bindgen` gets confused at certain things. */
>  const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
>  const size_t RUST_CONST_HELPER_PAGE_SIZE = PAGE_SIZE;
> 
> -- 
> 2.48.1.711.g2feabab25a-goog
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

