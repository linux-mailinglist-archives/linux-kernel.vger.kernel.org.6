Return-Path: <linux-kernel+bounces-260792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1818C93AE4A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 11:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6105284AC7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC6A1509A0;
	Wed, 24 Jul 2024 09:06:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C626414B095
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 09:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721812009; cv=none; b=YLZR3ne0BMD6QXGpqp6cBLLjnQRgj1BzXDWQxuPokTZyOOH/hJxgPgSAbM+gxe63e2zkzHSEzMRBDwwkblp0NjFkAKRBGH7yMGmNYj2Mx3dayT0/B+R4n15cVo84SfoaptgHrpqXkEMOJFJzi1CS6GNVQSy4iHQuOHlpqrVGWFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721812009; c=relaxed/simple;
	bh=J5RMh2auiLUki9j1PdcTV3UNR/RGAPE6dQ9+9xXBIxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EPf9mMtU8rA6jX1TglPW6HbpcIPLo/fPf5hJppZHbkOuByGIFc5/AEz5E2P17YhhMb/31i/XlqlaDxks2jxRgQ4I9SHXIEse1GYsGhbA+QLeFpaQq9rSLdqcDeq+0a/3aT+roFZrUQK82U+BWsn90SiMHn5YpWrlT0IglTlGVhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD512106F;
	Wed, 24 Jul 2024 02:07:10 -0700 (PDT)
Received: from [192.168.178.110] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81FB43F5A1;
	Wed, 24 Jul 2024 02:06:43 -0700 (PDT)
Message-ID: <e21c0ded-a554-42c1-ac7b-77b98d12fe88@arm.com>
Date: Wed, 24 Jul 2024 11:06:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/fair: Sync se's load_avg with cfs_rq in
 reweight_task
To: Chengming Zhou <chengming.zhou@linux.dev>,
 Vishal Chourasia <vishalc@linux.ibm.com>,
 Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org
References: <20240723114247.104848-1-zhouchuyi@bytedance.com>
 <Zp_QzS-DUiE934X2@linux.ibm.com>
 <da5b5683-ed22-4e65-9e89-e22ff7f6cf2b@arm.com>
 <d758614b-73e8-42a3-92d1-5d2424ee4e89@linux.ibm.com>
 <bc8e5905-7729-4263-84e2-ca86a710eccd@linux.dev>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <bc8e5905-7729-4263-84e2-ca86a710eccd@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/07/2024 04:12, Chengming Zhou wrote:
> On 2024/7/24 07:00, Vishal Chourasia wrote:
>> On 24/07/24 2:40 am, Dietmar Eggemann wrote:
>>> On 23/07/2024 17:48, Vishal Chourasia wrote:
>>>> On Tue, Jul 23, 2024 at 07:42:47PM +0800, Chuyi Zhou wrote:

[...]

>>>> The difference between using update_load_avg() and
>>>> sync_entity_load_avg() is:
>>>> 1. update_load_avg() uses the updated PELT clock value from the rq
>>>>     structure.
>>>> 2. sync_entity_load_avg() uses the last updated time of
>>>>     the cfs_rq where the scheduling entity (se) is attached.
>>>>
>>>> Won't this affect the entity load sync?
>>>
>>> Not sure what you mean exactly by entity load sync here.
>> load avg sync for the wakee
>>>
>>> The task has been sleeping for a long time, i.e. its PELT values haven't
>>> been updated or a long time (its last_update_time (lut) value is pretty
>>> old).
>>>
>>> In this meantime the task's cfs_rq has potentially seen other PELT
>>> updates due to PELT updates of other non-sleeping tasks related to this
>>> cfs_rq. I.e. the cfs_rq lut is much more recent.
>>>
>>> What we want to do here is to sync the sleeping task with its cfs_rq. If
>>> the task was sleeping for more than 1us (1024ns) and we cross a 1ms PELT
>>> period (1024us) when we use cfs_rq's lut as the 'now' value for
>>> __update_load_avg_blocked_se() then we will see the task PELT values
>>> decay.
>>>
>>> We rely on sync_entity_load_avg() for instance in EAS wakeup where the
>>> task's util_avg influences on which CPU type the task will run next. So
>>> we sync the wakee with its cfs_rq to be able to work with a current task
>>> util_avg.
>> I was talking about the case where all the tasks on a cfs_rq are
>> sleeping.
>> In this case, lut of the cfs_rq will be same as, at the time of last
>> dequeue.
> 
> In this case, cfs_rq is not on_rq, its load_sum/avg will be updated when
> enqueue next time. (Or periodically updated from load balance)

Yes, cfs_rq PELT values of an idle CPU decay via
sched_balance_update_blocked_averages() -> __update_blocked_fair()

[...]


