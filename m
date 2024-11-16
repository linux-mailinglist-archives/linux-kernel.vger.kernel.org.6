Return-Path: <linux-kernel+bounces-411929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A83919D0170
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 00:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5346128172E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 23:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04C91993B4;
	Sat, 16 Nov 2024 23:26:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A6818C008
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 23:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731799565; cv=none; b=R8B5hRxSNODS9BAbS8o+EG5YA33gd4QJQopKWxrC48eTPm42I8H63wewqTUKyb653/UKKQjrKSgrShUxvRMWO3HFhZA0Qi+hYUNtlDuEtvMY2s7YkCxl5CD7NwLP2qIsS8W6ewmL4oZdDlomujvjZq/rc4eQtivnWa9kVsdtTHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731799565; c=relaxed/simple;
	bh=vuWs0S3EeniurAZhOiHHv6a0bd9kr4WIi/phRwjnM70=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=f1PueBwxv76D4aolebSI4kwurMXUWg/k2rYUPGkSBHdjMbcEjzm/C0SmMaYRnnYeeW83dOlGU07Iiu4TzZnwr82LqQk9EJY10mnSusLk+b4kKcLdBnhSUF1J+wnp8dAUkTOyPTata0aHOKk7EuaB6GBaRL37z9pPDhJR6thD0DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83abf723da3so69308939f.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 15:26:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731799563; x=1732404363;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KS/3T9912Ge5sdPaeEv3HURQfOnZbK0lLGF2BFMXebQ=;
        b=NdFED9luykiS8uNTnegcbGexVg86lwLNKXqnWPFLyulm5JpUSiZhd9pfvnBKOS3iev
         RhDiikywAyu2GFWjooWCTqVeVIF/nihtcYW8aCUQA3V2kFa/sCfn61K0amqo8YbvdcTe
         xcdU7xYI1fOygwqo7ehQwphIW/GyH3pfe10PRx0QpQ9yWCgUrkNMlQFjlxdYPl7YjQzh
         wk61uYg1RM6DLqn4MIrHB7hNTF3a9EObdFw0v5gh5VKXOvK11L2EKOBgC7f7IGdhT1Td
         Kyk6YmueR3A5a2gpRttDOOs44hB/02TFnFjHROQbjJws9SifhW46eofjBYI7165nYYc/
         0/yQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwHkzgdw1G8Th8txd2IyPQHNpTmD8aUMg5Amx/uQuvZzV0XXiPL0s3ceSKxCdHf3YqriqXtgIo7GmBz6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfC+Ks55kNgfqcx2DaF9pTw9eqgB4EcqkJRbCSouUYU4QQetbb
	x+yWqzqvivXWu8/wmPLGHrmHL925JUlLpvpCA6c25rHxa76vrplrFFP1v455mXHhLkOkA4yv5Bv
	T84oEV8B+Oyc7EWiWtfhtHD93r9u8k14TIdAMOge0jxFcNpv9ArTxhP4=
X-Google-Smtp-Source: AGHT+IGprvu6a8h0hNiDccxdISSaTeNbmVI4V5PIwX9b7n9MJ/OWR4hJAF8hK7igkuNsF+C//MGCs2plOW7WoB5XWiwEjlsnJ/HT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3d04:b0:3a5:e7a5:afc with SMTP id
 e9e14a558f8ab-3a74800ee54mr66240775ab.2.1731799562924; Sat, 16 Nov 2024
 15:26:02 -0800 (PST)
Date: Sat, 16 Nov 2024 15:26:02 -0800
In-Reply-To: <20241116230913.1124-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67392a0a.050a0220.e1c64.0008.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in rcu_sync_dtor (2)
From: syzbot <syzbot+823cd0d24881f21ab9f1@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in rcu_sync_dtor

------------[ cut here ]------------
WARNING: CPU: 1 PID: 47 at kernel/rcu/sync.c:177 rcu_sync_dtor+0xcd/0x180 kernel/rcu/sync.c:177
Modules linked in:
CPU: 1 UID: 0 PID: 47 Comm: kworker/1:1 Not tainted 6.12.0-rc7-syzkaller-00192-gb5a24181e461-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Workqueue: events destroy_super_work
RIP: 0010:rcu_sync_dtor+0xcd/0x180 kernel/rcu/sync.c:177
Code: 74 19 e8 96 dd 00 00 43 0f b6 44 25 00 84 c0 0f 85 82 00 00 00 41 83 3f 00 75 1d 5b 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 90 <0f> 0b 90 e9 66 ff ff ff 90 0f 0b 90 eb 89 90 0f 0b 90 eb dd 44 89
RSP: 0018:ffffc90000b77b30 EFLAGS: 00010246
RAX: 0000000000000002 RBX: 1ffff1100acad877 RCX: ffff8880206cbc00
RDX: 0000000000000000 RSI: ffffffff8c6038c0 RDI: ffff88805656c350
RBP: 0000000000000236 R08: ffffffff820f0554 R09: 1ffffffff1cfbc21
R10: dffffc0000000000 R11: fffffbfff1cfbc22 R12: dffffc0000000000
R13: 1ffff1100acad86a R14: ffff88805656c350 R15: ffff88805656c350
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555583944808 CR3: 0000000012ac6000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 percpu_free_rwsem+0x41/0x80 kernel/locking/percpu-rwsem.c:42
 destroy_super_work+0xef/0x130 fs/super.c:282
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


Tested on:

commit:         b5a24181 Merge tag 'trace-ringbuffer-v6.12-rc7-2' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13cb52c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1503500c6f615d24
dashboard link: https://syzkaller.appspot.com/bug?extid=823cd0d24881f21ab9f1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=117bb130580000


