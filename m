Return-Path: <linux-kernel+bounces-290905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8895955B08
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 07:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FBE628202E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 05:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE828BA49;
	Sun, 18 Aug 2024 05:29:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E644C83
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 05:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723958945; cv=none; b=uNNRKVyWzKecEixxBXIkt9HMIder/T0KGPj3P5kM45yBckM+/417YHSjkfsUKP8W9lI8nbsaVCDp8VTv3QZV5Ip6aLapsuPvQas9ppS3dWihyJmREND1hk2XH4Cmr2ECJ6IHMHl7A2zA79gfnJz4vsGkyeaM5191us5dGeoR+jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723958945; c=relaxed/simple;
	bh=Xn+QCP6GRJB0uA+FhsYK+xp0OsbY9qgQje+eaGmWKCI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AS91mDNBoVJHjR4ZdpnRnXtj5uVrIZQFQ+QQIktKoaWZmuNmEg40f2eKKSk+ewW9MvIguokXOwqz5ai9RvA5NkBnjiiGhnESHruVbLO1QHRoGtLbDED6oMyWHLrCIO2eC7ayjPKUR6g8F+FjaangB2iBu5BlRgP6azmlaQWO+v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d293e492aso21901295ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 22:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723958943; x=1724563743;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HPmmVhOflEafKaoaafEaXM8mX95uI2BsS6TfveoW3rk=;
        b=N5kqyRqXVDdXoDR+IBxGUxcg8o3Yf8+fGtpkJyiFrWBRrZfzwZwPs4K0xIj2jl7uhl
         saOJEwOkYOqgzRC1CPfHeLxTqA/jS+7tUgiIhONURzlA3kps09sO3ZPXrTiZDXvzAkRT
         seUTXWaIzl8ybL+EPb+ukgG32VcSfJB9w+75NLwBjamA3QRMgjWb6aiB0uvxWH7FGzSj
         tSTV/PyoLYMCblkNXon3uWBvPXJ28TwA87FRu8flbff9ejv1LaXew5gbEqXp0FIV8b20
         ZbJjggdGjWd5rwgMQtbqOq8x0gq9M9YZCd31e5cCH90d+r79ViSuFu6DkDLoo5wyCKGn
         kDTw==
X-Forwarded-Encrypted: i=1; AJvYcCWdJ4X+7GDcgIYUd7tMe8nVblXBXvev1XR7Nl1VrSWU4wIpfV1eR9FIpkD1RagEx3T1JuRvt4rMlNgRCmsHchOdaEe6mbX9j69rZPB3
X-Gm-Message-State: AOJu0YwNPOZKORfs54lkaSdaOa6OO4aOS1wTDrqCzOq5AiI5l4T2i9n+
	NQn+A3CA46PMuoR7BvMhbOleoi42U1CcF1oP8CoPUWAvkE9ZNWF7VlMUiL7TcQ6AwjvIVk5tRCp
	oXMihrEVCx8PJZhQgK0y/acnLei4CeulslQtbIDowWub6kwi2GTrKiXU=
X-Google-Smtp-Source: AGHT+IGKIuerhN3QU/BsfOmnHaUCQWYUCCPIqTjv2eDYNntQVwUq44SLBvUMT1uMndh+D2ULyT6lVJDuXLjA54frOJBltjts09X5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6e:b0:380:f12f:30de with SMTP id
 e9e14a558f8ab-39d26ce5d57mr6189185ab.2.1723958942936; Sat, 17 Aug 2024
 22:29:02 -0700 (PDT)
Date: Sat, 17 Aug 2024 22:29:02 -0700
In-Reply-To: <tencent_B1542E456CC49638E98AEF12CDEC79866F0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000066c8f8061fee7814@google.com>
Subject: Re: [syzbot] [net?] kernel BUG in __sock_sendmsg
From: syzbot <syzbot+58c03971700330ce14d8@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in __sock_sendmsg

------------[ cut here ]------------
kernel BUG at net/socket.c:733!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 UID: 0 PID: 3938 Comm: syz.0.15 Not tainted 6.11.0-rc3-syzkaller-gc3f2d783a459 #0
Hardware name: linux,dummy-virt (DT)
pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : sock_sendmsg_nosec net/socket.c:733 [inline]
pc : sock_sendmsg_nosec net/socket.c:728 [inline]
pc : __sock_sendmsg+0x5c/0x60 net/socket.c:745
lr : sock_sendmsg_nosec net/socket.c:730 [inline]
lr : __sock_sendmsg+0x54/0x60 net/socket.c:745
sp : ffff80008960bb30
x29: ffff80008960bb30 x28: f8f00000054a4900 x27: 0000000000000000
x26: ffff80008960bbc0 x25: ffff80008960bbc0 x24: 0000000000000000
x23: fbf0000005f33740 x22: 0000000000000000 x21: ffff80008960bd90
x20: fbf0000005f33740 x19: ffff80008960bd90 x18: 0000000000000001
x17: 0000000000000000 x16: 0000000000000000 x15: 000000002002ffaf
x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000000 x10: ffff800081585b20 x9 : ffff8000815b4b18
x8 : 0000000000000000 x7 : 000000000000003f x6 : 0000000000000000
x5 : 00000000000007e0 x4 : fff07ffffd239000 x3 : f8f00000054a4900
x2 : 0000000000000000 x1 : 0000000000000000 x0 : 00000000fffffdef
Call trace:
 sock_sendmsg_nosec net/socket.c:733 [inline]
 __sock_sendmsg+0x5c/0x60 net/socket.c:745
 ____sys_sendmsg+0x274/0x2ac net/socket.c:2597
 ___sys_sendmsg+0xac/0x100 net/socket.c:2651
 __sys_sendmsg+0x84/0xe0 net/socket.c:2680
 __do_sys_sendmsg net/socket.c:2689 [inline]
 __se_sys_sendmsg net/socket.c:2687 [inline]
 __arm64_sys_sendmsg+0x24/0x30 net/socket.c:2687
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x48/0x110 arch/arm64/kernel/syscall.c:49
 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:151
 el0_svc+0x34/0xec arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:598
Code: f9404463 d63f0060 3108441f 54fffe81 (d4210000) 
---[ end trace 0000000000000000 ]---


Tested on:

commit:         c3f2d783 Merge tag 'mm-hotfixes-stable-2024-08-17-19-3..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14d277c5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9f3e2eb337834cdf
dashboard link: https://syzkaller.appspot.com/bug?extid=58c03971700330ce14d8
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Note: no patches were applied.

