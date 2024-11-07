Return-Path: <linux-kernel+bounces-400582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AB09C0F95
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B15D628520B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA75217465;
	Thu,  7 Nov 2024 20:18:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04730188CC6
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 20:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731010687; cv=none; b=n7dyW80nqgZNJgwcLFAzg6q65xk0H4mnsCDcFFt2Bhp+Z5RX6776HmRgmT2AfxhpCFQ+v60lyqB7EYe3c+V3BHiBACBSkkr0xYcxYxhopH6bceICv8O/4BkgLaSkuN2TSUIAnK7nC9AGPQf6d+Wx4LuJAVONwKnKEbLF6pK+kC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731010687; c=relaxed/simple;
	bh=WPvmbtBaYxXoHEDpDbJqziDmzEVKaPRObhirqmse8fc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iYFeSkOeB1Tg3q8Wk0BiWiWZPhxxSfeoB5L387yg8MzlDruePV1kO5hnAjSNxYn2MBzb8jv5DKaxGri8gOCUwebFfHWcLGsm+juuHPnGbzHxPAxoXd4qO7eZFhnZ+1jQg11mmO0+o7/B8bBRKyDE5+G5KZ81aEt1gtMeBkbycPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a6b963ca02so14662355ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 12:18:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731010684; x=1731615484;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cE3HxliS85KNj7fHNeZwZMP6EOvJP2ZQUCUySF8RSMs=;
        b=MPGxbDBiEfqzDpX8F7lUN8tuAHb+mVJSj2OgYaSVr2MSrweerAs2mhwvwIJfcGj9LO
         m6e4dfAj2miaX20WwWhlk7wWIewcu1Yknk2FXB8OHzHnwMWtP1HCxTXNPVYYkJUytMxd
         RxxlqZoJm4Lx2et2ElBO/kT0bAEOVWdD9UZiQi+Ma9hudfyqaf/359fr85WqrKvCuQRU
         vIfZFTtXcU26/gAjW/9K/ffEIknm8FmlydC+VrzbmP1CxIqdqXdvE8eu1ZQV/uNYV/ys
         BH3GyTwEmXz8x07i6Gumaf5QvJRUieuVqc0tx8YMMwfw6nWzsstjsCrAV9CvdGEBcDZu
         AgHg==
X-Gm-Message-State: AOJu0YwJnDY/kT96EqgJm4k3jXYJmannCT+g1M/iw4AmSmyt7zGROsFC
	EeUZ9XFmrxLLOZ729fGge7hODlUlgr0fHuDxeGAurbK1Xfl+lUzHgH2fzXDtdOXOiSiPWo2X3qI
	52nWZjDiIysUnKMQRMam9NWam1tTjlxwIxUEQMrlELS3nXZmXVeP8pgo=
X-Google-Smtp-Source: AGHT+IEpb6cTdrxV78t+pyQrrL7PvTeRJyWetWrHcNCw457KTvK1RuKQIPEI7TRdAx4Hut60P2RaalnzxfsBUebAS+OWu0FQijdF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13ac:b0:3a6:be66:ce53 with SMTP id
 e9e14a558f8ab-3a6f1a35505mr5788045ab.18.1731010684131; Thu, 07 Nov 2024
 12:18:04 -0800 (PST)
Date: Thu, 07 Nov 2024 12:18:04 -0800
In-Reply-To: <CAHiZj8jxeKnsZca8PGgoYvU4cH+gRveNkqjVguA3WX+V_eOtaQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672d207c.050a0220.15a23d.019e.GAE@google.com>
Subject: Re: [syzbot] [acpi?] [nvdimm?] KASAN: vmalloc-out-of-bounds Read in
 acpi_nfit_ctl (2)
From: syzbot <syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, surajsonawane0215@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

nx6: QNX6 filesystem 1.0.0 registered.
[    8.170952][    T1] fuse: init (API version 7.41)
[    8.177946][    T1] orangefs_debugfs_init: called with debug mask: :none=
: :0:
[    8.183363][    T1] orangefs_init: module version upstream loaded
[    8.187965][    T1] JFS: nTxBlock =3D 6193, nTxLock =3D 49545
[    8.208314][    T1] SGI XFS with ACLs, security attributes, realtime, qu=
ota, no debug enabled
[    8.216600][    T1] 9p: Installing v9fs 9p2000 file system support
[    8.220716][    T1] NILFS version 2 loaded
[    8.223207][    T1] befs: version: 0.9.3
[    8.226735][    T1] ocfs2: Registered cluster interface o2cb
[    8.231974][    T1] ocfs2: Registered cluster interface user
[    8.236251][    T1] OCFS2 User DLM kernel interface loaded
[    8.249844][    T1] gfs2: GFS2 installed
[    8.263620][    T1] ceph: loaded (mds proto 32)
[    8.291737][    T1] NET: Registered PF_ALG protocol family
[    8.295731][    T1] xor: automatically using best checksumming function =
  avx      =20
[    8.301190][    T1] async_tx: api initialized (async)
[    8.304560][    T1] Key type asymmetric registered
[    8.308011][    T1] Asymmetric key parser 'x509' registered
[    8.311630][    T1] Asymmetric key parser 'pkcs8' registered
[    8.315349][    T1] Key type pkcs7_test registered
[    8.319667][    T1] Block layer SCSI generic (bsg) driver version 0.4 lo=
aded (major 238)
[    8.325838][    T1] io scheduler mq-deadline registered
[    8.329570][    T1] io scheduler kyber registered
[    8.332988][    T1] io scheduler bfq registered
[    8.359110][    T1] ACPI: \_SB_.GSIE: Enabled at IRQ 20
[    8.370806][    T1] pcieport 0000:00:04.0: PME: Signaling with IRQ 25
[    8.379322][    T1] pcieport 0000:00:04.0: AER: enabled with IRQ 26
[    8.391225][  T140] kworker/u4:2 (140) used greatest stack depth: 25104 =
bytes left
[    8.398097][    T1] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN=
:00/input/input0
[    8.436998][    T1] ACPI: button: Power Button [PWRF]
[    8.637134][    T1] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    8.642545][    T1] BUG: KASAN: stack-out-of-bounds in acpi_nfit_ctl+0x1=
c8a/0x2540
[    8.646090][    T1] Read of size 4 at addr ffffc900003371e0 by task swap=
per/0/1
[    8.646090][    T1]=20
[    8.646090][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.1=
2.0-rc6-syzkaller-00114-g80fb25341631-dirty #0
[    8.646090][    T1] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
[    8.646090][    T1] Call Trace:
[    8.646090][    T1]  <TASK>
[    8.646090][    T1]  dump_stack_lvl+0x241/0x360
[    8.646090][    T1]  ? __pfx_dump_stack_lvl+0x10/0x10
[    8.646090][    T1]  ? __pfx__printk+0x10/0x10
[    8.646090][    T1]  ? _printk+0xd5/0x120
[    8.646090][    T1]  print_report+0x169/0x550
[    8.646090][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.646090][    T1]  ? __virt_addr_valid+0xbd/0x530
[    8.646090][    T1]  ? acpi_nfit_ctl+0x1c8a/0x2540
[    8.646090][    T1]  kasan_report+0x143/0x180
[    8.646090][    T1]  ? acpi_nfit_ctl+0x1c8a/0x2540
[    8.646090][    T1]  acpi_nfit_ctl+0x1c8a/0x2540
[    8.646090][    T1]  ? mark_lock+0x9a/0x360
[    8.646090][    T1]  ? __pfx_acpi_nfit_ctl+0x10/0x10
[    8.646090][    T1]  ? nfit_spa_type+0x81/0x410
[    8.646090][    T1]  ? nfit_spa_type+0x378/0x410
[    8.646090][    T1]  ? __pfx_nfit_spa_type+0x10/0x10
[    8.646090][    T1]  ? mark_lock+0x9a/0x360
[    8.646090][    T1]  acpi_nfit_register_regions+0x2ae/0xf50
[    8.646090][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.646090][    T1]  ? __pfx_acpi_nfit_register_regions+0x10/0x10
[    8.646090][    T1]  ? _raw_spin_unlock_irqrestore+0xdd/0x140
[    8.646090][    T1]  ? __pfx__raw_spin_unlock_irqrestore+0x10/0x10
[    8.646090][    T1]  ? __kmalloc_node_track_caller_noprof+0x242/0x440
[    8.646090][    T1]  acpi_nfit_init+0x6fd0/0x7060
[    8.646090][    T1]  ? __pfx_acpi_nfit_init+0x10/0x10
[    8.646090][    T1]  ? acpi_evaluate_object+0x9a3/0xaf0
[    8.646090][    T1]  ? acpi_nfit_add+0x2f3/0x620
[    8.646090][    T1]  acpi_nfit_add+0x469/0x620
[    8.646090][    T1]  ? __pfx_acpi_nfit_add+0x10/0x10
[    8.646090][    T1]  ? kernfs_put+0x315/0x370
[    8.646090][    T1]  acpi_device_probe+0xa5/0x2b0
[    8.646090][    T1]  ? really_probe+0x274/0xad0
[    8.646090][    T1]  ? __pfx_acpi_device_probe+0x10/0x10
[    8.646090][    T1]  really_probe+0x2b8/0xad0
[    8.646090][    T1]  __driver_probe_device+0x1a2/0x390
[    8.646090][    T1]  driver_probe_device+0x50/0x430
[    8.646090][    T1]  __driver_attach+0x45f/0x710
[    8.646090][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.646090][    T1]  bus_for_each_dev+0x239/0x2b0
[    8.646090][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.646090][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    8.646090][    T1]  bus_add_driver+0x346/0x670
[    8.646090][    T1]  driver_register+0x23a/0x320
[    8.646090][    T1]  nfit_init+0x166/0x1b0
[    8.646090][    T1]  ? __pfx_nfit_init+0x10/0x10
[    8.646090][    T1]  do_one_initcall+0x248/0x880
[    8.646090][    T1]  ? __pfx_nfit_init+0x10/0x10
[    8.646090][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    8.646090][    T1]  ? __pfx_parse_args+0x10/0x10
[    8.646090][    T1]  ? rcu_is_watching+0x15/0xb0
[    8.646090][    T1]  do_initcall_level+0x157/0x210
[    8.646090][    T1]  do_initcalls+0x3f/0x80
[    8.646090][    T1]  kernel_init_freeable+0x435/0x5d0
[    8.646090][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    8.646090][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.646090][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.646090][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.646090][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.646090][    T1]  kernel_init+0x1d/0x2b0
[    8.646090][    T1]  ret_from_fork+0x4b/0x80
[    8.646090][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.646090][    T1]  ret_from_fork_asm+0x1a/0x30
[    8.646090][    T1]  </TASK>
[    8.646090][    T1]=20
[    8.646090][    T1] The buggy address belongs to stack of task swapper/0=
/1
[    8.646090][    T1]  and is located at offset 160 in frame:
[    8.646090][    T1]  acpi_nfit_register_regions+0x0/0xf50
[    8.646090][    T1]=20
[    8.646090][    T1] This frame has 4 objects:
[    8.646090][    T1]  [32, 36) 'cmd_rc.i.i87'
[    8.646090][    T1]  [48, 80) 'ars_start.i.i'
[    8.646090][    T1]  [112, 116) 'cmd_rc.i.i'
[    8.646090][    T1]  [128, 160) 'ars_cap.i'
[    8.646090][    T1]=20
[    8.646090][    T1] The buggy address belongs to the virtual mapping at
[    8.646090][    T1]  [ffffc90000330000, ffffc90000339000) created by:
[    8.646090][    T1]  copy_process+0x5d1/0x3d50
[    8.646090][    T1]=20
[    8.646090][    T1] The buggy address belongs to the physical page:
[    8.646090][    T1] page: refcount:1 mapcount:0 mapping:0000000000000000=
 index:0x0 pfn:0x312a4
[    8.646090][    T1] flags: 0x4fff00000000000(node=3D1|zone=3D1|lastcpupi=
d=3D0x7ff)
[    8.646090][    T1] raw: 04fff00000000000 0000000000000000 dead000000000=
122 0000000000000000
[    8.646090][    T1] raw: 0000000000000000 0000000000000000 00000001fffff=
fff 0000000000000000
[    8.646090][    T1] page dumped because: kasan: bad access detected
[    8.646090][    T1] page_owner tracks the page as allocated
[    8.646090][    T1] page last allocated via order 0, migratetype Unmovab=
le, gfp_mask 0x2102(__GFP_HIGHMEM|__GFP_NOWARN|__GFP_ZERO), pid 0, tgid 0 (=
swapper/0), ts 2318285947, free_ts 0
[    8.646090][    T1]  post_alloc_hook+0x1f3/0x230
[    8.646090][    T1]  get_page_from_freelist+0x303f/0x3190
[    8.646090][    T1]  __alloc_pages_noprof+0x292/0x710
[    8.646090][    T1]  alloc_pages_mpol_noprof+0x3e8/0x680
[    8.646090][    T1]  __vmalloc_node_range_noprof+0xa2b/0x13f0
[    8.646090][    T1]  dup_task_struct+0x444/0x8c0
[    8.646090][    T1]  copy_process+0x5d1/0x3d50
[    8.646090][    T1]  kernel_clone+0x226/0x8f0
[    8.646090][    T1]  user_mode_thread+0x132/0x1a0
[    8.646090][    T1]  rest_init+0x23/0x300
[    8.646090][    T1]  start_kernel+0x47f/0x500
[    8.646090][    T1]  x86_64_start_reservations+0x2a/0x30
[    8.646090][    T1]  x86_64_start_kernel+0x9f/0xa0
[    8.646090][    T1]  common_startup_64+0x13e/0x147
[    8.646090][    T1] page_owner free stack trace missing
[    8.646090][    T1]=20
[    8.646090][    T1] Memory state around the buggy address:
[    8.646090][    T1]  ffffc90000337080: 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00
[    8.646090][    T1]  ffffc90000337100: 00 00 00 00 00 00 00 00 f1 f1 f1 =
f1 04 f2 00 00
[    8.646090][    T1] >ffffc90000337180: 00 00 f2 f2 f2 f2 04 f2 00 00 00 =
00 f3 f3 f3 f3
[    8.646090][    T1]                                                     =
   ^
[    8.646090][    T1]  ffffc90000337200: 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00
[    8.646090][    T1]  ffffc90000337280: 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00
[    8.646090][    T1] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    9.044043][    T1] Kernel panic - not syncing: KASAN: panic_on_warn set=
 ...
[    9.048635][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.1=
2.0-rc6-syzkaller-00114-g80fb25341631-dirty #0
[    9.053640][    T1] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
[    9.053640][    T1] Call Trace:
[    9.053640][    T1]  <TASK>
[    9.053640][    T1]  dump_stack_lvl+0x241/0x360
[    9.053640][    T1]  ? __pfx_dump_stack_lvl+0x10/0x10
[    9.053640][    T1]  ? __pfx__printk+0x10/0x10
[    9.053640][    T1]  ? preempt_schedule+0xe1/0xf0
[    9.053640][    T1]  ? vscnprintf+0x5d/0x90
[    9.053640][    T1]  panic+0x349/0x880
[    9.053640][    T1]  ? check_panic_on_warn+0x21/0xb0
[    9.053640][    T1]  ? __pfx_panic+0x10/0x10
[    9.053640][    T1]  ? _raw_spin_unlock_irqrestore+0x130/0x140
[    9.053640][    T1]  ? __pfx__raw_spin_unlock_irqrestore+0x10/0x10
[    9.053640][    T1]  ? print_report+0x502/0x550
[    9.053640][    T1]  check_panic_on_warn+0x86/0xb0
[    9.053640][    T1]  ? acpi_nfit_ctl+0x1c8a/0x2540
[    9.053640][    T1]  end_report+0x77/0x160
[    9.053640][    T1]  kasan_report+0x154/0x180
[    9.053640][    T1]  ? acpi_nfit_ctl+0x1c8a/0x2540
[    9.053640][    T1]  acpi_nfit_ctl+0x1c8a/0x2540
[    9.053640][    T1]  ? mark_lock+0x9a/0x360
[    9.053640][    T1]  ? __pfx_acpi_nfit_ctl+0x10/0x10
[    9.053640][    T1]  ? nfit_spa_type+0x81/0x410
[    9.053640][    T1]  ? nfit_spa_type+0x378/0x410
[    9.053640][    T1]  ? __pfx_nfit_spa_type+0x10/0x10
[    9.053640][    T1]  ? mark_lock+0x9a/0x360
[    9.053640][    T1]  acpi_nfit_register_regions+0x2ae/0xf50
[    9.053640][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    9.053640][    T1]  ? __pfx_acpi_nfit_register_regions+0x10/0x10
[    9.053640][    T1]  ? _raw_spin_unlock_irqrestore+0xdd/0x140
[    9.053640][    T1]  ? __pfx__raw_spin_unlock_irqrestore+0x10/0x10
[    9.053640][    T1]  ? __kmalloc_node_track_caller_noprof+0x242/0x440
[    9.053640][    T1]  acpi_nfit_init+0x6fd0/0x7060
[    9.053640][    T1]  ? __pfx_acpi_nfit_init+0x10/0x10
[    9.053640][    T1]  ? acpi_evaluate_object+0x9a3/0xaf0
[    9.053640][    T1]  ? acpi_nfit_add+0x2f3/0x620
[    9.053640][    T1]  acpi_nfit_add+0x469/0x620
[    9.053640][    T1]  ? __pfx_acpi_nfit_add+0x10/0x10
[    9.053640][    T1]  ? kernfs_put+0x315/0x370
[    9.053640][    T1]  acpi_device_probe+0xa5/0x2b0
[    9.053640][    T1]  ? really_probe+0x274/0xad0
[    9.053640][    T1]  ? __pfx_acpi_device_probe+0x10/0x10
[    9.053640][    T1]  really_probe+0x2b8/0xad0
[    9.053640][    T1]  __driver_probe_device+0x1a2/0x390
[    9.053640][    T1]  driver_probe_device+0x50/0x430
[    9.053640][    T1]  __driver_attach+0x45f/0x710
[    9.053640][    T1]  ? __pfx___driver_attach+0x10/0x10
[    9.053640][    T1]  bus_for_each_dev+0x239/0x2b0
[    9.053640][    T1]  ? __pfx___driver_attach+0x10/0x10
[    9.053640][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    9.053640][    T1]  bus_add_driver+0x346/0x670
[    9.053640][    T1]  driver_register+0x23a/0x320
[    9.053640][    T1]  nfit_init+0x166/0x1b0
[    9.053640][    T1]  ? __pfx_nfit_init+0x10/0x10
[    9.053640][    T1]  do_one_initcall+0x248/0x880
[    9.053640][    T1]  ? __pfx_nfit_init+0x10/0x10
[    9.053640][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    9.053640][    T1]  ? __pfx_parse_args+0x10/0x10
[    9.053640][    T1]  ? rcu_is_watching+0x15/0xb0
[    9.053640][    T1]  do_initcall_level+0x157/0x210
[    9.053640][    T1]  do_initcalls+0x3f/0x80
[    9.053640][    T1]  kernel_init_freeable+0x435/0x5d0
[    9.053640][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    9.053640][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    9.053640][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.053640][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.053640][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.053640][    T1]  kernel_init+0x1d/0x2b0
[    9.053640][    T1]  ret_from_fork+0x4b/0x80
[    9.053640][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.053640][    T1]  ret_from_fork_asm+0x1a/0x30
[    9.053640][    T1]  </TASK>
[    9.053640][    T1] Kernel Offset: disabled
[    9.053640][    T1] Rebooting in 86400 seconds..


syzkaller build log:
go env (err=3D<nil>)
GO111MODULE=3D'auto'
GOARCH=3D'amd64'
GOBIN=3D''
GOCACHE=3D'/syzkaller/.cache/go-build'
GOENV=3D'/syzkaller/.config/go/env'
GOEXE=3D''
GOEXPERIMENT=3D''
GOFLAGS=3D''
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMODCACHE=3D'/syzkaller/jobs/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/usr/local/go'
GOSUMDB=3D'sum.golang.org'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/usr/local/go/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.22.7'
GCCGO=3D'gccgo'
GOAMD64=3D'v1'
AR=3D'ar'
CC=3D'gcc'
CXX=3D'g++'
CGO_ENABLED=3D'1'
GOMOD=3D'/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/go.mo=
d'
GOWORK=3D''
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
PKG_CONFIG=3D'pkg-config'
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build70911805=3D/tmp/go-build -gno-record-gcc-=
switches'

git status (err=3D<nil>)
HEAD detached at da38b4c931f
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sy=
s/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
go fmt ./sys/... >/dev/null
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dda38b4c931f2882f34163d41ac10bfc78112afc8 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20241105-104654'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include -fpermissive -w -DGOOS_linu=
x=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"da38b4c931f2882f34163d41ac10bfc781=
12afc8\"
/usr/bin/ld: /tmp/cco8PKHf.o: in function `test_cover_filter()':
executor.cc:(.text+0x1426b): warning: the use of `tempnam' is dangerous, be=
tter use `mkstemp'
/usr/bin/ld: /tmp/cco8PKHf.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D15fb3f40580000


Tested on:

commit:         80fb2534 Merge tag 'pwm/for-6.12-rc7-fixes' of git://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D11254d3590b1671=
7
dashboard link: https://syzkaller.appspot.com/bug?extid=3D7534f060ebda6b8b5=
1b3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D100b2d879800=
00


