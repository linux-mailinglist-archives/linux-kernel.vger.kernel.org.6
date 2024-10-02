Return-Path: <linux-kernel+bounces-346952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7905C98CB61
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 05:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12D8F2852D0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 03:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D688EDF78;
	Wed,  2 Oct 2024 03:03:23 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFE02F24
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 03:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727838203; cv=none; b=fJ117bcmsev9h7jlzUl1vwzNAVwfIjBTtqXjlKT9jZL1r4XdDJlEEOExrli1pTErhgppFPc+1r1WecKQSdg3pdSww9wY2ekGVwAsXdh61DZds8a7WSWekK5CYhyOjZLVv3qw0MkM6z1Yv4PbSCt0bTD06E/ha+6wsTk+8eQWnmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727838203; c=relaxed/simple;
	bh=vlporeU2yp1L+YmJ3mGClTKnPRKj92WU2lNjavzFnmU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=B3K7sjJUTBTOP9j/m/h4V4j9ZmGHCfXlJCAlIjr77vCiq2VqsaBfU4JXPSS90PkevhiqG5IKR2VWxVU2WHX6sFX6mttHw8xJ4tOsuHg+C7+d3Vu/Wfjr6Of8NIvmeSEMAxeA4OzkZpIG0hYo2MrGvhI5xYR0IzIoBKwLsTLSlhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3440fc2d3so60547855ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 20:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727838201; x=1728443001;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I0QD8jg5SHtvvNbrGQIb1AX0c7yX5HrvNXSq3nfIERw=;
        b=aW/FlBw6fzt29ARzFS9EUxtlKP/3wtXISvdX2lKawe8hAms7DWLXS8bC5rV3IvP/zl
         i+86IZak32QoLanhymvuJj2IUwUweH7ljw582iNyVm6PfEWZ8MexPEuOth2AT1+DUjCy
         7qG0pgVdxoW1CuVD4dxjT6k2Znkz4GGBfgnVpKfAUsmxXwJkTJzvZ+DJtM68dhWAXABo
         879NKstcor0ETWTnJ3ySUB+s89fjQrNsUoltjUl2ZF+j1QQaa/IJsGESFHXIccUC33we
         ASbEOfAVDPnStzYylH+urkVA3/r+49mA617NWzcaqKVpdgblAwEixQUCnZnyBTwIzMpB
         h+rQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2PA7m042Syrduc077ZnJ7GStS52uWh7hyOuhXt1vpiauvZ762/9rfztWDQQ+EUKQP45JFJaOxl3s5Pb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YysXstry3jeYpCSKOVII3SphG9vXSoRpRcNxWSOQfe17hReG2t1
	lKMcQenDw86+uUEKhAC395u/t18UKos7RmDeLQQM1lJLXjBa0CD3gIr4AozvI9HwiRVdBRhvChR
	R0P2ua2YSKQYsJ84F+iu6N/MDhxxRqqDfCpNGX6ErzK0HLQXANPvAkgw=
X-Google-Smtp-Source: AGHT+IFiIUvUFVooEkm6DK801RPXnKK/MAoiUl347FytOqjzPOsO0LYWomMfHfbqgU+SmKrWRdSroPfkV1veBA/QGAONVDs8kOj8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda8:0:b0:3a0:9aef:4c2 with SMTP id
 e9e14a558f8ab-3a36594454fmr16660945ab.19.1727838201198; Tue, 01 Oct 2024
 20:03:21 -0700 (PDT)
Date: Tue, 01 Oct 2024 20:03:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fcb7f9.050a0220.f28ec.04e8.GAE@google.com>
Subject: [syzbot] [jfs?] KASAN: null-ptr-deref Read in drop_buffers (3)
From: syzbot <syzbot+de1498ff3a934ac5e8b4@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, jfs-discussion@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e32cde8d2bd7 Merge tag 'sched_ext-for-6.12-rc1-fixes-1' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17b18307980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=286b31f2cf1c36b5
dashboard link: https://syzkaller.appspot.com/bug?extid=de1498ff3a934ac5e8b4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10718307980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f3939f980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-e32cde8d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9c681f5609bc/vmlinux-e32cde8d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/00b4d54de1d9/bzImage-e32cde8d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/14b0b7eafa4c/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+de1498ff3a934ac5e8b4@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: null-ptr-deref in atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
BUG: KASAN: null-ptr-deref in buffer_busy fs/buffer.c:2881 [inline]
BUG: KASAN: null-ptr-deref in drop_buffers+0x6f/0x710 fs/buffer.c:2893
Read of size 4 at addr 0000000000000060 by task kswapd0/74

CPU: 0 UID: 0 PID: 74 Comm: kswapd0 Not tainted 6.12.0-rc1-syzkaller-00031-ge32cde8d2bd7 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_report+0xe8/0x550 mm/kasan/report.c:491
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
 buffer_busy fs/buffer.c:2881 [inline]
 drop_buffers+0x6f/0x710 fs/buffer.c:2893
 try_to_free_buffers+0x295/0x5f0 fs/buffer.c:2947
 shrink_folio_list+0x240c/0x8cc0 mm/vmscan.c:1432
 evict_folios+0x549b/0x7b50 mm/vmscan.c:4583
 try_to_shrink_lruvec+0x9ab/0xbb0 mm/vmscan.c:4778
 shrink_one+0x3b9/0x850 mm/vmscan.c:4816
 shrink_many mm/vmscan.c:4879 [inline]
 lru_gen_shrink_node mm/vmscan.c:4957 [inline]
 shrink_node+0x3799/0x3de0 mm/vmscan.c:5937
 kswapd_shrink_node mm/vmscan.c:6765 [inline]
 balance_pgdat mm/vmscan.c:6957 [inline]
 kswapd+0x1ca3/0x3700 mm/vmscan.c:7226
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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

