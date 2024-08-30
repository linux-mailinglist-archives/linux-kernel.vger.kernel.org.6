Return-Path: <linux-kernel+bounces-309086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1693A966607
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A1891F23F57
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12521B1D7C;
	Fri, 30 Aug 2024 15:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGegzo2e"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFF6EEC3
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 15:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725032892; cv=none; b=fJshWCDH/0d4/Qxmvjcax7Zy65bb2IrJh1quydNEuzd7ZHfWfxIoW7YP5Cw/qUTL750KcKUvxcodDTokOJOb08212iR0UL/syZ3fjgB8NHodAjKFQiTTqJtn/19ICirNHQWjCnrk0nZs3Fa//5hC7uoM5aSj7hO6S83tulVICUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725032892; c=relaxed/simple;
	bh=Z7MI2IVqi6ipAfCskyUhsTy+MLxgbjRyd6lS8JXEoqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWAP0GeC0Gwjd32dhB0WT40JYggHypZl3Gkd39vrAMJPKevdJT3FOv27GetbCxPokhnfnrTllqHZDSvX7S5lDccGOLjM5/wPmKWEA5t4hi/M2JgJXTpl6Srf1WSP2kl0qffin+Q8OtEn5xXpVbLbup4EP/VYnu4ujVQE2aYuf28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGegzo2e; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-716609a0e2bso868423b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725032890; x=1725637690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rQReOi0900UnIL3kC0bMSd8MrWOptaR/Y/13HgBEXbM=;
        b=TGegzo2eOvtnAgqT4l4n9Do6guYS1vHIQULliijlZRWer9AXswVdAcK0s9joqcNH7T
         UKSSwHvmxKdkNVKOzCWtoNrDUaHEQGrQC0d29547RCPyB7o/NteOuoz2t9RaVe2sM8Az
         sJ2BdlvMl50hDzsAVL7I4l5IemYh7jjyncxoy96Do89EyMFj6R0YXUubCuIfp1ojsEtO
         fjE2UAkta0R26+z2eWRGhRNIXCv+yc8jvvtMGydJfV8JVTH85Q0At32Mmq64Tp/juTuV
         Kfm0E2F9kmWay8aR1LGMKGZH1sx9OjbqfgVpl9xWpxRtCi5WLPwUdej2fRSOvPr4LW+h
         sUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725032890; x=1725637690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQReOi0900UnIL3kC0bMSd8MrWOptaR/Y/13HgBEXbM=;
        b=IIcpd+yHw07tIcHTFDXLcrxhKDp4qHibAtX592MrVJBidMRdjBdsPziCFJf5d2fBjm
         U4nK5TDE4tfr4UhRZbcAwOTVpa8wcY9zkqcLFyR2KnC2/ibLbLXbY0JDWUKxBR116EA0
         FgtDsRHjEqtyk+1557KB52s3SCbHr2B6b9pOlOmLh5z4R0HEp/iIXwH6zn+bKSVUYDAB
         t2rNrxF9fbgq46I+cNHALO9KUIu4y/B+jqWmPIQvN062y/xIJgQguK3mlqvBr0IOs6Up
         dvI7n5n4Ag3JrlhGSo8TYQNgHNJhrkUdy1uUaf62GFAutGohFGbXDMPGhyFYsvS84a1H
         eYQg==
X-Forwarded-Encrypted: i=1; AJvYcCVETz7mcZogrkQeMdd6iq7ikfL0C9qZLQpaTiMARI6eRukMCUQ1PzTj1etsuFnL0dg5xigZ/MUhd0UZ5+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZKUt7ZXUi/HdfqXf/4eDhKMrAV5XY9oZUCTwgmwqHoe4eDM1k
	DIfSlUD/GE2LyOdTV+k2TpBVncHsIwrahl5vUYaVfScu7cWXa4rdf6yNYLOm
X-Google-Smtp-Source: AGHT+IE0YeN/nagY2VVgNASEe67s+Y2/rSRhKoieYO+3jCX0rcknFLLIVIauh8yaUJw0zvNDFu99kQ==
X-Received: by 2002:a05:6a20:46aa:b0:1cc:e195:9c69 with SMTP id adf61e73a8af0-1cce1959d9emr5352749637.1.1725032889740;
        Fri, 30 Aug 2024 08:48:09 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a5dccsm2915294b3a.66.2024.08.30.08.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 08:48:09 -0700 (PDT)
Date: Fri, 30 Aug 2024 08:48:06 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] lib: benchmark bitmap sets binary operation find
Message-ID: <ZtHptgtLhgpGQTga@yury-ThinkPad>
References: <20240829135926.926603-1-mathieu.desnoyers@efficios.com>
 <20240829135926.926603-6-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829135926.926603-6-mathieu.desnoyers@efficios.com>

On Thu, Aug 29, 2024 at 09:59:25AM -0400, Mathieu Desnoyers wrote:
> Benchmark the following bitmap find functions applying binary operations
> on sets of two bitmaps:
> 
> - find_first_andnot_bit,
> - find_first_nor_bit,
> - find_next_andnot_bit,
> - find_next_nor_bit,
> - find_next_or_bit.
> 
> Note that find_first_or_bit is not part of the current API, so it is not
> covered.

Can you please show how the test output looks on your system now? I'll
add that in commit message.

> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  lib/find_bit_benchmark.c | 93 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
> 
> diff --git a/lib/find_bit_benchmark.c b/lib/find_bit_benchmark.c
> index aee2ebb6b3cd..3b16254dec23 100644
> --- a/lib/find_bit_benchmark.c
> +++ b/lib/find_bit_benchmark.c
> @@ -70,6 +70,44 @@ static int __init test_find_first_and_bit(void *bitmap, const void *bitmap2, uns
>  	return 0;
>  }
>  
> +static int __init test_find_first_andnot_bit(void *bitmap, const void *bitmap2, unsigned long len)
> +{
> +	static DECLARE_BITMAP(cp, BITMAP_LEN) __initdata;
> +	unsigned long i, cnt;
> +	ktime_t time;
> +
> +	bitmap_copy(cp, bitmap, BITMAP_LEN);
> +
> +	time = ktime_get();
> +	for (cnt = i = 0; i < len; cnt++) {
> +		i = find_first_andnot_bit(cp, bitmap2, len);
> +		__clear_bit(i, cp);
> +	}
> +	time = ktime_get() - time;
> +	pr_err("find_first_andnot_bit: %18llu ns, %6ld iterations\n", time, cnt);
> +
> +	return 0;
> +}
> +
> +static int __init test_find_first_nor_bit(void *bitmap, const void *bitmap2, unsigned long len)
> +{
> +	static DECLARE_BITMAP(cp, BITMAP_LEN) __initdata;
> +	unsigned long i, cnt;
> +	ktime_t time;
> +
> +	bitmap_copy(cp, bitmap, BITMAP_LEN);
> +
> +	time = ktime_get();
> +	for (cnt = i = 0; i < len; cnt++) {
> +		i = find_first_nor_bit(cp, bitmap2, len);
> +		__set_bit(i, cp);
> +	}
> +	time = ktime_get() - time;
> +	pr_err("find_first_nor_bit: %18llu ns, %6ld iterations\n", time, cnt);
> +
> +	return 0;
> +}
> +
>  static int __init test_find_next_bit(const void *bitmap, unsigned long len)
>  {
>  	unsigned long i, cnt;
> @@ -148,6 +186,51 @@ static int __init test_find_next_and_bit(const void *bitmap,
>  	return 0;
>  }
>  
> +static int __init test_find_next_andnot_bit(const void *bitmap,
> +		const void *bitmap2, unsigned long len)
> +{
> +	unsigned long i, cnt;
> +	ktime_t time;
> +
> +	time = ktime_get();
> +	for (cnt = i = 0; i < BITMAP_LEN; cnt++)
> +		i = find_next_andnot_bit(bitmap, bitmap2, BITMAP_LEN, i + 1);
> +	time = ktime_get() - time;
> +	pr_err("find_next_andnot_bit:  %18llu ns, %6ld iterations\n", time, cnt);
> +
> +	return 0;
> +}
> +
> +static int __init test_find_next_nor_bit(const void *bitmap,
> +		const void *bitmap2, unsigned long len)
> +{
> +	unsigned long i, cnt;
> +	ktime_t time;
> +
> +	time = ktime_get();
> +	for (cnt = i = 0; i < BITMAP_LEN; cnt++)
> +		i = find_next_nor_bit(bitmap, bitmap2, BITMAP_LEN, i + 1);
> +	time = ktime_get() - time;
> +	pr_err("find_next_nor_bit:  %18llu ns, %6ld iterations\n", time, cnt);
> +
> +	return 0;
> +}
> +
> +static int __init test_find_next_or_bit(const void *bitmap,
> +		const void *bitmap2, unsigned long len)
> +{
> +	unsigned long i, cnt;
> +	ktime_t time;
> +
> +	time = ktime_get();
> +	for (cnt = i = 0; i < BITMAP_LEN; cnt++)
> +		i = find_next_or_bit(bitmap, bitmap2, BITMAP_LEN, i + 1);
> +	time = ktime_get() - time;
> +	pr_err("find_next_or_bit:  %18llu ns, %6ld iterations\n", time, cnt);
> +
> +	return 0;
> +}
> +
>  static int __init find_bit_test(void)
>  {
>  	unsigned long nbits = BITMAP_LEN / SPARSE;
> @@ -169,6 +252,11 @@ static int __init find_bit_test(void)
>  	test_find_first_bit(bitmap, BITMAP_LEN / 10);
>  	test_find_first_and_bit(bitmap, bitmap2, BITMAP_LEN / 2);
>  	test_find_next_and_bit(bitmap, bitmap2, BITMAP_LEN);
> +	test_find_first_andnot_bit(bitmap, bitmap2, BITMAP_LEN / 2);
> +	test_find_next_andnot_bit(bitmap, bitmap2, BITMAP_LEN);
> +	test_find_first_nor_bit(bitmap, bitmap2, BITMAP_LEN / 2);
> +	test_find_next_nor_bit(bitmap, bitmap2, BITMAP_LEN);
> +	test_find_next_or_bit(bitmap, bitmap2, BITMAP_LEN);
>  
>  	pr_err("\nStart testing find_bit() with sparse bitmap\n");
>  
> @@ -187,6 +275,11 @@ static int __init find_bit_test(void)
>  	test_find_first_bit(bitmap, BITMAP_LEN);
>  	test_find_first_and_bit(bitmap, bitmap2, BITMAP_LEN);
>  	test_find_next_and_bit(bitmap, bitmap2, BITMAP_LEN);
> +	test_find_first_andnot_bit(bitmap, bitmap2, BITMAP_LEN);
> +	test_find_next_andnot_bit(bitmap, bitmap2, BITMAP_LEN);
> +	test_find_first_nor_bit(bitmap, bitmap2, BITMAP_LEN);
> +	test_find_next_nor_bit(bitmap, bitmap2, BITMAP_LEN);
> +	test_find_next_or_bit(bitmap, bitmap2, BITMAP_LEN);
>  
>  	/*
>  	 * Everything is OK. Return error just to let user run benchmark
> -- 
> 2.39.2

