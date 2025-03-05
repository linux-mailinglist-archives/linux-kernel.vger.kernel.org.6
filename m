Return-Path: <linux-kernel+bounces-547140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB58A5035C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C890A3AA80D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8B82505AE;
	Wed,  5 Mar 2025 15:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8h+jKk8"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A438324EF74
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 15:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741188170; cv=none; b=MWXenY6HDAXLkAk0mH9qJNnrjMoQ5bj8LLs9AFde6r0r014urWmhb3m6O3htY//oUoG75c3N/BqZGdg5Rlxy1lAxDB0v+RrGjCcKLQnk1XSQvikipSBVReDdud6KmYLHi+D/QsBKUJCJHsnp4Bxu1H4eVKsBcbvcXxPxtIZZGDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741188170; c=relaxed/simple;
	bh=Qo+BGr2TBvsHVRBIX0vTbyi18FqjfNdtscTkmLrC8hY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpcxWEAE4adCiTveWToEy6Neo1Jkt/za0weniQ7v6gwdU+NnOYW3VCoSOy7BnxcwDjZDu2eOxUvAjaVy44ZAXBIyHOUkYXOm6DmzQz3FbmhYK1II/r15FYVea6DclPCFGslmbGYs1OoNFpjEE15n5mH0G9P+dhPb0KfJpBKd7jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8h+jKk8; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-223a7065ff8so13489025ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 07:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741188168; x=1741792968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mrrWcWF0YU7DOHeensr3xXw8xMJox0I/sU8mMGZ4O/8=;
        b=j8h+jKk8puWHU7li4tT/xt18hB3dMRY6oBbLdal3vfYD3WNWc9s3gb2A04etGO11Ob
         lb9v2kJlcMeqaoAAnEWGQqfuNdcTc3CTZyn1eU4aImNj2ZYDNGyjsCIyShgsvV45WIJF
         1USqmDPURQCb3DlLmtvgRfqcAWdooCDA8F57nUOFkF1qri1a3rSY/uS22gBva6OeZEqu
         Wquc9njH566pFERSLcB+8dkeiMLdg6wq+g+xB7ZYVOeyo4ryjFVscRUkkLpdG73Hb4hy
         +TbFgp8qXdbctyUns4Z5hSCxqISWkEdK9U/KQmZEtFyw/DrGOsPdEKvT0Kdg/ukGDAMe
         4DxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741188168; x=1741792968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrrWcWF0YU7DOHeensr3xXw8xMJox0I/sU8mMGZ4O/8=;
        b=hvE/ililFY7EjUnoXKdkwKuqYuxfMeUxJYmUqlKnEmniEe6CVq1mzffY3AqKDIphCd
         FsRylKH2IRsDl3hMfc+H40PgIcGhw9qYWmLmJh7x6abgdDu1xtxo5XwUufjsQAo+/Lw8
         +qUmhyKIV8Pzhh3UNYOfM0QraWQbiKI46xgwLtjfYN4PAW1ddDbNcXJ8rzGPJEtJSS3E
         GHK+Dr1/BI7HRBVsK1MdCsnxLm31fFrDTuIEiw3TptbrsAYe3Qie24lDxMWNXEeWIE0e
         dsiItvV6VqiAk5XZV6JbNKZcyRe9vnO80wDwDWMwtDTHKYGml90jyv8uIaDJrtNqKjY0
         W/UA==
X-Forwarded-Encrypted: i=1; AJvYcCWoN/mvVAxd8pmWFo241rleYD+TvclRArkdO76uwr/42BVNQkz1rDuBLTeOvqzZkiil0ojVKu9j4LWMFwE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtei6reNiSL5rNjbZD/LLbGbdSMgPK9Py4BvUX4kKlKZITOOig
	Lz5E6j3PIcqmUZ02Mf1zksptJXAFQ+XYd94EHwDsi1s2bF+0L2gu
X-Gm-Gg: ASbGnct9MJAqd5SaSv7SL3dtKj5uTt1uJToIhlcrHBxskHbIPo3xcJwhNrNrOPYA1Ea
	numtwxcymJaDeL38TQ5T81TA/Yp3moFPmDe2atvKyJIRUXF+WcZ1cuFs9ryS3dnWuEgFgu2AQXl
	uDYEpMl6GLOZMKiU74m69mZg/7Nr+2j2v//hrnRN8f4eFZAwGVM1PddnKVpdrduCiAXSTrsxegm
	K3+/IzYB2MEEVQJQaSe80ifYXLVt1TEgIqRDN2ItU7bI76BllxFRxN7YN/UDGlXoOSFyeMAAu9h
	GWaHpdAZzMzBVCkm4CYzYC+mgGe/uV2IsA1K9iddIDdC
X-Google-Smtp-Source: AGHT+IE5Y9x6OMXLQ/Mj+bXe5afzgdLR0y3DfUUZhaNnHvvvOh27pCh2tcKmZ4JZ8zVAr2Ay/rOQxg==
X-Received: by 2002:a17:902:dac9:b0:223:6254:79b8 with SMTP id d9443c01a7336-223f1d4bf89mr53156905ad.47.1741188167525;
        Wed, 05 Mar 2025 07:22:47 -0800 (PST)
Received: from localhost ([216.228.125.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe6cfd9sm13044953b3a.76.2025.03.05.07.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 07:22:46 -0800 (PST)
Date: Wed, 5 Mar 2025 10:22:44 -0500
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
	Jani Nikula <jani.nikula@intel.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v4 3/8] bits: introduce fixed-type genmasks
Message-ID: <Z8hsRJvpjYoqh9RG@thinkpad>
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

+ Anshuman Khandual <anshuman.khandual@arm.com>

Anshuman,

I merged your GENMASK_U128() because you said it's important for your
projects, and that it will get used in the kernel soon.

Now it's in the kernel for more than 6 month, but no users were added.
Can you clarify if you still need it, and if so why it's not used?

As you see, people add another fixed-types GENMASK() macros, and their
implementation differ from GENMASK_U128().

My second concern is that __GENMASK_U128() is declared in uapi, while
the general understanding for other fixed-type genmasks is that they
are not exported to users. Do you need this macro to be exported to
userspace? Can you show how and where it is used there?

Thanks,
Yury


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
> +	(GENMASK_INPUT_CHECK(h, l) +			\
> +	 (((t)~ULL(0) - ((t)1 << (l)) + 1) &		\
> +	  ((t)~ULL(0) >> (BITS_PER_TYPE(t) - 1 - (h)))))
> +
> +#define GENMASK(h, l) GENMASK_t(unsigned long,  h, l)
> +#define GENMASK_ULL(h, l) GENMASK_t(unsigned long long, h, l)
>  
>  /*
>   * Missing asm support
>   *
> + * __GENMASK_U*() depends on BITS_PER_TYPE() which would not work in the asm
> + * code as BITS_PER_TYPE() relies on sizeof(), something not available in
> + * asm. Nethertheless, the concept of fixed width integers is a C thing which
> + * does not apply to assembly code.
> + */
> +#define GENMASK_U8(h, l) ((unsigned int)GENMASK_t(u8,  h, l))
> +#define GENMASK_U16(h, l) ((unsigned int)GENMASK_t(u16, h, l))
> +#define GENMASK_U32(h, l) GENMASK_t(u32, h, l)
> +#define GENMASK_U64(h, l) GENMASK_t(u64, h, l)
> +
> +/*
>   * __GENMASK_U128() depends on _BIT128() which would not work
>   * in the asm code, as it shifts an 'unsigned __int128' data
>   * type instead of direct representation of 128 bit constants
> 
> -- 
> 2.45.3
> 

