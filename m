Return-Path: <linux-kernel+bounces-355266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 296D7994EE4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A93661F22709
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1492D1DF973;
	Tue,  8 Oct 2024 13:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g52CjfDw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD48A1DF971
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 13:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393702; cv=none; b=SHZKDeZhFYrfdLmFgpzvQl2sdqjkWR8hteDKt222lgXircTqgpfiVMCpbuG7dFWHYHpftTWxjSgdJRPxmYzS+v6SPCTNziOYgh6zmqK1BbSmEtdNuuS6sCpPsnNmroFQv3t+mCF/Q19uZNzNO9CJmogye4xqBBM4yXhH1lUbnVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393702; c=relaxed/simple;
	bh=ajP7n0RqPyNoSyNoOW70sWnt1w9sBqfDzQAKeg1G680=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=sKkf+3Nicm0C3Ch+XMpd73qNFJdHPKzcmH8wsAFT+ZaqTkMYngJSd4p5/yhMAJShPyKJow2DSmTRnsT3DeuOmwGXLs5XrimA/4Or4FB1+LsdTJon/A9fBs1Sd0eZIzzEcI53bBrD//6UUmkBdNDTM16+oeHlR9lMzYMN573k4EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g52CjfDw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728393699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3i4WY4hzjXrQpVRw975Aj9ZRsZd7OJ2Z1ha+ChceVpo=;
	b=g52CjfDwnEZOmLDQZvP4jhUiDMW3BpV2AK+NQas6CGHrQpefMkVFMWTWbzUtX96u1NyuIU
	zqk9QzY3gjHHKo2aWj1/HF1XjYqb7VKwKqzkqdRiDzbFnLHsjTNz3jP5cAux1fFzCDU9iW
	t6T4sTNgGt2od680Wodghs9RE0P0TnA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-Ui73j019P2K2gKiXYSpC4Q-1; Tue, 08 Oct 2024 09:21:36 -0400
X-MC-Unique: Ui73j019P2K2gKiXYSpC4Q-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6cb38a37b56so93651716d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 06:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728393696; x=1728998496;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3i4WY4hzjXrQpVRw975Aj9ZRsZd7OJ2Z1ha+ChceVpo=;
        b=JfAIJ6YhfISJJOkxD4kNpe7Mh+huzhCa8sc2L4oPEKnc0BYayQEO6AKPbdGGQoo5T0
         Cp3k2gSi0J1ANsPS2uebJXhRRDrRc/VwzR0tukzs1yROuRji7yOSHA3A99S1zbK9CGru
         vLuj4IdoaEdmjuxW8ARZBhYWzsNeXD1jW9lu4AOoAYQ0vyAI4Yrkf2Nd88jj/qT2v9Zc
         D180flnc3mKZw0BDscFpNH9sYFaL6GVE0j4iGOAHAwHUsIh8aQSm0AxG1+5nvkPmsBxo
         WvzOihB3ffe+8WHQU3Ku4z4olDJA9DThxrCkML3OM5zXWZWtx+RMq4ulQcFbURUdjMxQ
         fplw==
X-Forwarded-Encrypted: i=1; AJvYcCX7y5xKc1gB15h7UigFAWpj50y27SaUjeIBzAeMjn+nbMRvWIueUyx0UQdUgNN7BMoT8jG8VzLmkLyTrbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy32B2yF6WMSrUkgMp+Fo8EdCtmTZjyfQes5XWwy70QB0y1r/H7
	6L+q1/2/8e71uFQiThnT36QL7vlnreVVuz7mVfUOKphKd28tci8DSEbhfSwGLKABmbM8Nm41UMT
	QyCogWNkVyWqeI5IANr1g0Z5UpkXNRmfKrqtR1K899Hiy8MiysMF9wz/6AxzbdA==
X-Received: by 2002:a05:6214:4688:b0:6cb:c684:fc4d with SMTP id 6a1803df08f44-6cbc684fcd4mr14237276d6.19.1728393695869;
        Tue, 08 Oct 2024 06:21:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZeY9f3MBY87PiWg12jEFRJZvaHHw90qEh6qk+10li/oi+JBY5TvX1wgYyK+tiXYrQIHwZMQ==
X-Received: by 2002:a05:6214:4688:b0:6cb:c684:fc4d with SMTP id 6a1803df08f44-6cbc684fcd4mr14236956d6.19.1728393695436;
        Tue, 08 Oct 2024 06:21:35 -0700 (PDT)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7afcab06219sm37232985a.132.2024.10.08.06.21.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 06:21:34 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <ce60b576-b8bd-49da-90b1-a84c7cb0eb9e@redhat.com>
Date: Tue, 8 Oct 2024 09:21:34 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locking/rtmutex: Always use trylock in rt_mutex_trylock()
To: Peter Zijlstra <peterz@infradead.org>, Waiman Long <llong@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Luis Goncalves <lgoncalv@redhat.com>,
 Chunyu Hu <chuhu@redhat.com>
References: <20240926151315.507905-1-longman@redhat.com>
 <20241002093745.GO5594@noisy.programming.kicks-ass.net>
 <7918987a-4b66-4191-aa52-798f9434352a@redhat.com>
 <20241007145037.GE4879@noisy.programming.kicks-ass.net>
 <95365aa5-d039-4d09-8191-516ba01c9e5d@redhat.com>
 <20241007153341.GA14587@noisy.programming.kicks-ass.net>
 <13f78472-2fa8-4af9-9d5f-a93cb16cc7ca@redhat.com>
 <20241008073800.GD14587@noisy.programming.kicks-ass.net>
Content-Language: en-US
In-Reply-To: <20241008073800.GD14587@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/8/24 3:38 AM, Peter Zijlstra wrote:
> On Mon, Oct 07, 2024 at 11:54:54AM -0400, Waiman Long wrote:
>> On 10/7/24 11:33 AM, Peter Zijlstra wrote:
>>> On Mon, Oct 07, 2024 at 11:23:32AM -0400, Waiman Long wrote:
>>>
>>>>> Is the problem that:
>>>>>
>>>>> 	sched_tick()
>>>             raw_spin_lock(&rq->__lock);
>>>>> 	  task_tick_mm_cid()
>>>>> 	    task_work_add()
>>>>> 	      kasan_save_stack()
>>>>> 	        idiotic crap while holding rq->__lock ?
>>>>>
>>>>> Because afaict that is completely insane. And has nothing to do with
>>>>> rtmutex.
>>>>>
>>>>> We are not going to change rtmutex because instrumentation shit is shit.
>>>> Yes, it is because of KASAN that causes page allocation while holding the
>>>> rq->__lock. Maybe we can blame KASAN for this. It is actually not a problem
>>>> for non-PREEMPT_RT kernel because only trylock is being used. However, we
>>>> don't use trylock all the way when rt_spin_trylock() is being used with
>>>> PREEMPT_RT Kernel.
>>> It has nothing to do with trylock, an everything to do with scheduler
>>> locks being special.
>>>
>>> But even so, trying to squirrel a spinlock inside a raw_spinlock is
>>> dodgy at the best of times, yes it mostly works, but should be avoided
>>> whenever possible.
>>>
>>> And instrumentation just doesn't count.
>>>
>>>> This is certainly a problem that we need to fix as there
>>>> may be other similar case not involving rq->__lock lurking somewhere.
>>> There cannot be, lock order is:
>>>
>>>     rtmutex->wait_lock
>>>       task->pi_lock
>>>         rq->__lock
>>>
>>> Trying to subvert that order gets you a splat, any other:
>>>
>>>     raw_spin_lock(&foo);
>>>     spin_trylock(&bar);
>>>
>>> will 'work', despite probably not being a very good idea.
>>>
>>> Any case involving the scheduler locks needs to be eradicated, not
>>> worked around.
>> OK, I will see what I can do to work around this issue.
> Something like the completely untested below might just work.

The real problem is due to the occasional need to allocate new pages to 
expand the stack buffer in stack depot that will take additional lock. 
Fortunately, there is a kasan_record_aux_stack_noalloc() variant that 
will prevent that. Below is my proposed solution that is less restrictive.

diff --git a/include/linux/task_work.h b/include/linux/task_work.h
index cf5e7e891a77..2964171856e0 100644
--- a/include/linux/task_work.h
+++ b/include/linux/task_work.h
@@ -14,11 +14,14 @@ init_task_work(struct callback_head *twork, 
task_work_func_t func)
  }

  enum task_work_notify_mode {
-    TWA_NONE,
+    TWA_NONE = 0,
      TWA_RESUME,
      TWA_SIGNAL,
      TWA_SIGNAL_NO_IPI,
      TWA_NMI_CURRENT,
+
+    TWA_FLAGS = 0xff00,
+    TWAF_NO_ALLOC = 0x0100,
  };

  static inline bool task_work_pending(struct task_struct *task)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 43e453ab7e20..0259301e572e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10458,7 +10458,9 @@ void task_tick_mm_cid(struct rq *rq, struct 
task_struct *curr)
          return;
      if (time_before(now, READ_ONCE(curr->mm->mm_cid_next_scan)))
          return;
-    task_work_add(curr, work, TWA_RESUME);
+
+    /* No page allocation under rq lock */
+    task_work_add(curr, work, TWA_RESUME | TWAF_NO_ALLOC);
  }

  void sched_mm_cid_exit_signals(struct task_struct *t)
diff --git a/kernel/task_work.c b/kernel/task_work.c
index 5d14d639ac71..c969f1f26be5 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -55,15 +55,26 @@ int task_work_add(struct task_struct *task, struct 
callback_head *work,
            enum task_work_notify_mode notify)
  {
      struct callback_head *head;
+    int flags = notify & TWA_FLAGS;

+    notify &= ~TWA_FLAGS;
      if (notify == TWA_NMI_CURRENT) {
          if (WARN_ON_ONCE(task != current))
              return -EINVAL;
          if (!IS_ENABLED(CONFIG_IRQ_WORK))
              return -EINVAL;
      } else {
-        /* record the work call stack in order to print it in KASAN 
reports */
-        kasan_record_aux_stack(work);
+        /*
+         * Record the work call stack in order to print it in KASAN
+         * reports.
+         *
+         * Note that stack allocation can fail if TWAF_NO_ALLOC flag
+         * is set and new page is needed to expand the stack buffer.
+         */
+        if (flags & TWAF_NO_ALLOC)
+            kasan_record_aux_stack_noalloc(work);
+        else
+            kasan_record_aux_stack(work);
      }

      head = READ_ONCE(task->task_works);


