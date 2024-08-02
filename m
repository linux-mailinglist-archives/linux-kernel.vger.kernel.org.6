Return-Path: <linux-kernel+bounces-272211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 220339458AF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 09:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DDBF1C23915
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 07:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E8F1C0DCF;
	Fri,  2 Aug 2024 07:26:30 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE3633991
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 07:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722583589; cv=none; b=GTOF6CZ+G58+FC4oPF75vjPVnPkF8BBymGxkNdHkq/77/OZm6yFr2fNzql8poy5n7SHLrKoRgYndZYvVm8/RUH+nPgL3qFANvdLImM/aKHEYuhPpbJsyNsm5qZokwl5s1NhXlWiVWz7Y8ggW0IXqWBsnpW5rdUVPfB16gby+ft8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722583589; c=relaxed/simple;
	bh=Oxm/pfSsuLOgexnoccmfnLZAlQbLWyVX1uliw0z/UC8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cIAzK7ZdGQl3zTykfRdXwC9GIokVSmcFxnUA8O5PzKzJ5apwIhM5DAj8C6XTEnKgmlZbiygHTGy/I0OY6OAVaV86LFXUaHS5S9PaPTYzT6t/x+tXJ9CfYaZ05C5o2lKO4OFKnZTAIp2de+yF2yUq5z5r319q4p3sjvQSdOzWmIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39835205d20so148366945ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 00:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722583587; x=1723188387;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BCr9LnPSoHkIK4J/GpkYOT3P7xvLGVBQAKEbbV6/rSI=;
        b=nutpL5h8kOBA1DvakeeZRg+qtgBVb907wS+QAJqvigbY4GkHLKYcsDqYPJipgQH2iZ
         EHhMXlkXFdnT8r8vfoQB2vRfX0BXHAubWgSjT3ms7+EClJQf/ATN4noceaDAjK/8c1nd
         ULfoiTBfocBmUp/Ur7stdqnsMbugKzi4XHI39zqUNTJWQY2l204Hnxh7jz/lroRwQ/Ly
         uXe5+PqIOMv4bW6ndewrgApVS33hQkJ2R9d137ePGhNxBfXVXtBtsmz3EHkELaCx6K5V
         NkS7GMMfoWLb57yFvOl3+6wbLgA8vn9OCX45VmqGqcOaYw/tZ1ZybT3WDQFGO5yAOCac
         TV7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWOC2FI6YRE310Y4k2gyd+tEvgJCMJTnUFFpnjJWQdKl8MKQHdgsnlHPx5WqoRZrozmiZ+OYcHVOxFcAHQxzWKZeuV0LXZGLtClhYec
X-Gm-Message-State: AOJu0YxjbBcyGs7O3OrnF/5yI7va9WekndgBgNP90HU5eTI8r9rUq0LV
	6g0PE/SbFU61QEGpAcV5DdWVHsN4HAUEjs8C8lx2TF21/5NN/jWs69QVM6AMRRlMTFOhlFKWuDt
	Ik98uCbdd3sVs/aVU3EhjBzKSHegeISvSnt3M56KHYysmByzOOSIhjsM=
X-Google-Smtp-Source: AGHT+IG+3+ysEdazJDjhmIN2EU+CswIpTEaa+h2llnHNpHqurWiCjI9rJ+YFuw5B1Y44ucmrbPztL27jYkvUAfnLWzIG29UHgVFq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214b:b0:39a:ea86:12f2 with SMTP id
 e9e14a558f8ab-39b1fca07c2mr2396255ab.6.1722583587405; Fri, 02 Aug 2024
 00:26:27 -0700 (PDT)
Date: Fri, 02 Aug 2024 00:26:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d2ce01061eae3e22@google.com>
Subject: [syzbot] Monthly input report (Aug 2024)
From: syzbot <syzbot+list9ef74d105b31e667593b@syzkaller.appspotmail.com>
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello input maintainers/developers,

This is a 31-day syzbot report for the input subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/input

During the period, 1 new issues were detected and 1 were fixed.
In total, 19 issues are still open and 56 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 685     No    possible deadlock in evdev_pass_values (2)
                  https://syzkaller.appspot.com/bug?extid=13d3cb2a3dc61e6092f5
<2> 389     Yes   INFO: task hung in uhid_char_release
                  https://syzkaller.appspot.com/bug?extid=8fe2d362af0e1cba8735
<3> 326     Yes   WARNING in cm109_urb_irq_callback/usb_submit_urb
                  https://syzkaller.appspot.com/bug?extid=2d6d691af5ab4b7e66df
<4> 21      Yes   possible deadlock in uinput_request_submit
                  https://syzkaller.appspot.com/bug?extid=159077b1355b8cd72757
<5> 19      Yes   WARNING in cm109_input_open/usb_submit_urb (3)
                  https://syzkaller.appspot.com/bug?extid=ac0f9c4cc1e034160492
<6> 2       Yes   INFO: rcu detected stall in asm_exc_page_fault
                  https://syzkaller.appspot.com/bug?extid=360faf5c01a5be55581d
<7> 2       Yes   WARNING in bcm5974_start_traffic/usb_submit_urb (2)
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

