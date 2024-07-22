Return-Path: <linux-kernel+bounces-258490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D36D49388BB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 08:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA3591C20E65
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 06:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CB617996;
	Mon, 22 Jul 2024 06:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="J6y/5bKJ"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126582F26
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 06:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721628286; cv=none; b=qbXP394Xd/M6e8XCywTGR694X15b90+WJqKtjqrMUt6VmLEFBUc1yFOL1Pc9sHbpnxSEoHbGFhS7gRAVxM1hYws5NIWHvcVpDc5eVSIz1Ju+Cr16FoCPaBRlXVkIIeubi0HqsVEpF60kIDCFrGSX79N+avyRONeS9RtnDBcmDkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721628286; c=relaxed/simple;
	bh=OuxaxacgCyc29pI43awwBJHOYOZNfOOOL7H1SFm48hQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SKYJrue6dosR0t8g/wpB2FDKN8yYekutr1lCGwMVVIoXhMxrDPZq4A/ro8PErpf5mM/34JFh5gkNIWONtGvxwdzZUuwURQVWwwVAnjrks8xTZB/Bg6pqEvfx6xkec3D1u8UmytC1PClcqnL8nZhTz4UkK9rDcDY+rV30cefahjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=J6y/5bKJ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70d1158d149so372653b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 23:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721628284; x=1722233084; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTucK2xz2U8aT8vxvUv3vyhW6VzTN5EqQ49H5XGmatQ=;
        b=J6y/5bKJ2+XATlq/D5YZdhbFBOVJITc+bxfDYfcIfqfTGvWsQKbvyxVF2ecAtgPq0o
         TmfGwHwhMpqjoLHI4HQAl7elfn60DRSp9OrPUktXICPEhSn2neZLkPkvzh3pF34JE+9H
         MK6Cs9TxnmuKOX3hOeABZj560cBL9OQE9gsMWOdr9DV0TjA60yrbypdn4vAFzG83UntF
         oDyeaJ0vmXHP7Vx7LybTOsjmf5uXop2ediaeIFMpiO7W0n3mdySpsreivxDZAf+HvIzm
         se0bF4Y8c4f4S6zgrfbvwYsSlw+x9mN/fM7YwPdP/pLgbFzWk9E9VQagi2JhGQo6QTC9
         xt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721628284; x=1722233084;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FTucK2xz2U8aT8vxvUv3vyhW6VzTN5EqQ49H5XGmatQ=;
        b=GiRb8R54pRmjuRezkOZvRGG8NhjTgL/6ucn5BVVpOxYkvj4+siGTCQd6fNH+m4G8OL
         AJf57oR1vpdnd1ZhLDk1W9pihPqW/mCMqXLcm+TbW+Q5KjT7UvuqGwFigKPJ/9UvS5it
         MJ8ingSgooJ99XujrxlZUdl4/tUq2QDF94TPPt2lMTszPj2P7CBQ9f4Ca5GibNBJHdRO
         qphg61lwXZLP36fsR+3NUCrvksZ9x/Xj/mHL5wObcQAhxDvmIjG6uy9IYDS7fojAd4at
         TAPu78tpSschVEAfB8HfL8kk2uZexEaLR1szT6GKw8r8rnT9EWNvQhYnGLKHhEmwqFvz
         8LiA==
X-Forwarded-Encrypted: i=1; AJvYcCW+S5g5x2oKwnK5k2oGprtf3x2KFuBnP4BRGhMpSqgj5DEhFXmz2CN5IZ5kTb+U2UuESflRNb08ArTm/ZxdFX5yxfAvsLOm2wNdCVMa
X-Gm-Message-State: AOJu0YxpKD+WZQ5dxudU5gP2jJwQKakoyQPtqFiI9l4vQLfGmv8wuhNX
	WDUc5eJTiSQZrdBo+TdXhPtLySQ322VbihKLy0k+XNZezTs15oB6Q1pAwSPV/dA=
X-Google-Smtp-Source: AGHT+IE1yrmYI/YvsrJpviVoXNiAha3hIpUqJ/5LJ6PAsIemMBEPbfdWKUInAS/3p77IhvDDnTkaVw==
X-Received: by 2002:a05:6a00:1903:b0:706:b3d0:ffd8 with SMTP id d2e1a72fcca58-70d0869f879mr5075975b3a.7.1721628284180;
        Sun, 21 Jul 2024 23:04:44 -0700 (PDT)
Received: from [10.254.189.162] ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d1d998317sm1868716b3a.175.2024.07.21.23.04.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jul 2024 23:04:43 -0700 (PDT)
Message-ID: <d0918be2-8d4e-427d-ac98-32aecffe3a3b@bytedance.com>
Date: Mon, 22 Jul 2024 14:04:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched/fair: Decrease cfs bandwidth usage in
 task_group destruction
To: Zhang Qiao <zhangqiao22@huawei.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com
Cc: chengming.zhou@linux.dev, linux-kernel@vger.kernel.org, joshdon@google.com
References: <20240721125208.5348-1-zhouchuyi@bytedance.com>
 <20240721125208.5348-2-zhouchuyi@bytedance.com>
 <91e88019-52f7-4fa6-a14b-ca5ecb8e63cf@huawei.com>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <91e88019-52f7-4fa6-a14b-ca5ecb8e63cf@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello

在 2024/7/22 11:47, Zhang Qiao 写道:
> 
> 
> Hi, Chuyi
> 
> 在 2024/7/21 20:52, Chuyi Zhou 写道:
>> The static key __cfs_bandwidth_used is used to indicate whether bandwidth
>> control is enabled in the system. Currently, it is only decreased when a
>> task group disables bandwidth control. This is incorrect because if there
>> was a task group in the past that enabled bandwidth control, the
>> __cfs_bandwidth_used will never go to zero, even if there are no task_group
>> using bandwidth control now.
>>
>> This patch tries to fix this issue by decrsasing bandwidth usage in
>> destroy_cfs_bandwidth().
>>
>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>> ---
>>   kernel/sched/fair.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index b1e07ce90284..7ad50dc31a93 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6447,6 +6447,9 @@ static void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
>>   	hrtimer_cancel(&cfs_b->period_timer);
>>   	hrtimer_cancel(&cfs_b->slack_timer);
>>   
>> +	if (cfs_b->quota != RUNTIME_INF)
>> +		cfs_bandwidth_usage_dec();
> 
> This calls static_key_slow_dec_cpuslocked, but destroy_cfs_bandwidth
> isn't holding the hotplug lock [1].
> 
> For fixing this issue, i also sent a patch, but it be not merged into mainline [2].
> 
> [1]: https://lore.kernel.org/all/20210712162655.w3j6uczwbfkzazvt@oracle.com/
> [2]: https://lore.kernel.org/all/20210910094139.184582-1-zhangqiao22@huawei.com/
> 

Thanks for your information.

I think maybe cfs_bandwidth_usage_dec() should be moved to other more 
suitable places where could hold hotplug lock(e.g. 
cpu_cgroup_css_released()). I would do some test to verify it.

Thanks.





