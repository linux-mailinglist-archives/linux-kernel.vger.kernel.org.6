Return-Path: <linux-kernel+bounces-304308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28261961DA1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 06:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D38C228516F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 04:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E23E1474B5;
	Wed, 28 Aug 2024 04:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="A15QVDzz";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="pdS0L2b0"
Received: from mx-lax3-1.ucr.edu (mx-lax3-1.ucr.edu [169.235.156.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9823018030
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 04:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724819371; cv=none; b=ePgUEQDB6g1miSvpTNyT3aVMYE1eRVaVbSso5y8qn9hjsusgCK1DfG+m9ebaNmp98Nai7KmZX4h0Of+aUBgrV3JnO1t0UrwiklZWE+1TalFLX4JSWizLlZTAHSntWLurU/os9/oL1UDI2PvtwSCCkTlL5QcoXomlbdSSGj5z2mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724819371; c=relaxed/simple;
	bh=5jbqLVD6HOqeZcqNMhD6rKu8dOjvUNxSSfxCXOeEkuo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=uN/kE8pyR3vDSZCcQLROIetgG8cHtnfY+/5r3BzmyAD1l3S+Ijrs20UxrepimZZB2ZWx9lYv3CoZjiCfwmpJv3z7ou4ifu8e1D0fF2fawHrIF6P8WT87lPn7RQvFP7eDxEOu/6DWCyClJLPTeyyw4SWPKqnw07WRvq1tewq2Odw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=A15QVDzz; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=pdS0L2b0; arc=none smtp.client-ip=169.235.156.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724819369; x=1756355369;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=5jbqLVD6HOqeZcqNMhD6rKu8dOjvUNxSSfxCXOeEkuo=;
  b=A15QVDzzPGCTGOESL5gc6h1i5WM5RcOlvhGVSDxltG84Yu1GSsis7wMU
   CKDvrB3xCuDh+QyWdROCnvS/abJUZu1NSz5OZlBgC+/8UvPXo4PFlnnex
   JIk2oQaJRnjg+WFLMvRw6FnwLCWbRtFpkPh2oSzc80qff/nTizYzshyKw
   43/IFTuMrLUjAqoSE1ciGWxbob0BqTQT2RIqAWJPub9bfZMUVM/cwJgnC
   zg9A+lA+TOUGePhqlXoc5JDiENFQrNRzazG+SRBmu4kyNgWnt1AtMx6Nb
   103+N9n1fenbAyfXWlrBz/3lrNLx8WZzzd7lEO+k3xx2u1lVkpJ0jtaOt
   g==;
X-CSE-ConnectionGUID: OPq/IN0rSMGtMD4KbSrk+Q==
X-CSE-MsgGUID: o4LHDSn1TFyW2Nw3xipv7g==
Received: from mail-io1-f70.google.com ([209.85.166.70])
  by smtp-lax3-1.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 27 Aug 2024 21:29:23 -0700
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8223c3509a9so683903039f.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 21:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724819363; x=1725424163; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3xEUcrGpRsILxlhkGCCDyEm1QUzbA2mMbQtvseXl3rM=;
        b=pdS0L2b0j2DzcDgk5mFQvrdtIgLMkFHXBhQynj0LRDznpqG1OcYcjZjZjis1eyvwg8
         nMs5j+ZECQQNqAlZ5Y6/Yez2mzhmIzYEx4QZ2Fdt1vQB2QqiP5waO1j11d9+Vx9iPIG6
         7Z1oNLUt8BFx6aDQTHrOK1TLs+o4aBhRRfI6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724819363; x=1725424163;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3xEUcrGpRsILxlhkGCCDyEm1QUzbA2mMbQtvseXl3rM=;
        b=ZRNMYfepsB4PHHAA79ZBKZsv+UOZg28PBa31Pkr3SxE+hPhYEDIyjMUwa36qzO45SZ
         VpTEB1sgZjDpbgimfQ1IXvMK9GuPfwk3tGKH9KiepUybifIvKHWvNSwWetl5IjHjls/q
         5EhXT9H9kuvlt3CMVSFW2iuEdqBTBLz7cOq66d4sAoxQQ89tHFVAJqiprSeonOJLs6ek
         KScienBXu/NdBig6BLa0nmlV6seM8DWhslI2q29TqbeOK3RJFg1vHWhuXA75yGS1BD16
         duVH/YfsMV+dASYcmLHSBeydui8BkopsDP38mKlcgJYkAgEyjBEE3ilEYHeKQqF4Gc+Z
         GGLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWb/roaRkiALOxTyxaPiXUg+2zbRxkuZbBPxGj+NyiBMrFciVabajPYUPB9cTnWiksqOH0aiBLuELuDpss=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtGiEdKfmdrROUFMwBuXDN2CqaSthNaKLKKQexPoPj27fl+U6u
	wTT+n+hnIlz7foYSH5V7RyENO4FqxK59zbRaq8mTYWKfjfgUxIAtJlnx6LjLHY7wZBw0DzCicsd
	1LMxKzmcMjfGccfRSqgemy3BUi0ADVyBa5G5avePEQo/DgnclDfCklSxGjDp/AMfK7KhFd7mkG6
	p/x41Tic/wctHom3WjmTMGENV5O1jYq9FU220zGQ==
X-Received: by 2002:a05:6602:620e:b0:804:f2be:ee33 with SMTP id ca18e2360f4ac-82a03e04450mr110474239f.2.1724819362823;
        Tue, 27 Aug 2024 21:29:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFugqrZ3AkG46XpT7REGdBW8HfXfoKF4nfV0tSaNuLIYS4mAVA6Y5M57I389r8KrhjtLqGlxcMfTfdm33xhMLo=
X-Received: by 2002:a05:6602:620e:b0:804:f2be:ee33 with SMTP id
 ca18e2360f4ac-82a03e04450mr110473239f.2.1724819362509; Tue, 27 Aug 2024
 21:29:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Juefei Pu <juefei.pu@email.ucr.edu>
Date: Tue, 27 Aug 2024 21:29:10 -0700
Message-ID: <CANikGpcXzNWJTkghnzFgqrPm_p=Lpm1r7oujrxQhw6k_xZW=nA@mail.gmail.com>
Subject: BUG: corrupted list in list_lru_del
To: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
We found the following issue using syzkaller on Linux v6.10.
When `to_shrink_list` tried to delete dentry via `d_lru_del(dentry)`,
a list corruption happened.
Unfortunately, the syzkaller failed to generate a reproducer.
But at least we have the report:

list_del corruption. prev->next should be ffff88802c7c32a0, but was
0000000000000000. (prev=ffff88803d1de410)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:64!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 PID: 8670 Comm: syz-executor Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:__list_del_entry_valid_or_report+0x10a/0x120 lib/list_debug.c:62
Code: e8 bb ff 96 06 0f 0b 48 c7 c7 80 5b a9 8b 4c 89 fe e8 aa ff 96
06 0f 0b 48 c7 c7 e0 5b a9 8b 4c 89 fe 48 89 d9 e8 96 ff 96 06 <0f> 0b
48 c7 c7 60 5c a9 8b 4c 89 fe 4c 89 f1 e8 82 ff 96 06 0f 0b
RSP: 0000:ffffc9000ad77428 EFLAGS: 00010246
RAX: 000000000000006d RBX: ffff88803d1de410 RCX: 4740cdb9afd41600
RDX: 0000000000000000 RSI: 0000000080000003 RDI: 0000000000000000
RBP: dffffc0000000000 R08: ffffffff8172e30c R09: 1ffff920015aee24
R10: dffffc0000000000 R11: fffff520015aee25 R12: dffffc0000000000
R13: ffff88803cf85000 R14: ffff88803d1de410 R15: ffff88802c7c32a0
FS:  000055555bfe4500(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000562d00112406 CR3: 0000000040714000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_del_init include/linux/list.h:287 [inline]
 list_lru_del+0x177/0x300 mm/list_lru.c:129
 d_lru_del fs/dcache.c:445 [inline]
 to_shrink_list+0x133/0x330 fs/dcache.c:868
 select_collect+0xc8/0x1a0 fs/dcache.c:1436
 d_walk+0x1d3/0x710 fs/dcache.c:1259
 shrink_dcache_parent+0x140/0x3b0 fs/dcache.c:1491
 d_invalidate+0x117/0x2e0 fs/dcache.c:1596
 proc_invalidate_siblings_dcache+0x3af/0x6c0 fs/proc/inode.c:142
 release_task+0x1619/0x1910 kernel/exit.c:281
 wait_task_zombie kernel/exit.c:1187 [inline]
 wait_consider_task+0x19f0/0x2e10 kernel/exit.c:1414
 do_wait_thread kernel/exit.c:1477 [inline]
 __do_wait+0x1a7/0x870 kernel/exit.c:1595
 do_wait+0x228/0x310 kernel/exit.c:1629
 kernel_wait4+0x29c/0x3e0 kernel/exit.c:1788
 __do_sys_wait4 kernel/exit.c:1816 [inline]
 __se_sys_wait4 kernel/exit.c:1812 [inline]
 __x64_sys_wait4+0x130/0x1e0 kernel/exit.c:1812
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x7e/0x150 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x67/0x6f
RIP: 0033:0x7f69a7976c17
Code: 89 7c 24 10 48 89 4c 24 18 e8 55 15 03 00 4c 8b 54 24 18 8b 54
24 14 41 89 c0 48 8b 74 24 08 8b 7c 24 10 b8 3d 00 00 00 0f 05 <48> 3d
00 f0 ff ff 77 31 44 89 c7 89 44 24 10 e8 a5 15 03 00 8b 44
RSP: 002b:00007ffe2a90f730 EFLAGS: 00000293 ORIG_RAX: 000000000000003d
RAX: ffffffffffffffda RBX: 000000000000039a RCX: 00007f69a7976c17
RDX: 0000000040000000 RSI: 00007ffe2a90f78c RDI: 00000000ffffffff
RBP: 00007ffe2a90f78c R08: 0000000000000000 R09: 00007f69a87c4080
R10: 0000000000000000 R11: 0000000000000293 R12: 000055555bff75eb
R13: 000055555bff7590 R14: 0000000000054822 R15: 00007ffe2a90f7e0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid_or_report+0x10a/0x120 lib/list_debug.c:62
Code: e8 bb ff 96 06 0f 0b 48 c7 c7 80 5b a9 8b 4c 89 fe e8 aa ff 96
06 0f 0b 48 c7 c7 e0 5b a9 8b 4c 89 fe 48 89 d9 e8 96 ff 96 06 <0f> 0b
48 c7 c7 60 5c a9 8b 4c 89 fe 4c 89 f1 e8 82 ff 96 06 0f 0b
RSP: 0000:ffffc9000ad77428 EFLAGS: 00010246
RAX: 000000000000006d RBX: ffff88803d1de410 RCX: 4740cdb9afd41600
RDX: 0000000000000000 RSI: 0000000080000003 RDI: 0000000000000000
RBP: dffffc0000000000 R08: ffffffff8172e30c R09: 1ffff920015aee24
R10: dffffc0000000000 R11: fffff520015aee25 R12: dffffc0000000000
R13: ffff88803cf85000 R14: ffff88803d1de410 R15: ffff88802c7c32a0
FS:  000055555bfe4500(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000562d00112406 CR3: 0000000040714000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

