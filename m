Return-Path: <linux-kernel+bounces-436824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6C09E8B64
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 07:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83C151885A10
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 06:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D382C2101A9;
	Mon,  9 Dec 2024 06:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCvKFRSC"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A513743146
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 06:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733724942; cv=none; b=Cso+8iRMZIFs0tXjTHiyxn+geNjFwy9q744YwO+0CI+m1n0uAFqzqE8j50it0H0xoYS07BoHWvqTQm+6dlGOYmKcdRpEYj+eXaHuQREtt3d78kXFw6NIsIjqMAkEHWx5CJ7CGB3S+f0RRuoQqh6PiBlCeRiJCe0+u2hdjgsDLvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733724942; c=relaxed/simple;
	bh=/Nc24hmLIjFFU/ReKtLXew8kxadOUJqFsNQfjTZOGOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YWgEUKiJ1/XPZmhcU7a4NXUlLzT+YcEOG0xyyNpdZy6pYdG8H4koOl83Mx61mRJ9gjipBWkbSzB//XOW5zlJOoWSd1qF7tCITBN6ubHcvVazRmBjVCqeKk84CwVoXu8iXD9EZknzWfmeYy01TG8gDZBVxrLKLeM+RF+svhrH3Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCvKFRSC; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7f43259d220so2658281a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 22:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733724940; x=1734329740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IYv1qGr0i8CgXleFa1ay/Hs+aztXUq/LqNayyjTCKR0=;
        b=CCvKFRSCMM/umLMg8QeSGII2B8iWN/BCTdeO/qd+F93JBuGOhimBZAp7lWqe9xJnhf
         VDBVTAJqHfByzdzcsvBezkEo/GwNi0KeNqsfDwpRgReWhxdjJdGWQBqZJyEJIrQnFW95
         UpvahM+NKC937KgH8hIK41KvtpcbrsorHgIVw72zEUIWlzochONBA0NCnGPX7d8ltHq4
         hxg4rNDC3rFkCUR3mCXbzL7+yzlG4rlO1tRN7eAoSp5URE9l2ti8kphYafz5woCAe3H9
         KzLynUefcx6QkZbhfaRkECFi0uGngRCATCEd6sGmrSYNroWDNPl6R7e7goIsUZxy60Uk
         7llA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733724940; x=1734329740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IYv1qGr0i8CgXleFa1ay/Hs+aztXUq/LqNayyjTCKR0=;
        b=LLPy10cspVU/iI6uGA6r5OHOnhrD6QPlIWbset9091NWTCq+d3RcD2WRVtRhjsly1g
         Lpx2co4lNvAEZsw2Po6h5CVmAWa7S1QGk41DIjcNhlsWeczDIXft4TPOs+YDEb8dHXG4
         yCT7ad5T3Ju0H5F5gejMlsB+0Di9507unpCMjBafI/Lf50o2BSFljjfQARmF4Wu8U4sg
         wzhldBLIEUlUWWdBVhYpdLUk3epamCXV+Q9IRiqmgagvyx16RwTQxhjEs3N+owQBj4mf
         np2zTyvEzSdkrvFF7xWqtcF888roZCKW4yiD158wRFwgvPfs9B4NFViT8dS7D5aFQeP4
         O3xw==
X-Forwarded-Encrypted: i=1; AJvYcCWaqad34WCInrjyRhOV7Fa57Ab7+x9wLU3097ZtdJr8VrgRN9TGhqOtMCmTYwhMnsfTCgUDqR+L2wIeSjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YweQmNh47Fq5X/4KoM7Ai7kugtut2slVBeiPNXeg9+0v6deNrMS
	b9PVlYWzaGXxS8ubGy8P9wcHsqM7t1WGgSARtEtnrj6ei3O7sbZ6
X-Gm-Gg: ASbGncvjcgfgZQDXdG93wp7xP1zwqu7R7iHtSaYdX0ewfCFQyJ9BDykLaFEfqnyyFGJ
	15g7r0HT/dO5b+LlaznaeQbbnCh9N6U9jdTiaJHGa+QLmwGiLM55r4wLDmPwu0u3avbUsvDsBZ+
	guX+JlTE6qBQKEKliTLzPwQq+4ipboNV+lrtJhRjqYw5iTxgNTUK1u5zvvs9mVZ3VdU7S9ZiDeG
	nLBnsIeBKiw7E8gNBboKX/ojgMXaOOoV8Vz8gduFCCfeQIjQ881f5cGIzm7vJZfJJvQkNXrL+23
	NV9Guw==
X-Google-Smtp-Source: AGHT+IFwjLCR3A08I3ZLndZJceRiCY8aMtc9aO2jpBzjrVXin7aLTsmoOVaGxzZ2plVqOhYmi9E8zg==
X-Received: by 2002:a17:902:ce83:b0:216:50c6:6b42 with SMTP id d9443c01a7336-21650c670ffmr41337415ad.56.1733724939868;
        Sun, 08 Dec 2024 22:15:39 -0800 (PST)
Received: from localhost ([58.29.143.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216634dd69esm2331245ad.40.2024.12.08.22.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 22:15:39 -0800 (PST)
From: Changwoo Min <multics69@gmail.com>
X-Google-Original-From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	mingo@redhat.com,
	peterz@infradead.org
Cc: changwoo@igalia.com,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/6] sched_ext: Support high-performance monotonically non-decreasing clock
Date: Mon,  9 Dec 2024 15:15:25 +0900
Message-ID: <20241209061531.257531-1-changwoo@igalia.com>
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
by 40-70% (65% for scx_lavd, 58% for scx_bpfland, and 43% for scx_rusty)
for the following benchmark:

    perf bench -f simple sched messaging -t -g 20 -l 6000

The patchset begins by managing the status of rq clock in the scheduler
core, then implementing scx_bpf_now_ns(), and finally applying it to the
BPF schedulers.

ChangwLog v3 -> v4:
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
  sched_ext: Implement scx_rq_clock_update/stale()
  sched_ext: Manage the validity of scx_rq_clock
  sched_ext: Implement scx_bpf_now_ns()
  sched_ext: Add scx_bpf_now_ns() for BPF scheduler
  sched_ext: Replace bpf_ktime_get_ns() to scx_bpf_now_ns()

 kernel/sched/core.c                      |  6 +-
 kernel/sched/ext.c                       | 73 ++++++++++++++++++++++++
 kernel/sched/sched.h                     | 52 ++++++++++++-----
 tools/sched_ext/include/scx/common.bpf.h |  1 +
 tools/sched_ext/include/scx/compat.bpf.h |  5 ++
 tools/sched_ext/scx_central.bpf.c        |  4 +-
 tools/sched_ext/scx_flatcg.bpf.c         |  2 +-
 7 files changed, 124 insertions(+), 19 deletions(-)

-- 
2.47.1


