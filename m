Return-Path: <linux-kernel+bounces-516829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD7EA377EC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 22:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46061188EE8F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 21:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189081A38E1;
	Sun, 16 Feb 2025 21:54:27 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BF1187342
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 21:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739742866; cv=none; b=ApqiHeF8eDP+B6WFIsi/Og3PhDaRnsTqa4qvqfBevTKrPrY/Z1HoB1ObYJ66DrPETIcjzOb5aUnGUx9MaMMgL/wrCujuMUzGqjZoviZto8lGtDfevPiJrijigBn1x7YKe+Ppa9lGTNj5nNFGyzXDoyPL+Sr9D/+je2RNC2CCxo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739742866; c=relaxed/simple;
	bh=4/xXUEqWiS6QTpoWo763VQ0tfwjsObOYl8I5SvlAeAQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JuP/5bD9o8lAFKQjsgD2jBut8de7vNwlzvnoYvutZcBkFk2x39Zkx1nyQBkh1gKEVxzhisqTOgk/xk9c/h2yRDXKyFyIwrtk5+/PD+uAgBCg86mlFUSF964CWJwU6SLnV+y8XEofs5+pShsjGrGOJA4vmLHDwQ14Jf2PLNJJG44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d060cfe752so25265355ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 13:54:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739742864; x=1740347664;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q1Crmy7a9xCm7aNVnKFx6S+jtNEBvsFBDyI15nAmHR4=;
        b=TVSRklupSmKb91Q3JQAnpwGUbbnIynMKRsr/ewBY+SKG02MuMInDNa6CnWyIA8RWbW
         DArilL275uax2xC9Gx/joM8axXrZFo5jV9lO/dH9l7Q+q6k9BKFvCLMBAKiu7Cz+aWds
         3vrvEWhX6K9B7iGtodA87i4h6baG5Y1X+PnOaFEKW9LsyfWm4m4vy1Hvl7DSP8OwjJ6C
         xoyA58vqsEifXQ76Uqa2bpDPDxDVcjxRF1fEI7Wx97Jxj9QUzzvmcboraRGdDWUIZkCm
         wlB9mTj+uKtfQpjmxHxD18i392a8GsZDQZJ7AkMt0fl4uv+NN4NCWtQZMNmQ3E63Xa1Y
         dYoA==
X-Forwarded-Encrypted: i=1; AJvYcCXHorTavGoaIBlqezVgelWGk1oHJQbTJ8idyZOG7+sbK+KLokmd0ujVJZ+ILL1Qck5ugjdKy6oEbwiMd/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzcPaJakQbQLRpQ2XdeJLPtLnb0AqslQT1NYJcF4PZQZWOrGZW
	qCb7Jo9DfgPirBE2+emOlNl8TOUy1V2yz7UjW/J4L7+jzt2vU34x4E47NgAVb40T+ao7KA/d5qR
	mKq6yUgO9/fiIPbRAfoJl25y5qgR0ze3WGwuSnl7CCpFcjz/Sbic1sgw=
X-Google-Smtp-Source: AGHT+IFWVgiMNeI/LpE8gPYhVODsF0vL+ntVc/J8CXPK5k4/dc2Q23Zoi53UKLhRFBRBtLWOCeQ6fTGDCy/qQF0krAEEvRWO7SFW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4d:b0:3d1:97e1:cbac with SMTP id
 e9e14a558f8ab-3d2807b04afmr55494265ab.11.1739742864275; Sun, 16 Feb 2025
 13:54:24 -0800 (PST)
Date: Sun, 16 Feb 2025 13:54:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b25e90.050a0220.173698.0019.GAE@google.com>
Subject: [syzbot] Monthly jfs report (Feb 2025)
From: syzbot <syzbot+list15fe4be5a738b4c9a456@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello jfs maintainers/developers,

This is a 31-day syzbot report for the jfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/jfs

During the period, 2 new issues were detected and 0 were fixed.
In total, 52 issues are still open and 51 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  34280   Yes   kernel BUG in jfs_evict_inode
                   https://syzkaller.appspot.com/bug?extid=9c0c58ea2e4887ab502e
<2>  18855   Yes   kernel BUG in txUnlock
                   https://syzkaller.appspot.com/bug?extid=a63afa301d1258d09267
<3>  13371   Yes   WARNING in dbAdjTree
                   https://syzkaller.appspot.com/bug?extid=ab18fa9c959320611727
<4>  5489    Yes   general protection fault in lmLogSync (2)
                   https://syzkaller.appspot.com/bug?extid=e14b1036481911ae4d77
<5>  3113    Yes   kernel BUG in dbFindLeaf
                   https://syzkaller.appspot.com/bug?extid=dcea2548c903300a400e
<6>  3027    Yes   INFO: task hung in lock_metapage
                   https://syzkaller.appspot.com/bug?extid=1d84a1682e4673d5c4fb
<7>  2950    Yes   KASAN: user-memory-access Write in __destroy_inode
                   https://syzkaller.appspot.com/bug?extid=dcc068159182a4c31ca3
<8>  2266    Yes   general protection fault in write_special_inodes
                   https://syzkaller.appspot.com/bug?extid=c732e285f8fc38d15916
<9>  1586    Yes   INFO: trying to register non-static key in txEnd (2)
                   https://syzkaller.appspot.com/bug?extid=5b27962d84feb4acb5c1
<10> 1519    Yes   general protection fault in jfs_flush_journal
                   https://syzkaller.appspot.com/bug?extid=194bfe3476f96782c0b6

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

