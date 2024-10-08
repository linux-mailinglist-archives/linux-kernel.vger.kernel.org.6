Return-Path: <linux-kernel+bounces-355694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D219955CA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 19:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C36F11F25E14
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 17:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02F020ADC1;
	Tue,  8 Oct 2024 17:36:29 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAE620A5F5
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 17:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728408988; cv=none; b=Say1UOycd6yulUQTpArG1+CokArnvZNy3LsoaN0C6VciCUPBqu9AazI6NrTtTH1ON+3EK01CSKdbQfqZOkWr7wbpooowEXV53cnedB9+CSS58Sz4drUWWcGCA35ZGNg2BkUD97mny5DTSSy7JRa1wzI6RsAp38AYMNqJVT67as0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728408988; c=relaxed/simple;
	bh=DNg3NYGFQ3OaIi/SN9v3Y7niL07DDr4tzBbKpqIebCs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UxdY9DUfA+Tbw7HSlDRxIefbRSDfVRDvPsuyBiMARRrbixti4zhS5JieWVhKN7i2sRb8jpAB4qDY7gfImMSn4lHEVq5D63d2tF+v7+uZ0g4uxu2c4AVngZywGsogPvCW3tFYNe2sJb9NbJSn5TUeIqxpaWfvwNEmHAcWy7TP1mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a39631593aso249685ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 10:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728408985; x=1729013785;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=knim6RMb0UOBysPQSJ6ShmsHPlXqICjEz5a6oGa8pOw=;
        b=RJLJoYFfmPfWi6C8hG/zskNPeFaHtThgIEuJfIs+tY9naslJW8VA12AkAx9eOavKeY
         W4iSPaFiGmL++X/TdoFQWJOk5wxOkfMLDz6KARNoTHoGZd+FEnBO4LLB32iXp00SQ2l2
         65WgFoKUY/9dW2NMGFKhWhhpuDqDsVf3Pud8c9Oxh7e/Cq+k48E6rRWx1be5I/AoWLyx
         oDGfejBVBwlzegMuP0ATUI4FFw347Sk/5IbyIzHunOiQCBxLF7erO96Q99mW4UxXynJ4
         +geolKX96VnNxhUtbfDVqcpDomzWw3jWaVqEOGidH0kD8OEH28uSxXPmE5T1Jih2hxyL
         um2A==
X-Forwarded-Encrypted: i=1; AJvYcCVvt2N0ROcUHVSAPpKp1tBlOxRcCtx2Bwwx45vy/ngu8rknYF2Js168lJCBNGuoUAizNNh25aOl88BtrXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtI48VIXwFNue50MM3dhgJGm1mqjH5JI00DCeu4A0Hxru/ptsd
	lrqIdJLSJRBvjzMRMYts9/RbLEwk80KZQycIC+NLH3xLgoZ1Dv1e+Rv7/9VIP2RQimIezvL4VI0
	F2xmmEfn55myJFlWppNlKPiKmHPZ6e08tIVvZQ0cXb0m4rE6keM1U1Ss=
X-Google-Smtp-Source: AGHT+IE44rWtn0WHiK/olQdkOZY/bukIfocfm05ncMg3ovKW4VACXSVujr88DmGXlLKC0ltrVkr0sqBeT4T9nH07/108jlyK/rp/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8e:b0:3a2:6402:96b9 with SMTP id
 e9e14a558f8ab-3a3946e88e6mr7458785ab.9.1728408985198; Tue, 08 Oct 2024
 10:36:25 -0700 (PDT)
Date: Tue, 08 Oct 2024 10:36:25 -0700
In-Reply-To: <000000000000939d0a0621818f1e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67056d99.050a0220.840ef.000a.GAE@google.com>
Subject: Re: [syzbot] [mm?] INFO: task hung in hugetlb_fault
From: syzbot <syzbot+7bb5e48f6ead66c72906@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, dvyukov@google.com, elver@google.com, 
	glider@google.com, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, muchun.song@linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    87d6aab2389e Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17e11780580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fb6ea01107fa96bd
dashboard link: https://syzkaller.appspot.com/bug?extid=7bb5e48f6ead66c72906
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17dd6327980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d24f9f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/676a1b91b952/disk-87d6aab2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f47965c6cebd/vmlinux-87d6aab2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9ada52fd0e29/bzImage-87d6aab2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7bb5e48f6ead66c72906@syzkaller.appspotmail.com

INFO: task syz-executor390:6168 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc2-syzkaller-00006-g87d6aab2389e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor390 state:D stack:28288 pid:6168  tgid:6166  ppid:5217   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0xef5/0x5750 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 io_schedule+0xbf/0x130 kernel/sched/core.c:7552
 folio_wait_bit_common+0x3d8/0x9b0 mm/filemap.c:1309
 __folio_lock mm/filemap.c:1647 [inline]
 folio_lock include/linux/pagemap.h:1148 [inline]
 folio_lock include/linux/pagemap.h:1144 [inline]
 __filemap_get_folio+0x6a4/0xaf0 mm/filemap.c:1900
 filemap_lock_folio include/linux/pagemap.h:788 [inline]
 filemap_lock_hugetlb_folio include/linux/hugetlb.h:795 [inline]
 hugetlb_fault+0x16ff/0x2fa0 mm/hugetlb.c:6406
 handle_mm_fault+0x930/0xaa0 mm/memory.c:6060
 do_user_addr_fault+0x7a3/0x13f0 arch/x86/mm/fault.c:1389
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x5c/0xc0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:rep_movs_alternative+0x33/0x70 arch/x86/lib/copy_user_64.S:58
Code: 40 83 f9 08 73 21 85 c9 74 0f 8a 06 88 07 48 ff c7 48 ff c6 48 ff c9 75 f1 c3 cc cc cc cc 66 0f 1f 84 00 00 00 00 00 48 8b 06 <48> 89 07 48 83 c6 08 48 83 c7 08 83 e9 08 74 df 83 f9 08 73 e8 eb
RSP: 0018:ffffc90009107c48 EFLAGS: 00050246
RAX: 0000000000000000 RBX: 0000000000000008 RCX: 0000000000000008
RDX: fffff52001220f98 RSI: ffffc90009107cb8 RDI: 000000002001bd48
RBP: 000000002001bd48 R08: 0000000000000000 R09: fffff52001220f97
R10: ffffc90009107cbf R11: 0000000000000000 R12: ffffc90009107cb8
R13: 000000002001bd50 R14: 0000000000000000 R15: 0000000020019680
 copy_user_generic arch/x86/include/asm/uaccess_64.h:121 [inline]
 raw_copy_to_user arch/x86/include/asm/uaccess_64.h:142 [inline]
 _inline_copy_to_user include/linux/uaccess.h:188 [inline]
 _copy_to_user+0xac/0xc0 lib/usercopy.c:26
 copy_to_user include/linux/uaccess.h:216 [inline]
 msr_read+0x14f/0x250 arch/x86/kernel/msr.c:69
 vfs_read+0x1ce/0xbd0 fs/read_write.c:567
 ksys_read+0x12f/0x260 fs/read_write.c:712
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4df1b1f8b9
RSP: 002b:00007f4df1ad6168 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f4df1ba6348 RCX: 00007f4df1b1f8b9
RDX: 0000000000018ff8 RSI: 0000000020019680 RDI: 0000000000000003
RBP: 00007f4df1ba6340 R08: 00007f4df1ad66c0 R09: 00007f4df1ba6348
R10: 00007f4df1ad66c0 R11: 0000000000000246 R12: 00007f4df1ba634c
R13: 0000000000000000 R14: 00007fff98b1c2f0 R15: 00007fff98b1c3d8
 </TASK>
INFO: task syz-executor390:6172 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc2-syzkaller-00006-g87d6aab2389e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor390 state:D stack:27104 pid:6172  tgid:6166  ppid:5217   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0xef5/0x5750 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 hugetlb_wp+0x1b4a/0x3320 mm/hugetlb.c:5894
 hugetlb_fault+0x2248/0x2fa0 mm/hugetlb.c:6454
 handle_mm_fault+0x930/0xaa0 mm/memory.c:6060
 do_user_addr_fault+0x60d/0x13f0 arch/x86/mm/fault.c:1338
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x5c/0xc0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7f4df1ae75cb
RSP: 002b:00007f4df1ab5170 EFLAGS: 00010246
RAX: 006b6e696c766564 RBX: 00007f4df1ba6358 RCX: 00007f4df1b1f8b9
RDX: d8e7cd4472269fec RSI: 0000000000000000 RDI: 00007f4df1ab55a0
RBP: 00007f4df1ba6350 R08: 00007f4df1ab56c0 R09: 00007f4df1ab56c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f4df1ba635c
R13: 000000000000006e R14: 00007fff98b1c2f0 R15: 00007fff98b1c3d8
 </TASK>
INFO: task syz-executor390:6171 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc2-syzkaller-00006-g87d6aab2389e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor390 state:D stack:28288 pid:6171  tgid:6167  ppid:5213   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0xef5/0x5750 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 hugetlb_fault+0x307/0x2fa0 mm/hugetlb.c:6326
 handle_mm_fault+0x930/0xaa0 mm/memory.c:6060
 do_user_addr_fault+0x7a3/0x13f0 arch/x86/mm/fault.c:1389
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x5c/0xc0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:rep_movs_alternative+0x33/0x70 arch/x86/lib/copy_user_64.S:58
Code: 40 83 f9 08 73 21 85 c9 74 0f 8a 06 88 07 48 ff c7 48 ff c6 48 ff c9 75 f1 c3 cc cc cc cc 66 0f 1f 84 00 00 00 00 00 48 8b 06 <48> 89 07 48 83 c6 08 48 83 c7 08 83 e9 08 74 df 83 f9 08 73 e8 eb
RSP: 0018:ffffc90009117c48 EFLAGS: 00050246
RAX: 0000000000000000 RBX: 0000000000000008 RCX: 0000000000000008
RDX: fffff52001222f98 RSI: ffffc90009117cb8 RDI: 000000002001b8a0
RBP: 000000002001b8a0 R08: 0000000000000000 R09: fffff52001222f97
R10: ffffc90009117cbf R11: 0000000000000000 R12: ffffc90009117cb8
R13: 000000002001b8a8 R14: 0000000000000000 R15: 0000000020019680
 copy_user_generic arch/x86/include/asm/uaccess_64.h:121 [inline]
 raw_copy_to_user arch/x86/include/asm/uaccess_64.h:142 [inline]
 _inline_copy_to_user include/linux/uaccess.h:188 [inline]
 _copy_to_user+0xac/0xc0 lib/usercopy.c:26
 copy_to_user include/linux/uaccess.h:216 [inline]
 msr_read+0x14f/0x250 arch/x86/kernel/msr.c:69
 vfs_read+0x1ce/0xbd0 fs/read_write.c:567
 ksys_read+0x12f/0x260 fs/read_write.c:712
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4df1b1f8b9
RSP: 002b:00007f4df1ad6168 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f4df1ba6348 RCX: 00007f4df1b1f8b9
RDX: 0000000000018ff8 RSI: 0000000020019680 RDI: 0000000000000003
RBP: 00007f4df1ba6340 R08: 00007f4df1ad66c0 R09: 00007f4df1ba6348
R10: 00007f4df1ad66c0 R11: 0000000000000246 R12: 00007f4df1ba634c
R13: 0000000000000000 R14: 00007fff98b1c2f0 R15: 00007fff98b1c3d8
 </TASK>
INFO: task syz-executor390:6174 blocked for more than 144 seconds.
      Not tainted 6.12.0-rc2-syzkaller-00006-g87d6aab2389e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor390 state:D stack:27104 pid:6174  tgid:6167  ppid:5213   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0xef5/0x5750 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 hugetlb_fault+0x307/0x2fa0 mm/hugetlb.c:6326
 handle_mm_fault+0x930/0xaa0 mm/memory.c:6060
 do_user_addr_fault+0x60d/0x13f0 arch/x86/mm/fault.c:1338
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x5c/0xc0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7f4df1ae75cb
RSP: 002b:00007f4df1ab5170 EFLAGS: 00010246
RAX: 006b6e696c766564 RBX: 00007f4df1ba6358 RCX: 00007f4df1b1f8b9
RDX: d8e7cd4472269fec RSI: 0000000000000000 RDI: 00007f4df1ab55a0
RBP: 00007f4df1ba6350 R08: 00007f4df1ba6358 R09: 00007f4df1ab56c0
R10: 00007f4df1ab56c0 R11: 0000000000000246 R12: 00007f4df1ba635c
R13: 000000000000006e R14: 00007fff98b1c2f0 R15: 00007fff98b1c3d8
 </TASK>
INFO: task syz-executor390:6384 blocked for more than 144 seconds.
      Not tainted 6.12.0-rc2-syzkaller-00006-g87d6aab2389e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor390 state:D stack:27040 pid:6384  tgid:6383  ppid:5218   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0xef5/0x5750 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 hugetlb_fault+0x307/0x2fa0 mm/hugetlb.c:6326
 handle_mm_fault+0x930/0xaa0 mm/memory.c:6060
 do_user_addr_fault+0x7a3/0x13f0 arch/x86/mm/fault.c:1389
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x5c/0xc0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:rep_movs_alternative+0x33/0x70 arch/x86/lib/copy_user_64.S:58
Code: 40 83 f9 08 73 21 85 c9 74 0f 8a 06 88 07 48 ff c7 48 ff c6 48 ff c9 75 f1 c3 cc cc cc cc 66 0f 1f 84 00 00 00 00 00 48 8b 06 <48> 89 07 48 83 c6 08 48 83 c7 08 83 e9 08 74 df 83 f9 08 73 e8 eb
RSP: 0018:ffffc90009597c48 EFLAGS: 00050246
RAX: 0000000000000000 RBX: 0000000000000008 RCX: 0000000000000008
RDX: fffff520012b2f98 RSI: ffffc90009597cb8 RDI: 000000002001d000
RBP: 000000002001d000 R08: 0000000000000000 R09: fffff520012b2f97
R10: ffffc90009597cbf R11: 0000000000000000 R12: ffffc90009597cb8
R13: 000000002001d008 R14: 0000000000000000 R15: 0000000020019680
 copy_user_generic arch/x86/include/asm/uaccess_64.h:121 [inline]
 raw_copy_to_user arch/x86/include/asm/uaccess_64.h:142 [inline]
 _inline_copy_to_user include/linux/uaccess.h:188 [inline]
 _copy_to_user+0xac/0xc0 lib/usercopy.c:26
 copy_to_user include/linux/uaccess.h:216 [inline]
 msr_read+0x14f/0x250 arch/x86/kernel/msr.c:69
 vfs_read+0x1ce/0xbd0 fs/read_write.c:567
 ksys_read+0x12f/0x260 fs/read_write.c:712
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4df1b1f8b9
RSP: 002b:00007f4df1ad6168 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f4df1ba6348 RCX: 00007f4df1b1f8b9
RDX: 0000000000018ff8 RSI: 0000000020019680 RDI: 0000000000000003
RBP: 00007f4df1ba6340 R08: 00007f4df1ad66c0 R09: 00007f4df1ba6348
R10: 00007f4df1ba6348 R11: 0000000000000246 R12: 00007f4df1ba634c
R13: 0000000000000000 R14: 00007fff98b1c2f0 R15: 00007fff98b1c3d8
 </TASK>
INFO: task syz-executor390:6385 blocked for more than 144 seconds.
      Not tainted 6.12.0-rc2-syzkaller-00006-g87d6aab2389e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor390 state:D stack:27088 pid:6385  tgid:6383  ppid:5218   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0xef5/0x5750 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 hugetlbfs_fallocate+0x577/0xfc0 fs/hugetlbfs/inode.c:872
 vfs_fallocate+0x459/0xf90 fs/open.c:333
 ksys_fallocate fs/open.c:356 [inline]
 __do_sys_fallocate fs/open.c:364 [inline]
 __se_sys_fallocate fs/open.c:362 [inline]
 __x64_sys_fallocate+0xd9/0x150 fs/open.c:362
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4df1b1f8b9
RSP: 002b:00007f4df1ab5168 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00007f4df1ba6358 RCX: 00007f4df1b1f8b9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f4df1ba6350 R08: 00007f4df1ab56c0 R09: 00007f4df1ba6358
R10: 0000000000000400 R11: 0000000000000246 R12: 00007f4df1ba635c
R13: 000000000000006e R14: 00007fff98b1c2f0 R15: 00007fff98b1c3d8
 </TASK>
INFO: task syz-executor390:6457 blocked for more than 145 seconds.
      Not tainted 6.12.0-rc2-syzkaller-00006-g87d6aab2389e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor390 state:D stack:27408 pid:6457  tgid:6453  ppid:5216   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0xef5/0x5750 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 hugetlbfs_fallocate+0x577/0xfc0 fs/hugetlbfs/inode.c:872
 vfs_fallocate+0x459/0xf90 fs/open.c:333
 ksys_fallocate fs/open.c:356 [inline]
 __do_sys_fallocate fs/open.c:364 [inline]
 __se_sys_fallocate fs/open.c:362 [inline]
 __x64_sys_fallocate+0xd9/0x150 fs/open.c:362
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4df1b1f8b9
RSP: 002b:00007f4df1ab5168 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00007f4df1ba6358 RCX: 00007f4df1b1f8b9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f4df1ba6350 R08: 00007f4df1ab56c0 R09: 00007f4df1ba6358
R10: 0000000000000400 R11: 0000000000000246 R12: 00007f4df1ba635c
R13: 000000000000006e R14: 00007fff98b1c2f0 R15: 00007fff98b1c3d8
 </TASK>
INFO: task syz-executor390:6501 blocked for more than 145 seconds.
      Not tainted 6.12.0-rc2-syzkaller-00006-g87d6aab2389e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor390 state:D stack:27616 pid:6501  tgid:6500  ppid:5215   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0xef5/0x5750 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 hugetlb_fault+0x307/0x2fa0 mm/hugetlb.c:6326
 handle_mm_fault+0x930/0xaa0 mm/memory.c:6060
 do_user_addr_fault+0x7a3/0x13f0 arch/x86/mm/fault.c:1389
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x5c/0xc0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:rep_movs_alternative+0x33/0x70 arch/x86/lib/copy_user_64.S:58
Code: 40 83 f9 08 73 21 85 c9 74 0f 8a 06 88 07 48 ff c7 48 ff c6 48 ff c9 75 f1 c3 cc cc cc cc 66 0f 1f 84 00 00 00 00 00 48 8b 06 <48> 89 07 48 83 c6 08 48 83 c7 08 83 e9 08 74 df 83 f9 08 73 e8 eb
RSP: 0018:ffffc90009567c48 EFLAGS: 00050246
RAX: 0000000000000000 RBX: 0000000000000008 RCX: 0000000000000008
RDX: fffff520012acf98 RSI: ffffc90009567cb8 RDI: 000000002001e260
RBP: 000000002001e260 R08: 0000000000000000 R09: fffff520012acf97
R10: ffffc90009567cbf R11: 0000000000000000 R12: ffffc90009567cb8
R13: 000000002001e268 R14: 0000000000000000 R15: 0000000020019680
 copy_user_generic arch/x86/include/asm/uaccess_64.h:121 [inline]
 raw_copy_to_user arch/x86/include/asm/uaccess_64.h:142 [inline]
 _inline_copy_to_user include/linux/uaccess.h:188 [inline]
 _copy_to_user+0xac/0xc0 lib/usercopy.c:26
 copy_to_user include/linux/uaccess.h:216 [inline]
 msr_read+0x14f/0x250 arch/x86/kernel/msr.c:69
 vfs_read+0x1ce/0xbd0 fs/read_write.c:567
 ksys_read+0x12f/0x260 fs/read_write.c:712
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4df1b1f8b9
RSP: 002b:00007f4df1ad6168 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f4df1ba6348 RCX: 00007f4df1b1f8b9
RDX: 0000000000018ff8 RSI: 0000000020019680 RDI: 0000000000000003
RBP: 00007f4df1ba6340 R08: 00007f4df1ad66c0 R09: 00007f4df1ba6348
R10: 00007f4df1ad66c0 R11: 0000000000000246 R12: 00007f4df1ba634c
R13: 0000000000000000 R14: 00007fff98b1c2f0 R15: 00007fff98b1c3d8
 </TASK>
INFO: task syz-executor390:6502 blocked for more than 145 seconds.
      Not tainted 6.12.0-rc2-syzkaller-00006-g87d6aab2389e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor390 state:D stack:27184 pid:6502  tgid:6500  ppid:5215   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0xef5/0x5750 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 hugetlbfs_fallocate+0x577/0xfc0 fs/hugetlbfs/inode.c:872
 vfs_fallocate+0x459/0xf90 fs/open.c:333
 ksys_fallocate fs/open.c:356 [inline]
 __do_sys_fallocate fs/open.c:364 [inline]
 __se_sys_fallocate fs/open.c:362 [inline]
 __x64_sys_fallocate+0xd9/0x150 fs/open.c:362
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4df1b1f8b9
RSP: 002b:00007f4df1ab5168 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00007f4df1ba6358 RCX: 00007f4df1b1f8b9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f4df1ba6350 R08: 00007f4df1ab56c0 R09: 00007f4df1ba6358
R10: 0000000000000400 R11: 0000000000000246 R12: 00007f4df1ba635c
R13: 000000000000006e R14: 00007fff98b1c2f0 R15: 00007fff98b1c3d8
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e1b8340 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e1b8340 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e1b8340 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x7f/0x390 kernel/locking/lockdep.c:6720
5 locks held by kworker/u8:8/3033:
1 lock held by klogd/4663:
2 locks held by getty/4978:
 #0: ffff88814c4320a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfba/0x1480 drivers/tty/n_tty.c:2211
3 locks held by syz-executor390/6168:
 #0: ffff8880614a9498 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock_killable include/linux/mmap_lock.h:153 [inline]
 #0: ffff8880614a9498 (&mm->mmap_lock){++++}-{3:3}, at: get_mmap_lock_carefully mm/memory.c:6108 [inline]
 #0: ffff8880614a9498 (&mm->mmap_lock){++++}-{3:3}, at: lock_mm_and_find_vma+0x3a9/0x6a0 mm/memory.c:6159
 #1: ffff8881442d0728 (&hugetlb_fault_mutex_table[i]){+.+.}-{3:3}, at: hugetlb_fault+0x307/0x2fa0 mm/hugetlb.c:6326
 #2: ffff88806034b8e8 (&resv_map->rw_sema){++++}-{3:3}, at: hugetlb_vma_lock_read mm/hugetlb.c:276 [inline]
 #2: ffff88806034b8e8 (&resv_map->rw_sema){++++}-{3:3}, at: hugetlb_vma_lock_read+0x105/0x140 mm/hugetlb.c:267
2 locks held by syz-executor390/6172:
 #0: ffff8880247719b8 (&vma->vm_lock->lock){++++}-{3:3}, at: vma_start_read include/linux/mm.h:704 [inline]
 #0: ffff8880247719b8 (&vma->vm_lock->lock){++++}-{3:3}, at: lock_vma_under_rcu+0x13e/0x980 mm/memory.c:6228
 #1: ffff8881442d0728 (&hugetlb_fault_mutex_table[i]){+.+.}-{3:3}, at: hugetlb_wp+0x1b4a/0x3320 mm/hugetlb.c:5894
2 locks held by syz-executor390/6171:
 #0: ffff8880614a9e18 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_trylock include/linux/mmap_lock.h:163 [inline]
 #0: ffff8880614a9e18 (&mm->mmap_lock){++++}-{3:3}, at: get_mmap_lock_carefully mm/memory.c:6099 [inline]
 #0: ffff8880614a9e18 (&mm->mmap_lock){++++}-{3:3}, at: lock_mm_and_find_vma+0x35/0x6a0 mm/memory.c:6159
 #1: ffff8881442d0728 (&hugetlb_fault_mutex_table[i]){+.+.}-{3:3}, at: hugetlb_fault+0x307/0x2fa0 mm/hugetlb.c:6326
2 locks held by syz-executor390/6174:
 #0: ffff88801d6e7070 (&vma->vm_lock->lock){++++}-{3:3}, at: vma_start_read include/linux/mm.h:704 [inline]
 #0: ffff88801d6e7070 (&vma->vm_lock->lock){++++}-{3:3}, at: lock_vma_under_rcu+0x13e/0x980 mm/memory.c:6228
 #1: ffff8881442d0728 (&hugetlb_fault_mutex_table[i]){+.+.}-{3:3}, at: hugetlb_fault+0x307/0x2fa0 mm/hugetlb.c:6326
2 locks held by syz-executor390/6384:
 #0: ffff8880612e3a98 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock_killable include/linux/mmap_lock.h:153 [inline]
 #0: ffff8880612e3a98 (&mm->mmap_lock){++++}-{3:3}, at: get_mmap_lock_carefully mm/memory.c:6108 [inline]
 #0: ffff8880612e3a98 (&mm->mmap_lock){++++}-{3:3}, at: lock_mm_and_find_vma+0x3a9/0x6a0 mm/memory.c:6159
 #1: ffff8881442d0728 (&hugetlb_fault_mutex_table[i]){+.+.}-{3:3}, at: hugetlb_fault+0x307/0x2fa0 mm/hugetlb.c:6326
3 locks held by syz-executor390/6385:
 #0: ffff8880232a0420 (sb_writers#10){.+.+}-{0:0}, at: ksys_fallocate fs/open.c:356 [inline]
 #0: ffff8880232a0420 (sb_writers#10){.+.+}-{0:0}, at: __do_sys_fallocate fs/open.c:364 [inline]
 #0: ffff8880232a0420 (sb_writers#10){.+.+}-{0:0}, at: __se_sys_fallocate fs/open.c:362 [inline]
 #0: ffff8880232a0420 (sb_writers#10){.+.+}-{0:0}, at: __x64_sys_fallocate+0xd9/0x150 fs/open.c:362
 #1: ffff88806270b8f8 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:815 [inline]
 #1: ffff88806270b8f8 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: hugetlbfs_fallocate+0x2b6/0xfc0 fs/hugetlbfs/inode.c:828
 #2: ffff8881442d0728 (&hugetlb_fault_mutex_table[i]){+.+.}-{3:3}, at: hugetlbfs_fallocate+0x577/0xfc0 fs/hugetlbfs/inode.c:872
3 locks held by syz-executor390/6457:
 #0: ffff8880232a0420 (sb_writers#10){.+.+}-{0:0}, at: ksys_fallocate fs/open.c:356 [inline]
 #0: ffff8880232a0420 (sb_writers#10){.+.+}-{0:0}, at: __do_sys_fallocate fs/open.c:364 [inline]
 #0: ffff8880232a0420 (sb_writers#10){.+.+}-{0:0}, at: __se_sys_fallocate fs/open.c:362 [inline]
 #0: ffff8880232a0420 (sb_writers#10){.+.+}-{0:0}, at: __x64_sys_fallocate+0xd9/0x150 fs/open.c:362
 #1: ffff888060fa4148 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:815 [inline]
 #1: ffff888060fa4148 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: hugetlbfs_fallocate+0x2b6/0xfc0 fs/hugetlbfs/inode.c:828
 #2: ffff8881442d0728 (&hugetlb_fault_mutex_table[i]){+.+.}-{3:3}, at: hugetlbfs_fallocate+0x577/0xfc0 fs/hugetlbfs/inode.c:872
2 locks held by syz-executor390/6501:
 #0: ffff88807d5a4d98 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock_killable include/linux/mmap_lock.h:153 [inline]
 #0: ffff88807d5a4d98 (&mm->mmap_lock){++++}-{3:3}, at: get_mmap_lock_carefully mm/memory.c:6108 [inline]
 #0: ffff88807d5a4d98 (&mm->mmap_lock){++++}-{3:3}, at: lock_mm_and_find_vma+0x3a9/0x6a0 mm/memory.c:6159
 #1: ffff8881442d0728 (&hugetlb_fault_mutex_table[i]){+.+.}-{3:3}, at: hugetlb_fault+0x307/0x2fa0 mm/hugetlb.c:6326
3 locks held by syz-executor390/6502:
 #0: ffff8880232a0420 (sb_writers#10){.+.+}-{0:0}, at: ksys_fallocate fs/open.c:356 [inline]
 #0: ffff8880232a0420 (sb_writers#10){.+.+}-{0:0}, at: __do_sys_fallocate fs/open.c:364 [inline]
 #0: ffff8880232a0420 (sb_writers#10){.+.+}-{0:0}, at: __se_sys_fallocate fs/open.c:362 [inline]
 #0: ffff8880232a0420 (sb_writers#10){.+.+}-{0:0}, at: __x64_sys_fallocate+0xd9/0x150 fs/open.c:362
 #1: ffff8880611b69c8 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:815 [inline]
 #1: ffff8880611b69c8 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: hugetlbfs_fallocate+0x2b6/0xfc0 fs/hugetlbfs/inode.c:828
 #2: ffff8881442d0728 (&hugetlb_fault_mutex_table[i]){+.+.}-{3:3}, at: hugetlbfs_fallocate+0x577/0xfc0 fs/hugetlbfs/inode.c:872

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.12.0-rc2-syzkaller-00006-g87d6aab2389e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x27b/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xf0c/0x1240 kernel/hung_task.c:379
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 3033 Comm: kworker/u8:8 Not tainted 6.12.0-rc2-syzkaller-00006-g87d6aab2389e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:lockdep_recursion_finish kernel/locking/lockdep.c:467 [inline]
RIP: 0010:lock_acquire.part.0+0x126/0x380 kernel/locking/lockdep.c:5827
Code: 94 c1 6a 00 45 0f b6 c9 ff b4 24 f8 00 00 00 41 57 44 8b 44 24 2c 8b 4c 24 28 e8 a5 ad ff ff 48 c7 c7 40 d3 6c 8b 48 83 c4 28 <e8> 25 23 b7 09 b8 ff ff ff ff 65 0f c1 05 40 d7 97 7e 83 f8 01 0f
RSP: 0018:ffffc90009a577a8 EFLAGS: 00000082
RAX: 0000000000000001 RBX: 1ffff9200134aef6 RCX: 0000000000000001
RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffffffff8b6cd340
RBP: 0000000000000200 R08: 0000000000000000 R09: fffffbfff2dc4d88
R10: ffffffff96e26c47 R11: 0000000000000000 R12: 0000000000000000
R13: ffff88801b07b078 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055a312fe8fd8 CR3: 000000000df7c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 __pte_offset_map_lock+0xf1/0x300 mm/pgtable-generic.c:375
 pte_offset_map_lock include/linux/mm.h:3014 [inline]
 __get_locked_pte+0x79/0xc0 mm/memory.c:1992
 get_locked_pte include/linux/mm.h:2727 [inline]
 __text_poke+0x224/0xca0 arch/x86/kernel/alternative.c:1899
 text_poke_bp_batch+0x493/0x760 arch/x86/kernel/alternative.c:2373
 text_poke_flush arch/x86/kernel/alternative.c:2486 [inline]
 text_poke_flush arch/x86/kernel/alternative.c:2483 [inline]
 text_poke_finish+0x30/0x40 arch/x86/kernel/alternative.c:2493
 arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
 jump_label_update+0x1d7/0x400 kernel/jump_label.c:920
 static_key_enable_cpuslocked+0x1b7/0x270 kernel/jump_label.c:210
 static_key_enable+0x1a/0x20 kernel/jump_label.c:223
 toggle_allocation_gate mm/kfence/core.c:849 [inline]
 toggle_allocation_gate+0xfc/0x260 mm/kfence/core.c:841
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.676 msecs


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

