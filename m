Return-Path: <linux-kernel+bounces-427697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED449E0500
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E00C1678B0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A05204093;
	Mon,  2 Dec 2024 14:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="hGzMVIus"
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0911FF5F9
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149707; cv=none; b=mLzy8CeyXJWW4UU+xhq8fQ0KUrisEb1trE4JeClbPFk+ao80OzjmIueEvK0G5V9GAMlw3V6zRzIqHzraqkl/M26F/RFjRjQGV54n9ipoVLM/bXVaDGqDa8DKyw7kYnoefcg18lYvXX29HIlMw6g0TVi4TXnj1uOdYIHNiKyt0wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149707; c=relaxed/simple;
	bh=LlTe85ejIGpBstSY8z4cyjI8lv62RbObuaPEsVUPNP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PQc1jHbiGx09OZhBH0X0mts05EKUGOWo8XFoGoWd0WdOFZicYSsmmcd71JwECcrrz6y/2VBWgSddjAbtjhrFyXMxoW96CFLb7RFmcaQ9bhJ6x8lrKiXJYetXCN9EQd08PbeJULA8/bemDhuP1caihCJHAEBSb0Em0Jijq4FMIFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=hGzMVIus; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1733149273;
	bh=LlTe85ejIGpBstSY8z4cyjI8lv62RbObuaPEsVUPNP8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=hGzMVIusvUXqjaY0Zu5Vud/ApKNvnxwpbrFJV6Rpl13nyGvx5/IjqX4qWyi1w1qhL
	 NN1AzCyVJj9+2ObUqwsM51JYG2mT4w0ShSfCIIMUJRs+9K3tVt73XfE7BnFeL2Ikah
	 eUIJ07vn5KiPeH8Qik4dE619QPqxhzARH210gNUc5TbasIYnptudYwtJEcJ2RH9SOS
	 XECNaHLQHglRaYyTgofKO+TD2GtH1vr5Y1oy/C6RDZeYt8yZLtaXkR4TiEIQm+E3r+
	 /06LBiA3JUu8/3qyB15tb+1Sj/uzCcnliBtKAiNKcjCxRXPhEia3MXZHchr8kZSKiy
	 jtoUUUPD7/mgw==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Y25Yj53kJzTwt;
	Mon,  2 Dec 2024 09:21:13 -0500 (EST)
Message-ID: <c9a39d2e-6829-4bc5-b560-347ee79ff2e8@efficios.com>
Date: Mon, 2 Dec 2024 09:21:13 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched: Optimise task_mm_cid_work duration
To: Gabriele Monaco <gmonaco@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20241202140735.56368-1-gmonaco@redhat.com>
 <20241202140735.56368-2-gmonaco@redhat.com>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20241202140735.56368-2-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-12-02 09:07, Gabriele Monaco wrote:
> The current behaviour of task_mm_cid_work is to loop through all
> possible CPUs twice to clean up old mm_cid remotely, this can be a waste
> of resources especially on tasks with a CPU affinity.
> 
> This patch reduces the CPUs involved in the remote CID cleanup carried
> on by task_mm_cid_work.
> 
> Using the mm_cidmask for the remote cleanup can considerably reduce the
> function runtime in highly isolated environments, where each process has
> affinity to a single core.  Likewise, in the worst case, the mask is
> equivalent to all possible CPUs and we don't see any difference with the
> current behaviour.
> 
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>   kernel/sched/core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 95e40895a519..57b50b5952fa 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -10553,14 +10553,14 @@ static void task_mm_cid_work(struct callback_head *work)
>   		return;
>   	cidmask = mm_cidmask(mm);
>   	/* Clear cids that were not recently used. */
> -	for_each_possible_cpu(cpu)
> +	for_each_cpu_from(cpu, cidmask)

Hi Gabriele,

Thanks for looking into this. I understand that you are after minimizing the
latency introduced by task_mm_cid_work on isolated cores. I think we'll need
to think a bit harder, because the proposed solution does not work:

  * for_each_cpu_from - iterate over CPUs present in @mask, from @cpu to the end of @mask.

cpu is uninitialized. So this is completely broken. Was this tested
against a workload that actually uses concurrency IDs to ensure it does
not break the whole thing ? Did you run the rseq selftests ?

Also, the mm_cidmask is a mask of concurrency IDs, not a mask of CPUs. So
using it to iterate on CPUs is wrong.

Mathieu

>   		sched_mm_cid_remote_clear_old(mm, cpu);
>   	weight = cpumask_weight(cidmask);
>   	/*
>   	 * Clear cids that are greater or equal to the cidmask weight to
>   	 * recompact it.
>   	 */
> -	for_each_possible_cpu(cpu)
> +	for_each_cpu_from(cpu, cidmask)
>   		sched_mm_cid_remote_clear_weight(mm, cpu, weight);
>   }
>   

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


