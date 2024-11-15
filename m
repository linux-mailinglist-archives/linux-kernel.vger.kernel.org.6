Return-Path: <linux-kernel+bounces-410832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C575F9CE5A8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 453A4B2B474
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2671CF2B7;
	Fri, 15 Nov 2024 14:42:25 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B661CD1F1
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 14:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731681745; cv=none; b=TXpBbh+BWaeTXfwUvjse43I0+Y8CuNHmZ68QXG/tsLHWjxLOjDNAd/mrzBLkbeDznZVUWQVLvqo/jhSCdiyN2yoiUFLZRa+R13RdNthbQXY7VuJCrAw/nXlVdp8Sq+qRr0Jw2gP4dDyhYAMLgRDb4ToTKsjIhoPFS+aKCTb0Cdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731681745; c=relaxed/simple;
	bh=LtNSkAzLSXCtPPaTga+LAQj/4pDrX/irLQXSdAVhvK4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iYdliADT5LL0LrQgyDw0QcJR0eYriSouj9sR844Srqdt3K5PUm4f8eMG2dRzfQlUnHoDZOWf9+hIR+TK57KvWA4i7rqrEEc2EgUk9M9G7d4c9BWHi1BHA+vImpp0T5rJyAsHEAcajx4tsxj/5gpxUsr9JbVawDlRvjMUZ9DbIgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a71a9ed154so20667805ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 06:42:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731681743; x=1732286543;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KbN2ypUO22bhAatVep/TVVxgQVG+AeOeRHiEpaGVRlY=;
        b=ng7BYWqRRT3ROhxhYIS17R0mRuZLw511CDWe2mMBZXiNkrghGQoMZV/prA/E3LrVAx
         GS2gYoVVw0qJOWKQ1ovjTKcpTVl+f1Gg5VfVUGQf59e88UwevwdIbD01U5o9z3xWr/sT
         L54+4TpU/FKp/sb+D0x7oUNcDYbqUVffgBPRRkTI93XTKF7z1Fii9Sxfb4izfADG1V49
         iqzdtKIE7Cp1ZBiJH4FS2c4wqcumAHA9UUgejGkreDoUGQtwFCLXjk1Fj/Xg/3NbMCi5
         Zb/9dl/4kOAvAlkFM6j79y1eNa3K1MSKNs/8gL4zv9wWLliZXyfj/AhfYYS3mgULBwvx
         ksUw==
X-Gm-Message-State: AOJu0YzFg2GfflvTZjMm3X5am1ep+qVI0vY3H/xVXSyULdZi9pevdblv
	gqKCCMdug6bc1krVqKuSX6oSWu9G1RWL5tL0iCzkYrnthMMuq/eplyjO4dpy6VQDbHbykpHT/Ua
	rl61LlmRnpTqxR61kGSukDcb4bf46aGU/FEpJee2lYYtRgyETFwcZ13M=
X-Google-Smtp-Source: AGHT+IEBeF6O3ZdAfz5TdbPb9Sj1ENMdzbhjcE0E3Ozv7YtXAqQMUb3hcM5t3X3XkyzK/DVlImRQEbPw3ZkCKjXBGqhYNDrDH7di
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4f:0:b0:3a2:7592:2c5 with SMTP id
 e9e14a558f8ab-3a748078111mr30608885ab.17.1731681743038; Fri, 15 Nov 2024
 06:42:23 -0800 (PST)
Date: Fri, 15 Nov 2024 06:42:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67375dcf.050a0220.bb738.0002.GAE@google.com>
Subject: [syzbot] Monthly usb report (Nov 2024)
From: syzbot <syzbot+list77c90b8abe21b2b55fe6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello usb maintainers/developers,

This is a 31-day syzbot report for the usb subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/usb

During the period, 12 new issues were detected and 1 were fixed.
In total, 100 issues are still open and 359 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  9169    Yes   KASAN: slab-use-after-free Read in hdm_disconnect
                   https://syzkaller.appspot.com/bug?extid=916742d5d24f6c254761
<2>  4442    Yes   KMSAN: uninit-value in dib3000mb_attach (2)
                   https://syzkaller.appspot.com/bug?extid=c88fc0ebe0d5935c70da
<3>  1537    Yes   INFO: task hung in jbd2_journal_commit_transaction (5)
                   https://syzkaller.appspot.com/bug?extid=3071bdd0a9953bc0d177
<4>  1524    Yes   INFO: task hung in uevent_show (2)
                   https://syzkaller.appspot.com/bug?extid=592e2ab8775dbe0bf09a
<5>  1203    Yes   INFO: rcu detected stall in hub_event
                   https://syzkaller.appspot.com/bug?extid=ec5f884c4a135aa0dbb9
<6>  1062    Yes   KASAN: use-after-free Read in v4l2_fh_init
                   https://syzkaller.appspot.com/bug?extid=c025d34b8eaa54c571b8
<7>  967     Yes   INFO: task hung in usbdev_open (2)
                   https://syzkaller.appspot.com/bug?extid=b73659f5bb96fac34820
<8>  878     Yes   general protection fault in ir_raw_event_store_with_filter
                   https://syzkaller.appspot.com/bug?extid=34008406ee9a31b13c73
<9>  862     Yes   INFO: task hung in usb_get_descriptor (2)
                   https://syzkaller.appspot.com/bug?extid=e8db9d9e65feff8fa471
<10> 660     Yes   INFO: task hung in hub_port_init (3)
                   https://syzkaller.appspot.com/bug?extid=b6f11035e572f08bc20f

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

