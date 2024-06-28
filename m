Return-Path: <linux-kernel+bounces-233236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644C091B49F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DAE3B219AD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 01:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A28BF9F5;
	Fri, 28 Jun 2024 01:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="bj4gppgC"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604F6D2E5
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 01:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719538118; cv=none; b=IPMN8rzSpQlvzJBxBhj6RTXndyM/+9AHKJOOtrzdOmXpbl67Hbv/UD/EEOG7mkEAp88GcJhYGZPdZ7sN1LYsCvPNuuyLqQCPkTvAtIr1xUkDE+Gnmne+zkhmU9P2M6NBH0sWok+a8B9bmbqmKZUP75HHOqbDiYJdok+/KFT+Ah4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719538118; c=relaxed/simple;
	bh=ibhzEgbbpa2M9jYV2mUm9cljoEPjam1yMoxE/3NQ4ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSyRYtLdA6zG2MZJug/FAy/Rv0ZLWEIGqn+6OQwfTqRox67f1SDp16lxFQNklHSP4gWXyqJkac8d972o19SdGCL8ambWaampbHf3Qcwwi3/Ohb5LCtmhgx95gTqWnqJcU/PYLmbZ8scDqXBUu150KvnGBsFPbhobNAvU0XGCf3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=bj4gppgC; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-425680b1d3aso377065e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 18:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1719538114; x=1720142914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RCQMjKKd/2ElvWUzZNqUT6vlKR7XsOfNqItFFkB2Rtc=;
        b=bj4gppgC1J+ZehczDu3dGTjbhhWih2ex5dpb22eEmBr2Xs08lQUxEB6TVQ89NJ2CPf
         zm5QMrIw2MQueW54cLj2r9IRvO+0ZQU+kl7RtdEdcMN0TfJwNwefmuQwV6TAH4IW4hov
         EDWGe68k0cWIZLlUsIgDRtZW5Aqo8khE5hzOAsICxhoHo4P6uHp68YnD6ZuabondNr7Y
         bvQaR9guuTJBVGT4kWfTb8BQf9pdDtYwp0eKtHdMNcXqMEyUtuYAFZSS1BetaLzH0ipI
         M6iT3NWYrgn3TwUgPpHtfgJqkvuu4VLXOBtNsod45twvIkE6BNzpVXQw0+uR36B8Sd/U
         gM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719538114; x=1720142914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCQMjKKd/2ElvWUzZNqUT6vlKR7XsOfNqItFFkB2Rtc=;
        b=uB5b5cks1/JLnQ0s0TDQq6Adz84G47XQg9tIxCxK9vDHz6QsYiTKjKwnDLP/YlgJDM
         cYBDSaPF8uhaDeZmybvh36BYp6IqADEx92P3vhn0YuhODg0FL5lHhS86qFm1DhpU7Qpb
         tKLmfJJQqVYoUxvAMojFZfqxsUqfH+XIxqXlFZVAgY8JIz0KxuiGXUv6hkSGKjkvlsyu
         TPyjsm+Kh49FUXAPTMcUeiY+1FKJaViqfVM6giMNGdeY2RVHT2h3BTVVuhcYj/0N47Ag
         ri6M2lm2gwIcVfe7TJoHNSxniXvqyxm8NN6od3HDnQukXnJjPCrS/Zbc1QArGJbYRX6O
         hSaw==
X-Forwarded-Encrypted: i=1; AJvYcCWEXKp64Ofh1lcCTh+2Mp01/Nr94QdMb2G18EzEdyAUo8QU0UHr88rtYR64NbJHyO0HgXAiuMSmxU5mzTRkuOLYKK1V8OXWd/emCmks
X-Gm-Message-State: AOJu0YxX8QN+uFzpmyc/d1O44LlnfjK8im7NL4s5BJUjqerZEcJIq0xM
	eeiJJq8gXjrKEhWgDPrBoBQWuRAUv7Ym4/P+PC1KYGkILIen/8o12MsCZPGgm5s=
X-Google-Smtp-Source: AGHT+IEPP2YvRqBWt2XUEvFMMBXjWtxlqBDmr5+SzrEiXI9KRGYGFW+eJxuKmHg5RwG7PzDlxjwg6g==
X-Received: by 2002:a05:600c:470d:b0:422:7eca:db41 with SMTP id 5b1f17b1804b1-4248cc18101mr118949255e9.2.1719538113479;
        Thu, 27 Jun 2024 18:28:33 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0c1611sm13316695e9.42.2024.06.27.18.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 18:28:33 -0700 (PDT)
Date: Fri, 28 Jun 2024 02:28:32 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: vincent.guittot@linaro.org, dietmar.eggemann@arm.com, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
	vschneid@redhat.com, christian.loehle@arm.com,
	vincent.donnefort@arm.com, ke.wang@unisoc.com, di.shen@unisoc.com,
	xuewen.yan94@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/2] sched/fair: Use actual_cpu_capacity everywhere in
 util_fits_cpu()
Message-ID: <20240628012832.37swdtxr4ds2kkp7@airbuntu>
References: <20240624082011.4990-1-xuewen.yan@unisoc.com>
 <20240624082011.4990-3-xuewen.yan@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240624082011.4990-3-xuewen.yan@unisoc.com>

On 06/24/24 16:20, Xuewen Yan wrote:
> Commit f1f8d0a22422 ("sched/cpufreq: Take cpufreq feedback into account")
> introduced get_actual_cpu_capacity(), and it had aggregated the
> different pressures applied on the capacity of CPUs.
> And in util_fits_cpu(), it would return true when uclamp_max
> is smaller than SCHED_CAPACITY_SCALE, althought the uclamp_max
> is bigger than actual_cpu_capacity.
> 
> So use actual_cpu_capacity everywhere in util_fits_cpu() to
> cover all cases.
> 
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>  kernel/sched/fair.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 5ca6396ef0b7..9c16ae192217 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4980,7 +4980,7 @@ static inline int util_fits_cpu(unsigned long util,
>  				int cpu)
>  {
>  	unsigned long capacity = capacity_of(cpu);
> -	unsigned long capacity_orig;
> +	unsigned long capacity_actual;
>  	bool fits, uclamp_max_fits;
>  
>  	/*
> @@ -4992,15 +4992,15 @@ static inline int util_fits_cpu(unsigned long util,
>  		return fits;
>  
>  	/*
> -	 * We must use arch_scale_cpu_capacity() for comparing against uclamp_min and
> +	 * We must use actual_cpu_capacity() for comparing against uclamp_min and
>  	 * uclamp_max. We only care about capacity pressure (by using
>  	 * capacity_of()) for comparing against the real util.
>  	 *
>  	 * If a task is boosted to 1024 for example, we don't want a tiny
>  	 * pressure to skew the check whether it fits a CPU or not.
>  	 *
> -	 * Similarly if a task is capped to arch_scale_cpu_capacity(little_cpu), it
> -	 * should fit a little cpu even if there's some pressure.
> +	 * Similarly if a task is capped to actual_cpu_capacity, it should fit
> +	 * the cpu even if there's some pressure.

This statement is not clear now. We need to be specific since
actual_cpu_capacity() includes thermal pressure and cpufreq limits.

/even if there's some pressure/even if there is non OPP based pressure ie: RT,
DL or irq/?

>  	 *
>  	 * Only exception is for HW or cpufreq pressure since it has a direct impact
>  	 * on available OPP of the system.
> @@ -5011,7 +5011,7 @@ static inline int util_fits_cpu(unsigned long util,
>  	 * For uclamp_max, we can tolerate a drop in performance level as the
>  	 * goal is to cap the task. So it's okay if it's getting less.
>  	 */
> -	capacity_orig = arch_scale_cpu_capacity(cpu);
> +	capacity_actual = get_actual_cpu_capacity(cpu);
>  
>  	/*
>  	 * We want to force a task to fit a cpu as implied by uclamp_max.
> @@ -5039,7 +5039,7 @@ static inline int util_fits_cpu(unsigned long util,
>  	 *     uclamp_max request.
>  	 *
>  	 *   which is what we're enforcing here. A task always fits if
> -	 *   uclamp_max <= capacity_orig. But when uclamp_max > capacity_orig,
> +	 *   uclamp_max <= capacity_actual. But when uclamp_max > capacity_actual,
>  	 *   the normal upmigration rules should withhold still.
>  	 *
>  	 *   Only exception is when we are on max capacity, then we need to be
> @@ -5050,8 +5050,8 @@ static inline int util_fits_cpu(unsigned long util,
>  	 *     2. The system is being saturated when we're operating near
>  	 *        max capacity, it doesn't make sense to block overutilized.
>  	 */
> -	uclamp_max_fits = (capacity_orig == SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE);
> -	uclamp_max_fits = !uclamp_max_fits && (uclamp_max <= capacity_orig);
> +	uclamp_max_fits = (capacity_actual == SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE);

We should use capacity_orig here. We are checking if the CPU is the max
capacity CPU.

> +	uclamp_max_fits = !uclamp_max_fits && (uclamp_max <= capacity_actual);
>  	fits = fits || uclamp_max_fits;
>  
>  	/*
> @@ -5086,8 +5086,7 @@ static inline int util_fits_cpu(unsigned long util,
>  	 * handle the case uclamp_min > uclamp_max.
>  	 */
>  	uclamp_min = min(uclamp_min, uclamp_max);
> -	if (fits && (util < uclamp_min) &&
> -	    (uclamp_min > get_actual_cpu_capacity(cpu)))
> +	if (fits && (util < uclamp_min) && (uclamp_min > capacity_actual))
>  		return -1;
>  
>  	return fits;
> -- 
> 2.25.1
> 

