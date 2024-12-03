Return-Path: <linux-kernel+bounces-429648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2939E1F1C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5068C164492
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CF11F471F;
	Tue,  3 Dec 2024 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uw3k4XLJ"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0742AD02
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236092; cv=none; b=o2SmDkTNqmEaSAGqwkGSn3OCkzIxcLir0KFHvr5TKSbgEYI6+8oqqqVmHtti7v9h62mfuO7l0lAhzPA3GOM9HKM6u6dBYPPGYr/+0cOC6Hbw1Xf1Kcu3uw1UFDaHfGg+iOgVikKcE7eAN1J8C59SaR5JzEHbDFWl8adkPSG9EVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236092; c=relaxed/simple;
	bh=7mN9C9Jn4rEvVc9jg6Io3jGStIMFE6pc94emAgCGj3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G5PwPo4TlA2rjegaWQhwLdOFEkxE8H9dwuKI7oG53Ek4AemjpqmMwBBxfqlM0X84qMIGR4ZcflyQ5ubBQJrHQmjXI8D+M7nUPcaefZHYgsNbTsZvjoC/0iZzNcK0uCvZk8CCVUp1ePHeTjhRKRTuhyXW5/EK3rPUAi8d55vPLjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uw3k4XLJ; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2eeb2e749c5so2048371a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 06:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733236090; x=1733840890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z1gfBgk5XxYxE26UI+NWj7ypg8ooTMwgNlts0k4kyyw=;
        b=Uw3k4XLJXQf/bOo7rl19P/wAr/q+8gbZJ4/ALE8032HCYgoUXrp3CH9uzyPOZ2zTaj
         l3bYMkBCP3rpI03b6Szx6gs1q3LZDyQy5coXzvP2yxbvxW+O0k9LOjMyETXcuwnxGmK8
         6W7J5eLMf+6pp1IqE9pozu2fom1LaEHlIfpCj8nIjYhG+VXuTR/6fVs4sZFtakN20JDV
         aPUq/Sp7k7dmzWZJdiMuKpcFjnG/hvBf850FIfog858muRMGyINX15X1byxeIWUWLTd9
         LYGt4iHZpj1K0BYlGKZ98UDMn41RJKuWN4revJqcBiHQLOl+UyNLRbplb450mWxgKrfs
         rV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733236090; x=1733840890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z1gfBgk5XxYxE26UI+NWj7ypg8ooTMwgNlts0k4kyyw=;
        b=OXIQ56LqCQh4Xx9oYaBZ/bWnIniNWiudXd3ISiB6FREwa+BsuqE4LbMrRYScVgvJ7/
         0YucZ5D6mYrFOvBO+/qBoo8UEkRUiMfsk7mHM5y7MkSRcdZsqOg0SR9I42P2PLSazhrp
         gMXVPV12GtwMuhyNhsBDdc8H3zzt2YZqoqDeVGMuo8im4bNOVI+rCxCFUAHW/objg7uO
         VbYOFwgzHSDNnO4zJFjnkp9Wl6eAfoajtgrCc7UEl8coDH+P4uafJlaW+x5UARbv7MWO
         r+fNJA26dwHocc/4EGMnytZVdTx407jd+2VYcvHGrvWDnDx84B5ISs7jIPuy6W0ObCRb
         /6iA==
X-Forwarded-Encrypted: i=1; AJvYcCWTUNOmh6KlKregWZ0UefcZNN8rLRHL4w5cg5NwKaEAIJ85NZz2lt+9HASAtQW3TraISREFGJNn4w/jcGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCjJWNJ6OpUROPAz2zKCThafeue6Wz3U2rCebh/W5hxKOrMG9V
	vjMFTRyvXvqWlNayPntHsk2t0sTySyn9iYTLhYmguhz9UZa/USMO
X-Gm-Gg: ASbGncvM1qAwgGc8epmGRQeZVl9qTlHgO+tbEr+lgGv84tWNhLyhiB4NWgbSxJHG9Za
	BaecinOPKtrd+zg5VrJzKi1Av0OcBMjVpKHhf0Qa7vLX/XVw2csvNESfkY4SKGVOSdVH1myVfr3
	ZRW2s4xe1N3OY2EtTQnORmFPqVXSyCPa7C6hzsWZJtKHdeVoCsoNNnVJY5kKVKhqRfMnto294hz
	ecFIeb7LGM2GUV0lVDBRfkV8Ts/O3u8xFMlDz/iZ5ySEmvB1fwJ9DJe0KTjGrXwL4EtOImYHzZh
	5aXlpw==
X-Google-Smtp-Source: AGHT+IEXyG9Cx8/N5TRX82Zs+cCY87hnTJcqT+hLVhVBtfBVyVWtXTgtZxj+wRO9YlFoEsEayViU5Q==
X-Received: by 2002:a17:90a:da87:b0:2ee:96e3:d834 with SMTP id 98e67ed59e1d1-2ef01274898mr3114151a91.34.1733236089864;
        Tue, 03 Dec 2024 06:28:09 -0800 (PST)
Received: from localhost ([58.29.143.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417fb7d5sm10497374b3a.94.2024.12.03.06.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 06:28:09 -0800 (PST)
From: Changwoo Min <multics69@gmail.com>
X-Google-Original-From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	mingo@redhat.com,
	peterz@infradead.org
Cc: changwoo@igalia.com,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] sched_ext: Support high-performance monotonically non-decreasing clock
Date: Tue,  3 Dec 2024 23:27:57 +0900
Message-ID: <20241203142802.36305-1-changwoo@igalia.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many BPF schedulers (such as scx_central, scx_lavd, scx_rusty, scx_bpfland,
and scx_flash) frequently call bpf_ktime_get_ns() for tracking tasks' runtime
properties. If supported, bpf_ktime_get_ns() eventually reads a hardware
timestamp counter (TSC). However, reading a hardware TSC is not
performant in some hardware platforms, degrading IPC.

This patchset addresses the performance problem of reading hardware TSC
by leveraging the rq clock in the scheduler core, introducing a
scx_bpf_clock_get_ns() function for BPF schedulers. Whenever the rq clock
is fresh and valid, scx_bpf_clock_get_ns() provides the rq clock, which is
already updated by the scheduler core (update_rq_clock), so it can reduce
reading the hardware TSC.

When the rq lock is released (rq_unpin_lock) or a long-running
operations are done by the BPF scheduler (ops.running, ops.update_idle),
the rq clock is invalidated, so a subsequent scx_bpf_clock_get_ns() call
gets the fresh sched_clock for the caller.

In addition, scx_bpf_clock_get_ns() guarantees the clock is
monotonically non-decreasing for the same CPU, so the clock cannot go
backward in the same CPU.

Using scx_bpf_clock_get_ns() reduces the number of reading hardware TSC
by 40-70% (65% for scx_lavd, 58% for scx_bpfland, and 43% for scx_rusty)
for the following benchmark.

    perf bench -f simple sched messaging -t -g 20 -l 6000

The patchset begins by managing the status of rq clock in the scheduler
core, then implementing scx_bpf_clock_get_ns(), and finally applying it
to the BPF schedulers.

ChangeLog v2 -> v3:
  - To avoid unnecessarily modifying cache lines, scx_rq_clock_update()
    and scx_rq_clock_stale() update the clock and flags only when a
    sched_ext scheduler is enabled.

ChangeLog v1 -> v2:
  - Rename SCX_RQ_CLK_UPDATED to SCX_RQ_CLK_VALID to denote the validity
    of an rq clock clearly.
  - Rearrange the clock and flags fields in struct scx_rq to make sure
    they are in the same cacheline to minimize the cache misses 
  - Add an additional explanation to the commit message in the 2/5 patch
    describing when the rq clock will be reused with an example.
  - Fix typos
  - Rebase the code to the tip of Tejun's sched_ext repo

Changwoo Min (5):
  sched_ext: Implement scx_rq_clock_update/stale()
  sched_ext: Manage the validity of scx_rq_clock
  sched_ext: Implement scx_bpf_clock_get_ns()
  sched_ext: Add scx_bpf_clock_get_ns() for BPF scheduler
  sched_ext: Replace bpf_ktime_get_ns() to scx_bpf_clock_get_ns()

 kernel/sched/core.c                      |  6 +-
 kernel/sched/ext.c                       | 74 ++++++++++++++++++++++++
 kernel/sched/sched.h                     | 50 +++++++++++-----
 tools/sched_ext/include/scx/common.bpf.h |  1 +
 tools/sched_ext/include/scx/compat.bpf.h |  5 ++
 tools/sched_ext/scx_central.bpf.c        |  4 +-
 tools/sched_ext/scx_flatcg.bpf.c         |  2 +-
 7 files changed, 123 insertions(+), 19 deletions(-)

-- 
2.47.1


