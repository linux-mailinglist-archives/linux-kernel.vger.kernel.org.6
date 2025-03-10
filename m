Return-Path: <linux-kernel+bounces-554577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D388A59A21
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC64B188DB0E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357EB22D4DE;
	Mon, 10 Mar 2025 15:37:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012511B3927
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 15:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741621062; cv=none; b=GZW7AhDXE7qO6tDyS/esktB9O/NjMoC11vnNRA5B3z5ZPtSN5hqy2tQeA7lXUGHp0s/UMaHmTFGz0o/zqoNPgpDcqDg3maW9EReSG847Z7AJSNfxoRmQsPYQBWtzmSJwPg0fNTPLF4C+YyePWEFfl09tqxOUsJgOaVilP8mEA6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741621062; c=relaxed/simple;
	bh=DcaynPSTfCFPu46URPqTnbfY89OV/2dhTpGCXPyuXJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V8zbyvgdtIFDBL2GWj/5ApaD/eucEXdVWSUI4aD8EFtYJZVkFzTEqxQcRRLHp/WIy+mkWBQ+e8pywZtgt2XTfdwnGEHxnv2ez21+wCagZOFWbEu31AUU7CCu3M/uubPMZ3Di3j3k5QaQDq+VCe6t5J3M5dxatwQyFK/VYIiOt0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A62E51692;
	Mon, 10 Mar 2025 08:37:51 -0700 (PDT)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9ABD53F5A1;
	Mon, 10 Mar 2025 08:37:38 -0700 (PDT)
Message-ID: <a5ea2f23-4b87-41d6-9dae-9ddc94024d6f@arm.com>
Date: Mon, 10 Mar 2025 16:37:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] uclamp sum aggregation
To: Hongyan Xia <hongyan.xia2@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Christian Loehle <christian.loehle@arm.com>,
 Pierre Gondois <pierre.gondois@arm.com>, linux-kernel@vger.kernel.org,
 Xuewen Yan <xuewen.yan@unisoc.com>
References: <cover.1741091349.git.hongyan.xia2@arm.com>
 <CAB8ipk_AvaOWp9QhmnFDdbFSWcKLhCH151=no6kRO2z+pSJfyQ@mail.gmail.com>
 <6eb93af8-e239-44d7-a132-2932f260e792@arm.com>
 <CAB8ipk9LpbiUDnbcV6+59+Sa=Ai7tFzO===mpLD3obNdV4=J-A@mail.gmail.com>
 <13ea9f62-e373-4248-997c-47c15e024c02@arm.com>
 <4a8ed999-2ee5-478c-a759-fec1c496cba9@arm.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <4a8ed999-2ee5-478c-a759-fec1c496cba9@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/03/2025 13:54, Hongyan Xia wrote:
> On 10/03/2025 11:34, Dietmar Eggemann wrote:
>> On 06/03/2025 12:38, Xuewen Yan wrote:
>>> On Thu, Mar 6, 2025 at 7:32 PM Hongyan Xia <hongyan.xia2@arm.com> wrote:
>>>>
>>>> Hi Xuewen,
>>>>
>>>> On 06/03/2025 11:12, Xuewen Yan wrote:
>>>>> Hi Hongyan,
>>>>>
>>>>> On Tue, Mar 4, 2025 at 10:26 PM Hongyan Xia <hongyan.xia2@arm.com>

[...]

>> Like I mentioned already in the original thread:
>>
>> https://lkml.kernel.org/r/65365ec7-6a16-4e66-8005-e78788cbedfa@arm.com
>>
>> I would prefer that uclamp stays in core.c. ENQUEUE_DELAYED among all
>> the other flags is already used there (ttwu_runnable()).
>>
>> task_struct contains sched_{,rt_,dl_}entity}. We just have to be
>> careful when switching policies.
>>
>> -- 
>>
>> Could you also incorporate the changes in {en,de}queue_task_fair()
>> ((task_on_rq_migrating(p) || (flags & {RESTORE,DEQUEUE}_SAVE))) vs.
>> (!p->se.sched_delayed || (flags & ENQUEUE_DELAYED)) and
>> (!p->se.sched_delayed) so the uclamp-util_est relation is easier to spot?
>>
>> [...]
> 
> At the moment we can't do this. Sum aggregation was designed before
> delayed dequeue and it syncs with p->se.on_rq. If we sync with something
> else and take care of delayed dequeue cases (like util_est) then I have
> to rewrite part of the series.

Ah, OK! But this 'uclamp not in sync with util_est' is already an issue
on today's mainline so I would like to see this fixed as discreet as
possible and then another prep-patch for 'uclamp sum aggregation'.
IMHO, then it's clearer why we would need more rework in this area.

