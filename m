Return-Path: <linux-kernel+bounces-547471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F15EA509C7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9B141702E1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E693252905;
	Wed,  5 Mar 2025 18:22:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CA41FC7D0
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 18:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198927; cv=none; b=K6IstplFAieiuL1xEGRTPFLilTxhU4sI1Hi2zLGm+Q3Z7i0sVSe35N9rwvXj8wyaJLsxtYSXk/9eP7krnwa/meQ3f2pUXllqfJ9pGZDrX+asiV40CbW1FyBM0rtLByori9eawv6r9INynxpB2lWpml4H+PzSx55DnYqQr0w7Dr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198927; c=relaxed/simple;
	bh=l/PkJFK/9HQoD0x4hoRGgG2Dz3UoUWKgmxJNMwGkR4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r17v0Hl1A65WMWLNXa3t+A1rLD3fy4bEklR0cc0c3U+I1BEAhMKo82BzoE5dlyIdd0skBM10XXuVQdbdB4hpJcx3FEf5fjXvsNBOV2LavIFc6K787wPYXXhGiTXtuT1RazaRJ/RtohqfLJrW1tinN/6VOjRUsNQeBsFp/9Og4P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5733FEC;
	Wed,  5 Mar 2025 10:22:17 -0800 (PST)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0BB23F66E;
	Wed,  5 Mar 2025 10:22:02 -0800 (PST)
Message-ID: <4394f2a7-b4e8-419a-a299-f1afa560c944@arm.com>
Date: Wed, 5 Mar 2025 19:22:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/uclamp: Let each sched_class handle uclamp
To: Hongyan Xia <hongyan.xia2@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org
References: <84441660bef0a5e67fd09dc3787178d0276dad31.1740664400.git.hongyan.xia2@arm.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <84441660bef0a5e67fd09dc3787178d0276dad31.1740664400.git.hongyan.xia2@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/02/2025 14:54, Hongyan Xia wrote:

[...]

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 857808da23d8..7e5a653811ad 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6941,8 +6941,10 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	 * Let's add the task's estimated utilization to the cfs_rq's
>  	 * estimated utilization, before we update schedutil.
>  	 */
> -	if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & ENQUEUE_RESTORE))))
> +	if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & ENQUEUE_RESTORE)))) {
> +		uclamp_rq_inc(rq, p);
>  		util_est_enqueue(&rq->cfs, p);
> +	}

So you want to have p uclamp-enqueued so that its uclamp_min value
counts for the cpufreq_update_util()/cfs_rq_util_change() calls later in
enqueue_task_fair?

  if (p->in_iowait)
    cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);

  enqueue_entity() -> update_load_avg() -> cfs_rq_util_change() ->
  cpufreq_update_util()

But if you do this before requeue_delayed_entity() (1) you will not
uclamp-enqueue p which got his ->sched_delayed just cleared in (1)?

[...]

