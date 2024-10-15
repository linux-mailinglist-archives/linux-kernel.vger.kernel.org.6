Return-Path: <linux-kernel+bounces-365362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A82699E12F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4093283575
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3280F1CCEDC;
	Tue, 15 Oct 2024 08:33:29 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5070D1C82E6
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 08:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728981208; cv=none; b=KWbooqEym8H4jpftcR2A2kNBaRd+hw4tffWVcx2bDLKyk0hS3TBrCKvT7FvtaBx0PHEbV7k07Sx712rqnVhZiTy6z2sMgvlQp7358mmu6bYN00AMK00Q5i3b03oLm11woMweKyA8X+z+YqXMyP3Gq2uaVEMvfYFCXna81lLQvPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728981208; c=relaxed/simple;
	bh=IFYFgGM3Odbd7g/GlONKnZB16g4OU8N2BUQmoNmX1/Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WXjlun/E8uGdZLBOZVN9h01dTwGl9tdFgMUjfnEQdQNhcPugw+HNgO45lkObzhg2Cfbm7dwj6IWnZSDv3Sz54iONNIKlWFvJnkvb1Aqd7VaJhwrD9reYym+B2BgKuIA+iwfZzz37QF6T8oRg4stegS6UzMbjo5e4lW+3hacu+Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3ba4fcf24so35760105ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728981205; x=1729586005;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R6gVaDSriwF5S9akQhORqAm27YecOFxvdJ7AKvsc18w=;
        b=sJPDmZDcN6hI/Z+vFKO+qcCbgwI4U0LvI0iF3K3g+/cGYn4fnGI+TIlyfV+ktuPxnV
         coGpS0G+lGO9RnxrW36riy2mE2FT0SExUOHNLFw/rmeAcNlYfDEDSX0NwuV6o1khIy/O
         5leKZE3mPoOuKeddQKbv3T8QLLUk2dzXpU4tDQuy0wXXS41iSsMCnLk6rLV8gWR2uOZK
         CvPUCqTxiT47dT/9YInf8psgWFZ11ZjzhzaM5bI8us0aAXJ8OL750iJf2/LcGVH9SC3c
         al/ctpIRjKUjzakA/QmVG/5KsohRm8KwBYNkslqR+yi+8SoXjNy984XiiDoDZ0imAwmV
         uTgA==
X-Gm-Message-State: AOJu0Yx7EuErfr8d7+c8WRzhO5b6xWCx3sWABWv7A9IvNQp4yNOREFH4
	HrlraM6d88xlrrmLaYXr1Fow6RBeF+qkPxhUlJcyH9xN+F+ttVdCJfMVRnDhzODBAL7RIJURWJ/
	GQrGE8D8YaMYaIDLUdAWEc4HCZKbFc4gchxe7ewf63BtKHfCYqsulOWo=
X-Google-Smtp-Source: AGHT+IEORFQpPPxNbNTUlO8T10ipbkVE6iPIvUK7JpxTN8XQMmau24jR5XiLTVQAI90UXX7g+yde1bySx4kZDR+VJH80pYA7gl+Q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16cf:b0:3a0:8edc:d133 with SMTP id
 e9e14a558f8ab-3a3b5f94601mr122862275ab.9.1728981205423; Tue, 15 Oct 2024
 01:33:25 -0700 (PDT)
Date: Tue, 15 Oct 2024 01:33:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670e28d5.050a0220.f16b.0008.GAE@google.com>
Subject: [syzbot] Monthly usb report (Oct 2024)
From: syzbot <syzbot+listba1ecd1770f23c38128a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello usb maintainers/developers,

This is a 31-day syzbot report for the usb subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/usb

During the period, 13 new issues were detected and 0 were fixed.
In total, 92 issues are still open and 357 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  8249    Yes   KASAN: slab-use-after-free Read in hdm_disconnect
                   https://syzkaller.appspot.com/bug?extid=916742d5d24f6c254761
<2>  4105    Yes   KMSAN: uninit-value in dib3000mb_attach (2)
                   https://syzkaller.appspot.com/bug?extid=c88fc0ebe0d5935c70da
<3>  1286    Yes   INFO: task hung in jbd2_journal_commit_transaction (5)
                   https://syzkaller.appspot.com/bug?extid=3071bdd0a9953bc0d177
<4>  1138    Yes   INFO: rcu detected stall in hub_event
                   https://syzkaller.appspot.com/bug?extid=ec5f884c4a135aa0dbb9
<5>  881     Yes   INFO: task hung in usbdev_open (2)
                   https://syzkaller.appspot.com/bug?extid=b73659f5bb96fac34820
<6>  874     Yes   general protection fault in ir_raw_event_store_with_filter
                   https://syzkaller.appspot.com/bug?extid=34008406ee9a31b13c73
<7>  862     Yes   INFO: task hung in usb_get_descriptor (2)
                   https://syzkaller.appspot.com/bug?extid=e8db9d9e65feff8fa471
<8>  807     Yes   KASAN: invalid-free in dev_free
                   https://syzkaller.appspot.com/bug?extid=3e563d99e70973c0755c
<9>  656     Yes   INFO: task hung in hub_port_init (3)
                   https://syzkaller.appspot.com/bug?extid=b6f11035e572f08bc20f
<10> 652     Yes   KASAN: use-after-free Read in v4l2_fh_init
                   https://syzkaller.appspot.com/bug?extid=c025d34b8eaa54c571b8

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

