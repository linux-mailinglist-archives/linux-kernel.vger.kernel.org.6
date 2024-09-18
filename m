Return-Path: <linux-kernel+bounces-332779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5CB97BEB7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 17:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2D9A1F22577
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 15:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278C31C8FC7;
	Wed, 18 Sep 2024 15:38:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCFE1C68AC
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 15:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726673885; cv=none; b=QXk3MUtgjh2Fia7fEP/YfZJVK1HIf7yx+wIhmMVTtBNNHkGkY+LNtxMnSDM3d3qEOnY7+GTr2XCIJKQu8/DzUw1bPMUDqRTIKVgHkEJWo3Gwaigx8vp9UeU5feJsodfGbcwNJUPX9FbevvjyxTDWpn0sadUoPkhNIsDKmhJI6AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726673885; c=relaxed/simple;
	bh=+Cfs6PMjY4fKFDqPhAZ48hNmjQ3TT5CGeZcMvzU/JYo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZVDT+LBMzHc3EVMgmFVfsoucEOyH/NgnpDBwT9QO+SfeXc31fqh0j2MfUZpdfeXf9s7lJ5z9MlAA8NrJKzZSIphy4IZMnMbh9zqc/WT9ApqiPfbIDcOH87gg6QDe4AXtBlDuWgtBsOimzsJlLz6Q82IA/Ndd1+L7U5os+OMiVO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82ad9fca5fcso998379039f.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 08:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726673883; x=1727278683;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SUeJBnDVP92jVDABUsrdYV3ZrVLsOBxxcGY7ZqKLYDY=;
        b=ht7a6ISfjfE6pcKws/ShkP1kmVKy1T5MVI4HjLJcHa9e2Yu+pHlRaFikLLmjW4DkO1
         N76T09F18a0AlirwvABQsMI7JBjyL5AhQ4Nq/q93sLTHQ2xNYXawbt+4fnWMZj0LJMMf
         QR0CdTUVmS90Ak2gwz8wBRxehaC+kE2oVdBtqrOIeh6tSYKpMDpmI2bwv5Apzttm8S4k
         7UMDX+kzBoU3NuAnas478rDoqhCS93KF4IVJQz92orDhvYyjo9hGgHEuQ7/zs1jhxGpy
         99TOuBIP0bLFsJQduLyKUg99vu7v/Nsj889K2nWmsVt31y0f3YSSCXq1KnFKkZZsZBZR
         1h/w==
X-Gm-Message-State: AOJu0YyCQFxj4iC8kkTE/eNC1I92gYi29O2DIicMnWZyjSq0A05K/CX5
	7IUxwHnaTQoUps3GjHYmIp0dL7Qisv1iimOmZ8Y0lpKn8+h/JnHcxjo0EFMAweusib2IWm6O+3n
	CheKeHxQVoqwBlDg4/BBCeyM8CU0iFRYTY216+p6A7ZvRLn6FXorU5yo=
X-Google-Smtp-Source: AGHT+IEUMY7SfLgigoR5Rt3yD6WwQgK9Htyem+f2zjw6xnuY6LwIN4oMp8rzeGsBiLSslotlAY2nmTxB5DFebnzgXPS1Z2I46vju
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c2:b0:39f:7a06:2a62 with SMTP id
 e9e14a558f8ab-3a0848af6d4mr222683805ab.5.1726673883080; Wed, 18 Sep 2024
 08:38:03 -0700 (PDT)
Date: Wed, 18 Sep 2024 08:38:03 -0700
In-Reply-To: <CAABpPxQ3+-wyEeGsVc+9ihNxDGFUFVQSWHKHSJnVQH6jSfYoRQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66eaf3db.050a0220.252d9a.0018.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_write_cluster_by_desc
From: syzbot <syzbot+18a87160c7d64ba2e2f6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, pvmohammedanees2003@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in ocfs2_write_cluster_by_desc

loop0: detected capacity change from 0 to 32768
ocfs2: Mounting device (7,0) on (node local, slot 0) with ordered data mode.
------------[ cut here ]------------
kernel BUG at fs/ocfs2/aops.c:1179!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5601 Comm: syz.0.16 Not tainted 6.11.0-syzkaller-05319-g4a39ac5b7d62-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ocfs2_write_cluster fs/ocfs2/aops.c:1179 [inline]
RIP: 0010:ocfs2_write_cluster_by_desc+0x1fc7/0x1ff0 fs/ocfs2/aops.c:1240
Code: 03 48 8d bc 24 30 02 00 00 48 c7 c6 39 81 10 8e ba 7e 04 00 00 48 c7 c1 00 05 49 8c e8 92 94 1d 00 90 0f 0b e8 fa 7c 12 fe 90 <0f> 0b e8 f2 7c 12 fe 90 0f 0b e8 ea 7c 12 fe 90 0f 0b e8 e2 7c 12
RSP: 0018:ffffc90002126e20 EFLAGS: 00010293
RAX: ffffffff83816206 RBX: ffff888043dd96e0 RCX: ffff88801f7d4880
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90002127170 R08: ffffffff8381496e R09: 1ffff110087bb2ac
R10: dffffc0000000000 R11: ffffed10087bb2ad R12: 0000000000000000
R13: ffff8880130be000 R14: ffff888043dd96b8 R15: 0000000000000000
FS:  00007f815880c6c0(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020201000 CR3: 00000000232b0000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ocfs2_write_begin_nolock+0x3a2f/0x4ec0 fs/ocfs2/aops.c:1816
 ocfs2_write_begin+0x205/0x3a0 fs/ocfs2/aops.c:1903
 generic_perform_write+0x37e/0x730 mm/filemap.c:4025
 ocfs2_file_write_iter+0x17b1/0x1f50 fs/ocfs2/file.c:2456
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xa6d/0xc90 fs/read_write.c:683
 ksys_write+0x1a0/0x2c0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f815797def9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f815880c038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f8157b35f80 RCX: 00007f815797def9
RDX: 000000000208e24b RSI: 0000000020000240 RDI: 0000000000000004
RBP: 00007f81579f0b76 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f8157b35f80 R15: 00007ffe1f4b9668
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ocfs2_write_cluster fs/ocfs2/aops.c:1179 [inline]
RIP: 0010:ocfs2_write_cluster_by_desc+0x1fc7/0x1ff0 fs/ocfs2/aops.c:1240
Code: 03 48 8d bc 24 30 02 00 00 48 c7 c6 39 81 10 8e ba 7e 04 00 00 48 c7 c1 00 05 49 8c e8 92 94 1d 00 90 0f 0b e8 fa 7c 12 fe 90 <0f> 0b e8 f2 7c 12 fe 90 0f 0b e8 ea 7c 12 fe 90 0f 0b e8 e2 7c 12
RSP: 0018:ffffc90002126e20 EFLAGS: 00010293
RAX: ffffffff83816206 RBX: ffff888043dd96e0 RCX: ffff88801f7d4880
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90002127170 R08: ffffffff8381496e R09: 1ffff110087bb2ac
R10: dffffc0000000000 R11: ffffed10087bb2ad R12: 0000000000000000
R13: ffff8880130be000 R14: ffff888043dd96b8 R15: 0000000000000000
FS:  00007f815880c6c0(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020201000 CR3: 00000000232b0000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         4a39ac5b Merge tag 'random-6.12-rc1-for-linus' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16817fc7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b74c2037cf7ab6b0
dashboard link: https://syzkaller.appspot.com/bug?extid=18a87160c7d64ba2e2f6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1550269f980000


