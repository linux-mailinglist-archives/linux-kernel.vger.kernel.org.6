Return-Path: <linux-kernel+bounces-364659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DDC99D78E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 21:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 113A21F23473
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D462C1CCED9;
	Mon, 14 Oct 2024 19:37:29 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A62F1C879E
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 19:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728934649; cv=none; b=L2XdCaYUP8rFqA+CgRNgOmB0qU7tjVD62hnns3dSEcvr7kxeBin4MMbiHZBin1JpUngIwinLsdX6t4cf6gwv5c8FOUNWCP9qKxamViFmlNuRDHGc8bfNQkyZ2xKnOS97ZfJEFt2a2PaU0Uu92a/HfgkBD+A66Dj1qK/e5E36bxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728934649; c=relaxed/simple;
	bh=YpVdCJRqP9r4/KRoF3xdbaJ6CWlYtY14les9I6/T9R0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ePli+EEomvwig+AJli1SfNoW/K7IvenKGTZuKu/zSWpB1Tc1Ocl0v1aiUvolzjp7jLYAxTQ9s3lje7/OH9lMRqhamI1DUuUTTpbWA3/oS2OX9Gx1GLre7HoO0mTDBQdWssQdWh0/LfJQj1+/PehmrpYIzDLbMNrdvFSQ4z5Xrjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3b2aee1a3so33474625ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 12:37:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728934647; x=1729539447;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZtM4iEdHicrMwv5gQKudIG1n3DgEExvY3relJ9nM2LY=;
        b=U0iMLR2ifaOI6js4l4v0Aen5om6OlE7koz3rF1L84prw05bso6u6E6vyj9uiwlMr9b
         ZQoPFy/sMgMU2IHvtpAFZ4ATfYmkbHf5JTpP2A8wo0hKfYC5g7MhQCWKUy9g3rudsLJo
         HK2N1Z6uCdLzQVYz9RK6ZVlLfSMPchbqxZs7cg+WMFwZm3DYCHmtVCobISx9pWLf5Hjc
         cRszlrBXslIeNYXHVapQClZuyF7md2Kw746A+4K38w+EJdofIbq9twYMT9wdIG5G9m2l
         EGyX64u3Msnc74YdJYxFPI1k6Kqv4W/HeQhoLkcMDfbVuWR+9/ipgrdumsjbaCgoklf0
         QZcA==
X-Forwarded-Encrypted: i=1; AJvYcCUo+basgmPv9O5sRsIF00Uql8YJu0JuNd/xBSRjj+XGTB9+nmX8BZ6FYK8infNy5492nEj9UlMUbXg2es4=@vger.kernel.org
X-Gm-Message-State: AOJu0YycwOmNEMyt1pou17oEWByGgDMvt8OXA7nUOPDE6ed5rwDCz5ix
	+LeNacKM1nEwTyPwNk2pxQFbmpFcqHYCGQQcfwtiIMwFl7fo4XtM6rdfZHvPQBYRyhKr4WMESZ1
	nNF1YNjfw798WoaDOtkYhPPWk+60yf+ib4cT+Heq0k5bwCY4ibZMfa6E=
X-Google-Smtp-Source: AGHT+IGQAbrgLL/TFdTYt+kTOkUzdaVBuNTQWBtfMLsc9tG4vaMPBwq/rKyRYlwo9GaQi42No11RzEdircxZekonHXhuR6ddScGe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b2b:b0:3a0:9952:5fcb with SMTP id
 e9e14a558f8ab-3a3b5fb6490mr95978835ab.17.1728934647268; Mon, 14 Oct 2024
 12:37:27 -0700 (PDT)
Date: Mon, 14 Oct 2024 12:37:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670d72f7.050a0220.3e960.00db.GAE@google.com>
Subject: [syzbot] Monthly jfs report (Oct 2024)
From: syzbot <syzbot+list47b21a48b702e3bbf3ac@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello jfs maintainers/developers,

This is a 31-day syzbot report for the jfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/jfs

During the period, 5 new issues were detected and 0 were fixed.
In total, 53 issues are still open and 47 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  21984   Yes   kernel BUG in jfs_evict_inode
                   https://syzkaller.appspot.com/bug?extid=9c0c58ea2e4887ab502e
<2>  9592    Yes   kernel BUG in txUnlock
                   https://syzkaller.appspot.com/bug?extid=a63afa301d1258d09267
<3>  4135    Yes   general protection fault in lmLogSync (2)
                   https://syzkaller.appspot.com/bug?extid=e14b1036481911ae4d77
<4>  3333    Yes   WARNING in dbAdjTree
                   https://syzkaller.appspot.com/bug?extid=ab18fa9c959320611727
<5>  2354    Yes   INFO: task hung in lock_metapage
                   https://syzkaller.appspot.com/bug?extid=1d84a1682e4673d5c4fb
<6>  2169    Yes   general protection fault in write_special_inodes
                   https://syzkaller.appspot.com/bug?extid=c732e285f8fc38d15916
<7>  2031    Yes   kernel BUG in dbFindLeaf
                   https://syzkaller.appspot.com/bug?extid=dcea2548c903300a400e
<8>  1946    Yes   KASAN: user-memory-access Write in __destroy_inode
                   https://syzkaller.appspot.com/bug?extid=dcc068159182a4c31ca3
<9>  1021    Yes   KASAN: use-after-free Read in release_metapage
                   https://syzkaller.appspot.com/bug?extid=f1521383cec5f7baaa94
<10> 907     Yes   general protection fault in jfs_flush_journal
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

