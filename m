Return-Path: <linux-kernel+bounces-300002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF6795DD6F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 12:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEB7F1C2118D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 10:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8C21552EE;
	Sat, 24 Aug 2024 10:58:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A6528DB3
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 10:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724497084; cv=none; b=r3ekjVfoLKLf4dDYlwJvGgIh7adQXakMP7jLpwXFOg8RF6VPh/TIYcgzrDX5tcm5YldF1sOnDJz8MEjSEQRL5EkY1ynZK2ZqdNCgVMQ/g7HGOp0Z4eJlNUP5grF/NqTxAZAOKk6v4CA2iXnwKR0W75lPttZ0uNXw8ShuaX/8xTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724497084; c=relaxed/simple;
	bh=HH4rQXIIMvDbdyvegr7/1VYVkC5fc08WM6nhAJj1JLA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=l4OwdEnaBZ+mxsBjwaomQ7fx9yWznIUZYOlndzrIK5M+FO/JQn5l4FAnTZ61HsqF6VKdo4xMALKdwqjcviY2V76lziEuDuCdG1hsRPbNexrqfRG5BupUUw4yCgoUYkkxVCCVWC8uZyC8NGfccNr5zRAVvn2ydkkwjL5EsxoOayo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d2df2e561so33906725ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 03:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724497082; x=1725101882;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dk82952GNCl38vKFvUNbJ0aE7xM95qstDq+DwcSqlRU=;
        b=XDsJcNi1hCdZoREt8IfIE9aQASx5HlMKBQHmRhDrQTMtUkfOCV14UGq66Q4yki+KCO
         kW4gmGS0C0nM+/QsFB6ah+UJ3C9pFFMrK3NsKfxE77B9za++QO2my/bPyTsqqWVY+0pO
         Zqt8IuuIFzqUQvn3scb/GAfkcUB24nmJRzK2HzB1XSu7QCBV0LBCMh5BmkwJjszCXAx9
         02FaTwDsAULLdtNHfixkD2XucAqFeF9fRgcI/6SFSeuUmIrNeJKylKVYG8nZb2y1/r5M
         g06aC2T2sMnNsWK8aMCA9Y0UqPwkf7vo+kxsnrM1w/NZr2WkN45JS5H4j45/X3I41+gm
         2RAA==
X-Forwarded-Encrypted: i=1; AJvYcCV3Xd1lNr/bjgFrpwtC1f3s8mE5kvSL/RaiIrdAH+Yl+yV8Ewy8VdY77bbcDpyVfNgK7bc3qNjhA9Rd2jM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXMQBt/+I2LDDnS4xj9HDQJquEcyMOom9P2uSsENmxkxNmNzsT
	W9DvCHDX1xoboaLp0Db63tpAODmuO14R0JFG5D087aWo5PY4ZPrZ1GJMWBFNpPVD0Hqd2tR7tSk
	VFlAbCy4OJUdU7LzhDdFWgw6aluhWAoYKzlycAFcPkFuQbs/ik/Sa4BM=
X-Google-Smtp-Source: AGHT+IEo/Wz3PuLhftQHD++ZUsRMfYYpRQ1N7Rr2R4tB19JNJewU7jXgh5qCRzDmbXtp/S4LS12i19u5hcPqhWgC50TEhUwecElh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c564:0:b0:39a:ea89:22e8 with SMTP id
 e9e14a558f8ab-39e3c97fb30mr2809285ab.2.1724497081751; Sat, 24 Aug 2024
 03:58:01 -0700 (PDT)
Date: Sat, 24 Aug 2024 03:58:01 -0700
In-Reply-To: <20240824103832.1203-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f9689a06206bc3bc@google.com>
Subject: Re: [syzbot] [bpf?] [net?] WARNING in sock_map_close (2)
From: syzbot <syzbot+8dbe3133b840c470da0e@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in sock_map_close

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6084 at net/core/sock_map.c:1699 sock_map_close+0x399/0x3d0 net/core/sock_map.c:1699
Modules linked in:
CPU: 0 UID: 0 PID: 6084 Comm: syz.0.15 Not tainted 6.11.0-rc3-syzkaller-00508-gd785ed945de6-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:sock_map_close+0x399/0x3d0 net/core/sock_map.c:1699
Code: 48 89 df e8 e9 a3 5a f8 4c 8b 23 eb 05 e8 8f 5e f3 f7 e8 ba ea ff ff 4c 89 ef e8 82 e1 da ff e9 47 ff ff ff e8 78 5e f3 f7 90 <0f> 0b 90 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc
RSP: 0018:ffffc9000364fcb0 EFLAGS: 00010293
RAX: ffffffff89a02af8 RBX: ffffffff95312d30 RCX: ffff88801edd5a00
RDX: 0000000000000000 RSI: ffffffff8c0ad560 RDI: ffffffff8c606900
RBP: 0000000000000000 R08: ffffffff937328e7 R09: 1ffffffff26e651c
R10: dffffc0000000000 R11: fffffbfff26e651d R12: ffffffff89a02760
R13: ffff88807a20b800 R14: dffffc0000000000 R15: ffffffff89a02791
FS:  000055556abaa500(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000440 CR3: 0000000011878000 CR4: 00000000003506f0
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
RIP: 0033:0x7f4615779e79
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffddbe62388 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 000000000001c61a RCX: 00007f4615779e79
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007ffddbe62458 R08: 0000000000000001 R09: 00007ffddbe6266f
R10: 00007f4615600000 R11: 0000000000000246 R12: 0000000000000032
R13: 00007ffddbe62480 R14: 00007ffddbe624a0 R15: ffffffffffffffff
 </TASK>


Tested on:

commit:         d785ed94 net: wwan: t7xx: PCIe reset rescan
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12911239980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7229118d88b4a71b
dashboard link: https://syzkaller.appspot.com/bug?extid=8dbe3133b840c470da0e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=147c642b980000


