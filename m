Return-Path: <linux-kernel+bounces-393141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 775729B9C4F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 03:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28C9B1F21E98
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 02:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A35784D3E;
	Sat,  2 Nov 2024 02:18:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85474249F9
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 02:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730513887; cv=none; b=R2veEzFQPH+nwISgcbZYG3yiYvRvXG14NDWvjG7xIOj0nhG1SCGXMKTWVk9q6Md9w+4AmmNFQIloB6piuYrrRX0aHxr+OsAWlQOls3g+vhUTkD6kM9cKXd/WkpHA5UpO9N3sNFIfcBkLrbF3kOR/KIkoS2Tm94VQZydj25xKmw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730513887; c=relaxed/simple;
	bh=6+7zhSZC0TPqbs7WWVf/LFmh9vu8+tkkU2w17Po86LQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MuJlPWlfdmMiIZKv8x2lFLfsvrXYT2Qu49xN2L1gd2hbnLrTMbutCvNxJ/ni2mB3L9Rnghta2iYFRH4XwbaI7i7z5fv4doCWBc/pSOwP7VB+G7pQHNB3a+KbVzgAxtcBykfleaeWCPt+g+seoZB0OcFXs9Kz+gEJ8NdeuGazMF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83aac7e7fd7so263296739f.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 19:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730513885; x=1731118685;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XOmQeVkUGrBcOBZP/e4o8oIuFhChU0/8LuS9KXkaZQ0=;
        b=r/dj5CnnuWZU13hZVt5UGIeRj8QyrgoipmS5OR1QF6LiJpcoAZM0uAOjN57ebsYdG0
         REW2erCFF/WID2T9lv3Ir2y5n6D/UpriyNJqw3GuPv5cepIkk8fSLQwFXveW1fk7AixY
         DXIUuaTq1GWFH8OzWPsmMVzbEjm7/CDmhbssXo2wxoEJfbX+BMPYGGF+uJ5UUgR+P4a7
         7WhCnu6HBtvV5FcU0nVNDUV6dkn/Q2N21cJyEXs2pVFebq9FhyrEEn+OtULUGEZ/6zqW
         DXgR+CQQVSzw0xV9QYdJbBqZGSQayd5hl5vhNXZ5IAd1PT+Da2N6uUQQTth81hGaPJ6l
         W+/A==
X-Forwarded-Encrypted: i=1; AJvYcCXgDr80IcXgR/1C3EyfMIrZmOVdBVoVYKKRVK0Bm1hN7FIc+nvux4aTF0BM05+n5YDMA/Yb200Zf68v5bI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkm+Jn4jqYlqYLMYsUlKNa1VlI0n0QyoO2SIiw9bHCqQCD1h/W
	rFGmN/DyPuBiUb/Joip2c4pq/WgEcRIAw5Q3YdbzA26J/H754G6YGM1splQHlUGZT/I9+rTByzj
	T6GdyMfBgvQsT+nF1B6hSClriKxo/uPAR3n0Lsy1JTG2PU3EoYJRd7Xk=
X-Google-Smtp-Source: AGHT+IEjnvR5ByVSPyVUq9+p2whtrEtlxchPuYaJVsNntqJDXdPWuRpF0l/RSgHxrJ6LgI/bmmVluWOXZWOxSbDXoVpCM1LyH5KN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4b:b0:39f:5e12:1dde with SMTP id
 e9e14a558f8ab-3a4ed2f2830mr252825045ab.21.1730513884658; Fri, 01 Nov 2024
 19:18:04 -0700 (PDT)
Date: Fri, 01 Nov 2024 19:18:04 -0700
In-Reply-To: <tencent_78E99EEC86CEF47AC26CE02E096EEC96BC0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67258bdc.050a0220.3c8d68.091e.GAE@google.com>
Subject: Re: [syzbot] [bpf?] WARNING: locking bug in bpf_map_put
From: syzbot <syzbot+d2adb332fe371b0595e3@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: locking bug in bpf_map_put

=============================
[ BUG: Invalid wait context ]
6.12.0-rc5-syzkaller-00291-g05b92660cdfe #0 Not tainted
-----------------------------
syz.0.15/6647 is trying to lock:
ffffffff8e9b57d8 (map_idr_lock){+...}-{3:3}, at: bpf_map_free_id kernel/bpf/syscall.c:380 [inline]
ffffffff8e9b57d8 (map_idr_lock){+...}-{3:3}, at: bpf_map_put+0x9a/0x380 kernel/bpf/syscall.c:808
other info that might help us debug this:
context-{5:5}
2 locks held by syz.0.15/6647:
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:3}, at: map_delete_elem+0x338/0x5c0 kernel/bpf/syscall.c:1677
 #1: ffff88807caca0f8 (&htab->lockdep_key){....}-{2:2}, at: htab_lock_bucket+0x1a4/0x370 kernel/bpf/hashtab.c:167
stack backtrace:
CPU: 0 UID: 0 PID: 6647 Comm: syz.0.15 Not tainted 6.12.0-rc5-syzkaller-00291-g05b92660cdfe #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4802 [inline]
 check_wait_context kernel/locking/lockdep.c:4874 [inline]
 __lock_acquire+0x15a8/0x2100 kernel/locking/lockdep.c:5152
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 bpf_map_free_id kernel/bpf/syscall.c:380 [inline]
 bpf_map_put+0x9a/0x380 kernel/bpf/syscall.c:808
 htab_put_fd_value kernel/bpf/hashtab.c:911 [inline]
 free_htab_elem+0xbb/0x460 kernel/bpf/hashtab.c:946
 htab_map_delete_elem+0x576/0x6b0 kernel/bpf/hashtab.c:1438
 map_delete_elem+0x431/0x5c0 kernel/bpf/syscall.c:1678
 __sys_bpf+0x598/0x810 kernel/bpf/syscall.c:5644
 __do_sys_bpf kernel/bpf/syscall.c:5760 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5758 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5758
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff3cef7e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff3cfda7038 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007ff3cf135f80 RCX: 00007ff3cef7e719
RDX: 0000000000000020 RSI: 0000000020000300 RDI: 0000000000000003
RBP: 00007ff3ceff132e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007ff3cf135f80 R15: 00007ffd7e2203e8
 </TASK>


Tested on:

commit:         05b92660 Merge tag 'pci-v6.12-fixes-2' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=145a9630580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a6b0d046ffd0e9c1
dashboard link: https://syzkaller.appspot.com/bug?extid=d2adb332fe371b0595e3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

