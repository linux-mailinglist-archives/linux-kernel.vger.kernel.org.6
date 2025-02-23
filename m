Return-Path: <linux-kernel+bounces-527626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7C2A40D6C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 09:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFA33189761D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 08:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF241FF1BF;
	Sun, 23 Feb 2025 08:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Ok2I9KKY"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB36527456
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 08:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740300303; cv=none; b=OwcerEMIpCBskNP/q3Hps1i/v382weJ3HzJRfrTcyu8o79Sw1dQFFAYWy3lTccm1fdedHh6bjshtU6Cx5A7UKrx1I+afGcTN6xdmm/H9n5BJ2Q5jHf5z+O1/a+TY1e/dScXzOaugsaqaAP94jkCo/WujLR8QAli3uCtUYcwtr38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740300303; c=relaxed/simple;
	bh=SZ0T2q3XF4HYP7TyrzVin4FMdnP0hClGKE3eWmTxdnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DKGECEMYNulkGqvM94tYQpQ2g/mcs382xh70PuJcEnQk1O1MFX7CaMxIb9axc0qm9D9//Nz46Ufdl54SI3pBrcG1R1sQvBIUorFam8RV0OTM90JbVDdXWoUBJhbCXLauyQW9YZkE50hWIBa8NVZqn0mzwd+LhlI0EQFCRlXuG/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Ok2I9KKY; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fc92215d15so953357a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 00:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740300300; x=1740905100; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oJJTF3HYuaSbL/88LkGxzdFLu+BfzcO92rEBv37Veyg=;
        b=Ok2I9KKY2WSQlplpLeo2/IdTD4sCe8C0jbIxohBVerKSS7G8yh07OiIHGmBlPKnSal
         CNX65Kms81JUB7uv4t8ojiPIF9c+J2kxL7Vtq/yc+BbSBo24oirKtdldbnv9in+deHOz
         DqjP3ch6IqkY2+aQ2Mk4hM5hhe14AaK7mX1lakKiQuxpasT6Po89nRfCHR4mJSjKzCck
         paJqGjlRM0kriruv3qgyAoMhmPUl1/X/FB0k8VuAdJC1yj/Cfuo4qxzvbcsi7DIJbx70
         aXCc6gQua3tHrSyrqTH4HWhH8bsvkcC67SXBlO12BNs+DgAjNu8ym8pzZM1CaH8rqk9f
         qe8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740300300; x=1740905100;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oJJTF3HYuaSbL/88LkGxzdFLu+BfzcO92rEBv37Veyg=;
        b=d7Yq4H8PgZom7vD+5BmL7ghs9OiPb5jwrbU6dqviuUIAaZkMnoTdUfaKCTphYz5jZp
         oIc0Jv4LcEL/4gU5q3GSieL1eMqUucreJVqNk7MQmteqyt90PSljCPkeYwkxD7jZ6R3w
         DVYgy1SHKeNQ3MBWQXvNpjlDlBxuzq4ay/ePNly3Mik3h+Nqn0JccFADgOrMlzaML7gr
         CgGPVWlOPCj7jtNcpG8RCZqHkXxeWaBPldxiaRtMXdWw7xgKVwgjYEZ0Ha0DHs7vIJsq
         M2BD5gHc4+GGjY4HIpUg2H5MYQpA6DWmQbhEnUF250dpe8NCi56wB5SQ5PYX9UKolXBl
         732Q==
X-Forwarded-Encrypted: i=1; AJvYcCWu/Jxwnnk0I/feqylzaaUSjWAL+fy7NDWANPCIXSkF++Ocjj0CRR7D9XmQ7O3Dycv51WWHv2+nb2gChiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmqfHHxyct0RPDdBjKqyWhCYhMNyDfXBZymxWd15Qyxpl/7f9K
	Y0/g4LeoPkjFFrhKdvOuNkihARhyBpA4NEBtD/8nxY2Mn9UJpR8R5JAx318vOOQ=
X-Gm-Gg: ASbGncvkfk5lZnNUmXmdwPMqX6/UeczYB7s2GmmV5PiTZXoMxqj2UVo9c7pwMSIF2RC
	AnIu4jOoP97WAaaBrXJpI5Q4mK+zL38Z8Ck53g/LeXPEEMBUzDoNbNr3zU/EtzdwYgMY42conKc
	sBuZBSUpDf9j9il2gAqNlzMMvekEzUOM/e6CEXo/YyN/nS+8EVTwq0l3Xx8Z9NY3HJKQU6afQ7y
	9KX31t7bQHsBnrESLXGzLN32hr7GKk4byI35PbMeoZsKb9jC+JWEn8ieIJ2ZUmUi9giKbyPyWsE
	eUH57RDjPO508y9BdQQ5pVz1aE7LVd2rbQdfPMU7IhniFA0XRK/mmpG5MfolNojTDwyam+FzPqz
	+ugnU5RuOpnzByQ==
X-Google-Smtp-Source: AGHT+IETX0ESoUIAgtzt1KCCNBxjuoR/U//Uk3J5qXSI+DLh2497upcZ2d6dyrwQTH19/4XOyyyhKg==
X-Received: by 2002:a17:903:294e:b0:216:42fd:79d8 with SMTP id d9443c01a7336-2219ffd8076mr60802665ad.12.1740300299881;
        Sun, 23 Feb 2025 00:44:59 -0800 (PST)
Received: from [10.200.58.71] (151.240.142.34.bc.googleusercontent.com. [34.142.240.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d7a540aasm158706295ad.245.2025.02.23.00.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Feb 2025 00:44:59 -0800 (PST)
Message-ID: <9d9d7432-9a5d-4216-ac53-a0f333a35d8f@bytedance.com>
Date: Sun, 23 Feb 2025 16:44:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH 2/2] sched/fair: Fix premature check of
 WAKEUP_PREEMPTION
Content-Language: en-US
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
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <e1cfabab-1326-4cd8-a8a4-4b3fc4c1f7ec@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Madadi,

On 2/23/25 2:16 AM, Madadi Vineeth Reddy Wrote:
> On 21/02/25 21:27, Abel Wu wrote:
>> On 2/21/25 7:49 PM, Vincent Guittot Wrote:
>>> On Fri, 21 Feb 2025 at 12:12, Abel Wu <wuyun.abel@bytedance.com> wrote:
>>>>
>>>> Idle tasks are by definition preempted by non-idle tasks whether feat
>>>> WAKEUP_PREEMPTION is enabled or not. This isn't true any longer since
>>>
>>> I don't think it's true, only "sched_idle never preempts others" is
>>> always true but sched_feat(WAKEUP_PREEMPTION) is mainly there for
>>> debug purpose so if WAKEUP_PREEMPTION is false then nobody preempts
>>> others at wakeup, idle, batch or normal
>>
>> Hi Vincent, thanks for your comment!
>>
>> The SCHED_IDLE "definition" of being preempted by non-idle tasks comes
>> from commit 6bc912b71b6f ("sched: SCHED_OTHER vs SCHED_IDLE isolation")
>> which said:
>>
>>      - no SCHED_IDLE buddies
>>      - never let SCHED_IDLE preempt on wakeup
>>      - always preempt SCHED_IDLE on wakeup
>>      - limit SLEEPER fairness for SCHED_IDLE
>>
>> and that commit let it be preempted before checking WAKEUP_PREEMPTION.
>> The rules were introduced in 2009, and to the best of my knowledge there
>> seemed no behavior change ever since. Please correct me if I missed
>> anything.
> 
> As Vincent mentioned, WAKEUP_PREEMPTION is primarily for debugging. Maybe
> it would help to document that SCHED_IDLE tasks are not preempted by non-idle
> tasks when WAKEUP_PREEMPTION is disabled. Otherwise, the intent of having no
> preemptions for debugging would be lost.
> 
> Thoughts?

I am not sure I really understand the purpose of this debug feature.
If it wants to provide a way to check whether a performance degrade of
certain workload is due to overscheduling or not, then do we really
care about performance of SCHED_IDLE workloads and why?

IMHO preempting SCHED_IDLE before WAKEUP_PREEMPTION is to preserve the
IDLE semantics trying to behave like real idle task. It is somehow
weird to me that we treat sched-idle cpus as idle while don't let the
non-idle tasks run immediately on sched-idle cpus on debug case.

Thanks,
	Abel


