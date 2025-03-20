Return-Path: <linux-kernel+bounces-570286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F22A6AE5A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BE1F1894FF1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A06B227EA3;
	Thu, 20 Mar 2025 19:09:39 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF12B1E3DDB
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 19:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742497778; cv=none; b=POoX65WBu3nPgkXvSp7vzLbH9jOeGEpMbUokpOeCjWPEDd70zwuijL5+VOMsSpFJlTkpByp6GSvWZgdo4pwvBFmp6iUzzXBkuf1rq9reWsYm4AGgkIYIL780I05VmIU3zImnX0sFiBLB2VTe62S4d9SsiPrxkUwiJs++FiQlFx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742497778; c=relaxed/simple;
	bh=IqK30dSg0VXcE8Hxcmvi+ASodPwc59V7GZz1jXxeDdQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OrHC4KHJLb5QgJc2tsyAcTIGd+LKjXqMYtz5Tt3au1eRr3x5QbrV5lBiUMoKGUPOGfDPmWjytRThnRbm4baOiQgv2uB3ooL7X/1j5wA9d/GbgQK1xC8+b1SlaLBAH3CoHlDa3E9VYVkMS7KB+WiNk8bLlprv/UTH8yLStCwUzNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-85b53875729so245021639f.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 12:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742497776; x=1743102576;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pbu2gMOs/U0oLHAsDX8wLz3Z53T/x8PaRosDpy4/fbw=;
        b=SlpBU13H4zb2THBOSyvWxYj4+6fO0NTMuULNkwLHrHjjG6R1RG9bqmZfdn5zB1PfBX
         EL5ny6inNkTgxdRsXIU3a2cCAQQPZfXZRNfxtYjIvCPiBamDUyHPzrRPgr+pmr43DKB3
         tbRdGWzuGwgWn0/+mEkHjCRjERwO43UdRvIKJUDK+F3ln6nqwlLeEABDfdId+I032zEL
         dyk1CA03v78iMh0e+ppmSyAfY/I2hJi09xc2e98h6eJDtoSTKiiTzDdav5lfQMDw0iwy
         6L4HxkP5OB4RIA4uICxKWzwXkEYJLQ6hzEvWZtG/JhdD7RCEtUfyBar4mmWVrLgJ5nku
         9pZA==
X-Forwarded-Encrypted: i=1; AJvYcCXWNtMx4TFV5LKjjwpidIubxmrfLuKQeL9QY07Md4k+pbgNUPa2CjZliGoA+RGxp8f7MtHE5xbv9h7UJKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYSluPcHdigZDRU3HWP+p0T9FgF+YBWlys5WXxabtPcVk4GIFX
	bYwgYEdksCCUKqXqaItGhROOEc7wxCd+QjrXoeTfqKMO2nGXOfEiC3jUUm2YHBLipKE6fVRZc1C
	1D8iH/KB6YmD4c434CspRD2CiCn78kNeDNyotL+v+gHlPX4IsKDmqmKU=
X-Google-Smtp-Source: AGHT+IGH76oVaYImak1yulyKzTW1M6dX+LZo9EfJLdjGWwIfgc25EP+Qp7ndSxK/TrVUssGaX4893mqnNfvuhWp3ZBvBKu2t3FMe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c263:0:b0:3cf:c773:6992 with SMTP id
 e9e14a558f8ab-3d59611acdbmr7769445ab.12.1742497776031; Thu, 20 Mar 2025
 12:09:36 -0700 (PDT)
Date: Thu, 20 Mar 2025 12:09:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67dc67f0.050a0220.25ae54.001e.GAE@google.com>
Subject: [syzbot] [mm?] BUG: unable to handle kernel paging request in vma_merge_existing_range
From: syzbot <syzbot+20ed41006cf9d842c2b5@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, jannh@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    eb88e6bfbc0a Merge tag 'fsnotify_for_v6.14-rc7' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11e6c83f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=77423669c2b8fa9
dashboard link: https://syzkaller.appspot.com/bug?extid=20ed41006cf9d842c2b5
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-eb88e6bf.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ded0ce69669f/vmlinux-eb88e6bf.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6e6fa3c719e7/bzImage-eb88e6bf.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+20ed41006cf9d842c2b5@syzkaller.appspotmail.com

RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
BUG: unable to handle page fault for address: fffffffffffffff4
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD df84067 P4D df84067 PUD df86067 PMD 0 
Oops: Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 1 UID: 0 PID: 17805 Comm: syz.8.3237 Not tainted 6.14.0-rc6-syzkaller-00212-geb88e6bfbc0a #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:vma_merge_existing_range+0x266/0x2070 mm/vma.c:734
Code: e8 5f 25 ad ff 48 8b 14 24 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 1c 19 00 00 48 8b 04 24 48 8b 74 24 08 <4c> 8b 38 4c 89 ff e8 9f 1f ad ff 48 8b 44 24 08 49 39 c7 0f 83 db
RSP: 0000:ffffc9000319f988 EFLAGS: 00010246
RAX: fffffffffffffff4 RBX: ffffc9000319fae8 RCX: ffffffff820cd3e5
RDX: 1ffffffffffffffe RSI: 0000000080c2a000 RDI: 0000000000000005
RBP: 0000000080ce2000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000001
R13: ffffc9000319fb08 R14: ffff888025eddc98 R15: ffff88804eec0a00
FS:  0000000000000000(0000) GS:ffff88802b500000(0063) knlGS:00000000f5106b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: fffffffffffffff4 CR3: 00000000614d6000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 vma_modify.constprop.0+0x87/0x410 mm/vma.c:1517
 vma_modify_flags_uffd+0x241/0x2e0 mm/vma.c:1598
 userfaultfd_clear_vma+0x91/0x130 mm/userfaultfd.c:1906
 userfaultfd_release_all+0x2ae/0x4c0 mm/userfaultfd.c:2024
 userfaultfd_release+0xf4/0x1c0 fs/userfaultfd.c:865
 __fput+0x3ff/0xb70 fs/file_table.c:464
 task_work_run+0x14e/0x250 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x27b/0x2a0 kernel/entry/common.c:218
 __do_fast_syscall_32+0x80/0x120 arch/x86/entry/common.c:390
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:412
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7fe6579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f510655c EFLAGS: 00000296 ORIG_RAX: 0000000000000135
RAX: 0000000000000001 RBX: 0000000080000180 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
CR2: fffffffffffffff4
---[ end trace 0000000000000000 ]---
RIP: 0010:vma_merge_existing_range+0x266/0x2070 mm/vma.c:734
Code: e8 5f 25 ad ff 48 8b 14 24 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 1c 19 00 00 48 8b 04 24 48 8b 74 24 08 <4c> 8b 38 4c 89 ff e8 9f 1f ad ff 48 8b 44 24 08 49 39 c7 0f 83 db
RSP: 0000:ffffc9000319f988 EFLAGS: 00010246
RAX: fffffffffffffff4 RBX: ffffc9000319fae8 RCX: ffffffff820cd3e5
RDX: 1ffffffffffffffe RSI: 0000000080c2a000 RDI: 0000000000000005
RBP: 0000000080ce2000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000001
R13: ffffc9000319fb08 R14: ffff888025eddc98 R15: ffff88804eec0a00
FS:  0000000000000000(0000) GS:ffff88802b500000(0063) knlGS:00000000f5106b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: fffffffffffffff4 CR3: 00000000614d6000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	e8 5f 25 ad ff       	call   0xffad2564
   5:	48 8b 14 24          	mov    (%rsp),%rdx
   9:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  10:	fc ff df
  13:	48 c1 ea 03          	shr    $0x3,%rdx
  17:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
  1b:	0f 85 1c 19 00 00    	jne    0x193d
  21:	48 8b 04 24          	mov    (%rsp),%rax
  25:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
* 2a:	4c 8b 38             	mov    (%rax),%r15 <-- trapping instruction
  2d:	4c 89 ff             	mov    %r15,%rdi
  30:	e8 9f 1f ad ff       	call   0xffad1fd4
  35:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
  3a:	49 39 c7             	cmp    %rax,%r15
  3d:	0f                   	.byte 0xf
  3e:	83                   	.byte 0x83
  3f:	db                   	.byte 0xdb


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

