Return-Path: <linux-kernel+bounces-267265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9062D940F4D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 133C8288E5A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E2D198A04;
	Tue, 30 Jul 2024 10:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AlvhLVNM"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E658197A89
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335210; cv=none; b=MMULIygfHbd2ix8dgsUJc1OGokuUpVFTpnD77jgmbycQR0ilXvLOSirgjL4rO/8ooTBjsj8uMYOJsrkB7GTVRTV1+lFMI9+VHgYZvbBW2CCd514/I3T/WK0LRB9DLEOs0JyN6aeGqzm+TF1sIsDKkpbtoQ/6S2aLSczZxnJ/6BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335210; c=relaxed/simple;
	bh=sxN7TLcnoHw+Zc2vz1WFQqMcQA3CmRtl7pUiHL9bTQA=;
	h=Message-ID:Date:MIME-Version:Subject:References:To:From:
	 In-Reply-To:Content-Type; b=NeZfyN15hStkwkY3IXRXp9XQUZPUTUX1UNA/uIiC70kdzijF3sloz26gfmNwz7fY6YweaapSpwMkMSa8MKhaKcTAiTzZmsBPcUuCUQ8DjiYZCCxSaY+oFTEy2cGlrcgOo/kHUPbxew0hOkBHye8surJ555HfJyYOB2lkoSqLn/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AlvhLVNM; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fc49c0aaffso27585815ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 03:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722335207; x=1722940007; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:to:references:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGL/a5eKl6ga4jYFa8CAaUgPa6lWkZV0E7sMDpiOh+Y=;
        b=AlvhLVNMzJbJDRQvnZMUokjEd8Y3Buqc+WcKqUYtm/U7GuGZOyjG51MOt0/GZsgpY+
         XqiNo9ms5b4/iqVEh+HbII48umSkiCfhGk/evu6Tt8+OmksYKat18NZuIqtleWQp/CaX
         5Pj5b+f5UwDwt04sexOsGKaDdS/TfQSrLCQzFxM9aoD1FKvrkagATVIJMJPFx4pDyezh
         19K7WjbMLgQwu1GHcBKmvV06E0Zc/bet1k0nN7wpgZBoCOZYmEapXMScwUiOG71sPgia
         JKI7DzcLX8PlM1lOpwFLv7D6wpvcWdGIxnFclF++WVcLoTPlkPdPICh5KKD7CNohoc9C
         Tuxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722335207; x=1722940007;
        h=content-transfer-encoding:in-reply-to:from:to:references:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yGL/a5eKl6ga4jYFa8CAaUgPa6lWkZV0E7sMDpiOh+Y=;
        b=BOEmYVzT9KO5tYtei5Sk0g7VaQezooxC/9JJuLVBlvJMjwG11Oxnt3SZ2rJyevy0O1
         1/F89Y8UM0nfCzKoJvwUH8YoqfNf7XYS9FMCPfaB+K5d6rLJbbN+oCPqeNQJJKYjJ4N2
         H/sir5mC0sxgiimRsqLmSfgLBKQ16EMri+IuLj3XQC/YaP5o9HFSqo5LKI/bbI9ESHJe
         2aTMxe1VQnidzcyjDBa9YbV/eTV9lZuksCcn/cswPFBwqedXQAEm2oue0HLUYDjYI4ve
         ZjEnQr3qP2GQ5hLiiZ9HXqnuzBEjDgl7QIyYVL6iz6eNoD0wpDgkSsDLvUREt7L+jC48
         /KYA==
X-Gm-Message-State: AOJu0YyACl0grSD4a8kMCJt/fPPZutRLz3G+QtOHsEiE8GBUlYIIqgeA
	Giy1H3jeZ5bRfz4FfGKBXM7QUoR6f2oJcD0U7H5zMfTWMJ9gpU9a4g1wWsDt5Vz08j8FsOTFspg
	k
X-Google-Smtp-Source: AGHT+IEWoiWxEa7ypz//+PdFQcaYycXDAjX8fN0lZnLl2bZIxcgBu8wqvGs7AYO1MopNgSU7vZEhYw==
X-Received: by 2002:a17:903:230c:b0:1fd:7664:d870 with SMTP id d9443c01a7336-1ff048e4ec3mr87874995ad.51.1722335207332;
        Tue, 30 Jul 2024 03:26:47 -0700 (PDT)
Received: from [10.84.153.104] ([203.208.167.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c7fd99sm98793245ad.47.2024.07.30.03.26.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 03:26:46 -0700 (PDT)
Message-ID: <8f358bc7-e1ed-4631-bdc1-4134b8f84a34@bytedance.com>
Date: Tue, 30 Jul 2024 18:26:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/fair: Sync se's load_avg with cfs_rq in
 reweight_task
References: <66ee1520-48b8-4229-8bdd-9746c8bea5fe@bytedance.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <66ee1520-48b8-4229-8bdd-9746c8bea5fe@bytedance.com>
X-Forwarded-Message-Id: <66ee1520-48b8-4229-8bdd-9746c8bea5fe@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit




-------- 转发的消息 --------
主题: Re: [PATCH v2] sched/fair: Sync se's load_avg with cfs_rq in 
reweight_task
日期: Mon, 29 Jul 2024 11:06:33 +0800
From: Chuyi Zhou <zhouchuyi@bytedance.com>
收件人: Qais Yousef <qyousef@layalina.io>, K Prateek Nayak 
<kprateek.nayak@amd.com>
抄送: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, 
vschneid@redhat.com, chengming.zhou@linux.dev

Hello Qais,

在 2024/7/29 04:14, Qais Yousef 写道:
> On 07/22/24 10:47, K Prateek Nayak wrote:
>> (+ Qais)
>>
>> Hello Chuyi,
>>
>> On 7/20/2024 10:42 AM, Chuyi Zhou wrote:
>>> In reweight_task(), there are two situations:
>>>
>>> 1. The task was on_rq, then the task's load_avg is accurate because we
>>> synchronized it with cfs_rq through update_load_avg() in dequeue_task().
>>>
>>> 2. The task is sleeping, its load_avg might not have been updated for some
>>> time, which can result in inaccurate dequeue_load_avg() in
>>> reweight_entity().
>>>
>>> This patch solves this by using update_load_avg() to synchronize the
>>> load_avg of se with cfs_rq. For tasks were on_rq, since we already update
>>> load_avg to accurate values in dequeue_task(), this change will not have
>>> other effects due to the short time interval between the two updates.
>>>
>>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>>> ---
>>> Changes in v2:
>>> - change the description in commit log.
>>> - use update_load_avg() in reweight_task() rather than in reweight_entity
>>> suggested by chengming.
>>> - Link to v1: https://lore.kernel.org/lkml/20240716150840.23061-1-zhouchuyi@bytedance.com/
>>> ---
>>>    kernel/sched/fair.c | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 9057584ec06d..b1e07ce90284 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -3835,12 +3835,15 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
>>>    	}
>>>    }
>>> +static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags);
>>> +
>>>    void reweight_task(struct task_struct *p, const struct load_weight *lw)
>>>    {
>>>    	struct sched_entity *se = &p->se;
>>>    	struct cfs_rq *cfs_rq = cfs_rq_of(se);
>>>    	struct load_weight *load = &se->load;
>>> +	update_load_avg(cfs_rq, se, 0);
> 
> White space and a comment perhaps?
> 
> LGTM anyway.

Thanks for taking a look, will send another patch later.

(V3 
link:https://lore.kernel.org/lkml/20240723114247.104848-1-zhouchuyi@bytedance.com/)

