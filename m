Return-Path: <linux-kernel+bounces-318603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4709A96F085
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01715282E91
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB07A1C8FA6;
	Fri,  6 Sep 2024 09:55:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCEE1C7B90
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 09:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725616536; cv=none; b=XuNsGQQIO7HvZSCtWA1NtFi56V/0Mxsj4wya5zBNiIseQUtfB1w5ohjeENJ0e6Na09hJls8D+Xz2bbEnDsoClJ/3DkILLf8FHNLhv/Jrhu38qD4/zX98ZHT195YRD758T28p8X0Rnj99DC80YbEW/VehprH0avTQwQPGu+XYydw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725616536; c=relaxed/simple;
	bh=FpCqUmxR12+Z0iTIhs4ATZ3sR5tHSqjlqOn0UZd0yz0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JUvzeAiQgFnH5YBjwy/JFgC3ZkeHwKqRh682fV1H80ebuodnDAWdyWOPtnhXpEZQIQhzxy8SndjMOv3BOjks5LvBnvjpVbEP+2+qt0uxFuUz0y91+zp3/SHohyfY8ImNEtKX5nfzrQxeLuwysnuagmEMhj/1q+DP1CecoKRmiqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65057FEC;
	Fri,  6 Sep 2024 02:56:01 -0700 (PDT)
Received: from [192.168.178.115] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15FCC3F73F;
	Fri,  6 Sep 2024 02:55:31 -0700 (PDT)
Message-ID: <22c238bc-7b9e-40db-9aa4-9af86208e20f@arm.com>
Date: Fri, 6 Sep 2024 11:55:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/24] sched/uclamg: Handle delayed dequeue
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Hongyan Xia <hongyan.xia2@arm.com>, Luis Machado <luis.machado@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
 juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
 kprateek.nayak@amd.com, wuyun.abel@bytedance.com, youssefesmat@chromium.org,
 tglx@linutronix.de, efault@gmx.de
References: <20240727102732.960974693@infradead.org>
 <20240727105029.315205425@infradead.org>
 <6f39e567-fd9a-4157-949d-7a9ccd9c3592@arm.com>
 <CAKfTPtAS0eSqf5Qoq_rpQC7DbyyGX=GACsB7OPdhi8=HEciPUQ@mail.gmail.com>
 <1debbea4-a0cf-4de9-9033-4f6135a156ed@arm.com>
 <CAKfTPtCEUZxV9zMpguf7RKs6njLsJJUmz8WadyS4ryr+Fqca1Q@mail.gmail.com>
 <83a20d85-de7a-4fe6-8cd8-5a96d822eb6b@arm.com>
 <629937b1-6f97-41d1-aa4f-7349c2ffa29d@arm.com>
 <CAKfTPtBPK8ovttHDQjfuwve63PK_pNH4WMznEHWoXQ=2vGhKQQ@mail.gmail.com>
 <CAKfTPtDO3n-4mcr2Sk-uu0ZS5xQnagdicQmaBh-CyrndPLM8eQ@mail.gmail.com>
 <aa81d37e-ad9c-42c6-a104-fe8496c5d907@arm.com>
 <c49ef5fe-a909-43f1-b02f-a765ab9cedbf@arm.com>
 <CAKfTPtCNUvWE_GX5LyvTF-WdxUT=ZgvZZv-4t=eWntg5uOFqiQ@mail.gmail.com>
 <a9a45193-d0c6-4ba2-a822-464ad30b550e@arm.com>
Content-Language: en-US
In-Reply-To: <a9a45193-d0c6-4ba2-a822-464ad30b550e@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/09/2024 16:07, Dietmar Eggemann wrote:
> On 05/09/2024 15:33, Vincent Guittot wrote:
>> On Thu, 5 Sept 2024 at 15:02, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>>
>>> On 29/08/2024 17:42, Hongyan Xia wrote:
>>>> On 22/08/2024 15:58, Vincent Guittot wrote:
>>>>> On Thu, 22 Aug 2024 at 14:10, Vincent Guittot
>>>>> <vincent.guittot@linaro.org> wrote:
>>>>>>
>>>>>> On Thu, 22 Aug 2024 at 14:08, Luis Machado <luis.machado@arm.com> wrote:
>>>>>>>
>>>>>>> Vincent,
>>>>>>>
>>>>>>> On 8/22/24 11:28, Luis Machado wrote:
>>>>>>>> On 8/22/24 10:53, Vincent Guittot wrote:
>>>>>>>>> On Thu, 22 Aug 2024 at 11:22, Luis Machado <luis.machado@arm.com>
>>>>>>>>> wrote:
>>>>>>>>>>
>>>>>>>>>> On 8/22/24 09:19, Vincent Guittot wrote:
>>>>>>>>>>> Hi,
>>>>>>>>>>>
>>>>>>>>>>> On Wed, 21 Aug 2024 at 15:34, Hongyan Xia <hongyan.xia2@arm.com>

[...]

> I just realized that this fixes the uneven util_est_dequeue/enqueue
> calls so we don't see the underflow depicted by Hongyan and no massive
> rq->cfs util_est due to missing ue_dequeues.
> But delayed tasks are part of rq->cfs util_est, not excluded. Let me fix
> that.

Looks like I got confused ... After checking again, it seems to be OK:


  dequeue_task_fair()

    if !(p is delayed && (migrating || DEQUEUE_SAVE))
      util_est_dequeue()

    if !entity_eligible(&p->se)
      se->sched_delayed = 1       -> p not contributing to
                                     rq->cfs.avg.util_est

  enqueue_task_fair()

    if !(p is delayed && (migrating || ENQUEUE_RESTORE))
      util_est_enqueue()

    if ENQUEUE_DELAYED
      requeue_delayed_entity()
        se->sched_delayed = 0     -> p contributing to
                                     rq->cfs.avg.util_est


Luis M. did test this for power/perf with jetnews on Pix6 mainline 6.8
and the regression went away.

There are still occasional slight CPU frequency spiking on little CPUs.
Could be the influence of decayed tasks on runnable_avg but we're not
sure yet.

[...]

