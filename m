Return-Path: <linux-kernel+bounces-332092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5D497B559
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 23:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D2A71C2325F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 21:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD42191F78;
	Tue, 17 Sep 2024 21:51:24 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301D627442
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 21:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726609884; cv=none; b=iH5DBox/assASUxVpKc29h96xfbmDYv3UkWsy9YVNmqqjf1Ugs56IGdFtjVcFQ3tq7tnMjRD5mX2iqxZr3KOB5gTDDmlY8RlYP6uj7DrvmU1F/pHTYPKokuivgUYHeSdCC7Sd0boc3P8fSOg7C1Zv5R85D47M0dAY0RC+vz2TwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726609884; c=relaxed/simple;
	bh=nfPQE0hyAsdTsWbZEGg7yPTOSPBJi8HHg8i8Jkly/bs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ERCqBf5w/uHnDcj7fq+Naweqkmv22BkO7VTcURVJjIB0vl9xOE0h0Plk0TH16ACp10aB29jspNiKV7e/Cqt+NP2dOq5Casq59pLt904TBHNpqAEM0B74FBT/r2A280/yMCfF8wtkF46S/Shsvb1X4QvLfk/xeSkLTeXY0aMfAUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82ce3316d51so942688139f.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 14:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726609882; x=1727214682;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=foE3EDF4SJPXDXQBI6yzznfO4++2n29pS6yS5E+tNN4=;
        b=gxbqDmamKHdY78bB8eDebHAbFpLyoQd2btkksd6TQ7gkv2tVAEsDaKjhTxyxnP1sEp
         5NXXmKst61ht0m+8Vb63l9O5r4yGIqxM2xeeSSSk6l1sVuofkNK3ypyF7pG2oq4C0C+C
         /Qd3xT+2qPyPit6bBvngbXI/RDxJ1pWX2fsNrJC5M3BHvRGH3XUAmssSEcjHzyyPr/Bz
         rxQv10BGTlUsu9EjJtD8/+NJ1G1NSEAFKPucFe9vVMZ349Os7Qk6g691lUWluzg47hiE
         z2K490q2N0PtVxAaiXR4oVIf3GcLl6iB/QeFp17HuZjkPbbTxwkKeLJWg9Ha2bu8dmL2
         uS3g==
X-Forwarded-Encrypted: i=1; AJvYcCXkngSII0Z5PCFONQACQPujqo3fNk/4PC2n5MYBwLi9oUr/vwAGteeKVOXaPTqwegTd2pnW2j+h51W81r8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8F0o8d3qltwZ/6KTi7TUoTRtXi1KDwBfnp4UfwC3irK9ysTpS
	6tAMGzlc38mfTjFb7ppH0OwFd8RRSFcdeKA3f9U1Ekou6QfLdX/p9yny4fo7Hy15eUHzw9zcKmU
	WUIIGKWTYxPdLAoOONWu+EcpTuB8AWNgX+EQTNmE4F9yGB55bdEzhcvs=
X-Google-Smtp-Source: AGHT+IE+sMH9Qq+1RZoge5VRSDxA1IuWlYZK32Y7IOp45hSLo5QmBmXfUAu+SsQDn8kxMvbgSmuQi+4AGtYV6JsTFbrBjVgJ6WGS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184e:b0:3a0:9c8e:9657 with SMTP id
 e9e14a558f8ab-3a09c8ea436mr79730665ab.3.1726609882386; Tue, 17 Sep 2024
 14:51:22 -0700 (PDT)
Date: Tue, 17 Sep 2024 14:51:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66e9f9da.050a0220.252d9a.0010.GAE@google.com>
Subject: [syzbot] Monthly nfc report (Sep 2024)
From: syzbot <syzbot+liste6c9225a61a37daf0211@syzkaller.appspotmail.com>
To: krzk@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nfc maintainers/developers,

This is a 31-day syzbot report for the nfc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nfc

During the period, 0 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 27 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 228     Yes   INFO: task hung in nfc_rfkill_set_block
                  https://syzkaller.appspot.com/bug?extid=3e3c2f8ca188e30b1427
<2> 175     Yes   INFO: task hung in rfkill_unregister (3)
                  https://syzkaller.appspot.com/bug?extid=bb540a4bbfb4ae3b425d
<3> 31      Yes   INFO: task hung in rfkill_sync_work
                  https://syzkaller.appspot.com/bug?extid=9ef743bba3a17c756174
<4> 23      No    KMSAN: uninit-value in nci_ntf_packet (3)
                  https://syzkaller.appspot.com/bug?extid=3f8fa0edaa75710cd66e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

