Return-Path: <linux-kernel+bounces-284385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4815E950066
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04AC1285048
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1FA17B421;
	Tue, 13 Aug 2024 08:52:32 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9700C14EC59
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723539152; cv=none; b=JeVXb8wEEYW0XplJuzyN9Ee/ah3vh/jWc2oHS44PSx3o9hFJS1H4EWEzYPJuAcBHxj+afvMAcga8FbiBJyl4iqSfrEXRDXkdSxIRFK6PJ6SaRWvs452cQ+XqaItDZkZL5wBoVPHE+sIZWQ7QzB+ZrJmaeGtP8F/wExs6xbmy8aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723539152; c=relaxed/simple;
	bh=+Bcb6kT/l2Wr3hUWpbLYOMKyWvb3o/8lV+uOqYxaksI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VuJSxOu2TKgYF1O60OlsUVOo7mmshXG60mHdjjgi9ZcA4o56RFT7ZVhrMCUnVJuwC7nrEY+j1PflPxgD/JTY+66216fwvxsIc88wONKwcwaKa93pQ7J44se1Zwqd7OWihdlByQL+LAIqAwKaDG8hsmE5w1Pue34gaXULN0UtS3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39915b8e08dso75657805ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 01:52:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723539150; x=1724143950;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1M4yZgZM5ECQ9txdRioj02m3GqqcYjRV1W6THARg06I=;
        b=MPtb4yl1+nYne4etbv3U7XClsNz1Xpm+n5QT710+a9nTeH1T5jhvUHUiSaS1xtpyN4
         ZTaOGixZwdfyvExmT7GXjj6MR18M0RoCmHb2F/+nOjkCCBydu6ttxWcEBAxpWm8NJ1Uu
         qQSfKJCx1KkNnKTfHdEKPIppS3HP4WTSOVdnQLp5iCIsCypHfZnKu5fnTc+5OLKHrNr8
         bWt4OiP6g/azQkgI2rJthUtvHofsMCWIE+Zn4BPDK0ngVjRR98HWfhYWFSGlswos6fXX
         MCByPULk7AvA2SP976qBBB+zv/UStc5HqYj5BIv3L8t9ztqw4g8lPXHWlLjDrPIeEKSg
         KfDw==
X-Forwarded-Encrypted: i=1; AJvYcCVmW2RIUq+oWbUtmwU25MGbQw47BzEIwUlNNefeckDaio8hX6N86z4NjHg574U47nAuRJzoSxR/b6aZ7Os=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0SzNLZAvQwczLuzsFfSaKG+vvPgLldXcQ8ptSLow6Qq78AFsv
	zmFx2QxwPevsFKpcQU6+WReuVPkGOIes/p3wzqxg2fYQv5AkY4Wd6zP/8zlhUKUPaxxX68L7k70
	ne6qJJNMtgs9a7a4HjcjlSDgOFH+TEvYd50mBIuTw4mmwnVHGPe6/mec=
X-Google-Smtp-Source: AGHT+IFfTNImxWMbZM+Pv1Wbn2yHaBKHKtF6QkwAUOtHkkrR7ePkWDuEDg/w2rtuNeuVCzVS63WUHXQIJ11y0A8LXBwKfXTq+hpG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c565:0:b0:375:a55e:f5fc with SMTP id
 e9e14a558f8ab-39c477c14f5mr2134065ab.1.1723539149773; Tue, 13 Aug 2024
 01:52:29 -0700 (PDT)
Date: Tue, 13 Aug 2024 01:52:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c76df0061f8cba62@google.com>
Subject: [syzbot] Monthly hams report (Aug 2024)
From: syzbot <syzbot+list1dc52af7778b04ad1d14@syzkaller.appspotmail.com>
To: linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hams maintainers/developers,

This is a 31-day syzbot report for the hams subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hams

During the period, 0 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 35 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 270     Yes   WARNING: refcount bug in ax25_release (3)
                  https://syzkaller.appspot.com/bug?extid=33841dc6aa3e1d86b78a
<2> 257     Yes   KMSAN: uninit-value in ax25cmp (3)
                  https://syzkaller.appspot.com/bug?extid=74161d266475935e9c5d
<3> 32      No    possible deadlock in serial8250_handle_irq
                  https://syzkaller.appspot.com/bug?extid=5fd749c74105b0e1b302
<4> 20      No    KASAN: slab-use-after-free Read in rose_get_neigh
                  https://syzkaller.appspot.com/bug?extid=e04e2c007ba2c80476cb
<5> 9       Yes   KMSAN: uninit-value in nr_route_frame
                  https://syzkaller.appspot.com/bug?extid=f770ce3566e60e5573ac

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

