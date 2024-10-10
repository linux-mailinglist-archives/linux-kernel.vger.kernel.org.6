Return-Path: <linux-kernel+bounces-358708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9110A9982B2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB0911F212DF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CDE1BB6BE;
	Thu, 10 Oct 2024 09:46:29 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6E010E6
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728553588; cv=none; b=JLzfL9UE5alYnUKkC4DVZNqY+ANh0MghS9b6LTZOURwR37CAbzSJnZfViZ6UZocTmbmNKxA5dt1ckrXw2HwNr+ZiRZB3rPYJLC7OpmFlVlw+raISDXaluHE9X8Y4slxC4rHgdhd7m8poymWu9p2gRdtO7m8WPTETFx3h++pRt3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728553588; c=relaxed/simple;
	bh=nLCjAI2lzdn5XG7wxaY7PlfZD104KVh0gxlBndtBI+w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=p1N1kut2Iyv3/8BU4FQtVhKNXtTSfC8vK1JSV8rCxn1jhrVoQLaHKSBibtWSOMktYeaxUfWGkx4iA29f+MFCgUoSJ8nyL8igkVSJhbG7+9oUo7dwsFwdZX4VE7ErPUsjeLYHBOILYXc2TCXfVsvio6r7/9ZmZkTznNEusLVs6mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a342e872a7so7924145ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 02:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728553584; x=1729158384;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fSMKPiAAVBf5LSl+D34DdF2HaAtrX+sLOOSYL+YMUpQ=;
        b=NazissZfxfo+5jZ0hBpYV8waFbIIQ50DjO9JutSLeKXHkXxrFRE7chfy5k9IX7eQU3
         8uERt4Y2PVfOrnV6vqNuGmjtpcVAPoqrZ0ubGmgP5ZWcqmdasQPg+GeqahKlJcGfJ647
         rPyVmC2G2CsI9eUrzLNg2wNEL4vw0yVoWD7hOzNgKTPTD/PsBiFvobwkDD4uMBFabaJs
         Z1mtUQ1+6Z+Rekst1DhrttlRE9fGN4xRAx3Is+q5c2oF0Wb0ax+QHdV1YrP5Pn3BL3ph
         g4QsoswtFAVIlcVxdLF1EOZF6goG8+YarUoZA58bZ+wGC6HUErQoW1V5TEd1MQ5HscSd
         vDlA==
X-Forwarded-Encrypted: i=1; AJvYcCXxVuw+ZYjdoLwiDiEfiWzwbLt4dxyUiudTEk5nAvBVvB1/IsKjGPq/uNI3wuEidR71x5dbvmNkoa7MTZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYURt/sm+Il365Z79wAPglDAMnvH9e1V1XblReuiZKFVGHlfvB
	NCCWyvJCe35B4asCNygL3rpzizq/V8M4ISe/hf4Quoyk3vTwpbWAE5ZU/yKzRc4xUwkFoHheAqi
	D9j10hjFZ4n0hxGSLMvmxf2oTRz4P9li9hwQxp9r/+yS1oue9PSf1yHM=
X-Google-Smtp-Source: AGHT+IHwilXyq0fbvKQqNq9jStxlqQSsbnozwkyvoFYftPzXAvbYu/lXUttp+5e/dCjtVNQWUXDI0TBpnwGMkQlcfkk30Gc252vQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:138a:b0:3a0:9f85:d74f with SMTP id
 e9e14a558f8ab-3a397d0fc3emr47740625ab.16.1728553584564; Thu, 10 Oct 2024
 02:46:24 -0700 (PDT)
Date: Thu, 10 Oct 2024 02:46:24 -0700
In-Reply-To: <0000000000005d16fe061fcaf338@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6707a270.050a0220.64b99.0015.GAE@google.com>
Subject: Re: [syzbot] [mm?] INFO: task hung in hugetlb_wp
From: syzbot <syzbot+c391aebb8e8e8cd95c55@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, kasan-dev@googlegroups.com, 
	keescook@chromium.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	muchun.song@linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    b983b271662b misc: sgi-gru: Don't disable preemption in GR..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14874b27980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fb6ea01107fa96bd
dashboard link: https://syzkaller.appspot.com/bug?extid=c391aebb8e8e8cd95c55
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=118c6fd0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b6a040580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/26adc3db9854/disk-b983b271.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/957da8fb32ba/vmlinux-b983b271.xz
kernel image: https://storage.googleapis.com/syzbot-assets/81f66240a49a/bzImage-b983b271.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c391aebb8e8e8cd95c55@syzkaller.appspotmail.com

INFO: task syz-executor966:9384 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc2-syzkaller-00061-gb983b271662b #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor966 state:D stack:26992 pid:9384  tgid:9380  ppid:5243   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0xef5/0x5750 kernel/sched/core.c:6682
 __schedule_loop kernel/sched/core.c:6759 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6774
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6831
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 hugetlb_wp+0x1b4a/0x3320 mm/hugetlb.c:5894
 hugetlb_fault+0x2248/0x2fa0 mm/hugetlb.c:6454
 handle_mm_fault+0x930/0xaa0 mm/memory.c:6060
 do_user_addr_fault+0x7a3/0x13f0 arch/x86/mm/fault.c:1389
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x5c/0xc0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:rep_movs_alternative+0x33/0x70 arch/x86/lib/copy_user_64.S:58
Code: 40 83 f9 08 73 21 85 c9 74 0f 8a 06 88 07 48 ff c7 48 ff c6 48 ff c9 75 f1 c3 cc cc cc cc 66 0f 1f 84 00 00 00 00 00 48 8b 06 <48> 89 07 48 83 c6 08 48 83 c7 08 83 e9 08 74 df 83 f9 08 73 e8 eb
RSP: 0018:ffffc9000ca47c48 EFLAGS: 00050246
RAX: 0000000000000000 RBX: 0000000000000008 RCX: 0000000000000008
RDX: fffff52001948f98 RSI: ffffc9000ca47cb8 RDI: 000000002002d008
RBP: 000000002002d008 R08: 0000000000000000 R09: fffff52001948f97
R10: ffffc9000ca47cbf R11: 0000000000000000 R12: ffffc9000ca47cb8
R13: 000000002002d010 R14: 0000000000000000 R15: 0000000020019680
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
RIP: 0033:0x7f1ba3b462d9
RSP: 002b:00007f1ba3afe218 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f1ba3bcd328 RCX: 00007f1ba3b462d9
RDX: 0000000000018ff8 RSI: 0000000020019680 RDI: 0000000000000003
RBP: 00007f1ba3bcd320 R08: 0000000000000000 R09: 0000000000000000
R10: 0072736d2f232f75 R11: 0000000000000246 R12: 00007f1ba3b9a328
R13: 00007f1ba3b9a078 R14: 0072736d2f232f75 R15: 7570632f7665642f
 </TASK>
INFO: task syz-executor966:9388 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc2-syzkaller-00061-gb983b271662b #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor966 state:D stack:27104 pid:9388  tgid:9380  ppid:5243   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0xef5/0x5750 kernel/sched/core.c:6682
 __schedule_loop kernel/sched/core.c:6759 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6774
 io_schedule+0xbf/0x130 kernel/sched/core.c:7559
 folio_wait_bit_common+0x3d8/0x9b0 mm/filemap.c:1309
 __folio_lock mm/filemap.c:1647 [inline]
 folio_lock include/linux/pagemap.h:1148 [inline]
 folio_lock include/linux/pagemap.h:1144 [inline]
 __filemap_get_folio+0x6a4/0xaf0 mm/filemap.c:1900
 filemap_lock_folio include/linux/pagemap.h:788 [inline]
 filemap_lock_hugetlb_folio include/linux/hugetlb.h:795 [inline]
 hugetlb_fault+0x16ff/0x2fa0 mm/hugetlb.c:6406
 handle_mm_fault+0x930/0xaa0 mm/memory.c:6060
 do_user_addr_fault+0x60d/0x13f0 arch/x86/mm/fault.c:1338
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x5c/0xc0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7f1ba3b0f030
RSP: 002b:00007f1ba3add220 EFLAGS: 00010217
RAX: 00007f1ba3b0f030 RBX: 00007f1ba3bcd338 RCX: ffffffffffffffb0
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f1ba3bcd338
RBP: 00007f1ba3bcd330 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f1ba3b9a328
R13: 00007f1ba3b9a078 R14: 0072736d2f232f75 R15: 7570632f7665642f
 </TASK>
INFO: task syz-executor966:9434 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc2-syzkaller-00061-gb983b271662b #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor966 state:D stack:27728 pid:9434  tgid:9430  ppid:5238   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0xef5/0x5750 kernel/sched/core.c:6682
 __schedule_loop kernel/sched/core.c:6759 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6774
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6831
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
RSP: 0018:ffffc9000cde7c48 EFLAGS: 00050246
RAX: 0000000000000000 RBX: 0000000000000008 RCX: 0000000000000008
RDX: fffff520019bcf98 RSI: ffffc9000cde7cb8 RDI: 000000002001d448
RBP: 000000002001d448 R08: 0000000000000000 R09: fffff520019bcf97
R10: ffffc9000cde7cbf R11: 0000000000000000 R12: ffffc9000cde7cb8
R13: 000000002001d450 R14: 0000000000000000 R15: 0000000020019680
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
RIP: 0033:0x7f1ba3b462d9
RSP: 002b:00007f1ba3afe218 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f1ba3bcd328 RCX: 00007f1ba3b462d9
RDX: 0000000000018ff8 RSI: 0000000020019680 RDI: 0000000000000003
RBP: 00007f1ba3bcd320 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f1ba3b9a328
R13: 00007f1ba3b9a078 R14: 0072736d2f232f75 R15: 7570632f7665642f
 </TASK>
INFO: task syz-executor966:9437 blocked for more than 144 seconds.
      Not tainted 6.12.0-rc2-syzkaller-00061-gb983b271662b #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor966 state:D stack:27408 pid:9437  tgid:9430  ppid:5238   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0xef5/0x5750 kernel/sched/core.c:6682
 __schedule_loop kernel/sched/core.c:6759 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6774
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6831
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
RIP: 0033:0x7f1ba3b462d9
RSP: 002b:00007f1ba3add218 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00007f1ba3bcd338 RCX: 00007f1ba3b462d9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f1ba3bcd330 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000400 R11: 0000000000000246 R12: 00007f1ba3b9a328
R13: 00007f1ba3b9a078 R14: 0072736d2f232f75 R15: 7570632f7665642f
 </TASK>
INFO: task syz-executor966:9679 blocked for more than 144 seconds.
      Not tainted 6.12.0-rc2-syzkaller-00061-gb983b271662b #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor966 state:D stack:28288 pid:9679  tgid:9678  ppid:5241   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0xef5/0x5750 kernel/sched/core.c:6682
 __schedule_loop kernel/sched/core.c:6759 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6774
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6831
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
RSP: 0018:ffffc9000d2b7c48 EFLAGS: 00050246
RAX: 0000000000000000 RBX: 0000000000000008 RCX: 0000000000000008
RDX: fffff52001a56f98 RSI: ffffc9000d2b7cb8 RDI: 0000000020020f20
RBP: 0000000020020f20 R08: 0000000000000000 R09: fffff52001a56f97
R10: ffffc9000d2b7cbf R11: 0000000000000000 R12: ffffc9000d2b7cb8
R13: 0000000020020f28 R14: 0000000000000000 R15: 0000000020019680
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
RIP: 0033:0x7f1ba3b462d9
RSP: 002b:00007f1ba3afe218 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f1ba3bcd328 RCX: 00007f1ba3b462d9
RDX: 0000000000018ff8 RSI: 0000000020019680 RDI: 0000000000000003
RBP: 00007f1ba3bcd320 R08: 0000000000000000 R09: 0000000000000000
R10: 0072736d2f232f75 R11: 0000000000000246 R12: 00007f1ba3b9a328
R13: 00007f1ba3b9a078 R14: 0072736d2f232f75 R15: 7570632f7665642f
 </TASK>
INFO: task syz-executor966:9684 blocked for more than 144 seconds.
      Not tainted 6.12.0-rc2-syzkaller-00061-gb983b271662b #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor966 state:D stack:27408 pid:9684  tgid:9678  ppid:5241   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0xef5/0x5750 kernel/sched/core.c:6682
 __schedule_loop kernel/sched/core.c:6759 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6774
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6831
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
RIP: 0033:0x7f1ba3b462d9
RSP: 002b:00007f1ba3add218 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00007f1ba3bcd338 RCX: 00007f1ba3b462d9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f1ba3bcd330 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000400 R11: 0000000000000246 R12: 00007f1ba3b9a328
R13: 00007f1ba3b9a078 R14: 0072736d2f232f75 R15: 7570632f7665642f
 </TASK>
INFO: task syz-executor966:9733 blocked for more than 145 seconds.
      Not tainted 6.12.0-rc2-syzkaller-00061-gb983b271662b #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor966 state:D stack:28288 pid:9733  tgid:9731  ppid:5239   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0xef5/0x5750 kernel/sched/core.c:6682
 __schedule_loop kernel/sched/core.c:6759 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6774
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6831
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
RSP: 0018:ffffc9000d2e7c48 EFLAGS: 00050246
RAX: 0000000000000000 RBX: 0000000000000008 RCX: 0000000000000008
RDX: fffff52001a5cf98 RSI: ffffc9000d2e7cb8 RDI: 0000000020023000
RBP: 0000000020023000 R08: 0000000000000000 R09: fffff52001a5cf97
R10: ffffc9000d2e7cbf R11: 0000000000000000 R12: ffffc9000d2e7cb8
R13: 0000000020023008 R14: 0000000000000000 R15: 0000000020019680
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
RIP: 0033:0x7f1ba3b462d9
RSP: 002b:00007f1ba3afe218 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f1ba3bcd328 RCX: 00007f1ba3b462d9
RDX: 0000000000018ff8 RSI: 0000000020019680 RDI: 0000000000000003
RBP: 00007f1ba3bcd320 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f1ba3b9a328
R13: 00007f1ba3b9a078 R14: 0072736d2f232f75 R15: 7570632f7665642f
 </TASK>
INFO: task syz-executor966:9735 blocked for more than 145 seconds.
      Not tainted 6.12.0-rc2-syzkaller-00061-gb983b271662b #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor966 state:D stack:27408 pid:9735  tgid:9731  ppid:5239   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0xef5/0x5750 kernel/sched/core.c:6682
 __schedule_loop kernel/sched/core.c:6759 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6774
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6831
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
RIP: 0033:0x7f1ba3b462d9
RSP: 002b:00007f1ba3add218 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00007f1ba3bcd338 RCX: 00007f1ba3b462d9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f1ba3bcd330 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000400 R11: 0000000000000246 R12: 00007f1ba3b9a328
R13: 00007f1ba3b9a078 R14: 0072736d2f232f75 R15: 7570632f7665642f
 </TASK>
INFO: task syz-executor966:9786 blocked for more than 145 seconds.
      Not tainted 6.12.0-rc2-syzkaller-00061-gb983b271662b #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor966 state:D stack:27648 pid:9786  tgid:9785  ppid:5236   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0xef5/0x5750 kernel/sched/core.c:6682
 __schedule_loop kernel/sched/core.c:6759 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6774
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6831
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
RSP: 0018:ffffc9000d477c48 EFLAGS: 00050246
RAX: 0000000000000000 RBX: 0000000000000008 RCX: 0000000000000008
RDX: fffff52001a8ef98 RSI: ffffc9000d477cb8 RDI: 00000000200226e0
RBP: 00000000200226e0 R08: 0000000000000000 R09: fffff52001a8ef97
R10: ffffc9000d477cbf R11: 0000000000000000 R12: ffffc9000d477cb8
R13: 00000000200226e8 R14: 0000000000000000 R15: 0000000020019680
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
RIP: 0033:0x7f1ba3b462d9
RSP: 002b:00007f1ba3afe218 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f1ba3bcd328 RCX: 00007f1ba3b462d9
RDX: 0000000000018ff8 RSI: 0000000020019680 RDI: 0000000000000003
RBP: 00007f1ba3bcd320 R08: 0000000000000000 R09: 0000000000000000
R10: 0072736d2f232f75 R11: 0000000000000246 R12: 00007f1ba3b9a328
R13: 00007f1ba3b9a078 R14: 0072736d2f232f75 R15: 7570632f7665642f
 </TASK>
INFO: task syz-executor966:9787 blocked for more than 146 seconds.
      Not tainted 6.12.0-rc2-syzkaller-00061-gb983b271662b #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor966 state:D stack:27408 pid:9787  tgid:9785  ppid:5236   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0xef5/0x5750 kernel/sched/core.c:6682
 __schedule_loop kernel/sched/core.c:6759 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6774
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6831
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
RIP: 0033:0x7f1ba3b462d9
RSP: 002b:00007f1ba3add218 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00007f1ba3bcd338 RCX: 00007f1ba3b462d9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f1ba3bcd330 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000400 R11: 0000000000000246 R12: 00007f1ba3b9a328
R13: 00007f1ba3b9a078 R14: 0072736d2f232f75 R15: 7570632f7665642f
 </TASK>
Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e1b8340 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e1b8340 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e1b8340 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x7f/0x390 kernel/locking/lockdep.c:6720
2 locks held by kworker/u8:5/793:
2 locks held by getty/4972:
 #0: ffff88814bbbb0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfba/0x1480 drivers/tty/n_tty.c:2211
2 locks held by syz-executor966/9384:
 #0: ffff88807b034418 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_trylock include/linux/mmap_lock.h:163 [inline]
 #0: ffff88807b034418 (&mm->mmap_lock){++++}-{3:3}, at: get_mmap_lock_carefully mm/memory.c:6099 [inline]
 #0: ffff88807b034418 (&mm->mmap_lock){++++}-{3:3}, at: lock_mm_and_find_vma+0x35/0x6a0 mm/memory.c:6159
 #1: ffff8881412dc698 (&hugetlb_fault_mutex_table[i]){+.+.}-{3:3}, at: hugetlb_wp+0x1b4a/0x3320 mm/hugetlb.c:5894
3 locks held by syz-executor966/9388:
 #0: ffff888079ca1ec8 (&vma->vm_lock->lock){++++}-{3:3}, at: vma_start_read include/linux/mm.h:704 [inline]
 #0: ffff888079ca1ec8 (&vma->vm_lock->lock){++++}-{3:3}, at: lock_vma_under_rcu+0x13e/0x980 mm/memory.c:6228
 #1: ffff8881412dc698 (&hugetlb_fault_mutex_table[i]){+.+.}-{3:3}, at: hugetlb_fault+0x307/0x2fa0 mm/hugetlb.c:6326
 #2: ffff88802db4ace8 (&resv_map->rw_sema){++++}-{3:3}, at: hugetlb_vma_lock_read mm/hugetlb.c:276 [inline]
 #2: ffff88802db4ace8 (&resv_map->rw_sema){++++}-{3:3}, at: hugetlb_vma_lock_read+0x105/0x140 mm/hugetlb.c:267
2 locks held by syz-executor966/9434:
 #0: ffff88805f660198 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_trylock include/linux/mmap_lock.h:163 [inline]
 #0: ffff88805f660198 (&mm->mmap_lock){++++}-{3:3}, at: get_mmap_lock_carefully mm/memory.c:6099 [inline]
 #0: ffff88805f660198 (&mm->mmap_lock){++++}-{3:3}, at: lock_mm_and_find_vma+0x35/0x6a0 mm/memory.c:6159
 #1: ffff8881412dc698 (&hugetlb_fault_mutex_table[i]){+.+.}-{3:3}, at: hugetlb_fault+0x307/0x2fa0 mm/hugetlb.c:6326
3 locks held by syz-executor966/9437:
 #0: ffff8881456d0420 (sb_writers#10){.+.+}-{0:0}, at: ksys_fallocate fs/open.c:356 [inline]
 #0: ffff8881456d0420 (sb_writers#10){.+.+}-{0:0}, at: __do_sys_fallocate fs/open.c:364 [inline]
 #0: ffff8881456d0420 (sb_writers#10){.+.+}-{0:0}, at: __se_sys_fallocate fs/open.c:362 [inline]
 #0: ffff8881456d0420 (sb_writers#10){.+.+}-{0:0}, at: __x64_sys_fallocate+0xd9/0x150 fs/open.c:362
 #1: ffff888030dd9588 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:815 [inline]
 #1: ffff888030dd9588 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: hugetlbfs_fallocate+0x2b6/0xfc0 fs/hugetlbfs/inode.c:828
 #2: ffff8881412dc698 (&hugetlb_fault_mutex_table[i]){+.+.}-{3:3}, at: hugetlbfs_fallocate+0x577/0xfc0 fs/hugetlbfs/inode.c:872
2 locks held by syz-executor966/9679:
 #0: ffff88807c5a1498 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_trylock include/linux/mmap_lock.h:163 [inline]
 #0: ffff88807c5a1498 (&mm->mmap_lock){++++}-{3:3}, at: get_mmap_lock_carefully mm/memory.c:6099 [inline]
 #0: ffff88807c5a1498 (&mm->mmap_lock){++++}-{3:3}, at: lock_mm_and_find_vma+0x35/0x6a0 mm/memory.c:6159
 #1: ffff8881412dc698 (&hugetlb_fault_mutex_table[i]){+.+.}-{3:3}, at: hugetlb_fault+0x307/0x2fa0 mm/hugetlb.c:6326
3 locks held by syz-executor966/9684:
 #0: ffff8881456d0420 (sb_writers#10){.+.+}-{0:0}, at: ksys_fallocate fs/open.c:356 [inline]
 #0: ffff8881456d0420 (sb_writers#10){.+.+}-{0:0}, at: __do_sys_fallocate fs/open.c:364 [inline]
 #0: ffff8881456d0420 (sb_writers#10){.+.+}-{0:0}, at: __se_sys_fallocate fs/open.c:362 [inline]
 #0: ffff8881456d0420 (sb_writers#10){.+.+}-{0:0}, at: __x64_sys_fallocate+0xd9/0x150 fs/open.c:362
 #1: ffff88807a45da98 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:815 [inline]
 #1: ffff88807a45da98 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: hugetlbfs_fallocate+0x2b6/0xfc0 fs/hugetlbfs/inode.c:828
 #2: ffff8881412dc698 (&hugetlb_fault_mutex_table[i]){+.+.}-{3:3}, at: hugetlbfs_fallocate+0x577/0xfc0 fs/hugetlbfs/inode.c:872
2 locks held by syz-executor966/9733:
 #0: ffff88807b17b118 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock_killable include/linux/mmap_lock.h:153 [inline]
 #0: ffff88807b17b118 (&mm->mmap_lock){++++}-{3:3}, at: get_mmap_lock_carefully mm/memory.c:6108 [inline]
 #0: ffff88807b17b118 (&mm->mmap_lock){++++}-{3:3}, at: lock_mm_and_find_vma+0x3a9/0x6a0 mm/memory.c:6159
 #1: ffff8881412dc698 (&hugetlb_fault_mutex_table[i]){+.+.}-{3:3}, at: hugetlb_fault+0x307/0x2fa0 mm/hugetlb.c:6326
3 locks held by syz-executor966/9735:
 #0: ffff8881456d0420 (sb_writers#10){.+.+}-{0:0}, at: ksys_fallocate fs/open.c:356 [inline]
 #0: ffff8881456d0420 (sb_writers#10){.+.+}-{0:0}, at: __do_sys_fallocate fs/open.c:364 [inline]
 #0: ffff8881456d0420 (sb_writers#10){.+.+}-{0:0}, at: __se_sys_fallocate fs/open.c:362 [inline]
 #0: ffff8881456d0420 (sb_writers#10){.+.+}-{0:0}, at: __x64_sys_fallocate+0xd9/0x150 fs/open.c:362
 #1: ffff88807a45e4b8 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:815 [inline]
 #1: ffff88807a45e4b8 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: hugetlbfs_fallocate+0x2b6/0xfc0 fs/hugetlbfs/inode.c:828
 #2: ffff8881412dc698 (&hugetlb_fault_mutex_table[i]){+.+.}-{3:3}, at: hugetlbfs_fallocate+0x577/0xfc0 fs/hugetlbfs/inode.c:872
2 locks held by syz-executor966/9786:
 #0: ffff88805f768198 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock_killable include/linux/mmap_lock.h:153 [inline]
 #0: ffff88805f768198 (&mm->mmap_lock){++++}-{3:3}, at: get_mmap_lock_carefully mm/memory.c:6108 [inline]
 #0: ffff88805f768198 (&mm->mmap_lock){++++}-{3:3}, at: lock_mm_and_find_vma+0x3a9/0x6a0 mm/memory.c:6159
 #1: ffff8881412dc698 (&hugetlb_fault_mutex_table[i]){+.+.}-{3:3}, at: hugetlb_fault+0x307/0x2fa0 mm/hugetlb.c:6326
3 locks held by syz-executor966/9787:
 #0: ffff8881456d0420 (sb_writers#10){.+.+}-{0:0}, at: ksys_fallocate fs/open.c:356 [inline]
 #0: ffff8881456d0420 (sb_writers#10){.+.+}-{0:0}, at: __do_sys_fallocate fs/open.c:364 [inline]
 #0: ffff8881456d0420 (sb_writers#10){.+.+}-{0:0}, at: __se_sys_fallocate fs/open.c:362 [inline]
 #0: ffff8881456d0420 (sb_writers#10){.+.+}-{0:0}, at: __x64_sys_fallocate+0xd9/0x150 fs/open.c:362
 #1: ffff88807a910148 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:815 [inline]
 #1: ffff88807a910148 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: hugetlbfs_fallocate+0x2b6/0xfc0 fs/hugetlbfs/inode.c:828
 #2: ffff8881412dc698 (&hugetlb_fault_mutex_table[i]){+.+.}-{3:3}, at: hugetlbfs_fallocate+0x577/0xfc0 fs/hugetlbfs/inode.c:872

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.12.0-rc2-syzkaller-00061-gb983b271662b #0
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
CPU: 0 UID: 0 PID: 4662 Comm: klogd Not tainted 6.12.0-rc2-syzkaller-00061-gb983b271662b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:check_kcov_mode kernel/kcov.c:183 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x13/0x70 kernel/kcov.c:217
Code: 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 65 48 8b 15 64 59 76 7e 65 8b 05 65 59 76 7e <a9> 00 01 ff 00 48 8b 34 24 74 1d f6 c4 01 74 43 a9 00 00 0f 00 75
RSP: 0018:ffffc900033efaa0 EFLAGS: 00000293
RAX: 0000000080000000 RBX: 0000000000000000 RCX: ffffffff84430a29
RDX: ffff88807d2f5a00 RSI: ffffffff844309e3 RDI: 0000000000000005
RBP: ffff8880248e98c0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888079859c80
R13: 0000000000000001 R14: ffff8880248e98c0 R15: ffff8880248e98c0
FS:  00007efe5ee35380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005638ed3e1400 CR3: 000000007c050000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 arch_static_branch arch/x86/include/asm/jump_label.h:27 [inline]
 security_sock_rcv_skb+0x5d/0x210 security/security.c:4748
 sk_filter_trim_cap+0xd2/0xac0 net/core/filter.c:151
 sk_filter include/linux/filter.h:1062 [inline]
 unix_dgram_sendmsg+0x66a/0x19e0 net/unix/af_unix.c:2061
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg net/socket.c:744 [inline]
 __sys_sendto+0x479/0x4d0 net/socket.c:2209
 __do_sys_sendto net/socket.c:2221 [inline]
 __se_sys_sendto net/socket.c:2217 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2217
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7efe5ef979b5
Code: 8b 44 24 08 48 83 c4 28 48 98 c3 48 98 c3 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 26 45 31 c9 45 31 c0 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 7a 48 8b 15 44 c4 0c 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffdfcdf97a8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007efe5ef979b5
RDX: 000000000000008b RSI: 000055ec577dbd60 RDI: 0000000000000003
RBP: 000055ec577d52c0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000004000 R11: 0000000000000246 R12: 0000000000000013
R13: 00007efe5f125212 R14: 00007ffdfcdf98a8 R15: 0000000000000000
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.352 msecs


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

