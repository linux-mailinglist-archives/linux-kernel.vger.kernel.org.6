Return-Path: <linux-kernel+bounces-256018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2031B9347D3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 502381C216DF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 06:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29464D8C3;
	Thu, 18 Jul 2024 06:06:09 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18CE1E495
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 06:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721282769; cv=none; b=UhPh+p/MnBkrmiA1WUYqwWn5E2lyciv6HCRAk+H5hNpsBab8OUerJ1Je88OtbKWiPBuXJTuQXhuXpZRgMtQDZOWFcEAx2mD+K/RAOFExWwZCJrzVEi7xjLHPeLJoMP6TWTB9MsDGx/AFTBsp6+VPKCzVEmv09uB7/IK8VHpiA/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721282769; c=relaxed/simple;
	bh=o8iXN582iwnMLhjRy2uq3UhYHG73Y4W7F3YBR8b3t24=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tDFxmOV8o9/dk3tv0Lggfjdq8g4kZc/ZmYjhoUTZa0d/m6W4sbhF3di9DvemC2cQrOK1rXnX+XMQu0eu5Riy26TRSP1H0eTeOFRZ+aVv9BR4Nk9/bLjLXzYcYXVb29xg1J6YaAIjwsMQ6QSDpvKk+cmwJuHWhMWjknRlbclxcNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WPhxk5Bnjz2ClL3;
	Thu, 18 Jul 2024 14:00:58 +0800 (CST)
Received: from kwepemg200007.china.huawei.com (unknown [7.202.181.34])
	by mail.maildlp.com (Postfix) with ESMTPS id 192281A0188;
	Thu, 18 Jul 2024 14:05:18 +0800 (CST)
Received: from [10.45.190.163] (10.45.190.163) by
 kwepemg200007.china.huawei.com (7.202.181.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 18 Jul 2024 14:05:17 +0800
Message-ID: <7d39f26d-3c9f-4ee4-977c-87f9bed0bac1@huawei.com>
Date: Thu, 18 Jul 2024 14:04:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH sched_ext/for-6.11] sched_ext: Reverting @p->sched_class
 if @p->disallow is set
To: Tejun Heo <tj@kernel.org>
CC: <void@manifault.com>, <linux-kernel@vger.kernel.org>
References: <20240711110720.1285-1-zhangqiao22@huawei.com>
 <ZpArK0qxZZI-0ykt@slm.duckdns.org>
 <ba2702f9-f66e-498b-853c-d23f1f9191bc@huawei.com>
 <ZpbclgFjf_q6PSd1@slm.duckdns.org>
 <cd3fa16d-5a70-4c85-a591-fa4fa481f50b@huawei.com>
 <ZpgERphu--gPn235@slm.duckdns.org>
From: "Zhangqiao (2012 lab)" <zhangqiao22@huawei.com>
In-Reply-To: <ZpgERphu--gPn235@slm.duckdns.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg200007.china.huawei.com (7.202.181.34)



在 2024/7/18 1:49, Tejun Heo 写道:
> On Wed, Jul 17, 2024 at 10:01:13AM +0800, Zhangqiao (2012 lab) wrote:
>>> Ah, I see what you mean. I was referring to the classs switching operations
>>> in scx_ops_enable(). You're looking at the fork path. I don't think we can
>>
>> Yes, i was referring to the fork path.
>>
>>> switch sched_class at that point and the .disallow mechanism is there to
>>> allow the scheduler to filter out tasks on scheduler start. I'll update the
>>> code so that .disallow is only allowed during the initial attach.
> 
> So, something like this.
> 

LGTM for this patch.

In addition, the @scx_nr_rejected is only updated while the BPF
scheduler is being loaded and this update behavior is proected by
scx_ops_enable_mutex, so is it appropriate to change the
@scx_nr_rejcted's type from atomic to int ?

> Thanks.
> 
> diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
> index 593d2f4909dd..a4aa516cee7d 100644
> --- a/include/linux/sched/ext.h
> +++ b/include/linux/sched/ext.h
> @@ -181,11 +181,12 @@ struct sched_ext_entity {
>  	 * If set, reject future sched_setscheduler(2) calls updating the policy
>  	 * to %SCHED_EXT with -%EACCES.
>  	 *
> -	 * If set from ops.init_task() and the task's policy is already
> -	 * %SCHED_EXT, which can happen while the BPF scheduler is being loaded
> -	 * or by inhering the parent's policy during fork, the task's policy is
> -	 * rejected and forcefully reverted to %SCHED_NORMAL. The number of
> -	 * such events are reported through /sys/kernel/debug/sched_ext::nr_rejected.
> +	 * Can be set from ops.init_task() while the BPF scheduler is being
> +	 * loaded (!scx_init_task_args->fork). If set and the task's policy is
> +	 * already %SCHED_EXT, the task's policy is rejected and forcefully
> +	 * reverted to %SCHED_NORMAL. The number of such events are reported
> +	 * through /sys/kernel/debug/sched_ext::nr_rejected. Setting this flag
> +	 * during fork is not allowed.
>  	 */
>  	bool			disallow;	/* reject switching into SCX */
>  
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index da9cac6b6cc2..cf60474efa75 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -3399,18 +3399,17 @@ static int scx_ops_init_task(struct task_struct *p, struct task_group *tg, bool
>  
>  	scx_set_task_state(p, SCX_TASK_INIT);
>  
> -	if (p->scx.disallow) {
> +	if (!fork && p->scx.disallow) {
>  		struct rq *rq;
>  		struct rq_flags rf;
>  
>  		rq = task_rq_lock(p, &rf);
>  
>  		/*
> -		 * We're either in fork or load path and @p->policy will be
> -		 * applied right after. Reverting @p->policy here and rejecting
> -		 * %SCHED_EXT transitions from scx_check_setscheduler()
> -		 * guarantees that if ops.init_task() sets @p->disallow, @p can
> -		 * never be in SCX.
> +		 * We're in the load path and @p->policy will be applied right
> +		 * after. Reverting @p->policy here and rejecting %SCHED_EXT
> +		 * transitions from scx_check_setscheduler() guarantees that if
> +		 * ops.init_task() sets @p->disallow, @p can never be in SCX.
>  		 */
>  		if (p->policy == SCHED_EXT) {
>  			p->policy = SCHED_NORMAL;
> @@ -3418,6 +3417,9 @@ static int scx_ops_init_task(struct task_struct *p, struct task_group *tg, bool
>  		}
>  
>  		task_rq_unlock(rq, p, &rf);
> +	} else if (p->scx.disallow) {
> +		scx_ops_error("ops.init_task() set task->scx.disallow for %s[%d] during fork",
> +			      p->comm, p->pid);
>  	}
>  
>  	p->scx.flags |= SCX_TASK_RESET_RUNNABLE_AT;
> 

