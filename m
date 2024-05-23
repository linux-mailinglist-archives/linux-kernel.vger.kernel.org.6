Return-Path: <linux-kernel+bounces-187613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B23188CD538
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 16:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D45551C21210
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF9B14B082;
	Thu, 23 May 2024 14:00:33 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA128003B
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 14:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716472832; cv=none; b=ZJxpQKiYSfGjbNRz9nc5Tpzf6F40mUc7LFeHAp9tdXpHtU4eKwtLyx9ByKYPMFQpEpP693Dmq4y3FkTnciTOF5jb91ZGcBn+JbuxXl+GvWcvWk5LibkzihPsjKadqaZJro15qUlNkVJLQDIdQNLASxWW6xVld56wa1TIkk6crpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716472832; c=relaxed/simple;
	bh=BG8dcEqjCOH1wPVaoDDDEw0Thu7qgrQNjsK9m9GavRg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VdNXNqX9e9F7R/fb9f9Q6jjj8b+d3n2N9fU3tZQwAb4KxzXuaQsakGnxLSOQrfzGIgTSQX3eq8lmLxoBvWcWjTM9x1nCZei+YzUeLmtQFYp/6TZLqz0nJw/FpDr2krhnDuN1TnyHOS1TvFp8Eo1/u2l7QrqdHQ0A6TFrBgwFJsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3705289d46fso20906455ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 07:00:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716472830; x=1717077630;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1PV08r8V8Buh7Jdk/bR/0HObqzvCrdeM/X52mKZH49k=;
        b=LiUT8lcJV8Tm+QS9nNA0H9ghx53bOekW9S2j2XgKhp43wNhDz40SBpVSAg3CDsud39
         17Y/ZlUWuWPWJbnbdkL2rNkC1v0JQFuS1Zc5VKchAUvM9brf673TuuT/np4jS8oVbbF5
         pr7RpQ8ODVhgE9EpZ0Ou/h8moOV2wus6hwwaWWSykOwlN6NMx18KenyGfqOomBuQfO7h
         L3EzVdc0M418DHeNVeGnI4RWRVvJe6DoUQfi4WMdlGD5Xuf16UNXWFo55U6uXaqqzksv
         Qdt46iVAp6hW9O6aG9VMMXtnXn2WP0goJijdqVsJFN00ZwR7yjvuTy+igQGPfroduf1q
         Bfwg==
X-Forwarded-Encrypted: i=1; AJvYcCUs88GnOnx38JpY9iCmQ29aOgzR+PTpu2d0MtccOmyoathoL1JvTrjVIB5i6pzdyb7FwpAVHgVQ3OMk0kmuy8+8OIQMbuZgZcvFM3W4
X-Gm-Message-State: AOJu0Yxm/6/X3TpNeDoyxDRD1ZHeRLgAqQQPzrcJbCkHBazrhiIAthh4
	yxKUkozxbcJizTCVurNahAJAtFPHOMJvfeg41tFl+1OW8hLmQvs0n1Krrl5E+k/7aLw8YIBmQM7
	zBHDrarDaFXgXPejSl1Ffxv/STEk2brfbScQ+fA8Nrkt0EhKpXOGTJrk=
X-Google-Smtp-Source: AGHT+IHwvzteIYubhFuL8M4JdYnnDQpvMvokBzsR0jSgITEDyYZCs3KKE8Lo07ZMNPV87tTuf+UhjQCccWCuBdv4fM8KLv/owNjF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2188:b0:36d:cccb:6842 with SMTP id
 e9e14a558f8ab-371f3e40d12mr4376725ab.0.1716472825895; Thu, 23 May 2024
 07:00:25 -0700 (PDT)
Date: Thu, 23 May 2024 07:00:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000de83f06191f79ad@google.com>
Subject: [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in bch2_btree_node_read_done
From: syzbot <syzbot+e6332ce6aa831184a0eb@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b6394d6f7159 Merge tag 'pull-misc' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17cd3df4980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=713476114e57eef3
dashboard link: https://syzkaller.appspot.com/bug?extid=e6332ce6aa831184a0eb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8e1377d4772/disk-b6394d6f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/19fbbb3b6dd5/vmlinux-b6394d6f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4dcce16af95d/bzImage-b6394d6f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e6332ce6aa831184a0eb@syzkaller.appspotmail.com

bcachefs (loop2): mounting version 1.7: mi_btree_bitmap opts=metadata_checksum=none,data_checksum=none,nojournal_transaction_names
bcachefs (loop2): recovering from clean shutdown, journal seq 8
------------[ cut here ]------------
UBSAN: shift-out-of-bounds in fs/bcachefs/btree_types.h:770:13
shift exponent 128 is too large for 32-bit type 'unsigned int'
CPU: 1 PID: 18326 Comm: syz-executor.2 Not tainted 6.9.0-syzkaller-10729-gb6394d6f7159 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_shift_out_of_bounds+0x3c8/0x420 lib/ubsan.c:468
 btree_node_type_is_extents fs/bcachefs/btree_types.h:770 [inline]
 bch2_btree_node_read_done+0x35bf/0x6770 fs/bcachefs/btree_io.c:1088
 btree_node_read_work+0x68b/0x1260 fs/bcachefs/btree_io.c:1340
 bch2_btree_node_read+0x2467/0x2a40
 __bch2_btree_root_read fs/bcachefs/btree_io.c:1764 [inline]
 bch2_btree_root_read+0x61e/0x970 fs/bcachefs/btree_io.c:1788
 read_btree_roots+0x22d/0x7b0 fs/bcachefs/recovery.c:472
 bch2_fs_recovery+0x2346/0x3700 fs/bcachefs/recovery.c:800
 bch2_fs_start+0x356/0x5b0 fs/bcachefs/super.c:1031
 bch2_fs_open+0xa8d/0xdf0 fs/bcachefs/super.c:2123
 bch2_mount+0x71d/0x1320 fs/bcachefs/fs.c:1917
 legacy_get_tree+0xee/0x190 fs/fs_context.c:662
 vfs_get_tree+0x90/0x2a0 fs/super.c:1780
 do_new_mount+0x2be/0xb40 fs/namespace.c:3352
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f76c307e5ea
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 09 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f76c2bbcef8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f76c2bbcf80 RCX: 00007f76c307e5ea
RDX: 0000000020000040 RSI: 00000000200001c0 RDI: 00007f76c2bbcf40
RBP: 0000000020000040 R08: 00007f76c2bbcf80 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00000000200001c0
R13: 00007f76c2bbcf40 R14: 0000000000005b22 R15: 0000000020000240
 </TASK>
---[ end trace ]---


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

