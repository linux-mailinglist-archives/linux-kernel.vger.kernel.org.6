Return-Path: <linux-kernel+bounces-188398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE428CE184
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D41C1F22261
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 07:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3051292E9;
	Fri, 24 May 2024 07:31:32 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859A012E5E
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 07:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716535891; cv=none; b=bnm5u65DZyQdDd01HwNHyDtm9Y1R5bUaSfxVNsMc4ekbQqzh8L7J1pNS5JOBaBW8XVEHXbUSl13EuktHPMZNhXGvo1Slx278RcgV8D9abzC+KNAzuAZiraigwe7pIWK6vwkAIlTn0ONeFIBznX6LxUFMamhn/yVLPITYZ1Gb5Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716535891; c=relaxed/simple;
	bh=ozhzQiDNEqcLvCSVKgQ5UNJluQO4Pa/883Qnf2UXauQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=irtIJSdbjW0hS9T1MKDnvIZikyWUUEQ1201BAGQbxPBIiyvmmYnlHJLd2vLCwVXvOD1Ps4G5QSrLfVUKklK9pOlAHRvgplbT1qWo/r3bfp6pliC7e8yIBzlJ98MPMBEoS3KaB9lZmeXKExsdNB1O5c27ANbt8dcbeKq7mFBzKKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7e1b65780b7so261622039f.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 00:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716535890; x=1717140690;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rAfbATsxMggfjxWxGQDWpN8gRwXVENntTbK+GLf4oBU=;
        b=cczvA0DzkE2OCiVepd4Ly+mKHcHQ8rcuFiUHpsSBo34bR8AfyBT0eZ53hdBBobFh/w
         /tdhuWovzfWXo8qozF/o8gV/M9TObIVpnADF2VjQBMIxX2LIvc5CvRkLVa97xFoH1UdL
         vt863GsBR4MD6T7HnV7Wwz8vzJbNiuySCfPeSPDz3SMcRd/SivVRXuM0JBS+mtk4aJ6f
         HIjWOH7KZ2cu3gObmnCvrzWsfYi9zcd4u/F8evo0srqG3iNypocfudLAuhjLFvaO/J72
         uKba2XYuajcJFzwUz+NRPFsskhJm6sPd5PgrXDYpzKNQ9winIrP1J20kUN/d/cVsh0wT
         eGAw==
X-Forwarded-Encrypted: i=1; AJvYcCWStkSOXPfFqkwI74Q8OkrOy1U9Nbp3BnrlxIUkW1H2rEW0iK+W2OLWJIiUyeL1cPChqA7TBKohmwP4AGygRjZPlHu917yJWSx++t+c
X-Gm-Message-State: AOJu0YzYm1QpeHBazKVCuwvopFCKoRT8Q/Wh9sJ93misksJDir+ZOh9S
	tKTUPFxUJENI/0k45NSKyMdw7B4F6WG6HMwgilcP4cqcgc0B1vyS2w9/qB5sLh6KB2YJNVlZ4+j
	vYlwGpHJTK1gURzSDdM8xGSQBFa6hofgGdviFBnQ2yDVpX6z5ZJHax48=
X-Google-Smtp-Source: AGHT+IHsHlyneuLNkN6uX357N7ttSvzkkHuqacjKuqKrp+lTpWI1Wzw2RMB+il1sJRJkWPq2JP7Is2uYIp4ZOZKvo1pOGNhyRqdK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:cd0a:0:b0:488:f465:f4cd with SMTP id
 8926c6da1cb9f-4b03f520d78mr25929173.1.1716535889773; Fri, 24 May 2024
 00:31:29 -0700 (PDT)
Date: Fri, 24 May 2024 00:31:29 -0700
In-Reply-To: <000000000000849b0606179c33b7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f456d406192e275b@google.com>
Subject: Re: [syzbot] [bcachefs?] WARNING in bchfs_truncate
From: syzbot <syzbot+247ac87eabcb1f8fa990@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    b6394d6f7159 Merge tag 'pull-misc' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=159d0210980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=713476114e57eef3
dashboard link: https://syzkaller.appspot.com/bug?extid=247ac87eabcb1f8fa990
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15c61a0c980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8e1377d4772/disk-b6394d6f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/19fbbb3b6dd5/vmlinux-b6394d6f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4dcce16af95d/bzImage-b6394d6f.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/fea098faf1eb/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+247ac87eabcb1f8fa990@syzkaller.appspotmail.com

bcachefs (loop2): resume_logged_ops... done
bcachefs (loop2): going read-write
bcachefs (loop2): done starting filesystem
------------[ cut here ]------------
truncate spotted in mem i_size < btree i_size: 1 < 33554432
WARNING: CPU: 0 PID: 15517 at fs/bcachefs/fs-io.c:440 bchfs_truncate+0xb79/0xc80 fs/bcachefs/fs-io.c:437
Modules linked in:
CPU: 0 PID: 15517 Comm: syz-executor.2 Not tainted 6.9.0-syzkaller-10729-gb6394d6f7159 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:bchfs_truncate+0xb79/0xc80 fs/bcachefs/fs-io.c:437
Code: 00 fc ff df 80 3c 03 00 74 08 4c 89 e7 e8 ff 28 d2 fd 48 8b 94 24 f8 00 00 00 48 c7 c7 00 98 12 8c 4c 89 f6 e8 38 b9 31 fd 90 <0f> 0b 90 90 e9 8c f9 ff ff e8 39 9f 6f fd 48 8b 5c 24 60 48 89 df
RSP: 0018:ffffc900038c7520 EFLAGS: 00010246
RAX: c2b55e02655caf00 RBX: 1ffff92000718ec3 RCX: ffff88807bd6da00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc900038c7758 R08: ffffffff815856f2 R09: fffffbfff1c3996c
R10: dffffc0000000000 R11: fffffbfff1c3996c R12: ffffc900038c7618
R13: ffff8880772676d0 R14: 0000000000000001 R15: ffff888077267bc8
FS:  00007f7f358766c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe610e2e6c0 CR3: 00000000ac338000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 notify_change+0xb9d/0xe70 fs/attr.c:497
 do_truncate+0x220/0x310 fs/open.c:65
 handle_truncate fs/namei.c:3308 [inline]
 do_open fs/namei.c:3654 [inline]
 path_openat+0x2a3d/0x3280 fs/namei.c:3807
 do_filp_open+0x235/0x490 fs/namei.c:3834
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1405
 do_sys_open fs/open.c:1420 [inline]
 __do_sys_openat fs/open.c:1436 [inline]
 __se_sys_openat fs/open.c:1431 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1431
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7f34a7cee9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7f358760c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f7f34babf80 RCX: 00007f7f34a7cee9
RDX: 000000000000275a RSI: 0000000020000280 RDI: ffffffffffffff9c
RBP: 00007f7f34ac949e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f7f34babf80 R15: 00007ffcb18bb738
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

