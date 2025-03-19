Return-Path: <linux-kernel+bounces-567467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFB9A6866E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F580188C615
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EFD2505B8;
	Wed, 19 Mar 2025 08:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2Ood/yj"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE8018DB0A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 08:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742371916; cv=none; b=g6Hk2X97Za6Zc/bxiwF8AjBoksxzOhsDzQGihrOSNaCcXKD3t7J0T33/fwFU4l8PeOFC+N1MenjdnJvRoCQ5/0Y31SguH/XfFrg7JGGiGpNjiGkweTovOKuL2gRCev0yNyanoj2k5Miu5c0jwKxkg4ETrkhZBCwCd2/ZdNM0jhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742371916; c=relaxed/simple;
	bh=e7ccE6SoLdZD68qyf5KyNwrsZd9YWIjb111AP0NQZ28=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ajWepCuqFCzynlJm4xM83muHLwlhi6n+EPhfz8qjNCc3Z6a32VcUGXv7qkul3Ubtp8w5YVQ4BYM/mCuXYaOQ5RNFtjsRz8MLcTS91lmygc8SgaY2AvLUpT5o7ZBc+bQw4fQpJjwlI9mBgE1Z61MgN41ejTBhHiDzn6woohH6DRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2Ood/yj; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22435603572so106722885ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 01:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742371914; x=1742976714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XOsLWxL0q0LjUoH4DdNGWqszFOOvUvIXGouyxdK5xQA=;
        b=C2Ood/yj7c9V+CD32LnAUiV3gn8fqppMV2PQCuSkBPY5C/TN6xs/Vedz8uuGyTKTj7
         R6fpE5S3hFCYAP8ZcmkoGJcK16t05sLQOHXtTKtudtigDIJjLFemJFGtmZSLvSaoDWXu
         aYZLM3kNepRapXkL3wfVXbPqnFkjT911CrK2XIttrm0PX8ol0Fcinjggwmbyv+wooPPI
         lO6YiL2ZLFWB9ekYvJX9EZCb+bvvDGhZT942vCbFyj1l6FRioBtYJSm/n4gpQew/TLiZ
         V9K4t+tJkxaLsTvmCSqHzHLHdbm/mNhVur4NIWe6/ZAlx+WAp61MxSP9tomstMyB2gg0
         ipLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742371914; x=1742976714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XOsLWxL0q0LjUoH4DdNGWqszFOOvUvIXGouyxdK5xQA=;
        b=NpFewL3YqYTYSmtJlLi7sdkSDVgjBEYurJhFLZYotLi3FeaVSDbcQFxN3hvlDj6jdH
         YKamuZhaz3DtS2XFA71lnQ+ciBfoV6WiFxS1eSXPTgttRJrPcUQPQD2m4ZYDZTOGTLny
         aERGfefKJmJKLiYeht2ZTkhwURqNrTXpxp6pyaNNM2qiIk6kwgUdV+Z7/91t0MgnUEe7
         AxyhjJrRhKXI28ztyMwCoBsDZXbYalaurUCavyWfxXH5o9x0x+Mzjq0xFCH9gdtiLihC
         EpyT2ZPvmqoglzZCB1qL6QF5NimLc6OK5T9M0sEVXEC6j2wiMVEmYCINlwpcTcFBHP8P
         174Q==
X-Forwarded-Encrypted: i=1; AJvYcCVW6y4Qj/yLuuCmXejGb0JMRI8IZFEkr2oITYchJ6wHz6JkqIdyq0X3+1y+T0giNf/VG62DMMAdDuFBVNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxV4Y5iLsbMRJAN6y06Lqi3/9877jZF+p/0xyvO1Xeceo5bUhG
	xoOfRhGLrYqs7PttZ816EHQiBkLQre+RRXF+c+Z7VOF+qDCgTrvC
X-Gm-Gg: ASbGncuRuzjV/6iac45do2BHfPyd6dG5s7EhYnTiCod4Og1FvCTl6gz4X6rOfWwbOC5
	fNA5kWHsXCbpFsu/9nMvS/GsdWaewHAGd+ngIeuXXzF+vMj/iiGHUsqzxcA5ncwkRSYt/GFHznx
	iK6p88PNnlFw9xCMpQRtSUt2Bj3Qhvvt+JgznP1hNVwe5Z5qZKKVfk79TVe3/GVYnIrLqJncDeY
	uqoOb2I791+o5xry0/nJQ2nmPxD/ArDGsScyWRVe2tj/C7SRJfBgIXFO6gAovI8m1UlCLQy2AST
	qmbzq0uOXKyIoZkNp/5yk863vFKrsyWIpGTrYX3P4PagYjUp9Q==
X-Google-Smtp-Source: AGHT+IGddSfvDR6g1jHk3NNkLJrncxIP12/Otd/s3qgE7CI1penbW9A+0+WPXkR8sC9/+S7uOYfdgw==
X-Received: by 2002:a17:902:f60d:b0:223:3b76:4e22 with SMTP id d9443c01a7336-2264980c773mr27967795ad.6.1742371913739;
        Wed, 19 Mar 2025 01:11:53 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([43.129.202.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68887bfsm108059455ad.34.2025.03.19.01.11.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Mar 2025 01:11:53 -0700 (PDT)
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
Subject: [PATCH v3 0/3] hung_task: extend blocking task stacktrace dump to semaphore
Date: Wed, 19 Mar 2025 16:11:35 +0800
Message-ID: <20250319081138.25133-1-ioworker0@gmail.com>
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

[Thu Mar 13 15:18:38 2025] INFO: task cat:1803 blocked for more than 122 seconds.
[Thu Mar 13 15:18:38 2025]       Tainted: G           OE      6.14.0-rc3+ #14
[Thu Mar 13 15:18:38 2025] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[Thu Mar 13 15:18:38 2025] task:cat             state:D stack:0     pid:1803  tgid:1803  ppid:1057   task_flags:0x400000 flags:0x00000004
[Thu Mar 13 15:18:38 2025] Call trace:
[Thu Mar 13 15:18:38 2025]  __switch_to+0x1ec/0x380 (T)
[Thu Mar 13 15:18:38 2025]  __schedule+0xc30/0x44f8
[Thu Mar 13 15:18:38 2025]  schedule+0xb8/0x3b0
[Thu Mar 13 15:18:38 2025]  schedule_timeout+0x1d0/0x208
[Thu Mar 13 15:18:38 2025]  __down_common+0x2d4/0x6f8
[Thu Mar 13 15:18:38 2025]  __down+0x24/0x50
[Thu Mar 13 15:18:38 2025]  down+0xd0/0x140
[Thu Mar 13 15:18:38 2025]  read_dummy+0x3c/0xa0 [hung_task_sem]
[Thu Mar 13 15:18:38 2025]  full_proxy_read+0xfc/0x1d0
[Thu Mar 13 15:18:38 2025]  vfs_read+0x1a0/0x858
[Thu Mar 13 15:18:38 2025]  ksys_read+0x100/0x220
[Thu Mar 13 15:18:38 2025]  __arm64_sys_read+0x78/0xc8
[Thu Mar 13 15:18:38 2025]  invoke_syscall+0xd8/0x278
[Thu Mar 13 15:18:38 2025]  el0_svc_common.constprop.0+0xb8/0x298
[Thu Mar 13 15:18:38 2025]  do_el0_svc+0x4c/0x88
[Thu Mar 13 15:18:38 2025]  el0_svc+0x44/0x108
[Thu Mar 13 15:18:38 2025]  el0t_64_sync_handler+0x134/0x160
[Thu Mar 13 15:18:38 2025]  el0t_64_sync+0x1b8/0x1c0
[Thu Mar 13 15:18:38 2025] INFO: task cat:1803 blocked on a semaphore likely last held by task cat:1802
[Thu Mar 13 15:18:38 2025] task:cat             state:S stack:0     pid:1802  tgid:1802  ppid:1057   task_flags:0x400000 flags:0x00000004
[Thu Mar 13 15:18:38 2025] Call trace:
[Thu Mar 13 15:18:38 2025]  __switch_to+0x1ec/0x380 (T)
[Thu Mar 13 15:18:38 2025]  __schedule+0xc30/0x44f8
[Thu Mar 13 15:18:38 2025]  schedule+0xb8/0x3b0
[Thu Mar 13 15:18:38 2025]  schedule_timeout+0xf4/0x208
[Thu Mar 13 15:18:38 2025]  msleep_interruptible+0x70/0x130
[Thu Mar 13 15:18:38 2025]  read_dummy+0x48/0xa0 [hung_task_sem]
[Thu Mar 13 15:18:38 2025]  full_proxy_read+0xfc/0x1d0
[Thu Mar 13 15:18:38 2025]  vfs_read+0x1a0/0x858
[Thu Mar 13 15:18:38 2025]  ksys_read+0x100/0x220
[Thu Mar 13 15:18:38 2025]  __arm64_sys_read+0x78/0xc8
[Thu Mar 13 15:18:38 2025]  invoke_syscall+0xd8/0x278
[Thu Mar 13 15:18:38 2025]  el0_svc_common.constprop.0+0xb8/0x298
[Thu Mar 13 15:18:38 2025]  do_el0_svc+0x4c/0x88
[Thu Mar 13 15:18:38 2025]  el0_svc+0x44/0x108
[Thu Mar 13 15:18:38 2025]  el0t_64_sync_handler+0x134/0x160
[Thu Mar 13 15:18:38 2025]  el0t_64_sync+0x1b8/0x1c0

[1] https://lore.kernel.org/all/174046694331.2194069.15472952050240807469.stgit@mhiramat.tok.corp.google.com

Thanks,
Lance

---
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

 include/linux/hung_task.h           | 93 +++++++++++++++++++++++++++
 include/linux/sched.h               |  2 +-
 include/linux/semaphore.h           | 15 ++++-
 kernel/hung_task.c                  | 49 +++++++++++----
 kernel/locking/mutex.c              |  5 +-
 kernel/locking/semaphore.c          | 52 ++++++++++++++--
 samples/Kconfig                     |  9 +--
 samples/hung_task/Makefile          |  2 +-
 samples/hung_task/hung_task_mutex.c | 66 --------------------
 samples/hung_task/hung_task_tests.c | 97 +++++++++++++++++++++++++++++
 10 files changed, 298 insertions(+), 92 deletions(-)
 create mode 100644 include/linux/hung_task.h
 delete mode 100644 samples/hung_task/hung_task_mutex.c
 create mode 100644 samples/hung_task/hung_task_tests.c

-- 
2.45.2


