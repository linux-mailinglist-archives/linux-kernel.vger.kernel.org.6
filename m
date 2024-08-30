Return-Path: <linux-kernel+bounces-309083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9359665FE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A7E61C20B70
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB52A1B1D7C;
	Fri, 30 Aug 2024 15:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mb7ZwdMm"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DA3EEC3
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 15:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725032813; cv=none; b=N+548b2WETs08hygggnS82DZ0CQzJoOaDdl8ZeyrjMpKRwPqdxNbS6HNFzTipYm99MbBWhW1imkbMIKBPLm2niYhZTRNqztHY93g0oprpeyqSQo6OhUkGR9RJFjF1xbmbnT+JehLDu+GYey2BgNHQsDtxNVXjdjQi+7YtORgR7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725032813; c=relaxed/simple;
	bh=btg0GBb3fOqUqE+y06VeJxy5Buihw92ap1zrzC3pSLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8XpEOblZdd9S8YlMQhjKIuoA9O1M9nzTMgu0dE/V+iphyREcKqZ154DuZ+2x2NJRgIahEjnN/u3hw6m3ia9CsRFX2xYG20/D2PNggds3aSjvTENg3Gde6cM5L3t7pP5MgpunhsHUYoL2sI9EG/WBj9YGepN7xfNdWzInW5Uu+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mb7ZwdMm; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7141d7b270dso1653441b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725032811; x=1725637611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uXdcV/Lje+RTUVxHye4gd4GwVOpzaeIJRP2OkYQ76c4=;
        b=Mb7ZwdMmjdjx1Gosz4puGfbj7PgnjGc3D1dEu9gFAwBpBU7HbhZEObXA/HyXHw51Cp
         4L1seTNWcNwZqhoCvqlxx+P6a/GDL5seLMKaBCstJh1h3bibuXvFj+CapJ/HpLL5D0sk
         AdnQeKKVQGkguXwCB4fT4oNSMq09YZ2B7rOh6ePn0AaEocXr1dNCZ+8zJcmqyvbtg3YT
         8DlPRiBz4ql6YYUlsD8EqCcEXTsvdJrGe3IPhT/5otnOBvyAs3/nOC/pM6/P117L28QX
         5tEyudRJ+qfIg9k4B3OnKYCShkIQUknyRO7vYYsLYaHRlQQlBd9FGTYQEiRAuJbCCFC8
         nt7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725032811; x=1725637611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXdcV/Lje+RTUVxHye4gd4GwVOpzaeIJRP2OkYQ76c4=;
        b=i2CtNxYTsCzaWmOky1GFsSb7whpS7N+msBSOO8NCTPuFVFLD7UKXzuC0ezGA4E9mx0
         15XM73LXJWhvVSUT6YUePkOoPYtXwXvWF4erxkVYRUWU5sBnJBYpDhbq85AbJRwUYy+X
         Wl8Lh+9+FwvqcJvBy686Rj5rgYCHScApc2y8h9gGrkTrwSEbR3CALGSMhDQiXif8uzQk
         NMzw0EcDoDmeW2UzZjV/pXSlBK0vkGncfHtQNF2KtG6Ekjxcv1amMHp9PHCDJN54FAwD
         s1H37UThu1vr9x69hURdkQqzxV3O0c7Cb0V57IqWtj5qXJSHzraUlFKml0ppXBZ4Y7df
         96GA==
X-Forwarded-Encrypted: i=1; AJvYcCX+ANoI3e6raVMCTUmCoCAVBS7l9Rf+kvUeNAKwWLbra3JD0evcsDK02iIRTADWnGZRrNgK7yMYpzUkvs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgHj/D8Y97fNtHBsgCYYUNfsUvkNiczvl5mgl1qB84+VlcEW8W
	8rYNy++V1fYoXF/UHmne+4yqpDBus7zBGLAtYFqT905DkNGKtn/Xibq+PCym
X-Google-Smtp-Source: AGHT+IFuA2geBV8TPPH9miJxb/3Abv3J7hbrp7n2fDvHx/6JcaGaJUc9kz02JcWjQpfUetwUNMXdMQ==
X-Received: by 2002:a05:6a20:2d07:b0:1cc:be79:92ca with SMTP id adf61e73a8af0-1cce0fed498mr6601422637.5.1725032810973;
        Fri, 30 Aug 2024 08:46:50 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e5576cc7sm2921266b3a.32.2024.08.30.08.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 08:46:50 -0700 (PDT)
Date: Fri, 30 Aug 2024 08:46:47 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] lib: Fix test_find_first_and_bit and
 test_find_next_and_bit benchmark
Message-ID: <ZtHpZzYE62qMvIFY@yury-ThinkPad>
References: <20240829135926.926603-1-mathieu.desnoyers@efficios.com>
 <20240829135926.926603-5-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829135926.926603-5-mathieu.desnoyers@efficios.com>

On Thu, Aug 29, 2024 at 09:59:24AM -0400, Mathieu Desnoyers wrote:
> Modify test_find_first_bit so it modifies a local copy of bitmap rather
> than modifying the input bitmap, which removes the requirement of
> placing it last in the tests.
> 
> Calls to test_find_first_and_bit and test_find_next_and_bit are placed
> after test_find_first_bit, which makes them use a bitmap entirely filled
> rather than the expected bitmap (random-filled or sparse).
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  lib/find_bit_benchmark.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/find_bit_benchmark.c b/lib/find_bit_benchmark.c
> index d3fb09e6eff1..aee2ebb6b3cd 100644
> --- a/lib/find_bit_benchmark.c
> +++ b/lib/find_bit_benchmark.c
> @@ -30,18 +30,20 @@ static DECLARE_BITMAP(bitmap, BITMAP_LEN) __initdata;
>  static DECLARE_BITMAP(bitmap2, BITMAP_LEN) __initdata;
>  
>  /*
> - * This is Schlemiel the Painter's algorithm. It should be called after
> - * all other tests for the same bitmap because it sets all bits of bitmap to 1.
> + * This is Schlemiel the Painter's algorithm.
>   */

Good to drop it, moreover, the comment is incorrect - we set all bits
to 0, not 1.

>  static int __init test_find_first_bit(void *bitmap, unsigned long len)
>  {
> +	static DECLARE_BITMAP(cp, BITMAP_LEN) __initdata;

This days we can allocate automatic variables, which is better than
statics:

   unsigned long *cp __free(bitmap) = bitmap_alloc(len, GFP_KERNEL);

If no objections, I can fix it inplace. The rest of the series looks
good. I'll add it in bitmap-for-next for testing shortly.

Thanks,
Yury

>  	unsigned long i, cnt;
>  	ktime_t time;
>  
> +	bitmap_copy(cp, bitmap, BITMAP_LEN);
> +
>  	time = ktime_get();
>  	for (cnt = i = 0; i < len; cnt++) {
> -		i = find_first_bit(bitmap, len);
> -		__clear_bit(i, bitmap);
> +		i = find_first_bit(cp, len);
> +		__clear_bit(i, cp);
>  	}
>  	time = ktime_get() - time;
>  	pr_err("find_first_bit:     %18llu ns, %6ld iterations\n", time, cnt);
> -- 
> 2.39.2

