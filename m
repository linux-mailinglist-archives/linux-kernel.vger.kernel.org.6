Return-Path: <linux-kernel+bounces-570605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9981A6B269
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 01:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC558486B63
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BED38FB9;
	Fri, 21 Mar 2025 00:44:42 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654DA5684
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 00:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742517882; cv=none; b=X0tXEgMPHMjd8Xa6qEQS2H7HZj2delIfq4deciaIFzHwu+2tS3+QUeK6LV0pFe0Mh+/GgSaJrnaIlh2iYv+ZUa6fswD6SOpvwgBZqwOsDPDlyrjr4skumP3/kRbLw6gXoCrBMXajpPmTdezY3X2ke76dU/u3nU7Jckk7kv3srGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742517882; c=relaxed/simple;
	bh=kUE3XcrhEmwai0vTcZPheXrXbOay9kMH//hPx8KGXa8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=r+D3fzAUWg8UqJRRPNTu9RldbbBrQhXe+/Ya35+VyHoUlRCzSJJxr9PBwLluUEoXzVLj6iOARw4Oa4w/iGXJB3cVf/lNyAT8PTBm5aph9szuiP57HzBBuUgmOztszAmQwmIHlBvujUdki8funymbZD9NTg3vUchm2OTauABxHY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d458e61faaso13411225ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 17:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742517878; x=1743122678;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kiux3QslEvXRyeLPLg16tLOU0yhFteFXkbcas4hBzGk=;
        b=k2ven1ZF56VPKv4zZBeD6np/NSLYVCcSqHB3Q6H5J3eq5I3++gwE+K9G6fuf9p3fsI
         FgMaiWFYzs3T0185DjE97jc+sToEITNcP5fkgYKr48aDpxx/ZJZtDCoZR2mwEiS4caoj
         urVjTpfOM3vxE/ARipjn1qyWq1Y/aBtLlJWFZiSYak2mkuSzXHcPdccKcUPWT78hCLUr
         RCACv82pI0pWV5FQHf95o7um5QK0IM7f415fSBOw3Ut/1Jlaoc5d8iFVvLha72SBiJSu
         HyzdCZS2CgP7lUQEO1mYS45k5a6le2lHUsCFzBoBW+eqB6sYorIcKx7lg8kf6f80ezIo
         ycxw==
X-Forwarded-Encrypted: i=1; AJvYcCVRpR1OkUonQyHnXFWt4lQ9sR3LIiQe8p/OUkWlkM1/lEpVivDK1TfMcBavA/Bj81NLeHc6G/N5HNegBow=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH7ZwfP6EDpvYFG7XC5S/82ZNMYW86Mklovu1WVUU9GjH2zBNI
	yl8pOWY84uG6NpFBJrKfYEIR+SUHTtBzFU5jH+bRPsQtC42GorpdzvrW5nnpz4mOpikXu9cMPN/
	4hUTxwqIcRlJVuLQCQjQ1y44GLgrchvf+R0k2z8WAyIFq2dvGyaG74KU=
X-Google-Smtp-Source: AGHT+IGeQr+Ks25Z+y+VBWToJi9YuwsKICJHIucttlI88aXt/OTUh7dbiuniviUAEK5TsCn8wxWwlNvrIj36MgoEZApemmK4zAo0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:9d:b0:3d4:44:958a with SMTP id
 e9e14a558f8ab-3d595edd857mr19747435ab.3.1742517878481; Thu, 20 Mar 2025
 17:44:38 -0700 (PDT)
Date: Thu, 20 Mar 2025 17:44:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67dcb676.050a0220.31a16b.0015.GAE@google.com>
Subject: [syzbot] Monthly serial report (Mar 2025)
From: syzbot <syzbot+lista1d9ae974973bddc29e6@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello serial maintainers/developers,

This is a 31-day syzbot report for the serial subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/serial

During the period, 1 new issues were detected and 0 were fixed.
In total, 19 issues are still open and 44 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 837     Yes   KMSAN: uninit-value in n_tty_receive_buf_standard
                  https://syzkaller.appspot.com/bug?extid=559c7fe4b8bac56d38c2
<2> 182     Yes   INFO: task can't die in show_free_areas
                  https://syzkaller.appspot.com/bug?extid=8f41dccfb6c03cc36fd6
<3> 123     Yes   KASAN: slab-use-after-free Read in tty_write_room (2)
                  https://syzkaller.appspot.com/bug?extid=2a81fdd5c6ddffee3894
<4> 82      Yes   BUG: soft lockup in tx
                  https://syzkaller.appspot.com/bug?extid=5e87db90e68fbc4707c6
<5> 78      Yes   KMSAN: uninit-value in n_tty_receive_buf_closing (3)
                  https://syzkaller.appspot.com/bug?extid=dd514b5f0cf048aec256
<6> 50      Yes   possible deadlock in tty_buffer_flush (3)
                  https://syzkaller.appspot.com/bug?extid=52cf91760dcb1dac6376
<7> 17      No    KMSAN: uninit-value in n_tty_lookahead_flow_ctrl (2)
                  https://syzkaller.appspot.com/bug?extid=290abdcd4f509377a0eb

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

