Return-Path: <linux-kernel+bounces-364662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1B199D793
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 21:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1D8AB2195C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7721D1CC891;
	Mon, 14 Oct 2024 19:38:34 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82831CB330
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 19:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728934714; cv=none; b=omC6czSm4PBtxG8abApIFqf0rpLjGEhvuye0nnaviqab5oPY8Ku2JKHWIBE6uI2pvvccOm8hzl+Y6ggdGJKW0mbiw+4ld2/gzW6RuyQJvdTNUXmjXOt+5/ng8/ZUCPMWtRUQFU+dEdQ2rnGq+PLq7Grr1cUaNGAoUi2x4/i8w2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728934714; c=relaxed/simple;
	bh=QO+CSv4VGx8JbUD2ZDg/8qSW4If41pNyKy6Y7gsfac8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=o7wK0TyA7/k9XJlpvFrAgv4bB23dP0gZ3xSB7d+t7CbeAZbOrjaElmn/FymfToKTJDo9PbDoOLhQjCoMZ0eTr4OlcsSMdkhVmcASu2mwUoo1RgQAjabFV9O2wfef+WgmgNMXIvIu73knFz3mHDMgro0U3f1Pvga59Wxq8kTzbe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3b4395dedso35613715ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 12:38:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728934712; x=1729539512;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=myczMVO4FCJEHSfCMtmpEB4pzxaKn2r6djR1Rt0h5H8=;
        b=SZOB8fd5/WcoJxL25BWO7yKkAqxC3+BGleF13irfQFf+W5TRBxJ9INe5xxt1f2k/1x
         kckB/jIredb8+2BxEDTDfeQFz7r7pyyG2msiZNcjCaMPeYth1QTlE9OFrIwiA0fUEIgZ
         vGqbdjbTTxgLytd983w2hvF1CuLUbwNol3Be8IUsYOOBeaPzUD2an+vehdukTCA1gIl0
         CKq0gUB7oJki57J8N4Ehu/9Aai53M2QW9WMdx+daf+KHZf9V2N15Grx5dVG/zPRifc/j
         0ewRSSQtlHIZEk4hl6DZ5HiWOovnFXS7RMgfM1dzXcJ53R7nI8ArqGl+yVwX27Bi3zPf
         wemw==
X-Forwarded-Encrypted: i=1; AJvYcCXx+0OtWbCe2WhTZFt6yn2c1OQTMOwRNWrPDAc+BV8leo+rQaqcwelp8AHcKthXi1eIV0wHdr2RxvsgyPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD7ytf+b1zqueLciZEkPEDM/P1nbwxz3taVelCpjiVuJzeuM6W
	m139kYcP01meIKihV7yz0II94Ela+DXr7UR3CetiVuWAvgYJbLkQ5OTwDqZeepHN4gKol3Ve+t7
	y9rHxnm08AWkUwRgNPcO0Sm/yF87jI5i81T7aclxomdfMvp2UjtIyu7A=
X-Google-Smtp-Source: AGHT+IGiR1esojjd+JJy5DQzMIgxp2crwY+LbYOI5GgIrK48JQIJlod5shIVJmy0jovHGY5I+r6ICrAH0j9ZaJYIREf2pwRW+GvT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4c:0:b0:3a0:92b1:ec3c with SMTP id
 e9e14a558f8ab-3a3b5f785ebmr116844045ab.4.1728934711898; Mon, 14 Oct 2024
 12:38:31 -0700 (PDT)
Date: Mon, 14 Oct 2024 12:38:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670d7337.050a0220.4cbc0.0050.GAE@google.com>
Subject: [syzbot] Monthly bcachefs report (Oct 2024)
From: syzbot <syzbot+listf06e1cd1cd7c615c04f9@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bcachefs maintainers/developers,

This is a 31-day syzbot report for the bcachefs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bcachefs

During the period, 24 new issues were detected and 5 were fixed.
In total, 57 issues are still open and 82 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  12004   Yes   INFO: task hung in bch2_copygc_stop
                   https://syzkaller.appspot.com/bug?extid=c6fd966ebbdea1e8ff08
<2>  5871    Yes   INFO: task hung in __closure_sync
                   https://syzkaller.appspot.com/bug?extid=7bf808f7fe4a6549f36e
<3>  3161    Yes   WARNING in bch2_trans_srcu_unlock
                   https://syzkaller.appspot.com/bug?extid=1e515cab343dbe5aa38a
<4>  1200    Yes   INFO: task hung in __bch2_fs_stop
                   https://syzkaller.appspot.com/bug?extid=6d3e28b33490b3085412
<5>  537     Yes   INFO: task hung in bch2_journal_reclaim_thread (2)
                   https://syzkaller.appspot.com/bug?extid=820dc3b465c69f766a57
<6>  278     Yes   INFO: task hung in bch2_fs_read_only_work
                   https://syzkaller.appspot.com/bug?extid=8996d8f176cf946ef641
<7>  243     No    WARNING in bch2_trans_put
                   https://syzkaller.appspot.com/bug?extid=291aef749c5cbb9ca2fd
<8>  208     No    INFO: task hung in bch2_write_iter
                   https://syzkaller.appspot.com/bug?extid=d8b126a5bfdcd1f3e7c5
<9>  73      Yes   possible deadlock in __bch2_disk_reservation_add
                   https://syzkaller.appspot.com/bug?extid=089ffc4307915afa0da7
<10> 62      Yes   INFO: task hung in bch2_fs_read_only
                   https://syzkaller.appspot.com/bug?extid=c7aacacf99dcfd3475a7

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

