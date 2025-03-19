Return-Path: <linux-kernel+bounces-568825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FF7A69AD3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86C5B189D8BA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A479D2165E9;
	Wed, 19 Mar 2025 21:27:32 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C540E215175
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742419652; cv=none; b=SlAOyLm403EEceVHk7CxO6s/fsagS/zlruazQcieYD+E8O3G6gUzllEBANmJcsKBR26jZTEDmftm5hQm8q0or50dXnn6erln3FD06cXqwMiEP+PStKPlJmUk4gQtZ5gOvSNs4Y6FzvP8IqbJJ/QmmbnhRdWYbtxpWVEUfWB812s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742419652; c=relaxed/simple;
	bh=yG4T9nNH2N5xGMJjilcN5AZWkftQcmaDCs0H6C9F1GM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=X/1ehCGCSMYUHQ1kg65kNha1Y1uVlqbsp4xQUiGtZXmD7y4X99DuXsjLG2EbXoNuBjcPYQzNKY4UfMXWVWWQupZqF6NUcfzsUfD0pEhNfOCxfN0iznlIsykWu12/0odt6UYbp+ih3Dy98cJv02bGZw9IO7iCR8DSREJmZw3i0MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d054d79dacso2253195ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:27:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742419650; x=1743024450;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qY/nusyBLkaT+7tx8zhuJubwT7+e+QzAs+yIBZGHAEo=;
        b=S34GLqHaspU+1qAiwPUGxGarxy3RNDgsBsSpEhDYWZHR0YTkqGPMiddjc+adqVXRJQ
         5XAKRrs59V7G3nwbrURvupPWm5kCnv6LDZNOVmZbx0rZVoHrb9Jz5Zc5mBzur7BP49bn
         V+4Jz6YAJThR/62BJMObB3f1p629EoxYfVzkuTgOotkfSHzIi6w+XMydbeDHVDNrWQ/X
         LDG1gMFZgnXKXqFPE4/JGj9M1fAWWpnC1n2wCT+zN7cMtUzwt0Kuke1H9RRQ41JaQXxS
         bOGeDRrOmJTfhsMSjgKd7YSlGGVb+B9V8BQdqeGAkU5yapVrv3xOkydJbVUn15AIkErq
         7+kw==
X-Forwarded-Encrypted: i=1; AJvYcCWO3nqTWrDvSsw6DhvjsoAT97ODwKkWHUlWTqwmZyn7qDs8JVK27yEBsEZLme+7vMAxR98lEr8IwEppxeI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf8Nzi8fXJTAZlQbLnUl8y78aWU1ITJbjWVopojlCms1oCORpH
	1E7ysvQ1EKw8t5N1Z5dpDBqL7ATq/IoRVsI+RPBYg2suSyDWJCPOpKbw6AfU6DA7rPfsW9cy/SN
	eU7lXIXh3Wrw2tMSlMWlp21FRY3FXCq+T8t+lbXx6mBoHx0tGkKDPfg8=
X-Google-Smtp-Source: AGHT+IE8+/yGNnZ1gsnCXBWXO6rvHzVfh87XxnxS3QI8gA8r0RYh5t2hFpcauWtsyJIY5pvRkv0BZ78LcCMD7zMENYvg56eUi9dX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d04:b0:3d4:2306:6d6 with SMTP id
 e9e14a558f8ab-3d586bfec38mr41382085ab.21.1742419650004; Wed, 19 Mar 2025
 14:27:30 -0700 (PDT)
Date: Wed, 19 Mar 2025 14:27:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67db36c1.050a0220.2ca2c6.01ef.GAE@google.com>
Subject: [syzbot] Monthly hams report (Mar 2025)
From: syzbot <syzbot+list33bbae2fb714b9ee1117@syzkaller.appspotmail.com>
To: linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hams maintainers/developers,

This is a 31-day syzbot report for the hams subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hams

During the period, 0 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 40 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 3367    Yes   possible deadlock in nr_rt_device_down (3)
                  https://syzkaller.appspot.com/bug?extid=ccdfb85a561b973219c7
<2> 219     Yes   possible deadlock in nr_remove_neigh (2)
                  https://syzkaller.appspot.com/bug?extid=8863ad36d31449b4dc17
<3> 175     No    KASAN: slab-use-after-free Read in rose_get_neigh
                  https://syzkaller.appspot.com/bug?extid=e04e2c007ba2c80476cb
<4> 63      No    possible deadlock in serial8250_handle_irq
                  https://syzkaller.appspot.com/bug?extid=5fd749c74105b0e1b302

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

