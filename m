Return-Path: <linux-kernel+bounces-299535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC1695D5FC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 21:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 955671C22CE6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 19:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D63192589;
	Fri, 23 Aug 2024 19:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNwAW4UR"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8100B8F6B
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 19:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724440723; cv=none; b=JaaVRgKGlgdOaAZxaPVYFUQGSsxR1EtbHAT5vIDz1kiFrn/NC0jg9PxSU1l0D7kWOCuA4PEhxzykPNOGnQqO87LY0901ybZmNA1+2KKgajx8nJFJaTthXMUwuUT+5TsFmb4A/UZ3SqwH6eO3Y7P76TlQcqUkUtAUOjdqR5Pk/eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724440723; c=relaxed/simple;
	bh=h05tDNb/w9/s2t4k6+FJ+qk72QG3Jl8OzoskMkOmMG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etc+whB82BPoe+0gtGNUxbQwr4Qq3wNkMsb1HpN2SwvOK5ZWQMum/JkHW/Rn0J6Uy02Ttgpr+b4F+XcSU74/7ZrK3+hQbq3B5cmBeVwdbUqVCzzLNyD/MuN8tqvWdoKcwymyvbo9OAyJIisriW0XQSiwoPMrOxJJFA3loQKRw4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNwAW4UR; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70cec4aa1e4so1746210b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 12:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724440722; x=1725045522; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VAI7U9+JMkiX53cBLbSTqP0FHZ0ZkqWJgaffwJcUIz8=;
        b=JNwAW4URsBaUWIotPurBxxvKjbZiSdO3y5xrGou47XzSXLfjunECRzwUtSRwo56Kpb
         0dpIDlP7WtPm1YpRJ6glGkbBM1dM1gLstsVjGQqV2WR/DUEvPgOvwqroWNQL7ic0TCqC
         jYmkxIhXN6N++mvsHo6dRovaW72X1y1T3YCOZ11zfDRAbcgQMBsTSV9DUxvolWkT8NQ9
         lnfp5vfdDm3L+au/D4z6qTvgVjFNhQsOQI9k+cThJX2dnoSXjA0m+euz3EQNsj8GfCU+
         UnkaBP8Jm8464iLFlXyeYJO5DAErpNDOSuxRtMt5Cx3KORJZwj/iHi4Y0a8KjOP2NSpe
         LD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724440722; x=1725045522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAI7U9+JMkiX53cBLbSTqP0FHZ0ZkqWJgaffwJcUIz8=;
        b=Ny8MVHvEpyTb4PnB+dKHepK3KidpRsCINzkuf8j5c0MDXHkY6E+j+x4Ldf3F6JQFka
         WYV/NgqqSfp4AKvISzGdyMnzsfJP8Elem/m0GMvWVNa6oLDoGAANoMhbeF3mi1d3XsqE
         CfEVmlMSoegn5xk2ZCuWzXGtZpc8yprkt1HElLq0R5rBzadK1kKx1KUoI3sbm4yAEd6Y
         JkhuXosshvnplfv3BI6KK7+HfPt+YzLVZwfQvGv8Bmw08vvixarfqIZr8rZMhnu2I3Bw
         8Em0Xet1I185UquKhMgmPmLDPY4zAy8QVE6KVmWlnYjdQkICYbTWoV34dCmFdWxldUex
         R4rQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqHX/4WfQVVG/byw47abjL2B9vBKn44L5RNT2o84x8T1qy73bUBKZCZ3/rMQTIAL5BvCdZU0LOCTd0KZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvafOg52xdOakarKQqw1vZ4vifENkm48ZO15HnW/pgnNn2+XF5
	6NgwUtLGUMmTxdisZymDd5aQp5pyii8d1njK1bYBDYcvirYHVv8ERQU9luXx
X-Google-Smtp-Source: AGHT+IG+uxStVBCvZMGuYVvSAEzznTm/nzsR/hczIylts491KxTnNIz1nb/XmKKacwo9SgkoOlAdeg==
X-Received: by 2002:a05:6a00:91d0:b0:714:10d2:baae with SMTP id d2e1a72fcca58-714457d3456mr3663894b3a.14.1724440721588;
        Fri, 23 Aug 2024 12:18:41 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143431a239sm3507575b3a.179.2024.08.23.12.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 12:18:41 -0700 (PDT)
Date: Fri, 23 Aug 2024 12:18:38 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	linux-kernel@vger.kernel.org,
	Valentin Schneider <vschneid@redhat.com>,
	Mel Gorman <mgorman@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [RFC PATCH v1 3/6] cpumask: Implement
 cpumask_{first,next}_{nor,andnot}
Message-ID: <Zsjgjh1V3wf0gwbd@yury-ThinkPad>
References: <20240823185946.418340-1-mathieu.desnoyers@efficios.com>
 <20240823185946.418340-4-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823185946.418340-4-mathieu.desnoyers@efficios.com>

On Fri, Aug 23, 2024 at 02:59:43PM -0400, Mathieu Desnoyers wrote:
> Allow finding the first or next bit within two input cpumasks which is
> either:
> 
> - both zero and zero,
> - respectively one and zero.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
> Changes since v0:
> - Rename "notandnot" to "nor".
> - Use __always_inline.
> ---
>  include/linux/cpumask.h | 60 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index 23686bed441d..5573e75c13ec 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -204,6 +204,32 @@ unsigned int cpumask_first_and_and(const struct cpumask *srcp1,
>  				      cpumask_bits(srcp3), small_cpumask_bits);
>  }
>  
> +/**
> + * cpumask_first_andnot - return the first cpu from *srcp1 & ~*srcp2
> + * @src1p: the first input
> + * @src2p: the second input
> + *
> + * Returns >= nr_cpu_ids if no cpus match in both.
> + */
> +static __always_inline
> +unsigned int cpumask_first_andnot(const struct cpumask *srcp1, const struct cpumask *srcp2)
> +{
> +	return find_first_andnot_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits);


Here should be a small_cpumask_bits. This is better optimized for
NR_CPUS < BITS_PER_LONG.

> +}
> +
> +/**
> + * cpumask_first_nor - return the first cpu from ~(*srcp1 | *srcp2)
> + * @src1p: the first input
> + * @src2p: the second input
> + *
> + * Returns >= nr_cpu_ids if no cpus match in both.
> + */
> +static __always_inline
> +unsigned int cpumask_first_nor(const struct cpumask *srcp1, const struct cpumask *srcp2)
> +{
> +	return find_first_nor_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits);
> +}
> +
>  /**
>   * cpumask_last - get the last CPU in a cpumask
>   * @srcp:	- the cpumask pointer
> @@ -246,6 +272,40 @@ static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
>  	return find_next_zero_bit(cpumask_bits(srcp), small_cpumask_bits, n+1);
>  }
>  
> +/**
> + * cpumask_next_andnot - return the next cpu from *srcp1 & ~*srcp2
> + * @n: the cpu prior to the place to search (ie. return will be > @n)
> + * @src1p: the first input
> + * @src2p: the second input
> + *
> + * Returns >= nr_cpu_ids if no cpus match in both.
> + */
> +static __always_inline
> +unsigned int cpumask_next_andnot(int n, const struct cpumask *srcp1, const struct cpumask *srcp2)
> +{
> +	/* -1 is a legal arg here. */
> +	if (n != -1)
> +		cpumask_check(n);
> +	return find_next_andnot_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits, n+1);
> +}
> +
> +/**
> + * cpumask_next_nor - return the next cpu from ~(*srcp1 | *srcp2)
> + * @n: the cpu prior to the place to search (ie. return will be > @n)
> + * @src1p: the first input
> + * @src2p: the second input
> + *
> + * Returns >= nr_cpu_ids if no cpus match in both.
> + */
> +static __always_inline
> +unsigned int cpumask_next_nor(int n, const struct cpumask *srcp1, const struct cpumask *srcp2)
> +{
> +	/* -1 is a legal arg here. */
> +	if (n != -1)
> +		cpumask_check(n);
> +	return find_next_nor_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits, n+1);
> +}
> +
>  #if NR_CPUS == 1
>  /* Uniprocessor: there is only one valid CPU */
>  static inline unsigned int cpumask_local_spread(unsigned int i, int node)
> -- 
> 2.39.2

