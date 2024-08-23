Return-Path: <linux-kernel+bounces-298080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5881395C1BD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 02:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DCC51F2434E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 00:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB5AC148;
	Fri, 23 Aug 2024 00:00:29 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75E7631
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 00:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724371229; cv=none; b=mURVPkU70X87HwlDq1ZVwD/1kAKHGOcAfy5I676lT4e4iP14VbQMHSeCs6F2LophdZHEqgKUYuYMnvk4AmkunUDvk5tMVNLUrz0Seaehy3UYqsvnwBY3aejoh3Jipxg+x/lR/MxMcaBteOaxBzPNh+HoHcakGkCWaDAtb8d+tgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724371229; c=relaxed/simple;
	bh=tVZ/FZQdi6cVMMx4oSiCbyzsSCTzaGzlqav3hYANfL0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=A85sQ0jHXAL4dpoqHLqnGWHryy5nPbgS1fwxDVYLPvBil+QlgyClXlBwoNbI32+zibbC2o3+Jr1/lLOir3EhmbqN01zLXACxGi/OrGt1vxa7Vc95G17tdmgWAogno448AbDb0nffgBpqMdts1npTsvtmeFTZ4utjj9xF+rsUPJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d465cd64bso18856235ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724371227; x=1724976027;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVRJSEL0nD2KAQwy+qrV2FzdIhqngme6cZPNpl0t6Oo=;
        b=Imkl84uZNCvZljJnRbmi6bYi9cPIaWUo+j4h7sXhJAUgLFi9DdStQh/UXN6BdTn9Zi
         n7Pb+TdJR3SNqyUR1JN4i1U9GxzvWepNXTtkAJ3JKQ1FlDfbW6lSEycT8bSvjhn1fLLE
         0LxCJjt865kl07hwOXWgc37/yPH78Gqxb0WcOh3TVg1xPmMZs3+e3BgDUwNo1C+Wx1f5
         kRGFi0CaPh6/rTcImurweyeUT24IKDbiQJwKwohAgAZmQdP/CxYZHapmwSsKTk4SJo4+
         n+KWq8PCQpXNY5W/J3d9uXen3lmHOKcp8c1uspJn8feI06jTV8Wh3hTsJTor+B4zllA3
         m2Xw==
X-Forwarded-Encrypted: i=1; AJvYcCWwQ+tmfhFQ11hOlJf2yxjnkSOicw4qKYiBjux5G11PBzlt1QRtHjpmbdqdGVaVHw4G2Kk2nsNX0eiu8q0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmZL9eORp1JVG4cCWz7q2PLzZFGQGEZU+Fma192DxzGH46+ju0
	AI6EMzAgBrgj5rFHO6PWz4rr08UB3/hsNbBpj7valTYlEEPvffqATuVtVPy3kc5LUIR4YFINMzI
	tuXy5uXLjroFirhO9lFy+zaOF6+XhKDcrBqQczyh1SK3NKX+tZVLzYrs=
X-Google-Smtp-Source: AGHT+IHXbHDGNacgb61MXzh5K83wTC7QH/vGfSUPjXAH8Dc9UTkiOleqFpQjekZZZgaaUAtOseHimbxptwskYbXOwhRIALYBxMwr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4c:b0:39a:e900:7e3e with SMTP id
 e9e14a558f8ab-39e3c9f0512mr284975ab.3.1724371226662; Thu, 22 Aug 2024
 17:00:26 -0700 (PDT)
Date: Thu, 22 Aug 2024 17:00:26 -0700
In-Reply-To: <0000000000002fda01061e334873@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006d2b8f06204e76f8@google.com>
Subject: Re: [syzbot] [erofs?] INFO: task hung in z_erofs_runqueue
From: syzbot <syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com>
To: chao@kernel.org, dhavale@google.com, hsiangkao@linux.alibaba.com, 
	huyue2@coolpad.com, jefflexu@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    048499f92ed7 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1118b433980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c686716759500c2
dashboard link: https://syzkaller.appspot.com/bug?extid=4fc98ed414ae63d1ada2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d09f83980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e3247b980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/66c48334a6dc/disk-048499f9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a8e45cac172b/vmlinux-048499f9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/80940291bc58/Image-048499f9.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f7747709ae10/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com

INFO: task syz-executor173:6412 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc4-syzkaller-g048499f92ed7 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor173 state:D stack:0     pid:6412  tgid:6412  ppid:6411   flags:0x00000005
Call trace:
 __switch_to+0x314/0x560 arch/arm64/kernel/process.c:553
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x13d4/0x2418 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xbc/0x238 kernel/sched/core.c:6621
 io_schedule+0x8c/0x124 kernel/sched/core.c:7401
 folio_wait_bit_common+0x65c/0xb90 mm/filemap.c:1307
 __folio_lock+0x2c/0x3c mm/filemap.c:1645
 folio_lock include/linux/pagemap.h:1050 [inline]
 z_erofs_fill_bio_vec fs/erofs/zdata.c:1470 [inline]
 z_erofs_submit_queue fs/erofs/zdata.c:1650 [inline]
 z_erofs_runqueue+0x838/0x17ec fs/erofs/zdata.c:1732
 z_erofs_readahead+0x858/0xc18 fs/erofs/zdata.c:1863
 read_pages+0x160/0x694 mm/readahead.c:160
 page_cache_ra_unbounded+0x484/0x584 mm/readahead.c:273
 do_page_cache_ra mm/readahead.c:303 [inline]
 force_page_cache_ra+0x22c/0x290 mm/readahead.c:332
 force_page_cache_readahead mm/internal.h:338 [inline]
 generic_fadvise+0x3e8/0x6a0 mm/fadvise.c:106
 vfs_fadvise mm/fadvise.c:185 [inline]
 ksys_fadvise64_64 mm/fadvise.c:199 [inline]
 __do_sys_fadvise64_64 mm/fadvise.c:207 [inline]
 __se_sys_fadvise64_64 mm/fadvise.c:205 [inline]
 __arm64_sys_fadvise64_64+0x12c/0x174 mm/fadvise.c:205
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffff80008f6edb60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0xc/0x44 include/linux/rcupdate.h:325
2 locks held by getty/6155:
 #0: ffff0000d23b60a0 (&tty->ldisc_sem){++++}-{0:0}, at: ldsem_down_read+0x3c/0x4c drivers/tty/tty_ldsem.c:340
 #1: ffff80009836e2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x41c/0x1228 drivers/tty/n_tty.c:2211
1 lock held by syz-executor173/6412:
 #0: ffff0000deee0330 (mapping.invalidate_lock#3){.+.+}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:854 [inline]
 #0: ffff0000deee0330 (mapping.invalidate_lock#3){.+.+}-{3:3}, at: page_cache_ra_unbounded+0xc8/0x584 mm/readahead.c:225

=============================================



---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

