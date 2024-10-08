Return-Path: <linux-kernel+bounces-355837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D24C09957C9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 21:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88CC61F24E2B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 19:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A9A213EEA;
	Tue,  8 Oct 2024 19:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N19JJlND"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A72E213EDF
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 19:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728416539; cv=none; b=F73MAEyABt6Bjc+Rb1YDJViuHtIdLPJxh+MnOoswjTapsquAw7vdLmAleE1x6AZxEW0ehJ+2aPmByYWcfBBhHSLBlHnqwIHCp1RvjNelYBA2VCRCJBu1yffJj2EEYN7EddTvIqMTz0mR48zCM2AWSV/+QsLb3i83lKOokDPap1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728416539; c=relaxed/simple;
	bh=QBxXkPAxgYlOWFZROC4O+JdUqTQA0L2XZo0nH/QH6uw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=If2koYib2mcvmCN3LVPatQYqxThRTXNcCQ1Yy8pPj3L20nQfELNy8JTSsevEYcCQnoz5GMSG6af5nc4NMBHzpFn4KBkuZRwD403uwYxYWLQ2Ke9k8lz9zUp4Dx053hEMyHB/St5UnZRiuvZEMtk6iGl7vsAwArC4Cn5m3e8MxSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N19JJlND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45AFC4CEC7;
	Tue,  8 Oct 2024 19:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728416538;
	bh=QBxXkPAxgYlOWFZROC4O+JdUqTQA0L2XZo0nH/QH6uw=;
	h=Date:From:To:Cc:Subject:From;
	b=N19JJlNDcapryMvVg08suzFOhPGmduTIaCW9XJSRtMG8W4MeOPXaKFOBReoTHGPYh
	 W8bMnP9jnyr1K9/ecxJghasoILrakXRt5YkPJ690IB7M/dxm/1WplMutt+kDkdi9g+
	 IttwK8S9XOVJOcEXuH45bSaNUMbbTUHDuHIiAGxvIz50h2qrblRWttrq1dzzzikhjN
	 BihiGWFi5xEQbxTQx+SjEdfWbU3N2iBN6XWn9HySnFizQRaFOBaDQ9OXvbP/zUe8Vg
	 zSsW5cZ0r7aSsFOJrJ5jTTCdJo495ZRzhEMXqjVBDfb9OV6zgoYOITove68jRMfZhR
	 mUtDyEJ7gJnJA==
Date: Tue, 8 Oct 2024 09:42:16 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	sched-ext@meta.com, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Subject: [GIT PULL] sched_ext: Fixes for v6.12-rc2
Message-ID: <ZwWLGKG4fsUYQyub@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 95b873693a0841e02b812e693296a884362fdd51:

  sched_ext: Remove redundant p->nr_cpus_allowed checker (2024-09-27 10:23:45 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.12-rc2-fixes

for you to fetch changes up to e0ed52154e866a1e9e9b97ded50b164698f0a222:

  sched_ext: Documentation: Update instructions for running example schedulers (2024-10-08 08:49:18 -1000)

----------------------------------------------------------------
sched_ext: Fixes for v6.12-rc2

- ops.enqueue() didn't have a way to tell whether select_task_rq_scx() and
  thus ops.select() were skipped. Some schedulers were incorrectly using
  SCX_ENQ_WAKEUP. Add SCX_ENQ_CPU_SELECTED and fix scx_qmap using it.

- Remove a spurious WARN_ON_ONCE() in scx_cgroup_exit().

- Fix error information clobbering during load.

- Add missing __weak markers to BPF helper declarations.

- Doc update.

----------------------------------------------------------------
Devaansh-Kumar (1):
      sched_ext: Documentation: Update instructions for running example schedulers

Tejun Heo (5):
      sched_ext: Improve error reporting during loading
      sched_ext: scx_cgroup_exit() may be called without successful scx_cgroup_init()
      sched/core: Make select_task_rq() take the pointer to wake_flags instead of value
      sched/core: Add ENQUEUE_RQ_SELECTED to indicate whether ->select_task_rq() was called
      sched_ext, scx_qmap: Add and use SCX_ENQ_CPU_SELECTED

Vishal Chourasia (1):
      sched_ext: Add __weak markers to BPF helper function decalarations

 Documentation/scheduler/sched-ext.rst    |  2 +-
 kernel/sched/core.c                      | 21 ++++++++++++++-------
 kernel/sched/ext.c                       | 32 ++++++++++++++++++++------------
 kernel/sched/sched.h                     |  3 +++
 tools/sched_ext/include/scx/common.bpf.h |  6 +++---
 tools/sched_ext/scx_qmap.bpf.c           |  4 ++--
 6 files changed, 43 insertions(+), 25 deletions(-)

-- 
tejun

