Return-Path: <linux-kernel+bounces-247904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 181B592D624
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BC3E1C2341B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A796A194C68;
	Wed, 10 Jul 2024 16:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NluwzYxO"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA1B194A68
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720628225; cv=none; b=Ozh8nHAFPOWBgZluPQCETNdbigbz6Ms+OkE0pfK/rwjfaw3UBLKBjXfHHcBmeJFdeOhrJ7BHY87/zqrTot4EGqJID3umc8DVqkwvVT23I7dZyhWVrq0ZHm84m6RTl7/JL/OaK2TQHLep21HqsZFaht0znXMGvC6Vs/OsXqnhIq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720628225; c=relaxed/simple;
	bh=1tLh6JEuz++RA/NPFAoQw8e2zCLQOh5yKExn3y442vI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRNQhvbzxYRdU+Pe06HlDg70jGfUrEsEu/0MFUUJkt+hrzWpUKHQkQK4K023m0pvW0gKjGwrTib2G1dl9oli2EWZc8VXJvpb0tnQkHBJ7fLceFNEFM+XRVH3TFwzthWmgXjWtG+rDQwhTBbeymUUCgQ6sCaKQgnh+0j+jl4gRuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NluwzYxO; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fb3cf78fbdso35939155ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720628224; x=1721233024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O7HwAh8xycV0R/vfiWzYLPkd90MNEgU0Np/qq5r4NOM=;
        b=NluwzYxO1qghVNng2wm+iMWD14ZNPshAysihLma6PwmTkTKD5XXIESJs9WVQHx6V4I
         stBplj4eUb9NCpLM1Qnynhs+giJCVXl1flZBC63HJ63idsvy98QxKe36IDTokF3jNTz0
         1BAOATPrEj/2wPimwKBNQNsPMTNizA0q+bxj5yL1Ciu3wQyHshN2pSryLq/6PMU8p7MO
         e8nyQwjh7bWaf5lOKiql9Gt4lYo37hH+HqL5HmE1USnlZKbD7hficXIlqRZR8bO7XVpP
         zx60gux3Vbf706fiOGXmqW/dLNguhAPOGinfsxRtmduHHI/8LUlSxMJ11WzJbOMKTyhw
         7Cqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720628224; x=1721233024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7HwAh8xycV0R/vfiWzYLPkd90MNEgU0Np/qq5r4NOM=;
        b=qmDkpvOSoykfX/kP/LQBMn2g95Wkt3ICmhhfXY/NmpFCrN1bXcrq/GqUvr6cpfhGKE
         Fuy4BV6pb4scjFHKYrFtDn5alnKQpo1FNuvRY0ZhD5rNaOC43zsmIWEKWvHfI/DA5Dim
         41OyMb0O8C+edNJF4EqhJD1NOKaw/568Fn/6gdq3+tWlh7mFJJkV36pOAx8M/qWiASXU
         /9ckK9uEwqfiNg0mIkRE+HpesGIQglC2YhbgRGtsKs4wOmcdF4TddAxamMXEFeQHQz9E
         41G81mC4HfcbSxRB7dJKjYiro25D9zySSdl9f3NUWTYOLFhqgIvXwFw7oD/lE3Rgs20f
         gU1g==
X-Forwarded-Encrypted: i=1; AJvYcCVWkxYh+ThzlpuM9R1MbwFvM96HosrYM9oBRQ0xnC0YL/K4Ag1RMzO+ZgrqOPKBkjuL+VxRondK6C4/MJQR/f7TjKxpXppivNT2+9/5
X-Gm-Message-State: AOJu0Yw14bjw5LBABpi7BsF5nG1coSodMzMtwxKctNnZ8dBjBk8m8BNS
	EYPk4l8fBknocvX+kiv3GvHpDzHWQHZxGhqdNkxRRhUEhgqYYH9vPYQ33d3i
X-Google-Smtp-Source: AGHT+IFQDAjz4OswWCwIIY0yFqjLry2VOfEX36VGwykCppVKy1lKX5hHgyRFdCDGicU1nhsw2VY21g==
X-Received: by 2002:a17:902:6808:b0:1fb:a2c0:53b1 with SMTP id d9443c01a7336-1fbb6cd1951mr35248205ad.13.1720628223558;
        Wed, 10 Jul 2024 09:17:03 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ac07f2sm35504855ad.194.2024.07.10.09.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 09:17:02 -0700 (PDT)
Date: Wed, 10 Jul 2024 09:17:00 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linux@rasmusvillemoes.dk, willy@infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] radix tree test suite: put definition of bitmap_clear()
 into lib/bitmap.c
Message-ID: <Zo6z_AuI6U8JBvfk@yury-ThinkPad>
References: <20240710095554.16725-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710095554.16725-1-richard.weiyang@gmail.com>

On Wed, Jul 10, 2024 at 09:55:54AM +0000, Wei Yang wrote:
> Instead of keeping a bitmap.c in radix-tree own directory, we can use
> the common implementation in lib/ directory.
> 
> Just move the definition and link some related libs, no functional
> change.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> CC: Matthew Wilcox <willy@infradead.org>

Hi Wei,

bitmap_clear() is not used in radix tests, and in fact not used
anywhere in tools at all. Unless you have plans on it, it's
better to drop bitmap_clear() from tools, instead of bloating
the library.

Thanks,
Yury

> ---
>  tools/lib/bitmap.c                | 20 ++++++++++++++++++++
>  tools/testing/radix-tree/Makefile |  4 ++--
>  tools/testing/radix-tree/bitmap.c | 23 -----------------------
>  3 files changed, 22 insertions(+), 25 deletions(-)
>  delete mode 100644 tools/testing/radix-tree/bitmap.c
> 
> diff --git a/tools/lib/bitmap.c b/tools/lib/bitmap.c
> index c3e4871967bc..a96dbf001244 100644
> --- a/tools/lib/bitmap.c
> +++ b/tools/lib/bitmap.c
> @@ -100,3 +100,23 @@ bool __bitmap_intersects(const unsigned long *bitmap1,
>  			return true;
>  	return false;
>  }
> +
> +void bitmap_clear(unsigned long *map, unsigned int start, int len)
> +{
> +	unsigned long *p = map + BIT_WORD(start);
> +	const unsigned int size = start + len;
> +	int bits_to_clear = BITS_PER_LONG - (start % BITS_PER_LONG);
> +	unsigned long mask_to_clear = BITMAP_FIRST_WORD_MASK(start);
> +
> +	while (len - bits_to_clear >= 0) {
> +		*p &= ~mask_to_clear;
> +		len -= bits_to_clear;
> +		bits_to_clear = BITS_PER_LONG;
> +		mask_to_clear = ~0UL;
> +		p++;
> +	}
> +	if (len) {
> +		mask_to_clear &= BITMAP_LAST_WORD_MASK(size);
> +		*p &= ~mask_to_clear;
> +	}
> +}
> diff --git a/tools/testing/radix-tree/Makefile b/tools/testing/radix-tree/Makefile
> index 7527f738b4a1..505cc24a8b9c 100644
> --- a/tools/testing/radix-tree/Makefile
> +++ b/tools/testing/radix-tree/Makefile
> @@ -5,8 +5,8 @@ CFLAGS += -I. -I../../include -I../../../lib -g -Og -Wall \
>  LDFLAGS += -fsanitize=address -fsanitize=undefined
>  LDLIBS+= -lpthread -lurcu
>  TARGETS = main idr-test multiorder xarray maple
> -CORE_OFILES := xarray.o radix-tree.o idr.o linux.o test.o find_bit.o bitmap.o \
> -			 slab.o maple.o
> +LIBS := find_bit.o bitmap.o hweight.o vsprintf.o
> +CORE_OFILES := xarray.o radix-tree.o idr.o linux.o test.o slab.o maple.o $(LIBS)
>  OFILES = main.o $(CORE_OFILES) regression1.o regression2.o regression3.o \
>  	 regression4.o tag_check.o multiorder.o idr-test.o iteration_check.o \
>  	 iteration_check_2.o benchmark.o
> diff --git a/tools/testing/radix-tree/bitmap.c b/tools/testing/radix-tree/bitmap.c
> deleted file mode 100644
> index 66ec4a24a203..000000000000
> --- a/tools/testing/radix-tree/bitmap.c
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -/* lib/bitmap.c pulls in at least two other files. */
> -
> -#include <linux/bitmap.h>
> -
> -void bitmap_clear(unsigned long *map, unsigned int start, int len)
> -{
> -	unsigned long *p = map + BIT_WORD(start);
> -	const unsigned int size = start + len;
> -	int bits_to_clear = BITS_PER_LONG - (start % BITS_PER_LONG);
> -	unsigned long mask_to_clear = BITMAP_FIRST_WORD_MASK(start);
> -
> -	while (len - bits_to_clear >= 0) {
> -		*p &= ~mask_to_clear;
> -		len -= bits_to_clear;
> -		bits_to_clear = BITS_PER_LONG;
> -		mask_to_clear = ~0UL;
> -		p++;
> -	}
> -	if (len) {
> -		mask_to_clear &= BITMAP_LAST_WORD_MASK(size);
> -		*p &= ~mask_to_clear;
> -	}
> -}
> -- 
> 2.34.1

