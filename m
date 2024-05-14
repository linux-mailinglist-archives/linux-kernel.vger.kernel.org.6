Return-Path: <linux-kernel+bounces-179159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A748C5C7E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 22:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B38BA1C21BE0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 20:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E92181CE1;
	Tue, 14 May 2024 20:49:37 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642221E491
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 20:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715719776; cv=none; b=g/BIgg4W0kxVkhlYOJ0AdtIC53hTgpxg+aG33jBrGIqzcFTCmNF6elJAHVhUFbKTADV9UprLwiNWidZgMUbzCJDPGlUMQsNLrHJgMwhVBUC4eja/7wUC+MTJOeZOl+FechJMg0Xcjd7a4CMG2mfqu8EFYE1VJeYPaCZ03Hgr9BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715719776; c=relaxed/simple;
	bh=GnJUEW+w78/aoxOtZcgVT9Rt5+/UNhIu5BjCQazjAEI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=L7lbxg/nYY4INSgAfeaBr4oweyy30YTzFLb+Swc7XhXIS/7vmXCNS0Bkv5zEHv6bEJ18bAtipv+8leBMXzqdZOoUF6HDk2MgGXhWfEXY9yvdW6EkekSuZN3U+6FuX4QdCGWKxkasfp+CVyLzwvAnmeLD4BISEbqfgJ5IWcAoFtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7e1ac2fbcb7so737795339f.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 13:49:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715719774; x=1716324574;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FYw8KFvaQf0/LV5Hio3cBQ21uObKw7TSNP4jDXA/rBM=;
        b=kb9mUMEgFJDg0TNTc6yYDQl1BhVgR7GEy9fizzYYK93rSFqUSH6sX3MLq9/TUrYuWw
         BNP82RUtcoTqNjmPvX5UblyS0FQ7X3BH4D36Fd5qA/7pbIun01KRj5mIb2fAbFZnWZ8r
         b5Rhl5Sgyn/DOdJf68LYBRCENDckj2SrtyU7mCy8MuGwMPKcRAbvoTMYBbj3V9c+GHY2
         WTzLXlM/Lj8tIgW36OnCDhz9FDQBJuBphYRCnfDizWlUZpyNR7PYMH0aZfpJWwlXh32X
         cymUA/tG3bwYSIqjB+ef7XVzAIAryYkIPKvt0ClwRr5HkJZJpIaEwfodnTOKsaneqyqy
         +hQw==
X-Forwarded-Encrypted: i=1; AJvYcCUybB/lPL4o/hD8XmlsGCDTZINS32szeNSFDOi9K15KTOgJXSyT3o3vnk8qY3UIgLU7KsDf1EIECVY6sVEdYeqZyaIsT11nGmmtyQEG
X-Gm-Message-State: AOJu0YxgxGNtHk0XJibGGy5SGDSJFJVTRpxLUXftz52tc9ztRrWSh3FP
	XGbKhpD3Ndc1sTLTy8TkuSRALAbvMCC/Ym8+QlurfkD5ZBrHtCx9twDh0X7Mehq2uvEuKvc6dP8
	t2hvlfXJE+1fB/o69vf2KxRSatxtAUxEtGFombCgAdKPQujA0ckXJ12Q=
X-Google-Smtp-Source: AGHT+IEmR1e6T4e4dH6jcvt49rF3ppJ7qYUv+bUTAmspZMxmj6Hh3g957JgC2hhv4puXafiGWbonQf7VQSH7kTwoD7K84wVPDEZv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:24d3:b0:48a:353c:65f with SMTP id
 8926c6da1cb9f-48a353c0892mr59301173.5.1715719774628; Tue, 14 May 2024
 13:49:34 -0700 (PDT)
Date: Tue, 14 May 2024 13:49:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b3799806187023d5@google.com>
Subject: [syzbot] Monthly udf report (May 2024)
From: syzbot <syzbot+listdf88851866274483e648@syzkaller.appspotmail.com>
To: jack@suse.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello udf maintainers/developers,

This is a 31-day syzbot report for the udf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/udf

During the period, 1 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 27 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 3382    Yes   WARNING in udf_truncate_extents
                  https://syzkaller.appspot.com/bug?extid=43fc5ba6dcb33e3261ca
<2> 581     Yes   KMSAN: uninit-value in udf_update_tag
                  https://syzkaller.appspot.com/bug?extid=d31185aa54170f7fc1f5
<3> 98      Yes   WARNING in __udf_add_aext (3)
                  https://syzkaller.appspot.com/bug?extid=799a0e744ac47f928024
<4> 37      Yes   kernel BUG in submit_bh_wbc (2)
                  https://syzkaller.appspot.com/bug?extid=5f682cd029581f9edfd1
<5> 27      Yes   WARNING in udf_setsize (2)
                  https://syzkaller.appspot.com/bug?extid=db6df8c0f578bc11e50e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

