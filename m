Return-Path: <linux-kernel+bounces-334509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A0B97D831
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 18:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65AEA284118
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 16:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A2B17E00A;
	Fri, 20 Sep 2024 16:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Frrhj+qd"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FCB22066
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 16:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726849061; cv=none; b=UMMMfzJcAjtRwtklL3huMquvsKtt7w98iZG2QKciXP7aQT8dnQRHWF5ukkt4Z4WN+u92voXWTX+YvM78AHBDM/9Nmg89mEFJ0yx8v1dgKDCCvwUO0fvbM0ZKJmUHvNIlJUpnua/66fYSCABm3uacG0fGY0feUUQYFYUMcbGcq1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726849061; c=relaxed/simple;
	bh=YvP56KG4Vmt9wLI7hvmo4nUfCflEK76/CA2EGsWFHjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccVoUTOZ3G566jBqAR8fVEcQ9lLEAyeTbovIUcwWbAiZqQRDvLA48cmHb53cLvVJgGKea+e6CLjT8lqmJ7S0PfCEFOG8gTJPN+ADoSxMhpyq8DO09ez8IcE116ncL/lsSQRW5DxvhIHK9CYxPVdSFRjpewguaSPVBW3ipiuf08k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Frrhj+qd; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c44e1cde53so2706300a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 09:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726849058; x=1727453858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sCXVb2W/9bKlbxyeDGGoYH3eTwWb5yy6lYNpEInm41U=;
        b=Frrhj+qdSOxpoeAGzXxYre8t65D/0fOyqpjwQ9Y+eQJzpPP5f5RtUQPL+E/9/D9j3T
         TavWZ6F+xg5vl9COPyiHkx3eNn6JWbxnRSxVor7v5syoTgYk0rlWgP28xnoX3vCmGFjX
         eGId0rvpvhQ8I5mEUC7uvgEumwBkxYfm/kbLNcZnpWfgOQcWmtPQ3Afo9XFc3S4sZitz
         k1qV02ZpsFjkTLFmDVmPvvlA0yiPunaN6nlQJWcnywNIH/afnkliPfxGnP2W2ucAhpvd
         LDHr/VZadag7DRkhV7mn5zmoFhp8cfQvlKX1qcDwLPgncyKSOoQVKM/gl5SHM2vyUaQw
         r2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726849058; x=1727453858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCXVb2W/9bKlbxyeDGGoYH3eTwWb5yy6lYNpEInm41U=;
        b=s10R76p+LvQ68CaFAhnQtVBRvdAi4diAWwzVNAmCAPMfLK+iP0iWpi3m0eD7ew/u0t
         QUM52w/R1Bd/l/bZu/munIYv+03YYV1OZZl9bIlyDZgECNYEkRYK1jbwmXdVl9fTXvNO
         2+VzGvnCnVak3O1pPuwUm/hYmazR2ZuL4rcQV8YvAaf4GmSttuSuF1U0YgP1cBuE1M/N
         yfsO6Lm78E3/HUqAgULdo7mgXDCX8rOci2XMbyYG42VqWvPEL5RimmxuZo6x0ZSiZAMp
         J0Yz9rA1mvE3+gR9BBOnfFBB4bNOxiuSboBma1jKrwYKXucPtH9gzi9zRkXJpJYZb+qD
         JbFw==
X-Forwarded-Encrypted: i=1; AJvYcCVlbhLsMYOiFiaBaabRwdi3lFmGN3E/tIKfJDq8U9gXHKzdLlBUOJbUXF1nU2wO37EZSNBay5NbSwcUoLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL0NmLwH3RPQuTvwy/SRK0WB/uv0w8XKDJQS49FTk11oUWxQeE
	Uu7USoYfy+IAfj6k7F3RROZKUkX1pGp93i+GdqK6phdcOnLgIeFlqcKWOQIHGUfx9DmUrkjyqWL
	QwsEl
X-Google-Smtp-Source: AGHT+IEhTqnijXnwAahxV4ruyarlL5DgMuOqi2lw4rYikZXR9sqFp2tAShp7h8JJ8+FN5eRIR1Gy7Q==
X-Received: by 2002:a50:c88d:0:b0:5c2:4dcc:b90a with SMTP id 4fb4d7f45d1cf-5c464a601bemr2348593a12.34.1726849055961;
        Fri, 20 Sep 2024 09:17:35 -0700 (PDT)
Received: from google.com (118.240.90.34.bc.googleusercontent.com. [34.90.240.118])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb52ff2sm7318741a12.24.2024.09.20.09.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 09:17:35 -0700 (PDT)
Date: Fri, 20 Sep 2024 16:17:32 +0000
From: Quentin Perret <qperret@google.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, lukasz.luba@arm.com,
	rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org,
	qyousef@layalina.io, hongyan.xia2@arm.com
Subject: Re: [RFC PATCH 4/5] sched/fair: Use EAS also when overutilized
Message-ID: <Zu2gHOv7mqArWXLZ@google.com>
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
 <20240830130309.2141697-5-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830130309.2141697-5-vincent.guittot@linaro.org>

Hi Vincent,

On Friday 30 Aug 2024 at 15:03:08 (+0200), Vincent Guittot wrote:
> Keep looking for an energy efficient CPU even when the system is
> overutilized and use the CPU returned by feec() if it has been able to find
> one. Otherwise fallback to the default performance and spread mode of the
> scheduler.
> A system can become overutilized for a short time when workers of a
> workqueue wake up for a short background work like vmstat update.
> Continuing to look for a energy efficient CPU will prevent to break the
> power packing of tasks.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 2273eecf6086..e46af2416159 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8505,7 +8505,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>  		    cpumask_test_cpu(cpu, p->cpus_ptr))
>  			return cpu;
>  
> -		if (!is_rd_overutilized(this_rq()->rd)) {
> +		if (sched_energy_enabled()) {

As mentioned during LPC, when there is no idle time on a CPU, the
utilization value of the tasks running on it is no longer a good
approximation for how much the tasks want, it becomes an image of how
much CPU time they were given. That is particularly problematic in the
co-scheduling case, but not just.

IOW, when we're OU, the util values are bogus, so using feec() is frankly
wrong IMO. If we don't have a good idea of how long tasks want to run,
the EM just can't help us with anything so we should stay away from it.

I understand how just plain bailing out as we do today is sub-optimal,
but whatever we do to improve on that can't be doing utilization-based
task placement.

Have you considered making the default (non-EAS) wake-up path a little
more reluctant to migrations when EAS is enabled? That should allow us
to maintain a somewhat stable task placement when OU is only transient
(e.g. due to misfit), but without using util values when we really
shouldn't.

Thoughts?

Thanks,
Quentin

>  			new_cpu = find_energy_efficient_cpu(p, prev_cpu);
>  			if (new_cpu >= 0)
>  				return new_cpu;
> -- 
> 2.34.1
> 
> 

