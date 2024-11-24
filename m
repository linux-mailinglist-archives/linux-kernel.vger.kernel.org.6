Return-Path: <linux-kernel+bounces-419330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 062069D6C8E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 04:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A772815C5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 03:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A539D25776;
	Sun, 24 Nov 2024 03:33:24 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A43E1CFA9
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 03:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732419204; cv=none; b=W4zhylRrTrpoPAwI35+KDJEJ6xS3vwmBFEGahQfknrSDWJ4sW930X3mm89yAY6oS26gydohj+8wzbT1OxMGihWPKPGuxmW+979idDQ6HInVGR70vIeRmMuBzSEqbslFnAxSfNYn74BeMuXEVz5WWtRhFzFn8ugEOLQ78j9p4PCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732419204; c=relaxed/simple;
	bh=SUi4cT637x5iZ14QR+bszgaLIJc1sVj0bIiFG0G6b14=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=md25w8sAE+TI6pU2iJvPXZSOlNKvy29UEhMj3oDOpwilyRY6Mu8Esj96Vkz7jdnwag0t62puIghtNHlqIhlOMki62NdoXG3TviwneJa8+mXIL/DHplcUUtUg27SX5d3TadIekVKVwWpwWDJFRJjSPAGMaKS2hhtRx7T4jnPuBlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a7932544c4so30540525ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 19:33:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732419202; x=1733024002;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9N+83kRE03YvGvu9iJvDyflie7kKDSTSs9dt4aNGmQA=;
        b=G1WM7u1ySMjwZ08e99+XGJNCZfii/XpOuUfou+RrLIHgFffsRX89LN0ymgpmFjdeyC
         IFFYYUnooIRhDRDeZ/Zem/XH1ZIpGUcq+7divdJ+FTgjHPFvrzKkT7Q28FhNP/hUXhv/
         Jy1hIAFET81JAwHRddZ9+n/jNF33SfogGFSJLYG5slhDcodhVaILTg/qBDqCAEsxpgxc
         Cgfo6S23CSgVW/qwbSIW392o97vqxRguUZxTp2LYkvcftvnlbqbDoLTv7ufF+YyMiGTX
         EzR5xmTgiqPQxo5NJUNAhgePMsFMXmnrKmi9dhlaRbgq/ExZazGB7cOKgIQW9X+6S66Z
         OkcA==
X-Gm-Message-State: AOJu0YznawaAvOaiCqyXlQOYmKmAZGKEu68yFZetta4c4NFSw/5Uxnec
	th3L961vWd6gnf1rF94QONPXhw1LivK6fNsWXUAESRbB40G9OFkzfrPfwpNNWNJmOecHZLuwdOV
	ZKV2QUNAOj0Nw9iLnqWl7CzpzOBwbcxM5Tcx2X/qfghbf5kRtSXVg920=
X-Google-Smtp-Source: AGHT+IHGIOU5+DLixzk/I4h6Fv2WWpcnEwrjNeapGgR0Tl+iLLR4jygqCEX+bwSdfrt52RrHO1+6LLAz7YuKtoSQtHejukEvfzhm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fed:b0:3a6:b445:dc92 with SMTP id
 e9e14a558f8ab-3a79adbc7b6mr89337095ab.10.1732419201773; Sat, 23 Nov 2024
 19:33:21 -0800 (PST)
Date: Sat, 23 Nov 2024 19:33:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67429e81.050a0220.1cc393.002d.GAE@google.com>
Subject: [syzbot] [kernel?] WARNING in sched_mm_cid_remote_clear (2)
From: syzbot <syzbot+0784d42fd852319c56a4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, luto@kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a5c93bfec0be Merge tag 'x86-mm-2024-11-18' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16d986c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=881d13977c7330ad
dashboard link: https://syzkaller.appspot.com/bug?extid=0784d42fd852319c56a4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5a79011a6168/disk-a5c93bfe.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/35d2b8ddacb6/vmlinux-a5c93bfe.xz
kernel image: https://storage.googleapis.com/syzbot-assets/521d7aa8240a/bzImage-a5c93bfe.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0784d42fd852319c56a4@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6707 at include/linux/cpumask.h:135 cpu_max_bits_warn include/linux/cpumask.h:135 [inline]
WARNING: CPU: 0 PID: 6707 at include/linux/cpumask.h:135 cpumask_check include/linux/cpumask.h:142 [inline]
WARNING: CPU: 0 PID: 6707 at include/linux/cpumask.h:135 cpumask_clear_cpu include/linux/cpumask.h:536 [inline]
WARNING: CPU: 0 PID: 6707 at include/linux/cpumask.h:135 __mm_cid_put kernel/sched/sched.h:3599 [inline]
WARNING: CPU: 0 PID: 6707 at include/linux/cpumask.h:135 sched_mm_cid_remote_clear+0x48a/0x4f0 kernel/sched/core.c:10474
Modules linked in:
CPU: 0 UID: 0 PID: 6707 Comm: syz-executor Not tainted 6.12.0-syzkaller-01518-ga5c93bfec0be #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
RIP: 0010:cpu_max_bits_warn include/linux/cpumask.h:135 [inline]
RIP: 0010:cpumask_check include/linux/cpumask.h:142 [inline]
RIP: 0010:cpumask_clear_cpu include/linux/cpumask.h:536 [inline]
RIP: 0010:__mm_cid_put kernel/sched/sched.h:3599 [inline]
RIP: 0010:sched_mm_cid_remote_clear+0x48a/0x4f0 kernel/sched/core.c:10474
Code: 0e 01 e8 19 6a 0d 00 eb 9d 4c 89 ef e8 ff ed 91 00 e9 66 fc ff ff e8 f5 ed 91 00 e9 46 fd ff ff 89 44 24 48 e9 16 fe ff ff 90 <0f> 0b 90 e9 ef fd ff ff e8 f9 b3 c7 09 e9 06 ff ff ff 48 89 d6 48
RSP: 0018:ffffc9001c567cf8 EFLAGS: 00010006
RAX: 000000000000001f RBX: ffffe8ffffd37180 RCX: ffffffff815ca5c2
RDX: 00000000ffffffff RSI: 0000000000000004 RDI: ffffc9001c567d40
RBP: 1ffff920038acfa0 R08: 0000000000000001 R09: fffff520038acfa8
R10: 0000000000000003 R11: 0000000000000000 R12: ffff888028574390
R13: ffffe8ffffd37188 R14: 0000000000000200 R15: ffff8880b873eec0
FS:  00005555936c8500(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30d14ff8 CR3: 000000002fe54000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 sched_mm_cid_remote_clear_old kernel/sched/core.c:10507 [inline]
 task_mm_cid_work+0x39e/0x930 kernel/sched/core.c:10557
 task_work_run+0x151/0x250 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 irqentry_exit_to_user_mode+0x25c/0x280 kernel/entry/common.c:231
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7fc4b4f51dc0
Code: 66 2e 0f 1f 84 00 00 00 00 00 48 8d 47 0d c3 66 66 2e 0f 1f 84 00 00 00 00 00 48 8d 47 0e c3 66 2e 0f 1f 84 00 00 00 00 00 90 <c5> f9 6e c6 89 f8 25 ff 0f 00 00 c4 e2 7d 78 c0 c5 f1 ef c9 3d e0
RSP: 002b:00007ffedb2eba78 EFLAGS: 00010246
RAX: 00007ffedb2ec180 RBX: 00007ffedb2ebfe0 RCX: 0000000000000000
RDX: 00007ffedb2ec160 RSI: 0000000000000025 RDI: 00007fc4b4ff2d5a
RBP: 00000000fbad8001 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc4b4ff2d5a
R13: 00007ffedb2ec160 R14: 0000000000000000 R15: 00007ffedb2ebfe0
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

