Return-Path: <linux-kernel+bounces-518454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7559EA38F4F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 23:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD5D83A9A1E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 22:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD741A5B9D;
	Mon, 17 Feb 2025 22:51:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491511A9B3B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 22:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739832714; cv=none; b=nx3CaLetfUoOeXAN4HImNyF3A94UBnb5h/UWhAlps6EWoaZuvDlCamwkqnG+Xpq9lMBvR1VdrEqIhWIGFpgLPwSFLFCEC38/tIkZ2KPIISdI87PWE1PspL5WXt3jV+zp4cdWSe4kijFd/Asuun7/VMi7uwA+UpaUtb/+ukPmYeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739832714; c=relaxed/simple;
	bh=bWvi8GKn6I2ofk0ZGQ7ds64lsKtnXmBW4Y6Ifs8a+2c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IFb83P6VpYnqneW5AJ6zE70SnRphEZVX1bduORi/FuKCbFhOVB3CJ+uZLpTGOfyZpnOW6fPEa1eSvDwKwSKSnaLXIwiU0YOJuWmBLplhFrJ6D+AA532mblkY20VoCH/qLvdU07UjDunVXVPShKK6FWpvndVLKNvAS0+7LRSXCrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A26841692;
	Mon, 17 Feb 2025 14:52:11 -0800 (PST)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14E9E3F5A1;
	Mon, 17 Feb 2025 14:51:51 -0800 (PST)
Message-ID: <5f92761b-c7d4-4b96-9398-183a5bf7556a@arm.com>
Date: Mon, 17 Feb 2025 23:51:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG Report: Fork benchmark drop by 30% on aarch64
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
To: Hagar Hemdan <hagarhem@amazon.com>
Cc: abuehaze@amazon.com, linux-kernel@vger.kernel.org
References: <20250205151026.13061-1-hagarhem@amazon.com>
 <4a9cc5ab-c538-4427-8a7c-99cb317a283f@arm.com>
 <20250207110754.GA10452@amazon.com>
 <1ca758c7-b6ab-4880-9cc7-217093a30bbb@arm.com>
 <20250210213155.GA649@amazon.com>
 <4b48fd24-6cd5-474c-bed8-3faac096fd58@arm.com>
 <20250211214019.GA15530@amazon.com>
 <75503128-c898-4da7-ab99-55f4ef6e2add@arm.com>
Content-Language: en-US
In-Reply-To: <75503128-c898-4da7-ab99-55f4ef6e2add@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/02/2025 19:55, Dietmar Eggemann wrote:
> On 11/02/2025 22:40, Hagar Hemdan wrote:
>> On Tue, Feb 11, 2025 at 05:27:47PM +0100, Dietmar Eggemann wrote:
>>> On 10/02/2025 22:31, Hagar Hemdan wrote:
>>>> On Mon, Feb 10, 2025 at 11:38:51AM +0100, Dietmar Eggemann wrote:
>>>>> On 07/02/2025 12:07, Hagar Hemdan wrote:
>>>>>> On Fri, Feb 07, 2025 at 10:14:54AM +0100, Dietmar Eggemann wrote:
>>>>>>> Hi Hagar,
>>>>>>>
>>>>>>> On 05/02/2025 16:10, Hagar Hemdan wrote:
>>>
>>> [...]
>>>
>>>>> The 'spawn' tasks in sched_move_task() are 'running' and 'queued' so we
>>>>> call dequeue_task(), put_prev_task(), enqueue_task() and
>>>>> set_next_task().
>>>>>
>>>>> I guess what we need here is the cfs_rq->avg.load_avg (cpu_load() in
>>>>> case of root tg) update in:
>>>>>
>>>>>   task_change_group_fair() -> detach_task_cfs_rq() -> ...,
>>>>>   attach_task_cfs_rq() -> ...
>>>>>
>>>>> since this is used for WF_FORK, WF_EXEC handling in wakeup:
>>>>>
>>>>>   select_task_rq_fair() -> sched_balance_find_dst_cpu() ->
>>>>>   sched_balance_find_dst_group_cpu()
>>>>>
>>>>> in form of 'least_loaded_cpu' and 'load = cpu_load(cpu_rq(i)'.
>>>>>
>>>>> You mentioned AutoGroups (AG). I don't see this issue on my Debian 12
>>>>> Juno-r0 Arm64 board. When I run w/ AG, 'group' is '/' and
>>>>> 'tsk->sched_task_group' is '/autogroup-x' so the condition 'if (group ==
>>>>> tsk->sched_task_group)' isn't true in sched_move_task(). If I disable AG
>>>>> then they match "/" == "/".
>>>>>
>>>>> I assume you run Ubuntu on your AWS instances? What kind of
>>>>> 'cgroup/taskgroup' related setup are you using?
>>>>
>>>> I'm running AL2023 and use Vanilla kernel 6.13.1 on m6g.xlarge AWS instance.
>>>> AL2023 uses cgroupv2 by default.
>>>>>
>>>>> Can you run w/ this debug snippet w/ and w/o AG enabled?
>>>>
>>>> I have run that and have attached the trace files to this email.
>>>
>>> Thanks!
>>>
>>> So w/ AG you see that 'group' and 'tsk->sched_task_group' are both
>>> '/user.slice/user-1000.slice/session-1.scope' so we bail for those tasks
>>> w/o doing the 'cfs_rq->avg.load_avg' update I described above.
>>
>> yes, both groups are identical so it returns from sched_move_task()
>> without {de|en}queue and without call task_change_group_fair().
> 
> OK.
> 
>>> You said that there is no issue w/o AG. 
>>
>> To clarify, I meant by there's no regression when autogroup is disabled,
>> that the fork results w/o AG remain consistent with or without the commit 
>> "sched/core: Reduce cost of sched_move_task when config autogroup". However,
>> the fork results are consistently lower when AG disabled compared to when
>> it's enabled (without commit applied). This is illustrated in the tables
>> provided in the report.
> 
> OK, but I don't quite get yet why w/o AG the results are lower even w/o
> eff6c8ce8d4d? Have to dig further I guess. Maybe there is more than this
> p->se.avg.load_avg update when we go via task_change_group_fair()?

'./Run -c 4 spawn' on AWS instance (m7gd.16xlarge) with v6.13, 'mem=16G
maxcpus=4 nr_cpus=4' and Ubuntu '22.04.5 LTS':

CFG_SCHED_AUTOGROUP | sched_ag_enabled | eff6c8ce8d4d | Fork (lps)

   	y	             1		   y            21005 (27120 **)
	y		     0		   y            21059 (27012 **)
	n		     -		   y            21299
	y		     1		   n	        27745 *
	y		     0		   n	        27493 *
	n		     -		   n	        20928

(*) So here the higher numbers are only achieved when
'sched_autogroup_exit_task() -> sched_move_task() ->
sched_change_group() is called for the 'spawn' tasks.

(**) When I apply the fix from
https://lkml.kernel.org/r/4a9cc5ab-c538-4427-8a7c-99cb317a283f@arm.com.

These results support the story that we need:

  task_change_group_fair() -> detach_task_cfs_rq() -> ...,
  attach_task_cfs_rq() -> ...

i.e. the related 'cfs_rq->avg.load_avg' update during do_exit() so that
WF_FORK handling in wakeup:

  select_task_rq_fair() -> sched_balance_find_dst_cpu() ->
  sched_balance_find_dst_group_cpu()

can use more recent 'load = cpu_load(cpu_rq(i)' values to get a better
'least_loaded_cpu'.

The AWS instance runs systemd so shell and test run in a taskgroup other
than root which trumps autogroups:

  task_wants_autogroup()

     if (tg != &root_task_group)
       return false;

     ...

That's why 'group == tsk->sched_task_group' in sched_move_task() is
true, which is different on my Juno: the shell from which I launch the
tests runs in '/' so that the test ends up in an autogroup, i.e. 'group
!= tsk->sched_task_group'.

[...]

