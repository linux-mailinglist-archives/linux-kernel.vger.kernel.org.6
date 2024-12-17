Return-Path: <linux-kernel+bounces-448981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 416AA9F47F1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81D22164AD8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2CC2E628;
	Tue, 17 Dec 2024 09:47:27 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732141B7F4
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734428847; cv=none; b=JOeujea4JYHl8ydqj2CAvo3RhwwdraJKI9Kxybc+E/gxOtZlFkjVoAfxO5sLAUpgyA3nkh8VSTWhNQ+Pi4QR9DrUpl/DIxYG3tNKE5IiSoCRO7yNy5KIaxviBMFiFMXHAIIYcmH3yg0SucGxmckAlPxPI4upAB1yV6qjCMKFnz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734428847; c=relaxed/simple;
	bh=5HEZH2B6CHk22BI1HMuRw3sZX+UQFvOOQT6W75ELc1Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QM6OU2g21gxHJBKX2yzjVmtGXr82IAq62IcxtxLbVfqOD/qxyrUnPZeRiM1TYNp/q/luL3Bpg6PSLVHms5TMHAXve/mAxqqJmEM5SlsCUeLgcW4Ufu16/0qnJvyUcOHRAaqq247YV9biVOEXQ460bYNslKxNbVPceMwDp8GeZH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a81684bac0so100346515ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 01:47:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734428844; x=1735033644;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SacZCQL02OTfHgYO1wkgdlbR5QwW3dwO+inms0XcACI=;
        b=VsyPUIIqr1mXjJmQCPc8Kgoe8g0W+CO/FLKGX0cCJXNpVuLfu7SRZfKgBppaHTMkuw
         JXct/98gRMTo8qlKSoy3kEG6sP4CO8ICoM3k0ZWX7zsxjd0tp5lkkFsQPTn1+Uwmzsjm
         mph8B0Va/2nfurk3Pg2mijr0jJ42mwHANGcL0Tofg80ucgt2krocaPU4WSRT5empz9Q4
         VeJHwoFZCG4AmpKQ8jERRaOCGedJHY/O0CR14+mR/Pomz6FOsKx4eYCy8ANsDbq0yiG/
         zJjNZW6TlJ++w/aj0yBm8uQBAqGsNN9GlZ9rPBhPCGpV9fJ5JXcpCipY4YuORO5rRlE2
         /QJg==
X-Forwarded-Encrypted: i=1; AJvYcCXnMwYyRLFHO7Oxtmr8/9z5iUKCKv+CszRktwOz4+8gB8dDrjDLgx4vPBJ5/J0bDTtzIGIi8PjHWHQLN54=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNt8pzGdx/BenhcfAZACmGiB1VeCdTrfa2i+v6Mj2jQ4rO5hre
	2OS00SbZeuXFgBA3s8Tt823fDdO9lSi7V3qtvvyuUkLT7cGrtdbeUCo2qryN0L3nfYxHiNYT1vs
	OtBVCbQWklWwfqjhgVGFvFDv60JFEjcUKtxALC19ETFEHEVNKa+IuBzc=
X-Google-Smtp-Source: AGHT+IE3b2Nm7LnXOOcU/wJ2UwmW0zqSDWdP5nczaji3hQBnBdk6OxmkmdLn/x/E35mlE2lCIBlVLAyOpbxZRnSrbSQPhbguklnF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:168a:b0:3a7:7ad4:fe78 with SMTP id
 e9e14a558f8ab-3aff88b85bfmr139383445ab.19.1734428844675; Tue, 17 Dec 2024
 01:47:24 -0800 (PST)
Date: Tue, 17 Dec 2024 01:47:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <676148ac.050a0220.37aaf.0155.GAE@google.com>
Subject: [syzbot] Monthly bluetooth report (Dec 2024)
From: syzbot <syzbot+list46237703043d572e3df9@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 6 new issues were detected and 1 were fixed.
In total, 49 issues are still open and 76 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  11971   Yes   KASAN: slab-use-after-free Read in l2cap_unregister_user
                   https://syzkaller.appspot.com/bug?extid=14b6d57fb728e27ce23c
<2>  5150    Yes   WARNING in call_timer_fn
                   https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<3>  697     Yes   general protection fault in skb_release_data (2)
                   https://syzkaller.appspot.com/bug?extid=ccfa5775bc1bda21ddd1
<4>  570     Yes   general protection fault in lock_sock_nested
                   https://syzkaller.appspot.com/bug?extid=d3ccfb78a0dc16ffebe3
<5>  83      Yes   BUG: sleeping function called from invalid context in lock_sock_nested (3)
                   https://syzkaller.appspot.com/bug?extid=55cd5225f71c5cff7f6f
<6>  61      No    WARNING in l2cap_chan_del
                   https://syzkaller.appspot.com/bug?extid=3272785b7a1fc9b510f6
<7>  61      Yes   WARNING: ODEBUG bug in put_device
                   https://syzkaller.appspot.com/bug?extid=a9290936c6e87b3dc3c2
<8>  55      No    KASAN: slab-use-after-free Read in skb_queue_purge_reason (2)
                   https://syzkaller.appspot.com/bug?extid=683f8cb11b94b1824c77
<9>  32      Yes   possible deadlock in mgmt_remove_adv_monitor_complete
                   https://syzkaller.appspot.com/bug?extid=e8651419c44dbc2b8768
<10> 29      Yes   WARNING in hci_recv_frame
                   https://syzkaller.appspot.com/bug?extid=3e07a461b836821ff70e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

