Return-Path: <linux-kernel+bounces-346537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A63E98C5A6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 899A2B23663
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F88A1CCEE6;
	Tue,  1 Oct 2024 18:46:32 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E0A1CCEE2
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 18:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727808391; cv=none; b=q39zqT4wIanBIMwqoi3umt2mbdr/2DUQEbSMiWqRJR9utwuNm9+gM8RwiV6+grgB4PGXqz+U1v+ASFt2KTSb/HXz6LcEEcjT8h8T6gh6KrtOzIsi4NfAPaURBWrDHIOKYjsd9HziHcDE0ObqSQdWYWC/0myOdQST48eZCLqzaQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727808391; c=relaxed/simple;
	bh=llEEAj0jafNIRXgo3fdFHSr69rSi6b1kfxLrgcDWu24=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kAaAr3Tbk30SFLEtUM2y6tz4zwm1roy21cBOLN8PpSANiFaMcoS2+PmYzybh3VY7VpKl3ZJu7ip9eeCmjYV+WpnmsgLnLtEzLd4E80Y3P9hRwr0I3weYcwS8q4+ABPrVzkCPtLdCYrb60nc0HzNzNYVCN/llbp/r6VumaYDXrk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a0cadb1536so68720285ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 11:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727808389; x=1728413189;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KimbdV0V63fE92YL58ZdrcLPlziF4S/f4fHyqIEi1r0=;
        b=IKQfEUuAMwhfbpV+JSMBbmRHEX1DA9uXw/3y981BcbPwz2GqegM4Rrl1Jwf7fi6Nh3
         g2affnGGEintz96cK4dJWLdEj61vdrISu2fLXyjLwVVbIEKQLyQK+gRzeSLclVdnJ+jX
         ocKCw4CmHd7f8lmG+SgixOX5M27z7CjB0bCJE5meU5v/sW1S7iwHKdQSGusxmYzqVdpz
         t10WxWcZ02Bo1+9rkAX2ZPYWy+Afin14cdy6VMxOkSbB+7p+tj/rsQ/anWft4TANmmGW
         aJJmB3fMjREi6Qq6ku18G04aVJTv8ltrv9t/X4blcGA9dM4rVzUCCgnn0TmemLdWXIEo
         u9wA==
X-Forwarded-Encrypted: i=1; AJvYcCVehl04RmzUMvs/vbxWbuQxW40WHaPvG5SKm52bpZ9vSs4NZ4hspuv0g3MILCosYhd+92vjxXZHX5aDVH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA3gW140Stsqy/SXAx94GQwoFeM6LQnVwY75xnNjFP85n9HWpX
	y058pMqIpee4h7iNfWiYNNE2PVeSq4mYVNGiAK1Fj5MDYjtWtIpUoyQBXmZ3oniLfcgt8wnf6Zy
	IEWeYJNJPcUeuOmHLiW3RFO/vVJfyx0fnt7JSMtdGAoKEquH/IvbptPI=
X-Google-Smtp-Source: AGHT+IH0P34juvH8drhmGEztgsks5iBCUBezKbLrcFNWFEN4eqohSQu69EIHmZ8BGqkkHebOsHREYriGG3FvMhWB9xCwN+cdPagJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a63:b0:3a0:c88c:e674 with SMTP id
 e9e14a558f8ab-3a3659133e4mr6146805ab.1.1727808389240; Tue, 01 Oct 2024
 11:46:29 -0700 (PDT)
Date: Tue, 01 Oct 2024 11:46:29 -0700
In-Reply-To: <66f8846e.050a0220.aab67.000b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fc4385.050a0220.f28ec.04c4.GAE@google.com>
Subject: Re: [syzbot] [mm?] possible deadlock in upgrade_mmap_lock_carefully
From: syzbot <syzbot+a6456f6334aa19425886@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, hughd@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    e32cde8d2bd7 Merge tag 'sched_ext-for-6.12-rc1-fixes-1' of..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14ed139f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=286b31f2cf1c36b5
dashboard link: https://syzkaller.appspot.com/bug?extid=a6456f6334aa19425886
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=154e8927980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1244bdd0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f7f2dc1bf47b/disk-e32cde8d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/063e4eafb554/vmlinux-e32cde8d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7ce38bae7b74/bzImage-e32cde8d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a6456f6334aa19425886@syzkaller.appspotmail.com

mmap: syz-executor813 (5232) uses deprecated remap_file_pages() syscall. See Documentation/mm/remap_file_pages.rst.
======================================================
WARNING: possible circular locking dependency detected
6.12.0-rc1-syzkaller-00031-ge32cde8d2bd7 #0 Not tainted
------------------------------------------------------
syz-executor813/5232 is trying to acquire lock:
ffff88807bfa0198 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:122 [inline]
ffff88807bfa0198 (&mm->mmap_lock){++++}-{3:3}, at: upgrade_mmap_lock_carefully+0xb6/0x160 mm/memory.c:6132

but task is already holding lock:
ffff888022786b48 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:815 [inline]
ffff888022786b48 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, at: shmem_file_write_iter+0x80/0x120 mm/shmem.c:3211

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       down_write+0x99/0x220 kernel/locking/rwsem.c:1577
       inode_lock include/linux/fs.h:815 [inline]
       process_measurement+0x439/0x1fb0 security/integrity/ima/ima_main.c:250
       ima_file_mmap+0x13d/0x2b0 security/integrity/ima/ima_main.c:455
       security_mmap_file+0x7e7/0xa40 security/security.c:2977
       __do_sys_remap_file_pages mm/mmap.c:1692 [inline]
       __se_sys_remap_file_pages+0x6e6/0xa50 mm/mmap.c:1624
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&mm->mmap_lock){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       down_write_killable+0xab/0x260 kernel/locking/rwsem.c:1588
       mmap_write_lock_killable include/linux/mmap_lock.h:122 [inline]
       upgrade_mmap_lock_carefully+0xb6/0x160 mm/memory.c:6132
       lock_mm_and_find_vma+0x107/0x2f0 mm/memory.c:6185
       do_user_addr_fault arch/x86/mm/fault.c:1361 [inline]
       handle_page_fault arch/x86/mm/fault.c:1481 [inline]
       exc_page_fault+0x1bf/0x8c0 arch/x86/mm/fault.c:1539
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
       fault_in_readable+0x165/0x2b0
       fault_in_iov_iter_readable+0x229/0x280 lib/iov_iter.c:94
       generic_perform_write+0x259/0x6d0 mm/filemap.c:4044
       shmem_file_write_iter+0xf9/0x120 mm/shmem.c:3221
       new_sync_write fs/read_write.c:590 [inline]
       vfs_write+0xa6d/0xc90 fs/read_write.c:683
       ksys_write+0x183/0x2b0 fs/read_write.c:736
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sb->s_type->i_mutex_key#12);
                               lock(&mm->mmap_lock);
                               lock(&sb->s_type->i_mutex_key#12);
  lock(&mm->mmap_lock);

 *** DEADLOCK ***

2 locks held by syz-executor813/5232:
 #0: ffff88807b202420 (sb_writers#5){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2931 [inline]
 #0: ffff88807b202420 (sb_writers#5){.+.+}-{0:0}, at: vfs_write+0x224/0xc90 fs/read_write.c:679
 #1: ffff888022786b48 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:815 [inline]
 #1: ffff888022786b48 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, at: shmem_file_write_iter+0x80/0x120 mm/shmem.c:3211

stack backtrace:
CPU: 0 UID: 0 PID: 5232 Comm: syz-executor813 Not tainted 6.12.0-rc1-syzkaller-00031-ge32cde8d2bd7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
 __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 down_write_killable+0xab/0x260 kernel/locking/rwsem.c:1588
 mmap_write_lock_killable include/linux/mmap_lock.h:122 [inline]
 upgrade_mmap_lock_carefully+0xb6/0x160 mm/memory.c:6132
 lock_mm_and_find_vma+0x107/0x2f0 mm/memory.c:6185
 do_user_addr_fault arch/x86/mm/fault.c:1361 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x1bf/0x8c0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:fault_in_readable+0x165/0x2b0 mm/gup.c:2235
Code: b3 ff 4c 8d b3 ff 0f 00 00 48 89 d8 4d 01 e6 49 81 e6 00 f0 ff ff 49 39 c6 72 6b e8 65 ca b3 ff 4c 39 f3 74 6e 4c 89 64 24 10 <44> 8a 23 43 0f b6 04 2f 84 c0 75 18 44 88 64 24 40 48 81 c3 00 10
RSP: 0018:ffffc90003c3fa40 EFLAGS: 00050287
RAX: ffffffff81e1114b RBX: 0000000020001000 RCX: ffff88801cf78000
RDX: 0000000000000000 RSI: 0000000000000100 RDI: 0000000000000000
RBP: ffffc90003c3faf8 R08: ffffffff81e110e8 R09: ffffffff84b94759
R10: 0000000000000002 R11: ffff88801cf78000 R12: 000000000000fecc
R13: dffffc0000000000 R14: 0000000020010000 R15: 1ffff92000787f50
 fault_in_iov_iter_readable+0x229/0x280 lib/iov_iter.c:94
 generic_perform_write+0x259/0x6d0 mm/filemap.c:4044
 shmem_file_write_iter+0xf9/0x120 mm/shmem.c:3221
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xa6d/0xc90 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f355e2f2a19
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdd6291a88 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f355e33c11f RCX: 00007f355e2f2a19
RDX: 000000000000fecc RSI: 0000000020000100 RDI: 0000000000000003
RBP: 00007f355e33c0fd R08: 0000000000000000 R09: 0000000000000000
R10: 0000000020005000 R11: 0000000000000246 R12: 00007f355e34113c
R13: 00007f355e33c082 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
----------------
Code disassembly (best guess):
   0:	b3 ff                	mov    $0xff,%bl
   2:	4c 8d b3 ff 0f 00 00 	lea    0xfff(%rbx),%r14
   9:	48 89 d8             	mov    %rbx,%rax
   c:	4d 01 e6             	add    %r12,%r14
   f:	49 81 e6 00 f0 ff ff 	and    $0xfffffffffffff000,%r14
  16:	49 39 c6             	cmp    %rax,%r14
  19:	72 6b                	jb     0x86
  1b:	e8 65 ca b3 ff       	call   0xffb3ca85
  20:	4c 39 f3             	cmp    %r14,%rbx
  23:	74 6e                	je     0x93
  25:	4c 89 64 24 10       	mov    %r12,0x10(%rsp)
* 2a:	44 8a 23             	mov    (%rbx),%r12b <-- trapping instruction
  2d:	43 0f b6 04 2f       	movzbl (%r15,%r13,1),%eax
  32:	84 c0                	test   %al,%al
  34:	75 18                	jne    0x4e
  36:	44 88 64 24 40       	mov    %r12b,0x40(%rsp)
  3b:	48                   	rex.W
  3c:	81                   	.byte 0x81
  3d:	c3                   	ret
  3e:	00 10                	add    %dl,(%rax)


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

