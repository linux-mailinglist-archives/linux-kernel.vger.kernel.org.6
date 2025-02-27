Return-Path: <linux-kernel+bounces-537322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 027C0A48A7D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48F6F188CFD5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAEC271281;
	Thu, 27 Feb 2025 21:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yh1/dnsX"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618B3270EC8;
	Thu, 27 Feb 2025 21:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740691781; cv=none; b=mtQ8H7lkfYdjnnbOIB+buDUK8CDqkBonzMdNjdv6ULg99e6P+d6eT49OSnoS7faC9U0QwjxHTYtmyO5duDC/oJHPMjBc3bVH/gDWUgQn7WHHc1F/r6KVsZnjBsk5EXP73AyQLVB0vspGNHOesFu7iJVdW+LHUajWTtcC+dHbd7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740691781; c=relaxed/simple;
	bh=pSxN5YSC2hWg3OMawMEMq+6m+7hxSAqh4xNdg0VOJrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCsWnL2OJGG7ZIAEjXtf4zSSkhOQBjj0Ht1pE2YcdW589q5t/jt46MrQgG2Jx92KEPVY8Tpa2DLiMb27FtaNBYhO1xDSMv3iGbxu3mTJ5gW25NDIdNBNAN71ohBXUBCMQZooxbNYlgTfBzG/8Ja5fPE9Hs/5UlKL7HRSG5JkZqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yh1/dnsX; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-47210ab1283so20265631cf.1;
        Thu, 27 Feb 2025 13:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740691778; x=1741296578; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMYme35BZpGxUGeEP8cC12QstjvajEPEqF5JaQ/Y5a4=;
        b=Yh1/dnsXWTTjJsXr2mTaDDPlLGfHbdJuZFShuA1eayPcJV3oYjlZSkMdHLbwVB+Y6H
         HHSGyI9bf+cZJg4qfHTxVDn7vKYV3twPZiiq6pjQDBNSQ99zMgi0aZCxGqXX73eWc3i9
         /4j8CLS9bspCfKb989X0rsT8Sm/L/bEVGzzfuWl5b23+TQjiOVBcNJdf1M1HJXKXz1Ly
         dGlcRif8iQaz3UoE0GkmygNxMrVi1s+/Pf9A6Xi6IX5ZwdQl3bXoMF4rTVSYKyVtvdsm
         cJUCX4cKF4q3/kc/N0TIgyNQEXI89nz+A6+sIkjW7YQF4eezoMpS8y1Kt6QvbQhT5wj2
         B4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740691778; x=1741296578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pMYme35BZpGxUGeEP8cC12QstjvajEPEqF5JaQ/Y5a4=;
        b=n8qiUlOIhynkPh0oUJPRlhBCUzUH0y8N9cQHMEAe0RJIPHzaoPkOySVwQi3FssiPcv
         4A9Qf1F97lf5x22Y+k5/K6PtYKDxf8ntHRDciFJVgqs9k4LxpMgvq4xpzd/xoRRov0MK
         /20Fa3B0495ZePsZb1uXapLA/aY8tT6Qo13uDeVZ9dqkrzGxl3XGacRISM6v5IxaJAFR
         1m2JpLWuN/Zuq64GmYlKfj943ebwQ9PbN9eskfbkXYXKyk2brNHeNvCzyznqk9mxJVdd
         IcWKIXWqEw4apevGbijgsnuhL3vi24IwdTimnQufxkw0mR06scbe+qOBMH2s8l00iimd
         egqw==
X-Forwarded-Encrypted: i=1; AJvYcCXLveOhy8+xU3dTLDgz0bQX/HHYYZY10Gen925KTH1Hwn8hlqHZ/ayBcPqXx1/xVBuieyzxmxDVNHeCaDc=@vger.kernel.org, AJvYcCXaQyXh5+zaNfzLh8BJSp6avAWL2HirRJQpv8lOe5Nq7L5DYC1yb0Sk+YTf2nd6mgU2z5SwMEDpejhbXVFjYn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOvcMt+Q3LTKvO67fg3EVskru0OTWywZK28bj/0VUblMAjPP4o
	GUib3Xk9uQGaSs244cWAe1SvD3Gj/faTXfXKDWJDkaz5oXMZ1AbE
X-Gm-Gg: ASbGncuF5fP4tmy0WnAWT5LIDu4UxrWePTwp4hLRQZtPsglPANHim8RIw2pxBJ/BcQN
	NVSDuZoIFyT/N84G3GdcinMCLdbDNI+5xZShKQT2wqOSMcvZBnshq4v/SJbIZX1BZ1h/HPTYt6u
	B3+c3yGkmspDx6RY/fiuc+9zzz79cx/GiM9xaVleKRgREA5STaczHzoOlsKPkek1YtMSe7CIeXj
	llte3F7fSpryxCGig3XnWL7YLdQCDQ/GButU6zYiYnMsoiSsWqEUnNP/8no8pcHdFIcS6qDvfYK
	doRU0RonLzKFp0QZsfyPdXV/soAMQWr10BchUtGVS1llC1BjTLcfgEV0bacEqrSF9rVdrwyiPzI
	sT5noqnUr0QftvnhQ
X-Google-Smtp-Source: AGHT+IHfFJ7Ib1C6jomDvlIhsy3en4tcKkX8nxtsA8sgaw7b5HqMRqGLntupkHR5FMA88h7oDdN8Zg==
X-Received: by 2002:ac8:5f0e:0:b0:472:fcd:a61f with SMTP id d75a77b69052e-474bc08f1b8mr10092431cf.27.1740691778166;
        Thu, 27 Feb 2025 13:29:38 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4746b5edf1asm15866181cf.28.2025.02.27.13.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 13:29:37 -0800 (PST)
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfauth.phl.internal (Postfix) with ESMTP id A3A7C120006A;
	Thu, 27 Feb 2025 16:29:36 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-13.internal (MEProxy); Thu, 27 Feb 2025 16:29:36 -0500
X-ME-Sender: <xms:QNnAZ9VDMfSX4H9yzd9cmoZDiRmU64ESZHdDL1Qfhx--FGITIMDS2g>
    <xme:QNnAZ9lbPcKut3JmUE1SvGqQa3LsMblyhmBsVaVtX39LAmTrbuFaB8vU4FiN1L97h
    Zpfl8ClWaxBIGGfLA>
X-ME-Received: <xmr:QNnAZ5ZpEabJF8bE8kuuKU9AM05F6p15bAYfoph_8mFls2dTvjzag2zY3Wo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekkeehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepffdtiefhieegtddvueeuffeiteevtdegjeeu
    hffhgfdugfefgefgfedtieeghedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvgdpnhgspghrtghpthhtohepvdefpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgrhgvghhk
    hheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehojhgvuggrse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehpmhhlrgguvghksehsuhhsvgdrtghomhdp
    rhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrdhorhhgpdhrtghpthhtoheprg
    hnughrihihrdhshhgvvhgthhgvnhhkoheslhhinhhugidrihhnthgvlhdrtghomhdprhgt
    phhtthhopehlihhnuhigsehrrghsmhhushhvihhllhgvmhhovghsrdgukhdprhgtphhtth
    hopehsvghnohiihhgrthhskhihsegthhhrohhmihhumhdrohhrghdprhgtphhtthhopegr
    khhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhg
X-ME-Proxy: <xmx:QNnAZwUlcgnShkha5Gj8VRv6NnfGnzJsrN1hlhSgk0DddvIskAEZ8A>
    <xmx:QNnAZ3kFvEV6WM63UIEYoK47MRQvaaRbnw0eT8cJallcFPumoLiWrw>
    <xmx:QNnAZ9emaxjGE1CQi1pGJ6_hkG4Xs7o-la0IiGi-Aq0UbdjOLpi37A>
    <xmx:QNnAZxHFjNDUL61VLcmBiNAUxuKlMcBrVubU8O7xqS0k-VPs0iJ1vA>
    <xmx:QNnAZxn7WbeJU7Vfl2HPa2PQmTaV-_k_kkvEEu_vW_Tlh9DhEU6pZoUi>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 16:29:36 -0500 (EST)
Date: Thu, 27 Feb 2025 13:28:48 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Gary Guo <gary@garyguo.net>,
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
Subject: Re: [PATCH 4/4] panic_qr: use new #[export] macro
Message-ID: <Z8DZEPoTJRwYj0p3@boqun-archlinux>
References: <20250227-export-macro-v1-0-948775fc37aa@google.com>
 <20250227-export-macro-v1-4-948775fc37aa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227-export-macro-v1-4-948775fc37aa@google.com>

On Thu, Feb 27, 2025 at 05:02:02PM +0000, Alice Ryhl wrote:
> This validates at compile time that the signatures match what is in the
> header file. It highlights one annoyance with the compile-time check,
> which is that it can only be used with functions marked unsafe.
> 
> If the function is not unsafe, then this error is emitted:
> 
> error[E0308]: `if` and `else` have incompatible types

Is there a way to improve this error message? I vaguely remember there
are ways to do customized error message.

Regards,
Boqun

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
> 2.48.1.658.g4767266eb4-goog
> 

