Return-Path: <linux-kernel+bounces-436150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B34F09E81CF
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 20:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F4063281A33
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 19:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535D01534FB;
	Sat,  7 Dec 2024 19:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="seW+r7j1"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E098B38FA3
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 19:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733599851; cv=none; b=OtwmhSTmHoJCbRngjuOQFDiee8ZaD4hXbxBOzr7qUTfXoXPLLsXZdk7UJ7w/JzMpSWFGBYcOxl1H/2+xRI/tmgeC3xIR9qdHzgmQwR6d0UdAKZpik7E04Lj1PxLg1cBnfjZSMaZ5wCfU5Mlep6B5lzvC96txQokBYUEMTh7Ndrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733599851; c=relaxed/simple;
	bh=+W+EfzKmK5TAtIQW28p2iwyfLPGqyqt+FTxz4XtyZ5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpzMUSxtud7acBHHI8Zgo4aWBexKWZFJzfcgDLYKnRPmuhWe3NORFs1DXbGJjFT6HwlorGNTPNcLnZbDcO8U98AHgEnGqclAMkfctWmhQnNMO99uhYe3DDUEOG+46iM9E55TvGbdv1DjNi4Qs6/z3dJgfhU/rzRYqQKjx1L0NrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=seW+r7j1; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-215bebfba73so30532855ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 11:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733599849; x=1734204649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sJ3AriieDFC/KNsLogDoYyW1Ut0XorELbLlY0y1fh8w=;
        b=seW+r7j1fUyiI3wfUH2QfrgEXqwfOIX88mojUv7MSN295cbnT3SQWytkYWbIDZYBkn
         R9+OiQqQ+vG6CIp2LXhzbEoBkqBEHJugjNR0mhG9w9ou0qZ8iKu1nRVa60YVPhnFTKwU
         YmeUxKplURnE0zX7h1IJ7iHv9Sb/zRwHWAhlIwmIRCAk3nq9Zmg23Jnxv7V4PWAaxp80
         BqbOEZs1rXZ//ZQZ8jcmVIVepnRMZyN9NQQ+Nhpiep9hnNCrbod8nvtQHBn3BeAUd64A
         s1jlQtbMGP3aO4fyUfLNt9r5C3oW/dGvYHQinH2aFz/ychAKzwKwPLqNU0cNntRk4qFc
         UV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733599849; x=1734204649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJ3AriieDFC/KNsLogDoYyW1Ut0XorELbLlY0y1fh8w=;
        b=DdpRngm4NaXyDPem9Z2WcCLN3tlbDqWv1GnfML0nwJDXJnLlRE7SERxB0feNErV2c2
         2AT/Lk7sjdKISZPhBZg/4X2h8ajAVzk1X2Ld4l9cw1SHuMRA/ZUZZbW4Y80WT7NRDeAZ
         P1ES77NY5B/ZhQTnRXEye5p/a9GoVHFBqt5wPOi9riOdjgyg2+bHNCLH/IGBHoBSqk4L
         qb78IlLCLow7JQm7xMKKqe+pJV0asO4OaKdSIhBTh8/M6KGGjLK5gbNbvH01bDQbtPth
         XIJEgosFxQssovqVLeX8h/PtLiuGcOCBU/t6OOwJQtxRMUMQpex5EFd0xbOj8F5VmI02
         Wx5A==
X-Forwarded-Encrypted: i=1; AJvYcCWOMBynafJP6PvgdVsAeyr7i6sbOjUli//D1G4Az0eFrkVg339ZMHfpOTym6TjXu5Yl/obL4ytuLgcvMs0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk813Q80faKuKLg4LxS9TzBB2h8Bf1kaX7iaWk2zgqiNbdy0Rw
	VJtoLr0xyBYCV/7ATSgWM7xVK6tj5Fluv++XvYFoAu7t3wzRcGfAbUhTPu+1zw==
X-Gm-Gg: ASbGncurMf6NVhjnRluLRH6RTkXRSeswzRrsK1mN+dcBB7ij++BJBkOLKBAMWZ5eG6e
	cvfi5aIcqSTppZZWWt0RCoEKI2AZUCaGmAdFNOToL22m/gewFbSIGnKpDHktd/F9k0Ay2mFmRoW
	UZLbz5pI6RD4maGLA8LRcO7U7NK4LuvkkjtL3+5uGbg7MkolGirj8aTwWWiJUwpdabzCQg9rUH1
	P0rdItKMnE7DFr88iOm+eGTyKCXtkxzrVI2zGaG4B81UGOgMntJnUKP72RoDTAdVGuF5KHAQAy2
	rdzc
X-Google-Smtp-Source: AGHT+IFZ5M9FL6gCR/DI1hKM4Xow7ROSGcnN4HIlFzNXPVtBw2MEhcCl4rJo0touOIVBUQyafX/vGw==
X-Received: by 2002:a17:902:f684:b0:216:34e5:6e49 with SMTP id d9443c01a7336-21634e58f45mr17129725ad.57.1733599848856;
        Sat, 07 Dec 2024 11:30:48 -0800 (PST)
Received: from google.com ([2a00:79e0:2e28:6:c5e3:4c27:49a5:9726])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21633b090a4sm9550445ad.112.2024.12.07.11.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 11:30:47 -0800 (PST)
Date: Sat, 7 Dec 2024 12:30:41 -0700
From: Yu Zhao <yuzhao@google.com>
To: syzbot <syzbot+67a21f2b4c8e9e650adf@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, kaleshsingh@google.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] WARNING in lru_gen_clear_refs
Message-ID: <Z1SiYXv7zgdh0lnj@google.com>
References: <67549eca.050a0220.2477f.001b.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67549eca.050a0220.2477f.001b.GAE@google.com>

On Sat, Dec 07, 2024 at 11:15:22AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    af2ea8ab7a54 Add linux-next specific files for 20241205
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1210e8df980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=76f158395f6f15fd
> dashboard link: https://syzkaller.appspot.com/bug?extid=67a21f2b4c8e9e650adf
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=111050f8580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=136fade8580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/8af0861258fa/disk-af2ea8ab.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/ffb38cf7a344/vmlinux-af2ea8ab.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/6fbd2e50358a/bzImage-af2ea8ab.xz
> 
> The issue was bisected to:
> 
> commit 51ac493f56fa00b052be4fbc94ac91f057ebc2e7
> Author: Yu Zhao <yuzhao@google.com>
> Date:   Mon Dec 2 03:28:19 2024 +0000
> 
>     mm/mglru: optimize deactivation
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=141418df980000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=161418df980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=121418df980000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+67a21f2b4c8e9e650adf@syzkaller.appspotmail.com
> Fixes: 51ac493f56fa ("mm/mglru: optimize deactivation")
> 
>  __kernel_write_iter+0x42a/0x940 fs/read_write.c:612
>  __kernel_write fs/read_write.c:632 [inline]
>  kernel_write+0x214/0x330 fs/read_write.c:653
>  process_sysctl_arg+0x3f7/0x650 fs/proc/proc_sysctl.c:1683
>  parse_one kernel/params.c:153 [inline]
>  parse_args+0x623/0xdc0 kernel/params.c:186
>  do_sysctl_args+0xeb/0x180 fs/proc/proc_sysctl.c:1715
>  kernel_init+0x80/0x2b0 init/main.c:1489
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> page_owner free stack trace missing
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 5828 at ./include/linux/memcontrol.h:730 folio_lruvec include/linux/memcontrol.h:730 [inline]
> WARNING: CPU: 0 PID: 5828 at ./include/linux/memcontrol.h:730 lru_gen_clear_refs+0x498/0x520 mm/swap.c:410
> Modules linked in:
> CPU: 0 UID: 0 PID: 5828 Comm: syz-executor425 Not tainted 6.13.0-rc1-next-20241205-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> RIP: 0010:folio_lruvec include/linux/memcontrol.h:730 [inline]
> RIP: 0010:lru_gen_clear_refs+0x498/0x520 mm/swap.c:410
> Code: 66 ff ff ff e8 99 dc c2 ff e9 92 fe ff ff e8 8f dc c2 ff 4c 89 e7 48 c7 c6 20 c9 13 8c e8 20 95 0c 00 c6 05 4c 86 27 0e 01 90 <0f> 0b 90 e9 7b fc ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 43 fd
> RSP: 0018:ffffc90003787460 EFLAGS: 00010246
> RAX: dc5da43f42521400 RBX: 0000000000000000 RCX: ffffc90003787003
> RDX: 0000000000000002 RSI: ffffffff8c0aa440 RDI: ffffffff8c5fbe80
> RBP: ffffc90003787530 R08: ffffffff9019d9b7 R09: 1ffffffff2033b36
> R10: dffffc0000000000 R11: fffffbfff2033b37 R12: ffffea00006a8000
> R13: 1ffffd40000d5000 R14: 00fff00000000058 R15: 0000000000000000
> FS:  0000555587a6b380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000040 CR3: 000000007213e000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  deactivate_file_folio+0x99/0x100 mm/swap.c:679
>  mapping_try_invalidate+0x28b/0x550 mm/truncate.c:489
>  drop_pagecache_sb+0x1ab/0x260 fs/drop_caches.c:40
>  iterate_supers+0xc6/0x190 fs/super.c:934
>  drop_caches_sysctl_handler+0x8c/0x160 fs/drop_caches.c:64
>  proc_sys_call_handler+0x5ec/0x920 fs/proc/proc_sysctl.c:601
>  do_iter_readv_writev+0x600/0x880
>  vfs_writev+0x376/0xba0 fs/read_write.c:1050
>  do_writev+0x1b6/0x360 fs/read_write.c:1096
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f625e20b329
> Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffc4d77ac58 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
> RAX: ffffffffffffffda RBX: 00007ffc4d77ae28 RCX: 00007f625e20b329
> RDX: 0000000000000001 RSI: 00000000200000c0 RDI: 0000000000000003
> RBP: 00007f625e27e610 R08: 0000000000000000 R09: 00007ffc4d77ae28
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007ffc4d77ae18 R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-unstable

diff --git a/mm/swap.c b/mm/swap.c
index 320b959b74c6..062c8565b899 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -384,7 +384,7 @@ static void lru_gen_inc_refs(struct folio *folio)
 {
 	unsigned long new_flags, old_flags = READ_ONCE(folio->flags);
 
-	if (folio_test_unevictable(folio))
+	if (!folio_test_lru(folio) || folio_test_unevictable(folio))
 		return;
 
 	/* see the comment on LRU_REFS_FLAGS */
@@ -405,14 +405,17 @@ static void lru_gen_inc_refs(struct folio *folio)
 
 static bool lru_gen_clear_refs(struct folio *folio)
 {
-	int gen = folio_lru_gen(folio);
+	struct lru_gen_folio *lrugen;
 	int type = folio_is_file_lru(folio);
-	struct lru_gen_folio *lrugen = &folio_lruvec(folio)->lrugen;
+
+	if (!folio_test_lru(folio) || folio_test_unevictable(folio))
+		return true;
 
 	set_mask_bits(&folio->flags, LRU_REFS_FLAGS | BIT(PG_workingset), 0);
 
+	lrugen = &folio_lruvec(folio)->lrugen;
 	/* whether can do without shuffling under the LRU lock */
-	return gen == lru_gen_from_seq(READ_ONCE(lrugen->min_seq[type]));
+	return folio_lru_gen(folio) == lru_gen_from_seq(READ_ONCE(lrugen->min_seq[type]));
 }
 
 #else /* !CONFIG_LRU_GEN */

