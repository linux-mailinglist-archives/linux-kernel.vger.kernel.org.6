Return-Path: <linux-kernel+bounces-209251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 843D3902F8E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 06:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC49228400F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 04:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8B416FF23;
	Tue, 11 Jun 2024 04:34:04 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C529386
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 04:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718080444; cv=none; b=jTK+ws/Gyaxmqsgt5xf5ECHwkPLd99POyX4xy+Yo0CkQpVW1KUa6y0gbmxOd913wB7ihBkkHdfroYGrRE21hlhYvSLB7OTZmgw3F+pALE9hAtrBZRVtNrM/TTbbXNbie+zgmRjX7w4hahLVIW/eh8n8y9bnDF0K37Nut1Iq6XX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718080444; c=relaxed/simple;
	bh=MxWSdzZ0Ki+RWTUzGHGRft2VmSoEvygFYKzpBnQivwk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AksxAb7sbRZ1DfzKQe5/kZgHg0Bq5Beote/OVl7zkUO1egvGRY0mulZiYg0COhcKp7b2fhOrkO9VTEvJNlIiUob5IhI8JjrN5nF+XFVK2gpKQiRLXjKao8MO9bpAv34nYKOD2eoqj9eWiCGNlBb+F8fLo4DbeNEnU/WP5ZRDY0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7eaa9ddad99so74304539f.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 21:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718080442; x=1718685242;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eyvKrG3Jol7r+bSHllwa0xIuvW0ZO4EU61YwcfEtQX4=;
        b=v8j5GKuM+Z123RaBPhdxkbf+s/c8lM2qA5pSSOmUcnhEENqj8NhRPksk5TDq4jIJaq
         EWLk9PZ+DjkmbWJshIIpGT+aLWi7W4o92zQ89Ts3w0yDPT2ucwMw6H70Gspz8RjM/85m
         3wpQuvAqmBv1RlCHomz63kiVl43xX83Ywbif3aoXEvRUwY3UFBUguDXcVrIfCXcvv0I3
         LX0qsXx6WEIR/asEox5H524G4i5CRS6sjmXkmFYOpFpni97w8Zh7s2RPT1ePsxfmi27j
         KpZsPScMBkZmndE68C+dLChP0CftgefOanN50bs6uqFzAJitLcw7oMtgafyI5o70rO1Q
         3+5A==
X-Forwarded-Encrypted: i=1; AJvYcCWpCWm2utaLNq0ITjsUQtX7tcc3ZXhm8LHFm2D6uA4LXBLSy8nrwnZQzfaE1x2TZy6YWNyi3YzM3Uz0fSOi/CofC0OtyZYqPFydmk9O
X-Gm-Message-State: AOJu0YyfE7cm5OekoMmvUyCgN0bSH9ejSbI/1JzKegpDiSRwzOWqvVhA
	ZFJEVykFgluwq5OJi54fyvyTd48fyPuR+io/q5WufO373i57BGVnXC+ZXOwYf2lK+Qp0m7GZYCW
	ceXLDM3lc8W7KBEmAufMB5erpmdJVkTZsSv7QLavqxytuTJPD1UrweWY=
X-Google-Smtp-Source: AGHT+IEP1KlpwNoN2WwLIxaNEKxlvBELxTkmkLW6I5Pv1TDfg5n6YiOL0wOKerF0GBhao0r8kOQGAyr0rGRCL/YeehhnOeYehHi7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:850b:b0:4b9:fb0:fd49 with SMTP id
 8926c6da1cb9f-4b90fb1077dmr195265173.3.1718080442184; Mon, 10 Jun 2024
 21:34:02 -0700 (PDT)
Date: Mon, 10 Jun 2024 21:34:02 -0700
In-Reply-To: <tencent_0036E097CA36A84BFA74C177EF66FC3CAF09@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000073c4f2061a95c6d7@google.com>
Subject: Re: [syzbot] [bluetooth?] general protection fault in l2cap_sock_recv_cb
From: syzbot <syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: held lock freed in l2cap_sock_recv_cb

=========================
WARNING: held lock freed!
6.10.0-rc1-syzkaller-00267-gcc8ed4d0a848-dirty #0 Not tainted
-------------------------
kworker/u9:3/6458 is freeing memory ffff88802f212000-ffff88802f2127ff, with a lock still held there!
ffff88802f212258 (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1602 [inline]
ffff88802f212258 (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+.}-{0:0}, at: l2cap_sock_recv_cb+0x58/0x6f0 net/bluetooth/l2cap_sock.c:1488
3 locks held by kworker/u9:3/6458:
 #0: ffff888079178148 ((wq_completion)hci1#2){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888079178148 ((wq_completion)hci1#2){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90004347d00 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90004347d00 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffff88802f212258 (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1602 [inline]
 #2: ffff88802f212258 (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+.}-{0:0}, at: l2cap_sock_recv_cb+0x58/0x6f0 net/bluetooth/l2cap_sock.c:1488

stack backtrace:
CPU: 0 PID: 6458 Comm: kworker/u9:3 Not tainted 6.10.0-rc1-syzkaller-00267-gcc8ed4d0a848-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Workqueue: hci1 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_freed_lock_bug kernel/locking/lockdep.c:6538 [inline]
 debug_check_no_locks_freed+0x3c5/0x4a0 kernel/locking/lockdep.c:6571
 slab_free_hook mm/slub.c:2159 [inline]
 slab_free mm/slub.c:4436 [inline]
 kfree+0xfa/0x360 mm/slub.c:4557
 sk_prot_free net/core/sock.c:2116 [inline]
 __sk_destruct+0x476/0x5f0 net/core/sock.c:2208
 sock_put include/net/sock.h:1879 [inline]
 l2cap_sock_recv_cb+0x596/0x6f0 net/bluetooth/l2cap_sock.c:1546
 l2cap_conless_channel net/bluetooth/l2cap_core.c:6780 [inline]
 l2cap_recv_frame+0x8b6d/0x10670 net/bluetooth/l2cap_core.c:6833
 hci_acldata_packet net/bluetooth/hci_core.c:3842 [inline]
 hci_rx_work+0x50f/0xca0 net/bluetooth/hci_core.c:4079
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Bluetooth: hci1: command tx timeout


Tested on:

commit:         cc8ed4d0 Merge tag 'drm-fixes-2024-06-01' of https://g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1082c82e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=47d282ddffae809f
dashboard link: https://syzkaller.appspot.com/bug?extid=b7f6f8c9303466e16c8a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1706587a980000


