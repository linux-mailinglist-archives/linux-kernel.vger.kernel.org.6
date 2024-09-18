Return-Path: <linux-kernel+bounces-332293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 840B697B7DF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 08:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09E3CB28827
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 06:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEBD15572C;
	Wed, 18 Sep 2024 06:22:28 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F28D13CA81
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 06:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726640548; cv=none; b=NCVKyGTMNIghTGSzahX09C97I/Vdn61iQc02WK2SBB1LewQKxZ18usqGWkaiD+HQul7c0rfIYa2P3ZNaenRYDIOXNginCDSRcZTWWWgFSjw+Iwa6QOajJtW2/BeJ59TXhOi90kwVYWkpOr8Z+ClGBhcyzHm1FXgTlAyBk3fnoxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726640548; c=relaxed/simple;
	bh=P+owOuPYyGFcRYkiwIFUSSnhtaysANFmowt3zdKJwXc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Zkmt7T2VdM5ssXN3O8VZMapaaHGnOvRmMwIecYISAoPnJnzQpkxf/CR2NOuELZWOoi/9YjwRxsta3BOb/Ra+hdB/scpOC7Z/I2EaN4oNUKAhsbRL9KrvYWdaNerQXPwKT46xKRRok4+gFN40InN5MMQANbAVAoG2N6OAeEhMNg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a0ab3fe36dso4572985ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 23:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726640546; x=1727245346;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qhQcknVPyfgEJpCAyxaSS59FNZpQyuadCo2mbqRxTS8=;
        b=tjfX/gNxE7RJGjoVZCssB3qgVBCsy8cOJq10niJIchAXP3IYR7zSC1s4KBHXm8rFAk
         VO4LIcbkw7Kj3R9lg9mhAK0wyPgLtQ+GwBWiTU8pXJD/rEejJNeWLncUKrRH2NY1Jzcu
         GJTYHhqUKkZnYYOY37z96nuJEgHXLSigDNvOKO4G1liavzVtjs5MbG3x/6y5T9yFIn6A
         YlJ1qBidhXnw2jw7uoxycvTsfrBSqWvhHHjtnnDFnaHyIegTHrID7QZ00K6MccgZoCaE
         xh675Dh+/gBvoeU2WLodr57kkBG0UTe+qU+uH+3dRD2y/da7z1XjKlvc0XzmqouuVVH2
         KkJg==
X-Gm-Message-State: AOJu0YyJgyPCmfHQPKkJicwYvutQjkvqWPVY/425PI7c/lEXfh645S/b
	Xz47SaBFMwREmDyyZSvTlI5+xRdHwJLRtTiNzM8WdyaVT7M/UdxgUMPcOAf/FJ+oAZjREduyg0p
	lm2ffr9xhJgyHT1BF9HKs6QfXHSR5gM0pIRkiOiiBoVm80TmoKkz3jpk=
X-Google-Smtp-Source: AGHT+IFFFmBp3UW/AA8UeDY8z6VwxejKLkDFDIMSI4tFwQ6LbZxYMMunn0sOYERnoyeCEJE2jd2n2K31ZtfG0eu5Vn1GPCEote09
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156e:b0:3a0:9b27:7d67 with SMTP id
 e9e14a558f8ab-3a09b277f33mr87454565ab.11.1726640546098; Tue, 17 Sep 2024
 23:22:26 -0700 (PDT)
Date: Tue, 17 Sep 2024 23:22:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000067c0b706225ed4b0@google.com>
Subject: [syzbot] [kernel?] kernel panic: corrupted stack end in smpboot_thread_fn
From: syzbot <syzbot+c634615db61fdcc74232@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7c1e5b9690b0 riscv: Disable preemption while handling PR_R..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=1259bfc7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c79e90d7b2f5b364
dashboard link: https://syzkaller.appspot.com/bug?extid=c634615db61fdcc74232
compiler:       riscv64-linux-gnu-gcc (Debian 12.2.0-13) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: riscv64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/a741b348759c/non_bootable_disk-7c1e5b96.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0f3679bc7f7b/vmlinux-7c1e5b96.xz
kernel image: https://storage.googleapis.com/syzbot-assets/867fc7aa207b/Image-7c1e5b96.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c634615db61fdcc74232@syzkaller.appspotmail.com

Kernel panic - not syncing: corrupted stack end detected inside scheduler
CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.11.0-rc2-syzkaller-g7c1e5b9690b0 #0
Hardware name: riscv-virtio,qemu (DT)
Call Trace:
[<ffffffff80010216>] dump_backtrace+0x2e/0x3c arch/riscv/kernel/stacktrace.c:130
[<ffffffff85edbd86>] show_stack+0x34/0x40 arch/riscv/kernel/stacktrace.c:136
[<ffffffff85f3735e>] __dump_stack lib/dump_stack.c:93 [inline]
[<ffffffff85f3735e>] dump_stack_lvl+0x108/0x196 lib/dump_stack.c:119
[<ffffffff85f37408>] dump_stack+0x1c/0x24 lib/dump_stack.c:128
[<ffffffff85edc94a>] panic+0x388/0x806 kernel/panic.c:348
[<ffffffff85f4554a>] schedule_debug kernel/sched/core.c:5745 [inline]
[<ffffffff85f4554a>] __schedule+0x3230/0x3288 kernel/sched/core.c:6411
[<ffffffff85f45666>] __schedule_loop kernel/sched/core.c:6606 [inline]
[<ffffffff85f45666>] schedule+0xc4/0x324 kernel/sched/core.c:6621
[<ffffffff801695e0>] smpboot_thread_fn+0x2ea/0xb9c kernel/smpboot.c:160
[<ffffffff8015372c>] kthread+0x28c/0x3a6 kernel/kthread.c:389
[<ffffffff85f5bb82>] ret_from_fork+0xe/0x1c arch/riscv/kernel/entry.S:239
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

