Return-Path: <linux-kernel+bounces-377523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42ECD9ABFFF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2BD2281F70
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 07:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7165D1531C2;
	Wed, 23 Oct 2024 07:18:30 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C07487BE
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 07:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729667910; cv=none; b=LhtFK/1FFke1TNSaGgm8HPl2pMV5yusxR8XnzxY62xYkmkGsdOtS8Og4OPpF5XzTTadNNthHiz3vfS9PNNQr8aH1jBFUwBDjgPCabpIg0aUFDhv334B6HxVuwa/8gEkccvmy6XRLE8U6U437h3jdTWNmHv0Jadov4C0uxJyjnOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729667910; c=relaxed/simple;
	bh=DOGQls+S7qC9YyZ7tKDQK7CuDzJQ1u3JoOdfGLaz2hI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BdiFFuaxo+mav7+Iq+XhVZqZReySc0YqAplrCtd1YUKJG+PEQqpMlloteKXaLPbMY9VYxMpBPr3s+dNTZOyszIX4CHdas/iexBeVcZZWfMPP/U+4dX2PXNr2B3FQLui5ScNU/d89wVRTstHlwd6J5ZzSN0CLRCOyIvBqv+M5MDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3bcae85a5so4818555ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 00:18:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729667907; x=1730272707;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FOW/3sFMA9yDfo0k20sYK1apZv7qHDN0ctLqS85kjbs=;
        b=U9OWq8cNflz37u3hiitDohUROlAwXVDKq2MmZsATvUSU1l4MpefsQ6n5TcYhErR+Z+
         CkkEOlQTUxpwriUau0/yFm2e9JRPm15liyr50I0DG8h3GPPzgzJ9dyv3Lq4bd3W7l0q6
         +WC5IJoldYUmnm8oSQCNDSsHx5QspDsyE8Wfbp/mJBXWgIkZO2FegGagPcvkc8vJ7kWb
         +6jWXewymsmkAF44eOkeFDkW64BRRRPYhiHAI6+l2tp0tuwzHER9u+T9j4grRD7+SWOi
         zmMp233aUrmsowqNoxLg8VvrOzBKiUziH6LnBMZWhRdAnmKawAdzaf5ddU+79Ab0HBH1
         /Ffw==
X-Forwarded-Encrypted: i=1; AJvYcCV9fv9G0oTlVA0VLtGvugPHwfwNaTLAL7zG0TfBJQwcdRRBWRKw7BlWk0IW+XkuqIdbsfKnn1pm47JgsMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YykJU9BXOYB2C+3yL2IzxkD41QwVu7gBTUNKj8vuuh5nt3BI+Gx
	pLFcN9JPQ66a/a+y1v3PxRyCPOIbR9Ru6vkC6CSW82S+ZysrJI6o1SoIN0HiSLSp5o7m2xkSevE
	qgjNmz6mjTsu2PzX1bEn/pVvlOh7MFOeJYoiW0QbqWPwEXTW8GXL0pYw=
X-Google-Smtp-Source: AGHT+IF4mNZgNjBIpn20lQz3RJA0XHCtHehMo1DFwBjlg1wcJxKndCb/+rJWtLNjSs/7todGYvqRR9XXh8TbBcsZdbRK0r0FKMY1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a0d:b0:3a0:9c04:8047 with SMTP id
 e9e14a558f8ab-3a4d592ee08mr12156935ab.6.1729667907577; Wed, 23 Oct 2024
 00:18:27 -0700 (PDT)
Date: Wed, 23 Oct 2024 00:18:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6718a343.050a0220.10f4f4.019d.GAE@google.com>
Subject: [syzbot] [bcachefs?] KASAN: null-ptr-deref Read in bch2_sb_set_upgrade_extra
From: syzbot <syzbot+b468b9fef56949c3b528@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b04ae0f45168 Merge tag 'v6.12-rc3-smb3-client-fixes' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14687487980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfbd94c114a3d407
dashboard link: https://syzkaller.appspot.com/bug?extid=b468b9fef56949c3b528
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14667c5f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11e18430580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-b04ae0f4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3e40a4ec7885/vmlinux-b04ae0f4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9312d8ec05d3/bzImage-b04ae0f4.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/3495c223c477/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b468b9fef56949c3b528@syzkaller.appspotmail.com

bcachefs (loop0): flagging btree freespace lost data
error reading btree root freespace l=0: btree_node_read_error, fixing
==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: null-ptr-deref in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: null-ptr-deref in btree_node_fake fs/bcachefs/btree_types.h:622 [inline]
BUG: KASAN: null-ptr-deref in have_stripes fs/bcachefs/sb-downgrade.c:146 [inline]
BUG: KASAN: null-ptr-deref in bch2_sb_set_upgrade_extra+0x152/0x270 fs/bcachefs/sb-downgrade.c:161
Read of size 8 at addr 00000000000000b0 by task syz-executor407/5095

CPU: 0 UID: 0 PID: 5095 Comm: syz-executor407 Not tainted 6.12.0-rc3-syzkaller-00319-gb04ae0f45168 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_report+0xe8/0x550 mm/kasan/report.c:491
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 btree_node_fake fs/bcachefs/btree_types.h:622 [inline]
 have_stripes fs/bcachefs/sb-downgrade.c:146 [inline]
 bch2_sb_set_upgrade_extra+0x152/0x270 fs/bcachefs/sb-downgrade.c:161
 bch2_fs_recovery+0x25c4/0x39c0 fs/bcachefs/recovery.c:860
 bch2_fs_start+0x356/0x5b0 fs/bcachefs/super.c:1036
 bch2_fs_get_tree+0xd68/0x1710 fs/bcachefs/fs.c:2174
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4055 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4032
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff4b3b479ba
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe3df5ae28 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffe3df5ae40 RCX: 00007ff4b3b479ba
RDX: 00000000200058c0 RSI: 0000000020000000 RDI: 00007ffe3df5ae40
RBP: 0000000000000004 R08: 00007ffe3df5ae80 R09: 0000000000005909
R10: 0000000000010000 R11: 0000000000000282 R12: 0000000000010000
R13: 00007ffe3df5ae80 R14: 0000000000000003 R15: 0000000001000000
 </TASK>
==================================================================


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

