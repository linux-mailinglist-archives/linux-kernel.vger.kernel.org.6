Return-Path: <linux-kernel+bounces-387981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4997F9B58BA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 01:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6B091F233E7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080201B59A;
	Wed, 30 Oct 2024 00:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eq/eQo3s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656E9125DF
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 00:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730248829; cv=none; b=uoELqnZiLd6zrJ4Yz64NCD6ngvWLXLN6ggUw57uLomzg0B3lQKFToiiRJ4A+0k6+QIqn2w+CYAyMM7Ig7ob/ey/0RtbsV7FKCVJ2xaZqh/JSpCoVp+WeCUk81sURMSwuCAJlqBKKj5GR48aJcnl3aid5898eo0ipNjiyrGoc++k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730248829; c=relaxed/simple;
	bh=bwOY5EPBqgZhCbgW0TUY1MLQLrW+KSYA3tjopKzOXIU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JGtWTdQx8mqd+CSfOfMyFfIYsTDWLvOuiiNPG92ctWKVV/AnQdFyVUXFB0WyWcaNe4iR016nm6gUGPRBv0SeKTb5yCxmrlGGjL49TwrHXIO3jtjQn7+JttjwqWbDtlznXUdmegP8ZdH/+x1exRSPk+lqSdO+laOLP11XNmxvLjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eq/eQo3s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFDCC4CECD;
	Wed, 30 Oct 2024 00:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730248829;
	bh=bwOY5EPBqgZhCbgW0TUY1MLQLrW+KSYA3tjopKzOXIU=;
	h=Date:From:To:Cc:Subject:From;
	b=eq/eQo3s6wkd/jGHBo48UMvN77BWW2L7eZc2plNmChMwL9G9lvBP96eC0MdE3nTLC
	 sXbKwX9qtHzr2fum3j/ZBeAqBRdgcYQ8qjMGgoqA/MNO0hUlF5CPQlCHQPdX3W/FtO
	 G/A6PpvUw0pseGvFHYQUzUK+ZRhPyYVn86VHBrB1h/KFrhICqWyNPtvksZUqM2LlaK
	 BMwRiFs5hH9tqu2LMF5p50tiQlCU15OaWLtfOiLie559RzS2Q/tu5zPMY6aBaktx/s
	 T2OpG3gOczCbdP9biWW6sMJVXLs7b7k/Wo/oZ/S1xBt96F7lT0lp5EXj7ujBzERqZQ
	 Ebw1XmFOKfhOw==
Date: Tue, 29 Oct 2024 14:40:28 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	sched-ext@meta.com
Subject: [GIT PULL] sched_ext: Fixes for v6.12-rc5
Message-ID: <ZyGAfCUwdSJysoB3@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 60e339be100d7d49e13616bd8b4b1b864f0a64a0:

  sched_ext: Remove unnecessary cpu_relax() (2024-10-14 13:23:49 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.12-rc5-fixes

for you to fetch changes up to c31f2ee5cd7da3086eb4fbeef9f3afdc8e01d36b:

  sched_ext: Fix enq_last_no_enq_fails selftest (2024-10-25 12:20:29 -1000)

----------------------------------------------------------------
sched_ext: Fixes for v6.12-rc5

- Instances of scx_ops_bypass() could race each other leading to
  misbehavior. Fix by protecting the operation with a spinlock.

- selftest and userspace header fixes.

----------------------------------------------------------------
David Vernet (2):
      scx: Fix exit selftest to use custom DSQ
      scx: Fix raciness in scx_ops_bypass()

Ihor Solodrai (1):
      selftests/sched_ext: add order-only dependency of runner.o on BPFOBJ

Tejun Heo (2):
      sched_ext: Make cast_mask() inline
      sched_ext: Fix enq_last_no_enq_fails selftest

Vishal Chourasia (1):
      sched_ext: Fix function pointer type mismatches in BPF selftests

 kernel/sched/ext.c                                 | 29 ++++++-----
 tools/sched_ext/include/scx/common.bpf.h           |  2 +-
 tools/testing/selftests/sched_ext/Makefile         |  2 +-
 tools/testing/selftests/sched_ext/create_dsq.bpf.c |  6 +--
 .../selftests/sched_ext/ddsp_bogus_dsq_fail.bpf.c  |  4 +-
 .../selftests/sched_ext/ddsp_vtimelocal_fail.bpf.c |  4 +-
 .../testing/selftests/sched_ext/dsp_local_on.bpf.c |  8 +--
 .../sched_ext/enq_last_no_enq_fails.bpf.c          |  8 +++
 .../selftests/sched_ext/enq_last_no_enq_fails.c    | 10 ++--
 .../selftests/sched_ext/enq_select_cpu_fails.bpf.c |  4 +-
 tools/testing/selftests/sched_ext/exit.bpf.c       | 22 ++++----
 tools/testing/selftests/sched_ext/hotplug.bpf.c    |  8 +--
 .../selftests/sched_ext/init_enable_count.bpf.c    |  8 +--
 tools/testing/selftests/sched_ext/maximal.bpf.c    | 58 +++++++++++-----------
 tools/testing/selftests/sched_ext/maybe_null.bpf.c |  6 +--
 .../selftests/sched_ext/maybe_null_fail_dsp.bpf.c  |  4 +-
 .../selftests/sched_ext/maybe_null_fail_yld.bpf.c  |  4 +-
 tools/testing/selftests/sched_ext/prog_run.bpf.c   |  2 +-
 .../selftests/sched_ext/select_cpu_dfl.bpf.c       |  2 +-
 .../sched_ext/select_cpu_dfl_nodispatch.bpf.c      |  6 +--
 .../selftests/sched_ext/select_cpu_dispatch.bpf.c  |  2 +-
 .../sched_ext/select_cpu_dispatch_bad_dsq.bpf.c    |  4 +-
 .../sched_ext/select_cpu_dispatch_dbl_dsp.bpf.c    |  4 +-
 .../selftests/sched_ext/select_cpu_vtime.bpf.c     | 12 ++---
 24 files changed, 119 insertions(+), 100 deletions(-)

-- 
tejun

