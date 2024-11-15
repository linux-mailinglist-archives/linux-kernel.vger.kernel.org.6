Return-Path: <linux-kernel+bounces-410537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EBC9CDCF6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 11:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8F30B23D49
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 10:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A3A1B3958;
	Fri, 15 Nov 2024 10:49:26 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB4B7D3F4
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 10:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731667765; cv=none; b=D8cI3pVFvDevVvtztKcGrupgahC2wUwiSdz/XFYIXw+DsuYU/Oy940Mw1Rsk6zbFYl7ZbTavHn4UN2dzvcxV35nnDSQfehmCR+z4+m0+jjcxiEIj5FBE9Qz6pb9xtM5W/Rja8ZgILxOoPWuGU9hc0VjQOYIRXPdBYadbu7VZEeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731667765; c=relaxed/simple;
	bh=gxy3kncUMYhSkyjaYeTXEbo3a7tEM0PY6y5ReWwPsec=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=S9V5JfSA9HU06p4M+fyuEc8nflch0341FjWnxT1TIU4LebmbWUUTu6cBsL1EsWUbWggcNJsVvPhx9TGTbgnoqjHx2kAakQWjgEq3DhBjfuQaTEwPZF89HguaPG16Rzx7MZy5/11HaJ7iXiZ4T0zGeJtFHJ147FJi2/pqpVJV7tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a6bce8a678so6988335ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 02:49:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731667763; x=1732272563;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3s4HffnOB2aGqugKtXeHjNUydA3cBYAPBxfBWZhwEtk=;
        b=LSaTrvlNePO6xK4xp//praE4lreANXlSHmOlRVTg2EVfxre6oiYLmr9wS4o1zpgxuG
         JZ3D92Z59qJ4V8t+pQiUECpdsNZVtYu4VEnSo23XIAah90x6z3eyTnaloT6Nmwm5VMTJ
         rgaZbxzgZG5K+H9eZtN/nkXzncbHwO3xy823avR0/17RPNrQaM7q3VXYumYy0HKNhU/F
         3AL1JSp41riLtnWmNa/r7aELLaIEnhSRZ9QIEXm1FFA6346X31+L5Qggqa487poujqKO
         LnnTLgupukI6bA6c4FxkXOaXiioASSwms/T82IW4EBa+3+rn4+bghw4JK9JlZVt4ddMN
         UItw==
X-Forwarded-Encrypted: i=1; AJvYcCX8jMGYPv//6r4TZLuC+p2D6QEae8YzUzjrBgnuqoRFNv0qcmLIEFBOrJVW/sCk7dRMVZqZRIAPkdsS8qU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP/xEhH3Q/3dHNgPNnAfFuXLs+M+1rOjlRdvdN9eeLRywv9Mkq
	ZWqTy+ZvOmb3tKI/HIQwYSwYUA5DXDoEKImvrUTfXNxLlgbbOPeYpVeR3OhMKtli1IDp9191yPZ
	ezY/xPISlAuNFTsodMp1a9KpHfHqS9X0Wt5sTRqnFkIAJxha7Z9JRkAk=
X-Google-Smtp-Source: AGHT+IHXMzR+T8ykMN2gdIf/rq47rB7rG+6DPx5BInp/GkP8WzgbHyEwpqP/Y5X7MH5u3h0rJocUgDifvSO3ojwOMGvTZRL+448T
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c248:0:b0:3a6:b6b4:1d64 with SMTP id
 e9e14a558f8ab-3a748093facmr22442615ab.24.1731667763697; Fri, 15 Nov 2024
 02:49:23 -0800 (PST)
Date: Fri, 15 Nov 2024 02:49:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67372733.050a0220.2a2fcc.0076.GAE@google.com>
Subject: [syzbot] Monthly bcachefs report (Nov 2024)
From: syzbot <syzbot+list513443baf0d817bf8fa0@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bcachefs maintainers/developers,

This is a 31-day syzbot report for the bcachefs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bcachefs

During the period, 26 new issues were detected and 9 were fixed.
In total, 75 issues are still open and 98 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  17171   Yes   INFO: task hung in bch2_copygc_stop
                   https://syzkaller.appspot.com/bug?extid=c6fd966ebbdea1e8ff08
<2>  5974    Yes   INFO: task hung in __closure_sync
                   https://syzkaller.appspot.com/bug?extid=7bf808f7fe4a6549f36e
<3>  3337    Yes   WARNING in bch2_trans_srcu_unlock
                   https://syzkaller.appspot.com/bug?extid=1e515cab343dbe5aa38a
<4>  2345    Yes   INFO: task hung in __closure_sync_timeout
                   https://syzkaller.appspot.com/bug?extid=43d0c6eb00a26a41ec60
<5>  1263    Yes   INFO: task hung in __bch2_fs_stop
                   https://syzkaller.appspot.com/bug?extid=6d3e28b33490b3085412
<6>  832     Yes   BUG: Bad rss-counter state (5)
                   https://syzkaller.appspot.com/bug?extid=f2bbbb592debc978d46d
<7>  541     Yes   INFO: task hung in bch2_journal_reclaim_thread (2)
                   https://syzkaller.appspot.com/bug?extid=820dc3b465c69f766a57
<8>  285     Yes   INFO: task hung in bch2_fs_read_only_work
                   https://syzkaller.appspot.com/bug?extid=8996d8f176cf946ef641
<9>  299     Yes   KASAN: slab-use-after-free Read in percpu_ref_put (2)
                   https://syzkaller.appspot.com/bug?extid=905d719acdbd213bf67e
<10> 256     No    WARNING in bch2_trans_put
                   https://syzkaller.appspot.com/bug?extid=291aef749c5cbb9ca2fd

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

