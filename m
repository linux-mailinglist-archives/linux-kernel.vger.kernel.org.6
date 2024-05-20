Return-Path: <linux-kernel+bounces-184114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8EE8CA2BD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 21:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7108B220D1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 19:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD961386AC;
	Mon, 20 May 2024 19:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfWOuOEk"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3509C138496
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 19:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716233398; cv=none; b=Mg1QftkoGtcF86hLB9/LoPJpiUFlCfx+tGJeufecBY/+diIJHU6YFpyUxoS+fv+z5vo1bTcmbgIct2D6QVBof2fKkzAx19FPgdwPCLoLW1wNDuDYvPrOTdbqi3Wj182/rxa2HBs9D5MQd0+rCSIbrHM3JnL73hPIUAMoc1dJd+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716233398; c=relaxed/simple;
	bh=+zQ3M4ICtmrucW/KehKSA4Uv/vxERuUOVio4+qBsEQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYQ4cMM73GEX+cBl3k/o/4ytgok8UVkzPmKXkfbhDzC/3DNrUxb1r3guzSbOcRerCd7NjnwJXu1ZRunxClMQxWgqPFAXAXXUoNjT7GHZfnrIWm1iuYdSWgKn7D7nuYDe6OSZAWCA8pRxcAHTopYa+TAv9crgDbExp4rWkQ7/7SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfWOuOEk; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-61af74a010aso28404817b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 12:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716233396; x=1716838196; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DHjVcta07avJK/5JfCv9aDON78HlV0YJswPHnBEv0i8=;
        b=RfWOuOEk8c8GGam/9AknT4vfe5tWePtgPy6Wl49b7dIjxep5XEvS4M/hl08D/8ntPp
         5SyGAQBHjVbIO1D51imBPf2/gszAo+08SswnJcVyB1yRPWlcev4V/oFb65BTd723K0XM
         GdVxmNUJS4iCpkc+BABEzqbvUhW/zoSQOahTKFt/P+QFXjmVpsbVN7yizClAQyX0oCW3
         aCty6kONxhlEyrYyTgL4+DYFrEEf0fssoebn/IhZtQSm34cpu49OXVVm41NX6VivRvHF
         qfIgJqauEKT0JjfAq+4q2cqMwMOK4Nstk1dH4Oh3MUFUBr1ZKG41sSebn7RCjlkT+MeJ
         UP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716233396; x=1716838196;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DHjVcta07avJK/5JfCv9aDON78HlV0YJswPHnBEv0i8=;
        b=ou2+RiuOFH1GU/cH5rfEEX0Nxis8IKzWeAc2tLp/popiZV2vq7d4flH0B7Yx3fvQNR
         x9aOlWR9t7FpgZyOFuoguLcBV/uwKLqsmEH4oTPl3G+r/UObxMuqVeQ2hx/9n52GIyL0
         RiZKDKjpDO1UpfY0orU5QQFrEn/H0RqKQ228xFvdAx6JjhcSxfQiUdFtrB6JBJVggTwX
         8gGwCD2sgtgBzkkYOygg7JlB1jO5cDYQZE4Q9cMep0PeGK5oJxLIoIj2q/4e/OLy7oNb
         7j/TJ4GJNDhQRVCk/1oVD8Z7MPGYmVEiInAqCYHtHxll3HK2QFP4d3DOhL/Hnxjz4jcK
         P8Cg==
X-Forwarded-Encrypted: i=1; AJvYcCXcHLjlQjIQjjZlUFg7UeFJZ6ol74g7nVc55N8ryDBwZR7egmDet2qtmKVGGQoiQLFn4cb7/7N82ujlDj7E0k8DNsIe1e0UTSRxenRJ
X-Gm-Message-State: AOJu0Yz2B+ny0IKOKt40r7VVaWzXOpcLQ2wS1BUmU8F4EVFVECEN3MWa
	P386eaqf+RSGGhkPdkzzZWaRBWRbF0Qk/pfpkALvBaAOdo9DqBTZ
X-Google-Smtp-Source: AGHT+IHg/7aEotpuKoQ3aw7jnHWrS0DS5+LVFrD2bA6ghBmWGIAs18OWqlVFcefrzLPlS3NLS9WgkQ==
X-Received: by 2002:a81:4e06:0:b0:61a:b7c8:ea05 with SMTP id 00721157ae682-622b001ec63mr310219357b3.35.1716233395949;
        Mon, 20 May 2024 12:29:55 -0700 (PDT)
Received: from localhost ([2601:344:8301:57f0:1842:2e87:56d3:d3fc])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e345e75sm50221297b3.97.2024.05.20.12.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 12:29:55 -0700 (PDT)
Date: Mon, 20 May 2024 12:29:54 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Michal Schmidt <mschmidt@redhat.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, Alex Elder <elder@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] bitfield.h: add FIELD_MAX_CONST
Message-ID: <Zkuksm3K+pKugjgF@yury-ThinkPad>
References: <20240515172732.288391-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240515172732.288391-1-mschmidt@redhat.com>

+ Alex Elder <elder@linaro.org>, Jakub Kicinski <kuba@kernel.org> and
David S. Miller <davem@davemloft.net>

On Wed, May 15, 2024 at 07:27:31PM +0200, Michal Schmidt wrote:
> FIELD_MAX_CONST is like FIELD_MAX, but it can be used where statement
> expressions are forbidden. For example, using FIELD_MAX in a
> static_assert gives:
>   error: braced-group within expression allowed only inside a function
> 
> It can be used also in array declarations, where using FIELD_MAX would
> trigger a warning :
>   warning: ISO C90 forbids variable length array ‘buf’ [-Wvla]
> (It's a bit surprising, because despite the warning, gcc calculated
> the array size correctly at compile time.)
> 
> A simplified example of what I actually want to use in a driver:
>   #define DATA_SIZE_M GENMASK(3, 0)
>   #define MAX_DATA_SIZE FIELD_MAX_CONST(DATA_SIZE_M)
>   static void f(void) {
>   	char buf[MAX_DATA_SIZE];
>   	/* ... */
>   }
> 
> In the implementation, reuse the existing compile-time checks from
> FIELD_PREP_CONST.
> 
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>

Hi Michal,

So... FIELD_MAX() already requires the _mask to be a const value.
Now you add a FIELD_MAX_CONST(), which makes it more confusing.

It looks like your new _CONST() macro would work anywhere where the
existing FIELD_MAX() works. At least for me, if I apply your patch
and do:

        #define FIELD_MAX FIELD_MAX_CONST

The implementation of the 'const' version looks the same as the
'variable' one, except for that sanity checking business.

I think the right path to go would be making the __BF_FIELD_CHECK()
a structure initializers friendly by using the BUILD_BUG_ON_ZERO(),
just like you did with the __BF_FIELD_CHECK_CONST(), so that the
FIELD_MAX() would work in all cases.

Thanks,
Yury

> ---
>  include/linux/bitfield.h | 34 +++++++++++++++++++++++++++-------
>  1 file changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> index 63928f173223..50bbab317319 100644
> --- a/include/linux/bitfield.h
> +++ b/include/linux/bitfield.h
> @@ -76,6 +76,16 @@
>  					      (1ULL << __bf_shf(_mask))); \
>  	})
>  
> +#define __BF_FIELD_CHECK_CONST(_mask, _val)				\
> +	(								\
> +		/* mask must be non-zero */				\
> +		BUILD_BUG_ON_ZERO((_mask) == 0) +			\
> +		/* check if value fits */				\
> +		BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val)) + \
> +		/* check if mask is contiguous */			\
> +		__BF_CHECK_POW2((_mask) + (1ULL << __bf_shf(_mask)))	\
> +	)
> +
>  /**
>   * FIELD_MAX() - produce the maximum value representable by a field
>   * @_mask: shifted mask defining the field's length and position
> @@ -89,6 +99,22 @@
>  		(typeof(_mask))((_mask) >> __bf_shf(_mask));		\
>  	})
>  
> +/**
> + * FIELD_MAX_CONST() - produce the maximum value representable by a field
> + * @_mask: shifted mask defining the field's length and position
> + *
> + * FIELD_MAX_CONST() returns the maximum value that can be held in
> + * the field specified by @_mask.
> + *
> + * Unlike FIELD_MAX(), it can be used where statement expressions can't.
> + * Error checking is less comfortable for this version.
> + */
> +#define FIELD_MAX_CONST(_mask)						\
> +	(								\
> +		__BF_FIELD_CHECK_CONST(_mask, 0ULL) +			\
> +		(typeof(_mask))((_mask) >> __bf_shf(_mask))		\
> +	)
> +
>  /**
>   * FIELD_FIT() - check if value fits in the field
>   * @_mask: shifted mask defining the field's length and position
> @@ -132,13 +158,7 @@
>   */
>  #define FIELD_PREP_CONST(_mask, _val)					\
>  	(								\
> -		/* mask must be non-zero */				\
> -		BUILD_BUG_ON_ZERO((_mask) == 0) +			\
> -		/* check if value fits */				\
> -		BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val)) + \
> -		/* check if mask is contiguous */			\
> -		__BF_CHECK_POW2((_mask) + (1ULL << __bf_shf(_mask))) +	\
> -		/* and create the value */				\
> +		__BF_FIELD_CHECK_CONST(_mask, _val) +			\
>  		(((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))	\
>  	)
>  
> -- 
> 2.44.0

