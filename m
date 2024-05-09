Return-Path: <linux-kernel+bounces-174331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5168C0D29
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 11:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C00101C21256
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 09:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6516513C9D4;
	Thu,  9 May 2024 09:09:30 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FB214A0BE
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 09:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715245770; cv=none; b=SsyQO4jB0490QXNWJBs5IIxT7j31awX+RFG4/6bhWmL/l6XclECF9nK7cfVNv49ZoI6ps2L/Q2JNZeTMwAW8zR+UhvZRyPPBrzKlocM7jIJDVJ4ppNrF+ozMr01F8sA/XDTFoj2KGp1ziUU4JnUPYeHjhhVypa5T46QrFZHxHd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715245770; c=relaxed/simple;
	bh=ytulcG2hVBXjfdv2BsEYipYgZI8539mOevLNiwL9VHU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RFNAt8piMpKtRjyNo4On44jqVjPe5R5LTDMrhvZoCL3DamJmLEjLCiS0tIUM2N7cyFKo3f8d+rH4SEbZiX67r8OSfdvuamQpWL/PKvo72N+sxJGyRoFvlTiaU8FyXE0D7athLOpsh3uVkjh6RUcX1f0mM5uEOZIUoQEk5fKpZuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36c66a7f96dso7536115ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 02:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715245768; x=1715850568;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8D562yGBs8i5WORQrx0v7SIEwVWve7FyJMoaMqizq5k=;
        b=MHHGQf2s51uol27WMCDz7aAflKZcWsxuHou3YnQ3pXyDWIt5txGSUMvC0SdXBlXiB6
         S+hcD4i0ynkIfqv7xKhVd7RNTi5TdMS8XUBh+bOAMC3paOpzgqdu4fr6Sh9M3fXd33DA
         bzGn51NQIVIpsqwA24Xx1FKProY3w3AJRVxwqarH5F/xvORHSy04NKfS5kHneg5iaiMe
         /Tk9BU4OVPTMu6AJJEjNDgvwxV2LRhK1ETbhTs1gRHMvm1t2CO8ZG4VXVku4otnZoUh6
         MZ81uwaswqRea1qco2mX5rBfEPEXG7xAd8JE0ClBqdrENRuWB3YWTWy9revBRVdSAlaL
         c1UA==
X-Gm-Message-State: AOJu0Yz+MXsmjRR1oOrZlZtFIUe4Y2AGBAoTGGGgFLzibflM/hhj2apw
	MZ28IMEVcFpFcU3BpRY+3ylN5TZGuty+xdd5JPC1fv4EOzHJnCAIDWZl/IBE/m9hY83qNC4c3eK
	JcIqaIDnSQV12hw3S5Qrey9LvvFvB3xxYximrQrSCicc/oklHN5Z7nGM=
X-Google-Smtp-Source: AGHT+IEydKNEtwD6pR0GHqjBkUmc3x39AWxaa1Mfx8AA9Du3xZe9hbmxeS315gojuwDiJdpAPBW+FBrnmFOfF8ahbGQKOIdA7KQm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188e:b0:36c:4b17:e05d with SMTP id
 e9e14a558f8ab-36caed49e7cmr1440815ab.4.1715245767870; Thu, 09 May 2024
 02:09:27 -0700 (PDT)
Date: Thu, 09 May 2024 02:09:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b2601a061801c6cc@google.com>
Subject: [syzbot] Monthly lsm report (May 2024)
From: syzbot <syzbot+list1a10eccb1964edee7534@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello lsm maintainers/developers,

This is a 31-day syzbot report for the lsm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/lsm

During the period, 3 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 25 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 54      No    INFO: task hung in process_measurement (2)
                  https://syzkaller.appspot.com/bug?extid=1de5a37cb85a2d536330
<2> 8       No    general protection fault in hook_inode_free_security
                  https://syzkaller.appspot.com/bug?extid=5446fbf332b0602ede0b
<3> 8       No    possible deadlock in keyring_clear
                  https://syzkaller.appspot.com/bug?extid=7e7ae1ea0744f1adce1a

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

