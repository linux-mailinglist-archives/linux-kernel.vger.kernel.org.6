Return-Path: <linux-kernel+bounces-525518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4ECA3F0D2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B2B6188A2B5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6355C2063CA;
	Fri, 21 Feb 2025 09:41:24 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3992D2045BC
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130883; cv=none; b=P5Gk3FYAcGDj0agbkX5uoln5jLexryWEy1ZUMvBDi8TJ5wQBYPCyZHGmCX+/JMCPaKlwRPmlxxo0sb7gxHYrMb6spqF/Xgz8zcw51y3q+FKFwLYDpRl0ve9VGqqqDef2A/I05T3tNdvhEUr6atIKpQghZEhsFjBJEXDIZloHe4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130883; c=relaxed/simple;
	bh=l3zvIDZMI6ET881AtYmbI3nm5amUHwCGjYOGgh9Xyw4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KmNyaBPb1iPM/w3eGh3a5zyENnv0GhPDhSzlx10ac3PWrtjV1pnHuZmbEd1xMteFZgtbcA5bswJvLTilcwQykaVVW+p+x8PVPecO/+1OAzVF3GknlJ2M2Fgg+c7G5UflGeBj1BQqoQhONETVfXiCCidRGK/w7p6e5gy+iaRv4X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d2b6d933a5so14732095ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:41:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740130881; x=1740735681;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5OsqRYgSCSxtMYToGhG+dYqJv9b218NUxAua9vJ1J8A=;
        b=KhjtBye+ELn5Uayk0+yW331Wlfo4No7sali8W9AxAsiZMWhYS8JRuYk2CUI1isgDPi
         PiSGrBx3KIG8UikKUgEuFIOgPfOavN+HP7FGS7s1HIr9MGjM4oUwbJbC5jJ+Dq9s2O9g
         r4mQOF2y/SdJzzPJhXQ0SF4NUDJm+uH6mbCeppn0nNP65fvndJZ/JfUS0NkUtoZ7uKCJ
         q/2oQ8rNixU68bs07Cm/YkWqTT2rgT//vljwfIbXJxOKfDNFzyLZacmAzA+WQfW2maLl
         5Xgde2lc5YinxZtlNNs07fRt6Zi47deV+31a98khyAnTP34wAUoziFtFtEqJ8tbZEqcy
         z82w==
X-Forwarded-Encrypted: i=1; AJvYcCVchbFUfoJIZZ+0GGUXOs1MbYEzPJbaepTd/OjgBDO7g1JiFhaVMyEcidSnODg32xsnIzRKJAKVTaV1Zso=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMPXowLXZlnnVxGKCJ51POxodL2ZLff1CBFj/SeczbSjaMfWVo
	LCsv8sqELNfNOiWUmIS8583FYbmfUhoTOxZX5US4vt/YtHZJOuhAXwXV5V5S2N8bjT0ReJAUWxF
	/HX286KqApfjPrEAnF34OTphYzR/MRwBLRx0XzPGbAToRvQIbw9+sw5Q=
X-Google-Smtp-Source: AGHT+IGvcQBb/y8ol5/5gosN1vMmptjmm1MJ4VhyhbDByxh8z9QBFuI6f47r9MMRmH/TQ3GoReKLOUElVmAst1ZlALa3m9/9/v9B
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1565:b0:3a7:8720:9de5 with SMTP id
 e9e14a558f8ab-3d2cae4652cmr21360085ab.1.1740130881378; Fri, 21 Feb 2025
 01:41:21 -0800 (PST)
Date: Fri, 21 Feb 2025 01:41:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b84a41.050a0220.14d86d.0357.GAE@google.com>
Subject: [syzbot] Monthly ext4 report (Feb 2025)
From: syzbot <syzbot+listf4d7496357876fa24aa1@syzkaller.appspotmail.com>
To: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ext4 maintainers/developers,

This is a 31-day syzbot report for the ext4 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ext4

During the period, 5 new issues were detected and 0 were fixed.
In total, 55 issues are still open and 148 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  33227   Yes   possible deadlock in dqget
                   https://syzkaller.appspot.com/bug?extid=6e493c165d26d6fcbf72
<2>  2203    Yes   INFO: task hung in sync_inodes_sb (5)
                   https://syzkaller.appspot.com/bug?extid=30476ec1b6dc84471133
<3>  1943    Yes   kernel BUG in ext4_do_writepages
                   https://syzkaller.appspot.com/bug?extid=d1da16f03614058fdc48
<4>  1920    Yes   INFO: task hung in jbd2_journal_commit_transaction (5)
                   https://syzkaller.appspot.com/bug?extid=3071bdd0a9953bc0d177
<5>  1025    Yes   KASAN: out-of-bounds Read in ext4_xattr_set_entry
                   https://syzkaller.appspot.com/bug?extid=f792df426ff0f5ceb8d1
<6>  1019    Yes   WARNING in __ext4_iget
                   https://syzkaller.appspot.com/bug?extid=2ff67872645e5b5ebdd5
<7>  201     No    KCSAN: data-race in generic_buffers_fsync_noflush / writeback_single_inode (3)
                   https://syzkaller.appspot.com/bug?extid=35257a2200785ea628f5
<8>  173     Yes   kernel BUG in ext4_write_inline_data_end (2)
                   https://syzkaller.appspot.com/bug?extid=0c89d865531d053abb2d
<9>  172     Yes   KMSAN: uninit-value in aes_encrypt (5)
                   https://syzkaller.appspot.com/bug?extid=aeb14e2539ffb6d21130
<10> 96      Yes   WARNING: locking bug in find_lock_lowest_rq
                   https://syzkaller.appspot.com/bug?extid=9a3a26ce3bf119f0190b

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

