Return-Path: <linux-kernel+bounces-531719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B73FDA44415
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFF43189B55B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7863226B0BC;
	Tue, 25 Feb 2025 15:14:22 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB1A21ABDD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740496462; cv=none; b=PFtCxIhoCJ6OxiImY/2BUSKTtPOiO/XzazMdaX9+pFD0loXtX+KRt3nW06HKO9rwsee4kS3NQPJq/F7wBjM+YZ4Wn9/y4lSRTw7BEGEpKDY06b5jY53jpHGDpxMLlyL4IWqH8V8OW8VKgAZGxHdjz74OSzGd8pfzqjIsp/rWMMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740496462; c=relaxed/simple;
	bh=pvTGZKSYu80TwXaYGOfuhUqK1pEERbXydrR80aMKOeM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QU6+Jvxhz/Q6ezHbgODk5r1y9Y3atUJ/SvqD8BrtLe2AcWKrdptN9HG6I/uC7sBjG/iIcpU5ClGjsgPWZei4aTWPobGh1sSWMg4PrPr/GAVpYK12CEu3083j1CUkBvh7UitjlLF4SCsc28CVyyX/YcyMBtAH7KiOYjbFs7Whjp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d18fbafa4dso42091225ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 07:14:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740496460; x=1741101260;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LqSNQanHHBGnbJKnLFdL6Ce5Z46qlBWfbEE/8S5V+PI=;
        b=Lwbk/Ljf0EIhRYd+3Ddw9mHGYRw9Mzriqf6rLJcNy7/a26o392E+3o+g8/gmRP/lc1
         0mZ1Pp2Onq4KUyFGZKcVYbbN+33CMlJ/dM7cVjFiMBnf9tosOB8pWv+XRuNGkFcyAyZv
         hQNTsw4+3effJ2WhoAaHWa2omNoMZHpFvy8FWQY69jy0cEVlaPPFk4Ieb6uraJ4gQ7y+
         Nqvj5sOpWJeCz5+awkDCfbwZqsNvQ/1VVT+2CzFCBYKMHIz1m0mekKl648OCu+DEplWg
         IMNaQ0rKXJ2hCWw+654cYiCYOG3ReIOviYP7OGuB1h6drt/fYH4dsk5Sb06Zw1SCWfBt
         4c5w==
X-Gm-Message-State: AOJu0Yx2ST5KZW62TMxn+v+pIYX19CrcgHOusmlg/Rw6w9umm3YSgbh9
	BCSlHflIV19wj3CcSoOcn9NcpmN8uM55OL8naDQyXpPuxyzfHUB4T60wXo8Thcy+hqDIpVHKner
	vGwcx4Y0cDugATwqE+bGd4pbTObn0PDzeaqTyx5/pEMw00guv7noPOvo=
X-Google-Smtp-Source: AGHT+IH3MC8/j7PGYeeZC0YDXVofgXnNz+mKy/4wrNT7+2JwUmuTMwQQcKTr1YZceT8HnSMfSxegHWbDAErP1xYz7lAOvEf+mELq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174d:b0:3d1:a34b:4d01 with SMTP id
 e9e14a558f8ab-3d2ff09ff49mr41356485ab.8.1740496459863; Tue, 25 Feb 2025
 07:14:19 -0800 (PST)
Date: Tue, 25 Feb 2025 07:14:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bdde4b.050a0220.bbfd1.00ab.GAE@google.com>
Subject: [syzbot] Monthly virt report (Feb 2025)
From: syzbot <syzbot+list6b0a0e4de61d18e18ed0@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello virt maintainers/developers,

This is a 31-day syzbot report for the virt subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/virt

During the period, 0 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 47 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 327     No    INFO: task hung in __vhost_worker_flush
                  https://syzkaller.appspot.com/bug?extid=7f3bbe59e8dd2328a990
<2> 70      No    INFO: task hung in drm_atomic_get_plane_state
                  https://syzkaller.appspot.com/bug?extid=eee643fdccb7c015b3a6
<3> 31      No    KCSAN: data-race in virtqueue_disable_cb / virtqueue_disable_cb (5)
                  https://syzkaller.appspot.com/bug?extid=9d46c74b27b961b244a9

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

