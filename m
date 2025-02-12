Return-Path: <linux-kernel+bounces-511336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C2AA3299B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEB241889AE2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F7C205AD9;
	Wed, 12 Feb 2025 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GNaEO2hi"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35126271800
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 15:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739373163; cv=none; b=Mz1TuMxODB1W3RluvjXvcJD19J0gpPyJt27TsF+J25N0U6qO0gWHG/YlXZ6rC0lnL7baW9uA1ENwCHXUMhG5StQ1R4N4Hm2ILSwYWmRMWecIt5CJskam7Y9EqmAwcCHCPWox5ofFM9OnGzxL3VdXr2t6fUJD/lSMaqR3ihyEf9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739373163; c=relaxed/simple;
	bh=IHSbh6r5DGMhZN/8rWZQQsLrq0/FTXzKTkc6Gh9pAKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uitSN+g5JdduongrFYLAldoVVc0g0Dywkp5eMjsfP2ebC8bBdEw4NKeWHaSl0+w2Mq31j9xrWru92PeDN4Tu0yvuDBWD9ZKqhWcDClLTduZzOlqIkNYROUdJ0RMxOMWSGkM+c/lSVndc44GgxjpKswsLVx0+zbYNlGoqci+9Ug0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GNaEO2hi; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2166db59927so14380535ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 07:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1739373160; x=1739977960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YBs34c4qQHheJQVXIkvBxk26x9OYVq3E9NsfJIlzJr4=;
        b=GNaEO2hiqCvKgE13oySLduw++pti1rY6qtZfFCVtKna3X9nOsT0MZcHTtX1rbYFz1g
         s8/+qjWpNYHqnA7WTQd6tz+P76aJJu6EWr6hEIc+S4Dma80FiR3YpjlN0UnFoa7zQFI9
         HjcWoNPD6V6PllPlX1BS1LhbLegf3PDlfcc5BVA1dZPkuX+I2UvP6pouQb/fieg8Ry9E
         w2T3AEIPGD9NWK+OI5kx5MWsJXicfP+g3p5eN/u9576E8IKcQr6v/oQYk++fE5kkNwRb
         6ThHVaNc9KDuJosFyimB2D7DlJkQoMVcBq6gjb6GB6CGpsH2y5kVzo01Ii37uitAZ84F
         ZWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739373160; x=1739977960;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YBs34c4qQHheJQVXIkvBxk26x9OYVq3E9NsfJIlzJr4=;
        b=mBThYgMP57ykFn5aKQlSrL6YNRZ0eLK4MzCIcGXa2lHRv/6/uC6PXmgAopMtEg14RY
         EF70Zbxbbo+STLu/p6GwqNzN4H9gXXKcRmOdavFVU6D1KwDX8O5gyLHwairUs4+6W9SA
         QJjnpq+z/hna8IOcO8hTB96JHmMuueZTQdtE8mbcnV8B40rSIlkdNvrf0xfn2JWoBAxv
         /UDZjelPVYWspWmCP8szdZrvirq/8w4uG/VavmhAso5ktf/YSlx193lqWAilITGHbPhN
         s7YvAOSF6YjuZDjjdZ/8J/6WVIqf9e4irv54bNF6EywNZ30hJTTtneLH3p8jHVKsgHr5
         JejQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6051KFkUtB24UeJqZW5s3fO8IM/E2DP/9w0676WFhO2az+h+emRBiuLLUNTjygTM1Zby+eVlxDfYpmVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYyedITLKktEtXTLefc2Qdfv39Gz3a96zrdOzqgnngUCStGB4I
	oR9GLu5ZmnauVGITIiXgKD06TaIcJZoy9sByhzudo2N/go5rDJgAJcdYp6lF07c=
X-Gm-Gg: ASbGncvW2ZoslyLtCZmjxIm5l6eYZyxLMuP0+UYnP4tZqUi5wZ1DKR0v/eLEZSxtoOu
	C74eD4A9H5JhXtLs0n057lQp/291GcMAsxZwozWTQi7wN7C9tkXHlgYkatj6jrf9vAo1uA4lpoX
	GA0+fw7HW5Aj4uh1w9ikrlpGFZx/5XBFVsOWIdQJsagzVRFSEaSaxrHDPpJk08vYFRUAmWxkOAk
	hyWDtABxWfVaDaH++9sjxZjLydh9KZy+ak6twoqcO9g+gRc2+aJykeRJAhiDY+kgDZ7bb6HKTl/
	elrkcqLamgzC0ZyGyyizbokEfzRJOiThr4a4
X-Google-Smtp-Source: AGHT+IGouYzGmjROSox/PWnSlVRVChVYl2AaCCEc0qnqfNRunaVXv0XRlbBjS/AwWeQ6AnVHMD63tw==
X-Received: by 2002:a17:902:d512:b0:20c:f648:e388 with SMTP id d9443c01a7336-220bbafb2b9mr22054375ad.7.1739373160274;
        Wed, 12 Feb 2025 07:12:40 -0800 (PST)
Received: from [10.4.234.23] ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf9ab0233sm1613044a91.44.2025.02.12.07.12.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 07:12:39 -0800 (PST)
Message-ID: <4c0f852e-bf79-4e59-be42-bdf11fb92f3b@bytedance.com>
Date: Wed, 12 Feb 2025 23:12:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH v2 3/3] cgroup/rstat: Add run_delay accounting for
 cgroups
Content-Language: en-US
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, Yury Norov <yury.norov@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Bitao Hu
 <yaoma@linux.alibaba.com>, Chen Ridong <chenridong@huawei.com>,
 "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250125052521.19487-1-wuyun.abel@bytedance.com>
 <20250125052521.19487-4-wuyun.abel@bytedance.com>
 <3wqaz6jb74i2cdtvkv4isvhapiiqukyicuol76s66xwixlaz3c@qr6bva3wbxkx>
 <9515c474-366d-4692-91a7-a4c1a5fc18db@bytedance.com>
 <qt3qdbvmrqtbceeogo32bw2b7v5otc3q6gfh7vgsk4vrydcgix@33hepjadeyjb>
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <qt3qdbvmrqtbceeogo32bw2b7v5otc3q6gfh7vgsk4vrydcgix@33hepjadeyjb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/10/25 11:38 PM, Michal Koutný Wrote:
> Hello Abel (sorry for my delay).
> 
> On Wed, Jan 29, 2025 at 12:48:09PM +0800, Abel Wu <wuyun.abel@bytedance.com> wrote:
>> PSI tracks stall times for each cpu, and
>>
>> 	tSOME[cpu] = time(nr_delayed_tasks[cpu] != 0)
>>
>> which turns nr_delayed_tasks[cpu] into boolean value, hence loses
>> insight into how severely this task group is stalled on this cpu.
> 
> Thanks for example. So the lost information is kind of a group load.

Exactly.

> What meaning it has when there is no group throttling?

It means how severely this cgroup is interfered by co-located tasks.
Both psi and run_delay are tracked in (part of) our fleet, and the
spikes usually lead to poor SLI. But we do find circumstances that
run_delay has a better correlation with SLI due to the abovementioned
method of stall time accounting.

They are treated as indicators of triggering throttling or evicting
the co-located low priority jobs.

In fact we also track per-cpu stats (cpu.stat.percpu) for cgroups,
including run_delay which helped us to decide which job to be the
victim, and also provided useful info when we diagnose issues.

> 
> Honestly, I can't reason neither about PSI.some nor Σ run_delay wrt
> feedback for resource control. What it is slightly bugging me is
> introduction of another stats field before first one was explored :-)
> 
> But if there's information loss with PSI -- could cpu.pressure:some be
> removed in favor of Σ run_delay? (The former could be calculated from
> latter if you're right :-p)

It is not my intent to replacing cpu.pressure:some by run_delay. The
former provides a normalized value that can be used to compare among
different cgroups while the latter isn't able to.

> 
> (I didn't like the before/after shuffling with enum cpu_usage_stat
> NR_STATS but I saw v4 where you tackled that.)
> 
> Michal
> 
> 
> More context form previous message, the difference is between a) and c),
> or better equal lanes:
> 
> a')
>     t1 |----|
>     t2 |xx--|
>     t3 |----|
> 
> c)
>     t1 |----|
>     t2 |xx--|
>     t3 |xx--|
> 
>        <-Δt->

Yes, a) and c) have same cpu.pressure:some but make different progress.

> 
> run_delay can be calculated indepently of cpu.pressure:some
> because there is still difference between a') and c) in terms of total
> cpu usage.
> 
> 	Δrun_delay = nr * Δt - Δusage
> 
> The challenge is with nr (assuming they're all runnable during Δt), that
> would need to be sampled from /sys/kernel/debug/sched/debug. But then
> you can get whatever load for individual cfs_rqs from there. Hm, does it
> even make sense to add up run_delays from different CPUs?

Very good question. In our case, this summed value is used as a general
indicator to trigger strategy which further depends on raw per-cpu data
provided by cpu.stat.percpu, which implies that what we actually want is
the per-cpu data.

Thanks & Best Regards,
	Abel


