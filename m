Return-Path: <linux-kernel+bounces-192777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BD98D21F7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 194341C23090
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1620917333B;
	Tue, 28 May 2024 16:49:23 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12292173336
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 16:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716914962; cv=none; b=duTqWMVEhmt1/kEQHQ/RLlmQIe/yLQsooCq7FtzzpJQCo2Or2hs6pkAwBUWg9x7GdFqFGxWy9ZJMtym8XW1VGlsvAzcsFRFD/x1sdBEWEOFLCU++zbZiDoENVnNiEHHX4wiA4moN0zLWLnX38IQL07dxXy88sDfm7k9bIevSnm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716914962; c=relaxed/simple;
	bh=BL6ItH3SCo6F1ruKNEGXPDqhFUeg2tFaW+4akh1m70c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DVOw1V3MFoUpyeU20vzub4ozS/W/r8Rg59XhDysR88faOYni3jmx+TXz8fs9qJXAoO8r32mjgSjvHxjaGWY9+EWaK/RRn/al1b3gCzqvdTLLbLTktD1iCBnK1FIIiag7RX+ojXoNBTMKE3nhhmmtwPjg+Fq7wo1e8kFGsxdmp74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7e8e2ea7b4bso138382339f.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 09:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716914960; x=1717519760;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tZzO/4pc+XDv2V+Jge2TnOBH79urp8XuvaLJBvnPUZI=;
        b=Yn7tUvNIUNc3+9BY/+5EUKTtDfQAghhOgXCACZfgrrNeqQNEYwG1KhUij63iVfCih+
         crv0why5VZoyjsVwi/EWHwiAs4KAZeLRoZrcSO1I7H7URpfDyq2ZE6lkLfEZcbTkql2I
         Lwq2HdCiEEgmnGel+aI3m/+PQbAhh3E+fOwTYbdNeLs0zFGDZhq1Ab6MocnhCyOI/Cz+
         Q52DsN+r+Phiviz917qt0ef9SfmjDEEXk2ZGgTz7Vl+lf7n7+tLxTIPbENMUeaMSwT36
         FqWS6a+BnrGSFiZO3j2bXjgOrvblHPIlVkF/z2hpOINYfKjCyooLfIez3czHnsoPmt9f
         e2lw==
X-Forwarded-Encrypted: i=1; AJvYcCUnEJtZkvvb0VVy23miWMz8M9dnRuJu6y0VbwAzh4F9D/1kr8UZaT2Ez9gEU9GjGqPvRYFbpEjhDicNSS2v+qmkDOAMKNXRnWJxg6hQ
X-Gm-Message-State: AOJu0YyF1vuOdfrk8UhRwsCqjje3ieAOisn+/LwUsH4mRLJi2pIR6a5W
	zj2NZ14v2XQZUa1HmiqCWWySmUmKDWul5IgNDxfVTg2SfFTMW/XilU3neZe3XnvLlE/BLbWe6+p
	rh3+OqUszbfo1HcDdNeKFJbzR4YjyQBYqetphuwY/dsHk5GIQ2UH/wm8=
X-Google-Smtp-Source: AGHT+IGsMmSC53th1dCVzNLiCsoYGAmD8/xq5DaB+r8Va3aTEcCYQSUssr8tKzI6cM4YH9DHCepfP4pgys2/22aFAlc/8u43nFL2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14d5:b0:7da:5250:5bf8 with SMTP id
 ca18e2360f4ac-7e8c73e7d2fmr71242039f.4.1716914960031; Tue, 28 May 2024
 09:49:20 -0700 (PDT)
Date: Tue, 28 May 2024 09:49:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004d74b30619866a7f@google.com>
Subject: [syzbot] [mm?] UBSAN: shift-out-of-bounds in try_to_shrink_lruvec
From: syzbot <syzbot+17416257cb95200cba44@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6dc544b66971 Add linux-next specific files for 20240528
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=146d3f84980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6a363b35598e573d
dashboard link: https://syzkaller.appspot.com/bug?extid=17416257cb95200cba44
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11e41b72980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15f3d2d2980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/334699ab67f8/disk-6dc544b6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4ca32b2218ce/vmlinux-6dc544b6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/400bc5f019b3/bzImage-6dc544b6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+17416257cb95200cba44@syzkaller.appspotmail.com

------------[ cut here ]------------
UBSAN: shift-out-of-bounds in mm/vmscan.c:4715:21
shift exponent -1 is negative
CPU: 1 PID: 5094 Comm: syz-executor177 Not tainted 6.10.0-rc1-next-20240528-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_shift_out_of_bounds+0x3c8/0x420 lib/ubsan.c:468
 get_nr_to_scan mm/vmscan.c:4715 [inline]
 try_to_shrink_lruvec+0xa99/0xbb0 mm/vmscan.c:4761
 lru_gen_shrink_lruvec mm/vmscan.c:4908 [inline]
 shrink_lruvec+0x554/0x3070 mm/vmscan.c:5685
 shrink_node_memcgs mm/vmscan.c:5921 [inline]
 shrink_node+0xb17/0x4150 mm/vmscan.c:5961
 shrink_zones mm/vmscan.c:6205 [inline]
 do_try_to_free_pages+0x789/0x1cb0 mm/vmscan.c:6267
 try_to_free_mem_cgroup_pages+0x48f/0xb10 mm/vmscan.c:6598
 try_charge_memcg+0x704/0x1850 mm/memcontrol.c:2946
 try_charge mm/memcontrol.c:3094 [inline]
 charge_memcg+0xa2/0x160 mm/memcontrol.c:7532
 __mem_cgroup_charge+0x27/0x80 mm/memcontrol.c:7547
 mem_cgroup_charge include/linux/memcontrol.h:686 [inline]
 shmem_alloc_and_add_folio+0x44b/0xbd0 mm/shmem.c:1663
 shmem_get_folio_gfp+0x82d/0x1f50 mm/shmem.c:2041
 shmem_read_folio_gfp+0xd6/0x170 mm/shmem.c:4944
 drm_gem_get_pages+0x21b/0xe50 drivers/gpu/drm/drm_gem.c:568
 drm_gem_shmem_get_pages+0xdd/0x290 drivers/gpu/drm/drm_gem_shmem_helper.c:177
 drm_gem_shmem_vmap+0x2ba/0x630 drivers/gpu/drm/drm_gem_shmem_helper.c:335
 drm_gem_vmap drivers/gpu/drm/drm_gem.c:1205 [inline]
 drm_gem_vmap_unlocked+0x103/0x1d0 drivers/gpu/drm/drm_gem.c:1247
 drm_gem_fb_vmap+0xa6/0x810 drivers/gpu/drm/drm_gem_framebuffer_helper.c:365
 drm_atomic_helper_prepare_planes+0x2b2/0xb50 drivers/gpu/drm/drm_atomic_helper.c:2601
 drm_atomic_helper_commit+0x18b/0x9f0 drivers/gpu/drm/drm_atomic_helper.c:2029
 drm_atomic_commit+0x2ac/0x310 drivers/gpu/drm/drm_atomic.c:1514
 drm_atomic_helper_update_plane+0x238/0x3a0 drivers/gpu/drm/drm_atomic_helper.c:3190
 drm_mode_cursor_universal drivers/gpu/drm/drm_plane.c:1221 [inline]
 drm_mode_cursor_common+0xd68/0x1570 drivers/gpu/drm/drm_plane.c:1280
 drm_mode_cursor_ioctl+0xe1/0x160 drivers/gpu/drm/drm_plane.c:1330
 drm_ioctl_kernel+0x33a/0x440 drivers/gpu/drm/drm_ioctl.c:744
 drm_ioctl+0x611/0xad0 drivers/gpu/drm/drm_ioctl.c:841
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f06b4225999
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff29e89738 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f06b4225999
RDX: 0000000020000340 RSI: 00000000c01c64a3 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0023647261632f69 R11: 0000000000000246 R12: 00007f06b426f036
R13: 00007fff29e89770 R14: 00007fff29e897b0 R15: 0000000000000000
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

