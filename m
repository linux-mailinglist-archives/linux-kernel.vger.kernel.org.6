Return-Path: <linux-kernel+bounces-423410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 804929DA705
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C62D1660ED
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1871F9ABE;
	Wed, 27 Nov 2024 11:44:35 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ABC1F9AB2
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 11:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732707874; cv=none; b=VGgxp45aCqBSHCQYuHczvxADfOFcDkWXveCsLLgSmAeSWPnxxBYlcl89irqR/8+4cKaOATYlKON0jA52XzC8759MEz9jQsZUvwnTKKcJVHPC7ERlbRzT6BhPITNNxOKfP2zCB2SBbcLrnw5No54qB1RxrYpiO5r9e3AWxYADvMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732707874; c=relaxed/simple;
	bh=ulqdfgcCw29+g175idsSF+YnNzDN3cWZhh20xhNDUcQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=T9gnyzkMUXcuiqaY4AVunKo40pmIpHM/pGzxaMMy+/b+8abOwP02wR+8kbpqjvFsS2BNYY7OGD5LNo3jBISYCfc1RsX8rTvSW5msKnsrd+Xw1/cm0c1yAUmbSH5VEEO/Q4ExTLaxBap/1iX9MapM46Vxe04yQ5/jxicmyTAzgxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a77a808c27so70301395ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 03:44:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732707872; x=1733312672;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H/Rvhs1+z8ZgEroaVZkWY66OMoCy8nJH+e2hZLcItBY=;
        b=jnLZ6meHak5aiRiZkbwyCPYD0TlA4S+iye65T7tF2SaVXfIvZqXg/bwUwgaAGV9ywM
         7T7SJctYBDkITbg0ZHmGae3tWJ+N+27zNhDU8xt8pKBpqXiJR49BEgK0OYDIM6xXCTLA
         9x+/iwqTzT9OWV4cIt6htkxZd62XR8V9ztsBNLmA1qgtlijEU0AxHPCmsPyqtqsl5FFm
         a8v/s+tAxa+h1PshcYhhTja8z/z0sGX70nG8+GjA/eqeyChwQB12tiX+GsdsuwhstbEa
         WQIsKhV1pjh2pQBncwKrLc9F3Arc/jUfq/4zlQoVHt32xD3R6A42yqTxKTyDsmFPdnrT
         M22g==
X-Forwarded-Encrypted: i=1; AJvYcCX6gcq6Ir6cCTZ4tJRVqnEtOdksIuC8vo6xefxL6DMLsFnimyi6Yd9h0Dzo+me2TWNGWr6dSJ5p85yxkJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxApxD7R/zDh8aTcjGjarQZu7Wx+Or0pMf2dyuOykHj9ACmlFto
	0MFL6ONjhnh52Dk5RSP4hyw7Bm0krGx8KocJhuYR1lJTO1AdV7KO1axhwkASjvBNI0+E032o4+0
	9HJIZA9FNHElPa09z/GqlEGgfD74HeUDo+LyjlQjT17WW7VHCUo0RliI=
X-Google-Smtp-Source: AGHT+IEsh0dw5SZs7xB4Cdg9u4jaHIyUVIpKu7zbkYEA3s5fo5l5AVYPW45H0amax6zw7/yGJSMZBx7KAuVi4EQrt/qSk5o7K8Qj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160a:b0:3a7:86ab:be6c with SMTP id
 e9e14a558f8ab-3a7c55d4165mr23496335ab.15.1732707872328; Wed, 27 Nov 2024
 03:44:32 -0800 (PST)
Date: Wed, 27 Nov 2024 03:44:32 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67470620.050a0220.1286eb.0030.GAE@google.com>
Subject: [syzbot] [kernel?] WARNING: refcount bug in bnep_session
From: syzbot <syzbot+8b3024ae934a6e1911d9@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fcc79e1714e8 Merge tag 'net-next-6.13' of git://git.kernel..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=1216fec0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=275de99a754927af
dashboard link: https://syzkaller.appspot.com/bug?extid=8b3024ae934a6e1911d9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1539da626e54/disk-fcc79e17.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d44dbcc68df2/vmlinux-fcc79e17.xz
kernel image: https://storage.googleapis.com/syzbot-assets/76fdad1309ae/bzImage-fcc79e17.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8b3024ae934a6e1911d9@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 1 PID: 11424 at lib/refcount.c:28 refcount_warn_saturate+0x15a/0x1d0 lib/refcount.c:28
Modules linked in:
CPU: 1 UID: 0 PID: 11424 Comm: kbnepd bnep0 Not tainted 6.12.0-syzkaller-05480-gfcc79e1714e8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
RIP: 0010:refcount_warn_saturate+0x15a/0x1d0 lib/refcount.c:28
Code: e0 ec 60 8c e8 47 47 96 fc 90 0f 0b 90 90 eb 99 e8 6b 4e d5 fc c6 05 85 55 48 0b 01 90 48 c7 c7 40 ed 60 8c e8 27 47 96 fc 90 <0f> 0b 90 90 e9 76 ff ff ff e8 48 4e d5 fc c6 05 5f 55 48 0b 01 90
RSP: 0018:ffffc900031877c0 EFLAGS: 00010246
RAX: f478ba731e83d900 RBX: ffff8880351dd078 RCX: ffff888069bb9e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000003 R08: ffffffff8155fe42 R09: fffffbfff1cfa898
R10: dffffc0000000000 R11: fffffbfff1cfa898 R12: ffff8880351dd060
R13: 1ffff11006a3ba0c R14: ffff8880351dd060 R15: ffffffff85fe66a0
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc7c6bcb18 CR3: 000000000e738000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __refcount_sub_and_test include/linux/refcount.h:275 [inline]
 __refcount_dec_and_test include/linux/refcount.h:307 [inline]
 refcount_dec_and_test include/linux/refcount.h:325 [inline]
 kref_put include/linux/kref.h:64 [inline]
 klist_dec_and_del+0x3ec/0x3f0 lib/klist.c:206
 klist_put lib/klist.c:217 [inline]
 klist_del+0xa7/0x110 lib/klist.c:230
 device_del+0x2c9/0x9b0 drivers/base/core.c:3838
 unregister_netdevice_many_notify+0x1859/0x1da0 net/core/dev.c:11556
 unregister_netdevice_many net/core/dev.c:11584 [inline]
 unregister_netdevice_queue+0x303/0x370 net/core/dev.c:11456
 unregister_netdevice include/linux/netdevice.h:3192 [inline]
 unregister_netdev+0x1c/0x30 net/core/dev.c:11602
 bnep_session+0x2e3c/0x3030 net/bluetooth/bnep/core.c:525
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

