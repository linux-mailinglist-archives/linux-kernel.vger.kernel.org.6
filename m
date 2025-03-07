Return-Path: <linux-kernel+bounces-551614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A8AA56EA6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64C56188C62C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB4323F400;
	Fri,  7 Mar 2025 17:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2cz8Wv+"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE8B219A8D;
	Fri,  7 Mar 2025 17:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741367161; cv=none; b=fRVxh6sS6xvoh6btGyO6aV9oeAxsmqfU4X9lMLXR0I6LYQL8ArPWREa6HtRl60NhX2aNUOo0Ke7k+K5Ztsi0t8P/T3eKIQn0+/nqReZg8+n4fPNq4BOnHAPDdN8v8Io56UHgyDahRwaxf1GcjNWLzU32ebUbkeOyykAt09siOjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741367161; c=relaxed/simple;
	bh=zrp0xijJ8gQb1ybmPkVToUtQ5n6ctcfJR1zDwrLRJ+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rn/y8bWIbmM7W4M7rb0Ydy+2jGLSmFeuWAACmPWsOkPRikvHGeJ4EE1G+FjLhcjmfshpFA7bdxJoswqB3iQzA+GTIQV6CExp4nl+gkLY3lwhT36+rfdPy9d0rjc5wOaNUXphBkbgSaLs5LkhUaIyAcOKHTbKL2Q93nG72Vd49sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2cz8Wv+; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6fece18b3c8so2421837b3.3;
        Fri, 07 Mar 2025 09:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741367158; x=1741971958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OvizVAeN9Cl9G1SPPyHnNC1ZwE6wLB5U+jwBHWWlf14=;
        b=L2cz8Wv+ePniBKviMLz1cnDAAuHP2abJEzqK3QI0ymFSGjz99twSSGHLF9kMfV1EVr
         eGcoB9mpDNOMdbcCA+QY6XeAX+uSNfC1TR/I0AnMymPJvG+Zty6RrMop9kQODjYTVfKV
         ynOHC5vOQNrLQgsjJ8et/q73tiZjYrNmDJV7oRsCs7ZqTYyCEjfXFUrm+UPm3mFzz+1r
         oALyKRJIBDFDNGCFGFkJawrZzjqRnG6+TrOiV2tT4qHjxhC/Rpn8mYIxbdqKEs900kSW
         czchB3GLB5Ux3FoJaG2oMEmgmyhOTwiLXbrzK1i38lDuZYTXEgz6nw7WlPCzl2G/FXMv
         +4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741367158; x=1741971958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvizVAeN9Cl9G1SPPyHnNC1ZwE6wLB5U+jwBHWWlf14=;
        b=GTPUsETFtXxQj/OM36QYdkAslxw94EBRAVKjr5XIb0tDXtIXajYyQ47YolEubu48G2
         WM3mAObx78f3zLMRzJiUlqHeSB/Cnglk/udYLxuhDXR4oTx8tUIixGLFwI0sU6O1ogb4
         BIvhIT2Mg3w+6Af4kvU5j8cKSPiQzWffwr+GJP20Il+0SV6frxmldjYtzMRggaALmf/o
         znTQl/GJa5L7M+VxKlvqcMdTcB/eaQbvk8UnUNgLzjbfG/v9pjUrLR7lOFO74xDEu21K
         J/5imP/6X1Ntqp5daEJTLBH2QDqrGSaq5h0FNA0XePuEUeaVcgvrAY0sOsmV0Dq0Uguc
         UtXA==
X-Forwarded-Encrypted: i=1; AJvYcCUVA2iIm6MUW+4RvX8Cs9DYxNMg6e4RDXw3mb3LpjPBWQqTRhrGua5HKbultRzaZuu6IkgAiBshq2Uk5T7m@vger.kernel.org, AJvYcCW6YpPOcdFsIjKp5p8iZ+3BrZf3Ljs1SwYS6/htUX7gcw3uwLQuJ8DdiAgxDTEJTQhpxV/3AL6tRis=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIX6RNwZPlJC2Tu1sOXSO/lsnskRlNsXC1CgwZepqmzs6qvBMj
	jL5ahcJUXbk7pQpUmdrI+wsfHR+5EnjhNZqgkyiXanPp/tm2YCYC
X-Gm-Gg: ASbGncttzm/HmcmyWwHCyxNJwTaDD8/HYFFkTbjj6RBgtvwu4agpeL2c7bMKUyKtx/W
	S6dWeM7Bv6o0pBrf8yAiFw4LM2N0yGFwwjkzpcw4VaXKil/nnJjiltqk0bX6McXs1HHSxoQjmt7
	nlET4Ou9X9qkfgrb8mrED+Rwn2L4jKODxQRX+5qT4ALbXQhnPgCJUJWvZS7/zhHBKepEfrIw10A
	t2gX0phcX2A3jghPxfOnqOYgCVmEjkQfjiVZkoqodVKHI2o6p+hT/lGGiIGVj48aPqdTERIr/Nv
	mR8xtKq5OpuTPKR/ci0Z5QMfbPq2FMClbUKz4HdbNOLt3Ox08BlAwFbT9Jm8wp+46uMNe1TraKz
	Bm5Gq
X-Google-Smtp-Source: AGHT+IF3BDtkzFgyarG1ls7NUDqoht4kFb9p5m8aEbdPGZQmr4sTo/aiCLtQHeGnDNQ+irvFryXmWw==
X-Received: by 2002:a05:690c:67c7:b0:6f9:b12b:8943 with SMTP id 00721157ae682-6febf2f3a9bmr62432267b3.19.1741367158201;
        Fri, 07 Mar 2025 09:05:58 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6feb2a5becdsm8156977b3.28.2025.03.07.09.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 09:05:57 -0800 (PST)
Date: Fri, 7 Mar 2025 12:05:56 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Akira Yokosawa <akiyks@gmail.com>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/2] cpumask: Fix kernel-doc formatting errors in
 cpumask.h
Message-ID: <Z8snakYmzhaavkKN@thinkpad>
References: <cover.1741332579.git.viresh.kumar@linaro.org>
 <f4ad81150eaa00b43c161f0d1f811f8ecfe21889.1741332579.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4ad81150eaa00b43c161f0d1f811f8ecfe21889.1741332579.git.viresh.kumar@linaro.org>

On Fri, Mar 07, 2025 at 01:04:51PM +0530, Viresh Kumar wrote:
> This fixes various kernel-doc formatting errors in cpumask.h:
> 
> - WARNING: Inline literal start-string without end-string.
> - ERROR: Unexpected indentation.
> - ERROR: Unknown target name: "gfp".
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  include/linux/cpumask.h | 65 +++++++++++++++++++++--------------------
>  1 file changed, 34 insertions(+), 31 deletions(-)
> 
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index 36a890d0dd57..8b53e01dbd97 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -20,7 +20,7 @@
>   * cpumask_pr_args - printf args to output a cpumask
>   * @maskp: cpumask to be printed
>   *
> - * Can be used to provide arguments for '%*pb[l]' when printing a cpumask.
> + * Can be used to provide arguments for '%*pb [l]' when printing a cpumask.
>   */
>  #define cpumask_pr_args(maskp)		nr_cpu_ids, cpumask_bits(maskp)
>  
> @@ -166,7 +166,7 @@ static __always_inline unsigned int cpumask_first_zero(const struct cpumask *src
>  }
>  
>  /**
> - * cpumask_first_and - return the first cpu from *srcp1 & *srcp2
> + * cpumask_first_and - return the first cpu from *@srcp1 & *@srcp2
>   * @srcp1: the first input
>   * @srcp2: the second input
>   *
> @@ -179,7 +179,7 @@ unsigned int cpumask_first_and(const struct cpumask *srcp1, const struct cpumask
>  }
>  
>  /**
> - * cpumask_first_and_and - return the first cpu from *srcp1 & *srcp2 & *srcp3
> + * cpumask_first_and_and - return the first cpu from *@srcp1 & *@srcp2 & *@srcp3
>   * @srcp1: the first input
>   * @srcp2: the second input
>   * @srcp3: the third input
> @@ -266,7 +266,7 @@ unsigned int cpumask_any_distribute(const struct cpumask *srcp);
>  #endif /* NR_CPUS */
>  
>  /**
> - * cpumask_next_and - get the next cpu in *src1p & *src2p
> + * cpumask_next_and - get the next cpu in *@src1p & *@src2p
>   * @n: the cpu prior to the place to search (i.e. return will be > @n)
>   * @src1p: the first cpumask pointer
>   * @src2p: the second cpumask pointer

So the question: if some word in this particular comment block is
prefixed with @ symbol, can we teach kernel-doc to consider every
occurrence of this word as a variable?

Why I'm asking: before the "*src1p & *src2p" was a line of C code.
And because we are all C programmers here, it's really simple to ident
it and decode. After it looks like something weird, and I think many
of us will just mentally skip it.

I like kernel-docs and everything, but again, kernel sources should
stay readable, and particularly comments should stay human-readable.

> @@ -334,7 +334,8 @@ unsigned int __pure cpumask_next_wrap(int n, const struct cpumask *mask, int sta
>   * @mask1: the first cpumask pointer
>   * @mask2: the second cpumask pointer
>   *
> - * This saves a temporary CPU mask in many places.  It is equivalent to:
> + * This saves a temporary CPU mask in many places.  It is equivalent to::
> + *

I'm OK with extra line, but this double-colon. What for and what does
it mean?

>   *	struct cpumask tmp;
>   *	cpumask_and(&tmp, &mask1, &mask2);
>   *	for_each_cpu(cpu, &tmp)
> @@ -352,7 +353,8 @@ unsigned int __pure cpumask_next_wrap(int n, const struct cpumask *mask, int sta
>   * @mask1: the first cpumask pointer
>   * @mask2: the second cpumask pointer
>   *
> - * This saves a temporary CPU mask in many places.  It is equivalent to:
> + * This saves a temporary CPU mask in many places.  It is equivalent to::
> + *
>   *	struct cpumask tmp;
>   *	cpumask_andnot(&tmp, &mask1, &mask2);
>   *	for_each_cpu(cpu, &tmp)
> @@ -369,7 +371,8 @@ unsigned int __pure cpumask_next_wrap(int n, const struct cpumask *mask, int sta
>   * @mask1: the first cpumask pointer
>   * @mask2: the second cpumask pointer
>   *
> - * This saves a temporary CPU mask in many places.  It is equivalent to:
> + * This saves a temporary CPU mask in many places.  It is equivalent to::
> + *
>   *	struct cpumask tmp;
>   *	cpumask_or(&tmp, &mask1, &mask2);
>   *	for_each_cpu(cpu, &tmp)
> @@ -411,7 +414,7 @@ unsigned int cpumask_any_but(const struct cpumask *mask, unsigned int cpu)
>  }
>  
>  /**
> - * cpumask_any_and_but - pick an arbitrary cpu from *mask1 & *mask2, but not this one.
> + * cpumask_any_and_but - pick an arbitrary cpu from *@mask1 & *@mask2, but not this one.
>   * @mask1: the first input cpumask
>   * @mask2: the second input cpumask
>   * @cpu: the cpu to ignore
> @@ -545,7 +548,7 @@ static __always_inline void __cpumask_clear_cpu(int cpu, struct cpumask *dstp)
>   * cpumask_assign_cpu - assign a cpu in a cpumask
>   * @cpu: cpu number (< nr_cpu_ids)
>   * @dstp: the cpumask pointer
> - * @bool: the value to assign
> + * @value: the value to assign
>   */
>  static __always_inline void cpumask_assign_cpu(int cpu, struct cpumask *dstp, bool value)
>  {
> @@ -623,7 +626,7 @@ static __always_inline void cpumask_clear(struct cpumask *dstp)
>  }
>  
>  /**
> - * cpumask_and - *dstp = *src1p & *src2p
> + * cpumask_and - *@dstp = *@src1p & *@src2p
>   * @dstp: the cpumask result
>   * @src1p: the first input
>   * @src2p: the second input
> @@ -639,7 +642,7 @@ bool cpumask_and(struct cpumask *dstp, const struct cpumask *src1p,
>  }
>  
>  /**
> - * cpumask_or - *dstp = *src1p | *src2p
> + * cpumask_or - *@dstp = *@src1p | *@src2p
>   * @dstp: the cpumask result
>   * @src1p: the first input
>   * @src2p: the second input
> @@ -653,7 +656,7 @@ void cpumask_or(struct cpumask *dstp, const struct cpumask *src1p,
>  }
>  
>  /**
> - * cpumask_xor - *dstp = *src1p ^ *src2p
> + * cpumask_xor - *@dstp = *@src1p ^ *@src2p
>   * @dstp: the cpumask result
>   * @src1p: the first input
>   * @src2p: the second input
> @@ -667,7 +670,7 @@ void cpumask_xor(struct cpumask *dstp, const struct cpumask *src1p,
>  }
>  
>  /**
> - * cpumask_andnot - *dstp = *src1p & ~*src2p
> + * cpumask_andnot - *@dstp = *@src1p & ~*@src2p
>   * @dstp: the cpumask result
>   * @src1p: the first input
>   * @src2p: the second input
> @@ -683,7 +686,7 @@ bool cpumask_andnot(struct cpumask *dstp, const struct cpumask *src1p,
>  }
>  
>  /**
> - * cpumask_equal - *src1p == *src2p
> + * cpumask_equal - *@src1p == *@src2p
>   * @src1p: the first input
>   * @src2p: the second input
>   *
> @@ -697,7 +700,7 @@ bool cpumask_equal(const struct cpumask *src1p, const struct cpumask *src2p)
>  }
>  
>  /**
> - * cpumask_or_equal - *src1p | *src2p == *src3p
> + * cpumask_or_equal - *@src1p | *@src2p == *@src3p
>   * @src1p: the first input
>   * @src2p: the second input
>   * @src3p: the third input
> @@ -714,7 +717,7 @@ bool cpumask_or_equal(const struct cpumask *src1p, const struct cpumask *src2p,
>  }
>  
>  /**
> - * cpumask_intersects - (*src1p & *src2p) != 0
> + * cpumask_intersects - (*@src1p & *@src2p) != 0
>   * @src1p: the first input
>   * @src2p: the second input
>   *
> @@ -729,7 +732,7 @@ bool cpumask_intersects(const struct cpumask *src1p, const struct cpumask *src2p
>  }
>  
>  /**
> - * cpumask_subset - (*src1p & ~*src2p) == 0
> + * cpumask_subset - (*@src1p & ~*@src2p) == 0
>   * @src1p: the first input
>   * @src2p: the second input
>   *
> @@ -743,7 +746,7 @@ bool cpumask_subset(const struct cpumask *src1p, const struct cpumask *src2p)
>  }
>  
>  /**
> - * cpumask_empty - *srcp == 0
> + * cpumask_empty - *@srcp == 0
>   * @srcp: the cpumask to that all cpus < nr_cpu_ids are clear.
>   *
>   * Return: true if srcp is empty (has no bits set), else false
> @@ -754,7 +757,7 @@ static __always_inline bool cpumask_empty(const struct cpumask *srcp)
>  }
>  
>  /**
> - * cpumask_full - *srcp == 0xFFFFFFFF...
> + * cpumask_full - *@srcp == 0xFFFFFFFF...
>   * @srcp: the cpumask to that all cpus < nr_cpu_ids are set.
>   *
>   * Return: true if srcp is full (has all bits set), else false
> @@ -765,10 +768,10 @@ static __always_inline bool cpumask_full(const struct cpumask *srcp)
>  }
>  
>  /**
> - * cpumask_weight - Count of bits in *srcp
> + * cpumask_weight - Count of bits in *@srcp
>   * @srcp: the cpumask to count bits (< nr_cpu_ids) in.

Here nr_cpu_ids is also a variable. Why you don't prefix it with @?

>   *
> - * Return: count of bits set in *srcp
> + * Return: count of bits set in *@srcp
>   */
>  static __always_inline unsigned int cpumask_weight(const struct cpumask *srcp)
>  {
> @@ -776,11 +779,11 @@ static __always_inline unsigned int cpumask_weight(const struct cpumask *srcp)
>  }
>  
>  /**
> - * cpumask_weight_and - Count of bits in (*srcp1 & *srcp2)
> + * cpumask_weight_and - Count of bits in (*@srcp1 & *@srcp2)
>   * @srcp1: the cpumask to count bits (< nr_cpu_ids) in.
>   * @srcp2: the cpumask to count bits (< nr_cpu_ids) in.
>   *
> - * Return: count of bits set in both *srcp1 and *srcp2
> + * Return: count of bits set in both *@srcp1 and *@srcp2
>   */
>  static __always_inline
>  unsigned int cpumask_weight_and(const struct cpumask *srcp1, const struct cpumask *srcp2)
> @@ -789,11 +792,11 @@ unsigned int cpumask_weight_and(const struct cpumask *srcp1, const struct cpumas
>  }
>  
>  /**
> - * cpumask_weight_andnot - Count of bits in (*srcp1 & ~*srcp2)
> + * cpumask_weight_andnot - Count of bits in (*@srcp1 & ~*@srcp2)
>   * @srcp1: the cpumask to count bits (< nr_cpu_ids) in.
>   * @srcp2: the cpumask to count bits (< nr_cpu_ids) in.
>   *
> - * Return: count of bits set in both *srcp1 and *srcp2
> + * Return: count of bits set in both *@srcp1 and *@srcp2
>   */
>  static __always_inline
>  unsigned int cpumask_weight_andnot(const struct cpumask *srcp1,
> @@ -803,7 +806,7 @@ unsigned int cpumask_weight_andnot(const struct cpumask *srcp1,
>  }
>  
>  /**
> - * cpumask_shift_right - *dstp = *srcp >> n
> + * cpumask_shift_right - *@dstp = *@srcp >> n
>   * @dstp: the cpumask result
>   * @srcp: the input to shift
>   * @n: the number of bits to shift by
> @@ -816,7 +819,7 @@ void cpumask_shift_right(struct cpumask *dstp, const struct cpumask *srcp, int n
>  }
>  
>  /**
> - * cpumask_shift_left - *dstp = *srcp << n
> + * cpumask_shift_left - *@dstp = *@srcp << n
>   * @dstp: the cpumask result
>   * @srcp: the input to shift
>   * @n: the number of bits to shift by
> @@ -829,7 +832,7 @@ void cpumask_shift_left(struct cpumask *dstp, const struct cpumask *srcp, int n)
>  }
>  
>  /**
> - * cpumask_copy - *dstp = *srcp
> + * cpumask_copy - *@dstp = *@srcp
>   * @dstp: the result
>   * @srcp: the input cpumask
>   */
> @@ -840,7 +843,7 @@ void cpumask_copy(struct cpumask *dstp, const struct cpumask *srcp)
>  }
>  
>  /**
> - * cpumask_any - pick an arbitrary cpu from *srcp
> + * cpumask_any - pick an arbitrary cpu from *@srcp
>   * @srcp: the input cpumask
>   *
>   * Return: >= nr_cpu_ids if no cpus set.
> @@ -848,7 +851,7 @@ void cpumask_copy(struct cpumask *dstp, const struct cpumask *srcp)
>  #define cpumask_any(srcp) cpumask_first(srcp)
>  
>  /**
> - * cpumask_any_and - pick an arbitrary cpu from *mask1 & *mask2
> + * cpumask_any_and - pick an arbitrary cpu from *@mask1 & *@mask2
>   * @mask1: the first input cpumask
>   * @mask2: the second input cpumask
>   *
> @@ -941,7 +944,7 @@ bool zalloc_cpumask_var_node(cpumask_var_t *mask, gfp_t flags, int node)
>  /**
>   * alloc_cpumask_var - allocate a struct cpumask
>   * @mask: pointer to cpumask_var_t where the cpumask is returned
> - * @flags: GFP_ flags
> + * @flags: %GFP_ flags
>   *
>   * Only defined when CONFIG_CPUMASK_OFFSTACK=y, otherwise is
>   * a nop returning a constant 1 (in <linux/cpumask.h>).
> -- 
> 2.31.1.272.g89b43f80a514

