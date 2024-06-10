Return-Path: <linux-kernel+bounces-208488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B87E9025AA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9699B28B2DC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9AF140E40;
	Mon, 10 Jun 2024 15:29:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D415913DB9B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 15:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718033354; cv=none; b=dnrrW629j+SeJA77XXZwbjqfYaVz3UEZp+hOkOP1PvEMzvxa+IfiGAdPpiPYUwmmWsPINMuHtgNuMCONYCBAIr6WodbDO6wYJLqAPxUI7wXxuUTKfbTbNIr6vmJX1BLwKohSgKOfUGk+BeaUq2F151FQ9714Zhf3yW91Hf2iTbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718033354; c=relaxed/simple;
	bh=Rk/pTVr4dMrIIDGaZ5dSZUdETiX8CTSW7Y1NoRKt3SQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XvI5dFxxU2Kb7gDWjgExcvGHXGUkLrnmyxp37Is0yvv7faWnempGRCOqRxiW7i1mUHp+KwFmxEvepqsU2OqmYlINau2OiGboEGt8xUo7hfrNPOb3B/yCVk0lS9eKmTxnv8Pm3INn30ZdyQ8qg+sMqfJY8vVGsgLWfd0zMUmgzpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FE1411FB;
	Mon, 10 Jun 2024 08:29:36 -0700 (PDT)
Received: from [10.57.88.147] (unknown [10.57.88.147])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D28D23F64C;
	Mon, 10 Jun 2024 08:29:09 -0700 (PDT)
Message-ID: <da0b9016-379b-4e4f-9741-5f69189661b9@arm.com>
Date: Mon, 10 Jun 2024 16:29:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 2/6] sched/uclamp: Track a new util_avg_bias signal
From: Hongyan Xia <hongyan.xia2@arm.com>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>
Cc: Qais Yousef <qyousef@layalina.io>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Christian Loehle <christian.loehle@arm.com>, pierre.gondois@arm.com,
 linux-kernel@vger.kernel.org
References: <cover.1715082714.git.hongyan.xia2@arm.com>
 <2e43dc6b376ea6d785976a398b5d9ffe823cf35d.1715082714.git.hongyan.xia2@arm.com>
 <fdde3285-6d40-458d-84bd-3d7badc1e592@arm.com>
 <1b36141c-1ad7-4c34-b293-92003f473465@arm.com>
Content-Language: en-US
In-Reply-To: <1b36141c-1ad7-4c34-b293-92003f473465@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/05/2024 12:09, Hongyan Xia wrote:
> On 26/05/2024 23:52, Dietmar Eggemann wrote:
>[...]
>>> +    old = READ_ONCE(p->se.avg.util_avg_bias);
>>> +    new = (int)clamp(util, uclamp_min, uclamp_max) - (int)util;
>>> +
>>> +    WRITE_ONCE(p->se.avg.util_avg_bias, new);
>>> +    if (!p->se.on_rq)
>>> +        return;
>>> +    WRITE_ONCE(avg->util_avg_bias, READ_ONCE(avg->util_avg_bias) + 
>>> new - old);
>>> +}
>>> +#else /* !CONFIG_UCLAMP_TASK */
>>> +static void update_util_bias(struct sched_avg *avg, struct 
>>> task_struct *p)
>>> +{
>>> +}
>>> +#endif
>>> +
>>>   /*
>>>    * sched_entity:
>>>    *
>>> @@ -296,6 +330,8 @@ int __update_load_avg_blocked_se(u64 now, struct 
>>> sched_entity *se)
>>>   {
>>>       if (___update_load_sum(now, &se->avg, 0, 0, 0)) {
>>>           ___update_load_avg(&se->avg, se_weight(se));
>>> +        if (entity_is_task(se))
>>> +            update_util_bias(NULL, task_of(se));
>>
>> IMHO,
>>
>> update_util_bias(struct sched_avg *avg, struct sched_entity *se)
>>
>>      if (!entity_is_task(se))
>>          return;
>>
>>      ...
>>
>> would be easier to read.
> 
> Yeah, that would work, and might be a good way to prepare for group 
> clamping if it ever becomes a thing.
> 

Sadly it's not as easy as I hoped. The problem is that we need to fetch 
task uclamp values here so we need to get p anyway. Also, even if one 
day we implement group uclamp, we need to fetch the cfs_rq this se is on 
instead of the whole rq, so the function signature needs to change 
anyway. Keeping it the current way might be the better thing to do here.

> [...]

