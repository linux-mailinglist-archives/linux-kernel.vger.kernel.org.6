Return-Path: <linux-kernel+bounces-393183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB049B9D61
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 07:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF2A285B03
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 06:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AC11465B3;
	Sat,  2 Nov 2024 06:16:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F4A1171C
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 06:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730528165; cv=none; b=WyeVpUfGsmUFn1cRVXEZ1DIfkfQJBjIlKwsrMhXYE36NqBJr+eH6rqBSN3kASZrpHN5bFwQfj+xiD3Qn0pXdM62HMzCYhTVKZ16PnYpF6NsHaKucthRZhZUjMPVfZptw9vR8LUPNDOXmWUmUpgoJbGfmIqFVMSjuzqIQuKcnLEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730528165; c=relaxed/simple;
	bh=4knUDubE4cJ6B8l/1TgSP8l94UYjxa2As6nvzYbHcFk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HXRAMd1i+wqzKdViE9jAhg6PYFOLTPXsZA0MBEHu3eREeqQIfGh6+lvaaC8jawxcJPzu8a3JR9da4cr38Vx7Xub4YIzlrDageQeX4gFappRpFQy1HmpkVvvTf7XBnWAMn9tU/Vn5W4Wb7uQOXNdMzWfKUrscvKMwssSrVcr2aRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83aae46538bso265679739f.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 23:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730528163; x=1731132963;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uJU5OjTkgIVFR2+zBCDrkpXZONAV8bCOfVhVOIX8DIA=;
        b=FOmKuATVIdqs5GKbmEI5jIaVMQn+2h25+qlWq6Mt/C/y5WOA0YU0raIhZq3Z/CAXi0
         deScOEXebjD1zj6c50jGhuaGcWuPbmKeZGmaIl1qMeS7E8pOxugGux1j+nBzWuZdVetH
         f/T2NvA9US5l+HWBwyWx+3qFhGdTa1/szEfOcadTNQn5Tj558vKmGFqilcwlLSoIKWgm
         GNh8j+9Dr9SrrH5HiXWVopXSJQOlLrD39xdVZUoYWXkyVz6ke1cZ0gbWKMjAkVuknBBR
         a+hy3wONIhSQ91mrQVRhMS+uj716NpCV+cbKM6DaeHUxBRGcuzQ+3UgF1HCQURC03SPd
         NZkg==
X-Forwarded-Encrypted: i=1; AJvYcCUdcTyYosrSAM1drwfd9b6AC0Wk0WQKUGpalovie6U5DOq+UtktJ2vl1SSWKxUKxqOor/WS4nlwvc5NUNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC6fs+RrBJpExPkyHsoE4w8/uFRkj6n2sbLZvbauQmXYBDJD9x
	jS80JllSIXm8ReBtwXTv6V9CL8nJPsLGO/mwUCqjzEhN8/PwjuAV0CjxhUnPzEHioaOPvO6KumU
	cGOAf0n3oYRtVRzXCaYn771O0AiEOdjXIFdNpnxwAKFcvffZmXRLd+f4=
X-Google-Smtp-Source: AGHT+IFE23HXzBZmXWctwXYpd7mYet/1XsJ/dAQrCGESdCxnjvpppCKS7UlV2TDP2eVjG1rQJdOY6rR6OgY0lLH6kaNxcvDW6gNH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18c5:b0:3a3:afa3:5155 with SMTP id
 e9e14a558f8ab-3a6175728e1mr97538875ab.25.1730528162668; Fri, 01 Nov 2024
 23:16:02 -0700 (PDT)
Date: Fri, 01 Nov 2024 23:16:02 -0700
In-Reply-To: <tencent_C34B2C1BD325BFBAC0BB5C339C9EB01B4008@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6725c3a2.050a0220.529b6.025c.GAE@google.com>
Subject: Re: [syzbot] [bpf?] WARNING: locking bug in bpf_map_put
From: syzbot <syzbot+d2adb332fe371b0595e3@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: locking bug in radix_tree_node_alloc

=============================
[ BUG: Invalid wait context ]
6.12.0-rc5-syzkaller-00299-g11066801dd4b-dirty #0 Not tainted
-----------------------------
syz.0.15/6617 is trying to lock:
ffff8880b8643cc0 (&c->lock){-.-.}-{3:3}, at: local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
ffff8880b8643cc0 (&c->lock){-.-.}-{3:3}, at: ___slab_alloc+0x265/0x14b0 mm/slub.c:3695
other info that might help us debug this:
context-{5:5}
2 locks held by syz.0.15/6617:
 #0: ffff8880b863d678 (lock){+.+.}-{3:3}, at: local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
 #0: ffff8880b863d678 (lock){+.+.}-{3:3}, at: __radix_tree_preload+0x80/0x860 lib/radix-tree.c:334
 #1: ffffffff8e9b57d8 (map_idr_lock){+...}-{2:2}, at: bpf_map_alloc_id+0x21/0xe0 kernel/bpf/syscall.c:355
stack backtrace:
CPU: 0 UID: 0 PID: 6617 Comm: syz.0.15 Not tainted 6.12.0-rc5-syzkaller-00299-g11066801dd4b-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4802 [inline]
 check_wait_context kernel/locking/lockdep.c:4874 [inline]
 __lock_acquire+0x15a8/0x2100 kernel/locking/lockdep.c:5152
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
 ___slab_alloc+0x27e/0x14b0 mm/slub.c:3695
 __slab_alloc+0x58/0xa0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x2a0 mm/slub.c:4141
 radix_tree_node_alloc+0x8b/0x3c0 lib/radix-tree.c:276
 idr_get_free+0x296/0xab0 lib/radix-tree.c:1506
 idr_alloc_u32+0x195/0x330 lib/idr.c:46
 idr_alloc_cyclic+0x106/0x300 lib/idr.c:125
 bpf_map_alloc_id+0x40/0xe0 kernel/bpf/syscall.c:356
 map_create+0xdc3/0x11c0 kernel/bpf/syscall.c:1398
 __sys_bpf+0x6c8/0x810 kernel/bpf/syscall.c:5661
 __do_sys_bpf kernel/bpf/syscall.c:5786 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5784 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5784
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe23117e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe231ee3038 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007fe231335f80 RCX: 00007fe23117e719
RDX: 0000000000000048 RSI: 00000000200004c0 RDI: 0000000000000000
RBP: 00007fe2311f132e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fe231335f80 R15: 00007fff2658b528
 </TASK>


Tested on:

commit:         11066801 Merge tag 'linux_kselftest-fixes-6.12-rc6' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=143a5630580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a6b0d046ffd0e9c1
dashboard link: https://syzkaller.appspot.com/bug?extid=d2adb332fe371b0595e3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12ce3340580000


