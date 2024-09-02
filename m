Return-Path: <linux-kernel+bounces-310811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4ADC96817E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7150628191C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E06154C00;
	Mon,  2 Sep 2024 08:16:25 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF658460
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725264985; cv=none; b=F+Cf5o33m5UxCvA4LmBqswk5TxYPhVU6+JoOPApdVYYbX1j+cAzVhsqWKEZmS3Uxqsx2YgTVu61FAyMI9CDxiVH1nzO5GbondOMUWQWNSs4CS2wbHDt9gNgMKHDzFJL8eX7tlFl3xtpaYp0oBOHi5HhkSCJlzpakWoMWBOXSmtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725264985; c=relaxed/simple;
	bh=EUfnylJ9vcVVnHFjzCZbSJNlUPnVZhXEp19cEn3v6/k=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DWWhjmEKhmr66gh4B7rs6buEq3bnFA5wZDMluNJWMOTp4NVqh8yrDWd/++Niks0fH4c/M2HfZpTPbrtkUYBurwMdGty/wryRFZh4TrCalzSQK2IFxwLePxs34KZHoeBMlNYn5Dd3XE2EHh4kf2uF2qglNGAe6ni7AKZXHwyd16Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82a3754a02bso246994239f.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 01:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725264983; x=1725869783;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IlzEK6zx3drWd3CncPgWRWy7MM37kwdWJowE/D3ZMeM=;
        b=ookiHzrZeJKlIijkIU/o3ctU5r/c2tREdp+FoXc2+P8vANY1znYHvs4JRDr27Oyhke
         F/8sbUgEt3oYPukoABplpYhno0ExW/z2599Z5JajjhSDmh6JecNtc5MVMI77nBypJCkr
         brOLDjkoJeL4hwbSeO/rRi+JtexbZ7yFUsgd056ARq9JL6WDe1qkFUT5kkXUsOcUpqNJ
         RRQzaJHMikkDZm0LK5CW1yX84bAkb8gxVTwMJD3zKbTrjlhBpprWAmLKcgozUmj2A4QJ
         0ujffVK4UKibwpypX4JDzqyi6MmkhH8gZuSXdHywCSUTjtbvaUsSihnsi1D8cQ3vnp6N
         qHLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyYMM9EmRDmixbVDTKvcAHtJQeDrlYfhUYSzd0vk/mslpePwPzM2crk3USVdsMo/1FXV2dfX8uLxRQLa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAb6apC/VT9wb/5ygLyQldEAe+hnoOeLQ2CcoSV2ma9I7mIQUX
	aqKOB9UbCcLJJPy20Y0HxccEJgE21T4qk2E0/3aQVdY1kFLPsB5MVyaB9IQJumkcu3XltH2mOds
	o8IRYQ8EdKUy+52A6z4c5IRGm4umUoIyeNKoY6f9UHgammkDPo4syd1I=
X-Google-Smtp-Source: AGHT+IGGzBjTn8zhxjXURsJ5Ke9dm5h0xdeNcY9l8qdowHxE0xjcsWGhUNCfw0xl3Ot7xvoOOs0cYOdp6sqve7rahkoZCW5yU3IF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8904:b0:4b9:def5:3dcb with SMTP id
 8926c6da1cb9f-4d017d9e27bmr527376173.2.1725264982887; Mon, 02 Sep 2024
 01:16:22 -0700 (PDT)
Date: Mon, 02 Sep 2024 01:16:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000072e00806211e8e96@google.com>
Subject: [syzbot] Monthly gfs2 report (Sep 2024)
From: syzbot <syzbot+list845ba4eedb2e54c4fd28@syzkaller.appspotmail.com>
To: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello gfs2 maintainers/developers,

This is a 31-day syzbot report for the gfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/gfs2

During the period, 0 new issues were detected and 0 were fixed.
In total, 12 issues are still open and 31 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 503750  Yes   WARNING in __folio_mark_dirty (2)
                  https://syzkaller.appspot.com/bug?extid=e14d6cd6ec241f507ba7
<2> 11978   Yes   WARNING: locking bug in gfs2_fill_super
                  https://syzkaller.appspot.com/bug?extid=ee157488ade46c021ef4
<3> 1312    Yes   kernel BUG in gfs2_glock_nq (2)
                  https://syzkaller.appspot.com/bug?extid=70f4e455dee59ab40c80
<4> 221     Yes   KASAN: stack-out-of-bounds Read in gfs2_dump_glock
                  https://syzkaller.appspot.com/bug?extid=7efd59a5a532c57037e6
<5> 29      Yes   INFO: task hung in gfs2_glock_nq
                  https://syzkaller.appspot.com/bug?extid=dbb72d38131e90dc1f66
<6> 14      Yes   WARNING in gfs2_check_blk_type (2)
                  https://syzkaller.appspot.com/bug?extid=26e96d7e92eed8a21405

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

