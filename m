Return-Path: <linux-kernel+bounces-177523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA94C8C4024
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 13:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 426F71F21D74
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 11:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2960C14D2BF;
	Mon, 13 May 2024 11:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVMBSIOQ"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870B914D2AA
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 11:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715601075; cv=none; b=fE3Lf80MvEpb5l4nnxqmKTfelj9V2lgqZ46XnO/jaxNJVuyCwLXOMnShFYVicitouAl1n7rUWJKI7jllMHhTZO2i8vB4ehXJoEXr33pPpO0smx6Xh47/LEt9+NqoSlEgZgCvQpkKOkYFlL9irCM7YVdy9mnwsXQmtxbXfy1yN6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715601075; c=relaxed/simple;
	bh=dxXGmCzHTBG68V4Sgj+E7JBboKRnNrioG4mXmhP1BNk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dEMC3HV8kJiNl3OaRiAK8Z/gzj60bQBL6inoOaEIW3VAUNIHsfyL3J+so4JJj+OZu3dhtzpC5cINVPWFELJ8ifSqRiu+07pk6b4RLvgiRtwu2gcQV9J5VKIVF4whLE5HFXPYbPdzuFAOU5kWlhFZg5Lgd1UMmeU37eFYZN3AZ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVMBSIOQ; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5f80aa2d4a3so3323241a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 04:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715601073; x=1716205873; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dxXGmCzHTBG68V4Sgj+E7JBboKRnNrioG4mXmhP1BNk=;
        b=TVMBSIOQfkGnGOrfkABxK4CzRtIuZjbPDLtHCUwHQcpkJcoIOOkFJtzouPgXpWGstp
         3iRThHYf1U540HlNJSH2Zuv9g+EBGQn4SWE2nT5Oti1FCdy9LVxAojgdBPDgrFacSiwD
         vIU3oecnDir6DfFStNnpvJNW8T3xDJe5ftBcS84NALCC1YjoX2On1bfCqmCuFffMZgXR
         cnW6kpUUzpc9o7ZJXMeTCLDzIgo0p3D8YUmYqgWtMpWwuGuVx+kym5TEehElnikuOD7j
         72e/SIBYqeSwxUhh4Yyz75aPRoX87ynUkCMz03nrsTN3CGZQ5J/xVX/UGwR/Q9AYJ8p4
         pnoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715601073; x=1716205873;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dxXGmCzHTBG68V4Sgj+E7JBboKRnNrioG4mXmhP1BNk=;
        b=l6t1zpLI+Ow5e72D9Pvs8FeixYdY/kFLjkh3grupktHyYWIHlULeHHnniZhi3NZfnZ
         z5NXyaocaatc9XsOMPg0xCcPHMqfXrzK+zW7nW6YT5+Ji6Bnjuk9uoixyiVXQWf+TRIH
         j65unX93iVNBjBCkEnenKMTOVJWC4yrFKDl5eXdahKolAR29SlURD/qz3am/aMSO3QRk
         4ddkGkrZjx+QDJperqqcOnPwBdsVr1OmiOYXytQacYOmvFqVK1yLnpUTYzz/BLYiw6yX
         cSTDKizxbPelKNFfdjpWc2c/iPVKsGInwcRunEmfog4zfYZ7Q6ek2fTFqw2mv3fgQAsT
         sphg==
X-Forwarded-Encrypted: i=1; AJvYcCWvY7j5mpw8KXvhAsunWMgJ0D4ddQcPT8fxZnxJ6C3ZRDOlNoPb2sxMWI4gpYO5z9kCfWuwxQdC8Turd1iJBTaRvLw0XCGk5Ysm8NyK
X-Gm-Message-State: AOJu0YxPWu5rC1O/O1oR88Mgqvw++vmvCFQbCpqACBYrm4lBIMxXJrEA
	K9++yJzEeVFMHuaj90woDt5DIk+ROIT4HZaQuF7GqOV4aq1CfUgdk3OEWMMcI6AOptGara9M+VV
	QAfOxex2qcNifaD9P3oR4yhn5Dmg=
X-Google-Smtp-Source: AGHT+IEOdoW7RZJ+pycKQshemWD1e3dxnN/hwaDK8MOqft+DrxWTbjjN161+npD1FT97ymJXDAH0f9lhhkb43Uxi2ew=
X-Received: by 2002:a05:6a20:9747:b0:1af:8fa8:3126 with SMTP id
 adf61e73a8af0-1afde07cd39mr8141290637.6.1715601072540; Mon, 13 May 2024
 04:51:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: lee bruce <xrivendell7@gmail.com>
Date: Mon, 13 May 2024 19:50:59 +0800
Message-ID: <CABOYnLygfZLue33Z6GKhY-WoDqXmKfc6KWpffQ0QF5TAaJX_+g@mail.gmail.com>
Subject: Re: [syzbot] [v9fs?] KASAN: slab-use-after-free Write in v9fs_free_request
To: syzbot+df038d463cca332e8414@syzkaller.appspotmail.com
Cc: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev, yue sun <samsun1006219@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hello, I found a reproducer for this bug.

If you fix this issue, please add the following tag to the commit:
Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: yue sun <samsun1006219@gmail.com>

I use the same kernel as syzbot instance
git tree: upstream ba16c1cf11c9f264b5455cb7d57267b39925409a
kernel config: https://syzkaller.appspot.com/x/.config?x=6d14c12b661fb43
dashboard link: https://syzkaller.appspot.com/bug?extid=df038d463cca332e8414
compiler: Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Since, this may be a concurrency bug, we need to run the PoC for a
while, like ./syz-execprog -repeat 0 ../prog for 5 minus, and I test
that only syzlang repro work.
[ 106.007857][ T39]
==================================================================
[ 106.008516][ T39] BUG: KASAN: slab-use-after-free in
v9fs_free_request+0x69/0xf0
[ 106.009146][ T39] Write of size 4 at addr ffff88802842620c by task
kworker/u17:1/39
[ 106.009773][ T39]
[ 106.009976][ T39] CPU: 2 PID: 39 Comm: kworker/u17:1 Not tainted
6.9.0-rc7-00136-gf4345f05c0df-dirty #6
[ 106.010722][ T39] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 106.011521][ T39] Workqueue: events_unbound v9fs_upload_to_server_worker
[ 106.012083][ T39] Call Trace:
[ 106.012351][ T39] <TASK>
[ 106.012585][ T39] dump_stack_lvl+0x250/0x380
[ 106.012976][ T39] ? __pfx_dump_stack_lvl+0x10/0x10
[ 106.013396][ T39] ? __pfx__printk+0x10/0x10
[ 106.013783][ T39] ? _printk+0xda/0x120
[ 106.014118][ T39] ? __virt_addr_valid+0x19b/0x580
[ 106.014532][ T39] ? __virt_addr_valid+0x19b/0x580
[ 106.014943][ T39] print_report+0x169/0x550
[ 106.015306][ T39] ? __virt_addr_valid+0x19b/0x580
[ 106.015712][ T39] ? __virt_addr_valid+0x19b/0x580
[ 106.016119][ T39] ? __virt_addr_valid+0x4a8/0x580
[ 106.016526][ T39] ? __phys_addr+0xc3/0x180
[ 106.016892][ T39] ? v9fs_free_request+0x69/0xf0
[ 106.017287][ T39] kasan_report+0x143/0x180
[ 106.017650][ T39] ? v9fs_free_request+0x69/0xf0
[ 106.018053][ T39] kasan_check_range+0x282/0x290
[ 106.018444][ T39] v9fs_free_request+0x69/0xf0
[ 106.018828][ T39] ? __pfx_v9fs_free_request+0x10/0x10
[ 106.019260][ T39] netfs_free_request+0x259/0x630
[ 106.019660][ T39] ? netfs_free_subrequest+0x26f/0x420
[ 106.020092][ T39] v9fs_upload_to_server_worker+0x211/0x400
[ 106.020564][ T39] ? __pfx_v9fs_upload_to_server_worker+0x10/0x10
[ 106.021055][ T39] ? process_scheduled_works+0x93a/0x1840
[ 106.021510][ T39] process_scheduled_works+0xa39/0x1840
[ 106.021966][ T39] ? __pfx_process_scheduled_works+0x10/0x10
[ 106.022441][ T39] ? assign_work+0x3b7/0x430
[ 106.022811][ T39] worker_thread+0x89c/0xdc0
[ 106.023187][ T39] ? __kthread_parkme+0x172/0x1d0
[ 106.023589][ T39] kthread+0x310/0x3b0
[ 106.023918][ T39] ? __pfx_worker_thread+0x10/0x10
[ 106.024330][ T39] ? __pfx_kthread+0x10/0x10
[ 106.024702][ T39] ret_from_fork+0x52/0x80
[ 106.025062][ T39] ? __pfx_kthread+0x10/0x10
[ 106.025432][ T39] ret_from_fork_asm+0x1a/0x30
[ 106.025826][ T39] </TASK>
[ 106.026072][ T39]
[ 106.026259][ T39] Allocated by task 34417:
[ 106.026608][ T39] kasan_save_track+0x3f/0x80
[ 106.026981][ T39] __kasan_kmalloc+0x98/0xb0
[ 106.027347][ T39] kmalloc_trace+0x1db/0x370
[ 106.027721][ T39] p9_fid_create+0x54/0x230
[ 106.028083][ T39] p9_client_walk+0x118/0x6c0
[ 106.028456][ T39] v9fs_file_open+0x2b9/0xae0
[ 106.028827][ T39] do_dentry_open+0x93d/0x1610
[ 106.029213][ T39] path_openat+0x29ba/0x33f0
[ 106.029578][ T39] do_filp_open+0x23c/0x4a0
[ 106.029946][ T39] do_sys_openat2+0x122/0x1c0
[ 106.030323][ T39] __x64_sys_creat+0x128/0x170
[ 106.030706][ T39] do_syscall_64+0xf5/0x240
[ 106.031064][ T39] entry_SYSCALL_64_after_hwframe+0x77/0x7f
[ 106.031529][ T39]
[ 106.031722][ T39] Freed by task 8234:
[ 106.032036][ T39] kasan_save_track+0x3f/0x80
[ 106.032412][ T39] kasan_save_free_info+0x40/0x50
[ 106.032817][ T39] poison_slab_object+0xa6/0xe0
[ 106.033205][ T39] __kasan_slab_free+0x37/0x60
[ 106.033582][ T39] kfree+0x153/0x3b0
[ 106.033905][ T39] p9_client_destroy+0x205/0x6b0
[ 106.034296][ T39] v9fs_session_close+0x5b/0x220
[ 106.034690][ T39] v9fs_kill_super+0x61/0x90
[ 106.035056][ T39] deactivate_locked_super+0xcb/0x140
[ 106.035477][ T39] cleanup_mnt+0x444/0x4e0
[ 106.035836][ T39] task_work_run+0x25c/0x320
[ 106.036206][ T39] syscall_exit_to_user_mode+0x168/0x370
[ 106.036650][ T39] do_syscall_64+0x102/0x240
[ 106.037023][ T39] entry_SYSCALL_64_after_hwframe+0x77/0x7f
[ 106.037485][ T39]
[ 106.037673][ T39] The buggy address belongs to the object at ffff888028426200
[ 106.037673][ T39] which belongs to the cache kmalloc-96 of size 96
[ 106.038739][ T39] The buggy address is located 12 bytes inside of
[ 106.038739][ T39] freed 96-byte region [ffff888028426200, ffff888028426260)
[ 106.039789][ T39]
[ 106.039979][ T39] The buggy address belongs to the physical page:
[ 106.040480][ T39] page: refcount:1 mapcount:0
mapping:0000000000000000 index:0x0 pfn:0x28426
[ 106.041162][ T39] flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
[ 106.041770][ T39] page_type: 0xffffffff()
[ 106.042117][ T39] raw: 00fff00000000800 ffff888015042780
ffffea00006db8c0 dead000000000002
[ 106.042783][ T39] raw: 0000000000000000 0000000000200020
00000001ffffffff 0000000000000000
[ 106.043442][ T39] page dumped because: kasan: bad access detected
[ 106.043944][ T39] page_owner tracks the page as allocated
[ 106.044388][ T39] page last allocated via order 0, migratetype
Unmovable, gfp_mask 0x12820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY),
pid 8265, tgid 626513798 (syz-executor), ts 8265, free_ts 69218878619
[ 106.045775][ T39] post_alloc_hook+0x1ea/0x210
[ 106.046156][ T39] get_page_from_freelist+0x3410/0x35b0
[ 106.046598][ T39] __alloc_pages+0x256/0x6c0
[ 106.046963][ T39] alloc_slab_page+0x5f/0x160
[ 106.047337][ T39] new_slab+0x84/0x2f0
[ 106.047661][ T39] ___slab_alloc+0xc73/0x1260
[ 106.048034][ T39] kmalloc_trace+0x269/0x370
[ 106.048404][ T39] nsim_fib_event_nb+0x191/0x1130
[ 106.048812][ T39] notifier_call_chain+0x1ae/0x400
[ 106.049213][ T39] atomic_notifier_call_chain+0xea/0x1a0
[ 106.049651][ T39] call_fib_notifiers+0x3f/0x70
[ 106.050049][ T39] call_fib_entry_notifiers+0x218/0x380
[ 106.050492][ T39] fib_table_insert+0xf43/0x1fe0
[ 106.050888][ T39] fib_magic+0x3df/0x620
[ 106.051225][ T39] fib_add_ifaddr+0x156/0x610
[ 106.051597][ T39] fib_inetaddr_event+0x16f/0x200
[ 106.051996][ T39] page last free pid 34 tgid 34 stack trace:
[ 106.052460][ T39] free_unref_page_prepare+0x97b/0xaa0
[ 106.052893][ T39] free_unref_page+0x37/0x3f0
[ 106.053264][ T39] __put_partials+0xeb/0x130
[ 106.053628][ T39] put_cpu_partial+0x17c/0x250
[ 106.054014][ T39] __slab_free+0x2ea/0x3d0
[ 106.054371][ T39] qlist_free_all+0x5e/0xc0
[ 106.054733][ T39] kasan_quarantine_reduce+0x14f/0x170
[ 106.055163][ T39] __kasan_slab_alloc+0x23/0x80
[ 106.055546][ T39] kmalloc_trace+0x16f/0x370
[ 106.055913][ T39] nsim_fib_event_work+0xe30/0x41d0
[ 106.056325][ T39] process_scheduled_works+0xa39/0x1840
[ 106.056759][ T39] worker_thread+0x89c/0xdc0
[ 106.057123][ T39] kthread+0x310/0x3b0
[ 106.057451][ T39] ret_from_fork+0x52/0x80
[ 106.057811][ T39] ret_from_fork_asm+0x1a/0x30
[ 106.058194][ T39]
[ 106.058383][ T39] Memory state around the buggy address:
[ 106.058816][ T39] ffff888028426100: fa fb fb fb fb fb fb fb fb fb fb
fb fc fc fc fc
[ 106.059435][ T39] ffff888028426180: 00 00 00 00 00 00 00 00 00 fc fc
fc fc fc fc fc
[ 106.060052][ T39] >ffff888028426200: fa fb fb fb fb fb fb fb fb fb
fb fb fc fc fc fc
[ 106.060667][ T39] ^
[ 106.061009][ T39] ffff888028426280: 00 00 00 00 00 00 00 00 00 00 fc
fc fc fc fc fc
[ 106.061630][ T39] ffff888028426300: fa fb fb fb fb fb fb fb fb fb fb
fb fc fc fc fc
[ 106.062256][ T39]
==================================================================
[ 106.071000][ T39] Kernel panic - not syncing: KASAN: panic_on_warn set ...
[ 106.071654][ T39] CPU: 0 PID: 39 Comm: kworker/u17:1 Not tainted
6.9.0-rc7-00136-gf4345f05c0df-dirty #6
[ 106.072473][ T39] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 106.073339][ T39] Workqueue: events_unbound v9fs_upload_to_server_worker
[ 106.073954][ T39] Call Trace:
[ 106.074242][ T39] <TASK>
[ 106.074500][ T39] dump_stack_lvl+0x250/0x380
[ 106.074910][ T39] ? __pfx_dump_stack_lvl+0x10/0x10
[ 106.075361][ T39] ? __pfx__printk+0x10/0x10
[ 106.075765][ T39] ? preempt_schedule+0xe1/0xf0
[ 106.076188][ T39] ? vscnprintf+0x64/0x90
[ 106.076563][ T39] panic+0x35a/0x890
[ 106.076905][ T39] ? check_panic_on_warn+0x2b/0xb0
[ 106.077351][ T39] ? __pfx_panic+0x10/0x10
[ 106.077738][ T39] ? _raw_spin_unlock_irqrestore+0x130/0x140
[ 106.078260][ T39] ? __pfx__raw_spin_unlock_irqrestore+0x10/0x10
[ 106.078803][ T39] ? print_report+0x502/0x550
[ 106.079216][ T39] check_panic_on_warn+0x8f/0xb0
[ 106.079643][ T39] ? v9fs_free_request+0x69/0xf0
[ 106.080066][ T39] end_report+0x77/0x160
[ 106.080434][ T39] kasan_report+0x154/0x180
[ 106.080821][ T39] ? v9fs_free_request+0x69/0xf0
[ 106.081249][ T39] kasan_check_range+0x282/0x290
[ 106.081674][ T39] v9fs_free_request+0x69/0xf0
[ 106.082092][ T39] ? __pfx_v9fs_free_request+0x10/0x10
[ 106.082562][ T39] netfs_free_request+0x259/0x630
[ 106.082991][ T39] ? netfs_free_subrequest+0x26f/0x420
[ 106.083475][ T39] v9fs_upload_to_server_worker+0x211/0x400
[ 106.083992][ T39] ? __pfx_v9fs_upload_to_server_worker+0x10/0x10
[ 106.084551][ T39] ? process_scheduled_works+0x93a/0x1840
[ 106.085056][ T39] process_scheduled_works+0xa39/0x1840
[ 106.085554][ T39] ? __pfx_process_scheduled_works+0x10/0x10
[ 106.086086][ T39] ? assign_work+0x3b7/0x430
[ 106.086498][ T39] worker_thread+0x89c/0xdc0
[ 106.086908][ T39] ? __kthread_parkme+0x172/0x1d0
[ 106.087354][ T39] kthread+0x310/0x3b0
[ 106.087717][ T39] ? __pfx_worker_thread+0x10/0x10
[ 106.088171][ T39] ? __pfx_kthread+0x10/0x10
[ 106.088567][ T39] ret_from_fork+0x52/0x80
[ 106.088952][ T39] ? __pfx_kthread+0x10/0x10
[ 106.089352][ T39] ret_from_fork_asm+0x1a/0x30
[ 106.089777][ T39] </TASK>
[ 106.090207][ T39] Kernel Offset: disabled
[ 106.090585][ T39] Rebooting in 86400 seconds..


=* repro.txt =*
creat(&(0x7f0000000240)='./file0\x00', 0x0)
pipe2$9p(&(0x7f0000000080)={<r0=>0xffffffffffffffff,
<r1=>0xffffffffffffffff}, 0x0)
write$P9_RVERSION(r1,
&(0x7f0000000480)=ANY=[@ANYBLOB="1500000065ffff018000000800395032303030"],
0x15)
r2 = dup(r1)
write$FUSE_BMAP(r2, &(0x7f0000000100)={0x18}, 0x18)
write$FUSE_NOTIFY_RETRIEVE(r2, &(0x7f00000000c0)={0x14c}, 0x137)
mount$9p_fd(0x0, &(0x7f0000000000)='./file0\x00', &(0x7f0000000040),
0x0, &(0x7f0000000280)={'trans=fd,', {'rfdno', 0x3d, r0}, 0x2c,
{'wfdno', 0x3d, r2}, 0x2c, {[{@cache_mmap}], [], 0x6b}})
chmod(&(0x7f0000000140)='./file0\x00', 0x0)
r3 = creat(&(0x7f00000004c0)='./file0\x00', 0x600000000000000)
write$FUSE_DIRENTPLUS(r3, &(0x7f0000000200)=ANY=[], 0x1001)

and see also in
https://gist.github.com/xrivendell7/f9a108d59abc4c4fe1883e6d347f7b17.

I hope it helps.
Best regards
xingwei lee

