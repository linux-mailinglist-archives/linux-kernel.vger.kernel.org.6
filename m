Return-Path: <linux-kernel+bounces-260928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C76293B079
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2165B227EC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 11:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D151581FF;
	Wed, 24 Jul 2024 11:39:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D78A481CD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 11:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721821144; cv=none; b=EJ+DYpQj9CgMQL4LjZyUgMady85EXCQ1qFCQJn39gaT1zWLkr0iqAW8WAsHZN+I/SLgfCFoneAY5QixrnePVOz9tMW6u+7RoPEV2CwxCuF1rzLNs7XH3oI9TTe4CZdKQc8WplAYgweF0SMtAeufXRFDJ072poFPWPZ1fNRn+A0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721821144; c=relaxed/simple;
	bh=z2wsP7Oi7tDgSLgDOWCRogpqaK6nWVT46jdQWIaGI14=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rKW1ZZXXns8+95WU1PHNDnz8bdPQMI3os5iUWLAu2REuG46uDqBYx/i04k0GuzKq18zNc452+LHyMXHj1ll8pG+jh+AKPe4kkyNN0HLjlBZ2kab6bPAu8oDAS7Pf+HZtuaGR/egoj33mq+kXlBSSIwUE4HJeHIGfqbmAPL6EOSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7fc9fc043eeso1100274239f.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 04:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721821142; x=1722425942;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t9MuzjALq9PifOPxpXzAnvt64VKieqQbK5hHMZmM6NU=;
        b=lSqUlzKcgrVw+vHPEbyrzp58ZwaQJLTiiQ1XhDi1yBWjm0pLOd28jeZ6DqNwEPkJLp
         y2lUzu91aoyflDBa+MXwoORlmoJ807tXGcrHPgNsHqR7YaEljSEs+bJYjfFuFIOLeNl7
         9t0nvbRT1ywoUA1rL3DkV5Q4SzCKIcwxWl8d9cl+iiJn6YVtuwZewOFEvkHOlPXgMScw
         CJwhnN7Boi8eRfGqJapfff8wdkyNa7cDr0gW5Rt4fkQQYxPn1WFjsUZdk6jwqLXLUKVd
         p6gTvmjlN9yLQS2Pd/NMSlFryeqcDkjniwmfM5egxhlXr6X98v/z8N7Efo0lnBqrqK/+
         ptsw==
X-Forwarded-Encrypted: i=1; AJvYcCVpX7q4sdKvdmGt+B4DerD1FOMUePyFOLpD5Q6gYPkvZQ7BICRvvPtBjBSmwQASHwJR4mVY3O+JjTaQr6dLcuZFAwwP42f33Ubr9TI2
X-Gm-Message-State: AOJu0YzTsqXNvpebJ+5OihkmKsEr13gCjroVot/NaFtAQeqqOrrViAvC
	A+y3p7AKyQnMGyXA5BVZ4ukGfG4LNmYe1MWY2S7MGT4k5cIjy+swDByHKzeEscdvdEn0B6Rttl/
	tAFZGv12kSHRkR65t4U0A9iqa2aU2QRV2NSrgl9FRPhZppI9a5WXQKY8=
X-Google-Smtp-Source: AGHT+IF9MidXeweMHRSXXE1kIvoaGQPoDi6T8MFT8YMnPZHdgI4qwxI24EDRcuLylv0bO3AybZwWhlth07INAH0j3PcVOpcnXJkH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154e:b0:397:5d37:622e with SMTP id
 e9e14a558f8ab-39a193822b1mr1099015ab.2.1721821142419; Wed, 24 Jul 2024
 04:39:02 -0700 (PDT)
Date: Wed, 24 Jul 2024 04:39:02 -0700
In-Reply-To: <tencent_B78F6EC46ED2CC9E67F9C6DCD2C6C66D0906@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008f9ea3061dfcb91d@google.com>
Subject: Re: [syzbot] [io-uring?] KMSAN: uninit-value in io_req_task_work_add_remote
From: syzbot <syzbot+82609b8937a4458106ca@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in io_req_task_work_add_remote

=====================================================
BUG: KMSAN: uninit-value in io_req_local_work_add io_uring/io_uring.c:1192 [inline]
BUG: KMSAN: uninit-value in io_req_task_work_add_remote+0x588/0x5d0 io_uring/io_uring.c:1240
 io_req_local_work_add io_uring/io_uring.c:1192 [inline]
 io_req_task_work_add_remote+0x588/0x5d0 io_uring/io_uring.c:1240
 io_msg_remote_post io_uring/msg_ring.c:102 [inline]
 io_msg_data_remote io_uring/msg_ring.c:133 [inline]
 io_msg_ring_data io_uring/msg_ring.c:152 [inline]
 io_msg_ring+0x1c38/0x1ef0 io_uring/msg_ring.c:305
 io_issue_sqe+0x383/0x22c0 io_uring/io_uring.c:1710
 io_queue_sqe io_uring/io_uring.c:1924 [inline]
 io_submit_sqe io_uring/io_uring.c:2180 [inline]
 io_submit_sqes+0x1259/0x2f20 io_uring/io_uring.c:2295
 __do_sys_io_uring_enter io_uring/io_uring.c:3205 [inline]
 __se_sys_io_uring_enter+0x40c/0x3ca0 io_uring/io_uring.c:3142
 __x64_sys_io_uring_enter+0x11f/0x1a0 io_uring/io_uring.c:3142
 x64_sys_call+0x2d82/0x3c10 arch/x86/include/generated/asm/syscalls_64.h:427
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __alloc_pages_noprof+0x9d6/0xe70 mm/page_alloc.c:4706
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page mm/slub.c:2304 [inline]
 allocate_slab+0x20a/0x1550 mm/slub.c:2467
 new_slab mm/slub.c:2520 [inline]
 ___slab_alloc+0x12ef/0x35e0 mm/slub.c:3706
 __kmem_cache_alloc_bulk mm/slub.c:4750 [inline]
 kmem_cache_alloc_bulk_noprof+0x486/0x1330 mm/slub.c:4822
 __io_alloc_req_refill+0x84/0x560 io_uring/io_uring.c:940
 io_alloc_req io_uring/io_uring.h:393 [inline]
 io_submit_sqes+0x171b/0x2f20 io_uring/io_uring.c:2284
 __do_sys_io_uring_enter io_uring/io_uring.c:3205 [inline]
 __se_sys_io_uring_enter+0x40c/0x3ca0 io_uring/io_uring.c:3142
 __x64_sys_io_uring_enter+0x11f/0x1a0 io_uring/io_uring.c:3142
 x64_sys_call+0x2d82/0x3c10 arch/x86/include/generated/asm/syscalls_64.h:427
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 PID: 5808 Comm: syz.0.15 Not tainted 6.10.0-syzkaller-11185-g2c9b3512402e-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
=====================================================


Tested on:

commit:         2c9b3512 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11c0f8e3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6bfb33a8ad10458f
dashboard link: https://syzkaller.appspot.com/bug?extid=82609b8937a4458106ca
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15e3bca1980000


