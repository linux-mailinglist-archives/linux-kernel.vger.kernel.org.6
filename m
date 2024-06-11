Return-Path: <linux-kernel+bounces-209175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E903D902E3E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 04:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A25BB21505
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 02:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315C7BA5E;
	Tue, 11 Jun 2024 02:15:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAAAA94C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 02:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718072105; cv=none; b=rAeOBwr4wQw/EVWJyT2QPNYoZbvO36P1z586Qv/HOEXLPrCZRUEut2ljbtm+CWW6ro4a+LzfIq/xH/WY26BsBNqBCiau5WpL7bJOoKJn3WPD0YNSmLA3ifipX7wAh+bl7Ky5QDhWzllDCgAdYfzYyq4Eh3ObOpB2L+7xw5X+mow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718072105; c=relaxed/simple;
	bh=mEfVO07jHJ3r9UWUI1HyGbKK8qcYcV576PKnLNlcoJg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YBQGmGmQ6DuXD1+JRDiBWvX/BZJQvBJ993W6WwGBed2g89xt0hGUIGJFKfs5DA2KBs4j5QUFeHCe+Q0Z/Kwao6FBKayaXJG/uA0CnaRvAflktAtLyyZOMkxacvEAhhyTteYW8lg724325AMpW2ers/TERa6ulszbLwbj+xTx/RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7eb5f83ae57so329821539f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 19:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718072103; x=1718676903;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lhD8NPV+IaXIpPTT1nqmL8i1YPkjK35iGoJ19RdQs58=;
        b=leeE38Hg0JdbMqrXrk6SZUSgg4YaQBbB7RHuMP8GJbhxe7ZzWg1TSf92HeT7b6Hc3D
         T5cwo7xyR6zdksy/23NY5hjZtIK4iyM4eYYwD/ukAGMB8U6sU67KQniuurXCA0kBT7ev
         /2f3mwIaUsfJr6QWEh7VnmwQvQXZTsR42o87labo6KZSOR9lWbOs6F4Cr507z2huTRdU
         Vb3APCTu0TAZRDK7PYHSaE68/D9i023E/kaZncNjI4LqzueNR6R5AhsJ/ya+5QZCN8nm
         i7dLJe7W7Tj42cyXDzpsrLLLIXpBkVdQiEJQcYFCjZbLfZKPx/r1rQbJNbP1mpxINMNx
         2kcQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7B1jgwIxYOZUkgb3VNrRtY2K6Qp6TNAyvinkYTbtP3S9tp3Adf6cc1vnhkhpTpYCSNU6jzrdUw/XhSowsxrpx4akilRrOQ5f3+Lmi
X-Gm-Message-State: AOJu0YxzD+w52gSvk/O7DkTSAg6vevmulUXTY87TyrPQkIFKCAYv+vpp
	EL1pclz4KbDJKOvYVcLHbynWVspBvZcMOPgvFKhGciTiiP4wL6mkT+IdPS7EhpwcJXNZcHmY3oq
	QJR1giWTZo2yYHvBxRGtot/DuzLlHkSZiUgLypIYo07DVzhi1MinpuwE=
X-Google-Smtp-Source: AGHT+IGNpfK5OgTI/t7SSdUgoMwS+5ohepkWU1SF2eVLO+xDSnZTlCJmB4p27rMILouBbxDIQhAEfOk8j9/xhOvd8+7L1CBRNo67
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:b741:0:b0:375:af46:bb4a with SMTP id
 e9e14a558f8ab-375b32c19c2mr244295ab.3.1718072103303; Mon, 10 Jun 2024
 19:15:03 -0700 (PDT)
Date: Mon, 10 Jun 2024 19:15:03 -0700
In-Reply-To: <tencent_8136A297D436844B76745177E567363C7309@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006a8ebb061a93d549@google.com>
Subject: Re: [syzbot] [bluetooth?] general protection fault in l2cap_sock_recv_cb
From: syzbot <syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: refcount bug in l2cap_sock_recv_cb

------------[ cut here ]------------
refcount_t: addition on 0; use-after-free.
WARNING: CPU: 1 PID: 4478 at lib/refcount.c:25 refcount_warn_saturate+0x13a/0x1d0 lib/refcount.c:25
Modules linked in:
CPU: 1 PID: 4478 Comm: kworker/u9:1 Not tainted 6.10.0-rc1-syzkaller-00267-gcc8ed4d0a848-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Workqueue: hci0 hci_rx_work
RIP: 0010:refcount_warn_saturate+0x13a/0x1d0 lib/refcount.c:25
Code: c0 cb 1e 8c e8 c7 ae b1 fc 90 0f 0b 90 90 eb b9 e8 1b 80 ef fc c6 05 9a 04 f0 0a 01 90 48 c7 c7 20 cc 1e 8c e8 a7 ae b1 fc 90 <0f> 0b 90 90 eb 99 e8 fb 7f ef fc c6 05 7b 04 f0 0a 01 90 48 c7 c7
RSP: 0018:ffffc9000d40f440 EFLAGS: 00010246
RAX: 8178418b52383400 RBX: ffff88807498d080 RCX: ffff88802fa51e00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000002 R08: ffffffff815846c2 R09: 1ffff110172a519a
R10: dffffc0000000000 R11: ffffed10172a519b R12: ffff88807498e4a0
R13: ffff88807498e000 R14: dffffc0000000000 R15: 1ffff1100e931c94
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbe77aafffc CR3: 000000000e132000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __refcount_inc include/linux/refcount.h:241 [inline]
 refcount_inc include/linux/refcount.h:258 [inline]
 sock_hold include/net/sock.h:774 [inline]
 l2cap_sock_recv_cb+0x53d/0x600 net/bluetooth/l2cap_sock.c:1509
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


Tested on:

commit:         cc8ed4d0 Merge tag 'drm-fixes-2024-06-01' of https://g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=149a3bf6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=47d282ddffae809f
dashboard link: https://syzkaller.appspot.com/bug?extid=b7f6f8c9303466e16c8a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=106af454980000


