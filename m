Return-Path: <linux-kernel+bounces-354480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEB8993E04
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 06:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E5B4B23012
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 04:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1A7137932;
	Tue,  8 Oct 2024 04:29:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A55135A69
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 04:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728361744; cv=none; b=raZLrVNuTR9P+e0jS7mR7wrMOs4Lb6ybq7h9h7sOHENZsB+HDMi1roSZJiRiGs8Kl4Jug1oEr6IMFhLwirDVW4ocfNbY95etn7F2BKq5ik3p1atS6qdmnaixXCILrU+iowz1GTYPdlGEYXKm+vUolYbOVpZxGSZlYkCecs0NFPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728361744; c=relaxed/simple;
	bh=HjQbh03wAl2L5RRbv8PryHIL+Z74+F02TEG7HiSiN/Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NKjWXE/NUwMsPolG1gjaXv/p0iyKMAmFqeUHGi3b/sxmvyTl8/xh9Z6HXPB37oVPj+2hYiru/AAIvEVS/FQPyLKKeeThj7neScIpQSP3m5PHMT1vP8H3ZuYVjrAPtnV4UvbcCd2uQ0DQxuFtgfuZSxu/eYienYM3LQ/1TXe8Sew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-831e873e4e4so408745939f.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 21:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728361742; x=1728966542;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JReZ/1yPBKQndox+MJlmbYm+fSfopOPKgYabd96xzFQ=;
        b=PaB3/AvoC2ZSy4dsqRfcDuepSLswjQN2j/H1ApCQCXkXMkJud4jBo7yLMrLofXD5Zg
         flWZ3+xwG8LUKCr0tSto89+UWcCXQ+HRfiFNgD2qxs4IqHL/kxxikMVLxGtvBdyB57b5
         LCtuXvlwAUJljZ4kzOYyW2MLq3z700sIcAsuGsspOv/wl31+bgEP6N0+Sfm/Qyec9RTo
         F4n4kkVykrz0qCx/zopuggUfV8ybc2FFbAVtqil+jf8wMN+K38ORrSVHhdualWESk89h
         9C5UC6S5FPlrmii5VZt4NTrIgJHLma8OHK9x+86Pjh54r+0TJgYCU6mGxyPlZiA5FW3f
         1NeQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6xcp0ghdJSck5GD1cy5sNsJ1ZFSPSitL/6qkZeHrYacV7i61gj94/Dhi9cJbjwKbagNjI8ps7lgOUqM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMRWgfMYoQrXdYbDUB5qhbXT/yab7JxdOdyDX69QxMYgAuBLmc
	pJVkwx5tC4yoa5SLRenXxMLc8k1wEXRLMDQWPrZ5ZeFUgp8U3/++Ph/rA9vHrMi4LMDmQcOM6R8
	MVklhd+xNBiZe+onnQnzNMajVpG8LgLlFM25gjKnm5TbsZv76CoR+7Kw=
X-Google-Smtp-Source: AGHT+IElUx/7bX1NMhK2xXsWLcc5/IpMF+7jwmn5Z/oAZyqaUzvv5ROJ5ZbDCXqCtqs6HwP2gWaYv0857HliFAzIWtpCqPdfIF6Q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a6:b0:3a0:a385:911d with SMTP id
 e9e14a558f8ab-3a3757d92e5mr115478535ab.0.1728361742188; Mon, 07 Oct 2024
 21:29:02 -0700 (PDT)
Date: Mon, 07 Oct 2024 21:29:02 -0700
In-Reply-To: <tencent_193D761367023C1936DE96C236B24A627409@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6704b50e.050a0220.49194.0522.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KMSAN: uninit-value in hci_rx_work
From: syzbot <syzbot+6ea290ba76d8c1eb1ac2@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in hci_rx_work

=====================================================
BUG: KMSAN: uninit-value in hci_acldata_packet net/bluetooth/hci_core.c:3796 [inline]
BUG: KMSAN: uninit-value in hci_rx_work+0xff7/0x1150 net/bluetooth/hci_core.c:4030
 hci_acldata_packet net/bluetooth/hci_core.c:3796 [inline]
 hci_rx_work+0xff7/0x1150 net/bluetooth/hci_core.c:4030
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3310
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3391
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4091 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_node_noprof+0x6bf/0xb80 mm/slub.c:4186
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:587
 __alloc_skb+0x363/0x7b0 net/core/skbuff.c:678
 alloc_skb include/linux/skbuff.h:1322 [inline]
 bt_skb_alloc include/net/bluetooth/bluetooth.h:493 [inline]
 vhci_get_user drivers/bluetooth/hci_vhci.c:487 [inline]
 vhci_write+0x127/0x900 drivers/bluetooth/hci_vhci.c:607
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xb28/0x1540 fs/read_write.c:683
 ksys_write+0x24f/0x4c0 fs/read_write.c:736
 __do_sys_write fs/read_write.c:748 [inline]
 __se_sys_write fs/read_write.c:745 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:745
 x64_sys_call+0x306a/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 4556 Comm: kworker/u9:1 Not tainted 6.12.0-rc2-syzkaller-g87d6aab2389e-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: hci0 hci_rx_work
=====================================================


Tested on:

commit:         87d6aab2 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1602bb80580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=981fe2ff8a1e457a
dashboard link: https://syzkaller.appspot.com/bug?extid=6ea290ba76d8c1eb1ac2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12890f9f980000


