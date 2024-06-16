Return-Path: <linux-kernel+bounces-216428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CAC909F2E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 20:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7F58282E3C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 18:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C426EB4D;
	Sun, 16 Jun 2024 18:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fg4xDFaF"
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009BD757F0
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 18:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718562279; cv=none; b=dhYbZjY9ZSWk742jAQB6MZSCZO4gQGhOG53upPBj8qSOdUbPHVgt2Vdj2kI8+p4UNUFNFYRzHNR8L/s1YloDRHo80CeiAHuUsfTJXK8YahEPNDl68AbdfaKfZhiG4L9p+b5/xX/eWGRprCFEF49jbZNpDMcg9f2ZP6DLDDgLqzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718562279; c=relaxed/simple;
	bh=9aQbROJJacasVHB0PYfd7B7a04QeCVBjogCcmr26hGY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=KjuYKrmSuJL4cmIm2j1Jke4JxEsFKMl1f76dAYqybwuE2aDlGk9eOvUL5ZKFPk+8kysdHd2tYu9zYWF/q06mvP+cHDUfXveFYeOX04tFjg95OkBdHUHA5e5D/70FjX9M6DWfiyOIvxi7kcG9T72U3CUOOoeR2NdltK9049K0JW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fg4xDFaF; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-795482e114cso300553985a.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 11:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718562276; x=1719167076; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OA5RrKHq6U5NOhutDc9FWGoFGxMbg9Hkcrkyxe1CR6Q=;
        b=fg4xDFaF5KJHusxK4xauS8QvWPq3RJpNTx/wPG5kPzcsSjCsjjSSaPP/d+lB8iZpwT
         /Mq2EW5BZRtfWt/LBaXRgDnxqxWCP/pKo+/h2pStqhuJqwliI3XlatS7WU0zpVIeJu+I
         pqvEXbrWCwZMhshDhXvRo8jfTvX/sGj/IpI3pB6456uOjqI9g7qQTOk+IWwzEF09O/sS
         IgFoTR3/oyTShGH9BmC8ElX4wLi4S3EgH4uVEe5g1XQxpSXIR0mqWHlz1wnlWWLOL9SL
         bGTVu7d3gyU+2qM1PSb4ytuULQmjmfnXsWgwjhCmctUhPUJe36CK8rJUhMZ1KcOtZBIa
         ncSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718562276; x=1719167076;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OA5RrKHq6U5NOhutDc9FWGoFGxMbg9Hkcrkyxe1CR6Q=;
        b=SZCk4ipXQe76IA21vOYg6VE4mz3M8Eyc0Ab0q3HmB+9po2TKndBeSny/pLANgFpDjJ
         2GVWOoKKe512nt/bCnM0R57dW/yQAHRPeWga1v5EonNVD4zXOQJvqAmSe85gGMv425so
         kj1JraaxXPNZv7QaorQS4FkzhrQz4IF4xH0dlcB0nw41T2qu0UgbryyoEfUkM8i1CHZD
         6dcpkxL9pTwn/iSHwAIhj4Tj3Gqkje9FewE2VS7xx8i0HNUXGS3Nyo0yo7MJ5sLwa0Lg
         nKSHCWKroLQeMBrtCv05r0DnDbVU0C1saZ8y3EOnqpraGN5QpG50by1z10JnExJXZ70T
         3H8A==
X-Forwarded-Encrypted: i=1; AJvYcCVvuDYGOhh6oku7VQo2K91U82Vou6CR9ioBDSej/BTfYPhgbI179vNv94k9hAf0d803YeIVA9zGjTU528hFNC8VHZvJbxnhhmreB1Oh
X-Gm-Message-State: AOJu0Yw5DFcZ+2ZBJM3oJdCaM6SVK89PESkVrwOSBOrrCPL8YC2N8iT5
	wVWHCPuJLcXbusT5fsbddcmp8DK3dugct/SnPtUipXxS506F9axK
X-Google-Smtp-Source: AGHT+IGE3xYGW7JIoU/LBvBNtkd+YSk2U++cDfApTOVkpXG3xU0LsKxWVyeaf57eYln5el83nQqfNw==
X-Received: by 2002:a05:620a:4110:b0:795:5ca2:374e with SMTP id af79cd13be357-798d259c53fmr894491185a.54.1718562275655;
        Sun, 16 Jun 2024 11:24:35 -0700 (PDT)
Received: from smtpclient.apple ([2601:98a:4102:7e80:2c22:6bd5:784c:5f44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abc0ceeesm360177785a.73.2024.06.16.11.24.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jun 2024 11:24:35 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Follow-Up on Reported Kernel Bug KASAN: slab-out-of-bounds in
 gfs2_check_blk_type 
From: Shuangpeng Bai <shuangpengbai@gmail.com>
In-Reply-To: <95FA39C9-7D8E-4857-B103-4B0E8503C7B4@gmail.com>
Date: Sun, 16 Jun 2024 14:24:24 -0400
Cc: gfs2@lists.linux.dev,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5C25152C-6708-4200-95E6-449CA0EE49E6@gmail.com>
References: <95FA39C9-7D8E-4857-B103-4B0E8503C7B4@gmail.com>
To: agruenba@redhat.com
X-Mailer: Apple Mail (2.3774.300.61.1.2)

Dear Kernel Maintainers,

I hope this message finds you well.

I am writing to follow up on the recent bug report KASAN: =
slab-out-of-bounds in gfs2_check_blk_type. I was wondering if there have =
been any updates or progress on this issue. Additionally, please let me =
know if there is any assistance I can provide.

Thank you for your time and attention to this matter.

Best regards,
Shuangpeng


> On Jun 11, 2024, at 00:19, Shuangpeng Bai <shuangpengbai@gmail.com> =
wrote:
>=20
> Hi Kernel Maintainers,
>=20
> Our tool found a new kernel bug KASAN: slab-out-of-bounds in =
gfs2_check_blk_type. Please see the details below.
>=20
> Kernel commit: v6.9 (Commits on May 12, 2024)
> Kernel config: attachment
> C/Syz reproducer: attachment
>=20
> Please let me know for anything I can help.
>=20
> Best,
> Shuangpeng
>=20
>=20
> [   71.590873][ T8079] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ 71.593005][ T8079] BUG: KASAN: slab-out-of-bounds in =
gfs2_check_blk_type (fs/gfs2/rgrp.c:153 fs/gfs2/rgrp.c:2638)=20
> [   71.595063][ T8079] Read of size 8 at addr ffff888021a377d0 by task =
a.out/8079
> [   71.596905][ T8079]
> [   71.597832][ T8079] CPU: 0 PID: 8079 Comm: a.out Not tainted 6.9.0 =
#8
> [   71.600123][ T8079] Hardware name: QEMU Standard PC (i440FX + PIIX, =
1996), BIOS 1.15.0-1 04/01/2014
> [   71.603460][ T8079] Call Trace:
> [   71.604602][ T8079]  <TASK>
> [ 71.605683][ T8079] dump_stack_lvl (lib/dump_stack.c:117)=20
> [ 71.607296][ T8079] print_report (mm/kasan/report.c:378 =
mm/kasan/report.c:488)=20
> [ 71.608909][ T8079] ? __phys_addr (arch/x86/mm/physaddr.c:32 =
(discriminator 4))=20
> [ 71.610551][ T8079] ? gfs2_check_blk_type (fs/gfs2/rgrp.c:153 =
fs/gfs2/rgrp.c:2638)=20
> [ 71.612454][ T8079] kasan_report (mm/kasan/report.c:603)=20
> [ 71.613973][ T8079] ? gfs2_check_blk_type (fs/gfs2/rgrp.c:153 =
fs/gfs2/rgrp.c:2638)=20
> [ 71.615832][ T8079] gfs2_check_blk_type (fs/gfs2/rgrp.c:153 =
fs/gfs2/rgrp.c:2638)=20
> [ 71.617677][ T8079] ? __pfx_gfs2_check_blk_type (fs/gfs2/rgrp.c:2614)=20=

> [ 71.619723][ T8079] ? gfs2_evict_inode (fs/gfs2/super.c:1346 =
fs/gfs2/super.c:1492)=20
> [ 71.621526][ T8079] ? __gfs2_holder_init (fs/gfs2/glock.c:1272)=20
> [ 71.623447][ T8079] gfs2_evict_inode (fs/gfs2/super.c:1346 =
fs/gfs2/super.c:1492)=20
> [ 71.626079][ T8079] ? __pfx_sched_clock_cpu =
(kernel/sched/clock.c:389)=20
> [ 71.628057][ T8079] ? pick_eevdf (kernel/sched/fair.c:909)=20
> [ 71.629661][ T8079] ? __pfx_gfs2_evict_inode (fs/gfs2/super.c:1473)=20=

> [ 71.631511][ T8079] ? _raw_spin_unlock =
(./arch/x86/include/asm/preempt.h:103 =
./include/linux/spinlock_api_smp.h:143 kernel/locking/spinlock.c:186)=20
> [ 71.633165][ T8079] ? finish_task_switch.isra.0 =
(./arch/x86/include/asm/irqflags.h:42 =
./arch/x86/include/asm/irqflags.h:77 kernel/sched/sched.h:1399 =
kernel/sched/core.c:5163 kernel/sched/core.c:5281)=20
> [ 71.635270][ T8079] ? __inode_wait_for_writeback =
(fs/fs-writeback.c:1512)=20
> [ 71.637336][ T8079] ? __pfx___inode_wait_for_writeback =
(fs/fs-writeback.c:1512)=20
> [ 71.639501][ T8079] ? evict (fs/inode.c:672)=20
> [ 71.640957][ T8079] ? __pfx__raw_spin_lock =
(kernel/locking/spinlock.c:153)=20
> [ 71.642637][ T8079] ? __pfx__raw_spin_lock =
(kernel/locking/spinlock.c:153)=20
> [ 71.644575][ T8079] ? _raw_spin_lock =
(./arch/x86/include/asm/atomic.h:115 =
./include/linux/atomic/atomic-arch-fallback.h:2170 =
./include/linux/atomic/atomic-instrumented.h:1302 =
./include/asm-generic/qspinlock.h:111 ./include/linux/spinlock.h:187 =
./include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154)=20
> [ 71.646161][ T8079] ? __pfx_gfs2_evict_inode (fs/gfs2/super.c:1473)=20=

> [ 71.648103][ T8079] evict (fs/inode.c:672)=20
> [ 71.649493][ T8079] iput.part.0 (fs/inode.c:1741 fs/inode.c:1767)=20
> [ 71.650985][ T8079] ? __pfx_gfs2_drop_inode (fs/gfs2/super.c:1025)=20
> [ 71.652903][ T8079] iput (fs/inode.c:1769)=20
> [ 71.654195][ T8079] dentry_unlink_inode (fs/dcache.c:401)=20
> [ 71.655902][ T8079] __dentry_kill (fs/dcache.c:606)=20
> [ 71.657456][ T8079] dput (fs/dcache.c:846 fs/dcache.c:833)=20
> [ 71.658782][ T8079] shrink_dcache_for_umount =
(./include/linux/list_bl.h:74 fs/dcache.c:1557)=20
> [ 71.660731][ T8079] generic_shutdown_super (fs/super.c:620)=20
> [ 71.662500][ T8079] kill_block_super (fs/super.c:1676)=20
> [ 71.664147][ T8079] gfs2_kill_sb (fs/gfs2/ops_fstype.c:1805)=20
> [ 71.665748][ T8079] deactivate_locked_super (fs/super.c:433 =
fs/super.c:474)=20
> [ 71.667612][ T8079] deactivate_super (fs/super.c:507)=20
> [ 71.669282][ T8079] cleanup_mnt (fs/namespace.c:144 =
fs/namespace.c:1268)=20
> [ 71.670805][ T8079] task_work_run (kernel/task_work.c:181 =
(discriminator 1))=20
> [ 71.672412][ T8079] ? __pfx_task_work_run (kernel/task_work.c:148)=20
> [ 71.674201][ T8079] ? __put_net (net/core/net_namespace.c:689)=20
> [ 71.675709][ T8079] do_exit (kernel/exit.c:879)=20
> [ 71.677175][ T8079] ? __count_memcg_events (mm/memcontrol.c:723 =
mm/memcontrol.c:962)=20
> [ 71.679117][ T8079] ? __pfx_do_exit (kernel/exit.c:819)=20
> [ 71.680723][ T8079] ? __pfx__raw_spin_lock_irq =
(kernel/locking/spinlock.c:169)=20
> [ 71.682564][ T8079] ? zap_other_threads (kernel/signal.c:1390)=20
> [ 71.684339][ T8079] do_group_exit (kernel/exit.c:1008)=20
> [ 71.685853][ T8079] __x64_sys_exit_group (kernel/exit.c:1036)=20
> [ 71.687482][ T8079] do_syscall_64 (arch/x86/entry/common.c:52 =
arch/x86/entry/common.c:83)=20
> [ 71.689990][ T8079] entry_SYSCALL_64_after_hwframe =
(arch/x86/entry/entry_64.S:130)=20
> [   71.691214][ T8079] RIP: 0033:0x7f5ca99d3146
> [ 71.692267][ T8079] Code: Unable to access opcode bytes at =
0x7f5ca99d311c.
>=20
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   71.693702][ T8079] RSP: 002b:00007ffe66c629e8 EFLAGS: 00000246 =
ORIG_RAX: 00000000000000e7
> [   71.695408][ T8079] RAX: ffffffffffffffda RBX: 00007f5ca9ad88a0 =
RCX: 00007f5ca99d3146
> [   71.697059][ T8079] RDX: 0000000000000001 RSI: 000000000000003c =
RDI: 0000000000000001
> [   71.698635][ T8079] RBP: 0000000000000001 R08: 00000000000000e7 =
R09: ffffffffffffff80
> [   71.700276][ T8079] R10: 0000000000000002 R11: 0000000000000246 =
R12: 00007f5ca9ad88a0
> [   71.702040][ T8079] R13: 0000000000000001 R14: 00007f5ca9ae12e8 =
R15: 0000000000000000
> [   71.703663][ T8079]  </TASK>
> [   71.704290][ T8079]
> [   71.704752][ T8079] Allocated by task 8079:
> [ 71.705650][ T8079] kasan_save_stack (mm/kasan/common.c:48)=20
> [ 71.706631][ T8079] kasan_save_track =
(./arch/x86/include/asm/current.h:49 mm/kasan/common.c:60 =
mm/kasan/common.c:69)=20
> [ 71.707574][ T8079] __kasan_kmalloc (mm/kasan/common.c:391)=20
> [ 71.708505][ T8079] __kmalloc (./include/linux/kasan.h:211 =
mm/slub.c:3972 mm/slub.c:3985)=20
> [ 71.709364][ T8079] read_rindex_entry (./include/linux/slab.h:665 =
./include/linux/slab.h:696 fs/gfs2/rgrp.c:766 fs/gfs2/rgrp.c:931)=20
> [ 71.710394][ T8079] gfs2_ri_update (fs/gfs2/rgrp.c:1002 =
(discriminator 1))=20
> [ 71.711339][ T8079] gfs2_rindex_update (fs/gfs2/rgrp.c:1051)=20
> [ 71.712483][ T8079] init_inodes (fs/gfs2/ops_fstype.c:913)=20
> [ 71.713427][ T8079] gfs2_fill_super (fs/gfs2/ops_fstype.c:1264)=20
> [ 71.714433][ T8079] get_tree_bdev (fs/super.c:1615)=20
> [ 71.715380][ T8079] gfs2_get_tree (fs/gfs2/ops_fstype.c:1342)=20
> [ 71.716319][ T8079] vfs_get_tree (fs/super.c:1780)=20
> [ 71.717229][ T8079] path_mount (fs/namespace.c:3353 =
fs/namespace.c:3679)=20
> [ 71.718124][ T8079] __x64_sys_mount (fs/namespace.c:3693 =
fs/namespace.c:3898 fs/namespace.c:3875 fs/namespace.c:3875)=20
> [ 71.719108][ T8079] do_syscall_64 (arch/x86/entry/common.c:52 =
arch/x86/entry/common.c:83)=20
> [ 71.720025][ T8079] entry_SYSCALL_64_after_hwframe =
(arch/x86/entry/entry_64.S:130)=20
> [   71.721224][ T8079]
> [   71.721838][ T8079] The buggy address belongs to the object at =
ffff888021a37780
> [   71.721838][ T8079]  which belongs to the cache kmalloc-96 of size =
96
> [   71.724602][ T8079] The buggy address is located 0 bytes to the =
right of
> [   71.724602][ T8079]  allocated 80-byte region [ffff888021a37780, =
ffff888021a377d0)
> [   71.727454][ T8079]
> [   71.727931][ T8079] The buggy address belongs to the physical page:
> [   71.729233][ T8079] page: refcount:1 mapcount:0 =
mapping:0000000000000000 index:0x0 pfn:0x21a37
> [   71.730941][ T8079] ksm flags: =
0xfff00000000800(slab|node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> [   71.732522][ T8079] page_type: 0xffffffff()
> [   71.733415][ T8079] raw: 00fff00000000800 ffff888011c41780 =
ffffea0000860340 dead000000000003
> [   71.735106][ T8079] raw: 0000000000000000 0000000080200020 =
00000001ffffffff 0000000000000000
> [   71.736792][ T8079] page dumped because: kasan: bad access detected
> [   71.738102][ T8079] page_owner tracks the page as allocated
> [   71.739229][ T8079] page last allocated via order 0, migratetype =
Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid =
1, tgid 1 (swapper/0), ts 18270934128, free_ts 182673967
> [ 71.742812][ T8079] post_alloc_hook (./include/linux/page_owner.h:32 =
mm/page_alloc.c:1534)=20
> [ 71.743828][ T8079] get_page_from_freelist (mm/page_alloc.c:1543 =
mm/page_alloc.c:3317)=20
> [ 71.744948][ T8079] __alloc_pages (mm/page_alloc.c:4576)=20
> [ 71.745863][ T8079] allocate_slab (mm/slub.c:2181 mm/slub.c:2343)=20
> [ 71.746796][ T8079] ___slab_alloc (mm/slub.c:3531)=20
> [ 71.747698][ T8079] __slab_alloc.constprop.0 (mm/slub.c:3615)=20
> [ 71.748821][ T8079] kmalloc_trace (mm/slub.c:3668 mm/slub.c:3841 =
mm/slub.c:3998)=20
> [ 71.749739][ T8079] call_usermodehelper_setup (kernel/umh.c:364)=20
> [ 71.750918][ T8079] kobject_uevent_env (lib/kobject_uevent.c:613)=20
> [ 71.752105][ T8079] param_sysfs_builtin_init (kernel/params.c:822 =
kernel/params.c:856 kernel/params.c:990)=20
> [ 71.753257][ T8079] do_one_initcall (init/main.c:1245)=20
> [ 71.754155][ T8079] kernel_init_freeable (init/main.c:1306 =
init/main.c:1323 init/main.c:1342 init/main.c:1555)=20
> [ 71.755340][ T8079] kernel_init (init/main.c:1446)=20
> [ 71.756346][ T8079] ret_from_fork (arch/x86/kernel/process.c:153)=20
> [ 71.757242][ T8079] ret_from_fork_asm (arch/x86/entry/entry_64.S:257)=20=

> [   71.758204][ T8079] page last free pid 8 tgid 8 stack trace:
> [ 71.759381][ T8079] free_unref_page_prepare =
(./include/linux/page_owner.h:25 mm/page_alloc.c:1141 =
mm/page_alloc.c:2347)=20
> [ 71.760517][ T8079] free_unref_page (mm/page_alloc.c:2487)=20
> [ 71.761655][ T8079] vfree.part.0 (./include/linux/sched.h:1988 =
mm/vmalloc.c:3341)=20
> [ 71.762567][ T8079] delayed_vfree_work (mm/vmalloc.c:3260 =
(discriminator 1))=20
> [ 71.763552][ T8079] process_one_work (kernel/workqueue.c:3272)=20
> [ 71.764550][ T8079] worker_thread (kernel/workqueue.c:3342 =
kernel/workqueue.c:3429)=20
> [ 71.765490][ T8079] kthread (kernel/kthread.c:388)=20
> [ 71.766344][ T8079] ret_from_fork (arch/x86/kernel/process.c:153)=20
> [ 71.767258][ T8079] ret_from_fork_asm (arch/x86/entry/entry_64.S:257)=20=

> [   71.768206][ T8079]
> [   71.768674][ T8079] Memory state around the buggy address:
> [   71.769194][ T8079]  ffff888021a37680: fa fb fb fb fb fb fb fb fb =
fb fb fb fc fc fc fc
> [   71.769942][ T8079]  ffff888021a37700: 00 00 00 00 00 00 00 00 00 =
00 00 00 fc fc fc fc
> [   71.770679][ T8079] >ffff888021a37780: 00 00 00 00 00 00 00 00 00 =
00 fc fc fc fc fc fc
> [   71.771410][ T8079]                                                 =
 ^
> [   71.772016][ T8079]  ffff888021a37800: fa fb fb fb fb fb fb fb fb =
fb fb fb fc fc fc fc
> [   71.772768][ T8079]  ffff888021a37880: fa fb fb fb fb fb fb fb fb =
fb fb fb fc fc fc fc
> [   71.773516][ T8079] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   71.778624][ T8079] Kernel panic - not syncing: KASAN: =
panic_on_warn set ...
> [   71.780113][ T8079] CPU: 0 PID: 8079 Comm: a.out Not tainted 6.9.0 =
#8
> [   71.781462][ T8079] Hardware name: QEMU Standard PC (i440FX + PIIX, =
1996), BIOS 1.15.0-1 04/01/2014
> [   71.783278][ T8079] Call Trace:
> [   71.783932][ T8079]  <TASK>
> [ 71.784536][ T8079] dump_stack_lvl (lib/dump_stack.c:118 =
(discriminator 4))=20
> [ 71.785477][ T8079] panic (kernel/panic.c:348)=20
> [ 71.786276][ T8079] ? __pfx_panic (kernel/panic.c:282)=20
> .787159][ T8079]
> 1? preeMmessapge ft_schedule_romth suynk+sl0ogdx@s1yzkallaer/ 0x3at0 =
Jun
> 1 04:06:[ 71.789194][ T8079] ? preempt_schedule_common =
(./arch/x86/include/asm/preempt.h:84 kernel/sched/core.c:6927)=20
> [ 71.790322][ T8079] ? check_panic_on_warn (kernel/panic.c:240)=20
> [ 71.791312][ T8079] ? gfs2_check_blk_type (fs/gfs2/rgrp.c:153 =
fs/gfs2/rgrp.c:2638)=20
> [ 71.792378][ T8079] check_panic_on_warn (kernel/panic.c:241)=20
> [ 71.793372][ T8079] end_report (mm/kasan/report.c:226)=20
> [ 71.794210][ T8079] kasan_report (./arch/x86/include/asm/smap.h:56 =
mm/kasan/report.c:606)=20
> [ 71.795072][ T8079] ? gfs2_check_blk_type (fs/gfs2/rgrp.c:153 =
fs/gfs2/rgrp.c:2638)=20
> [ 71.796124][ T8079] gfs2_check_blk_type (fs/gfs2/rgrp.c:153 =
fs/gfs2/rgrp.c:2638)=20
> [ 71.797166][ T8079] ? __pfx_gfs2_check_blk_type (fs/gfs2/rgrp.c:2614)=20=

> [ 71.798273][ T8079] ? gfs2_evict_inode (fs/gfs2/super.c:1346 =
fs/gfs2/super.c:1492)=20
> [ 71.799279][ T8079] ? __gfs2_holder_init (fs/gfs2/glock.c:1272)=20
> [ 71.800333][ T8079] gfs2_evict_inode (fs/gfs2/super.c:1346 =
fs/gfs2/super.c:1492)=20
> [ 71.801313][ T8079] ? __pfx_sched_clock_cpu =
(kernel/sched/clock.c:389)=20
> [ 71.802342][ T8079] ? pick_eevdf (kernel/sched/fair.c:909)=20
> [ 71.803240][ T8079] ? __pfx_gfs2_evict_inode (fs/gfs2/super.c:1473)=20=

> [ 71.804316][ T8079] ? _raw_spin_unlock =
(./arch/x86/include/asm/preempt.h:103 =
./include/linux/spinlock_api_smp.h:143 kernel/locking/spinlock.c:186)=20
> [ 71.805280][ T8079] ? finish_task_switch.isra.0 =
(./arch/x86/include/asm/irqflags.h:42 =
./arch/x86/include/asm/irqflags.h:77 kernel/sched/sched.h:1399 =
kernel/sched/core.c:5163 kernel/sched/core.c:5281)=20
> [ 71.806403][ T8079] ? __inode_wait_for_writeback =
(fs/fs-writeback.c:1512)=20
> [ 71.807560][ T8079] ? __pfx___inode_wait_for_writeback =
(fs/fs-writeback.c:1512)=20
> [ 71.808805][ T8079] ? evict (fs/inode.c:672)=20
> [ 71.809617][ T8079] ? __pfx__raw_spin_lock =
(kernel/locking/spinlock.c:153)=20
> [ 71.810623][ T8079] ? __pfx__raw_spin_lock =
(kernel/locking/spinlock.c:153)=20
> [ 71.811620][ T8079] ? _raw_spin_lock =
(./arch/x86/include/asm/atomic.h:115 =
./include/linux/atomic/atomic-arch-fallback.h:2170 =
./include/linux/atomic/atomic-instrumented.h:1302 =
./include/asm-generic/qspinlock.h:111 ./include/linux/spinlock.h:187 =
./include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154)=20
> [ 71.812546][ T8079] ? __pfx_gfs2_evict_inode (fs/gfs2/super.c:1473)=20=

> [ 71.813592][ T8079] evict (fs/inode.c:672)=20
> [ 71.814368][ T8079] iput.part.0 (fs/inode.c:1741 fs/inode.c:1767)=20
> [ 71.815242][ T8079] ? __pfx_gfs2_drop_inode (fs/gfs2/super.c:1025)=20
> [ 71.816287][ T8079] iput (fs/inode.c:1769)=20
> [ 71.817017][ T8079] dentry_unlink_inode (fs/dcache.c:401)=20
> [ 71.818015][ T8079] __dentry_kill (fs/dcache.c:606)=20
> [ 71.818920][ T8079] dput (fs/dcache.c:846 fs/dcache.c:833)=20
> [ 71.819674][ T8079] shrink_dcache_for_umount =
(./include/linux/list_bl.h:74 fs/dcache.c:1557)=20
> [ 71.820782][ T8079] generic_shutdown_super (fs/super.c:620)=20
> [ 71.821828][ T8079] kill_block_super (fs/super.c:1676)=20
> [ 71.822766][ T8079] gfs2_kill_sb (fs/gfs2/ops_fstype.c:1805)=20
> [ 71.823658][ T8079] deactivate_locked_super (fs/super.c:433 =
fs/super.c:474)=20
> [ 71.824712][ T8079] deactivate_super (fs/super.c:507)=20
> [ 71.825633][ T8079] cleanup_mnt (fs/namespace.c:144 =
fs/namespace.c:1268)=20
> [ 71.826501][ T8079] task_work_run (kernel/task_work.c:181 =
(discriminator 1))=20
> [ 71.827407][ T8079] ? __pfx_task_work_run (kernel/task_work.c:148)=20
> [ 71.828436][ T8079] ? __put_net (net/core/net_namespace.c:689)=20
> [ 71.829281][ T8079] do_exit (kernel/exit.c:879)=20
> [ 71.830111][ T8079] ? __count_memcg_events (mm/memcontrol.c:723 =
mm/memcontrol.c:962)=20
> [ 71.831169][ T8079] ? __pfx_do_exit (kernel/exit.c:819)=20
> [ 71.832055][ T8079] ? __pfx__raw_spin_lock_irq =
(kernel/locking/spinlock.c:169)=20
> [ 71.833161][ T8079] ? zap_other_threads (kernel/signal.c:1390)=20
> [ 71.834169][ T8079] do_group_exit (kernel/exit.c:1008)=20
> [ 71.835077][ T8079] __x64_sys_exit_group (kernel/exit.c:1036)=20
> [ 71.836064][ T8079] do_syscall_64 (arch/x86/entry/common.c:52 =
arch/x86/entry/common.c:83)=20
> [ 71.836965][ T8079] entry_SYSCALL_64_after_hwframe =
(arch/x86/entry/entry_64.S:130)=20
> [   71.838114][ T8079] RIP: 0033:0x7f5ca99d3146
> [ 71.838990][ T8079] Code: Unable to access opcode bytes at =
0x7f5ca99d311c.
>=20
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   71.840378][ T8079] RSP: 002b:00007ffe66c629e8 EFLAGS: 00000246 =
ORIG_RAX: 00000000000000e7
> [   71.841988][ T8079] RAX: ffffffffffffffda RBX: 00007f5ca9ad88a0 =
RCX: 00007f5ca99d3146
> [   71.843542][ T8079] RDX: 0000000000000001 RSI: 000000000000003c =
RDI: 0000000000000001
> [   71.845086][ T8079] RBP: 0000000000000001 R08: 00000000000000e7 =
R09: ffffffffffffff80
> [   71.846664][ T8079] R10: 0000000000000002 R11: 0000000000000246 =
R12: 00007f5ca9ad88a0
> [   71.848199][ T8079] R13: 0000000000000001 R14: 00007f5ca9ae12e8 =
R15: 0000000000000000
> [   71.849736][ T8079]  </TASK>
> [   71.850486][ T8079] Kernel Offset: disabled
> [   71.851322][ T8079] Rebooting in 86400 seconds..
>=20
> <repro.c><.config>
>=20


