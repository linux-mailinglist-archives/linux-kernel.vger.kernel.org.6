Return-Path: <linux-kernel+bounces-236035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB9C91DC99
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BF791C2165C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2D9157473;
	Mon,  1 Jul 2024 10:27:21 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BB81534EC
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 10:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829641; cv=none; b=qb6+EmNrnXGjOo9Uab+3llXyBifBJPUEgxrwEWpothec1N8kbry3RcEMB3jBmchnmZu7y6p6ZS5BE0WaFGtI3REOttRxY6uTwZpfoxc7uyekKWbPaSSiLHjrJuVeEEp9JBdz0ALJjU3oW1qgI8tks5bqhgmqWBkIO5XRbjJ1pHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829641; c=relaxed/simple;
	bh=1HP887e6Ea4WDAE35px35VdpUyXaiLd1atsEL35N0oc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ByVQhkK09PrWmK7FsEZrcgHi9aCV5sUgtrrA3hhGCr3z2U7/QsSKaT9jYjsrSCt4vRcbHFQIxODrX6RKiuc0o1maV/YG4mhujt+xLWh/kTn4XfTXfed4sQXHeoeuBYqJ3inWEixcycsLXmHGLgzxSSWRcULAY6JQQpXF3nuUEgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7eb01189491so320410839f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 03:27:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719829639; x=1720434439;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A47/TizqhE+pZZ3v7ifvB6Z3SgqMGF8RAQxtsDMwcH8=;
        b=TojhNshSWASa2EbPF73PhPkCx6Q2r5FMlUbBJmUYnBMKpqEnvZaLVSnDo8LXCqqsj6
         77HgX6Z/pBR2Ors0mNk0NQxJ/xnfwQHRR1BX1KWg78+V8g9rLaG1tAg1AEwPJ/fctDHn
         pkM9BBEga4823xPYkB6DEvIyVKFBJ63sG9B5IS3LBa9dRt//6Frn8mKLg9BpLbeXbOxP
         s7QRytWlbEDXuEujRPA0PcQBi8htqnd5Sdp9t70yoh6F9sisVxyh/NfyDjP58mL6G++H
         DyU1pirMtWx9dSkXb7SLMKfP7IAQDZSpQ4NGADDEoVNETBLbH+os8c4tUFJnZmEsTesG
         BULA==
X-Forwarded-Encrypted: i=1; AJvYcCUrMpyq05ZuOtGKXCUSQeW1Y810Z89Yw0SWxmkaOPtYQWlhzFAwzfRewL7AutWnNonHGcjKBIo2fnWgo5h2eFBYCg3P5mt5HYackhUV
X-Gm-Message-State: AOJu0YycJQMgWvGFumDiCfK3Grld/eGgfXniFYEa5f2pzPTf3y4YWBjy
	UObc57LznD22rkA1cjKuzJ38WKjTVCt2049/lop/rUCn8fgo2VoipHbzjCX5HqMf4Sz6dDblFL/
	QjppPiLsSRGHDLckluvmPn8zjlFJjucKD0NLSlUxiRqQpwS8cqhkK1JI=
X-Google-Smtp-Source: AGHT+IEyHvl/XKfFDgtbN6kOczny0AyW/l3JzsNiMFCdxRyGlYMUd1IPHrmxYnVnkcGvOMV8XU26ZmQnGNxGjkxlytVxjgCydULw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:9806:b0:4b9:6637:4913 with SMTP id
 8926c6da1cb9f-4bbb6e52facmr258839173.3.1719829638906; Mon, 01 Jul 2024
 03:27:18 -0700 (PDT)
Date: Mon, 01 Jul 2024 03:27:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b38d84061c2d0a58@google.com>
Subject: [syzbot] Monthly input report (Jul 2024)
From: syzbot <syzbot+list0328d7a3dda088d6481f@syzkaller.appspotmail.com>
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello input maintainers/developers,

This is a 31-day syzbot report for the input subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/input

During the period, 0 new issues were detected and 1 were fixed.
In total, 21 issues are still open and 54 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 671     No    possible deadlock in evdev_pass_values (2)
                  https://syzkaller.appspot.com/bug?extid=13d3cb2a3dc61e6092f5
<2> 386     Yes   INFO: task hung in uhid_char_release
                  https://syzkaller.appspot.com/bug?extid=8fe2d362af0e1cba8735
<3> 318     Yes   WARNING in cm109_urb_irq_callback/usb_submit_urb
                  https://syzkaller.appspot.com/bug?extid=2d6d691af5ab4b7e66df
<4> 19      Yes   possible deadlock in uinput_request_submit
                  https://syzkaller.appspot.com/bug?extid=159077b1355b8cd72757
<5> 8       Yes   INFO: rcu detected stall in sys_syslog (2)
                  https://syzkaller.appspot.com/bug?extid=269f9ad9bc32451d5fb5
<6> 6       Yes   INFO: rcu detected stall in sendmsg (4)
                  https://syzkaller.appspot.com/bug?extid=9c0539eda655673bdaa4

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

