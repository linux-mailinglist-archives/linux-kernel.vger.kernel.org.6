Return-Path: <linux-kernel+bounces-280652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C82A94CD51
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 11:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CBD6B21CD4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858A91917DD;
	Fri,  9 Aug 2024 09:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Z3LMNcWu"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5288218FDBC
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 09:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723195737; cv=none; b=sc/4iBTFqVx1srxtaOxITnlAiBAxUNSQSb+n1ImcfC+7nPlphEdbxAy/iSrEeq0fSu9JkLlMQEw88xC5Rd0VFfmESIcoo7grA49ma6bD/qCzYZFSb4BbUm7VDK9ifJP25EFJWpWehvF1fkYN4atehSEQyqPa/zR4IsOP9Tg2jrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723195737; c=relaxed/simple;
	bh=dnDwme/kka69SyfBSHL/ZAfpVn5Q9mjinursXPuI1xM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lAV5hITdOqZ0Nm82txVU3ZyhWucHkbRT2kT4Xo5YE0L2GvpHJU3kmgafnBd7Bq4j7hUTVSG4TNEoH4hmNNwP+XmmEjk/9KcV5Rn/TiLPDFXlSsH34rx2rzTDkQ95tkfvvq0qqTWQM0GNc2h1OyLF5CrPMZ2aSzm4fB4El+cTcc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Z3LMNcWu; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d1ecfe88d7so151024a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 02:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723195734; x=1723800534; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UiCkP8mZ5PMGPQmTsGb2ykbZHeNMNoBKRpnVFYpYQV8=;
        b=Z3LMNcWudb/v7mQLp4KXcFwWZk/hd3rWDAbgRGj5gPYuoR95Cq98Wk/m0Ro8NcjvBs
         AW0tSLWnQHWy6v07aq1EPBGyP1QILfmi+4GJWTCD7ZrcIwDXegUAdZniEgsGFF3NEtS5
         viTKHBrXzRjTQkWL8COIe7czzDmbmybKobap88z8FLyjCzeMD0yzlcJyfXuCU30SAsH4
         PLAtFThzVAPRA9SNhgZ9uEITe2Y0lOSTsWP3NUZXG6riOVb7wzCxfpaIVW/Uxtf4ZlYx
         5+6uCO5umqz2oZefC23W1+ggo/jQhi5epdcN4PDSoP3zL0FG7B2zHliBkPijTnr/W7Db
         xXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723195734; x=1723800534;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UiCkP8mZ5PMGPQmTsGb2ykbZHeNMNoBKRpnVFYpYQV8=;
        b=BR/oudI7zjdfm+0ErvOHZO2VttIQVfbStsDgMLBdI86pYboLWarKxD42JsKW3ttCa2
         nEeXC36plmzScKH6PbjWPwnDYzrZkUN8Br2ZPOt5gXTDNSpAscUBD5nCrvcdhYIZOC2E
         cPko0vfttWc/bpyymO02pwwQbmfSnKjwTlj47oI6qx9gZSy6sF3uHKyJ0zMEqxjgyHjb
         tMDS+7yQV9o+Vc5KAx2OYOG28OIPjNtEMFrvHvm15i9/vPFwvXEFwn4nIfpTwN06T4+Y
         ARVWyPyVOt8DxUcsJ8aEHbAfdHPNGoZjMSyz2aAhW9GF/4QG4oOJIfPpCu9KpnlUIhDS
         RKcw==
X-Forwarded-Encrypted: i=1; AJvYcCXPSXqr1nie+dP6Zq/GocNs/Z7DGicCxViF9ByM900eekBI9MImGMJo1wlZaxlaL6Dj/e5AZMN1q9QMM7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNlRg4Zn5RlSVdwsWrzoOnhFJNP0FsuY5ZBG/U0VqV3Ul72Ixh
	Cq4g5FGhDhKzIbixRKs9zICitH+PSmU/5wH6ejHk/B6JBsF3FyfiK6KDP7w+MrY=
X-Google-Smtp-Source: AGHT+IEceErTEhz7Hhb89JnQOvA7lDYnjXHP1PjtSz8F+Zuhetl6dBji3x2/KIKxMW8rTIaBjEUsuQ==
X-Received: by 2002:a17:90b:1e47:b0:2c9:321:1bf1 with SMTP id 98e67ed59e1d1-2d1e8073cfbmr961834a91.39.1723195734594;
        Fri, 09 Aug 2024 02:28:54 -0700 (PDT)
Received: from [10.4.232.12] ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1b3b0c796sm4783894a91.33.2024.08.09.02.28.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 02:28:54 -0700 (PDT)
Message-ID: <489bf8ab-7007-411d-9ee4-919cbcc8cdfd@bytedance.com>
Date: Fri, 9 Aug 2024 17:28:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] sched/fair: Sync se's load_avg with cfs_rq in
 reweight_task
To: Vincent Guittot <vincent.guittot@linaro.org>, peterz@infradead.org
Cc: mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, chengming.zhou@linux.dev, linux-kernel@vger.kernel.org,
 Vishal Chourasia <vishalc@linux.ibm.com>
References: <20240729104616.180445-1-zhouchuyi@bytedance.com>
 <CAKfTPtA4VRDzvbKC11rhbkFECMNvbFdWkf2n4pk=AehBUgRxvQ@mail.gmail.com>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <CAKfTPtA4VRDzvbKC11rhbkFECMNvbFdWkf2n4pk=AehBUgRxvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Friendly Ping.

在 2024/8/5 21:41, Vincent Guittot 写道:
> On Mon, 29 Jul 2024 at 12:47, Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
>>
>> In reweight_task(), there are two situations:
>>
>> 1. The task was on_rq, then the task's load_avg is accurate because in
>> __sched_setscheduler()/set_user_nice(), we would dequeue the on_rq tasks
>> before doing reweight. The task's load_avg would be synchronized with
>> cfs_rq through update_load_avg() in dequeue_task().
>>
>> 2. The task is sleeping, its load_avg might not have been updated for some
>> time, which can result in inaccurate dequeue_load_avg() in
>> reweight_entity().
>>
>> This patch solves this by using sync_entity_load_avg() to synchronize the
>> load_avg of se with cfs_rq before dequeue_load_avg() in reweight_entity().
>> For tasks were on_rq, since we already update load_avg to accurate values
>> in dequeue_task(), this change will not have other effects due to the short
>> time interval between the two updates.
>>
>> Suggested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
>> Reviewed-by: Vishal Chourasia <vishalc@linux.ibm.com>
>> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> 
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> 
>>
>> ---
>> Changes in v4:
>> - Fix the 'if else' code style issue.(Dietmar)
>> - Add a description of __sched_setscheduler()/set_user_nice() in the commit
>>    log.(Dietmar)
>> - Add comment before calling sync_entity_load_avg().(Qais)
>> Changes in v3:
>> - use sync_entity_load_avg() rather than update_load_avg() to sync the
>> sleeping task with its cfs_rq suggested by Dietmar.
>> - Link t0 v2: https://lore.kernel.org/lkml/20240720051248.59608-1-zhouchuyi@bytedance.com/
>> Changes in v2:
>> - change the description in commit log.
>> - use update_load_avg() in reweight_task() rather than in reweight_entity
>> suggested by chengming.
>> - Link to v1: https://lore.kernel.org/lkml/20240716150840.23061-1-zhouchuyi@bytedance.com/
>> ---
>>   kernel/sched/fair.c | 46 +++++++++++++++++++++++++++------------------
>>   1 file changed, 28 insertions(+), 18 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 9057584ec06d..1e3c7c582541 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -3669,11 +3669,32 @@ dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
>>          cfs_rq->avg.load_sum = max_t(u32, cfs_rq->avg.load_sum,
>>                                            cfs_rq->avg.load_avg * PELT_MIN_DIVIDER);
>>   }
>> +
>> +static inline u64 cfs_rq_last_update_time(struct cfs_rq *cfs_rq)
>> +{
>> +       return u64_u32_load_copy(cfs_rq->avg.last_update_time,
>> +                                cfs_rq->last_update_time_copy);
>> +}
>> +
>> +/*
>> + * Synchronize entity load avg of dequeued entity without locking
>> + * the previous rq.
>> + */
>> +static void sync_entity_load_avg(struct sched_entity *se)
>> +{
>> +       struct cfs_rq *cfs_rq = cfs_rq_of(se);
>> +       u64 last_update_time;
>> +
>> +       last_update_time = cfs_rq_last_update_time(cfs_rq);
>> +       __update_load_avg_blocked_se(last_update_time, se);
>> +}
>> +
>>   #else
>>   static inline void
>>   enqueue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) { }
>>   static inline void
>>   dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) { }
>> +static void sync_entity_load_avg(struct sched_entity *se) { }
>>   #endif
>>
>>   static void reweight_eevdf(struct sched_entity *se, u64 avruntime,
>> @@ -3795,7 +3816,14 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
>>                  if (!curr)
>>                          __dequeue_entity(cfs_rq, se);
>>                  update_load_sub(&cfs_rq->load, se->load.weight);
>> +       } else if (entity_is_task(se)) {
>> +               /*
>> +                * If the task is sleeping, we need to synchronize entity load avg
>> +                * before dequeue_load_avg().
>> +                */
>> +               sync_entity_load_avg(se);
>>          }
>> +
>>          dequeue_load_avg(cfs_rq, se);
>>
>>          if (se->on_rq) {
>> @@ -4034,11 +4062,6 @@ static inline bool load_avg_is_decayed(struct sched_avg *sa)
>>          return true;
>>   }
>>
>> -static inline u64 cfs_rq_last_update_time(struct cfs_rq *cfs_rq)
>> -{
>> -       return u64_u32_load_copy(cfs_rq->avg.last_update_time,
>> -                                cfs_rq->last_update_time_copy);
>> -}
>>   #ifdef CONFIG_FAIR_GROUP_SCHED
>>   /*
>>    * Because list_add_leaf_cfs_rq always places a child cfs_rq on the list
>> @@ -4773,19 +4796,6 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>>          }
>>   }
>>
>> -/*
>> - * Synchronize entity load avg of dequeued entity without locking
>> - * the previous rq.
>> - */
>> -static void sync_entity_load_avg(struct sched_entity *se)
>> -{
>> -       struct cfs_rq *cfs_rq = cfs_rq_of(se);
>> -       u64 last_update_time;
>> -
>> -       last_update_time = cfs_rq_last_update_time(cfs_rq);
>> -       __update_load_avg_blocked_se(last_update_time, se);
>> -}
>> -
>>   /*
>>    * Task first catches up with cfs_rq, and then subtract
>>    * itself from the cfs_rq (task must be off the queue now).
>> --
>> 2.20.1
>>

