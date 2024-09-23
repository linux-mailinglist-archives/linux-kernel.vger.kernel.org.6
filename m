Return-Path: <linux-kernel+bounces-335613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2C397E810
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 695EA1C206A0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36351946D1;
	Mon, 23 Sep 2024 09:02:24 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B1218801D
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727082144; cv=none; b=haFO/O+PpT5OpWYvx0MLScAyfjOTaV/ZQt5T6A8XgROr6enn9voVd+OlyHKsPqIPOOlwUVRHJ7dXHRbFUhfG10HjbAoBq6hI1vuU0NzYeC+ITB0/XQANmoYX75dYXS81lhsvYKwr+EnWTUjSS9KNngb9A3apvCO5Elpkfwt344I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727082144; c=relaxed/simple;
	bh=GAd44S+5klCaPfKDd6etwTCIXJl3mBx+mqeSxPW4+dE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=H7dJNEdTkGNd4h3ZpBe0AD4XzF3Z9ckVEbLOQ2j4UCEE8I9DszV9PV22KlcoL3tnGFmj7U9u3jLkvLfGsOOwpIMdzdr5HF8dBShJ+WBZ/O3UB9QUs9uBxK1Fw8nuEjYNu6UUiK2ZNa5rKYDRfpVn1Iq5iH7UAeAK8YOksRnn9No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39f56ac8d88so61810475ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 02:02:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727082142; x=1727686942;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5iWrHDgy75ujQSAtkrd1YSd/BK1uHyW7PPvp12qtc8g=;
        b=Oh6Dyrpose+ydGMAvT+tFrjHgXEBR0o9jVcJ08DhkYiCVyUqVPsDYfsfxtFrvpXe3Q
         pQ7z1Fc6sExdgtCaL5rzCH5uYEvaf0mD/8uhaWWt89L8N9IjkmBIEDW8tulksSAApzWe
         wNDcK1iRVHKM6m5I7K13wGj8vPTN2Kne3EocDa7JySHiqLwd5VXkPPD83jM2OREqNEHF
         Zb5oB1Zmb6twxaac6Y7ZLZNGbYjTQ2Aq5Hi+YQaHjXcpfYdQQIQlg29blCi+5dc3ELOi
         PCJp0mAntFqmSWhXOIdhvYqaLynX/8xG0rKvnUAICpxSpWwNAIMqxCeXFRrBQuT0ocEx
         tjLA==
X-Gm-Message-State: AOJu0Yy+uYrwHaN1aIqJ6WfEiUVBhaJ1KyFOanSgPNE9+JXSeO6HuiXP
	QsV78dlo49jDt+hHY9wzBo34uPGkcm4AItzJFG7e1bcwtElBHCYL3KrD7qgDqdWnfO6Az5B/Uzk
	0iitMYpHioekE9LrMBMCebddej25YMpXB6nUXWKyBqzi89HrR9v4azrA=
X-Google-Smtp-Source: AGHT+IHr/1nMZN9npsBJqflH8EDyMKxMKowp6Z57TX0KA0hBnVZKYlmZ/dMEdZ0nIpW8iSX+MxjK+mYO90E3bQ/u+/HoicntAi0w
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2184:b0:3a0:b0dc:abfe with SMTP id
 e9e14a558f8ab-3a0c8d25cffmr81200665ab.17.1727082142465; Mon, 23 Sep 2024
 02:02:22 -0700 (PDT)
Date: Mon, 23 Sep 2024 02:02:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f12e9e.050a0220.3eed3.000a.GAE@google.com>
Subject: [syzbot] Monthly ppp report (Sep 2024)
From: syzbot <syzbot+list22f4c01bc59cfcacc23a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ppp maintainers/developers,

This is a 31-day syzbot report for the ppp subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ppp

During the period, 1 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 9 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 73      No    INFO: task hung in ppp_exit_net (4)
                  https://syzkaller.appspot.com/bug?extid=32bd764abd98eb40dea8
<2> 27      Yes   inconsistent lock state in valid_state (4)
                  https://syzkaller.appspot.com/bug?extid=d43eb079c2addf2439c3
<3> 16      No    possible deadlock in ppp_input
                  https://syzkaller.appspot.com/bug?extid=38ad8c7c6638c5381a47

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

