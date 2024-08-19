Return-Path: <linux-kernel+bounces-291617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D50A49564CF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 09:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78CFF1F22C39
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 07:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A9C158532;
	Mon, 19 Aug 2024 07:39:22 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B905115749C
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 07:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724053162; cv=none; b=LbI/wcu2orP9jiz7bN6pnga0HO1i6snhDEsszuxjBJVoYQiFosm3wHH84XAa2t8fkVeQ/aYOlF3gPFTeSdOyUYA/NFh6FyQTHxf1EwtB8OTMjXeabYo69qRrQfJMw6ogV9W/+WnW6tG4BaNTw2KtGtSF17WhktdIBf2uDdamcZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724053162; c=relaxed/simple;
	bh=QC/eCvIe4Z0WaYM7c3KqLyuSj5z7rbLREK4iVQViOpg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GDr5GZTNgCfeSe38uUcj8HGaUSr38rjWXgrVaa4PU1mDHBwzJza/q/stv05NkNV2vkGTwKZcKmnonZB7bXGjomBmzFq0b5R3F/ipcult6V/ahSEbkzmjR94TyPhUoI1OSxOj0ql/glE/VpwKZCyiVaGiVWznvcCT7BZVbhg/fx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f8d1720ebso390124639f.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 00:39:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724053160; x=1724657960;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TTfnb67k22MLpM3A85hXVfpyRYO3HcoiSS4BqkZT7R4=;
        b=Op/sDlLERmhQGwWhmnmAyaJtJkaccDBzbQ67Z+ALxwc4bHYGmYjepnMlMAxseMHhFL
         FYKuvEm4m0xWpTBNqtWezXuMhjRJoGT36Fe1O2z2twdQjBr+SvQeRaQW0ZnPSml+9yyQ
         jMsh0p9gUZM9+nxnnDpgGpyOEpzgjITY75MxhmRJchnpJ1mbw15wzzb2tDkow0m6Tc4D
         lTQY/gPKWhTXxsKRknwW17VlFKLKwDVBTSzKT7H7kbTjcUP31avt8iIa1mR91gZ3cdpy
         oirF1PGgWj7YXsrd47lZUbGCNEitJZi/MO9tiyFdTSG+MkzKwuTXrO2QX3skQ07yDXh/
         IbcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTFimPv+H0Vyz2If+WrxQjm6xe/x4ac84QdFn3cOkMJt7UMDAbsiYyhsH4zW8tS9WoK3JEu8z/RL+06w/0t2YZEosVltKZ+u2BBhRX
X-Gm-Message-State: AOJu0YxGmNQS7C+5SavSsNoIc6GUn6d9Wx/X/jxtbA64tqHjU+P3QOhm
	kZiqyu2WKOZK+hEkDWadp9Ff595FyduJ2eso2L3KjpIwUvMADPfrZUcrgSHBYg8WBa2hGqlsZyZ
	L8TZHx9I29HD8Vx0e7vBfL65iiD1a0phChW3qGMZY9yY3M8pb+23lDvc=
X-Google-Smtp-Source: AGHT+IG6HXxs/ynnoi6WxlCaOWgBlvHY1/o9En1pwTOHwPYo7qCr0D5hUxepeJHr8fPf5GSbahkgVaqYuuvx3Tz3+gkbFisCdzOs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:851d:b0:4c2:8e08:f579 with SMTP id
 8926c6da1cb9f-4cce15e045amr577793173.2.1724053159870; Mon, 19 Aug 2024
 00:39:19 -0700 (PDT)
Date: Mon, 19 Aug 2024 00:39:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002b15070620046876@google.com>
Subject: [syzbot] Monthly nfc report (Aug 2024)
From: syzbot <syzbot+list6eb6e310c9acf922e970@syzkaller.appspotmail.com>
To: krzk@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nfc maintainers/developers,

This is a 31-day syzbot report for the nfc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nfc

During the period, 0 new issues were detected and 0 were fixed.
In total, 8 issues are still open and 27 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 207     Yes   INFO: task hung in nfc_rfkill_set_block
                  https://syzkaller.appspot.com/bug?extid=3e3c2f8ca188e30b1427
<2> 139     Yes   INFO: task hung in rfkill_unregister (3)
                  https://syzkaller.appspot.com/bug?extid=bb540a4bbfb4ae3b425d
<3> 30      Yes   INFO: task hung in rfkill_sync_work
                  https://syzkaller.appspot.com/bug?extid=9ef743bba3a17c756174
<4> 19      No    KMSAN: uninit-value in nci_ntf_packet (3)
                  https://syzkaller.appspot.com/bug?extid=3f8fa0edaa75710cd66e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

