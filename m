Return-Path: <linux-kernel+bounces-448466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0846E9F4077
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 03:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4896B188696A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 02:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9131F84E1C;
	Tue, 17 Dec 2024 02:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3EZJ2R1"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADA620B22
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 02:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734401903; cv=none; b=qBsNUzxpuEufN+hs81o74xcGse1W6ilUKhasHq1ySBkuMaQcmZ6RtWnThmkZRM1wswuuA4RdGJGzbMaUR8j5RERACGWH4w09xKVw9n730juUOixu57GfhI5S16S/9rtu0oqscrzjBuAKHCUZWyqBWpw3Zvbc2CfGcXSF2QdeTHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734401903; c=relaxed/simple;
	bh=BgP9ExKy1JJuDxpQ+rJ+yIQyddU5CjkHTFaOE+adJQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HV348XgDwQAHiXrUdPcTI0YECk7NkaggGiFE2+k2JnIiKlsDhdK+74tquaiGFaTwqr+kTa482gREXOxkzuMj/VBIdVOTI7/VAHwWg5y/KO4uD1qPVVZlrpo+rAf3buMOYi2oOkSjgcNrihfwytJ86b32J7KdJRP/1zfv8yxOI8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3EZJ2R1; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6efe4e3d698so37027417b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 18:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734401901; x=1735006701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3DLmluN411z0hGvp8vy0X1NPB3IpK22SX655VkMUwYA=;
        b=J3EZJ2R1FuSdAg9XjB+qzC4jNU9Qa5c49m6CWF/QiAeIJBxrlwRb7H68vLqzuuTRp2
         droIfDeJNOpGw2IQr6hJLiS3F34XVL3yIMZjgT05B/pubVRjIIRNgZCOqc40571Kr/hP
         NsAOwiGVs26Wh/CSzWaC4+udiuvrT1B9qnNI3fUt7vzzadKrmC8lA2ruhPNqAf54mJzP
         wUgBvitju5XRzhz54jgspU1jOZ5bHXw2lP+k0bX6mj9yLzH3CyR374FCxOKiG5CZEGLD
         imXVWStXQSCQJEij2kI7/yhfcfJhUaQBQ4i0dEPMDDDnl1mmeclm0Tk14oN9ZBxGZnUh
         PPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734401901; x=1735006701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DLmluN411z0hGvp8vy0X1NPB3IpK22SX655VkMUwYA=;
        b=fd/XtLeX5RF+hSjt6BNqVv1NsevnkoPRMwZZdjRziE3kQvmS7Wisws70pcMNO3vc4N
         tmy0AqBiPZpjb4aXn+pHw9PxTFbPo2JRc5uUZIbjYjDELThZtHeJ82QO3s2bbSP+1Nav
         F0z2J9Kun1uagw+kDQbmeRq4+papThfdx7FNgCHD2XzU7+yRUtIYc62FsV6jm/gqXNii
         0d/2tNALfPIbUJyOWcTT7Z2DGB2u1ujKglJJrSO6OBYZIeVUPHIr3ayIZSfT0tPfbf3A
         tGmSJQR+4bI/gmqpYDaak4tSuXtpMlSfmiraE4xFbuVyjigDo41qZKpQd2fcelLXBncn
         2iSQ==
X-Gm-Message-State: AOJu0YwcDGoCSViRuRgGYmAeJf5SvAyy0RiQdeDChfSIRNA9js9ffjFo
	c7DChv+wGMRmFKEzsFV7I9kQMh4YvXO2TKK0xR0EVvArIXzJphYc
X-Gm-Gg: ASbGncveuBn26yn+2j6sC++GpAKJy1eOtclcCYo2nrZXYdgNozgDyEK3qmdbffzxW2q
	O2H+uI88IvuuDVcMZO09w5CIENp87iibc56NW1/FmAI3erjxwLNyQfN23szGVShxeztYZWvjn50
	+20DznG9+KEY9cxJ1HZVugVw1fDevVQC+exOW294SJDTl1sAAe1Q+3eHoLyT6C4kkTrkCEcCQFB
	NmvO+wMOuvbKJ4Gxg0E7vgoNKiybmO/3SywlsWokdFzl3bw86iC6qpqxpRF54/+qZeqU6fV2i/e
	qx+23mqGFlbT0UuX
X-Google-Smtp-Source: AGHT+IEH9Nu9l8My96O0M6hTx8gsNJUcbJaivRhWlr1a3eg2IUF1w9bwF6hNfhRMDU46vtGTTMXYGw==
X-Received: by 2002:a05:690c:6105:b0:6ef:5ab8:2c63 with SMTP id 00721157ae682-6f279b145bfmr145271167b3.20.1734401901009;
        Mon, 16 Dec 2024 18:18:21 -0800 (PST)
Received: from localhost (c-24-129-28-254.hsd1.fl.comcast.net. [24.129.28.254])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f289031306sm16484407b3.56.2024.12.16.18.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 18:18:20 -0800 (PST)
Date: Mon, 16 Dec 2024 18:18:19 -0800
From: Yury Norov <yury.norov@gmail.com>
To: David Laight <David.Laight@aculab.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	'Rasmus Villemoes' <linux@rasmusvillemoes.dk>,
	'Andrew Morton' <akpm@linux-foundation.org>,
	'Masahiro Yamada' <masahiroy@kernel.org>,
	'Vincent Mailhol' <mailhol.vincent@wanadoo.fr>,
	'Linus Torvalds' <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 next] linux/bits.h: Simplify GENMASK()
Message-ID: <Z2Dfaw7OTagl47ir@yury-ThinkPad>
References: <7a1b1534e51342769740985db773d5e1@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a1b1534e51342769740985db773d5e1@AcuMS.aculab.com>

On Mon, Dec 16, 2024 at 09:39:23AM +0000, David Laight wrote:
> Change 95b980d62d52c replaced ~0ul and ~0ull with ~UL(0) and ~ULL(0)
> in the GENMASK() defines as part of a change to allow the bitops
> definitions be used from assembly.
> 
> The definitions have since been moved to a uapi header which
> probably shouldn't require some other header be included first.

Sorry, I don't understand that. Are you saying that uapi headers
should not include one another? What is exactly wrong with that
for you? Or did you mean something else? 

> The definition of __GENMASK() is also overcomplicated partially
> due to avoiding overflow warnings from shifting ~0u left.
>
> Implement GENMASK() using the simpler (1u << hi) * 2 - (1u << lo) formula.

I don't think that this formula is any simpler than the original one.

> This doesn't rely on right shifts

What is wrong with right shifts? 

> and doesn't need to know the number
> of bits in the integral type.

What is wrong in BITS_PER_LONG?


> It can be used for different types by just changing the type of the 1u.
> __GENMASK() __GENMASK_ULL() and __GENMASK_U128() can now implemeted
> using a single ___GENMASK(one, hi, lo).

I like idea of generic implementation or different flavors of GENMASK().
I even proposed something similar back then for fixed-type genmasks: 

https://lkml.org/lkml/2023/6/21/1734

Both you and I do the same - provide type as a macro parameter. I like
my way of doing it a bit more because it's more explicit. But now that
we have _Generic(), we don't need this hack at all.

> 
> Overflow warnings (from shifting out the MSB) are avoided by subtracting 1
> before the multiply and adding two back in later.
> The complers see straight through the subterfuge when generating code.

Ironically... You're trying to simplify a part that silences Woverflow, and
end up by adding another part that silences Woverflow...

> Since there are already conditionals for ASSEMBLY in bits.h, for ASSEMBLY
> directly expand GENMASK() and GENMASK_ULL() as ___GENMASK(1, hi, lo)
> rather than through the __GENMASK() and __GENMASK_ULL() uapi defines.
> Remove the UL(x) and ULL(x) from the uapi file.
> 
> GENMASK() and GENMASK_ULL() now generate the correct values when
> ASSEMBLY is defined.
> Fortunately they've never been used.

They were used before. They are not used now - that's true.

Can you explain in details how are those macros are broken for assemblers?
Can you add a test?

> 
> Rename 'h' to 'hi' and 'l' to 'lo' because 'l' looks like '1' in many fonts.

No please don't!

This type of changes don't help at all. They effectively wipe all the
history for absolutely nothing. If your fonts mess characters, please
use other fonts.
 
> Signed-off-by: David Laight <david.laight@aculab.com>
> ---
> 
> v2: '__uint128' => 'unsigned __int128'
> 
>  include/linux/bits.h      | 43 ++++++++++++++++-----------------------
>  include/uapi/linux/bits.h | 15 +++++++-------
>  2 files changed, 24 insertions(+), 34 deletions(-)
> 
> diff --git a/include/linux/bits.h b/include/linux/bits.h
> index 60044b608817..d5cf0ec22e43 100644
> --- a/include/linux/bits.h
> +++ b/include/linux/bits.h
> @@ -14,41 +14,32 @@
>  #define BITS_PER_BYTE		8
>  
>  /*
> - * Create a contiguous bitmask starting at bit position @l and ending at
> - * position @h. For example
> + * Create a contiguous bitmask starting at bit position @lo and ending at
> + * position @hi. For example
>   * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
>   */
>  #if !defined(__ASSEMBLY__)
>  #include <linux/build_bug.h>
> -#define GENMASK_INPUT_CHECK(h, l) \
> +#define GENMASK_INPUT_CHECK(hi, lo) \
>  	(BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> -		__is_constexpr((l) > (h)), (l) > (h), 0)))
> -#else
> -/*
> - * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
> - * disable the input check if that is the case.
> - */
> -#define GENMASK_INPUT_CHECK(h, l) 0
> -#endif
> +		__is_constexpr((lo) > (hi)), (lo) > (hi), 0)))
>  
> -#define GENMASK(h, l) \
> -	(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> -#define GENMASK_ULL(h, l) \
> -	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
> +#define GENMASK(hi, lo) \
> +	(GENMASK_INPUT_CHECK(hi, lo) + __GENMASK(hi, lo))
> +#define GENMASK_ULL(hi, lo) \
> +	(GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_ULL(hi, lo))
>  
> -#if !defined(__ASSEMBLY__)
> +#define GENMASK_U128(hi, lo) \
> +	(GENMASK_INPUT_CHECK(hi, lo) + __GENMASK_U128(hi, lo))
> +#else
>  /*
> - * Missing asm support
> - *
> - * __GENMASK_U128() depends on _BIT128() which would not work
> - * in the asm code, as it shifts an 'unsigned __init128' data
> - * type instead of direct representation of 128 bit constants
> - * such as long and unsigned long. The fundamental problem is
> - * that a 128 bit constant will get silently truncated by the
> - * gcc compiler.
> + * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
> + * 128bit exprssions don't work, neither can C 0UL (etc) constants be used.
> + * These definitions only have to work for constants and don't require
> + * that ~0 have any specific number of set bits.
>   */
> -#define GENMASK_U128(h, l) \
> -	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
> +#define GENMASK(hi, lo) ___GENMASK(1, hi, lo)
> +#define GENMASK_ULL(hi, lo) ___GENMASK(1, hi, lo)
>  #endif
>  
>  #endif	/* __LINUX_BITS_H */
> diff --git a/include/uapi/linux/bits.h b/include/uapi/linux/bits.h
> index 5ee30f882736..a25d9dfb7072 100644
> --- a/include/uapi/linux/bits.h
> +++ b/include/uapi/linux/bits.h
> @@ -4,15 +4,14 @@
>  #ifndef _UAPI_LINUX_BITS_H
>  #define _UAPI_LINUX_BITS_H
>  
> -#define __GENMASK(h, l) \
> -        (((~_UL(0)) - (_UL(1) << (l)) + 1) & \
> -         (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
> +/* Result is '(1u << (hi + 1)) - (1u << lo)' coded to avoid overflow. */
> +#define ___GENMASK(one, hi, lo) \
> +	((((one) << (hi)) - 1) * 2 + 1 - (((one) << (lo)) - 1))
>  
> -#define __GENMASK_ULL(h, l) \
> -        (((~_ULL(0)) - (_ULL(1) << (l)) + 1) & \
> -         (~_ULL(0) >> (__BITS_PER_LONG_LONG - 1 - (h))))
> +#define __GENMASK(hi, lo) ___GENMASK(1UL, hi, lo)
>  
> -#define __GENMASK_U128(h, l) \
> -	((_BIT128((h)) << 1) - (_BIT128(l)))
> +#define __GENMASK_ULL(hi, lo) ___GENMASK(1ULL, hi, lo)
> +
> +#define __GENMASK_U128(hi, lo) ___GENMASK((unsigned __int128)1, hi, lo)
>  
>  #endif /* _UAPI_LINUX_BITS_H */
> -- 
> 2.17.1
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

