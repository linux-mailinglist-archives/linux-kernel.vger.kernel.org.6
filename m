Return-Path: <linux-kernel+bounces-305863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CEF963563
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 01:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F26BA1F240E1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 23:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7BE1AD9F7;
	Wed, 28 Aug 2024 23:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="hrBf+PgM";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="e03wN4kC"
Received: from mx2.ucr.edu (mx.ucr.edu [138.23.62.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3B6158DCD
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 23:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724887671; cv=none; b=rXe8oLI+8MABrmhKI2XeS+xiFR5pgLB3dPF1yY6PcC0fksKEN6v+9AQfZ9xQEz4wvu+kbca0CVXebLtVVcCaLVT6Tv+2i5c4O0f1YrhvymiMYgHBIjZkX/WqlEea581OoEDAN/JfilQIEZueGA5lRtOFzaY4zZAPEwvyV6zwCwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724887671; c=relaxed/simple;
	bh=PPl2nxNPc1g3RQcdJyM/0AzfD4AlEJKnhfobSQc/SV4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=pVrpsykcEGilte17opwu9qxWn7yAGqGx/SAymuE/ubIGvn2XzSlsyQwH9s5JER3PkEp3Gpp9JN8FCeVWogqm4efKYicrBliEamH3pGYQ5097H/z5teDmy6JjHYjYq7knnAoGHWl5lnoeEQ2B7+jaROVGuE4OexvWKulY+XadlCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=hrBf+PgM; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=e03wN4kC; arc=none smtp.client-ip=138.23.62.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724887667; x=1756423667;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:cc:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=PPl2nxNPc1g3RQcdJyM/0AzfD4AlEJKnhfobSQc/SV4=;
  b=hrBf+PgMhvz0gs1+wG5fHvklOZMg+dX8ZM3hIMgCjxKTFG1xY+JABWBr
   QD70QzJ4OCU6uz7ptiq29G36JpTZ1lpBHCofagMtutp1LTCd/9evh9PoY
   hV9bQdjGZn+qCZujO8C2gwOBoHHA8kO3Yg1mREridIyJScaNFBhWFKu4b
   L7E0F37addLeOt+SE84IP4QS7eIeqUdP9Fz+YQl0jFT21JF2agbOhbsor
   WcIqq0Kl5Zvob5/CYHhI4wylLcLaaMonohPc/ROiL5i0NVQLTKxYIQL9t
   pK8V5/xSdXOG/TiOfGI7MZTqTgTFjmAwFnFNlX9dn0XJXVmKfVW8mTmqU
   A==;
X-CSE-ConnectionGUID: txKrBrRCSQ2AV1mfoAuY7Q==
X-CSE-MsgGUID: ZXD9h+10RLCFW1aR36TWwA==
Received: from mail-il1-f198.google.com ([209.85.166.198])
  by smtp2.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 16:27:46 -0700
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d32a4f301so10139485ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 16:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724887667; x=1725492467; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fyik/MSBYY6QT7eyssywU0zOFgYOEIoQrlYEvt6Bvsw=;
        b=e03wN4kCKE6JeFzBElbIV9bBsygWkJPZN3MLnC5vYhp9wqpBwwhstFnW/wgtDYLcBl
         fpfhBn1FmUyABHJfzchcQwN1UXzWD/qIGqNwo79gBnTUyWcKwu1jGskmtys4fPruougA
         SfYO4wHzOYwnlQA/4WU0VIDfsc5za4mrx+6VE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724887667; x=1725492467;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fyik/MSBYY6QT7eyssywU0zOFgYOEIoQrlYEvt6Bvsw=;
        b=vKMWjUEsPp4AQv3/jSLZDThJgE9j8708k3sNmIaKDgfrh502P+nEk9Ac7/bwaiCkwK
         Uc0cHsLIgSkRQdJp+PzzrpwOxweTI1J+W5BYyuI/kRjzO0bGYr+ZXJUciDFJ1PEH5bUV
         /ctIcaq+qyjE83zmu8Nvwij0QFBIzmw6t/xUm4HnOsNLKgfHuWPa6ipK9/MRRjnXKJqM
         ie/a/LRlCyywdAVDWCv/l2ajZ4ql32uvqvtKmMfIeW5uc6a/DKadympfpwAHSepw3eFe
         5BxKFSrpPa+KpJ1/5FaVujEgOkhZnntHeXiO6JrrOx+tdP3yP01ZL5VDMUhrKukhQzVC
         oBrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyijfSD9uh8ywbfgX7owydaWv7kbe1A3llTZW6BNd3B5EjiDeZbDa3ycfOCTUD9i6+J5gQGNY14eoUzps=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp9z7Jqop6a6aI4ZRDTjquT4OJOGViwYSfXJ7nj/TQBpCvxBlb
	SAp6DOaTLnRX0Xt52xuXjuAhDTcwWezr6HQfQB5wdoy8w0O2A7808NNL/FUSE3avL3bWEG8oaVS
	n/PEITDB6h+Wt7LIOjXvqFH4YUl2R4xzTUGibPBUngnchlhtuQ1/x7AaJH4ZuoLrOT8yJ/6Atp5
	um7RZV6jiY/59GwlX+t/IuwUd/7jSraKU4xkZxrCHm7ODCHKKNH6w=
X-Received: by 2002:a05:6e02:1b01:b0:39b:36d6:2150 with SMTP id e9e14a558f8ab-39f38afa478mr6043895ab.6.1724887667488;
        Wed, 28 Aug 2024 16:27:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIUw6lFniPA+9PhahQD/BiJk5boI5RISKBjQvwk6GfJq1O//7MSQtpXdPMVzIIymAl8nLntzA5cXWWPoLc990=
X-Received: by 2002:a05:6e02:1b01:b0:39b:36d6:2150 with SMTP id
 e9e14a558f8ab-39f38afa478mr6043815ab.6.1724887667084; Wed, 28 Aug 2024
 16:27:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 28 Aug 2024 16:27:36 -0700
Message-ID: <CALAgD-7TsMdA7rjxfpheXc=MNqikEXY9TZNxJt4z9vm6Yfs5qQ@mail.gmail.com>
Subject: BUG: general protection fault in __free_object
To: tglx@linutronix.de, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org
Cc: Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"

Hi,

We found a bug in Linux 6.10 using syzkaller. It is possibly a null
pointer dereference  bug.
The reproducer is
https://gist.github.com/freexxxyyy/5aefd53c6567415e9fe8c76cc2ad390c

The bug report is:

Syzkaller hit 'general protection fault in __free_object' bug.

Oops: general protection fault, probably for non-canonical address
0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: events kfree_rcu_work
RIP: 0010:hlist_add_head include/linux/list.h:1032 [inline]
RIP: 0010:__free_object+0x903/0xaa0 lib/debugobjects.c:396
Code: 24 18 48 8b 7c 24 38 74 05 e8 89 bf 95 fd 48 8b 44 24 28 49 89
45 08 eb 03 45 31 ed 48 8b 1d 34 95 61 0e 4c 89 e8 48 c1 e8 03 <42> 80
3c 30 00 74 08 4c 89 ef e8 5e bf 95 fd 49 89 5d 00 48 85 db
RSP: 0018:ffffc900000af740 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff888028f56cb0 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: 0000000000000004 RDI: ffff888028f56cb8
RBP: ffffc900000af920 R08: 0000000000000003 R09: fffff52000015ed8
R10: dffffc0000000000 R11: fffff52000015ed8 R12: ffffffff92c03280
R13: 0000000000000000 R14: dffffc0000000000 R15: 0000000000000003
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555787e6868 CR3: 000000000d932000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __debug_check_no_obj_freed lib/debugobjects.c:994 [inline]
 debug_check_no_obj_freed+0x135/0x530 lib/debugobjects.c:1019
 slab_free_hook mm/slub.c:2163 [inline]
 slab_free_freelist_hook mm/slub.c:2225 [inline]
 slab_free_bulk mm/slub.c:4462 [inline]
 kmem_cache_free_bulk+0x1bf/0x360 mm/slub.c:4676
 kfree_bulk include/linux/slab.h:568 [inline]
 kvfree_rcu_bulk+0x249/0x4d0 kernel/rcu/tree.c:3371
 kfree_rcu_work+0x443/0x500 kernel/rcu/tree.c:3450
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0x977/0x1410 kernel/workqueue.c:3329
 worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
 kthread+0x2eb/0x380 kernel/kthread.c:389
 ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:hlist_add_head include/linux/list.h:1032 [inline]
RIP: 0010:__free_object+0x903/0xaa0 lib/debugobjects.c:396
Code: 24 18 48 8b 7c 24 38 74 05 e8 89 bf 95 fd 48 8b 44 24 28 49 89
45 08 eb 03 45 31 ed 48 8b 1d 34 95 61 0e 4c 89 e8 48 c1 e8 03 <42> 80
3c 30 00 74 08 4c 89 ef e8 5e bf 95 fd 49 89 5d 00 48 85 db
RSP: 0018:ffffc900000af740 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff888028f56cb0 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: 0000000000000004 RDI: ffff888028f56cb8
RBP: ffffc900000af920 R08: 0000000000000003 R09: fffff52000015ed8
R10: dffffc0000000000 R11: fffff52000015ed8 R12: ffffffff92c03280
R13: 0000000000000000 R14: dffffc0000000000 R15: 0000000000000003
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555787e6868 CR3: 000000000d932000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0: 24 18                 and    $0x18,%al
   2: 48 8b 7c 24 38       mov    0x38(%rsp),%rdi
   7: 74 05                 je     0xe
   9: e8 89 bf 95 fd       call   0xfd95bf97
   e: 48 8b 44 24 28       mov    0x28(%rsp),%rax
  13: 49 89 45 08           mov    %rax,0x8(%r13)
  17: eb 03                 jmp    0x1c
  19: 45 31 ed             xor    %r13d,%r13d
  1c: 48 8b 1d 34 95 61 0e mov    0xe619534(%rip),%rbx        # 0xe619557
  23: 4c 89 e8             mov    %r13,%rax
  26: 48 c1 e8 03           shr    $0x3,%rax
* 2a: 42 80 3c 30 00       cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2f: 74 08                 je     0x39
  31: 4c 89 ef             mov    %r13,%rdi
  34: e8 5e bf 95 fd       call   0xfd95bf97
  39: 49 89 5d 00           mov    %rbx,0x0(%r13)
  3d: 48 85 db             test   %rbx,%rbx


-- 
Yours sincerely,
Xingyu

