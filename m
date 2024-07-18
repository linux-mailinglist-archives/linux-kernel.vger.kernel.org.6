Return-Path: <linux-kernel+bounces-255902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D35293466E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 04:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B3961F2274C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 02:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360C424B4A;
	Thu, 18 Jul 2024 02:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eBmLrgSg"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DC826AD0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 02:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721269966; cv=none; b=MCyPmykZg4talQv4ZZo4fToKFnR6eT9HsN54/IH6kCAs1Hy9umTE+jgQ3iLQlhGQEALU3+BHnrXRkhZZafuNUwhssUlyOytd+SOGzIyYv/CJ4FcsRiT6PuOoOW8dc30nkSCLRDZ6NIfltsgy4FHqtBfhylodYQKhLcc4URhnYFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721269966; c=relaxed/simple;
	bh=WJ7RYF/ht6tTem2L3HuMLEevEhtEaH/tb3fWEtteaBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=otCsCPGAFlirf1oioNmro1/Kqt9e90jns1JofsmVhPAVIrSsNnFPzsrmjEXskq1qR1OyTDk5GIETFVlUK0AiTSE8epa8QhUfFpv6Ai8pjqC04U+J32ugNEudQ8Xgz5CQCKeK+9FEMecj4PluJD/e0SNqF+6dWKSznRKyXj5l/Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eBmLrgSg; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc658b6b2eso207715ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 19:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721269964; x=1721874764; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7VxRQsPdN4iYVQHu4WwR0CdoZRj0oY3xvf9uxc9mHh0=;
        b=eBmLrgSgwFxJTHCi/dIT9abKRIvg6z4XJ2ixTPHFnddliFS0GotmGBqX0g+fvXDYVK
         NDUtyDsyhwmxIbS56UwrhmjDneGQOCvkW2Z+O5ZjZflrbubqGGQ+s7a9DMbBNuA6X+cJ
         YWfsS9Vm3CJorlbLY2rEZ4TscoM3ifRHIU63X/zmzbAxxfHFkpJLBUwocIuF4pe60UXL
         PW2PgENlvVQm5CnW6SEfoIU7qls92Uc5o0cQY1j8DF/DrntBvapL7QXP8nmZE4int+NP
         6GYcY1hEA2Yd0fm3HXOn50hlfS4UFAPNwA1RsbuGMtP5ZwpHsoQ+xNOkjpSK/qTawu1A
         MAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721269964; x=1721874764;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7VxRQsPdN4iYVQHu4WwR0CdoZRj0oY3xvf9uxc9mHh0=;
        b=Rbkh5TtpxnEjAX5y6yla3SSGoPtmRAOxwKub47fh639ETDpajlu6A9svGOuO5ej78j
         q7TX3Md7JFasTdooRMyaSCT83y95gWxE1zO9mTjzs871AyNyPcjBVxkmyfvqTNHGXEDJ
         S9G6X2RfJU2pkfqAyQUfkVkNzsw5u8pHc5WcN3As0vKMI2637qu0kV6fFjSPh7vqgFya
         bOx+rEw+mF7zS11xJ0QtMLubBtstl+dLIrjNAk/rv2v02deci7k+nRBhN07co3DtFoPT
         BondOMELKQ/ApblVkXhHoxP/iZgtrOcufs5weTPtYwLBBjqRuR0tZMhqA7g0r3sBtoEl
         lsSg==
X-Gm-Message-State: AOJu0Yy63Wu0Hn8dQf/deANJa8X3jnapjsb3tI8SPaLZSn1gb7vKAwCl
	3EhdT3u6LSswYcWrkoxH67C0H87PeA7SK1qCm0qy6FnaoGThqNunh1yp2V3OEOk=
X-Google-Smtp-Source: AGHT+IGGMvxmXHd8W3M7ZthMIrV3z+rSaWdB+ZFzm+BMrmRkt3ZIbBp0dvh4napS21LmOgHfulp7Hg==
X-Received: by 2002:a17:902:fa4c:b0:1fa:18c3:2788 with SMTP id d9443c01a7336-1fc4e5650d9mr22785535ad.24.1721269963735;
        Wed, 17 Jul 2024 19:32:43 -0700 (PDT)
Received: from [10.84.154.236] ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc418f0d0dsm31313545ad.207.2024.07.17.19.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 19:32:43 -0700 (PDT)
Message-ID: <cea46f88-6a4b-48c6-bbd7-033a3fc5d34d@bytedance.com>
Date: Thu, 18 Jul 2024 10:32:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Sync se's load_avg with cfs_rq in
 reweight_entity
To: Chengming Zhou <chengming.zhou@linux.dev>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org
Cc: linux-kernel@vger.kernel.org
References: <20240716150840.23061-1-zhouchuyi@bytedance.com>
 <3faf976d-52ee-4fc7-ad42-70fc0dc53de4@linux.dev>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <3faf976d-52ee-4fc7-ad42-70fc0dc53de4@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/7/17 19:18, Chengming Zhou 写道:
> On 2024/7/16 23:08, Chuyi Zhou wrote:
>> In reweight_entity(), if !se->on_rq (e.g. when we are reweighting a
>> sleeping task), we should sync the load_avg of se to cfs_rq before 
>> calling
>> dequeue_load_avg(). Otherwise, the load_avg of this se can be inaccurate.
> 
> Good catch!
> 
>>
>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>> ---
>>   kernel/sched/fair.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 9057584ec06d..2807f6e72ad1 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -3782,6 +3782,8 @@ static void reweight_eevdf(struct sched_entity 
>> *se, u64 avruntime,
>>       se->deadline = avruntime + vslice;
>>   }
>> +static inline void update_load_avg(struct cfs_rq *cfs_rq, struct 
>> sched_entity *se, int flags);
>> +
>>   static void reweight_entity(struct cfs_rq *cfs_rq, struct 
>> sched_entity *se,
>>                   unsigned long weight)
>>   {
>> @@ -3795,7 +3797,11 @@ static void reweight_entity(struct cfs_rq 
>> *cfs_rq, struct sched_entity *se,
>>           if (!curr)
>>               __dequeue_entity(cfs_rq, se);
>>           update_load_sub(&cfs_rq->load, se->load.weight);
>> +    } else {
>> +        /* Sync with the cfs_rq before removing our load_avg */
>> +        update_load_avg(cfs_rq, se, 0);
> 
> I think it's suboptimal to update_load_avg() here unconditionally.
> 
> Because reweight_entity() has two types of usages:
> 
> 1. group se, which uses reweight_entity() in update_cfs_group(), which
> should already update_load_avg(), so should have no problem.
> 
> 2. task se, which uses reweight_entity() in reweight_task(), which 
> should be fixed for sleep task entity as you described above.
> 
> So IMHO, we should only update_load_avg() or sync_entity_load_avg() in
> reweight_task(), right?
> 

I will send another patch later.

Thanks for the review!


