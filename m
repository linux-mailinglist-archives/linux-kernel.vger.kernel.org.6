Return-Path: <linux-kernel+bounces-329940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 294539797BD
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 18:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D3F9280A12
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 16:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52BF1C8FB5;
	Sun, 15 Sep 2024 16:09:24 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1395B39FEB
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 16:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726416564; cv=none; b=mBdVGFczDg+TWqUcJzqJxRfgBes3uAMEmi+a73DMQyr1cs+HZAaVxvr0C8steeTUi4Fg5NuyXhsbyvQnsYOaCoWW9UX/3eV2iQEm/w1tA7dnIXPPVLuxt0atEjANzo3VKNV4DL//OFTR3ep7fK56mx6tqcANF1hVB5CkQPmL3h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726416564; c=relaxed/simple;
	bh=FqrPJnL4yHJcIv8K1FEz1QhEamKng/ISQ3Bl8Dipflc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jQMnG+3NdF9L8y1aJB7maDZdfTinc1kphOQiCc5yCADeQuy6ByWkIj7OBHR3hJ89EEEtdbrEXFalghZoogbkacnhO0ZmgvN1G5Sy6eWlDbTATvUUBJWjg1a83E0CLPhLOeWJ7o1OUuc3sTbn8IpYkzphPoEK5T5a1x/VFrT6RNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a0980547efso35837435ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 09:09:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726416562; x=1727021362;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nIJdMEW9d9P8+jXupHV5746h78yBKydFnCBaG1bjO80=;
        b=rVfl1r19Vz4I+SlXpHzMAOdPLHoSlPmunX7Pavvn55dTpJnF4ma6MGEdGMQnZi3bBd
         XxgUZRkwsPwumA3bVIF8gMNq60Ez2n7VCUzR7/Fuma8b5N+R0UiOHvNe7/iFyt8Is75h
         CE6z7hYDwIHtKJX0Tre/bcGLS/wCrLHQQll3vUDAu5Q1jLkud/H0jqs+jtl3SyBCs5pa
         Blc5hZBUjJe/GxOIEgRCFxVUncEAqMnfDL7IfkuyPB7FpyrgotmnJDvKYHBSySBl22YS
         T28xAsP9LJZsOBkYZhuv2yrhhXheb1CM0TQZEfWd17qBOrATNHGmKyR8/2w1jQEP1SZ4
         9GZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYtbi+DfGyd59AYDzM4CD8GZ70AH3Ze+titJtCAe5khwpX2tUHAMnpGE8EHRs8GWmyBQB7aQLSTsNnVNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTscf8+EczRMbR+Gu9aEw52It/p10kXQRlbTubEgyR+CKbpoLY
	pE3Tw609R7Fm8EyvvM0/1HzwBouBMb3h117NTMODsEY7keAck23Njfiegw9GOZvEDH7Mu+vm3fq
	nNPIjDRdjzhnv7TcTrDt+JBDvCXIv2DAuIxYT8OcD7BoyCkuFQt3jF5A=
X-Google-Smtp-Source: AGHT+IH2EijF+rbtzm6hg1J64j3GP4Ad3aROxxr8n6TJwsvP5N88AQeTBVYkGaNq4cjQl6e+GpPbUgp0MYNzIuzZEXyjLAjAo1ft
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a6:b0:398:39f:8b4d with SMTP id
 e9e14a558f8ab-3a0848e54afmr128757555ab.5.1726416562101; Sun, 15 Sep 2024
 09:09:22 -0700 (PDT)
Date: Sun, 15 Sep 2024 09:09:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eb301906222aadc2@google.com>
Subject: [syzbot] [riscv?] riscv/fixes test error: kernel panic: Kernel stack overflow
From: syzbot <syzbot+ba9eac24453387a9d502@syzkaller.appspotmail.com>
To: aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7c1e5b9690b0 riscv: Disable preemption while handling PR_R..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=1618e900580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c79e90d7b2f5b364
dashboard link: https://syzkaller.appspot.com/bug?extid=ba9eac24453387a9d502
compiler:       riscv64-linux-gnu-gcc (Debian 12.2.0-13) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: riscv64

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/a741b348759c/non_bootable_disk-7c1e5b96.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/71b65c326093/vmlinux-7c1e5b96.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4110f50eed32/Image-7c1e5b96.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ba9eac24453387a9d502@syzkaller.appspotmail.com

 s11: ff60000011ee5b20 t3 : ffffffffffffffff t4 : fffffffef12c91f0
 t5 : ffffffff89655e40 t6 : 1fec0000023dcb6d
status: 0000000200000100 badaddr: ff20000000087fe8 cause: 000000000000000f
Kernel panic - not syncing: Kernel stack overflow
CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.11.0-rc2-syzkaller-g7c1e5b9690b0 #0
Hardware name: riscv-virtio,qemu (DT)
Call Trace:
[<ffffffff80010216>] dump_backtrace+0x2e/0x3c arch/riscv/kernel/stacktrace.c:130
[<ffffffff85edbd86>] show_stack+0x34/0x40 arch/riscv/kernel/stacktrace.c:136
[<ffffffff85f3735e>] __dump_stack lib/dump_stack.c:93 [inline]
[<ffffffff85f3735e>] dump_stack_lvl+0x108/0x196 lib/dump_stack.c:119
[<ffffffff85f37408>] dump_stack+0x1c/0x24 lib/dump_stack.c:128
[<ffffffff85edc94a>] panic+0x388/0x806 kernel/panic.c:348
[<ffffffff8000fcee>] handle_bad_stack+0xe4/0x10c arch/riscv/kernel/traps.c:427
[<ffffffff8022b788>] __bfs_backwards kernel/locking/lockdep.c:1843 [inline]
[<ffffffff8022b788>] check_irq_usage+0x1d6/0x1466 kernel/locking/lockdep.c:2803
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

