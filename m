Return-Path: <linux-kernel+bounces-432835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C12F9E50E5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DDCE160E56
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0181D54D6;
	Thu,  5 Dec 2024 09:08:30 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589E217B506
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 09:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733389709; cv=none; b=acV4/0GOYrPrXGx77/LYIiqTgBgHSDNVhHQiPEwnBI6CDlv2HGMy7XjnI6/6jpcz4t8FBP8LICpuxReyf5TASVgSJ6bYytvStewG12r5FkGf33j7EqdbaRco+AEIpeVyMnpaHgSGo/ElhECFZBIkvkee9tjh/GD7dexzL26pe0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733389709; c=relaxed/simple;
	bh=llFR7118dKZ4MLn6ZJ/e2Mm8bz2s3I1Mprl4MGUjl5c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=f7yplk4SpEgJmMcPg6f5e8lnwXYM0F4BcHIh/TN29M73KmtM6QT1z4zfmubNy5eigeXAFoMIHD8ZPG6BfbZTt+WQz86FqS462z4XqLCPuoVagY0ZHiECk8QYA88iOmx1TlaPxBq8NIbdFmDuHZKJTUXv4Dbu65ffOWRM+wdY1zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a7a5031e75so5974495ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 01:08:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733389707; x=1733994507;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LOb5bRCTs7fB0tNDMCyTrFEpjY3yj4VUPsI90sOxb2A=;
        b=RLtr+FRlcdHGYqRzil+E89X8dgLqzwPjhnUNKOeywYL9vcas91gYwk/gOEfUydiScS
         54udV5nkD8fFma5xEgWh7/0SMyOE/14GG6OIiau7dinUAVZI3NcVmLv5TgaAqsoSkPma
         d3zFDqIxEUAGlKueM+SH8LAnFI+5uw0jeXDauX/cmlVNOBLN7u/9iiLw1OjaBJIJh0Gv
         kX8rWdhN1D6XpD5Q9F/4m8T5NxnuM+YtZcDM5X7t9BldfjD7XCGIrMOEidLAhpJhAR94
         NaLLSxnXjNt+p7SpmDNEjr9BBZ1holf5sTT9INETsIsTwYOM5kl3FyS4RYAjo0oedubG
         dYVg==
X-Forwarded-Encrypted: i=1; AJvYcCUWNpB1+V/CR5qM9H+Y8gOcAZQJO6lT3cl+PbX0n/6h3r8UNdKGS7KOTmj9IOMj9t5oLFrRaSEg78O7tPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXsRB6tMzwqpietkWLnGoy+j6Lo9nOL/RCPcXxUPUixOTeM1EV
	I9dSTVz9xTwbM492zZPzJz5u6H8ZJoMJ9zBGthGzT4Zp5Eugu32J/qzAvkgGhHXcyx2rrO4iqdL
	klM3ISNy+1ah/lf7A0ktdLzjEyg+aFR17LW6OZsJwKAqhoteBHBVj8Nk=
X-Google-Smtp-Source: AGHT+IGFvIah2BIE67hHqF9MlPPOwhy/w8UaViJ0teMog5nkys7YJXsLbRsV5l6JsV1JrUo7cTM2I2RjWjCRULRGGSwntd5zJKkB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164f:b0:3a6:ac4e:264a with SMTP id
 e9e14a558f8ab-3a7f9a46431mr112676745ab.10.1733389707494; Thu, 05 Dec 2024
 01:08:27 -0800 (PST)
Date: Thu, 05 Dec 2024 01:08:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67516d8b.050a0220.17bd51.0092.GAE@google.com>
Subject: [syzbot] Monthly arm report (Dec 2024)
From: syzbot <syzbot+list5853008af9f104a9355f@syzkaller.appspotmail.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello arm maintainers/developers,

This is a 31-day syzbot report for the arm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/arm

During the period, 0 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 5 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 3448    Yes   BUG: bad usercopy in fpa_set
                  https://syzkaller.appspot.com/bug?extid=cb76c2983557a07cdb14
<2> 817     Yes   BUG: unable to handle kernel paging request in trans_pgd_create_copy
                  https://syzkaller.appspot.com/bug?extid=2d1f5a94167d430a3bd7
<3> 123     No    WARNING in delayed_work_timer_fn
                  https://syzkaller.appspot.com/bug?extid=e13e654d315d4da1277c

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

