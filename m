Return-Path: <linux-kernel+bounces-436054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9349E8087
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 17:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A56CE1884333
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 16:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D36B14AD2E;
	Sat,  7 Dec 2024 16:12:29 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284CD22C6FE
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 16:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733587948; cv=none; b=ZFb/0QyaBwxCCgBw7n3c9w/dGtEDUdfHph8s3mixu2P+NRceLJyZl1u24kE45NOIvjKFp4UZUmnRI/W9pfDZXDNP50TJ5lZoy2GsjES8eMVbu2MyHz0pJNUCRlVrvP4f945MAyIpkiqgYz8RzMfwpv26fOW1LAMcrpgpUhtBD/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733587948; c=relaxed/simple;
	bh=ouwXvSe1knh7wv47Qc6XJmHyUS4VxHpHthoSndAt28g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=t+zQ/A88dRzNbKfAbBoAzHVOU3TjsWys8HuiedTCdFoRG9Xyob6Cm6muryD1Nigt62mF83mcAh3TXj+OEnDnCt3pBrFr5I0+bp0XKn524KgbqCdG4srvx6/DelZOT2QkuVMdn552wmMWuSJVgOJRz56F1rfeVsVmdFLsEGj1a1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a9cbe8fea1so1623585ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 08:12:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733587946; x=1734192746;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D+JG4qnBLpllsmCaEwFhhtqecdIWaTzL64jr3+YLTZI=;
        b=bgpV6o/A1HYW8Wu6B2PLYliM6KJQwegmvy5uMNVKkXr7uUheGiTf7um9jKOD2cCgXT
         Th4C8Xpi6DOcLVr4lCzi4NGcolt7eIPX+Ye9+02+maNq67JThTfJ2Iv3csGS5RVSLpHJ
         5H1kQemyCQ5fOOJ1YIqH2bn/Nb/axYOy+ZcX+p62Y/mDg6R5MELNh564M5TzclknCvKe
         mhN5Xd8Ht2urBD4tyogu6kt/UyT1bmDPH3EUTr7pgAEweJoVVel/EzTHsRP+NGUz2QNQ
         2kIK3KgWBPH4mVMZUsULC172XMf+YxH8snIJ2c0CfaujUuS9E5BtQ4W6aKBz/ljPKVaq
         jYAA==
X-Forwarded-Encrypted: i=1; AJvYcCVkoGo0WIea1mriwLyvgHdRYt3p98sUKeyejT7E5tugFJ4MI5HbGsW8NrpNZNUexZ2/Z2SS7ZCX6451lUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqJTDp+J0lXohMQF4CXt4CitflMnpF4zy61KX0HRlZOfBLhRgQ
	1cRKwNCahBrWK71Fz9+qAAlwtubYH3tPQzmsD6ihtd/8SGqk1MJaF9omU2gsfenI1iruyKKjSik
	7vXkXNazxQJImBt/XYs9tvMst+GpMFE20NeUbb5rx5S6Yk1eIiYDtU2o=
X-Google-Smtp-Source: AGHT+IEb8qWA7F1OFfn/rTZXkPcErKK3GOUrm2bVUFfqD2TjViVTNYIBdH6488kwbngRgUEBbVtWyGy4o5ywx+cY8o3fK/43vSq+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8b:b0:3a7:6e59:33ad with SMTP id
 e9e14a558f8ab-3a811e0879emr70609855ab.17.1733587946408; Sat, 07 Dec 2024
 08:12:26 -0800 (PST)
Date: Sat, 07 Dec 2024 08:12:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675473ea.050a0220.a30f1.0159.GAE@google.com>
Subject: [syzbot] Monthly exfat report (Dec 2024)
From: syzbot <syzbot+list4af3b8ed9549444d90bf@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello exfat maintainers/developers,

This is a 31-day syzbot report for the exfat subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/exfat

During the period, 3 new issues were detected and 1 were fixed.
In total, 12 issues are still open and 19 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 3225    Yes   INFO: task hung in exfat_write_inode
                  https://syzkaller.appspot.com/bug?extid=2f73ed585f115e98aee8
<2> 1854    No    INFO: task hung in exfat_sync_fs
                  https://syzkaller.appspot.com/bug?extid=205c2644abdff9d3f9fc
<3> 394     Yes   WARNING in __brelse (3)
                  https://syzkaller.appspot.com/bug?extid=ce3af36144a13b018cc7
<4> 36      Yes   KMSAN: uninit-value in iov_iter_alignment_iovec
                  https://syzkaller.appspot.com/bug?extid=f2a9c06bfaa027217ebb
<5> 8       Yes   KMSAN: kernel-infoleak in pipe_read
                  https://syzkaller.appspot.com/bug?extid=41ebd857f013384237a9
<6> 2       No    possible deadlock in __generic_file_fsync (2)
                  https://syzkaller.appspot.com/bug?extid=625941ecc67c107ef2bd

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

