Return-Path: <linux-kernel+bounces-337374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 031A998493F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DA4F281C3E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0031B1ABECF;
	Tue, 24 Sep 2024 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJb9B4xD"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0481ABEC5
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727194116; cv=none; b=ExfZ9IT7VDm/RhZtD/T75lYR+ky2suwb6jtcOSmIOZHa/SNWuryZLjAoUGiWWYllCwgcxsn6i5260kfhVFu//HhPto8toMNeaUKWCT+aIe64uFxBvE+dBCyYseGD/rRrAre63NS2KTtqb7T6wYXJJpQ0DU8CZxk9YnAhK05M7pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727194116; c=relaxed/simple;
	bh=uMMpWDE0+nYaMmLmogzrU5crD3ETdI95/V4hCG9xh2U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=MbyG6F7MUCTrPnqZThQdfuVgfe7kVGRlDdKj634NC1+qFQVlAsLJwcv31nVN3uMnGJaCxW0FIKgoPowlpyQA3JVhr+DPKLO7xmN9JZgpZfnaRGkgMd2rR2QlZRQOLNPTTVWNLmbnEAmXdEJs9Drr3tGnw2xW0Xr0vjBpzcfV1xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJb9B4xD; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-535694d67eeso19130e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727194112; x=1727798912; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5jkvs5u7wPkIJLH8S5CdPba/IijOygWvEyioUozl+qg=;
        b=CJb9B4xDMYopRbxMUCvgPXFp51jSSMeAsXPAmRV2M3ap7btVY7ntaLGBEWnjw/7Qa8
         bisqjX6oePM1jTpBa057/4B/0MiB8D1Y6s1HA2wa+J5IuNksJHGkrFxCTcTkgaIX3W5Y
         k+CtuLO4NFKlihI2mv73qSGntPRzcPrHgkA52lsyW+3PNKxrHw7YHMVeJZFRWHEsIMsy
         9+TR4ANcSBMFqHP/JuoNoJHjkOxmSMRNOcKvdXb1SRT76FEzB7CyZoTNYE1wHHAyxsxn
         5PmWSXyCmlYwsXWUljTk9Xup6virm7+4hblh5CUPOHQdo3gZWlXmQNJJ1YDAUCIkiPSR
         tpGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727194112; x=1727798912;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5jkvs5u7wPkIJLH8S5CdPba/IijOygWvEyioUozl+qg=;
        b=Wnvnh7iAwopN5JuH6xNGdeSLsK2PXsPpmG72VAiXwtrcQrpavcLtcBm/+mJ4/OclBn
         A7/wTEjyqbKQA2LlU432AYVM5Q4JyWiwmTgOEu+wBhCHPlvBlKi90rvI/rq3+r0SZCw/
         5fwbTWdnX1UfY47uZC6p0hHk4QktL9ux3SubyvDM5vsRCOUqKyFnczsghw6YoGb0Vzf6
         qM/GEL5KkM3ILzyHUtKNY2XFLd0iEPZ4+nT8Txvsyk4KalCvEfp9/5zkkokOl7tsf/Uh
         gyh8qgrIt9NJbo30m+oO2acS3nKHZ5g1yF4kL3m7y/EzLbQ6oP/UalODfvNTwyeXyqzk
         OSIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3jKcNvMFe6ZNqmeOBzQrbAx4OFLG4grzz5LvG2eZYyezPsjch+qtq3jA36b9lPVjnwACoxWQKXOwy5bY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8VhChf7o1Ggdc1Lp6HAwpwmHi2rw0QJrf2W0ZYJKuPNkOhCx7
	wsDb1QQSTNThrdw4dQ17qNt0TrvqUI8I69kMsJ+OpkRNnsPw+6KkBu4bbrODaa5KGj2eAbIpeRI
	B2l0DokM749TmNr5R/ffEVkTIb9+1V2RNuTiwfA==
X-Google-Smtp-Source: AGHT+IFBemCDakoP22PU9JR1/Ls4NUWPNWM9deRTt7ZgiXZMxSl6PSKSE878PCQ9Qo/Ul5HIW2giKB3hKIbm5Y+N+6M=
X-Received: by 2002:ac2:4c54:0:b0:52f:30d:526c with SMTP id
 2adb3069b0e04-537a6512a2fmr1385177e87.5.1727194111807; Tue, 24 Sep 2024
 09:08:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: reveliofuzzing <reveliofuzzing@gmail.com>
Date: Tue, 24 Sep 2024 12:08:20 -0400
Message-ID: <CA+-ZZ_iymSbkgLzhBLJ-KnL+6thFc5pGXvJOpWf=xf1tpyppUw@mail.gmail.com>
Subject: Report "BUG: unable to handle kernel paging request in stack_depot_save_flags"
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

We found the following crash when fuzzing^1 the Linux kernel 6.10 and
we are able
to reproduce it. To our knowledge, this crash has not been observed by SyzBot so
we would like to report it for your reference.

- Crash
BUG: unable to handle page fault for address: ffff88800834c300
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 6801067 P4D 6801067 PUD 6802067 PMD 9b9b063 PTE 0
Oops: Oops: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.10.0 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:find_stack linux-6.10/lib/stackdepot.c:553 [inline]
RIP: 0010:stack_depot_save_flags+0x122/0x6f0 linux-6.10/lib/stackdepot.c:618
Code: 03 0d 8a e3 6a 04 65 ff 05 c3 f6 01 7e 4c 8b 31 41 89 e9 41 8d
77 ff 41 83 e1 02 4c 39 f1 75 0a eb 1e 4d 8b 36 4c 39 f1 74 16 <41> 39
5e 10 75 f2 31 c0 45 3b 7e 14 74 10 4d 8b 36 4c 39 f1 75 ea
RSP: 0018:ffff88806d3098f8 EFLAGS: 00010002
RAX: 000000006bb4baf3 RBX: 0000000059cc606c RCX: ffff88806cb606c0
RDX: 0000000084bc6976 RSI: 000000000000000c RDI: 00000000508ad1ea
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: ffff88806d309818 R11: 0000000000000003 R12: 0000000000000000
R13: ffff88806d309958 R14: ffff88800834c2f0 R15: 000000000000000d
FS:  0000000000000000(0000) GS:ffff88806d300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88800834c300 CR3: 0000000007522005 CR4: 0000000000170ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 kasan_save_stack+0x34/0x50 linux-6.10/mm/kasan/common.c:48
 __kasan_record_aux_stack+0x8c/0xa0 linux-6.10/mm/kasan/generic.c:541
 insert_work+0x27/0x200 linux-6.10/kernel/workqueue.c:2208
 __queue_work linux-6.10/kernel/workqueue.c:2360 [inline]
 __queue_work+0x562/0xb00 linux-6.10/kernel/workqueue.c:2260
 call_timer_fn+0x34/0x230 linux-6.10/kernel/time/timer.c:1792
 expire_timers linux-6.10/kernel/time/timer.c:1838 [inline]
 __run_timers linux-6.10/kernel/time/timer.c:2417 [inline]
 __run_timer_base.part.0+0x43f/0x8f0 linux-6.10/kernel/time/timer.c:2428
 __run_timer_base linux-6.10/kernel/time/timer.c:2423 [inline]
 timer_expire_remote+0x8e/0xc0 linux-6.10/kernel/time/timer.c:2180
 tmigr_handle_remote_cpu linux-6.10/kernel/time/timer_migration.c:938 [inline]
 tmigr_handle_remote_up linux-6.10/kernel/time/timer_migration.c:1030 [inline]
 __walk_groups linux-6.10/kernel/time/timer_migration.c:488 [inline]
 tmigr_handle_remote+0x84d/0xae0 linux-6.10/kernel/time/timer_migration.c:1091
 run_timer_softirq+0x156/0x1b0 linux-6.10/kernel/time/timer.c:2451
 handle_softirqs+0x162/0x520 linux-6.10/kernel/softirq.c:554
 __do_softirq linux-6.10/kernel/softirq.c:588 [inline]
 invoke_softirq linux-6.10/kernel/softirq.c:428 [inline]
 __irq_exit_rcu linux-6.10/kernel/softirq.c:637 [inline]
 irq_exit_rcu+0x7f/0xb0 linux-6.10/kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt
linux-6.10/arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x6e/0x90
linux-6.10/arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20
linux-6.10/arch/x86/include/asm/idtentry.h:702
RIP: 0010:native_irq_disable
linux-6.10/arch/x86/include/asm/irqflags.h:37 [inline]
RIP: 0010:arch_local_irq_disable
linux-6.10/arch/x86/include/asm/irqflags.h:72 [inline]
RIP: 0010:default_idle+0x1e/0x30 linux-6.10/arch/x86/kernel/process.c:743
Code: 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00
66 90 0f 1f 44 00 00 0f 00 2d 79 d9 3f 00 0f 1f 44 00 00 fb f4 <fa> c3
cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
RSP: 0018:ffff888006f27e68 EFLAGS: 00000242
RAX: ffff88806d300000 RBX: 0000000000000001 RCX: ffffffff83e26864
RDX: 0000000000000001 RSI: 0000000000000004 RDI: 000000000022ffb4
RBP: dffffc0000000000 R08: 0000000000000001 R09: ffffed100da66a99
R10: ffffed100da66a98 R11: ffff88806d3354c3 R12: ffffffff856175d0
R13: 1ffff11000de4fd2 R14: 0000000000000000 R15: 0000000000000000
 default_idle_call+0x38/0x60 linux-6.10/kernel/sched/idle.c:117
 cpuidle_idle_call linux-6.10/kernel/sched/idle.c:191 [inline]
 do_idle+0x2e8/0x3a0 linux-6.10/kernel/sched/idle.c:332
 cpu_startup_entry+0x4f/0x60 linux-6.10/kernel/sched/idle.c:430
 start_secondary+0x1ba/0x210 linux-6.10/arch/x86/kernel/smpboot.c:313
 common_startup_64+0x12c/0x138
 </TASK>
Modules linked in:
CR2: ffff88800834c300
---[ end trace 0000000000000000 ]---
BUG: unable to handle page fault for address: ffff88800834c300
RIP: 0010:find_stack linux-6.10/lib/stackdepot.c:553 [inline]
RIP: 0010:stack_depot_save_flags+0x122/0x6f0 linux-6.10/lib/stackdepot.c:618
#PF: supervisor read access in kernel mode
Code: 03 0d 8a e3 6a 04 65 ff 05 c3 f6 01 7e 4c 8b 31 41 89 e9 41 8d
77 ff 41 83 e1 02 4c 39 f1 75 0a eb 1e 4d 8b 36 4c 39 f1 74 16 <41> 39
5e 10 75 f2 31 c0 45 3b 7e 14 74 10 4d 8b 36 4c 39 f1 75 ea
#PF: error_code(0x0000) - not-present page
RSP: 0018:ffff88806d3098f8 EFLAGS: 00010002
PGD 6801067

RAX: 000000006bb4baf3 RBX: 0000000059cc606c RCX: ffff88806cb606c0
P4D 6801067
RDX: 0000000084bc6976 RSI: 000000000000000c RDI: 00000000508ad1ea
PUD 6802067
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
PMD 9b9b063
R10: ffff88806d309818 R11: 0000000000000003 R12: 0000000000000000
PTE 0
R13: ffff88806d309958 R14: ffff88800834c2f0 R15: 000000000000000d

FS:  0000000000000000(0000) GS:ffff88806d300000(0000) knlGS:0000000000000000
Oops: Oops: 0000 [#2] PREEMPT SMP KASAN PTI
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D            6.10.0 #2
CR2: ffff88800834c300 CR3: 0000000007522005 CR4: 0000000000170ef0
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
RIP: 0010:find_stack linux-6.10/lib/stackdepot.c:553 [inline]
RIP: 0010:stack_depot_save_flags+0x122/0x6f0 linux-6.10/lib/stackdepot.c:618
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Code: 03 0d 8a e3 6a 04 65 ff 05 c3 f6 01 7e 4c 8b 31 41 89 e9 41 8d
77 ff 41 83 e1 02 4c 39 f1 75 0a eb 1e 4d 8b 36 4c 39 f1 74 16 <41> 39
5e 10 75 f2 31 c0 45 3b 7e 14 74 10 4d 8b 36 4c 39 f1 75 ea
----------------
Code disassembly (best guess):
   0: 03 0d 8a e3 6a 04    add    0x46ae38a(%rip),%ecx        # 0x46ae390
   6: 65 ff 05 c3 f6 01 7e incl   %gs:0x7e01f6c3(%rip)        # 0x7e01f6d0
   d: 4c 8b 31              mov    (%rcx),%r14
  10: 41 89 e9              mov    %ebp,%r9d
  13: 41 8d 77 ff          lea    -0x1(%r15),%esi
  17: 41 83 e1 02          and    $0x2,%r9d
  1b: 4c 39 f1              cmp    %r14,%rcx
  1e: 75 0a                jne    0x2a
  20: eb 1e                jmp    0x40
  22: 4d 8b 36              mov    (%r14),%r14
  25: 4c 39 f1              cmp    %r14,%rcx
  28: 74 16                je     0x40
* 2a: 41 39 5e 10          cmp    %ebx,0x10(%r14) <-- trapping instruction
  2e: 75 f2                jne    0x22
  30: 31 c0                xor    %eax,%eax
  32: 45 3b 7e 14          cmp    0x14(%r14),%r15d
  36: 74 10                je     0x48
  38: 4d 8b 36              mov    (%r14),%r14
  3b: 4c 39 f1              cmp    %r14,%rcx
  3e: 75 ea                jne    0x2a


- reproducer
r0 = syz_open_dev$tty20(0xc, 0x4, 0x1)
setxattr$trusted_overlay_opaque(0x0, 0x0, 0x0, 0x0, 0x0)
syz_open_dev$sg(0x0, 0x5, 0x20000)
socket$inet6_tcp(0xa, 0x1, 0x0)
syz_genetlink_get_family_id$ipvs(0x0, 0xffffffffffffffff)
r1 = openat$urandom(0xffffffffffffff9c, &(0x7f0000000040), 0x0, 0x0)
read(r1, &(0x7f0000000000), 0x2000)
socket$inet6_icmp_raw(0xa, 0x3, 0x3a)
syz_clone3(0x0, 0x0)
ioctl$KDGKBMODE(r0, 0x4b44, &(0x7f0000000480))
r2 = syz_open_dev$sg(&(0x7f00000000c0), 0x0, 0x0)
ioctl$SCSI_IOCTL_SEND_COMMAND(r2, 0x1,
&(0x7f0000000000)=ANY=[@ANYBLOB="000000001d00000085", @ANYRES8=r2])


- kernel config
https://drive.google.com/file/d/1LMJgfJPhTu78Cd2DfmDaRitF6cdxxcey/view?usp=sharing


[^1] We used a customized Syzkaller but did not change the guest kernel or the
hypervisor.

