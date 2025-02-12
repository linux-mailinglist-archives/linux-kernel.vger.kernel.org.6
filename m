Return-Path: <linux-kernel+bounces-511345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25111A329BE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB10C7A19F0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E36D21146B;
	Wed, 12 Feb 2025 15:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VEXBTZb5"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130821D5176
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 15:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739373451; cv=none; b=OkO++dy3i7Gx7mf8jPJs0s0/ROsKZCP6MRBqDoQc+4FNQgzKTOf7wih00ETIYHDk2oXMRgCGkIVlH3KWTyanRRHpcx3tAnRdmOSuSK/ibzM6lE2QLEd7Wat3bm+vQMH+I5Ma8ykJGtz4G4GY9j7huTznv086Yif/8YZ3jDiWG+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739373451; c=relaxed/simple;
	bh=uDCf5cSTeU5fMxoojUj0qD4NkNwcI1qy3O/oPBYOdVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ujLf7ydyc09P8kHQYlFTXaJS7abPBQ8m6dGiaUmfLOypsVhxH4QAzZjVq88xNfwwmQTqBiH1fE1HzTTcLM3YzhTXFWRSgq2JivqdkJwJmZ9l6nz8xawUK2EvjZYj4TMFgWKSjfJ30/J8w3m5HFa+kQsmAvs9/EqFT5s6Hs05aq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VEXBTZb5; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21f8f3bd828so7801905ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 07:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1739373449; x=1739978249; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j4Y5qtwiWWBCUuyHL6kUsNo5ULsNCnhaneGE9b6ZnxI=;
        b=VEXBTZb5Cw2hQwScsrvMOfAGQtVDNZO6ANxq62To2IQtKXlVxEDJ2dWnmfSCIJxAiq
         6ayn2baesmrN52JM1Rk85hHgRfYGaRAd2YqyWS/Crz5t50hMa5AjKGm756S6B28knvCn
         /hLVW4A0hAgmxPdC8XmNY1eDO6jDw/ZarmAKL5piKjOYBPv+BEyhOXj6DbHrpBlpY/0a
         rlTn5dFKyGDAY70Fu7YhF0nrDPn/jjmZfGTvsl3gxg6vq8i9J+qO/nIw68suzdVH5Ctm
         Ks1mDO4D4xft7re1sPkVv92Y0b16hn9DHcFpROHBZzxf0hym2CDUc31v3FYjeKD9ARBy
         Vkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739373449; x=1739978249;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j4Y5qtwiWWBCUuyHL6kUsNo5ULsNCnhaneGE9b6ZnxI=;
        b=mx2dTovj98lTny4RPkGNzzs2oreqytuPX/yywjYBgEpiNHzA14cSPkmSy7beh0Kfm4
         iI+OhCbHaBgoDQY0gL9xYxva9vAVFDWQHMPYW2hAIE8v9Cj4i2qRyHST+dqRU9/XU3dT
         6zMmvn5ZxPk4MCBvyUJe/9ICa1xfaRzX8s2qge4jhtWW5X6eVX60j9dcuOXnC4b6oLmh
         yCrNfh+9QBdieL3EwV+MINvz09gEr6Pa8bCHZ3t8sQqednnWmxyNjsn+NRw1v7k5YSC4
         nkCHOit9Hbd6YQV68BpctjAqTQ7TVFkMj0Ck53ySFF0whSjjc8XxtVuTKp0JkvoBVQqe
         XGsw==
X-Forwarded-Encrypted: i=1; AJvYcCUWUyq1ezzL34LU/EF10uwMcSKQA/lbDBGGYjL6wkCPsUFKRvUbtL38ZmoWWkm1zJtlOuEubzaJ4F9Bn5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWov0eg71EwFwzo4WWNAUcXimk7L7osATL1mnjCLXHem6WTlSu
	mMLlrIH0EoG2Jt6tXIafcYlyjOAjbK0wlIk5Go7px2Zp5L7rt4e792/YhkcGGXc=
X-Gm-Gg: ASbGncuL+Pr22QWx1niGjKPrfflqxnQBd3iApwJM0p7+QNZZjWds84k8cVOjQPzO5+i
	nISduIwrLU4AfVwM0vuOlxtLbzIoMlU91Afmf8bAijIXcbN0la+pDR/xmAFQOkZD0a/Y85YTi7v
	88aqb4ufOcLNcfZeeAggmk19PGMlCLzQ+phn3TJrdUTCmwM5NAQ4QqkTkiCK+J5UnGX/fBfzVlL
	Bx779sDDXqvw4cbdlB0dGWsKY5Uom9CPNCXdoT8pHd7+5VGGBSG3CrDTSUJQWT31UQ8vrdzAX6T
	Iy8m0HzPLVj+FMHjGMt3m/0sCFJm6EaOT7+X
X-Google-Smtp-Source: AGHT+IHSDBOUcY4DgChpk0VgGr5Q3FBvaJPNKMmexpCLPTtk05TaIQ9t4qmleE/HZFgIUTI1TQ/PFQ==
X-Received: by 2002:a05:6a21:e85:b0:1cf:34a9:63d2 with SMTP id adf61e73a8af0-1ee5cd41f1dmr2188229637.9.1739373449062;
        Wed, 12 Feb 2025 07:17:29 -0800 (PST)
Received: from [10.4.234.23] ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ae7baasm11351432b3a.73.2025.02.12.07.17.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 07:17:28 -0800 (PST)
Message-ID: <83a9d6c0-47bd-4257-9162-a926c1ecd1d0@bytedance.com>
Date: Wed, 12 Feb 2025 23:17:19 +0800
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
To: Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
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
 <Z6onPMIxS0ixXxj9@slm.duckdns.org> <20250210182545.GA2484@cmpxchg.org>
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20250210182545.GA2484@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/11/25 2:25 AM, Johannes Weiner Wrote:
> On Mon, Feb 10, 2025 at 06:20:12AM -1000, Tejun Heo wrote:
>> On Mon, Feb 10, 2025 at 04:38:56PM +0100, Michal Koutný wrote:
>> ...
>>> The challenge is with nr (assuming they're all runnable during Δt), that
>>> would need to be sampled from /sys/kernel/debug/sched/debug. But then
>>> you can get whatever load for individual cfs_rqs from there. Hm, does it
>>> even make sense to add up run_delays from different CPUs?
>>
>> The difficulty in aggregating across CPUs is why some and full pressures are
>> defined the way they are. Ideally, we'd want full distribution of stall
>> states across CPUs but both aggregation and presentation become challenging,
>> so some/full provide the two extremes. Sum of all cpu_delay adds more
>> incomplete signal on top. I don't know how useful it'd be. At meta, we
>> depend on PSI a lot when investigating resource problems and we've never
>> felt the need for the sum time, so that's one data point with the caveat
>> that usually our focus is on mem and io pressures where some and full
>> pressure metrics usually seem to provide sufficient information.
>>
>> As the picture provided by some and full metrics is incomplete, I can
>> imagine adding the sum being useful. That said, it'd help if Able can
>> provide more concrete examples on it being useful. Another thing to consider
>> is whether we should add this across resources monitored by PSI - cpu, mem
>> and io.
> 
> Yes, a more detailed description of the usecase would be helpful.

Please check my last reply to see our usecase, and it would be appreciated
if you can shed some light on it.

> 
> I'm not exactly sure how the sum of wait times in a cgroup would be
> used to gauge load without taking available concurrency into account.
> One second of aggregate wait time means something very different if
> you have 200 cpus compared to if you have 2.

Indeed. So instead of comparing between different cgroups, we only
compare with the past for each cgroup we care about.

> 
> This is precisely what psi tries to capture. "Some" does provide group
> loading information in a sense, but it's a ratio over available
> concurrency, and currently capped at 100%. I.e. if you have N cpus,
> 100% some is "at least N threads waiting at all times." There is a
> gradient below that, but not above.
> 
> It's conceivable percentages over 100% might be useful, to capture the
> degree of contention beyond that. Although like Tejun says, we've not
> felt the need for that so far. Whether something is actionable or not
> tends to be in the 0-1 range, and beyond that it's just "all bad".

PSI is very useful and we heavily rely on it, especially for mem and
io. The reason of adding run_delay is try to find the piece lost by
cpu.some when <100%. Please check Michal's example.

> 
> High overload scenarios can also be gauged with tools like runqlat[1],
> which give a histogram over individual tasks' delays. We've used this
> one extensively to track down issues.
> 
> [1] https://github.com/iovisor/bcc/blob/master/tools/runqlat.py

Thanks for mentioning this, but I am not sure whether it is appropriate
to make it constantly enabled as we rely it to be realtime to trigger
throttling or eviction of certain jobs.

Thanks & Best Regards,
	Abel


