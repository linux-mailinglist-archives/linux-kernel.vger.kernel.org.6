Return-Path: <linux-kernel+bounces-302223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E02795FB4D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 23:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA166280B83
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905AC198A35;
	Mon, 26 Aug 2024 21:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="GU/15bWE";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="Y3NrXDDv"
Received: from mx-lax3-3.ucr.edu (mx.ucr.edu [169.235.156.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EB6881E
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 21:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724706723; cv=none; b=mcJ+qrfk3GpNkONFK0+ARslxf7Y8QPMlDAfo+eQrDyiEUMyAxDrsytrIHqMgUHPz+zVzUDVLO9ir7I7PEQQvvtEPGGg/mQQRpb0UNZaeN/tSaVsO89IYCjy0Q7aHdQnkKDUuKvPCRy+jA45cdzOxTgqd79b1Qnvtckb8VUXNQKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724706723; c=relaxed/simple;
	bh=UgxBd/mRWTMaqrzvvHdKipa6J0qjgwA1IikuPhuehUQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Uu7krDRrNiDUrT8Z/BYKTKrLcwwLa6vXdsp27Xar4XnPF0EzNkXkUOQHfOdRb4M59bxHQ/EBlur5MTKVUmjxVazdgDqLFzWIlYSSNkg/AoUbbkJdKoL2B0ovQ8gRrzrrgSuGe3r9Fe5esNBPXe69EiPgpduT6bMoHRK1wZCjyLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=GU/15bWE; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=Y3NrXDDv; arc=none smtp.client-ip=169.235.156.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724706722; x=1756242722;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=UgxBd/mRWTMaqrzvvHdKipa6J0qjgwA1IikuPhuehUQ=;
  b=GU/15bWEHa2SA8ltpMMCLRKcgm+L0lt/tJFw8t7aJJNbWF1PU1BOZsOX
   minisCxFsklVdGUOQ2s4+8HUUFUFGqTAUzLUssCsVpUOUKDZJZgQaLUqb
   nP9tGO4Jj3boWHPlBmkP1axABbQzYngZ8uC0MdTXyrfLtL62SgSZFY3+/
   Hx6CMovXWpgWYs37IO8mDlReiwX2BHVasfSN+rWUjCuEWpiNo4iTq5pIV
   vC6JMsoEABJc5M6PNMBKvC0cgsT4xATS9E1axcM7yZb1K0F0z8oN2ap6L
   6b8RCaId6zkrwcE5BUx92JJ9jaaB3syhGUVgL/VioyMKttLXitxSfJ39g
   g==;
X-CSE-ConnectionGUID: xaWPvlkfQTOiUtPlnhfUXg==
X-CSE-MsgGUID: 7m+Qis6mSJO0Y2Lh46WQnA==
Received: from mail-io1-f72.google.com ([209.85.166.72])
  by smtp-lax3-3.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 26 Aug 2024 14:11:55 -0700
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f968e53b0so506275739f.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 14:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724706714; x=1725311514; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FGOtBtlKDN6HnB8IthMrTA23RN9iLz3v/HiIv2JP034=;
        b=Y3NrXDDvM16gOuoRfi/ulsjgkVZnrYsXFX3jTDVpN0RXoRcfwqeKXQ7kjacvXBPmDh
         UjSTPwGq/OA/ul6Aq0Xu9V7ut2RxSQCqxFm6pdHi8xwkxFpHyXNh+JR5qQ4vuuJoUugp
         NUGwkpg+2gzdgE9EgD/opasCB5+uD+8NQygIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724706714; x=1725311514;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FGOtBtlKDN6HnB8IthMrTA23RN9iLz3v/HiIv2JP034=;
        b=BJM7AEsHEXi7KqmX+z2sKfATzzy36omYMvA/v/gvADBXnimq+30/c+3vYWlD+/hwYZ
         6RkoRfXLFu4C1pfXePJUtvNgH0L5gW8DkxdqPprGFqpYAdPe3hhjekE+KPKLf7Cygmzz
         qt7iKzBcGgQgjg7HIwc8Wns5ONuW75VNbhCcbdEj+BrfhiMXWp+nb6EMFtww3Mu1VvZD
         duiEXtY7YsXVegxV0u9TL/BGUVtS+qRzywUi+/asHnQAyLOlesyh+ILuVrSGcICpmS9m
         FdJBEhbt/K4WMDgXF7Zm9hBsatZIO+8pHZugsazLgd35pQntKhMrCDZQwCXcngJrxnhu
         CGQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQO2y5DVuGkqwZ71PC2rnpqVbcz0odjO9N1ytYEUOWJfDl4ZpkwPuLm6QSO2CEGLLahs9qDcqsqKTKfWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTbHMLmpB02lRR0P6aI53T5wPiilfAdAe5eXc8A1AGcSxnlxGL
	CBB9EUIFQdBIqZkEdhUK2wC7mZdtQ4YkMS67Z2HqYBsEmu3np3zzLUwj9VyHI5RXMEAx72/SfYW
	GXSah3Psraz8zemqvSDxVCidm+GESm83lWH3vQS7WgGfj6OugWzIxLmvm3XZG+A8hfZFX3wMbnZ
	v9MYAO/FAJygDKeJzIn2xWfs4KlXracxryJMN3kiBPGSP4AozB8pc=
X-Received: by 2002:a05:6602:6c16:b0:7f8:c0eb:7adf with SMTP id ca18e2360f4ac-827871356f5mr1548607539f.0.1724706714116;
        Mon, 26 Aug 2024 14:11:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8UKXgHVZyvUe0zdJOLbZ19XLPMrg7ncUbhcl/s9YX+vbZlobXBJyZO25RPkktOVScecK/am/v5z5zINMxr/E=
X-Received: by 2002:a05:6602:6c16:b0:7f8:c0eb:7adf with SMTP id
 ca18e2360f4ac-827871356f5mr1548605439f.0.1724706713729; Mon, 26 Aug 2024
 14:11:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Juefei Pu <juefei.pu@email.ucr.edu>
Date: Mon, 26 Aug 2024 14:11:41 -0700
Message-ID: <CANikGpck2+ziQBWy5K0YfAQhbZnjtyohU5BxPp=v8ZWNdb5R6A@mail.gmail.com>
Subject: BUG: possible deadlock in hci_dev_do_close
To: marcel@holtmann.org, johan.hedberg@gmail.com, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
We found the following issue using syzkaller on Linux v6.10.
A possible deadlock issue was discovered in function
`hci_dev_do_close` when it attempted to acquire the lock
`hdev->req_lock`

The full report including the Syzkaller reproducer:
https://gist.github.com/TomAPU/5f32d2f519bf24b651580496e07497b2

The brief report is below:

Syzkaller hit 'possible deadlock in hci_dev_do_close' bug.

======================================================
WARNING: possible circular locking dependency detected
6.6.0 #9 Not tainted
------------------------------------------------------
kworker/0:3/4591 is trying to acquire lock:
ffff888031c5cdc0 ((work_completion)(&hdev->tx_work)){+.+.}-{0:0}, at:
__flush_work+0xeb/0xa40 kernel/workqueue.c:3403

but task is already holding lock:
ffff888031c5d0b8 (&hdev->req_lock){+.+.}-{3:3}, at:
hci_dev_do_close+0x29/0xa0 net/bluetooth/hci_core.c:552

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&hdev->req_lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x147/0x940 kernel/locking/mutex.c:747
       hci_dev_do_close+0x29/0xa0 net/bluetooth/hci_core.c:552
       hci_rfkill_set_block+0x175/0x210 net/bluetooth/hci_core.c:956
       rfkill_set_block+0x211/0x560 net/rfkill/core.c:346
       rfkill_epo+0x8e/0x1d0 net/rfkill/core.c:466
       __rfkill_handle_global_op net/rfkill/input.c:60 [inline]
       rfkill_op_handler+0x223/0x250 net/rfkill/input.c:108
       process_one_work+0x838/0x1560 kernel/workqueue.c:2630
       process_scheduled_works kernel/workqueue.c:2703 [inline]
       worker_thread+0x855/0x1200 kernel/workqueue.c:2784
       kthread+0x2cf/0x3b0 kernel/kthread.c:388
       ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:304

-> #2 (rfkill_global_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x147/0x940 kernel/locking/mutex.c:747
       rfkill_register+0x3a/0xb30 net/rfkill/core.c:1075
       hci_register_dev+0x43b/0xdc0 net/bluetooth/hci_core.c:2656
       __vhci_create_device+0x399/0x810 drivers/bluetooth/hci_vhci.c:437
       vhci_create_device drivers/bluetooth/hci_vhci.c:478 [inline]
       vhci_get_user drivers/bluetooth/hci_vhci.c:535 [inline]
       vhci_write+0x2bd/0x470 drivers/bluetooth/hci_vhci.c:615
       call_write_iter include/linux/fs.h:1956 [inline]
       new_sync_write fs/read_write.c:491 [inline]
       vfs_write+0x99d/0xdd0 fs/read_write.c:584
       ksys_write+0x122/0x250 fs/read_write.c:637
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x40/0xc0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x6f/0xd9

-> #1 (&data->open_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x147/0x940 kernel/locking/mutex.c:747
       vhci_send_frame+0xb4/0x120 drivers/bluetooth/hci_vhci.c:78
       hci_send_frame+0x229/0x480 net/bluetooth/hci_core.c:3039
       hci_sched_acl_pkt net/bluetooth/hci_core.c:3651 [inline]
       hci_sched_acl net/bluetooth/hci_core.c:3736 [inline]
       hci_tx_work+0x13bf/0x1c80 net/bluetooth/hci_core.c:3835
       process_one_work+0x838/0x1560 kernel/workqueue.c:2630
       process_scheduled_works kernel/workqueue.c:2703 [inline]
       worker_thread+0x855/0x1200 kernel/workqueue.c:2784
       kthread+0x2cf/0x3b0 kernel/kthread.c:388
       ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:304

-> #0 ((work_completion)(&hdev->tx_work)){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3868 [inline]
       __lock_acquire+0x24ab/0x3b50 kernel/locking/lockdep.c:5136
       lock_acquire kernel/locking/lockdep.c:5753 [inline]
       lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
       __flush_work+0xf4/0xa40 kernel/workqueue.c:3403
       hci_dev_close_sync+0x191/0x1230 net/bluetooth/hci_sync.c:4982
       hci_dev_do_close+0x31/0xa0 net/bluetooth/hci_core.c:554
       hci_rfkill_set_block+0x175/0x210 net/bluetooth/hci_core.c:956
       rfkill_set_block+0x211/0x560 net/rfkill/core.c:346
       rfkill_epo+0x8e/0x1d0 net/rfkill/core.c:466
       __rfkill_handle_global_op net/rfkill/input.c:60 [inline]
       rfkill_op_handler+0x223/0x250 net/rfkill/input.c:108
       process_one_work+0x838/0x1560 kernel/workqueue.c:2630
       process_scheduled_works kernel/workqueue.c:2703 [inline]
       worker_thread+0x855/0x1200 kernel/workqueue.c:2784
       kthread+0x2cf/0x3b0 kernel/kthread.c:388
       ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:304

other info that might help us debug this:

Chain exists of:
  (work_completion)(&hdev->tx_work) --> rfkill_global_mutex --> &hdev->req_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&hdev->req_lock);
                               lock(rfkill_global_mutex);
                               lock(&hdev->req_lock);
  lock((work_completion)(&hdev->tx_work));

 *** DEADLOCK ***

4 locks held by kworker/0:3/4591:
 #0: ffff888014476d38 ((wq_completion)events){+.+.}-{0:0}, at:
process_one_work+0x735/0x1560 kernel/workqueue.c:2605
 #1: ffffc90002f2fd88 ((rfkill_op_work).work){+.+.}-{0:0}, at:
process_one_work+0x797/0x1560 kernel/workqueue.c:2606
 #2: ffffffff8f0c7868 (rfkill_global_mutex){+.+.}-{3:3}, at:
rfkill_epo+0x55/0x1d0 net/rfkill/core.c:462
 #3: ffff888031c5d0b8 (&hdev->req_lock){+.+.}-{3:3}, at:
hci_dev_do_close+0x29/0xa0 net/bluetooth/hci_core.c:552

stack backtrace:
CPU: 0 PID: 4591 Comm: kworker/0:3 Not tainted 6.6.0 #9
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: events rfkill_op_handler
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 check_noncircular+0x2f8/0x3e0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3868 [inline]
 __lock_acquire+0x24ab/0x3b50 kernel/locking/lockdep.c:5136
 lock_acquire kernel/locking/lockdep.c:5753 [inline]
 lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
 __flush_work+0xf4/0xa40 kernel/workqueue.c:3403
 hci_dev_close_sync+0x191/0x1230 net/bluetooth/hci_sync.c:4982
 hci_dev_do_close+0x31/0xa0 net/bluetooth/hci_core.c:554
 hci_rfkill_set_block+0x175/0x210 net/bluetooth/hci_core.c:956
 rfkill_set_block+0x211/0x560 net/rfkill/core.c:346
 rfkill_epo+0x8e/0x1d0 net/rfkill/core.c:466
 __rfkill_handle_global_op net/rfkill/input.c:60 [inline]
 rfkill_op_handler+0x223/0x250 net/rfkill/input.c:108
 process_one_work+0x838/0x1560 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x855/0x1200 kernel/workqueue.c:2784
 kthread+0x2cf/0x3b0 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:304
 </TASK>

