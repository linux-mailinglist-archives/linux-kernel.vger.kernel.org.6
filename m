Return-Path: <linux-kernel+bounces-358570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E06269980F3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0286282686
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199A31C461A;
	Thu, 10 Oct 2024 08:44:31 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E931BD018
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 08:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728549870; cv=none; b=t76QhJeLUnFNAEY/vdNj3xFaB8bs8+c27wqy4UtwAF3l6UgYltmSNlmUAs0XkBoqPl/2xhg6uB/FB5/t3J2uIEQeHfAqxw6yGnTgABZCAgcHGDSYQ5YydZL0SjmGWC12bdMdO0pLJbMXZ2uOdC9pKAVex8i/sTE4RgNg6VwFyyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728549870; c=relaxed/simple;
	bh=YcJ7gx82npwIKurhKJuA/T8l955PB6F8RJEEnXhVFow=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fvNghtwPO8UXQv1ewFcDfAZbvhVKUyd2pmdAGIxXHzZl2eJaUQRAuM0a79S7D0mw/XJr5c/I+t2xD/x91A55ubOLUgKj8RrCJspAldYh47zTCy1HUT2qUwGfW0f7k6Mk9YbCY8Mo2Qk5C/45VYFTeMBx7nfSt86NOQHp8a5z1zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a34988d6b4so12037405ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 01:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728549867; x=1729154667;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sYbSMepZyDYQYd2ij9BYBvz9J5ZkOicUkA9xWdyI/CI=;
        b=Q10aTLcUo13EnLebjVYfE0Kfb4u1G+6MCXo8OTEzP/xcYipxzfY1m4B1ZWrUUiBL4u
         zdtBnfgparp2doeo442XSXvmi2e5IcC03iwQWYYgcE7L3gm1RpsGjqUzJmlhFHnHHNRe
         PaGgVVYV9FvtBUE4sA+W1QNM/3jUYxdFPJyvqfQIaoLOXgUP7jyBvz556LtFt936gfkY
         KG1vx98OihNoQBPuzD1i0NFe+5Ft2Ok05FeZ4Tgxgom/TznAebxV5mVGdgb322jnXZ0Y
         sdnxmxJbWaHXqabIqav+nUexh/7rGMRkIKn/l37zRGEVX9D9H618VvX49T3PXOU0OWyI
         sl7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTGfLklKncDKGTabICyCfN/5r3GAJkhSHMDtLwyOOnOW2NGaCbKlf6uXA7xjwjMVk6fkxReR6cssTh06c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4C9qvG+DyBzUYQTLBqy8avR+DxBilryWl1OFx7mziNbZ9klDi
	nPxv6oGtplRJsglaUGjqVK73nm0j6BU8syKk/vu0spuXM77WO+MBmEXhe3x/LRhn3qZULHR8ga7
	1mFIPcLbi6ralpMb+xt0YFFXzh3kvLjuGDSlcmY3fCmuEcXsvlTkIElQ=
X-Google-Smtp-Source: AGHT+IHWqfE5d+PTxyair+ZeYoidTVwqJMFXMyLHueyk8hbzyXCa8YkYEf9zIfU7/E0bvynWILTdvHgAtIT1EH33paUWY589YPdh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a07:b0:3a3:6b20:5e20 with SMTP id
 e9e14a558f8ab-3a397d0aecamr57970545ab.13.1728549867161; Thu, 10 Oct 2024
 01:44:27 -0700 (PDT)
Date: Thu, 10 Oct 2024 01:44:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670793eb.050a0220.8109b.0003.GAE@google.com>
Subject: [syzbot] [mm?] KMSAN: uninit-value in swap_writepage
From: syzbot <syzbot+febb2473441bfb8fb380@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fc20a3e57247 Merge tag 'for-linus-6.12a-rc2-tag' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11cdfd27980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d302f14701986aa0
dashboard link: https://syzkaller.appspot.com/bug?extid=febb2473441bfb8fb380
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5b4b9aca7b75/disk-fc20a3e5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b22e17636ec0/vmlinux-fc20a3e5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5266e625be99/bzImage-fc20a3e5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+febb2473441bfb8fb380@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in is_folio_zero_filled mm/page_io.c:189 [inline]
BUG: KMSAN: uninit-value in swap_writepage+0x536/0x12b0 mm/page_io.c:259
 is_folio_zero_filled mm/page_io.c:189 [inline]
 swap_writepage+0x536/0x12b0 mm/page_io.c:259
 shmem_writepage+0x2117/0x2450 mm/shmem.c:1567
 pageout mm/vmscan.c:688 [inline]
 shrink_folio_list+0x5e78/0x7dd0 mm/vmscan.c:1366
 evict_folios+0x9813/0xbaf0 mm/vmscan.c:4583
 try_to_shrink_lruvec+0x13a3/0x1750 mm/vmscan.c:4778
 shrink_one+0x646/0xd20 mm/vmscan.c:4816
 shrink_many mm/vmscan.c:4879 [inline]
 lru_gen_shrink_node mm/vmscan.c:4957 [inline]
 shrink_node+0x451a/0x50f0 mm/vmscan.c:5937
 kswapd_shrink_node mm/vmscan.c:6765 [inline]
 balance_pgdat mm/vmscan.c:6957 [inline]
 kswapd+0x25e2/0x42f0 mm/vmscan.c:7226
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 __alloc_pages_noprof+0x9d6/0xe70 mm/page_alloc.c:4756
 alloc_pages_mpol_noprof+0x299/0x990 mm/mempolicy.c:2265
 folio_alloc_mpol_noprof+0x55/0x180 mm/mempolicy.c:2283
 shmem_alloc_folio mm/shmem.c:1774 [inline]
 shmem_alloc_and_add_folio+0xc33/0x1c30 mm/shmem.c:1813
 shmem_get_folio_gfp+0xacd/0x1f30 mm/shmem.c:2335
 shmem_get_folio mm/shmem.c:2441 [inline]
 shmem_symlink+0x528/0xa20 mm/shmem.c:3834
 vfs_symlink+0x1ed/0x460 fs/namei.c:4615
 do_symlinkat+0x257/0x8a0 fs/namei.c:4641
 __do_sys_symlink fs/namei.c:4662 [inline]
 __se_sys_symlink fs/namei.c:4660 [inline]
 __x64_sys_symlink+0xe0/0x140 fs/namei.c:4660
 x64_sys_call+0x30e8/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:89
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 80 Comm: kswapd0 Tainted: G        W          6.12.0-rc1-syzkaller-00330-gfc20a3e57247 #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
=====================================================


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

