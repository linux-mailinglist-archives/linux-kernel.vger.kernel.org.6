Return-Path: <linux-kernel+bounces-179774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E14198C651F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 12:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10D291C21F61
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 10:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAC35FDA6;
	Wed, 15 May 2024 10:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="Nch468A7"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6455EE82
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 10:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715770083; cv=none; b=rM0Q51YNIlsTGcDCfDFCk7Vonmt5uAO817cFuN9EiQlRHTWK4eQCb3k0AtaDueW61hvW2ygyccNUmeIjfOkrZEdImlkIodSw7QVTtGDCBC8pSuyu20g8s8L1EpPcIWphylSTDo95UmUXP17Hxytb90M92B0Uk+QNxnKGSxN60yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715770083; c=relaxed/simple;
	bh=N2FKve7kzbtbwbW6zdoI5H92KUC45apZQxWi5AbAkWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJrQzva8IE0XrRj0Ok+flpnAmKXscW+xhIxtmPQJoFZptKgfQvOB7qAFQPuxXg5m0ZXhqGGsiLLE2ZQNtv+MP07T8XBk3YND7049sp6fKhNboy2U4HDyMNqWNiVH75+3swKFJk9l7R0Ztwhifso4+U6ZIFhhRDNYJG1BlhWBeyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=Nch468A7; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-34d7d04808bso5096961f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 03:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1715770080; x=1716374880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PXKzd9jKR474S4K4gbsTpTo7Rg9oLuIMxwGuMrzMWBo=;
        b=Nch468A7HY63kaezodmHR0N/PXs7SOe7HCk4XYxhQKjRopLlGSQEzoVrHB/RssHqGB
         nQH+xi6owP3UrZidQuzqE8ifbe6/PMYr8Mk2A5edalUBa6rHw0fNXGiVgN4FegeagS/9
         hdqbwJhV36uQodANVMp31Nh2DOvsIAZhkCMP5BBZ56RuQADYs3dK7uVnQ38d91JeZXrL
         ulThXdRnYExbM0c29W0criJO/zXcBL3j8RlH4so8GgCEU0174E/HGeSFrbifdA0Yv4UK
         ueCSpQPWnfmTWxXkw5PZ0AUIGz11uvOvgsXtiLUz+Bs90ZwDd3pXoD8i6AdcSzyJAZk9
         c76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715770080; x=1716374880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXKzd9jKR474S4K4gbsTpTo7Rg9oLuIMxwGuMrzMWBo=;
        b=l4DsV/4xzQzfNWAZ4+6kc/UAfbrRg9C5AdBkN2glxh3pTsDRcfQrLsh7nOLCmPQEXm
         ZDaPtnTanvB/YG0XfpQTGzT7FQ8gG9UXWFHg6kMwO8228SfYH1dHBIhIybrQq9vQV+Uo
         ERxQkv+4DVnkTbcaw37EpQJyvZ/RvgiHgLkTyGmZEaafjW545oCNLv447AwCGQzN3SDe
         p251j9rmmzLIq3n5lk+b3eQ5hO/mDr310Kpi9hiemfVaCOIgWz2DnBWSRBfOVjLKjj00
         CLsanrkfYGx3PevvlePejrC2UuS5XyLon29gIPn60ODSizVvxhcyb1wt0d7tprWTSj18
         Z14A==
X-Forwarded-Encrypted: i=1; AJvYcCX1K0S0ZB1THAbrB51VhjFZYZHZ+ywDq+1f11Q75kAVfELkljLWzitsgYozcjm4wBauvHYhxCb6lxeA+ildAoIFIEII0Lh1huDWZJny
X-Gm-Message-State: AOJu0Yx+ZFvMJ+AotvTuvXYwWOK8kPWIhORj2g5HyIEkR9lRCXlPFDhM
	wp3Qffu+aq+hge4FK7WxxZy1y7JL3+IuXl6ay5mrwNfDUXdh1w3VKEdKRY8Md4s=
X-Google-Smtp-Source: AGHT+IHLgs85cQJ0IYuNj1eOc0h3h7Cneoi38hQ/XXPZLKi77VyA6D1Fx7WdI66voGEy82wAV/o8TA==
X-Received: by 2002:adf:ff8a:0:b0:34d:963a:12cf with SMTP id ffacd0b85a97d-3504a955afcmr13042982f8f.50.1715770080568;
        Wed, 15 May 2024 03:48:00 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b895887sm16120381f8f.40.2024.05.15.03.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 03:48:00 -0700 (PDT)
Date: Wed, 15 May 2024 11:47:58 +0100
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
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	John Stultz <jstultz@google.com>
Subject: Re: [PATCH v3] sched: Consolidate cpufreq updates
Message-ID: <20240515104758.mogzntczla6xar6o@airbuntu>
References: <20240512190018.531820-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240512190018.531820-1-qyousef@layalina.io>

On 05/12/24 20:00, Qais Yousef wrote:

> +static __always_inline void
> +update_cpufreq_ctx_switch(struct rq *rq, struct task_struct *prev)
> +{
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

I just realized policy check will ignore PI-boosted tasks. But since we don't
have performance inheritance in rt_mutex() yet (have out-of-tree patches if
there's appetite for this), I don't think it will matter here as the decision
wouldn't change.

Once Proxy Execution lands, I think this should work as intended once we use
the correct wrapper to check the current scheduling context.

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
> +

