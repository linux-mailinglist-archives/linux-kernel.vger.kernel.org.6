Return-Path: <linux-kernel+bounces-409784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F373F9C9184
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843561F23B4D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC188198A38;
	Thu, 14 Nov 2024 18:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yh6gkSeN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E0319597F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 18:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731608171; cv=none; b=lz4jK4Y6mnN/R9izcJVcwrysYdYCpE25YYd6/UwmqXvhbSd3FT3v3ypr4mFDcXicGVTrO6CrhMeznPHh/lXUQQ6v6y7G+jVjOAYhTXEXZRGG+Xzeu7gSybziZKLQ3eo0gG8+2pash5DNVi9/qBJZ2C6m75ei04XYB62IaYiS5dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731608171; c=relaxed/simple;
	bh=VctM/IPnH2yyy/sS2iJxA5jUc9OrwP0FIVpQMhQBgEc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=P6AEnVzlz8SDoqtzePWvTIB423rXHrJ1h5HxdJ9vjPuYFSDaw1kXdMe4mHMIxuMVesOSm3eqkzzXlFkJYyvQWMB1v3GI2JmCy1z25hLYgSbjK/GXrpYVF/0j2vrRyTPERvCoSFSEaBOGtFjC7cxsvq3CqGF19Mc0S9dGjTJw1/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yh6gkSeN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731608168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=seKR5b1uIR8hf1jRDmf9nGHCTSqoveoZspsqd8LxLYQ=;
	b=Yh6gkSeNTuAGSkrnjcJibJkfeelM1SkOLYzHhsErvi8Xum/KDzUoYX5AwMZ3MeQOeqgziL
	km+cQPj2VANueU4G3AmNtFnV80RU/kmxJT6UMHxaRQjJVvCmBQKm1eluaI27AcnRAojH6W
	mjnEfaOEcYaRM+Bd19pjzMjMicux6TI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-ZoxuS7gKOyypMmVYDQchXA-1; Thu, 14 Nov 2024 13:16:06 -0500
X-MC-Unique: ZoxuS7gKOyypMmVYDQchXA-1
X-Mimecast-MFC-AGG-ID: ZoxuS7gKOyypMmVYDQchXA
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-461011bd338so12177731cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 10:16:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731608166; x=1732212966;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=seKR5b1uIR8hf1jRDmf9nGHCTSqoveoZspsqd8LxLYQ=;
        b=e+sfpO7MaIJjkWQZNwJVp/T2l0rWhxoAn5+ke4DlnharIyiTcTYrCork4nzLhQ0OCB
         X2rBIHAb7QAXI3UEiOHVWF5K1qYrF0L91l8JiPJvf30ZWuWc9vpyOBtWH92QJJGe31Ac
         efmkUNodXkfUOAwCxx3oOws53fjEuYAbrRij2ZXQXjDjnkK/w3cRJkWfUtf9GT8GvUdq
         tYJAOzucwGHHrvHD2kPHZ5PLMj2hBYtTK3cXXxeJ1liM0+PnRPLWrzz3ET17QmJirHt0
         sxnrZoLfoY6fvWs7hP7ws9AgmjeCZOIgNn7yDK76YsFh6RAk0wpcKZMOSgWMOg1T3W63
         D4ww==
X-Forwarded-Encrypted: i=1; AJvYcCWUUGH6qx+yFXUGKgrnMyRspcrFkZpOlFYvzWqJjvK5MeLcqxcnRlxHoVGnQjl64NX3OXuFk0xOderzcIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvPdQ+XhCblvbkuZxc0hqVdc6LufbzP5L1QszVbibqEVNALNGP
	XVYG0qHx0fAe19m7eb4dXs9gAhVYdlCekF2zUYTNaa4vNy/J1wm5iG6u+m8btJBB+/8gaL1anO7
	WzaSAFxWRuIL1cisBIYfXfq2IuxUW2jhwwJ1upekIayATZ0CzO3iYqMofKFhWlQ==
X-Received: by 2002:a05:622a:5b86:b0:461:4372:f2cc with SMTP id d75a77b69052e-4634033c0f3mr127426141cf.46.1731608166144;
        Thu, 14 Nov 2024 10:16:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/DX0EahUDJNOxNsZyPhii4fQlkiDqgJ2dY0smClbKQDaRxRQBK/iqwH8c+tONfyisPsLXTQ==
X-Received: by 2002:a05:622a:5b86:b0:461:4372:f2cc with SMTP id d75a77b69052e-4634033c0f3mr127425741cf.46.1731608165736;
        Thu, 14 Nov 2024 10:16:05 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4635aa35dadsm8454501cf.52.2024.11.14.10.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 10:16:05 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <768d0363-d83e-42ac-aa44-18dbc6018a72@redhat.com>
Date: Thu, 14 Nov 2024 13:16:03 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Fix DEADLINE bandwidth accounting in root domain
 changes and hotplug
To: Juri Lelli <juri.lelli@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Phil Auld <pauld@redhat.com>
Cc: Qais Yousef <qyousef@layalina.io>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 Suleiman Souhlal <suleiman@google.com>, Aashish Sharma <shraash@google.com>,
 Shin Kawamura <kawasin@google.com>,
 Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20241114142810.794657-1-juri.lelli@redhat.com>
 <ZzYhyOQh3OAsrPo9@jlelli-thinkpadt14gen4.remote.csb>
Content-Language: en-US
In-Reply-To: <ZzYhyOQh3OAsrPo9@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/14/24 11:14 AM, Juri Lelli wrote:
> Thanks Waiman and Phil for the super quick review/test of this v2!
>
> On 14/11/24 14:28, Juri Lelli wrote:
>
> ...
>
>> In all honesty, I still see intermittent issues that seems to however be
>> related to the dance we do in sched_cpu_deactivate(), where we first
>> turn everything related to a cpu/rq off and revert that if
>> cpuset_cpu_inactive() reveals failing DEADLINE checks. But, since these
>> seem to be orthogonal to the original discussion we started from, I
>> wanted to send this out as an hopefully meaningful update/improvement
>> since yesterday. Will continue looking into this.
> About this that I mentioned, it looks like the below cures it (and
> hopefully doesn't regress wrt the other 2 patches).
>
> What do everybody think?
>
> ---
> Subject: [PATCH] sched/deadline: Check bandwidth overflow earlier for hotplug
>
> Currently we check for bandwidth overflow potentially due to hotplug
> operations at the end of sched_cpu_deactivate(), after the cpu going
> offline has already been removed from scheduling, active_mask, etc.
> This can create issues for DEADLINE tasks, as there is a substantial
> race window between the start of sched_cpu_deactivate() and the moment
> we possibly decide to roll-back the operation if dl_bw_deactivate()
> returns failure in cpuset_cpu_inactive(). An example is a throttled
> task that sees its replenishment timer firing while the cpu it was
> previously running on is considered offline, but before
> dl_bw_deactivate() had a chance to say no and roll-back happened.
>
> Fix this by directly calling dl_bw_deactivate() first thing in
> sched_cpu_deactivate() and do the required calculation in the former
> function considering the cpu passed as an argument as offline already.
>
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> ---
>   kernel/sched/core.c     |  9 +++++----
>   kernel/sched/deadline.c | 12 ++++++++++--
>   2 files changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index d1049e784510..43dfb3968eb8 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8057,10 +8057,6 @@ static void cpuset_cpu_active(void)
>   static int cpuset_cpu_inactive(unsigned int cpu)
>   {
>   	if (!cpuhp_tasks_frozen) {
> -		int ret = dl_bw_deactivate(cpu);
> -
> -		if (ret)
> -			return ret;
>   		cpuset_update_active_cpus();
>   	} else {
>   		num_cpus_frozen++;
> @@ -8128,6 +8124,11 @@ int sched_cpu_deactivate(unsigned int cpu)
>   	struct rq *rq = cpu_rq(cpu);
>   	int ret;
>   
> +	ret = dl_bw_deactivate(cpu);
> +
> +	if (ret)
> +		return ret;
> +
>   	/*
>   	 * Remove CPU from nohz.idle_cpus_mask to prevent participating in
>   	 * load balancing when not active
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 267ea8bacaf6..6e988d4cd787 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -3505,6 +3505,13 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
>   		}
>   		break;
>   	case dl_bw_req_deactivate:
> +		/*
> +		 * cpu is not off yet, but we need to do the math by
> +		 * considering it off already (i.e., what would happen if we
> +		 * turn cpu off?).
> +		 */
> +		cap -= arch_scale_cpu_capacity(cpu);
> +
>   		/*
>   		 * cpu is going offline and NORMAL tasks will be moved away
>   		 * from it. We can thus discount dl_server bandwidth
> @@ -3522,9 +3529,10 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
>   		if (dl_b->total_bw - fair_server_bw > 0) {
>   			/*
>   			 * Leaving at least one CPU for DEADLINE tasks seems a
> -			 * wise thing to do.
> +			 * wise thing to do. As said above, cpu is not offline
> +			 * yet, so account for that.
>   			 */
> -			if (dl_bw_cpus(cpu))
> +			if (dl_bw_cpus(cpu) - 1)
>   				overflow = __dl_overflow(dl_b, cap, fair_server_bw, 0);
>   			else
>   				overflow = 1;
>
I have applied this new patch to my test system and there was no 
regression to the test_cpuet_prs.sh test.

Tested-by: Waiman Long <longman@redhat.com>


