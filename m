Return-Path: <linux-kernel+bounces-339181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E5F986122
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25D10288585
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA0318EFC8;
	Wed, 25 Sep 2024 13:55:28 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C470418893A
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 13:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727272528; cv=none; b=i2Npy42DpencuE1LIeNJYOUv29KJAuCjh+bOCxl1BYKwPvdHPOJe5YTIDRPHaiQ4Yuws5mJB9SpaYL9Q5jWnx/WHBxWzz7y8ESI3+wNOuJ8AAbAcE6LnP6KVpnFgazB6idfFS54nj9u4UeQA3BOEMuKUtZI+09RpYjC65JY3d6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727272528; c=relaxed/simple;
	bh=c/RXjAQdQZsSdgp0f9EvpCNzCzvtO+26felbWv3Y754=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BtjBmEXDMsG9JBPAi6hkU2ldFgCsjjjtxusv9CGhdfA0Sc+pwZYEhSaswbpb36dqVMe9SRf5HW27NBvH6PjjnYs8C3NJkGmSGDZLmcEPP1E59+oFE2QJsaPgs9438DROYBy8L1dT7o+yKrwBMXQdqVG+8pC5AX/xuQcmobQ9+nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a1a8a4174dso17333565ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 06:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727272526; x=1727877326;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vLMBv9Fe6JcSvW5DsInLOm7dJ+eWmOXJ66A06ODGD+g=;
        b=TE9Kh16KLec2//1IO+UQVHdElBqnh+CAMXOPlU44tPUyBlEDOMGqAiqYDCoQQ404Yw
         vZEZm5c6vQykoUcDV+/7Fhxqv5gfhfr+Wnz8fTlfBMSwegSQsOq1yUh5qXd+GLb3VfV8
         GxCBolOHWAYF3fdNSTUFzgTvt8mE19T8CO6rhyXJ6IcCmZOEQB/RaHsc0mjK1Nlku4Nf
         9Two+Ol3uS9p8b4S48yZgywwdBwCM8GXFrgYHQoLJyUDl0dBSi9bQ6XjP03SI/VraaS2
         bgD7wENIOQYNce0IzvytZHQbW79BRrAmulkOSkLbYpG5dBMnYvkAf/SYv45MZQUL9p+q
         F/kA==
X-Forwarded-Encrypted: i=1; AJvYcCUcUWJHhLlKggi/Gj9vR+KHtRJ3s83IFofHxKKUi4qxRtbiyKf5/BjSRRafSey+QUZ3Klhdm6lEY6Ptq5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA4l8F2S3ZBmvC8eJ5B5kJZOOp0HLntWczPSXmt6ubg1Xl1cSG
	37SOP+aagqX/ifrue3lTJ4qcTrJS5y+PSCg0IJIyjdM6ootNVpEF8GZ0utPqJCyZZkJ9tIl+sEr
	QF6PLr+XuQBibzBOfm76RfBESc3QnVGwHsyly8oEl+8l8217rIHo7PO4=
X-Google-Smtp-Source: AGHT+IFStIZgHMGq388F7aa+FYX4ZUpuZlggvMhl6a4RPAOA3kcvP7JdTFUH7YX4i0AZBckg3Iw+o950NEyc18w78nrd96LbckfW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a24:b0:3a0:52f9:9170 with SMTP id
 e9e14a558f8ab-3a26d6f9e12mr30454645ab.1.1727272525843; Wed, 25 Sep 2024
 06:55:25 -0700 (PDT)
Date: Wed, 25 Sep 2024 06:55:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f4164d.050a0220.211276.0032.GAE@google.com>
Subject: [syzbot] [kvm?] WARNING in srcu_check_nmi_safety (2)
From: syzbot <syzbot+314c2cfd4071ad738810@syzkaller.appspotmail.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    abf2050f51fd Merge tag 'media/v6.12-1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=114cc99f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc30a30374b0753
dashboard link: https://syzkaller.appspot.com/bug?extid=314c2cfd4071ad738810
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-abf2050f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2179ebeade58/vmlinux-abf2050f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f05289b5cf7c/bzImage-abf2050f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+314c2cfd4071ad738810@syzkaller.appspotmail.com

------------[ cut here ]------------
CPU 0 old state 2 new state 1
WARNING: CPU: 0 PID: 73 at kernel/rcu/srcutree.c:708 srcu_check_nmi_safety+0xca/0x150 kernel/rcu/srcutree.c:708
Modules linked in:
CPU: 0 UID: 0 PID: 73 Comm: kswapd0 Not tainted 6.11.0-syzkaller-09959-gabf2050f51fd #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:srcu_check_nmi_safety+0xca/0x150 kernel/rcu/srcutree.c:708
Code: 81 c3 c8 01 00 00 48 89 d8 48 c1 e8 03 42 0f b6 04 20 84 c0 75 77 8b 33 48 c7 c7 20 0c 0c 8c 89 ea 44 89 f9 e8 b7 8c db ff 90 <0f> 0b 90 90 eb 0c 42 0f b6 04 23 84 c0 75 3d 45 89 3e 48 83 c4 08
RSP: 0018:ffffc90000e464e0 EFLAGS: 00010246
RAX: 41404736cdfea900 RBX: ffffe8ffffc414c8 RCX: ffff88801efb0000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000002 R08: ffffffff8155aaa2 R09: 1ffff11003f8519a
R10: dffffc0000000000 R11: ffffed1003f8519b R12: dffffc0000000000
R13: 0000607fe0041300 R14: ffffe8ffffc41320 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000564aa6d10940 CR3: 0000000011c68000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 srcu_read_lock include/linux/srcu.h:248 [inline]
 __kvm_handle_hva_range virt/kvm/kvm_main.c:612 [inline]
 kvm_handle_hva_range virt/kvm/kvm_main.c:684 [inline]
 kvm_mmu_notifier_clear_flush_young+0xe6/0x820 virt/kvm/kvm_main.c:867
 __mmu_notifier_clear_flush_young+0x11d/0x1d0 mm/mmu_notifier.c:379
 mmu_notifier_clear_flush_young include/linux/mmu_notifier.h:410 [inline]
 folio_referenced_one+0xb9d/0x2160 mm/rmap.c:895
 rmap_walk_anon+0x4cd/0x8a0 mm/rmap.c:2638
 rmap_walk mm/rmap.c:2716 [inline]
 folio_referenced+0x394/0x7a0 mm/rmap.c:1008
 folio_check_references mm/vmscan.c:863 [inline]
 shrink_folio_list+0xe96/0x8cc0 mm/vmscan.c:1198
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

