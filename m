Return-Path: <linux-kernel+bounces-243542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D9192976D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 12:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C35A1C209EA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 10:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB1A17C8B;
	Sun,  7 Jul 2024 10:33:16 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F5D1B948
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 10:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720348396; cv=none; b=dwpMrpQjkc38AxOo+89IvTqseONRZuuiVIgKxDbpQKZS/l3cIocjKEbDR8r3xesHDkstje1milbioS263EDI7sEmxhVDH7YFT4N8bZXoXWBrgpuH1pLuh00O4KCSxg2EuakYQoA2XPWIQF8zQI86uw+5CQoem46OPJZvJrsbtLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720348396; c=relaxed/simple;
	bh=8OFG/6ybkA1R6UsG60HX7V2pXPWfa8ytkL11wioZvio=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TZFeIKwRCgKEYAoKTBHMBbFBdo2hbLVxcj4hY70C7cM5F9K8Ot51WSHE+9wLEiEiDjgFRQNLhq8e+faQikGR44a3FdrhqByHXurWhPGJuN4JDq5whg4ssTe9Aw0+CMrjWRz+FFs0rO7Kc8E/RBrq51BtnE/cPnMey9BlgAuJE1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 467AW6WL050735;
	Sun, 7 Jul 2024 19:32:06 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Sun, 07 Jul 2024 19:32:06 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 467AW5mV050731
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 7 Jul 2024 19:32:05 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <5136bcc7-3db7-4fc2-abde-a3aceeaf17c2@I-love.SAKURA.ne.jp>
Date: Sun, 7 Jul 2024 19:32:05 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [kernel?] KASAN: stack-out-of-bounds Read in __show_regs
 (2)
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+e9be5674af5e3a0b9ecc@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        kasan-dev <kasan-dev@googlegroups.com>, linux-mm <linux-mm@kvack.org>,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mingo@redhat.com, tglx@linutronix.de, x86@kernel.org,
        Andrey Konovalov <andreyknvl@gmail.com>
References: <000000000000a8c856061ae85e20@google.com>
 <82cf2f25-fd3b-40a2-8d2b-a6385a585601@I-love.SAKURA.ne.jp>
 <daad75ac-9fd5-439a-b04b-235152bea222@I-love.SAKURA.ne.jp>
 <CA+fCnZdg=o3bA-kBM4UKEftiGfBffWXbqSapje8w25aKUk_4Nw@mail.gmail.com>
 <ec7411af-01ac-4ebd-99ad-98019ff355bf@I-love.SAKURA.ne.jp>
 <CA+fCnZfxCWZYX-7vJzMcwN4vKguuskk5rGYA2Ntotw=owOZ6Sg@mail.gmail.com>
 <1df448bd-7e22-408a-807a-4f4a6c679915@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <1df448bd-7e22-408a-807a-4f4a6c679915@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Guessing from IRQ entry hint, I found
commit 37ad4ee83642 ("x86: kmsan: don't instrument stack walking functions") and
commit 6cae637fa26d ("entry: kmsan: introduce kmsan_unpoison_entry_regs()").
I guess that we need to disable KASAN for the same reason as well as KMSAN.
Alexander, can you write a patch description for below change?

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index a7d562697e50..01edff4a9d6b 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -192,6 +192,9 @@ static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 	int graph_idx = 0;
 	bool partial = false;
 
+	/* As with KMSAN, disable KASAN for the same reason. */
+	kasan_disable_current();
+
 	printk("%sCall Trace:\n", log_lvl);
 
 	unwind_start(&state, task, regs, stack);
@@ -304,6 +307,8 @@ static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 		if (stack_name)
 			printk("%s </%s>\n", log_lvl, stack_name);
 	}
+
+	kasan_enable_current();
 }
 
 void show_stack(struct task_struct *task, unsigned long *sp,

On 2024/07/03 0:21, Tetsuo Handa wrote:
> On 2024/07/02 23:29, Andrey Konovalov wrote:
>> One other thing that comes to mind with regards to your patch: if the
>> task is still executing, the location of things on its stack might
>> change due to CONFIG_RANDOMIZE_KSTACK_OFFSET while you're printing the
>> task info. However, if the task is sleeping on a lock, this shouldn't
>> happen... But maybe a task can wake up during sched_show_task() and
>> start handling a new syscall? Just some guesses.
> 
> https://syzkaller.appspot.com/bug?extid=d7491e9e156404745fbb says that
> this bug happens without my patch. It seems that this bug happens when
> printing registers of a preempted thread. 5.15 kernel does not have
> CONFIG_RANDOMIZE_KSTACK_OFFSET config option, but
> 
>   __schedule()
>   preempt_schedule_irq()
>   irqentry_exit_cond_resched()
>   irqentry_exit()
> 
> pattern in 5.15 resembles
> 
>   __schedule()
>   preempt_schedule_irq()
>   irqentry_exit()
> 
> pattern in linux-next.
> 
> [ 1008.224617][T14487] task:syz-executor.1  state:R  running task     stack:22256 pid:14483 ppid:   434 flags:0x00004000
> [ 1008.224656][T14487] Call Trace:
> [ 1008.224661][T14487]  <TASK>
> [ 1008.224669][T14487]  __schedule+0xcbe/0x1580
> [ 1008.224689][T14487]  ? __sched_text_start+0x8/0x8
> [ 1008.224709][T14487]  ? ttwu_do_activate+0x15d/0x280
> [ 1008.224732][T14487]  ? _raw_spin_unlock_irqrestore+0x5c/0x80
> [ 1008.224758][T14487]  preempt_schedule_irq+0xc7/0x140
> [ 1008.224781][T14487]  ? __cond_resched+0x20/0x20
> [ 1008.224802][T14487]  ? try_invoke_on_locked_down_task+0x2a0/0x2a0
> [ 1008.224829][T14487]  irqentry_exit_cond_resched+0x2a/0x30
> [ 1008.224851][T14487]  irqentry_exit+0x30/0x40
> [ 1008.224874][T14487]  sysvec_apic_timer_interrupt+0x55/0xc0
> [ 1008.224900][T14487]  asm_sysvec_apic_timer_interrupt+0x1b/0x20
> [ 1008.224923][T14487] RIP: 0010:preempt_schedule_thunk+0x5/0x18
> [ 1008.224950][T14487] Code: fd 85 db 0f 84 98 00 00 00 44 8d 73 01 44 89 f6 09 de bf ff ff ff ff e8 47 e4 8f fd 41 09 de 0f 88 88 00 00 00 e8 89 e0 8f fd <4c> 89 e0 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 0f b6 04 08 84
> [ 1008.224970][T14487] RSP: 0000:0000000000000001 EFLAGS: 00000000 ORIG_RAX: 0000000000000000
> [ 1008.224991][T14487] RAX: ffff88811532d948 RBX: ffffc900072ef560 RCX: ffffc900077e7680
> [ 1008.225009][T14487] RDX: ffffc900072ef5b0 RSI: ffffffff8100817a RDI: dffffc0000000001
> [ 1008.225027][T14487] RBP: 0000000000000001 R08: ffff88811532d948 R09: ffffc900077e7690
> [ 1008.225043][T14487] R10: 1ffff92000efced2 R11: ffffffff84bfe126 R12: ffffc900077e7680
> [ 1008.225062][T14487] ==================================================================
> [ 1008.225071][T14487] BUG: KASAN: stack-out-of-bounds in __show_regs+0x252/0x4d0
> [ 1008.225098][T14487] Read of size 8 at addr ffffc900072ef4f8 by task syz-executor.3/14487
> [ 1008.225117][T14487] 
> [ 1008.225123][T14487] CPU: 0 PID: 14487 Comm: syz-executor.3 Not tainted 5.15.118-syzkaller-01748-g241da2ad5601 #0
> 


