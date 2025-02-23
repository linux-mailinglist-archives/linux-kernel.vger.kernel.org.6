Return-Path: <linux-kernel+bounces-527627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09719A40D6D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 09:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 766A23BE166
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 08:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0741FCFE2;
	Sun, 23 Feb 2025 08:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="R217fZy0"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EE31FC0E6
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 08:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740300368; cv=none; b=WvqeDRZPWBlAkTBB0PAcXx55moA7inLbz8WsSgfer+IDbh5RJk1lDcmenuFn0KGJSdmZ/so7bgl/ji9PZc7FIGyuU1YwH29tSMDczu9MC8GdDkBojbb1RI5zFe6Op7nLliCqo/zeoAOpQRGQ/OJeThvkby0VqD5toxOowmyaIWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740300368; c=relaxed/simple;
	bh=DhOhL98HKSlfxfm8aXGegeM9ziARLp58xw8GPE0QOZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SCj+AeLKZ6KyBaZJ4EJjU7PVKbTSvPEaE989IzREhS1n4mbzVbFNZZ0JYfIn3oKQT0z64WnzDZ+WnW8i9zYLiSbWQ5FQeUERXp74nPEuvGJkPbBB7V/7kXfD/Uh9b3gD+vZgYo6LAjxYic3eh0jjZ3s+TVX73gIhaWLVadso4d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=R217fZy0; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fc317ea4b3so950156a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 00:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740300361; x=1740905161; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fARdZemRNN4lIMHQeupATWlyXvjiZ5YaX4PJLgbPEck=;
        b=R217fZy0n3Uv0Fn4vHfYMWpugEqxtbZV3AI4khEaszSZLjjufEzPf5S9/ne17K98Ha
         c7qY+XbzniT6BEXfncMpP35RzixuhjWT5TlChhF+UteDAfH93viI3QzmjxPFY9aOmUZM
         nyHHNwIks98UMDD9B1eRGG8OwYyeCFgpieikD3wuT5GnkIAJXWM3vYgO5ATlvMDytUxj
         bOG7Xm3bSDXAIDNR0Rk+KsY0CIIlDlVzhO+YIF1s4mw5ATM2EpNW9l1IF3JL9HOvrNAE
         IpywWUbgXY35ItT6tojOR4KWJl2NIP31gOiRUL6pBJNwNdNy+oiwzCoX1etedFVuzJVK
         OK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740300361; x=1740905161;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fARdZemRNN4lIMHQeupATWlyXvjiZ5YaX4PJLgbPEck=;
        b=U6nAkH89dJoYHL58jquGxuVEWC15eg9PH0FbrYutHkpmlyDwl7QBXtCJp3p35Qfcts
         RCP8dLp7Pf5e+9Ibe8b1cEPQK1gUb+WhoH1LjeClu4hS1au1S6neDG6WayKwpImUoUlZ
         pBTp3RbEdKZSJsj4uoKyzonDkNePy3ka6I+Z6oUqmxT+3k21My8xtFOR+boJYh3JvMiL
         ceyyK8b9m2Pu0CP4sTLoi/P/g4ZN5hLI7N4mEtbNwM5CJQ1M/Os9e0/K8JkircyNrRk+
         Rv+OfalkpGDuJW7CmuRRYGO7mjU/Ji3QZ/jW5KoJDyTu1Bsv+QEtWHynRyQ2rvoR2i3F
         QGTQ==
X-Gm-Message-State: AOJu0YxFO6Ltxm6qbiHF4QC85GFJcrkxpg7wkz47Yfc+LhSWdizZFcj3
	ASUSluFGGLoMI0ybYqjNDvvCQfpZU/VOlr3EbxJm9hZFp3jX/vF9Vbv4buh3reQ=
X-Gm-Gg: ASbGncsbXYGbVh6XCzor4vPGKdvh1v/CL+MwS1cqS4bfTbkCU1QfCQ6GMPg9BjwBocB
	oFCYX1N1SmS4c9s8k6qGYVVgsp8FU+7ZhAHkjQa1qO2iqiKo0CiWbraU8wQW8cS2PbZnwTl4161
	5HegmL4oTgueNwpkk9uIMjNqSYiRqMtN79ghfMQxeuZQ7mbQKQ7aPSp/xyIFqC8bJgubHHFKWfj
	DXVy+bX37VaH4e0xmVcOeoJL6ALpHkt9dzXATKQwgxFowGEIumLyIXY4oOTninxQ7ZqBgF5nEmr
	rUObK06DWkmYnuOaFB08ue5DE8zlOiFw9cJAE3EnjZUa2Qcc4LwKktQIopkRSbHGWiSHOzGHs/L
	FKXJMxVG8ZhOwbg==
X-Google-Smtp-Source: AGHT+IFlxEBLplToG+esywlhszEAaN3NlRVA8UQFP2sp4KwEIOoPwUTT/OJPy59g2TIJ3AJgF1Xuvg==
X-Received: by 2002:a05:6a00:190f:b0:730:8a0a:9f0f with SMTP id d2e1a72fcca58-73426dd835emr5886263b3a.7.1740300361273;
        Sun, 23 Feb 2025 00:46:01 -0800 (PST)
Received: from [10.200.58.71] (151.240.142.34.bc.googleusercontent.com. [34.142.240.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73271a02648sm13932582b3a.107.2025.02.23.00.45.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Feb 2025 00:46:00 -0800 (PST)
Message-ID: <e7a81f13-6f09-4a7a-9d85-0ba4885442bc@bytedance.com>
Date: Sun, 23 Feb 2025 16:45:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH 1/2] sched/fair: Do not let idle entities preempt
 others
Content-Language: en-US
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Cc: "open list:SCHEDULER" <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Josh Don <joshdon@google.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Tianchen Ding <dtcccc@linux.alibaba.com>
References: <20250221111226.64455-1-wuyun.abel@bytedance.com>
 <20250221111226.64455-2-wuyun.abel@bytedance.com>
 <e7c4d27f-6b98-4cd6-85b8-9c4672acdef4@linux.ibm.com>
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <e7c4d27f-6b98-4cd6-85b8-9c4672acdef4@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/23/25 1:48 AM, Madadi Vineeth Reddy Wrote:
> On 21/02/25 16:42, Abel Wu wrote:
>> A task with SCHED_IDLE policy doesn't preempt others by definition, and
>> the semantics are intended to be preserved when extending to cgroups
>> introduced in commit 304000390f88 ("sched: Cgroup SCHED_IDLE support").
> 
> [snip]
> 
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 1c0ef435a7aa..4340178f29b7 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -8778,12 +8778,15 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>>   	pse_is_idle = se_is_idle(pse);
>>   
>>   	/*
>> -	 * Preempt an idle entity in favor of a non-idle entity (and don't preempt
>> -	 * in the inverse case).
>> +	 * Preempt an idle entity in favor of a non-idle entity.
>>   	 */
>>   	if (cse_is_idle && !pse_is_idle)
>>   		goto preempt;
> 
> This patch doesn't apply cleanly on top of tip/sched/core because of the
> commit f553741ac8c0 ("sched: Cancel the slice protection of the idle entity").
> Please rebase it.

Will rebase. Thanks!

> 
> Thanks,
> Madadi Vineeth Reddy
> 
>> -	if (cse_is_idle != pse_is_idle)
>> +
>> +	/*
>> +	 * IDLE entities do not preempt others.
>> +	 */
>> +	if (unlikely(pse_is_idle))
>>   		return;
>>   
>>   	/*
> 


