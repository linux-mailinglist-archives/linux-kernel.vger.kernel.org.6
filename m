Return-Path: <linux-kernel+bounces-298755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E0F95CB1D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 13:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A64331F24413
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6CD185B74;
	Fri, 23 Aug 2024 11:04:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DB9381BD
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724411044; cv=none; b=QHpIaR52HpMe0VSznIxvmuIOI9GRbEoo9vNzlAZj4Jb9NvDhrAA93tF2e566xe0q2kZ+4maOuwz7ei5DcU1hYka6KCJBB25qx0DbDORjFSqx8L4jqi5i7enYmMAmnshilHsgwKA5AuV3xC1YqKba1mNoCLFVWku5xtMnmkqToXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724411044; c=relaxed/simple;
	bh=A792DAzbzJC/kYyuA3p9/u/A7PS6WmnK8LqV5qYxrAA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mL+zP4v886ChvUBWDY7OmL3GvbTw77HqxtykD2XWgS+NGKy6TpNVxRGpYvuc6uVQxoHYZwOX03LEsJNJNv929vLQsa/BjdFg4D1w6zOa7atzmY9Dk2XlihCDXWEti7+IP3+WuwII5TNmiGGS9If4Tblny8aMm1RiKpf6rxiH4sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d2c44422eso17320545ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 04:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724411042; x=1725015842;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=btTCxaqkf5uA64CLa9Idc3D6FiB1yejXnxaa+YLEYnY=;
        b=d83kQElFVJM/8Tb6JP7KBnUddXgiqnzlmf2Nw2zAIRABYUrmyz2X8GLC+bt1sXTOn9
         lXhwO8VDcvI/eMf6kk62CkTGho7sSlYIz6Q3xbixfvRHEzi3lqgK3606mocpvdAgfbh6
         oGuUb1m7c7ZY9qYp5t5KHUswFrRB9zxDZLi0Wti2rheFt8zHG0ZIOFjQ9Br9GWKE6Wh1
         h9ap08LSFoVmOGPFDWtKi3oiFXGax/1njSPZ/EcYkfKfoozCMWL3r8g3kF5C68jQU3sR
         ezOj3qEsMPTEq8Ziy+3JxHK58W0rJDWGpDpbN3sAECE6/Ok/QbSFjFPBv2bTn1vhKF1X
         jxkA==
X-Forwarded-Encrypted: i=1; AJvYcCWxIVFXvq8rARuOSKIm6Vzf3ReFcOt1qDooN3xIBf5PSveQgkBB11mGYqjES3fYUVCw0rKBWpkS0ijNy8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU8i+xiPvPE+OUVfUhPPN9nIAcV918j/hoQLHjrq4GY5ngy99B
	bgVw8Qdb+lW0rDrVY99vGiQ3eMThQsD/LHUil7gKgi55qlmYX3lLKlU1IWNeXPW1z2ekUFFxEUk
	5xA0eOoYSIudmDTucQhTtFGNZFBWIi6jMnNena9RO7eBpLVlB46phdFE=
X-Google-Smtp-Source: AGHT+IH+heS5j6PHInlJiOJ0qNSjOWar+s6ypmBq/+4BvF++D4WTloobCAZ7vvScVGwRJeX9oSBN9kvq3VUsQkBcpBUXOuk1TCsj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ed:b0:398:b1d3:7c9d with SMTP id
 e9e14a558f8ab-39e3c9e4872mr889555ab.3.1724411042118; Fri, 23 Aug 2024
 04:04:02 -0700 (PDT)
Date: Fri, 23 Aug 2024 04:04:02 -0700
In-Reply-To: <20240823104726.1055-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009ccb26062057bb9a@google.com>
Subject: Re: [syzbot] [bpf?] [net?] WARNING in sock_map_close (2)
From: syzbot <syzbot+8dbe3133b840c470da0e@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in sock_map_close

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6140 at net/core/sock_map.c:1699 sock_map_close+0x399/0x3d0 net/core/sock_map.c:1699
Modules linked in:
CPU: 0 UID: 0 PID: 6140 Comm: syz.0.15 Not tainted 6.11.0-rc3-syzkaller-00508-gd785ed945de6-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:sock_map_close+0x399/0x3d0 net/core/sock_map.c:1699
Code: 48 89 df e8 29 a4 5a f8 4c 8b 23 eb 05 e8 cf 5e f3 f7 e8 ba ea ff ff 4c 89 ef e8 c2 e1 da ff e9 47 ff ff ff e8 b8 5e f3 f7 90 <0f> 0b 90 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc
RSP: 0018:ffffc90003447cb0 EFLAGS: 00010293
RAX: ffffffff89a02ab8 RBX: ffffffff95312d30 RCX: ffff88802a959e00
RDX: 0000000000000000 RSI: ffffffff8c0ad560 RDI: ffffffff8c606900
RBP: 0000000000000000 R08: ffffffff937328e7 R09: 1ffffffff26e651c
R10: dffffc0000000000 R11: fffffbfff26e651d R12: ffffffff89a02720
R13: ffff88802026b000 R14: dffffc0000000000 R15: ffffffff89a02751
FS:  00005555867fa500(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000440 CR3: 000000004646a000 CR4: 00000000003506f0
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
RIP: 0033:0x7f75df579e79
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff8db960f8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 000000000001cc78 RCX: 00007f75df579e79
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007fff8db961c8 R08: 0000000000000001 R09: 00007fff8db963df
R10: 00007f75df400000 R11: 0000000000000246 R12: 0000000000000032
R13: 00007fff8db961f0 R14: 00007fff8db96210 R15: ffffffffffffffff
 </TASK>


Tested on:

commit:         d785ed94 net: wwan: t7xx: PCIe reset rescan
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1046b239980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7229118d88b4a71b
dashboard link: https://syzkaller.appspot.com/bug?extid=8dbe3133b840c470da0e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10236b91980000


