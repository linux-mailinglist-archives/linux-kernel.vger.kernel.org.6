Return-Path: <linux-kernel+bounces-318707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE6996F1D8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4916328367E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CC61C9DE5;
	Fri,  6 Sep 2024 10:46:30 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F42A81745
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 10:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725619590; cv=none; b=byvqaXZNA0P9ZAhlUjb6bTcjllP+L4yG7PgirCTqZNomD3hmCWvmxoyqj3qnesPMNZOxxAAML/HYs/K6R4+Wq4+TwYOzECxrtZJc8qs9brvV+M720P5UEqrKmZVe+MX6QQxB8S6mraGSgShySruwftqu/WjXjGex2e2prWhOsdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725619590; c=relaxed/simple;
	bh=cuS0LmEDdRvK168YAcOxpF2YozCspKZLiWR/eHXEVqw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Esfbu0aKgaetWaooNDo4MASHckI5ixHejE+1J7N+aN9TBcFbtXLtu0EcyY1mfprc7XovtRbb7UMgwEAwlS3LNXcg+m3jswu+GgltqTAjMoqKNIKSaaNR0tLYfSYTN/3vNZfeDs3z8U7eZD9m/wIxcU+ntnB50wZDKMNYZnlu5aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a05009b331so10925615ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 03:46:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725619588; x=1726224388;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tkwaehz+iG9JFBYhsoZrFz/XPoHEB1/o/QKI8Mm8xSw=;
        b=PHzK3gYhqGx2x3V6+l425rL32vvK+nZ10x4I1WvT/hC6ChiqDdogpbieam9CynL5/J
         5aXx+z1Rb+GvSeElUZnpeeeuqi4v4uKTMZnEVy0YMafKCsus5oiQrfDzywi5RBn3mLTW
         bFO03wT00S7ErqFlii2CfNk5QU4MxU7uLb7Bf6xclVZ5Jc5qtqkoYR+XCJ13PeEBLOFx
         n41Pgp0VgAPakG0rkLmnN76h5/TZesOc7Y8Fh0mvzTbwte94Ef13TEcyloEqcM5965WM
         xrLzEAP3aBcu2h7Nksh4dGCn4YSUEMF+Vq2TLcR+a1rswOdXldFvGPL/8xUY82uAM6a6
         Qktg==
X-Forwarded-Encrypted: i=1; AJvYcCXYVSLiFap8kdoYXna3bmsi8Sj3M2eHUtyaBPfN/PZxwCrqjOz0EHS4z+qEzvqWFKQAt81zWmYbNuHVoCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmAMCk/hauC2V17VT4BUguUEheb84TelpXJoaSbYPcyz3F7jeY
	wR/6WjDfn/ZBTKL1LmcXzUSu2y14/yyLgEj6EcWImkU2rDI5VTjOif7gOC3xCG4oBeB3neYY0cH
	EGyPa+ywNZ4+G1eR7No3g385jHjKeTkAWtyIy/Jua8p9SlJ51CRG2UC8=
X-Google-Smtp-Source: AGHT+IHFexPtZUpEN2Y9YNgz7bFHlt8qELmhdsDJ0CKW5F34L5elPWEyh9+dNZlwJEvO6pD6CkyEW4dUpED29rrwvva6ei9R3D+a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188a:b0:3a0:4c30:fa6f with SMTP id
 e9e14a558f8ab-3a04eff83eemr1399745ab.0.1725619587733; Fri, 06 Sep 2024
 03:46:27 -0700 (PDT)
Date: Fri, 06 Sep 2024 03:46:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008b6aa30621711e8f@google.com>
Subject: [syzbot] [mm?] KCSAN: data-race in do_sync_mmap_readahead /
 do_sync_mmap_readahead (7)
From: syzbot <syzbot+55b80301d2f1b98738ce@syzkaller.appspotmail.com>
To: jstultz@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	sboyd@kernel.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c3f2d783a459 Merge tag 'mm-hotfixes-stable-2024-08-17-19-3..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16475bd3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=77bd8f74037eecb
dashboard link: https://syzkaller.appspot.com/bug?extid=55b80301d2f1b98738ce
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7d33f08b7d45/disk-c3f2d783.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/06f0ae9609a1/vmlinux-c3f2d783.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e319fa11563c/bzImage-c3f2d783.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+55b80301d2f1b98738ce@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in do_sync_mmap_readahead / do_sync_mmap_readahead

write to 0xffff88810f822480 of 4 bytes by task 4192 on cpu 0:
 do_sync_mmap_readahead+0x236/0x2a0 mm/filemap.c:3172
 filemap_fault+0x331/0xa60 mm/filemap.c:3314
 __do_fault+0xb6/0x200 mm/memory.c:4655
 do_shared_fault mm/memory.c:5121 [inline]
 do_fault mm/memory.c:5195 [inline]
 do_pte_missing mm/memory.c:3947 [inline]
 handle_pte_fault mm/memory.c:5521 [inline]
 __handle_mm_fault mm/memory.c:5664 [inline]
 handle_mm_fault+0xc0a/0x2940 mm/memory.c:5832
 do_user_addr_fault arch/x86/mm/fault.c:1389 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x296/0x650 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
 rep_movs_alternative+0x33/0x70 arch/x86/lib/copy_user_64.S:57
 copy_user_generic arch/x86/include/asm/uaccess_64.h:110 [inline]
 raw_copy_to_user arch/x86/include/asm/uaccess_64.h:131 [inline]
 _inline_copy_to_user include/linux/uaccess.h:181 [inline]
 _copy_to_user+0x77/0xa0 lib/usercopy.c:26
 copy_to_user include/linux/uaccess.h:209 [inline]
 put_timespec64+0x64/0xb0 kernel/time/time.c:910
 __do_sys_clock_gettime kernel/time/posix-timers.c:1144 [inline]
 __se_sys_clock_gettime kernel/time/posix-timers.c:1132 [inline]
 __x64_sys_clock_gettime+0x138/0x180 kernel/time/posix-timers.c:1132
 x64_sys_call+0x27b5/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:229
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

write to 0xffff88810f822480 of 4 bytes by task 4191 on cpu 1:
 do_sync_mmap_readahead+0x236/0x2a0 mm/filemap.c:3172
 filemap_fault+0x331/0xa60 mm/filemap.c:3314
 __do_fault+0xb6/0x200 mm/memory.c:4655
 do_shared_fault mm/memory.c:5121 [inline]
 do_fault mm/memory.c:5195 [inline]
 do_pte_missing mm/memory.c:3947 [inline]
 handle_pte_fault mm/memory.c:5521 [inline]
 __handle_mm_fault mm/memory.c:5664 [inline]
 handle_mm_fault+0xc0a/0x2940 mm/memory.c:5832
 do_user_addr_fault arch/x86/mm/fault.c:1389 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x296/0x650 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
 rep_movs_alternative+0x33/0x70 arch/x86/lib/copy_user_64.S:57
 copy_user_generic arch/x86/include/asm/uaccess_64.h:110 [inline]
 raw_copy_to_user arch/x86/include/asm/uaccess_64.h:131 [inline]
 _inline_copy_to_user include/linux/uaccess.h:181 [inline]
 _copy_to_user+0x77/0xa0 lib/usercopy.c:26
 copy_to_user include/linux/uaccess.h:209 [inline]
 put_timespec64+0x64/0xb0 kernel/time/time.c:910
 __do_sys_clock_gettime kernel/time/posix-timers.c:1144 [inline]
 __se_sys_clock_gettime kernel/time/posix-timers.c:1132 [inline]
 __x64_sys_clock_gettime+0x138/0x180 kernel/time/posix-timers.c:1132
 x64_sys_call+0x27b5/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:229
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x00000000 -> 0x00000020

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 4191 Comm: syz.0.141 Not tainted 6.11.0-rc3-syzkaller-00338-gc3f2d783a459 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
==================================================================


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

