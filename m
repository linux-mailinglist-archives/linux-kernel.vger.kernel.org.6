Return-Path: <linux-kernel+bounces-258726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D672B938C2A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 139411C212D8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B361E16C437;
	Mon, 22 Jul 2024 09:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OHdYvh3B"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E90926ADB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721641183; cv=none; b=U02PZEdq55/f4BYi0ckNplkHEUNryL9JD71ss3PyhFDGcU+k9L8vrAu/KfXTba3ZfEyUern2siBJ0VBhVPx1rVsRlEnqLTyUKm/meP03/WnJNj/otGg/RCLPT2TDgT6y1Egjs1VT1X9JFBlEs4mtXTTz/nZyyWgrVBfUgxu2wlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721641183; c=relaxed/simple;
	bh=eq5Xpv/5EUYhcWbqrc0Zl5Iwg09zgdkZh8XoWGL5H/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A3Tl4cuGjAJtlfp6oioJov3sgbRo6UXZcX9gp4a0LPpE9IP84k43ooRbUtpcFu689U4bqMpEF8th4bgoRj4XTcryZG2o6XgvsHp49SXbj/aF7lFEiHipZhhFhcsD6y75fvDXH9CVkacCgQ1Jui7oLwKiTQpX/Z69yG6IWYvVgXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OHdYvh3B; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7a2123e9ad5so506513a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 02:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721641181; x=1722245981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1sFLMAddajkGuvG7pwl8VcoUW+BvLkAuKqaPHXhUdg=;
        b=OHdYvh3BY/HSUrCcuHLLa6Eih2RENoGmtCe1qcYLn3p5PtJtJEC2sJ9EehcQQOFVLs
         GQWNnvMWpXfm80tu6jGkUEQ6ALPaHeIhTOlnyr6E/zWSxht8A/UTS5CoOG+Xey1F9f6d
         EXbx6QShPnVqvS3PBlqzyBCWwpvF8hZRZ1r7OMUuhCMvXJsMrz9MD0jGncn6ExtD+i3R
         07cDIPRTynXioIbCfPLN3rRUcvbz00ssiEac3uH4ELbT0OZdqFddedIc3v4ylCP+zlno
         NdlOGI8NzxBYD43o28V3+lxca0wM3XmXS8WdGnbMnJKWwm0rg10CeiSTrzArfPLUBIS9
         egUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721641181; x=1722245981;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A1sFLMAddajkGuvG7pwl8VcoUW+BvLkAuKqaPHXhUdg=;
        b=R94b1W9FwtiIXbFVIMmHTj3UVDTv5THwQ2MeYElNbHijWVXs1zr6W3gPYzNvEee6mR
         37IjNnyNBcRSEjaJpiTiRr75ZoKIUnFvXkAY/NKP2+1VF7WzD+vNvH6fwJHYCfzmMTBe
         QbeVLoPVGHOwKvr1poxJl4uLg01S6TEginka3qKcEXkZJGGDCDJARVnQ2rZdB9DWgqzz
         wzvU0z998S2Yni9oQL+kWjvrqyYStN6Yr8NJH2FaaV48WiNqHA5oT84b+yMmVkxs/vX9
         ALV33OLt3xi10Y1C3ANqQtOaCB+dzwS5/gI7ir/2iZuqR7TicXGir1M/XRTFdt4RH4MB
         N2nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiSb1QBUTKUVRH7TgxxNIMtgg7t8OTxK7ah1fILuXjE3AWaEtcv/zBuHdqY2Encjn2DLCJoB4YWGGhpOhqh7O8AAFI08QecIpmg5MG
X-Gm-Message-State: AOJu0YwEKQeis4dC0AqD/FvMOJmsai8Q4zZbiyMsknYQ2Amv4EKthQEa
	ysHgf2/HS/8FvJenRF1h6xog++M8stPAgWdLImOtKLq70bN2BwN6PMZpY7ZUdT8=
X-Google-Smtp-Source: AGHT+IFlHPXWVLMxGpOhptGVNtkgtFYRULMLycpK3rgMXm3tfT/OCqXgEzUeCz7KEKDOIItIXZO/3w==
X-Received: by 2002:a17:90b:344:b0:2c9:6aab:67c4 with SMTP id 98e67ed59e1d1-2cb7735dcdbmr17838260a91.10.1721641181357;
        Mon, 22 Jul 2024 02:39:41 -0700 (PDT)
Received: from [10.254.189.162] ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70cff49159bsm4986511b3a.21.2024.07.22.02.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 02:39:41 -0700 (PDT)
Message-ID: <0e522193-b4af-40ad-9762-41bfa643dd60@bytedance.com>
Date: Mon, 22 Jul 2024 17:39:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/fair: Sync se's load_avg with cfs_rq in
 reweight_task
To: Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com
Cc: chengming.zhou@linux.dev, linux-kernel@vger.kernel.org
References: <20240720051248.59608-1-zhouchuyi@bytedance.com>
 <0575c014-6fe7-4118-bae8-cbb5b303a390@arm.com>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <0575c014-6fe7-4118-bae8-cbb5b303a390@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

在 2024/7/22 14:34, Dietmar Eggemann 写道:
> On 20/07/2024 07:12, Chuyi Zhou wrote:
>> In reweight_task(), there are two situations:
>>
>> 1. The task was on_rq, then the task's load_avg is accurate because we
>> synchronized it with cfs_rq through update_load_avg() in dequeue_task().
>>
>> 2. The task is sleeping, its load_avg might not have been updated for some
>> time, which can result in inaccurate dequeue_load_avg() in
>> reweight_entity().
>>
>> This patch solves this by using update_load_avg() to synchronize the
>> load_avg of se with cfs_rq. For tasks were on_rq, since we already update
>> load_avg to accurate values in dequeue_task(), this change will not have
>> other effects due to the short time interval between the two updates.
>>
>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>> ---
>> Changes in v2:
>> - change the description in commit log.
>> - use update_load_avg() in reweight_task() rather than in reweight_entity
>> suggested by chengming.
>> - Link to v1: https://lore.kernel.org/lkml/20240716150840.23061-1-zhouchuyi@bytedance.com/
>> ---
>>   kernel/sched/fair.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 9057584ec06d..b1e07ce90284 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -3835,12 +3835,15 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
>>   	}
>>   }
>>   
>> +static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags);
>> +
>>   void reweight_task(struct task_struct *p, const struct load_weight *lw)
>>   {
>>   	struct sched_entity *se = &p->se;
>>   	struct cfs_rq *cfs_rq = cfs_rq_of(se);
>>   	struct load_weight *load = &se->load;
>>   
>> +	update_load_avg(cfs_rq, se, 0);
> 
> IIUC, you only want to sync the sleeping task with its cfs_rq. IMHO,
> sync_entity_load_avg() should be used here instead of update_load_avg().
> The latter is doing much more than this.

Indeed, sync_entity_load_avg() is better.

> 
>>   	reweight_entity(cfs_rq, se, lw->weight);
>>   	load->inv_weight = lw->inv_weight;
>>   }
> 
> Maybe even do this in reweight_entity()?. You would have to do it under
> 'if (!se->on_rq) in reweight_task() anyway I assume.
> 

Yes, we can do it reweight_entity() and it's more clear.

Thanks for your suggestion.



