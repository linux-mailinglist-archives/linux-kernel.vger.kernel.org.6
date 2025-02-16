Return-Path: <linux-kernel+bounces-516825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EA5A377E5
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 22:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF1BE188E76B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 21:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DF71990D8;
	Sun, 16 Feb 2025 21:53:22 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35634C8E0
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 21:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739742801; cv=none; b=InWetjEhgLn16RJyF0HmxTUPQ6KhaDyvoBScfKCXwfvksbU20ZhNAa+3O8BYGUbmyOD3rK7aAMTRIwD/CC/KahpHaZ2VxmxTDGNXYA5BXjM5R9iJXEdMX5s9C2hzI2zHF+oHbMfMCyn0aPvKo0G2ScWaJcZfQqEqed7zn68mZXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739742801; c=relaxed/simple;
	bh=uIhAZ4GX55IifAUO0HZ5YNZ4H95enbP3Ufo7EZSw4es=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gDLzl/gNL/uUTKmXLv+ltu9OGHjyUh+thLjVZ1yZrMGPIAB9FaKe2aKt6CNFePutH7razL4mkl0JLiBw7eFBd4xUsRgyxCo3WMNRgAYi4xJYVZ6t/cClN6b/cEckeNa3TfNKWiaJqLZL/bi6a5Dg/y9wod/kpok/p+nG1k6Ai+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8552cf82c01so596295239f.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 13:53:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739742799; x=1740347599;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zvzlh8rBNfRkvNnq76a9cHlXie97oPHR6kXBR2RdZMs=;
        b=cdQ6twGPkaOvQd8OlE1bIljjGkRGI4Bl+8O8k+7vJ++E052le0c3Jp/8pyOeN0mZHX
         kPV2++B0oqIah4pae48ogcrczn58E9bmua+/tZqisC3hFTAah6hHi+0INGxsyXTx8heR
         nF/Wjeur7g1HFQ7ZKGPn4eCrTijv56jx/lt7GVJXcbDwuffSbpwjxo2nFvAcHB93AW7o
         PQGlFCe2QcaNfPHaDzv/bzZiCGyW66Soo2dyaDLIfEMNOABOelPf8/R42toZsw1oLxQu
         D5IQfyuKBg9T/+LnIWQG+FTG5XA/gqE80JrR9+hvrC+ASZOvNZTanFjIot9aidWIm+ww
         L2BA==
X-Forwarded-Encrypted: i=1; AJvYcCUj4A3bXbRdYCA9qSuAuas4WklZHzUWZIl7lHmqbp7rEpqi+33YPQXHAuKMgaQz9kC4mbmFCics7tqn0x4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQHpfn4NPQBXqp0g01bJJAvox9Ahsv8t5tVpnoSHYxkkUlcKa5
	WtbWthGDF2gwULpKyAElIXymcnm1T3h8soiEQA+Y3DNXRlK4ObxtQCRNThogeWHZAATfK9CFOjR
	FCnF6IzAOv3rxUzBDDPSRrxK02ixWw2LmY9LiitDQrmfe5i37Tjv9IdY=
X-Google-Smtp-Source: AGHT+IHQmuM6vRequHdbUhqRX+tGP+7f81E5WepbRoXVBH+w2f7nnCdNHCePw7gGOXimpBVEvfG1ToF80Rww+3tNEuB8fyEtlChX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184d:b0:3cf:bb3e:884c with SMTP id
 e9e14a558f8ab-3d280940c90mr60134545ab.16.1739742799361; Sun, 16 Feb 2025
 13:53:19 -0800 (PST)
Date: Sun, 16 Feb 2025 13:53:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b25e4f.050a0220.173698.0015.GAE@google.com>
Subject: [syzbot] Monthly ntfs3 report (Feb 2025)
From: syzbot <syzbot+list540750168bf76ebe43cf@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ntfs3 maintainers/developers,

This is a 31-day syzbot report for the ntfs3 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ntfs3

During the period, 2 new issues were detected and 0 were fixed.
In total, 43 issues are still open and 61 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  16240   Yes   kernel BUG in dnotify_free_mark
                   https://syzkaller.appspot.com/bug?extid=06cc05ddc896f12b7ec5
<2>  5550    Yes   possible deadlock in ntfs_read_folio
                   https://syzkaller.appspot.com/bug?extid=8ef76b0b1f86c382ad37
<3>  4557    Yes   possible deadlock in run_unpack_ex
                   https://syzkaller.appspot.com/bug?extid=731b27ee9413ba859499
<4>  4395    Yes   KASAN: out-of-bounds Write in end_buffer_read_sync
                   https://syzkaller.appspot.com/bug?extid=3f7f291a3d327486073c
<5>  3718    Yes   possible deadlock in ntfs_fiemap
                   https://syzkaller.appspot.com/bug?extid=96cee7d33ca3f87eee86
<6>  2302    Yes   possible deadlock in ntfs_file_mmap
                   https://syzkaller.appspot.com/bug?extid=c1751b6739d83d70bb75
<7>  1999    Yes   possible deadlock in mark_as_free_ex (2)
                   https://syzkaller.appspot.com/bug?extid=8df514c431bd240c5644
<8>  1782    Yes   possible deadlock in attr_data_get_block (2)
                   https://syzkaller.appspot.com/bug?extid=262a71e9d2faf8747085
<9>  1717    Yes   possible deadlock in ntfs_look_for_free_space
                   https://syzkaller.appspot.com/bug?extid=d27edf9f96ae85939222
<10> 399     Yes   possible deadlock in ntfs_fallocate
                   https://syzkaller.appspot.com/bug?extid=adacb2b0c896bc427962

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

