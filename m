Return-Path: <linux-kernel+bounces-538832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7786A49D96
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AB0E1899989
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424AE17A2E8;
	Fri, 28 Feb 2025 15:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EUy4xZ7A"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65791EF399;
	Fri, 28 Feb 2025 15:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740756894; cv=none; b=Ql3N/n/2kLjvLukEOOvzFW5/kf3X/WQOsxtRpN8ll8Fr/chCY0/uWl+ITY1xPJIdStmQYQEBihreoyCI1jsYy6SGvlgZ6LgimiCtOEzZy1c25pL9pb63k7wwvCeYOyuZe9MJDkpPrM9spGGoEV1I63Zx5qcVDIOxN6l2GLPZRL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740756894; c=relaxed/simple;
	bh=hoIVAnEnmN6EuWjyk3vWzUsF+GUxQ5fLOK1avR054jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkVX2cZSWDMqbe6S4D05GvlVOOmgfGJzyd0iYjOXZyeDeQaJrMxe+1+R6x/2xAlLhD9FtHKqF7ZJoKsaRFdVWxzkbjhFFUHy3sjXsWIe+h865d9/DJ9cW3eqQLH23ICxeMnPTianNF88cb6KNxmsuX7/9f4QeZvykM8hm1bhGJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EUy4xZ7A; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740756892; x=1772292892;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hoIVAnEnmN6EuWjyk3vWzUsF+GUxQ5fLOK1avR054jM=;
  b=EUy4xZ7ATz4B3BA8biNLlu6tp1Vm9uixahKWLdnQ0qlsM2s44uoX8Bxr
   Jzjw9OioiQl3nSkJiMonEYXryRsP47P0c1nVIGqY+Tc5tgYTgQ5HvnZ2t
   aWZKkfvDzgutbRtE6Z0wrDF3J50uNQTvIPYSSn/S0tNUmOmql1dB57sy6
   nSq4cTQjn55sRVbXXgNlB6LSr4SAjYnVyPvCaW7Lc5XKBriNTk9d5a2qs
   fej91bGMXjPlGoYAmdI5qzGLG1D3OZ3g0Dow5s187fdJbtvLOhKGazuzC
   KUyrFVUT2LmKHCLq5o7wF+DBBwvgEo8OQ2qbAWW2OExF3Siqa/IHc3u07
   w==;
X-CSE-ConnectionGUID: 1Z4IQCDTS9SIGgYSfDuCnw==
X-CSE-MsgGUID: HVu0EcfwTbKisSm0hs52sA==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="29282406"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="29282406"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 07:34:52 -0800
X-CSE-ConnectionGUID: oVLb54hiRr+7MeX9VmAH4w==
X-CSE-MsgGUID: 05cxxMQ1SI6OYdNLCpiw+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="117115612"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 07:34:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1to2Nu-0000000Fz4s-2Hwg;
	Fri, 28 Feb 2025 17:34:42 +0200
Date: Fri, 28 Feb 2025 17:34:42 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <Z8HXkmtrMMD1dATZ@smile.fi.intel.com>
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
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

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

...

> +#if defined(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
> +extern size_t drm_panic_qr_max_data_size(u8 version, size_t url_len);
> +
> +extern u8 drm_panic_qr_generate(const char *url, u8 *data, size_t data_len, size_t data_size,
> +				u8 *tmp, size_t tmp_size);

Is extern needed?

> +#endif

-- 
With Best Regards,
Andy Shevchenko



