Return-Path: <linux-kernel+bounces-570327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 223A8A6AEEA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 21:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8033B423C10
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5C8227E98;
	Thu, 20 Mar 2025 20:02:41 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9BC2F28
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 20:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742500960; cv=none; b=uEsuYlr+Ygzlhc9CNux+PxgLpRjC8qrSMe2eD+ifxBEHp7JnBN4zK/PZI70omavRDk1mfL2YTY5QW6FqGTOWRblxKUsjtoeUv0TndDEDDwX1ZFDtKwsjyXpIl1oFcJBGbg9vkTX4Lgr4VBnMUEAuJ6ZSbaEruKYA6F+jYJBg7No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742500960; c=relaxed/simple;
	bh=QDHM/qW/ewyrGXiWD/jJ1i7Mvl7H5JMMT/cNGKSf2jY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=suC9smVcy34DFlXeQuhAYj3Ed9q4AKrd4gSBOFtEBOzeVv/5kbCx5dOCORRQhAyogN/SuwB4JGUGLlWNxhBa641gva6JYJkTZEB5s+uC4MelhFU6kyeKYWagFRKd61m1WIxdClBnYX0whZRdmHjNjfcET7R7vA7rJImNRQytXLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d451ad5b2dso24322335ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 13:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742500958; x=1743105758;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Etq5TP2xoNJQvFgoQupyFkxy1Uppzb4mI/ZsT/Ut4k=;
        b=ESJ9ziyQGYtOHpQQsUzEJYTXp80LC0GAEZuIc3SJLc9STT3L6ihMlJrkkXDC+kci4q
         GITrLEVwcrA2/5VHtrZZzdYJSr0zlcRqPHNRebUG3Jkn1kaVXpm2J4unNwzMcYD/Q79g
         +DX4TX1VAbAZwkKxQ4nThONadlCC5BoaVl24XzaQjr0OGTtULGJvBVSeVW1pkJj7AI6E
         3VoNCMWNwdFN1nlS4oPFFzeEa2iQly2Q9K1MwEwCLrF2NYZm7J+D912vjg5hFVjh6grr
         rFdgK0HMg0bzIj69f1zHl6fYdZUWs+pAtmui6kDKa+DQFus4nXkSP1/VWVnIDXsC1HyJ
         8UHw==
X-Forwarded-Encrypted: i=1; AJvYcCXhC8bqXWFmI28N4cFX/Dwd0gMWvViOr0jsff1Tx8bw9BWPvhKAXbMY5kvVDy2IaPLnR8eLTo68dbqc/D4=@vger.kernel.org
X-Gm-Message-State: AOJu0YztqO0B1B4vDMR4Fq6TondUrON378prTvVKUAvC1j80uvSPLUjx
	P5C32Y9/8VfTYWjM6SQN/cK0N2lGSzYvsjwCAqamCpA2/yiKjjIgshEzUF91GJXtl3++wiXYHQQ
	6WCukjz+LDdv7Ns8A44mV9fo8rW4P8De6TAO/FdnP1sEZydbwrJai2UE=
X-Google-Smtp-Source: AGHT+IHLspIAzV44BAI8Ovzlbju+v6rgPBHVMr5AWSt7r4q9isy3D8BlOOJMZf1z0WPYpRsLkFiKSmOnbCnpdkAcgZEogl+xdZIN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12cb:b0:3d3:d344:2a1a with SMTP id
 e9e14a558f8ab-3d595dfea7amr12787455ab.0.1742500958149; Thu, 20 Mar 2025
 13:02:38 -0700 (PDT)
Date: Thu, 20 Mar 2025 13:02:38 -0700
In-Reply-To: <qn7ncujf5gkfmohf5qp3fdakrymhoapkscafqp5t2gulmgdqai@tuhu2igx33k4>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67dc745e.050a0220.25ae54.0023.GAE@google.com>
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in vma_merge_existing_range
From: syzbot <syzbot+20ed41006cf9d842c2b5@syzkaller.appspotmail.com>
To: pfalcato@suse.de
Cc: akpm@linux-foundation.org, jannh@google.com, liam.howlett@oracle.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	pfalcato@suse.de, syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

> On Thu, Mar 20, 2025 at 12:09:36PM -0700, syzbot wrote:
>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    eb88e6bfbc0a Merge tag 'fsnotify_for_v6.14-rc7' of git://g..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=11e6c83f980000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=77423669c2b8fa9
>> dashboard link: https://syzkaller.appspot.com/bug?extid=20ed41006cf9d842c2b5
>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>> userspace arch: i386
>> 
>> Unfortunately, I don't have any reproducer for this issue yet.
>> 
>> Downloadable assets:
>> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-eb88e6bf.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/ded0ce69669f/vmlinux-eb88e6bf.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/6e6fa3c719e7/bzImage-eb88e6bf.xz
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+20ed41006cf9d842c2b5@syzkaller.appspotmail.com
>> 
>> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
>> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>>  </TASK>
>> BUG: unable to handle page fault for address: fffffffffffffff4
>> #PF: supervisor read access in kernel mode
>> #PF: error_code(0x0000) - not-present page
>> PGD df84067 P4D df84067 PUD df86067 PMD 0 
>> Oops: Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
>> CPU: 1 UID: 0 PID: 17805 Comm: syz.8.3237 Not tainted 6.14.0-rc6-syzkaller-00212-geb88e6bfbc0a #0
>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
>> RIP: 0010:vma_merge_existing_range+0x266/0x2070 mm/vma.c:734
>> Code: e8 5f 25 ad ff 48 8b 14 24 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 1c 19 00 00 48 8b 04 24 48 8b 74 24 08 <4c> 8b 38 4c 89 ff e8 9f 1f ad ff 48 8b 44 24 08 49 39 c7 0f 83 db
>> RSP: 0000:ffffc9000319f988 EFLAGS: 00010246
>> RAX: fffffffffffffff4 RBX: ffffc9000319fae8 RCX: ffffffff820cd3e5
>> RDX: 1ffffffffffffffe RSI: 0000000080c2a000 RDI: 0000000000000005
>> RBP: 0000000080ce2000 R08: 0000000000000005 R09: 0000000000000000
>> R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000001
>> R13: ffffc9000319fb08 R14: ffff888025eddc98 R15: ffff88804eec0a00
>> FS:  0000000000000000(0000) GS:ffff88802b500000(0063) knlGS:00000000f5106b40
>> CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
>> CR2: fffffffffffffff4 CR3: 00000000614d6000 CR4: 0000000000352ef0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>  <TASK>
>>  vma_modify.constprop.0+0x87/0x410 mm/vma.c:1517
>>  vma_modify_flags_uffd+0x241/0x2e0 mm/vma.c:1598
>>  userfaultfd_clear_vma+0x91/0x130 mm/userfaultfd.c:1906
>>  userfaultfd_release_all+0x2ae/0x4c0 mm/userfaultfd.c:2024
>>  userfaultfd_release+0xf4/0x1c0 fs/userfaultfd.c:865
>>  __fput+0x3ff/0xb70 fs/file_table.c:464
>>  task_work_run+0x14e/0x250 kernel/task_work.c:227
>>  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>>  exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
>>  exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
>>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>>  syscall_exit_to_user_mode+0x27b/0x2a0 kernel/entry/common.c:218
>>  __do_fast_syscall_32+0x80/0x120 arch/x86/entry/common.c:390
>>  do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:412
>>  entry_SYSENTER_compat_after_hwframe+0x84/0x8e
>> RIP: 0023:0xf7fe6579
>> Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
>> RSP: 002b:00000000f510655c EFLAGS: 00000296 ORIG_RAX: 0000000000000135
>> RAX: 0000000000000001 RBX: 0000000080000180 RCX: 0000000000000001
>> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
>> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>>  </TASK>
>> Modules linked in:
>> CR2: fffffffffffffff4
>> ---[ end trace 0000000000000000 ]---
>> RIP: 0010:vma_merge_existing_range+0x266/0x2070 mm/vma.c:734
>> Code: e8 5f 25 ad ff 48 8b 14 24 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 1c 19 00 00 48 8b 04 24 48 8b 74 24 08 <4c> 8b 38 4c 89 ff e8 9f 1f ad ff 48 8b 44 24 08 49 39 c7 0f 83 db
>> RSP: 0000:ffffc9000319f988 EFLAGS: 00010246
>> RAX: fffffffffffffff4 RBX: ffffc9000319fae8 RCX: ffffffff820cd3e5
>> RDX: 1ffffffffffffffe RSI: 0000000080c2a000 RDI: 0000000000000005
>> RBP: 0000000080ce2000 R08: 0000000000000005 R09: 0000000000000000
>> R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000001
>> R13: ffffc9000319fb08 R14: ffff888025eddc98 R15: ffff88804eec0a00
>> FS:  0000000000000000(0000) GS:ffff88802b500000(0063) knlGS:00000000f5106b40
>> CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
>> CR2: fffffffffffffff4 CR3: 00000000614d6000 CR4: 0000000000352ef0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> ----------------
>> Code disassembly (best guess):
>>    0:	e8 5f 25 ad ff       	call   0xffad2564
>>    5:	48 8b 14 24          	mov    (%rsp),%rdx
>>    9:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
>>   10:	fc ff df
>>   13:	48 c1 ea 03          	shr    $0x3,%rdx
>>   17:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
>>   1b:	0f 85 1c 19 00 00    	jne    0x193d
>>   21:	48 8b 04 24          	mov    (%rsp),%rax
>>   25:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
>> * 2a:	4c 8b 38             	mov    (%rax),%r15 <-- trapping instruction
>>   2d:	4c 89 ff             	mov    %r15,%rdi
>>   30:	e8 9f 1f ad ff       	call   0xffad1fd4
>>   35:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
>>   3a:	49 39 c7             	cmp    %rax,%r15
>>   3d:	0f                   	.byte 0xf
>>   3e:	83                   	.byte 0x83
>>   3f:	db                   	.byte 0xdb
>
> Ahh, fun bug. This *seems* to be the bug:
>
> First, in vma_modify:
>
> 	merged = vma_merge_existing_range(vmg);
> 	if (merged)
> 		return merged;
> 	if (vmg_nomem(vmg))
> 		return ERR_PTR(-ENOMEM);
>
> then, all the way up to userfaultfd_release_all (the return value propagates
> vma_modify -> vma_modify_flags_uffd -> userfaultfd_clear_vma):
>
> 	prev = NULL;
> 	for_each_vma(vmi, vma) {
> 		cond_resched();
> 		BUG_ON(!!vma->vm_userfaultfd_ctx.ctx ^
> 		       !!(vma->vm_flags & __VM_UFFD_FLAGS));
> 		if (vma->vm_userfaultfd_ctx.ctx != ctx) {
> 			prev = vma;
> 			continue;
> 		}
>
> 		vma = userfaultfd_clear_vma(&vmi, prev, vma,
> 					    vma->vm_start, vma->vm_end);
> 		prev = vma;
> 	}
>
> So, if uffd gets an IS_ERR(vma), it keeps going and takes that vma as the prev value,
> which leads to that ERR_PTR(-ENOMEM) deref crash (-12 = -ENOMEM = 0xffffff4).
> This situation is kind of awkward because ->release() errors don't mean a thing.
> So, I have another idea (pasting for syzbot) which might just be cromulent.
> Untested, but thoughts?
>
> #syz test

This crash does not have a reproducer. I cannot test it.

>
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index d06453fa8aba..fb835d82eb84 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -2023,6 +2023,8 @@ void userfaultfd_release_all(struct mm_struct *mm,
>
>                 vma = userfaultfd_clear_vma(&vmi, prev, vma,
>                                             vma->vm_start, vma->vm_end);
> +               if (WARN_ON(IS_ERR(vma)))
> +                       break;
>                 prev = vma;
>         }
>         mmap_write_unlock(mm);
> diff --git a/mm/vma.c b/mm/vma.c
> index 71ca012c616c..b2167b7dc27d 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -1517,8 +1517,16 @@ static struct vm_area_struct *vma_modify(struct vma_merge_struct *vmg)
>         merged = vma_merge_existing_range(vmg);
>         if (merged)
>                 return merged;
> -       if (vmg_nomem(vmg))
> +       if (vmg_nomem(vmg)) {
> +               /* If we can avoid failing the whole modification
> +                * due to a merge OOM and validly keep going
> +                * (we're modifying the whole VMA), return vma intact.
> +                * It won't get merged, but such is life - we're avoiding
> +                * OOM conditions in other parts of mm/ this way */
> +               if (start <= vma->vm_start && end >= vma->vm_end)
> +                       return vma;
>                 return ERR_PTR(-ENOMEM);
> +       }
>
>         /* Split any preceding portion of the VMA. */
>         if (vma->vm_start < start) {
>
> -- 
> Pedro

