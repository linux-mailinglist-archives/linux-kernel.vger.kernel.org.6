Return-Path: <linux-kernel+bounces-340463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE26C9873C3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01A7D1C229FF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8504A32;
	Thu, 26 Sep 2024 12:43:25 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CBEA48
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 12:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727354605; cv=none; b=c97wNkFiXzw1OXv39V0VyqOxbJFHEpsS87WSj45cUt0x7ltTXruN4eNtcnIljC2gOr63ybhu6k7QnXqVSgT4XczONsJ8oeLZ9EHEN2EbgU2EQJvyKxkK5y/y9XcE4mUdLc6MeAYwchOubX1ECLezckJ2C3tOGMo3FbZMVORSaqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727354605; c=relaxed/simple;
	bh=JyDPdanlq19dnEIjOGTUaJSbn0zGxru2p+hcq3U3v8o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dY99FQ9+cAGM5Y3c0GdcFXQyC+b1rNGPer/rRdoQ38k2iPaDH14qubPn/I9SyEx3S339UrR/ptFelQWTw1t9GJAru+jDZOKN465cK13KNVgTfcUan6oEfN/JElGiANLDiYhUQT4Qgz2QwcdNicvM78zSL+PXna+UY+CMbi2sSVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a1957c7cf3so10388925ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 05:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727354602; x=1727959402;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+6ML6Ssq8ICikN6jstwv2jWYGmi6nqCff9WtX1Tt2E8=;
        b=oEhB79M1UtfzriwvdkqdH7MrXJe4YiH1o0MxJ6oNQ8O9KGO27bzooO3Slxy+z/DZes
         qaxNQ6TNlLO6MRomM0mmbnV4MUhU/9hdEOHi3WfCu5wjSCzFizHuYHbThSAFSQ9hoK1T
         nD+of0BjjN7wiwOH/6NPo5ldltxWIk7SEtIYzeejKddQkpW+OgGkh0XFRYn74sCWQ5FB
         AYfsasNFgpvMrnKHqRA03dri1y/AjKr6sa4CH1ebzz/akUNeW8kFtUDlfU0EgwrFB0am
         INe7XXhytztkKdJ4280d9Q4+1YFUlojixuQksOJ+IY5LfqtS+Qscc77RsDKQn5r8Tqwr
         70KQ==
X-Gm-Message-State: AOJu0YzSfswXffMw6zCzaYcXA85FzKMjFw2787HxkLrrWP6tZ4lMgIV7
	YV3wm1JI2hxVrUIMKuBLUDaCSCqCu74ie4oFhF0UDCbxdtBCb7fPdBDlWVMHfzsJwvo9M92Gms7
	VrPmiS3hdt5qdCH2g9ELHavBAmu3nLKrSeeVGE2eWGT3Oo8yZQSIGctA=
X-Google-Smtp-Source: AGHT+IEDI9pzcMSZd3ct2WD7ipuMjMl/GrDDJHwfITVk2w2T8J9J2g6yub2cYzTHh/tex/KRSpUKsr66jNvBC2ZLJHGZqVqziE7W
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1cad:b0:39d:637f:97bc with SMTP id
 e9e14a558f8ab-3a26d5f6f20mr63092455ab.0.1727354602557; Thu, 26 Sep 2024
 05:43:22 -0700 (PDT)
Date: Thu, 26 Sep 2024 05:43:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f556ea.050a0220.211276.0072.GAE@google.com>
Subject: [syzbot] Monthly pm report (Sep 2024)
From: syzbot <syzbot+list3b69e62a08fee9ce4922@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello pm maintainers/developers,

This is a 31-day syzbot report for the pm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/pm

During the period, 0 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 7 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 202     Yes   KASAN: use-after-free Read in netdev_unregister_kobject
                  https://syzkaller.appspot.com/bug?extid=6cf5652d3df49fae2e3f
<2> 12      Yes   WARNING in enable_work
                  https://syzkaller.appspot.com/bug?extid=7053fbd8757fecbbe492
<3> 2       Yes   possible deadlock in dpm_for_each_dev
                  https://syzkaller.appspot.com/bug?extid=2a03726f1d4eff48b278

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

