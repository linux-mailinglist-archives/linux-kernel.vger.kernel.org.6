Return-Path: <linux-kernel+bounces-193883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3F48D33A0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0947F28458E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 09:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C4916F0C4;
	Wed, 29 May 2024 09:49:34 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3FA16D31A
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 09:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716976174; cv=none; b=FzMmccboji20MzFRfsITxeH1Zo56ZfEyLm/mAxWlFHS+4hnChXDOn5LaoGD4XEaMxYw7siJD2M8b+wmMsKeScynb3y7N+UxmEqkuiWDBULfTaY6OBfMx4DZYDL6xjFT70oaW6Xg5LK33Qt57K3mR40XT5T96bvdY73vtp2vUL2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716976174; c=relaxed/simple;
	bh=Sk4Dt7yZdAd1uLagqqUNML2SGQLclnQj6L3onp7FUDE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KehUMSjhTS0y57UxhwOBWUSARb1iRmLBdXYfIuH9an0svZ/ImTE2zQ8Tv3+wb+b/ZSuVHOBk3kNUikmJpM+I3zs2alLmoKEcq/s11XfWHCFxL+ZxOxaMlCCMElLGX4Exrhz3pV2Wxg9XFOjKYZ3EXeLOvZnmXe0zk0Siyp/SYPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7eac4d26336so240911739f.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 02:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716976171; x=1717580971;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N/gB9SA1D5Rtl34GsQ50mkVEhrgVfCvpoZtkqi8HNvI=;
        b=i6PNfv4nxuAfi4qIuXnk93Mg65iWFv01G9SGZ1BdaSj0QB0kin5GejljA6oQ9b8ZSa
         MsWmmMbsPio8aWG54M6g0JpnpTNNRKaT1LyQEJu3GtxFRJPdpgF2QhNV8YK9JZFjMQzc
         RopZyj3etaYFE0hsaQShz5cTS8KnMV3kIsXgd0t5FY2Nvp0BOq5T5wFg4iOYiEUi/iBw
         p94UOHlaej9AwOgiTF5V8HCAvbCPE/ooDb//cm/jcknEwLvVrUwYu8O0d7uvKgPyU0If
         LTuyyAhUxEwd15uunFM4e7gvmlYZdy1nToo1yE/ubtphnJYzZzjp7SRHPr1VyQlNvASG
         R4dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJBA6FrLfs69U1JiT0FpLK3HkXnqynGapK6yS/xvHzx2t4Dikfzf5xNOYt5yCfVfAOCfFcvcdAI1m/FrEvgIsbKo5Gidmbhj39jZHL
X-Gm-Message-State: AOJu0YzX/kAgRweiPY/BtcSfh6MLvA7LaOikhEgDR045CB/2UgUJ9PSH
	3TRqX8Fmj3ddjthpNtJJ/ew3GkBD55mkUIeGhde5/e4q+TvGiucQ2F1b0FXxmYTLuOEje7l9m+D
	4xziuceyQjhFncS83NY21hRkasw5TWdUd803TGdGeyTUBZ3w6p+aF7rg=
X-Google-Smtp-Source: AGHT+IHVMJ9Q3SoUSwqVEc6vdi85sZCehZz4qCMrSLxjKmVzLtgdu4TGCG3J1AqKWzzOsrCUJ3fKWRFHiVChtk+yIrmzcmWj3aWf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:cd9e:0:b0:488:5e26:ffb5 with SMTP id
 8926c6da1cb9f-4b03f649493mr477570173.2.1716976171521; Wed, 29 May 2024
 02:49:31 -0700 (PDT)
Date: Wed, 29 May 2024 02:49:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000caabf7061994aa0c@google.com>
Subject: [syzbot] [wireless?] KASAN: slab-out-of-bounds Read in cfg80211_wext_freq
From: syzbot <syzbot+253cd2d2491df77c93ac@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fda5695d692c Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=12be4768980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95dc1de8407c7270
dashboard link: https://syzkaller.appspot.com/bug?extid=253cd2d2491df77c93ac
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15fc7784980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15505e8a980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/07f3214ff0d9/disk-fda5695d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/70e2e2c864e8/vmlinux-fda5695d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b259942a16dc/Image-fda5695d.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+253cd2d2491df77c93ac@syzkaller.appspotmail.com

warning: `syz-executor854' uses wireless extensions which will stop working for Wi-Fi 7 hardware; use nl80211
==================================================================
BUG: KASAN: slab-out-of-bounds in cfg80211_wext_freq+0x170/0x1ac net/wireless/wext-compat.c:238
Read of size 2 at addr ffff0000cd6ce140 by task syz-executor854/6234

CPU: 1 PID: 6234 Comm: syz-executor854 Not tainted 6.9.0-rc7-syzkaller-gfda5695d692c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:317
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:324
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x198/0x538 mm/kasan/report.c:488
 kasan_report+0xd8/0x138 mm/kasan/report.c:601
 __asan_report_load2_noabort+0x20/0x2c mm/kasan/report_generic.c:379
 cfg80211_wext_freq+0x170/0x1ac net/wireless/wext-compat.c:238
 cfg80211_wext_siwscan+0x438/0xef0 net/wireless/scan.c:3413
 ioctl_standard_iw_point+0x7f0/0xdc4 net/wireless/wext-core.c:867
 ioctl_standard_call+0xcc/0x264 net/wireless/wext-core.c:1052
 wext_ioctl_dispatch+0x1b4/0x534 net/wireless/wext-core.c:1016
 wext_handle_ioctl+0x1f8/0x3f4 net/wireless/wext-core.c:1077
 sock_ioctl+0x15c/0x838 net/socket.c:1275
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:904 [inline]
 __se_sys_ioctl fs/ioctl.c:890 [inline]
 __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:890
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

Allocated by task 6234:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:68
 kasan_save_alloc_info+0x40/0x50 mm/kasan/generic.c:565
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xac/0xc4 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:3966 [inline]
 __kmalloc+0x2b8/0x508 mm/slub.c:3979
 kmalloc include/linux/slab.h:632 [inline]
 kzalloc include/linux/slab.h:749 [inline]
 ioctl_standard_iw_point+0x3b8/0xdc4 net/wireless/wext-core.c:828
 ioctl_standard_call+0xcc/0x264 net/wireless/wext-core.c:1052
 wext_ioctl_dispatch+0x1b4/0x534 net/wireless/wext-core.c:1016
 wext_handle_ioctl+0x1f8/0x3f4 net/wireless/wext-core.c:1077
 sock_ioctl+0x15c/0x838 net/socket.c:1275
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:904 [inline]
 __se_sys_ioctl fs/ioctl.c:890 [inline]
 __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:890
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

The buggy address belongs to the object at ffff0000cd6ce000
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 4 bytes to the right of
 allocated 316-byte region [ffff0000cd6ce000, ffff0000cd6ce13c)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10d6cc
head: order:2 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x5ffc00000000840(slab|head|node=0|zone=2|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 05ffc00000000840 ffff0000c0001c80 fffffdffc335a900 dead000000000002
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
head: 05ffc00000000840 ffff0000c0001c80 fffffdffc335a900 dead000000000002
head: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
head: 05ffc00000000002 fffffdffc335b301 fffffdffc335b348 00000000ffffffff
head: 0000000400000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000cd6ce000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff0000cd6ce080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff0000cd6ce100: 00 00 00 00 00 00 00 04 fc fc fc fc fc fc fc fc
                                           ^
 ffff0000cd6ce180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff0000cd6ce200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in net/wireless/scan.c:3411:8
index 33 is out of range for type 'struct iw_freq[32]'
CPU: 1 PID: 6234 Comm: syz-executor854 Tainted: G    B              6.9.0-rc7-syzkaller-gfda5695d692c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:317
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:324
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:114
 dump_stack+0x1c/0x28 lib/dump_stack.c:123
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_out_of_bounds+0xf8/0x148 lib/ubsan.c:429
 cfg80211_wext_siwscan+0x4a8/0xef0 net/wireless/scan.c:3411
 ioctl_standard_iw_point+0x7f0/0xdc4 net/wireless/wext-core.c:867
 ioctl_standard_call+0xcc/0x264 net/wireless/wext-core.c:1052
 wext_ioctl_dispatch+0x1b4/0x534 net/wireless/wext-core.c:1016
 wext_handle_ioctl+0x1f8/0x3f4 net/wireless/wext-core.c:1077
 sock_ioctl+0x15c/0x838 net/socket.c:1275
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:904 [inline]
 __se_sys_ioctl fs/ioctl.c:890 [inline]
 __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:890
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
---[ end trace ]---


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

