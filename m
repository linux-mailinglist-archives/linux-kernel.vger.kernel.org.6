Return-Path: <linux-kernel+bounces-319605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4239D96FF29
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 04:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C55CB2843AB
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 02:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A127B10A24;
	Sat,  7 Sep 2024 02:14:23 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA8379C4
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 02:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725675263; cv=none; b=CwQXlmwP8STD8v3GXDQDSIUWPnWBPL/S8O9wHXEjcjezoqs9gNb5JHcb4Q0eHc72FyXibqaTmluQS7lb1exnCSd/vWERS2Zx/RhOhgGzUeSqRLzG58AsVbwskrFvO2QCKUU/wo86XrNOHUwltwZfq9B5GDHBhD5Hu/GOEx36uE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725675263; c=relaxed/simple;
	bh=Qgd4T5V1oPEnKn8aqh7wggst8XqjnqNKzW2g68FuuSE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LwoV2Eojbxu2iUoOAMFALwLg7D1ORJb/rJzq+n1Mm/6mUXW8FyzpFf0Zc8B2p5JvQMO1tcmoWopgTJ4vKLije9zzVR8V3bV8g1/qTSai0Wx1hu2PS3rC5HXmMu3AYtNs5cVXulHeuusNYOCE21/qOnyagi/CrDhiupVaZYeMYoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82aa467836eso47625839f.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 19:14:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725675261; x=1726280061;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CPrtT89GWnAYj4eqiYYj81c5PFHSAOrrMkACYbXqjSY=;
        b=E8pBIDJeI5K4uzEmsSNRYAHEBZYxTRDYaHJmbBQIkXGvknzlmGiVraKEMQweOXfo2b
         PmCuhgFX96QwVCTKPysq0tXO67Cfepv2NyeEMD/wLLLqgFH4CqCJbJVRyGt3tpLFntzh
         oBRZ2Z+pKnGYP+nU0nVPpNFM96CZ0XafPJ2YL1YjhMNKBEuh+qPo88+s4EL7PLpwQ384
         Ou6CXsk+1x0sT4C1LjVvAh2VEBC8iNZd1nbQWiBIHMNKT4EkOySAY5HKzigkyCaVlFDN
         3tAzaXbpWDCbGfm+XekrLnspS7XgFKodEZebNpuvwfT+F1oJofQDpIkvM9QChRKTYNw0
         M4QQ==
X-Gm-Message-State: AOJu0YwklDEJLi7yPhTfa+HnlPdzOWgV/rTW6bOvrUL60zQoSPbp/mYL
	Cbr2SicRWmhYnrfWhrlkCtElKhIplwHVrk2oP6isoILO2+990U5EbW6jOg0/JF9QejWZ43Tq3sp
	a7G8HkrGIKFJRKHlJnmzovQqGF/rBLiWIOvuzA/KcPF+eKK1pyrX9Qek=
X-Google-Smtp-Source: AGHT+IHdgkgzAaJJ+VOyNfUwpjOmNPZcDF2aNtxLvHZaefAv0lvoC1449d3IzP8BOkD4B7mmpUtYZ84LfLKBAYbKI5FjXRRlTcmt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1308:b0:4c0:9a3e:c259 with SMTP id
 8926c6da1cb9f-4d084ff3c43mr460905173.5.1725675260964; Fri, 06 Sep 2024
 19:14:20 -0700 (PDT)
Date: Fri, 06 Sep 2024 19:14:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ed7d9406217e14f8@google.com>
Subject: [syzbot] [kernel?] kernel panic: corrupted stack end in
 lock_is_held_type (2)
From: syzbot <syzbot+7386187dbd10f33cc0dc@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1ff95eb2bebd riscv: Fix RISCV_ALTERNATIVE_EARLY
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=15316567980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c79e90d7b2f5b364
dashboard link: https://syzkaller.appspot.com/bug?extid=7386187dbd10f33cc0dc
compiler:       riscv64-linux-gnu-gcc (Debian 12.2.0-13) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: riscv64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/a741b348759c/non_bootable_disk-1ff95eb2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1491182abe4e/vmlinux-1ff95eb2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/926302c5c645/Image-1ff95eb2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7386187dbd10f33cc0dc@syzkaller.appspotmail.com

Kernel panic - not syncing: corrupted stack end detected inside scheduler
CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.11.0-rc2-syzkaller-g1ff95eb2bebd #0
Hardware name: riscv-virtio,qemu (DT)
Call Trace:
[<ffffffff80010216>] dump_backtrace+0x2e/0x3c arch/riscv/kernel/stacktrace.c:130
[<ffffffff85edbc4e>] show_stack+0x34/0x40 arch/riscv/kernel/stacktrace.c:136
[<ffffffff85f3714c>] __dump_stack lib/dump_stack.c:93 [inline]
[<ffffffff85f3714c>] dump_stack_lvl+0x108/0x196 lib/dump_stack.c:119
[<ffffffff85f371f6>] dump_stack+0x1c/0x24 lib/dump_stack.c:128
[<ffffffff85edc812>] panic+0x388/0x806 kernel/panic.c:348
[<ffffffff85f4533a>] schedule_debug kernel/sched/core.c:5745 [inline]
[<ffffffff85f4533a>] __schedule+0x3230/0x3288 kernel/sched/core.c:6411
[<ffffffff85f45a4c>] preempt_schedule_notrace+0xe0/0x2be kernel/sched/core.c:6801
[<ffffffff85f39cc0>] lockdep_enabled kernel/locking/lockdep.c:118 [inline]
[<ffffffff85f39cc0>] lock_is_held_type+0x7a/0x1f2 kernel/locking/lockdep.c:5824
[<ffffffff8017e84a>] lock_is_held include/linux/lockdep.h:249 [inline]
[<ffffffff8017e84a>] __might_resched+0x2b4/0x5fc kernel/sched/core.c:8425
[<ffffffff800e099c>] run_ksoftirqd kernel/softirq.c:930 [inline]
[<ffffffff800e099c>] run_ksoftirqd+0xec/0x144 kernel/softirq.c:920
[<ffffffff8016980e>] smpboot_thread_fn+0x654/0xb9c kernel/smpboot.c:164
[<ffffffff801535f0>] kthread+0x28c/0x3a6 kernel/kthread.c:389
[<ffffffff85f5b972>] ret_from_fork+0xe/0x1c arch/riscv/kernel/entry.S:239
SMP: stopping secondary CPUs
Rebooting in 86400 seconds..


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

