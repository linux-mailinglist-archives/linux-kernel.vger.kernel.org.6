Return-Path: <linux-kernel+bounces-348804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1D198EC06
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 828BE1C2291A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D962D145B00;
	Thu,  3 Oct 2024 09:03:28 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0531812C473
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 09:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727946208; cv=none; b=eP7ogzbiVoV3cMsjVe6k2JrIqfZp2OUG0kgWA836WjAdU3fx/OAL+PWyKz7IyUUlgMql0SZT30PjnqyOhwwPC1qWHjjXj+7xngPVawZtxC+0831sj5SsQurdH+G2TXTXJUbT6ySV71QcIRxTDfVeSxA393s21ekPbw8moOn3JA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727946208; c=relaxed/simple;
	bh=drR1l788D9mRPiNJFjzNSSN1fgY8nMeZhgMBUbGXkY4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dHPQcDlkks3K61qCWS55UCtdOWOC9eb5efrmKJAJJlFxH4U2iOaE0CwfwrMPX6hx3GbnnSlaqWPmDNDSTfXSaj7N/N8HOmyP2mEPW3l6H2+zWUgWcA84YrppqhDfyA+Idy4DIpAn5HnJM96TWOq/Dsy/Rg4TJcyL9KZL2TRD3no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8324396d0abso73701339f.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 02:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727946206; x=1728551006;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dU4a2t1oKs9S+lHM5kucxZWO5tZk9Ss5D5YXPR7ufkQ=;
        b=QPsWJU63Ohy6bAV6xrqlifsyYiAJMaGrEh2Eol3crEcx1kQZW/+YbKf2zm+lCDWLsy
         8mGFCqv/NfuntnqcRJN6Eaqj+m143LD+9bWnm1fUREg0Q5HzSbHVnv+aPzlwdaEKAGRO
         YZ37Pj4JYSYSzT45dBAVQaRpCdCHB8yrvxj6WFvPx1gd25puPvgNnsC1rw9fxzLlJSY3
         1vT/I0qPPdGHgFMB0w4IdlGPXXOWnnZ7vwGww8D7/x7Ih3bRZko9DQdvYDFqWo5hoLhg
         GV5aunWqAF7R7rkfs0MObNgmNrwAe5GHHnda1OJrhQNI33TEy7DyWWxlrVu3sj6fSdqS
         Vpeg==
X-Forwarded-Encrypted: i=1; AJvYcCV6TyFcnhpdInBXJTkpT+KvJLSZLeVaPceMSuhMdhW+MUj70UjCcoWwNqLAwGqcBacF7MZuviYog2qVKgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIBVekrRMKTXI9aZBngcx/gIyBw/z6NIALLKFjcY7pBA0rehu3
	S9tcJQAs30lSPJD8bEp2i75h2vyl5NJzWREg3csEH/7YK9EzhQZxJs5UtA5Ig2QA/jBP701+seS
	DVEobHXxwNxY1IGmAWzO50Y8RFFMtA1ypU/iH1Af0gV7l01/50wBDNKg=
X-Google-Smtp-Source: AGHT+IGWvTcNXXQvfvJJtLOAawQZqurErzp2lWk9ddQ+qYXfYmI0xMgOC25VglL86kXCErEuI6QnnwcUm0i8/B/ZRdiKdr1u8zMs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a05:b0:3a0:9244:1916 with SMTP id
 e9e14a558f8ab-3a36592b8c9mr54055635ab.11.1727946206058; Thu, 03 Oct 2024
 02:03:26 -0700 (PDT)
Date: Thu, 03 Oct 2024 02:03:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fe5dde.050a0220.9ec68.0035.GAE@google.com>
Subject: [syzbot] Monthly gfs2 report (Oct 2024)
From: syzbot <syzbot+list989caf6985e8118d71b1@syzkaller.appspotmail.com>
To: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello gfs2 maintainers/developers,

This is a 31-day syzbot report for the gfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/gfs2

During the period, 4 new issues were detected and 0 were fixed.
In total, 16 issues are still open and 32 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  544794  Yes   WARNING in __folio_mark_dirty (2)
                   https://syzkaller.appspot.com/bug?extid=e14d6cd6ec241f507ba7
<2>  15162   Yes   WARNING: locking bug in gfs2_fill_super
                   https://syzkaller.appspot.com/bug?extid=ee157488ade46c021ef4
<3>  1320    Yes   kernel BUG in gfs2_glock_nq (2)
                   https://syzkaller.appspot.com/bug?extid=70f4e455dee59ab40c80
<4>  249     Yes   KASAN: stack-out-of-bounds Read in gfs2_dump_glock
                   https://syzkaller.appspot.com/bug?extid=7efd59a5a532c57037e6
<5>  104     Yes   kernel BUG in gfs2_withdraw
                   https://syzkaller.appspot.com/bug?extid=ed42f17ebcb58526788c
<6>  15      Yes   WARNING in gfs2_check_blk_type (2)
                   https://syzkaller.appspot.com/bug?extid=26e96d7e92eed8a21405
<7>  15      Yes   WARNING in gfs2_ri_update (2)
                   https://syzkaller.appspot.com/bug?extid=7567dc5c8aa8f68bde74
<8>  4       No    possible deadlock in gfs2_trans_begin
                   https://syzkaller.appspot.com/bug?extid=5baab0d4d584f7b68982
<9>  2       Yes   KASAN: slab-use-after-free Read in gfs2_invalidate_folio
                   https://syzkaller.appspot.com/bug?extid=3a36aeabd31497d63f6e
<10> 2       Yes   kernel BUG in gfs2_assert_warn_i
                   https://syzkaller.appspot.com/bug?extid=ffe01cefd437cbde362b

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

