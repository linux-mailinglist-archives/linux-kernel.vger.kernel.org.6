Return-Path: <linux-kernel+bounces-573702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F6BA6DAF7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE0C7164AF8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8881A25E83C;
	Mon, 24 Mar 2025 13:22:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3371CD1E4
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742822572; cv=none; b=Fv5CkxhL0/pJ1TwYVqWGDLf1LgcfB3F9Sz6EmYgo3fCEb8Og+blpfm++wvQgge5hddMw1CeceoH8zvYTejPA8kZeJcJ+xcfO4970tbQquzFmsu/gKALFHQfiInhbEAh4ioEXw3ICmr7g/LRkew/N0GH+PODgVxdosoMyo6Yyctw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742822572; c=relaxed/simple;
	bh=KwMQZpqgbmIGigqWo2CSQ2NSifYwX0YK07syeXZnCak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BuoDKgykx58StPFOZBOxu++ZVWVKu7P/uxyIfSmuBg7LjG326eJcT/61TIoBR2pflGvmyxMAScbGvgGt6WmDDy5bFwnJbzDR1xW9umdSHZ7PtUqZOoXqZU6KAMkTDxfKpnogkxLTI1lG8FS4TpnjAuPg7A0L48vKJopRnrkqiL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 768B016F3;
	Mon, 24 Mar 2025 06:22:55 -0700 (PDT)
Received: from [192.168.11.25] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0005D3F63F;
	Mon, 24 Mar 2025 06:22:45 -0700 (PDT)
Message-ID: <e4f331d6-1724-4f6d-8dbb-bd07fe82229f@arm.com>
Date: Mon, 24 Mar 2025 14:22:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] sched/util_est: Do not sub the delayed-task's
 util-est
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, vincent.guittot@linaro.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.co, linux-kernel@vger.kernel.org, hongyan.xia2@arm.com,
 qyousef@layalina.io, ke.wang@unisoc.com, di.shen@unisoc.com
References: <20250314090909.8404-1-xuewen.yan@unisoc.com>
 <aa8baf67-a8ec-4ad8-a6a8-afdcd7036771@arm.com>
 <CAB8ipk8FX=zhBo0vHPC8MEHMEJKsa+E9J081mzJMLZU_8-U78w@mail.gmail.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <CAB8ipk8FX=zhBo0vHPC8MEHMEJKsa+E9J081mzJMLZU_8-U78w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21/03/2025 07:44, Xuewen Yan wrote:
> Hi hongyan
> 
> On Wed, Mar 19, 2025 at 9:33 PM Dietmar Eggemann
> <dietmar.eggemann@arm.com> wrote:
>>
>> On 14/03/2025 10:09, Xuewen Yan wrote:
>>> In cpu_util_without, When the task is in rq, we should
>>> sub the task's util_est, however, the delayed_task->on_rq
>>> is true, however, the delayed_task's util had been sub
>>> when sleep, so there is no need to sub the delayed task's
>>> util-est. So add the checking of delayed-task.
>>>
>>> On the other hand, as said in [1], the logic of util_est's
>>> enqueue/dequeue could be simplified.
>>> So simplify it by aligning with the conditions of uclamp.
>>
>> This flag simplification looks good to me.
>>
>> IMHO, you should submit this with the uclamp change so that we can call
>> uclamp_rq_inc() before p->sched_class->enqueue_task(). To make sure the
>> task which is enqueued with 'flags & ENQUEUE_DELAYED' is considered for
>> cpufreq_update_util() in enqueue_task_fair() (Hongyan's finding in
>> https://lkml.kernel.org/r/84441660bef0a5e67fd09dc3787178d0276dad31.1740664400.git.hongyan.xia2@arm.com)
>>
>> I would prefer the less invasive fix you presented here:
>>
>> https://lkml.kernel.org/r/CAB8ipk9LpbiUDnbcV6+59+Sa=Ai7tFzO===mpLD3obNdV4=J-A@mail.gmail.com
>>
>> since uclamp is already a core thing (fair + rt), it works for current
>> max aggregation and it's less invasive.
>>
> 
> Since the uclamp's enqueue is affecting performance, could we fix the
> uclamp-enqueue issue first?
> Need I to send the patch-v2 base the
> https://lore.kernel.org/all/CAB8ipk9LpbiUDnbcV6+59+Sa=Ai7tFzO===mpLD3obNdV4=J-A@mail.gmail.com/T/#mb32d7675beda5cadc35a3c04cddebc39580c718b
> ?

That would be nice. Maybe a patch-set with 1) uclamp enqueue fix and 2)
util_est flag simplification? So those two things stay together ...

[...]

