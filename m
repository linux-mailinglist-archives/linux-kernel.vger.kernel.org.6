Return-Path: <linux-kernel+bounces-443241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 136739EE91C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14164168AD9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7641223324;
	Thu, 12 Dec 2024 14:38:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2928223339
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 14:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734014286; cv=none; b=HXoXqsOcmVV/SMVnYDh/dvGh+mHHniy7/7PMXnQ4AgVhSx8o6Thd0TCe/VBg27xJFhV1MEsQw4TddByky+c+QrD3vHRn2IU0H9rqtJzlRB+6SfvGX0H5WoOFpjAh9kFH5SH14C4JhUofC1WCa5C7JvGnrH7jPkQhH3RnVp4EHlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734014286; c=relaxed/simple;
	bh=wRPXTTcvzE1/hW5hRm+lkqIhyFeY0E6JzT6LLVTgbhg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=g/OE1wP/O0jfvg/PfveFYFs7hUKkDPmNtEAJ+9nNpkShyhiSeTIjg9VEp2RCLIujiR3q9+jNNGWvlxuBA6iSZVCeYsj7Xea5wZPbDqdiUOp8A9KYiWKVY4pPzLE0Gpd4LjtLczCO9hBKSF/qwPtxZJfkWFSdIxSsZLAgdi8BHME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a9cefa1969so6257335ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 06:38:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734014282; x=1734619082;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m0gvdui7FbksT7OTFX5a7TvcKbA/YbVlR11UKArxqOs=;
        b=TpxPteZCqUqa7EpKbfI/pSDAI+e74HK3xHn8mw4hImoZGlKrJZ7DZUUSTpo+ugFmy7
         /pX/pPDKfryHhGwsMpqdcUNjBSfHP5oxczPpkzcYVxoTPWb1AYkaEBwZUBxxgPh7lVzq
         PhIV4+bxCjy1iYcmNudg/JaDjiYdaFoXwB9gfSzGFMixAxxD8q0ucVYv2Q73YYIgoSiu
         1kLtRh419xAxDehGRh7i7teXrD7Cy8p8SI+uIBJZWEAA3yh2iShxEbWD84vsI7oZBhBv
         bo6aUW6Ug44ylVRnzkUydltAxYIfTDTzf8eKyAtLpa7hdVNAd3soz6olmM4cq8qU0vyP
         z6NQ==
X-Gm-Message-State: AOJu0YyqJMplpj6Tl/A8fswLh3tHnDcdZpPzdmVzzJ5ZYlvkvdFiqZJz
	4cqAsCcVQKVonoFFK3c+H/ZVj8F4bu0czItHlvYsd9V4HVwJrvsjmaD6nxtvMudtyau9TarCG9d
	61cZLT/5bqR15V/pPvPMp9zYYcE0XUFuLhCrbTW1oQj/UaKryw1z314o=
X-Google-Smtp-Source: AGHT+IGuLgry+67vnKLaPqpKFNqtaiYvjJSvbDCjv0mB6hLExwGGDdio61i9DkdbQ5mun7RxHl8FDVsJfz073JFwRq2YOuXknXAE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda4:0:b0:3a7:d672:652d with SMTP id
 e9e14a558f8ab-3ae589a78b3mr5245425ab.16.1734014282679; Thu, 12 Dec 2024
 06:38:02 -0800 (PST)
Date: Thu, 12 Dec 2024 06:38:02 -0800
In-Reply-To: <20241212142157.3707515-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675af54a.050a0220.1334be.003f.GAE@google.com>
Subject: Re: [syzbot] [net?] [afs?] WARNING in rxrpc_send_data
From: syzbot <syzbot+ff11be94dfcd7a5af8da@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in rxrpc_send_data

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6653 at net/rxrpc/sendmsg.c:296 rxrpc_alloc_txqueue net/rxrpc/sendmsg.c:296 [inline]
WARNING: CPU: 0 PID: 6653 at net/rxrpc/sendmsg.c:296 rxrpc_send_data+0x2969/0x2b30 net/rxrpc/sendmsg.c:390
Modules linked in:
CPU: 0 UID: 0 PID: 6653 Comm: syz.0.16 Not tainted 6.13.0-rc1-syzkaller-00417-gf3674384709b-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
RIP: 0010:rxrpc_alloc_txqueue net/rxrpc/sendmsg.c:296 [inline]
RIP: 0010:rxrpc_send_data+0x2969/0x2b30 net/rxrpc/sendmsg.c:390
Code: 24 48 48 89 de e8 97 35 ab f6 4c 39 f3 b8 00 fe ff ff 41 bf fc ff ff ff 44 0f 44 f8 45 31 f6 e9 71 fd ff ff e8 98 30 ab f6 90 <0f> 0b 90 48 8b 7c 24 28 e8 aa d0 09 f7 e9 46 fd ff ff 89 d9 80 e1
RSP: 0018:ffffc90003d4f3a0 EFLAGS: 00010293
RAX: ffffffff8af44188 RBX: ffff88805a8bce80 RCX: ffff8880263e8000
RDX: 0000000000000000 RSI: 00000000000000ff RDI: ffff888034486440
RBP: ffffc90003d4f650 R08: ffff88803448643f R09: 0000000000000000
R10: ffff888034486340 R11: ffffed1006890c88 R12: ffff88805a8bce48
R13: 1ffff1100b5179cf R14: ffff888034486000 R15: 0000000000000000
FS:  00007fc905bbc6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000559e43303950 CR3: 0000000025e2a000 CR4: 00000000003526f0
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
RIP: 0033:0x7fc904d7ff19
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc905bbc058 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007fc904f45fa0 RCX: 00007fc904d7ff19
RDX: 0000000000000001 RSI: 0000000020005c00 RDI: 0000000000000003
RBP: 00007fc904df3cc8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fc904f45fa0 R15: 00007ffcacaf6308
 </TASK>


Tested on:

commit:         f3674384 Merge branch 'net-smc-two-features-for-smc-r'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17821be8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1362a5aee630ff34
dashboard link: https://syzkaller.appspot.com/bug?extid=ff11be94dfcd7a5af8da
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17ec1be8580000


