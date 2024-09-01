Return-Path: <linux-kernel+bounces-310177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F9A9675DE
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 12:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C9432824A8
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 10:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF87149E00;
	Sun,  1 Sep 2024 10:13:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC0442045
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 10:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725185585; cv=none; b=ot4NCZh92zdzWMHpzem7QFLPO860lyQuvgUWK6ggQWQ1sFDCdgKvaWFH+tm7Ig44GUW/gFcdq7Yl0li1cZm30qFJTOVrwcceMYYsPYo7u2Pwf4dNFRD68V29SOJODgZ4YxXgc/Q1oaP0dE3lYfSq+j0gzFiddX7O7DXPbJAeNlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725185585; c=relaxed/simple;
	bh=jEj2g/1L7U5EpWGs24I3v2VGaO59GPOHUpTIwEg2GQY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sBgyCYP3OyBr/A3H/Bp+vAXyo7OpXZwPtM/AlsB9rrB9i4LexV+DEoVM5a710Ia8mZzzBG0dT+nEeobISzMM6DQ0N+/TkH8QwThQHm9tqPoum7p0j3HZjl22uSHeF3rkSvL5x455Tw8wTVjiajOh3wFjpztKgBSQOpbteohVb38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39f4e119c57so15329525ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 03:13:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725185583; x=1725790383;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pyF7NdOnmdJ2161DRgVMqA/JwKNGhRBmwqFgW4ZcHRI=;
        b=XvNTAVVoUt/LcqHrPwXpXxunXPG3cjA/mcpip3Bbyl9KVL1yMSwCVkfK42JcFoQYbn
         7W+U9AflCtY0ljzkU8kY/alh7l4/RGkektfTdaO3Sv6NwdH9B9qkOXDq90VL+mS4UtjX
         wOzNosvYzSRBJzqgOAuqtm6Z9LW+MguxKpB5xL38PVxtcf5vJhjAPjS1Trj7iFg7CHYg
         alhJReM56NtqAMq8LpgKrckiMmirSsGG4cR9znFbLw3/ioYYXPkYbdUAXAUyMlnoxWIJ
         vLGTFwPmsyEk+3k5whkmn4BCFNBc+1c5vl2aib7E288dmIN74pqYid3O0DxH/q2AFrsH
         TrBg==
X-Forwarded-Encrypted: i=1; AJvYcCWIGptKPIp+RgzoBhCmh8XcvdhS7lctakpwEeKIazHAR5yPEOtxwCtDAYG7XN/RaO1cJOF4WJ6SfftE/JM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy27uoqgGCMt0g1G9i4W36yQH5sjz+ZJ6qNx84hIuUrA1gHctYh
	0nrTI21/9+3FYuBNwWJIa5AyJXSjcvM/TVUA9V9Bv7EdyC1H3beZx2tp+yf+yv9O+omxmqKgbaZ
	gj7lEPp/dxD3rISQoleeaCcIDY8tzbD37001Bbar2XE8l+5TumCfTo8s=
X-Google-Smtp-Source: AGHT+IGRFuOHe4sAmHrHmS2gwQagQv9i/72e39hoAGsPI9FyWKNbE9BZkWuCuLbIUIzwc/fhoyY5kAl1QZExWDZjemWp+yn0E9Vw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174d:b0:39f:518f:c9e1 with SMTP id
 e9e14a558f8ab-39f518fcbf3mr3164425ab.4.1725185583328; Sun, 01 Sep 2024
 03:13:03 -0700 (PDT)
Date: Sun, 01 Sep 2024 03:13:03 -0700
In-Reply-To: <20240901090400.1493-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ddc0b606210c11a0@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_recv_frame
From: syzbot <syzbot+5c915dc5dd417b83b348@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in l2cap_recv_frame

Bluetooth: hci0: command tx timeout
=====================================================
BUG: KMSAN: uninit-value in l2cap_conless_channel net/bluetooth/l2cap_core.c:6758 [inline]
BUG: KMSAN: uninit-value in l2cap_recv_frame+0xc9c5/0x18b10 net/bluetooth/l2cap_core.c:6832
 l2cap_conless_channel net/bluetooth/l2cap_core.c:6758 [inline]
 l2cap_recv_frame+0xc9c5/0x18b10 net/bluetooth/l2cap_core.c:6832
 l2cap_recv_acldata+0xdd9/0x2ac0 net/bluetooth/l2cap_core.c:7515
 hci_acldata_packet net/bluetooth/hci_core.c:3791 [inline]
 hci_rx_work+0xb38/0x1130 net/bluetooth/hci_core.c:4028
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3312
 worker_thread+0xea7/0x14d0 kernel/workqueue.c:3389
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3994 [inline]
 slab_alloc_node mm/slub.c:4037 [inline]
 kmem_cache_alloc_node_noprof+0x6bf/0xb80 mm/slub.c:4080
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:583
 __alloc_skb+0x363/0x7b0 net/core/skbuff.c:674
 alloc_skb include/linux/skbuff.h:1320 [inline]
 bt_skb_alloc include/net/bluetooth/bluetooth.h:493 [inline]
 vhci_get_user drivers/bluetooth/hci_vhci.c:487 [inline]
 vhci_write+0x128/0x910 drivers/bluetooth/hci_vhci.c:607
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xb2f/0x1550 fs/read_write.c:590
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 x64_sys_call+0x306a/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 5289 Comm: kworker/u9:2 Not tainted 6.11.0-rc5-syzkaller-00310-ge8784b0aef62-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: hci0 hci_rx_work
=====================================================


Tested on:

commit:         e8784b0a Merge tag 'usb-6.11-rc6' of git://git.kernel...
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1721e347980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b3e19fd08b312452
dashboard link: https://syzkaller.appspot.com/bug?extid=5c915dc5dd417b83b348
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=155009eb980000


