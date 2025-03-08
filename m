Return-Path: <linux-kernel+bounces-552839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDFBA57F45
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 23:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2B3F3AF156
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 22:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EFE1DE4E7;
	Sat,  8 Mar 2025 22:15:34 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449F57346F
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 22:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741472133; cv=none; b=RuMUh+f6DIBDXV+Q8h8HTUTXm6EoIETGbgy7bg7BKRca6S4lazMWuZT+tnxrEtLs0FTwM4LVeSUoWOX+q19qDA4Ucn0HIG2yx2XanM6SHTB2i91c/RZOVMQdLaw4ZPI/OksTNz/13McZkAJUlbW9fC5AI3wGOvKRDRK+t2oIrro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741472133; c=relaxed/simple;
	bh=Kszz8mtYtFrF7gjWM0v3bUUjJRhMTeWiuQRvVwYSURo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Y6osyUSOkml9lc6HKJ2mnDhJ1AQs9pYwHQ8VzfWBtvh6uLjhAE4La+2PIMTX54qlCeQjHT6ey+cMB2QFYYOyNARtBIQhtLUy9hT7EXsKWUeStZLPxcES9q4fPmbJgud8Q+Na+hsDiza7dBA5OibV3Bom4JX9bj4dAjdGg26gRMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3cfb20d74b5so27761195ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 14:15:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741472131; x=1742076931;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UvzKf+sVK4uQBK0HdKndULW1i5XBUawIXSHX2OP03mk=;
        b=Vc7g1H8QMXPubek4oftqThZm+/hd5OBjo409UbBG4ifqS5Qh0n08Oyg8/z31rz6im1
         P1+L1O9cpL3vSjPCRKXFtVsfOL3oUCJz/TGjufDzUCoP+550eIs0E/b3wOPLbC3VAjrG
         8f2BRhM050IpblQqjamGjwaFTs4bLslLLHodHrw15yP//BYbD1XlSzZGqzy7Or4FfnKE
         Ywy701wh7FRbxQEvvg3Z9veZVKrc52k0BNPDxqLd17aZ5LncvTfIcFu427jZ/be+YWQV
         dYC8puNTBzyMwcEzhREQfRQ6Br+3w2pqepUuakb1rgnEXzAi1+z039pVYpaM0l93qzm6
         ceMA==
X-Forwarded-Encrypted: i=1; AJvYcCXt5Q+lh7Opdd+JQVWeZ9sH8YxiHKEe72QClnCckqiTKxa6l2tt4jYfcdXpxOsz53H/QGGXDK3e7al9Ql8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZztgufTzyskW21IASfdENDqNBoOsIQnuJm9uOMZVM1tzV6A1Y
	Mtt77YTO964gYSN2x6xrVRLU2f1vPVyJA0fQsEQgAXq++G2vhdlmaXbLVbHL2LbfUMwAIwVg695
	dKu1YVvcDcO6FXOme4FDqtkT4UshfM245AZPy2JQwK6rfa4ii5w4VfUU=
X-Google-Smtp-Source: AGHT+IGymKYXs5JD65mhonbvS022JZmSRMn3vjWy03XHFTHkqWLV3EZ4P//wd9/WI0yd5ES9yFjUv7LAo8mOhffmdzDSWS69AkEy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa5:b0:3d3:dcc4:a58e with SMTP id
 e9e14a558f8ab-3d44196903cmr101807165ab.8.1741472131422; Sat, 08 Mar 2025
 14:15:31 -0800 (PST)
Date: Sat, 08 Mar 2025 14:15:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ccc183.050a0220.24a339.009c.GAE@google.com>
Subject: [syzbot] Monthly input report (Mar 2025)
From: syzbot <syzbot+list20464a1cac16bade6d05@syzkaller.appspotmail.com>
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello input maintainers/developers,

This is a 31-day syzbot report for the input subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/input

During the period, 1 new issues were detected and 1 were fixed.
In total, 28 issues are still open and 58 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  1412    Yes   WARNING in cm109_urb_irq_callback/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=2d6d691af5ab4b7e66df
<2>  996     No    possible deadlock in evdev_pass_values (2)
                   https://syzkaller.appspot.com/bug?extid=13d3cb2a3dc61e6092f5
<3>  667     Yes   WARNING: ODEBUG bug in release_nodes
                   https://syzkaller.appspot.com/bug?extid=624d9e79ec456915d85d
<4>  631     Yes   WARNING in enable_work
                   https://syzkaller.appspot.com/bug?extid=7053fbd8757fecbbe492
<5>  165     Yes   KASAN: stack-out-of-bounds Read in sched_show_task
                   https://syzkaller.appspot.com/bug?extid=8d2757d62d403b2d9275
<6>  120     Yes   KASAN: slab-out-of-bounds Read in mcp2221_raw_event
                   https://syzkaller.appspot.com/bug?extid=52c1a7d3e5b361ccd346
<7>  47      Yes   WARNING in cm109_input_open/usb_submit_urb (3)
                   https://syzkaller.appspot.com/bug?extid=ac0f9c4cc1e034160492
<8>  35      Yes   possible deadlock in uinput_request_submit
                   https://syzkaller.appspot.com/bug?extid=159077b1355b8cd72757
<9>  18      No    UBSAN: shift-out-of-bounds in s32ton
                   https://syzkaller.appspot.com/bug?extid=3fa2af55f15bd21cada9
<10> 12      Yes   WARNING in bcm5974_start_traffic/usb_submit_urb (2)
                   https://syzkaller.appspot.com/bug?extid=b064b5599f18f7ebb1e1

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

