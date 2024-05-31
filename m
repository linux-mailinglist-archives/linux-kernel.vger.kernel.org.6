Return-Path: <linux-kernel+bounces-196364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 519808D5AB7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82CD21C21592
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 06:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D337680C04;
	Fri, 31 May 2024 06:48:33 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009518062D
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 06:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717138113; cv=none; b=JyVvzdVoqYEaB8dNQ2cLR6OBdBgHdI9WBdHdAjPc4I79pqs9hTGfiMTQnJelt7xnRchhzO12fAAI7XZRTYdP5e/kEDIYyXfj8amdzYtyZDFpj7D2flsqUEiLqp5L4FiA4vESVCFurJY/gLCWpHNjT7tq0jnDndh8+UOERYOxD6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717138113; c=relaxed/simple;
	bh=7QejB9pI0IN5MUmQWauJo90F0JVTLv2zs5GyRFRNBA0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NC/Ao3FQzOUJTgiFiG2t0Uz+DcjFAnhb2U74FKSq8SnP205J1kap8P9XBtNXLdL4SvqFGiCrY40YKy9+8tOWZ5V2UmCach8hXPC0IXbvU7Ptc/9faBddtxxiNf0EPBzdeYNCrvjv6h89OzekARWcblvh/K5OkwrHuR9pnqjb3jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3748bce476fso3907095ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 23:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717138111; x=1717742911;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gEINjGxnE7ro2V60KkzJtpSNs6OYeynGZGwunvL8F4w=;
        b=BnKTNUm868lxGwl8nicFOj0y8Rl2KJCN97XUGI25rN1jsFdmJNNfYowgpOwi//ORaG
         1D5nEqKWDrNYC2l/6kEVMlTOk6ZBZFXpWBj0vnwfPNbCnON+K3+QpusSM+GRTdazoSYZ
         BLo15z1WeN86cY8ftqx/bgcof13FJ3eiv3akyr5925gJJW58WCJ/s0desHkcyXEa75gk
         yFbRGK5vt52j7cl7EOOJpZIGTSvgb9x5O/HjBEIBR6KMG+IU/sO+/57qaDM6j8uRZmil
         W3XE3Jq0BvTmLqUe3Zw4ULMasHfHFzjz8Dh/pM1BLM4E4TRgEIR6egze594cwFdWg/Uj
         FIBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU87fsDOKgSiWOuREaP0gEEiRHlmDQ4JMCuFuqds0IgeTvB56gcdYRDbFne84uN9ioNPmn17ko1kNF2/bhiRMQXRlFY2MGM8QKfETNj
X-Gm-Message-State: AOJu0YwaSvx9axlct6/bwF/GLlLM7l4daLHeNTDIJa14urmBzrD5E+tX
	6I0zxunLhT2EKPvyr8j7sVvm+fLXDcRqK3WPSuUZ5R//ooAtRgswjZnztxLck9eW7udU0aP7BzW
	ePXCrIzMn1BuKxOJVe6zSF7J8iF0WpIT+2IreMxkgz5rBAHfPrjNqWog=
X-Google-Smtp-Source: AGHT+IF1hLMNoT/Ruj48ZmhlqzRawIwG3TzT7LjKnD077jWcLgUayf6dNSVc0J5xARvBUFRuxYPg2yAOcRCH4SBGe/TYfQi6KF0+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cb:b0:36d:cef6:7c8c with SMTP id
 e9e14a558f8ab-3748b9f6d02mr786545ab.5.1717138110541; Thu, 30 May 2024
 23:48:30 -0700 (PDT)
Date: Thu, 30 May 2024 23:48:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001bfd730619ba5fe5@google.com>
Subject: [syzbot] Monthly input report (May 2024)
From: syzbot <syzbot+listc6acad497c5ea05c5769@syzkaller.appspotmail.com>
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello input maintainers/developers,

This is a 31-day syzbot report for the input subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/input

During the period, 4 new issues were detected and 0 were fixed.
In total, 24 issues are still open and 52 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  11549   Yes   WARNING in input_mt_init_slots
                   https://syzkaller.appspot.com/bug?extid=0122fa359a69694395d5
<2>  958     Yes   WARNING in implement
                   https://syzkaller.appspot.com/bug?extid=38e7237add3712479d65
<3>  646     No    possible deadlock in evdev_pass_values (2)
                   https://syzkaller.appspot.com/bug?extid=13d3cb2a3dc61e6092f5
<4>  380     Yes   INFO: task hung in uhid_char_release
                   https://syzkaller.appspot.com/bug?extid=8fe2d362af0e1cba8735
<5>  313     Yes   WARNING in cm109_urb_irq_callback/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=2d6d691af5ab4b7e66df
<6>  19      Yes   possible deadlock in uinput_request_submit
                   https://syzkaller.appspot.com/bug?extid=159077b1355b8cd72757
<7>  13      Yes   WARNING in cm109_input_open/usb_submit_urb (3)
                   https://syzkaller.appspot.com/bug?extid=ac0f9c4cc1e034160492
<8>  8       Yes   INFO: task hung in __input_unregister_device (5)
                   https://syzkaller.appspot.com/bug?extid=78e2288f58b881ed3c45
<9>  4       Yes   WARNING in __input_unregister_device
                   https://syzkaller.appspot.com/bug?extid=b03b0fc32e288051502d
<10> 4       Yes   WARNING in input_unregister_device (2)
                   https://syzkaller.appspot.com/bug?extid=617f4ccb03b9869f6494

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

