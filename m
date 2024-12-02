Return-Path: <linux-kernel+bounces-426908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A199DF9FB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 05:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6191B21B29
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 04:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864A31D6DBE;
	Mon,  2 Dec 2024 04:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frncWXKZ"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8858928399
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 04:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733114340; cv=none; b=hzeu5IcQn61+26NWJEL++AZEkg/Lgc/gqgpF3K85GInoaeScS/8qkPcRSZiRafW6NjdqcBVvv7kmfggdTQxTFzVq7WnC9i4DB+G15RXAdMsfZF8IJDNyjHQDFmwn/1wubwG+Rch/OLUzo+TGw8hIEIakizSPmy5q7HIVI0SZ1OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733114340; c=relaxed/simple;
	bh=F95rKXoNzAKa5cmUUSr5KAbv7rE56BLDSZ8GGmi0brw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c2hRPA3Ik++PX9QruWGu0mzMy0dbPr5pjv04omiN9MTB6zbMqzI2JARBp0CQvYqDbgXWvCl15F1Gu6X2keM5zBBpotHF7Q4VdbX/bY69pymsp5NEfFGp8sFyZwH2T1d1T+GrVyQN9cQ69hAPzJsXvCSWANveC6/+OoahPqI7QrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frncWXKZ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-215936688aeso3601755ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 20:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733114339; x=1733719139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p7k1BZ3LkaLj8m6wKaz8x/LaePHGLoUdOuQY1P9Ye/I=;
        b=frncWXKZIkaj67x2wQfGilllL2byr/vFilXB9YHjZSypMSQVYC6A6uWvT8Vp213D2M
         Kr4um8tqxVCYGucjSPBVM4XEbYxrYIERu6VGMkYgSVeiRMtDDjhwPFpCWU1Pffe3hjTv
         kUo/4rbIt/hLumVQhhPmgKPf2k37SED9qII16a5ikUXrlGxUZXmA7JfUWTn1MkXH+PDN
         xVEjSGadEt2AK2g1Ylpcpi68eF4yAz5I/Xzn9MFVYYYvYqTStyJ0AHdBJY8LsImSWGr7
         tYYq0MjSUSDxcxXqpr5yOyllortRwmZSBRwwWBQ+qyQQ6bylwinvoj0gFnoxSU2DM0dG
         /qew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733114339; x=1733719139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p7k1BZ3LkaLj8m6wKaz8x/LaePHGLoUdOuQY1P9Ye/I=;
        b=av0kkR5NuD1tMgg8ZXksmpemWnxrdZl3eUkecRsM3em9zqT2eVSu2GYBUjxLJTq4Vn
         QU9mPHa4+jPxoljBgWWQlQRh7Z4XYtxNvvzQI2sjZBy+oWIYYXa8J4AbjZNbARsyd1W+
         gMoTDm4y3izn2Kn5xh5yvyeA3fM7cTradyGRz+9o8szz9XShIjTYOe9iO7xmCfjTpDbL
         A6cRbhapXRjQW8uXn7PnbbDS4KZqCkoVxlC9qE3pyWrswYc6/Y/k8hiifh9fwRCug7xA
         3zUyS02WXNeU+86OK5gw1yxWBkjb80yIki6yiRZVWStCcJvTXr2ATVhukzTrT+e28/+N
         G2ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcklK4C+Ag7ew18FU4TWKLXrjqnS3rrP5HrmE819HwnkWpv0O5E94FAOtmchLQ0eQTNgF/UV1lY+EeEPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdodQuzPLK9sg0ip7dmjTncGl+dplhwHsLb+gWsoADQGHWhaat
	7FP938M0sZ5t8YnEeABE5iQBgxiAW+Oz5MQkn24E2WEx+czksdIm
X-Gm-Gg: ASbGncuVquAJ7I90UuD6dHZUiPNszfe/EzcFIIjlQGjkOCiilMyuqafpyepelu/Krl9
	HVwxDebFM1B6zmSh1gejaKM2irxX4Wo9mYUKs21v7lMZWLs+44MNXBhPr+zG7XnNwbezfafJOJW
	pxKTgIYBfhUO6FwdjS4Io/Aoo4aUcHpGx6KvTBYQzvu7EKCaDJwTJeRGOQbXi9FQaM5D8TYbqhB
	0A2n4EZGoad6XJhMBboS6Jbym5sFOUzYvAzwzKNxwbTo9e/m270iWuhYWZAvhHzGcpIuiruhf2x
	wUa0TQ==
X-Google-Smtp-Source: AGHT+IHXVfyT1BdSnTTF70SCBQjwOxaCMvZ/ncrM6RiH8cjECeF5BT7bBRexJRpx3COL1r7b0HbH5A==
X-Received: by 2002:a17:902:ccc4:b0:215:9bce:2c98 with SMTP id d9443c01a7336-2159bce2dc6mr21531515ad.51.1733114337337;
        Sun, 01 Dec 2024 20:38:57 -0800 (PST)
Received: from localhost ([58.29.143.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215219c9657sm67161845ad.261.2024.12.01.20.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 20:38:56 -0800 (PST)
From: Changwoo Min <multics69@gmail.com>
X-Google-Original-From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	mingo@redhat.com,
	peterz@infradead.org
Cc: changwoo@igalia.com,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] sched_ext: Support high-performance monotonically non-decreasing clock
Date: Mon,  2 Dec 2024 13:38:44 +0900
Message-ID: <20241202043849.1465664-1-changwoo@igalia.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many BPF schedulers (such as scx_central, scx_lavd, scx_rusty, scx_bpfland,
scx_flash) frequently call bpf_ktime_get_ns() for tracking tasks' runtime
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
 kernel/sched/sched.h                     | 24 +++++++-
 tools/sched_ext/include/scx/common.bpf.h |  1 +
 tools/sched_ext/include/scx/compat.bpf.h |  5 ++
 tools/sched_ext/scx_central.bpf.c        |  4 +-
 tools/sched_ext/scx_flatcg.bpf.c         |  2 +-
 7 files changed, 110 insertions(+), 6 deletions(-)

-- 
2.47.1


