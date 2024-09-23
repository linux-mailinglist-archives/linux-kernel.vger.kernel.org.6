Return-Path: <linux-kernel+bounces-330649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CEB97A245
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 14:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D975BB20DCD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 12:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0978156C65;
	Mon, 16 Sep 2024 12:27:29 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEC9152517
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 12:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489649; cv=none; b=KgAtK1Uj30OGDxwMMuSh0r+Hc/eShoCguWSBgFndiFsND+ZP2S12lag999Oz75YsvQIXFoBgR4PfmChSQxnGZMlZP74lypZgcgDzJ/7xDAFZ2PAho6jZZDkhktjval4VJ8t7B/+/8SzC+r1SRSaWVSKB/vccDIp2s5WUfcyLr9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489649; c=relaxed/simple;
	bh=WRdqu3dsOVSI0lNgiDnJrUv7eoGbmpzNFNQ11X99l3k=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=s+4tQ0Cx3KmyiOntQt1mrZIXE1mXqNDZwIXDRAO7AIPNHLUP/N29b4Ks1yJBUMDwHZO26PcMa9sEg3uJtXtPXcmscj3xAyvfUOlrlFnf+BzczfUYDp0x4x9zWErUAotPxegQ167VRW81BI7bUHj6HmJ5ghT86dAJmcu1WjzA7Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39f4e119c57so64267715ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 05:27:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726489647; x=1727094447;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LlTq1FKLOUJVjmvuCSRVVshFU5CeqzTXz/udGtr7rFg=;
        b=bzdQ2USEJDGaCOmHQ005GzW0QPHMQLeaCMtU9w/Z/7RUuAhUJro3IHI7qG0a5fDdyq
         72zTF+LK1Taqc0ihZyh8sB9EE9X8LIPEWYQf3AL37A192StpAa8i7ZmIVMkAZY34gGqk
         n3N9GkFDxxcSm8GrS3d+yYPuuycSe4QuZalrhhry83dulIqjT95DFPkHC053T2zyDB9O
         GL3nUbB3CHbUezNmrEkCuHnBd9etQpVC//+oJhb0gNXUikc/f9kv9NYUqZyLoNoDNDKf
         vQ4aqUznBO6xwPQy2LALSkAB0gsISrnfIIPfbV6MjLOp6OIlk9EhWVbF1MIegR+2/nb/
         n8BA==
X-Forwarded-Encrypted: i=1; AJvYcCWSKiESLm0+fw96+4BBiU7j9Tm2lNGxXX5TTQqUawtQBQ+3MvWL2oxYOwq2CUYTX72E83VR2E3Sb4UEFkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM81xmK06zbquZAYQjZhslruvXWg7pv69msYbLLrwo8tRABoVI
	K5PJHJJNon2TfdnOEJHM3RTBiGaLcOopAMsx4imEd5Vzl62ltx8rF5HXwLyJavMA0vTNV72GXfl
	uB35uzkJgt9Auu+MwhXG4yUH+WHcxmK+hNdV/D2sLxQOAwy0ephP8GZw=
X-Google-Smtp-Source: AGHT+IHLIwUx6pn339V3ltmZupk9Di8OEjQGeA8YFKo4dPTP2a30LofFmtnVOuEXCbghRY7krTwzh3YB08M+uu6lmBBxwACSaxhO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218c:b0:3a0:9050:702a with SMTP id
 e9e14a558f8ab-3a090507262mr75239965ab.17.1726489647183; Mon, 16 Sep 2024
 05:27:27 -0700 (PDT)
Date: Mon, 16 Sep 2024 05:27:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66e8242f.050a0220.252d9a.0001.GAE@google.com>
Subject: [syzbot] Monthly ext4 report (Sep 2024)
From: syzbot <syzbot+list9332a94148ef9d3caccb@syzkaller.appspotmail.com>
To: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ext4 maintainers/developers,

This is a 31-day syzbot report for the ext4 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ext4

During the period, 7 new issues were detected and 0 were fixed.
In total, 38 issues are still open and 140 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  11122   Yes   WARNING: locking bug in ext4_move_extents
                   https://syzkaller.appspot.com/bug?extid=7f4a6f7f7051474e40ad
<2>  1321    Yes   kernel BUG in ext4_do_writepages
                   https://syzkaller.appspot.com/bug?extid=d1da16f03614058fdc48
<3>  1251    Yes   INFO: task hung in sync_inodes_sb (5)
                   https://syzkaller.appspot.com/bug?extid=30476ec1b6dc84471133
<4>  807     Yes   WARNING: locking bug in __ext4_ioctl
                   https://syzkaller.appspot.com/bug?extid=a537ff48a9cb940d314c
<5>  768     Yes   WARNING: locking bug in ext4_ioctl
                   https://syzkaller.appspot.com/bug?extid=a3c8e9ac9f9d77240afd
<6>  489     No    INFO: task hung in sb_start_write
                   https://syzkaller.appspot.com/bug?extid=fb3ada58a6c0a3208821
<7>  459     No    INFO: task hung in ext4_stop_mmpd
                   https://syzkaller.appspot.com/bug?extid=0dd5b81275fa083055d7
<8>  342     Yes   INFO: task hung in jbd2_journal_commit_transaction (5)
                   https://syzkaller.appspot.com/bug?extid=3071bdd0a9953bc0d177
<9>  167     Yes   possible deadlock in ext4_xattr_inode_iget (3)
                   https://syzkaller.appspot.com/bug?extid=ee72b9a7aad1e5a77c5c
<10> 64      Yes   kernel BUG in ext4_write_inline_data_end (2)
                   https://syzkaller.appspot.com/bug?extid=0c89d865531d053abb2d

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

