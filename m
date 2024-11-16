Return-Path: <linux-kernel+bounces-411794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB7A9CFFB9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 17:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D3DAB224C7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 16:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A3F2A8E5;
	Sat, 16 Nov 2024 16:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="An9v0oGm"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F4A372
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 16:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731772907; cv=none; b=EWyLmS3+1eklTH6hoYG/KiNeU7ItCBno+DZP7U2iTHhRihoPjpRGFUXBMWPbGX5JQ5GFAUIEC/hPrkf6OcM3towFGTeWjxPX5/J7upnNBE87FyelDSYAWHNf5UgcTv44pcGuCO4IsOFLdjq8Xgs2hEX41FB7dmj7mpLnlWuRZXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731772907; c=relaxed/simple;
	bh=bNduWXazk9MwSgNBNyb286FLDnXtkFNmv7H07c/a9ns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iZRl+/1tPR1WLcT82wNDzsXI2/5ej7Ws/OsjARdS3vw/tkAGBhz20RBKWYtaowNFbrO2aCD3fP3jCiT/LOLrfln+PqVxJ+S0PeuBQpPa5q4RhZ0x0LwJi2jgOrA8icB28gNaypNaeAFE7lVXpuV7s7bRg7dlEAX8+G8YQRga87o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=An9v0oGm; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e4e481692so579837b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 08:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731772905; x=1732377705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6+Dm04F/+RO0VaxEI3Tcn9ob9XAwIZwxknNsrEtEodQ=;
        b=An9v0oGm2CKSCwUxhrYu6ly8SdywGrXPRA6fxdynUDCc0KIDFPWd/8d3kxNR0VI345
         9iUIuKFQlSsaFZAjfSKYoPN9XonlsmGOnmBqjBAEoN357oTCTrDfOEuI4m4A+FTLLFX/
         lg5pQ2fPxrXfHETyMtjUJsvLbSvKpcmdkR73SOk8causFwGvlyXA9Up+JI4lON8IGib2
         XvXfWQt5NFlXH8z2Onz2hCFtfNlyxFVTGIkgcEZ7SX3FALOU8TqvmhDEwz86JZaLI6Qs
         IOexuOYTb1CinU142579pbo/wpiqn3kLXr4xLxG9KC25n9YfyVMvM9plCYC1O2p37cJv
         C5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731772905; x=1732377705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6+Dm04F/+RO0VaxEI3Tcn9ob9XAwIZwxknNsrEtEodQ=;
        b=mUD+iGbOm1+QEvR4URdF6X1Wzh4tU9xnuV56k6T+NX4TxdBVh+jXvFC601R58pSwvd
         pIOMt4GLmreyMirhI1VzP3V5ICyazbnhbwxA3W6HdxA/Br8fK9JAvO1xHIVChvz4Gykq
         IjOlTdss2HoDcAPS8FuCc2grlkPLmgQSl+ST4pwtWtpLOJtzJStGMSiUSJnJEMuN1wVE
         uxzVEq4/AAyGMqGV6wk4cSdY8KyfeyVoBD9O2A6C+VZ6wCUdZK+uL+cXXsXEr8H2pc6l
         Zhb3n3NFlBIF0l2BBzMBNlieeEiYiN6FG2xXvT/hizQ93RCtnfpqE2hJRBzGtTRaESlt
         YpsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWm9GhNhGoMLW4Qi/6UgakDWYHbe+0VzxVp7woUovLoNCGTnH8BKQYnX6pvhoJMPgjKqT/0U2k1vsEEck4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwURXyxRi0CZJUMXkOh2M6NCPqsyu7evW31OtzhY9bcKH66Wx6k
	816zE3n7BiEPxg0uje+K/RKJCyeWp/iBuNAI3MdZJPFCSsz7xC/K
X-Google-Smtp-Source: AGHT+IGq+TaLzRd5b1H0KShlQKrQztqgOXx02j/Qozw3iIya/u0cIEaNxgIvtKVnBAknvFErCr6Ipg==
X-Received: by 2002:a05:6a00:a8f:b0:720:36c5:b53b with SMTP id d2e1a72fcca58-72476f7d471mr8802437b3a.17.1731772905056;
        Sat, 16 Nov 2024 08:01:45 -0800 (PST)
Received: from localhost ([58.29.143.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724770ee999sm3234082b3a.3.2024.11.16.08.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 08:01:44 -0800 (PST)
From: Changwoo Min <multics69@gmail.com>
X-Google-Original-From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com
Cc: mingo@redhat.com,
	peterz@infradead.org,
	changwoo@igalia.com,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] sched_ext: Support high-performance monotonically non-decreasing clock
Date: Sun, 17 Nov 2024 01:01:21 +0900
Message-ID: <20241116160126.29454-1-changwoo@igalia.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many BPF schedulers (such as scx_lavd, scx_rusty, scx_bpfland)
frequently call bpf_ktime_get_ns() for tracking tasks' runtime
properties. If supported, bpf_ktime_get_ns() eventually reads a hardware
timestamp counter (TSC). However, reading a hardware TSC is not
performant in some hardware platforms, degrading IPC.

This patchset addresses the performance problem of reading hardware TSC
by leveraging the rq clock in the scheduler core, introducing a
scx_bpf_clock_get_ns() function for BPF schedulers. Whenever the rq clock
is fresh enough, scx_bpf_clock_get_ns() provides the rq clock, which is
already updated by the scheduler core (update_rq_clock), so it can reduce
the reading TSC calls.

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

Changwoo Min (5):
  sched_ext: Implement scx_rq_clock_update/stale()
  sched_ext: Manage the validity of scx_rq_clock
  sched_ext: Implement scx_bpf_clock_get_ns()
  sched_ext: Add scx_bpf_clock_get_ns() for BPF scheduler
  sched_ext: Replace bpf_ktime_get_ns() to scx_bpf_clock_get_ns()

 kernel/sched/core.c                      |  6 +-
 kernel/sched/ext.c                       | 74 ++++++++++++++++++++++++
 kernel/sched/sched.h                     | 22 ++++++-
 tools/sched_ext/include/scx/common.bpf.h |  1 +
 tools/sched_ext/include/scx/compat.bpf.h |  5 ++
 tools/sched_ext/scx_central.bpf.c        |  4 +-
 tools/sched_ext/scx_flatcg.bpf.c         |  2 +-
 7 files changed, 109 insertions(+), 5 deletions(-)

-- 
2.47.0


