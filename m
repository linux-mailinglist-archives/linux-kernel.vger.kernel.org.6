Return-Path: <linux-kernel+bounces-437406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F869E92D4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 108081885168
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1262236F4;
	Mon,  9 Dec 2024 11:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G/2b1eyh"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA11D2236E5
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 11:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733745146; cv=none; b=E0cKXTFPHdJ7pfxwe8U6+/T/d4K+mFF5Q2WATFORaWHZUt310rJympka8nMDSmzrKP7lp0OOE63d4k9RB7OIj2FflrqovipUrrbfdh8QfDDdYkNJK4bGD5YbXriRkfgv5L3DZadB1HIL8d5T4P9vs+DL5aidRrCVJrhuSpBco30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733745146; c=relaxed/simple;
	bh=6WZDl0c6GbDd5aykjawOGGO2/zVRZyLqHPOtT+BaZcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlWIe0RWnB7ouFMdaEhS/5V2zfDqknUHxUqYkIZkDPcpGLnRmvRXQKszPBZ+ym4p8UOySOO2GlpU1bCEV9JSWmoR42T24Bw7I34Kr+TrNm6PU48+LYgijXMbpxOkfgKLXcNhs8ytlb7dkC2Z5PfeuOkxy96BFT4sEvains34um4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=G/2b1eyh; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EjDEXiaLNizBNiZ1SpRbwrXGkrjI3/tcSqfmslFzdQ0=; b=G/2b1eyh3XfgMaPQDRR6jeG3Km
	KT315tDF1y/MdEN6dr1MContKCGegBWdJhUHOmlTYOTOQ9usu9XK0czFsOBJzaZXhRoJwMk+mpWHb
	+w2hHAuN77UHpr+JjAFyS+fmPQBD2inLZ6E1NXd+/zrXRNmylWICdy2vXFFAjcgfsx3jmc5nZipWV
	cyp+79vid9llBEPfkgaZSvihPaSGdKrePQlfALOJo/rMvchh8rWEMZShA6AS7SCiYenur44mg2+aM
	YcMDtZvvizdY3yD+QqIRls8R0aelzUkkvl9HLv4+pV8/CSaQWxMLepdhC77EMnSTVhQEcaFdPUH04
	1zAjHI5Q==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tKcJK-00000003X1s-0FPE;
	Mon, 09 Dec 2024 11:52:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 679933003FF; Mon,  9 Dec 2024 12:52:21 +0100 (CET)
Date: Mon, 9 Dec 2024 12:52:21 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] fault-inject: use prandom where cryptographically secure
 randomness is not needed
Message-ID: <20241209115221.GO21636@noisy.programming.kicks-ass.net>
References: <20241208142415.205960-1-akinobu.mita@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241208142415.205960-1-akinobu.mita@gmail.com>

On Sun, Dec 08, 2024 at 11:24:15PM +0900, Akinobu Mita wrote:
> Currently get_random*() is used to determine the probability of fault
> injection, but cryptographically secure random numbers are not required.
> 
> There is no big problem in using prandom instead of get_random*() to
> determine the probability of fault injection, and it also avoids acquiring
> a spinlock, which is unsafe in some contexts.
> 
> Link: https://lore.kernel.org/lkml/20241129120939.GG35539@noisy.programming.kicks-ass.net
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  lib/fault-inject.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/fault-inject.c b/lib/fault-inject.c
> index 52eb6ba29698..92a54c8a8380 100644
> --- a/lib/fault-inject.c
> +++ b/lib/fault-inject.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> -#include <linux/random.h>
> +#include <linux/prandom.h>
>  #include <linux/debugfs.h>
>  #include <linux/sched.h>
>  #include <linux/stat.h>
> @@ -12,6 +12,24 @@
>  #include <linux/stacktrace.h>
>  #include <linux/fault-inject.h>
>  
> +/*
> + * The should_fail() use prandom instead of the normal Linux RNG since they don't
> + * need cryptographically secure random numbers.
> + */
> +static DEFINE_PER_CPU(struct rnd_state, fault_rnd_state);
> +
> +static u32 fault_prandom_u32_below_100(void)
> +{
> +	struct rnd_state *state;
> +	u32 res;
> +
> +	state = &get_cpu_var(fault_rnd_state);
> +	res = prandom_u32_state(state);
> +	put_cpu_var(fault_rnd_state);
> +
> +	return res % 100;

This is a bit unfortunate, the remainder function is not uniform (for
non-powers-of-two). I mean, nobody cares, and certainly here it doesn't
matter, but *groan*.

The problem seems to be that this ->probability thing used throughout
this code seems to be a percentage, while typically the probability is
expressed as a real number between 0 and 1.

<rant> For reasons not understood by me, and probably related to education
systems, some people think percentages are 'special' and not just a
1/100 fraction. </rant>

I feel this code would be improved if instead of a percentage value, the
probability would be represented as a fixed point value 0<=p<=1 with a
power-of-two base.

Eg. attr->probability = 1024*probability/100;

> +}
> +
>  /*
>   * setup_fault_attr() is a helper function for various __setup handlers, so it
>   * returns 0 on error, because that is what __setup handlers do.
> @@ -31,6 +49,8 @@ int setup_fault_attr(struct fault_attr *attr, char *str)
>  		return 0;
>  	}
>  
> +	prandom_init_once(&fault_rnd_state);
> +
>  	attr->probability = probability;
>  	attr->interval = interval;
>  	atomic_set(&attr->times, times);
> @@ -146,7 +166,7 @@ bool should_fail_ex(struct fault_attr *attr, ssize_t size, int flags)
>  			return false;
>  	}
>  
> -	if (attr->probability <= get_random_u32_below(100))
> +	if (attr->probability <= fault_prandom_u32_below_100())
>  		return false;
>  
>  fail:
> @@ -219,6 +239,8 @@ struct dentry *fault_create_debugfs_attr(const char *name,
>  	if (IS_ERR(dir))
>  		return dir;
>  
> +	prandom_init_once(&fault_rnd_state);
> +
>  	debugfs_create_ul("probability", mode, dir, &attr->probability);
>  	debugfs_create_ul("interval", mode, dir, &attr->interval);
>  	debugfs_create_atomic_t("times", mode, dir, &attr->times);
> @@ -431,6 +453,8 @@ static const struct config_item_type fault_config_type = {
>  
>  void fault_config_init(struct fault_config *config, const char *name)
>  {
> +	prandom_init_once(&fault_rnd_state);
> +
>  	config_group_init_type_name(&config->group, name, &fault_config_type);
>  }
>  EXPORT_SYMBOL_GPL(fault_config_init);

Anyway, yes, this cures the random problem. Thanks!

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

