Return-Path: <linux-kernel+bounces-554189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AEAA59433
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1C4818847AE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02B9227E87;
	Mon, 10 Mar 2025 12:24:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB734226D1B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 12:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741609477; cv=none; b=cATrErUFm1XOX9eTr75wSuTsUi3PstUUZgCzTQMG3YhN3JvlimopZGP+dg9Y15UQxjSiSJorgO4ba9SkToazVWkkOw7Ys6Rb2AL5UDRE3Q1l7mQg834SwOggI797up5f/sk2tvRiIZS0zhTB5llgoIFLGcdbpF30JGjywMIxLcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741609477; c=relaxed/simple;
	bh=be7iYBhWCt5fNoFpxb56QSV9NrXBBlZi37xKCzsw8eI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UCj8TdDGyTQEOyB1o1Mq6CWcHT3gZJewM7D702oJp68bGybxKS3L6RxyNuGLNLpwAxrD7Tm5uPlKk8d2HnE45CNK14GIlNVUKE3criTpXLc9b9arISooncQCRCf242eWKuqRZc6Da+Pl0ItDbgDffuwqtogAXm8RwpMP3flokBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F66D152B;
	Mon, 10 Mar 2025 05:24:46 -0700 (PDT)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B4C03F5A1;
	Mon, 10 Mar 2025 05:24:32 -0700 (PDT)
Message-ID: <d2da740a-8786-4726-8467-b7534af3d0e5@arm.com>
Date: Mon, 10 Mar 2025 13:24:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/uclamp: Let each sched_class handle uclamp
To: Hongyan Xia <hongyan.xia2@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 linux-kernel@vger.kernel.org, Xuewen Yan <xuewen.yan@unisoc.com>
References: <84441660bef0a5e67fd09dc3787178d0276dad31.1740664400.git.hongyan.xia2@arm.com>
 <4394f2a7-b4e8-419a-a299-f1afa560c944@arm.com>
 <CAB8ipk_627GF+TV5u=6DK_3aRUHW8qGYwmN+KXMq_Cg-+Say1Q@mail.gmail.com>
 <bf5a70bf-3d13-4b3b-a3ef-804998b21fe9@arm.com>
 <CAB8ipk-SUFDATb=euJQFebxQ513SRwTEpSbBSD6K=batQKELHg@mail.gmail.com>
 <80c2c9f4-eb84-4a43-9c48-8f776615b45a@arm.com>
 <CAB8ipk8pEvOtCm-d0o1rsekwxPWUHk9iBGtt9TLTWW-iWTQKiA@mail.gmail.com>
 <65365ec7-6a16-4e66-8005-e78788cbedfa@arm.com>
 <84a8f306-e2f6-4c9e-a150-72ee3c187b64@arm.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <84a8f306-e2f6-4c9e-a150-72ee3c187b64@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/03/2025 12:56, Hongyan Xia wrote:
> On 10/03/2025 11:22, Dietmar Eggemann wrote:
>> On 10/03/2025 12:03, Xuewen Yan wrote:
>>> Hi Dietmar,
>>>
>>> On Mon, Mar 10, 2025 at 6:53 PM Dietmar Eggemann
>>> <dietmar.eggemann@arm.com> wrote:
>>>>
>>>> On 10/03/2025 03:41, Xuewen Yan wrote:
>>>>> On Sat, Mar 8, 2025 at 2:32 AM Dietmar Eggemann
>>>>> <dietmar.eggemann@arm.com> wrote:
>>>>>>
>>>>>> On 06/03/2025 13:01, Xuewen Yan wrote:
>>>>>>> On Thu, Mar 6, 2025 at 2:24 AM Dietmar Eggemann
>>>>>>> <dietmar.eggemann@arm.com> wrote:
>>>>>>>>
>>>>>>>> On 27/02/2025 14:54, Hongyan Xia wrote:

[...]

>>> I submitted a patch similar to yours before:
>>>
>>> https://lore.kernel.org/all/CAB8ipk_AvaOWp9QhmnFDdbFSWcKLhCH151=no6kRO2z+pSJfyQ@mail.gmail.com/
>>>
>>> And Hongyan fears that as more complexity goes into each sched_class
>>> like delayed dequeue,
>>> so it's better to just let the sched_class handle how uclamp is
>>> enqueued and dequeued within itself rather than leaking into core.c.
>>
>> Ah, OK. Your patch didn't have 'sched' in the subject so I didn't see it
>> immediately.
>>
>> I would prefer that uclamp stays in core.c. ENQUEUE_DELAYED among all
>> the other flags is already used there (ttwu_runnable()).
>>
>> task_struct contains  sched_{,rt_,dl_}entity}. We just have to be
>> careful when switching policies.
> 
> I lean towards letting each class handle uclamp. We've seen the trouble
> with delayed dequeue. Just like the if condition we have for util_est,
> if uclamp is in each class then we can re-use the condition easily,
> otherwise we need to carefully synchronize the enqueue/dequeue between
> core.c and the sub class.
> 
> Also I think so far we are assuming delayed dequeue is the only trouble
> maker. If RT and sched_ext have their own corner cases (I think maybe
> sched_ext is likely because it may eventually want the ext scheduler to
> be able to decide on uclamp itself) then the uclamp inc/dec in core.c
> need to cater for that as well. Once a task is in a class, the variables
> in another class may be in an undefined state, so checking corner cases
> for all the sub-classes in a centralized place like core.c may not even
> be easy to get right.

I do understand your concern with sched_ext but I still prefer the less
invasive change to get uclamp & util_est aligned for fair.c aligned.

AFAICS, related to policy changes, we have a
SCHED_WARN_ON(p->se.sched_delayed) in switched_to_fair() so far.

