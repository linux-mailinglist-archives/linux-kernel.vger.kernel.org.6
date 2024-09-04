Return-Path: <linux-kernel+bounces-315985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD9B96C979
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 23:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89343281A6A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 21:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A374414D290;
	Wed,  4 Sep 2024 21:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXREPvFg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF5447F4D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 21:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725484700; cv=none; b=qqPpXNI4YgzkZVMreU4WBn5ICgg3RH1U/+xoFxwScHXdBU/oKQIXBW0jMG7xFD03zoSb2cTv7BUhlsAt4QQr23xIb8idMR9YVhj62UfKAnW1fvQ8jqmkJmcLmYgBL4RV+wvT7woSYLtIcDSD8LstD/Ti++dVkGcKko1eeTSgzYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725484700; c=relaxed/simple;
	bh=WdVavWvCcaDT0xnVmcrUlqUm2Tx6+1qyqvxjnIpjqhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODUf5mfG7D3AvTKaUba/RQJ/3RKFKks+b7hIcp+0tXgqJ4jolbygAkkhQKqdIWjflLwxOotIiTNzLL/CK3c21cafcdz9O1CVr92XVFgIsOQimUnrmO/G78Cke38DiD6g1U74v6hfWkdy6dRp+bgPMOPepJ3V3cw092uUHhRhDUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXREPvFg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A3EC4CEC2;
	Wed,  4 Sep 2024 21:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725484699;
	bh=WdVavWvCcaDT0xnVmcrUlqUm2Tx6+1qyqvxjnIpjqhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DXREPvFg0K7ztkLPwubRj9O2cwzthjQ5G49/NUvL7AH1rP86/Q8Zlgb9R2uwCFlLw
	 /POmeR9uC20rLy0LHdA3Z7ba8ndTfBpUoSscSHsBo3GXX/3l5kddIqFSZgK4j2QGvh
	 0hDWEUpkL20XTRt3pdhj4KbumvUM5KE3QGph+JMjrhDNipLgGYbBCzM25Yca30srCB
	 yMrncTAqQtyyD6YAX3FUcDVs7DzV7OVrF5BbTGx9i6F5ffh7K1zLMs4iqA90Nxl78I
	 Jh0oBsGDbtUQUIsZNJPtAFVF1CvPkSqEOzJAgB9JjdzV/kikUiWrG0rzxbdZycoXMM
	 JvjDpTNPKfoFA==
Date: Wed, 4 Sep 2024 23:18:16 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v3 2/2] sched/isolation: Consolidate housekeeping
 cpumasks that are always identical
Message-ID: <ZtjOmPV0V7jbYqfO@pavilion.home>
References: <20240904183650.1053708-1-longman@redhat.com>
 <20240904183650.1053708-3-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240904183650.1053708-3-longman@redhat.com>

Le Wed, Sep 04, 2024 at 02:36:50PM -0400, Waiman Long a écrit :
> The housekeeping cpumasks are only set by two boot commandline
> parameters: "nohz_full" and "isolcpus". When there is more than one of
> "nohz_full" or "isolcpus", the extra ones must have the same CPU list
> or the setup will fail partially.
> 
> The HK_TYPE_TICK, HK_TYPE_DOMAIN and HK_TYPE_MANAGED_IRQ types are
> settable by "isolcpus" and they can be set individually. The other
> housekeeping types are all set by "nohz_full" without a way to set them
> individually. So they all have identical cpumasks.

And HK_TYPE_TICK is part of them, so it should become HK_TYPE_KERNEL_NOISE.

> 
> There is actually no point in having different cpumasks for these
> "nohz_full" only housekeeping types. Consolidate these types to use the
> same cpumask by aliasing them to the same value. If there is a need to
> set any of them independently in the future, we can break them out to
> their own cpumasks again.
> 
> With this change, the number of cpumasks in the housekeeping structure
> drops from 9 to 4. There is no other functional change.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  include/linux/sched/isolation.h | 18 ++++++++++++------
>  kernel/sched/isolation.c        |  9 ++-------
>  2 files changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index 499d5e480882..e2c42172de82 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -7,15 +7,21 @@
>  #include <linux/tick.h>
>  
>  enum hk_type {
> -	HK_TYPE_TIMER,
> -	HK_TYPE_RCU,
> -	HK_TYPE_MISC,
>  	HK_TYPE_TICK,
>  	HK_TYPE_DOMAIN,
> -	HK_TYPE_WQ,
>  	HK_TYPE_MANAGED_IRQ,
> -	HK_TYPE_KTHREAD,
> -	HK_TYPE_MAX
> +	HK_TYPE_KERNEL_NOISE,
> +	HK_TYPE_MAX,
> +
> +	/*
> +	 * The following housekeeping types are only set by the nohz_full
> +	 * boot commandline option. So they can share the same value.
> +	 */
> +	HK_TYPE_TIMER   = HK_TYPE_KERNEL_NOISE,
> +	HK_TYPE_RCU     = HK_TYPE_KERNEL_NOISE,
> +	HK_TYPE_MISC    = HK_TYPE_KERNEL_NOISE,
> +	HK_TYPE_WQ      = HK_TYPE_KERNEL_NOISE,
> +	HK_TYPE_KTHREAD = HK_TYPE_KERNEL_NOISE

Why not removing them entirely and only keep HK_TYPE_KERNEL_NOISE ?

Thanks.

>  };
>  
>  #ifdef CONFIG_CPU_ISOLATION
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 5345e11f3d44..61d0f97341c3 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -9,14 +9,10 @@
>   */
>  
>  enum hk_flags {
> -	HK_FLAG_TIMER		= BIT(HK_TYPE_TIMER),
> -	HK_FLAG_RCU		= BIT(HK_TYPE_RCU),
> -	HK_FLAG_MISC		= BIT(HK_TYPE_MISC),
>  	HK_FLAG_TICK		= BIT(HK_TYPE_TICK),
>  	HK_FLAG_DOMAIN		= BIT(HK_TYPE_DOMAIN),
> -	HK_FLAG_WQ		= BIT(HK_TYPE_WQ),
>  	HK_FLAG_MANAGED_IRQ	= BIT(HK_TYPE_MANAGED_IRQ),
> -	HK_FLAG_KTHREAD		= BIT(HK_TYPE_KTHREAD),
> +	HK_FLAG_KERNEL_NOISE	= BIT(HK_TYPE_KERNEL_NOISE),
>  };
>  
>  DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
> @@ -194,8 +190,7 @@ static int __init housekeeping_nohz_full_setup(char *str)
>  {
>  	unsigned long flags;
>  
> -	flags = HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER | HK_FLAG_RCU |
> -		HK_FLAG_MISC | HK_FLAG_KTHREAD;
> +	flags = HK_FLAG_TICK | HK_FLAG_KERNEL_NOISE;
>  
>  	return housekeeping_setup(str, flags);
>  }
> -- 
> 2.43.5
> 

