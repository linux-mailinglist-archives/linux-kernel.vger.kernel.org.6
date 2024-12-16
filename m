Return-Path: <linux-kernel+bounces-446739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2799F289A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 04:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86A0F165592
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 03:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277DE153838;
	Mon, 16 Dec 2024 03:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWM7EQw5"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F89171BB
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 03:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734318728; cv=none; b=g8wgS7gm0E8JB+p9TWluqBKaTMtnrMywpHo0qtsj44XiKSU7GmTO8pJthAKrYRpwLdCNyLzRXhl891DT8kB9lDZCxCdty364nfD+ReK+Y579NtpAgkTTjHKdJ9Y7ayv+nwEUBLSEI+oVmkSI+0Qjtsn05suT6TwP/KVwoWrAOes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734318728; c=relaxed/simple;
	bh=iCJsXEPKcfzkUJiaNcwPEwMlcRzd0SBq/00lpXbLSQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mcz/caHduaJ/2HevATyIiaDlz0IUKqfk5sVXB3u0LQsQfsRMHWN4ynlPZJVS2zkKe1bU/YT5uXJzi6lf/1Zokz5x8rRorJURAwKrHISTnM4aSmfU1Cw/+o3mmhGWnOonEPA0s853GCIj5dh07XF8dipolNX6I8UFlLvQ8gg9IVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWM7EQw5; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21675fd60feso37913215ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 19:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734318726; x=1734923526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mM0+HQYd4sebLXNTJZj1lf5N6f/uv9wUHc9FBPnV5zs=;
        b=YWM7EQw5s1Tv94wnrstovwNC3Y3VhxXRp/RH6X71ViGdeypQDPQJx9KmAX+ANzjzbg
         VJAJI+7xZ7J09LdnXli9KiHUWA6r5FBE/RCeo8gtbOTIJIdxMOjPDGip2TiBuxl0zmU0
         xlvBZzTmriXlfyqdyq2W+b3BuSK0dYWH2Og14CBPCy1BerddnkEDXSRao3bOwrQP/vlP
         H+Ft5Sf3ql0bSY9oyfFsuoR9sGihJjCi8iyHh5izq6FAGlRRmrgZuGtubTHRzZPwHvr7
         OT4D34ivw0xXb/RZ1rVmBY2ti7JhikilteATK9uYaHQyfQKvod4ePzI181iDZF2qfn9F
         goMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734318726; x=1734923526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mM0+HQYd4sebLXNTJZj1lf5N6f/uv9wUHc9FBPnV5zs=;
        b=WlBlI0k8++aTrC2iXe2SZ8QrCE2wqFKT25IrvPZ8YnO74idcXAm65lCQcRGkkWGrAB
         bVG7x6LYDEyDimlTvceXJ+LXU4wlVJ4YWmvlfioipAA3KJHjRepUQc67G7MIRL+H+iYI
         F8slTyACNE07ADHUDEXm8oaBenrfX/kFgq5ozcCIG31haHiOs7Vr08Y8BTL8WS/gsyin
         Fy/2I2Yd/k2jexPHluqMKmMLQLVfIvmKS+BSxaFYFEceU1Jz2aNDKj/z6HvKjfgZ/mnd
         b3oD9B6eIfXt70nJdUapaWnIyyDJA9a8id4X42EIfLop+FIGsyNkHmG9a0Ytcd+rtGST
         ogTg==
X-Forwarded-Encrypted: i=1; AJvYcCUghop0f34oDnYADxVGYk4n+DTq3iWSlMN4SiQyrS7gmu9B5NGfftNUvWptFRM3z6XJ7Sw79GHPZQb4rng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk72FfWHmqCaKk+uTvR+KX8C6nLqJjSL8k+9zXLIUboYVFsPE1
	4viu9Jb/SlCEjlA8Wvb0oieG17uk+cL6+aH5Ei292FlXy7H0toGIj0IO8Q==
X-Gm-Gg: ASbGnctS7S/9XzfdZAlfJYmf9/aQyhV9QvgEtlI/4QajSe63HBA4eD9p6XvpfFADeWX
	dI1AJVB5S/JQLaqo573VWWlpf9tYU4oo7lIFFLPYZiV64AWW5mANNYArDEvL9c4rnriPv7qSjXY
	bKw9zMQ+5rd8+iXopRXbTYNBm6t7nuSKDnfaX3ep1UdbJ392XYMqmHIGi/i8ABZkbVYvcZmRJwe
	A5o2NgW59CuEylqON3i/TI8Y/zTOmzGm8I2Jwm2qabWSF18DOC9tNvucTVFi3bpVkkoTZSvZETr
	nmse5VB7G6dz
X-Google-Smtp-Source: AGHT+IHRvd2Qaz+f/19XwPgp1bWXlOi6GD8SNVhh6JSKFTrgpr4eBRCo3chbXJGDqyKv2GfQTfTPAg==
X-Received: by 2002:a17:902:dace:b0:215:b5d6:5fa0 with SMTP id d9443c01a7336-21892a5d71emr146736095ad.36.1734318725986;
        Sun, 15 Dec 2024 19:12:05 -0800 (PST)
Received: from localhost ([58.29.143.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1dd43c4sm32929115ad.107.2024.12.15.19.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 19:12:05 -0800 (PST)
From: Changwoo Min <multics69@gmail.com>
X-Google-Original-From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	mingo@redhat.com,
	peterz@infradead.org,
	arighi@nvidia.com
Cc: kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org,
	Changwoo Min <changwoo@igalia.com>
Subject: [PATCH v5 0/6] sched_ext: Support high-performance monotonically non-decreasing clock
Date: Mon, 16 Dec 2024 12:11:38 +0900
Message-ID: <20241216031144.98097-1-changwoo@igalia.com>
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
scx_bpf_now_ns() function for BPF schedulers. Whenever the rq clock
is fresh and valid, scx_bpf_now_ns() provides the rq clock, which is
already updated by the scheduler core (update_rq_clock), so it can reduce
reading the hardware TSC.

When the rq lock is released (rq_unpin_lock), the rq clock is invalidated,
so a subsequent scx_bpf_now_ns() call gets the fresh sched_clock for the caller.

In addition, scx_bpf_now_ns() guarantees the clock is monotonically
non-decreasing for the same CPU, so the clock cannot go backward
in the same CPU.

Using scx_bpf_now_ns() reduces the number of reading hardware TSC
by 50-80% (76% for scx_lavd, 82% for scx_bpfland, and 51% for scx_rusty)
for the following benchmark:

    perf bench -f simple sched messaging -t -g 20 -l 6000


ChangeLog v4 -> v5:
  - Merge patches 2, 3, and 4 into one for readability.
  - Use a time helper (time_after_eq64) for time comparison at scx_bpf_now_ns().
  - Do not validate the rq clock outside the rq critical section for
    more predictable behavior.
  - Improve the comment at scx_bpf_now_ns() for readability.
  - Rename scx_rq_clock_stale() into  scx_rq_clock_invalidate().
  - Invalidate all the rq clocks upon unloading to prevent getting outdated
    rq clocks from a previous scx scheduler.
  - Use READ/WRITE_ONCE() when accessing rq->scx.{clock, prev_clock, flags}
    to properly handle concurrent accesses from an interrupt contex.
  - Add time helpers for BPF schedulers.
  - Update the rdtsc reduction numbers in the cover letter with the latest
    scx_scheds (1.0.7) and the updated scx_bpf_now_ns().

ChangeLog v3 -> v4:
  - Separate the code relocation related to scx_enabled() into a
    separate patch.
  - Remove scx_rq_clock_stale() after (or before) ops.running() and
    ops.update_idle() calls
  - Rename scx_bpf_clock_get_ns() into scx_bpf_now_ns() and revise it to
    address the comments
  - Move the per-CPU variable holding a prev clock into scx_rq
    (rq->scx.prev_clock)
  - Add a comment describing when the clock could go backward in
    scx_bpf_now_ns()
  - Rebase the code to the tip of Tejun's sched_ext repo (for-next
    branch)

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

Changwoo Min (6):
  sched_ext: Relocate scx_enabled() related code
  sched_ext: Implement scx_bpf_now_ns()
  sched_ext: Add scx_bpf_now_ns() for BPF scheduler
  sched_ext: Add time helpers for BPF schedulers
  sched_ext: Replace bpf_ktime_get_ns() to scx_bpf_now_ns()
  sched_ext: Use time helpers in BPF schedulers

 kernel/sched/core.c                      |   6 +-
 kernel/sched/ext.c                       | 121 ++++++++++++++++++++++-
 kernel/sched/sched.h                     |  54 +++++++---
 tools/sched_ext/include/scx/common.bpf.h |  95 ++++++++++++++++++
 tools/sched_ext/include/scx/compat.bpf.h |   5 +
 tools/sched_ext/scx_central.bpf.c        |   9 +-
 tools/sched_ext/scx_flatcg.bpf.c         |  13 +--
 tools/sched_ext/scx_simple.bpf.c         |   5 -
 8 files changed, 270 insertions(+), 38 deletions(-)

-- 
2.47.1


