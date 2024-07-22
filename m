Return-Path: <linux-kernel+bounces-258601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D98938A57
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DEF0281194
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 07:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A541586F5;
	Mon, 22 Jul 2024 07:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="k7AIG/pj"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEC5158202
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 07:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721634395; cv=none; b=luyXpSvdprvKI3cCXby0qNSM9aLwbiU4jNKKN/DZg+pzGkO0yV3Jwx7PwZlVhanm41+ne3zp8Orv1lfrNNbDDzMK5JqteXoouCZB1PJFcX3uxsyVnhqHPXxE6VJrnBsbXCM5WsK18hr5JmaQSeINBBMtAucxyltxjhhGC6V9lJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721634395; c=relaxed/simple;
	bh=Dp/QhsbatvF3hBrR80X7+q5TbAEJOUdpQ8bDbChkvYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fXIOM/gdnSkIRSAKCbBfPGP3FQ9+WBJ/91t0RfHN8SxxI5D1UDiSjLumGQ/Z8tn2N4Y41/ZwKHJQOX8kVoOWBz5osLp1VOcfGoPpW2ByL4VfdaEYbG1dqzhFmUjto206SMw/RJq1OqV0KXpUd3gGAYJ+RxzZufw96fEITRxmcUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=k7AIG/pj; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-260209df55dso1933038fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 00:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721634392; x=1722239192; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2oZMADNy7ggKDtNiN/O71dpaVIuM51IzWkENQuhDmE=;
        b=k7AIG/pjqQWLah45D/MttYT74a0AR6bVg/mW+Y+1AM1DGK9yz0mOqOSLye9plHM/I1
         7PYiIZbqAVQkmzOK66DIWoy8yJq4Prb+Z2rCMEkkTmmwB4AldflokUyoTnCexDsT7zFI
         bXIpZNciNIZ2EKMegqZN2UDp7acMp0YvXVyzerqs+OQF9JWj5fla+iFbqswV3dOG9BD8
         XpJmEeTzgrz7AEHe8HB+ASy/9YgrURJ+YNhR9Ek4cIT+JPJee+TWdF7LHGGkk3d/baqs
         DJmGIMjTxBaDBHIJy1ts1KTENqRSLFPqjihrmSJwKf9UWDRBDYSUePXHo5XM+2ccLLJo
         Gjyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721634392; x=1722239192;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c2oZMADNy7ggKDtNiN/O71dpaVIuM51IzWkENQuhDmE=;
        b=v4IBHaj4NnBcq744HCdfMoU/ttqPUGKxjbRd686pDwdYXNoxNF/tRKf0MHsAGBvfnk
         DqiEJEx8GD+uKb+mqmdLWYVXZY+M/gofu141NjXSL8tH3YjcVbFG/EQ1DL6R5+zwAJJt
         xrndlXIqi0KEZ8/kZ3D50Ak8JDqSAxDX15FWKRKJSel49Q7e0dSHVsrJvTewJ4VL6nrU
         SvPkFA4qXURut4BxQ3BtqfyBFrOQ/MFzHkRLCJV/P5joVbTi9OiciuBbmBJwAb9zU/4N
         b85mAggiEOzjFQ01ySLU6ni8M4B/cM4NyYNDfGoCTNZo5c1WbTftplA1m0zC3kN9g5Hr
         DjeA==
X-Forwarded-Encrypted: i=1; AJvYcCW9otASSyoz8CP1dHkcv1zkyudODKNYxegp5cmJiGhdP1Xml8yNz44sdAertMiiCLpKThlLGuCKXjC5RAYXt2FZikZHOZihtDmsTfte
X-Gm-Message-State: AOJu0YygT9Ks0sZntAGXiBu4uZvWe1yu/idv34KMxmx9nUfFuAeGMt/K
	KCgWeMVGCdBATd3ReGDf26JfEderZbDIEwSUWoAwDY/ITpDUsm9L0Xq0p0JXYC4=
X-Google-Smtp-Source: AGHT+IE84mGJX+1WfMsfj781hYl7v/wzKO7/MrM1QhDiVL85SSxVRn/TtRPv4Ycrmkequ60U0gwaqg==
X-Received: by 2002:a05:6870:8183:b0:260:e678:b660 with SMTP id 586e51a60fabf-263ab65243cmr4660701fac.51.1721634392001;
        Mon, 22 Jul 2024 00:46:32 -0700 (PDT)
Received: from [10.254.189.162] ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d1971a5bcsm2334447b3a.0.2024.07.22.00.46.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 00:46:31 -0700 (PDT)
Message-ID: <e4e3a63d-a5f2-4c1d-a9da-4ddbc3693450@bytedance.com>
Date: Mon, 22 Jul 2024 15:46:24 +0800
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
 <d0918be2-8d4e-427d-ac98-32aecffe3a3b@bytedance.com>
 <14c3db2b-5de2-4f1c-b4d4-6183568b8c24@huawei.com>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <14c3db2b-5de2-4f1c-b4d4-6183568b8c24@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

在 2024/7/22 15:16, Zhang Qiao 写道:
> hi
> 
> 在 2024/7/22 14:04, Chuyi Zhou 写道:
>> Hello
>>
>> 在 2024/7/22 11:47, Zhang Qiao 写道:
>>>
>>>
>>> Hi, Chuyi
>>>
>>> 在 2024/7/21 20:52, Chuyi Zhou 写道:
>>>> The static key __cfs_bandwidth_used is used to indicate whether bandwidth
>>>> control is enabled in the system. Currently, it is only decreased when a
>>>> task group disables bandwidth control. This is incorrect because if there
>>>> was a task group in the past that enabled bandwidth control, the
>>>> __cfs_bandwidth_used will never go to zero, even if there are no task_group
>>>> using bandwidth control now.
>>>>
>>>> This patch tries to fix this issue by decrsasing bandwidth usage in
>>>> destroy_cfs_bandwidth().
>>>>
>>>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>>>> ---
>>>>    kernel/sched/fair.c | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>> index b1e07ce90284..7ad50dc31a93 100644
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -6447,6 +6447,9 @@ static void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
>>>>        hrtimer_cancel(&cfs_b->period_timer);
>>>>        hrtimer_cancel(&cfs_b->slack_timer);
>>>>    +    if (cfs_b->quota != RUNTIME_INF)
>>>> +        cfs_bandwidth_usage_dec();
>>>
>>> This calls static_key_slow_dec_cpuslocked, but destroy_cfs_bandwidth
>>> isn't holding the hotplug lock [1].
>>>
>>> For fixing this issue, i also sent a patch, but it be not merged into mainline [2].
>>>
>>> [1]: https://lore.kernel.org/all/20210712162655.w3j6uczwbfkzazvt@oracle.com/
>>> [2]: https://lore.kernel.org/all/20210910094139.184582-1-zhangqiao22@huawei.com/
>>>
>>
>> Thanks for your information.
>>
>> I think maybe cfs_bandwidth_usage_dec() should be moved to other more suitable places where could
>> hold hotplug lock(e.g. cpu_cgroup_css_released()). I would do some test to verify it.
>>
> 
> The cpu_cgroup_css_released() also doesn't seem to be in the cpu hotplug lock-holding context.
> 

IIUC, cpus_read_lock/cpus_read_unlock can be called in 
cpu_cgroup_css_released() right? But cfs bandwidth destroy maybe run in 
a rcu callback since task group list is protected by RCU so we could not
get the lock. Did I miss something important?


