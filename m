Return-Path: <linux-kernel+bounces-194326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA2A8D3A3E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 17:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE23F1C23810
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 15:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E26E17F39E;
	Wed, 29 May 2024 15:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eTalXLN8"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FAE15991E
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 15:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716994983; cv=none; b=hScLMJCXprBu+7tmjR0LJCAHK5DLHvQvJeqD+5+HfgtH86Q/JhfY6Q546sn51Qf7N8Bkec9TwsheWiG17haJPmgy066+UOtef7GAZ3jNKD6PTW6YZXu8OMZWQVaGHUz7xO0rcxS38X0c46CELF47WNZFcp7oK+c3j0mDcsqHaWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716994983; c=relaxed/simple;
	bh=6uNWgGnSxo6sDvA3pIWhMfZ+SCGVX42Deu9AXDdU7is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4JId7cMjhBlxT2pNbSIOx0lQuxXEiBkdj2eBW22RSWE4RMxTxT0KCyer2VTMclqUTcBgdGAu3GBcYS5GdT23F0iuojpO5JBio/5QicXXkrQ4fZ7cYERkXaaqMdChP6FZDKRRtKb1uXn/z6pbmW0i4R+QKxDWNmyXyGKASD/GOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eTalXLN8; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: syzbot+17416257cb95200cba44@syzkaller.appspotmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716994977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1G4Orolc70FwGoHqDJFmJ45OthETZFDcXpL+e6XCoMM=;
	b=eTalXLN8LnSBBCfciD4iv/S5fDwsNUAM7Ky8dqgFr4PBysAL9tvSo76FeUg4gmcsEvRqbe
	Krp+UFPKW8UIiKUglaLcFPOiiQUeiSi2jdB/7/s4rMjn//bY/uthSDjEvc7N3hF7iYAHyX
	H+znS6K/GbXOY1ibVc9HAmcrcx5o9II=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: syzkaller-bugs@googlegroups.com
Date: Wed, 29 May 2024 08:02:52 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: syzbot <syzbot+17416257cb95200cba44@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] UBSAN: shift-out-of-bounds in try_to_shrink_lruvec
Message-ID: <2afuizvfwythsdbwfiz7hdcpi73znr354bcuoy2hjux6et4u5p@mustf2czcn2x>
References: <0000000000004d74b30619866a7f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000004d74b30619866a7f@google.com>
X-Migadu-Flow: FLOW_OUT

On Tue, May 28, 2024 at 09:49:20AM GMT, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    6dc544b66971 Add linux-next specific files for 20240528
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=146d3f84980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6a363b35598e573d
> dashboard link: https://syzkaller.appspot.com/bug?extid=17416257cb95200cba44
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11e41b72980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15f3d2d2980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/334699ab67f8/disk-6dc544b6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/4ca32b2218ce/vmlinux-6dc544b6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/400bc5f019b3/bzImage-6dc544b6.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+17416257cb95200cba44@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> UBSAN: shift-out-of-bounds in mm/vmscan.c:4715:21
> shift exponent -1 is negative
> CPU: 1 PID: 5094 Comm: syz-executor177 Not tainted 6.10.0-rc1-next-20240528-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>  ubsan_epilogue lib/ubsan.c:231 [inline]
>  __ubsan_handle_shift_out_of_bounds+0x3c8/0x420 lib/ubsan.c:468
>  get_nr_to_scan mm/vmscan.c:4715 [inline]
>  try_to_shrink_lruvec+0xa99/0xbb0 mm/vmscan.c:4761
>  lru_gen_shrink_lruvec mm/vmscan.c:4908 [inline]
>  shrink_lruvec+0x554/0x3070 mm/vmscan.c:5685
>  shrink_node_memcgs mm/vmscan.c:5921 [inline]
>  shrink_node+0xb17/0x4150 mm/vmscan.c:5961
>  shrink_zones mm/vmscan.c:6205 [inline]
>  do_try_to_free_pages+0x789/0x1cb0 mm/vmscan.c:6267
>  try_to_free_mem_cgroup_pages+0x48f/0xb10 mm/vmscan.c:6598
>  try_charge_memcg+0x704/0x1850 mm/memcontrol.c:2946
>  try_charge mm/memcontrol.c:3094 [inline]
>  charge_memcg+0xa2/0x160 mm/memcontrol.c:7532
>  __mem_cgroup_charge+0x27/0x80 mm/memcontrol.c:7547
>  mem_cgroup_charge include/linux/memcontrol.h:686 [inline]
>  shmem_alloc_and_add_folio+0x44b/0xbd0 mm/shmem.c:1663
>  shmem_get_folio_gfp+0x82d/0x1f50 mm/shmem.c:2041
>  shmem_read_folio_gfp+0xd6/0x170 mm/shmem.c:4944
>  drm_gem_get_pages+0x21b/0xe50 drivers/gpu/drm/drm_gem.c:568
>  drm_gem_shmem_get_pages+0xdd/0x290 drivers/gpu/drm/drm_gem_shmem_helper.c:177
>  drm_gem_shmem_vmap+0x2ba/0x630 drivers/gpu/drm/drm_gem_shmem_helper.c:335
>  drm_gem_vmap drivers/gpu/drm/drm_gem.c:1205 [inline]
>  drm_gem_vmap_unlocked+0x103/0x1d0 drivers/gpu/drm/drm_gem.c:1247
>  drm_gem_fb_vmap+0xa6/0x810 drivers/gpu/drm/drm_gem_framebuffer_helper.c:365
>  drm_atomic_helper_prepare_planes+0x2b2/0xb50 drivers/gpu/drm/drm_atomic_helper.c:2601
>  drm_atomic_helper_commit+0x18b/0x9f0 drivers/gpu/drm/drm_atomic_helper.c:2029
>  drm_atomic_commit+0x2ac/0x310 drivers/gpu/drm/drm_atomic.c:1514
>  drm_atomic_helper_update_plane+0x238/0x3a0 drivers/gpu/drm/drm_atomic_helper.c:3190
>  drm_mode_cursor_universal drivers/gpu/drm/drm_plane.c:1221 [inline]
>  drm_mode_cursor_common+0xd68/0x1570 drivers/gpu/drm/drm_plane.c:1280
>  drm_mode_cursor_ioctl+0xe1/0x160 drivers/gpu/drm/drm_plane.c:1330
>  drm_ioctl_kernel+0x33a/0x440 drivers/gpu/drm/drm_ioctl.c:744
>  drm_ioctl+0x611/0xad0 drivers/gpu/drm/drm_ioctl.c:841
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:907 [inline]
>  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f06b4225999
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fff29e89738 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f06b4225999
> RDX: 0000000020000340 RSI: 00000000c01c64a3 RDI: 0000000000000003
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0023647261632f69 R11: 0000000000000246 R12: 00007f06b426f036
> R13: 00007fff29e89770 R14: 00007fff29e897b0 R15: 0000000000000000
>  </TASK>
> ---[ end trace ]---
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

#syz test

From 47251f8cdafd8a5e6e242b8c9785fb38f130e088 Mon Sep 17 00:00:00 2001
From: Shakeel Butt <shakeel.butt@linux.dev>
Date: Wed, 29 May 2024 07:58:50 -0700
Subject: [PATCH] mm: vmscan: reset sc->priority on retry

The commit 6be5e186fd65 ("mm: vmscan: restore incremental cgroup
iteration") added a retry reclaim heuristic to iterate all the cgroups
before returning an unsuccessful reclaim retry but missed to reset the
sc->priority. Let's fix it.

Reported-by: syzbot+17416257cb95200cba44@syzkaller.appspotmail.com
Fixes: 6be5e186fd65 ("mm: vmscan: restore incremental cgroup iteration")
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/vmscan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index b9170f767353..731b009a142b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6317,6 +6317,7 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
 	 * meaningful forward progress. Avoid false OOMs in this case.
 	 */
 	if (!sc->memcg_full_walk) {
+		sc->priority = initial_priority;
 		sc->memcg_full_walk = 1;
 		goto retry;
 	}
-- 
2.43.0


