Return-Path: <linux-kernel+bounces-557910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13764A5DF48
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 398B53A6459
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76D2251783;
	Wed, 12 Mar 2025 14:41:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE8A245039
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741790506; cv=none; b=Bn6syrQhT25bJyurzMjTPymEHS0whatlfbXKxGqXLp0bTehlp+AdF6TggzQckfR/0wbkqGNgzDwyRbenHkKBNVC+gkH+OTZDNl6cvaYYZXOGPevwCVZsy2LVW5u7Oh0z1MfH3CPXE1r10oAUrmyANU+6Apu3Nt/MrbMMnDARmdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741790506; c=relaxed/simple;
	bh=QYF2vzlo4Lst3pft5WC59+tCAzmX42djgz3/BF5bv+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cTRXLJE2QnNEkkjnCsbCV/5lI7jqsQ5agQw5Ly5gwTJ8w9uE2szhH1jZ+mjCbAKLi1CziWsRsJtZkcFFErHHSf6o72naoT5kIz441zWfur/RPVb3hjLv+sQqvw6bxKPvvVOa+I//oy4JNPnT7yCYy1KXAarAbdpsXaxE5IG9PrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 360CA1515;
	Wed, 12 Mar 2025 07:41:54 -0700 (PDT)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E965A3F5A1;
	Wed, 12 Mar 2025 07:41:41 -0700 (PDT)
Message-ID: <51d24e59-247d-4b66-9ddb-4b9f0f53497b@arm.com>
Date: Wed, 12 Mar 2025 15:41:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] /sched/core: Fix Unixbench spawn test regression
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>, Hagar Hemdan
 <hagarhem@amazon.com>, linux-kernel@vger.kernel.org, wuchi.zero@gmail.com
References: <20250306162635.2614376-1-dietmar.eggemann@arm.com>
 <CAKfTPtCfd_=gm7rsT_qBL8pw5uybEvYH4N2tvxpKndxxi4L7oA@mail.gmail.com>
 <8ddd7bb2-3a18-48b5-85c6-23263134308a@arm.com>
 <CAKfTPtD9DwWquFN6G8BXAii7HH5zJeEXiUjE8ma-eHdEqeHzdw@mail.gmail.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <CAKfTPtD9DwWquFN6G8BXAii7HH5zJeEXiUjE8ma-eHdEqeHzdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/03/2025 17:35, Vincent Guittot wrote:
> On Mon, 10 Mar 2025 at 16:29, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 10/03/2025 14:59, Vincent Guittot wrote:
>>> On Thu, 6 Mar 2025 at 17:26, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>>>
>>>> Hagar reported a 30% drop in UnixBench spawn test with commit
>>>> eff6c8ce8d4d ("sched/core: Reduce cost of sched_move_task when config
>>>> autogroup") on a m6g.xlarge AWS EC2 instance with 4 vCPUs and 16 GiB RAM
>>>> (aarch64) (single level MC sched domain) [1].
>>>>
>>>> There is an early bail from sched_move_task() if p->sched_task_group is
>>>> equal to p's 'cpu cgroup' (sched_get_task_group()). E.g. both are
>>>> pointing to taskgroup '/user.slice/user-1000.slice/session-1.scope'
>>>> (Ubuntu '22.04.5 LTS').
>>>
>>> Isn't this same use case that has been used by commit eff6c8ce8d4d to
>>> show the benefit of adding the test if ((group ==
>>> tsk->sched_task_group) ?
>>> Adding Wuchi who added the condition
>>
>> IMHO, UnixBench spawn reports a performance number according to how many
>> tasks could be spawned whereas, IIUC, commit eff6c8ce8d4d was reporting
>> the time spend in sched_move_task().
> 
> But does not your patch revert the benefits shown in the figures of
> commit eff6c8ce8d4d ? It skipped sched_move task in do_exit autogroup
> and you adds it back

Yeah, we do need the PELT update in sched_change_group()
(task_change_group_fair()) in the do_exit() path to get the 30% score
back in 'UnixBench spawn'. Even that means we need more time due to this
in sched_move_task().

I retested this and it turns out that 'group == tsk->sched_task_group'
is only true when sched_move_task() is called from exit.

So to get the score back for 'UnixBench spawn' we should rather revert
commit eff6c8ce8d4d.

The analysis in my patch still holds though.

If you guys agree I can send the revert with my analysis in the
patch-header.

