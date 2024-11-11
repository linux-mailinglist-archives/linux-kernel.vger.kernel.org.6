Return-Path: <linux-kernel+bounces-404414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0280A9C437B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACBE71F21E65
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA851A704C;
	Mon, 11 Nov 2024 17:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUKgE4N7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA73925777
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 17:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731345833; cv=none; b=Z2b/Lyd6Aj+TvqH1FSmzDPkXarpClrNBx/Lr3vgu2cxSvAhOybrvER1+TL28zHJ1Huocll7m0MQj2w8xI70+zM6eWEFxnUc9c67n1gQ4rjaIf7V4tqoOXrMxKMevf/wKZ1/yQKKOTsPyFvBJzEDw/qADyquNuR+DMr0tjc2fUFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731345833; c=relaxed/simple;
	bh=b0c9HKVf+NUMnKmXEFv0KUuL/x0pXi5FJDssH2sljPE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=c3KyoJlQ3jRF7DB0GEZlvN6AC7cHW56Vmpk6WjK0VFYV/R3zOBWnPhVz8AM4f17mWpLjPlgZR2FNy+gF4Jm2EILrr/VQhCaaWl1wnGQPwt8ByfKxvqeIB4n/DFKlpteJH+H/5LBFkTgDeQddHiWRPkODuypIJaAhg+Tnoz0I+Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUKgE4N7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD8DC4CECF;
	Mon, 11 Nov 2024 17:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731345833;
	bh=b0c9HKVf+NUMnKmXEFv0KUuL/x0pXi5FJDssH2sljPE=;
	h=Date:From:To:Cc:Subject:From;
	b=BUKgE4N7CwTXWvxvthGfnfF3KcmKNH82DSfcqD2Ryrmk+xRwDCQtD6Ft96vZqzCXk
	 s9IP6M5/6Pim4QbvuBGUqP8KEpahZa2Z45r0dSA98izmfzFywIgTl/A9plr5NOLOjf
	 rCmRxJebUsxpS9tiBoUGxdmJd1GHuemZ7FkHuSOo+fS28q1O4ZZ/haz2n6+fbtL5P2
	 iaJ1fDK1AHyiC06Itbb23lAUUO63UdHxQjL0y8WgNcNbD9VaYYIZyIHTBBW1nixseZ
	 rOzZ9OzPtBGiIpN86VOpyDa5MfmiFkJlRS6jGjuL6z4vBYXeBmxgSlLUqCsBe45Uuh
	 FKWbQiJROULfQ==
Date: Mon, 11 Nov 2024 07:23:52 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, sched-ext@meta.com,
	Peter Zijlstra <peterz@infradead.org>
Subject: [GIT PULL] sched_ext: Fixes for v6.12-rc7
Message-ID: <ZzI9qJ_LLdELWhQX@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit c31f2ee5cd7da3086eb4fbeef9f3afdc8e01d36b:

  sched_ext: Fix enq_last_no_enq_fails selftest (2024-10-25 12:20:29 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.12-rc7-fixes

for you to fetch changes up to a6250aa251eacaf3ebfcfe152a96a727fd483ecd:

  sched_ext: Handle cases where pick_task_scx() is called without preceding balance_scx() (2024-11-09 10:43:55 -1000)

----------------------------------------------------------------
sched_ext: Fixes for v6.12-rc7

- The fair sched class currently has a bug where its balance() returns true
  telling the sched core that it has tasks to run but then NULL from
  pick_task(). This makes sched core call sched_ext's pick_task() without
  preceding balance() which can lead to stalls in partial mode. For now,
  work around by detecting the condition and forcing the CPU to go through
  another scheduling cycle.

- Add a missing newline to an error message and fix drgn introspection tool
  which went out of sync.

----------------------------------------------------------------
Tejun Heo (3):
      sched_ext: Add a missing newline at the end of an error message
      sched_ext: Update scx_show_state.py to match scx_ops_bypass_depth's new type
      sched_ext: Handle cases where pick_task_scx() is called without preceding balance_scx()

 kernel/sched/core.c               | 13 ++++++-----
 kernel/sched/ext.c                | 46 +++++++++++++++++++++++++++------------
 kernel/sched/sched.h              |  5 +++--
 tools/sched_ext/scx_show_state.py |  2 +-
 4 files changed, 44 insertions(+), 22 deletions(-)

-- 
tejun

