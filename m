Return-Path: <linux-kernel+bounces-363255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A71A99BFAE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A3DE2834D3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 06:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B732E13C9C7;
	Mon, 14 Oct 2024 06:01:36 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0137085956
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 06:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728885696; cv=none; b=j4icOI/0MwVCr41bkHBKsIKvbz+M1D21V+zTCICvHOnJmTy2sH9G7q7sNwvIj7jHkRKDQY3QCDEdEvWP/xbgYEL/3gzJ5CMBU5HudufCz/AusUpFDLlgQ91cf8ZIs2SlRVHoP13PgibuQtEHzfNya4EsaooeC3CWecmwuFQFti4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728885696; c=relaxed/simple;
	bh=8BdQfTrtYsj7qHISXUSGac+FjdDzaE+vhCt3VsJK8Gk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=X881rEc7GjjISQVkX3f9V6wDtMgyO41g4b8Ayjso1P2gOocoUxoo9meRSuxGcgKEP49cckmcnAV0TgoDfIxLt/hjFjTgXetXKgoK56KsXAb2YD+adUDkDM4tXPa2kQ1Rl0sPRUfQ5KXWdsr7jMFpgnHfIBGurx4duYJf0uMSuG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83a69fb833dso162514639f.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 23:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728885693; x=1729490493;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OVRsmBtgs8jn5Jxv78t+D/S1/3+yYfQpKi0us3DL3gk=;
        b=VI7Jaj5ZYQEihlxWaDGAPAm428hthB2GSsCG6+L/g2aio9jNRme/MDWu44V7bY74Pa
         SiwOpbvKqi3d8JL49Qc3/+UYNTMB+5kbsSHDHB4oyE+41EkWzi44oqZxkk+ncNIeX/Kt
         +6AHlqPaHgMFqJD/M23UQuBS9a0WN4kzdQw0sNvSDlJAxcUh37wFHn2QI5WrRvXvOTib
         agCWL2OxkCrmuibAfY6cpjLLKbUCbrCwND90UZ5coYBIEtkZUDLpQfQDa8vwCp7W9myl
         3qrh96zVyB/pZgWDHfjyqbKq9PSim/u2hcrV0l7rv1cC+0UZuuhKQXcA4aDhMbyAOYzK
         w59g==
X-Forwarded-Encrypted: i=1; AJvYcCVkMao56Jg2yA5+mYjjxw3HIZxFcmzokylPxOiYWCYWfNjgGGPVbPa1+VSolK1IBXN65ekZ1KmvsZZIcCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG9+ngNrx0/ZmFy9F6qY44gUn2BNcMdAugEjl+vfuEDE4fiq5+
	eWErtaq12y8qBjdvKmgGvx7Hht+2hKiZxlGx4l2axPsfydLq1jBH+884/1gaOMEM8DnZXX64+et
	9V3FsMedxwmOz4ixkLahUYRnrrQ2rAgeHwneZWPE3fZXGU5jkBtdEVyM=
X-Google-Smtp-Source: AGHT+IHVx9kLvgXnhz7Zz4BB5/5F+PdK00AYgqb+sHSuU76EQ45VBa9u2GqvUl8BKZXeSQpF/Kk9CMC35iFaOhTfoXIeKwSigjH4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a25:b0:3a0:a070:b81 with SMTP id
 e9e14a558f8ab-3a3b603d139mr84962995ab.23.1728885693115; Sun, 13 Oct 2024
 23:01:33 -0700 (PDT)
Date: Sun, 13 Oct 2024 23:01:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670cb3bd.050a0220.4cbc0.0040.GAE@google.com>
Subject: [syzbot] [mm?] BUG: stack guard page was hit in compat_sys_open
From: syzbot <syzbot+0e1748603cc9f2dfc87d@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    27cc6fdf7201 Merge tag 'linux_kselftest-fixes-6.12-rc2' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13043307980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e3e4d87a80ed4297
dashboard link: https://syzkaller.appspot.com/bug?extid=0e1748603cc9f2dfc87d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-27cc6fdf.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ae2f7d656e32/vmlinux-27cc6fdf.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1b06a62cc1e5/bzImage-27cc6fdf.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0e1748603cc9f2dfc87d@syzkaller.appspotmail.com

BUG: TASK stack guard page was hit at ffffc90002b3ffb8 (stack is ffffc90002b40000..ffffc90002b48000)
Oops: stack guard page: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 12425 Comm: syz.2.2179 Not tainted 6.12.0-rc1-syzkaller-00306-g27cc6fdf7201 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:mark_lock+0x25/0xc60 kernel/locking/lockdep.c:4686
Code: 90 90 90 90 90 55 48 89 e5 41 57 41 56 41 89 d6 48 ba 00 00 00 00 00 fc ff df 41 55 41 54 53 48 83 e4 f0 48 81 ec 10 01 00 00 <48> c7 44 24 30 b3 8a b5 41 48 8d 44 24 30 48 c7 44 24 38 38 51 57
RSP: 0018:ffffc90002b3ffc0 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000003
RDX: dffffc0000000000 RSI: ffff888021edaf98 RDI: ffff888021eda440
RBP: ffffc90002b40100 R08: 0000000000000000 R09: 0000000000000006
R10: ffffffff9698ad37 R11: 0000000000000002 R12: dffffc0000000000
R13: ffff888021edaf98 R14: 0000000000000008 R15: ffff888021eda440
FS:  0000000000000000(0000) GS:ffff88802b400000(0063) knlGS:00000000f56f6b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: ffffc90002b3ffb8 CR3: 000000005f61e000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <#DF>
 </#DF>
 <TASK>
 mark_usage kernel/locking/lockdep.c:4646 [inline]
 __lock_acquire+0x906/0x3ce0 kernel/locking/lockdep.c:5156
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5825
 rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 rcu_read_lock include/linux/rcupdate.h:849 [inline]
 page_ext_get+0x3a/0x310 mm/page_ext.c:525
 __set_page_owner+0x9a/0x790 mm/page_owner.c:322
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x101e/0x3070 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x223/0x25c0 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x2c9/0x610 mm/mempolicy.c:2265
 alloc_slab_page mm/slub.c:2412 [inline]
 allocate_slab mm/slub.c:2578 [inline]
 new_slab+0x2ba/0x3f0 mm/slub.c:2631
 ___slab_alloc+0xd1d/0x16f0 mm/slub.c:3818
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 kmem_cache_alloc_noprof+0x2ae/0x2f0 mm/slub.c:4141
 p9_tag_alloc+0x9c/0x870 net/9p/client.c:281
 p9_client_prepare_req+0x19f/0x4d0 net/9p/client.c:644
 p9_client_zc_rpc.constprop.0+0x105/0x880 net/9p/client.c:793
 p9_client_read_once+0x443/0x820 net/9p/client.c:1560
 p9_client_read+0x13f/0x1b0 net/9p/client.c:1524
 v9fs_issue_read+0x115/0x310 fs/9p/vfs_addr.c:74
 netfs_retry_read_subrequests fs/netfs/read_retry.c:60 [inline]
 netfs_retry_reads+0x153a/0x1d00 fs/netfs/read_retry.c:232
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
 netfs_dispatch_unbuffered_reads fs/netfs/direct_read.c:103 [inline]
 netfs_unbuffered_read fs/netfs/direct_read.c:127 [inline]
 netfs_unbuffered_read_iter_locked+0x12f6/0x19b0 fs/netfs/direct_read.c:221
 netfs_unbuffered_read_iter+0xc5/0x100 fs/netfs/direct_read.c:256
 v9fs_file_read_iter+0xbf/0x100 fs/9p/vfs_file.c:361
 __kernel_read+0x3f1/0xb50 fs/read_write.c:527
 integrity_kernel_read+0x7f/0xb0 security/integrity/iint.c:28
 ima_calc_file_hash_tfm+0x2c9/0x3e0 security/integrity/ima/ima_crypto.c:480
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
 ima_calc_file_hash+0x1ba/0x490 security/integrity/ima/ima_crypto.c:568
 ima_collect_measurement+0x8a7/0xa10 security/integrity/ima/ima_api.c:293
 process_measurement+0x1271/0x2370 security/integrity/ima/ima_main.c:372
 ima_file_check+0xc1/0x110 security/integrity/ima/ima_main.c:572
 security_file_post_open+0x8e/0x210 security/security.c:3127
 do_open fs/namei.c:3776 [inline]
 path_openat+0x1419/0x2d60 fs/namei.c:3933
 do_filp_open+0x1dc/0x430 fs/namei.c:3960
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_compat_sys_open fs/open.c:1481 [inline]
 __se_compat_sys_open fs/open.c:1479 [inline]
 __ia32_compat_sys_open+0x147/0x1e0 fs/open.c:1479
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf740e579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f56f656c EFLAGS: 00000296 ORIG_RAX: 0000000000000005
RAX: ffffffffffffffda RBX: 0000000020000240 RCX: 0000000000000b00
RDX: 0000000000000008 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:mark_lock+0x25/0xc60 kernel/locking/lockdep.c:4686
Code: 90 90 90 90 90 55 48 89 e5 41 57 41 56 41 89 d6 48 ba 00 00 00 00 00 fc ff df 41 55 41 54 53 48 83 e4 f0 48 81 ec 10 01 00 00 <48> c7 44 24 30 b3 8a b5 41 48 8d 44 24 30 48 c7 44 24 38 38 51 57
RSP: 0018:ffffc90002b3ffc0 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000003
RDX: dffffc0000000000 RSI: ffff888021edaf98 RDI: ffff888021eda440
RBP: ffffc90002b40100 R08: 0000000000000000 R09: 0000000000000006
R10: ffffffff9698ad37 R11: 0000000000000002 R12: dffffc0000000000
R13: ffff888021edaf98 R14: 0000000000000008 R15: ffff888021eda440
FS:  0000000000000000(0000) GS:ffff88802b400000(0063) knlGS:00000000f56f6b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: ffffc90002b3ffb8 CR3: 000000005f61e000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	55                   	push   %rbp
   6:	48 89 e5             	mov    %rsp,%rbp
   9:	41 57                	push   %r15
   b:	41 56                	push   %r14
   d:	41 89 d6             	mov    %edx,%r14d
  10:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
  17:	fc ff df
  1a:	41 55                	push   %r13
  1c:	41 54                	push   %r12
  1e:	53                   	push   %rbx
  1f:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
  23:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
* 2a:	48 c7 44 24 30 b3 8a 	movq   $0x41b58ab3,0x30(%rsp) <-- trapping instruction
  31:	b5 41
  33:	48 8d 44 24 30       	lea    0x30(%rsp),%rax
  38:	48                   	rex.W
  39:	c7                   	.byte 0xc7
  3a:	44 24 38             	rex.R and $0x38,%al
  3d:	38 51 57             	cmp    %dl,0x57(%rcx)


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

