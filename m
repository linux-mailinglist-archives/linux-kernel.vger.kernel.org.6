Return-Path: <linux-kernel+bounces-516830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 591E0A377ED
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 22:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 348C11891E2F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 21:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C431A5BBC;
	Sun, 16 Feb 2025 21:54:27 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673CE17BB35
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 21:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739742867; cv=none; b=uDJInfv27AteBjZQmsgmpUus6AZNYJMaQ9+82qY+iQNMgsVYj9FarrXsiQ0WS4ifnaw3X6YzTr7xPbD4FIHIB0o7FRMl9ZHjoLh62fG12SpGfT2GqLaX1bxiDqumhvwWol/avTUDnIo+9ROOr8fIZDzu6oeyMFgJTgn2HDH5tdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739742867; c=relaxed/simple;
	bh=AnXkxWDVZN6ZOqJ2AGzIG8GpQnK/7jPsMK9Cj5PLMts=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DtU7Mjc7kLZkrBKFvNZZ/sk8jTPuwC452RXvL2QvQs0v43iVmhAVT+D+a+JqSdO/xptjuyTTWqatD3L8j0anLTA8uEO0yf0vsP/+ABoc0S7BEqGPL9bkwGxYjZBQyUoCY1wy451AtmSspJd/cX4ZbF1sKB8ESIFFgKpT9XFERog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d289bf6c39so6546455ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 13:54:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739742864; x=1740347664;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JxXm2tnKZ6flglv2BpFKGPaVLZ5UuhckkDLJNcHnXYk=;
        b=g8Hfu90qrLBjY5/V4R3nmDZuvcE0rUT2W6CMrKrACMhvFrvCfPuOma6XsqMJauFQqM
         ZWA9CD1ZOkpdKIs7mZ3xj2JNWtbHMCffHBxDDdEXZrK9z7AWM6wWaCVu4iwNzdOeTpqJ
         OhcZQtrcTTrfjwBiE65TguAMz2XALobpByQSdzfcG5URVXAvcWeEROp9ttaSWLSBehM7
         hgO2JesouD2j1+pf1phatI0TbFDZ75uROCmnXA50A4Uw9nUVREAYg353v3taRfDf3ogh
         3mbifvJhCXcoQqDOUnOIZVPfVMCGPncTj1XhqnoJobh6G4z+vjJxVqnEFnSyS7WHea04
         OVyw==
X-Forwarded-Encrypted: i=1; AJvYcCWbdR4TyNRsabZ86sKwgOms9HYGMNTI54uRjK6AcYbwOZSpYiy6Qfl7pQ1AZ8dReT7pcuKLSIH430LC7Eo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa9bWInsGh2psWf0PhMlerjCXJ61f8hecEvoZApcFnNc1EIhJn
	PP8nWgv5CBL/j5jSKUWEubia523Rnd04TCsS/yOxXmmRNPi2LnXENWpwKsAQQueWOt4fgPEN491
	M0aNgMErzHA02m357MYBuyqJBjABh7W0VYqbizhGQ78u54ZiMlAu373Y=
X-Google-Smtp-Source: AGHT+IFzda1xV1KPMTDiBZq7NT5bGJLzcIDp4P+g6zdjsqRvqgd7cwPSXXExFKJrRg/lPMKWnLrxiw4AGFCR6ScLn7uUF/XgYY0f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a1:b0:3d0:353a:c97e with SMTP id
 e9e14a558f8ab-3d28201f3cemr49948925ab.10.1739742864481; Sun, 16 Feb 2025
 13:54:24 -0800 (PST)
Date: Sun, 16 Feb 2025 13:54:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b25e90.050a0220.173698.001a.GAE@google.com>
Subject: [syzbot] Monthly kernfs report (Feb 2025)
From: syzbot <syzbot+list821004b1afbe695d7ba1@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello kernfs maintainers/developers,

This is a 31-day syzbot report for the kernfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/kernfs

During the period, 1 new issues were detected and 0 were fixed.
In total, 24 issues are still open and 21 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  2917    Yes   possible deadlock in __kernfs_remove (2)
                   https://syzkaller.appspot.com/bug?extid=aa419d82b68e6a7e96c5
<2>  348     Yes   WARNING in kernfs_remove_by_name_ns (3)
                   https://syzkaller.appspot.com/bug?extid=93cbdd0ab421adc5275d
<3>  342     No    possible deadlock in lookup_slow (3)
                   https://syzkaller.appspot.com/bug?extid=65459fd3b61877d717a3
<4>  272     Yes   WARNING in kernfs_get (5)
                   https://syzkaller.appspot.com/bug?extid=2f44671e54488d20f0e6
<5>  90      Yes   INFO: task hung in kernfs_dop_revalidate (4)
                   https://syzkaller.appspot.com/bug?extid=da20d108162166514db6
<6>  87      Yes   INFO: task hung in fdget_pos
                   https://syzkaller.appspot.com/bug?extid=0ee1ef35cf7e70ce55d7
<7>  23      No    possible deadlock in kernfs_fop_write_iter (2)
                   https://syzkaller.appspot.com/bug?extid=1cfd86253864f61b533e
<8>  11      Yes   INFO: task hung in chmod_common (5)
                   https://syzkaller.appspot.com/bug?extid=4426dfa686191fab8b50
<9>  8       Yes   INFO: task hung in __generic_file_fsync (5)
                   https://syzkaller.appspot.com/bug?extid=d11add3a08fc150ce457
<10> 5       Yes   general protection fault in kernfs_dop_revalidate
                   https://syzkaller.appspot.com/bug?extid=e37a1730d63d207fe403

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

