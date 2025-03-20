Return-Path: <linux-kernel+bounces-570544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D847BA6B1D0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DBEB188941B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAAB22ACFB;
	Thu, 20 Mar 2025 23:48:37 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB8786352
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 23:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742514516; cv=none; b=BsPHkYzKdtb08IV7MAoHAXZ7WfCkaGjBwnj4oC+k59E6RHvHUXtNIT5NTseKR3uk6NMc4dOwpTzPHjSidd9QV9HMqcxw36e8uobAoHAunaSHuYwFuucEqDnOYDz9dJcebqaJCvC6AZDWeK1gbuTw1XalBd+Xz4vWCmvZ+8nuqbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742514516; c=relaxed/simple;
	bh=/67vlHR+yzivopGOH8NnRt+rwnIBGuEuYA3AcqPzAbw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=S8V1cGvPtYpGfxjcAQYr3rKBVjmFSTLKvHJ0EDtA+02Q7YofX8f9Z+hWP2/gGBL+aHPBUOdHQwAGtyHTe8dGg4ykT79OyCsltEgV3z0zL15/oXwHW0cZDJcVy79SF/7iNqfxe/XRk7KtLVv1ofdHbKXKT/lC1hpDmUBh9dqsN68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d43d1df18bso14499025ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 16:48:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742514513; x=1743119313;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j2Z8Qd5/Rkca80sOD11PnGP8NP8AwU91dlrNXFMEDds=;
        b=URdw8xLuSUpO2L4VwJN/ebQHbZmC9OCAKTmNuledTgtKZnfEjqV18rtbWXGfD2Vh04
         eNTObZRruoN9YYnksswPG6FqpGmlMu/H9EzQAXEAPjlR5Ec0UlufMC6qXRG2TyTJim/V
         /cxL9i9OLJEoG9aZuwF3rhFUUL0t4KjsoH1GyZFbSECcrewiF3hTDeNtc/dYleNdehzv
         l+OlRbLvmIh9/2F4aBQ0ASb9gfAut5cYmRD9joHLBi4yFbtcNnA2yN/ALQL8cFNfuKs+
         hY+T2via+geu5D9bkv8fDcrDhvo38Vi+I54an+Gg4D/HNNxPyVWmNowGr6P1iQHkrpMv
         XMJA==
X-Forwarded-Encrypted: i=1; AJvYcCUBmuhFbIVrtRnG5xWvd+/xzXYgjPvD4XqZ4mpMhFLGLqKqcZw2Y2q35jW7XhVEm1xBaWjuA39X9PA9/bk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgxz6K0jNZPC06T2j3I30GWM4zF96x4aIXTQlzZmDhdpj+v1Rt
	wELDxnZU4684DZGwFS4qEUx/OxN6KypKXeF50pPeSGAADUkbSVkLMwXE8CIY6qmM5IA1Q2fLUb/
	8Wd5PCWDL2IZ8YgPSIpW/GGy9ha2TBcyl4B7x6vfGTcRZbrlTGKLDCvw=
X-Google-Smtp-Source: AGHT+IGnEdHU8/Go9DITU/jHDTM/nXkAFLf0Cg8GY21geJeZjfySh3tD9Pt8sFMOxHAXPjz56PIWkq7OGgRLHBf+qAsQcurPYtmG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2783:b0:3d4:700f:67e2 with SMTP id
 e9e14a558f8ab-3d5960f2e60mr12763565ab.10.1742514512886; Thu, 20 Mar 2025
 16:48:32 -0700 (PDT)
Date: Thu, 20 Mar 2025 16:48:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67dca950.050a0220.25ae54.0029.GAE@google.com>
Subject: [syzbot] Monthly bluetooth report (Mar 2025)
From: syzbot <syzbot+list4dde778597ae28b2ed4e@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 6 new issues were detected and 0 were fixed.
In total, 58 issues are still open and 79 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  32796   Yes   KASAN: slab-use-after-free Read in l2cap_unregister_user
                   https://syzkaller.appspot.com/bug?extid=14b6d57fb728e27ce23c
<2>  6267    Yes   WARNING in call_timer_fn
                   https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<3>  1289    Yes   general protection fault in lock_sock_nested
                   https://syzkaller.appspot.com/bug?extid=d3ccfb78a0dc16ffebe3
<4>  313     Yes   WARNING in hci_conn_timeout (2)
                   https://syzkaller.appspot.com/bug?extid=fc4b5b2477d4ca272907
<5>  312     Yes   KASAN: slab-use-after-free Read in force_devcd_write
                   https://syzkaller.appspot.com/bug?extid=bc71245e56f06e3127b7
<6>  212     Yes   WARNING: ODEBUG bug in hci_release_dev (2)
                   https://syzkaller.appspot.com/bug?extid=b170dbf55520ebf5969a
<7>  163     No    WARNING in l2cap_chan_del
                   https://syzkaller.appspot.com/bug?extid=3272785b7a1fc9b510f6
<8>  129     Yes   BUG: sleeping function called from invalid context in lock_sock_nested (3)
                   https://syzkaller.appspot.com/bug?extid=55cd5225f71c5cff7f6f
<9>  89      No    KASAN: slab-use-after-free Write in sco_conn_put
                   https://syzkaller.appspot.com/bug?extid=55d58a05f0b5fd2ea0c7
<10> 47      Yes   WARNING in hci_recv_frame
                   https://syzkaller.appspot.com/bug?extid=3e07a461b836821ff70e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

