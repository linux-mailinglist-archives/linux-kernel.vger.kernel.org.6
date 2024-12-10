Return-Path: <linux-kernel+bounces-438626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED839EA3B1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEB66165926
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2F11EB3E;
	Tue, 10 Dec 2024 00:31:22 +0000 (UTC)
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE1233EA
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 00:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733790681; cv=none; b=DN1pUMKf+ctvq+WkXGXlLEZdkTG7HVsWZujpvF15mZNulAF7psy8ASurN+s0GRW5LYPmaDaMGloPzlVRhiB2oyc6dh7w0Wr7eHNnuKF8DtuFMjsJZu+mJiH08+wEo3P/OMs2oGWCSW1YPQK1NXi9hhuadAVT1wcOxtfrtqtnAxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733790681; c=relaxed/simple;
	bh=8M+Kf7/sTkMklE0K0HqWHqo4jvCC5ztRfopDaz/9fo0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=u6ZQi5J+2jK+r9gz/UYZiibzUm7JlYZJmInbGsl7M88iqT/dYz+Hrb9kQrrPfTL4YqJ0Qxj8EThF/1l6O8JFOD0uTkp/X2jQRckzckSbdCnMEBzfiSdoBa54INqrF1pfcPjjmQ48TsBomAiswnVNGzA2HF9xJnGXxGVN8hOEXvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-385e2880606so4114089f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 16:31:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733790677; x=1734395477;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHnkO+qyV/cJ1X0YjSwPti7mYgr+62UmvDWcbfFjbYA=;
        b=p0LpxhNinBJTqvAFyHt/DhYD0dlXwVoAf60RMTyANU+C6mkjEl3WJhYeOh/0DB7s9S
         W/STf7lADjAam3bVlvzj4pr1hU0pbMpEx11EkEE9pBU7Fs2moc+tWOyeDmtuS5Qba1JW
         F9ZrDY55e0JGTH2zojezUpr9bJIyT/tvvevVgp75OJlKQDtdd4k8O7RLHx52S5AcEBfS
         bGDJtPmq96iRJ2AJ/2rZCF0MoUO5Sf4mlDPSrUZ24R8/YlfRoTAawSyCqxhUjrIzC8Hk
         X6R5yFTRtGFyVzPT7NP7HpWhkN8nQVUw3k8Z1gahuyZsywO6OnY851mMuk47gyAwCHTA
         +MEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUddkw+QRTESoSbWOuOJWWJV0fqmCiffqOO++CJTs/Xh5Gz+cjWPomfP9laSg3BRH2xau9RBAEwgpeNooU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvTmJhbQV9nSo+Bw98oO/rpR8coTeGGZJS9gdZO4wyCYrypH3E
	Dxa4Cv9bm8zUzYPGmp7Yl7EYYIcwVxCww6axO1pgAzxAL5KyhjUW
X-Gm-Gg: ASbGncsylLgk4eGUomX3ZT8RgTtz+8CRAKcXyS8NDovCZO4JM8iOvPnsdUU5h7q7oK6
	DZfOKNyszROGvk7rsSVz9XN+SAtoC/z/twpC3U/k0wa5EsgwMmwvf6tvl3ir3idhtldtnn5TKm+
	MjxdJErK9EMbQJjsGSPb8s6xgcjAKh96yPzANcgbWanru4dOHrdCiP5un9h9QUsiXhU9FAdJOvt
	ZXFLwWm/cS0bkso8fY+BkX5PWAwyVYgORG/JRfSiCFJ2MQZ/R0OoRTMBY2T0Ay1sReOhObjlRSC
	vRm+zi6mPg==
X-Google-Smtp-Source: AGHT+IGsJLLIp5lyNzTHHwvqefIGyNw57oqFjQZcLhumadrHnnpeTZl4F2Q4BQGb6rCRBmVRqzLDOQ==
X-Received: by 2002:a5d:64a1:0:b0:382:46ea:113f with SMTP id ffacd0b85a97d-386453cf89cmr2379804f8f.10.1733790677083;
        Mon, 09 Dec 2024 16:31:17 -0800 (PST)
Received: from [192.168.0.13] (ip-86-49-44-151.bb.vodafone.cz. [86.49.44.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38634bb1669sm9236238f8f.60.2024.12.09.16.31.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 16:31:15 -0800 (PST)
Message-ID: <2b407663-9c9b-45df-8419-25f97f5281e8@ovn.org>
Date: Tue, 10 Dec 2024 01:31:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, Joel Fernandes <joel@joelfernandes.org>,
 LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, vineethrp@google.com,
 shraash@google.com
Subject: Re: [v6.12] WARNING: at kernel/sched/deadline.c:1995
 enqueue_dl_entity (task blocked for more than 28262 seconds)
To: Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
 Peter Zijlstra <peterz@infradead.org>
References: <571b2045-320d-4ac2-95db-1423d0277613@ovn.org>
 <20241206151819.GA3949140@google.com>
 <CAO7JXPhdv+Jx_UpAq=-aG-BKwiyjZ2kvuZDM4+GLjbya_=ZJsw@mail.gmail.com>
 <20241209105514.GK21636@noisy.programming.kicks-ass.net>
 <CAO7JXPgSYCzu0mtnWqBaS8ihmoQXX3WE_Yb_rEYuMeQn+B6KJg@mail.gmail.com>
 <991b3afe-9570-40ff-b34a-cb0d0bf1adfa@ovn.org>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <991b3afe-9570-40ff-b34a-cb0d0bf1adfa@ovn.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/9/24 13:34, Ilya Maximets wrote:
> On 12/9/24 13:29, Vineeth Remanan Pillai wrote:
>> On Mon, Dec 9, 2024 at 5:55 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>>
>>> On Fri, Dec 06, 2024 at 11:57:30AM -0500, Vineeth Remanan Pillai wrote:
>>>
>>>> I was able to reproduce this WARN_ON couple of days back with
>>>> syzkaller. dlserver's dl_se gets enqueued during a update_curr while
>>>> the dlserver is stopped. And subsequent dlserver start will cause a
>>>> double enqueue.
>>>
>>> Right, I spotted that hole late last week. There is this thread:
>>>
>>>   https://lore.kernel.org/all/20241209094941.GF21636@noisy.programming.kicks-ass.net/T/#u
>>>
>>> Where I just added this thunk:
>>>
>>>   @@ -1674,6 +1679,12 @@ void dl_server_start(struct sched_dl_entity *dl_se)
>>>
>>>  void dl_server_stop(struct sched_dl_entity *dl_se)
>>>  {
>>> +       if (current->dl_server == dl_se) {
>>> +               struct rq *rq = rq_of_dl_se(dl_se);
>>> +               trace_printk("stop fair server %d\n", cpu_of(rq));
>>> +               current->dl_server = NULL;
>>> +       }
>>> +
>>>         if (!dl_se->dl_runtime)
>>>                 return;
>>>
>>> Which was my attempt at plugging said hole. But since I do not have
>>> means of reproduction, I'm not at all sure it is sufficient :/
>>>
>> I think I was able to get to the root cause last week. So the issue
>> seems to be that dlserver is stopped in the pick_task path of dlserver
>> itself when the sched_delayed is set:
>> __pick_next_task
>> => pick_task_dl -> server_pick_task
>>      => pick_task_fair
>>           => pick_next_entity (if (sched_delayed))
>>                => dequeue_entities
>>                      => dl_server_stop
>>
>> Now server_pick_task returns NULL and then we set dl_yielded and call
>> update_curr_dl_se. But dl_se is already dequeued and now the code is
>> confused and it does all sorts of things including setting a timer to
>> enqueue it back. This ultimately leads to double enqueue when dlserver
>> is started next time(based on timing of dl_server_start)
>>
>> I think we should not call update_curr_dl_se when the dlserver is
>> dequeued. Based on this I have a small patch and it seems to solve the
>> issue:
>>
>> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
>> index d9d5a702f1a6..a9f3f020e421 100644
>> --- a/kernel/sched/deadline.c
>> +++ b/kernel/sched/deadline.c
>> @@ -2419,12 +2419,18 @@ static struct task_struct *__pick_task_dl(struct rq *rq)
>>
>>         if (dl_server(dl_se)) {
>>                 p = dl_se->server_pick_task(dl_se);
>> -               if (!p) {
>> +               if (p) {
>> +                       rq->dl_server = dl_se;
>> +               } else if (WARN_ON_ONCE(on_dl_rq(dl_se))) {
>> +                       /*
>> +                        * If server_pick_task returns NULL and dlserver is
>> +                        * enqueued, we have a problem. Lets yield and do a
>> +                        * pick again.
>> +                        */
>>                         dl_se->dl_yielded = 1;
>>                         update_curr_dl_se(rq, dl_se, 0);
>>                         goto again;
>>                 }
>> -               rq->dl_server = dl_se;
>>         } else {
>>                 p = dl_task_of(dl_se);
>>         }
>>
>> I can send a formal patch if this looks okay to you all..
> 
> Thanks!
> 
> I can try this out on my setup today over the night (it takes a long time
> to reproduce the issue on my setup).

So, I tried applying this one on top of v6.12 and I got the following after
about 20 minutes of testing:

Dec  9 19:08:31 kernel: ------------[ cut here ]------------
Dec  9 19:08:31 kernel: watchdog: BUG: soft lockup - CPU#2 stuck for 21s! [handler37:428139]
Dec  9 19:08:31 kernel: rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
Dec  9 19:08:31 kernel: rcu: #0110-...0: (1 GPs behind) idle=e41c/1/0x4000000000000000 softirq=186760/186760 fqs=7457
Dec  9 19:08:31 kernel: rcu: #011(detected by 27, t=60002 jiffies, g=913205, q=503974 ncpus=40)
Dec  9 19:08:31 kernel: Sending NMI from CPU 27 to CPUs 0:
Dec  9 19:08:31 kernel: rcu: rcu_preempt kthread starved for 40001 jiffies! g913205 f0x2 RCU_GP_DOING_FQS(6) ->state=0x0 ->cpu=15
Dec  9 19:08:31 kernel: rcu: #011Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
Dec  9 19:08:31 kernel: rcu: RCU grace-period kthread stack dump:
Dec  9 19:08:31 kernel: task:rcu_preempt     state:R  running task     stack:0     pid:18    tgid:18    ppid:2      flags:0x00004000
Dec  9 19:08:31 kernel: Call Trace:
Dec  9 19:08:31 kernel: <TASK>
Dec  9 19:08:31 kernel: ? lock_timer_base (kernel/time/timer.c:1051) 
Dec  9 19:08:31 kernel: ? _raw_spin_lock (./arch/x86/include/asm/paravirt.h:584 ./arch/x86/include/asm/qspinlock.h:51 ./include/asm-generic/qspinlock.h:114 ./include/linux/spinlock.h:187 ./include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
Dec  9 19:08:31 kernel: ? raw_spin_rq_lock_nested (./arch/x86/include/asm/preempt.h:84 kernel/sched/core.c:600) 
Dec  9 19:08:31 kernel: ? resched_cpu (./arch/x86/include/asm/bitops.h:239 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 ./include/linux/cpumask.h:570 ./include/linux/cpumask.h:1117 kernel/sched/core.c:1109) 
Dec  9 19:08:31 kernel: ? force_qs_rnp (kernel/rcu/tree.c:2734 (discriminator 6)) 
Dec  9 19:08:31 kernel: ? __pfx_rcu_watching_snap_recheck (kernel/rcu/tree.c:816) 
Dec  9 19:08:31 kernel: ? __pfx_rcu_gp_kthread (kernel/rcu/tree.c:2222) 
Dec  9 19:08:31 kernel: ? rcu_gp_fqs_loop (kernel/rcu/tree.c:2004 kernel/rcu/tree.c:2067) 
Dec  9 19:08:31 kernel: ? rcu_gp_kthread (kernel/rcu/tree.c:2250) 
Dec  9 19:08:31 kernel: ? kthread (kernel/kthread.c:389) 
Dec  9 19:08:31 kernel: ? __pfx_kthread (kernel/kthread.c:342) 
Dec  9 19:08:31 kernel: ? ret_from_fork (arch/x86/kernel/process.c:147) 
Dec  9 19:08:31 kernel: ? __pfx_kthread (kernel/kthread.c:342) 
Dec  9 19:08:31 kernel: ? ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
Dec  9 19:08:31 kernel: </TASK>
Dec  9 19:08:31 kernel: rcu: Stack dump where RCU GP kthread last ran:
Dec  9 19:08:31 kernel: Sending NMI from CPU 27 to CPUs 15:
Dec  9 19:09:49 systemd[1]: systemd-udevd.service: Watchdog timeout (limit 3min)!
Dec  9 19:09:49 systemd[1]: systemd-udevd.service: Killing process 1087 (systemd-udevd) with signal SIGABRT.
Dec  9 19:11:19 systemd[1]: systemd-udevd.service: State 'stop-watchdog' timed out. Killing.
Dec  9 19:11:19 systemd[1]: systemd-udevd.service: Killing process 1087 (systemd-udevd) with signal SIGKILL.
Dec  9 19:11:51 kernel: rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
Dec  9 19:11:51 kernel: rcu: #0110-...0: (1 GPs behind) idle=e41c/1/0x4000000000000002 softirq=186760/186760 fqs=7457
Dec  9 19:11:51 kernel: rcu: #011(detected by 5, t=260010 jiffies, g=913205, q=2087901 ncpus=40)
Dec  9 19:11:51 kernel: Sending NMI from CPU 5 to CPUs 0:
Dec  9 19:11:51 kernel: rcu: rcu_preempt kthread starved for 240008 jiffies! g913205 f0x2 RCU_GP_DOING_FQS(6) ->state=0x0 ->cpu=15
Dec  9 19:11:51 kernel: rcu: #011Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
Dec  9 19:11:51 kernel: rcu: RCU grace-period kthread stack dump:
Dec  9 19:11:51 kernel: task:rcu_preempt     state:R  running task     stack:0     pid:18    tgid:18    ppid:2      flags:0x00004000
Dec  9 19:11:51 kernel: Call Trace:
Dec  9 19:11:51 kernel: <TASK>
Dec  9 19:11:51 kernel: ? lock_timer_base (kernel/time/timer.c:1051) 
Dec  9 19:11:51 kernel: ? _raw_spin_lock (./arch/x86/include/asm/paravirt.h:584 ./arch/x86/include/asm/qspinlock.h:51 ./include/asm-generic/qspinlock.h:114 ./include/linux/spinlock.h:187 ./include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
Dec  9 19:11:51 kernel: ? raw_spin_rq_lock_nested (./arch/x86/include/asm/preempt.h:84 kernel/sched/core.c:600) 
Dec  9 19:11:51 kernel: ? resched_cpu (./arch/x86/include/asm/bitops.h:239 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 ./include/linux/cpumask.h:570 ./include/linux/cpumask.h:1117 kernel/sched/core.c:1109) 
Dec  9 19:11:51 kernel: ? force_qs_rnp (kernel/rcu/tree.c:2734 (discriminator 6)) 
Dec  9 19:11:51 kernel: ? __pfx_rcu_watching_snap_recheck (kernel/rcu/tree.c:816) 
Dec  9 19:11:51 kernel: ? __pfx_rcu_gp_kthread (kernel/rcu/tree.c:2222) 
Dec  9 19:11:51 kernel: ? rcu_gp_fqs_loop (kernel/rcu/tree.c:2004 kernel/rcu/tree.c:2067) 
Dec  9 19:11:51 kernel: ? rcu_gp_kthread (kernel/rcu/tree.c:2250) 
Dec  9 19:11:51 kernel: ? kthread (kernel/kthread.c:389) 
Dec  9 19:11:51 kernel: ? __pfx_kthread (kernel/kthread.c:342) 
Dec  9 19:11:51 kernel: ? ret_from_fork (arch/x86/kernel/process.c:147) 
Dec  9 19:11:51 kernel: ? __pfx_kthread (kernel/kthread.c:342) 
Dec  9 19:11:51 kernel: ? ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
Dec  9 19:11:51 kernel: </TASK>
Dec  9 19:11:51 kernel: rcu: Stack dump where RCU GP kthread last ran:
Dec  9 19:11:51 kernel: Sending NMI from CPU 5 to CPUs 15:
Dec  9 19:12:49 systemd[1]: systemd-udevd.service: Processes still around after SIGKILL. Ignoring.
Dec  9 19:14:20 systemd[1]: systemd-udevd.service: State 'final-sigterm' timed out. Killing.

An interesting part here is that CPU 15 doesn't even react to NMI...
I had to kill the system as it got completely unresponsive.

Best regards, Ilya Maximets.

