Return-Path: <linux-kernel+bounces-304745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA431962442
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7343D287A28
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543791684BB;
	Wed, 28 Aug 2024 10:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rGqsRbAM"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EFC15CD7A
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 10:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724839366; cv=none; b=DB1yh7CdBvmHequDUu28bl44JamkS1opCc0cbRUV2Z6jDdAZnD8rqjp/wZHHzKGJKYriWHhIhE9GWozq1j0ruxbAFczMfhD+sxeAICvnmlaVZdRNrBIWh9nQpgBN5dxSsOBJkJSvjk7pXqdCXbnOvOIDLR/ikpAqefq/h6QYPF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724839366; c=relaxed/simple;
	bh=wb02rMS2bsF5J7OFUre9Utun01pITJHUSlfc5FUYKs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=r6S5dQESN73axbqeRXyamKEvW+Jz9yatFW9eNsgDFIiIIzvcBTfKrmCooaL5+w4YOhnxc+kigynGVDKSolYlX91wghg6WOoRhvQrBYJr6XnSDmzzPAZnqzs/taMgumjz1twg+4gYmTj4lvp326wprwrNoGo/9CSmYaaqfi0orYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rGqsRbAM; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240828100241euoutp02b0e4f2beeb7f8daddd110352640009db~v3EKk4kU02858728587euoutp02z
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 10:02:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240828100241euoutp02b0e4f2beeb7f8daddd110352640009db~v3EKk4kU02858728587euoutp02z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724839361;
	bh=jxOYpLlpHtoqPanB1bXfLrsnl/Hdigkcgd5eIcTB9uk=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=rGqsRbAM7lisA7vhQ+TbBuiBbyIB0vtnlXpbsNdqoJjN+XaYXUcfM5wM1srfaImvi
	 ZmEdb/V/DusMnO4kginlwcTJUDJ4auzDIEdw1CwuT3CAsidV1YP8DrB3h0m8xMTqFc
	 0nrIed8juDLamnNGnrQhGX0MvxdRjPV0dDbeaWTk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240828100240eucas1p1c6fd26d45b966c026319f660ea11ef79~v3EKF9D2z3233832338eucas1p1d;
	Wed, 28 Aug 2024 10:02:40 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id FA.39.09624.0C5FEC66; Wed, 28
	Aug 2024 11:02:40 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240828100239eucas1p2afc0d3088c66468061baf81c5676882a~v3EJiUdmT2575325753eucas1p2n;
	Wed, 28 Aug 2024 10:02:39 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240828100239eusmtrp12197c5e18ae88c568b560c2807b4f984~v3EJhwLjW0290402904eusmtrp1k;
	Wed, 28 Aug 2024 10:02:39 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-8c-66cef5c09732
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 88.E4.08810.FB5FEC66; Wed, 28
	Aug 2024 11:02:39 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240828100239eusmtip23fa78ebad18e90509ddcc4d30b670050~v3EI3nevQ0491504915eusmtip2D;
	Wed, 28 Aug 2024 10:02:39 +0000 (GMT)
Message-ID: <8303f283-d60a-4840-aff2-b486d6a9774f@samsung.com>
Date: Wed, 28 Aug 2024 12:02:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] regmap: Hold the regmap lock when allocating and
 freeing the cache
To: Mark Brown <broonie@kernel.org>, "Liam R. Howlett"
	<Liam.Howlett@oracle.com>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	maple-tree@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20240822-b4-regmap-maple-nolock-v1-2-d5e6dbae3396@kernel.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsWy7djP87oHvp5LM+i8LmYx9eETNotvh84w
	WmxveMBucXnXHDaLe2v+s1psWNnA5MDmsePuEkaPTas62Tw2fZrE7rF5Sb3Hx6e3WDw+b5IL
	YIvisklJzcksSy3St0vgyphxawNbwdJ2xoreTWtYGhh7K7sYOTkkBEwknhy/yd7FyMUhJLCC
	UeLBkiUsIAkhgS+MEveOSUAkPjNK/H29ihGm4+zcm2wQieWMEssmPGWD6PjIKHFpHieIzStg
	J9F27TPQWA4OFgFViaM/zCHCghInZz4BWyAqIC9x/9YMdhBbWCBWonf7T1YQW0QgSOLklhlM
	IDazQD+jxNOOYghbXOLWk/lgcTYBQ4mut11gazkFvCX6Tk5hg6iRl2jeOpsZ4s47HBL39utA
	2C4SVybPZIGwhSVeHd/CDmHLSJye3MMC8ouEQDujxILf95kgnAmMEg3Pb0F9bC1x59wvNpBn
	mAU0Jdbv0ocIO0psv3oMLCwhwCdx460gxA18EpO2TWeGCPNKdLQJQVSrScw6vg5u7cELl5gn
	MCrNQgqVWUi+nIXkm1kIexcwsqxiFE8tLc5NTy02zEst1ytOzC0uzUvXS87P3cQITD+n/x3/
	tINx7quPeocYmTgYDzFKcDArifCeOH42TYg3JbGyKrUoP76oNCe1+BCjNAeLkjivaop8qpBA
	emJJanZqakFqEUyWiYNTqoHJYG8vz8prBzJ+BXryxey/dfvW1Qeit0vd9ZIMNp8xmCyxp2lb
	23OJs30fl+iefmD47eolj2LBqCu7nwg4bRHY7L/A/uqKfvXb0lIhyz9feBxz2LNPtZpX6ao9
	x/ONRq9uZavMCL2lfnmZ/LtUiZRJ+w94i5zkOf/i7dIa6zX6BoH3o5gjD3hb2snve7ejL/h/
	+/rzf+X6P6UtUBD6GfZ94u99FZwvU1IOHtE1nWB1Z2/B+a41do2We9e9F/d5WT/3zfxFcgVR
	j6dO0Z6Yza4QJbL1iblj2OMcwfexFSdCUwpLP+9UtrncMG/d7u7be3wEC7lW54kG2Bs9L12w
	5cjf3u7kkxVu66bPLze43PfbUYmlOCPRUIu5qDgRAGNGVzSuAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsVy+t/xe7r7v55LM/jQqGMx9eETNotvh84w
	WmxveMBucXnXHDaLe2v+s1psWNnA5MDmsePuEkaPTas62Tw2fZrE7rF5Sb3Hx6e3WDw+b5IL
	YIvSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy5hx
	awNbwdJ2xoreTWtYGhh7K7sYOTkkBEwkzs69ydbFyMUhJLCUUeLFsVnMEAkZiZPTGlghbGGJ
	P9e6oIreM0pM2LCEHSTBK2An0XbtM5DNwcEioCpx9Ic5RFhQ4uTMJywgtqiAvMT9WzPAyoUF
	YiV6t/8EmykiECRx/NszsJnMAv2MEh17vrFDLOhmlJh2bxnYFcwC4hK3nsxnArHZBAwlut6C
	XMHJwSngLdF3cgobRI2ZRNfWLkYIW16ieets5gmMQrOQHDILyahZSFpmIWlZwMiyilEktbQ4
	Nz232FCvODG3uDQvXS85P3cTIzDuth37uXkH47xXH/UOMTJxMB5ilOBgVhLhPXH8bJoQb0pi
	ZVVqUX58UWlOavEhRlNgYExklhJNzgdGfl5JvKGZgamhiZmlgamlmbGSOK9nQUeikEB6Yklq
	dmpqQWoRTB8TB6dUA9OMsnUeYqJNDaoTvJYn3D3t57pMwlKjfuH2vrbT97f5OFzcstrP/4/t
	o+B7mn7Ne29mvIqbHp8nvUt79n11LT/Duk8th6tSW8ojIzZm1Djm1K0oSBdwv5PwgMv90qFT
	Dtf9hFY8U0orM1/lFRMkdCj3kl/B/eDsKecs9++cnxjm/GOO8d9viYlR5jdKe3g1HuvoG+71
	7n2YKxRmfSFcLD11ifiO5zsrfq9J/dNb1FGbm+zZkv78kfaDLuZncgr79XaJBZxffWyW0aIM
	jjvyFrqClSfa+CsvPb7t8e3bqmxXxgM2nTIuqTULlN/UfH604OXeW99n3VkZsu/D5n32+v4P
	whZ+nsvFm5G5/c+MbCWW4oxEQy3mouJEAAD2JA9EAwAA
X-CMS-MailID: 20240828100239eucas1p2afc0d3088c66468061baf81c5676882a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240828100239eucas1p2afc0d3088c66468061baf81c5676882a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240828100239eucas1p2afc0d3088c66468061baf81c5676882a
References: <20240822-b4-regmap-maple-nolock-v1-0-d5e6dbae3396@kernel.org>
	<20240822-b4-regmap-maple-nolock-v1-2-d5e6dbae3396@kernel.org>
	<CGME20240828100239eucas1p2afc0d3088c66468061baf81c5676882a@eucas1p2.samsung.com>

Dear Mark,

On 22.08.2024 21:13, Mark Brown wrote:
> For the benefit of the maple tree's lockdep checking hold the lock while
> creating and exiting the cache.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>

This patch landed recently in linux-next as commit fd4ebc07b4df 
("regmap: Hold the regmap lock when allocating and freeing the cache"). 
In my tests I found that it triggers the following warnings on 
Rockchip3568 based Odroid-M1 board:

BUG: sleeping function called from invalid context at 
include/linux/sched/mm.h:337
in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 157, name: 
systemd-udevd
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
2 locks held by systemd-udevd/157:
  #0: ffff0001f0cf30f8 (&dev->mutex){....}-{3:3}, at: 
__driver_attach+0x90/0x1ac
  #1: ffff0001f1196818 
(rockchip_i2s_tdm:1300:(&rockchip_i2s_tdm_regmap_config)->lock){....}-{2:2}, 
at: regmap_lock_spinlock+0x18/0x2c
irq event stamp: 11474
hardirqs last  enabled at (11473): [<ffff8000812b4cc0>] 
_raw_spin_unlock_irqrestore+0x74/0x78
hardirqs last disabled at (11474): [<ffff8000812b40d4>] 
_raw_spin_lock_irqsave+0x84/0x88
softirqs last  enabled at (9730): [<ffff8000800b13dc>] 
handle_softirqs+0x4cc/0x4e4
softirqs last disabled at (9721): [<ffff8000800105b0>] 
__do_softirq+0x14/0x20
CPU: 3 UID: 0 PID: 157 Comm: systemd-udevd Not tainted 6.11.0-rc3+ #15305
Hardware name: Hardkernel ODROID-M1 (DT)
Call trace:
  dump_backtrace+0x94/0xec
  show_stack+0x18/0x24
  dump_stack_lvl+0x90/0xd0
  dump_stack+0x18/0x24
  __might_resched+0x144/0x248
  __might_sleep+0x48/0x98
  __kmalloc_noprof+0x208/0x328
  regcache_flat_init+0x40/0xb0
  regcache_init+0x1ec/0x490
  __regmap_init+0x8e0/0xd50
  __devm_regmap_init+0x78/0xc8
  __devm_regmap_init_mmio_clk+0x9c/0xc4
  rockchip_i2s_tdm_probe+0x318/0x754 [snd_soc_rockchip_i2s_tdm]
  platform_probe+0x68/0xdc
  really_probe+0xbc/0x298
  __driver_probe_device+0x78/0x12c
  driver_probe_device+0x40/0x164
  __driver_attach+0x9c/0x1ac
  bus_for_each_dev+0x74/0xd4
  driver_attach+0x24/0x30
  bus_add_driver+0xe4/0x208
  driver_register+0x60/0x128
  __platform_driver_register+0x28/0x34
  rockchip_i2s_tdm_driver_init+0x20/0x1000 [snd_soc_rockchip_i2s_tdm]
  do_one_initcall+0x68/0x300
  do_init_module+0x60/0x224
  load_module+0x1b0c/0x1cb0
  init_module_from_file+0x84/0xc4
  idempotent_init_module+0x18c/0x284
  __arm64_sys_finit_module+0x64/0xa0
  invoke_syscall+0x48/0x110
  el0_svc_common.constprop.0+0xc8/0xe8
  do_el0_svc+0x20/0x2c
  el0_svc+0x4c/0x11c
  el0t_64_sync_handler+0x13c/0x158
  el0t_64_sync+0x190/0x194

and

========================================================
WARNING: possible irq lock inversion dependency detected
6.11.0-rc3+ #15305 Tainted: G        W
--------------------------------------------------------
swapper/0/0 just changed the state of lock:
ffff0001f2305018 
(rockchip_drm_vop2:3114:(&vop2_regmap_config)->lock){-...}-{2:2}, at: 
regmap_lock_spinlock+0x18/0x2c
but this lock took another, HARDIRQ-unsafe lock in the past:
  (fs_reclaim){+.+.}-{0:0}


and interrupts could create inverse lock ordering between them.


other info that might help us debug this:
  Possible interrupt unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(fs_reclaim);
                                local_irq_disable();
lock(rockchip_drm_vop2:3114:(&vop2_regmap_config)->lock);
                                lock(fs_reclaim);
   <Interrupt>
lock(rockchip_drm_vop2:3114:(&vop2_regmap_config)->lock);

  *** DEADLOCK ***

no locks held by swapper/0/0.

the shortest dependencies between 2nd lock and 1st lock:
  -> (fs_reclaim){+.+.}-{0:0} {
     HARDIRQ-ON-W at:
                       lock_acquire+0x200/0x340
                       fs_reclaim_acquire+0xdc/0xfc
                       __kmalloc_cache_noprof+0x54/0x288
                       __kthread_create_worker+0x3c/0x150
                       kthread_create_worker+0x64/0x8c
                       workqueue_init+0x30/0x3c4
                       kernel_init_freeable+0x11c/0x50c
                       kernel_init+0x20/0x1d8
                       ret_from_fork+0x10/0x20
     SOFTIRQ-ON-W at:
                       lock_acquire+0x200/0x340
                       fs_reclaim_acquire+0xdc/0xfc
                       __kmalloc_cache_noprof+0x54/0x288
                       __kthread_create_worker+0x3c/0x150
                       kthread_create_worker+0x64/0x8c
                       workqueue_init+0x30/0x3c4
                       kernel_init_freeable+0x11c/0x50c
                       kernel_init+0x20/0x1d8
                       ret_from_fork+0x10/0x20
     INITIAL USE at:
                      lock_acquire+0x200/0x340
                      fs_reclaim_acquire+0xdc/0xfc
                      __kmalloc_cache_noprof+0x54/0x288
                      __kthread_create_worker+0x3c/0x150
                      kthread_create_worker+0x64/0x8c
                      workqueue_init+0x30/0x3c4
                      kernel_init_freeable+0x11c/0x50c
                      kernel_init+0x20/0x1d8
                      ret_from_fork+0x10/0x20
   }
   ... key      at: [<ffff800083097970>] __fs_reclaim_map+0x0/0x28
   ... acquired at:
    fs_reclaim_acquire+0xdc/0xfc
    __kmalloc_cache_noprof+0x54/0x288
    regcache_maple_init+0x2c/0x110
    regcache_init+0x1ec/0x490
    __regmap_init+0x8e0/0xd50
    __devm_regmap_init+0x78/0xc8
    __devm_regmap_init_mmio_clk+0x9c/0xc4
    vop2_bind+0xf4/0xb10 [rockchipdrm]
    component_bind_all+0x118/0x24c
    rockchip_drm_bind+0xb0/0x1fc [rockchipdrm]
    try_to_bring_up_aggregate_device+0x168/0x1d4
    component_master_add_with_match+0xb4/0xfc
    rockchip_drm_platform_probe+0x154/0x284 [rockchipdrm]
    platform_probe+0x68/0xdc
    really_probe+0xbc/0x298
    __driver_probe_device+0x78/0x12c
    driver_probe_device+0x40/0x164
    __driver_attach+0x9c/0x1ac
    bus_for_each_dev+0x74/0xd4
    driver_attach+0x24/0x30
    bus_add_driver+0xe4/0x208
    driver_register+0x60/0x128
    __platform_driver_register+0x28/0x34
    dw_hdmi_cec_transmit+0x44/0xc4 [dw_hdmi_cec]
    do_one_initcall+0x68/0x300
    do_init_module+0x60/0x224
    load_module+0x1b0c/0x1cb0
    init_module_from_file+0x84/0xc4
    idempotent_init_module+0x18c/0x284
    __arm64_sys_finit_module+0x64/0xa0
    invoke_syscall+0x48/0x110
    el0_svc_common.constprop.0+0xc8/0xe8
    do_el0_svc+0x20/0x2c
    el0_svc+0x4c/0x11c
    el0t_64_sync_handler+0x13c/0x158
    el0t_64_sync+0x190/0x194

-> (rockchip_drm_vop2:3114:(&vop2_regmap_config)->lock){-...}-{2:2} {
    IN-HARDIRQ-W at:
                     lock_acquire+0x200/0x340
                     _raw_spin_lock_irqsave+0x60/0x88
                     regmap_lock_spinlock+0x18/0x2c
                     regmap_read+0x3c/0x78
                     vop2_isr+0x84/0x2a8 [rockchipdrm]
                     __handle_irq_event_percpu+0x9c/0x304
                     handle_irq_event+0x4c/0xa8
                     handle_fasteoi_irq+0xa4/0x1cc
                     generic_handle_domain_irq+0x2c/0x44
                     gic_handle_irq+0x4c/0x110
                     call_on_irq_stack+0x24/0x4c
                     do_interrupt_handler+0x80/0x84
                     el1_interrupt+0x34/0x64
                     el1h_64_irq_handler+0x18/0x24
                     el1h_64_irq+0x64/0x68
                     default_idle_call+0xa8/0x1e8
                     do_idle+0x220/0x284
                     cpu_startup_entry+0x34/0x3c
                     rest_init+0xf4/0x184
                     start_kernel+0x680/0x78c
                     __primary_switched+0x80/0x88
    INITIAL USE at:
                    lock_acquire+0x200/0x340
                    _raw_spin_lock_irqsave+0x60/0x88
                    regmap_lock_spinlock+0x18/0x2c
                    regcache_init+0x1dc/0x490
                    __regmap_init+0x8e0/0xd50
                    __devm_regmap_init+0x78/0xc8
                    __devm_regmap_init_mmio_clk+0x9c/0xc4
                    vop2_bind+0xf4/0xb10 [rockchipdrm]
                    component_bind_all+0x118/0x24c
                    rockchip_drm_bind+0xb0/0x1fc [rockchipdrm]
                    try_to_bring_up_aggregate_device+0x168/0x1d4
                    component_master_add_with_match+0xb4/0xfc
                    rockchip_drm_platform_probe+0x154/0x284 [rockchipdrm]
                    platform_probe+0x68/0xdc
                    really_probe+0xbc/0x298
                    __driver_probe_device+0x78/0x12c
                    driver_probe_device+0x40/0x164
                    __driver_attach+0x9c/0x1ac
                    bus_for_each_dev+0x74/0xd4
                    driver_attach+0x24/0x30
                    bus_add_driver+0xe4/0x208
                    driver_register+0x60/0x128
                    __platform_driver_register+0x28/0x34
                    dw_hdmi_cec_transmit+0x44/0xc4 [dw_hdmi_cec]
                    do_one_initcall+0x68/0x300
                    do_init_module+0x60/0x224
                    load_module+0x1b0c/0x1cb0
                    init_module_from_file+0x84/0xc4
                    idempotent_init_module+0x18c/0x284
                    __arm64_sys_finit_module+0x64/0xa0
                    invoke_syscall+0x48/0x110
                    el0_svc_common.constprop.0+0xc8/0xe8
                    do_el0_svc+0x20/0x2c
                    el0_svc+0x4c/0x11c
                    el0t_64_sync_handler+0x13c/0x158
                    el0t_64_sync+0x190/0x194
  }
  ... key      at: [<ffff80007c3e3a58>] _key.6+0x0/0xffffffffffffd5a8 
[rockchipdrm]
  ... acquired at:
    __lock_acquire+0xb10/0x21a0
    lock_acquire+0x200/0x340
    _raw_spin_lock_irqsave+0x60/0x88
    regmap_lock_spinlock+0x18/0x2c
    regmap_read+0x3c/0x78
    vop2_isr+0x84/0x2a8 [rockchipdrm]
    __handle_irq_event_percpu+0x9c/0x304
    handle_irq_event+0x4c/0xa8
    handle_fasteoi_irq+0xa4/0x1cc
    generic_handle_domain_irq+0x2c/0x44
    gic_handle_irq+0x4c/0x110
    call_on_irq_stack+0x24/0x4c
    do_interrupt_handler+0x80/0x84
    el1_interrupt+0x34/0x64
    el1h_64_irq_handler+0x18/0x24
    el1h_64_irq+0x64/0x68
    default_idle_call+0xa8/0x1e8
    do_idle+0x220/0x284
    cpu_startup_entry+0x34/0x3c
    rest_init+0xf4/0x184
    start_kernel+0x680/0x78c
    __primary_switched+0x80/0x88


stack backtrace:
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G        W 6.11.0-rc3+ #15305
Tainted: [W]=WARN
Hardware name: Hardkernel ODROID-M1 (DT)
Call trace:
  dump_backtrace+0x94/0xec
  show_stack+0x18/0x24
  dump_stack_lvl+0x90/0xd0
  dump_stack+0x18/0x24
  print_irq_inversion_bug.part.0+0x1ec/0x27c
  mark_lock+0x63c/0x954
  __lock_acquire+0xb10/0x21a0
  lock_acquire+0x200/0x340
  _raw_spin_lock_irqsave+0x60/0x88
  regmap_lock_spinlock+0x18/0x2c
  regmap_read+0x3c/0x78
  vop2_isr+0x84/0x2a8 [rockchipdrm]
  __handle_irq_event_percpu+0x9c/0x304
  handle_irq_event+0x4c/0xa8
  handle_fasteoi_irq+0xa4/0x1cc
  generic_handle_domain_irq+0x2c/0x44
  gic_handle_irq+0x4c/0x110
  call_on_irq_stack+0x24/0x4c
  do_interrupt_handler+0x80/0x84
  el1_interrupt+0x34/0x64
  el1h_64_irq_handler+0x18/0x24
  el1h_64_irq+0x64/0x68
  default_idle_call+0xa8/0x1e8
  do_idle+0x220/0x284
  cpu_startup_entry+0x34/0x3c
  rest_init+0xf4/0x184
  start_kernel+0x680/0x78c
  __primary_switched+0x80/0x88
Console: switching to colour frame buffer device 240x67
rockchip-drm display-subsystem: [drm] fb0: rockchipdrmfb frame buffer device


Both issues can be fixed by the following patch, but I'm not sure if 
this is not an overuse of the GFP_ATOMIC just for the initialization phase:

diff --git a/drivers/base/regmap/regcache-flat.c 
b/drivers/base/regmap/regcache-flat.c
index 9b17c77dec9d..8e8cf328bffb 100644
--- a/drivers/base/regmap/regcache-flat.c
+++ b/drivers/base/regmap/regcache-flat.c
@@ -27,7 +27,8 @@static int regcache_flat_init(struct regmap *map)
                return -EINVAL;

        map->cache = kcalloc(regcache_flat_get_index(map, 
map->max_register)
-                            + 1, sizeof(unsigned int), GFP_KERNEL);
+     + 1, sizeof(unsigned int),
+     map->can_sleep ? GFP_KERNEL : GFP_ATOMIC);
        if (!map->cache)
                return -ENOMEM;

diff --git a/drivers/base/regmap/regcache-maple.c 
b/drivers/base/regmap/regcache-maple.c
index 2dea9d259c49..b95130127bdc 100644
--- a/drivers/base/regmap/regcache-maple.c
+++ b/drivers/base/regmap/regcache-maple.c
@@ -348,7 +348,7 @@static int regcache_maple_init(struct regmap *map)
        int ret;
        int range_start;

-       mt = kmalloc(sizeof(*mt), GFP_KERNEL);
+mt = kmalloc(sizeof(*mt), map->can_sleep ? GFP_KERNEL : GFP_ATOMIC);
        if (!mt)
                return -ENOMEM;
        map->cache = mt;
diff --git a/drivers/base/regmap/regcache-rbtree.c 
b/drivers/base/regmap/regcache-rbtree.c
index 3db88bbcae0f..c53c38a965d5 100644
--- a/drivers/base/regmap/regcache-rbtree.c
+++ b/drivers/base/regmap/regcache-rbtree.c
@@ -187,7 +187,8 @@static int regcache_rbtree_init(struct regmap *map)
        int i;
        int ret;

-       map->cache = kmalloc(sizeof *rbtree_ctx, GFP_KERNEL);
+map->cache = kmalloc(sizeof *rbtree_ctx,
+     map->can_sleep ? GFP_KERNEL : GFP_ATOMIC);
        if (!map->cache)
                return -ENOMEM;

Let me know if such approach is fine, then I will submit a proper patch 
in a few minutes.


> ---
>   drivers/base/regmap/regcache.c | 4 ++++
>   drivers/base/regmap/regmap.c   | 1 +
>   2 files changed, 5 insertions(+)
>
> diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
> index 7ec1ec605335..d3659ba3cc11 100644
> --- a/drivers/base/regmap/regcache.c
> +++ b/drivers/base/regmap/regcache.c
> @@ -195,7 +195,9 @@ int regcache_init(struct regmap *map, const struct regmap_config *config)
>   	if (map->cache_ops->init) {
>   		dev_dbg(map->dev, "Initializing %s cache\n",
>   			map->cache_ops->name);
> +		map->lock(map->lock_arg);
>   		ret = map->cache_ops->init(map);
> +		map->unlock(map->lock_arg);
>   		if (ret)
>   			goto err_free;
>   	}
> @@ -223,7 +225,9 @@ void regcache_exit(struct regmap *map)
>   	if (map->cache_ops->exit) {
>   		dev_dbg(map->dev, "Destroying %s cache\n",
>   			map->cache_ops->name);
> +		map->lock(map->lock_arg);
>   		map->cache_ops->exit(map);
> +		map->unlock(map->lock_arg);
>   	}
>   }
>   
> diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
> index bfc6bc1eb3a4..9ed842d17642 100644
> --- a/drivers/base/regmap/regmap.c
> +++ b/drivers/base/regmap/regmap.c
> @@ -1445,6 +1445,7 @@ void regmap_exit(struct regmap *map)
>   	struct regmap_async *async;
>   
>   	regcache_exit(map);
> +
>   	regmap_debugfs_exit(map);
>   	regmap_range_exit(map);
>   	if (map->bus && map->bus->free_context)
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


