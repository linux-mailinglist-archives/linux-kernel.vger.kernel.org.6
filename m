Return-Path: <linux-kernel+bounces-519724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5ADA3A115
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82CF31680D4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20E326B941;
	Tue, 18 Feb 2025 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YI32NXG0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915B5211499
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 15:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739892238; cv=none; b=eTdJ9HttSLM0IIWBCiWSYGnxP8ZothXPsYDUChr9xh6Qn8GHwKRVIdtNrVvnGzOfM/6TtNocaxEckQ6IrPkG5FhSA4kAUr9aFIA1YOqkTJAH3wFKapWEVWT/DxmNHympq9MIHK8HYNn1mn4tMry6L7koLrVIF3aWhtze6BMIvCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739892238; c=relaxed/simple;
	bh=I++1OfaaY6kszWN29nHAexPRjJpGYk7wMR7qYXgrmA4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=d5jQHs67MExmph6hEI18P+vSjC5kAhKFUJYwsFh6DmZO53Gpkt4M9H3SJt6uH+V0IhhxR+SOS/+FXdHRbL+VtyI9HbumflO1QFcr82dmNOOfb+lmzvaPwnd0Gf9HN2YlvBUI37ld7XeLdSEmJKAsxQKcfq5D7/c6YgCZDc4nZvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YI32NXG0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739892234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AVxAiNMCdsH9bOyFBAQ4oaOYQMHCUBzRtQUKLspv+ZQ=;
	b=YI32NXG0sd9ohBXD2WoLOuz0qdTOBSFU/7E+VNi2WjP7uWft8se5gULE16g7r1Lc+txAaZ
	Zqzh71ECRvVh9jtFlR7X3M5CmdUmNkYYIRo4qDiIILt7vBARKxkrrKUl06liVZPJn6jJlC
	tW+9fZhcHeNPdvOXWOIPphQ6Iwo/WRA=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-4zcgSJSVPFap5ImwMubxQA-1; Tue, 18 Feb 2025 10:23:52 -0500
X-MC-Unique: 4zcgSJSVPFap5ImwMubxQA-1
X-Mimecast-MFC-AGG-ID: 4zcgSJSVPFap5ImwMubxQA_1739892232
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-2b8fdf98b0eso9809685fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 07:23:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739892232; x=1740497032;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AVxAiNMCdsH9bOyFBAQ4oaOYQMHCUBzRtQUKLspv+ZQ=;
        b=RrkSs9tCPWJW9xeMc2rXw3IFc0Gk3gBuRSFwQxY08ZCdCZ0om+cHhm4cLIgZ5tcd05
         16Yc4Syw8qVcUXgDY+FkkcO7tv5XUAo9I8i8SOmm/BUIrPpWXbKF4bnBlENTk6Ke6R/9
         Ll4qWbm0HJ/jftbVgnvE9vnbURMiexaPf55Hg3Vt92p3VXUA3vG4Du4izXLt7a8Pbkeg
         fqO0w+DymgnR5isKFsvVWl7VspJZL1m7KMKTdx1aEJs/UHFUIOfcUJsppEcRB7gJTtji
         1gDanPs7HHXG1fFWuf0EU/+fe+5JYO/WG6RdtekqIgdrOZV2gaGTLsa4vDITFLXv1sv5
         RuLA==
X-Forwarded-Encrypted: i=1; AJvYcCW60uFxR92csaONGPr4Dcskmv5DKgse7kvdwmO+dqzGtAcEP50S0PJfL9B3GsMljGRpaxt0cXTU6Ais0sU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqXcvV/xtJjLOZWBAQkGlhBTRl3hLnVxRyDdeNx0ePwW20bbiV
	p9pMI3z6+5jn1XQSK/dcivdT89iygFTnmVVHQLJOpfipcTbCiN2iWmZ9LntM0z5T+5o7TRbXZnC
	7YsHQ8eWYxUAeTsbL1rBq5ok7KaIVOs0PxOGCnUgORJDDy0cQKYnJkWTJU/aMbQ==
X-Gm-Gg: ASbGncvZYfmiTKgmnL0rHlnDsojECIRp1cDaL1cqv9p94zHKv8beqiB6F/ZuZlBGWF8
	Qe3ZXfCHvBFwYwN0xSywkWkzPNSl54JN1gXUkYOhQCP/f9X7PUqFNxOVeXdyQQUztXkY8QGhJ8g
	09KWUNhWgyZfyRBUEP36AKjbSB2BA3Euy1h3YVzGckYhwTKPgO/nkJuk4g+0f3pseA/W3JHqB8s
	UrXTTDvW4h9+1vRcI0ylI/IJIe/3Z6tkj8+7p/sAiVb2yfi92oxDah68xu9HUYXu369nueLvA1u
	eyXd+zvOckFkoSc8jQeD6FmetQWP7K/W+Uc3UY6xfCx0nCeF
X-Received: by 2002:a05:6870:fbac:b0:2bc:61b3:b0ec with SMTP id 586e51a60fabf-2bd10231f20mr7534fac.9.1739892232138;
        Tue, 18 Feb 2025 07:23:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1Xkflrn+VD8mtgwGmlUjnJgfd7En+5mQbaK6O0vjYmO1AE583dLrMXRXbdKV1DA5suW7LEw==
X-Received: by 2002:a05:6870:fbac:b0:2bc:61b3:b0ec with SMTP id 586e51a60fabf-2bd10231f20mr7510fac.9.1739892231762;
        Tue, 18 Feb 2025 07:23:51 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-727001fd29esm3893639a34.38.2025.02.18.07.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 07:23:51 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <12775fc3-1575-4bdd-8d1e-056915d95e3d@redhat.com>
Date: Tue, 18 Feb 2025 10:23:50 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [CHANGE 1/2] sched/isolation: Make use of more than one
 housekeeping cpu
To: Phil Auld <pauld@redhat.com>, Vishal Chourasia <vishalc@linux.ibm.com>
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>, linux-kernel@vger.kernel.org
References: <20250211140104.420739-1-pauld@redhat.com>
 <4a8d54e7-fa29-4ce4-9023-3cdffa0807e6@linux.ibm.com>
 <20250213142653.GA472203@pauld.westford.csb> <Z67Wy9Jjn0BZa01A@linux.ibm.com>
 <20250218150059.GC547103@pauld.westford.csb>
Content-Language: en-US
In-Reply-To: <20250218150059.GC547103@pauld.westford.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/18/25 10:00 AM, Phil Auld wrote:
> Hi Vishal.
>
> On Fri, Feb 14, 2025 at 11:08:19AM +0530 Vishal Chourasia wrote:
>> Hi Phil, Vineeth
>>
>> On Thu, Feb 13, 2025 at 09:26:53AM -0500, Phil Auld wrote:
>>> On Thu, Feb 13, 2025 at 10:14:04AM +0530 Madadi Vineeth Reddy wrote:
>>>> Hi Phil Auld,
>>>>
>>>> On 11/02/25 19:31, Phil Auld wrote:
>>>>> The exising code uses housekeeping_any_cpu() to select a cpu for
>>>>> a given housekeeping task. However, this often ends up calling
>>>>> cpumask_any_and() which is defined as cpumask_first_and() which has
>>>>> the effect of alyways using the first cpu among those available.
>>>>>
>>>>> The same applies when multiple NUMA nodes are involved. In that
>>>>> case the first cpu in the local node is chosen which does provide
>>>>> a bit of spreading but with multiple HK cpus per node the same
>>>>> issues arise.
>>>>>
>>>>> Spread the HK work out by having housekeeping_any_cpu() and
>>>>> sched_numa_find_closest() use cpumask_any_and_distribute()
>>>>> instead of cpumask_any_and().
>>>>>
>>>> Got the overall intent of the patch for better load distribution on
>>>> housekeeping tasks. However, one potential drawback could be that by
>>>> spreading HK work across multiple CPUs might reduce the time that
>>>> some cores can spend in deeper idle states which can be beneficial for
>>>> power-sensitive systems.
>>>>
>>>> Thoughts?
>>> NOHZ_full setups are not generally used in power sensitive systems I think.
>>> They aren't in our use cases at least.
>>>
>>> In cases with many cpus a single housekeeping cpu can not keep up. Having
>>> other HK cpus in deep idle states while the one in use is overloaded is
>>> not a win.
>> To me, an overloaded CPU sounds like where more than one tasks are ready
>> to run, and a HK CPU is one receiving periodic scheduling clock
>> ticks, so HP CPU is bound to comes out of any power-saving state it is in.
> If the overload is caused by HK and interrupts there is nothing in the
> system to help. Tasks, sure, can get load balanced.
>
> And as you say, the HK cpus will have generally ticks happening anyway.
>
>>> If your single HK cpu can keep up then only configure that one HK cpu.
>>> The others will go idle and stay there.  And since they are nohz_full
>>> might get to stay idle even longer.
>> While it is good to distribute the load across each HK CPU in the HK
>> cpumask (queuing jobs on different CPUs each time), this can cause
>> jitter in virtualized environments. Unnecessaryily evicting other
>> tenants, when it's better to overload a VP than to wake up other VPs of a
>> tenant.
>>
> Sorry I'm not sure I understand your setup. Are your running virtual
> tenants on the HK cpus?  nohz_full in the guests? Maybe you only need
> on HK then it won't matter.
>
> My concern is that currently there is no point in having more than
> one HK cpu (per node in a NUMA case). The code as currently implemented
> is just not doing what it needs to.
>
> We have numerous cases where a single HK cpu just cannot keep up and
> the remote_tick warning fires. It also can lead to the other things
> (orchastration sw, HA keepalives etc) on the HK cpus getting starved
> which leads to other issues.  In these cases we recommend increasing
> the number of HK cpus.  But... that only helps the userspace tasks
> somewhat. It does not help the actual housekeeping part.

That is the part that should go into the commit log as well as it is the 
rationale behind your patch.

Cheers,
Longman


