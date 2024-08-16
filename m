Return-Path: <linux-kernel+bounces-290275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 391E19551A6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 21:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71E0EB2207B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 19:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272061C4607;
	Fri, 16 Aug 2024 19:52:28 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C401C233C
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 19:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723837947; cv=none; b=YLdPkMMwkv9MpYcJEQO1ld8I+esY2vrLkcFzsXhvfibKHcdmvtobi3eAor+MiUwyNmRm10Pi8osnFOghUNxxJNoHqlkE9FPjMPcPcAlOc4xXW5kP2pwHSpEMRaqML4Wu0W9uoe83dD/IhWYCrNefqYoM3+LAykpY5sZNVN71pvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723837947; c=relaxed/simple;
	bh=qrgZSVXraFbnasXCeycJNBObjrjXH9ccKTOH4BLMTD8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jpoRQtA6z+CcwMT0vwsXc9fCQFhgOoNR7lhUIj5/aoKPQBfNVmooiI5GxU/19d83sr2P03e/38+elQ9Q+87eDHvXqOAeeDqPTt7uieppTXBVWFym4u8BTzV42U1fZbdko2W1WaZvtyjGzdTgJT/zGn1KOtQ5pvjmKhef1x0aFIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f968e53b0so223920839f.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 12:52:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723837945; x=1724442745;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sWy1CY98uGfAzvbeIONKR5qCblpJHHCwJaPisbgzY8M=;
        b=DIjr5dz/vsVvMQzpCBuiZlPR/0rHEHjgzCU3fzmphgApafRWQQwso2nRtisLV1xjiN
         pFlrV80grXfer/ArKV/ZeUJq5W99aNXcJUhS0+dd/QaXQn1C78ns2dP944bgqJ2Dry1b
         BRf1B9hSTFoJGJJ//tlwpIvvWOtE/TcZ0YK2vdxRzIv3Mmq1dMEwm56zRgdLBT4IO0Pv
         mJZ8HXyiDF3p/LjTpXYQeg7cPGQqcBaXGOE301PAmzhMBIjLmFWNIHLhHTRdcSdpYGQM
         kiMN8hcD/ugjYJZoE8/dj8BbKQIZ1ujBlTB6QDldsdA52RI985wwF0DfJOv1PLGXMRkn
         IBIA==
X-Forwarded-Encrypted: i=1; AJvYcCUeGccPhIXiu1BXXq4GMljEC6tjYBsaMZ9xFylP0GmT8hU0I8RhIZscGBuK+qDr32R7kxbtBmcekEBICg7piZ5Vm9Kq9/l/KfnkLa0s
X-Gm-Message-State: AOJu0YwpYMv8JFR2dilz6+ub9syngtQOUTM4jdOjKy155LNq5GSED9Nu
	Ixe6afBFO1RyIfJcopKOy4WGEtXtX/V9jLFBVQ4w+qlR5duTHI1pK6xFEfZfMMEtTmwr791FCdY
	7ZqmO+SaKo+gAymauIFF0lydZZHrWvA2gjxTW+8fUCau5kv3ihFm6baU=
X-Google-Smtp-Source: AGHT+IHFbC3KfJeiVObTY0ZY0LGK1pA7r4FFsV+UtWb5xuDIqJkdVcF704aKFpvmTfN/7GBou0xAb+CoV7pgPJ6vK4Cb1ds7jcU3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8625:b0:4c0:8165:c39d with SMTP id
 8926c6da1cb9f-4cce15df126mr228683173.2.1723837945265; Fri, 16 Aug 2024
 12:52:25 -0700 (PDT)
Date: Fri, 16 Aug 2024 12:52:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000060cf79061fd24ca8@google.com>
Subject: [syzbot] [mm?] WARNING in zswap_swapoff
From: syzbot <syzbot+ce6029250d7fd4d0476d@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, chengming.zhou@linux.dev, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com, 
	syzkaller-bugs@googlegroups.com, yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    367b5c3d53e5 Add linux-next specific files for 20240816
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12489105980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61ba6f3b22ee5467
dashboard link: https://syzkaller.appspot.com/bug?extid=ce6029250d7fd4d0476d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0b1b4e3cad3c/disk-367b5c3d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5bb090f7813c/vmlinux-367b5c3d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6674cb0709b1/bzImage-367b5c3d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ce6029250d7fd4d0476d@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 11298 at mm/zswap.c:1700 zswap_swapoff+0x11b/0x2b0 mm/zswap.c:1700
Modules linked in:
CPU: 0 UID: 0 PID: 11298 Comm: swapoff Not tainted 6.11.0-rc3-next-20240816-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:zswap_swapoff+0x11b/0x2b0 mm/zswap.c:1700
Code: 74 05 e8 78 73 07 00 4b 83 7c 35 00 00 75 15 e8 1b bd 9e ff 48 ff c5 49 83 c6 50 83 7c 24 0c 17 76 9b eb 24 e8 06 bd 9e ff 90 <0f> 0b 90 eb e5 48 8b 0c 24 80 e1 07 80 c1 03 38 c1 7c 90 48 8b 3c
RSP: 0018:ffffc9000302fa38 EFLAGS: 00010293
RAX: ffffffff81f4d66a RBX: dffffc0000000000 RCX: ffff88802c19bc00
RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff888015986248
RBP: 0000000000000000 R08: ffffffff81f4d620 R09: 1ffffffff1d476ac
R10: dffffc0000000000 R11: fffffbfff1d476ad R12: dffffc0000000000
R13: ffff888015986200 R14: 0000000000000048 R15: 0000000000000002
FS:  00007f9e628a5380(0000) GS:ffff8880b9000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30f15ff8 CR3: 000000006c5f0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __do_sys_swapoff mm/swapfile.c:2837 [inline]
 __se_sys_swapoff+0x4653/0x4cf0 mm/swapfile.c:2706
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9e629feb37
Code: 73 01 c3 48 8b 0d f1 52 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a8 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c1 52 0d 00 f7 d8 64 89 01 48
RSP: 002b:00007fff17734f68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a8
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9e629feb37
RDX: 00007f9e62a9e7e8 RSI: 00007f9e62b9beed RDI: 0000563090942a20
RBP: 0000563090942a20 R08: 0000000000000000 R09: 77872e07ed164f94
R10: 000000000000001f R11: 0000000000000246 R12: 00007fff17735188
R13: 00005630909422a0 R14: 0000563073724169 R15: 00007f9e62bdda80
 </TASK>


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

