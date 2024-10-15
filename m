Return-Path: <linux-kernel+bounces-366645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 144DF99F831
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD29B28619C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D5A1F81A1;
	Tue, 15 Oct 2024 20:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIUIMY5j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D35158D9C
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 20:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729024716; cv=none; b=l+W4oGg9qloktDdrj1cAZLVC+JjwEeuFvbDmVb09uDMNa/PZapPztDnC7N6BKdiIgZM/ct5s0lsv75VIz9OwZvg90cY0YASSdHUxqOf7ZI++YA1HkkRLZWAGddA5divxFLnMFsEa9H6cyDrUg+smE2FBWgmfuO0j2VXNrAUfN3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729024716; c=relaxed/simple;
	bh=RkxXj0gX4PbFXoXsYohFoDyKm8yQK6wWhWxAG0Svqcs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nXa9y4y/T71zYM7itObVvdq6zS9EPHvtD4cjLPrOZHh9Ir9mOxUxTxRigO/wYiPmMuqha5rt/2h1SjEIymrcIOWPHxoY7S1jwGPeIq1nHIc6Oc71iLvzdYMjdhb7XekF/IR+NXCaAK/+nX11bMP53OJQ07qF0yEjF2rU3NAeNPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIUIMY5j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A15DC4CEC6;
	Tue, 15 Oct 2024 20:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729024716;
	bh=RkxXj0gX4PbFXoXsYohFoDyKm8yQK6wWhWxAG0Svqcs=;
	h=Date:From:To:Cc:Subject:From;
	b=EIUIMY5jOz14AUGte+IY9RYR7bAsxISo7dvjaSqPnuiKn/FFwfliV7S8RQY+hStWE
	 zEO0fkaM+4urLy1eK1r/X7RZqIbFW2qdpRLnKWNrjh+jN9Ou9qMB1R1Q6mMqsXoahG
	 3gifthPx9cKrMvUqhG+Va/1mh//oBH7HvYHXLDCUyF8M0kEM7VrbXeZh84AE4k4xf0
	 mj3aeSYfmxVgLP4vgxtME/H4G0eYhrfp5Ie53ICVovmCA1tRq4TxmpgoVpXESOKt8l
	 KoHV1XPsLI5aKkAd+zHw0HRmH/nsnUkeofMyJxfqvi2QqtijQeP+yRVqT/FVWIRAbV
	 gBaWEIyv+vHbg==
Date: Tue, 15 Oct 2024 10:38:35 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, sched-ext@meta.com,
	David Vernet <void@manifault.com>
Subject: [GIT PULL] sched_ext: Fixes for v6.12-rc3
Message-ID: <Zw7Syx6dUES0a_R5@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit e0ed52154e866a1e9e9b97ded50b164698f0a222:

  sched_ext: Documentation: Update instructions for running example schedulers (2024-10-08 08:49:18 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.12-rc3-fixes

for you to fetch changes up to 60e339be100d7d49e13616bd8b4b1b864f0a64a0:

  sched_ext: Remove unnecessary cpu_relax() (2024-10-14 13:23:49 -1000)

----------------------------------------------------------------
sched_ext: Fixes for v6.12-rc3

- More issues reported in the enable/disable paths on large machines with
  many tasks due to scx_tasks_lock being held too long. Break up the task
  iterations.

- Remove ops.select_cpu() dependency in bypass mode so that a misbehaving
  implementation can't live-lock the machine by pushing all tasks to few
  CPUs in bypass mode.

- Other misc fixes.

----------------------------------------------------------------
Björn Töpel (1):
      selftests: sched_ext: Add sched_ext as proper selftest target

David Vernet (1):
      sched_ext: Remove unnecessary cpu_relax()

Honglei Wang (1):
      sched_ext: use correct function name in pick_task_scx() warning message

Tejun Heo (6):
      Revert "sched_ext: Use shorter slice while bypassing"
      sched_ext: Start schedulers with consistent p->scx.slice values
      sched_ext: Move scx_buildin_idle_enabled check to scx_bpf_select_cpu_dfl()
      sched_ext: bypass mode shouldn't depend on ops.select_cpu()
      sched_ext: Move scx_tasks_lock handling into scx_task_iter helpers
      sched_ext: Don't hold scx_tasks_lock for too long

 kernel/sched/ext.c                         | 186 ++++++++++++++++-------------
 tools/testing/selftests/Makefile           |   9 +-
 tools/testing/selftests/sched_ext/Makefile |  71 +++++------
 3 files changed, 138 insertions(+), 128 deletions(-)

-- 
tejun

