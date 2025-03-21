Return-Path: <linux-kernel+bounces-570604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C79BEA6B268
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 01:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 531C5486B4F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B275538384;
	Fri, 21 Mar 2025 00:44:42 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B41526AE4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 00:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742517882; cv=none; b=h4kgCqJ98GHi27Krrsf0Zo01iW9P1nOBw7BRFWwC7ep5vbqnIbCG0Gtaj8f5Fl2UA9E1plCd9eytF70420JZq2P7AXlf5E2ypsj/T0DmCSXRP7YBAerbWMT4p8RHcp/Dxu1CfT0TH0BjGD3ID/kZBhw8yW6Wd47JLG4cO0FLYa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742517882; c=relaxed/simple;
	bh=gVrx8JwHkvcVCcTs9bw8eqzimuLsp2e3hep1h4EuT30=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=itiARNn0E0BzWVDJ1+Yrx6154oerxCgpsNjj4Ljunb9DX1nDaKhMgcJ2TjvLs/pqVXmsyPTbnjxhR4kttTwqG3Y/aRA/7akmtJYarYuU5U5H+qMMIGwcXSJX0XiZw9RZ3drSniiKoJRvGjVjjM4T9IJvMM7EU70yxT7xDaMB9is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3cfb20d74b5so18456425ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 17:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742517878; x=1743122678;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XLe3EfXEq7ymtnT+1ejTFU9x1KX0C5ejSjskerXlAxg=;
        b=GyzRE0rCv0G52QkG2cJabC9fjxEMqe3S1g9kFzelpRzqp9hCM8zNmzcWmq+Ktu1r7C
         5E5op7cotl308VRi1rcEPom8clITsUfYdCGFbJM2am/f2uJMwHdyhv7sTKzkCLKd1vZh
         /BrT26xr5zB6msXJP8kaed9JtE4wpbpJ17Nn2BV988evhQj56pBZZR8KfedRJjjX+wBC
         9ovAL2qHB7v7Sph249ZQwO/wIJllPSiB5OWg6UfmbAFP/UlYpu0vKtiIrkVGJ/wiLYPZ
         /ErC/r867Wt+3ZdCsr/xrtUPIBchahO6zEpoLE2yvQBfJ8GIU0mP4MEddzQQN+g34Gnv
         dXMA==
X-Gm-Message-State: AOJu0YxdHj2QaBxy/OiMrSO1qBjkEO1d7v0+ZZX4LWcf0hf2p0IyA6Dd
	n0XNJ2dGiQ1ebSy/xoAr2aFJe/jw4uK/vx+Xp3lsxoZofgn5nAUhO+d9oeNoc1OhXzwHOkcJg8u
	IOr9pOTsHuPzFEZUYUnIwDwN6GLyp+T3l7DmGeMvhW8xlcmM8QpG32sY=
X-Google-Smtp-Source: AGHT+IHxevJ6n34X7cYaD0ykzZlag17qgnTsXf8laxxIPzy7Zgti7tAsNnVcIMCE0N3ISW7WkjIarSLmswV+Livoq7AQsQRNyib1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3047:b0:3d2:b154:49dc with SMTP id
 e9e14a558f8ab-3d5960cd132mr19329485ab.5.1742517878710; Thu, 20 Mar 2025
 17:44:38 -0700 (PDT)
Date: Thu, 20 Mar 2025 17:44:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67dcb676.050a0220.31a16b.0016.GAE@google.com>
Subject: [syzbot] Monthly usb report (Mar 2025)
From: syzbot <syzbot+listade70b662293f9976322@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello usb maintainers/developers,

This is a 31-day syzbot report for the usb subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/usb

During the period, 4 new issues were detected and 2 were fixed.
In total, 85 issues are still open and 375 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  13032   Yes   KASAN: slab-use-after-free Read in hdm_disconnect
                   https://syzkaller.appspot.com/bug?extid=916742d5d24f6c254761
<2>  3328    Yes   KASAN: use-after-free Read in v4l2_fh_init
                   https://syzkaller.appspot.com/bug?extid=c025d34b8eaa54c571b8
<3>  1931    Yes   INFO: task hung in jbd2_journal_commit_transaction (5)
                   https://syzkaller.appspot.com/bug?extid=3071bdd0a9953bc0d177
<4>  1385    Yes   KASAN: use-after-free Read in em28xx_init_extension (2)
                   https://syzkaller.appspot.com/bug?extid=99d6c66dbbc484f50e1c
<5>  1142    Yes   KASAN: use-after-free Read in v4l2_fh_open
                   https://syzkaller.appspot.com/bug?extid=b2391895514ed9ef4a8e
<6>  1096    Yes   INFO: task hung in usbdev_open (2)
                   https://syzkaller.appspot.com/bug?extid=b73659f5bb96fac34820
<7>  723     Yes   INFO: rcu detected stall in syscall_exit_to_user_mode (2)
                   https://syzkaller.appspot.com/bug?extid=a68ef3b1f46bc3aced5c
<8>  674     Yes   INFO: task hung in hub_port_init (3)
                   https://syzkaller.appspot.com/bug?extid=b6f11035e572f08bc20f
<9>  667     Yes   WARNING: ODEBUG bug in release_nodes
                   https://syzkaller.appspot.com/bug?extid=624d9e79ec456915d85d
<10> 652     Yes   WARNING in enable_work
                   https://syzkaller.appspot.com/bug?extid=7053fbd8757fecbbe492

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

