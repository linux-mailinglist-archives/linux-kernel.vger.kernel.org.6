Return-Path: <linux-kernel+bounces-310812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6718A968181
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFD01B209B6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E9E17A5BD;
	Mon,  2 Sep 2024 08:17:23 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59042032A
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725265043; cv=none; b=vGuS1f30dl50JLdp0Laa1G53ZgVjrOQIXlIfs4+MdyKMK/mKLhCpuDplzCZ6bI6f7VIJsWW1nMHOjt42veP/aupx462QQPOBKUO+on26LJ9o5Z4Rrchj9u6ZB9EEdAfdaui4a+Xz25/pj6Zim/zQN1GrlJxpgK9WE5jiGKRJP88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725265043; c=relaxed/simple;
	bh=IRTJHVYUzlZ9RvtWow2fn+GIAETMjVyYAVFQqMO2Jgk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=e11cRf6yEhttZXrztyAVZRviE+ADL2HzB/KBcLW++8Bx2GnCpyAmcJ+UMybSd1IYc2RD4kxc/xe04GI08YhKLNiHmktRTcVxHTQcFh7V81M2b3Z0ZC3iFn3R1dwNsNHPpcJ78JrOr4WyGzYGzr2P3gw+fICg9nGQVUHI2y77Opc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39d5101012eso47884715ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 01:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725265041; x=1725869841;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2sns7FwWpwK54OmxtXlX+1DBcBpWQtZaZin2PDIL4+0=;
        b=sIVFrzWW4tZJJjNY1BGh16uPKGVDkOGMc8sBoTxT1x8rldI8aHIIPGS1gyYVGWcs7S
         lzRxFEK0eN12Uf3qUejWTvk+jeOUn5nAnS/T28AGI2RXGiy6HJrPT8HcfVSMjmGBJL0j
         Q+4m43+jN0Vt+pWLbyQJLQZ9AhF3C0wc1QuYbB4FtXHuXIxcyMYOIhEQzGFsygEzp8ae
         4pST4Wi89gbkAlsS1d0eHEMWUuvbyxbW11r7x4g+N3+LnKKsOWAzQxWmm4+7iqelLwY7
         lecKqQWqCMur4Ed3dBjccb6EWDstz62ZOYAlUPMaSGSOuFGceyyj3NRgELieH2MuJD1o
         +z0w==
X-Forwarded-Encrypted: i=1; AJvYcCVLqFE6bse1CJ59oaEQt4GSHmGsev54PQ6WJ41ubFJzwJ3bmVUSg2/HczuBOYT1SPYRTO/UGGFio4rzEm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR2g0flfHy7Ax8o8mt0bM5l8BHjuy7DI9nASHQZJ+1Ry3Q57A1
	gnmxhlCIeoV5n6/PxY8Ix8fkukntAEYw576CxdaMbRGruBLGxSxluTAQ4sYnGvWKP0MoW6paIKM
	CHT+pYoTIwsimyEUTzsyXbkjB9ZZkvddDFkMZzu4xZ/SWOgduWw3rvt4=
X-Google-Smtp-Source: AGHT+IGbwOCsNT+/J0+VefbIlcQy4+aRzLa3+CQCPb/6igbcthkuqiPhcsqwpBWr6e16Rf1yZ4MtiBXaLjNbXVhny5tNaffBanRZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e09:b0:39d:637f:97cf with SMTP id
 e9e14a558f8ab-39f40ef46b7mr6736105ab.1.1725265040927; Mon, 02 Sep 2024
 01:17:20 -0700 (PDT)
Date: Mon, 02 Sep 2024 01:17:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e882a306211e9197@google.com>
Subject: [syzbot] Monthly input report (Sep 2024)
From: syzbot <syzbot+list404de26cc86aa8de7c97@syzkaller.appspotmail.com>
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello input maintainers/developers,

This is a 31-day syzbot report for the input subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/input

During the period, 3 new issues were detected and 0 were fixed.
In total, 18 issues are still open and 57 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 702     No    possible deadlock in evdev_pass_values (2)
                  https://syzkaller.appspot.com/bug?extid=13d3cb2a3dc61e6092f5
<2> 392     Yes   INFO: task hung in uhid_char_release
                  https://syzkaller.appspot.com/bug?extid=8fe2d362af0e1cba8735
<3> 353     Yes   WARNING in cm109_urb_irq_callback/usb_submit_urb
                  https://syzkaller.appspot.com/bug?extid=2d6d691af5ab4b7e66df
<4> 23      Yes   WARNING in cm109_input_open/usb_submit_urb (3)
                  https://syzkaller.appspot.com/bug?extid=ac0f9c4cc1e034160492
<5> 21      Yes   possible deadlock in uinput_request_submit
                  https://syzkaller.appspot.com/bug?extid=159077b1355b8cd72757
<6> 19      No    possible deadlock in __input_unregister_device
                  https://syzkaller.appspot.com/bug?extid=3f4bf5c599ee9b16d704
<7> 10      Yes   INFO: rcu detected stall in sendmsg (4)
                  https://syzkaller.appspot.com/bug?extid=9c0539eda655673bdaa4
<8> 9       No    possible deadlock in hid_hw_open
                  https://syzkaller.appspot.com/bug?extid=2313ca2498b9554beeba
<9> 3       Yes   WARNING in bcm5974_start_traffic/usb_submit_urb (2)
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

