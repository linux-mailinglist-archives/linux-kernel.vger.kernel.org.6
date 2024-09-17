Return-Path: <linux-kernel+bounces-332036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C50297B48F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 22:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41DE6B214FD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 20:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECB018893F;
	Tue, 17 Sep 2024 20:24:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A9513777E
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 20:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726604667; cv=none; b=M5GmhonnJ7NnuxYyHCkcgpNyY5hYRORJ2g9BKtsRCYp7zBioNabdXoIIQoOMr6yxGrY8x+BZXeP7H/gVz6mW6UZa1t2zJE3ES8RI+QMfKmPhYbl7iwxNAksJWKAxiF37QvfS41dqSgHRnoJ19tDF6XwAx/XSPqywm40UThKMGwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726604667; c=relaxed/simple;
	bh=D5h2cUXL7xAUCAGbKP+qqFnHEWwFhB8GoTl3M6z26EI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RL6ckO8rP1u/jcQ7BrG0jB4SshBG4A2yjuQwwFMXEtOMczMbGXgqRmQcIh4pYMBlSArX8JtVWR2jkQqXCY4y+KPrUyZAGANjC2JoGORLzyODANG15jeVT+ecrKf+hzZ2J5rHk1khPz/mCtcoNrjjIq9kl8VEs/cgAUOw8DJLGHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 856ECFEC;
	Tue, 17 Sep 2024 13:24:53 -0700 (PDT)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D1513F64C;
	Tue, 17 Sep 2024 13:24:21 -0700 (PDT)
Message-ID: <64ed0fb8-12ea-4452-9ec2-7ad127b65529@arm.com>
Date: Tue, 17 Sep 2024 21:24:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/5] sched/fair: Use EAS also when overutilized
To: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, lukasz.luba@arm.com, rafael.j.wysocki@intel.com,
 linux-kernel@vger.kernel.org
Cc: qyousef@layalina.io, hongyan.xia2@arm.com
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
 <20240830130309.2141697-5-vincent.guittot@linaro.org>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20240830130309.2141697-5-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/30/24 14:03, Vincent Guittot wrote:
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
>  			new_cpu = find_energy_efficient_cpu(p, prev_cpu);
>  			if (new_cpu >= 0)
>  				return new_cpu;

Super quick testing on pixel6:
for i in $(seq 0 6); do /data/local/tmp/hackbench -l 500 -g 100 | grep Time; sleep 60; done                                     
with patch 5/5 only:
Time: 19.433
Time: 19.657
Time: 19.851
Time: 19.789
Time: 19.857
Time: 20.092
Time: 19.973

mainline:
Time: 18.836
Time: 18.718
Time: 18.781
Time: 19.015
Time: 19.061
Time: 18.950
Time: 19.166


The reason we didn't always have this enabled is the belief that
this costs us too much performance in scenarios we most need it
while at best making subpar EAS decisions anyway (in an
overutilized state).
I'd be open for questioning that, but why the change of mind?
And why is this necessary in your series if the EAS selection
isn't 'final' (until the next sleep) anymore (Patch 5/5)?

