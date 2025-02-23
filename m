Return-Path: <linux-kernel+bounces-527985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A2EA41204
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 23:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E2213B44EF
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 22:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1CA239096;
	Sun, 23 Feb 2025 22:20:30 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE226EB7C
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 22:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740349230; cv=none; b=IBPtQ+TAYspu2xaAuLeqjOLfguMveNkuzodWYI5nO/E+u/qtJlRg85EaSS0Ugq2hWjqoZO34Bazi+L5NTmMiJfpOzPFXmfghKTXu4fb6DFDtdiI78LZaNeLb1bnXftnUvgVd6RBkBvoLd77qrP6FRYNvKlwxlaPXkF6lyRM0xiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740349230; c=relaxed/simple;
	bh=SWnh5rNvNspb8eiJWUQEaB8a8aoS9VKL31z1twyGdGo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ts2Hed1EKMhRF1Vg/tEyTkURJfyucrB2ZxVhRFsYj9xSJpxhVWqOpeDrXkqgEL7vSL/TMF6hhSSv4+rOppkElCbhIv0/ggRo/FWWcT4QTiULWPlyrOBMH9uiQOUvHQVrTq1vz1NGd3ysw1Le2dk+moCyDkKxxHDH7QRkonf0Qwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d2b6d933c1so67225665ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 14:20:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740349228; x=1740954028;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QShPSqIb3IFVQqZB/tGogFLEw8lwGPmLzmRCWSLQME4=;
        b=AtcF9AHFO/uQuo4vJfbwB3b8MJcfqnq/kYBXZNsaZHdUwhG1ywPA2KfvFQ6cuqrUmx
         1mB87h7boI9DogswkG0I/o1gRd/MwwF6Mtpqr1yHVthbP/b3UJbbVQjZjRsIT3MdQ7mb
         zn8ji7HIF8K/ikhRyadAoIOpFcJFUP2/4JWPYy7zWMwqNFo0uui+YnLHemQuZQPjzAUr
         pYXdbuudLyoYCGth+oEhchqd2sPRgsqQNra7psR+dlKMWs2FBl6bSANMfHwydQXMSCAZ
         p1EUFZSjXt0X1rlNw9NRN/p/eIVe56vcjcVl7XIzr2CiQJ7yCZ7Qg53R/f3l7aGzCUp8
         uaAg==
X-Forwarded-Encrypted: i=1; AJvYcCUu2A/rz48SozLcNMm1/N8DXZUX0wxK1qRgAKPErlRFmsoxQr2+T4NWCqN9G19RMfO4rXKzuHlIk/VmvKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YydvQFTTcUAZljALdSmRqWLvBlVDPWoglNdGD/27PskrvWPAoLE
	Vacyvp/63RRq1qQDNnBGFXt8Eon9F9ttQFvGRXpRSA4yDrvytFOiL6waMSOziw1sDEdfWqYE91D
	YGRTyKiFC6xRsMi9/6keQQtLNLfbUsWwZOYV5NnZiaLGfpmCjILUUhTo=
X-Google-Smtp-Source: AGHT+IE9ZGEQf5LlFyUfdyj9yYo6OQ3jgADdANVyAa73H/rVA9obvtwqYYr8dmy0bMKVgSdlOp7vXgRUHxkrot4tPCxwGa+WEQET
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c0f:b0:3d2:b34d:a264 with SMTP id
 e9e14a558f8ab-3d2cb492863mr116015355ab.12.1740349228038; Sun, 23 Feb 2025
 14:20:28 -0800 (PST)
Date: Sun, 23 Feb 2025 14:20:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bb9f2c.050a0220.bbfd1.003d.GAE@google.com>
Subject: [syzbot] Monthly cgroups report (Feb 2025)
From: syzbot <syzbot+list7fec1c4497e9462aa056@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello cgroups maintainers/developers,

This is a 31-day syzbot report for the cgroups subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/cgroups

During the period, 1 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 38 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 4312    Yes   possible deadlock in console_flush_all (3)
                  https://syzkaller.appspot.com/bug?extid=18cfb7f63482af8641df
<2> 3250    Yes   possible deadlock in task_rq_lock
                  https://syzkaller.appspot.com/bug?extid=ca14b36a46a8c541b509
<3> 98      Yes   possible deadlock in console_lock_spinning_enable (5)
                  https://syzkaller.appspot.com/bug?extid=622acb507894a48b2ce9
<4> 5       Yes   general protection fault in __cgroup_rstat_lock
                  https://syzkaller.appspot.com/bug?extid=31eb4d4e7d9bc1fc1312
<5> 3       No    BUG: unable to handle kernel paging request in memcg_rstat_updated
                  https://syzkaller.appspot.com/bug?extid=c62387c3885ca12e1255

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

