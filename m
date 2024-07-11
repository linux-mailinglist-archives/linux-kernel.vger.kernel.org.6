Return-Path: <linux-kernel+bounces-248702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B0A92E0DA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC3FC283DDF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 07:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3207814F9E5;
	Thu, 11 Jul 2024 07:30:29 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8B214D283
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 07:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720683028; cv=none; b=I5ZwQp3glhQNVJ/dlI33LqG3f9/xti4+7WYfseOqQIKEHg92QUIRwqrEl9gSRqYKmCu4mpikJ2uQNv2uF/MPrtBdkQxwRvHwqm9yk7a/stnYc2nBjDAAFnt6FwZcgN0BFrDllyIxzUUb6jE84eYdmRUL8ySYWkMfB/Sh4mBqrzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720683028; c=relaxed/simple;
	bh=CT2w5QA35aLjTLwarP/4uLIBR6BEN1ANVUeRxdhmPoo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DmYfg+aD2wUgYoCIG6en29DSh4KyvOgZRB+ViV7SmqBQ8KLzt1kyiOYuRK2HUvC8dD4weIDI3yPrkxeVZsbFHQj5mns9+ss4sk+PcLSvqiaylKDL5WXirzzztBkqiljQbwN+bMPmB7yoZobjXcx+Pchb/ibaSbIaQ4kPeZtwVsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7fdfb3333e5so63349739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 00:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720683026; x=1721287826;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=54aAvm6LePKSlwnTq172Rk/A87OMUsHrkKd5lTJvMzw=;
        b=TtT1yh1MGEdSfai2HPlEG0QeA9T54w1m4s/zZGFJVyj6BhHJ1y/WTPwHBGjFpYmZcw
         v91yWCYcuy3/zCIa66NVZLfo8ceuQ6GqqKiJNtq5y14nGWVGBYavt2mnvPa+rJftvbEM
         doWxgDud9zO1R6A72K2FonwnNlQ/6ex/zl6qcPORXtmLDBIQjJIRX3N7+WcgdCLOzUcP
         x1KHF1jKPurdGuAUB+hIzIhxXwtfIn/rgwA/YwizaIQ73tr7psLfIR40UtsfkvFoKK4O
         o7kK4S+yVr0Fgcs+q+LnSHjxy4kH6vqEQVZlJNeey7VC0qL0gutaRdOhkGe/6SB3++Bh
         DcqA==
X-Gm-Message-State: AOJu0YzYZgljS3JFYm5kzbZYl3AcEHtxiaIUxANomrRMV/gI6QIxsJ16
	etGHFf4+vHKlwQthVADu/XEQVsb/pv6O9QbzVSed1HIVW4IUZwYAUssAJ7pLPiV647nLRnqm7mX
	3L7c6YnGijNBuggYWV+2GICXSfRjxefXYgLvqjFwQGWWF8dXaQUENjtU=
X-Google-Smtp-Source: AGHT+IF/9euBIQ8zE0JKguMDceR5Txqske6VIpLr3rdn5XagQic/P7rQaUz5coAD0DCaNkSKSoUML/Ltyklv+OrBMlhbLdTOadxK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:24d5:b0:4c0:a8a5:81f5 with SMTP id
 8926c6da1cb9f-4c0b2b331c3mr630013173.4.1720683026355; Thu, 11 Jul 2024
 00:30:26 -0700 (PDT)
Date: Thu, 11 Jul 2024 00:30:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008ea816061cf3bc76@google.com>
Subject: [syzbot] Monthly usb report (Jul 2024)
From: syzbot <syzbot+listeb8d66e6043d7c79c774@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello usb maintainers/developers,

This is a 31-day syzbot report for the usb subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/usb

During the period, 2 new issues were detected and 3 were fixed.
In total, 74 issues are still open and 343 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  870     Yes   general protection fault in ir_raw_event_store_with_filter
                   https://syzkaller.appspot.com/bug?extid=34008406ee9a31b13c73
<2>  751     Yes   INFO: task hung in uevent_show
                   https://syzkaller.appspot.com/bug?extid=edd9fe0d3a65b14588d5
<3>  700     Yes   INFO: task hung in usbdev_open (2)
                   https://syzkaller.appspot.com/bug?extid=b73659f5bb96fac34820
<4>  646     Yes   INFO: task hung in hub_port_init (3)
                   https://syzkaller.appspot.com/bug?extid=b6f11035e572f08bc20f
<5>  498     Yes   INFO: rcu detected stall in hub_event
                   https://syzkaller.appspot.com/bug?extid=ec5f884c4a135aa0dbb9
<6>  483     Yes   INFO: rcu detected stall in corrupted (4)
                   https://syzkaller.appspot.com/bug?extid=aa7d098bd6fa788fae8e
<7>  409     Yes   INFO: task hung in r871xu_dev_remove
                   https://syzkaller.appspot.com/bug?extid=f39c1dad0b7db49ca4a8
<8>  377     Yes   INFO: rcu detected stall in syscall_exit_to_user_mode (2)
                   https://syzkaller.appspot.com/bug?extid=a68ef3b1f46bc3aced5c
<9>  304     Yes   KASAN: use-after-free Read in v4l2_fh_init
                   https://syzkaller.appspot.com/bug?extid=c025d34b8eaa54c571b8
<10> 243     Yes   INFO: rcu detected stall in addrconf_rs_timer (6)
                   https://syzkaller.appspot.com/bug?extid=fecf8bd19c1f78edb255

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

