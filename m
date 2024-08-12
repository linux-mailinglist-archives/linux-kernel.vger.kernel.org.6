Return-Path: <linux-kernel+bounces-282474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2EC94E47E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 03:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 249791F214DA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 01:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610FA4D8CB;
	Mon, 12 Aug 2024 01:37:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B0B136A
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 01:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723426626; cv=none; b=ItcnE7ziIijXQY+5avdTpNX1BH3pWh1IqtbFpS0TRlpk15VhEJMACriXPKQn4FSbwlTEHHM/1bZzX/QjE5ndVSwWK4GSM4n7wtk2jsiyMuxm5TOb67D2Cd8yp12h0n2g1DYJTS1LqlodC1EvgIbFygrO9eqWQyX1dDVY1kwDR40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723426626; c=relaxed/simple;
	bh=e4F6cEwTvBdZhuKLq+m8iIOwwpo9fbmBReylRK63nvo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ikD8PGC8L8iPQdsLsYlYUoGq6j2ekX18AISdzjgczrLYPV2Q/G6XqA80O4q84ju32bX0qzJ25GW9+pVMtz+8LbhhKGX7r4/hg0602xMf6RmTMYK/o8HsO0iLkZkVrGdKyk64LofWb9TeaaMWUn6jpIM5FDJOx/FkVkFXia5+Glc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81faf98703eso527261239f.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 18:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723426623; x=1724031423;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DaptOmFV5G2FRU8U/MI3TWc2DFE7uMQTAISbawqmhHA=;
        b=lZEVqGEW7sjpRZmLnsQ9zIuxBtGzxifWP614+KSEGHd4Ic22WSxO6aUJN0qN5ZH+DB
         50OAlK3hyn+OdzqcITTXVUUMazIO2LGZioC2fGQ+J6CF0c4cB1iVGXG8iWDIQ5GKS8pz
         4ve5N/VGSmcSog+hd0QXirCgY9yr6MxTm9+5bKMTD8CaTeSyggkOxzUP8v/4NMc7Efoa
         WtN4vjZErZZE/CUiZjpQ2/ZAxKhcj/Pdw7FmFWQ2E7Y/L/y8/9rNxJZBcQ8emmRhrgNX
         TZNfOBawJ08yLKQ3b0ivOvj5FISDX3vD/DeYhsN+cVhDe2BtDc4C+W/o1CkogzS0q+T6
         r5qQ==
X-Gm-Message-State: AOJu0Yx8Yz72CDKyQ3CAc8glw8YF0evj12N6GXXoZWGXUM0BnrY9TZcR
	K5GwsBp9MaUT2XCoTweFLz5/EPlUVt4eXGmajZGO8lngYlnbCcyO0BKKXx4nZbPP/plPNJdU+Fk
	7wwB1xzHjw36ExmWgeiXYEY1yjTLs3KuD4JWQz2swR2ocAFNaxFFK3ew=
X-Google-Smtp-Source: AGHT+IEH7uYapg5bC6jsQ4822KVBZ9Pg8YOgbQYBE27bJqRI/al7hqXFOTuEPNznVj7/M0BMG+8MW4OH1JqZlU3mZ+yi7VKq0PdU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:6bc2:b0:4b9:b122:d07d with SMTP id
 8926c6da1cb9f-4ca6edcb974mr233711173.4.1723426623453; Sun, 11 Aug 2024
 18:37:03 -0700 (PDT)
Date: Sun, 11 Aug 2024 18:37:03 -0700
In-Reply-To: <CAM_iQpV6aNoiXkYejbgfeQQpwL5LsE9rtJdOdjeRrnQyRuR19Q@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b008ae061f7287db@google.com>
Subject: Re: [syzbot] [net?] [virt?] BUG: stack guard page was hit in vsock_bpf_recvmsg
From: syzbot <syzbot+bdb4bd87b5e22058e2a4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in release_sock

------------[ cut here ]------------
WARNING: CPU: 1 PID: 6092 at include/net/sock.h:1718 sock_release_ownership include/net/sock.h:1718 [inline]
WARNING: CPU: 1 PID: 6092 at include/net/sock.h:1718 release_sock+0x194/0x1f0 net/core/sock.c:3564
Modules linked in:
CPU: 1 UID: 0 PID: 6092 Comm: syz.0.15 Not tainted 6.11.0-rc2-syzkaller-00325-gc4e82c025b3f-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:sock_release_ownership include/net/sock.h:1718 [inline]
RIP: 0010:release_sock+0x194/0x1f0 net/core/sock.c:3564
Code: 01 00 00 00 31 c9 e8 7b 73 f2 f7 eb 05 e8 04 0a 19 f8 4c 89 f7 5b 41 5c 41 5d 41 5e 41 5f 5d e9 32 b9 45 02 e8 ed 09 19 f8 90 <0f> 0b 90 e9 67 ff ff ff e8 df 09 19 f8 4c 89 e7 49 89 db 41 ff d3
RSP: 0018:ffffc9000366fa80 EFLAGS: 00010293
RAX: ffffffff897a6d93 RBX: 0000000000000000 RCX: ffff88801cb81e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 1ffff11005538250 R08: ffffffff897a6cf6 R09: fffff520006cdf40
R10: dffffc0000000000 R11: fffff520006cdf40 R12: ffff88802a9c1080
R13: dffffc0000000000 R14: ffff88802a9c1240 R15: ffff88802a9c1280
FS:  00007f2597b966c0(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000040 CR3: 00000000229fe000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 vsock_connectible_recvmsg+0x7f/0xf0 net/vmw_vsock/af_vsock.c:2308
 sock_recvmsg_nosec net/socket.c:1046 [inline]
 sock_recvmsg+0x22f/0x280 net/socket.c:1068
 ____sys_recvmsg+0x1db/0x470 net/socket.c:2816
 ___sys_recvmsg net/socket.c:2858 [inline]
 __sys_recvmsg+0x2f0/0x3e0 net/socket.c:2888
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2596d779f9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2597b96038 EFLAGS: 00000246 ORIG_RAX: 000000000000002f
RAX: ffffffffffffffda RBX: 00007f2596f05f80 RCX: 00007f2596d779f9
RDX: 0000000000010042 RSI: 00000000200003c0 RDI: 0000000000000005
RBP: 00007f2596de58ee R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f2596f05f80 R15: 00007fff84f29b48
 </TASK>


Tested on:

commit:         c4e82c02 net: dsa: microchip: ksz9477: split half-dupl..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=166ef55d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e8a2eef9745ade09
dashboard link: https://syzkaller.appspot.com/bug?extid=bdb4bd87b5e22058e2a4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=131902ed980000


