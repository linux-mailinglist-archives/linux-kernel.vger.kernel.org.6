Return-Path: <linux-kernel+bounces-327249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB8A9772D7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 22:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F5191F22A32
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 20:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DE11C1AAA;
	Thu, 12 Sep 2024 20:45:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F081BF816
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 20:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726173902; cv=none; b=L+VaC7tyd6iX7OTpFvyhApd+/QvxI9odrG36ZpVXfq2DIE4sqZZcG8iEgtAH39P10WKx4jRA9NETR7C6Xg9B5tXowVTXoRi+WJdYi7HcXaM3HeRxX1ikHKvadMotmOb8VeDtLYJxq6hEq0qU/JVItXD7axAj0P4PIm4/tmTb9q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726173902; c=relaxed/simple;
	bh=X53vx+eQ70p0sQHV18a4CL+JbJJhKFp68RPM7zJLQ2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rgmdt8+aNUns9jWNsv9+p9jyzZoSxBVMQ9Wq9FnXeEEd29/6eJmuV1rH1ZcTtasQf8CfeJ5faJYOIl7A6BjnXwNLYyBHc3jH7b5NIPxebIfvFiTjUUS1iGYb4TuIWlCFunn7pUgIxI6Zb3i9ejLacurp9S+ZFPJmNKe3T7+zhbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA0C613D5;
	Thu, 12 Sep 2024 13:45:21 -0700 (PDT)
Received: from [192.168.2.132] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F253B3F64C;
	Thu, 12 Sep 2024 13:44:49 -0700 (PDT)
Message-ID: <f83d9e8d-af07-4ce4-81aa-e29fae5762b3@arm.com>
Date: Thu, 12 Sep 2024 22:44:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/24] sched/uclamg: Handle delayed dequeue
To: Luis Machado <luis.machado@arm.com>, Mike Galbraith <efault@gmx.de>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Hongyan Xia <hongyan.xia2@arm.com>, mingo@redhat.com, juri.lelli@redhat.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com, youssefesmat@chromium.org, tglx@linutronix.de
References: <CAKfTPtDO3n-4mcr2Sk-uu0ZS5xQnagdicQmaBh-CyrndPLM8eQ@mail.gmail.com>
 <aa81d37e-ad9c-42c6-a104-fe8496c5d907@arm.com>
 <c49ef5fe-a909-43f1-b02f-a765ab9cedbf@arm.com>
 <CAKfTPtCNUvWE_GX5LyvTF-WdxUT=ZgvZZv-4t=eWntg5uOFqiQ@mail.gmail.com>
 <a9a45193-d0c6-4ba2-a822-464ad30b550e@arm.com>
 <20240905145354.GP4723@noisy.programming.kicks-ass.net>
 <20240906104525.GG4928@noisy.programming.kicks-ass.net>
 <8d0d01b9-a430-49cc-93a5-67b4d68aa35c@arm.com>
 <20240910140524.GH4723@noisy.programming.kicks-ass.net>
 <52ca4cea-8f65-434e-af17-e4bf664d9488@arm.com>
 <20240911084528.GJ4723@noisy.programming.kicks-ass.net>
 <4fde8f26a9aeaeafda15b81bbb17b0ffc96941f0.camel@gmx.de>
 <6df12fde-1e0d-445f-8f8a-736d11f9ee41@arm.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <6df12fde-1e0d-445f-8f8a-736d11f9ee41@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/09/2024 14:58, Luis Machado wrote:
> On 9/11/24 10:10, Mike Galbraith wrote:
>> On Wed, 2024-09-11 at 10:45 +0200, Peter Zijlstra wrote:
>>> On Wed, Sep 11, 2024 at 09:35:16AM +0100, Luis Machado wrote:

[...]

> Ok, I seem to have narrowed this down to scheduler class switching. In particular
> switched_from_fair.
> 
> Valentin's patch (75b6499024a6c1a4ef0288f280534a5c54269076
> sched/fair: Properly deactivate sched_delayed task upon class change) introduced
> finish_delayed_dequeue_entity, which takes care of cleaning up the state of delayed-dequeue
> tasks during class change. Things work fine (minus delayed task accounting) up to this point.
> 
> When Peter introduced his patch to do h_nr_delayed accounting, we modified
> finish_delayed_dequeue_entity to also call clear_delayed, instead of simply
> zeroing se->sched_delayed.
> 
> The call to clear_delayed decrements the rq's h_nr_delayed, and it gets used elsewhere
> to cleanup the state of delayed-dequeue tasks, in order to share some common code.
> 
> With that said, my testing on Android shows that when we hit switched_from_fair during
> switching sched classes (due to some RT task), we're in a state where...
> 
> 1 - We already called into dequeue_entities for this delayed task.
> 2 - We tested true for the !task_sleep && !task_delayed condition.
> 3 - se->sched_delayed is true, so h_nr_delayed == 1.
> 4 - We carry on executing the rest of dequeue_entities and decrement the rq's h_nr_running by 1.
> 
> In switched_from_fair, after the above events, we call into finish_delayed_dequeue_entity -> clear_delayed
> and do yet another decrement to the rq's h_nr_delayed, now potentially making it negative. As
> a consequence, we probably misuse the negative value and adjust the frequencies incorrectly. I
> think this is the issue I'm seeing.
> 
> It is worth pointing out that even with the Android setup, things only go bad when there is enough
> competition and switching of classes (lots of screen events etc).
> 
> My suggestion of a fix (below), still under testing, is to inline the delayed-dequeue and the lag zeroing
> cleanup within switched_from_fair instead of calling finish_delayed_dequeue_entity. Or maybe
> drop finish_delayed_dequeue_entity and inline its contents into its callers.
> 
> The rest of Peter's patch introducing h_nr_delayed seems OK as far as I could test.
> 
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f993ac282a83..f8df2f8d2e11 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -13168,7 +13168,9 @@ static void switched_from_fair(struct rq *rq, struct task_struct *p)
>                  * related to sched_delayed being true and that wasn't done
>                  * due to the generic dequeue not using DEQUEUE_DELAYED.
>                  */
> -               finish_delayed_dequeue_entity(&p->se);
> +               p->se.sched_delayed = 0;
> +               if (sched_feat(DELAY_ZERO) && p->se.vlag > 0)
> +                       p->se.vlag = 0;
>                 p->se.rel_deadline = 0;
>                 __block_task(rq, p);
>         }

I could recreate this on QEMU with:

@@ -5473,6 +5473,7 @@ static void clear_delayed(struct sched_entity *se)
        for_each_sched_entity(se) {
                struct cfs_rq *cfs_rq = cfs_rq_of(se);
                cfs_rq->h_nr_delayed--;
+               BUG_ON((int)cfs_rq->h_nr_delayed < 0);
                if (cfs_rq_throttled(cfs_rq))
                        break;
        }
running:

  # while(true); do chrt -rr -p 50 $$; chrt -o -p 0 $$; done

in one shell and:

  # hackbench

in another.

[  318.490522] ------------[ cut here ]------------
[  318.490969] kernel BUG at kernel/sched/fair.c:5476!
[  318.491411] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[  318.491964] CPU: 3 UID: 0 PID: 68053 Comm: chrt Not tainted 6.11.0-rc1-00066-g2e05f6c71d36-dirty #23
[  318.492604] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.4
[  318.494192] RIP: 0010:switched_from_fair+0x67/0xe0
[  318.494899] Code: ff ff c6 85 d1 00 00 00 00 48 85 db 75 0e eb 1c 48 8b 9b 98 00 00 00 48 85 db 74 10 48 8b 0
[  318.496491] RSP: 0018:ffffb1154bc63e20 EFLAGS: 00010097
[  318.496991] RAX: 0000000000000001 RBX: ffff92668844e200 RCX: ffff9266fddadea8
[  318.497681] RDX: ffff926684213e00 RSI: ffff9266fddadea8 RDI: ffff92668844e608
[  318.498339] RBP: ffff92668844e180 R08: ffff92668106c44c R09: ffff92668119c0b8
[  318.498940] R10: ffff926681f42000 R11: ffffffffb1e155d0 R12: ffff9266fddad640
[  318.499525] R13: ffffb1154bc63ed8 R14: 0000000000000078 R15: ffff9266fddad640
[  318.500234] FS:  00007f68f52bf740(0000) GS:ffff9266fdd80000(0000) knlGS:0000000000000000
[  318.500837] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  318.501261] CR2: 00007f68f53afdd0 CR3: 0000000006a58002 CR4: 0000000000370ef0
[  318.501798] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  318.502385] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  318.502919] Call Trace:
[  318.503118]  <TASK>
[  318.503284]  ? die+0x32/0x90
[  318.503508]  ? do_trap+0xd8/0x100
[  318.503770]  ? switched_from_fair+0x67/0xe0
[  318.504085]  ? do_error_trap+0x60/0x80
[  318.504374]  ? switched_from_fair+0x67/0xe0
[  318.504652]  ? exc_invalid_op+0x53/0x70
[  318.504995]  ? switched_from_fair+0x67/0xe0
[  318.505270]  ? asm_exc_invalid_op+0x1a/0x20
[  318.505588]  ? switched_from_fair+0x67/0xe0
[  318.505929]  check_class_changed+0x2a/0x80
[  318.506236]  __sched_setscheduler+0x1f3/0x920
[  318.506526]  do_sched_setscheduler+0xfd/0x1c0
[  318.506867]  ? do_sys_openat2+0x7c/0xc0
[  318.507141]  __x64_sys_sched_setscheduler+0x1a/0x30
[  318.507462]  do_syscall_64+0x9e/0x1a0
[  318.507722]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  318.508127] RIP: 0033:0x7f68f53c3719
[  318.508369] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 8
[  318.509941] RSP: 002b:00007fff8d920578 EFLAGS: 00000246 ORIG_RAX: 0000000000000090
[  318.511178] RAX: ffffffffffffffda RBX: 00007fff8d920610 RCX: 00007f68f53c3719
[  318.512105] RDX: 00007fff8d92058c RSI: 0000000000000002 RDI: 0000000000000103
[  318.512676] RBP: 0000000000000103 R08: 0000000000000000 R09: 0000000000000000
[  318.513296] R10: 1999999999999999 R11: 0000000000000246 R12: 0000000000000002
[  318.513917] R13: 0000000000000002 R14: 0000000000000032 R15: 0000000000000103
[  318.514617]  </TASK>
[  318.514861] Modules linked in:
[  318.515132] ---[ end trace 0000000000000000 ]---
[  318.515466] RIP: 0010:switched_from_fair+0x67/0xe0
[  318.515942] Code: ff ff c6 85 d1 00 00 00 00 48 85 db 75 0e eb 1c 48 8b 9b 98 00 00 00 48 85 db 74 10 48 8b 0
[  318.517411] RSP: 0018:ffffb1154bc63e20 EFLAGS: 00010097
[  318.517819] RAX: 0000000000000001 RBX: ffff92668844e200 RCX: ffff9266fddadea8
[  318.518354] RDX: ffff926684213e00 RSI: ffff9266fddadea8 RDI: ffff92668844e608
[  318.518946] RBP: ffff92668844e180 R08: ffff92668106c44c R09: ffff92668119c0b8
[  318.519527] R10: ffff926681f42000 R11: ffffffffb1e155d0 R12: ffff9266fddad640
[  318.520138] R13: ffffb1154bc63ed8 R14: 0000000000000078 R15: ffff9266fddad640
[  318.520684] FS:  00007f68f52bf740(0000) GS:ffff9266fdd80000(0000) knlGS:0000000000000000
[  318.521350] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  318.521745] CR2: 00007f68f53afdd0 CR3: 0000000006a58002 CR4: 0000000000370ef0
[  318.522306] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  318.522896] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  318.523388] note: chrt[68053] exited with irqs disabled

With your proposed fix the issue goes away.

Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>





