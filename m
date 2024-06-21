Return-Path: <linux-kernel+bounces-224192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B648911E92
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB34E2825CF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F82716C856;
	Fri, 21 Jun 2024 08:22:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2C813C9A9
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 08:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718958166; cv=none; b=t9brqY8eLzHtW6eKvMt/Y/UdHAuWX6sgmpzLQXqNjOHA7cDKYdwK/+61NuKAhMD2FUScXpdwgmgq7mLmC7+OWd3+hGCK+6lgE3AIuI3evjabP+fFxGu8Y/rIfV9rh1xUxn6pdAamtLY2e1REuOfkWznu2+/Nai3CwrdjW/lzieI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718958166; c=relaxed/simple;
	bh=70aOEx1E8D/ozj7dO7c5swj+/sTVUG3v51eeHL51maQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lIJ5HNKY5vy6s0Z7Q95NgNr+SEHvN43irhRfJTAZDD43hTSrHodgX1yq4hAHDMetxt/lg5luyVNUDp0AtRCw/9C23+w5l8cZ7lg0axeC5a8Q7+5w8F0JTAKDj2Ro1UJOUVgjhhjUGVfADkrQSz/1NFsBbI4r9e3EEVM5JR9ycLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6612DDA7;
	Fri, 21 Jun 2024 01:23:08 -0700 (PDT)
Received: from [192.168.178.110] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C2B53F64C;
	Fri, 21 Jun 2024 01:22:41 -0700 (PDT)
Message-ID: <3bfb4e65-b746-449e-a9e7-acda24897045@arm.com>
Date: Fri, 21 Jun 2024 10:22:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Prevent cpu_busy_time from exceeding
 actual_cpu_capacity
To: Qais Yousef <qyousef@layalina.io>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>, Xuewen Yan <xuewen.yan@unisoc.com>,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 bristot@redhat.com, vschneid@redhat.com, vincent.donnefort@arm.com,
 ke.wang@unisoc.com, linux-kernel@vger.kernel.org, christian.loehle@arm.com
References: <20240609225520.6gnmx2wjhxghcxfo@airbuntu>
 <CAB8ipk-9EVgyii3SGH9GOA3Mb5oMQdn1_vLVrCsSn1FmSQieOw@mail.gmail.com>
 <20240616222003.agcz5osb2nkli75h@airbuntu>
 <CAKfTPtBikWsyPon6HweEZg5qjSP+QX=WZDQu4NHs7PUcSCqDDA@mail.gmail.com>
 <20240617105348.ebtony3ciwxhvj2w@airbuntu>
 <CAKfTPtDPCPYvCi1c_Nh+Cn01ZVS7E=tAHQeNX-mArBt3BXdjYw@mail.gmail.com>
 <20240618153931.ub5ezml3imd5mwu7@airbuntu>
 <CAB8ipk86jmb6xnEUnv_Vs5=A5EnNfnHTy3FXYZRhKhuEFKhzDw@mail.gmail.com>
 <20240619181021.kxcjxaqe47fkve42@airbuntu>
 <CAKfTPtA1cKiB=mv-QUAYOLtiwOE+Rcg+HkAirkVW=irTQtqNVw@mail.gmail.com>
 <20240620113756.hivzk7sj4uj4sm6j@airbuntu>
Content-Language: en-US
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20240620113756.hivzk7sj4uj4sm6j@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/06/2024 13:37, Qais Yousef wrote:
> On 06/20/24 09:45, Vincent Guittot wrote:
>> On Wed, 19 Jun 2024 at 20:10, Qais Yousef <qyousef@layalina.io> wrote:
>>>
>>> On 06/19/24 11:05, Xuewen Yan wrote:
>>>> On Tue, Jun 18, 2024 at 11:39 PM Qais Yousef <qyousef@layalina.io> wrote:
>>>>>
>>>>> On 06/18/24 17:23, Vincent Guittot wrote:
>>>>>> On Mon, 17 Jun 2024 at 12:53, Qais Yousef <qyousef@layalina.io> wrote:
>>>>>>>
>>>>>>> On 06/17/24 11:07, Vincent Guittot wrote:

[...]

>>>> diff --git a/drivers/thermal/cpufreq_cooling.c
>>>> b/drivers/thermal/cpufreq_cooling.c
>>>> index 280071be30b1..a8546d69cc10 100644
>>>> --- a/drivers/thermal/cpufreq_cooling.c
>>>> +++ b/drivers/thermal/cpufreq_cooling.c
>>>> @@ -164,7 +164,7 @@ static u32 get_load(struct cpufreq_cooling_device
>>>> *cpufreq_cdev, int cpu,
>>>>  {
>>>>         unsigned long util = sched_cpu_util(cpu);
>>>>
>>>> -       return (util * 100) / arch_scale_cpu_capacity(cpu);
>>>> +       return (util * 100) / get_actual_cpu_capacity(cpu);
>>>>  }
>>>>  #else /* !CONFIG_SMP */
>>>>  static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu,
>>>>
>>>>
>>>> Because if still use arch_scale_cpu_capacity(), the load pct may be decreased,
>>>> It may affect the thermal-IPA-governor's power consideration.
>>>
>>> I am not sure about this one. But looks plausible. Vincent?
>>
>> I don't see why we should change them ? We don't want to change
>> sched_cpu_util() as well
>> AFAICT, the only outcome of this thread is that we should use
>> get_actual_cpu_capacity() instead of arch_scale_cpu_capacity() in
>> util_fits_cpu(). capping the utilization only make the estimation
>> worse
> 
> Yes my bad. Only util_fits_cpu() is needed now

Looks like that's for the uclamp part (2. part) of util_fits_cpu().

For the first part we use capacity_of() which bases on
get_actual_cpu_capacity() [scale_rt_capacity()] and changes each 4ms
[250 Hz].

Our assumption is that hw_load_avg() and cpufreq_get_pressure() change
way less frequent than that, right?

So we can use capacity_of() and get_actual_cpu_capacity() in the same
code path.

