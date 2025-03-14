Return-Path: <linux-kernel+bounces-561604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC658A613DF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD2983B9899
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70583200BBE;
	Fri, 14 Mar 2025 14:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvDmzIW6"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525681FCFE3
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963399; cv=none; b=EV3wOiyLBFqV8l/dEADMFUeVA0Dvj94rK/tAv/ncHJECriz+EyiyaJHFLQ0uirs2pnEjgbZ9GH57Yz7N6nBwkPg6DILBuEiluJWwHdpyi0QQi/aeu5yC/yBnqplclJK8ObrUdL3JO1+AStW4lJ+SmGl2tAu22goQ/aLpoAaaOqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963399; c=relaxed/simple;
	bh=asug4tEF3jJOWntdlDJ2EnhB4XqSbzDL6jCN0fdEmv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ld59CIelbIGDPetv1rXLaT9hf3mogn3mYkwgyO9D5YD1Hz7gNm3B8KVh71B9+isOz/jOkwvQwNEc4Kjd4FmG/TfGNYfMkF13PLG37bRZiaIhFt9fg8W1tygO+H0wQ6pPdUonVq+FQuj/eP90j6ZI6/HLz8SKNQPndccf2+E2HP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvDmzIW6; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22409077c06so57351745ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741963396; x=1742568196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l6d/kobmHcOAfT2jWRHRunYvMQgtAxEDS/3OPy96SxE=;
        b=AvDmzIW6cZ+Ph/xDVVehEh4NzNVtBXOIbzWoHaROaaA4rrxn0mML6Ih5GDpg0Mx9K0
         zvD932Y2EZ3iUZIFcV/jVhbom7nBEcmmoK7dvWcwnzZoGYCTnDRsPiowO/BAcJ6mZAfN
         VzaKrz+ZUqXb4Ki6Se2bDoxFamPxiJvfibLaqfG1qJPub6HMOnNEqyTh1IIJ9DONEB6p
         fBGtuJJrrDB3YkG+xEePJIn0jKXrMefj7WW0JzOb9G8282G7Yx4K5Tlrbil5HtTOmc2T
         hbBZ5wSwd0guagT0mpk/yDBrYAFMCHVpTtuioQ2hjnFhrCd4eNG/qa2y4LSFNOG7z9DF
         3/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741963396; x=1742568196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l6d/kobmHcOAfT2jWRHRunYvMQgtAxEDS/3OPy96SxE=;
        b=mQauK3qcF3LTUnT/PdE5LgIr97ogW+3xSbcAu94w11y7UZbZeBl5wOLuYJuHsirgDK
         TZYT6jkJ0r3FWFBVJA4/KchPKYa23tq4T15nPiOAeVIrRLNVcNuV4iTgGj/Mubxj0mPY
         ShGlyqbvsiVb2U2kd+ZRoKlmCsAumCBIbknpTd8LnlfmdUVPaAm5NxGNq8WZaESM9spF
         nAN89YIfDnz0JBxovf+IELSqBdvTv3woSMzwvOoYiWaSM+psKgKnqI/GhbKK20qL3xfJ
         GuuEt6I3lIrxnd38rIVm/nhCioIJhGW82JsH5t/5mkj39W6Wphg7dsvV2oecfB+JK1Jl
         mC7g==
X-Forwarded-Encrypted: i=1; AJvYcCWNWMaonOHAyQstqCa+zqDd/aehR/g9s0EadKoUVQSoHL7xb2GbSdlZDSkvN3S7Eomb24vcDsHFhdGNXxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0J/E61DU0BK3m07ME+Vg8fn0sD3wwfIxihw8YBQGmm9inJNS5
	ZrvewAWSub1dQG2z9IiOiOXMmEipRTDldIYAxWNTbH98qrHV43SI
X-Gm-Gg: ASbGncuHOqiaq/tTfkgefPnzCHRGCWAnyOBnOryhyUNQyxQfJAaFVpLqRoxIjPEk0b/
	5+etlzhaStEYQlJP1gwqedMGICDfwsxaH+jlF33Td1LtlnZKNsYGDrTZKtgwa5yHP+z+PtsbDun
	rtnyO3qNCxQLnseH8KVGQ0OQzhK59iyQCTR9kfZ02LZg9WFVsazXy6AKuslcZVzeG3qSIg2ino3
	E9Fiyc/GZMYlpKVD+9vuX1jjA5FFecig5TyXsQYjE2BSrJWSEHBDr1V+PywzVFtNGoC0WUiB9aV
	vy9mfUFg0vbfZrKIXeD667LpYLuWa7MzPAH4HWOtAs2xfcLmR0uezBs=
X-Google-Smtp-Source: AGHT+IFsw6nMOQeaoPaK8V8ZIv2mq8RD1nAS/CAMQ5EoYf0WgVFAL/GaII5idQPsEBte51RXFWxlPA==
X-Received: by 2002:a17:902:c952:b0:224:584:6f05 with SMTP id d9443c01a7336-225e0aee7e6mr33970955ad.41.1741963396473;
        Fri, 14 Mar 2025 07:43:16 -0700 (PDT)
Received: from localhost.localdomain ([124.156.216.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba7280sm29228835ad.147.2025.03.14.07.43.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Mar 2025 07:43:16 -0700 (PDT)
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
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH RESEND v2 0/3] hung_task: extend blocking task stacktrace dump to semaphore
Date: Fri, 14 Mar 2025 22:42:57 +0800
Message-ID: <20250314144300.32542-1-ioworker0@gmail.com>
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
  samples: add hung_task detector semaphore blocking sample

 include/linux/hung_task.h               | 94 +++++++++++++++++++++++++
 include/linux/sched.h                   |  2 +-
 include/linux/semaphore.h               | 15 +++-
 kernel/hung_task.c                      | 52 +++++++++++---
 kernel/locking/mutex.c                  |  8 ++-
 kernel/locking/semaphore.c              | 55 +++++++++++++--
 samples/Kconfig                         | 11 +--
 samples/hung_task/Makefile              |  3 +-
 samples/hung_task/hung_task_mutex.c     | 20 ++++--
 samples/hung_task/hung_task_semaphore.c | 74 +++++++++++++++++++
 10 files changed, 301 insertions(+), 33 deletions(-)
 create mode 100644 include/linux/hung_task.h
 create mode 100644 samples/hung_task/hung_task_semaphore.c

-- 
2.45.2


