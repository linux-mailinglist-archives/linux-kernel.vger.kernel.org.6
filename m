Return-Path: <linux-kernel+bounces-198024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEA58D728D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 00:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DD4D1C20AE4
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 22:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25E21F5E6;
	Sat,  1 Jun 2024 22:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="bHaksFIh"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F75F17CD
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 22:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717281622; cv=none; b=hMtWKnEtD1Mo7/IZhbaUKruVhvhW801qrlkbEKdJcW4zdrGMmDRPGIQRpgQ1h8kfdvhu6k9ni+S5kyMYkqQAX6I5GtX9bcUDLIYpExO+3Q0xR7iM1hojQMuplwtnkG4DL4eQPI0Wx7yXH5Nxl2n1BGfM6qngLI143GhTsWtYwcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717281622; c=relaxed/simple;
	bh=W2C84SLg0Pn4h2sxtZ6Q8X6xsLLM2bE6McGd4h8wP2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMFZCfalMZYdv0pwxjft8Nt2Xk/5Z5efF+jQMcbDY0SVv/dwd1LHP63ifaBQtJCCQRGzc+3PicAOP2ECxLeqkRcBK9xOP6de96p2sacmbCFrj2/BnEH+CsJRGAwLhNbH+wM24nJttgO8Gd58zR8ugVAWLmBeTXOHO+5vBsUlyaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=bHaksFIh; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-421124a04d6so32474135e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 15:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1717281619; x=1717886419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DW54dtexIyCzuXyNF0cUY9kxjBpfAJ8MrU77GRtz9rI=;
        b=bHaksFIhBOO/HPJmsnNIokQtNY9rZa2xGu6cjkwPEIa/2M8CP74RsFmL80QOo2msAv
         IlCx58v3k2Q4dpvFGmUpj0mFKzrN9LCje+Y7zsstlvKHWH5jl6ATQiFSOXsiT4cCJJkO
         TNQoPHEd1OcWX9BGxkF+9kvBxWednhhT/010EhYG/LpV/Mq7ExN+bterbHDqmSyObUsk
         D609MRGO8vd2NyWWKicK7dme8RQCBnKiWrsYVlOQBd1zfgKNfopP9Nz/fbR+ch1PhXNQ
         Z6MZUoRmocwnlCD65yi1vhN8VjCczSb8dwG2M7XMWHPUeyEYXsByrq8OtRydlOsNAi+5
         DENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717281619; x=1717886419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DW54dtexIyCzuXyNF0cUY9kxjBpfAJ8MrU77GRtz9rI=;
        b=AkcTjiN3fxrfJKhlNX/IKksjVYkcRhuKqG1CRbrg5WrHtTFTce9OxCPG04v7X6sfzm
         KiybmLxrrdCtLVkFUqHh7/QVfPQzrY8zojEyudjUpNjmr5YPWFnLl7SEjYIUnvnXPhXi
         IOxY+UvaJzGor1sQXN0I8gX6WerQ2mJS8+8VNydlaMTjKJRdcktD3vpolBGGWR7UXSUk
         /yFUIeoH5V7+5/0dGsIJmYJAJtwuip0TppMumaLDE4Zb0LgmylyBFcaFIpi8ue4LzE9B
         VyvLIyLNl2gh7c9zcvVH+12NSSV+wHeUZA434OOsp+GZJUW+SLnRniZAruKy/+lw+9Aq
         zM1w==
X-Forwarded-Encrypted: i=1; AJvYcCV+u67DIchZUUCaQS8UK1svxHCoI42vkc/ZT6i23FhdZp702dm1ivOhZyXHhlgC7lumqCAOYlLeZ65d3bfewDRbVpdQ51v1WPKycXxG
X-Gm-Message-State: AOJu0YydQFea/vLJ8719bFhbXYnCDF7qZRX8yyJB3urVxvG9k/kqr9qq
	ANQH2FYqRN63hdx8r0EK+34WRKvho84PN0anFRKZgMhiAmTw/FsfsIBdoDDLZdk=
X-Google-Smtp-Source: AGHT+IH0tU6JP0VtcTkbX56KtUiGoj9Mxrg3pH2DYMlhPGEKUkeAZcSECAlOU3L0XP49igIoLrob/A==
X-Received: by 2002:a05:600c:5113:b0:420:1585:7a99 with SMTP id 5b1f17b1804b1-4212e0bda0fmr43418625e9.38.1717281618721;
        Sat, 01 Jun 2024 15:40:18 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42127069305sm95128755e9.22.2024.06.01.15.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 15:40:18 -0700 (PDT)
Date: Sat, 1 Jun 2024 23:40:17 +0100
From: Qais Yousef <qyousef@layalina.io>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Hongyan Xia <hongyan.xia2@arm.com>,
	John Stultz <jstultz@google.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] sched: Consolidate cpufreq updates
Message-ID: <20240601224017.qku2mhbaz4vsh3a3@airbuntu>
References: <20240530104653.1234004-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240530104653.1234004-1-qyousef@layalina.io>

On 05/30/24 11:46, Qais Yousef wrote:

> +static __always_inline void
> +__update_cpufreq_ctx_switch(struct rq *rq, struct task_struct *prev)
> +{

I found a problem here. We should check if prev was sugov task. I hit a
corner case where we were constantly switching between RT task and sugov.

	if (prev && prev->dl.flags & SCHED_FLAG_SUGOV) {
		/* Sugov just did an update, don't be too aggressive */
		return;
	}

> +#ifdef CONFIG_CPU_FREQ
> +	/*
> +	 * RT and DL should always send a freq update. But we can do some
> +	 * simple checks to avoid it when we know it's not necessary.
> +	 *
> +	 * iowait_boost will always trigger a freq update too.
> +	 *
> +	 * Fair tasks will only trigger an update if the root cfs_rq has
> +	 * decayed.
> +	 *
> +	 * Everything else should do nothing.
> +	 */
> +	switch (current->policy) {
> +	case SCHED_NORMAL:
> +	case SCHED_BATCH:
> +		if (unlikely(current->in_iowait)) {
> +			cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT | SCHED_CPUFREQ_FORCE_UPDATE);
> +			return;
> +		}
> +
> +#ifdef CONFIG_SMP
> +		if (unlikely(rq->cfs.decayed)) {
> +			rq->cfs.decayed = false;
> +			cpufreq_update_util(rq, 0);
> +			return;
> +		}
> +#endif
> +		return;
> +	case SCHED_FIFO:
> +	case SCHED_RR:
> +		if (prev && rt_policy(prev->policy)) {
> +#ifdef CONFIG_UCLAMP_TASK
> +			unsigned long curr_uclamp_min = uclamp_eff_value(current, UCLAMP_MIN);
> +			unsigned long prev_uclamp_min = uclamp_eff_value(prev, UCLAMP_MIN);
> +
> +			if (curr_uclamp_min == prev_uclamp_min)
> +#endif
> +				return;
> +		}
> +#ifdef CONFIG_SMP
> +		/* Stopper task masquerades as RT */
> +		if (unlikely(current->sched_class == &stop_sched_class))
> +			return;
> +#endif
> +		cpufreq_update_util(rq, SCHED_CPUFREQ_FORCE_UPDATE);
> +		return;
> +	case SCHED_DEADLINE:
> +		if (current->dl.flags & SCHED_FLAG_SUGOV) {
> +			/* Ignore sugov kthreads, they're responding to our requests */
> +			return;
> +		}
> +		cpufreq_update_util(rq, SCHED_CPUFREQ_FORCE_UPDATE);
> +		return;
> +	default:
> +		return;
> +	}
> +#endif
> +}

