Return-Path: <linux-kernel+bounces-276895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 649F69499C2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A6B51F21D1F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D24E16D9B9;
	Tue,  6 Aug 2024 20:59:29 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D9B15573A
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 20:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722977969; cv=none; b=bzsfYJ9BFc315mXGkiz+HWJ77f1+xW9wacqXQiI3askHG8YBRX4iVGLEoVEaDZYVmphHDIZBAFjG6JDkFSIXlsiczfofEgDTXgLE6O0djbls+zSWigXLiGjwjCdNh+Q8VYdwZPGrZCMpZGXkOhbrPu5yhkUUGT7OO9kE8C8z/EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722977969; c=relaxed/simple;
	bh=ehTKYVnxzN4Em69tEUZl7Fl720FVMz0oLqUp/CeJTuI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qMUIMC/wCEWIj8Kzeif47VfzctSswLdqIdv+5DnKj50TshDHdcw4XJOoQSG/EBMDViIxRPKqN+uZ4MN6B90ldRlqgScytufgvb8R8zQKy7TQmdK/I8lRoJ/eOEp+1hGMhQK+SoTeaWy7kWnzS3VQhg8gdZM9oJu0j4gqYdpM8hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39b3b5858e6so13235665ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 13:59:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722977967; x=1723582767;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d2Zb4qHRdNaBW9lnmm93Rls+1yHmfEFpvjbCaqW5xWQ=;
        b=MPuMD2zOsm716Jmvqz5exY5FcJZp7DE/6UHBG4OlKw3KnPiiYxF7vLz8X/N/nGATLN
         6dDsnjq6wuxPYAw3adonR76ZMTJh68pNgENXTf+sNzCBARe6P0Tnz941IB1DXoIT3xuD
         rDXJpsi2KRwuve8ehuzVwhGaKOIzm3c4R9AT3gtC/5W3IMaBtRwbqKP3XPGPOsKpWIht
         rNHKvnT4V9BfZdCGtwPOrrOYZGMtzN5nktIgFOyi8Ub25F1QKXONlX79atScb8CQ+XUy
         crCRCmZWM6ACPSmb8fqZsOiFGP/xoK1duHUBiKvxuC7zsDqHNt0LiJfsj7ilF6FA1BSS
         acMQ==
X-Gm-Message-State: AOJu0Ywc+QzQTN1Jp1PXpc0TJ5DeA+LSzVEyMc8+ZhIjSl375SrbkQPc
	+umsb8q35LLKDbTWqiWW2oX9wqomZaOd8ggoELMro2Zi1VKfrMyJNRfXrY56j+dK5KGlV1qq7Pw
	73H9ZGL2mtpG1xMH6KAKtZ3OAJ/UJKR2TTcrK+19X5QodUOmLmGv/dPM=
X-Google-Smtp-Source: AGHT+IFmH9UnzhC/T2ONfxI71jBqSjFRCMoEp/vrL+PzvkzDMJwkLFs5BCNCic9Ex+cklhcGat0RDTvc/yW5oU7zrARWmOaCs5LK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154b:b0:397:95c7:6f72 with SMTP id
 e9e14a558f8ab-39b1fc8baecmr12735905ab.6.1722977966707; Tue, 06 Aug 2024
 13:59:26 -0700 (PDT)
Date: Tue, 06 Aug 2024 13:59:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a96781061f0a1165@google.com>
Subject: [syzbot] [kernel?] kernel panic: corrupted stack end in do_idle
From: syzbot <syzbot+1e65605d6233841d7c3c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b446a2dae984 Merge tag 'linux_kselftest-fixes-6.11-rc3' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12b2759d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=692f298d4e1a1b64
dashboard link: https://syzkaller.appspot.com/bug?extid=1e65605d6233841d7c3c
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/8ead8862021c/non_bootable_disk-b446a2da.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/15ff7610068d/vmlinux-b446a2da.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ef3c5eb94167/zImage-b446a2da.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1e65605d6233841d7c3c@syzkaller.appspotmail.com

Kernel panic - not syncing: corrupted stack end detected inside scheduler
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.11.0-rc2-syzkaller #0
Hardware name: ARM-Versatile Express
Call trace: 
[<81953848>] (dump_backtrace) from [<81953944>] (show_stack+0x18/0x1c arch/arm/kernel/traps.c:257)
 r7:00000000 r6:826228c4 r5:00000000 r4:8200ba34
[<8195392c>] (show_stack) from [<81971618>] (__dump_stack lib/dump_stack.c:93 [inline])
[<8195392c>] (show_stack) from [<81971618>] (dump_stack_lvl+0x54/0x7c lib/dump_stack.c:119)
[<819715c4>] (dump_stack_lvl) from [<81971658>] (dump_stack+0x18/0x1c lib/dump_stack.c:128)
 r5:00000000 r4:8286bd18
[<81971640>] (dump_stack) from [<819543ec>] (panic+0x120/0x358 kernel/panic.c:348)
[<819542cc>] (panic) from [<81975e8c>] (schedule_debug kernel/sched/core.c:5745 [inline])
[<819542cc>] (panic) from [<81975e8c>] (__schedule+0xb68/0xb6c kernel/sched/core.c:6411)
 r3:57ac6e9d r2:00000000 r1:8200ba34 r0:81fff164
 r7:824b9340
[<81975324>] (__schedule) from [<819761a8>] (schedule_idle+0x24/0x68 kernel/sched/core.c:6647)
 r10:00000000 r9:00000000 r8:00000000 r7:8260c5fc r6:8261ae40 r5:8260c5d0
 r4:8261ae40
[<81976184>] (schedule_idle) from [<80297f48>] (do_idle+0x19c/0x2cc kernel/sched/idle.c:354)
 r5:8260c5d0 r4:00000000
[<80297dac>] (do_idle) from [<802983ac>] (cpu_startup_entry+0x30/0x34 kernel/sched/idle.c:424)
 r10:8261a970 r9:82128eb4 r8:8260c580 r7:00000000 r6:deffc061 r5:82625864
 r4:000000ee
[<8029837c>] (cpu_startup_entry) from [<81973968>] (kernel_init+0x0/0x138 init/main.c:747)
[<81973888>] (rest_init) from [<82401398>] (start_kernel+0x75c/0x778 init/main.c:1103)
[<82400c3c>] (start_kernel) from [<00000000>] (0x0)
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

