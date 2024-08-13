Return-Path: <linux-kernel+bounces-284389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2630C950070
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2BD11F23623
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FC5181317;
	Tue, 13 Aug 2024 08:53:28 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F22017E919
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723539207; cv=none; b=iypdmFKwUEja+oXClYk7T7vzzklhs95M8C7buAgNeds+LTsMmIr2mxYPjFHAOlt+YlzesnessOy2sxKgCwqum9TyokZypUDualt/is/KX91/NDOHMwQCyEUEbnDpE35UZiEKENN4VhV0VKgr5xetuE3DRZYjLqBEzZx6bAhhmMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723539207; c=relaxed/simple;
	bh=YjYGmZ8crfTZIYfPTthho7tbXsQd1/fl/xSECo88FXs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gVni5GRmBLk+jC5qt4uR2UOvNmQDc5SEpt8A4fT6q/LL9FrYABv2jUQa4vPv4NawuApHoUku4KUj14efOjeETnMW97GR716dZSN7pIBxm9TXTXtmbcY7Y9+NOzPwvdZO9MwHOtUNy0SMceZ57dlvwO9L58QCsSLbLdGQadckM6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39b28ea6f37so71049305ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 01:53:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723539205; x=1724144005;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mAMXFIFRKJpj/G/fvrDcZKD/wh5ArnCaafeSsdLbFlU=;
        b=HbwLfPgRB3Dh0JmSE4kqWx4EclIL2TgmNV7THscWbUJznQd2VLvC3giXPINuycBN7x
         /qfxmP/eymOlowLmyYNSMLdrVu4zMgqNatXvqoxTuMOYhIXrDlGvuMUkLoJwarj3FXvX
         bWbiw4Ae85JRYzSMXo/gR2GBOi5fqSxRoNGI67L+9R/4Q7rRawmZa8g0mxUJUpQOK3CX
         oh2M04BtzlNtqXLBGXh4ZUqpcs3bxvwu+I5Rv6n/BkSuTmkoVWWi7wZOcT40OMZaicqj
         D/hSzV3CG5TZKg29BSStNxI0YmYYC8VuVcwhBaSMM6KJxAJX4PQ/eWGZr5ug8eqG66QP
         FAuw==
X-Forwarded-Encrypted: i=1; AJvYcCUttZhBV+KxI/kU8HXjdkzhZvjSZ82aZ24JCF0xp0HjwOH81RPfJpbsnpkPcpMs7O1nETnHfZ9mCle7tyzCQuzR09eMdOYZ+nFL4xWo
X-Gm-Message-State: AOJu0YwyKSk9VZThXtbWFSmGiVDw+KPrs19ASSfXuDxOUhRYxcs8oq5W
	++Wv//WXsTQR8gE33o+N2ywljmA2GV8u1XFqDv9bjSxfmoNP/b/4uHTrvhMy3iuYYZeSRtQAjQo
	EbD5BB2oLtpnHjAcR01iACSZ5SvtBFmdtMonyVO3waGteUJm7iSsyNU8=
X-Google-Smtp-Source: AGHT+IGgUBDALvrCrch7SF4UhE1THnJLvppqL5MqTLE/qhTaObGjrIme1a5PEaBE0wlQoNOxDYlfySuDnncaQ2rH5K+aYMwnzddx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160f:b0:376:417e:c2ab with SMTP id
 e9e14a558f8ab-39c47912e84mr1765715ab.5.1723539205554; Tue, 13 Aug 2024
 01:53:25 -0700 (PDT)
Date: Tue, 13 Aug 2024 01:53:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001a9128061f8cbee7@google.com>
Subject: [syzbot] Monthly bcachefs report (Aug 2024)
From: syzbot <syzbot+list88c61bedfe3e28153b24@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bcachefs maintainers/developers,

This is a 31-day syzbot report for the bcachefs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bcachefs

During the period, 5 new issues were detected and 1 were fixed.
In total, 71 issues are still open and 52 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  4330    Yes   kernel BUG in bch2_fs_journal_stop
                   https://syzkaller.appspot.com/bug?extid=10b936c5eaee2819b49b
<2>  2944    Yes   INFO: task hung in __closure_sync
                   https://syzkaller.appspot.com/bug?extid=7bf808f7fe4a6549f36e
<3>  1364    Yes   BUG: MAX_LOCK_DEPTH too low! (4)
                   https://syzkaller.appspot.com/bug?extid=46405fa9afa07e6c8c40
<4>  398     Yes   KMSAN: uninit-value in bch2_alloc_v4_invalid
                   https://syzkaller.appspot.com/bug?extid=3b2968fa4953885dd66a
<5>  246     No    INFO: task hung in bch2_readahead
                   https://syzkaller.appspot.com/bug?extid=a6060114362257e9798a
<6>  221     No    WARNING in bch2_trans_put
                   https://syzkaller.appspot.com/bug?extid=291aef749c5cbb9ca2fd
<7>  215     Yes   INFO: task hung in bch2_fs_read_only_work
                   https://syzkaller.appspot.com/bug?extid=8996d8f176cf946ef641
<8>  138     Yes   INFO: task hung in __bch2_fs_stop
                   https://syzkaller.appspot.com/bug?extid=6d3e28b33490b3085412
<9>  86      Yes   possible deadlock in bch2_gc_mark_key
                   https://syzkaller.appspot.com/bug?extid=050e797ad21ccc3f5d1a
<10> 82      Yes   WARNING in __bch2_truncate_folio
                   https://syzkaller.appspot.com/bug?extid=3d11e35eeafe176a6c5b

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

