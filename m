Return-Path: <linux-kernel+bounces-342248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4C6988C81
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 00:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0046C283618
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 22:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436EC1B29CD;
	Fri, 27 Sep 2024 22:34:30 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E988019E7D8
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 22:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727476469; cv=none; b=eVsIhNBQhnl3ihpMNjp22B72qvI0u5YbqqDsiaVwHHuKO6fP0i+ABELxrJM3cfysDr0W50Fs+keeT0CbSN2sZ+56kc9DXJf8YJRc2Dy9iVbHQhKKYiv8bKbZO7f/EyYvcrnzo/e2xuiFFlVmufavymdLmH18aIm5W3a5T/GXYA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727476469; c=relaxed/simple;
	bh=zmlaBg377cAf34EsASmsZFGRqGPqwGoMst1UzhGEON4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SFe8VLBttGyQy5IK5GeA6tzUkLVc93mkoddyqhzPtqoab6WonRNFK7rOZBzrpH6ElHKTFd06wvoAkt5MTaIe1xAJldKVaVsmrUsgW7ioVJbXEORSRlOZyY7jwuORlUFWlVC7RVxA7fwMPAF6/x5H5sXLz+Rp9ugE40U0MZFmZHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a348ebb940so10062525ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 15:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727476467; x=1728081267;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j2Igy5PW4SyOARBnxB1I5c5ouJJZ4yuGO7/1MRZzBAQ=;
        b=L/+a8sxq8IdABh4i9BNG3CitTm22w+HXyhR1Pf4YViMRIW/w+RoxU+EV1zFuOjAlz5
         Nj9VJB9g/1E5s5J6fQpy34SdbBEIsxcSGP8ZLDipIBwzrHFmgnuBBysCVQ4VfJiHgwXU
         yv4FzA3X7aEm3X6Mu1eWb6HuA6gW02qoEU+il3vM/nPIbbSJyJYbgLwdQ/zECtVBc0/j
         OARhV54a9Qwq9oS6HT5tBUuDCNIYy3Vb72ltUEgWsQQjIvXGAegdUKZKIMmo5M9RoThY
         VLKaYPh3nlWXM6aPsMwq9OiqpnEGQGzTPV/0ywzssJfZ6ph7uYM6nyang/ETO64P1WFh
         o4LA==
X-Forwarded-Encrypted: i=1; AJvYcCV0W6XFQap8xnqSpfpWjFgeRNI7KpREPlg8i8LD5zXAhF/5PelWrw+vEGYr4WAv8rhn3783Q99yZPSmghM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyINT2Wj9bBvUXAD2kSO7jIYxii2yl8+gklgZoVjAVMGDJ89x2c
	cjZVizKHjTbawtonOUz2PJkpWLaRk0bbgNX7DJJ+hzSMe/Ifobqo/4hi1gzvs42SH6nkwcJAU7E
	/sd4ARnvNPL2iloXixgsGmzdQURNfE8madbcZg7qMehxbCbfZBq7WGfo=
X-Google-Smtp-Source: AGHT+IFldvpJlBnOPaHQAO0RiZ1dI4qyH+XQU+9Fypsl9R4IeurawaRA/Yg6uqvob6F2H0ul9KgbWblAOlkgVPxknv0/wPkBhwOy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c83:b0:3a0:8c83:91fb with SMTP id
 e9e14a558f8ab-3a3451bc001mr41939635ab.20.1727476467059; Fri, 27 Sep 2024
 15:34:27 -0700 (PDT)
Date: Fri, 27 Sep 2024 15:34:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f732f3.050a0220.46d20.0029.GAE@google.com>
Subject: [syzbot] [mm?] [ntfs3?] kernel panic: stack is corrupted in _raw_spin_unlock_irqrestore
From: syzbot <syzbot+7614fef79a88d3c02bf2@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, almaz.alexandrovich@paragon-software.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e477dba5442c Merge tag 'for-6.12/dm-changes' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14a8fa80580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b2d4fdf18a83ec0b
dashboard link: https://syzkaller.appspot.com/bug?extid=7614fef79a88d3c02bf2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101386a9980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-e477dba5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3bf119f19bb7/vmlinux-e477dba5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2de4db7684f9/bzImage-e477dba5.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/184157d9745b/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7614fef79a88d3c02bf2@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 256
exFAT-fs (loop0): failed to load upcase table (idx : 0x000104d0, chksum : 0x60d18cac, utbl_chksum : 0xe619d30d)
Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: _raw_spin_unlock_irqrestore+0x137/0x140
CPU: 0 UID: 0 PID: 7456 Comm: syz.0.1047 Not tainted 6.11.0-syzkaller-11624-ge477dba5442c #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 panic+0x349/0x880 kernel/panic.c:354
 __stack_chk_fail+0x15/0x20 kernel/panic.c:836
 _raw_spin_unlock_irqrestore+0x137/0x140
 debug_object_activate+0x3e4/0x510 lib/debugobjects.c:726
 debug_rcu_head_queue kernel/rcu/rcu.h:224 [inline]
 __call_rcu_common kernel/rcu/tree.c:3071 [inline]
 call_rcu+0x97/0xa70 kernel/rcu/tree.c:3190
 slab_free_hook mm/slub.c:2307 [inline]
 slab_free mm/slub.c:4580 [inline]
 kmem_cache_free+0x2fc/0x420 mm/slub.c:4682
 anon_vma_free mm/rmap.c:138 [inline]
 __put_anon_vma+0x128/0x2d0 mm/rmap.c:2560
 put_anon_vma include/linux/rmap.h:116 [inline]
 unlink_anon_vmas+0x492/0x5f0 mm/rmap.c:445
 free_pgtables+0x567/0x840 mm/memory.c:409
 exit_mmap+0x48e/0xc40 mm/mmap.c:1875
 __mmput+0x115/0x390 kernel/fork.c:1347
 exit_mm+0x220/0x310 kernel/exit.c:571
 do_exit+0x9b2/0x28e0 kernel/exit.c:926
 do_group_exit+0x207/0x2c0 kernel/exit.c:1088
 get_signal+0x16a3/0x1740 kernel/signal.c:2917
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fed97b7df39
Code: Unable to access opcode bytes at 0x7fed97b7df0f.
RSP: 002b:00007fed975ff0e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: 0000000000000001 RBX: 00007fed97d35f88 RCX: 00007fed97b7df39
RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00007fed97d35f8c
RBP: 00007fed97d35f80 R08: 7fffffffffffffff R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fed97d35f8c
R13: 0000000000000000 R14: 00007fff93524ba0 R15: 00007fff93524c88
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

