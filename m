Return-Path: <linux-kernel+bounces-172046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB9A8BEC65
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 21:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B13811C242C0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 19:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECA316DEAE;
	Tue,  7 May 2024 19:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ef6HhOr1"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DCD16D319
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 19:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715109302; cv=none; b=ODAsD46CZ0LhyHwiTFJVSx7VQaH6LGrvKFHtcr3iQPWJb/g8KJC+wAQZ8O2adySWxlkrenZEkJrdRYdAoC3OTR2/kcKKgoOZhw+Kluqb70TlbqTIZxdYmpX9qrk5X4Bo/udnCx147UerGij3VnXXZJTM8zbf14j0bfuA+BAsM9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715109302; c=relaxed/simple;
	bh=tlldNfcByzJ4XQ7ta0Hf3J+SE8kzMt2alkaxZtOanBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqvj5KL1eH/tCxfsfTWczabMGCfWIxTI+pmbCCvhIcE4S7hepEG/a6l5MnK12FqseEz+j4XXmDYv0F/gISL2phj4s0g3aIsSZ83m85Ix/FR4Yq4dzWCjRDjTqlNJXP+2itQmXB+IJS3K7WIleefzQFGui9QGnFwpHfwiF33y0zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ef6HhOr1; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6203b1bc935so36742277b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 12:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715109300; x=1715714100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6eo4SgJ7QCEB1nNYUR2zdqZ3ccKqwNFeVNFLBZzA2CQ=;
        b=Ef6HhOr1hf7hWiJPrybOgBUGfn8QFZjltNt1WcJ90TpBprJWXesfWFCVBAUEprUa0c
         tdNtOW/gWpB4B6/ZGheQkoHuVmJJOfrj0nz13Zioaokxkj4Ikvq7S4VmjKDc0iY7PZ5H
         eTWEARSnVdbXp29gA23tC7OllMTwSEx+xN4rTzemOJduOk08FxhaotuapZpewO9bnpEK
         LUF5CDRomk0m0IdNiL2xJrdoTsNQKsHTmzIEUcfXas21HwmaI9fVE78WLdSPeIjAC34I
         ST3rX63DjR+pGtoNPgjxhHbfGZt1orSBHac20O5jGFvxxztRRPIRcRC8ycLzTUBTUu01
         8sDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715109300; x=1715714100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6eo4SgJ7QCEB1nNYUR2zdqZ3ccKqwNFeVNFLBZzA2CQ=;
        b=Th/wt4LvJQM9A+e5nveguf4Wn8CW7xRBySwlGZQHRiq1p0hkCGyAb+IoJEJfmcNiFE
         Q9Hfuod+o/O0Hvw9kuFrM+wLlf7G/CEb9SF095mV/nIQzzwjSSfqIZ1aLK5hmnJvXmWt
         Vu/5HhtdjI4xAX/L9cPr92nvjfNG/+fJq6mjlCD+Yodt/NS3Bv//X0jHSFkcRvZDgW0F
         Wpfv2IrrhMPNKGbXbpBBmJU6DqhmSogNKFIYY04u57GVyqMnAlWf+tzT52SXAMi8ORbu
         d/L0SwtjFgnQLk+NZEFnHR3Zd1i/aVCaZ0Kts+Q8rRGO7UKF1GNYZgvb1y3As2ysDpTy
         8Egw==
X-Gm-Message-State: AOJu0YzoPP+60O5bGZBBijA4AY+mlc9Z3zcjVe2AXD7e+NVthbt92I9m
	lSA2r3Ug9JlBvaEcfURGneI+aT/FsvKWZGSuuy2ouw3Q7jDQWf9F
X-Google-Smtp-Source: AGHT+IEasfG7B0Q510dqj1rgc0zUzn6hPKlQPGPlgG1JyH5qj5YI9YQDThWQtNp946o9Q1gQdU/qSQ==
X-Received: by 2002:a0d:eb11:0:b0:615:4700:94cb with SMTP id 00721157ae682-62085d1f5bbmr8376077b3.1.1715109299891;
        Tue, 07 May 2024 12:14:59 -0700 (PDT)
Received: from localhost ([2601:344:8301:57f0:5343:96f7:3e43:fa89])
        by smtp.gmail.com with ESMTPSA id s3-20020a817703000000b0061beb26a082sm2886510ywc.112.2024.05.07.12.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 12:14:59 -0700 (PDT)
Date: Tue, 7 May 2024 12:14:58 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v1 1/1] bitops: Move aligned_byte_mask() to wordpart.h
Message-ID: <Zjp9sm8s50rb9N/+@yury-ThinkPad>
References: <20240507140155.197304-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507140155.197304-1-andriy.shevchenko@linux.intel.com>

On Tue, May 07, 2024 at 05:01:54PM +0300, Andy Shevchenko wrote:
> The bitops.h is for bit related operations. The aligned_byte_mask()
> is about byte (or part of the machine word) operations, for which
> we have a separate header, move the mentioned macro to wordpart.h
> to consolidate similar operations.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Hi Andy,

I see the macro is used in lib/strnlen_user.c and in lib/usercopy.c.
In case of strnlen_user, the wordpart.h is included via linux/kernel.h,
which is OK to me. But In case of usercopy.c, I can't find how the
header is included. 

I'm sure there is some inclusion path, but it's always better to have
the dependencies listed explicitly.

Can you please send a 2nd version with the lib/usercopy.c including
wordpart.h?

Thanks,
Yury

> ---
>  include/linux/bitops.h   | 7 -------
>  include/linux/wordpart.h | 7 +++++++
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index 0b561ee6b4a4..ec45284c03f5 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -8,13 +8,6 @@
>  
>  #include <uapi/linux/kernel.h>
>  
> -/* Set bits in the first 'n' bytes when loaded from memory */
> -#ifdef __LITTLE_ENDIAN
> -#  define aligned_byte_mask(n) ((1UL << 8*(n))-1)
> -#else
> -#  define aligned_byte_mask(n) (~0xffUL << (BITS_PER_LONG - 8 - 8*(n)))
> -#endif
> -
>  #define BITS_PER_TYPE(type)	(sizeof(type) * BITS_PER_BYTE)
>  #define BITS_TO_LONGS(nr)	__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
>  #define BITS_TO_U64(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u64))
> diff --git a/include/linux/wordpart.h b/include/linux/wordpart.h
> index f6f8f83b15b0..4ca1ba66d2f0 100644
> --- a/include/linux/wordpart.h
> +++ b/include/linux/wordpart.h
> @@ -39,4 +39,11 @@
>   */
>  #define REPEAT_BYTE(x)	((~0ul / 0xff) * (x))
>  
> +/* Set bits in the first 'n' bytes when loaded from memory */
> +#ifdef __LITTLE_ENDIAN
> +#  define aligned_byte_mask(n) ((1UL << 8*(n))-1)
> +#else
> +#  define aligned_byte_mask(n) (~0xffUL << (BITS_PER_LONG - 8 - 8*(n)))
> +#endif
> +
>  #endif // _LINUX_WORDPART_H
> -- 
> 2.43.0.rc1.1336.g36b5255a03ac

