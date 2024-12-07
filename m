Return-Path: <linux-kernel+bounces-436057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1D39E808D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 17:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1539A282D3A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 16:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026BB14E2C0;
	Sat,  7 Dec 2024 16:13:30 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E1B14AD3F
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733588009; cv=none; b=C7R/5OXK7vB79y4a6gnGfgt/oMRtwyOkjCXOXbC/cA0hN6eSOVOrCN64zB+wfV3RvIb92GVyVdrjJkwQaTLaa0NT3bZiH7sUeprSY0muGDaAbqVigp7aVB1ZH+/qTBnSJNN2BEHTYTRS/RWSbzqGdn8RXAqeyP9QnbJDXnS2h2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733588009; c=relaxed/simple;
	bh=XUHSZQQSYkDoekv/qHj+HpewJonX3WiLq814271Dryk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bUp9JQn77HPg8ADRl3YRPZZ5/K2rDS8k8OrUMWP61U+Af1jQX5DGsY9ZoSDFzn14CpLmw4TjFxbBlnMoDDsES6eIVgMUYhE8bj6NIDVeqJPE0rVzohuGp9F1CJ7yHW0JOtdnpoydip3lgcbR9Y3IKXGnNDp/LngZ+xG3pSeFmLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-841a3f2aebfso303581739f.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 08:13:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733588005; x=1734192805;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qhzxDwbCKq+JPBpgwoXjwLiPNtdks5c8N/aqFvEki9k=;
        b=S3N3xNWH5mgU4zpWl1r5QdinDBidN4qMHQt/1SpCEjo+mwWpt2wjBpn0X3wDql34ui
         Am89HhDHnbaH5f00SWc+p99wQL2Hp3pYS6YxiGEegvYw1jJe7/pmNTVwEUbAiHbo+x/m
         n6wl2IgAGyEGmJFvPbYiwChIAE+fBXVgdy5J+v+Te4vzmMgPaYEp3PssO0TgGSXdg5Bd
         dYQUWD7eyPXOssgZqZLsEHMDEf2FAsie35Lq5IggRdxmEI6eVWdchV9iGPSvu/7FqaJL
         G+/qFQNa6BzeJCWPf0e+e8FssrsSevEmHYKnIUz5qnuBIjenZgFEIeF9E+7etxPkN3wX
         FFHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqsJijc4v5E5ri+dxxlpeNEp2jNKnTwYQ4GNehhNSz365x/nlUMz2GiIo0zyc8TbXjYZCxEb5H1dEmdgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb9O/m25F3Nf3LSHmRoemrM2yBYoM+uR4N8SwMR74czwNVy0dq
	q8TpVDJs0uMvXgUqSRdg9nPON8Z7twQCFJePe+gdhKIb5BKvpFT0q4WMVoCHOx5mZBbLin5iU4P
	egCeTcBrRF+8RbPHnlYM8XP0WnkHCnjpX33Rs3NAoCpKFtXkDnp7QpjE=
X-Google-Smtp-Source: AGHT+IFEATkXgz2VvopKjAnmUJQ9g8FTzvOI4HKq+jh61iR/WN1sLq9AcM63t8f5v134v7ygI5kH9sH4oAi9R8unKpHc57zwGXtE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d99:b0:3a7:e732:472e with SMTP id
 e9e14a558f8ab-3a811c616c0mr80851425ab.4.1733588005325; Sat, 07 Dec 2024
 08:13:25 -0800 (PST)
Date: Sat, 07 Dec 2024 08:13:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67547425.050a0220.2477f.0019.GAE@google.com>
Subject: [syzbot] Monthly integrity report (Dec 2024)
From: syzbot <syzbot+list2eccd137a466e6acfa54@syzkaller.appspotmail.com>
To: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello integrity maintainers/developers,

This is a 31-day syzbot report for the integrity subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/integrity

During the period, 0 new issues were detected and 0 were fixed.
In total, 3 issues are still open and 8 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 433     No    INFO: task hung in process_measurement (2)
                  https://syzkaller.appspot.com/bug?extid=1de5a37cb85a2d536330
<2> 32      Yes   KMSAN: uninit-value in ima_add_template_entry (2)
                  https://syzkaller.appspot.com/bug?extid=91ae49e1c1a2634d20c0
<3> 2       Yes   INFO: task hung in ima_file_free (4)
                  https://syzkaller.appspot.com/bug?extid=8036326eebe7d0140944

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

