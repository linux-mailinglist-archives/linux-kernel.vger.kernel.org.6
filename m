Return-Path: <linux-kernel+bounces-310107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9019796750F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 06:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 157CC2829B5
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 04:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9C42B9BE;
	Sun,  1 Sep 2024 04:51:04 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC21EEC6
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 04:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725166264; cv=none; b=npsfb67p7MxnzxyXR952LFEzWxsJgTrwRjhOi6f4DRQBMuibp2gy54Etp3Ke/PvXI8UXWlOZYq03UjGHmQufzBR6LAhY8Olora0oY/zDQhPXo9yyELx1ailq/jKVnGdoA2DZh6v1wJLSnnuRNM+RmWwkkQbvPeOGLNeI/zMq3Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725166264; c=relaxed/simple;
	bh=G1MlGs8NKDksXc8Ux0PLoNE2g0uoEYKriCC4vwwRbRo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=d2/sZBOqOdmVR6VJIiwOv4W/53Zs0WPmI4vaZ7Ae+CwyY72l8D0K1IpsVoBsPlguI2lkRF4DipK5PyQMBqvxhh32EKCa1lMw75SU5nwjeRZSkJ+xtl3hYgAgay2WpjkZ6wTiC21eRlopMXt9fA+l/tXEQnVFQVlEzvRcdof6yU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82a29c9d39dso170700639f.2
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 21:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725166262; x=1725771062;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zpyyYCjxczzci6XrFq38qZb2ywe9h4m5lJK1rEkVpIY=;
        b=TW5dvMf8pV3ybo883Nk58MAgLO/1XdLTX/acLLqcx/IY0pR1PoDFSlUWFTHc6yxpVT
         DY/Jxl/TAlqc4yI7SajS7IlK2tfQYy5UaDJ/n46GdFsxO3NYXiu/eDtO9AHieHkRn5Vz
         HUMXJASJldrf2yl0YvBUUyq/n6qI7XaqOfn4riOAlPXfKHfrP2HOFEyW8GVkViqQUP8O
         sInbUpmNjk5jVRm/n0vo+/sHR2HF3lbV9goXyHh/R0qf+3b1SmPXxqtt0AXHlmPxYYd6
         SdB0Y0pXveY0NZ/Zku//fYeiLMMRuNylQKi26PCeIGl+4tBL2H3T+p4noEqH1P9EYuIo
         ttjA==
X-Forwarded-Encrypted: i=1; AJvYcCWEaLLTZP7QFgV5N6w5PWIb914hPwZXqBD8UjoqdvTNXTvv0fy8sVMYqLYlxXSRGIeOGVD9OLVHURXyAs8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd0FSnQOqvDuig5ml9U4qwm4YVkaASGywE4z1V87Gw55/laEut
	iR0sj6+0ci6B5JYkMelfgV0hr99lX816NxyKsNIiVOvA2NNTt4KPAYshP6JwpckGRY+gUUoboJ/
	WqiSiaRV9DFjdebsGkX1VQrhIoDP1f5LJRdSSz/Nc3ZEtcYwISe5cgG8=
X-Google-Smtp-Source: AGHT+IGPNMdEWMAaw2/iqqLHWEOUf0pht9vgX0xNlgSxPez9K649t9waLW/QGm32rq0tUSZ7lyrKGWihHW7KtFU9Rc4NIzuhVQm5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14c2:b0:81b:d4:3802 with SMTP id
 ca18e2360f4ac-82a2611839amr52288239f.0.1725166261740; Sat, 31 Aug 2024
 21:51:01 -0700 (PDT)
Date: Sat, 31 Aug 2024 21:51:01 -0700
In-Reply-To: <tencent_8764481771D77F06D7136EE36C496203AD05@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000035b63b06210792e1@google.com>
Subject: Re: [syzbot] [nfs?] INFO: task hung in nfsd_nl_listener_set_doit
From: syzbot <syzbot+d1e76d963f757db40f91@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in nfsd_create_serv

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6124 at fs/nfsd/nfssvc.c:656 nfsd_create_serv+0x631/0x760 fs/nfsd/nfssvc.c:656
Modules linked in:
CPU: 0 UID: 0 PID: 6124 Comm: syz.3.18 Not tainted 6.11.0-rc5-syzkaller-00151-gfe1910f9337b-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:nfsd_create_serv+0x631/0x760 fs/nfsd/nfssvc.c:656
Code: 43 0f b6 44 25 00 84 c0 0f 85 f5 00 00 00 48 8b 44 24 18 ff 00 48 8b 7c 24 30 e8 ba 60 15 09 e9 cd fa ff ff e8 c0 53 e5 fe 90 <0f> 0b 90 e9 91 fa ff ff 48 c7 c1 00 88 47 9a 80 e1 07 80 c1 03 38
RSP: 0018:ffffc90003aaf000 EFLAGS: 00010293
RAX: ffffffff82ae3870 RBX: ffff88801276bb80 RCX: ffff888055cf9e00
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff8ec0b5c0
RBP: ffffc90003aaf190 R08: ffffffff8ec0b5c7 R09: 1ffffffff1d816b8
R10: dffffc0000000000 R11: fffffbfff1d816b9 R12: dffffc0000000000
R13: dffffc0000000000 R14: ffff888032c74000 R15: 1ffff92000755e08
FS:  00007fb26fd8a6c0(0000) GS:ffff8880b8800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000100 CR3: 00000000318c8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 nfsd_nl_listener_set_doit+0x13f/0x19f0 fs/nfsd/nfsctl.c:1958
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1116 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1196 [inline]
 genl_rcv_msg+0xb4e/0xef0 net/netlink/genetlink.c:1211
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1220
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2597
 ___sys_sendmsg net/socket.c:2651 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2680
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb26ef79eb9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb26fd8a038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fb26f115f80 RCX: 00007fb26ef79eb9
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000003
RBP: 00007fb26efe793e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fb26f115f80 R15: 00007fffd4289438
 </TASK>


Tested on:

commit:         fe1910f9 tcp_bpf: fix return value of tcp_bpf_sendmsg()
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=1548dc67980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=996585887acdadb3
dashboard link: https://syzkaller.appspot.com/bug?extid=d1e76d963f757db40f91
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1517ab39980000


