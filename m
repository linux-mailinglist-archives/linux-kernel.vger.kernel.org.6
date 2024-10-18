Return-Path: <linux-kernel+bounces-371157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF229A372A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 747181F2290D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1272717BEAE;
	Fri, 18 Oct 2024 07:31:32 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4217E13D51E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 07:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729236691; cv=none; b=qWKn5WBQ+kMwO8Vjo+SjOh13+0AvzT8WKppkO+GwcqG58NARA83E/w6/lsNrISJrozE/3MsJczPLpR7hKerN3bjigeqkd03aMpsK05756sv7utcLhaWSdZouf2lzVj2cwTJ/1iDi0mEIwYBJMaOI0AWAWVb/H8E4uwHEiN3i57s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729236691; c=relaxed/simple;
	bh=FwxLymgIGX19bQ3q5+ZUKoMF7qjKIFs/m/upHfQjmJo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fkpOVfqQVrLp/2SNHB7JzrQx3FpZ4j94oCGFpSJODtFJU2Hqz7SBue4X4ipG5sZgUZcffS6+6XhyKVYdbMWadSBUNGvHUNehhBRLoorfmiSoI6f0u4I0jXoA6BsqxLO4tb3oy0BoqyG9VcqEkx4F4jTSDvAjusGGcFlZxkkl97s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3c27c72d5so16133235ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 00:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729236689; x=1729841489;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GzXkhfT9/F2JC3M0BsEDAkKgZtNlAin3Z8M1bsi6SHM=;
        b=rVXNnwUfsH9z1TeSuNe7KRyCXe3EWlJKEO5wgmi4cjBekbXkRTHSCoF4epgxF2PSBB
         UJvxwDyR5OuTyf2Fl1kN7tLSUwWOzVe451hz53WnGh/q8aP6bwLGPZsTvZwQM5bNDobY
         nnVjf/LxYcgUf38LSPs0TsjOz83Lz1Ov1VqqC+ov/ODzWIkcpJnKwLEOcuAqkgyEQw/R
         sTR6O+MwoTdEkhotrG5Qfw3ja8ICy2mKKjWF8UG9KVnV4PMp091CNMB/yyvgTmbQ18ji
         OpLIXFFLZGWNFlt3WxzGuxeb4L9In0D5utfbDIMr9G1uLbfjoKrlcCrnBNYBgLm8c6KF
         Re9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLETt8qFV+NZfLt/0LWk1tJ+Dg9P3LXbEwRYRLbpiy3h1fG+xnFQEx5uNBe3QiAVDpkqlgTuXY83UYWRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGitBgVbbm5JgCaOTMEjz6T8mHsJWkZNEURLfcDQHAeA9uzxuk
	xrfrR4F4XSQ5yUABE7/PV5Lg6gLPsV2sDAAlFIB+lbbnKB2hX/J1Axgy7uAmexejyHKKRAfAv4e
	C/zEcKSTXdLl2G030o6PUZgAldC7Xd1nXP/ewYj5Db0B0qQSNsobLD4k=
X-Google-Smtp-Source: AGHT+IFySUjvgG3Fl/szHy+Coj3vJjzvXk/L63ixiuhUZyvUQfFUQNj8qSben04A5CXrGYP1+XPl4tfLrEs3JS28u6E47iL5hN9j
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1389:b0:3a0:90c7:f1b with SMTP id
 e9e14a558f8ab-3a3f40623e0mr15094615ab.12.1729236689484; Fri, 18 Oct 2024
 00:31:29 -0700 (PDT)
Date: Fri, 18 Oct 2024 00:31:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67120ed1.050a0220.10f4f4.000d.GAE@google.com>
Subject: [syzbot] Monthly f2fs report (Oct 2024)
From: syzbot <syzbot+list5742c28e505b5188ee8a@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello f2fs maintainers/developers,

This is a 31-day syzbot report for the f2fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/f2fs

During the period, 3 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 47 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1071    Yes   INFO: task hung in f2fs_balance_fs
                  https://syzkaller.appspot.com/bug?extid=8b85865808c8908a0d8c
<2> 70      No    INFO: task hung in vfs_rename
                  https://syzkaller.appspot.com/bug?extid=6165bc9800cd6e1fe958
<3> 2       Yes   possible deadlock in f2fs_evict_inode
                  https://syzkaller.appspot.com/bug?extid=7988d9999219aea9f2db

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

