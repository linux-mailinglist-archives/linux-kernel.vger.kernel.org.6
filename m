Return-Path: <linux-kernel+bounces-183448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE638C992C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 09:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A6551F21598
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 07:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F33182DB;
	Mon, 20 May 2024 07:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NzicRqtm"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092451BC4F
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 07:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716189121; cv=none; b=S4msKI2eRNg+6+i/lSHLbPYRRKtp6XvAlg7nU2quRUHT3ecaD78q/Hj5/wMpMUrXjr4YcZi9Q8Sn4FrOpbDQyHFUkDpCA/4kIasEzBmi13YVCkJjzA9t1OosEhaI6rXqjlDEVAnr/8Pd6GWNz7DlMacmQWKn+WIlWZe1Er9OaRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716189121; c=relaxed/simple;
	bh=quW73Dwdi12WfG3At2nCwuAVaKbL7l554/u5u007xYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0WX09TujXQLRKrhIG3/n0dTvJ+ABO2J4FopcJSiPyYkd2iAv/SFEFkAUeuwfDjYOb2S1zzVU0s1V3BKBWyIcit93iIl6TvPnJz7YaU5hFZMotMmQN9pL2waaNBINMbvAysMw8kKt8s90csuyRGUyZrZt4eSApCwYWbLxse394U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NzicRqtm; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-24c39cedc7bso105574fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 00:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716189119; x=1716793919; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MHRjk1UF5y6ZXolJPbrenklGO031NQi7q46Dk0j7hM4=;
        b=NzicRqtmrre+8Bi+vLep0NV+H+tdjDFEs3vnqZhaj2WciM48GL0Dp6A8wQdGV9SwsF
         g3zpi6UN8VCZmcuYF8nFSj4S1hwFlcAeUO/Pl/9PKoWuqf1dQz+7UT7n4TsuJZBHHXaF
         x8YCsYqoaTYvZecIcSFOhg0LIE5jGxdVnzfGNSc63nOs7uvAIpr3GN1QdgKrS7afVydH
         QWUkxTpNhisB73Aunz1Bm75TC6Xdk98J1tVvWjoc64kOOqNHZ8gEMeZ2mDHlFEgvdn72
         avTu4g9tJ6yObS8NWPQ8G4s3cwFQZ6vq2djD2WYNbwQEoDOJv3LASNPI2tUbBOxuYwy8
         VW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716189119; x=1716793919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHRjk1UF5y6ZXolJPbrenklGO031NQi7q46Dk0j7hM4=;
        b=XFXV8EjyEMvLoUXLLXewX4l+ILO4KTZM/S6DAspOqml6gxVtCKmFhcJXRl0uLpE/Ts
         9YBJ4dooe5t+o6rvn9j7ikIp6u/0FW/GFb29fd7i3Lwbdk0/YDXHmmI4ErtJbRvEUXDP
         Csnu0LAZRukD2pXyaM4vcxE2oo9V2EgAaTs1v9a5MUJu27h/dJiEYXHZfvy5yKaDwEan
         zbogk76P3mgOk6WHJeBhbAebPAeZ3xuNLHJj9r02q6Xn89SfSMWAIkCgxonv+UVKD7C1
         L2wuhTpUpDbMkx2ri7pSDaqV1t9e+9S+FEZZi3yiEkq5FjDjUhQKB/HK9rnwbyXJLgJy
         nARg==
X-Forwarded-Encrypted: i=1; AJvYcCXHJWsUXpJ4EbSjeGotTsn0vNGJdvqDGW+QLMjYLVBAKCJQ9BgYFs1DKmqCfNJgStz5r4ZDseBpxDlzwkLjCbMNcXS+PeLzUR6oqdK7
X-Gm-Message-State: AOJu0YxnuXlHDUA50jbI2IcTBzalL4S64FiB45PgmHGnZ91fDqbOiY5F
	bxZIWN71F3U0/MXjlB9YWn1njtfDKWy3tqn+1Kaa3kPJf1UAG2kGa1t6g78b/2w=
X-Google-Smtp-Source: AGHT+IEX1+Tc+YIv9rsF8PL7xmBz5GnyZpJw7hRZ+XdVJ40PqJQSws3qL/vUQk+4G5xYWMI7a2hpDw==
X-Received: by 2002:a05:6870:aa89:b0:239:7801:dbd0 with SMTP id 586e51a60fabf-24172e08c8emr32974507fac.47.1716189118484;
        Mon, 20 May 2024 00:11:58 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a665ccsm18518300b3a.23.2024.05.20.00.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 00:11:57 -0700 (PDT)
Date: Mon, 20 May 2024 12:41:55 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Fares Mehanna <faresx@amazon.de>
Cc: rkagan@amazon.de, "Rafael J. Wysocki" <rafael@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: fail to start a governor if limits weren't
 updated correctly
Message-ID: <20240520071155.lbphk4dqbhibogtj@vireshk-i7>
References: <20240430143923.40431-1-faresx@amazon.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430143923.40431-1-faresx@amazon.de>

On 30-04-24, 14:39, Fares Mehanna wrote:
> Current cpufreq governors are using `__cpufreq_driver_target()` in their
> `.limits()` functions to update the frequency. `__cpufreq_driver_target()`
> will eventually call `.target()` or `.target_index()` in the cpufreq driver
> to update the frequency.
> 
> `.target()`, `.target_index()` and `__cpufreq_driver_target()` may fail and
> all do return an error code, this error code is dropped by the governor and
> not propagated to the core.
> 
> This have the downside of accepting a new CPU governor even if it fails to
> set the wanted limits. This is misleading to the sysfs user, as setting the
> governor will be accepted but the governor itself is not functioning as
> expected. Especially with `performance` and `powersave` where they only
> target specific frequency during starting of the governor and stays the
> same during their lifetime.
> 
> This change will cause a failure to start the new governor if `.limits()`
> failed, propagating back to userspace if the change is driven by sysfs.
> 
> Signed-off-by: Fares Mehanna <faresx@amazon.de>
> ---
>  drivers/cpufreq/cpufreq.c             |  7 +++++--
>  drivers/cpufreq/cpufreq_governor.c    |  6 ++++--
>  drivers/cpufreq/cpufreq_governor.h    |  2 +-
>  drivers/cpufreq/cpufreq_performance.c |  4 ++--
>  drivers/cpufreq/cpufreq_powersave.c   |  4 ++--
>  drivers/cpufreq/cpufreq_userspace.c   | 16 +++++++++-------
>  include/linux/cpufreq.h               | 13 +++++++------
>  kernel/sched/cpufreq_schedutil.c      |  6 ++++--
>  8 files changed, 34 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 66e10a19d76a..5ac44a44d319 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2474,8 +2474,11 @@ int cpufreq_start_governor(struct cpufreq_policy *policy)
>  			return ret;
>  	}
>  
> -	if (policy->governor->limits)
> -		policy->governor->limits(policy);
> +	if (policy->governor->limits) {
> +		ret = policy->governor->limits(policy);
> +		if (ret)
> +			return ret;

You need to stop the governor here on failure as this function started it
successfully.

-- 
viresh

