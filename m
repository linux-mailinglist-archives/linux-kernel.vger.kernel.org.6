Return-Path: <linux-kernel+bounces-207535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BC3901892
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 00:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAB231F21248
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 22:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689944C627;
	Sun,  9 Jun 2024 22:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="sENSOwL+"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB09E208CB
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 22:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717973725; cv=none; b=dQDQr5CbF1D9GIIMY2P97pKdjELWobWFpNcnyDCupGH4Q007YetmB23bnCo/RMq2VyfKJYeyDHmSgeowBUeSzuCtaaSIpkVo6w1r5fdnFTcwv6tIqbPmi+4jCaAYYpI4uI90XEPPpgdJR5NSp02ZH7bkaAsBJfT+15M78pE/Te4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717973725; c=relaxed/simple;
	bh=ehpmDSbl4lMpkp6LjsltKUEYdBpWLpnkrfwilgTcaZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PG576C3zfvQ1HodKJ62DjFRvYPO5Gz6Wyw+89INh9Jgyjm8T/aO40YnLeX1Drx4Ai9l2+VflwGIsN7QQFPb0A2vzrOnWEZLfvkoedRyFWAFD6nx9EQMsmD43X7Y+cr7ESCg7G+7LlOZ++lD6EfKxQO41Y01a7KLhhmQ7VvOgInE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=sENSOwL+; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-421820fc26dso4643525e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 15:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1717973722; x=1718578522; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rU8mmOTJ5SUXajvdC/Zl4SFrSmsJUmbhkZaZ5sER8f4=;
        b=sENSOwL+l7rsrSiG2nrniqKBvWi0Hpc8tVPwsiFZyJbuh0aIcQaDDqx+s9JBsSIRgg
         rcEfYsO9En0U4ZHsxPNUNnjZ5XC32Vr+Sybqv5bRvbkV9e0Pd6sQ4Jxuzogvg2roRd37
         +E+pbIMctyFo+TtgY98mSdyUF1klpURTU3focIOopXRMXOApBbsNfT43JWQd0kzfmAcO
         hRLtrR4r8km6e/URbcnKeIWE2QDTPxS6DBYu9tHw4NTWO1XBueGrek1HFwkHEQV2npqt
         /tsH88qeuhyn1jyNJQ19e2DGytgiJmBDQXwVG6sxVgUzi5x+ZLn8aXHRzSZgHPlcHdDl
         vUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717973722; x=1718578522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rU8mmOTJ5SUXajvdC/Zl4SFrSmsJUmbhkZaZ5sER8f4=;
        b=jkznP5FPX0sU0VVkf3nKDlSttUJyFw4r3farVMEYTt2MB65wdb47F8Dcvy/c+WG87z
         +7QcjX5M6yejm0ixyd2n+KsX4wjLNDFzMranGVIeoYkgwbR5CcyRzkbHA0ScOA6rv1h9
         Youxgun6jG9xalgwvydE+DUO4w6MhOiuF1WAJRdFIRphiUY2ZbMEHwcbMFn0mLQcdjIe
         lYDjJm1tA8QVfIhpO6otGAG8tkUHskOJOmpcvOzzh/ZaAMAR+2xWBDawPzpdIsjDxoZw
         m7s1k5sYTGCqNvZRBXC2FOg7Zv/BB/zQyHoj+k5l22tVdwWi2zo5UThut+sd4KTDbHgG
         R/4w==
X-Forwarded-Encrypted: i=1; AJvYcCWaXdYnskVQJmcRzhUNdgswllpXRV2qt+KCVFb3OJz8zF9QysWOaZ8Ycfb/FxE3Uv7Q6tMj5R060P91knOjjguJyjDT+LYddvv5zH3w
X-Gm-Message-State: AOJu0YzNJ4yHm9rRwp4svi4N67TB+hwWp0TauYIdGs20NkwlDlCWAJiH
	bwpGYI2uXQZU+RRMKI1T+ZzwI7pLAJbGdese7w92R6/QcVH3O18HOfcx6Z5saRU=
X-Google-Smtp-Source: AGHT+IHts2gnLFQmIhTYJn/kx65GoJaltqUIGCBmLkEcBMJkTXLvnjNmHOqAGVSL5m2HLy9mPyZkNA==
X-Received: by 2002:a05:600c:3aca:b0:421:b47d:4e9d with SMTP id 5b1f17b1804b1-421b47d4eaemr11187575e9.40.1717973722153;
        Sun, 09 Jun 2024 15:55:22 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421580fe37csm157828705e9.3.2024.06.09.15.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 15:55:21 -0700 (PDT)
Date: Sun, 9 Jun 2024 23:55:20 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: vincent.guittot@linaro.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, vincent.donnefort@arm.com,
	ke.wang@unisoc.com, xuewen.yan94@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Prevent cpu_busy_time from exceeding
 actual_cpu_capacity
Message-ID: <20240609225520.6gnmx2wjhxghcxfo@airbuntu>
References: <20240606070645.3295-1-xuewen.yan@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240606070645.3295-1-xuewen.yan@unisoc.com>

On 06/06/24 15:06, Xuewen Yan wrote:
> Because the effective_cpu_util() would return a util which
> maybe bigger than the actual_cpu_capacity, this could cause
> the pd_busy_time calculation errors.
> So clamp the cpu_busy_time with the eenv->cpu_cap, which is
> the actual_cpu_capacity.

I actually think capping by pd_cap is something we should remove. Saturated
systems aren't calculated properly especially when uclamp_max is used.

But this might a bigger change and out of scope of what you're proposing..

Did this 'wrong' calculation cause an actual problem for task placement?
I assume the pd looked 'busier' because some CPUs were too busy.

Was the system in overutilzied state? Usually if one CPU is that busy
overutilized should be set and we'd skip EAS - unless uclamp_max was used.

> 
> Fixes: 3e8c6c9aac42 ("sched/fair: Remove task_util from effective utilization in feec()")
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>  kernel/sched/fair.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8a5b1ae0aa55..8939d725023a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7870,7 +7870,9 @@ static inline void eenv_pd_busy_time(struct energy_env *eenv,
>  	for_each_cpu(cpu, pd_cpus) {
>  		unsigned long util = cpu_util(cpu, p, -1, 0);
>  
> -		busy_time += effective_cpu_util(cpu, util, NULL, NULL);
> +		util = effective_cpu_util(cpu, util, NULL, NULL);
> +		util = min(eenv->cpu_cap, util);
> +		busy_time += util;
>  	}
>  
>  	eenv->pd_busy_time = min(eenv->pd_cap, busy_time);
> -- 
> 2.25.1
> 

