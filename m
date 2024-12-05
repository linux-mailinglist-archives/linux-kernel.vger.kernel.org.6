Return-Path: <linux-kernel+bounces-434009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6ED9E6018
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 22:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 032B7164BE6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 21:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51521C3BEF;
	Thu,  5 Dec 2024 21:28:35 +0000 (UTC)
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3A61B87FB
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 21:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733434115; cv=none; b=GrxKwZYMPoUYnLIamfP8ppG0Kuh9T0/v9N00WoAfcXpDZw3ibw9Dqj7vORqceLO2k+mQTpgq6uhZ9ANOJd13BOr7JTiTm1e5yAYOTxNPtEv0UEkgYCL3C9zcfEy5LV9VS1lvBBheW2DQ1Ird3kSkILZtBx3+7lG9ikCkeoHeibU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733434115; c=relaxed/simple;
	bh=d245TM7TRoeflKb+grbpzAdlrdczq38xHHhrgWegxRE=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type:Cc:In-Reply-To; b=n6AYDQjkp7wqoDH6WZ7DJ0zqvVkfXGEUpIu2HgWuSc4DxMz6BAQZzAMrJPh0Nn40J/8Ctxalw983Gwa+BMp5VFeoB9t5QtACqdI21OgsnKg/pd9xxOxcKwoQE+OvIiT8/nu8ddo/ojYlXVI3GQq+7x0JqXx6UzRX+pEviNaSkAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <glk-linux-kernel-4@m.gmane-mx.org>)
	id 1tJJJj-0001F2-Uh
	for linux-kernel@vger.kernel.org; Thu, 05 Dec 2024 22:23:23 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [RFC][PATCH] sched: deadline: Remove unnecessary goto label in
 pick_earliest_pushable_dl_task
Date: Thu, 5 Dec 2024 22:23:17 +0100
Message-ID: <06444675-136e-442f-918b-e7887d2c535b@wanadoo.fr>
References: <20241205211632.1181715-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla Thunderbird
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Wanpeng Li <wanpeng.li@linux.intel.com>, Todd Kjos <tkjos@google.com>,
 kernel-team@android.com
Content-Language: en-US, fr-FR
In-Reply-To: <20241205211632.1181715-1-jstultz@google.com>

Le 05/12/2024 à 22:16, John Stultz a écrit :
> Commit 8b5e770ed7c0 ("sched/deadline: Optimize pull_dl_task()")
> added an odd goto label that seems to be unnecssary, given its

s/unnecssary/unnecessary/

> called unconditionally from the bottom of a while loop and the
> label is at the top.

Except that it is not a while loop, but only an if.

Maybe, changing this if into a while would save a few lines of code and 
be more readable as-well.

CJ

> 
> Thus, clean it up and remove the label/goto.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Wanpeng Li <wanpeng.li@linux.intel.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: kernel-team@android.com
> Fixes: 8b5e770ed7c0 ("sched/deadline: Optimize pull_dl_task()")
> Reported-by: Todd Kjos <tkjos@google.com>
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
>   kernel/sched/deadline.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index d9d5a702f1a61..566a05efa4e57 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2501,8 +2501,6 @@ static struct task_struct *pick_earliest_pushable_dl_task(struct rq *rq, int cpu
>   		return NULL;
>   
>   	next_node = rb_first_cached(&rq->dl.pushable_dl_tasks_root);
> -
> -next_node:
>   	if (next_node) {
>   		p = __node_2_pdl(next_node);
>   
> @@ -2510,7 +2508,6 @@ static struct task_struct *pick_earliest_pushable_dl_task(struct rq *rq, int cpu
>   			return p;
>   
>   		next_node = rb_next(next_node);
> -		goto next_node;
>   	}
>   
>   	return NULL;



