Return-Path: <linux-kernel+bounces-540868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 586D6A4B5F7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3C9E16C074
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 02:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E092A1CF;
	Mon,  3 Mar 2025 02:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZDTne0x"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425CD146585
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 02:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740967745; cv=none; b=bhu09pMzEzKeBgYaHZIDd1t7Ql51/narswO1XPt0q/QMfjSl7lb4GbQL1Fgvg0RzqpI/4O8NbZUaLNWJdymyTGZ7y+NuNowVIjoaUq67N9cj6pK7ZSO7gW3iOXgr7ATDHkHmcf0H7NDk1mhxYKzi4jOp0wlVkKqkl9fdII3MNmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740967745; c=relaxed/simple;
	bh=Eru7GAzLk7NsFLzOIwtfwBmFfsFnVh4686GU4xU1hWM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=XqZlN2r/TnHgdt0VT7PqFTS0qe5Yei+THH7sXhgKoL46VHvBEIT0emZg7MyNJMQI7FFn+l3YB76u3AbEBeB7K/au6fxSnnA6LbqsdLJ3/pLq8wHXCIun3v0ZC1G75/mv5Fgd2syCFH1lclTkC+59YlhaC6EqOvpltffa4/mGCdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZDTne0x; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5fc6cd89f85so1638752eaf.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 18:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740967742; x=1741572542; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bGVtdzstiW/wqh/Ldd58xgGtwp0dOJm8co7AXDuD+CY=;
        b=cZDTne0xXLFLxYsUyKeV6CMj5IBsB6a59kZDikrBAMpgw3hY3OMGN0Z84/iUEFliok
         bWoDPUeXUaQXl+TZzwNySUmdD/dF4BxXx1+SDCcXle9RCAOJhJKYF8pwujnfI2aAUWc1
         DLQmOV7oq9Vmz41XVYltbXbOQmpXXVNLyUXA4bZzZlvcuMuD7CHPKrCfnDPwgC6ZDIE8
         j/lQnpOi8Cpl4/rixSUTovHImu5dVfdC30aasUMqgCrtd+sb5hki4a3Y12k4BWGh/943
         l9A3fRDyFhzJKahj1jD59oGyfXf5yfCOvrCrP5HcIEtvhhNQGGiSKezbcSoEZO6HQsvv
         +V9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740967742; x=1741572542;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bGVtdzstiW/wqh/Ldd58xgGtwp0dOJm8co7AXDuD+CY=;
        b=m/R5hXzQX6pETdDU38utptJLbIkGtU4xzvFDRyuGn0oWtsV1CxTYN9PSb9Xh4xnf0N
         vIWvMktF7Uhay1JvBRClx6DBopa7UKwg4wKvEKxYoXzuRAyF6SZ/YqlM7khZCqbeVsZW
         iWkgi41DMUg1/2N6EBIQbn/aeeGJLG7+8TjSynmwum2xAre247br2EPzcDnxi2Ga/M7v
         rReooQ6/j03Q80E0i09W5vF4fVHdDbFPR4ganQLm66IOo3RFu/mU+YsoRDcGR/GHRlMM
         S7rw+hLtnM+WrKfxvoL2jNa2szB71nGwsRyOiTlHF1ZUCVXvApW0De4qAd4MVyExW1sH
         w96A==
X-Forwarded-Encrypted: i=1; AJvYcCUxf6uC4waUF36UgWBX0Ylj3BPw0CcV797AuAnCj9f1w9039/VRtPaJepxfLx13kc8IIIcf8SrhD7rOh2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3cM5rE6TasZ2UjPP3CXlkhkhmkDX0swEvK9rzsg9dlcduXwch
	GFiX9f+497qWzTzt6ITkf4qhGKeEBQ/kR+k5H1hImVN3K5yuCs2hJ2pn3RPNaDQV6f/xligY6aw
	377Xi7eFLkFQaYcMVFpMzrW+RLsg=
X-Gm-Gg: ASbGncsfWpYGN6HfWAfb4uiEUomawoqAmHDtrQweZupno6Tygt4PrlGwO8CE1p3lawR
	N8NGqlNwY/zzb9XPzzeWecWlw+x8gjRdEHLdsljuHBUw2QifxBUi1M14VHNZcUnwkjWPDMefLI4
	dIwsjFgV0tYIqaIOy+X16XlwDpdA==
X-Google-Smtp-Source: AGHT+IECdbEngM1QwmkflxOZqBnCIk+22Ndoku3IRNsN8NE6AjLygIdCsGztaqwVoc5FxdYaBBRftwi2/HRDtbSNBIY=
X-Received: by 2002:a05:6870:390f:b0:29e:5c37:a1c0 with SMTP id
 586e51a60fabf-2c1783f5c45mr6994385fac.21.1740967742003; Sun, 02 Mar 2025
 18:09:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Strforexc yn <strforexc@gmail.com>
Date: Mon, 3 Mar 2025 10:08:51 +0800
X-Gm-Features: AQ5f1Jo98mhugTMDnFGdj1_SXDDWwzAo-t8qVEMESU92n4XUXIcKkevpDxkwbfE
Message-ID: <CA+HokZqaL86gQ-7zSW+4YZs2krj4PRnk3Qz2p8a7uBUwkHhdBw@mail.gmail.com>
Subject: =?UTF-8?B?S0FTQU46IHNsYWItb3V0LW9mLWJvdW5kcyBXcml0ZSBpbiBkaVdyaXRl77yIIHY2LjE0LQ==?=
	=?UTF-8?B?cmM0IGtlcm5lbO+8iQ==?=
To: Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Kernel commit: v6.14-rc4 (Commits on Feb 24, 2025)
Kernel Config : https://github.com/Strforexc/LinuxKernelbug/blob/main/.conf=
ig
Kernel Log: LinuxKernelbug/KASAN slab-out-of-bounds Write in
diWrite/log0 at main =C2=B7 Strforexc/LinuxKernelbug
Reproduce: LinuxKernelbug/KASAN slab-out-of-bounds Write in
diWrite/repro.prog at main =C2=B7 Strforexc/LinuxKernelbug


This bug seems to have been reported and fixed in the old kernel,
which seems to be a regression issue? If you fix this issue, please
add the following tag to the commit:
Reported-by: Zhizhuo Tang strforexctzzchange@foxmail.com, Jianzhou
Zhao xnxc22xnxc22@qq.com

loop5: detected capacity change from 0 to 32768
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-out-of-bounds in diWrite+0xea2/0x1950 fs/jfs/jfs_imap.c:75=
3
Write of size 32 at addr ffff88802a7d40c0 by task syz.5.15/11537

CPU: 1 UID: 0 PID: 11537 Comm: syz.5.15 Not tainted 6.14.0-rc4 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1b0 lib/dump_stack.c:120
 print_address_description.constprop.0+0x2c/0x420 mm/kasan/report.c:408
 print_report+0xaa/0x270 mm/kasan/report.c:521
 kasan_report+0xbd/0x100 mm/kasan/report.c:634
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x108/0x1e0 mm/kasan/generic.c:189
 __asan_memcpy+0x3d/0x70 mm/kasan/shadow.c:106
 diWrite+0xea2/0x1950 fs/jfs/jfs_imap.c:753
 txCommit+0x6ab/0x1400 fs/jfs/jfs_txnmgr.c:1255
 add_missing_indices+0x834/0xb20 fs/jfs/jfs_dtree.c:2663
 jfs_readdir+0x1b1e/0x26d0 fs/jfs/jfs_dtree.c:3019
 wrap_directory_iterator+0xa2/0xf0 fs/readdir.c:65
 iterate_dir+0x2b5/0xac0 fs/readdir.c:108
 __do_sys_getdents64 fs/readdir.c:403 [inline]
 __se_sys_getdents64 fs/readdir.c:389 [inline]
 __x64_sys_getdents64+0x154/0x2e0 fs/readdir.c:389
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcb/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ffaffdb85ad
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffb00d41f98 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007ffb00045fa0 RCX: 00007ffaffdb85ad
RDX: 000000000000005d RSI: 00004000000002c0 RDI: 0000000000000005
RBP: 00007ffaffe6a8d6 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007ffb00045fa0 R15: 00007ffb00d22000
 </TASK>

Allocated by task 9387:
 kasan_save_stack+0x24/0x50 mm/kasan/common.c:47
 kasan_save_track+0x14/0x40 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x97/0xa0 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4115 [inline]
 slab_alloc_node mm/slub.c:4164 [inline]
 kmem_cache_alloc_noprof+0x167/0x400 mm/slub.c:4171
 __kernfs_new_node+0xd4/0x8d0 fs/kernfs/dir.c:624
 kernfs_new_node+0x185/0x250 fs/kernfs/dir.c:700
 __kernfs_create_file+0x55/0x370 fs/kernfs/file.c:1034
 sysfs_add_file_mode_ns+0x211/0x400 fs/sysfs/file.c:313
 create_files+0x186/0x6b0 fs/sysfs/group.c:76
 internal_create_group+0x3c3/0x8a0 fs/sysfs/group.c:183
 internal_create_groups+0x9e/0x150 fs/sysfs/group.c:223
 device_add_groups drivers/base/core.c:2812 [inline]
 device_add_attrs+0xdd/0x660 drivers/base/core.c:2876
 device_add+0x6c9/0x1490 drivers/base/core.c:3619
 netdev_register_kobject+0x185/0x3b0 net/core/net-sysfs.c:2170
 register_netdevice+0xf25/0x1770 net/core/dev.c:10949
 veth_newlink+0x3a4/0x8b0 drivers/net/veth.c:1844
 rtnl_newlink_create+0x2d8/0x700 net/core/rtnetlink.c:3796
 __rtnl_newlink+0x23c/0xa80 net/core/rtnetlink.c:3907
 rtnl_newlink+0x7eb/0xc90 net/core/rtnetlink.c:4022
 rtnetlink_rcv_msg+0x9f4/0xfc0 net/core/rtnetlink.c:6912
 netlink_rcv_skb+0x168/0x450 net/netlink/af_netlink.c:2543
 netlink_unicast_kernel net/netlink/af_netlink.c:1322 [inline]
 netlink_unicast+0x552/0x800 net/netlink/af_netlink.c:1348
 netlink_sendmsg+0x8b3/0xd90 net/netlink/af_netlink.c:1892
 sock_sendmsg_nosec net/socket.c:718 [inline]
 __sock_sendmsg net/socket.c:733 [inline]
 __sys_sendto+0x4b2/0x520 net/socket.c:2187
 __do_sys_sendto net/socket.c:2194 [inline]
 __se_sys_sendto net/socket.c:2190 [inline]
 __x64_sys_sendto+0xe4/0x1d0 net/socket.c:2190
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcb/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88802a7d4000
 which belongs to the cache kernfs_node_cache of size 176
The buggy address is located 16 bytes to the right of
 allocated 176-byte region [ffff88802a7d4000, ffff88802a7d40b0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2a7d4
flags: 0xfff00000000000(node=3D0|zone=3D1|lastcpupid=3D0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff8880404fb140 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000110011 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask
0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 9387,
tgid 9387 (syz-executor), ts 67779724149, free_ts 66055112407
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1a3/0x1d0 mm/page_alloc.c:1551
 prep_new_page mm/page_alloc.c:1559 [inline]
 get_page_from_freelist+0x8a5/0xfa0 mm/page_alloc.c:3477
 __alloc_frozen_pages_noprof+0x1d8/0x3b0 mm/page_alloc.c:4739
 alloc_pages_mpol+0x1f2/0x550 mm/mempolicy.c:2270
 alloc_slab_page mm/slub.c:2423 [inline]
 allocate_slab+0x229/0x310 mm/slub.c:2587
 ___slab_alloc+0x7f3/0x12b0 mm/slub.c:3826
 __slab_alloc.constprop.0+0x56/0xc0 mm/slub.c:3916
 __slab_alloc_node mm/slub.c:3991 [inline]
 slab_alloc_node mm/slub.c:4152 [inline]
 kmem_cache_alloc_noprof+0x275/0x400 mm/slub.c:4171
 __kernfs_new_node+0xd4/0x8d0 fs/kernfs/dir.c:624
 kernfs_new_node+0x185/0x250 fs/kernfs/dir.c:700
 __kernfs_create_file+0x55/0x370 fs/kernfs/file.c:1034
 sysfs_add_file_mode_ns+0x211/0x400 fs/sysfs/file.c:313
 create_files+0x186/0x6b0 fs/sysfs/group.c:76
 internal_create_group+0x3c3/0x8a0 fs/sysfs/group.c:183
 internal_create_groups+0x9e/0x150 fs/sysfs/group.c:223
 device_add_groups drivers/base/core.c:2812 [inline]
 device_add_attrs+0xdd/0x660 drivers/base/core.c:2876
page last free pid 89 tgid 89 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_folios+0x8f4/0x12b0 mm/page_alloc.c:2707
 shrink_folio_list+0x2bf2/0x3ea0 mm/vmscan.c:1587
 shrink_inactive_list+0x370/0xc90 mm/vmscan.c:2000
 shrink_list mm/vmscan.c:2238 [inline]
 shrink_lruvec+0x26e/0xa60 mm/vmscan.c:5749
 shrink_node_memcgs+0x4fc/0x9c0 mm/vmscan.c:5951
 shrink_node+0x1c5/0x1180 mm/vmscan.c:5992
 kswapd_shrink_node mm/vmscan.c:6807 [inline]
 balance_pgdat+0x8be/0x1320 mm/vmscan.c:6999
 kswapd+0x32b/0x460 mm/vmscan.c:7264
 kthread+0x3b3/0x760 kernel/kthread.c:464
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff88802a7d3f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88802a7d4000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88802a7d4080: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc 00 00
                                           ^
 ffff88802a7d4100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88802a7d4180: 00 00 00 00 fc fc fc fc fc fc fc fc 00 00 00 00
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Thanks,
Zhizhuo Tang

