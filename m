Return-Path: <linux-kernel+bounces-325975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D37179760A1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D9061C22C06
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 05:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEDB188927;
	Thu, 12 Sep 2024 05:55:25 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF67918734F
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 05:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726120525; cv=none; b=r3lmmqu60mn4xzUuVIdykZYbhgYXerBBrYjp9xT/PoO5NsMwO3es/wT+xzzwHNFQsMJn6PvjRDP6fBJOa7zGVR//rWxj4CMc3FNekP3lY2MptHJeY5WFA9JUM4j7F3GHIPVYUBRHaOgHWqIBFe+lUkDpNMrHtRgnFR12PEsd0CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726120525; c=relaxed/simple;
	bh=PApkvqJXVEUNrwVkteCTy1JePFsPgV32jO/HlEaSDJ4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VsXrjxCnLbhAH5n4AsuzGD9DB5JL7poNJH/9oOV2VbqAFbftOo1RcRFdzR2GX5x0py/FOJLU97O8Li2jfmWSyZ1uUscHho6PjklVpmOvTNiCwV1cI9jNjPmPMEDSEJMqI3B+5TdIVgw9m3Qp3jTlZWrxBKhlRqEqgYk8eW/87bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d28a70743so8266485ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 22:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726120523; x=1726725323;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zefzmfyJk8t8yJT5t/jigSUzYtXEsJyalJWIcKH+4Uo=;
        b=u5l0VwP8eue87VOd6vyh+s3sGU2pebjs1MNcAqifsmGGPY7x/jVDhBBfgUDZpTfTTL
         2829rWN3Fko6xA4P73aMv/Yb8lkhY3iL4O6URq/3NsTGMixVur8uXtedoJEe+jKAYdnW
         +4G6FTcqrUHzvUOk3squ9wXIcOkgh++rA+9SBPqiYI9mJXpcNtUiLWh21Fl1g0Gtje/E
         40Gs/MOmlPLW97X4F08gm42teVmoZ6z/oCQfM1tNxIfB6O0f3lJUtIacCdo6H66hMhq2
         zV2kMRJLTTqj7sjbvwJSkt2BGpFcHpsxzMUxBnpdUgkLLhg+vnR+IspQyuv3GlheddpQ
         YaSA==
X-Forwarded-Encrypted: i=1; AJvYcCVzW1Q6fxZMEDk7LZ63z2Ae8A/nCsUDtBThVNtMna3f71sMlIutCqx01mw5H/KvMNiPKpX+aIvL7MLEPYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT5MDb5VWZUoVNAJX37JA7dZB/qW4/s6HnNDvjoHoX3XhxieqO
	OEc/Xo/iDwxzkkOrz7jteMkt3qphXm5RxzTI3rf3/qO4fb4sOH0XPnjaFqgCi5wU5FPvMbSxzWm
	pNEkIcVFRXhokifJaTxxMRLeKLjSML8FC82yldBF1LepRfvlB1CoHjSE=
X-Google-Smtp-Source: AGHT+IHKPoAnfLthhAIuluDrpEV1nrIA2EDTF3BxQ6SRlol9/JoP6cWnQbOeqYC4Rwce5LCyoGQWlLmNbAZKujsUG1oqxhYdp9l4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c5:b0:39f:325f:78e6 with SMTP id
 e9e14a558f8ab-3a0845a0d55mr13801545ab.0.1726120522992; Wed, 11 Sep 2024
 22:55:22 -0700 (PDT)
Date: Wed, 11 Sep 2024 22:55:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009ce1970621e5c01f@google.com>
Subject: [syzbot] [ntfs3?] kernel panic: stack is corrupted in do_raw_spin_lock
From: syzbot <syzbot+3659c2af3c190d9e5548@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d1f2d51b711a Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15b32797980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc7fa3453562e8b
dashboard link: https://syzkaller.appspot.com/bug?extid=3659c2af3c190d9e5548
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13b32797980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9e90e1655cd2/disk-d1f2d51b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4e83e072c038/vmlinux-d1f2d51b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f9da7a0ffce5/bzImage-d1f2d51b.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b141e72fbe37/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3659c2af3c190d9e5548@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 4096
Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: do_raw_spin_lock+0x36c/0x370
CPU: 0 UID: 0 PID: 6983 Comm: syz.0.762 Not tainted 6.11.0-rc6-syzkaller-00326-gd1f2d51b711a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 panic+0x349/0x860 kernel/panic.c:354
 __stack_chk_fail+0x15/0x20 kernel/panic.c:827
 do_raw_spin_lock+0x36c/0x370
 spin_lock include/linux/spinlock.h:351 [inline]
 inode_wait_for_writeback+0x8d/0x290 fs/fs-writeback.c:1529
 evict+0x502/0x950 fs/inode.c:701
 ntfs_fill_super+0x3e27/0x4730 fs/ntfs3/super.c:1467
 get_tree_bdev+0x3f7/0x570 fs/super.c:1635
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3472
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa489b7e69a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa48a8b5e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fa48a8b5ef0 RCX: 00007fa489b7e69a
RDX: 0000000020000080 RSI: 000000002001f740 RDI: 00007fa48a8b5eb0
RBP: 0000000020000080 R08: 00007fa48a8b5ef0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000002001f740
R13: 00007fa48a8b5eb0 R14: 000000000001f70e R15: 00000000200000c0
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

