Return-Path: <linux-kernel+bounces-260926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EAB93B070
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EF1528509C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 11:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EE715687C;
	Wed, 24 Jul 2024 11:34:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5ACF156C5E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 11:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721820877; cv=none; b=QAjwdoABMaLRKaetuH5tI4M4ftmM3GDhE8lJuBsaDHVaiJ+jBSrX+WUAfQzR3N1pJFidajejOHr5Q2fZm0YO1VJB+gJGACzvQgVNyjUPDiwhoOPNAwqJDoxv5ttnPkCeORXwBK1NHuTNNYv1Bz39NvlMXvflqeg/RBvEN7ugVvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721820877; c=relaxed/simple;
	bh=x5BIygFhVqUH+30R0m+T4QNecWs43Qt5ls4enfh/Hr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X91IU1OFWs3MJeLEabz0wpgwVMu1TN+sQqc2iziigyPHRjY6dhf5QFWBYvzuuVWkEqmG3X837bhkuPUsmo9x+pZCjsI7JZTuIfkk9TvFDzRolpAW6KXkhvG+TJ20nGY5qXep+w9/vUdypJruCFA30QQripEo4y6bcKBoXkmFmdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A098106F;
	Wed, 24 Jul 2024 04:34:59 -0700 (PDT)
Received: from [192.168.178.110] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A2BF43F766;
	Wed, 24 Jul 2024 04:34:32 -0700 (PDT)
Message-ID: <5e97cfda-48e1-4a7d-ba66-33751463e98d@arm.com>
Date: Wed, 24 Jul 2024 13:34:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [sched/pelt] 97450eb909:
 INFO:task_blocked_for_more_than#seconds
To: Chen Yu <yu.c.chen@intel.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Qais Yousef <qyousef@layalina.io>
References: <202407091527.bb0be229-lkp@intel.com>
 <CAKfTPtBMdLRN8WVUmvXXZQK5fE_rZEFJenujrxpqWYAQ7b-jBw@mail.gmail.com>
 <ZpFcz7s+R7ay77Js@chenyu5-mobl2>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <ZpFcz7s+R7ay77Js@chenyu5-mobl2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/07/2024 18:41, Chen Yu wrote:
> On 2024-07-09 at 12:03:42 +0200, Vincent Guittot wrote:
>> On Tue, 9 Jul 2024 at 09:22, kernel test robot <oliver.sang@intel.com> wrote:
>>>
>>> Hello,
>>>
>>> kernel test robot noticed "INFO:task_blocked_for_more_than#seconds" on:
>>>
>>> commit: 97450eb909658573dcacc1063b06d3d08642c0c1 ("sched/pelt: Remove shift of thermal clock")
>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>
>> First, I'm surprised that an Intel platform is impacted by this patch
>> because Intel doesn't use it AFAIK.
>> Then, this patch mainly remove a right shift i.e.:
>> instead of:
>>   return rq_clock_task(rq) >> sched_hw_decay_shift
>> we are now doing:
>>   return rq_clock_task(rq)
>>
>> Could it be a false positive ?
> 
> Before trying to reproduce it locally, one question is that, should we use
> rq_clock_task(rq) in __update_blocked_others() rather than 'now', which is
> actually calculated by rq_clock_pelt(rq)? 
> 
> thanks,
> Chenyu
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d34f6d5b11b5..17ec0c51b29d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9432,7 +9432,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
>  
>  	decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
>  		  update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
> -		  update_hw_load_avg(now, rq, hw_pressure) |
> +		  update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure) |
>  		  update_irq_load_avg(rq, 0);
>  
>  	if (others_have_blocked(rq))

Yes, update_hw_load_avg() should be driven entirely by
rq_clock_task(rq). But IMHO this PELT signal is only used on some arm64
platforms. So you won't detect any misbehavior running your tests on Intel.

