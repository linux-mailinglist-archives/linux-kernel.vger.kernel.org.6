Return-Path: <linux-kernel+bounces-410539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D609CDCF9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 11:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CDE2280EC6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 10:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0618B1B6D02;
	Fri, 15 Nov 2024 10:49:27 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307581B2196
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 10:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731667766; cv=none; b=hYkDUqfAnAxzIPeivTbKV9Cw2HTbsI6VO/6LG0u9JnzYs5h1A0J02gHGO2wnFfYAPI9SZJLqJtevRsNRnOV5r6tQLw2QFt0pdVhB6zI3QNVZFFTAoDRTcc+UsjVF5DeWDreRtdDHc+P1cJOlwbeFzvDmPHVyJX3XA0zwYMDELI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731667766; c=relaxed/simple;
	bh=ubEYGt1zvGVfg6XdBlBj7Ra+4IlQFTaDQuwvvEB7O90=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rl8fwU/AWdvJ6se1lboVP9+ctfnpYWRCn3hRElIgEzE8gDXkaYe1QhAFFxrpox7MR53+37yuaMiVZUrIAeqz6R1/VyC+0oudfnXLZ4hjwBuiCaPRpw4j7YCMG+K+e7osKZXRcyJbQ0cilKcPyhma6S9Km6OrUFlbcygjFcTPQuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a71d04c76dso6597195ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 02:49:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731667764; x=1732272564;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f+rlxtKG2aGkvlFRBMhtlmvZbAbGNeSTd8P0PcCyJfE=;
        b=IDMnddmWc0/UJ/esuZ0c5V7YK2MxBvY7x/4Wym4LdTTYrGWHbyvpaEjW5OfXU71Jdo
         OawJVRJBFejagySf7g9y5G1tYtDOCqzFeJhEPccOWrvgB8aO6XJKjuwPj79wfXoAnSZS
         4GllRq4mBcGPUmnttyo5GEWdR53JUtvoBZelwpq2oQLarf6bSo+U8K04es81CqGSQ1ZI
         0kwEyrflw6aR99In4B6mRfGHHPfI9UTFoiAUJ1mmKIbEK5S0Ai/JeKjL7HVICBdQ68bg
         4/RqCCwoFDugbiD1I3Q8YcaaQzNlcIAId9U7Cr2VnIB/9HdV4bc0Nx+ON2x3XbZNpyY5
         eBEA==
X-Forwarded-Encrypted: i=1; AJvYcCXWtlE4cUMf5d657kzTCejCAPauvylKRcA8K67XF1Mk2XeLjgMwmr7bQyYYIROe13eGgo8COLDRkJroQw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRUBV+sujd4wfkp8mXdD6qBuWAlbPZkOoc5USr6cmVOIGAyQVO
	jhj0yev1f3N+XIjbDSNJOwr5JKZdwIiwhMoIJvJhQt4VoGUQ9RVwV8/VxrURHPZnmZ3CqPlM6Ls
	kz3AY4mVYqVpQkyh1cqH8K2HH+dbqqoXQ627i32N6WvFVe9Ko333TlOA=
X-Google-Smtp-Source: AGHT+IEk0v0Tl83Y60397ic2iMUG3lvC58jjO9vBypvdRBKMc5saVXpQ2Ag+VCBNGJAAvTQj/IvZnU8Dt/CXoZniX3Mq0+45VNtq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d88:b0:3a6:ac4e:2659 with SMTP id
 e9e14a558f8ab-3a74800f183mr23740335ab.6.1731667764204; Fri, 15 Nov 2024
 02:49:24 -0800 (PST)
Date: Fri, 15 Nov 2024 02:49:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67372734.050a0220.2a2fcc.0078.GAE@google.com>
Subject: [syzbot] Monthly jfs report (Nov 2024)
From: syzbot <syzbot+listf156ee00ba8a7b601a18@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello jfs maintainers/developers,

This is a 31-day syzbot report for the jfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/jfs

During the period, 2 new issues were detected and 0 were fixed.
In total, 49 issues are still open and 47 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  24478   Yes   kernel BUG in jfs_evict_inode
                   https://syzkaller.appspot.com/bug?extid=9c0c58ea2e4887ab502e
<2>  11810   Yes   kernel BUG in txUnlock
                   https://syzkaller.appspot.com/bug?extid=a63afa301d1258d09267
<3>  5816    Yes   WARNING in dbAdjTree
                   https://syzkaller.appspot.com/bug?extid=ab18fa9c959320611727
<4>  4529    Yes   general protection fault in lmLogSync (2)
                   https://syzkaller.appspot.com/bug?extid=e14b1036481911ae4d77
<5>  2536    Yes   KASAN: user-memory-access Write in __destroy_inode
                   https://syzkaller.appspot.com/bug?extid=dcc068159182a4c31ca3
<6>  2468    Yes   INFO: task hung in lock_metapage
                   https://syzkaller.appspot.com/bug?extid=1d84a1682e4673d5c4fb
<7>  2316    Yes   kernel BUG in dbFindLeaf
                   https://syzkaller.appspot.com/bug?extid=dcea2548c903300a400e
<8>  2206    Yes   general protection fault in write_special_inodes
                   https://syzkaller.appspot.com/bug?extid=c732e285f8fc38d15916
<9>  1085    Yes   KASAN: use-after-free Read in release_metapage
                   https://syzkaller.appspot.com/bug?extid=f1521383cec5f7baaa94
<10> 970     Yes   general protection fault in jfs_flush_journal
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

