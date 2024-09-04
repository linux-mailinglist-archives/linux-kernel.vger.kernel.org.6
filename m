Return-Path: <linux-kernel+bounces-315643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1B396C54C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDF211C22DFE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D181E4109;
	Wed,  4 Sep 2024 17:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fmVoKlQD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FE31E1324
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725470404; cv=none; b=Fn+Fm4rwpzzhwlWkie8Ab3tlM2lcMas2AvdgaQWLe4AcEARvKCJKKBlNdB9FNKkWvrgGZvl1rGUN25f+u4Id8dWhSkDQWNXlZ8Bk8gBFH2AzI1jZhF9It421gL/PML/IHW/jaJl8zB4QYNBSiSz/EJLshbN/H3zvbvXBw2BHN6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725470404; c=relaxed/simple;
	bh=wUVA50Tb6lpzAsD4VWX0+HP/wkFBtAppxC5yyzWCbgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ano9cc2NC1sGS1GZrSJqiDNtDZoFUEAqyLTEyBVpSUXQU/D9hcXC7m6dEIwncKB31oXBdPxBDddt8L1/jIIre3nS6UqI8KzCJmW9rP8O5mlfuiAH/dBGZpUW7AuZHhcWt/vNr2BchFTwgzAIDrsBYViMc7CL85yhiwXIzjMV0qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fmVoKlQD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725470402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tK5JXAJ5pwDODC67HF+vXeXJCd8VrcuchZz7A7Ee0j8=;
	b=fmVoKlQDi0L/nmNGnSRpKy5KOdTpBtF9P8bF3V5QEalKcKrjOE4HMhMvA9tZZlmqOqFG6x
	mAj8HyZMgRQhY2dGFuLi0Relr43B7N3ekHy7xhfaw9hCJnc1zI4SEfoPNoY8nT4Sr7C+vs
	zR9PHtMXPZOXfLZfisXup5/kYwy/sqo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-Qg2tXxCLMnug2l8Qcf8M3g-1; Wed,
 04 Sep 2024 13:20:00 -0400
X-MC-Unique: Qg2tXxCLMnug2l8Qcf8M3g-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2CBC11955D44;
	Wed,  4 Sep 2024 17:19:59 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.39.194.241])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 418361955F44;
	Wed,  4 Sep 2024 17:19:53 +0000 (UTC)
Date: Wed, 4 Sep 2024 13:19:49 -0400
From: Phil Auld <pauld@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] sched/isolation: Consolidate housekeeping
 cpumasks that are always identical
Message-ID: <20240904171949.GC136544@pauld.westford.csb>
References: <20240904171441.1048072-1-longman@redhat.com>
 <20240904171441.1048072-3-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904171441.1048072-3-longman@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Wed, Sep 04, 2024 at 01:14:41PM -0400 Waiman Long wrote:
> The housekeeping cpumasks are only set by two boot commandline
> parameters: "nohz_full" and "isolcpus". When there is more than one of
> "nohz_full" or "isolcpus", the extra ones must have the same CPU list
> or the setup will fail partially.
> 
> The HK_TYPE_TICK, HK_TYPE_DOMAIN and HK_TYPE_MANAGED_IRQ types are
> settable by "isolcpus" and they can be set individually. The other
> housekeeping types are all set by "nohz_full" without a way to set them
> individually. So they all have identical cpumasks.
> 
> There is actually no point in having different cpumasks for these
> "nohz_full" only housekeeping types. Consolidate these types to use the
> same cpumask by aliasing them to the same value. If there is a need to
> set any of them independently in the future, we can break them out to
> their own cpumasks again.
> 
> With this change, the number of cpumasks in the housekeeping structure
> drops from 9 to 4.
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
>  };
>  
>  #ifdef CONFIG_CPU_ISOLATION
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 5345e11f3d44..2b654272edcd 100644
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
> +	flags = HK_FLAG_KERNEL_NOISE;
>

This does not look equivalent. HK_FLAG_TICK seems to be lost?




Cheers,
Phil


>  	return housekeeping_setup(str, flags);
>  }
> -- 
> 2.43.5
> 

-- 


