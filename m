Return-Path: <linux-kernel+bounces-513743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF96A34E1D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F069B7A449A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AFB245AF4;
	Thu, 13 Feb 2025 18:55:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2341F28A2D4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 18:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739472952; cv=none; b=QX1U3hwv47w7AKjM6W0S9zCuMbuhMpv0m6SC5w7xis5azbFIIHFHPgerb7pwgNXBv3sYjMKaU9kjoty/Qg2loBdMRJeoHEcDNJAEbkeSObsFO13uw83mgHF3eDSBuZmyJ18xPEBqiWP10q5qYL5Yz7H2Hhc358S/ySW4HS5bFPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739472952; c=relaxed/simple;
	bh=3GC3y5CLnOJiMrtelgsjBlnnrJxMiYd1o/okGukKg5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KdcJbgC8DdlQ/TLvJGrW/a7MBJJvxiuH9lt9a8gmYe2PMlHPR+xWcKN69w5fJ/iYCs/pxaVBdVczchrvGySiXLcmjxllciSy5btFJ6437o2YqnM3BMaY7CkCG2q6t1lyugitokl6yldogEtLCmthYhTDSpBWSPZsYR2CvL5uzSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB76B1682;
	Thu, 13 Feb 2025 10:56:09 -0800 (PST)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2F653F58B;
	Thu, 13 Feb 2025 10:55:48 -0800 (PST)
Message-ID: <75503128-c898-4da7-ab99-55f4ef6e2add@arm.com>
Date: Thu, 13 Feb 2025 19:55:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG Report: Fork benchmark drop by 30% on aarch64
To: Hagar Hemdan <hagarhem@amazon.com>
Cc: abuehaze@amazon.com, linux-kernel@vger.kernel.org
References: <20250205151026.13061-1-hagarhem@amazon.com>
 <4a9cc5ab-c538-4427-8a7c-99cb317a283f@arm.com>
 <20250207110754.GA10452@amazon.com>
 <1ca758c7-b6ab-4880-9cc7-217093a30bbb@arm.com>
 <20250210213155.GA649@amazon.com>
 <4b48fd24-6cd5-474c-bed8-3faac096fd58@arm.com>
 <20250211214019.GA15530@amazon.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <20250211214019.GA15530@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/02/2025 22:40, Hagar Hemdan wrote:
> On Tue, Feb 11, 2025 at 05:27:47PM +0100, Dietmar Eggemann wrote:
>> On 10/02/2025 22:31, Hagar Hemdan wrote:
>>> On Mon, Feb 10, 2025 at 11:38:51AM +0100, Dietmar Eggemann wrote:
>>>> On 07/02/2025 12:07, Hagar Hemdan wrote:
>>>>> On Fri, Feb 07, 2025 at 10:14:54AM +0100, Dietmar Eggemann wrote:
>>>>>> Hi Hagar,
>>>>>>
>>>>>> On 05/02/2025 16:10, Hagar Hemdan wrote:
>>
>> [...]
>>
>>>> The 'spawn' tasks in sched_move_task() are 'running' and 'queued' so we
>>>> call dequeue_task(), put_prev_task(), enqueue_task() and
>>>> set_next_task().
>>>>
>>>> I guess what we need here is the cfs_rq->avg.load_avg (cpu_load() in
>>>> case of root tg) update in:
>>>>
>>>>   task_change_group_fair() -> detach_task_cfs_rq() -> ...,
>>>>   attach_task_cfs_rq() -> ...
>>>>
>>>> since this is used for WF_FORK, WF_EXEC handling in wakeup:
>>>>
>>>>   select_task_rq_fair() -> sched_balance_find_dst_cpu() ->
>>>>   sched_balance_find_dst_group_cpu()
>>>>
>>>> in form of 'least_loaded_cpu' and 'load = cpu_load(cpu_rq(i)'.
>>>>
>>>> You mentioned AutoGroups (AG). I don't see this issue on my Debian 12
>>>> Juno-r0 Arm64 board. When I run w/ AG, 'group' is '/' and
>>>> 'tsk->sched_task_group' is '/autogroup-x' so the condition 'if (group ==
>>>> tsk->sched_task_group)' isn't true in sched_move_task(). If I disable AG
>>>> then they match "/" == "/".
>>>>
>>>> I assume you run Ubuntu on your AWS instances? What kind of
>>>> 'cgroup/taskgroup' related setup are you using?
>>>
>>> I'm running AL2023 and use Vanilla kernel 6.13.1 on m6g.xlarge AWS instance.
>>> AL2023 uses cgroupv2 by default.
>>>>
>>>> Can you run w/ this debug snippet w/ and w/o AG enabled?
>>>
>>> I have run that and have attached the trace files to this email.
>>
>> Thanks!
>>
>> So w/ AG you see that 'group' and 'tsk->sched_task_group' are both
>> '/user.slice/user-1000.slice/session-1.scope' so we bail for those tasks
>> w/o doing the 'cfs_rq->avg.load_avg' update I described above.
> 
> yes, both groups are identical so it returns from sched_move_task()
> without {de|en}queue and without call task_change_group_fair().

OK.

>> You said that there is no issue w/o AG. 
> 
> To clarify, I meant by there's no regression when autogroup is disabled,
> that the fork results w/o AG remain consistent with or without the commit 
> "sched/core: Reduce cost of sched_move_task when config autogroup". However,
> the fork results are consistently lower when AG disabled compared to when
> it's enabled (without commit applied). This is illustrated in the tables
> provided in the report.

OK, but I don't quite get yet why w/o AG the results are lower even w/o
eff6c8ce8d4d? Have to dig further I guess. Maybe there is more than this
p->se.avg.load_avg update when we go via task_change_group_fair()?

>> Unfortunately your 'w/o AG'
>> trace does not contain any evidence that you ran UnixBench's './Run -c 4
>> spawn' since there are no lines for tasks with p->comm='spawn'.
> 
> You're right, the trace doesn't show tasks with p->comm='spawn' because I ran
> the fork benchmark with CONFIG_SCHED_AUTOGROUP disabled and 
> sched_autogroup_exit_task() is empty in this case.

Makes sense.

>> Could you rerun this please. My hunch is that 'group' and
>> 'tsk->sched_task_group' differ w/o AG?
> 
> I've re-run the fork test with CONFIG_SCHED_AUTOGROUP enabled, but with 
> autogroup disabled at runtime using 'echo 0 | sudo tee /proc/sys/kernel
> /sched_autogroup_enabled' to avoid empty sched_autogroup_exit_task().
> I've attached the new trace file and I observed that both groups still
> don't differ.

So with 'sched_autogroup_enabled: 0' you run:

group                  /user.slice/user-1000.slice/session-3.scope
tsk->sched_task_group  /user.slice/user-1000.slice/session-3.scope

Looks the same as with 'sched_autogroup_enabled: 1'.

> Have you seen different results when testing this on a Debian 12 
> Juno-r0 Arm64 board? 

I have on 4 (little) CPUs with './Run -c 4 spawn'

sched_autogroup_enabled: 1

group                 /
tsk->sched_task_group /autogroup-21

sched_autogroup_enabled: 0

group                 /
tsk->sched_task_group /

(1) v6.13:

CONFIG_SCHED_AUTOGROUP is not set

  5250 lps

sched_autogroup_enabled: 1

  4900 lps

This +1200 compared to 'sched_autogroup_enabled: 0' could fit into this
'p->se.avg.load_avg update when we go via task_change_group_fair()' story.

sched_autogroup_enabled: 0

  3700 lps


(2) v6.13 w/o eff6c8ce8d4d

CONFIG_SCHED_AUTOGROUP is not set

  5250 lps

sched_autogroup_enabled: 1

  5250 lps

sched_autogroup_enabled: 0

  5250 lps

