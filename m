Return-Path: <linux-kernel+bounces-184413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCED8CA6A7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C3271F21994
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5DB1CA8A;
	Tue, 21 May 2024 03:10:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E411C68F
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716261006; cv=none; b=SeIcn1eBHLca40zkI6IZESROe9kUeYfgAUy+uaHDX0/9TWTRohDprN1fAP0lcDO4asDfn3CH2KVC80AO/I9SX63r3xRBAXX2JPSk60F+2k+f7jDddDg0Qq72vaALzM2Vtyyz+XmN0ck/lqhck23k49Zk+4tyNNWzuStCAgUF9TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716261006; c=relaxed/simple;
	bh=jNpgdmywX/Q8NX3pZmMoxw1gBEXlgBwbRE/UD4+nwUE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WAjSD7aSWR6544QNjyOYfa05prh335/yh8KUHRWk2GnZZiI1CHdEWPiR1wdChw2iGRJ4b5DnFpjLmmptIthnEoNGDDl6IDO4ek2SSsJ9BPUgVaLwhDj79U2YsUDRgKt5FLrJbjTxWkZDyu1ywpQqZjKYRIxaDeSSPlPghjr1PQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7e21af40435so203519339f.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:10:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716261004; x=1716865804;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D5UeTxuze7jcviZy9h2jYdcX38BRjbzfYR5h9j7b2uY=;
        b=khrtkEpMLsck/XS/4PgClBIsqEYoioMZlOKiZl0mOaqiN9c9jsvgHzoqjtw3zfCEiV
         yMeR/pPuHD3CTSSrCVoqp1wbsaOjjqF5dBVGjuBMvNn6vrueUMQZU5jrUKGGZZ+BjebA
         2b6JFfx8xI95DQZKMcA7HOErsVV+Jf839VWrUQTDvCN96srthkjlGqvTYFYsFugBuV/G
         ywYCCHIdyfsj7YxJNdlFI97AivN+8L1XDY35y3LcS85cFfcoVe1zq2GHtIrYW8efuywL
         zSbvBvUAZ/ZjnJxb67OQINQaZaMN0ioXw7w1uKa7l8u/kImjQoh2xpDhP6Rts5iQHcQi
         /AuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyIIa+iq5ouJp5KgjA/g1hI9m5kaPDqtZXvI+Diq9T3KvreSOj8MLU1Tp6RCLpiylf6PPm/FBtf5l+YqNRdO6lCQd58xcoV8VELghN
X-Gm-Message-State: AOJu0Ywwb4jXFGXe1YrrfYI36W0nAN0fqPOuGFQxb6//DXzUKgcgOzbo
	/gJRHtfKISgxGmxH5v2ye7fYrFWLoJCvib37PKCxaEJhAJHpzCMg3jcyXqa4i/4gl6NxMrlvvI4
	2WbngqpOu5/3RBCMkdFuLbmtjpu0tl6RFAf4zcbywHqVVD7P2dUS2V9o=
X-Google-Smtp-Source: AGHT+IHfsCooj9kt+MDjyTXfGsTEVJt5pggy+ePsEcaoDtbfJc8ksCv3pL4XphzE33Ul5hGiYAurLwWJtXNU9AeJt3bVOC9Xeppp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c8b:b0:7e2:b00:224b with SMTP id
 ca18e2360f4ac-7e2304d4053mr23696839f.0.1716261004697; Mon, 20 May 2024
 20:10:04 -0700 (PDT)
Date: Mon, 20 May 2024 20:10:04 -0700
In-Reply-To: <tencent_CAB0DDA2192E4FE30DA8A5990DFD923A5D07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086f5b40618ee2716@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in copy_name
From: syzbot <syzbot+efde959319469ff8d4d7@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in hfsplus_listxattr

loop0: detected capacity change from 0 to 1024
1sb: ffff888027b26c00, xnl: 762, hfsplus_listxattr
res: 1, cc: 121, op:ffff888027b26c12, len: 744, ustrlen: 0, hfsplus_uni2asc
=====================================================
BUG: KMSAN: uninit-value in string_nocheck lib/vsprintf.c:647 [inline]
BUG: KMSAN: uninit-value in string+0x36f/0x580 lib/vsprintf.c:728
 string_nocheck lib/vsprintf.c:647 [inline]
 string+0x36f/0x580 lib/vsprintf.c:728
 vsnprintf+0x1b3b/0x2a00 lib/vsprintf.c:2824
 vprintk_store+0x414/0x13f0 kernel/printk/printk.c:2228
 vprintk_emit+0x1e4/0xbc0 kernel/printk/printk.c:2329
 vprintk_default+0x3e/0x50 kernel/printk/printk.c:2363
 vprintk+0xee/0xf0 kernel/printk/printk_safe.c:45
 _printk+0x157/0x190 kernel/printk/printk.c:2373
 hfsplus_listxattr+0xb53/0x1740 fs/hfsplus/xattr.c:743
 vfs_listxattr fs/xattr.c:493 [inline]
 listxattr+0x1f3/0x6b0 fs/xattr.c:840
 path_listxattr fs/xattr.c:864 [inline]
 __do_sys_listxattr fs/xattr.c:876 [inline]
 __se_sys_listxattr fs/xattr.c:873 [inline]
 __x64_sys_listxattr+0x16b/0x2f0 fs/xattr.c:873
 x64_sys_call+0x2ba0/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:195
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3877 [inline]
 slab_alloc_node mm/slub.c:3918 [inline]
 kmalloc_trace+0x57b/0xbe0 mm/slub.c:4065
 kmalloc include/linux/slab.h:628 [inline]
 hfsplus_listxattr+0x4b6/0x1740 fs/hfsplus/xattr.c:699
 vfs_listxattr fs/xattr.c:493 [inline]
 listxattr+0x1f3/0x6b0 fs/xattr.c:840
 path_listxattr fs/xattr.c:864 [inline]
 __do_sys_listxattr fs/xattr.c:876 [inline]
 __se_sys_listxattr fs/xattr.c:873 [inline]
 __x64_sys_listxattr+0x16b/0x2f0 fs/xattr.c:873
 x64_sys_call+0x2ba0/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:195
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 PID: 5518 Comm: syz-executor.0 Not tainted 6.9.0-syzkaller-01768-ga5131c3fdf26-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
=====================================================


Tested on:

commit:         a5131c3f Merge tag 'x86-shstk-2024-05-13' of git://git..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14dc197c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=64e100d74625a6a5
dashboard link: https://syzkaller.appspot.com/bug?extid=efde959319469ff8d4d7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1234ddf0980000


