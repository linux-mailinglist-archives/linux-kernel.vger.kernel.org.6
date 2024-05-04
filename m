Return-Path: <linux-kernel+bounces-168597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5738BBAA0
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 13:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190F81C20DA1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 11:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D00A1CAA6;
	Sat,  4 May 2024 11:14:29 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4015258
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 11:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714821269; cv=none; b=IXONPHBatqRnPTjwkxDdFEr4hfpjzS34t6/IQ4RYHtT2wp2lsXfkwVJlNYRILGAvZYKUnMeOUYwQlF461z5f/q23kAok4ekgt8KKU1MG1Be7Vs+PhFMoDsjwMrJW6swSKkQ+OeeWY1grEtmowJQDWzxUJD07mld+06ASZKFI4fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714821269; c=relaxed/simple;
	bh=Vb/N5a7l7CXPZndnD97qbGczwbX/OLAMGGfIpReIBWY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cmD01KixBRmp9AX/AbcyaSC/kJBidaxDyV6dWci3UprzL7h0LEE6w3cM66+zTVnrkD20I3/5wz1M43xi0WnNG1+rXRqxP4H1bu+lMrsIpIu5GB0v+a0F93M6tyduM6PcLDnIhba+qVEqs/Skq8HLmkauvnE7yMX7ArSJu0DyYYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7da41da873bso72317439f.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 04:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714821267; x=1715426067;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kaNh1uycWMkqmuRgdX88elvezOaZHrN9ZGKQhKZ1N1Y=;
        b=FvTjl1ZjeJ9ZAe8Xvwv3eK3/NAsrpt1b+RWhj+9Ra3tlVild72NEs2x+391AH77BRb
         l4LkxaMLIJ8PsHQ+nf81Jl5S7TmzByt4oXBR18hxFuAPrCPVd5NLyrfjpKMdk0T7DZfA
         hGRXcHmfKHJ7aRZcXvcAXr4XWE8K4a3vDHtgKH29busPsJuKcaqIOagsWnzz2MtnrGE3
         +UmTAVq5JPphePp8/K7BXl76pgBnww7RRJYdjIdhoFLvgJS+3nL+mp1ZobusRE6J513A
         BEMxxTLnMRxdkRLGUHYUcpbMVPJLaGXiBQGNrFIjN+Ur7L+crlkojkblSGZPKMJG6bBk
         VkSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXr0yT7H69Wcd5eA4FrgHdwD7usNzoYBz8vQGG4HNp7b8MuroEAlirgJeJlBA1XVQxbKRXX7UxDwIPf/F8X9/yS1ZC+ZjDvacKqEu8n
X-Gm-Message-State: AOJu0Yy52eRSquQD4a0JaSPgY3+B5xAHZVjmiGyNcnLA6sUTVJkEQAO1
	8BtHNC6in3gaqLxNwrhh4Yae2jC8L8VMdHM4vYx3q9pvfD+CjajppJoC+LzoG3fJ+cxS6D4/VVX
	fOZuemIov446tppIS2cYI4wEM8d/K/VwpAEjRRKf2vcIZrBETGUCkXpg=
X-Google-Smtp-Source: AGHT+IE/aW5y1tX546x13PbSqYbkaT2/IAXJZdhzr37z9sCAExpdwBAzRrM64M30UsGLT31kMn4l+1U1IyHXOyXWQdA1vMSaWWxh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d84:b0:36b:f8:e87e with SMTP id
 h4-20020a056e021d8400b0036b00f8e87emr385263ila.1.1714821266879; Sat, 04 May
 2024 04:14:26 -0700 (PDT)
Date: Sat, 04 May 2024 04:14:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000774a9006179ef0a2@google.com>
Subject: [syzbot] [kernel?] WARNING in pwq_release_workfn
From: syzbot <syzbot+735c2553ea82b2b34e82@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    496bc5861c73 selftests: netfilter: nft_concat_range.sh: re..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14aa8897180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=15dda165e1d20cf1
dashboard link: https://syzkaller.appspot.com/bug?extid=735c2553ea82b2b34e82
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/507454068ec8/disk-496bc586.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/083381b27086/vmlinux-496bc586.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4a1aaddd6e1a/bzImage-496bc586.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+735c2553ea82b2b34e82@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 3 at kernel/locking/lockdep.c:6465 lockdep_unregister_key+0x4cd/0x540 kernel/locking/lockdep.c:6465
Modules linked in:
CPU: 0 PID: 3 Comm: pool_workqueue_ Not tainted 6.9.0-rc5-syzkaller-01461-g496bc5861c73 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:lockdep_unregister_key+0x4cd/0x540 kernel/locking/lockdep.c:6465
Code: 24 41 02 75 14 41 f7 c6 00 02 00 00 74 01 fb e8 29 b4 09 00 e9 83 fc ff ff e8 6f 25 0f 0a 41 f7 c6 00 02 00 00 75 e7 eb e6 90 <0f> 0b 90 eb 85 48 c7 c1 c0 fd a8 8f 80 e1 07 80 c1 03 38 c1 0f 8c
RSP: 0018:ffffc90000087cc0 EFLAGS: 00010002
RAX: 0000000000000000 RBX: 0000000000000000 RCX: dffffc0000000000
RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffffc90000087c20
RBP: ffffc90000087da0 R08: 0000000000000003 R09: fffff52000010f84
R10: dffffc0000000000 R11: fffff52000010f84 R12: 00000000000003ee
R13: 1ffff92000010f9c R14: 0000000000000207 R15: ffffc90000087d00
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000006272c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 wq_unregister_lockdep kernel/workqueue.c:4655 [inline]
 pwq_release_workfn+0x6e0/0x840 kernel/workqueue.c:4958
 kthread_worker_fn+0x500/0xaf0 kernel/kthread.c:841
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

