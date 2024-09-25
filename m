Return-Path: <linux-kernel+bounces-339093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A5E986042
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 881911C25E8D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84C619F120;
	Wed, 25 Sep 2024 12:47:30 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7A119F10A
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 12:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727268450; cv=none; b=qSUNnhAdQX9Dxbdzgo7xMoLM7WqU4bSR8TD29d1203ET4EZOWfAjDI9jUcKXNYmWSVIkHx5CuLvDnADfaUBTaWrZzDfv6gDnlLhTpsTRPHEuzTo1grvNtKQ83u6//ebOGgn17JjgsCo4tp6s0lk9lPFZiKSrb4VKSYgZr5YeIgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727268450; c=relaxed/simple;
	bh=NCzsW4E2ZZ2FzA20ISpl6xFoETKKdSaYRdl/64ktIa4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aiv3gtvVrTtLRQThosYHl+/XcMl1b/fPbc9UxOQUqjE4D9aeI5esctDl/elcywO+wgWexX0UIfeeljkLySaD7UuzFNINZ4s2P8pMuQ7ohgprG/FuUzdqV3SdcU7hqOVVSwQIBE1xaHtfGHw4+Kim3Ub93M+bxblGdRftjYUEqF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82ce3316d51so789064539f.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 05:47:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727268448; x=1727873248;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cbe2GuJNvu3f+dUwcul28DEfPY70yqUucRe+UoOSEdk=;
        b=CIDnlTC4uNMbH+4Ak1vncB4s+BvLTCIcmbRTJOLcRtq1AJ9db0U+87R+Mwq/WLm7fo
         rPeGKEJPBbojYmxzIMEggkyMFY+lFfjOpgrmODiP+I/P0A2qZvwVqHwiSNi89i4/nRID
         9xowwZ2Hq8zxsYjoaU0+GgZ5JI6B0Hmaf2QLbPaUgsxd4v8AMlaeUiJ89X7gIqrmKYSM
         T01CcZze2L5PFof+cS5sPQJk8OSCxTdsYAT5OBDLB86fwhLANnr2+N+SoEIx61J9FRI9
         WKkyPYQam3Wv4ENDiJIJyqHPjDZlDxRdVD11w0hAP+yKvyb12/43P0uC5AY8B1H+BRDw
         yidw==
X-Gm-Message-State: AOJu0YxicGU5WCfgs8ehXOolWosSVLpNFyDA1d7U1Ao16i8wqIvozRKl
	QM6eXQWD/z2020VI+iKZcWYB2Z960Nhw/ZgWcr4xrWhrSjGF9pc+0QbM6YotiIVy5E2vGZguStR
	Y078Kg9Kmkc/cmVFwkIbq4qk4Y16+EirkgiIyQnKOR4l5g7dCIPQl1iE=
X-Google-Smtp-Source: AGHT+IGdu7jW53gAtty/Z8NYGmjy8KYYIM6G1e9GE6nxm3CZKmYKiP6EgzQqN3JbkSSMi6X1O4s5yrtQ+d4EB/sGl5OX5h7p1fnO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1564:b0:3a0:c820:c5f0 with SMTP id
 e9e14a558f8ab-3a26d7f11admr28720545ab.24.1727268447974; Wed, 25 Sep 2024
 05:47:27 -0700 (PDT)
Date: Wed, 25 Sep 2024 05:47:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f4065f.050a0220.211276.002b.GAE@google.com>
Subject: [syzbot] Monthly netfs report (Sep 2024)
From: syzbot <syzbot+list6282f492642ca904f394@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello netfs maintainers/developers,

This is a 31-day syzbot report for the netfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/netfs

During the period, 5 new issues were detected and 0 were fixed.
In total, 6 issues are still open.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 11      Yes   KASAN: slab-use-after-free Read in iov_iter_folioq_advance
                  https://syzkaller.appspot.com/bug?extid=e6089e62b4d92c4a7792
<2> 12      No    possible deadlock in lock_mm_and_find_vma (2)
                  https://syzkaller.appspot.com/bug?extid=b02bbe0ff80a09a08c1b
<3> 4       Yes   KASAN: slab-use-after-free Read in iov_iter_revert
                  https://syzkaller.appspot.com/bug?extid=2625ce08c2659fb9961a

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

