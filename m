Return-Path: <linux-kernel+bounces-537079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A2EA487D7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C574C3A9BF7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0D3206F15;
	Thu, 27 Feb 2025 18:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ukv8ZNYh"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6892C20B1E1;
	Thu, 27 Feb 2025 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740681009; cv=none; b=ArXMUPIghPDZE/Uto0sTirfqwF6+oce+szN3S35BIiWbzeV4tHDj+xJhS3HU1mys2ZqrlI40oi9SrZdBVZzk22wyddgPihUuQEehiKxUnTwHmGDQVf8/hAS+GAj0s+E+eq/VpaTnXxQhJ3XEkkolWv0poKRsFXBYXTe+K6wZP4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740681009; c=relaxed/simple;
	bh=OycL5tLSb6kRnrnNo/gopmbCdrp+VP1JmXoUjo62ZhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m837gDov6D1B4VI0TUzJ0IHIPy2Io8gkTGhSS3ATjzXrlsDagh6pPZLfHlNnQb54URiEMPoQn4BdKEAnnMck20lhXcIvHMGGCnIOHSSsaArzk4FArmACCQfxBG1h8y86ZKLAJtjsrriRD43RfkE+MMUi87mqy4IHKe2wAzfVjoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ukv8ZNYh; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22328dca22fso21343215ad.1;
        Thu, 27 Feb 2025 10:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740681006; x=1741285806; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=caOIB/kbSO6skFmZNg/mE0ddm8H3WZ0wS7C69kcXQ/A=;
        b=Ukv8ZNYhLl4XcNPKsZEqQENYssDvJCu1JJjBaIBbpQgr1yg2FgF+Jrqm/B/xhp4f0F
         ONiNcsHF1ML85GN/ulB0KZA/NrCEvAIrJXGACj4kEfZi3mLjPx+2jBas/VQgqLSUBncz
         YXmH/gqQhj64KGD9g3lbFcFZPyB0Kv9aSqJwOCaSWKJHrvTvyxBbAPKfqS4/c1raHhnX
         qVHxBlOrP3DSuDj4L157BlnlyhHpLL8qaiwFsarJv2PEGNnZOA00FR1Q9KUQ+TY+nvtb
         rY+yaQrs5P+rtA3f5MlFxdphdRmaoV+xZywk6VoWVfbyBJlZ4RpWt6wl3gMJFy8BKCpf
         0GWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740681006; x=1741285806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=caOIB/kbSO6skFmZNg/mE0ddm8H3WZ0wS7C69kcXQ/A=;
        b=faX1BAbpARhemyuulHpSdVtqb+fQXMWLw2xjvhCcetc+B60GW4WMFhMCqUugq6YUD3
         oTW32PbPZN+yidaCIxCCNWX/g1moMZf49HXt7hYqo1bjgVpb6L7NLMyfZ5sMc4LfALwP
         AIIc+0i+bLNbDU9Q3BXp/P1qEeGxJf3sNiW7ov8Hq4E1NIbon9+4yf2r7d+LH5tjZkZV
         xhTuDVs2oX+deJiRAG9zR+/Ekuicid8dPL2JoRdAKQUOExHXNcMCR2t0QYTk0uxAu0UI
         6CGacvXQM1z3F+NYtSshHAlYfrH9RTTWuvYe34urRsIFVepylmKKO5rAIyDCLMMcyA29
         h2Ww==
X-Forwarded-Encrypted: i=1; AJvYcCWaTMLq6M/x1YnIaiiv8AeoaM2qkTJRd14zT4yLmKhneIcNu3uQWV7KYscJ3GoQDnuLgTPiRrLbVTv0uphgQDY=@vger.kernel.org, AJvYcCWcCHwnKHR8tjnX0u8S9/7gHkK5RWEbmUzXtDpflNK6WLBRxyUITJDVXOV4juD5k0vPhz3r71d7/TueVn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp+g1J+u64R9xXPGfaClnEKhbJVd8dnkIV1NYJc4ao79NHKV+t
	U7LsW/ydsBMFQcs4chTk1oN5zVGQc3yOM+MlxDkgE/7YSvaR6xlQ
X-Gm-Gg: ASbGncteC2X+FiB4v48Tb6qBGMp90LhIq5E9qwBVhuT6bB+TrYyt3Z8dsouYzePnKXi
	QZZbn89aHIcnlapPEGFDCsEJvndS1dJicO8jmeeTMleYuMZDC+WGmpfUx3eWioUq1C4htSyxhF0
	GJ5z26c0alKp+tMOW4Wi9BpUwrDFfoa95kOnRBjcvCYLDNHXELZ3qRbzaDYa000Pzn9EGLqrySS
	ly3KYy3G5WKtIXsnEPeN0CmZOx83N/33WIVgufgQ8nySbS17Jn0GL0JvLBM/bs3vFxZBQVkNiet
	Qv6PTccJdgBvNn+UMX2pHKFZRiTV0lWmcLX2R/7gLwKhPy+Tuw==
X-Google-Smtp-Source: AGHT+IGsfJjpo5l8BgWZFoLGtvXpgwVblWolnL+szEmEK/IVNKP+zBT3MDxaw5WEhutnZ/QH6UsBXA==
X-Received: by 2002:a17:903:22d2:b0:220:fe51:1aab with SMTP id d9443c01a7336-2236924f926mr2439475ad.38.1740681006557;
        Thu, 27 Feb 2025 10:30:06 -0800 (PST)
Received: from localhost (maglev-oncall.nvidia.com. [216.228.125.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a003dcedsm1983557b3a.125.2025.02.27.10.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 10:30:06 -0800 (PST)
Date: Thu, 27 Feb 2025 13:30:04 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Burak Emir <bqe@google.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: add bindings and API for bitmap.h and bitops.h.
Message-ID: <Z8CvLBwKeH2gM-2u@thinkpad>
References: <20250227101720.1811578-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227101720.1811578-1-bqe@google.com>

On Thu, Feb 27, 2025 at 10:08:41AM +0000, Burak Emir wrote:
> Adds a bitmap and bitops bindings and bitmap Rust API.
> These are for porting the approach from commit 15d9da3f818c ("binder:
> use bitmap for faster descriptor lookup") to Rust. The functionality
> in dbitmap.h makes use of bitmap and bitops.
> 
> The Rust bitmap API provides an abstraction to underlying bitmaps
> and bitops operations. For now, we only include methods that are
> necessary for reimplementing dbitmap.h. It is straightforward to add
> more methods later, as needed. We offer a safe API through
> bounds checks which panic if violated.
> 
> This series uses the usize type for sizes and indices into the bitmap,
> because Rust generally always uses that type for indices and lengths
> and it will be more convenient if the API accepts that type. This means
> that we need to perform some casts to/from u32 and usize, since the C
> headers use unsigned int instead of size_t/unsigned long for these
> numbers in some places.
> 
> Adds F: entries to MAINTAINERS.
> 
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Burak Emir <bqe@google.com>
> ---
> This series adds a Rust abstraction for bitmap, and binding helpers
> for inline methods of bitmap.h bitops.h.
> 
> It depends on [1] and [2] which add bitmap helpers, MAINTAINERS entries
> and an abstraction that is part of the bitmaps Rust API.
> 
> Question for Yury: What would you like us to do for the MAINTAINERS
> file? For now I just added the new files as F: entries.
> 
> [1] https://lore.kernel.org/all/20250224233938.3158-1-yury.norov@gmail.com/
> [2] https://lore.kernel.org/all/cover.1740475625.git.viresh.kumar@linaro.org/
> 
>  MAINTAINERS                     |   4 +
>  rust/bindings/bindings_helper.h |   1 +
>  rust/helpers/bitmap.c           |   8 ++
>  rust/helpers/bitops.c           |  13 +++
>  rust/helpers/find.c             |  15 +++
>  rust/helpers/helpers.c          |   3 +
>  rust/kernel/bitmap.rs           | 182 ++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs              |   1 +
>  8 files changed, 227 insertions(+)
>  create mode 100644 rust/helpers/bitmap.c
>  create mode 100644 rust/helpers/bitops.c
>  create mode 100644 rust/helpers/find.c
>  create mode 100644 rust/kernel/bitmap.rs
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6d6e55d8593b..359f09e8e2c0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4033,12 +4033,16 @@ BITMAP API BINDINGS [RUST]
>  M:	Yury Norov <yury.norov@gmail.com>
>  S:	Maintained
>  F:	rust/helpers/cpumask.c
> +F:	rust/helpers/find.c
> +F:	rust/helpers/bitmap.c
> +F:	rust/helpers/bitops.c

bitops.c is part of BITOPS API, not the BITMAP one. I think we need a
new record for it?

>  
>  BITMAP API [RUST]
>  M:	Viresh Kumar <viresh.kumar@linaro.org> (cpumask)
>  R:	Yury Norov <yury.norov@gmail.com>
>  S:	Maintained
>  F:	rust/kernel/cpumask.rs
> +F:	rust/kernel/bitmap.rs
>  
>  BITOPS API
>  M:	Yury Norov <yury.norov@gmail.com>
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 673b1daa9a58..50416c1a3de9 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -7,6 +7,7 @@
>   */
>  
>  #include <kunit/test.h>
> +#include <linux/bitmap.h>
>  #include <linux/blk-mq.h>
>  #include <linux/blk_types.h>
>  #include <linux/blkdev.h>
> diff --git a/rust/helpers/bitmap.c b/rust/helpers/bitmap.c
> new file mode 100644
> index 000000000000..4fa4e4f76110
> --- /dev/null
> +++ b/rust/helpers/bitmap.c
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bitmap.h>
> +
> +void rust_helper_bitmap_copy(unsigned long *dst, const unsigned long *src, unsigned int nbits)
> +{
> +	bitmap_copy(dst, src, nbits);
> +}
> diff --git a/rust/helpers/bitops.c b/rust/helpers/bitops.c
> new file mode 100644
> index 000000000000..191ef0341fd5
> --- /dev/null
> +++ b/rust/helpers/bitops.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bitops.h>
> +
> +void rust_helper_set_bit(unsigned int nr, volatile unsigned long *addr)
> +{
> +	set_bit(nr, addr);
> +}
> +
> +void rust_helper_clear_bit(unsigned int nr, volatile unsigned long *addr)
> +{
> +	clear_bit(nr, addr);
> +}

So you mention that you're rewriting dbitmap, and I took a brief look
at drivers/android/dbitmap.h.

What I can say is that at least dbitmap_acquire_next_zero_bit() abuses 
the set_bit() API. It should use non-atomic __set_bit(). If you're
going to re-write it, can you review the existing code and make sure
you're using the right API in a right way?

> diff --git a/rust/helpers/find.c b/rust/helpers/find.c
> new file mode 100644
> index 000000000000..3841d3f0330f
> --- /dev/null
> +++ b/rust/helpers/find.c
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/find.h>
> +
> +unsigned long rust_helper_find_last_bit(const unsigned long *addr, unsigned long size)
> +{
> +	return find_last_bit(addr, size);
> +}
> +
> +
> +unsigned long rust_helper_find_next_zero_bit(const unsigned long *addr, unsigned long size,
> +				 unsigned long offset)
> +{
> +	return find_next_zero_bit(addr, size, offset);
> +}

For those two, the find_*_bit() are the wrappers around _find_*_bit()
in lib/find_bit.c, with a few exceptions. The reason for having the
wrappers is an optimization that improves code generation for small
bitmaps.

In your case, when you wrap a macro, the optimization becomes impossible,
and the macro is unneeded.

From technical perspective, the underscored _find_*_bit() functions
should be accessible by rust directly. Can you confirm that? If so,
maybe just use them and avoid bloating?

Thanks,
Yury

