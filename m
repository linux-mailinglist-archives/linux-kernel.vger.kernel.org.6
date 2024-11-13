Return-Path: <linux-kernel+bounces-407436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 582B69C6D69
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00AF4B272E1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD4C1FF053;
	Wed, 13 Nov 2024 11:07:26 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7C81F81A0
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 11:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731496046; cv=none; b=iNtzlL/fG/l5EXiWqhK3lvhv98C7fvwmBPiljbk4p1J681cNrUdi9NMiMFIMCMZJcglMkNyxFsBPivuPsgAysIL7Tt1PXw58vfHJYijfJKFX+/GaivM4D3s6CFoPFiTUQhCqJOd0zuwn2WSpx88TbUCkqZ2N9JH7JhSknIY/2j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731496046; c=relaxed/simple;
	bh=3nNM0RWOHRwOh7vCR5bAGUb3yt8DqN9rgmZNmyv+1dA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DYCjLAO9xvGHhNhDb7ItOmlaPNTlb9IymRURLw1KT0Avz/QAH3kCbieAkD66ce9mVCkPXB6wETHVHavN/AEItETMbXQc985O19tH5wi5jzB5EGcOWc9iAyWNP2cr/+zfHiaeElQ/pimOR0OpH9HPWKrxXzbvG7hxa76huR34/lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a7158d5c8aso7615245ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 03:07:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731496044; x=1732100844;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DwSOEAvBktMgftzuxBHvBD9aUQ+nzTMLZyoeTaPM0CE=;
        b=Fe8FGXp6xshxkv31z9id+F9Tj//RxEzhnpiDKHw2IIY4wBZJiTdpTufIbjsQzMJnhR
         LHM5P4BEnu3BY6gV5T6V9P2VA+CSGk0n5Df+3ohJx32SJjQIAnpcuWCXSUzvci1NKwhK
         5usyCBlih/1/HJMu5jMZGzfGoRLr0LizIh4gUuYvm3XX+5w+EHqhwabgWXLg+yzgURuy
         I16X7gXvaPz5otYP9Vn4jZGAC7NCyoCefPDiu8op2II2GBQVGxg0R5gAOZg9TomxJnEk
         tCJBLuuiWao/o8/+UCwD+9vAH3+lzJ0+XrsW4HuehMd3v66UzoLoauZqF8mIvTOmrpN/
         3pfg==
X-Forwarded-Encrypted: i=1; AJvYcCULAwZabEIl/n9KVJg2C/HpRNSXM4iW3U63BrlKd5zby8/evfBlnDuT9Sbu8IkvXVij+4qMSHNR2xfs1x0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt7KBP6rpCnW/N5Neu8RR5Mzgj8k0thaiX4Kn0K+sJUF2X0tjy
	3841SJgl2Y6by9OOwH/apcFW6Ul8/DiK6kud0Rt7VR4I4xKGGfmQ9fbee7NQm7GjOhWUTfNRm33
	QdE/gfC3GqMnSYAD2469ecPtu44IlzblNjdA/UxZwqvFnMKu7sCAGsbU=
X-Google-Smtp-Source: AGHT+IHc+ihD1CVYxIdzETMaxBkZllwA44W9mPFRV4QkVI/dOD/r9sngDbwP1exuFO+kJoaz8wB0v7JQPSv6nZFBRR6bZVgtedxn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:680d:0:b0:3a7:18ac:1fd1 with SMTP id
 e9e14a558f8ab-3a718ac209fmr10563875ab.2.1731496043720; Wed, 13 Nov 2024
 03:07:23 -0800 (PST)
Date: Wed, 13 Nov 2024 03:07:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6734886b.050a0220.2a2fcc.0008.GAE@google.com>
Subject: [syzbot] Monthly netfilter report (Nov 2024)
From: syzbot <syzbot+lista609c7c1ef075b5cd57f@syzkaller.appspotmail.com>
To: kadlec@netfilter.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello netfilter maintainers/developers,

This is a 31-day syzbot report for the netfilter subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/netfilter

During the period, 2 new issues were detected and 1 were fixed.
In total, 10 issues are still open and 177 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 117     Yes   INFO: rcu detected stall in gc_worker (3)
                  https://syzkaller.appspot.com/bug?extid=eec403943a2a2455adaa
<2> 47      Yes   INFO: rcu detected stall in NF_HOOK (2)
                  https://syzkaller.appspot.com/bug?extid=34c2df040c6cfa15fdfe
<3> 45      Yes   BUG: soft lockup in batadv_iv_send_outstanding_bat_ogm_packet
                  https://syzkaller.appspot.com/bug?extid=572f6e36bc6ee6f16762

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

