Return-Path: <linux-kernel+bounces-336236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB24A97F0F4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 21:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBDFF1C21778
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 19:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CD31A263A;
	Mon, 23 Sep 2024 19:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZAmKGZa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F96B1A262B
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 19:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727118033; cv=none; b=ABtuHJ2ZFlOcSyxwQLLTigOrq6pMeYuFLNM211pR9+5jPfFabnEBuQpBrwrC+5rSF5pQhYXnX/0Abx24Li9Pe0aVaTwQ9OVbzgvo75le/pxgZzPeVfltGQdIZx+zzqbazyo8vsZL95Y2Bu1oNO6gj6MwVy5xZhngipkP6vu4PwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727118033; c=relaxed/simple;
	bh=N4Ug99/YXUwz1ZAm3MUbkfQ8JePQtlYXZW/1L1QDOhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GOv2ICHqUFjvXa3ekjDSopATsoRfOEsZscmikbqhZ9SdAWXdsfztpKSr7tzidVcsI9AW+ur+fnmYyc2phaHuIuf8IW30j6gH39h4UOUkaKMQB7T1BTbVynYK6e3MTnq9CMtsG0DIxdLgXaeBAXD2UbOPhdGVTDGfq92NOqtudzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZAmKGZa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD86BC4CEC5;
	Mon, 23 Sep 2024 19:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727118032;
	bh=N4Ug99/YXUwz1ZAm3MUbkfQ8JePQtlYXZW/1L1QDOhc=;
	h=From:To:Cc:Subject:Date:From;
	b=qZAmKGZas3dH02UfYwymACDM+nj5f0W2o1aCuzg2N0ka8RqeOiJhEy0WqIGCxLGeC
	 q8VFjfXgHMXIWM0jwgTIGpppMmjkke84q5F53kp5gy97jWSp4HuGqcOg3PGgFLNxKu
	 3Xvf0U4km0NVAW4KiLrIJqrtGQVcgbRkmZfdGTjmiMvoXIQyiTlff6JHfEDGqCUHn7
	 TVuZGEK7MYNZdmw4mOIZFqpAoWlrFP+QDU6kV3YUAkEcc3AVPAZspyW5XBhTlWZsV0
	 exyyutUm/w9Z5owTHqh9Z9M/d1PwGj39eh7eBF188zUPtCZWUmMHJxQ4QedFtIBHnc
	 eUgeUp74ryILA==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	sched-ext@meta.com,
	aboorvad@linux.ibm.com
Subject: [PATCHSET sched_ext/for-6.12-fixes] sched_ext: Fix locking enable/disable path bugs includling locking order one
Date: Mon, 23 Sep 2024 08:59:27 -1000
Message-ID: <20240923190020.1446325-1-tj@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Aboorva Devarajan reported an issue where sched_ext init code can
occasionally deadlock when scheduler loading races CPU hotplug. The deadlock
scenario is as follows:

       scx_ops_enable()                               hotplug

                                          percpu_down_write(&cpu_hotplug_lock)
   percpu_down_write(&scx_fork_rwsem)
   block on cpu_hotplug_lock
                                          kthread_create() waits for kthreadd
					  kthreadd blocks on scx_fork_rwsem

Note that this doesn't trigger lockdep because the hotplug side dependency
bounces through kthreadd.

This is primarily caused by SCX enable/disable paths grabbing big locks
together. This patchset updates the enable/disable paths to decouple the
locks. In the process, it also fixes several subtle bugs in the enable path.

This patchset contains the following patches:

 0001-sched_ext-Relocate-check_hotplug_seq-call-in-scx_ops.patch
 0002-sched_ext-Remove-SCX_OPS_PREPPING.patch
 0003-sched_ext-Initialize-in-bypass-mode.patch
 0004-sched_ext-Fix-SCX_TASK_INIT-SCX_TASK_READY-transitio.patch
 0005-sched_ext-Enable-scx_ops_init_task-separately.patch
 0006-sched_ext-Add-scx_cgroup_enabled-to-gate-cgroup-oper.patch
 0007-sched_ext-Decouple-locks-in-scx_ops_disable_workfn.patch
 0008-sched_ext-Decouple-locks-in-scx_ops_enable.patch

 0001-0002 are prep patches.

 0003 removes a race window in the enable path that can cause stalls and
 prepares for further locking updates.

 0004-0005 remove race windows in the enable path that can cause invalid task
 state transitions.

 0006 fixes a bug in cgroup enable path which can skip invocation of
 ops.cgroup_exit() and prepares for further locking updates.

 0007-0008 decouple the big locks and fix the deadlock.

This patchset can also be found in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-enable-locking-fix

diffstat follows. Thanks.

 kernel/sched/ext.c |  199 ++++++++++++++++++++++++++++++++------------------------------------
 1 file changed, 94 insertions(+), 105 deletions(-)

--
tejun

