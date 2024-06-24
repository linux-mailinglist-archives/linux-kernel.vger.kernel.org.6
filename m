Return-Path: <linux-kernel+bounces-226827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E36491446B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C98C8281DB6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1018D4AECE;
	Mon, 24 Jun 2024 08:17:23 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C30849652
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719217042; cv=none; b=ZTxYPYMjWGevzLRskuUckd9jGgx2kJmP0VX3m5lx4dfsu+rSN70s6PMJ2as3LGlkWt6DlQR+RuHFibgkJHFJedaf+8gvTdn4nJ0ZGSL5HVCg2+VRhakQXd0uZDPWpCTXy5mKc8j5Kkn4EaBRTGdk2yxh+HwSbWramfCspw0TpME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719217042; c=relaxed/simple;
	bh=48cOdN4PuePxmojtyTa2DfkcwJPJsmX9zBw4qHtg6ZU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Ryo4797mWR+pBtFnPp0FQ4N7g8Rgtzg6MA52LT2E+I2n1qq/GmLRuAosXFYHhUqF4AWypqqVT+OxJ0p/EBmU4yWT8QCcZtnrsjXQNereeyLdsC4xZ9FzMbJFHFMTbEIWQTyLvY/Z4oXjzt6XfvqliK3+bpi3iVYPgg+lOYman+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7eb01189491so536922939f.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 01:17:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719217040; x=1719821840;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cb7YV6N594TNGXj5Z0so7J+YBmlEIUP0oD8xrTwJKVk=;
        b=tUObsEguB5kOEFbeLxr1IL+KRvdyss/71csW78y0Raaytx1HfyXOggXi27P/bZdSuE
         9EqQneYsvXBujpR2H7xCzg/AomeBQ7/fl/YpUgpjhqM2MRjgaMAznaQkrlvCGxyidt3j
         m+Dk7ztxsmY/3ZyHR/XH9gOSHk004IkgcAhOkT6omPJ8zixEybXdg8HxYJpHrPqT0q20
         tPqHB4CNbJDsfLyDbKlrJzeMNFgUZLzZIbBkD76UXNXHUwRKGqPivO/XgeYnFuSuKOL+
         Jz5UdhO0cOijP7IhVr1XttSwOS+GIXqGm0pno2dGb72NFzBjKGSueSMHBRz9aHVl+ReW
         21uQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX7kH4vsB1nHRGyjX2mO4fz+clegPyO1+AadQR8jceqSpBzSPqhRCtgbTFqzFXqcOozjNo5LERIvUvJHO7md5qd0j0RNRFbrIXliy/
X-Gm-Message-State: AOJu0Yz46+du+1uWvJC8roiGl45EFhQEH742pfb202ksMxK31b2R3C83
	6+dDAAlVMKs6qEgaWvdWbaNWlcN7W5sPMx79Zzd3wOdY5ggCXeiH+jZOZEl4Vjas9qaN4YVAb0l
	10WCBYh8TqNeW21fm0sSBYWkHj2Mgyuh1EORGjtPfUu6vD08kqZCEtRY=
X-Google-Smtp-Source: AGHT+IFpZwUj1I08hTQpAF6jqKtPR3PEAwWD9FJ6deqxfVhGRxLunCTDw6JmCIQ+vKvwp0g256eG4gIDisJTUSaSCgvrVqit/ldN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:629f:b0:4b9:a647:36d0 with SMTP id
 8926c6da1cb9f-4b9ec60ef56mr187572173.0.1719217040322; Mon, 24 Jun 2024
 01:17:20 -0700 (PDT)
Date: Mon, 24 Jun 2024 01:17:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fb03a7061b9e68eb@google.com>
Subject: [syzbot] [mm?] KCSAN: data-race in __anon_vma_prepare /
 handle_mm_fault (3)
From: syzbot <syzbot+3d69e72f363bbb907374@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7c16f0a4ed1c Merge tag 'i2c-for-6.10-rc5' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17a1b551980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=704451bc2941bcb0
dashboard link: https://syzkaller.appspot.com/bug?extid=3d69e72f363bbb907374
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9acd4869df3e/disk-7c16f0a4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a5b6e853a6e5/vmlinux-7c16f0a4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/23b225386827/bzImage-7c16f0a4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3d69e72f363bbb907374@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in __anon_vma_prepare / handle_mm_fault

write to 0xffff888103d6e888 of 8 bytes by task 6933 on cpu 0:
 __anon_vma_prepare+0x180/0x310 mm/rmap.c:213
 vmf_anon_prepare mm/memory.c:3239 [inline]
 do_anonymous_page mm/memory.c:4451 [inline]
 do_pte_missing mm/memory.c:3895 [inline]
 handle_pte_fault mm/memory.c:5380 [inline]
 __handle_mm_fault mm/memory.c:5523 [inline]
 handle_mm_fault+0x1c03/0x2a80 mm/memory.c:5688
 do_user_addr_fault arch/x86/mm/fault.c:1389 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x296/0x650 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
 __put_user_4+0x11/0x20 arch/x86/lib/putuser.S:86
 __sys_socketpair+0xba/0x430 net/socket.c:1756
 __do_sys_socketpair net/socket.c:1822 [inline]
 __se_sys_socketpair net/socket.c:1819 [inline]
 __x64_sys_socketpair+0x52/0x60 net/socket.c:1819
 x64_sys_call+0x27a9/0x2d70 arch/x86/include/generated/asm/syscalls_64.h:54
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff888103d6e888 of 8 bytes by task 6932 on cpu 1:
 vmf_anon_prepare mm/memory.c:3231 [inline]
 do_anonymous_page mm/memory.c:4451 [inline]
 do_pte_missing mm/memory.c:3895 [inline]
 handle_pte_fault mm/memory.c:5380 [inline]
 __handle_mm_fault mm/memory.c:5523 [inline]
 handle_mm_fault+0xcf3/0x2a80 mm/memory.c:5688
 do_user_addr_fault arch/x86/mm/fault.c:1338 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x3b9/0x650 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

value changed: 0x0000000000000000 -> 0xffff888118538138

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 6932 Comm: syz-executor.4 Not tainted 6.10.0-rc4-syzkaller-00330-g7c16f0a4ed1c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
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

