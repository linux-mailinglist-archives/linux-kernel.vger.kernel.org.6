Return-Path: <linux-kernel+bounces-536010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B84A47A71
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC42C3B1412
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF31225A29;
	Thu, 27 Feb 2025 10:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dvDVnCT8"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A6B21ABB4
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 10:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740652679; cv=none; b=U/Hj5v0qpAJRaUY1VbAXHjvYfMPpkFgky+H7KfnFUnR4hT7Qz55Fbajlcvl5ga1bp5MJsA+CBwjQCr/G/JiZqnfj4jndFa+K7UpuOWGEcHFTT7jZj75GFQKpFVloD7ctOwetAOTzMxBskrixOo9MAY/Ysipv8mc/xqeDIyGY9Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740652679; c=relaxed/simple;
	bh=Txiv0GNTP8DGlYvTjBfM0J81bv9A0WhZ76PlMqt/6+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KLX5Fk0Oq/9Jl8YIgoLHrCyfUqt7kSQZ3j+VXkstggGFXZ52aCVjVAAg1WrH/KGEi4p6zljyF5k6Tx5GBVBFjfhaTQNJW+KMuZjrTkEyB4VgXaEeWkOqm9AkN5ueG6n8VSb5vQ7p8ViWGQsUxYPviRGrsE0rol24VZkq6cVFCE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dvDVnCT8; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fe9596a582so194476a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 02:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740652677; x=1741257477; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DV/4+EIKBxHU9rDR8HjaAlgwx72Pm8lEHt843SwpNpU=;
        b=dvDVnCT8/LfSjdZINBh31asLOi1pKIpKPfFRXP0L5RJ0ifD3b1RorjVr+4WDv0BPeR
         pZvUFZO4LaLad+igGoWbL07yhJOQ+bucwyE8ihUEpjiIX9LahU1ePrZV088ZUrNO13nS
         U2uOBaHtqsI8G9AgGho+RDYZzQwwaic6TsHgikfjPN74soPu+k49cbilKHNR4OcmUZRw
         59abPwYOmy4JZdyBsFzz73ACip2TwK8z9nzxRfANsVsuiFvV40sdNpKA99iH8Iq6zQJW
         uoHjQHjsSuPkLmIL7P53xLVmU6BVbjNu9GfA3WVUEkSe77w8amVgjIa+LCr3eVLnphHY
         ZZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740652677; x=1741257477;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DV/4+EIKBxHU9rDR8HjaAlgwx72Pm8lEHt843SwpNpU=;
        b=nRZe4i+XfRXT937ICNzPSeDj+OmlLjyzo6AIIuFhLL3s+69u1Nid/LDr7xcFQpBJqv
         2CLwnLdCO+ffIisiBAQCjdxRQnzWKse7INfyiI0r5Qfe3i+HMcDfGdzmsquaIqiCnnY6
         9/Y60gbm/NXTQ1c+a3dWeVqdS7T9OzcFUKy/t4XEi0Lr73pFGTRpeygfHo2B46I86bV/
         d+JNw2oe780qXe1w12SgsLAFTtGu3DLMeoRjVRO9F8bAIVTAjt+HWhYxfWtXx5G82Pp4
         WHju9cU54gLBlc39BlT0loFluIPJviDg0Cz0WhWPuoda6PlDpeKnfB8dVY9tyifWqpbQ
         Nn1g==
X-Forwarded-Encrypted: i=1; AJvYcCW2bkTLpjmuhcgfu/XoENuPiuteq5ZxxPKab8c4It7qSvSP6rYNNGzKFFERRFH9ABFphtuz2luppX3dGyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBYVg1lHZcOYGN8thAe3ys2gl/wRk0qK6aAyDqDRabIl89Bbwi
	2AJm2gStMgbq/NElLmz9KWalxWetIW50zeSVWMDxWoHLNZPAKAil0RB1qJ3Bi10=
X-Gm-Gg: ASbGncss/wAUmowRQ/YMFy2S4oeIAFtZztT+RYFLZRaq2xbGyCS1ITwrl+Ko2Khkc/v
	xkwqY1yqChrpuaSmaCQEC8c/+/bkx39uCKzCClkKX7LCUD/+i/jwizyRK0/ewBuuTc2t8sT4yTn
	GONpRB3NVs15FH1g5emAfj6KUEz3lK4FeGHJ7sXQa8BBKbGL/0TAk1Z7JUwbXtZ3YL6MSzTiaLY
	PMpJLaTT2nsbgOjbS53xAGdLGeQwmTCaO+4DnmWLbVcTeIqc+uV1bY9NbOhH6l0iiA6X+BCldt9
	M7RLlI0j9h+nfQ4xgS6GoKsbdHOS2TIit7zlXUesuj0aR0afeA==
X-Google-Smtp-Source: AGHT+IF3E5oQo5TmO1ZbvJta2mk5C4leDe1bchlXF4Xyba/pdZ/HKHpPajKrTqwrefFmXv5KCnX2hQ==
X-Received: by 2002:a17:90b:a11:b0:2fe:8e19:bcd7 with SMTP id 98e67ed59e1d1-2fe8e19c0c0mr2872297a91.5.1740652676848;
        Thu, 27 Feb 2025 02:37:56 -0800 (PST)
Received: from [10.254.225.63] ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2feb0057317sm543180a91.0.2025.02.27.02.37.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 02:37:55 -0800 (PST)
Message-ID: <15581a04-867f-4fc2-ab01-f4bd23e3c035@bytedance.com>
Date: Thu, 27 Feb 2025 18:37:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] cgroup/rstat: Fix forceidle time in cpu.stat
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Bitao Hu <yaoma@linux.alibaba.com>, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>, Yury Norov
 <yury.norov@gmail.com>, Chen Ridong <chenridong@huawei.com>
Cc: "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250209061322.15260-1-wuyun.abel@bytedance.com>
 <20250209061322.15260-2-wuyun.abel@bytedance.com>
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20250209061322.15260-2-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Tejun, can you please pick this fix? Since there is no objections..

Thanks!

On 2/9/25 2:13 PM, Abel Wu wrote:
> The commit b824766504e4 ("cgroup/rstat: add force idle show helper")
> retrieves forceidle_time outside cgroup_rstat_lock for non-root cgroups
> which can be potentially inconsistent with other stats.
> 
> Rather than reverting that commit, fix it in a way that retains the
> effort of cleaning up the ifdef-messes.
> 
> Fixes: b824766504e4 ("cgroup/rstat: add force idle show helper")
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> ---
>   kernel/cgroup/rstat.c | 29 +++++++++++++----------------
>   1 file changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index 5877974ece92..c2784c317cdd 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -613,36 +613,33 @@ static void cgroup_force_idle_show(struct seq_file *seq, struct cgroup_base_stat
>   void cgroup_base_stat_cputime_show(struct seq_file *seq)
>   {
>   	struct cgroup *cgrp = seq_css(seq)->cgroup;
> -	u64 usage, utime, stime, ntime;
> +	struct cgroup_base_stat bstat;
>   
>   	if (cgroup_parent(cgrp)) {
>   		cgroup_rstat_flush_hold(cgrp);
> -		usage = cgrp->bstat.cputime.sum_exec_runtime;
> +		bstat = cgrp->bstat;
>   		cputime_adjust(&cgrp->bstat.cputime, &cgrp->prev_cputime,
> -			       &utime, &stime);
> -		ntime = cgrp->bstat.ntime;
> +			       &bstat.cputime.utime, &bstat.cputime.stime);
>   		cgroup_rstat_flush_release(cgrp);
>   	} else {
> -		/* cgrp->bstat of root is not actually used, reuse it */
> -		root_cgroup_cputime(&cgrp->bstat);
> -		usage = cgrp->bstat.cputime.sum_exec_runtime;
> -		utime = cgrp->bstat.cputime.utime;
> -		stime = cgrp->bstat.cputime.stime;
> -		ntime = cgrp->bstat.ntime;
> +		root_cgroup_cputime(&bstat);
>   	}
>   
> -	do_div(usage, NSEC_PER_USEC);
> -	do_div(utime, NSEC_PER_USEC);
> -	do_div(stime, NSEC_PER_USEC);
> -	do_div(ntime, NSEC_PER_USEC);
> +	do_div(bstat.cputime.sum_exec_runtime, NSEC_PER_USEC);
> +	do_div(bstat.cputime.utime, NSEC_PER_USEC);
> +	do_div(bstat.cputime.stime, NSEC_PER_USEC);
> +	do_div(bstat.ntime, NSEC_PER_USEC);
>   
>   	seq_printf(seq, "usage_usec %llu\n"
>   			"user_usec %llu\n"
>   			"system_usec %llu\n"
>   			"nice_usec %llu\n",
> -			usage, utime, stime, ntime);
> +			bstat.cputime.sum_exec_runtime,
> +			bstat.cputime.utime,
> +			bstat.cputime.stime,
> +			bstat.ntime);
>   
> -	cgroup_force_idle_show(seq, &cgrp->bstat);
> +	cgroup_force_idle_show(seq, &bstat);
>   }
>   
>   /* Add bpf kfuncs for cgroup_rstat_updated() and cgroup_rstat_flush() */


