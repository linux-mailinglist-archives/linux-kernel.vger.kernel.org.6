Return-Path: <linux-kernel+bounces-262845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D94893CDC9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 07:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5645B2266C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 05:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C628539AFD;
	Fri, 26 Jul 2024 05:45:24 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED852744C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 05:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721972724; cv=none; b=Hx5hSImVKB9XsFn91RvlWC/9Y6eKF+EkUx1WuidMzLtFua5O+ZealEG0cnC1tzQBrouTmg5UKkV4LqNFf+IHvvUrd9fPsibylCkpdHoAbvvvHusDooeEIB12zMmvOPbCjWS/IL9BgDZtimLnzNSQ20ZZn+6Yvc6UUKuba/Xn39I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721972724; c=relaxed/simple;
	bh=WvMolKkuujMCUrJeaT8YEQokMzX6QD8PJZQgaPNu7/Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=K9RGyWbGF2Oa/SyVyJRS6VPgpCqM1jyV6oRnTKm3BSuhIy5Rp+FUHXRmog0AyuzL8P0Sy915+vSkGfNv2xONAw98nMIVUrjF166rad2rqgO2H8ayf2t0CQpYY9b7JLtxq0O51Nu5vtnkxWixtNlSH1XutcHGizbVxCwW8rLCpag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39a2a3883easo10899615ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 22:45:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721972722; x=1722577522;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DZcaH5okJTNj2VAL4oorr93ZBcU8Ex5+owgFpt6K9nc=;
        b=u+k9jHKmHtxeZdz0tkFdpJPP51YSCI2MZzHEe0a1qHTD1LQyRhhs3KBGeodiwGy6eI
         2N8D2KYyCqbPdXQugQqhNGBDHZR+MflrbpnvvHSePtsagYhKlZ/2VgU+ED3EyX8SzvVF
         eoxMLwF5RoX4YWrLocvGpkCFmyAs9LoO/zP9EqqjWPzDKZ8S98OlLXbnVloAjzWubMpn
         po6YbcJf05TuOSAzF44YsokLxai6Nb5ebwoJAuduP2wZGXexTLPxbLJl7RfN6Tah/hL2
         1w9ICPXizO05ZhCV0DyTcDJ389hBdesr5OikL+kNu1OokXgo8nuKfXVFZ9pPRCo8z1vX
         gFbw==
X-Forwarded-Encrypted: i=1; AJvYcCUl5b0NCO1tMQcQ4dC1rEa6s2Xq5FI81kj/IOGwPABwsnAbtWscLc1RmwK01djioec+BhSFGoSnJLcySz5szho2bDxW+HlQExx5oOpo
X-Gm-Message-State: AOJu0YyQFhOhhNFj4kkWufL7IzxMvlpp6kdZCeAH1YVy1V+oFS8gwQzr
	DdiQzI8gMKFVjtsGwxEafeE+e/enVdyIU2t7gZzkuPOpSMSZCEo6KX0R787WQqxYypYXS41wE3q
	HaY0eiUrzLKhjqDwkdGwqEYZChRSUAZyxGpwQoDaPDIGsWxfOXpPa8qQ=
X-Google-Smtp-Source: AGHT+IEMOt5qA+PaIFHYI84FHgyOcl+1QMlA8NhttYDLRzsq7P4g3brP7Zcp0/Gnv89zLWybjo6PttkopSA5q6nI8EzmHdZv6P4H
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d90:b0:396:2d57:b1cb with SMTP id
 e9e14a558f8ab-39a23d14de9mr3124455ab.0.1721972721759; Thu, 25 Jul 2024
 22:45:21 -0700 (PDT)
Date: Thu, 25 Jul 2024 22:45:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000064c7a0061e2004d6@google.com>
Subject: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in dbSplit
From: syzbot <syzbot+dca05492eff41f604890@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7846b618e0a4 Merge tag 'rtc-6.11' of git://git.kernel.org/..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=169ade0d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4925140c45a2a50
dashboard link: https://syzkaller.appspot.com/bug?extid=dca05492eff41f604890
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=165876b5980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1453ee95980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/43e8dc30bfe7/disk-7846b618.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2563411f0b58/vmlinux-7846b618.xz
kernel image: https://storage.googleapis.com/syzbot-assets/19d3b69b2212/bzImage-7846b618.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/97777a7e85e9/mount_0.gz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13f21c65980000
console output: https://syzkaller.appspot.com/x/log.txt?x=17f21c65980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dca05492eff41f604890@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
loop0: detected capacity change from 32768 to 32745
------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_dmap.c:2628:27
index 4294967295 is out of range for type 's8[1365]' (aka 'signed char[1365]')
CPU: 0 PID: 5087 Comm: syz-executor157 Not tainted 6.10.0-syzkaller-11323-g7846b618e0a4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_out_of_bounds+0x121/0x150 lib/ubsan.c:429
 dbSplit+0x1fd/0x220 fs/jfs/jfs_dmap.c:2628
 dbAllocBits+0x4e5/0x9a0 fs/jfs/jfs_dmap.c:2191
 dbAllocDmap fs/jfs/jfs_dmap.c:2032 [inline]
 dbAllocDmapLev+0x250/0x4a0 fs/jfs/jfs_dmap.c:1986
 dbAllocCtl+0x113/0x920 fs/jfs/jfs_dmap.c:1823
 dbAllocAG+0x28f/0x10b0 fs/jfs/jfs_dmap.c:1364
 dbAlloc+0x658/0xca0 fs/jfs/jfs_dmap.c:888
 dtSplitUp fs/jfs/jfs_dtree.c:979 [inline]
 dtInsert+0xda7/0x6b00 fs/jfs/jfs_dtree.c:868
 jfs_create+0x7ba/0xbb0 fs/jfs/namei.c:137
 lookup_open fs/namei.c:3578 [inline]
 open_last_lookups fs/namei.c:3647 [inline]
 path_openat+0x1a9a/0x3470 fs/namei.c:3883
 do_filp_open+0x235/0x490 fs/namei.c:3913
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_openat fs/open.c:1447 [inline]
 __se_sys_openat fs/open.c:1442 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1442
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff80ad14019
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcebdf6708 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007ff80ad5d095 RCX: 00007ff80ad14019
RDX: 000000000000275a RSI: 0000000020000080 RDI: 00000000ffffff9c
RBP: 00007ff80ad8e5f0 R08: 00005555712cc4c0 R09: 00005555712cc4c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffcebdf6730
R13: 00007ffcebdf6958 R14: 431bde82d7b634db R15: 00007ff80ad5d03b
 </TASK>
---[ end trace ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

