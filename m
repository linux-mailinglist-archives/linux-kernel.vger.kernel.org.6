Return-Path: <linux-kernel+bounces-205822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC769000CF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4AD51F256A2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED8115CD75;
	Fri,  7 Jun 2024 10:30:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8039E158214
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 10:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717756219; cv=none; b=Yx+ZyociwDEHedSJhHsXD+OwExeGZAex8h/s5tU/nAJfKNYdvF3UQGDQBEFdtekc2Fe+YXGKYj8nnbVlkyU/nxHKIhgvbWVIJQrfOVn2Kz5beStBsH4RS2NOgj3HKx11HMrVmyAEack+ESbMqkIde1y3CL5sVG31LAleyjbV1kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717756219; c=relaxed/simple;
	bh=NccNIYy2Gy7W2SjQwlZRh0VSwGC/qT4hnXlrb21+hQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hGyaYvYW6ClvCTPaBLRnwuUnuDXTs1RCtB2ZBCPG7XGI7T9qRmfJq7Ybg6ubOTzx4GjBAxv4gT8gatJnmy5Bk4TofP7pnHNi/u7kCQydWXIR9AzPYTUPAQhmook2SCQGn3/SclVWw4yf0nee5J4lXUpFnbX9d9gpvfu4M996HbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD8222F4;
	Fri,  7 Jun 2024 03:30:40 -0700 (PDT)
Received: from [192.168.2.88] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 101DD3F64C;
	Fri,  7 Jun 2024 03:30:13 -0700 (PDT)
Message-ID: <64115627-c6c7-416b-99f9-0df22cbdca6b@arm.com>
Date: Fri, 7 Jun 2024 12:30:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Prevent cpu_busy_time from exceeding
 actual_cpu_capacity
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, vincent.guittot@linaro.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 bristot@redhat.com, vschneid@redhat.com, vincent.donnefort@arm.com,
 qyousef@layalina.io, ke.wang@unisoc.com, linux-kernel@vger.kernel.org
References: <20240606070645.3295-1-xuewen.yan@unisoc.com>
 <0763f870-e30c-46cf-aefa-b879f2ebdba4@arm.com>
 <CAB8ipk_TjqoNetBZ7dbjRxuBHAP=nz9=ZNomnjnaCEikLQSK2A@mail.gmail.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <CAB8ipk_TjqoNetBZ7dbjRxuBHAP=nz9=ZNomnjnaCEikLQSK2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/06/2024 10:20, Xuewen Yan wrote:
> Hi Dietmar
> 
> On Fri, Jun 7, 2024 at 3:19 PM Dietmar Eggemann
> <dietmar.eggemann@arm.com> wrote:
>>
>> On 06/06/2024 09:06, Xuewen Yan wrote:
>>> Because the effective_cpu_util() would return a util which
>>> maybe bigger than the actual_cpu_capacity, this could cause
>>> the pd_busy_time calculation errors.
>>
>> Doesn't return effective_cpu_util() either scale or min(scale, util)
>> with scale = arch_scale_cpu_capacity(cpu)? So the util sum over the PD
>> cannot exceed eenv->cpu_cap?
> 
> In effective_cpu_util, the scale = arch_scale_cpu_capacity(cpu);
>  Although there is the clamp of eenv->pd_cap, but let us consider the
> following simple scenario:
> The pd cpus are 4-7, and the arch_scale_capacity is 1024, and because
> of cpufreq-limit,

Ah, this is due to:

find_energy_efficient_cpu()

   ...
   for (; pd; pd = pd->next)
       ...
       cpu_actual_cap = get_actual_cpu_capacity(cpu)

       for_each_cpu(cpu, cpus)
           ...
           eenv.pd_cap += cpu_actual_cap

and:

get_actual_cpu_capacity()

   ...
   capacity = arch_scale_cpu_capacity(cpu)

   capacity -= max(hw_load_avg(cpu_rq(cpu)), cpufreq_get_pressure(cpu))

which got introduced by f1f8d0a22422 ("sched/cpufreq: Take cpufreq
feedback into account").

[...]

