Return-Path: <linux-kernel+bounces-522389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F336BA3C980
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B72D16048F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466BE22DFF3;
	Wed, 19 Feb 2025 20:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fYAgmS5V"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5441B4247
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 20:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739996345; cv=none; b=XrICIYdjHnAFUE1wbOh9x63ZOKoflWyeernyxGGnCzm1UOjIBFn3YU/VsEWbNzoHw6zbJuXjsZJCaxSWR5MVp6WkosNpV5tvSJVAo/2i8Gp34SkOTBzUZAVqSvJIVR/BPgAL4l4GK4ugjQl4o80Ml0lnJ6mCmNbZ4e9AVWeIxpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739996345; c=relaxed/simple;
	bh=lsSHzRCNLy63NlqU1QkNa2XHSRz50rpwo5U8svMFqQk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mbPRO0F81BqmXW7/SHzFaUScLnTbs/OMJLGu+iAvqa/+qiNKkvbWGcVDYmx28UvvZvDMT26AVL/EL11Ks5T5uApoU+qzZBx+QjvPyXCXN8+EUdB5oDB4nr7zE9hgeKVKCecsv0kacAoEfdw24nJ8C9aRLEeHlOJ9LSPlpwyU/JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fYAgmS5V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739996342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+AH4scGbKIzpZqSLnVZxg/gjNhNXB6eTJvEQUNi8u6Q=;
	b=fYAgmS5Vddt3+E6GUpE+c65IZnEEOYmTd8cB2quqZrY7FqCHqEzoURfJawfv34A+s/Fks3
	gCUmpHamlhNwI53ZIwZYArCAbRUKjmbX4C01TE9HUbMnwZyHO5d3hOM6IdnfmxCPKzeU15
	hNC4MmSvB33+k0tlCvLOIKvjZ3z+ROg=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-1j23WDkKPayudmqKaoa9zg-1; Wed, 19 Feb 2025 15:19:01 -0500
X-MC-Unique: 1j23WDkKPayudmqKaoa9zg-1
X-Mimecast-MFC-AGG-ID: 1j23WDkKPayudmqKaoa9zg_1739996341
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-2a8e3905c56so38276fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 12:19:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739996341; x=1740601141;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+AH4scGbKIzpZqSLnVZxg/gjNhNXB6eTJvEQUNi8u6Q=;
        b=r6L9ylBCfq0jm+dtSvVXA0UgxLar5zTxTC5qz1tqmVjyEyAt01PxikTjCG47cJWD9z
         BTJB1+0ubFWM3hm0sat47Yjtpnfv+r6Uq/gjm8M24JOQa5sZl3xtnqT3ffWS0RcIE7bQ
         T9G0s0gbOww/f+QXZn9YL+MwNx84tQswoWfsLyD1KlGL6ENpuEyoLiRskh2/oILzeCDq
         Ns/7xk7P31knqRjOHvnHAXl+xWwyQzqt8+7lluBZIxRE9pazgIrLP1BHuVpYo1EJfU/t
         UL6h0McToNhzDLIqILWKrvvsz5Mc4KLYYNR3/KDGnxM7d7DzkSYPeZpwGIJ9d05Eu7Ij
         kBjA==
X-Forwarded-Encrypted: i=1; AJvYcCU6Ood6tFDO1xhSdZUw2M8uyH79wMuHOUSMpwHby9PNWhryIHBMy6hhsoo6qw0w7Zcm9UJo9Zv1KKDhXIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh9ZbCkfHOAeGy3k0X452VzbFyS6TZwtPFoxHFDFQUrbAL04Oy
	TUzjPR/2KDB8iwE3LLqBegFWpc22LMP0xFLiGq8zRGmJ/Wi+FpaVehSdpCLWrXmdR/0iJa9+A5h
	t5xpLgd58/GWEf0D6Kr++26XTTwIB9NxlbqE5+7nvs2tzdcH6kmlaiY4nQ9QP8g==
X-Gm-Gg: ASbGncvM9iRQHnp5f1qTJdJp9LtQK9dJiXXxNrL5iq4jonmOfpdYy01AsWMxWTFiJlF
	kbkn/THnYtj0dblN4EGbTTCexVXBiSKOefKDd9OcHO9xyU4sf4H7WkXZMzUSLTmRF7WvMcvOZmi
	Fb7MxcouO5ryrdsbR879PlOZP2HIHel7GFt4JFAYd+tuNIFlxqTAUEYLfOluu7sCPhm4Rw51jAP
	PYhBOK0csAVZwa50duolDCRsn2Fo8uYElrp7buJ2AOPRg/24rzfRtdc9DLUo78FcTBwSdb/PlzL
	uidKMcQviebWP5Jklv0rLdI59f55VHUmt3QmaHwga7y+1B2E
X-Received: by 2002:a05:6870:8998:b0:2b8:3a1f:6351 with SMTP id 586e51a60fabf-2bc99dcc5efmr12526877fac.34.1739996340659;
        Wed, 19 Feb 2025 12:19:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrJxX62AmjCm6onqMRcZ6OFMOdNVajrQy68F4HE2zaP9IEVg4qTVl8EutVYzFzQflHTieqAg==
X-Received: by 2002:a05:6870:8998:b0:2b8:3a1f:6351 with SMTP id 586e51a60fabf-2bc99dcc5efmr12526841fac.34.1739996340309;
        Wed, 19 Feb 2025 12:19:00 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2bc69a3af4fsm5484323fac.19.2025.02.19.12.18.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 12:18:59 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <0fa9dd8e-2d83-487e-bfb1-1f5d20cd9fe6@redhat.com>
Date: Wed, 19 Feb 2025 15:18:57 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hung_task: Show the blocker task if the task is hung
 on mutex
To: Steven Rostedt <rostedt@goodmis.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Boqun Feng <boqun.feng@gmail.com>, Joel Granados <joel.granados@kernel.org>,
 Anna Schumaker <anna.schumaker@oracle.com>, Lance Yang
 <ioworker0@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>,
 Yongliang Gao <leonylgao@tencent.com>, Tomasz Figa <tfiga@chromium.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org,
 Linux Memory Management List <linux-mm@kvack.org>
References: <173997003868.2137198.9462617208992136056.stgit@mhiramat.tok.corp.google.com>
 <173997004932.2137198.7959507113210521328.stgit@mhiramat.tok.corp.google.com>
 <20250219112308.5d905680@gandalf.local.home>
Content-Language: en-US
In-Reply-To: <20250219112308.5d905680@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/25 11:23 AM, Steven Rostedt wrote:
> On Wed, 19 Feb 2025 22:00:49 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
>
>> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>
>> The "hung_task" shows a long-time uninterruptible slept task, but most
>> often, it's blocked on a mutex acquired by another task. Without
>> dumping such a task, investigating the root cause of the hung task
>> problem is very difficult.
>>
>> Fortunately CONFIG_DEBUG_MUTEXES=y allows us to identify the mutex
>> blocking the task. And the mutex has "owner" information, which can
>> be used to find the owner task and dump it with hung tasks.
>>
>> With this change, the hung task shows blocker task's info like below;
>>
> We've hit bugs like this in the field a few times, and it was very
> difficult to debug. Something like this would have made our lives much
> easier!
I agree that it will be a useful feature.
>> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>> ---
>>   kernel/hung_task.c           |   38 ++++++++++++++++++++++++++++++++++++++
>>   kernel/locking/mutex-debug.c |    1 +
>>   kernel/locking/mutex.c       |    9 +++++++++
>>   kernel/locking/mutex.h       |    6 ++++++
>>   4 files changed, 54 insertions(+)
>>
>> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
>> index 04efa7a6e69b..d1ce69504090 100644
>> --- a/kernel/hung_task.c
>> +++ b/kernel/hung_task.c
>> @@ -25,6 +25,8 @@
>>   
>>   #include <trace/events/sched.h>
>>   
>> +#include "locking/mutex.h"
>> +
>>   /*
>>    * The number of tasks checked:
>>    */
>> @@ -93,6 +95,41 @@ static struct notifier_block panic_block = {
>>   	.notifier_call = hung_task_panic,
>>   };
>>   
>> +
>> +#ifdef CONFIG_DEBUG_MUTEXES
>> +static void debug_show_blocker(struct task_struct *task)
>> +{
>> +	struct task_struct *g, *t;
>> +	unsigned long owner;
>> +	struct mutex *lock;
>> +
>> +	if (!task->blocked_on)
>> +		return;
>> +
>> +	lock = task->blocked_on->mutex;
> This is a catch 22. To look at the task's blocked_on, we need the
> lock->wait_lock held, otherwise this could be an issue. But to get that
> lock, we need to look at the task's blocked_on field! As this can race.
>
> Another thing is that the waiter is on the task's stack. Perhaps we need to
> move this into sched/core.c and be able to lock the task's rq. Because even
> something like:
>
> 	waiter = READ_ONCE(task->blocked_on);
>
> May be garbage if the task were to suddenly wake up and run.
>
> Now if we were able to lock the task's rq, which would prevent it from
> being woken up, then the blocked_on field would not be at risk of being
> corrupted.

It is tricky to access the mutex_waiter structure which is allocated 
from stack. So another way to work around this issue is to add a new 
blocked_on_mutex field in task_struct to directly point to relevant 
mutex. Yes, that increase the size of task_struct by 8 bytes, but it is 
a pretty large structure anyway. Using READ_ONCE/WRITE_ONCE() to access 
this field, we don't need to take lock, though taking the wait_lock may 
still be needed to examine other information inside the mutex.

Cheers,
Longman


