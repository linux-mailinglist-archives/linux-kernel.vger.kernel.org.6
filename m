Return-Path: <linux-kernel+bounces-310304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6294A967971
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 18:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F2AE28119D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 16:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65570181CE1;
	Sun,  1 Sep 2024 16:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YervSnaf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC0D1C68C
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 16:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725209059; cv=none; b=C48+7DkIrjCe4zaT2rG2aG3G5WtzLSaL/jsTRU4jm32OAYjY2ZAwsUZklN5v5uXAKsucW8mj4sYVDlWC0J5hZ3/dBsGMW4ePt3emX4lHPITsoUfaeuesiOhif+IKYzeT/00sUaE/AWCCCFOVQUb5y/nA71HnjyINbaNOWie5lKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725209059; c=relaxed/simple;
	bh=jCaD4BYF6M+4Lo3R0hV4sxW4iO3MoXg/akwxDtMBt+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uIpROL6/M4T4KHASNX2Rb9YwQKZ51tlSL9O7Tmv0V5DRDVDj45tbdhplctEbNovYpLW+JSoN/qz/ezVsFRPdDRpW96d5m557nqLO4jZCDiJqE2SNEHWNNeJuI1WTdXBjKgAjwBhmlEmyfYShne1N/aKKLGs1OWQUdbJPgFFQaWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YervSnaf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A80C4CEC3;
	Sun,  1 Sep 2024 16:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725209059;
	bh=jCaD4BYF6M+4Lo3R0hV4sxW4iO3MoXg/akwxDtMBt+k=;
	h=From:To:Cc:Subject:Date:From;
	b=YervSnafyOJnDkzZN4y7b3gs3FfSZ48G5k1g6bUjCbeFCnqMqWCMN3CA327OTWEkS
	 o3Iyknt7+1VxEDPewqt62RQdTuK3XI+aVJcCbARwjUv+eZkV+XwyimPdvIhYqjJac3
	 vFR1VxRJ+/c/aqeID0Weljn63uf4sjNn44Ma5Pv6YHmOk3qcu1SXb44nw6+Ey6YDCS
	 JzVR7m9ShDmRg6DiotdI6kU1Ox3n5APVMnPs2XF6jLf1zwXy7Svd5k2wOBjblKqpOH
	 isZ8AUFllza8n8IuQNCMG2EHM69FxThhxS90Jv70nngWKazCafXhGfDh5pOG8JlAN3
	 YRk+JrCwcPi7A==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v2 sched_ext/for-6.12] sched_ext: Implement scx_bpf_dispatch[_vtime]_from_dsq()
Date: Sun,  1 Sep 2024 06:43:37 -1000
Message-ID: <20240901164417.779239-1-tj@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is v2. Changes from v1
(http://lkml.kernel.org/r/20240830110415.116090-1-tj@kernel.org) are:

- @slice and @vtime dropped from scx_bpf_dispatch[_vtime]_from_dsq() as
  scx_bpf_dispatch_vtime_from_dsq() was pushing past kfunc parameter count
  limit and often weren't needed anyway. Instead
  scx_bpf_dispatch_from_slice_set_{slice|vtime}() are added so that the
  parameters can be overridden when necessary.

- 0010-sched_ext-Compact-struct-bpf_iter_scx_dsq_kern.patch was added to
  enable the above.

- @task_rq renamed to @src_rq for consistency.

Once a task is put into a DSQ, the allowed operations are fairly limited.
Tasks in the built-in local and global DSQs are executed automatically and,
ignoring dequeue, there is only one way a task in a user DSQ can be
manipulated - scx_bpf_consume() moves the first task to the dispatching
local DSQ. This inflexibility sometimes gets in the way and is an area where
multiple feature requests have been made.

Implement scx_bpf_dispatch[_vtime]_from_dsq(), which can be called during
DSQ iteration and can move the task to any DSQ - local DSQs, global DSQ and
user DSQs. The kfuncs can be called from ops.dispatch() and any BPF context
which dosen't hold a rq lock including BPF timers and SYSCALL programs.

This patchset is on top of:

   sched_ext/for-6.12 62607d033bb8 ("sched_ext: Use sched_clock_cpu() instead of rq_clock_task() in touch_core_sched()")
 + bpf/master 2ad6d23f465a ("selftests/bpf: Do not update vmlinux.h unnecessarily")

and is also available at:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-dispatch_from_dsq-v2

This patchset contains the following patches:

 0001-sched_ext-Rename-scx_kfunc_set_sleepable-to-unlocked.patch
 0002-sched_ext-Refactor-consume_remote_task.patch
 0003-sched_ext-Make-find_dsq_for_dispatch-handle-SCX_DSQ_.patch
 0004-sched_ext-Fix-processs_ddsp_deferred_locals-by-unify.patch
 0005-sched_ext-Restructure-dispatch_to_local_dsq.patch
 0006-sched_ext-Reorder-args-for-consume_local-remote_task.patch
 0007-sched_ext-Move-sanity-check-and-dsq_mod_nr-into-task.patch
 0008-sched_ext-Move-consume_local_task-upward.patch
 0009-sched_ext-Replace-consume_local_task-with-move_local.patch
 0010-sched_ext-Compact-struct-bpf_iter_scx_dsq_kern.patch
 0011-sched_ext-Implement-scx_bpf_dispatch-_vtime-_from_ds.patch
 0012-scx_qmap-Implement-highpri-boosting.patch

 0001-0010 are prep patches. The logic to bounce tasks across DSQs and CPUs
 is rather complicated due to synchronization. The prep patches do quite a
 bit of refactoring so that the helpers are more composable and can be used
 for the new kfuncs.

 0011 implements scx_bpf_dispatch[_vtime]_from_dsq().

 0012 adds demo usages to scx_qmap.

diffstat follows. Thanks.

 include/linux/sched/ext.h                |   10
 kernel/sched/ext.c                       |  667 ++++++++++++++++++++++++++++++++++-------------------
 tools/sched_ext/include/scx/common.bpf.h |   10
 tools/sched_ext/scx_qmap.bpf.c           |  133 +++++++++-
 tools/sched_ext/scx_qmap.c               |   11
 5 files changed, 585 insertions(+), 246 deletions(-)

--
tejun

