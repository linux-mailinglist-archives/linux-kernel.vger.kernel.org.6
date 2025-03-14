Return-Path: <linux-kernel+bounces-561572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D81ECA6139F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 551797AD289
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723B3201002;
	Fri, 14 Mar 2025 14:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gyj5C2OE"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4882828DB3
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 14:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741962566; cv=none; b=o3pPybC8+pJXc1QuLf4TuDD/xGw/A1gvPuXw/SlnvdDOuzsT3INEHlWiV86dXqXxDHWAplaKeon2BYyLWxwVUbrWJPIJPACaRteSmTCVNcWzbOIhHbqlj+zvA+1RlFVQY9RWjshypTcwWm8mv0+e7QUTasT3kh0/n5FIdoBuECg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741962566; c=relaxed/simple;
	bh=asug4tEF3jJOWntdlDJ2EnhB4XqSbzDL6jCN0fdEmv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CGf9790u/wmtvnD2qFWFCiOSImaFliOEkqUsJowdYRx8byyFfjp1/VBY6jhu4hwogRckma94KNS8Ef57LtAqhOAWC2IYCr9gnHowubYn/oGLHYkMgmcItdfeazLsQeA7fH2S46qfEXwaHUV2uk6bTS3G9zfy+isl+2QyZSHtY/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gyj5C2OE; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22349bb8605so48158465ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741962564; x=1742567364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l6d/kobmHcOAfT2jWRHRunYvMQgtAxEDS/3OPy96SxE=;
        b=Gyj5C2OEZH44pXHkE67ociWjQjJqJqkDDP1NAoiS8IWv+qyeOnmQV9O9opFjPti4D3
         L3wuRW5H+FMqjI8iq57fXwZN9hb2l5YIL6s+X9AAZRAgQcFY+dRCUFhZMOt3U1T0u0Ox
         RxISPd1ebk6/TKMzwH7l93PP93z0+3h4RURqTojLn9TtI/eqfojEvUdyU0GpmVjGGze2
         VmZXj8GRaXA1qQpoN3nyCdCnQo1fZppRPFjnm7G4XdPWXLrGLyfxz5ekq72GoOTLOJKx
         hb/pJyeyXpUVAN9Ka4t5oe4WMTViWAXVyzHWYIjPVLYs/pQ4nyqefqKSBHUF/zEgzH4+
         TG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741962564; x=1742567364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l6d/kobmHcOAfT2jWRHRunYvMQgtAxEDS/3OPy96SxE=;
        b=Td/I5AjLrRQf6VsZuXQ0so43GiJz4/YOLgHH7IwLjczndrQms1+wEZenb15iYyHmBG
         zNlPRXWTHvxFkIz48MaSbNkdOt7VbLod3+rIcVbRqD8ARekjnbtSlFsjaDytma+sHOk9
         /0EOTOhhk2bAH7sQ++dT1+KwCLzOx7tbBKY3gKBFO/DlS0hvZ8m2HiFxJHwJps4eeAvi
         O+6Z8Vd4xhxZkko62T9c7/zoQib635DhZZH+4Hq0ojXxNwZhfs5fVHtny7blH5IP5/EX
         0NwtjyFmyxJ5U4tfr5YMoJxejMntmhHCt2jg5N18PCdZT7uU+ivgmTjXg4b9NEn6mVSI
         MRtw==
X-Forwarded-Encrypted: i=1; AJvYcCWsJui4pV7yyWYirBI1up15RHk0rFaDz2Qvu1LtfpF28sgq3/NGhcjgXa8skVasoyKk90cSLCMzFq2hnxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsD8i5YoPRNDenvwYoQQJ6xr4ZYyhO4Taz3LW5ldn2+YlfGyHz
	s+z3mZdYkyAsxqtLkdPeCHo2XcHt02hB9Y+I4fDUwcuKiNw9WChS
X-Gm-Gg: ASbGncttQyPzNQmvwb2UapmqHIiPVrJzUOygpThiuHOapSIJMJFH5uuGgrf+k9r+TqM
	yHGaWckBFgY9qt5y08BX9YuKITr2c0xIiCU9T+YqnyaiLTfgsJ41uclPT6+Akm0ri5ttSuOn9br
	Fb58WM2vFu0Oqj3CuYLgs857N2wGwsOfN9hmsEjvtkcpqlwyp4oMn3KFXHgf06KnVNitdwZKo4W
	UJKArrM5iYBBJZeJu7/iTCjY1yhsqi8yfDiQmXxv/CWT9ldDiVSa9sQjvlRExGoEDQGMurVIfJ0
	khLpemOCQup7eSoHNTG1QRafkkeONwVhs1pByZUUFHNzhg+dcit5oLc=
X-Google-Smtp-Source: AGHT+IGjdtEnlp+LXGCCMjl4Cll8ZA9DBXAqifiRF/DN96dM0ifKa0ZndxvnQtxCY8yX05ridXWNPw==
X-Received: by 2002:a17:902:d542:b0:216:6283:5a8c with SMTP id d9443c01a7336-225e0af9e3emr38892155ad.39.1741962564390;
        Fri, 14 Mar 2025 07:29:24 -0700 (PDT)
Received: from localhost.localdomain ([124.156.216.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbe833sm29142445ad.183.2025.03.14.07.29.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Mar 2025 07:29:23 -0700 (PDT)
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
Subject: [PATCH v2 0/3] hung_task: extend blocking task stacktrace dump to semaphore
Date: Fri, 14 Mar 2025 22:28:35 +0800
Message-ID: <20250314142839.24910-1-ioworker0@gmail.com>
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


