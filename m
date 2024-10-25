Return-Path: <linux-kernel+bounces-382057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BFF9B087E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94DE11C20932
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEE015ADAB;
	Fri, 25 Oct 2024 15:39:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B927070837
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 15:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729870745; cv=none; b=lcIrGeOasV67VfZ4ETmiXWtsAOLR9BLcNk8dJaRqoqTLVWCuz1Pfayv9Y4rH9RSK7EoYazYhFyeYW2zxmlDpIYLpJxREdIyGI8droVZkXlI1jrjdFIIlYEJeLw94D1CQGxUwoqv/VOc2GDr1AHlXsCt2TvH+dJBppwr/PwH26Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729870745; c=relaxed/simple;
	bh=p9sUutlW1W8I35BzB1umbiyZrvACpo+idZP5Sscodrg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fokOUSIiJBcuv49Rs+gnLcpCWBUFj/hwqJrw2YWMessm8pDcJfmpUUAkTyTUJ6LqGeUXi0y89paMvAqNvG8Gd0MP90kU7/RElsrJo39pJwhzFQ6Xr9+u+bCyrcQ/497kns8vtOaLbQeWtmRlRJn4rVCAD4cSHkNJbgLQ5z8t/xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a4e52b6577so9982255ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729870743; x=1730475543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Oq8HxeYVIUawIesiC01zouDOwHoc+4BYOjOHVRTs+Y=;
        b=LQxxvo8/zCcMYguYJehLkcXbTou0rPm4hDm5p3gupgn/pdbxInC9exKqaPQHFSZ+Vz
         ovjh065XJ3ZlU5Ez/+znbmX0djhNZLq2tseZifFTWQfO9YEx7ntM2uvW10ueKLqcAVW8
         WbrLLwDyLy3/Idfx76fBFCwmuKBcinwlkZYa7Z/hr2qtCl4agr6qzRx4Pkf/CInM335l
         +LIZNgAsFFWV/tAaJBG+ahkj85OVz+sHoxyxjNBUwAoDosOmnJTIoEXii23IChd5R3GO
         wNW/0aefFbKi0poaAjL38QDSHgGZbaGgmLikcTMe05yKaXFDKie7GOWnQWw5s5k8m0l1
         AbOw==
X-Forwarded-Encrypted: i=1; AJvYcCU/yeDFMLwoaZ+5jkLI3UtIuNvTo5e65HWKzh9OcX2/0yUDd7IStl6Pg6j/AVNlN3fSKD5ZEvHBeBA5dvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxzFPI+Zoh2Y1rq3tk0dPoEoOG6m4TS+MdRFm8uyTwIoHhesRQ
	QlnPTv6vKXRGZY4whXPZL08MBcCpYxFq0hsdGQHKE/deMGVPQS/LpGiKsXzWgSPboeI5Nb+t6D2
	PFs/G+1BeJjAEOWiGocmBhwI3Qlz/+5KU6aePw7D3hATCNbR8eA/xy0Y=
X-Google-Smtp-Source: AGHT+IEW+6miMwqaGV67v3YaAfuEG8aVAR1vi48q9c5G2ONiHa9saNcMzSStyHkUWKrLpGhCj87HBKenBVPtFz9hiiSPvfy9INs8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c21:b0:3a3:da4f:79ec with SMTP id
 e9e14a558f8ab-3a4de78e854mr64363205ab.7.1729870742768; Fri, 25 Oct 2024
 08:39:02 -0700 (PDT)
Date: Fri, 25 Oct 2024 08:39:02 -0700
In-Reply-To: <20241025152459.485-1-zoo868e@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671bbb96.050a0220.2e773.0008.GAE@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in dbFindBits (2)
From: syzbot <syzbot+9e90a1c5eedb9dc4c6cc@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, skhan@linuxfoundation.org, syzkaller-bugs@googlegroups.com, 
	zoo868e@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in dbFindBits

ERROR: (device loop0): dbAllocBits: leaf page corrupt
BUG at fs/jfs/jfs_dmap.c:3018 assert(nb < DBWORD || (nb == DBWORD && !word))
------------[ cut here ]------------
kernel BUG at fs/jfs/jfs_dmap.c:3018!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5606 Comm: syz.0.15 Not tainted 6.12.0-rc4-syzkaller-00161-gae90f6a6170d-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:dbFindBits+0x1dc/0x210 fs/jfs/jfs_dmap.c:3018
Code: e9 fa fe ff ff e8 74 40 68 fe 48 c7 c7 00 33 43 8c 48 c7 c6 40 30 43 8c ba ca 0b 00 00 48 c7 c1 c0 3a 43 8c e8 65 30 97 08 90 <0f> 0b e8 4d 40 68 fe 48 c7 c7 00 33 43 8c 48 c7 c6 40 30 43 8c ba
RSP: 0018:ffffc9000b107940 EFLAGS: 00010246
RAX: 000000000000004c RBX: ffff88801f140800 RCX: 37b0eb8928fc2800
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000000020 R08: ffffffff81749f8c R09: 1ffff92001620ec4
R10: dffffc0000000000 R11: fffff52001620ec5 R12: 0000000000000020
R13: 1ffff92001620f38 R14: 00000000ffffffff R15: 0000000000000005
FS:  00007fd1f83196c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2ea5ffff CR3: 00000000415e4000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 dbAllocDmapLev+0x1e9/0x4a0 fs/jfs/jfs_dmap.c:1985
 dbAllocCtl+0x113/0x920 fs/jfs/jfs_dmap.c:1825
 dbAllocAG+0x28f/0x10b0 fs/jfs/jfs_dmap.c:1364
 dbDiscardAG+0x352/0xa20 fs/jfs/jfs_dmap.c:1613
 jfs_ioc_trim+0x45a/0x6b0 fs/jfs/jfs_discard.c:105
 jfs_ioctl+0x2cd/0x3e0 fs/jfs/ioctl.c:131
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd1f757dff9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd1f8319038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fd1f7735f80 RCX: 00007fd1f757dff9
RDX: 00000000200000c0 RSI: 00000000c0185879 RDI: 0000000000000004
RBP: 00007fd1f75f0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fd1f7735f80 R15: 00007ffdd2e520e8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:dbFindBits+0x1dc/0x210 fs/jfs/jfs_dmap.c:3018
Code: e9 fa fe ff ff e8 74 40 68 fe 48 c7 c7 00 33 43 8c 48 c7 c6 40 30 43 8c ba ca 0b 00 00 48 c7 c1 c0 3a 43 8c e8 65 30 97 08 90 <0f> 0b e8 4d 40 68 fe 48 c7 c7 00 33 43 8c 48 c7 c6 40 30 43 8c ba
RSP: 0018:ffffc9000b107940 EFLAGS: 00010246
RAX: 000000000000004c RBX: ffff88801f140800 RCX: 37b0eb8928fc2800
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000000020 R08: ffffffff81749f8c R09: 1ffff92001620ec4
R10: dffffc0000000000 R11: fffff52001620ec5 R12: 0000000000000020
R13: 1ffff92001620f38 R14: 00000000ffffffff R15: 0000000000000005
FS:  00007fd1f83196c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2ea5ffff CR3: 00000000415e4000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         ae90f6a6 Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=166868a7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc6f8ce8c5369043
dashboard link: https://syzkaller.appspot.com/bug?extid=9e90a1c5eedb9dc4c6cc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10a7de40580000


