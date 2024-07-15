Return-Path: <linux-kernel+bounces-252470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD7A93137A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD0C92836CB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7BC18C168;
	Mon, 15 Jul 2024 11:52:27 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB6A18A94A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 11:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721044346; cv=none; b=Udzc0E8gfL6tT4t+2e2VlD3kUZVj30OG99QcrWutqaTNg3JbQ9QUeJ+Ff/5qO0wd4IqdM7W+WW5ZYwS1rlD89H1COvrOuXRhWhH6qmD9M0d1LTLpJMM13Z/tcGxuZMZZueE0y2OaCIhzpl4EIxfosuBf8MAxdxaA46SeOUl6jxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721044346; c=relaxed/simple;
	bh=diIkvLPLDk621MQUgXDoYLDnPu5UDhuEInfuGBiLta0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QP7rK78cEZnk+tRh3lPOg1R2qRQaies1jY9thtUgBbo6Q64MjkL41+6ed76GuO175viBAjEf7TKsnK/lWLiWa/UhnpKsSCejVCY1irrxQnIsbWZZ3+EhhIhy4MZTPEv1w7EK22YJxniajTzDoy58NmO17QjjhG81kCq/jTi3qKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f6218c0d68so509216039f.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 04:52:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721044344; x=1721649144;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=akbEEO5eDMgzVWGCcvmROY2hRDgzwS14XNZ5oBf1+cg=;
        b=iqeVDk2KjrogchP6sUK62JnbeXHuVNxujrkPNAwMZ7dPfIxJkioKJtmkd/Iyakn8wx
         RyYEBO7MEdIb3Cz+NGf/7Mw/IThhwbEJbxXMP3E2iXx/IyJLcJN9CBrBL47Dy3rqM2Up
         jQBdok2wrqNj4n8VTCo201BJa4WwEWQgUMfmGha5BP4lcRpWvW+8pkEKOHhHlIPK1Uj3
         YQyguROL1ng25d132QvrVgqAUZRN/qgXauf7S51fIcHaO3IqgifeMNZkMA+cL+g+M+eI
         +Y89Pn2AosCIETWmr1nu2VPv6C/tDESne5MagwD/dXbP3nJ/WVG7wA2WqVGP8kVqv6bT
         Gj9A==
X-Forwarded-Encrypted: i=1; AJvYcCUwq5uhNIpYt4m5H+Pa+vu7vO9mHFLQzy1JJ8im1ShrIbX6C65vtElAgR6VkLDRzdyuvcWWNuBZ/mVNr/X5jfImmbYbhaGEcM+9N1l6
X-Gm-Message-State: AOJu0Ywd7Qz9FdLsZpAG9QHbHjYTWFsuYq3//sy4LBs6a62WB8RLBX61
	14xdjyeJxQyafBZF59ndgaq+IBcrYxQqRdaBUeF7MVKtvLJxZ0SHt1NzUj1Sp1s5hqqOa/hk71T
	t4vUCMAbXn/DEmUGaFrv/s/zW7ZxfJqyuAK26KceOOviX16dUIchYcWc=
X-Google-Smtp-Source: AGHT+IGbO8E7xzqfGGCF4bOhniymNQ6wQMjLxQgwbzBzed/SnyWB802ButKIujMhzYIKYVew/98ZKs8CLCbAdG91B/tufBuj89U3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2486:b0:4be:d44b:de24 with SMTP id
 8926c6da1cb9f-4c0b2999752mr1398314173.2.1721044344440; Mon, 15 Jul 2024
 04:52:24 -0700 (PDT)
Date: Mon, 15 Jul 2024 04:52:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cb15b9061d47dc76@google.com>
Subject: [syzbot] Monthly bpf report (Jul 2024)
From: syzbot <syzbot+list0338b242d2eaf79f8dd5@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bpf maintainers/developers,

This is a 31-day syzbot report for the bpf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bpf

During the period, 5 new issues were detected and 2 were fixed.
In total, 52 issues are still open and 256 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  18263   Yes   possible deadlock in trie_delete_elem
                   https://syzkaller.appspot.com/bug?extid=9d95beb2a3c260622518
<2>  10705   Yes   KASAN: slab-out-of-bounds Read in btf_datasec_check_meta
                   https://syzkaller.appspot.com/bug?extid=cc32304f6487ebff9b70
<3>  8741    Yes   possible deadlock in task_fork_fair
                   https://syzkaller.appspot.com/bug?extid=1a93ee5d329e97cfbaff
<4>  1396    Yes   WARNING in bpf_map_lookup_percpu_elem
                   https://syzkaller.appspot.com/bug?extid=dce5aae19ae4d6399986
<5>  966     Yes   WARNING in format_decode (3)
                   https://syzkaller.appspot.com/bug?extid=e2c932aec5c8a6e1d31c
<6>  803     Yes   possible deadlock in __bpf_ringbuf_reserve
                   https://syzkaller.appspot.com/bug?extid=850aaf14624dc0c6d366
<7>  144     Yes   possible deadlock in __queue_map_get
                   https://syzkaller.appspot.com/bug?extid=8bdfc2c53fb2b63e1871
<8>  110     Yes   WARNING in __xdp_reg_mem_model
                   https://syzkaller.appspot.com/bug?extid=f534bd500d914e34b59e
<9>  108     Yes   BUG: unable to handle kernel NULL pointer dereference in sk_msg_recvmsg
                   https://syzkaller.appspot.com/bug?extid=84f695756ed0c4bb3aba
<10> 84      No    possible deadlock in trie_update_elem
                   https://syzkaller.appspot.com/bug?extid=ea624e536fee669a05cf

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

