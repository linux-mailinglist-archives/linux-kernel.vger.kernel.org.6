Return-Path: <linux-kernel+bounces-442958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7524E9EE496
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAE78281CCC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8052116EC;
	Thu, 12 Dec 2024 10:58:10 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B120B211487
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734001089; cv=none; b=VNBUJpjSqogjPZGKr6CrUI3ur0fYlqmLTP5kGEK1zh4iPOvJ3hAdhQX1OgEM8Qw5kKmU3VrfxpU7wcEMPp+bvxLYFiDsKwb44FsmBPVAsJtWXbE6Sn46xln6yV/6EJaHujBi2urYOJmWQoYFIgKF3b6MKmM0+1LVfbkszbgjGbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734001089; c=relaxed/simple;
	bh=AXQLLufskhu+HDRL7gqBvgUREvnpB/1eYyUsoXSPioE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CifA0CE1czkVFCygCW2kitKOvmXO6CVYbHVKoIdOHQS+xPgCXp064KNrgDemVCiOEhGg8z9m9NAA0/XYlYe94gEoPCta/fYz7GpZOfjQXEthOlgHJG2VYA7UXBh6ZJI1va2EdQFSCUpCvTY5QYduoLILQdhDOkssQxSOvtP5CHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-844d38b44ebso34014539f.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 02:58:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734001087; x=1734605887;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7Q/hVYcpPPlLILUALKjLfxj7ylNWD4n4P2Wq+ruhf0=;
        b=DctYb1ymPwi3s8+9f+T988r3o6WwXqH46PzNfzPJAVkFHAcJ/p/FAYQU1p53jThQn3
         EIPxqvEePzQMro8L8TxVTHuJk3vEvKR2ROW4wx8S6adHIGBLs4zVDGkTtRZpLw7LmcMt
         yR6b/MP/5wvaJfcZ76U75a1Y8enarUPlkTedkVylus4BGYaeQ25hBc8Ds7eZJMqpP4nI
         hftKhbdaayXuiCFAnfl4pL94PvDnUnBRCj5t9KCAIJhmVhmrVqyDOvleiPN+LE2pEjOV
         ynQCEtLJa2L5+DJdhKpfP7LHOwqKI3hIJFBItRITIGSa5fiPCYgIsuca6CogCPHZkjmR
         kENg==
X-Gm-Message-State: AOJu0YwU3YkxGy6MFsoCWKneTiidOe2Di67GG6QTD9HeCrTO6VY3/B/B
	tBQmUJIFYcYytdPdjkUe2+g+aP75+p+OtvK4qZn/SjEqsVqfQon+S+YuJXd28DnrkFgfrBaBNrB
	/s3/Btta6z/0Wmak0I+eDEXInKKzyV6o6k2G5gWXbBxRNPDKlJZLYxr0=
X-Google-Smtp-Source: AGHT+IEXTuhrz8d1tfwfxwpy0n6r//oMdcb7C63p6VPn7opp4Y7+eRCN+mgwdGL6iob4W0Ix78d3LgcrLvDTsFcWrESyb2oUcb/Y
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d0f:b0:841:950b:3871 with SMTP id
 ca18e2360f4ac-844d7447b2fmr380914839f.4.1734001086856; Thu, 12 Dec 2024
 02:58:06 -0800 (PST)
Date: Thu, 12 Dec 2024 02:58:06 -0800
In-Reply-To: <20241212033040.3361429-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675ac1be.050a0220.20c8bc.0001.GAE@google.com>
Subject: Re: [syzbot] [net?] [afs?] WARNING in rxrpc_send_data
From: syzbot <syzbot+ff11be94dfcd7a5af8da@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in rxrpc_send_data

------------[ cut here ]------------
WARNING: CPU: 1 PID: 6894 at net/rxrpc/sendmsg.c:296 rxrpc_alloc_txqueue net/rxrpc/sendmsg.c:296 [inline]
WARNING: CPU: 1 PID: 6894 at net/rxrpc/sendmsg.c:296 rxrpc_send_data+0x2969/0x2b30 net/rxrpc/sendmsg.c:390
Modules linked in:
CPU: 1 UID: 0 PID: 6894 Comm: syz.0.74 Not tainted 6.13.0-rc1-syzkaller-00407-g96b6fcc0ee41-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
RIP: 0010:rxrpc_alloc_txqueue net/rxrpc/sendmsg.c:296 [inline]
RIP: 0010:rxrpc_send_data+0x2969/0x2b30 net/rxrpc/sendmsg.c:390
Code: 24 48 48 89 de e8 37 35 ab f6 4c 39 f3 b8 00 fe ff ff 41 bf fc ff ff ff 44 0f 44 f8 45 31 f6 e9 71 fd ff ff e8 38 30 ab f6 90 <0f> 0b 90 48 8b 7c 24 28 e8 4a d0 09 f7 e9 46 fd ff ff 89 d9 80 e1
RSP: 0018:ffffc9000217f3a0 EFLAGS: 00010293
RAX: ffffffff8af441e8 RBX: ffff888064916500 RCX: ffff888030ef5a00
RDX: 0000000000000000 RSI: 00000000000000ff RDI: ffff8880792ee440
RBP: ffffc9000217f650 R08: ffff8880792ee43f R09: 0000000000000000
R10: ffff8880792ee340 R11: ffffed100f25dc88 R12: ffff8880649164c8
R13: 1ffff1100c922c9f R14: ffff8880792ee000 R15: 0000000000000000
FS:  00007fc5a3d7d6c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020005c00 CR3: 000000003143c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 rxrpc_do_sendmsg+0x1569/0x1910 net/rxrpc/sendmsg.c:763
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:726
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2583
 ___sys_sendmsg net/socket.c:2637 [inline]
 __sys_sendmmsg+0x36a/0x720 net/socket.c:2726
 __do_sys_sendmmsg net/socket.c:2753 [inline]
 __se_sys_sendmmsg net/socket.c:2750 [inline]
 __x64_sys_sendmmsg+0xa0/0xb0 net/socket.c:2750
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc5a2f7ff19
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc5a3d7d058 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007fc5a3145fa0 RCX: 00007fc5a2f7ff19
RDX: 0000000000000001 RSI: 0000000020005c00 RDI: 0000000000000003
RBP: 00007fc5a2ff3cc8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fc5a3145fa0 R15: 00007ffd4836f878
 </TASK>


Tested on:

commit:         96b6fcc0 Merge branch 'net-dsa-cleanup-eee-part-1'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12b084f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1362a5aee630ff34
dashboard link: https://syzkaller.appspot.com/bug?extid=ff11be94dfcd7a5af8da
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11c2acdf980000


