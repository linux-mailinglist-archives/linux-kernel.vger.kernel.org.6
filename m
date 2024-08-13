Return-Path: <linux-kernel+bounces-284846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2237A9505D7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D734DB29124
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCCD19AD87;
	Tue, 13 Aug 2024 13:00:24 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1C14C8C
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 13:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723554024; cv=none; b=HTpT+Sa6ebj7j8VmuuMhSh4JDa4Yl78GZaUAVwKPYGOhPUmpHrYXfvb0lJJ/rhBy3uMeJhzmDmP7s8nTyKTTGMfKpUQgC0P5XfK317TRYRkn0KlLUsJFA4Ev2rgZydZDHs+nf1yl0aAYNVDGbRokd6P0OitpZdq6q6AAxWUDyZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723554024; c=relaxed/simple;
	bh=BsqWnXde4RM7d9XpIAupZ8mD2dSE0K6SOKl+3d/KV90=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Kv3yV4A9egdRx1JX2n/TCngVce4mMPIJxogAXTRSAiibS4K6WUbOswz147a52Uts4XqjIMj9slVyZ9tPZCP/CQ1/pDZAvOHou/S50cUYpM+UEVq3bVwvb6E6j0gwr/OqdbEynS6ka9bCoFVeEd+dfr+u5fvFcHdSviCUuTrgTss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-824d69be8f7so34284339f.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 06:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723554022; x=1724158822;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VruzWptRfX9xkAt0mRXgwQuQYUayBdmZKx68o6q5KFI=;
        b=SZOxZ5MWHO/XGr7C6UuO6tLvBrlYbovx9E7ZazmzaSWnPo9QGN+tQlzUiI7SDBsuJ5
         EBSvLv+NkkWvPZ5f7whdNDd6wXcs7r0IN/Fo/N/3KCpE7q2PuQrRqAAknwL0vL72v2AH
         qSSovUrGax2hXxRtRWMG0LvD3CRCxuFhSi9GQB2ve8153OT8sJcmOn5vhNDVncfzmNZQ
         3Gx5A+5LPrL5coHZmp0iHv6E1wqecA+t9IYyQ4RkSeuYjAeJlVSGrYYztEGZEXYwVdVD
         pILJ6IJZhuYJEdOBbMlz7fKUEBDffRVCcipiqjYwqegio9VGrTxWqAUljawaiODq9os3
         fZFQ==
X-Gm-Message-State: AOJu0YzhctPF5t1AzFTyeOEIPEr275fujUV3pqBmXWItrUxvC4JJmuhV
	C/i2nTue7KZZzrsYCroEMaQOn4/v6w/7ycLGHT4l8Ss2hl/iVMYtkYlFql88U5mZHP3HXnjgs8n
	GKfVHYsIQdFpBjwQSjT8EtuYyp5IQNGfTicIqzVrGikuV2rWR+ZWkRJE=
X-Google-Smtp-Source: AGHT+IFAGCSI2iBaoAoBwtITY7gmxZpjQ0s6Ac4RJRs19SwK/kIjhtzkyLMtd0cHz1379e6wlOPuF8LiuTPBWkIwP347bdSSyx16
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:264b:b0:4bd:4861:d7f8 with SMTP id
 8926c6da1cb9f-4ca9f8229admr214000173.4.1723554021869; Tue, 13 Aug 2024
 06:00:21 -0700 (PDT)
Date: Tue, 13 Aug 2024 06:00:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000399a37061f90311c@google.com>
Subject: [syzbot] Monthly usb report (Aug 2024)
From: syzbot <syzbot+list8d0849f955e749430552@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello usb maintainers/developers,

This is a 31-day syzbot report for the usb subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/usb

During the period, 10 new issues were detected and 1 were fixed.
In total, 78 issues are still open and 348 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  874     Yes   general protection fault in ir_raw_event_store_with_filter
                   https://syzkaller.appspot.com/bug?extid=34008406ee9a31b13c73
<2>  867     Yes   INFO: rcu detected stall in hub_event
                   https://syzkaller.appspot.com/bug?extid=ec5f884c4a135aa0dbb9
<3>  862     Yes   INFO: task hung in usb_get_descriptor (2)
                   https://syzkaller.appspot.com/bug?extid=e8db9d9e65feff8fa471
<4>  814     Yes   INFO: task hung in usbdev_open (2)
                   https://syzkaller.appspot.com/bug?extid=b73659f5bb96fac34820
<5>  650     Yes   INFO: task hung in hub_port_init (3)
                   https://syzkaller.appspot.com/bug?extid=b6f11035e572f08bc20f
<6>  589     Yes   WARNING in ath6kl_bmi_get_target_info (2)
                   https://syzkaller.appspot.com/bug?extid=92c6dd14aaa230be6855
<7>  527     Yes   KASAN: slab-use-after-free Read in hdm_disconnect
                   https://syzkaller.appspot.com/bug?extid=916742d5d24f6c254761
<8>  502     Yes   INFO: rcu detected stall in corrupted (4)
                   https://syzkaller.appspot.com/bug?extid=aa7d098bd6fa788fae8e
<9>  437     Yes   INFO: rcu detected stall in syscall_exit_to_user_mode (2)
                   https://syzkaller.appspot.com/bug?extid=a68ef3b1f46bc3aced5c
<10> 423     Yes   INFO: task hung in r871xu_dev_remove
                   https://syzkaller.appspot.com/bug?extid=f39c1dad0b7db49ca4a8

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

