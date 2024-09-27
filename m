Return-Path: <linux-kernel+bounces-341391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D034F987F68
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791581F22272
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 07:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3401C18733B;
	Fri, 27 Sep 2024 07:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TRu/7hJw"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810A613A896
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 07:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727421997; cv=none; b=d08CjwcOz/Ipoii9aG4fF2OCb7Ep5079mpsy+3JMB8BMjx3OkP9J88U0ol1kZKJo0BwKUd2rNdcaIygh/2XPiAoirgvjsd5TSDDTHsieY8C7xdxVIblim2ScC0UwiDbwaj6q/SzqyR2tQbjeMi21BXuI72uehk5HOKHoAcIse4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727421997; c=relaxed/simple;
	bh=xMgAuIsRbpaGRuJllqDUgSrd+lucxNOpIKVPx5iakck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCdSbsvjd4Od6X5gMHyjhwA9dv7zweUv968k7y3yUGcfxEQMEhscQ6mmFSHWmMbr75MABby0lu8I/UeMMN85dyFkLtv6U+NUd8p0g87b/gHx/C4lmAaJn/LfDoDLJUvpKHY9huLW04DGyf5uAKe3FutV+Ujc4fW5Irv5Vqon8EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TRu/7hJw; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8d3cde1103so230061066b.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 00:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727421993; x=1728026793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=80ztDIsJWeriQoGVLSr3JhFbaWjjf3yBIgtVIEKSUh4=;
        b=TRu/7hJwrxUx3wOak5e/c2+oVr4Z3m54883QdSdso5qBSw31X+adwJtycElOCD4Q6v
         /1qASgjKoiXjg11Y+yuLtk8rSVHWLl3WoEfnZj6nZeJebmWRRulcTQmWM1eRomi08Kmy
         1piDNGEUFsS+fExW1zjOO9W/23CkRq9be2YQ/vcM8jh5Yr8mhvV83T81zii5ZfFc9bMX
         NLQQUe4OU/TNG0bkZH9KL0w9MhpzRvgZQfpew9K2P3lK8YoD8A2F+1ZjZ/P47mgtw1qG
         AnNbcwWYK9dbJJ/z3gOKJJRR5XKTiHIUpc24H6lhKhskcy08rrZufIJTKhTfutGgGiS5
         UxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727421993; x=1728026793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80ztDIsJWeriQoGVLSr3JhFbaWjjf3yBIgtVIEKSUh4=;
        b=pj8mQ9Uf4SYm11/3L3hLLno5o56M5NPyJ0hycVVRrafYMcQBUo1tVnTEMnPxDZ2BHH
         W6OrwS1IWnRogKacTZroB20qmqfQsREvqdzBADHAtWTMgyzc++fMa3682KxqdU3r1GPE
         vBtQWThhkrqhbRQ6pybQZiYu2I3jIzd18GxQN6U46PiVCceu/QPjr3R8c2CuFoxM7pqc
         Z2VPuk7JjqeOL/aMyVXEYiY8gu4c8iQbstcFBk68BvNEXJPeGoSvDBtezWgJtprfY2z/
         imr9QKv/3/8DM3Z/H9EsiAhDVBbQOATSOyXappNU6B0IfInwBaqb31+eFegTIx4yhuhZ
         D4Sg==
X-Gm-Message-State: AOJu0YzCHH6q1rJzuntAEwMgfQW6dXNXRIrUZ/StrDU3c7Yf+ZYO3Z3n
	YoCFyE4yrKj+UU8gnIRPU40d3n0Y/wNRk7n35AWwWPJmXkqXcXIfFI9wL/TNq04FZgO8WJbXL+l
	k
X-Google-Smtp-Source: AGHT+IE7+CblqEppxGApcOTVpZmHP9GLtTzDm9g1t7gy3vhONmLGIDrJpXglSfFblCwn/uYQ+Ow0Nw==
X-Received: by 2002:a17:906:c115:b0:a86:4649:28e6 with SMTP id a640c23a62f3a-a93c4a98d6amr167324466b.57.1727421993567;
        Fri, 27 Sep 2024 00:26:33 -0700 (PDT)
Received: from localhost (109-81-81-255.rct.o2.cz. [109.81.81.255])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27776efsm93534866b.30.2024.09.27.00.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 00:26:33 -0700 (PDT)
Date: Fri, 27 Sep 2024 09:26:32 +0200
From: Michal Hocko <mhocko@suse.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH 11/20] sched: Handle CPU isolation on last resort
 fallback rq selection
Message-ID: <ZvZeKBzOBbVyA-xL@tiehlicka>
References: <20240926224910.11106-1-frederic@kernel.org>
 <20240926224910.11106-12-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926224910.11106-12-frederic@kernel.org>

On Fri 27-09-24 00:48:59, Frederic Weisbecker wrote:
> When a kthread or any other task has an affinity mask that is fully
> offline or unallowed, the scheduler reaffines the task to all possible
> CPUs as a last resort.
> 
> This default decision doesn't mix up very well with nohz_full CPUs that
> are part of the possible cpumask but don't want to be disturbed by
> unbound kthreads or even detached pinned user tasks.
> 
> Make the fallback affinity setting aware of nohz_full. This applies to
> all architectures supporting nohz_full except arm32. However this
> architecture that overrides the task possible mask is unlikely to be
> willing to integrate new development.
> 
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Thanks, this makes sense to me. Up to scheduler maitainers whether this
makes sense in general though.

Thanks for looking into this Frederic!

> ---
>  kernel/sched/core.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 43e453ab7e20..d4b759c1cbf1 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3421,6 +3421,21 @@ void kick_process(struct task_struct *p)
>  }
>  EXPORT_SYMBOL_GPL(kick_process);
>  
> +static const struct cpumask *task_cpu_fallback_mask(struct task_struct *t)
> +{
> +	const struct cpumask *mask;
> +
> +	mask = task_cpu_possible_mask(p);
> +	/*
> +	 * Architectures that overrides the task possible mask
> +	 * must handle CPU isolation.
> +	 */
> +	if (mask != cpu_possible_mask)
> +		return mask;
> +	else
> +		return housekeeping_cpumask(HK_TYPE_TICK);
> +}
> +
>  /*
>   * ->cpus_ptr is protected by both rq->lock and p->pi_lock
>   *
> @@ -3489,7 +3504,7 @@ static int select_fallback_rq(int cpu, struct task_struct *p)
>  			 *
>  			 * More yuck to audit.
>  			 */
> -			do_set_cpus_allowed(p, task_cpu_possible_mask(p));
> +			do_set_cpus_allowed(p, task_cpu_fallback_mask(p));
>  			state = fail;
>  			break;
>  		case fail:
> -- 
> 2.46.0

-- 
Michal Hocko
SUSE Labs

