Return-Path: <linux-kernel+bounces-300206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAA695E05A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 01:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA6B528288B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 23:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F2F142652;
	Sat, 24 Aug 2024 23:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="H19ZlFk5";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="IRQfGRi/"
Received: from mx6.ucr.edu (mx6.ucr.edu [138.23.62.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484764A05
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 23:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724540928; cv=none; b=EIcvDVHDgrTNPfgZRywme6KlrmreyenbQ1qC0S7RgVd/nqyZwa+1MFNzXmVts0IkZTIWlXBE0AMWW6hFkcmnBLesUrGglWmg44CVgWicp134wwHDWGvTz3KZ+aX2NoBfVVN+gYgrzMzGzSpbAGKIpbQW/TkujU2EkI/4mevKTS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724540928; c=relaxed/simple;
	bh=KwTEpTJVyQ8anR7mVpiMXWx+OVdxWj9gjO3TLdEJWJM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=GGP5HX6hTdNbtDl52JIeTQZATahs8ZBCyZ/DDfQs0yT39kc6RgMfyeWLLq/fB1RirML4mtbzU8IuvNsj0e6boGd1QLWof37eTZbFE/mPQvdWR1H/zciNNXfkpaNtj2udWlJtdai4x5xtXAuOQB3bYHPmPMjWuaRpwIBo2TjVFgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=H19ZlFk5; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=IRQfGRi/; arc=none smtp.client-ip=138.23.62.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724540926; x=1756076926;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=KwTEpTJVyQ8anR7mVpiMXWx+OVdxWj9gjO3TLdEJWJM=;
  b=H19ZlFk5ks/lI7cEqzNBp0XqQhNopVSec5i71byoWw5gt7FJsHNLhucs
   EeUr0O0MDwV37+o1YCY6SvyfNQnfjrHVCh4hrf/YIcx01x8ZO7HmkrVLC
   lWWH+LM7FI+yWYQp1nfOajuWjs6bgy3dq5RbIugYl1nDrlVyvJdnk7ikK
   3kaj/8UujNvacXKv2xWyiAreXDZOCDh5RECWg3KOJT/3160JGcDXtpYLb
   zliYhPzbfyw0tILGdq3i9ZZ1s6CL16NOtdSgVH0+OzUVw+ejyNcbTSRea
   dhdfDKIIKg9eBnki4Ng520IYbhAt5u3YTieCQMM/OqRZEpDsDV+vSDfWz
   w==;
X-CSE-ConnectionGUID: KkFFEAfiTemZnkIAKkLdfw==
X-CSE-MsgGUID: 3B9tr4g6SwyRHWssSdZWfA==
Received: from mail-io1-f72.google.com ([209.85.166.72])
  by smtpmx6.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 24 Aug 2024 16:08:45 -0700
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-827973cb3baso80472539f.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 16:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724540924; x=1725145724; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vnM6WbLG1jGTZoQIBdsIE1GJVAwXQu433koNWvzjUdo=;
        b=IRQfGRi/jreYOvgD5+16aToc8XGgOoQdB8xgX/Q01stTz2ZylUnNUrhWFJST3KpPUG
         CPb1bn3n04vCSrOv7v78whj+eFD9HaJgliXhE8pOmfpMbiT/0NZaElE3cdBqlvZ2uHBW
         pmEZj9uOYoijzo9iz2OVFansEgam+iQPwKtyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724540924; x=1725145724;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vnM6WbLG1jGTZoQIBdsIE1GJVAwXQu433koNWvzjUdo=;
        b=Q6mPJz2xVdkzs/Y952L6B9HqoJZPT3L7p9UU4+tZ8rkWJzIof5h04ykfya+8CMBLpD
         kFSfPcYt41spY8po/8fXEr7b8jADJedj/34K7QM7gie4ZuvprF+O3vBEJZ8Yz3tSWcq0
         1kdti5znrYsl5zM8s5WpdkV7ysizAaaBtrpcmbw1KBoppu0pxFUEqBGp0hkr/FWAKBfo
         nX5DIVTdmWmXOhVHp2U/2F1/tlyL/U3yutLNPKSkIwUN7Vzlxe6uGUhpYDQ/xnRv+hqb
         wHEle7yxfWP0F7xrBcVhmdIgMFGvHPAph4aV8EMOu9n+STz0kw1oHy0CXTMJvyBudhJx
         tXeg==
X-Forwarded-Encrypted: i=1; AJvYcCUZpNPmxnZ2KfIh0FOnjfbZHrph09WXAOrcaLQ5QHtXwNtswMdxKvSCaICIP2DP1h0vvpdPaqkgjJkOkuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRO3YcPXxXOsZ4FIT7x5VGEkugDNZlu3bUZQcp0rau7rE3LOWk
	Lzx9bAKDhJ2cUz1k6eHcb/4tqlMr6Ol23O2gjKzxuk5zDkUcaVPlA5BnaNl9HhuOdgs9egGcFXp
	EYksmJ/riiV22CUNIo6B+rrZ77cKGyLl9kZLtaIxt4bsmxXi4LNFmEYnCacAoLF2H804Bfq3hW8
	H2daXZpKOD6S//07Ca8ScaNyz1ja4BkfoFVZu6zmhp/2cHCoQ0iBQ=
X-Received: by 2002:a05:6602:3d1:b0:824:e864:569 with SMTP id ca18e2360f4ac-8278738088dmr908947539f.11.1724540924517;
        Sat, 24 Aug 2024 16:08:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXTcaR1Ppk2Bb3VJgWGtpkd5sYNwtoN/eS7aYKU5BH7mQpHbujNN3DDaXzr2VnHYOPY7ku2i7vpDXXFZpPMuA=
X-Received: by 2002:a05:6602:3d1:b0:824:e864:569 with SMTP id
 ca18e2360f4ac-8278738088dmr908945539f.11.1724540924105; Sat, 24 Aug 2024
 16:08:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Juefei Pu <juefei.pu@email.ucr.edu>
Date: Sat, 24 Aug 2024 16:08:32 -0700
Message-ID: <CANikGpe4pbGxQV+CCvSF6U+4cGHLWBzY_WXGSV9m+prBE6tYEQ@mail.gmail.com>
Subject: BUG: INFO: task hung in seq_free_client
To: perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
We found the following issue using syzkaller on Linux v6.10.
In `seq_free_client`,  the task hangs when trying to acquire lock
`register_mutex`.

Unfortunately, the syzkaller failed to generate a reproducer.
But at least we have the report:

INFO: task syz.0.38:8767 blocked for more than 143 seconds.
      Not tainted 6.10.0 #13
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.38        state:D stack:24680 pid:8767  tgid:8767
ppid:8050   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5407 [inline]
 __schedule+0xf4a/0x15e0 kernel/sched/core.c:6748
 __schedule_loop kernel/sched/core.c:6825 [inline]
 schedule+0x143/0x310 kernel/sched/core.c:6840
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6897
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x69a/0xd50 kernel/locking/mutex.c:752
 seq_free_client+0x27/0x180 sound/core/seq/seq_clientmgr.c:298
 snd_seq_release+0x44/0xc0 sound/core/seq/seq_clientmgr.c:387
 __fput+0x24a/0x8a0 fs/file_table.c:422
 task_work_run+0x239/0x2f0 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x12d/0x280 kernel/entry/common.c:218
 do_syscall_64+0x8a/0x150 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x67/0x6f
RIP: 0033:0x7f9a0cf809b9
RSP: 002b:00007ffc31b75f88 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007f9a0d147a80 RCX: 00007f9a0cf809b9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f9a0d147a80 R08: 0000000000000006 R09: 00007ffc31b7626f
R10: 00000000003ffcd0 R11: 0000000000000246 R12: 00000000000248af
R13: 00007ffc31b76080 R14: 00007ffc31b760a0 R15: ffffffffffffffff
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/0:1/10:
 #0: ffff88801307a948 ((wq_completion)events){+.+.}-{0:0}, at:
process_one_work kernel/workqueue.c:3223 [inline]
 #0: ffff88801307a948 ((wq_completion)events){+.+.}-{0:0}, at:
process_scheduled_works+0x8fb/0x1410 kernel/workqueue.c:3329
 #1: ffffc900000cfd20
((work_completion)(&data->fib_event_work)){+.+.}-{0:0}, at:
process_one_work kernel/workqueue.c:3224 [inline]
 #1: ffffc900000cfd20
((work_completion)(&data->fib_event_work)){+.+.}-{0:0}, at:
process_scheduled_works+0x922/0x1410 kernel/workqueue.c:3329
 #2: ffff888100af7240 (&data->fib_lock){+.+.}-{3:3}, at:
nsim_fib_event_work+0x2de/0x4050 drivers/net/netdevsim/fib.c:1489
1 lock held by khungtaskd/25:
 #0: ffffffff8db32fe0 (rcu_read_lock){....}-{1:2}, at:
rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8db32fe0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock
include/linux/rcupdate.h:781 [inline]
 #0: ffffffff8db32fe0 (rcu_read_lock){....}-{1:2}, at:
debug_show_all_locks+0x54/0x2d0 kernel/locking/lockdep.c:6614
2 locks held by kworker/u4:9/2825:
1 lock held by systemd-udevd/4506:
1 lock held by in:imklog/7643:
1 lock held by syz.1.37/8761:
 #0: ffffffff8ecc0b08 (register_mutex#3){+.+.}-{3:3}, at:
seq_free_client+0x27/0x180 sound/core/seq/seq_clientmgr.c:298
1 lock held by syz.0.38/8767:
 #0: ffffffff8ecc0b08 (register_mutex#3){+.+.}-{3:3}, at:
seq_free_client+0x27/0x180 sound/core/seq/seq_clientmgr.c:298
1 lock held by syz.0.44/9437:
 #0: ffffffff8ecc0b08 (register_mutex#3){+.+.}-{3:3}, at:
snd_seq_open+0x42/0x4a0 sound/core/seq/seq_clientmgr.c:335
1 lock held by syz.1.46/9506:
 #0: ffffffff8ecc0b08 (register_mutex#3){+.+.}-{3:3}, at:
snd_seq_open+0x42/0x4a0 sound/core/seq/seq_clientmgr.c:335
1 lock held by syz.1.46/9508:
 #0: ffffffff8ecc0b08 (register_mutex#3){+.+.}-{3:3}, at:
snd_seq_open+0x42/0x4a0 sound/core/seq/seq_clientmgr.c:335
1 lock held by syz.1.46/9509:
 #0: ffffffff8ecc0b08 (register_mutex#3){+.+.}-{3:3}, at:
snd_seq_open+0x42/0x4a0 sound/core/seq/seq_clientmgr.c:335
1 lock held by syz.0.53/10021:
 #0: ffffffff8ecc0b08 (register_mutex#3){+.+.}-{3:3}, at:
snd_seq_open+0x42/0x4a0 sound/core/seq/seq_clientmgr.c:335
1 lock held by syz.0.53/10022:
 #0: ffffffff8ecc0b08 (register_mutex#3){+.+.}-{3:3}, at:
snd_seq_open+0x42/0x4a0 sound/core/seq/seq_clientmgr.c:335
1 lock held by syz.1.57/10085:
 #0: ffffffff8ecc0b08 (register_mutex#3){+.+.}-{3:3}, at:
snd_seq_open+0x42/0x4a0 sound/core/seq/seq_clientmgr.c:335
1 lock held by syz.1.57/10091:
 #0: ffffffff8ecc0b08 (register_mutex#3){+.+.}-{3:3}, at:
snd_seq_open+0x42/0x4a0 sound/core/seq/seq_clientmgr.c:335
1 lock held by syz.0.64/10607:
 #0: ffffffff8ecc0b08 (register_mutex#3){+.+.}-{3:3}, at:
snd_seq_open+0x42/0x4a0 sound/core/seq/seq_clientmgr.c:335
1 lock held by syz.1.66/10653:
 #0: ffffffff8ecc0b08 (register_mutex#3){+.+.}-{3:3}, at:
snd_seq_open+0x42/0x4a0 sound/core/seq/seq_clientmgr.c:335
1 lock held by syz.0.70/11162:
 #0: ffffffff8ecc0b08 (register_mutex#3){+.+.}-{3:3}, at:
snd_seq_open+0x42/0x4a0 sound/core/seq/seq_clientmgr.c:335
1 lock held by syz.1.68/11179:
 #0: ffffffff8ecc0b08 (register_mutex#3){+.+.}-{3:3}, at:
snd_seq_open+0x42/0x4a0 sound/core/seq/seq_clientmgr.c:335
1 lock held by syz.0.71/11691:
 #0: ffffffff8ecc0b08 (register_mutex#3){+.+.}-{3:3}, at:
snd_seq_open+0x42/0x4a0 sound/core/seq/seq_clientmgr.c:335
1 lock held by syz.1.72/11705:
 #0: ffffffff8ecc0b08 (register_mutex#3){+.+.}-{3:3}, at:
snd_seq_open+0x42/0x4a0 sound/core/seq/seq_clientmgr.c:335
1 lock held by syz.1.74/12211:
 #0: ffffffff8ecc0b08 (register_mutex#3){+.+.}-{3:3}, at:
snd_seq_open+0x42/0x4a0 sound/core/seq/seq_clientmgr.c:335
1 lock held by syz.0.81/12259:
 #0: ffffffff8ecc0b08 (register_mutex#3){+.+.}-{3:3}, at:
snd_seq_open+0x42/0x4a0 sound/core/seq/seq_clientmgr.c:335
2 locks held by syz-executor/12269:
1 lock held by systemd-udevd/12279:
2 locks held by syz-executor/12313:
1 lock held by syz.1.82/12748:
 #0: ffffffff8ecc0b08 (register_mutex#3){+.+.}-{3:3}, at:
snd_seq_open+0x42/0x4a0 sound/core/seq/seq_clientmgr.c:335
1 lock held by syz.0.83/12763:
 #0: ffffffff8ecc0b08 (register_mutex#3){+.+.}-{3:3}, at:
snd_seq_open+0x42/0x4a0 sound/core/seq/seq_clientmgr.c:335

