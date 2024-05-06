Return-Path: <linux-kernel+bounces-169496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2260A8BC98B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 806061F21091
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E94B1422A2;
	Mon,  6 May 2024 08:26:26 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623DD1411F4
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 08:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714983985; cv=none; b=njblUhEl4CRZdcg7W7TEzqXrPMirefuMq+9wwfEmDJwv2MOJFZLuBujvqxlG7CB0mKQVVzRScl78HUcavjbIjL0mL2IaQFf3u6oRY7fniQRvu8eprhBvI2bFd9/qca5RstWgLn0B19+R6qUnK6wj16zAn5UBgKTjPyFvpD0jxH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714983985; c=relaxed/simple;
	bh=1gnWL3AWkbByxKqcsyTl0Pn9NxYdIMlbdOu27yM+k7Q=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Dd7vIWebbNXrzq4fWDPM7ud+U4r43ggc33+iw/RpDrPQAR1El7pRMjM10u9WTGujgG5k0flrSwYIdxXK08Lmw/H/MTGwFREP7BDYLVB9VCJy6yTAwzbLzgNdB/26+qJRJjj4B3q/RETaIfVwUGO0gnTid6pBwz0Z5ycK2fUw23g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7e15eaeef60so186209139f.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 01:26:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714983983; x=1715588783;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4oQYfjPoTswq9La2UDJTWDIy0E4GcKbv/iMKFV9nv4Y=;
        b=Iq8/oR+PukKM8390LieRcRSm9CMuoPkPpCEl6aqmNwFCoEaCD0Cdd7kRDYIiwXA3Nq
         GFg3J4lcEBVypGIcT2cnYkSvd38VA4Gmd84E4JNbjah7ZJ03Q1w3+bcQxomV+giMzQ2q
         JjCWOMwUL7Hi2gIR9OEnE9EE7tKJuReof7Xgk6hGa9DjwjMgwkOkBaWAcHlKQRS1XSb2
         eRYO/JiWy3GuQDcIhPcKDw0zBHNPI4NuPN1s2DQeiyWnsWFFcHntxJgA8RGVN8eBoopc
         7j2GWvL+abfUYnbKoDeX33GEoCN0GN8gg9xS1JhMd0IUsxvITVLTgj9sIwv1K19wu9dd
         4OpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzz3Y/bEWQ7xpuiF2DacenQCpFyuH1ETg3Z+o4EvE+uUTWHuzc9LBWu/TAx1ml0oDtIQP664BL7IOuQf50IDu4cxz3Hc8AYnXbSS+W
X-Gm-Message-State: AOJu0YwoCyBOsXKLKmIEquu+GRuLXRJie1F0w7fxJ3espF+goxZBaHLD
	22eSBf4KNKHs6ZcAisR6tKNaTX0pBKAeqgr6YTGd1HcU+bzCfTE3ZOtv6tZM9tt64b+7HPNri91
	sVGjkjiIf++2UU5vHSFoGjzp4YQqSKFEek5n8BeEWT7OEIN+Q7AWNdjg=
X-Google-Smtp-Source: AGHT+IH0auiScA/jwdSBOyDC5Dqm3jkTillkPzY+x0oBjWx/wYwoXx2mSnERXRQoer2DfOhUl2EPNYhPfCZi/AFuVLc4sZCUfb6O
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:a412:0:b0:488:59cc:eb4c with SMTP id
 c18-20020a02a412000000b0048859cceb4cmr389030jal.3.1714983983599; Mon, 06 May
 2024 01:26:23 -0700 (PDT)
Date: Mon, 06 May 2024 01:26:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000235bec0617c4d391@google.com>
Subject: [syzbot] [net?] KMSAN: uninit-value in cmsghdr_from_user_compat_to_kern
From: syzbot <syzbot+bbafcc77279b6c156e52@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7367539ad4b0 Merge tag 'cxl-fixes-6.9-rc7' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1444078b180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bbf567496022057b
dashboard link: https://syzkaller.appspot.com/bug?extid=bbafcc77279b6c156e52
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b037b3fdb412/disk-7367539a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/715a45b086cb/vmlinux-7367539a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a13ab40a70b3/bzImage-7367539a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bbafcc77279b6c156e52@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in cmsghdr_from_user_compat_to_kern+0x568/0x10d0 net/compat.c:154
 cmsghdr_from_user_compat_to_kern+0x568/0x10d0 net/compat.c:154
 ____sys_sendmsg+0x222/0xb60 net/socket.c:2546
 __sys_sendmsg_sock+0x42/0x60 net/socket.c:2650
 io_sendmsg+0x47a/0x1020 io_uring/net.c:453
 io_issue_sqe+0x371/0x1150 io_uring/io_uring.c:1897
 io_wq_submit_work+0xa17/0xeb0 io_uring/io_uring.c:2006
 io_worker_handle_work+0xc3a/0x2050 io_uring/io-wq.c:596
 io_wq_worker+0x5a1/0x1370 io_uring/io-wq.c:649
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was stored to memory at:
 io_sendmsg+0x6a4/0x1020 io_uring/net.c:435
 io_issue_sqe+0x371/0x1150 io_uring/io_uring.c:1897
 io_wq_submit_work+0xa17/0xeb0 io_uring/io_uring.c:2006
 io_worker_handle_work+0xc3a/0x2050 io_uring/io-wq.c:596
 io_wq_worker+0x5a1/0x1370 io_uring/io-wq.c:649
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 __alloc_pages+0x9d6/0xe70 mm/page_alloc.c:4598
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page mm/slub.c:2175 [inline]
 allocate_slab mm/slub.c:2338 [inline]
 new_slab+0x2de/0x1400 mm/slub.c:2391
 ___slab_alloc+0x1184/0x33d0 mm/slub.c:3525
 __kmem_cache_alloc_bulk mm/slub.c:4555 [inline]
 kmem_cache_alloc_bulk+0x503/0x13e0 mm/slub.c:4629
 __io_alloc_req_refill+0x248/0x780 io_uring/io_uring.c:1101
 io_alloc_req io_uring/io_uring.h:405 [inline]
 io_submit_sqes+0xaba/0x2fe0 io_uring/io_uring.c:2481
 __do_sys_io_uring_enter io_uring/io_uring.c:3668 [inline]
 __se_sys_io_uring_enter+0x407/0x4400 io_uring/io_uring.c:3603
 __ia32_sys_io_uring_enter+0x11d/0x1a0 io_uring/io_uring.c:3603
 ia32_sys_call+0x2c0/0x40a0 arch/x86/include/generated/asm/syscalls_32.h:427
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xb4/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/common.c:411
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:449
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

CPU: 1 PID: 20102 Comm: iou-wrk-20100 Tainted: G        W          6.9.0-rc6-syzkaller-00234-g7367539ad4b0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
=====================================================


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

