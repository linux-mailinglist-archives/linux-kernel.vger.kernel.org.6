Return-Path: <linux-kernel+bounces-522550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B563A3CBB5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E1D03B66FD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC2E2580F0;
	Wed, 19 Feb 2025 21:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gMLSrrD0"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7091424394C
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 21:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740001455; cv=none; b=rtp3xKsRekij9CTXzkZzi5+sHcJYodAIYUy2r7jCHNJ/jJxNfJeXYuyCIe74WTimRcoa2OAwDN6tNdBOgY1DTlMtaleIw1PiEbTgKekGWjFFZYzs7pwZ97W39MQBlx8mqJu7iDMkZW7D4s2ZjJgHy12JDBm28HNAaiqB45M/IXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740001455; c=relaxed/simple;
	bh=CTguHI9ra+AVpeiViEJMVcn8TOZbCheJ7ifbmczf1sE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AQUZh1AGSwzG4zvCafO1o2PNhEfxoE4tHCe5wYpgRDIzp7V6zE4u2h4o5O8zOgohJuH+oBH2hlCQZLnc7derlMlIHbvvUZQ7wUIin5yi92BCAULmPbNVeUteU3c2PBzrCroqhg8gN9Yoz4A0LmoeyWAyyIrmfGieTUwZ3JfqBEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gMLSrrD0; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc5888c192so513039a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 13:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740001454; x=1740606254; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H9Jer7zFjUDPh822Asgplz1kcj6Jbt7KPnFYJhaZSsc=;
        b=gMLSrrD0ReyHJ2CLEQkMNZWGRidxkRNBPaK2OVs1nmQcUaSAu/oMAMWV56zcmMRkHn
         s7qmrZcBCEEDSEXqcLGlGzG8KSMbrp+ruLH3dgIBzZPZjTVmWlbSl0BTUayIiYFvGsOE
         KB6oTI+X/6N8o+VXjKHUAtkGV8yxKT0ku6feXQyA2Gl2FLA9RCmeIrR/xTizK3MI0xv7
         qDdJD0RVGjb0Khx8O6T3zxLDL6m0nyxwCpUXvawPWDtMqtA7MQd1tL0tBhjCM8EO5p0W
         OzzclDoTMNQIxy/AtLCRoa3AaLZL642RtQuZM7T7kr2V9zXmEfuVreUtmJNSRWl/XmFU
         2Iow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740001454; x=1740606254;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H9Jer7zFjUDPh822Asgplz1kcj6Jbt7KPnFYJhaZSsc=;
        b=wMvN2sIZ3Cvak9kzp6WWwoHQ00TNZLdqwqEeW4tKiW4Psnzj49bvYFMOZC5SK4eg7G
         UP9p/Zx00DIXb+B3NN3zNgNVdiqViBwOTQE+rTT8ectrihLmhqXHEJNxzpBEEVIwOXjZ
         jT4ICp9ByEQuUCce6ipUkki9RYKghZIpDwy1NW545MIGU1y65TvfKW/B9Fydj6Ye9UpM
         kSra+U1fpCgOukEQsbQzpu5gO1uv/jDjyosoVG6BQ7RUiLc6JzCHobPKLbSSEcVacy9H
         oKTIcXh0r+PIbhORVHB4LdGDSxCDLuV0oWZkFIwv/9sraGyygTB6QLPCP4feOtF/9hLP
         H5uQ==
X-Gm-Message-State: AOJu0YzZ0AWrOnFqqMJF6nocRn4lHUbzVb5aw0qwscqVP5FviszNuk2K
	F3+vLor44KtLhrGlW/kWDmdOp1aIN2qREzIdieZdGQU+R/5brUCvIyG4QQawR+VSBYOkA2n9o/S
	MnBC0NoGSKqlaLJ08cnD38Ofn14PqvgwVLITJds/i4LS3ZGRY2/fH3kW/Z5AYP8T9VxCfcMVVkR
	V5HE/fVC7FsX0DaH6FrpsGIA8x+R5RqXoV/v7JQqJb
X-Google-Smtp-Source: AGHT+IHX5qUfJaeakQrn3oXg8HX3xosiOB+02t7Xb8qpc65w1pTX+0PNjU+WzpQgPNL3xlQlXCZYy1OCKTA=
X-Received: from pfay10.prod.google.com ([2002:a05:6a00:180a:b0:730:7bad:2008])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1acb:b0:72a:bcc2:eefb
 with SMTP id d2e1a72fcca58-7329de4ee2bmr7801608b3a.2.1740001453578; Wed, 19
 Feb 2025 13:44:13 -0800 (PST)
Date: Wed, 19 Feb 2025 13:39:59 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250219214400.3317548-1-ctshao@google.com>
Subject: [PATCH v6 0/4] Tracing contention lock owner call stack
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, nick.forrington@arm.com, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For perf lock contention, the current owner tracking (-o option) only
works with per-thread mode (-t option). Enabling call stack mode for
owner can be useful for diagnosing why a system running slow in
lock contention.

Example output:
  $ sudo ~/linux/tools/perf/perf lock con -abvo -Y mutex -E16 perf bench sched pipe
   ...
   contended   total wait     max wait     avg wait         type   caller

         171      1.55 ms     20.26 us      9.06 us        mutex   pipe_read+0x57
                          0xffffffffac6318e7  pipe_read+0x57
                          0xffffffffac623862  vfs_read+0x332
                          0xffffffffac62434b  ksys_read+0xbb
                          0xfffffffface604b2  do_syscall_64+0x82
                          0xffffffffad00012f  entry_SYSCALL_64_after_hwframe+0x76
          36    193.71 us     15.27 us      5.38 us        mutex   pipe_write+0x50
                          0xffffffffac631ee0  pipe_write+0x50
                          0xffffffffac6241db  vfs_write+0x3bb
                          0xffffffffac6244ab  ksys_write+0xbb
                          0xfffffffface604b2  do_syscall_64+0x82
                          0xffffffffad00012f  entry_SYSCALL_64_after_hwframe+0x76
           4     51.22 us     16.47 us     12.80 us        mutex   do_epoll_wait+0x24d
                          0xffffffffac691f0d  do_epoll_wait+0x24d
                          0xffffffffac69249b  do_epoll_pwait.part.0+0xb
                          0xffffffffac693ba5  __x64_sys_epoll_pwait+0x95
                          0xfffffffface604b2  do_syscall_64+0x82
                          0xffffffffad00012f  entry_SYSCALL_64_after_hwframe+0x76
           2     20.88 us     11.95 us     10.44 us        mutex   do_epoll_wait+0x24d
                          0xffffffffac691f0d  do_epoll_wait+0x24d
                          0xffffffffac693943  __x64_sys_epoll_wait+0x73
                          0xfffffffface604b2  do_syscall_64+0x82
                          0xffffffffad00012f  entry_SYSCALL_64_after_hwframe+0x76
           1      7.33 us      7.33 us      7.33 us        mutex   do_epoll_ctl+0x6c1
                          0xffffffffac692e01  do_epoll_ctl+0x6c1
                          0xffffffffac6937e0  __x64_sys_epoll_ctl+0x70
                          0xfffffffface604b2  do_syscall_64+0x82
                          0xffffffffad00012f  entry_SYSCALL_64_after_hwframe+0x76
           1      6.64 us      6.64 us      6.64 us        mutex   do_epoll_ctl+0x3d4
                          0xffffffffac692b14  do_epoll_ctl+0x3d4
                          0xffffffffac6937e0  __x64_sys_epoll_ctl+0x70
                          0xfffffffface604b2  do_syscall_64+0x82
                          0xffffffffad00012f  entry_SYSCALL_64_after_hwframe+0x76

  === owner stack trace ===

           3     31.24 us     15.27 us     10.41 us        mutex   pipe_read+0x348
                          0xffffffffac631bd8  pipe_read+0x348
                          0xffffffffac623862  vfs_read+0x332
                          0xffffffffac62434b  ksys_read+0xbb
                          0xfffffffface604b2  do_syscall_64+0x82
                          0xffffffffad00012f  entry_SYSCALL_64_after_hwframe+0x76
  ...

v6:
  Free allocated memory in error patch.
  Add description in man page.

v5: lore.kernel.org/20250212222859.2086080-1-ctshao@google.com
  Move duplicated code into function.
  Remove code to retrieve undesired callstack at the end of `contention_end()`.
  Other minor fix based on Namhyung's review.

v4: lore.kernel.org/20250130052510.860318-1-ctshao@google.com
  Use `__sync_fetch_and_add()` to generate owner stackid automatically.
  Use `__sync_fetch_and_add(..., -1)` to workaround compiler error from
    `__sync_fetch_and_sub()`
  Remove unnecessary include headers.
  Dedicate on C-style comment.
  Other minor fix based on Namhyung's review.

v3: lore.kernel.org/20250129001905.619859-1-ctshao@google.com
  Rename/shorten multiple variables.
  Implement owner stackid.
  Add description for lock function return code in `contention_end()`.
  Other minor fix based on Namhyung's review.

v2: lore.kernel.org/20250113052220.2105645-1-ctshao@google.com
  Fix logic deficit in v1 patch 2/4.

v1: lore.kernel.org/20250110051346.1507178-1-ctshao@google.com

Chun-Tse Shao (4):
  perf lock: Add bpf maps for owner stack tracing
  perf lock: Retrieve owner callstack in bpf program
  perf lock: Make rb_tree helper functions generic
  perf lock: Report owner stack in usermode

 tools/perf/Documentation/perf-lock.txt        |   6 +-
 tools/perf/builtin-lock.c                     |  56 +++-
 tools/perf/util/bpf_lock_contention.c         |  72 ++++-
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 251 +++++++++++++++++-
 tools/perf/util/bpf_skel/lock_data.h          |   7 +
 tools/perf/util/lock-contention.h             |   7 +
 6 files changed, 372 insertions(+), 27 deletions(-)

--
2.48.1.601.g30ceb7b040-goog


