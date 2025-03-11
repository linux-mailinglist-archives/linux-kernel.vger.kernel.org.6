Return-Path: <linux-kernel+bounces-556136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CCAA5C155
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E113F3A50E8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1D1256C7B;
	Tue, 11 Mar 2025 12:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P0Eoh66Y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F7D241682
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696500; cv=none; b=PGP6bk8QqpTvO5Aex4oTqT42BqalIVVsxM2tGoMwg+HddMF5CKGHEYbb+JTtiuvLnNfqh6iflM4gArT7VerTYNNv+VLHgPfr0ZEd+E7+6HC0Hj6PZC9HgggUvAHgKwQLhnqXPLzbwdUQRJbeZES5KMNWVfGFn8jFWPfWkTXAM/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696500; c=relaxed/simple;
	bh=aKiGzqdBbxcc/5cbLnhvQZp99FQc9SzjEqGyeRvi3UI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=e9tURgx7PVdNcnU+LCEoM4TjwWQxu4A4SpvE+d+1rajHaUX6jhqmAcuo9pBLTpfMXcxAfogbIYT0mzKwxFOsxkEAQ5zBUNGagjwg2L3lAraqcILpsQaymZrZg0jBVKlSiSHhM7KsNAP6BW6EWMmCmRHvCngJWjVcv2WrbZoXi88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P0Eoh66Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741696497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YVRBGKiRGPzk/Nusnk5D+UYIhSnWxiHi8h1c+qO5IMs=;
	b=P0Eoh66YbkRqkmeanV64C9h4l/PWwOSltNmruLygYvi3oPDscNKulhd+kby2dvIWk9/Dk5
	5htgLRDN8ZrpvMj+/khh/XCmmWuy2V0qmt9nuT6UrUh1Ypie9zbX6V4MM10f9KtFHiqi91
	50FVfLM+mQ1l/+xwga0sKKOMK5PfoA8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-DvRMl0ppPvqrsPBUg77RRw-1; Tue, 11 Mar 2025 08:34:55 -0400
X-MC-Unique: DvRMl0ppPvqrsPBUg77RRw-1
X-Mimecast-MFC-AGG-ID: DvRMl0ppPvqrsPBUg77RRw_1741696494
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e6bb677312so101733756d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 05:34:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741696494; x=1742301294;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YVRBGKiRGPzk/Nusnk5D+UYIhSnWxiHi8h1c+qO5IMs=;
        b=ERjwjSUte1YrT4L3h9AMRPGCrlg4OutPr93diLCn0EPLwsIC7dXmGOou1d8IvPCuzO
         katx8EDqciIZUdTMrAs+2owPPglUIYMSPzQpibkeQtUcNaU0v35BNwLadcCZUG/TaFY2
         fZbDg6Xxaat2kILLYpBQSbn56K2gCYol4/8dHBVuI6f7E5a489Rsqr7mqu3phvQ35TVe
         RqcTRR1QVaVd8xV2bliHbw+QldgQJzNBAF2PaffeC+UjxY1JQpo4zNdQCp3KHJEvWhFG
         yli5b/uXdunXwkH+M8vw62j/6hIciqPpjDoUHCtumROM5ZXDT5vMEFejO22mw+Rg0EfF
         F8GA==
X-Forwarded-Encrypted: i=1; AJvYcCVTmZGSurpDKq8cFu4XapgsFUdbwxE1/RxqDVpwo4tH5gaJq3BPTcUxpiKAy2wjgapf/tOSkYrJbf3pHFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwscYntzgHOkfLzrYJIu4Q1PtzA8fD8mzkGMDufgOjlW25KoEWR
	/wxF107xeHm3UXjDHB3qRmutNAYonjpie2ipHwb96uG1TjxQUGLFd3i6iCSH25S0O+hW8XGNou+
	wWgmLHiI2cwJ1y3ZQaaETX4t4hLY3iPqEYA+4rcxrW7M0Nci/ovo4gIlrhr6KdQ==
X-Gm-Gg: ASbGncv+U4ERs/FQ93IwPcs4IxfP+SDmGurWCI7+ru1XG0Vblt99qK2zO3TXh1op8e0
	CSrq7RtJH9Tofkw6mR/RFqRTjtT/17yqR4cR9OznhZL8e4drHgrmCz1MzpFcE6itMgXUGrHfS9v
	DecBRPuM1UXYM9c0fLyF8tWNbhtsgQC62AZsGgQ4iTJcyJ4M5fEJ5yp6Q5GnnVVAiAWXuxcunq3
	zARuPbPdGMyZ0WkXjFceixd0z4aWyWsTo2Lz5hyMWZp28ME/wv7HgW5M/PzACmMov4sVLk2IIp6
	CeCf5c4OKaH86b6/On4DWlLCdNRXbJ4w+diM2HKRD9kzHlVfRqRuGdHbcM93tg==
X-Received: by 2002:a05:6214:230b:b0:6e8:c713:321f with SMTP id 6a1803df08f44-6e9006ad612mr249639506d6.35.1741696494682;
        Tue, 11 Mar 2025 05:34:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1X/5pNm8jSwSPWY9K6moKHuVMLqYbTwchEAI60r4jNa2+YfXoHa7A8T5XAznABUUEwfsmcg==
X-Received: by 2002:a05:6214:230b:b0:6e8:c713:321f with SMTP id 6a1803df08f44-6e9006ad612mr249639246d6.35.1741696494346;
        Tue, 11 Mar 2025 05:34:54 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f7170312sm71580526d6.114.2025.03.11.05.34.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 05:34:53 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <be2c47b8-a5e4-4591-ac4d-3cbc92e2ce5d@redhat.com>
Date: Tue, 11 Mar 2025 08:34:52 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] sched/deadline: Rebuild root domain accounting
 after every update
To: Juri Lelli <juri.lelli@redhat.com>, Waiman Long <llong@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Qais Yousef <qyousef@layalina.io>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Phil Auld <pauld@redhat.com>,
 luca.abeni@santannapisa.it, tommaso.cucinotta@santannapisa.it,
 Jon Hunter <jonathanh@nvidia.com>
References: <20250310091935.22923-1-juri.lelli@redhat.com>
 <Z86yxn12saDHLSy3@jlelli-thinkpadt14gen4.remote.csb>
 <797146a4-97d6-442e-b2d3-f7c4f438d209@arm.com>
 <398c710f-2e4e-4b35-a8a3-4c8d64f2fe68@redhat.com>
 <fd4d6143-9bd2-4a7c-80dc-1e19e4d1b2d1@redhat.com>
 <Z9Alq55RpuFqWT--@jlelli-thinkpadt14gen4.remote.csb>
Content-Language: en-US
In-Reply-To: <Z9Alq55RpuFqWT--@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/11/25 7:59 AM, Juri Lelli wrote:
> On 10/03/25 20:16, Waiman Long wrote:
>> On 3/10/25 3:18 PM, Waiman Long wrote:
>>> On 3/10/25 2:54 PM, Dietmar Eggemann wrote:
>>>> On 10/03/2025 10:37, Juri Lelli wrote:
>>>>> Rebuilding of root domains accounting information (total_bw) is
>>>>> currently broken on some cases, e.g. suspend/resume on aarch64. Problem
>>>> Nit: Couldn't spot any arch dependency here. I guess it was just tested
>>>> on Arm64 platforms so far.
>>>>
>>>> [...]
>>>>
>>>>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>>>>> index 44093339761c..363ad268a25b 100644
>>>>> --- a/kernel/sched/topology.c
>>>>> +++ b/kernel/sched/topology.c
>>>>> @@ -2791,6 +2791,7 @@ void partition_sched_domains_locked(int
>>>>> ndoms_new, cpumask_var_t doms_new[],
>>>>>        ndoms_cur = ndoms_new;
>>>>>          update_sched_domain_debugfs();
>>>>> +    dl_rebuild_rd_accounting();
>>>> Won't dl_rebuild_rd_accounting()'s lockdep_assert_held(&cpuset_mutex)
>>>> barf when called via cpuhp's:
>>>>
>>>> sched_cpu_deactivate()
>>>>
>>>>     cpuset_cpu_inactive()
>>>>
>>>>       partition_sched_domains()
>>>>
>>>>         partition_sched_domains_locked()
>>>>
>>>>           dl_rebuild_rd_accounting()
>>>>
>>>> ?
> Good catch. Guess I didn't notice while testing with LOCKDEP as I was
> never able to hit this call path on my systems.
>
>>> Right. If cpuhp_tasks_frozen is true, partition_sched_domains() will be
>>> called without holding cpuset mutex.
>>>
>>> Well, I think we will need an additional wrapper in cpuset.c that
>>> acquires the cpuset_mutex first before calling partition_sched_domains()
>>> and use the new wrapper in these cases.
>> Actually, partition_sched_domains() is called with the special arguments (1,
>> NULL, NULL) to reset the domain to a single one. So perhaps something like
>> the following will be enough to avoid this problem.
> I think this would work, as we will still rebuild the accounting after
> last CPU comes back from suspend. The thing I am still not sure about is
> what we want to do in case we have DEADLINE tasks around, since with
> this I belive we would be ignoring them and let suspend proceed.

That is the current behavior. You can certainly create a test case to 
trigger such condition and see what to do about it. Alternatively, you 
can document that and come up with a follow-up patch later on.

Cheers,
Longman


