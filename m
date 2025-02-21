Return-Path: <linux-kernel+bounces-526195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB76A3FB73
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 450AE166D0A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553F61EE03D;
	Fri, 21 Feb 2025 16:28:27 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BBE1DED6F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740155306; cv=none; b=VOigvF52kXdAKGBftRVMshrzlkb+K3bh/XXl5qa/xtGqWlDgSRjJWRGisBhH73nHE24Y7M2uDUiyuqhpEX5aF4JRgtIFuhq40CeQgrfUZoMe8gTMDSCFLAiW5oM3BwMuq+8scomF8ztjI+FAgOVL4Ty5Ih7ODEh8Zq3hTFI8vh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740155306; c=relaxed/simple;
	bh=jOQZjstGgxm5Bcgaf6+5NtX9rawNxzPDbommu8Q5S1I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=IRicER1noZfUOCr9lUVPlDr/bllhvxbasbNorDSMULmsQggvm69M25ZvNVx0H/hPESgZA3JIDWJUk3/rUu4o37QP01EgemSS20NeWtJwp6Iaf1CO19XF2kgKiSyfqZGuEjul5qEfWf4e1D9P4AOyjz80BOmV9IHd0nunDyx5gkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3cfb20d74b5so19568455ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 08:28:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740155304; x=1740760104;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F/Q/W/O04TlVZ2Jk9AR9ks1KfkLx5QxQ1RJMHHI2ixs=;
        b=hbm3c5hQadn5N6FgK/b8mBRRhXNogyX4uKAvCDQLgpp7neVN80odUt0eOaTCl7zwpG
         TC+U9/oDSd8cX/KJ6l6720CGvGyv6y+BqGmuQfO/rEWMEgAIFR45i3f9bSVG54O6CjA4
         fLaQWZQwZKrweBLMXgBhDksl22lz/yQFpf5adGGGdbs1SREA4dE32CgTvZW4I/uZiNg8
         H4oTTCRsi2PevPGilfBaEgLLDYmUJr8IbilxDONcF1iKgB40OchdACb+zIRzeX8RyY6U
         EjeiNflMiDHV97WfAjPSeRXYoNJeJUhrp2heOJUC5PqfsOXqn0Ray0Ej7wKMTtZGbsCo
         EqEw==
X-Forwarded-Encrypted: i=1; AJvYcCVM/xrFfv0u/njnH54AIvFS1cj7xI9FAtzEmyv28U/yEU2gvLAYlqjRKEfv4qyzWlErE8eA1ExEZirTsVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy05MwBZl3cnQc3VlqQlYH1/CIA5dsOJGt39XRPpU7bDBpWtiiN
	2Qtddrz+wGYSAochREtebJcxrr5zSAu7T0yOa7OKhMBwFiOYI14sp0mB9tWj+HlSY73Bfx8pvGf
	qkmola25ED8PresIlzSf/y9nwFcsgZMlZ2tzrYn4w6QYkbwiWGYOy4Cw=
X-Google-Smtp-Source: AGHT+IFOkfdL83iUv16vUWA0KAHkH/HE19gHlCTnvanjPZjS/KbqZMg12elcIAlJwc7WzI0eI2uQ5wfmPqVqOFSmFJd2BHEGy5C4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4d:b0:3cf:bb11:a3a7 with SMTP id
 e9e14a558f8ab-3d2caee673amr35317745ab.17.1740155304262; Fri, 21 Feb 2025
 08:28:24 -0800 (PST)
Date: Fri, 21 Feb 2025 08:28:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b8a9a8.050a0220.14d86d.0579.GAE@google.com>
Subject: [syzbot] [mm?] KMSAN: uninit-value in __alloc_frozen_pages_noprof
From: syzbot <syzbot+0cfd5e38e96a5596f2b6@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    27eddbf34490 Merge tag 'net-6.14-rc4' of git://git.kernel...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=133a6ba4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8cf1217edc1cc7da
dashboard link: https://syzkaller.appspot.com/bug?extid=0cfd5e38e96a5596f2b6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12dff5b0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=179fbba4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/31d2c5efefde/disk-27eddbf3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/18b5dc7f96c2/vmlinux-27eddbf3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f6a957d3f940/bzImage-27eddbf3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0cfd5e38e96a5596f2b6@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in __alloc_pages_slowpath+0xee8/0x16c0 mm/page_alloc.c:4416
 __alloc_pages_slowpath+0xee8/0x16c0 mm/page_alloc.c:4416
 __alloc_frozen_pages_noprof+0xa4c/0xe00 mm/page_alloc.c:4752
 alloc_pages_mpol+0x4cd/0x890 mm/mempolicy.c:2270
 alloc_frozen_pages_noprof mm/mempolicy.c:2341 [inline]
 alloc_pages_noprof mm/mempolicy.c:2361 [inline]
 folio_alloc_noprof+0x1dc/0x350 mm/mempolicy.c:2371
 filemap_alloc_folio_noprof+0xa6/0x440 mm/filemap.c:1019
 __filemap_get_folio+0xb9a/0x1840 mm/filemap.c:1970
 grow_dev_folio fs/buffer.c:1039 [inline]
 grow_buffers fs/buffer.c:1105 [inline]
 __getblk_slow fs/buffer.c:1131 [inline]
 bdev_getblk+0x2c9/0xab0 fs/buffer.c:1431
 getblk_unmovable include/linux/buffer_head.h:369 [inline]
 ext4_getblk+0x3b7/0xe50 fs/ext4/inode.c:864
 ext4_bread_batch+0x9f/0x7d0 fs/ext4/inode.c:933
 __ext4_find_entry+0x1ebb/0x36c0 fs/ext4/namei.c:1627
 ext4_lookup_entry fs/ext4/namei.c:1729 [inline]
 ext4_lookup+0x189/0xb40 fs/ext4/namei.c:1797
 __lookup_slow+0x538/0x710 fs/namei.c:1793
 lookup_slow+0x6a/0xd0 fs/namei.c:1810
 walk_component fs/namei.c:2114 [inline]
 link_path_walk+0xf29/0x1420 fs/namei.c:2479
 path_openat+0x30f/0x6250 fs/namei.c:3985
 do_filp_open+0x268/0x600 fs/namei.c:4016
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1428
 do_sys_open fs/open.c:1443 [inline]
 __do_sys_openat fs/open.c:1459 [inline]
 __se_sys_openat fs/open.c:1454 [inline]
 __x64_sys_openat+0x2a1/0x310 fs/open.c:1454
 x64_sys_call+0x36f5/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable compact_result created at:
 __alloc_pages_slowpath+0x66/0x16c0 mm/page_alloc.c:4218
 __alloc_frozen_pages_noprof+0xa4c/0xe00 mm/page_alloc.c:4752

CPU: 0 UID: 0 PID: 5126 Comm: syslogd Not tainted 6.14.0-rc3-syzkaller-00137-g27eddbf34490 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
=====================================================


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

