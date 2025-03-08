Return-Path: <linux-kernel+bounces-552841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5D0A57F47
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 23:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C7C93AF224
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 22:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823E320CCD8;
	Sat,  8 Mar 2025 22:16:27 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9791531F0
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 22:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741472187; cv=none; b=UygQl5maUme+BRtRWqlJyQPbwocAZHcB4AVvMfDIL+i4nkQNHXCALUMwNeAyx54rqzSRqUBXrugVUUgfDyIAhtGpZAecDqpmErVZZ0O6rut+wZFX2ptZLhIvHpV8/duMDpgoKb6oyVf10Pr7kaJKoisM6ZsB/w3i5bdm35W2fkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741472187; c=relaxed/simple;
	bh=AZ6HEutI1ya5K1fyoV/rqT20gBMbCiNoZehfNeza3PQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bqzzn3CSYae5zWJcqFWO/G7p5YQjj5Tujey7hj6JVPC7ah6RcJCGC3HUHuJCl8VKdXRvBVqJxbdzFfmkQNvbkrAsLlTQFFSN9hmGSQmDM3ylzUvvKim/e+qfS/VNxcUfrkgP1qqJQij+o9UYsO9x8edeXSQR9zuhDsjbwb/mdSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ce3bbb2b9dso30248585ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 14:16:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741472185; x=1742076985;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nvw8mmHRWv5fTemUVzBOD4h1wuNtwJjKC4LeykE7LA8=;
        b=pLWFBzFijlLo8Lx/i2cBMPU0xCGBBWUfSrH60gcBHDZnBuI9pHzxKPQ5e0TsudMxUV
         cV1mebzh7uKqX9Xq+Nd6/JY/B8PMh5Xf2XYWK6W65ow/M7AB5iZdt/x1NR3UzWc+pzcy
         wr3WE4//0TKTtAlqkChn5qbFvUQ2tJuwnbPWMYIaYjxlNgxv6tKUap0qbn3SjrmDfjnu
         t7H681ksUGmmG4y+kPjauQXOGLFuIR+4GnN+mRccg4bW3BPo2XSHNrbB17Z10TffHW/C
         2klVOghVWYbf39dJsL23GJ4l8E8rvuo27KR2Ti6hjaQ9ljV+bIalOxMYsw+yNxry5Sec
         vDvA==
X-Gm-Message-State: AOJu0YziGUa9SubnoT/Bt7/bujW4h4ewN+FIy721uUuNTDqXS4EsGqav
	a9YeL6XRKaAddusPWFQrji947iyOD6OamLxMq3FMFOx1W3wFpiFZWckE3PTP9I2tMRY6AvcesIu
	/7bA5N98lYaquDcZv6XtZGmuH8LZqokw0LxaWnaYaJbXAb7JB+8aX7ko=
X-Google-Smtp-Source: AGHT+IHqR/TmjF5yy0a436si1V2miEf/+9cO9pfVNgZVz1IxfSo/5/RZwwMypAT3/Eyvp7FWidMIsdB7fZ4WktBNUapCZiDF3u62
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16ce:b0:3d0:bd5:b863 with SMTP id
 e9e14a558f8ab-3d441a1d665mr87756715ab.20.1741472184936; Sat, 08 Mar 2025
 14:16:24 -0800 (PST)
Date: Sat, 08 Mar 2025 14:16:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ccc1b8.050a0220.14db68.0058.GAE@google.com>
Subject: [syzbot] Monthly mm report (Mar 2025)
From: syzbot <syzbot+listf46e9233db143e95a163@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello mm maintainers/developers,

This is a 31-day syzbot report for the mm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/mm

During the period, 15 new issues were detected and 0 were fixed.
In total, 136 issues are still open and 282 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  10454   Yes   KASAN: slab-out-of-bounds Read in generic_perform_write
                   https://syzkaller.appspot.com/bug?extid=4a2376bc62e59406c414
<2>  7391    Yes   WARNING in ext4_dirty_folio
                   https://syzkaller.appspot.com/bug?extid=ecab51a4a5b9f26eeaa1
<3>  3633    Yes   INFO: task hung in page_cache_ra_unbounded (2)
                   https://syzkaller.appspot.com/bug?extid=265e1cae90f8fa08f14d
<4>  3318    Yes   INFO: rcu detected stall in worker_thread (9)
                   https://syzkaller.appspot.com/bug?extid=225bfad78b079744fd5e
<5>  2561    Yes   possible deadlock in filemap_fault
                   https://syzkaller.appspot.com/bug?extid=7736960b837908f3a81d
<6>  2298    Yes   BUG: Bad rss-counter state (5)
                   https://syzkaller.appspot.com/bug?extid=f2bbbb592debc978d46d
<7>  1765    No    WARNING: locking bug in __schedule
                   https://syzkaller.appspot.com/bug?extid=46b40e354b532433eeef
<8>  1612    Yes   possible deadlock in gup_fast_fallback
                   https://syzkaller.appspot.com/bug?extid=63ba90b81c16b86379bd
<9>  1260    Yes   WARNING in vms_complete_munmap_vmas
                   https://syzkaller.appspot.com/bug?extid=38c3a8b50658644abaca
<10> 640     Yes   INFO: rcu detected stall in corrupted (4)
                   https://syzkaller.appspot.com/bug?extid=aa7d098bd6fa788fae8e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

