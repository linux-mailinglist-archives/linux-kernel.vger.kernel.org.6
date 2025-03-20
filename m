Return-Path: <linux-kernel+bounces-569206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDFCA69FF4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 07:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17B771895B7B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 06:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45401EA7C2;
	Thu, 20 Mar 2025 06:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mw92UGF1"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE401BE251
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 06:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742453386; cv=none; b=EZgSoCfVrCsCqFgnKBgjUijdrUR0ji/fZMAIERbrgnec92YbZ5nCUodlhTemhpreRmffYPwtpHvSk/CRdzYnZntgIPsMpOQyOVsD7wab7RUkHgd/qoT51SKWKKf7JqclTb3DWEv207XBxwByUlsns/nt6hnFu0+orzF2YGkUMJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742453386; c=relaxed/simple;
	bh=HD/aZlYOobvGLkwcXxoRUHjKQ8ApF3UDJ2BOuPBG4pY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ASoi4Fqcwmrr2PbK6UABZOOJtTfc3nrKpu0vDBWIhZgvyO8N9tfyH5i2VVfoILwa4zjsEWCSvuO7iCUjBc5WRK7iEZtMePX3grTAKXlKtnF40mDT5IuSDN22C7gPSxfb1TGY/ByK5Or+sfdpaFZR3YZX30qfm/z81oFxvPNGsfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mw92UGF1; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-300fefb8e06so824731a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 23:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742453383; x=1743058183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gXOO3bKJSnf/iDCevzy1JpJbFCGuEvw9AgOpzlDoFyU=;
        b=Mw92UGF17rpOc7KVmTTrW/x6cObgowa8OQKULZiFAve0jX1ojfYUgEe1j/dMo9MhfP
         w+JGQD1FyqZ2G10oyJxs7A1MctAhXYn5k7bYIQEs/OAO0trHGDMi119UP52BTx7T6Ci4
         ymw9jrpR8aiLUnZZlc/s81jSHdcq2MDwNvsXceuGvreAEWCTGgN00fB0MNw+tPjgIzLM
         BoMrf8/RPVZfdQUlkmhvKDrbQQe/HuFDxZvl+EMKLEJYGMp8imwenAgrnysH0sr5TOAp
         sBUEcpvWC03H574KAPnjYSr6byQRfH9n5rZHshnc7iJX8CzF/aRMefd8xRIg99Wlyf01
         K4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742453383; x=1743058183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gXOO3bKJSnf/iDCevzy1JpJbFCGuEvw9AgOpzlDoFyU=;
        b=l3HZ3o9kno7EXUcqiM2xMUHSCxAftbXRlzE1mP2m5vRz/YoZp2IbMmlH1wYsoTwc54
         9mMAi5j5YguqWv4tRc3Xq3XOJti6f2sLBbIQWU7fu2ngrL5Dfxd2EJvzc91AcohaKWzv
         LWR11sQ1xGS2+zgzLNPvNFNO3ePrpPchaEX9+2weqoXL4PH5BBNPxDCh0UnQpVamltEe
         dN71BBJZuMSVnm8QdGKOjjypZTQyXBDlmqaeJdt+tjfv9KcOpPzaTbQJhrQ9h1FDQPCl
         srAoCRvagsUAPDVDL2TzPsNB4F76Nh2NyLdcg7WLlXOAIgE5T5ULRcXgW2xQqZxGhue6
         fBoA==
X-Forwarded-Encrypted: i=1; AJvYcCXRcz713TYH7VyjPyy6io/u4eNVilZIx/jnQHuLJwInkaimIcZ5tLnPKw7VJmEDUyjW6RS/5G6vM5RdPqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCMY8ciK2/5/7B6ixkJXZWJ/RVFtAwNEuAXmEnAMMJ+/5+gHQD
	FyRcYuxWc/bVZRq3GleH9rrDtAUuiPCQbEeKkTrxPaSk75AQZ6XW
X-Gm-Gg: ASbGncvA6jX9bSt4muc2aOlV4K9mqE73NdqOCOoMwzWKrSGcBnwUZmlpEn9r3NRE25h
	ioqvY4GkY996qOkoZwiOzHT5LKX0S9eh0jkKJ4OQ5nOFgbNQQ4X3togfWlLwxIdW6dA2JD9daHi
	7XzeUKrz9IEY8tDLpb9Issu4Wdbwtlb/VXoGXwhjHAZwGxsitEX2+HLW+m+ImJlXVIXdseUIY6o
	+7NLNIiG+FmIw5Ahfcl5a1YJA73d3jJJSv5Wc4ySMw/VeeSYu0joYFXZtwiGEZku1u18qGACf/b
	P9O+aV0OLnVTjHtZVqbrNKEZd+hrmRHOycYE8Kt1fRYslWgxyZmM
X-Google-Smtp-Source: AGHT+IEwicNm2K39Ha2/ODJPFS9rRCq9591lPiIdTuvlBppnRe9elJT9KQkhOC+NPUUHMDofqu8Hhw==
X-Received: by 2002:a17:90b:4a48:b0:2fe:a77b:d97e with SMTP id 98e67ed59e1d1-301bde59536mr8658765a91.11.1742453382573;
        Wed, 19 Mar 2025 23:49:42 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([124.156.216.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68885a1sm127260155ad.13.2025.03.19.23.49.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Mar 2025 23:49:42 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: will@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	longman@redhat.com,
	mhiramat@kernel.org,
	anna.schumaker@oracle.com,
	boqun.feng@gmail.com,
	joel.granados@kernel.org,
	kent.overstreet@linux.dev,
	leonylgao@tencent.com,
	linux-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	senozhatsky@chromium.org,
	tfiga@chromium.org,
	amaindex@outlook.com,
	jstultz@google.com,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH v4 0/3] hung_task: extend blocking task stacktrace dump to semaphore
Date: Thu, 20 Mar 2025 14:49:20 +0800
Message-ID: <20250320064923.24000-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Inspired by mutex blocker tracking[1], this patch series extend the
feature to not only dump the blocker task holding a mutex but also to
support semaphores. Unlike mutexes, semaphores lack explicit ownership
tracking, making it challenging to identify the root cause of hangs. To
address this, we introduce a last_holder field to the semaphore structure,
which is updated when a task successfully calls down() and cleared during
up().

The assumption is that if a task is blocked on a semaphore, the holders
must not have released it. While this does not guarantee that the last
holder is one of the current blockers, it likely provides a practical hint
for diagnosing semaphore-related stalls.

With this change, the hung task detector can now show blocker task's info
like below:

[Thu Mar 20 04:52:21 2025] INFO: task cat:955 blocked for more than 120 seconds.
[Thu Mar 20 04:52:21 2025]       Tainted: G            E      6.14.0-rc6+ #1
[Thu Mar 20 04:52:21 2025] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[Thu Mar 20 04:52:21 2025] task:cat             state:D stack:0     pid:955   tgid:955   ppid:917    task_flags:0x400000 flags:0x00000000
[Thu Mar 20 04:52:21 2025] Call Trace:
[Thu Mar 20 04:52:21 2025]  <TASK>
[Thu Mar 20 04:52:21 2025]  __schedule+0x491/0xbd0
[Thu Mar 20 04:52:21 2025]  schedule+0x27/0xf0
[Thu Mar 20 04:52:21 2025]  schedule_timeout+0xe3/0xf0
[Thu Mar 20 04:52:21 2025]  ? __folio_mod_stat+0x2a/0x80
[Thu Mar 20 04:52:21 2025]  ? set_ptes.constprop.0+0x27/0x90
[Thu Mar 20 04:52:21 2025]  __down_common+0x155/0x280
[Thu Mar 20 04:52:21 2025]  down+0x53/0x70
[Thu Mar 20 04:52:21 2025]  read_dummy_semaphore+0x23/0x60
[Thu Mar 20 04:52:21 2025]  full_proxy_read+0x5f/0xa0
[Thu Mar 20 04:52:21 2025]  vfs_read+0xbc/0x350
[Thu Mar 20 04:52:21 2025]  ? __count_memcg_events+0xa5/0x140
[Thu Mar 20 04:52:21 2025]  ? count_memcg_events.constprop.0+0x1a/0x30
[Thu Mar 20 04:52:21 2025]  ? handle_mm_fault+0x180/0x260
[Thu Mar 20 04:52:21 2025]  ksys_read+0x66/0xe0
[Thu Mar 20 04:52:21 2025]  do_syscall_64+0x51/0x120
[Thu Mar 20 04:52:21 2025]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[Thu Mar 20 04:52:21 2025] RIP: 0033:0x7ff96d4ab46e
[Thu Mar 20 04:52:21 2025] RSP: 002b:00007ffe2f47f3a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[Thu Mar 20 04:52:21 2025] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007ff96d4ab46e
[Thu Mar 20 04:52:21 2025] RDX: 0000000000020000 RSI: 00007ff96d39f000 RDI: 0000000000000003
[Thu Mar 20 04:52:21 2025] RBP: 00007ff96d39f000 R08: 00007ff96d39e010 R09: 0000000000000000
[Thu Mar 20 04:52:21 2025] R10: fffffffffffffbc5 R11: 0000000000000246 R12: 0000000000000000
[Thu Mar 20 04:52:21 2025] R13: 0000000000000003 R14: 0000000000020000 R15: 0000000000020000
[Thu Mar 20 04:52:21 2025]  </TASK>
[Thu Mar 20 04:52:21 2025] INFO: task cat:955 blocked on a semaphore likely last held by task cat:909
[Thu Mar 20 04:52:21 2025] task:cat             state:S stack:0     pid:909   tgid:909   ppid:771    task_flags:0x400000 flags:0x00000000
[Thu Mar 20 04:52:21 2025] Call Trace:
[Thu Mar 20 04:52:21 2025]  <TASK>
[Thu Mar 20 04:52:21 2025]  __schedule+0x491/0xbd0
[Thu Mar 20 04:52:21 2025]  ? _raw_spin_unlock_irqrestore+0xe/0x40
[Thu Mar 20 04:52:21 2025]  schedule+0x27/0xf0
[Thu Mar 20 04:52:21 2025]  schedule_timeout+0x77/0xf0
[Thu Mar 20 04:52:21 2025]  ? __pfx_process_timeout+0x10/0x10
[Thu Mar 20 04:52:21 2025]  msleep_interruptible+0x49/0x60
[Thu Mar 20 04:52:21 2025]  read_dummy_semaphore+0x2d/0x60
[Thu Mar 20 04:52:21 2025]  full_proxy_read+0x5f/0xa0
[Thu Mar 20 04:52:21 2025]  vfs_read+0xbc/0x350
[Thu Mar 20 04:52:21 2025]  ? __count_memcg_events+0xa5/0x140
[Thu Mar 20 04:52:21 2025]  ? count_memcg_events.constprop.0+0x1a/0x30
[Thu Mar 20 04:52:21 2025]  ? handle_mm_fault+0x180/0x260
[Thu Mar 20 04:52:21 2025]  ksys_read+0x66/0xe0
[Thu Mar 20 04:52:21 2025]  do_syscall_64+0x51/0x120
[Thu Mar 20 04:52:21 2025]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[Thu Mar 20 04:52:21 2025] RIP: 0033:0x7fe6bf7a046e
[Thu Mar 20 04:52:21 2025] RSP: 002b:00007ffd6e1a4028 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[Thu Mar 20 04:52:21 2025] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007fe6bf7a046e
[Thu Mar 20 04:52:21 2025] RDX: 0000000000020000 RSI: 00007fe6bf694000 RDI: 0000000000000003
[Thu Mar 20 04:52:21 2025] RBP: 00007fe6bf694000 R08: 00007fe6bf693010 R09: 0000000000000000
[Thu Mar 20 04:52:21 2025] R10: fffffffffffffbc5 R11: 0000000000000246 R12: 0000000000000000
[Thu Mar 20 04:52:21 2025] R13: 0000000000000003 R14: 0000000000020000 R15: 0000000000020000

[1] https://lore.kernel.org/all/174046694331.2194069.15472952050240807469.stgit@mhiramat.tok.corp.google.com

Thanks,
Lance

---
v3 -> v4:
 * #01 #02 Pick RB from Masami - thanks!
 * #03 Pick AB from Masami - thanks!
 * Extract the type from the blocker and use a switch-case instead of
if-else, suggested by Masami
 * https://lore.kernel.org/all/20250319081138.25133-1-ioworker0@gmail.com

v2 -> v3:
 * Remove the unnecessary WARN_ON_ONCE check for 'current->blocker',
 suggested by Masami
 * Drop the redundant #ifdef for including the hung task header file,
 suggested by Masam
 * Unify the samples into 'hung_task_tests.c', suggested by Masami
 * https://lore.kernel.org/all/20250314144300.32542-1-ioworker0@gmail.com

v1 -> v2:
 * Use one field to store the blocker as only one is active at a time,
 suggested by Masami
 * Leverage the LSB of the blocker field to reduce memory footprint,
 suggested by Masami
 * Add a hung_task detector semaphore blocking test sample code
 * https://lore.kernel.org/all/20250301055102.88746-1-ioworker0@gmail.com

Lance Yang (2):
  hung_task: replace blocker_mutex with encoded blocker
  hung_task: show the blocker task if the task is hung on semaphore

Zi Li (1):
  samples: extend hung_task detector test with semaphore support

 include/linux/hung_task.h           | 99 +++++++++++++++++++++++++++++
 include/linux/sched.h               |  2 +-
 include/linux/semaphore.h           | 15 ++++-
 kernel/hung_task.c                  | 55 ++++++++++++----
 kernel/locking/mutex.c              |  5 +-
 kernel/locking/semaphore.c          | 52 +++++++++++++--
 samples/Kconfig                     |  9 +--
 samples/hung_task/Makefile          |  2 +-
 samples/hung_task/hung_task_mutex.c | 66 -------------------
 samples/hung_task/hung_task_tests.c | 97 ++++++++++++++++++++++++++++
 10 files changed, 310 insertions(+), 92 deletions(-)
 create mode 100644 include/linux/hung_task.h
 delete mode 100644 samples/hung_task/hung_task_mutex.c
 create mode 100644 samples/hung_task/hung_task_tests.c

-- 
2.45.2


