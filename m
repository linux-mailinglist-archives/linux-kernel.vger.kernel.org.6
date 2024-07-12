Return-Path: <linux-kernel+bounces-250507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE6792F8AB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 12:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 984B01F235BD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 10:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BE415ADA1;
	Fri, 12 Jul 2024 10:05:23 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB742157469
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 10:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720778723; cv=none; b=jbSwZR0D4bYHfpJko+7CkRNPbM/aOgIld7LuHGzG++oA/wyvU3Sd/gVxirT5x8wBwdoQfDANJ6yqIL2nbNhwZpezLa4fAsH98zuWC/lKRScn5xj8qGxa4pDRM90CXYeu+M73139ZQ0VJQzzEUI0pcpaVIZtxukzTLKiewUjLHXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720778723; c=relaxed/simple;
	bh=DikmJ9E0CkpxwbNQafR/uYCkxku/pf/Nz17bFWwUQD4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LNxsDR0Ga0KRk9xPVybnl8wYr0OSor10fQHYEb9fvm+Zj0oiWx9OYiCxov0hn2BO+OlXgQfziwqA+Yz1cyWGaatPT8LF1Ed+1Zx7WRdonN4fXJpIjbqrAMa+d/6vBR0PcL++SY/nqd1Qdq1/AWagwUVB6c5mewQ3gpHE3IJaRAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-804b8301480so204896239f.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 03:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720778721; x=1721383521;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sbd91EqdxWCu/AGP/6JU5N6zMd6H/sbaW+FVWVJC6ew=;
        b=g3ZEN8h3ZzWz8a0+7K+8Cv+6b8JhKiDPPChSDxx2fFS+LiJeUKxmGRzuYbcSiX3x2h
         IMBx3MKLy/Rn5uW1Cu0jeakEB2GdHYzSZJI5Xbx1bKgLnPvBeEwc+b36IX8PK1mo+48O
         SOti0RIu4Ev1TTWagkT3CWpJKa6MLG+C30bw8m3hYnU/Z1fAEf9+6eg5NC96glBLQ8GX
         FZ9/dbml43WgRWTgaHSCMuwzfrdJIJs4LpFxz8I+4ZhwZldobX9VxktGXSq4OC6b03KD
         6+cR5kcweW3+bPogNRUTSPjMezithF5A5oocsy8JO5iTxRUlcflcWGMGu24kHMvF3cXQ
         hQxA==
X-Forwarded-Encrypted: i=1; AJvYcCUwpwnRBn+FHkv4EbYCxQBi8lgRXWfx030qVvNBgL2kgL2Mnjli6R9kUELiQRnIEF7MnevR4bzQwDxJE48wm8FGjKSMaeeAV5Pr0z23
X-Gm-Message-State: AOJu0YxQz+mDZssu+ePp/syjJL1pxJ3hXBFUQImBW28LXwYDgNIncmoq
	BtcudcIFhgN/elvYnSPkNAgyP47KlHrug3qxvHTQMRuqDxxXdDW3LeB5ihI6EnADpVscbL7IkCA
	LqPkly/8lqIJo2XcAZfQSOOfDMvt+ou/qo9SJcfX71GUpPPpyFENuymM=
X-Google-Smtp-Source: AGHT+IGOOu5kA2OdFNx3OPYCfpBjbuyZtWQxI+rSmp0aKMpP/GM8DhnuanvAXnFLoMgIkRMkFSPKyuZ7sLUB9otUh7fA+i7L+Nnw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8601:b0:4c0:9a05:44c4 with SMTP id
 8926c6da1cb9f-4c0b24e9f62mr666495173.0.1720778720883; Fri, 12 Jul 2024
 03:05:20 -0700 (PDT)
Date: Fri, 12 Jul 2024 03:05:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000065473a061d0a0451@google.com>
Subject: [syzbot] Monthly ntfs3 report (Jul 2024)
From: syzbot <syzbot+list90007c8b31066d0be99e@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ntfs3 maintainers/developers,

This is a 31-day syzbot report for the ntfs3 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ntfs3

During the period, 2 new issues were detected and 0 were fixed.
In total, 32 issues are still open and 48 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  11954   Yes   VFS: Busy inodes after unmount (use-after-free)
                   https://syzkaller.appspot.com/bug?extid=0af00f6a2cba2058b5db
<2>  5491    Yes   possible deadlock in mi_read
                   https://syzkaller.appspot.com/bug?extid=bc7ca0ae4591cb2550f9
<3>  3908    Yes   possible deadlock in ni_fiemap
                   https://syzkaller.appspot.com/bug?extid=c300ab283ba3bc072439
<4>  3543    Yes   KASAN: out-of-bounds Write in end_buffer_read_sync
                   https://syzkaller.appspot.com/bug?extid=3f7f291a3d327486073c
<5>  2533    Yes   kernel BUG in dnotify_free_mark
                   https://syzkaller.appspot.com/bug?extid=06cc05ddc896f12b7ec5
<6>  870     Yes   possible deadlock in ntfs_fiemap
                   https://syzkaller.appspot.com/bug?extid=96cee7d33ca3f87eee86
<7>  562     Yes   possible deadlock in ntfs_set_state (2)
                   https://syzkaller.appspot.com/bug?extid=c2ada45c23d98d646118
<8>  97      No    possible deadlock in ntfs_fallocate
                   https://syzkaller.appspot.com/bug?extid=adacb2b0c896bc427962
<9>  92      Yes   BUG: unable to handle kernel NULL pointer dereference in attr_make_nonresident
                   https://syzkaller.appspot.com/bug?extid=5b6ed16da1077f45bc8e
<10> 82      Yes   possible deadlock in ntfs_mark_rec_free (2)
                   https://syzkaller.appspot.com/bug?extid=016b09736213e65d106e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

