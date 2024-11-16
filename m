Return-Path: <linux-kernel+bounces-411785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D159CFF86
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 16:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 671F4B244F1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 15:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C983EA76;
	Sat, 16 Nov 2024 15:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRE3ms3B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6768218027
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731771145; cv=none; b=JOi/G+UL5QSPFyivpzWatm+BMKP/eB7P8Tec5yVIdB7KJIMWLi/sOBN0wUglwYVWykFM/yixLvhrukuujV7l5z4mfZapXFXG+CLzOdpPQE0oUpoCOop47Xxoj3zdrPQvqea7gdcC4Csjxje1LADYjTpmrYw/6om6nQkBjk4vE2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731771145; c=relaxed/simple;
	bh=gUhI8FPCE2iHwriwexSVAIZxCk3k4+8NuwBEKyXj/x4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsyihCApWxjvA0G3jhTkXyt6/dp2A8r6gr7ozQ3GX2c1uP4IqXlJ2fjDJU/c1YAuGDcfSabq01ABmk2+SMtSuNyypq+LvWdZbtC+nZo8iU6Ar2RwkjFZGm2Rvijpq+v12eE0T2eZ6rm+2nLP8Q4gFiRvfL4juaB+hFpOWKwap5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRE3ms3B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8308C4CEC3;
	Sat, 16 Nov 2024 15:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731771145;
	bh=gUhI8FPCE2iHwriwexSVAIZxCk3k4+8NuwBEKyXj/x4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dRE3ms3B5HYFsnfZbR2unSAo3E51ZvYGcn+QRDdwjA2oOVsctbBBC8Io+/TWpNRUt
	 PSGQEWwBpvmOhZnln4HMEze/gEA/MlLr6iVs1T/FH0PzGYJPcSlIZy/atmeuz2wBHK
	 SbMjeENrKf6CebrYBN+cZMPUfU2UYg7zX8T+2Cq7Z4ZxTU6EFectv3Z7TCZKy2clZ1
	 mYop16XeTCxtW4sTzhlGRaQKrFYobr6J1h2ZFwGzZtw/h5Z5JFOWbBindDXWPuLFDo
	 HBlV/VyU6M+2lTGOqtxTDBNTvYLiFiXYAijhr23rZZZtwH4h+Zu2VoIKps5jRvg/yv
	 pYSGlOfZM4xWg==
Date: Sat, 16 Nov 2024 10:32:23 -0500
From: Sasha Levin <sashal@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	David Rientjes <rientjes@google.com>,
	Christoph Lameter <cl@linux.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [GIT PULL] slab updates for 6.13
Message-ID: <Zzi7BxJASrR_wbAQ@sashalap>
References: <03ec75a9-aade-4457-ac21-5649116afa98@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <03ec75a9-aade-4457-ac21-5649116afa98@suse.cz>

[ Adding Christian and Al ]

On Fri, Nov 15, 2024 at 03:22:30PM +0100, Vlastimil Babka wrote:
>Hi Linus,
>
>please pull the latest slab updates from:
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.13
>
>One new feature and non-critical fixes (mostly related to debugging).
>No conflicts to be expected, AFAIK.

After merging the last batch of pull requests which included VFS and
SLAB into my linus-next[1] tree I've started seeing consistent boot and
runtime failures both on LKFT[2] and KernelCI[3]. I'm going to start
bisection, but given the amount of content that went in it might take a
day or two.

It seems that this is something in the interaction between VFS and SLAB:

Boot failures:

[    4.600870] __kmem_cache_create_args(ext4_groupinfo_4k) failed with error -22
[    4.602001] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-rc7 #1
[    4.602644] Hardware name: linux,dummy-virt (DT)
[    4.603346] Call trace:
[    4.603594]  dump_backtrace+0x108/0x190
[    4.604831]  show_stack+0x24/0x38
[    4.605104]  dump_stack_lvl+0x40/0xa0
[    4.605472]  dump_stack+0x18/0x28
[    4.605842]  __kmem_cache_create_args+0x21c/0x248
[    4.606235]  ext4_mb_init+0x118/0x720
[    4.606572]  ext4_fill_super+0x1550/0x17d8
[    4.606890]  get_tree_bdev_flags+0x138/0x1d8
[    4.607279]  get_tree_bdev+0x20/0x38
[    4.607643]  ext4_get_tree+0x24/0x38
[    4.608013]  vfs_get_tree+0x3c/0x108
[    4.608260]  do_new_mount+0x154/0x398
[    4.608622]  path_mount+0x258/0x4d0
[    4.609030]  init_mount+0x78/0xc8
[    4.609434]  do_mount_root+0xd4/0x1b0
[    4.609887]  mount_root_generic+0x110/0x308
[    4.610177]  mount_block_root+0x5c/0x78
[    4.610428]  mount_root+0x74/0xa8
[    4.610662]  prepare_namespace+0x8c/0xd8
[    4.610922]  kernel_init_freeable+0x10c/0x160
[    4.611197]  kernel_init+0x2c/0x1c0
[    4.611437]  ret_from_fork+0x10/0x20
[    4.612106] EXT4-fs: no memory for groupinfo slab cache
[    4.612757] EXT4-fs (vda): failed to initialize mballoc (-12)

Runtime failures:

__kmem_cache_create_args(ext4_groupinfo_1k) failed with error -22
CPU: 0 UID: 0 PID: 76 Comm: kunit_try_catch Tainted: G                 N 6.12.0-rc7 #1
Tainted: [N]=TEST
Hardware name: ARM-Versatile (Device Tree Support)
Call trace:
  unwind_backtrace from show_stack+0x10/0x14
  show_stack from dump_stack_lvl+0x34/0x3c
  dump_stack_lvl from __kmem_cache_create_args+0x24c/0x2c4
  __kmem_cache_create_args from ext4_mb_init+0xf4/0x690
  ext4_mb_init from mbt_kunit_init+0x394/0x474
  mbt_kunit_init from kunit_try_run_case+0x40/0x1d4
  kunit_try_run_case from kunit_generic_run_threadfn_adapter+0x1c/0x34
  kunit_generic_run_threadfn_adapter from kthread+0xe0/0x10c
  kthread from ret_from_fork+0x14/0x28
Exception stack(0xd0981fb0 to 0xd0981ff8)
1fa0:                                     00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
EXT4-fs: no memory for groupinfo slab cache
     # test_new_blocks_simple: failed to initialize: -12
------------[ cut here ]------------
kernel BUG at fs/ext4/mballoc.c:3283!
Internal error: Oops - BUG: 0 [#1] PREEMPT ARM
Modules linked in:
CPU: 0 UID: 0 PID: 77 Comm: kunit_try_catch Tainted: G                 N 6.12.0-rc7 #1
Tainted: [N]=TEST
Hardware name: ARM-Versatile (Device Tree Support)
PC is at ext4_mb_release+0x2f4/0x31c
LR is at mbt_kunit_exit+0x10/0x80
pc : [<c02239d4>]    lr : [<c022e758>]    psr: 60000113
sp : d0985f18  ip : d0985f30  fp : 00000000
r10: 00000000  r9 : d0811d50  r8 : c17cc000
r7 : c17cc000  r6 : c16be240  r5 : c1c761c0  r4 : d0811d44
r3 : ffff0fff  r2 : 00000000  r1 : c12d3fc0  r0 : 00000000
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 00093177  Table: 00004000  DAC: 00000053
Register r0 information: NULL pointer
Register r1 information: non-slab/vmalloc memory
Register r2 information: NULL pointer
Register r3 information: non-paged memory
Register r4 information: 2-page vmalloc region starting at 0xd0810000 allocated at copy_process+0x170/0xdd4
Register r5 information: slab task_struct start c1c761c0 pointer offset 0 size 1728
Register r6 information: slab kmalloc-64 start c16be240 pointer offset 0 size 64
Register r7 information: slab kmalloc-1k start c17cc000 pointer offset 0 size 1024
Register r8 information: slab kmalloc-1k start c17cc000 pointer offset 0 size 1024
Register r9 information: 2-page vmalloc region starting at 0xd0810000 allocated at copy_process+0x170/0xdd4
Register r10 information: NULL pointer
Register r11 information: NULL pointer
Register r12 information: 2-page vmalloc region starting at 0xd0984000 allocated at copy_process+0x170/0xdd4
Process kunit_try_catch (pid: 77, stack limit = 0x(ptrval))
Stack: (0xd0985f18 to 0xd0986000)
5f00:                                                       c1440000 00000000
5f20: c102e680 c1c76638 d0985f68 c0c21734 00000003 00000000 00000004 d0811d44
5f40: c1c761c0 c16be240 d0811c88 c17cc000 d0811d50 00000000 00000000 c022e758
5f60: d0811d44 c1c761c0 c16be240 d0811c88 c039be9c d0811d50 00000000 c0399c0c
5f80: d0811d50 c039beb8 c16bf160 c0044a4c c16bf160 c004496c 00000000 00000000
5fa0: 00000000 00000000 00000000 c000854c 00000000 00000000 00000000 00000000
5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
5fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
Call trace:
  ext4_mb_release from mbt_kunit_exit+0x10/0x80
  mbt_kunit_exit from kunit_try_run_case_cleanup+0x30/0x3c
  kunit_try_run_case_cleanup from kunit_generic_run_threadfn_adapter+0x1c/0x34
  kunit_generic_run_threadfn_adapter from kthread+0xe0/0x10c
  kthread from ret_from_fork+0x14/0x28
Exception stack(0xd0985fb0 to 0xd0985ff8)
5fa0:                                     00000000 00000000 00000000 00000000
5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
Code: e3a010c9 e3811c0e eb278c81 eaffff5d (e7f001f2)
---[ end trace 0000000000000000 ]---


[1] https://git.kernel.org/pub/scm/linux/kernel/git/sashal/linus-next.git/log/?h=linus-next
[2] https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.11-15430-gc12cd257292c/testrun/25849362/suite/boot/test/clang-19-lkftconfig/log
[3] https://kciapistagingstorage1.file.core.windows.net/early-access/baseline-x86-kcidebug-amd-6738b3dc1a48e7821930a51b/log.txt.gz?sv=2022-11-02&ss=f&srt=sco&sp=r&se=2026-10-18T13:36:18Z&st=2024-10-17T05:36:18Z&spr=https&sig=xFxYOOh5uXJWeN9I3YKAUvpGGQivo89HKZbD78gcxvc%3D

-- 
Thanks,
Sasha

