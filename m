Return-Path: <linux-kernel+bounces-284786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A44995051E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D8641C22A4C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DCD19B5B4;
	Tue, 13 Aug 2024 12:33:28 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1447D19AD85
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723552408; cv=none; b=AU1J42lI8xOLzrR2zWX3RWWBYsroxM5KNQhhUfDniYwgexe66hCw4L0gl6QTh9Zf6ehb1fQBSf6/0ikbZ7PILC0Jw+RAZQep7Jn4mu3NodJrOe2Y2N3Jl3+yVmHvSvlTSNK4NMcKpLWGf/AmXzj/UCvzEqaogJX1jpWzQvW0JTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723552408; c=relaxed/simple;
	bh=zYSC3S25YSekPc0BVGVDTeuyebZsaGXh9Np/h6ZHAeY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZmzMs2qlXhNpNx/saYFmpPLmq2lEcTi5TSO5+9zTbGCqzY4hMB+qv++k2ZFsVJK+33cCRZ/6glHy4GrqJ91yZgJYuXJTns+EJ1Qdjfc3js2pWMxkgmWeLPif4EtP44iOsPgno2T80ykCS/TL2WlltZjom484v7veXsuRhC8C0jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-824cad19812so123838639f.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 05:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723552406; x=1724157206;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=20ZSdz0JrTICMmwGJ76qzs6KtHczHMuniTe0wObpInI=;
        b=GrBJzC/o6ZAJ6zvhtLp2Qg2etM27tXHFu57rWCvsVKMTEY2DeZcsCDLv+lzRwg8s+V
         ej1699IbdZaMpLq0BVcXMOL+H6TxcvC8bTud+aQuNJHTXt1KShP2/uNjZ9ct5UQ5jJ86
         pIt/BI85W8BKtqXeALmtTe9FK/cY+Ynyn3lcj8SrhLWJtG17JhbqHy0udewfEJoqqSlA
         Bz7FRjm2mfKUsUEXdVTypBYYVRsXJHBWM+e73O0eeHbGU+UZsKczhTfH5SRph4gS7JgR
         SK2wpVSLIbCybsfbfq+zetofX6xBAIo66vGE4w30WAjzTKUkDExl54y/vceuqPzDg5o8
         dkMw==
X-Forwarded-Encrypted: i=1; AJvYcCUsQpeNuClpU549OwhR/WgcjopPSn2q+eesxwgFJHExySllQzQnOsBwqvesi7brEJH/WYs7+W4mDhuHPn3m8W8UBV0aafr9dxC7ZCAz
X-Gm-Message-State: AOJu0YwIwpbdRHBsWYlYIB3n8p0+3xb5Hq50zEyN01S7AKXKI4ofXmGN
	sa1tUbPlIAg2bd8z3a+DuMd9ujHXtxSn1hNsgl9YHWhuo1Jl2jC8avLJqwaZSCf45vYslovlbqD
	vZrRMVCAoap4Cu7huFFvlCxvXH+UC+8uAkQaxkzNdrQH6KvxItN1/jG0=
X-Google-Smtp-Source: AGHT+IGO0b0pC3yR29k25kLffGT5m5yUG3sGqqsxF3ul3sMpjjkUiOAlJ6Pe+LdG1nEmAPSH9gjGawVELHLz2Lq0nJSJ7TX8iiDj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1506:b0:4c8:d4a7:898d with SMTP id
 8926c6da1cb9f-4ca9f41a6eemr103815173.0.1723552406080; Tue, 13 Aug 2024
 05:33:26 -0700 (PDT)
Date: Tue, 13 Aug 2024 05:33:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ea9dd2061f8fd02e@google.com>
Subject: [syzbot] Monthly kernfs report (Aug 2024)
From: syzbot <syzbot+list1aed897c54fdb9f8ce25@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello kernfs maintainers/developers,

This is a 31-day syzbot report for the kernfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/kernfs

During the period, 1 new issues were detected and 0 were fixed.
In total, 21 issues are still open and 21 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  5471    Yes   BUG: workqueue lockup (5)
                   https://syzkaller.appspot.com/bug?extid=f0b66b520b54883d4b9d
<2>  1155    Yes   INFO: task hung in lookup_slow (3)
                   https://syzkaller.appspot.com/bug?extid=7cfc6a4f6b025f710423
<3>  249     Yes   WARNING in kernfs_remove_by_name_ns (3)
                   https://syzkaller.appspot.com/bug?extid=93cbdd0ab421adc5275d
<4>  182     No    INFO: task hung in eventpoll_release_file (2)
                   https://syzkaller.appspot.com/bug?extid=63ab1a905aebbf410bb7
<5>  118     No    INFO: task hung in do_renameat2 (2)
                   https://syzkaller.appspot.com/bug?extid=39a12f7473ed8066d2ca
<6>  77      Yes   INFO: rcu detected stall in sys_openat (3)
                   https://syzkaller.appspot.com/bug?extid=23d96fb466ad56cbb5e5
<7>  43      Yes   INFO: task hung in kernfs_dop_revalidate (4)
                   https://syzkaller.appspot.com/bug?extid=da20d108162166514db6
<8>  38      Yes   INFO: task hung in kernfs_add_one
                   https://syzkaller.appspot.com/bug?extid=e4804edf2708e8b7d2a5
<9>  31      Yes   INFO: rcu detected stall in sys_newfstatat (4)
                   https://syzkaller.appspot.com/bug?extid=1c02a56102605204445c
<10> 23      Yes   WARNING in kernfs_get (5)
                   https://syzkaller.appspot.com/bug?extid=2f44671e54488d20f0e6

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

