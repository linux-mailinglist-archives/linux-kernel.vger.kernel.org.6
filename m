Return-Path: <linux-kernel+bounces-173397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E658BFFF0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 16:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4BF9286C56
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139268563D;
	Wed,  8 May 2024 14:26:23 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2487BB0F
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 14:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715178382; cv=none; b=svdiDCUkGkwaCFsOEzNfbuT69tFShhRRxmGdxTW1JVZfm4SStTTcYH0JxWb6M72It924xuuAWWDxhw6Uc1PhUOLR7gZEiHTel07/nIU5g8ixGfLkZW1PLizWsRcoP/SkhRX6fcpGIao8luHaGIB85R9Umy5yohWW3POYWewrDVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715178382; c=relaxed/simple;
	bh=UdR2fErl7TnEbwnYOGyhHFBr3B8ZGufJf022XuyvVHM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=r2jAp6anZV1HfP+tpki+FePixFfb7wZPcRajz50vE3MzNsKtUsHQa2uy6csiF2lVRl67vr9G/GffzYBcBi4OWR1TGUuOqxAEhbE2+cePD8p9DGsrX8s1Z+UYIqhRDS0mRsOHSKAFypVGDlMtu0FlIP49RSR6y3IFj0/deBTG7hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36b3c9c65d7so46479515ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 07:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715178380; x=1715783180;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ggX7JfzxabWB+vmWXTbMblhOWD2FBIwHUcIiLQVCmEY=;
        b=SSURfMMds60LI70l4zx/zK+WOrX0ywk3QXaCkR7Kh9iGdyFSjJ11sJTuStb3jdXOc3
         aXl3127GshGK33syWBlFqNhNO9d3EvKy/M5GcCMYsKt5VGALVsLOyO91qsyZEmujtjpB
         VR0Jufz7HveQ3Wed32hvoBm+Kx978f0s5yaV4mhbnl/hS+AbUkdms/wwBdMPETZFQAeX
         BlZ7PFO4ZC2kW9u6AOfKFAeNYT1+t0UZJXXaxPFjuJIqbX+14Ezii0H3+hbtjw/ISYeM
         lIQd1UkQViXE47QE/vAOX6IP86Zd/cBgD0WukmLDJuMaGuKEB4tNagSiUXSPq9hbUOkC
         v+8A==
X-Forwarded-Encrypted: i=1; AJvYcCVY+5DennOWHKC9XkHESc40Ysbs0wKUpOvRxNrFD8w7c91Vb259jWdeUD6HNk9sdJJmoWaBpv+1XhyPofl3XeoIVLXAjJs7tG2rsBCO
X-Gm-Message-State: AOJu0Yywy1PPoN4jQXGI3YDbMsIjn5W0LOX5vxjvFvZIVgDDLPPME/NV
	pCXah1vhAV0agHhlCFhqENDXKkWQ66/vAIVoN7MuPOKYN8fSgW9oWSKmQZeKYmWk4cBBy2oq9AD
	yXdgZ4xN3sWXZrfVzqflVry0U2we/dW67uUWxn3e9r1P9AHT5Dn3dTt0=
X-Google-Smtp-Source: AGHT+IE3irFr0EarejwE4ZUfo63P6rsADopPw0Tyws7UdKSafF9C+DV9+qZmahh9Xs5+4US62vYMjrQQgAEiQLPuZjpLQBNTdTUf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c549:0:b0:36c:5bd2:6b92 with SMTP id
 e9e14a558f8ab-36caeb3f298mr1304065ab.0.1715178380480; Wed, 08 May 2024
 07:26:20 -0700 (PDT)
Date: Wed, 08 May 2024 07:26:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001863ff0617f21661@google.com>
Subject: [syzbot] Monthly jfs report (May 2024)
From: syzbot <syzbot+list96c21f4b86afe479c7ee@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello jfs maintainers/developers,

This is a 31-day syzbot report for the jfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/jfs

During the period, 12 new issues were detected and 0 were fixed.
In total, 39 issues are still open and 39 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  3656    Yes   kernel BUG in jfs_evict_inode
                   https://syzkaller.appspot.com/bug?extid=9c0c58ea2e4887ab502e
<2>  2347    Yes   general protection fault in lmLogSync (2)
                   https://syzkaller.appspot.com/bug?extid=e14b1036481911ae4d77
<3>  1710    Yes   kernel BUG in txUnlock
                   https://syzkaller.appspot.com/bug?extid=a63afa301d1258d09267
<4>  1654    Yes   WARNING in dbAdjTree
                   https://syzkaller.appspot.com/bug?extid=ab18fa9c959320611727
<5>  1439    Yes   general protection fault in write_special_inodes
                   https://syzkaller.appspot.com/bug?extid=c732e285f8fc38d15916
<6>  882     Yes   INFO: task hung in lock_metapage
                   https://syzkaller.appspot.com/bug?extid=1d84a1682e4673d5c4fb
<7>  750     Yes   WARNING in inc_nlink (3)
                   https://syzkaller.appspot.com/bug?extid=2b3af42c0644df1e4da9
<8>  606     Yes   kernel BUG in dbFindLeaf
                   https://syzkaller.appspot.com/bug?extid=dcea2548c903300a400e
<9>  500     Yes   general protection fault in jfs_flush_journal
                   https://syzkaller.appspot.com/bug?extid=194bfe3476f96782c0b6
<10> 410     Yes   KASAN: user-memory-access Write in __destroy_inode
                   https://syzkaller.appspot.com/bug?extid=dcc068159182a4c31ca3

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

