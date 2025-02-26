Return-Path: <linux-kernel+bounces-533194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AB1A456C0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2157175030
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEE5267F48;
	Wed, 26 Feb 2025 07:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LH1/iPRk"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7B117F7
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 07:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740555299; cv=none; b=oUhPS2IvMnqC3EmQ/LV5ttr47ONLIhaTPAr9txa406pX0OtsU/OWYBGFJh8WmcrjMSWKLGqc0H6lSerKZLG9EEfb4sJocoNEJ32Fea7/buJO5IKaMVkmhBkblR8+xPrJXAAtS3dBC2rds9s0L4paZiFSto5CThLJ1n1u716RhEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740555299; c=relaxed/simple;
	bh=/9QbEammsDZ+MoV+baU38H7A9jyD0bz943mZsN0lqno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=To9djN+H0CIOrpDhLPOy0H1eL3r1oGPVHMcSvefJYfnjggdVJQgUtfFKL4FMxYcI3jmXwr4vPkGc2J/mGNpgClP4+3l1NQ7Z9vBdSt4CQVVhzfwoFZNV9+pL0bOhjuPtLIFBZNr30DWwVvZ1oiAMLw8PPHX/KK7dI5DLmxBBJjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LH1/iPRk; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2217875d103so14957675ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 23:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740555296; x=1741160096; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x28X5fsQ4xsFzZbMl6btgjD9I7okMDzYyUFTw0zKYAU=;
        b=LH1/iPRkqBmaEtK/jIgRYxJJCMIm86CYGo+nSwOzY0HkQZrPf7UEDmsFtUiIHUTq+S
         8oOCu0djAvBSjz/8Aicvcx4W/Gy7TtpmSOjEy8X8QVQrCMwBgYAJo4/7TIVGKLA/BTws
         i8vtgglKS1r7UvyFStp75iNaHD5Oflyl3JR6jlJIPwRMCnWUbQueKtsK3IXjv/QmD0ya
         kPg+tBISzwNx02RiG33Te80scBpLo/p60EezlUHJbnF66sraCKnf3cUBZgbtG7chVlW8
         tpiMmNUAszQ64I8UC6gcH/1/lUtTvffAqCb8+SZqBlGLPJHT+Rp6WY9uor0CI2feDUSF
         Fl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740555296; x=1741160096;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x28X5fsQ4xsFzZbMl6btgjD9I7okMDzYyUFTw0zKYAU=;
        b=jhxK9lEsodjDsPnwKZ2CSVBo9P1kd+SsQvdRV76hfpJnkV39hw1/WfsT5qBk13nqnj
         nK+mMGZVpwszJ62GEirNmauzLHt/k/eUYA1Q95DOFyYDFkZBxBL+CW2OsPKUy0UMl2v2
         r3wwsoudVBVWbqWHPYMiZgSWQN07Xyr44LFuJehbBz3rzM4VqBWIrOOjgfIVDevcNUT+
         Qmg51uAR+HRbzSnhdk+fWWGFRw73BGw/hSyddg/YQfrTogKISdFUJjzZtVsU10i7mLxf
         ll4TNUZGx7iroJNJ5y6c5IJqWkg258FjWcoVNa4NUP8hlajTPxXUjUR+7LQNUQJGjuBb
         iCbw==
X-Forwarded-Encrypted: i=1; AJvYcCV1Q31YBRI4aj1RhqhxUKMXuPA/wYhSuZ5Z/HpMWTfySQul/z3QDVQY+WlnNtrxWOMqQybdiy2FfgSpx+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI/afvuadnZ0lcyX3Q3fy2gJdIb3d004tTIWKvUFKK5zZzklpu
	vpPAu7l1JRUFEaUvxtOG+LGhcHJ8ccThJ0gr2UfV2erkfOhdScFYySkChtgEeUw=
X-Gm-Gg: ASbGncvwhAuZFPpGhSMtvIxpPkg5xW1VY4/6GS0XwDLCjTSpAEIGOLELp8WmUWgjF9F
	nma510Lxe9y2AsLuBYshgoivcvq/DPVxrswemMf0PxcEqaTBHLRwrSGmq5QHi/e5awNloM9Ceat
	irm7j84+1mBLIPjWah9Wkr3qMMcq5kSCivhrKe1uLSg1YDB2RYXlfrQNEGNciA3+nEZALjwIRRm
	o61XnHKp0zWGn108xHoNqPQtGg0UiU8nGtGWp0X8iJPuA5OUGgHDR4gq9SFYHQWu9fW1XexHRqm
	2e1OWCe39sxKa7mrSE9P+0+OJsFrJjv+e2TpcF4DOXUcIpDdkQ==
X-Google-Smtp-Source: AGHT+IFuZoh/ho8qVqDkdMTi0yIlI5WhSBQL6i4pi70UQGjl82bhDOPMaLQVwuG9+czS7vsnF3g3jw==
X-Received: by 2002:a17:902:cec6:b0:220:d71d:4666 with SMTP id d9443c01a7336-2219fff855emr123473605ad.13.1740555296305;
        Tue, 25 Feb 2025 23:34:56 -0800 (PST)
Received: from [10.254.225.63] ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a0a3bfcsm26110265ad.164.2025.02.25.23.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 23:34:55 -0800 (PST)
Message-ID: <b37f144b-5d99-4b86-a074-e50ffbca619c@bytedance.com>
Date: Wed, 26 Feb 2025 15:34:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH 2/2] sched/fair: Fix premature check of
 WAKEUP_PREEMPTION
To: Vincent Guittot <vincent.guittot@linaro.org>,
 Tianchen Ding <dtcccc@linux.alibaba.com>
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Josh Don <joshdon@google.com>,
 "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
References: <20250221111226.64455-1-wuyun.abel@bytedance.com>
 <20250221111226.64455-3-wuyun.abel@bytedance.com>
 <CAKfTPtBzsX6GKZP_NGTONrkp96qx9uOHr0+XG7tC6ELy4tbHBg@mail.gmail.com>
 <6097164a-aa99-4869-b666-9dc7018c1f96@bytedance.com>
 <e1cfabab-1326-4cd8-a8a4-4b3fc4c1f7ec@linux.ibm.com>
 <9d9d7432-9a5d-4216-ac53-a0f333a35d8f@bytedance.com>
 <d1237acd-9e3c-4ab9-8628-31d98fcf7638@linux.ibm.com>
 <83f8b833-af79-4d77-a179-5065aec994dc@bytedance.com>
 <CAKfTPtBL4aPbEDOa8jJ+h2wQ9CLU80=0mQdrc07vfqBVswzAsg@mail.gmail.com>
 <ffda0c9a-0794-4080-921f-99f0c31e2d6c@bytedance.com>
 <CAKfTPtC-pSxpk9i1T4rgc8U7M-nYJ_fdJKaBJa-1dwi9+scTbg@mail.gmail.com>
Content-Language: en-US
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <CAKfTPtC-pSxpk9i1T4rgc8U7M-nYJ_fdJKaBJa-1dwi9+scTbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/26/25 1:15 AM, Vincent Guittot wrote:
> On Tue, 25 Feb 2025 at 07:29, Abel Wu <wuyun.abel@bytedance.com> wrote:
>>
>> On 2/24/25 9:47 PM, Vincent Guittot wrote:
>>>
>>> Or we should just remove it. I'm curious to know who used it during
>>> the last couple of years ? Having in mind that lazy preemption adds
>>
>> TBH I have never used this feature. But since Phil mentioned a case
>> in debugging DELAY_DEQUEUE, I think we'd better keep it, what do you
>> think?
> 
> Yes. And we need to figure out how to deal with the below as well

Hi Vincent, Tianchen,

I'm not sure this is the right way to do to let SCHED_IDLE be promoted
to the full NEED_RESCHED, as LAZY has relaxed responsiveness of normal
tasks to TICK_NSEC/2 in avg and workloads using fair policies should
adjust their expectations on it. And I would also recommend scheduling
policies playing with each other inside the scope of policy, while the
preemption model is another scope. Tying the two scopes together might
make things complicate, although I can imagine that certain workloads
or scenarios will benefit from it.

Best Regards,
	Abel

> 
>>
>>> another level as check_preempt_wakeup_fair()  uses it so sched-idle
>>> tasks might not always be immediately preempted anyway.
>>
>> Right, thanks for mention that.
>>
>>>
>>>
>>>>
>>>> Thanks,
>>>>           Abel
>>>>
>>


