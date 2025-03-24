Return-Path: <linux-kernel+bounces-574056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 465D9A6E00E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 484F63B2174
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416A62641C1;
	Mon, 24 Mar 2025 16:41:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F8F263F25
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 16:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742834515; cv=none; b=sex67GMNE0weJhvwxOIPGKlFxvHMDu/EeQ8XhhXTRjKa0Sb2W+8oK3vUakWk/3pPIKNeWsdh/lWQrTESHEptixLknsj14xN3tIi+OJWWujy4zdLA8C99/tFv9Qtaoz75yM7nTO7hg5Q8o3HTelU16Rq2uFEbVqAcqE3gCkodLYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742834515; c=relaxed/simple;
	bh=vaAoFB4c62lRNfCN9DTkU/aGYILAYpjuERsBbE4FR+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WxsyeTGmD9y5RgPOIz4gFiC111KbpT8bK8K2p2OxeQLKKIEBWtNkclF1la5ifu3+5DqDFdhrLcDgp3HTnLB8aRiikgz1+wttFRMYF/tMVWQ/RbaYo1pIGNjatguNgg+iThtNwLm8U76eQrDG7PyZGcm7a1eAzZgjeadOS24tZhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47DA116F3;
	Mon, 24 Mar 2025 09:41:59 -0700 (PDT)
Received: from [192.168.188.123] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5888D3F58B;
	Mon, 24 Mar 2025 09:41:49 -0700 (PDT)
Message-ID: <9f9d876b-ed06-4053-91f6-a323f47d6c4c@arm.com>
Date: Mon, 24 Mar 2025 16:41:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7 v5] sched/fair: Rework EAS to handle more cases
To: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, lukasz.luba@arm.com, rafael.j.wysocki@intel.com,
 pierre.gondois@arm.com, linux-kernel@vger.kernel.org
Cc: qyousef@layalina.io, hongyan.xia2@arm.com, luis.machado@arm.com,
 qperret@google.com
References: <20250302210539.1563190-1-vincent.guittot@linaro.org>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20250302210539.1563190-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/2/25 21:05, Vincent Guittot wrote:
> The current Energy Aware Scheduler has some known limitations which have
> became more and more visible with features like uclamp as an example. This
> serie tries to fix some of those issues:
> - tasks stacked on the same CPU of a PD
> - tasks stuck on the wrong CPU.
> 
> Patch 1 fixes the case where a CPU is wrongly classified as overloaded
> whereas it is capped to a lower compute capacity. This wrong classification
> can prevent periodic load balancer to select a group_misfit_task CPU
> because group_overloaded has higher priority.
> 
> Patch 2 creates a new EM interface that will be used by Patch 3
> 
> Patch 3 fixes the issue of tasks being stacked on same CPU of a PD whereas
> others might be a better choice. feec() looks for the CPU with the highest
> spare capacity in a PD assuming that it will be the best CPU from a energy
> efficiency PoV because it will require the smallest increase of OPP.
> This is often but not always true, this policy filters some others CPUs
> which would be as efficients because of using the same OPP but with less
> running tasks as an example.
> In fact, we only care about the cost of the new OPP that will be
> selected to handle the waking task. In many cases, several CPUs will end
> up selecting the same OPP and as a result having the same energy cost. In
> such cases, we can use other metrics to select the best CPU with the same
> energy cost. Patch 3 rework feec() to look 1st for the lowest cost in a PD
> and then the most performant CPU between CPUs. At now, this only tries to
> evenly spread the number of runnable tasks on CPUs but this can be
> improved with other metric like the sched slice duration in a follow up
> series.
> 
> perf sched pipe on a dragonboard rb5 has been used to compare the overhead
> of the new feec() vs current implementation.
> 
> 9 iterations of perf bench sched pipe -T -l 80000
>                 ops/sec  stdev 
> tip/sched/core  16634    (+/- 0.5%)
> + patches 1-3   17434    (+/- 1.2%)  +4.8%
> 
> 
> Patch 4 removed the now unused em_cpu_energy()
> 
> Patch 5 solves another problem with tasks being stuck on a CPU forever
> because it doesn't sleep anymore and as a result never wakeup and call
> feec(). Such task can be detected by comparing util_avg or runnable_avg
> with the compute capacity of the CPU. Once detected, we can call feec() to
> check if there is a better CPU for the stuck task. The call can be done in
> 2 places:
> - When the task is put back in the runnnable list after its running slice
>   with the balance callback mecanism similarly to the rt/dl push callback.
> - During cfs tick when there is only 1 running task stuck on the CPU in
>   which case the balance callback can't be used.
> 
> This push callback mecanism with the new feec() algorithm ensures that
> tasks always get a chance to migrate on the best suitable CPU and don't
> stay stuck on a CPU which is no more the most suitable one. As examples:
> - A task waking on a big CPU with a uclamp max preventing it to sleep and
>   wake up, can migrate on a smaller CPU once it's more power efficient.
> - The tasks are spread on CPUs in the PD when they target the same OPP.
> 
> Patch 6 adds task misfit migration case in the cfs tick and push callback
> mecanism to prevent waking up an idle cpu unnecessarily.
> 
> Patch 7 removes the need of testing uclamp_min in cpu_overutilized to
> trigger the active migration of a task on another CPU.
> 
> Compared to v4:
> - Fixed check_pushable_task for !SMP
> 
> Compared to v3:
> - Fixed the empty functions
> 
> Compared to v2:
> - Renamed the push and tick functions to ease understanding what they do.
>   Both are kept in the same patch as they solve the same problem.
> - Created some helper functions
> - Fixing some typos and comments
> - The task_stuck_on_cpu() condition remains unchanged. Pierre suggested to
>   take into account the min capacity of the CPU but the is not directly
>   available right now. It can trigger feec() when uclamp_max is very low
>   compare to the min capacity of the CPU but the feec() should keep 
>   returning the same CPU. This can be handled in a follow on patch
> 
> Compared to v1:
> - The call to feec() even when overutilized has been removed
> from this serie and will be adressed in a separate series. Only the case
> of uclamp_min has been kept as it is now handled by push callback and
> tick mecanism.
> - The push mecanism has been cleanup, fixed and simplified.
> 
> This series implements some of the topics discussed at OSPM [1]. Other
> topics will be part of an other serie
> 
> [1] https://youtu.be/PHEBAyxeM_M?si=ZApIOw3BS4SOLPwp
> 
> Vincent Guittot (7):
>   sched/fair: Filter false overloaded_group case for EAS
>   energy model: Add a get previous state function
>   sched/fair: Rework feec() to use cost instead of spare capacity
>   energy model: Remove unused em_cpu_energy()
>   sched/fair: Add push task mechanism for EAS
>   sched/fair: Add misfit case to push task mecanism for EAS
>   sched/fair: Update overutilized detection
> 
>  include/linux/energy_model.h | 111 ++----
>  kernel/sched/fair.c          | 721 ++++++++++++++++++++++++-----------
>  kernel/sched/sched.h         |   2 +
>  3 files changed, 518 insertions(+), 316 deletions(-)
> 

Hi Vincent,
I'm giving this another go of reviewing after our OSPM discussions.
One thing which bothered me in the past is that it's just a lot going
on in this series, almost rewriting all of the EAS code in fair.c ;)

For easier reviewing I suggest splitting the series:
1. sched/fair: Filter false overloaded_group case for EAS
(Or actually just get this merged, no need carrying this around, is there?)
2. Rework feec to use more factors than just max_spare_cap to improve
responsiveness / reduce load (Patches 2,3,4)
3. Add push mechanism and make use of it for misfit migration (Patches
5,6,7)

In particular 2 & 3 could be separated, reviewed and tested on their own,
this would make it much easier to discuss what's being tackled here IMO.

Best regards,
Christian

