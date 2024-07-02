Return-Path: <linux-kernel+bounces-237364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AF791EFB8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 09:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C23191F21976
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 07:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368A312EBE1;
	Tue,  2 Jul 2024 07:05:58 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420033EA69
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 07:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719903957; cv=none; b=sJ9GnENgDjwwE/3c50VmvCJqT5FsV4YI3JKbmjmqyRu4JeTmnQT3mcAOv854bTSwTIJN+BwXzsSNSUBtWc8+feglSljKiHawdVl26yR70+rQIM5J33YVg/DZeVOWC77Kl8YKQdmiZCM1kAjsIFrr8mZjLRAicsyl0EEcLx4JuVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719903957; c=relaxed/simple;
	bh=I++kslG8ihenEvWXSMDFZqI3nirvDtne2p9d6pqkVIA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LWlQ54Z27Mgsx8ZhKRVB8IVJO8M1UAfbmAsBAtMS5EwCHDHzVaa81XxptQEvrnJ9BzRzMu2/R+xnFijVUJQbyc3UlcANcUCfFJMdqt/kRzF9fA5YY2GENjUNwtLm4YxlR7s9Kwl84O7/C58qq9HSQ6d+/fGN+T+YEPpXgZESDQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav111.sakura.ne.jp (fsav111.sakura.ne.jp [27.133.134.238])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 46275JJp069284;
	Tue, 2 Jul 2024 16:05:19 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav111.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp);
 Tue, 02 Jul 2024 16:05:19 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 46275JB6069281
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 2 Jul 2024 16:05:19 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <e045dcff-a6cd-4110-83e0-6fc2a56d0413@I-love.SAKURA.ne.jp>
Date: Tue, 2 Jul 2024 16:05:19 +0900
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
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: syzbot <syzbot+e9be5674af5e3a0b9ecc@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        kasan-dev <kasan-dev@googlegroups.com>, linux-mm <linux-mm@kvack.org>,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mingo@redhat.com, tglx@linutronix.de, x86@kernel.org
References: <000000000000a8c856061ae85e20@google.com>
 <82cf2f25-fd3b-40a2-8d2b-a6385a585601@I-love.SAKURA.ne.jp>
 <daad75ac-9fd5-439a-b04b-235152bea222@I-love.SAKURA.ne.jp>
 <CA+fCnZdg=o3bA-kBM4UKEftiGfBffWXbqSapje8w25aKUk_4Nw@mail.gmail.com>
 <ec7411af-01ac-4ebd-99ad-98019ff355bf@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <ec7411af-01ac-4ebd-99ad-98019ff355bf@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/07/02 15:11, Tetsuo Handa wrote:
> Well, KASAN says "out-of-bounds". But the reported address
> 
>   BUG: KASAN: stack-out-of-bounds in __show_regs+0x172/0x610
>   Read of size 8 at addr ffffc90003c4f798 by task kworker/u8:5/234
> 
> is within the kernel stack memory mapping
> 
>   The buggy address belongs to the virtual mapping at
>    [ffffc90003c48000, ffffc90003c51000) created by:
>    copy_process+0x5d1/0x3d7
> 
> . Why is this "out-of-bounds" ? What boundary did KASAN compare with?

I think I found a hint. The KASAN message is printed when the call trace
starts with

  __schedule()
  preempt_schedule_irq()
  irqentry_exit()

. That is, when preemption happens, KASAN by error tries to compare with
unintended stack boundary?

[  504.507489][    C0] DEBUG: holding rtnl_mutex for 3212 jiffies.
[  504.513708][    C0] task:kworker/u8:5    state:R  running task     stack:19992 pid:340   tgid:340   ppid:2      flags:0x00004000
[  504.525827][    C0] Workqueue: netns cleanup_net
[  504.530890][    C0] Call Trace:
[  504.534213][    C0]  <TASK>
[  504.537244][    C0]  __schedule+0x17e8/0x4a20
[  504.541874][    C0]  ? mark_lock+0x9a/0x360
[  504.546279][    C0]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[  504.552396][    C0]  ? __virt_addr_valid+0x183/0x520
[  504.557711][    C0]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[  504.564121][    C0]  ? lock_release+0xbf/0x9f0
[  504.568918][    C0]  ? __pfx___schedule+0x10/0x10
[  504.573835][    C0]  ? lockdep_hardirqs_on+0x99/0x150
[  504.579189][    C0]  ? mark_lock+0x9a/0x360
[  504.583592][    C0]  preempt_schedule_irq+0xfb/0x1c0
[  504.588984][    C0]  ? __pfx_preempt_schedule_irq+0x10/0x10
[  504.594785][    C0]  irqentry_exit+0x5e/0x90
[  504.599421][    C0]  asm_sysvec_reschedule_ipi+0x1a/0x20

[  463.514954][    C1] DEBUG: holding rtnl_mutex for 993 jiffies.
[  463.528845][    C1] task:kworker/u8:10   state:R  running task     stack:19856 pid:5725  tgid:5725  ppid:2      flags:0x00004000
[  463.536743][ T9938] rock: corrupted directory entry. extent=41, offset=65536, size=8
[  463.540652][    C1] Workqueue: netns cleanup_net
[  463.553421][    C1] Call Trace:
[  463.556740][    C1]  <TASK>
[  463.559706][    C1]  __schedule+0x17e8/0x4a20
[  463.564304][    C1]  ? __pfx_validate_chain+0x10/0x10
[  463.569611][    C1]  ? __pfx___schedule+0x10/0x10
[  463.574628][    C1]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[  463.580760][    C1]  ? preempt_schedule_irq+0xf0/0x1c0
[  463.586149][    C1]  preempt_schedule_irq+0xfb/0x1c0
[  463.591401][    C1]  ? __pfx_preempt_schedule_irq+0x10/0x10
[  463.597269][    C1]  irqentry_exit+0x5e/0x90
[  463.601834][    C1]  asm_sysvec_apic_timer_interrupt+0x1a/0x20

[ 1558.178669][    C1] DEBUG: holding rtnl_mutex for 536 jiffies.
[ 1558.184806][    C1] task:syz-executor.3  state:R  running task     stack:25968 pid:6351  tgid:6345  ppid:6200   flags:0x00004006
[ 1558.196699][    C1] Call Trace:
[ 1558.200068][    C1]  <TASK>
[ 1558.203055][    C1]  __schedule+0x17e8/0x4a20
[ 1558.207638][    C1]  ? __pfx___schedule+0x10/0x10
[ 1558.212585][    C1]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[ 1558.218675][    C1]  ? preempt_schedule_irq+0xf0/0x1c0
[ 1558.224004][    C1]  preempt_schedule_irq+0xfb/0x1c0
[ 1558.229196][    C1]  ? __pfx_preempt_schedule_irq+0x10/0x10
[ 1558.234986][    C1]  irqentry_exit+0x5e/0x90
[ 1558.239503][    C1]  asm_sysvec_reschedule_ipi+0x1a/0x20

[ 1104.439430][    C0] DEBUG: holding rtnl_mutex for 578 jiffies.
[ 1104.445729][    C0] task:kworker/u8:3    state:R  running task     stack:18544 pid:53    tgid:53    ppid:2      flags:0x00004000
[ 1104.459070][    C0] Workqueue: netns cleanup_net
[ 1104.464170][    C0] Call Trace:
[ 1104.467478][    C0]  <TASK>
[ 1104.470481][    C0]  __schedule+0x17e8/0x4a20
[ 1104.476080][    C0]  ? mark_lock+0x9a/0x360
[ 1104.480776][    C0]  ? __lock_acquire+0x1359/0x2000
[ 1104.486043][    C0]  ? __pfx___schedule+0x10/0x10
[ 1104.490987][    C0]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[ 1104.497017][    C0]  ? preempt_schedule_irq+0xf0/0x1c0
[ 1104.502486][    C0]  preempt_schedule_irq+0xfb/0x1c0
[ 1104.507809][    C0]  ? __pfx_preempt_schedule_irq+0x10/0x10
[ 1104.514030][    C0]  irqentry_exit+0x5e/0x90
[ 1104.518689][    C0]  asm_sysvec_reschedule_ipi+0x1a/0x20

[  926.207053][    C1] DEBUG: holding rtnl_mutex for 517 jiffies.
[  926.213142][    C1] task:syz.1.1365      state:R  running task     stack:24672 pid:11152 tgid:11152 ppid:10992  flags:0x00004006
[  926.225053][    C1] Call Trace:
[  926.228434][    C1]  <TASK>
[  926.231441][    C1]  __schedule+0x17e8/0x4a20
[  926.236054][    C1]  ? __pfx___schedule+0x10/0x10
[  926.241130][    C1]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[  926.247265][    C1]  ? kasan_save_track+0x51/0x80
[  926.252225][    C1]  ? preempt_schedule_irq+0xf0/0x1c0
[  926.257705][    C1]  preempt_schedule_irq+0xfb/0x1c0
[  926.262899][    C1]  ? __pfx_preempt_schedule_irq+0x10/0x10
[  926.268725][    C1]  ? __pfx_pfifo_fast_destroy+0x10/0x10
[  926.274379][    C1]  irqentry_exit+0x5e/0x90
[  926.278903][    C1]  asm_sysvec_apic_timer_interrupt+0x1a/0x20

[  940.917894][    C0] DEBUG: holding rtnl_mutex for 1611 jiffies.
[  940.924066][    C0] task:syz.2.2274      state:R  running task     stack:24336 pid:15954 tgid:15954 ppid:14850  flags:0x00004006
[  940.936192][    C0] Call Trace:
[  940.939550][    C0]  <TASK>
[  940.942540][    C0]  __schedule+0x17e8/0x4a20
[  940.947134][    C0]  ? __pfx___schedule+0x10/0x10
[  940.952070][    C0]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[  940.958362][    C0]  ? kasan_save_track+0x51/0x80
[  940.963266][    C0]  ? preempt_schedule_irq+0xf0/0x1c0
[  940.968628][    C0]  preempt_schedule_irq+0xfb/0x1c0
[  940.973790][    C0]  ? __pfx_preempt_schedule_irq+0x10/0x10
[  940.979610][    C0]  ? __pfx_pfifo_fast_destroy+0x10/0x10
[  940.985227][    C0]  irqentry_exit+0x5e/0x90
[  940.989731][    C0]  asm_sysvec_apic_timer_interrupt+0x1a/0x20

[ 2120.744289][    C1] DEBUG: holding rtnl_mutex for 1675 jiffies.
[ 2120.750440][    C1] task:syz-executor    state:R  running task     stack:20288 pid:2431  tgid:2431  ppid:1      flags:0x00004006
[ 2120.762291][    C1] Call Trace:
[ 2120.765647][    C1]  <TASK>
[ 2120.768615][    C1]  __schedule+0x17e8/0x4a20
[ 2120.773210][    C1]  ? __pfx___schedule+0x10/0x10
[ 2120.778152][    C1]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[ 2120.784188][    C1]  ? kasan_save_track+0x51/0x80
[ 2120.789118][    C1]  ? preempt_schedule_irq+0xf0/0x1c0
[ 2120.794445][    C1]  preempt_schedule_irq+0xfb/0x1c0
[ 2120.799621][    C1]  ? __pfx_preempt_schedule_irq+0x10/0x10
[ 2120.805378][    C1]  ? kvm_kick_cpu+0x26/0xb0
[ 2120.809965][    C1]  irqentry_exit+0x5e/0x90
[ 2120.814423][    C1]  asm_sysvec_apic_timer_interrupt+0x1a/0x20

[ 1465.514982][    C1] DEBUG: holding rtnl_mutex for 583 jiffies.
[ 1465.521071][    C1] task:kworker/u8:2    state:R  running task     stack:20232 pid:35    tgid:35    ppid:2      flags:0x00004000
[ 1465.532945][    C1] Workqueue: netns cleanup_net
[ 1465.537846][    C1] Call Trace:
[ 1465.541164][    C1]  <TASK>
[ 1465.544132][    C1]  __schedule+0x17e8/0x4a20
[ 1465.548730][    C1]  ? mark_lock+0x9a/0x360
[ 1465.553148][    C1]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[ 1465.559257][    C1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[ 1465.565697][    C1]  ? __pfx___schedule+0x10/0x10
[ 1465.570636][    C1]  ? lockdep_hardirqs_on+0x99/0x150
[ 1465.575968][    C1]  ? mark_lock+0x9a/0x360
[ 1465.580381][    C1]  preempt_schedule_irq+0xfb/0x1c0
[ 1465.585599][    C1]  ? __pfx_preempt_schedule_irq+0x10/0x10
[ 1465.591383][    C1]  irqentry_exit+0x5e/0x90
[ 1465.595895][    C1]  asm_sysvec_reschedule_ipi+0x1a/0x20


