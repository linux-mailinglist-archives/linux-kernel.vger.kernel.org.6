Return-Path: <linux-kernel+bounces-432806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F189E5088
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1038286F0D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4011D54D8;
	Thu,  5 Dec 2024 09:04:29 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B40E191F60
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 09:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733389469; cv=none; b=eglZ3iIbHIFD3vqnljz5/kKGIYMo672m9kSqGth0Gk6qlmaiIUVi9oblII2FGBsvfr1/XP6PXSTyP1x7a7wpM80UZXqU9F5HgODmOFOXI6XIuPuKYsJloN/05Xfb2eRvPiLJDjLRt35NcKL/Scz85PsWElbWw2kuCU7rLi8VQQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733389469; c=relaxed/simple;
	bh=EQhb6TGrZfYkcOpRdqn/lxXol9nmxg+0ajmsWIkzyuM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=I6nMcvA7I0EttqU/+1dHuhfFPsz4OOqO5ZWvT9pnpimVOuScE3ivKYU4ttEnLMhi8tjFcE6ws4/j/H4gOwDU4Xuv/5+wlhSy2vQwtiTGeMebW7NzCA2KYV6bO1EoObb+CB/m9YRh3ck/qV2DY1oPCL2E1rWAiixaiiiNAalq5FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a7e39b48a2so15081435ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 01:04:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733389466; x=1733994266;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KHXZaowWSdlvsGcGTREz+UJbqIy1FIWlv6vHNKmb8UE=;
        b=jNguWVn6a9qtXL76ue82aS3LPquEvvHKR591vzqe90OD8qZcn26RMNAZLcnkgvxdRa
         Z/87wUWgcoSopBtLG0iPgEzvCO8clqkaOf1qotfodcfGXJjN16EBFqhxXSamZxC625Jt
         TVNRCp3FPe481lOqkFviKiEZ2Tv9niMFjoZPOo/4gv6BrlRc2Jqfu4wC2CGtV3rD9kne
         ceqr/ER4mSVaBZzu4APzcKQbNmpuWBWyOXgObTOaZwkNSZFwWsH9SZ9EztSkR23Xf5Ei
         KuIsGhvWx0q/SSD+kXXbOUr2zshO4Gg7BHvdQOPJPgD8+UOue2hOV0h1kPRaAlnpMicq
         H+yg==
X-Forwarded-Encrypted: i=1; AJvYcCXuQhEuCs6JhY99x0SGZdinycOZhFCZQdg79MHBZTCgKMsLKQHT+rXO/qgHf4mBe06KDUXQUHu8CN+oaPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYhYArgIzledniuRuKiL53Unh0/FAuNPw2Ae76c1Ft3AQO+6e4
	Be2N2yk4OnymVNAMz7rh/wVnZp37kwrI7VfaXPT/6vlFOqMM7s7KbRDvxrCFw9YoEYNYtrtXIZ/
	aHkb0eomDrwQRip6GVdjZl/jk/fsXfBEnBEZja2Aokuu5clAPVUDiiZ4=
X-Google-Smtp-Source: AGHT+IFhAKlhuZu7yThWGfVrufIBKwl6bloyeYgsdPkO+TTRBg0M1WWgpSf1r0/z5/FRHVxBFdVUxnW5OZsuyJQqWcFvIOcRYShE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c0e:b0:3a7:159d:2dd8 with SMTP id
 e9e14a558f8ab-3a7f9a3b435mr114740365ab.7.1733389466600; Thu, 05 Dec 2024
 01:04:26 -0800 (PST)
Date: Thu, 05 Dec 2024 01:04:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67516c9a.050a0220.17bd51.008e.GAE@google.com>
Subject: [syzbot] Monthly input report (Dec 2024)
From: syzbot <syzbot+list8cb80ffc769f03e3d563@syzkaller.appspotmail.com>
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello input maintainers/developers,

This is a 31-day syzbot report for the input subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/input

During the period, 1 new issues were detected and 0 were fixed.
In total, 22 issues are still open and 57 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  917     No    possible deadlock in evdev_pass_values (2)
                   https://syzkaller.appspot.com/bug?extid=13d3cb2a3dc61e6092f5
<2>  677     Yes   WARNING in cm109_urb_irq_callback/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=2d6d691af5ab4b7e66df
<3>  400     Yes   INFO: task hung in uhid_char_release
                   https://syzkaller.appspot.com/bug?extid=8fe2d362af0e1cba8735
<4>  183     No    possible deadlock in __input_unregister_device
                   https://syzkaller.appspot.com/bug?extid=3f4bf5c599ee9b16d704
<5>  160     Yes   KASAN: stack-out-of-bounds Read in sched_show_task
                   https://syzkaller.appspot.com/bug?extid=8d2757d62d403b2d9275
<6>  157     Yes   INFO: rcu detected stall in x64_sys_call
                   https://syzkaller.appspot.com/bug?extid=65203730e781d98f23a0
<7>  49      No    possible deadlock in hid_hw_open
                   https://syzkaller.appspot.com/bug?extid=2313ca2498b9554beeba
<8>  22      Yes   possible deadlock in uinput_request_submit
                   https://syzkaller.appspot.com/bug?extid=159077b1355b8cd72757
<9>  5       Yes   WARNING in bcm5974_start_traffic/usb_submit_urb (2)
                   https://syzkaller.appspot.com/bug?extid=b064b5599f18f7ebb1e1
<10> 4       No    UBSAN: shift-out-of-bounds in s32ton
                   https://syzkaller.appspot.com/bug?extid=3fa2af55f15bd21cada9

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

