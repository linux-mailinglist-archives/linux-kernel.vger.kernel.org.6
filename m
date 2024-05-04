Return-Path: <linux-kernel+bounces-168543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C68878BB9E2
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 09:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E836FB21BA1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 07:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B974125C9;
	Sat,  4 May 2024 07:58:29 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53294C79
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 07:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714809509; cv=none; b=e/KNhEBwjUL2tFZL3hw+6mGIKS1zyX9emwrIqfiqLF+1puOJvHLTnYAb5CzGOl6+Rl7a+G4XMu7XojqdppNjLzG3PCivSwhZ73212hao4iIDzErt2zOPSWzIJx6cAuzyxfiXI4Mh+tgNw7y8EY9e0LjmdJTIoSAtRtKz0+8r0B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714809509; c=relaxed/simple;
	bh=vhKsE9nsqfxOf9+LQz19COlJhVq6lk7Bw13Im3yyPlY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Qm1ZvEcRh8PZ7/Yp2C0pvayXN3bMXG+H7KEQcH+V8N4waOQEAdsAzy9Bv2To3w4SF/3b7q8Q6GEXJF/nyPO7WXjE32zXjick+DaPMfx5iB10NjmRhe5wb/6oL5ITXIweE5IWLCx1VHjqHqQk56wzA6MwQaxZZ05FRPSagZc29c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7dda529a35cso50425539f.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 00:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714809507; x=1715414307;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vA5i4KHL0Yd8QTGSNFy0jEQTCNF4LREnEXz70X88j8Y=;
        b=wD8oDX2ntNnnnWxwUsVAW1lbE8SYhchaeG965tTgEy1OPMd3+bht1YWYpl8U4Rkxwr
         fZ3qBik1K6Om+aaX6f1VJydbVR0gJGsGh2kPNOwnIrFCO/dYOJEGDgYqkKSshKIUYuuq
         fPwbosu95FYqBcjgy9shYE9pjjgGM25itqHFgSLbwh5wTg7C+bS16m3d74BjT+3rXi+o
         nVEbI4ka5z0G30/iFo+mQ25rjitm6ovRoBnikvGs/UovDaaO/ezPDYjpMybiZhi83wpJ
         AoYMq76/DVdhLObqXBvShwFQ39pw2AWmHR7yrfmgDaffip6PO6+f8DG1uz7hB9jPiEcO
         Lufw==
X-Forwarded-Encrypted: i=1; AJvYcCVln2qD5rHjDvglFValKNxIcETqcZbA+1ibcnE6y+le5iLbTzxmuDBB1zIeWgZkdujhUxI1QMGpcbbXJ7z58xD9IdZaNXHnbED2r0Rz
X-Gm-Message-State: AOJu0YzPZvai5eFxj04JcrQnWt/+oDvRgO54w5X3Ww8lr26dWL+qsU5P
	1sr1Cbf8oY8xR8g6q4ovLLm8EfDIc5cEmaP5Bx7RK67XhMCRgW944xYqYivIbvNzNMWTSjQpPkD
	s+91rF4iy6YAjtEuNHRrjBWPDOilUvKyG7qDuKWa4wQMgPTHO5wnDdhg=
X-Google-Smtp-Source: AGHT+IEGyO9zZwVgSt4Q42epq8S6QIIvrSXM7TW4Vuh8uLj1vkMof77Bv7c2DSFmH6OvckxGZaXz8qqrasPcn9ua0PZUMFKWKuMA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b08:b0:36b:26df:cce4 with SMTP id
 i8-20020a056e021b0800b0036b26dfcce4mr233962ilv.6.1714809506922; Sat, 04 May
 2024 00:58:26 -0700 (PDT)
Date: Sat, 04 May 2024 00:58:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000849b0606179c33b7@google.com>
Subject: [syzbot] [bcachefs?] WARNING in bchfs_truncate
From: syzbot <syzbot+247ac87eabcb1f8fa990@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3d25a941ea50 Merge tag 'block-6.9-20240503' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10e71b9b180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3310e643b6ef5d69
dashboard link: https://syzkaller.appspot.com/bug?extid=247ac87eabcb1f8fa990
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a743748c2da4/disk-3d25a941.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9a51bb4cf9ba/vmlinux-3d25a941.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f4a1ba4b268a/bzImage-3d25a941.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+247ac87eabcb1f8fa990@syzkaller.appspotmail.com

------------[ cut here ]------------
truncate spotted in mem i_size < btree i_size: 4 < 65536
WARNING: CPU: 0 PID: 29645 at fs/bcachefs/fs-io.c:434 bchfs_truncate+0x7ad/0xd70 fs/bcachefs/fs-io.c:434
Modules linked in:
CPU: 0 PID: 29645 Comm: syz-executor.3 Not tainted 6.9.0-rc6-syzkaller-00227-g3d25a941ea50 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:bchfs_truncate+0x7ad/0xd70 fs/bcachefs/fs-io.c:434
Code: 24 38 84 c0 0f 85 d3 fc ff ff e8 7e 4b 8e fd c6 05 91 7f 89 0b 01 90 48 c7 c7 80 52 5f 8b 4c 89 ea 4c 89 fe e8 14 b6 50 fd 90 <0f> 0b 90 90 48 b8 00 00 00 00 00 fc ff df 48 8b 54 24 48 48 c1 ea
RSP: 0018:ffffc900032d7758 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff888064756cf8 RCX: ffffc9000c7d0000
RDX: 0000000000040000 RSI: ffffffff81503286 RDI: 0000000000000001
RBP: ffffc900032d7920 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 000000000008d6b8 R12: ffff8880647567b0
R13: 0000000000010000 R14: ffffc900032d7a18 R15: 0000000000000004
FS:  00007fb75c3de6c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020ee5000 CR3: 000000002ac62000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bch2_setattr+0x1ab/0x250 fs/bcachefs/fs.c:882
 notify_change+0x742/0x11c0 fs/attr.c:497
 do_truncate+0x15c/0x220 fs/open.c:65
 handle_truncate fs/namei.c:3300 [inline]
 do_open fs/namei.c:3646 [inline]
 path_openat+0x24b9/0x2990 fs/namei.c:3799
 do_filp_open+0x1dc/0x430 fs/namei.c:3826
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1406
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_open fs/open.c:1429 [inline]
 __se_sys_open fs/open.c:1425 [inline]
 __x64_sys_open+0x154/0x1e0 fs/open.c:1425
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb75c87dca9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb75c3de0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007fb75c9ac050 RCX: 00007fb75c87dca9
RDX: 0000000000000000 RSI: 000000000014927e RDI: 0000000020000180
RBP: 00007fb75c8c947e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007fb75c9ac050 R15: 00007ffdfe29fbb8
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

