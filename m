Return-Path: <linux-kernel+bounces-527696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50475A40E3F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 12:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C03A97A950E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 11:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076702045B5;
	Sun, 23 Feb 2025 11:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="D1ISEC/f"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F75F1FCCF9
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 11:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740309764; cv=none; b=HbsC7dvGRSDncPZ0zTGCD/7v1GcUZz7lkCs6+BsBFX738mfJLQOAS65bfinwXV/me8PKwI/sb6Eiddxfm4lqj3PZzj0YAzJUbz13ATtPUM8x1HqfeTA27nrEXwGHRqCbqF1Bg0RUZGqhyJesnOOnVyYXCDaXsDewQWSZAMOT7iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740309764; c=relaxed/simple;
	bh=U8m/urX6jwsglKRw6Ye5oD69vsE01GEGagbiqQM2AP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AiS1CYxMOAANn9K3nBWXrSAY72f3a3or5Z4/pX3ROro1DyY/IKU/60zIWI/mQ14JhoZmEiIFI+ZnbUvfJxfYe6y0k10qdfvQx7srHgENtyXwAmiC0Sgo5OLJX449PtqkfjAuGOrig6k2XxYWKkxYY4E6oVFHW8ipxQWeWqYcCVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=D1ISEC/f; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fbfe16cbf5so938645a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 03:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740309760; x=1740914560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LDItQAI1o55x4csyyYDcB1y5jXzN4ZM+5Iz7ltjo1wg=;
        b=D1ISEC/foSZYJJ6WhbL99K9eqHRGYVSXP7rzuoe1h3wVT8qoKQhiTYbEYC9Kr0EjmV
         /7xSZIyna4E70/nPHMwPxWSOYRdShwpTMaaEZB7yGFJPQoPXS6YYYeEakgNHzs9Hehfl
         VK1s+dg6FXqty2zdaSu2dafu76d+RbYbTpaM2Bg9bDGEykMo315M0QuHtS2D0DPUD9wE
         34mCX+uZGTtxCpz5xDOI1XVlGiWIe56rjj4CSXgMsEwuw84oV608CBKwsDLqC/bZmAnx
         ak4EbLpRQmWdCqHcRq5kYSxD6+2xZz9Rv1Il65IZeFqh+xRaCo0fI2KZH0kIIuX3+4pU
         HVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740309760; x=1740914560;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LDItQAI1o55x4csyyYDcB1y5jXzN4ZM+5Iz7ltjo1wg=;
        b=W5OSY1NhfEGeWBBuC5O4ZTHHfTS8VBvZ2YYZftzrE+EfOfYymdKi0l1ZvMd6gjXGDm
         84sP40M6gePE6VbfvOBXjCL6AWcell32vnyAf2/2Q4CBTf/IP49NWkDAG283WL3nrfh4
         /ukKuaqgW3Z/2zWividyBKVU67+rABWJ0gevIrGpNkgajbBjsWxOy0GV/Y4bK8yFla+y
         Pyi3tOODN3iv5Ykl/387c1ibmOk2j8z3G5wBWlJZn5F4bsE1GEFrj17wVNzixr42Hbq5
         Vci5kgFERTok72Aqszj626s7x8W71gucyp1Fx7XYWBjc1csR4zSTMHjkDKhGhqraW6Bp
         cBCA==
X-Forwarded-Encrypted: i=1; AJvYcCW/xV8XVMqUCLlwjp/TZcdB+rPRtp0Yd7j0hHAAlSt1Erda6RJeN7jFNxC/3qFtQTy8exBVnUPlH3XuBwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiFl2qWTAt/kiX+QQJOepkbzL1fkpuNL+WpCCHGX0z9ahG8Yus
	9bHbbDlMosjnAtV/48FJho9zBxFuxl7Gx06omKjMy1gN6wxENn3xMLd3dsWJNzo=
X-Gm-Gg: ASbGnct0H0beyh8Vwz23yK+ZfyK2vPd5k/44zhD1QlYQ6nIVJ/X8PYdNmZzxm5AuVnq
	mi+kWLZxCprzQuEC0dN1k2zImdrBoogNVY+oPxBDzBcP62tQ/b2b6csSHcITaOLPRRg8ju52dHl
	gg6syFkMQ/tol58rMp8FoQG76i+zcYj3T/YX1Jg77OOtS7rm79UvNlwPEqJJzLHBGz0th9YfXUj
	Zt43g1G0DGADl59HGkRvtr3ASm+Vz/SCaQy2cGzt8LeO8fpMwcdbml7YyFhtLkuLN/V0rvgPbLv
	7778X7pLcpExZQ4L1ObIzk1e5zLZhPiYC48zVGwErOJRyil5Zg==
X-Google-Smtp-Source: AGHT+IEPxTGm3RYOgyXIOZF3oIfqFjpymk5LxNqACH8176Bi4hPmS84buqqkahWH74iRPCMk/lOybA==
X-Received: by 2002:a17:903:22c6:b0:21f:f02:4154 with SMTP id d9443c01a7336-2219ffe0dbdmr60219715ad.11.1740309760308;
        Sun, 23 Feb 2025 03:22:40 -0800 (PST)
Received: from [10.254.22.156] ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d537d0f2sm163538725ad.105.2025.02.23.03.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Feb 2025 03:22:39 -0800 (PST)
Message-ID: <83f8b833-af79-4d77-a179-5065aec994dc@bytedance.com>
Date: Sun, 23 Feb 2025 19:22:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH 2/2] sched/fair: Fix premature check of
 WAKEUP_PREEMPTION
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Josh Don <joshdon@google.com>, Tianchen Ding <dtcccc@linux.alibaba.com>,
 "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
References: <20250221111226.64455-1-wuyun.abel@bytedance.com>
 <20250221111226.64455-3-wuyun.abel@bytedance.com>
 <CAKfTPtBzsX6GKZP_NGTONrkp96qx9uOHr0+XG7tC6ELy4tbHBg@mail.gmail.com>
 <6097164a-aa99-4869-b666-9dc7018c1f96@bytedance.com>
 <e1cfabab-1326-4cd8-a8a4-4b3fc4c1f7ec@linux.ibm.com>
 <9d9d7432-9a5d-4216-ac53-a0f333a35d8f@bytedance.com>
 <d1237acd-9e3c-4ab9-8628-31d98fcf7638@linux.ibm.com>
Content-Language: en-US
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <d1237acd-9e3c-4ab9-8628-31d98fcf7638@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/23/25 6:25 PM, Madadi Vineeth Reddy Wrote:
> On 23/02/25 14:14, Abel Wu wrote:
>> Hi Madadi,
>>
>> On 2/23/25 2:16 AM, Madadi Vineeth Reddy Wrote:
>>> On 21/02/25 21:27, Abel Wu wrote:
>>>> On 2/21/25 7:49 PM, Vincent Guittot Wrote:
>>>>> On Fri, 21 Feb 2025 at 12:12, Abel Wu <wuyun.abel@bytedance.com> wrote:
>>>>>>
>>>>>> Idle tasks are by definition preempted by non-idle tasks whether feat
>>>>>> WAKEUP_PREEMPTION is enabled or not. This isn't true any longer since
>>>>>
>>>>> I don't think it's true, only "sched_idle never preempts others" is
>>>>> always true but sched_feat(WAKEUP_PREEMPTION) is mainly there for
>>>>> debug purpose so if WAKEUP_PREEMPTION is false then nobody preempts
>>>>> others at wakeup, idle, batch or normal
>>>>
>>>> Hi Vincent, thanks for your comment!
>>>>
>>>> The SCHED_IDLE "definition" of being preempted by non-idle tasks comes
>>>> from commit 6bc912b71b6f ("sched: SCHED_OTHER vs SCHED_IDLE isolation")
>>>> which said:
>>>>
>>>>       - no SCHED_IDLE buddies
>>>>       - never let SCHED_IDLE preempt on wakeup
>>>>       - always preempt SCHED_IDLE on wakeup
>>>>       - limit SLEEPER fairness for SCHED_IDLE
>>>>
>>>> and that commit let it be preempted before checking WAKEUP_PREEMPTION.
>>>> The rules were introduced in 2009, and to the best of my knowledge there
>>>> seemed no behavior change ever since. Please correct me if I missed
>>>> anything.
>>>
>>> As Vincent mentioned, WAKEUP_PREEMPTION is primarily for debugging. Maybe
>>> it would help to document that SCHED_IDLE tasks are not preempted by non-idle
>>> tasks when WAKEUP_PREEMPTION is disabled. Otherwise, the intent of having no
>>> preemptions for debugging would be lost.
>>>
>>> Thoughts?
>>
>> I am not sure I really understand the purpose of this debug feature.
>> If it wants to provide a way to check whether a performance degrade of
>> certain workload is due to overscheduling or not, then do we really
>> care about performance of SCHED_IDLE workloads and why?
> 
> It's true that we may not be too concerned about performance with
> SCHED_IDLE. The issue is preserve the original SCHED_IDLE definition
> versus WAKEUP_PREEMPTION, which applies across all policies. Since by

Yes, exactly.

> default the feature is true. I am not sure. Either way seems ok to me.

Hi Vincent,

Since Peter gave the priority to SCHED_IDLE semantics over WAKEUP_PREEMPTION
in his commit 6bc912b71b6f ("sched: SCHED_OTHER vs SCHED_IDLE isolation"),
and the choice is kept unchanged for quite a long time until the recent merged
commit faa42d29419d ("sched/fair: Make SCHED_IDLE entity be preempted in strict hierarchy")
which seemed not intend to change it, shall we restore the choice for now and
leave the discussion of the scope of WAKEUP_PREEMPTION to the future once any
usecase shows up?

Thanks,
	Abel


