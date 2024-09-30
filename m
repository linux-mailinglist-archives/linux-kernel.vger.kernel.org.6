Return-Path: <linux-kernel+bounces-344736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DCD98AD9E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4E211C2114E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 19:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F22719DF60;
	Mon, 30 Sep 2024 19:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRM1OHDF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF7719F413
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 19:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727726204; cv=none; b=pqs3hrJw+aceIVCV5S2/k7kGflXU57svgMB8qRRgG6EXxzBoaBvoCJNR+S1lPVOwFmil+hUNVugRImOqdz9Y5fZczVyEy0RTuGcm+anY3xRGGqVuEyvizlzFvyO6IVOBfRzAUC08ldBpzqlYLP02t9a13FVIgy87nYT6yHxwQRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727726204; c=relaxed/simple;
	bh=dSgA3s4FRg7X5+3zKSk1L+f/MKKIV6mZOmUvIOrBZ6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CZkjagQQyLIOPR9OPPNQJCHRc4QcVYBQU5M4vLFGkn6ojb+tIoxdD3RjlL9mv/vr8sLPOxK8QQwnr2d36dzNbq6iH8P2W0AS75bqHTkyVf8hZJ6Omb2o7R7xpWcdqi3rJWmc9AuH/yfDFNYQ0MX5K50QGZsOuKgzmQW9jL1pNMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRM1OHDF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64717C4CEC7;
	Mon, 30 Sep 2024 19:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727726203;
	bh=dSgA3s4FRg7X5+3zKSk1L+f/MKKIV6mZOmUvIOrBZ6Y=;
	h=Date:From:To:Cc:Subject:From;
	b=eRM1OHDFtHrEbadg16/rjlQm0gUdwUeYdBtpXvlnhL9JOfV4qYNXtevtPYN98Ui5g
	 J+k9UDXVLcZt+fEzCrU1cj++0jhDVMXOt5kf3hDbUsUGzYpmTnSjnsMd3/1gyxEP8J
	 PSd58r60PqQEitqeAFaYNGOIH4nVvblAca3pIm3nN0EmloQL02sM5JqgIPHAdCvDzb
	 vdMs4joSa8CnS8qcYq020MRFVKRelHFenST7QzFkaQV4geM1pSM2cM36nfqs5IpScV
	 aJfThcB3BEWMlLLZf/cQmSadepbuSo58StiWmiKs2QDd/KaASFtzzWMzNYTMy7cHpl
	 FY08wOTG32Z6g==
Date: Mon, 30 Sep 2024 09:56:42 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	sched-ext@meta.com
Subject: [GIT PULL] sched_ext: A second set of fixes for v6.12-rc1
Message-ID: <ZvsCeqjNGgqglWaD@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 68e5c7d4cefb66de3953a874e670ec8f1ce86a24:

  Merge tag 'kbuild-v6.12' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild (2024-09-24 13:02:06 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.12-rc1-fixes-1

for you to fetch changes up to 95b873693a0841e02b812e693296a884362fdd51:

  sched_ext: Remove redundant p->nr_cpus_allowed checker (2024-09-27 10:23:45 -1000)

----------------------------------------------------------------
sched_ext: A second set of fixes for v6.12-rc1

- When sched_ext is in bypass mode (e.g. while disabling the BPF scheduler),
  it was using one DSQ to implement global FIFO scheduling as all it has to
  do is guaranteeing reasonable forward progress. On multi-socket machines,
  this can lead to live-lock conditions under certain workloads. Fixed by
  splitting the queue used for FIFO scheduling per NUMA node. This required
  several preparation patches.

- Hotplug tests on powerpc could reliably trigger deadlock while enabling a
  BPF scheduler. This was caused by cpu_hotplug_lock nesting inside
  scx_fork_rwsem and then CPU hotplug path trying to fork a new thread while
  holding cpu_hotplug_lock. Fixed by restructuring locking in enable and
  disable paths so that the two locks are not coupled. This required several
  preparation patches which also fixed a couple other issues in the enable
  path.

- A build fix for !CONFIG_SMP.

- Userspace tooling sync and updates.

----------------------------------------------------------------
Tejun Heo (16):
      sched_ext: Build fix for !CONFIG_SMP
      sched_ext: Add __COMPAT helpers for features added during v6.12 devel cycle
      tools/sched_ext: Receive misc updates from SCX repo
      scx_flatcg: Use a user DSQ for fallback instead of SCX_DSQ_GLOBAL
      sched_ext: Allow only user DSQs for scx_bpf_consume(), scx_bpf_dsq_nr_queued() and bpf_iter_scx_dsq_new()
      sched_ext: Relocate find_user_dsq()
      sched_ext: Split the global DSQ per NUMA node
      sched_ext: Use shorter slice while bypassing
      sched_ext: Relocate check_hotplug_seq() call in scx_ops_enable()
      sched_ext: Remove SCX_OPS_PREPPING
      sched_ext: Initialize in bypass mode
      sched_ext: Fix SCX_TASK_INIT -> SCX_TASK_READY transitions in scx_ops_enable()
      sched_ext: Enable scx_ops_init_task() separately
      sched_ext: Add scx_cgroup_enabled to gate cgroup operations and fix scx_tg_online()
      sched_ext: Decouple locks in scx_ops_disable_workfn()
      sched_ext: Decouple locks in scx_ops_enable()

Zhang Qiao (1):
      sched_ext: Remove redundant p->nr_cpus_allowed checker

 kernel/sched/ext.c                           | 320 ++++++++++++++-------------
 tools/sched_ext/include/scx/common.bpf.h     |  15 ++
 tools/sched_ext/include/scx/compat.bpf.h     |  19 ++
 tools/sched_ext/include/scx/user_exit_info.h |   4 +
 tools/sched_ext/scx_flatcg.bpf.c             |  32 ++-
 tools/sched_ext/scx_qmap.bpf.c               |  12 +-
 6 files changed, 236 insertions(+), 166 deletions(-)

-- 
tejun

