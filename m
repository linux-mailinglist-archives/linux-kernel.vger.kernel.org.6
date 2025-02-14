Return-Path: <linux-kernel+bounces-515383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A93F4A3642E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D97B188D2B7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20A8267B81;
	Fri, 14 Feb 2025 17:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsw7BtbD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591B12676F5
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553285; cv=none; b=L9L85Vmx9zBe3SqA/XVxlydS/SU14UnpCMstftEvrtn2Phn835TnJwkvh6pgqX1g/T01aVtrEWu0JglupC3yqYezI3Q51v6x5TnLajLbnNaq31T2VMid8bF25NWrmc8973Ao7jBXUe9IkBhqrg42FjIbP8nrNaOc3GXU1DuO+TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553285; c=relaxed/simple;
	bh=VCSMWeZ5ubkR7/YoAU13MVMrPXgbHa6YakFHLZU7G/E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cOqxCrpHySJxVsEm10xBZGNfZPpv13XXxpM7R+W5b0xWlT3JUUEQTbb7hMDApj+5ndYi5zsEPgiP0xoyu7vBhrovXIr2sHZJ4iL4OAr8N/2BOlZS/V7sSMvKSWkHJolzfEH/65rma30MWoF6h/9Tg3A5UDKcCtUq+OVTDEW21Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsw7BtbD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5253C4CED1;
	Fri, 14 Feb 2025 17:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739553284;
	bh=VCSMWeZ5ubkR7/YoAU13MVMrPXgbHa6YakFHLZU7G/E=;
	h=Date:From:To:Cc:Subject:From;
	b=hsw7BtbDGp3WmtTyK5aQE8AUATia4HTQhPPIzqSKgBZdYp5xAVwx9CC/jf6Zpz/aS
	 TeeImij2NQ1LTV4I5gAytpHMAi8g9GmTV8LJuRjgWPCbyPkMK5NA2z5GQUz1ChmBif
	 D3gkB+Oum5tZpDQaSnfnaC4mllK9FKC57N4AoXS/vACvKNymeyYCj//vzC0h6Nr58H
	 35PE8Cm55yi3omaU5TwLxrmK3S0sdRJHmQday8HbXvYI7BsMafXxvoiwJ9onKeKtkj
	 38E+DbdP/pWtyAn+xu8ajvoloPC5CLq1rAdZDmB2Z2LKp2p1KU1Z99ggCeK77gldDa
	 bw3spRcB6yrOQ==
Date: Fri, 14 Feb 2025 07:14:43 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Subject: [GIT PULL] sched_ext: Fixes for v6.14-rc2
Message-ID: <Z696A62FFj_UkApm@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit ab18b8fff124c9b76ea12692571ca822dcd92854:

  Merge tag 'auxdisplay-v6.14-1' of git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-auxdisplay (2025-01-24 08:03:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.14-rc2-fixes

for you to fetch changes up to f5717c93a1b999970f3a64d771a1a9ee68cc37d0:

  sched_ext: Use SCX_CALL_OP_TASK in task_tick_scx (2025-02-13 06:57:33 -1000)

----------------------------------------------------------------
sched_ext: Fixes for v6.14-rc2

- Fix lock imbalance in a corner case of dispatch_to_local_dsq().

- Migration disabled tasks were confusing some BPF schedulers and its
  handling had a bug. Fix it and simplify the default behavior by
  dispatching them automatically.

- ops.tick(), ops.disable() and ops.exit_task() were incorrectly disallowing
  kfuncs that require the task argument to be the rq operation is currently
  operating on and thus is rq-locked. Allow them.

- Fix autogroup migration handling bug which was occasionally triggering a
  warning in the cgroup migration path.

- tools/sched_ext, selftest and other misc updates.

----------------------------------------------------------------
Andrea Righi (5):
      sched_ext: Include task weight in the error state dump
      selftests/sched_ext: Fix enum resolution
      tools/sched_ext: Add helper to check task migration state
      sched_ext: selftests/dsp_local_on: Fix selftest on UP systems
      sched_ext: Fix lock imbalance in dispatch_to_local_dsq()

Atul Kumar Pant (1):
      sched_ext: Fixes typos in comments

Changwoo Min (1):
      sched_ext: Fix incorrect time delta calculation in time_delta()

Chuyi Zhou (2):
      sched_ext: Fix the incorrect bpf_list kfunc API in common.bpf.h.
      sched_ext: Use SCX_CALL_OP_TASK in task_tick_scx

Devaansh Kumar (1):
      sched_ext: selftests: Fix grammar in tests description

Tejun Heo (5):
      sched_ext: selftests/dsp_local_on: Fix sporadic failures
      sched_ext: Fix incorrect autogroup migration detection
      sched_ext: Implement auto local dispatching of migration disabled tasks
      sched_ext: Fix migration disabled handling in targeted dispatches
      sched_ext: Fix incorrect assumption about migration disabled tasks in task_can_run_on_remote_rq()

 kernel/sched/autogroup.c                           |   4 +-
 kernel/sched/core.c                                |   7 +-
 kernel/sched/ext.c                                 | 113 ++++++++++++++-------
 kernel/sched/ext.h                                 |   4 +-
 kernel/sched/sched.h                               |   2 +-
 tools/sched_ext/include/scx/common.bpf.h           |  25 ++++-
 tools/testing/selftests/sched_ext/create_dsq.c     |  10 +-
 .../selftests/sched_ext/ddsp_bogus_dsq_fail.c      |   7 +-
 .../selftests/sched_ext/ddsp_vtimelocal_fail.c     |   7 +-
 .../testing/selftests/sched_ext/dsp_local_on.bpf.c |   2 +-
 tools/testing/selftests/sched_ext/dsp_local_on.c   |   1 +
 .../selftests/sched_ext/enq_last_no_enq_fails.c    |  10 +-
 .../selftests/sched_ext/enq_select_cpu_fails.c     |  10 +-
 tools/testing/selftests/sched_ext/exit.c           |   1 +
 tools/testing/selftests/sched_ext/hotplug.c        |   6 +-
 .../selftests/sched_ext/init_enable_count.c        |  27 ++---
 tools/testing/selftests/sched_ext/maximal.c        |   7 +-
 tools/testing/selftests/sched_ext/maybe_null.c     |   2 +-
 tools/testing/selftests/sched_ext/minimal.c        |  10 +-
 tools/testing/selftests/sched_ext/prog_run.c       |  10 +-
 tools/testing/selftests/sched_ext/reload_loop.c    |   9 +-
 tools/testing/selftests/sched_ext/select_cpu_dfl.c |   7 +-
 .../sched_ext/select_cpu_dfl_nodispatch.c          |   7 +-
 .../selftests/sched_ext/select_cpu_dispatch.c      |   7 +-
 .../sched_ext/select_cpu_dispatch_bad_dsq.c        |   7 +-
 .../sched_ext/select_cpu_dispatch_dbl_dsp.c        |   7 +-
 .../testing/selftests/sched_ext/select_cpu_vtime.c |   7 +-
 27 files changed, 198 insertions(+), 118 deletions(-)

-- 
tejun

