Return-Path: <linux-kernel+bounces-308654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C64BD965FF6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EB001F214FF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC99A199FAC;
	Fri, 30 Aug 2024 11:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGYw2It3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41CC199FB1
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 11:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725015863; cv=none; b=rfOwpqmyJ0kmUQP/ybAP9/QaRFvpyEyDpfOuCltLIL32IFHVUmx5bWc26owfJtCltXZ0ApmZ67x150HKUFIuxfbs6yemYydqmH3t2PIxiz0lAkv+b1HgwZizflSKzM1sTONicw0zJ4ARV4cYfjKmBQFWFdbrzpEtr59Ju5Hi4OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725015863; c=relaxed/simple;
	bh=kakPEz8Ef8v8t+WPNdzapM37p3OjYXHmUl3Nyj1uvJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r3bpy1QmgWABxtCUGtNXtdDOTp5w67mSJ0j/pmyAxKQAP2oouHy0+2Ofx1E848kXYIILlQXBEG5yVlbWavDWt4OxSLs4A9GJATrjb6i1fnLo80rVjMMCjhC6UByWKhLCYwHv+t9FNDUiHq/HeXdMmd5LThz8RnwDFhcF61Fncg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGYw2It3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A922C4CEC4;
	Fri, 30 Aug 2024 11:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725015862;
	bh=kakPEz8Ef8v8t+WPNdzapM37p3OjYXHmUl3Nyj1uvJA=;
	h=From:To:Cc:Subject:Date:From;
	b=TGYw2It3RVjbdbb4h2Q+Ns0is5TCQeiLkGLbsM1y6OkrhegvEI72T1XA+Wj7RVgFU
	 fSia/tEEiRcDxjDSy1+VqwXaE+2nY90+OynVg6UMXjZ+UA3WB5a0EPd8ezm7p85M04
	 a4GZ+KSiLXrTq6nRKBcLj0s80q+X0QDI0HqjxYCEYGnuRvdaSeKTh1bgtoYOVtIqT1
	 Fnhu+De/HxFvGzpupCx3yOm/044hynu++MtArrt+pafBQnD+oQ2h9K9vYa6GW3XL4C
	 6e1gdH6vgp/npRw1+iaCMQ7bVHa/ElL3Yqgx76t/EnA9BKU1FzB7dPU2wN+lcPltQ+
	 ECDD/UlKxJEdw==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET sched_ext/for-6.12] sched_ext: Implement scx_bpf_dispatch[_vtime]_from_dsq()
Date: Fri, 30 Aug 2024 01:03:44 -1000
Message-ID: <20240830110415.116090-1-tj@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

   sched_ext/for-6.12 bf934bed5e2f ("sched_ext: Add missing cfi stub for ops.tick")
 + two fix patches (http://lkml.kernel.org/r/ZtGkPKgoE5BeI7fN@slm.duckdns.org)

and is also available at:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-dispatch_from_dsq

This patchset contains the following patches:

 0001-sched_ext-Rename-scx_kfunc_set_sleepable-to-unlocked.patch
 0002-sched_ext-Refactor-consume_remote_task.patch
 0003-sched_ext-Make-find_dsq_for_dispatch-handle-SCX_DSQ_.patch
 0004-sched_ext-Make-dispatch_to_local_dsq-return-void.patch
 0005-sched_ext-Restructure-dispatch_to_local_dsq.patch
 0006-sched_ext-Reorder-args-for-consume_local-remote_task.patch
 0007-sched_ext-Move-sanity-check-and-dsq_mod_nr-into-task.patch
 0008-sched_ext-Move-consume_local_task-upward.patch
 0009-sched_ext-Replace-consume_local_task-with-move_local.patch
 0010-sched_ext-Implement-scx_bpf_dispatch-_vtime-_from_ds.patch
 0011-scx_qmap-Implement-highpri-boosting.patch

 0001-0009 are prep patches. The logic to bounce tasks across DSQs and CPUs
 is rather complicated due to synchronization. The prep patches do quite a
 bit of refactoring so that the helpers are more composable and can be used
 for the new kfuncs.

 0010 implements scx_bpf_dispatch[_vtime]_from_dsq().

 0011 adds demo usages to scx_qmap.

diffstat follows. Thanks.

 kernel/sched/ext.c                       |  592 ++++++++++++++++++++++++++++++++++++----------------------
 tools/sched_ext/include/scx/common.bpf.h |    8
 tools/sched_ext/scx_qmap.bpf.c           |  142 ++++++++++++-
 tools/sched_ext/scx_qmap.c               |   11 -
 4 files changed, 519 insertions(+), 234 deletions(-)

--
tejun

