Return-Path: <linux-kernel+bounces-290084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3139B954F3A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC5F0288A58
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC43C1C68B0;
	Fri, 16 Aug 2024 16:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ponTeJVY"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130051C6889
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 16:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723826634; cv=none; b=F8WqfXX4uYmWlMyO79yMCiJhU/N7SmknfNnZoVnCk6+djgWydzg6yQMqqucRbpsI6CpKRhDFrQFmjUW5FRCl3Y7lK1eSxc9JnF1MDZfZsDgBEbsqwJ9Y8ryp5AK8COghMRlkHWyVQKbuc9vCmksrq4z9AEzR1W12AWm+Jiux2Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723826634; c=relaxed/simple;
	bh=POUSCFjhMmjc53IeotcoKAIbxHVuTi8fH+Fdyt4W6mU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tq9oV5WUhXddd4b9G20Xs8Dqvvbd1XBAjDrRJCWP0WRqzqkHbKEmCCRxI+b1nCZR8y+eFXVa42F+ZJd8ArZsbOTA0nAxzmzwrPk3cXBH3/YYAUld7Y0p/+ofBlWAu0bAU2TvSrCKuOcavKYEMyYFUxZRyW3y7F+eP3I0JuY9eQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ponTeJVY; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70cec4aa1e4so1494228b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 09:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723826632; x=1724431432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjmGfkeT03F5tWuD6c3K+1JLQYngGMBUoadb0gqAs30=;
        b=ponTeJVYrj1u+KwTHWPIhF2QtlterdlpkcidkJ15MbKcoknUnxsYkW1iWj4zDkpw9B
         n4zZoKhexoacNXeQGimJiQEdeIUGliL3R333IN/hSkECrFfl6pjmddBty1jrLxNSUZTz
         PCxJ65ubRaHW3isJu0HZ+qrsLgC6Xosl57EVVosqO5V8QTJsUe2TuWgZbeuzyNCMB52K
         HXhGZ9m2cvAxZEc2SRwjZPDKsKoChFkdyfSO87qpmXtVujB54HG9QMW+5i3UaGhhOxFd
         lk96WACdva5s9obiZ2MnkLMXdkTGdFdONl/bfeSWPiRwqu9KpBfUzaNUNLU/Q4X8LTlf
         4C3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723826632; x=1724431432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjmGfkeT03F5tWuD6c3K+1JLQYngGMBUoadb0gqAs30=;
        b=htVISq/rIoiJfyGncbDfDKCD7a2g6tOPnSCDKtk40T2797Bki95ETDXUF4Uf7AFJXu
         1jnFZr19jmBa5BECvTaatRL6B+psOBn/BWhCYrkQLDnIGhja2WRLGSY/DPNl/M4lqYrG
         wCuHc6y9CH2jWT/vaWRh1XH5dtrd6JzfEvnOCWCRwRn02FqVQV1RPggrrSjQY5cAL3t3
         6+tM1Jn+aJFNsLGiGV6UwJohvQGfBB3RbTttTlx7Ug5NIB1TXkMsODTN7fXGvc07gmgG
         DaWAxNQ3uIahwicPgmwO7YdjntJ8bC5wyo10k4zU+AqT1+6jARvJG28KoP3D1xlvlxG1
         jgtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWplxtv1xLJhu+yWEjo224v2r9Rfuvr8cRWaM0KwQ5+AMaZeFIMWHtPxCQNKpDu2aOebSryJ5NvH8B5VeLjjk2iIWJYVbmhAydQ9i9m
X-Gm-Message-State: AOJu0YyrVU5VeRz8M1S0K6SvXrV2iRuPoQa9MqIKLyXFHUBD2JEA+jfn
	LvGjXGcj1MWfsOe+PVcePmxPnZxGfkMqsS7jBcB/pCAzLz87gXNcOsA5HIsEOETGbKspA5m+5+a
	4zBSsxJPcP72yxwb1be26B1wvxYUXbZcCn1eb
X-Google-Smtp-Source: AGHT+IFxt2OJjMKLRIjlOiAs738JBINyrGlu5mNXJo4i433lVF6SzMZhcaCSpNjQg5D0tiOvafTn3byiWIfc3Xr9AY0=
X-Received: by 2002:a05:6a00:cc9:b0:70d:2e24:af66 with SMTP id
 d2e1a72fcca58-713c4f37ecemr4744108b3a.20.1723826632040; Fri, 16 Aug 2024
 09:43:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000005bb657061fc9e31e@google.com> <ho6vtmwtscjszkoceusnf6rff72svhtbj6kbbqupl76dkvpybv@zmjaeybnmqsw>
In-Reply-To: <ho6vtmwtscjszkoceusnf6rff72svhtbj6kbbqupl76dkvpybv@zmjaeybnmqsw>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Fri, 16 Aug 2024 18:43:38 +0200
Message-ID: <CANp29Y6S=qD8-j869gHcNYM3ArXs03BxYBEB0c=Zb9mJvDGCCA@mail.gmail.com>
Subject: Re: [syzbot] [bcachefs?] WARNING in discard_new_inode
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Dmitry Vyukov <dvyukov@google.com>, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 6:30=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Fri, Aug 16, 2024 at 02:50:23AM GMT, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    d7a5aa4b3c00 Merge tag 'perf-tools-fixes-for-v6.11-2024=
-08..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D131e27c5980=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D7229118d88b=
4a71b
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D95e40eae71609=
e40d851
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D150be3c59=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D165c93cb980=
000
> >
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets=
/7bc7510fe41f/non_bootable_disk-d7a5aa4b.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/af15738cca6c/vmli=
nux-d7a5aa4b.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/62dacb1384ee=
/bzImage-d7a5aa4b.xz
> > mounted in repro: https://storage.googleapis.com/syzbot-assets/92de1b01=
cc1a/mount_0.gz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+95e40eae71609e40d851@syzkaller.appspotmail.com
> >
> > R13: 00007f7d2a233210 R14: 0000000000000001 R15: 0032656c69662f2e
> >  </TASK>
>
> Dmitry, this bug has been fixed upstream, and I've been seeing others
> where syzbot appears to be generating reports for bugs that have been
> fixed (e.g. BUG() in bch2_fs_journal_stop() long after that was changed
> to a warning).
>
> I don't know what's going on, but the report appears to be in error.

Did those fixes already reach the latest torvalds?
I've just tried to run the C reproducer from the report on
d7a5aa4b3c00 several times and it eventually did crash the kernel.

[   42.746251][ T5239] ------------[ cut here ]------------
[   42.747210][ T5239] WARNING: CPU: 0 PID: 5239 at fs/inode.c:1143
discard_new_inode+0x217/0x2a0
[   42.748401][ T5239] Modules linked in:
[   42.748948][ T5239] CPU: 0 UID: 0 PID: 5239 Comm: repro Not tainted
6.11.0-rc3-syzkaller-00156-gd7a5aa4b3c00 #0
[   42.750331][ T5239] Hardware name: QEMU Standard PC (Q35 + ICH9,
2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   42.751806][ T5239] RIP: 0010:discard_new_inode+0x217/0x2a0

--
Aleksandr

>
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 5116 at fs/inode.c:1143 discard_new_inode+0x217/0x=
2a0 fs/inode.c:1143
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 5116 Comm: syz-executor345 Not tainted 6.11.0-rc3-sy=
zkaller-00156-gd7a5aa4b3c00 #0
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-=
1.16.3-2~bpo12+1 04/01/2014
> > RIP: 0010:discard_new_inode+0x217/0x2a0 fs/inode.c:1143
> > Code: 00 e8 ad d7 59 ff 4c 89 f7 e8 e5 98 ad 09 4c 89 e7 48 83 c4 08 5b=
 41 5c 41 5d 41 5e 41 5f 5d e9 9f 00 00 00 e8 ba 6e 80 ff 90 <0f> 0b 90 42 =
80 3c 2b 00 75 ae eb b4 44 89 e1 80 e1 07 fe c1 38 c1
> > RSP: 0018:ffffc90002d1f1e0 EFLAGS: 00010293
> > RAX: ffffffff82131c36 RBX: 1ffff110078521f2 RCX: ffff888018a94880
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > RBP: 0000000000000000 R08: ffffffff82131bdd R09: fffff520005a3e2c
> > R10: dffffc0000000000 R11: fffff520005a3e2c R12: ffff88803c290ec0
> > R13: dffffc0000000000 R14: ffff88803c290f40 R15: ffff88803c290f90
> > FS:  00007f7d2a2336c0(0000) GS:ffff888020800000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f4c62ac2440 CR3: 000000003a4be000 CR4: 0000000000350ef0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  bch2_inode_insert+0x35b/0x3d0 fs/bcachefs/fs.c:203
> >  bch2_lookup_trans fs/bcachefs/fs.c:465 [inline]
> >  bch2_lookup+0x1014/0x16c0 fs/bcachefs/fs.c:483
> >  lookup_open fs/namei.c:3556 [inline]
> >  open_last_lookups fs/namei.c:3647 [inline]
> >  path_openat+0x11cc/0x3470 fs/namei.c:3883
> >  do_filp_open+0x235/0x490 fs/namei.c:3913
> >  do_sys_openat2+0x13e/0x1d0 fs/open.c:1416
> >  do_sys_open fs/open.c:1431 [inline]
> >  __do_sys_openat fs/open.c:1447 [inline]
> >  __se_sys_openat fs/open.c:1442 [inline]
> >  __x64_sys_openat+0x247/0x2a0 fs/open.c:1442
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f7d2a2861a9
> > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 1d 00 00 90 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007f7d2a233208 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> > RAX: ffffffffffffffda RBX: 00007f7d2a30c6a8 RCX: 00007f7d2a2861a9
> > RDX: 0000000000000000 RSI: 0000000020004280 RDI: ffffffffffffff9c
> > RBP: 00007f7d2a30c6a0 R08: 00007f7d2a232fa7 R09: 0000000000000038
> > R10: 0000000000000000 R11: 0000000000000246 R12: 00007f7d2a2d9090
> > R13: 00007f7d2a233210 R14: 0000000000000001 R15: 0032656c69662f2e
> >  </TASK>
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing=
.
> >
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> >
> > If you want to undo deduplication, reply with:
> > #syz undup
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/ho6vtmwtscjszkoceusnf6rff72svhtbj6kbbqupl76dkvpybv%40zmjae=
ybnmqsw.

