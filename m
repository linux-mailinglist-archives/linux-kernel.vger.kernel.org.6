Return-Path: <linux-kernel+bounces-300247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0555A95E0FE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 06:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DF3AB214F9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 04:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16E01426C;
	Sun, 25 Aug 2024 04:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="IEq8Sip3";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="HAqP/ja3"
Received: from mx5.ucr.edu (mx.ucr.edu [138.23.62.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F468C06
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 04:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724558607; cv=none; b=WWBYTDY6mfBgg/Q0p1LjZrR9muxuwIsdzW9qE18i6VszVBnpMdnWLjKGX/plXCDYkdGp3ewXdJVoYifbsmbZtUzGc//2TIBuQMb28YyoN2dKj/WcEIEcDmWsn6cT5SHHV6XAF97wuzpVJ3p+tRU+Z9PdmR+tfGXrgmm7avi6h4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724558607; c=relaxed/simple;
	bh=F9M4bjI6l4B0/qhQUE4eI09QP/1V/wJ7xmc8QGt5/0k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=kbfe54S1WiN/SsRndJWyIdgOeBlf3vcKmosrhmmjYEnfxfO77M5dwVRC6zdWdpzqNIdB/YjwKqLFgM/b4typfdcUnWg6caXDNOz5hTuR0x3XywxbazZsjihQBVlnYR/OAXYdXBoRYLxiRQQmjp9ElsK/fgI1FNz1cc7Ni7j0wVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=IEq8Sip3; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=HAqP/ja3; arc=none smtp.client-ip=138.23.62.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724558604; x=1756094604;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=F9M4bjI6l4B0/qhQUE4eI09QP/1V/wJ7xmc8QGt5/0k=;
  b=IEq8Sip3hucuyjoBljLoFhgPu9eBGpZobeeqhy3IvOthTLOMobqv4Efs
   aDjNqEtAsoQuHnBL+mtZDvSffRZMPhJAAotzv1Pkm9MwcSaZU+cYAkPC+
   +KbzIbrpU0pGs7jCp887vrYq2Ne1WKt9RQ6N7xli6QxOY54MI6kybZdEk
   VFjx7qsdT1/rTpSeIgdWQxBCWhCkxWwqjlG1WRsvnHppCiRwkcyzUWpBb
   jAGRyFskYgQbuBEoZCMq9IPpgdDu465SPzB6eIHqnV/aiS04uLJKH3gU4
   kHHjH3vinuvChKSauaR557T/iPYxfqA0JQzvJAzmdpN/tZ7SHQ162ovEz
   w==;
X-CSE-ConnectionGUID: I8iM8eN7T6WtFEONH13oMg==
X-CSE-MsgGUID: CmreDt5mRb6e/4576F207A==
Received: from mail-pf1-f200.google.com ([209.85.210.200])
  by smtpmx5.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 24 Aug 2024 21:03:22 -0700
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-71420354182so3790817b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 21:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724558603; x=1725163403; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UT84F2+F2rCr2tFK0YNt3h5wYkfLyRZ0ZcFlrmDzsKY=;
        b=HAqP/ja3ahwRxhgyHnamy3u2Ji1AqL/zmBnREU53gRBJtgc7CxP/gZIn69Xsip+sVM
         oc0wKX//Dd3h7CI1CbDSLI7hFC8Zg/1aEXYoDU056JTuNeq8Y5qXeF72u4V9OYd+OM4x
         Zh0yBYLOFDXTQzlq1XfH9DveorX0Go0LFzkk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724558603; x=1725163403;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UT84F2+F2rCr2tFK0YNt3h5wYkfLyRZ0ZcFlrmDzsKY=;
        b=Hqwup/2mykid4Xs5OP74IdZO8ivl7y2/WyJYQQbVDadVR3DtGtsqV9d981yXZ8dCEe
         ojKoAF3WwTodMyBLYOV3wt3s3Kk4L77FXY8Cmc2Zdj9xus7Z1iHeLqdoGOukiohHpwT4
         Nkf8PORB1XpMGm5XcqKs9eZHAXs0C2g+GRhMSMUts5lShq2+5pyPPOdStxGX3NCJD6hY
         +pOkHLzoED6U5eSgMBmmK1wIsErrSVJsjzsliqdzeYyqOau7UJdQR5oHPYiKZiIhwiru
         sFKxmmQZH3SvCFP+mTATTcZeaYVB0wxNUSZcTmebADkcMcFXEN2Rwkycrkeb73hhtnXZ
         gccA==
X-Forwarded-Encrypted: i=1; AJvYcCWuVCTW8XqyKC4AIx7E+QUyY3mZT8Df3aGBVZvYHfBaSlktpFej/y9NOqwaxf3TK7QfgciFJH9TnMRLl2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAK14tMlqFCesJ3HHMXTlG4W+EclkBd/ef+rDGpLrt0bFY1pyh
	lNCsIQ7f3U6OR5mtYkfQuA8Z3MO2YxlIohfHzSM2wKmY6WfJ9T9ij6Xe9tkeUdhwk3kRhgonUuE
	hsDRAK34FjVZP9QqLujuQTf1eP6WqB1JllWccK0zG09EMY3TJF9i6UAMi1OaPKhIjOi0J9igdKQ
	wVgQQtu1rYjx1KXeMyEkA3eCMAZrSGjdj5DflcoZXgYYFjALWv
X-Received: by 2002:a05:6a21:9206:b0:1ca:da64:4f4b with SMTP id adf61e73a8af0-1cc89d29cfemr9019251637.2.1724558602595;
        Sat, 24 Aug 2024 21:03:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVpxElNfvpBOgSsL9YoSzLe3QLwsG+2EKtpTX/bsVIopG+GOKskP09098BeFOu+tZ2+yIcYtfpdmZatXt4+sg=
X-Received: by 2002:a05:6a21:9206:b0:1ca:da64:4f4b with SMTP id
 adf61e73a8af0-1cc89d29cfemr9019241637.2.1724558602208; Sat, 24 Aug 2024
 21:03:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Sat, 24 Aug 2024 21:03:11 -0700
Message-ID: <CALAgD-6Pk4D9J3KHRts-g_6Zj1iphuWXfBhYzOn+wF7BrcbyAg@mail.gmail.com>
Subject: general protection fault in __kernfs_remove
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

We found a bug in Linux 6.10 using syzkaller. It is a null pointer
dereference bug.
We show the bug report  as below. Unfortunately, there is no syzkaller
reproducer for it.

bug report:
veth0_vlan: left promiscuous mode
team0 (unregistering): Port device team_slave_1 removed
team0 (unregistering): Port device team_slave_0 removed
Oops: general protection fault, probably for non-canonical address
0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 923 Comm: kworker/u4:5 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:____rb_erase_color lib/rbtree.c:354 [inline]
RIP: 0010:rb_erase+0x5c8/0xe80 lib/rbtree.c:445
Code: 00 49 8d 5f 10 48 89 d8 48 c1 e8 03 48 89 44 24 10 42 80 3c 28
00 74 08 48 89 df e8 02 56 03 f7 4c 8b 23 4d 89 e6 49 c1 ee 03 <43> 80
3c 2e 00 74 08 4c 89 e7 e8 e9 55 03 f7 41 f6 04 24 01 48 89
RSP: 0018:ffffc90002f774d8 EFLAGS: 00010246
RAX: 1ffff11008ae8954 RBX: ffff888045744aa0 RCX: dffffc0000000000
RDX: 0000000000000001 RSI: ffff8880456beca0 RDI: ffff888045744138
RBP: ffff888045744a98 R08: ffff8880142d3177 R09: 1ffff1100285a62e
R10: dffffc0000000000 R11: ffffed100285a62f R12: 0000000000000000
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff888045744a90
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffcb35aed90 CR3: 00000000417fa000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kernfs_unlink_sibling fs/kernfs/dir.c:419 [inline]
 __kernfs_remove+0x5eb/0x830 fs/kernfs/dir.c:1492
 kernfs_remove_by_name_ns+0xd3/0x150 fs/kernfs/dir.c:1694
 kernfs_remove_by_name include/linux/kernfs.h:625 [inline]
 remove_files fs/sysfs/group.c:28 [inline]
 sysfs_remove_group+0xfa/0x2c0 fs/sysfs/group.c:319
 sysfs_remove_groups+0x50/0xa0 fs/sysfs/group.c:343
 device_remove_groups drivers/base/core.c:2833 [inline]
 device_remove_attrs+0x236/0x290 drivers/base/core.c:2969
 device_del+0x512/0x940 drivers/base/core.c:3867
 unregister_netdevice_many_notify+0x11a3/0x16d0 net/core/dev.c:11249
 unregister_netdevice_many net/core/dev.c:11277 [inline]
 default_device_exit_batch+0xa79/0xaf0 net/core/dev.c:11760
 ops_exit_list net/core/net_namespace.c:178 [inline]
 cleanup_net+0x8ae/0xcd0 net/core/net_namespace.c:640
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0x977/0x1410 kernel/workqueue.c:3329
 worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
 kthread+0x2eb/0x380 kernel/kthread.c:389
 ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:____rb_erase_color lib/rbtree.c:354 [inline]
RIP: 0010:rb_erase+0x5c8/0xe80 lib/rbtree.c:445
Code: 00 49 8d 5f 10 48 89 d8 48 c1 e8 03 48 89 44 24 10 42 80 3c 28
00 74 08 48 89 df e8 02 56 03 f7 4c 8b 23 4d 89 e6 49 c1 ee 03 <43> 80
3c 2e 00 74 08 4c 89 e7 e8 e9 55 03 f7 41 f6 04 24 01 48 89
RSP: 0018:ffffc90002f774d8 EFLAGS: 00010246
RAX: 1ffff11008ae8954 RBX: ffff888045744aa0 RCX: dffffc0000000000
RDX: 0000000000000001 RSI: ffff8880456beca0 RDI: ffff888045744138
RBP: ffff888045744a98 R08: ffff8880142d3177 R09: 1ffff1100285a62e
R10: dffffc0000000000 R11: ffffed100285a62f R12: 0000000000000000
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff888045744a90
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6f4aa4f048 CR3: 00000000197b6000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0: 00 49 8d             add    %cl,-0x73(%rcx)
   3: 5f                   pop    %rdi
   4: 10 48 89             adc    %cl,-0x77(%rax)
   7: d8 48 c1             fmuls  -0x3f(%rax)
   a: e8 03 48 89 44       call   0x44894812
   f: 24 10                 and    $0x10,%al
  11: 42 80 3c 28 00       cmpb   $0x0,(%rax,%r13,1)
  16: 74 08                 je     0x20
  18: 48 89 df             mov    %rbx,%rdi
  1b: e8 02 56 03 f7       call   0xf7035622
  20: 4c 8b 23             mov    (%rbx),%r12
  23: 4d 89 e6             mov    %r12,%r14
  26: 49 c1 ee 03           shr    $0x3,%r14
* 2a: 43 80 3c 2e 00       cmpb   $0x0,(%r14,%r13,1) <-- trapping instruction
  2f: 74 08                 je     0x39
  31: 4c 89 e7             mov    %r12,%rdi
  34: e8 e9 55 03 f7       call   0xf7035622
  39: 41 f6 04 24 01       testb  $0x1,(%r12)
  3e: 48                   rex.W
  3f: 89                   .byte 0x89


-- 
Yours sincerely,
Xingyu

