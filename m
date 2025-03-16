Return-Path: <linux-kernel+bounces-563163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D94A637AE
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 23:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7160F3AE3AA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 22:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7471C5D4E;
	Sun, 16 Mar 2025 22:21:32 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7890719ADA2
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 22:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742163691; cv=none; b=Nz9pRChIqQ/oFGOGgV9Yg6qSu5Vx6IMWBwFf2bo92VByWhUOYG+NKPebUpCvrNdwazfkKwhBv09vcnDJ3kbbs5qIzltM8NYfTKbYskETd4AxFJshjcf0G1ICujOyUH6t/vNub2pGvi4/TQ2EaaOzu5QAk24VNkYYtbHHFOPOYSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742163691; c=relaxed/simple;
	bh=f/bkzuKJBrCQQFvFO7kQ6QMquwdda1sZmGWNQShxsnA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hGIjvXfYUm031tod87l3kR8ZabQJ/RuENHHQ03jNL6s/6OX91M/PbhxWtdkLJGxIwOf5JE9BKZIsU7mHWX6SknVqLOw2HNAldNyJ/6CGVEmB85FJPk7Y6T6/4oOuyfYX4IoTInIoZ5ZbgAL9ODIVUtXgMvLz27NBqDEx+sq1TRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ce3bbb2b9dso41634705ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 15:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742163689; x=1742768489;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vytDXSrDTUIA50F7Adluh0AaQUpx4RGewUd+6TVCqd4=;
        b=ATlD2XzFXTqsscs2h4W6hFIRXtAWaSrp9Vd+4eeRMwkt4JvgNle6MxpDI2Xa55YdtK
         0UkTlZ8b4iL1PAVBdXdSKFDfdjWfZNlHqiHSem1J9QWt3QTQY+a4Zf9d7PFE1xhcmN/M
         th0xg8dKQiqrjYOXYP69edUzBqArnCY6XKZqEWRn1BrlP606HurZDcfJXqizRCA5i5ce
         sFmRXjnQosJhkL2vdTomqTV8zVjkmIb8CWRUftHe8tBYTaeFiCobR1HR47jvTGLqTwfm
         W75lS4cQx9Lj7q4Q/PvhyreiIzGXx7Jh0nv8fKJFo9iEPH2yd3SsJ1sG18UczlZbvqmj
         RZkw==
X-Gm-Message-State: AOJu0YyuFI7t4TnNoPtaCwjD9Q5c/YjRXM3do3p1sLWaLXNLtZMgwWhE
	H4YLaX1mGqsovonu8wEj8S4zZGMe5snaLbhJYYrDbuMGlgMZFaiMNAnjAPD0HPrnDO/4msC9y0i
	46705M0A0Fus4N2YPb6bR1yt0b25tYc9CeaNhKpn+FfTdIZfQGSxYNuQ=
X-Google-Smtp-Source: AGHT+IEn+wquHBPxIpt0ermTcUKPWlfXqft6IlQRcDVJwMRJPcgYXM63WiE55Bj7+8ezsWoTIlKXO2u/bBJ0a2JmahvU1f3NbVfO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184e:b0:3d4:3ab3:e1c9 with SMTP id
 e9e14a558f8ab-3d483a6e932mr96942565ab.15.1742163689656; Sun, 16 Mar 2025
 15:21:29 -0700 (PDT)
Date: Sun, 16 Mar 2025 15:21:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d74ee9.050a0220.2ca2c6.0003.GAE@google.com>
Subject: [syzbot] Monthly trace report (Mar 2025)
From: syzbot <syzbot+listdef366be10f5531c250b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mhiramat@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello trace maintainers/developers,

This is a 31-day syzbot report for the trace subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/trace

During the period, 1 new issues were detected and 0 were fixed.
In total, 15 issues are still open and 42 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1480    Yes   WARNING in format_decode (3)
                  https://syzkaller.appspot.com/bug?extid=e2c932aec5c8a6e1d31c
<2> 162     Yes   WARNING in bpf_get_stack_raw_tp
                  https://syzkaller.appspot.com/bug?extid=ce35de20ed6652f60652
<3> 37      Yes   INFO: task hung in blk_trace_ioctl (4)
                  https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c
<4> 34      Yes   WARNING in blk_register_tracepoints
                  https://syzkaller.appspot.com/bug?extid=c54ded83396afee31eb1
<5> 16      Yes   WARNING in get_probe_ref
                  https://syzkaller.appspot.com/bug?extid=8672dcb9d10011c0a160
<6> 15      Yes   WARNING in tracepoint_probe_unregister (3)
                  https://syzkaller.appspot.com/bug?extid=a1d25e53cd4a10f7f2d3
<7> 7       Yes   INFO: task hung in blk_trace_remove (2)
                  https://syzkaller.appspot.com/bug?extid=2373f6be3e6de4f92562

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

