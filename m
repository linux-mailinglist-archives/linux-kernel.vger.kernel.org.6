Return-Path: <linux-kernel+bounces-290472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5BF95542B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 02:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFEA81F22B9D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 00:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A72D184E;
	Sat, 17 Aug 2024 00:27:25 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2D27E1
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 00:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723854444; cv=none; b=i6MEohW6XjLzmdXvJP7urniS9vCnsw7Osx8fe3NF1vlbVZc0qnEV5Z+xoHmb+Ez1HerTj4gqU1RqqPAJ30cTMZ6vJAmLPcVT04TdiGi09FeQJ+5hHaa3Z76+nITdm+jTWyc2m4EIarGMxYlS7gvGiKFDzuctcUf36C0Z/R2RnJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723854444; c=relaxed/simple;
	bh=DNLqfeRs4I7++ViKrJYG6wVxgrS5xZn449MCAqZ14sI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=a9GDCtwEWiXjhvYFLQGAdBJa6+tWQkWFohziLsSM5cMZUMSu5HReWfTB/ZTnGRmECBMlrkGhMFGIvbGuiypIA6jprlzPm6qOj93jUhjJW7TENvARNpcID4pole90iHis+RK3g4QUvK1d7RXtWJqb6+aDdxVKgt++RvHTsZAgncc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f897b8b56so193351439f.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 17:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723854442; x=1724459242;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1gN2SrQ5ddI5BK1sabWQZ54KOewTmtdJJhiH/IDylRw=;
        b=bsjxfN2Sp2zrhoHzVTgBxWvYolJ+S+zITDzyPVZeCPhFXAqemy9MAk3+pAYa9+WBuq
         OcAFYQDUeqfBY3xdZHqaZlCJB3ED96vlJkPXJxOH6repOgI8S41cpMtXJr5WFNYwCByR
         G2D3Q4t7i9ylwhMcKYSxzpSudxnI69jCbUwNyBbET8stfaBQklBNuTaZJBBqH+pV3SRy
         KhoK5CMGlaUa19AhrAG81tI3eEkm2miAYmh1ZN+e2aLW/Nsbk2hMw2Q1qusGPNoqSTD1
         etqIoZDzRrzrRRCR/Dn3V4sCQGIXkfySRr68wOoUatoGlLOFhlJdOBdJ/dgD3zUQEdnL
         Y5ow==
X-Forwarded-Encrypted: i=1; AJvYcCU8v1cTwRTzkFl8jTI3Y7kdlyUWA3zePRCMPuivjt+wrgqnUUEfUPqg60HKrg8y8oJrUmu2qPc757JKRuGEaF9UmEo52RPBAOgUuo+S
X-Gm-Message-State: AOJu0YwpN0J6wsqQ++yc+NRffZmO8EYNpUYTqKA5B2q2aE7Oz0izTlge
	FaGVPF/4MNGRhsJy3wcwbJFv3LLDBhqewMENJhbZbobMbhyLGI0SE7aWvPhgLDta7bVqwi3sZRU
	wmPWeOVBv1cBsz+keEH3Ox/WF32hMjexJ8vQWPwaQo556CJaOD1scDkM=
X-Google-Smtp-Source: AGHT+IGS+h644N8ypGgzieUdY/TV/bcjfk/heAl8LcVZKHCXEJH/wP7Fd6SyetIe3ooZ+XL736Rg3KdE/LtcOrf6EI51MYgRkhSh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:370f:b0:4b9:9c0a:6f6c with SMTP id
 8926c6da1cb9f-4cce117868cmr161716173.1.1723854442200; Fri, 16 Aug 2024
 17:27:22 -0700 (PDT)
Date: Fri, 16 Aug 2024 17:27:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ac12e3061fd623b8@google.com>
Subject: [syzbot] [f2fs?] WARNING: lock held when returning
From: syzbot <syzbot+16c06d2c27b585e352f8@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9e6869691724 Add linux-next specific files for 20240812
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=177f4b7d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61ba6f3b22ee5467
dashboard link: https://syzkaller.appspot.com/bug?extid=16c06d2c27b585e352f8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e46af5980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=158ea2ed980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f1b086192f50/disk-9e686969.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b457920fb52e/vmlinux-9e686969.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e63ba9cce98a/bzImage-9e686969.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b1fc2a52ac10/mount_0.gz

The issue was bisected to:

commit 7566a155c666dd23b413a002a50cd9ae7b95f053
Author: Chao Yu <chao@kernel.org>
Date:   Tue Jun 25 03:13:49 2024 +0000

    f2fs: atomic: fix to not allow GC to pollute atomic_file

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1416b183980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1616b183980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1216b183980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+16c06d2c27b585e352f8@syzkaller.appspotmail.com
Fixes: 7566a155c666 ("f2fs: atomic: fix to not allow GC to pollute atomic_file")

F2FS-fs (loop0): Mounted with checkpoint version = 48b305e5
syz-executor161: attempt to access beyond end of device
loop0: rw=2049, sector=45096, nr_sectors = 8 limit=40427
================================================
WARNING: lock held when returning


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

