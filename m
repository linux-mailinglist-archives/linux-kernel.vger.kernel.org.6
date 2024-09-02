Return-Path: <linux-kernel+bounces-310818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA709681A0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC0831F22721
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E728617C9B3;
	Mon,  2 Sep 2024 08:23:31 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7CF1581F8
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725265411; cv=none; b=YdlNSATv5cTZyb7bksGYLq2b45Jbg9Wlm3Y5KoZvRcPvx+mlD9aZlQhJtnVsq8Dk1Fa/RrfGj7TtQr+LrHksZjgXarpuxf/2aIxluHafjOSjSQoi3IaRrQiHF9IL7N0E/vJ2gmQ5f8OILjzOCc23zcStcSVKHaQck0PmNKwbptQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725265411; c=relaxed/simple;
	bh=EJv4FPFVzF3CHwZkg9zSnK57yGyWwOdANtqk4VlUAjo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mW3XKIEfwVAQ0GINiv1wWDn4tjbF/zg6u049Kqb2sh62A7G3iRlA2/hEU28gxHy1zgY0Uy3P44sR78I4IyhRRw4XA8We1+1cYqVj49PG8FdWkUfq9vJn97C+0izKBcS/wxWpzeIMH8DgyUl/4A5aoEfJkrNkGvReXhc+GoiG6JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d2dbd9bebso49979435ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 01:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725265409; x=1725870209;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XIDqZTfcmAesPh056iiL6+G+IkZun7sJwDyjRNdHujk=;
        b=rmW4n7h//iNZj9lVNrDL7DBFm9oHzYvprPbM2k12dc/NquClVNB2XiIvAouqURfphN
         4aQMnzkhw1JScbd3sxktnLKzen1rnChu250tFs43AQFkV3Ngy2qPBkWqy3K8LJObR2K8
         nJUiC09gZSmscVlC4D+iFfaLRT3uHiqEyHmfy26gG7LHcowiHhXftqP9nc/wEAxdy+Ym
         MX2fuHja1ar3lI2z85vkI71CPbXM4WzZV/lKywKi1RsXPJqPM3TY9teQ7KM8RE5DcbE2
         J26TumfDpNaR0HA2NXCuJlZeY3sB4I1pRUX13EkUKgWO4TZou2qJzdLKd3/6VGBwk++b
         PrHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAjKld2FZ6LzXU/5TqyUwC+P0BgV2M+qTnwWnuvIX4JZcBHNE5w3i+ufxJDrfhLRpA25Xspixto8iuxlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxqPz/8x0K5ROA6jmtKpyUZEbs0yyg/IBuHzU6vN0q07bnJknH
	vd8iJmVnqWXlDF6LbAGmGdwupfGk6uEUua3yfHXnHjLUmRfe5e9hIpiKzipukhNoKWTzALLT1xI
	PyPHMto8cEGIDiHV+1AkxtoGnNVRG+yAITQ33vZj9nI6oVHLUiWLGDSk=
X-Google-Smtp-Source: AGHT+IEhfipKOTuBHZbInIdSOCsUi8fvMuRBzcUPtmpuZPlWy12gnt2/L65lTGfvn8x1kfR/5kUwEfQNMOwAJZF8Fkc1GAx8vKd9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a1:b0:39f:52b4:ba41 with SMTP id
 e9e14a558f8ab-39f52b4baefmr3609985ab.4.1725265409379; Mon, 02 Sep 2024
 01:23:29 -0700 (PDT)
Date: Mon, 02 Sep 2024 01:23:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dea27206211ea733@google.com>
Subject: [syzbot] Monthly perf report (Sep 2024)
From: syzbot <syzbot+list4e6906a01c6f7576013d@syzkaller.appspotmail.com>
To: acme@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, namhyung@kernel.org, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello perf maintainers/developers,

This is a 31-day syzbot report for the perf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/perf

During the period, 2 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 22 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2373    Yes   WARNING: suspicious RCU usage in get_callchain_entry
                  https://syzkaller.appspot.com/bug?extid=72a43cdb78469f7fbad1
<2> 59      No    KASAN: slab-use-after-free Read in uprobe_mmap
                  https://syzkaller.appspot.com/bug?extid=ab687d3cbad90def4b18
<3> 8       Yes   KASAN: slab-use-after-free Read in __uprobe_unregister
                  https://syzkaller.appspot.com/bug?extid=f7a1c2c2711e4a780f19
<4> 6       No    KCSAN: data-race in _free_event / perf_pending_task
                  https://syzkaller.appspot.com/bug?extid=ef3b1bb7dd78b4e9109c

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

