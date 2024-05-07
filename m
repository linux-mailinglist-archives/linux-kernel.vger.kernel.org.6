Return-Path: <linux-kernel+bounces-171605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4568BE652
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1542B285BF0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC8F16130A;
	Tue,  7 May 2024 14:44:30 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5772515EFDE
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715093069; cv=none; b=efe/g7PeFk589Lc7PJ8DcMjHz22fMWw38XqKkiRm8pQzWgVzAr69ypR3BzQUAoU5NvvOmp2yvjPgRcYGAemtDnYjoZn7FtWmG8CHTbKoyadxc08H505D1XDcQJVix8Kp8vJFYLLt4MGfHfyBAtSj3PNaR+wWhl94Da5+cwZ/qgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715093069; c=relaxed/simple;
	bh=D0UTLFspFsWByZZFGA4+uXnJFM3ra4mAEtBflpTGQVA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=IqG7Mgo+T1Aejrt7u5ltRfwICmUuWzz7WwR55s3rKn5dHDYXv1xcpOgVK1g8vxXMARJNs3mY3h0XmiOYSfo3e7+863HanmXoyk4JfyYSAoGyqOAvRXJnWwEE5m9Or/vXpi0KgLh5SkssnpcjjnBoDvjdctOm42qfrdnjaOAO6CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-36c610e9479so34686515ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 07:44:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715093067; x=1715697867;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uyNfp6nWdtV4tA+dKAOrhxuQUYnNWIbCZXbPLIQWmEc=;
        b=GjG4wznCq2fI/myaNs4X2+gDc5fq8JYfATLOZ8jJLakZuwN4uKAs/BYE+P1Rg0mVVT
         +yFHrOq+NFU9O5UHAJ+7X3gZ/26u5I+gq6HSY4VwSwybEtoREawkefLUzSogooxJxLxx
         GslOY+OeaT3IL5wNCNsXv63rIinvg1UWo8+AF+5HOGCA4oRMGDkckrjrFqoXwbK1c2r+
         /z8WxBrGgVipcUj1AJn2/b2v2H0sedpeTDFK1giyN1/L7votA9VFm/wQnNFpUcUX736b
         jS9NpJ49/i4ughcJVyVtzP63guyF5JgFf9OHcv0zZmDZPAtYDcpDxEXuTxOYjsJM4Ze2
         LY1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTpTnbkiM7pm1W4itKUql9h1K0MDey/8ZBkiXTN8xRZk9v+huaZVrGomzRsV/N4x1KwNkW6ZG5QbYmZLd5Kl/VWVJfYqr8s8XAXIBW
X-Gm-Message-State: AOJu0Yzy7HV3hPG35UsX6lq0oh85EO4Er/0wzmZjvSRe+BG4mzxQWydN
	4hxDx4Q5LlcHhDraKhGpkiTN8qWIo/DtLODXKwiSsbmquVEKzYZX9H7z1xX9RrE7MoSDFRLbSw2
	Pxi/syKJ9J0AwRHvFfz7VcQvDbjnQ9Hl0a442G7YZkNiu1bMmf9LL7Qc=
X-Google-Smtp-Source: AGHT+IHxi5FMjRKGS86sTLbyv+XlYa3WknYNgi1bWsHA4oym01bjm7ugKbucsPz2dDmEyjsEHTuFNjIM6GZ8MtFk/pLv4fU3MEGT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c02:b0:36c:5520:9597 with SMTP id
 l2-20020a056e021c0200b0036c55209597mr521639ilh.6.1715093067590; Tue, 07 May
 2024 07:44:27 -0700 (PDT)
Date: Tue, 07 May 2024 07:44:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000cfa3f0617de399a@google.com>
Subject: [syzbot] [kernel?] WARNING in srcu_invoke_callbacks
From: syzbot <syzbot+2250e31d8f78fffa4768@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f03359bca01b Merge tag 'for-6.9-rc6-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16968250980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3310e643b6ef5d69
dashboard link: https://syzkaller.appspot.com/bug?extid=2250e31d8f78fffa4768
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1b4deeb2639b/disk-f03359bc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f3c3d98db8ef/vmlinux-f03359bc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6f79ee1ae20f/bzImage-f03359bc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2250e31d8f78fffa4768@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 928 at kernel/rcu/srcutree.c:1758 srcu_invoke_callbacks+0x412/0x490 kernel/rcu/srcutree.c:1758
Modules linked in:
CPU: 0 PID: 928 Comm: kworker/0:2 Not tainted 6.9.0-rc6-syzkaller-00131-gf03359bca01b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: rcu_gp srcu_invoke_callbacks
RIP: 0010:srcu_invoke_callbacks+0x412/0x490 kernel/rcu/srcutree.c:1758
Code: 10 e8 82 ff 74 00 e9 b2 fd ff ff 48 8b 7c 24 10 e8 63 00 75 00 e9 2c fe ff ff 48 8b 7c 24 10 e8 54 00 75 00 e9 41 ff ff ff 90 <0f> 0b 90 e9 fc fe ff ff 4c 89 ff e8 de ff 74 00 e9 b2 fe ff ff 4c
RSP: 0018:ffffc90004847bf8 EFLAGS: 00010202
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 1ffffffff27bdd6c
RDX: 1ffff92000908f87 RSI: ffffffff8b0cae00 RDI: ffffc90004847c38
RBP: ffffe8ffff804160 R08: 0000000000000001 R09: fffffbfff27bb636
R10: ffffffff93ddb1b7 R11: 0000000000000000 R12: 1ffff92000908f83
R13: dffffc0000000000 R14: ffffc90004847c38 R15: ffffc9000405f6d8
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020071000 CR3: 000000007b086000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 process_one_work+0x9a9/0x1ac0 kernel/workqueue.c:3267
 process_scheduled_works kernel/workqueue.c:3348 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3429
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
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

