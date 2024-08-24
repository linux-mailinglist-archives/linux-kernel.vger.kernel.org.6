Return-Path: <linux-kernel+bounces-300210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B1895E06A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 01:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01DB828250C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 23:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67D91448F6;
	Sat, 24 Aug 2024 23:51:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28F344C94
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 23:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724543465; cv=none; b=sKXrLZYDx+l3ZJvfgbcOaXETl5oiocm/yIQZqvoGqr6YcT9KgEt/CZ+odWfNMg7Rd5dMhIWMVdSoFpnruAvXmBGI5mAuNG4us7G5MJnwyYpaKFnu2ccy5RQNOR0GXt80ixHFqQv9o4h4s9sh94QTkirOfmTCp13vQPKE0YGV0Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724543465; c=relaxed/simple;
	bh=RdFitmVq7fNagzHabT9F7T6WLSGQgYZGqrHFYgDusKg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eE/hWgbjPmT5t6+7T+UGAKAxm5zkEvn2lflzH+1gE0mei2lMXxoU5AeoHfwyTsc/BWgJ4sZ4vLyu3D7j5uAho1LiPUNWo6f44a7RRkHamQBaBDYoZw911/AMYooXnQcnmqs4BGgC8IVpKFrrLfbkxM5FjRnGWyJXvLFxqm2wlfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d4b5b9fa0so35127845ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 16:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724543463; x=1725148263;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hHUdLUDtzoyWcRju9aboq/EWF2441Z1I8yb34fhDtIk=;
        b=FhWLGVjZ2qUexx73LFiF5lM+5L62zBPBT0EDZYS9irNkknEQdkOKtUv7buoD9GEMK/
         nsrtGDJj50UXslWo41CkWVln8YH9cpKW6fqCF90JesChZT2clKKQIbB4eDok2aR/CcSf
         y80Px+cJNCIV1Vc2xX9J/DLJbZU3J25qMa+BNOWW4Qja7IoMYSyG8c/k4TCVb5x3JE6X
         h0NS/2/75Kbq8MV2NIWjqh9y3uGyPZMbtGJdQ/mEqF2X7m88emmEZGjG11dqcDoDI4jI
         wAAa1Mr/OZzPJgWr6RMZT+zLCrU//R1U3ClHknjj24ALwTBlxkO+bbx/lJXkb9Ma3YZH
         av7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUez6xiRV9r3BIvmGHv1AkUOghUH7aLhZvNh1Owl/hnJsTo9WuAMn18OGKmHDQ+bD1wVY53FcPbqI4zHa0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi1Dr/DrehE8mym7/GU9LB10HyG7HdSbwb/J7k2VmO4jVRJgSs
	+/F5Jphsg2GButmbDWzgWJJLFp1gZuhi1xOrDlcdT9lh+TD4IjhIfm9JOhxiLxzscKKyNzowmUq
	T9w22Hsh0iirUo9rcKGXwZPAN5dB8+I/VSFQvtK3OR4klywi1iBa/SPo=
X-Google-Smtp-Source: AGHT+IGnmPy7WZZw6V1ZwYMArdCSmE3r4joOhkwu5Ss9cVSBL9xZdua08LJBhptLiK+Iz/SLCd45UFiKppSidKdVwVdKyxf6qBAe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c261:0:b0:39d:3043:1f20 with SMTP id
 e9e14a558f8ab-39e3ca06c49mr3630425ab.5.1724543463015; Sat, 24 Aug 2024
 16:51:03 -0700 (PDT)
Date: Sat, 24 Aug 2024 16:51:03 -0700
In-Reply-To: <20240824233445.1324-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008359bb06207690e0@google.com>
Subject: Re: [syzbot] [bpf?] [net?] WARNING in sock_map_close (2)
From: syzbot <syzbot+8dbe3133b840c470da0e@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in sock_map_close

------------[ cut here ]------------
WARNING: CPU: 1 PID: 6067 at net/core/sock_map.c:1699 sock_map_close+0x399/0x3d0 net/core/sock_map.c:1699
Modules linked in:
CPU: 1 UID: 0 PID: 6067 Comm: syz.0.15 Not tainted 6.11.0-rc3-syzkaller-00508-gd785ed945de6-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:sock_map_close+0x399/0x3d0 net/core/sock_map.c:1699
Code: 48 89 df e8 e9 a3 5a f8 4c 8b 23 eb 05 e8 8f 5e f3 f7 e8 ba ea ff ff 4c 89 ef e8 82 e1 da ff e9 47 ff ff ff e8 78 5e f3 f7 90 <0f> 0b 90 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc
RSP: 0018:ffffc90003727cb0 EFLAGS: 00010293
RAX: ffffffff89a02af8 RBX: ffffffff95312d30 RCX: ffff88802a251e00
RDX: 0000000000000000 RSI: ffffffff8c0ad560 RDI: ffffffff8c606900
RBP: 0000000000000000 R08: ffffffff937328e7 R09: 1ffffffff26e651c
R10: dffffc0000000000 R11: fffffbfff26e651d R12: ffffffff89a02760
R13: ffff88802f8c6000 R14: dffffc0000000000 R15: ffffffff89a02791
FS:  000055555a036500(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000440 CR3: 000000001d6a6000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 inet_release+0x17d/0x200 net/ipv4/af_inet.c:437
 __sock_release net/socket.c:659 [inline]
 sock_close+0xbc/0x240 net/socket.c:1421
 __fput+0x24a/0x8a0 fs/file_table.c:422
 task_work_run+0x24f/0x310 kernel/task_work.c:228
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0768979e79
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffff26dcf28 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 000000000001d163 RCX: 00007f0768979e79
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007ffff26dcff8 R08: 0000000000000001 R09: 00007ffff26dd20f
R10: 00007f0768800000 R11: 0000000000000246 R12: 0000000000000032
R13: 00007ffff26dd020 R14: 00007ffff26dd040 R15: ffffffffffffffff
 </TASK>


Tested on:

commit:         d785ed94 net: wwan: t7xx: PCIe reset rescan
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14fdfbf5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7229118d88b4a71b
dashboard link: https://syzkaller.appspot.com/bug?extid=8dbe3133b840c470da0e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13102d8d980000


