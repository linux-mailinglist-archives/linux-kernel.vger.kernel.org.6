Return-Path: <linux-kernel+bounces-284386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E37E950067
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292A91F231D0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD23C17BB2F;
	Tue, 13 Aug 2024 08:52:32 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80711684A6
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723539152; cv=none; b=lp1TeYPWS7msUMtiQ2M6nlIp+kF/fv9+IFz5UFudfXw9DX7IFz2S+XABJDSkXhShgJqs+oCT8kC24jB7HfLuRNJXTKj9pFotwpRBDyusqUHRX/WwzgallJnX3JP0HsNdt9OaeQZoe+YW+XFIhregxqs44KwT3jIYIttJV849V1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723539152; c=relaxed/simple;
	bh=KdQgaaQD9Gm3vlA0Bj8Kjz/Ob1ZT/AY5tusHH8cbt50=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=p5B3meay2JqeZtewi8EHi9m+hTlCL6SMPgW1AB4K3ePT/6gd6750XdjGO4B5q74EaKiMHUwL/CzsiBhuqNDu4KBWHiOPwqJlGqy/QTbRG5BYcSneM0JP7EnRfyYwY/GdLmZehGS3VE9IfOrcky0PdBTHgiMGX0nc3C3APRkRkZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f901cd3b5so705367539f.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 01:52:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723539150; x=1724143950;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MxCz8Eby8KQ7jnQK1qi3zgA2Q4cwBTTBeHl6KMvYRpA=;
        b=tB3OqLTeiDCP+HTW82Mps2AtaFEuxYkfY8/zFXvyP0ZSXzWHC2uv7EWsfPcbBdgQnt
         CQtw0EEUUjYMb/s3mBxHiO2iCpA03+PoemgsMaGQaKDGhQurWsbTZyqYl5qHtrFTBXo7
         SCBglXbiruYUPP4ZCEGDLkmR86O9rWA5zsksmj1XK42BgngR2dGX8pKgX6A94nuTahpp
         80Wf1qpIYr1o1FRO9pGfPN3lO7Zpi2RrlJ1VsziG/ljEw/SgUJSGpTB81ZSNSSadq9o3
         yA8reQxHygD8LKXSaE/bZ0W9tNJvdwTVOGZvqSQJmfFrhADHuemZ0vh+rWTD54C/ZHJY
         ubAw==
X-Forwarded-Encrypted: i=1; AJvYcCXVELcx+uj/z/e1dg/xJ17aLk6SCsN56WVdxWrMIK3lV1U13iig2gmVWyRfboA8XEyY5wca9U2f7MkXvvIl0W4q9f0X3CSGMHnPWRVd
X-Gm-Message-State: AOJu0Yx/5vf0LC3FMHTpOCs+eqimRHTi51vEOmOf8EV39zHoa0CAlqdA
	Flv9XqteApvRv5lmjljcR2mPfEj5HQ2VtErRzbpWZWaIgZ2jinpDWs/8yPKHz+gQhHERvNMgiPi
	1sfUZNV8jazcD1/u/h1fu7fNr3VobDBRRIoBIXYAGAfj76FYfK66Vezc=
X-Google-Smtp-Source: AGHT+IG5LjLCaltlZi/+xGhkmf5g4xJjA7k6ZEE4LQyEOQKrO7meo5oqmYRFwdLkhNAg6BRcx9d3X7+to+5uMR8WK5Q1qu8DOHbq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6c0f:b0:80f:81f5:b469 with SMTP id
 ca18e2360f4ac-824c99fb90bmr8207639f.2.1723539150004; Tue, 13 Aug 2024
 01:52:30 -0700 (PDT)
Date: Tue, 13 Aug 2024 01:52:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000caef11061f8cba67@google.com>
Subject: [syzbot] Monthly jfs report (Aug 2024)
From: syzbot <syzbot+listf7efaa67dc7c45e77bd4@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello jfs maintainers/developers,

This is a 31-day syzbot report for the jfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/jfs

During the period, 4 new issues were detected and 0 were fixed.
In total, 52 issues are still open and 43 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  13937   Yes   kernel BUG in jfs_evict_inode
                   https://syzkaller.appspot.com/bug?extid=9c0c58ea2e4887ab502e
<2>  6809    Yes   kernel BUG in txUnlock
                   https://syzkaller.appspot.com/bug?extid=a63afa301d1258d09267
<3>  3462    Yes   general protection fault in lmLogSync (2)
                   https://syzkaller.appspot.com/bug?extid=e14b1036481911ae4d77
<4>  2508    Yes   WARNING in dbAdjTree
                   https://syzkaller.appspot.com/bug?extid=ab18fa9c959320611727
<5>  2152    Yes   general protection fault in write_special_inodes
                   https://syzkaller.appspot.com/bug?extid=c732e285f8fc38d15916
<6>  1572    Yes   INFO: task hung in lock_metapage
                   https://syzkaller.appspot.com/bug?extid=1d84a1682e4673d5c4fb
<7>  1514    Yes   KASAN: user-memory-access Write in __destroy_inode
                   https://syzkaller.appspot.com/bug?extid=dcc068159182a4c31ca3
<8>  1413    Yes   kernel BUG in dbFindLeaf
                   https://syzkaller.appspot.com/bug?extid=dcea2548c903300a400e
<9>  798     Yes   general protection fault in jfs_flush_journal
                   https://syzkaller.appspot.com/bug?extid=194bfe3476f96782c0b6
<10> 602     Yes   INFO: trying to register non-static key in txEnd (2)
                   https://syzkaller.appspot.com/bug?extid=5b27962d84feb4acb5c1

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

