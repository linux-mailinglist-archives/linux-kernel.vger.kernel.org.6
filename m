Return-Path: <linux-kernel+bounces-208118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 843F59020F9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F601B2597F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD0381AA3;
	Mon, 10 Jun 2024 11:56:29 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E517C7F47F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718020588; cv=none; b=LUktvq4UIHjsp05xp34nSk5cxGJoU52Uua8GBvUKXNY6nFHGAImVE2mBZ5YnpdrtD9PdhaXJP6P/39yZ94HS+RAj/6weO22yHAgeNMMpjeRuZ68kGMEnFVjq7UF5gQPvdGfUE/osq1+QGlELFEvjhKISMQJJiykB1urofQULgSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718020588; c=relaxed/simple;
	bh=3zfvzlmcR8N56u/FKlbPmt+e+1fkdR4IKAhj3L5vxzs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=m2vyvS1Iw4dLwgcNroueGr/QgIVWBchcPaDBnUYzcyPtZUYsRUzguF2rh/7EcFXfZSSRy9MKBT4LujwDWSCLrKPf452wDguni8uR2/k44zWgqmw3MzYfgjsUFO+CtH8SFvyb/mr9ltwZ6C3ipjrCx/ZSJDKpxtxFMs4ljCl0sfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3747f77bafcso41186595ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 04:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718020586; x=1718625386;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZkZ3+r53EPSlPEfxLkR3ZeP8CW8pwD/hEhLYRJTOsaQ=;
        b=I92+0A/cqElOkrG7UutLSH/+I23dvuDUOCmoYMje/1xRvAmNJPF5vp6HYg1aw4bND5
         ubCdb7ZYtvs1Krde7Vw1B1tlGe8Vj1HwCI5LYxNUwTQQSUenssiogiyjyd+eu48RIFDU
         gUnUB3Kk0vkJCHm+UQhWNzeCmvqcV2n3gnnc9GUkPoz9aWtDUCDZ6hCo6o9RBSy4lRvd
         m90e1yceZeAfhXi7Bbccsq26AF1VC8ePAZk36F/uWTBiCtaitgszlvBdrAJJUhhk/L18
         /wyTpVgDNh/rv70Oz8PKLcacYyT68AY7/H46xUaapbzcu7dkk5I5r+voqIxxu2RegfJ2
         98MQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy/95iaF291MFeQtgz0KlSr7grtqUf2kEVr/Y/XnoglJ9eqbG8A+v2hHSvJxudEeFaUv4d1LgBaj97UdUa9dubEdjdAmXahRam+7Sn
X-Gm-Message-State: AOJu0YxcF2ugF+RDGcaSy2WGboLHzjpuKmIPYtkuLc1CW4a5eXaRg2B9
	++oXsz8C0PTxFSNkO9h5wQGft647/uPppjDZEAxUgJPTz972PbKO9hihAJKL6A6fFna9Q58KA2E
	M5yDr4RA80y4qR9zCRjiHG2+8/TUZnFDgm6ZiSG+vxFWRSkqTBS1rayg=
X-Google-Smtp-Source: AGHT+IEkaqB6ydyDctJGeDvNtCoQHlYExJ79u/V7cVFMgkdlq2tTHJ64KPaQk/juXHrnZEb840thf0gmF1RT6W3WOiOAOjqGU96Q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:786:b0:375:9b4f:5e47 with SMTP id
 e9e14a558f8ab-3759b4f609emr1485945ab.1.1718020585979; Mon, 10 Jun 2024
 04:56:25 -0700 (PDT)
Date: Mon, 10 Jun 2024 04:56:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000be90d1061a87d641@google.com>
Subject: [syzbot] Monthly bluetooth report (Jun 2024)
From: syzbot <syzbot+listdd264ff43a865b537e43@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 4 new issues were detected and 0 were fixed.
In total, 53 issues are still open and 63 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  21745   Yes   possible deadlock in rfcomm_sk_state_change
                   https://syzkaller.appspot.com/bug?extid=d7ce59b06b3eb14fd218
<2>  7056    Yes   WARNING in hci_conn_del
                   https://syzkaller.appspot.com/bug?extid=b2545b087a01a7319474
<3>  5110    Yes   WARNING in hci_conn_timeout
                   https://syzkaller.appspot.com/bug?extid=2446dd3cb07277388db6
<4>  2972    Yes   WARNING in call_timer_fn
                   https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<5>  2528    Yes   KASAN: slab-use-after-free Read in __hci_req_sync
                   https://syzkaller.appspot.com/bug?extid=27209997e4015fb4702e
<6>  1001    No    possible deadlock in __flush_workqueue
                   https://syzkaller.appspot.com/bug?extid=da0a9c9721e36db712e8
<7>  680     No    possible deadlock in touch_wq_lockdep_map
                   https://syzkaller.appspot.com/bug?extid=91dbdfecdd3287734d8e
<8>  615     Yes   general protection fault in skb_release_data (2)
                   https://syzkaller.appspot.com/bug?extid=ccfa5775bc1bda21ddd1
<9>  243     Yes   KASAN: slab-use-after-free Write in sco_sock_timeout
                   https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
<10> 185     Yes   general protection fault in lock_sock_nested
                   https://syzkaller.appspot.com/bug?extid=d3ccfb78a0dc16ffebe3

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

