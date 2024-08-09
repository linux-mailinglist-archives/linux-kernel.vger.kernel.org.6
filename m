Return-Path: <linux-kernel+bounces-280303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B83594C85C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 04:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7167A1C21D7E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 02:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEA312B82;
	Fri,  9 Aug 2024 02:04:08 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CF1F9DA
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 02:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723169048; cv=none; b=OmIvzlRKznLEHmxRU1MzW1Je0/LT4JUx1viUg60XKTMCmS2hF00ywysyleMYfmk2nKXgJu4L2C6JsbSbt0FaXN6QugnniQn6NFbAYVUu2pVFqsxEY6OQ/LvlYekEVNDwYRWm6tYCOTCtkPMtK6S9em1CkYVo2quh1VXu8WImM6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723169048; c=relaxed/simple;
	bh=+jTPdcdHFwiBL3qJZeaijVd+0JVzgucX0zvhwZgh5Jo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hSrrfWkeLOHNL0TwYz2npFEKVIoaud5H3GsGMtU1LUbuMfn97PFaYYj7t1fuuE+DNI0pW5eN3yQnp3oIC1OM1z2P/YvGWjo2zxy0/G9j1SZGtmWlKCwPE3LxYy/EzRtPQvbdT07L/oGz7BQrgXCZEIKoqHURhkpsHCy2uwD8Bno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f8d1720ebso195171539f.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 19:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723169046; x=1723773846;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DyvxDKQsz+9GVYT9Os6VuLGXVjX48xB3GCw5HWURFYc=;
        b=AffkvtRWvboXODC7Tu/wFcyjVQKasjQjQPrKKGNiPuqSoVeI9UJyOFyBgO8/Ku0JFe
         mwVSO4lxJ3/AvY+3fsTpSdmp+5081r05Pk9dTpZS5pVyV2QNQocANDewLWde9YG5GZbm
         egA2Q9h0bIe4Sd9PyDbTzbXxCzvOpvhmnDfPr+QDfjmHldm89pMwxXfgDwOlaw6SnCDp
         DqJWz12My5GWQPuJW7bzwN12j8lisa1xF8hRTzjq/Ay9gyC2R5Qow95KO8S+PUPJFlEo
         MmiXvtvfQc+gaFxucmg+mGDvUnYQvuRVr4k+Lhtw5+3q49JDXfEJ4P+xoceF4VIvKhvB
         jaMQ==
X-Gm-Message-State: AOJu0YyMEcijtLDOdbOv9o2NZnb5Umhy+AHtGQcjOTUaNVS/Lthz4yPo
	iA6hNETgY1L4/DQUWb5PPgqY3ZM9dgA1epvRTYya1DZykyKO6i2y8wKJMvQxWnwuLw5leCYAs48
	qRmd6J6XQOIuXhUrXHU2kdpc5+0xVa1H0OO9om/QGYDmtFgf82ICetz0=
X-Google-Smtp-Source: AGHT+IEis0cNA6D7fN/uEsjtrOSJr20rK45BonWytdVcXdDbviYt2UXsI9/f1PKJt4F+UynA7AccmbIsoFAANYwtskuuOwXdVdgp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:9806:b0:4c0:9a3e:c24b with SMTP id
 8926c6da1cb9f-4ca6eb9d115mr21173.0.1723169045765; Thu, 08 Aug 2024 19:04:05
 -0700 (PDT)
Date: Thu, 08 Aug 2024 19:04:05 -0700
In-Reply-To: <20240809014410.672145-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dc7b36061f368e44@google.com>
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: wild-memory-access Read in v9fs_dir_release

==================================================================
BUG: KASAN: wild-memory-access in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: wild-memory-access in _test_bit_acquire include/asm-generic/bitops/instrumented-non-atomic.h:153 [inline]
BUG: KASAN: wild-memory-access in wait_on_bit_timeout include/linux/wait_bit.h:126 [inline]
BUG: KASAN: wild-memory-access in v9fs_dir_release+0x5b6/0x710 fs/9p/vfs_dir.c:225
Read of size 8 at addr 1fff8880330d80c8 by task syz.0.15/5886

CPU: 3 UID: 0 PID: 5886 Comm: syz.0.15 Not tainted 6.11.0-rc1-syzkaller-00154-gc0ecd6388360-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0xef/0x1a0 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit_acquire include/asm-generic/bitops/instrumented-non-atomic.h:153 [inline]
 wait_on_bit_timeout include/linux/wait_bit.h:126 [inline]
 v9fs_dir_release+0x5b6/0x710 fs/9p/vfs_dir.c:225
 __fput+0x408/0xbb0 fs/file_table.c:422
 task_work_run+0x14e/0x250 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xaa3/0x2bb0 kernel/exit.c:882
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1031
 get_signal+0x25fd/0x2770 kernel/signal.c:2917
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbb473773b9
Code: Unable to access opcode bytes at 0x7fbb4737738f.
RSP: 002b:00007fbb4807f0f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: 0000000000000001 RBX: 00007fbb47505f88 RCX: 00007fbb473773b9
RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00007fbb47505f8c
RBP: 00007fbb47505f80 R08: 00007fbb48080080 R09: 00007fbb4807f6c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fbb47505f8c
R13: 000000000000000b R14: 00007fff1cf6dc20 R15: 00007fff1cf6dd08
 </TASK>
==================================================================


Tested on:

commit:         c0ecd638 Merge tag 'pci-v6.11-fixes-1' of git://git.ke..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15b3bd23980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8da8b059e43c5370
dashboard link: https://syzkaller.appspot.com/bug?extid=0b74d367d6e80661d6df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15702291980000


