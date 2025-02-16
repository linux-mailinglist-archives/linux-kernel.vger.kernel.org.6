Return-Path: <linux-kernel+bounces-516827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE458A377EB
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 22:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 635257A3668
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 21:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AB07F9;
	Sun, 16 Feb 2025 21:54:26 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C668D186E2F
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 21:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739742866; cv=none; b=tA/cMjX35IDKGnxrlz0wf+btrIOuZralLQYOS4XCmZWxJYOOFLHqBKN6+Z9e7yuNYI64f5bXDJeBlLvQX0jqASLkoGNVNfim400GvCm/DkAA50v9paBh4idRTcaScGscYZbQAIzVxWo25QIUuBc3wC5iHhLi9a/kOe/4PmjGSdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739742866; c=relaxed/simple;
	bh=12FxA9JP68+2LUTYA+wtHbmtTMgzkFGriLT2SJUjRiE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hi7O8ASow5qzx4c9wmPUTGUdggLmvQB43JPkg/0EaQJoub3L7EBcUQ0/ax0J5vvfNRtBlRXYOJv5h2ULMrRd7yBJ/7tlS20AX3mVpJBpsLWOzDCWGyV4lzeEN22u1COv0sA9TTaPT1EbkAYO/mwqNRz8CCGPCPf8PD4pqO+pcUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d14950ac9fso65878835ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 13:54:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739742864; x=1740347664;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DF9gO2b1dWsDC7qG/opNyDJomEflT7vtEOvv8g3Isps=;
        b=RnppP9nduYFlph3YdwoQ5qA65Mr7arvL2U2ut/y/t31m2/wlq2XSMMdq+MFK/kdFYf
         wbjCfK0FKv8gsWogglNH+x8PgmD0+vPOq6pFP6gWl8oANt71yTU4funI62hp9Uex/w0n
         RMHf9R8rbPuO2JmV3KJZRHonXMf54oFBA8qaKJw4S9qv87FxyVtlFswFbxgu/Xzx06oR
         l9jxnbIHZmTG3N8Zwbsee9nxMX4f0T+dH1xPLpdX1Ez7qavHmNwwnprtp3SAGR6+8nT9
         4oYiV9Fz5R6lRfVUYyJItBLhv25+OfT1Q3Y/f1L27UbxPNQa+GnpN6Yez79MHXerTthV
         MZgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUviprPFUG4Kd2HZ4HFM0EL1plvgn7DN82EGsxjW+vflmXmOyfT8ksbhacyB/1IZ9ffU8suBcqlR8dT3ZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbQKruarLwG2BsSgJZk8tWReNR8kO2KO3un5vwfYAZU9QrSMu1
	Pfh6Jtlyoo5tyuFY69XVYV+P1q7xBaZNDPepaY3B5yUDnGCyXGusOHfxAvCSBN+sVKqJYTWT/J+
	pHF5lhc1IuKf+sZ8DpV5Q3PyepODDN7sdxux18nTnUo4J0SyXVh+5nWI=
X-Google-Smtp-Source: AGHT+IGCcxhH2fiV0PN+XnZx3IknqK2g+XFDc+UO72yVPyz10o42DRVkyI3UBnGTiZih2AYyKDbuGaj/RwZi5PvPQ0ySnPsA5Oxg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24d:0:b0:3cf:bb6e:3065 with SMTP id
 e9e14a558f8ab-3d279694a2emr59373375ab.0.1739742864085; Sun, 16 Feb 2025
 13:54:24 -0800 (PST)
Date: Sun, 16 Feb 2025 13:54:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b25e90.050a0220.173698.0018.GAE@google.com>
Subject: [syzbot] Monthly hams report (Feb 2025)
From: syzbot <syzbot+list840c40be55a03514cfd1@syzkaller.appspotmail.com>
To: linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hams maintainers/developers,

This is a 31-day syzbot report for the hams subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hams

During the period, 0 new issues were detected and 3 were fixed.
In total, 8 issues are still open and 40 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1687    Yes   possible deadlock in nr_rt_device_down (3)
                  https://syzkaller.appspot.com/bug?extid=ccdfb85a561b973219c7
<2> 92      No    KASAN: slab-use-after-free Read in rose_get_neigh
                  https://syzkaller.appspot.com/bug?extid=e04e2c007ba2c80476cb
<3> 59      No    possible deadlock in serial8250_handle_irq
                  https://syzkaller.appspot.com/bug?extid=5fd749c74105b0e1b302

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

