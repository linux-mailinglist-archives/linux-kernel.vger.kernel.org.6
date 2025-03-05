Return-Path: <linux-kernel+bounces-547169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 864BBA503C1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C218D3A6E78
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78630230BC6;
	Wed,  5 Mar 2025 15:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQm7s/zD"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CAB8828
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 15:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741189626; cv=none; b=ILgp3Q/NOJqPSFkBM/Uxn0RBtGG1z+lxKhKe0SA7QZ51gvMttNMG8CiCwPV3xONeEsSGXHrZ6zFDfzhzqvmDVu3r91ZJsXoFd1QND9edo52skJ6ZNlxLUApsfC0vcnKuWI3gewaFMgtPoVgedePAl7EoA7BkewAQPMy3iAcVNFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741189626; c=relaxed/simple;
	bh=hCiS72UNC+mZ/ZPj88A454qBxiESlYdRanqwmJlg0M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/77RETxtG85OCefY1bxKTmakfIc5d5UUoj9vGdCfGmLXND73c1rMTDqQHxJWcOL6gpnXRViJuD5sv15+rm1wQfajpqucMUyT1dB8vucpTieJtepyeEl9vcIq7YzbHi8OYw31rzjXnQiF+n4+DKJRmrhYxgrApJ3CJ96TgGHSbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQm7s/zD; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2f9d3d0f55dso11437491a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 07:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741189624; x=1741794424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qbmBv9WPN2ltuxsgR8pg8jbB1hgd+dc954tuEUYQ9Iw=;
        b=iQm7s/zDJf4ELqK+5JEQTll+oHOFmIhv5B3xAUtnXsa3DRGkBg2pfZwDaELAgZlX1+
         7aX0YUwbVyLvlKbWvq+XeOnQsXbfwuK+r57x2M0HFGs8RXNEJgPtR5Z8myISPRj6Geet
         Bn9S99fc1RfSlM/O8B8UqiyvlxqLjEW5kWtOrZX67IswIpJNs0snZNy4/YX3WG9p0O7Y
         jgMWjy3pMwWvXCwIT5g+6vZ/cTIAtPYHy5x3RyBxcIAvP4Y1aY9bSXzL7V6xrECKKX42
         YYSh5a0SGnSi48sbEZ+m/2Bvorrkrwe2SE1nsriZe5SLhRbwpFo0Wvl0Gv3Xh9T6zqFO
         5jsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741189624; x=1741794424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbmBv9WPN2ltuxsgR8pg8jbB1hgd+dc954tuEUYQ9Iw=;
        b=jVfqDnLjegrVoM6GNOdAZpFlO8OCHHwrTyjUHV7jzzNfxQ38k2KNaBxPiDil2TlVH+
         DOgl0QFhy9/sSKt5RyEesrY2Pa6o3vHocS0wgXvmU1ar6yYcNDps6daYXGarQwRFlQsu
         rJftjpD/4qXnVBCR7fhhaQ/BZEl4ypky1HJqVAyV9WsH9y1lXMJp+bZ/eR/i0IBc1aCn
         ZF3DatLILvHbABUWoahTFM6Nib7gLIrT7cRGYRF9amd3O8/QNFt+XdFzpXaiYIMQ2hAv
         SsERn2jvRYAKUHCyDwGG9ZRXx+H0ljvZ+K81yZTVEsMSlYS7TAyaffVMPMZOYakbaPdu
         mBbg==
X-Forwarded-Encrypted: i=1; AJvYcCVjAz/oYkuj0VQoZz0tn6EhGTLbaiicJbMxj8M+zb09Nx154OQ6W6En9sAh4I1agyUEhiEvOu3F6Y0evy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJfSJ/LmB/QPj/078pY2r+9vdlqBom2azUbFtllbq8y+I/WNDD
	jzEkrhjBapw2VmN6sLwUnpcBaXStr4ZuSBiMi065+tZiIQt8BxID
X-Gm-Gg: ASbGnctmo1DAymhAbTN1UiYAnZVsiMXOU6mXgWRrPJMJmMw+UG3oEcd0ddOLXo3nBbf
	WhodHinOWe0zQVXuCi8ATqOiOlHXSbiHmq4SPZgwk5iEjlMwn3vPYxFdUfkmFmqt9OektJLDWfL
	8GCA7oeoPF7SWqvOpFYPcjP4X44Z+x9uMBRI+Vbz5miQ1Zfr9ohJdgjlnuZMSQU4jzRO9wWtrRj
	8vO0BCcXW1/sRDHaze7L8gEo4hDEzOS+lvCM09OZyia2qizl4lRkxGtbWSowhzstgFzREdnXqj/
	rflGBgjEl6AdTZqV87qNgIT0xj1Ne4mxqKu3g+XxJY2U
X-Google-Smtp-Source: AGHT+IH6GxbgpDkJALxCm31tn74sfA7iweXsWVkgkcuDtN2qWf9CiMByQx77ZiiaPQFQa+lPoaMXpQ==
X-Received: by 2002:a17:90b:48c7:b0:2fe:a0ac:5fcc with SMTP id 98e67ed59e1d1-2ff497c57ccmr5005442a91.34.1741189622904;
        Wed, 05 Mar 2025 07:47:02 -0800 (PST)
Received: from localhost ([216.228.125.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e7ff9f7sm1491518a91.33.2025.03.05.07.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 07:47:02 -0800 (PST)
Date: Wed, 5 Mar 2025 10:47:00 -0500
From: Yury Norov <yury.norov@gmail.com>
To: mailhol.vincent@wanadoo.fr
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Andi Shyti <andi.shyti@linux.intel.com>,
	David Laight <David.Laight@aculab.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v4 3/8] bits: introduce fixed-type genmasks
Message-ID: <Z8hx9AaUX_GvYq_A@thinkpad>
References: <20250305-fixed-type-genmasks-v4-0-1873dcdf6723@wanadoo.fr>
 <20250305-fixed-type-genmasks-v4-3-1873dcdf6723@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305-fixed-type-genmasks-v4-3-1873dcdf6723@wanadoo.fr>

On Wed, Mar 05, 2025 at 10:00:15PM +0900, Vincent Mailhol via B4 Relay wrote:
> From: Yury Norov <yury.norov@gmail.com>
> 
> Add __GENMASK_t() which generalizes __GENMASK() to support different
> types, and implement fixed-types versions of GENMASK() based on it.
> The fixed-type version allows more strict checks to the min/max values
> accepted, which is useful for defining registers like implemented by
> i915 and xe drivers with their REG_GENMASK*() macros.
> 
> The strict checks rely on shift-count-overflow compiler check to fail
> the build if a number outside of the range allowed is passed.
> Example:
> 
> 	#define FOO_MASK GENMASK_U32(33, 4)
> 
> will generate a warning like:
> 
> 	../include/linux/bits.h:41:31: error: left shift count >= width of type [-Werror=shift-count-overflow]
> 	   41 |          (((t)~0ULL - ((t)(1) << (l)) + 1) & \
> 	      |                               ^~
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Co-developed-by?

> ---
> Changelog:
> 
>   v3 -> v4:
> 
>     - The v3 is one year old. Meanwhile people started using
>       __GENMASK() directly. So instead of generalizing __GENMASK() to
>       support different types, add a new GENMASK_t().
> 
>     - replace ~0ULL by ~_ULL(0). Otherwise, __GENMASK_t() would fail
>       in asm code.
> 
>     - Make GENMASK_U8() and GENMASK_U16() return an unsigned int. In
>       v3, due to the integer promotion rules, these were returning a
>       signed integer. By casting these to unsigned int, at least the

This comment will disappear when I'll apply the patch. Can you comment
it in the code instead?

>       signedness is kept.
> ---
>  include/linux/bitops.h |  1 -
>  include/linux/bits.h   | 33 +++++++++++++++++++++++++++++----
>  2 files changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index c1cb53cf2f0f8662ed3e324578f74330e63f935d..9be2d50da09a417966b3d11c84092bb2f4cd0bef 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -8,7 +8,6 @@
>  
>  #include <uapi/linux/kernel.h>
>  
> -#define BITS_PER_TYPE(type)	(sizeof(type) * BITS_PER_BYTE)
>  #define BITS_TO_LONGS(nr)	__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
>  #define BITS_TO_U64(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u64))
>  #define BITS_TO_U32(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u32))
> diff --git a/include/linux/bits.h b/include/linux/bits.h
> index 5f68980a1b98d771426872c74d7b5c0f79e5e802..f202e46d2f4b7899c16d975120f3fa3ae41556ae 100644
> --- a/include/linux/bits.h
> +++ b/include/linux/bits.h
> @@ -12,6 +12,7 @@
>  #define BIT_ULL_MASK(nr)	(ULL(1) << ((nr) % BITS_PER_LONG_LONG))
>  #define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
>  #define BITS_PER_BYTE		8
> +#define BITS_PER_TYPE(type)	(sizeof(type) * BITS_PER_BYTE)
>  
>  /*
>   * Create a contiguous bitmask starting at bit position @l and ending at
> @@ -25,14 +26,38 @@
>  
>  #define GENMASK_INPUT_CHECK(h, l) BUILD_BUG_ON_ZERO(const_true((l) > (h)))
>  
> -#define GENMASK(h, l) \
> -	(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> -#define GENMASK_ULL(h, l) \
> -	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
> +/*
> + * Generate a mask for the specified type @t. Additional checks are made to
> + * guarantee the value returned fits in that type, relying on
> + * shift-count-overflow compiler check to detect incompatible arguments.
> + * For example, all these create build errors or warnings:
> + *
> + * - GENMASK(15, 20): wrong argument order
> + * - GENMASK(72, 15): doesn't fit unsigned long
> + * - GENMASK_U32(33, 15): doesn't fit in a u32
> + */
> +#define GENMASK_t(t, h, l)				\

Agree with Andy. This should be GENMASK_TYPE, or triple-underscored
___GENMASK() maybe. This _t thing looks misleading.

> +	(GENMASK_INPUT_CHECK(h, l) +			\
> +	 (((t)~ULL(0) - ((t)1 << (l)) + 1) &		\
> +	  ((t)~ULL(0) >> (BITS_PER_TYPE(t) - 1 - (h)))))

Can you rebase it on top of -next? In this dev cycle I merge a patch
that reverts the __GENMASK() back to:

#define __GENMASK(h, l) (((~_UL(0)) << (l)) & (~_UL(0) >> (BITS_PER_LONG - 1 - (h))))

> +#define GENMASK(h, l) GENMASK_t(unsigned long,  h, l)
> +#define GENMASK_ULL(h, l) GENMASK_t(unsigned long long, h, l)

This makes __GENMASK() and __GENMASK_ULL() unused in the kernel, other
than in uapi. Or I misunderstand it?

Having, in fact, different implementations of the same macro for kernel
and userspace is a source of problems. Can we move GENMASK_TYPE() to uapi,
and implement __GENMASK() on top of them? If not, I'd prefer to keep
GENMASK and GENMASK_ULL untouched.

Can you run bloat-o-meter and ensure there's no unwanted effects on
code generation?

>  /*
>   * Missing asm support
>   *
> + * __GENMASK_U*() depends on BITS_PER_TYPE() which would not work in the asm

And there's no __GENMASK_U*(), right?

> + * code as BITS_PER_TYPE() relies on sizeof(), something not available in
> + * asm. Nethertheless, the concept of fixed width integers is a C thing which
> + * does not apply to assembly code.
> + */
> +#define GENMASK_U8(h, l) ((unsigned int)GENMASK_t(u8,  h, l))
> +#define GENMASK_U16(h, l) ((unsigned int)GENMASK_t(u16, h, l))

Typecast to the type that user provides explicitly?  And maybe do
in GENMASK_TYPE()

> +#define GENMASK_U32(h, l) GENMASK_t(u32, h, l)
> +#define GENMASK_U64(h, l) GENMASK_t(u64, h, l)

OK, this looks good. But GENMASK_U128() becomes a special case now.
The 128-bit GENMASK is unsued, but it's exported in uapi. Is there any
simple way to end up with a common implementation for all fixed-type
GENMASKs?

> +
> +/*
>   * __GENMASK_U128() depends on _BIT128() which would not work
>   * in the asm code, as it shifts an 'unsigned __int128' data
>   * type instead of direct representation of 128 bit constants

This comment is duplicated by the previous one. Maybe just join them?
(Let's wait for a while for updates regarding GENMASK_U128 status before
doing it.)

