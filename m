Return-Path: <linux-kernel+bounces-236044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8F691DCC9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2630F283534
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D7F14291E;
	Mon,  1 Jul 2024 10:28:23 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E751339B1
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 10:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829703; cv=none; b=f/I6XLKNepM64L29KWdpAFv3pg8sbkPS5mbapWq/Cy15cgAYT4GkadQJ2GPG8op5ybgXw95bILxkM85aaHL7UX2a3poNIVnZtFKjvb5urJfK0gdeGqPwttyJOS9kZRq79QJY8MmF8+A7IVQgL8s7qGi6uYKovguh+f1zhdRDCR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829703; c=relaxed/simple;
	bh=97ox7ge8hmSa6Aeq71PmlkIBe5jGWS2sJRtMDt3CUEs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DErA+s1VVVA60EtPncLzs+kZlp+uejAWG0SIsOrV2Vq8t2jOlwl+kfRySU3LavOk+YFOKah11kXBsCFg66CQjemGYVYLoiXJck4mvzqMofDi/DsCmRgldnvb3Pgy+7qX8jbMrQx9R4Qtyv5G3u20TN787ytSkZkSlARYvGczvbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7f3c9764edbso289871039f.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 03:28:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719829701; x=1720434501;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Re8DON4XHiHt6dKzpiAM/If0D5pMagFKauS5vNeg2Bw=;
        b=JqEY/fCM8K18odixBm3MnR9bMa8YSEG8+IfBYDTo63M3Gy8lr4ku++326vPTVN+tmM
         atO1qbwlni2BikTP7KhwTOmkOZ/oa7QX1awV8+JNdVIOgQaHYKmMH4sPH0UihY1KDKVR
         i3nciQtkNi2sL9bZrME0K184BNUYE1MJXgu6FxnYeog8wvt6t7uhFIhQPlafqZu/QxO6
         JPBkSaJ8ib76X8acMorZhf4YW0pzv737JfMVIUiKHU9jGC15U3AFgKL9/js5NQoAkC5e
         Ebx1ow7H6JJ8+TNoPKfJUDySx0yvcr0j6hz/T39yB0B/ZMyZSwHUsFjYyEriSABORjGw
         SjnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEWOxiGc3f29ebatxavkGeQos6gkv8KMkamYCcYbsTvjz//BAgRfeQQ18CjYG5jNkol12V3N418Pk1mmOXsQyXpH63CVT7ZkzgvWOh
X-Gm-Message-State: AOJu0YxggKHPrMa5Rqzcf5QOY/jBlW7R6ss5uG4O3dQhGghWS92Qlk80
	ehZZpU9gjfGfC5SDWpMc449fss65uzjs7mQNBZuD+PNpGhrDydjrjQEVSfoQHA312R3qKba8c8G
	qXIbcRQ8fLlOt7P9/GK3/isVmbWb40BB+8fED2ucMyXWCWQTSdcim28w=
X-Google-Smtp-Source: AGHT+IENHz27lqyF4XHNtAd7g84TRj1RoYmVTvoqSRrX6HyeUH0AjOxG50RjPZ6BG8rcHyjav8FAtfuDJddwTdB+XiEqMhhA5G1G
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3415:b0:7eb:8530:810 with SMTP id
 ca18e2360f4ac-7f62eea8cefmr26899439f.4.1719829701126; Mon, 01 Jul 2024
 03:28:21 -0700 (PDT)
Date: Mon, 01 Jul 2024 03:28:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000068fb29061c2d0e7c@google.com>
Subject: [syzbot] Monthly xfs report (Jul 2024)
From: syzbot <syzbot+listd8b7cc04330f5e8b3e92@syzkaller.appspotmail.com>
To: chandan.babu@oracle.com, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello xfs maintainers/developers,

This is a 31-day syzbot report for the xfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/xfs

During the period, 0 new issues were detected and 0 were fixed.
In total, 14 issues are still open and 23 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1422    No    possible deadlock in xfs_ilock (2)
                  https://syzkaller.appspot.com/bug?extid=c6d7bff58a2218f14632
<2> 853     Yes   KASAN: stack-out-of-bounds Read in xfs_buf_lock
                  https://syzkaller.appspot.com/bug?extid=0bc698a422b5e4ac988c
<3> 45      No    general protection fault in xfs_destroy_mount_workqueues
                  https://syzkaller.appspot.com/bug?extid=8905ded1b49ae88b96a6
<4> 45      No    KASAN: slab-use-after-free Read in xfs_inode_item_push
                  https://syzkaller.appspot.com/bug?extid=1a28995e12fd13faa44e
<5> 3       No    WARNING in mod_delayed_work_on
                  https://syzkaller.appspot.com/bug?extid=d9c37490b32d66c6bc78

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

