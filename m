Return-Path: <linux-kernel+bounces-292783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABE3957454
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 21:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 288911F2389C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477FD1D6191;
	Mon, 19 Aug 2024 19:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8w7t36+"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286034438B
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 19:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724095504; cv=none; b=Ls2izq+rgSCNnyfDRECAJqUDonORzTmhkQASyn12ABfoHbZnJ/KN8NJ47PADGN1Yj1A6NazpLVFpAscQnJDh8ve9rDdcrxfbRSSgJKDBN37ujy14eT9nnuZrP6eOHblrXNZ6TmJ+vWE7qIKpR20LjlUWrud0Fc/B7JMDGz+Js6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724095504; c=relaxed/simple;
	bh=jNnGDCPncqOjy1dMJ7YUFxZUaUz80Rk9HwOfwD+ITb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUhK2avAjN8dPbux5FozwuUahGt8EgVKAlEQ7poywqNxNY0m6AZopL88nxpZBCG20/3J5lOOtFC4QzLRsINBGQOLFappxcTqZHwp2huoJiwEHvNAIokaxe/HDNj+SZIlBuQ9020kPmRtYt+5QuYAbbl2HQs+cfcAEVEAXbTPcPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8w7t36+; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-201cd78c6a3so35995315ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 12:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724095502; x=1724700302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YegbN6hoOZXxYeEaxNij25J1+Q3zB99tPDDll9NCovw=;
        b=B8w7t36+RcMQZWokzbNHwvqnFK4lXEn1Z3ooA2O02SwHzIDohLmGMP2uEPYmp0NovM
         VZj5sCnQ5/90sMtN5w55l6u51aasXT8wDTWLxPL1r6rURr8QXKYNBnL70ANoE6tSj2L4
         nwkHH+9Om09I8ejLslbZ3bWt0EHp1R7lBlkY229UzQs/b3eaKVzXW4tqjl+8u0bomngl
         IUL8bBDaX2HxwmyyVReGfLujeWlWba546EcjhutPklZ+mifou6eXRNoCN8a/O3ZsCWj9
         yJL+QFmqy7Qbf2+/vXW9feg6NMbBaZe+NTfRB1c7q1HbrLR/ykMKwPpegXfxId2c0OoX
         d8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724095502; x=1724700302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YegbN6hoOZXxYeEaxNij25J1+Q3zB99tPDDll9NCovw=;
        b=VOs6wfjeJ4gmPRSNXDRbHokgYMw7XwijIVl2DZF9g4/xNyUbFeefT43bKC3/402yrE
         Tv/d6F8WnZAMQ7IXOdlHzmjAxKkAU7yWTCk+PeGyKDwhgXiqMORkSHsX95W9hQDTcJ6A
         NaLXzhZnkRdbquC47xM3x/CWneraPjfJ2d1QFCRvsJMtmBAT6/Op29C1YF1w29mEjQpI
         dq1DnGUDPMF3aQo4uZ2lTQxuJuPgUhyPo35+ZGzaw7yml25SbhdTWImHbM8QryEfao3w
         DgcUJAI5Jt1kHouLG+zXTJrXsMK055GQxWCmLXxZ97RGmN446nyX01rB4D0m2bC18eKj
         UfTw==
X-Forwarded-Encrypted: i=1; AJvYcCUAF8kA519EwXi/RGx2e8c2hEjk7MkG48n6m4l6K38JLS+g79PE+trwTno1mtfFYZwllR2HXeqoZ1stT88ThWkx5H4aTPpTLNGBTUgT
X-Gm-Message-State: AOJu0YzUJXT73SRZBrRadX36zNF6xlRws2EVpmQoEaxkYihIQ1BH1d7y
	FPp2n0aYyy+QRk07UTTsM8WBegZlwsTTU4Cqt73s6t9V4p2H16Of
X-Google-Smtp-Source: AGHT+IFQNe/nTCD3xJsESyDkPngmYmqUq5cLIro/iXes7k2lh+x4vGaf0eefwz9SiTzjJOteyZ/JGg==
X-Received: by 2002:a17:902:db03:b0:202:1529:3b17 with SMTP id d9443c01a7336-20215293f1fmr137676265ad.39.1724095502261;
        Mon, 19 Aug 2024 12:25:02 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f03a55a0sm65749695ad.294.2024.08.19.12.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 12:25:01 -0700 (PDT)
Date: Mon, 19 Aug 2024 12:24:59 -0700
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
Subject: Re: [RFC PATCH 2/5] cpumask: Implement
 cpumask_{first,next}_{not,}andnot
Message-ID: <ZsOcC_6S3_GviaIJ@yury-ThinkPad>
References: <20240819142406.339084-1-mathieu.desnoyers@efficios.com>
 <20240819142406.339084-3-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819142406.339084-3-mathieu.desnoyers@efficios.com>

On Mon, Aug 19, 2024 at 04:24:03PM +0200, Mathieu Desnoyers wrote:
> Allow finding the first or next bit within two input cpumasks which is
> either:

"first or next CPU..." here.
 
> - both zero and zero,
> - respectively one and zero.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  include/linux/cpumask.h | 60 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index 23686bed441d..57b7d99d6da1 100644
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
> +static inline
> +unsigned int cpumask_first_andnot(const struct cpumask *srcp1, const struct cpumask *srcp2)

Please use __always_inline to enforce a compile-time optimizations.
Check for this series:
https://lore.kernel.org/lkml/20240719005127.2449328-4-briannorris@chromium.org/T/

It's already in -next.

Thanks,
Yury

> +{
> +	return find_first_andnot_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits);
> +}
> +
> +/**
> + * cpumask_first_notandnot - return the first cpu from ~*srcp1 & ~*srcp2
> + * @src1p: the first input
> + * @src2p: the second input
> + *
> + * Returns >= nr_cpu_ids if no cpus match in both.
> + */
> +static inline
> +unsigned int cpumask_first_notandnot(const struct cpumask *srcp1, const struct cpumask *srcp2)
> +{
> +	return find_first_notandnot_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits);
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
> +static inline
> +unsigned int cpumask_next_andnot(int n, const struct cpumask *srcp1, const struct cpumask *srcp2)
> +{
> +	/* -1 is a legal arg here. */
> +	if (n != -1)
> +		cpumask_check(n);
> +	return find_next_andnot_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits, n+1);
> +}
> +
> +/**
> + * cpumask_next_notandnot - return the next cpu from ~*srcp1 & ~*srcp2
> + * @n: the cpu prior to the place to search (ie. return will be > @n)
> + * @src1p: the first input
> + * @src2p: the second input
> + *
> + * Returns >= nr_cpu_ids if no cpus match in both.
> + */
> +static inline
> +unsigned int cpumask_next_notandnot(int n, const struct cpumask *srcp1, const struct cpumask *srcp2)
> +{
> +	/* -1 is a legal arg here. */
> +	if (n != -1)
> +		cpumask_check(n);
> +	return find_next_notandnot_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits, n+1);
> +}
> +
>  #if NR_CPUS == 1
>  /* Uniprocessor: there is only one valid CPU */
>  static inline unsigned int cpumask_local_spread(unsigned int i, int node)
> -- 
> 2.39.2

