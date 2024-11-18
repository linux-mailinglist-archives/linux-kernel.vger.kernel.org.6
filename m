Return-Path: <linux-kernel+bounces-412776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBF79D0EDC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75A2B1F220E0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B95E194A53;
	Mon, 18 Nov 2024 10:47:30 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43311946A8
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731926850; cv=none; b=sN4vp3CYvznqIsieyj/IUv3HBjmJfbcMA8l0Tt7Am4lzkuP2Zfm36xaVQWDHtT/sdTiZi1Ibc5epFe43EqKr+wIFu5cyID4pSjo5bmRo7xuDXr7ZSOZt1e9289Ew46LcJPGj1C7jk45YRgIyv21yRv2WJKPtZqUUdx6Oc/UOKco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731926850; c=relaxed/simple;
	bh=G6acRCPoaZczBq5eKWs9aeIGIsazsljPP+Q9fwjE7bs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dJAuXppoYdm1srl3jGshH5SBzfrLGS6gfPu8N3P1A/NgOjSbWLsahR1aU2YY4OjTDjbZAIua+xFdhTe9fMdPyY9lPVHl8y7l87+ffG5JRx1t/wjszo1GtPQaFTuoN/C+JhPhM+fBlw45/XvICBkotIdbvc7pI27tdLaJ4Fcb3tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83e5dc9f6a4so381916639f.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 02:47:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731926847; x=1732531647;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iCGgr6jF62CkKSpy2KgTZ0e2y8a5/93+Gsn1jNtML9M=;
        b=ESjbZJ0Ia1nsX4vw2QT6TqXxxaCBIO7fL4EeyT+TmYz/VET8h64Dd0B0wG+vpqkLxK
         Ii1nFIRc4GUqqaX80RYjIwzT57u8/NL1/cT+ZefYXPNWp1sz8TjoyFGHZKr6H+Vk+/xH
         2A3qHP4DfP6tUd/obQ5LHZkz3m5HML+Wm2Gbca6n7KtsWcZh3M0msXccpF4op3LC2vrn
         9da3kU0qMlaJ1W6PlPWsurIEdpfLUdL0HXNGgZ0a3v5nBIHg+HJ8+wV0GvGTL+fvKnz3
         Yjyrk978U45PMN8j5xzsa6oMLnh72kh7Is/QYlrCQG3qmG9kXfN4kYRdHqFn1LTHKgqk
         r4Nw==
X-Forwarded-Encrypted: i=1; AJvYcCW59tbdT1tiIeIUPH7DOLD9uDhGS2Y64fW8y/i/ae6XBBStJru1rKIps+hbaNpUntdL2mucjZiAuC/IyMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbFXLAWyIpzQgCH5/Lod7vcWx1UdPks25KF5HY9+VU6/UFaiT8
	h8D/rTthvvL2MeEsSi4ttWlaub19Rip7rw5sVyV0acDf4GcGl47HUY7ea1/7tVWVYVOegtvzA2v
	ZIo49bGIYI38wFvKTP4g4FB63rkVhuHlYP662o8k5wsUyXsmRuQcgTXQ=
X-Google-Smtp-Source: AGHT+IHwrHHy5srwaOBswGeP93PHi8Hlax2OH+m5lHO8XGWR6Ai99a8C9JbZNy4YdZB1PelkzyOVYWMPinLs3P0ixIEOD4LRu0Xc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd8d:0:b0:3a7:6da0:9a00 with SMTP id
 e9e14a558f8ab-3a76da09baamr8637285ab.1.1731926846872; Mon, 18 Nov 2024
 02:47:26 -0800 (PST)
Date: Mon, 18 Nov 2024 02:47:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673b1b3e.050a0220.87769.0032.GAE@google.com>
Subject: [syzbot] Monthly udf report (Nov 2024)
From: syzbot <syzbot+listb2770ca7b7b9b9998f43@syzkaller.appspotmail.com>
To: jack@suse.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello udf maintainers/developers,

This is a 31-day syzbot report for the udf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/udf

During the period, 1 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 32 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 6085    Yes   WARNING in udf_truncate_extents
                  https://syzkaller.appspot.com/bug?extid=43fc5ba6dcb33e3261ca
<2> 3712    Yes   WARNING in drop_nlink (2)
                  https://syzkaller.appspot.com/bug?extid=651ca866e5e2b4b5095b
<3> 587     Yes   WARNING in __udf_add_aext (3)
                  https://syzkaller.appspot.com/bug?extid=799a0e744ac47f928024
<4> 29      Yes   WARNING in udf_setsize (2)
                  https://syzkaller.appspot.com/bug?extid=db6df8c0f578bc11e50e
<5> 17      Yes   general protection fault in udf_read_folio
                  https://syzkaller.appspot.com/bug?extid=ddf8715339c89280b6fc
<6> 10      Yes   KASAN: use-after-free Read in udf_update_tag
                  https://syzkaller.appspot.com/bug?extid=8743fca924afed42f93e
<7> 3       No    possible deadlock in udf_free_blocks
                  https://syzkaller.appspot.com/bug?extid=d472c32c5dd4cd2fb5c5

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

