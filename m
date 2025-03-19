Return-Path: <linux-kernel+bounces-568827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D5CA69ADA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C56F88804A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AEB219319;
	Wed, 19 Mar 2025 21:29:28 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F62821579C
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742419767; cv=none; b=C2P684NRTG/Z9i6qUhenpYet8cMEkZTsmAZvXT7BRjF1b1+5oFPWf15w20iqeM1wlFIMrRjZRaYH5TrmfP0O/jD9iXnpG9pAOR/VNMhfbvy2MSP/oXib/Ndqq0qdzn2n4DKt+cYDhzRPhQp4FRkyYuft6hUnF6hIuPki8VEaGfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742419767; c=relaxed/simple;
	bh=x1ig/f/GSZ3+QQzGhD5KKvU6Nf3H0QQ3ns/NTbOSFU4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=S72Upj6Q2+TzrmAK8iYwLqbJZY4t1yv78j/hQi+ZnwY57SzWklMwIAeR9tbm7NWI3a7vnhEIb4lhPD8K/C0aSdl5LNcTT+AK/Wh7jcGq8/pENfjYDaVMu9HQxbOMmOmjvFxxScPTMyI/NuHZSRhqFw5Fbjis1zdnWdfRBum+o6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d2b3a2f2d4so2610745ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742419765; x=1743024565;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2dDDQzC3zAiXNSSKolDKsj/rYgJ5nWbTr3QpkC1PGlo=;
        b=brq1a011HqBTmUugVtlf3xAQfu4rlXdLcfA1vJeLVucqIgDli54mHeZy6L34A5IWJo
         iWk+/DUg42qjLxIdAFGJUztha/bsjGLtO03il8oXIrqfqYu3sRwc5p648NZK2bpWQZSr
         IM7BlGRI/xhuLKwUOkT/7ur2SAeOAXQVWCs8oerCDDWfd9ibC37STF19Y/uu9jpDFtPe
         Hf8WevY5K8ar1BCO+IAB1MVQzJMh+gL8mzJIKn/8pmfVgaHqQOVPi6O0A4VA1CrLWLzj
         xGx7QxokJZGKL9pyMtCltHwMuOOf1OZqwR5NG3YvbIWqLNBMDtJ28QiUIKGM2DDiuf8n
         pSQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOXCDwlQs69jwzxU4Ans1Tic+yS9NsQOHvaSlsUDEfNgNnsi7SfaleVNu0ka05aZfaL0FN9h/ebbCMkrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR80hMXKKKCmm6bddDV1IXmopGt3b7fQk2ulqF1CwC+7FcgHWi
	u8bFgduK+3MKhIMIJIBQ/JkOnQqr1OlryfIr2UZ6tGWEcJ0nkRX4/PQbCZRd1dC108hQf0zbS/u
	MGDHMBgUq5+QZjH5Mlhf4HryuDpji9YQ95bkA5SECl5NqqRB1St9HO2Y=
X-Google-Smtp-Source: AGHT+IHfZAsHI335RXi6BMggSOGezH85UzpwPNmDSAWHyWkdaX6WrnlZgsFXb57bM1bGvi4Dz92BsMVg597ZQa0waNQQoaTzLKgg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2787:b0:3d4:712e:29eb with SMTP id
 e9e14a558f8ab-3d586b2ab41mr49128935ab.5.1742419765531; Wed, 19 Mar 2025
 14:29:25 -0700 (PDT)
Date: Wed, 19 Mar 2025 14:29:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67db3735.050a0220.3657bb.0146.GAE@google.com>
Subject: [syzbot] Monthly jfs report (Mar 2025)
From: syzbot <syzbot+listb6d66f57a78401653965@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello jfs maintainers/developers,

This is a 31-day syzbot report for the jfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/jfs

During the period, 4 new issues were detected and 0 were fixed.
In total, 50 issues are still open and 51 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  38640   Yes   kernel BUG in jfs_evict_inode
                   https://syzkaller.appspot.com/bug?extid=9c0c58ea2e4887ab502e
<2>  20043   Yes   kernel BUG in txUnlock
                   https://syzkaller.appspot.com/bug?extid=a63afa301d1258d09267
<3>  16537   Yes   WARNING in dbAdjTree
                   https://syzkaller.appspot.com/bug?extid=ab18fa9c959320611727
<4>  5721    Yes   general protection fault in lmLogSync (2)
                   https://syzkaller.appspot.com/bug?extid=e14b1036481911ae4d77
<5>  3361    Yes   kernel BUG in dbFindLeaf
                   https://syzkaller.appspot.com/bug?extid=dcea2548c903300a400e
<6>  3122    Yes   INFO: task hung in lock_metapage
                   https://syzkaller.appspot.com/bug?extid=1d84a1682e4673d5c4fb
<7>  3111    Yes   KASAN: user-memory-access Write in __destroy_inode
                   https://syzkaller.appspot.com/bug?extid=dcc068159182a4c31ca3
<8>  2279    Yes   general protection fault in write_special_inodes
                   https://syzkaller.appspot.com/bug?extid=c732e285f8fc38d15916
<9>  1672    Yes   INFO: trying to register non-static key in txEnd (2)
                   https://syzkaller.appspot.com/bug?extid=5b27962d84feb4acb5c1
<10> 1597    Yes   general protection fault in jfs_flush_journal
                   https://syzkaller.appspot.com/bug?extid=194bfe3476f96782c0b6

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

