Return-Path: <linux-kernel+bounces-252651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E24E493165A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F0A41C21E78
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0242018EA8B;
	Mon, 15 Jul 2024 14:03:31 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2391118E771
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 14:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721052210; cv=none; b=sdb6U6JO5hf1wlLcbDwY7gylwWr5+xhDumxnPKBXeSSdD6zzzdxs/SHYXye9b1Qy66WnuW7/UigGABtUlb1dgYYzwVw6Q1F8UtFmNxYtTQ7TwYC/q+IYatuHEsAmq36guGJBipbCCuU9nJwNHqnuktArUu7TLmNmwaVBZ2QP1UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721052210; c=relaxed/simple;
	bh=C+gRiq69F4ISt6vvxd9tUTsZhvSX+XhIhoiPKht+0Vk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Ro84hVaFmC3mKH4KAYDNBwPZNsEH2iC81CC/re5uKS00Sro0jXOe60d6Y4l48rNZvLVy3xMTsSxND8Rh21SMKfKlOFTdBaPZRUi+yDIVd3XSgPZMDVyfX4UV/bwvUZkUZmVRXpUOFKTrya9L9f9u0DfqC8l5dQ1ief2V+AiDdy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7fb15d52c5cso526876739f.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 07:03:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721052208; x=1721657008;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l1lNj/oSeYXzBUdR6uxjHpRPfChohFUFqZTmJEjOkYE=;
        b=MpRP4eZ1c71rEsPt4xnVipYyCgq6IdRcVNPRKdy7NJ5BaXcm7F6zLvH/98CuS0rsvw
         RSEVjJBlg+ti/dO5baZOnoYi3hNtEN0jJTSC5AhOhABRVZjVPs4EsQmtwOiSMQnQZ9cq
         Yu/qkD4Yg8pYtyfXXo/PMu04PX3j0/nXfUPt2iJRqNb4ZWXzATM/9p030CRUmUGbB1n6
         yM+Ui1eHXz2xjTG7bDIpmrUaJ/NdmUu4QtYTRw+kvpKNIV+DN8yyqJoAO/w5ReouFPsH
         R3NuLwXxw3IKLCkQ1i5cuC9K3cZks9I0Q2uRHc0sTbXxrekw4ZzW/i14CgOXJ4Ol/cg0
         /HHA==
X-Forwarded-Encrypted: i=1; AJvYcCWHAaGtSX8st6RJp0Xhpgpc8SOrtPyXwZqQ4CgijML8ULIo9Lp1FR9mRdzRudnByM2T0/A/0BestOIc42Sdq99Ay/KSzNvUErFziOrx
X-Gm-Message-State: AOJu0Ywv3yiwpX4UkNlPuL9IFUNrdtZeiU9n6wPaKeyZ/aKkdI5z3jX8
	ARpnmfj2SPfvgtqUMypK54N+AXY7wMzLjOMPV2BlhnnSD1cerH+3ptg6WWi5zDSVLeHyCQR9W9Y
	Ewc6/9TLJ9uyCXEoBMCS7wgF49A+NNCM1F6mZiMKvZsMHO39AQ5Rsf5A=
X-Google-Smtp-Source: AGHT+IGZKMBcCYlEDP31jz9E4gHrPb9JJsJPbCjKFqlG0rQxOeHTaUxB8iufAyylTONKJLMyslc4OwLTjoP2Tbvlx5LYLJSk1SLo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:9827:b0:4b7:c9b5:675c with SMTP id
 8926c6da1cb9f-4c0b2b907f6mr1432835173.6.1721052208085; Mon, 15 Jul 2024
 07:03:28 -0700 (PDT)
Date: Mon, 15 Jul 2024 07:03:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000080c9c5061d49b1d4@google.com>
Subject: [syzbot] Monthly ext4 report (Jul 2024)
From: syzbot <syzbot+list2032c8f48b9cdc43ce58@syzkaller.appspotmail.com>
To: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ext4 maintainers/developers,

This is a 31-day syzbot report for the ext4 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ext4

During the period, 6 new issues were detected and 0 were fixed.
In total, 39 issues are still open and 134 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  893     Yes   INFO: task hung in sync_inodes_sb (5)
                   https://syzkaller.appspot.com/bug?extid=30476ec1b6dc84471133
<2>  784     Yes   WARNING: locking bug in __ext4_ioctl
                   https://syzkaller.appspot.com/bug?extid=a537ff48a9cb940d314c
<3>  595     Yes   WARNING: locking bug in ext4_ioctl
                   https://syzkaller.appspot.com/bug?extid=a3c8e9ac9f9d77240afd
<4>  237     Yes   INFO: task hung in jbd2_journal_commit_transaction (5)
                   https://syzkaller.appspot.com/bug?extid=3071bdd0a9953bc0d177
<5>  120     No    WARNING in ext4_fileattr_get
                   https://syzkaller.appspot.com/bug?extid=d6a7a43c85606b87babd
<6>  111     Yes   possible deadlock in ext4_xattr_inode_iget (3)
                   https://syzkaller.appspot.com/bug?extid=ee72b9a7aad1e5a77c5c
<7>  66      No    INFO: task hung in ext4_stop_mmpd
                   https://syzkaller.appspot.com/bug?extid=0dd5b81275fa083055d7
<8>  47      Yes   kernel BUG in ext4_write_inline_data_end (2)
                   https://syzkaller.appspot.com/bug?extid=0c89d865531d053abb2d
<9>  31      Yes   INFO: rcu detected stall in sys_unlink (3)
                   https://syzkaller.appspot.com/bug?extid=c4f62ba28cc1290de764
<10> 30      Yes   WARNING in fscrypt_fname_siphash
                   https://syzkaller.appspot.com/bug?extid=340581ba9dceb7e06fb3

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

