Return-Path: <linux-kernel+bounces-527613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0A9A40D4C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 08:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F7ED3A0712
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 07:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E511FC7C8;
	Sun, 23 Feb 2025 07:52:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77181FC0E5
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 07:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740297125; cv=none; b=M018whv5BaRadaUJiLWIk0LEHaP47VKgDAeO1Faq1oOEWMO4tKCmQ9nsABHUjeOKJEA5D3SOKcKX6uC4kFZ/js3Q9GxOcg5XYa6MlYkggmdzSK8+Mg1FGhyb6mAbPYxA9NeI0AoTYRq91Yf2RNE8QBlLjhLkFECATQWwrqd8Nns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740297125; c=relaxed/simple;
	bh=NkN36S6nBiBoWbo3lRSuMSmUSEF41SNwR0YIJ9Kxv+k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PoXFFjEG4ncRmi0xVmWTAJMzxPMZccIiQQSXe2T8C/9sStlEhV6XFOrX749cScMxg+v8sdWrLI0+JZjlBDq0UlZN7Bw4neqDf09n4sBk4IvSn0HGDxXHODCh3T19NxOniGuY2Eq/TBduskCjzf3Qxg6aOV9OVvh39fvWsQELWLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-855b610548dso625062139f.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 23:52:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740297122; x=1740901922;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6MAJEXPqg1sySv3CL5RwaQRLT8TlVCC7fj/5gPZqxJw=;
        b=bSl510HD7mCpAhmuM+jxn27JOca6TYIBHJjLlGtiog5uH0h37zYK9GCuo6zsJAs3TN
         BVqu6K9z7bOvpyXzRFmXwg0gBDwiDtqRm0HqsNdP6eniWymDB7U1CEinjm3xwvEQQcyj
         BoENMZX/zhH2Mr19roXlRSAPAtKNkJ5gRk7Ae+Kdr6rBnKLRKS+d9LZojM3bCteBj0gg
         4TFwiALsN52AGuquqo1eC5ulYHeKZ/0uDe9xhlOpjnCRAhAfxTn1ESp4FTRMm3ebVEsE
         h5KcANxGocLvKaU5QWKz1i4UziEDzvR/eDTx8hOgp3HkyHTa4yXiJItUCV0x6gtxwiI8
         6QDw==
X-Forwarded-Encrypted: i=1; AJvYcCWdFuPHFeiyikH7E2i5Wuf6WmhGjKTxPthbqjjw9KQu0UgNJNjkTyQjCfJvWRfZAjJSXRknlsmIaxBR9Xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkqcflS9K8yI+2jaBjPNvpXo06/chwK1u9JD0tPugeaCpggtjd
	BQ1YZduVNjAxh0V4Zl2sWaFrqfJceAJsc9rck1ogVkZrtngFUsF3LoSyKhE6T8VBYjzbuDKY80k
	poI7Zif6RGuD+UfBOxPNeKpd3KAFlmRiPm03SEniMvW4Xg4rJEAgEvW4=
X-Google-Smtp-Source: AGHT+IGrCVCI85W3JotzjLrIbt4AKRVysVe2gZ8H+hFSNyuHSNrfvwjGCEGhY6ByUyQPTBw9uFXoYIU++hTgjxNE6H9AXi5NF4kC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a4:b0:3d0:123e:fbdd with SMTP id
 e9e14a558f8ab-3d2cae8a7b4mr86227915ab.11.1740297122777; Sat, 22 Feb 2025
 23:52:02 -0800 (PST)
Date: Sat, 22 Feb 2025 23:52:02 -0800
In-Reply-To: <20250223073007.2673-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bad3a2.050a0220.bbfd1.0010.GAE@google.com>
Subject: Re: [syzbot] [input?] [usb?] KASAN: slab-use-after-free Read in steam_input_open
From: syzbot <syzbot+0154da2d403396b2bd59@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: ODEBUG bug in release_nodes

------------[ cut here ]------------
ODEBUG: free active (active state 0) object: ffff888112274300 object type: work_struct hint: steam_work_unregister_cb+0x0/0x180 drivers/hid/hid-steam.c:870
WARNING: CPU: 1 PID: 36 at lib/debugobjects.c:612 debug_print_object+0x1a2/0x2b0 lib/debugobjects.c:612
Modules linked in:
CPU: 1 UID: 0 PID: 36 Comm: kworker/1:1 Not tainted 6.14.0-rc3-syzkaller-00295-g27102b38b8ca-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Workqueue: usb_hub_wq hub_event
RIP: 0010:debug_print_object+0x1a2/0x2b0 lib/debugobjects.c:612
Code: fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 54 48 8b 14 dd c0 d4 47 87 41 56 4c 89 e6 48 c7 c7 40 c9 47 87 e8 df e1 c0 fe 90 <0f> 0b 90 90 58 83 05 f6 7f d8 07 01 48 83 c4 18 5b 5d 41 5c 41 5d
RSP: 0018:ffffc90000267208 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000003 RCX: ffffffff813f4dd9
RDX: ffff888102ed57c0 RSI: ffffffff813f4de6 RDI: 0000000000000001
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff8747cfe0
R13: ffffffff87274240 R14: ffffffff85a7ab00 R15: ffffc90000267318
FS:  0000000000000000(0000) GS:ffff8881f5900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8542fc7bac CR3: 0000000116b54000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __debug_check_no_obj_freed lib/debugobjects.c:1099 [inline]
 debug_check_no_obj_freed+0x4b7/0x600 lib/debugobjects.c:1129
 slab_free_hook mm/slub.c:2284 [inline]
 slab_free mm/slub.c:4609 [inline]
 kfree+0x2e1/0x480 mm/slub.c:4757
 release_nodes+0x11e/0x240 drivers/base/devres.c:506
 devres_release_group+0x1be/0x2a0 drivers/base/devres.c:689
 hid_device_remove+0x107/0x260 drivers/hid/hid-core.c:2774
 device_remove+0xc8/0x170 drivers/base/dd.c:567
 __device_release_driver drivers/base/dd.c:1273 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1296
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:579
 device_del+0x396/0x9f0 drivers/base/core.c:3854
 hid_remove_device drivers/hid/hid-core.c:2953 [inline]
 hid_destroy_device+0x19c/0x240 drivers/hid/hid-core.c:2975
 usbhid_disconnect+0xa0/0xe0 drivers/hid/usbhid/hid-core.c:1458
 usb_unbind_interface+0x1e2/0x960 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:569 [inline]
 device_remove+0x122/0x170 drivers/base/dd.c:561
 __device_release_driver drivers/base/dd.c:1273 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1296
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:579
 device_del+0x396/0x9f0 drivers/base/core.c:3854
 usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1418
 usb_disconnect+0x2e1/0x920 drivers/usb/core/hub.c:2316
 hub_port_connect drivers/usb/core/hub.c:5373 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5673 [inline]
 port_event drivers/usb/core/hub.c:5833 [inline]
 hub_event+0x1bed/0x4f40 drivers/usb/core/hub.c:5915
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3317 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3398
 kthread+0x3af/0x750 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


Tested on:

commit:         27102b38 Merge tag 'v6.14-rc3-smb3-client-fix-part2' o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=142d5fdf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28127f006c1c31ee
dashboard link: https://syzkaller.appspot.com/bug?extid=0154da2d403396b2bd59
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=170157f8580000


