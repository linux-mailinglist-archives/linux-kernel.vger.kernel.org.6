Return-Path: <linux-kernel+bounces-357909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2619977B2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD3741F214AC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00D41E2831;
	Wed,  9 Oct 2024 21:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnXFoXFN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFD71E1C30
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 21:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728510254; cv=none; b=ctCKJscRE5FHVrbVrTLBma7ykHyc+5J413YD8GRdKnxOv5dt2TDIk6EyzNrIwfI3NvpjzRkyWgMRHg3O0hNIcPi7fuhBQmzpd6u+DnI7IBu13gJslKgNmlJnc0TL3irWIYYdur3TxoXVBaH2OwHCDq9R4t9N72UnExLJgF0nEgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728510254; c=relaxed/simple;
	bh=ZYm0poSjJGcLAV6auAlIuHSTxJRQgTFVtLqoUrc08Mg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d/37xr2ZXlrw5ORrJ4tX+QNsiwDQc+FEziZFKk9xJx0aAaOvsYeqxJp8X2aIqaaR2yVWoXbcImt5tzmuNwqXlWjsG0x7h4P1eckHTb7gHAdAFJ2pPXBIKlD7iBRwpXcEVLQNANyI8BGarwgXuEnpllBQ5PVyzFAudBoTgnkaPrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnXFoXFN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58F1C4CEC3;
	Wed,  9 Oct 2024 21:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728510253;
	bh=ZYm0poSjJGcLAV6auAlIuHSTxJRQgTFVtLqoUrc08Mg=;
	h=From:To:Cc:Subject:Date:From;
	b=YnXFoXFNKQgz6y5jVD3dYBl8mWnbKkqgkvEjhiTwAniUcgrrNFwd7oKSKOpIxFJsd
	 YOKVnzOgs+Yd83yOWMYyy+rU4jY8deTUdPKLfAWTC0JJIMHPx1/nDTOJfWDxSi2vvS
	 WzmW8z/ts6YIdOaHhASI5fiFOmDu395t7opXL1rlLbSbaxw9w0HxYXnlo7ytUAoPso
	 xu7dbU7/yieYgf6VbBIuWB9sZGRh6NCweWlY78Y04n9ZscurE0RI56Y6vH81BR+IBY
	 SIaCwUCJG+l7VSzTpD8XHGccYAOxiiscymnOTR+v+e4ve+RsI5+WhqldLzD/n8K3kZ
	 RoK7VbYBLofqA==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	sched-ext@meta.com
Subject: [PATCHSET sched_ext/for-6.12-fixes] sched_ext: Fix RCU and other stalls while iterating tasks during enable/disable
Date: Wed,  9 Oct 2024 11:40:56 -1000
Message-ID: <20241009214411.681233-1-tj@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The enable/disable paths walk all tasks a couple times in bypass mode. There
are a couple problems:

- Bypass mode incorrectly depends on ops.select_cpu() which must not be
  trusted in bypass mode.

- scx_tasks_lock is held while walking all tasks. This can lead to RCU and
  other stalls on a large heavily contended system with many tasks.

Fix the former by always using the default select_cpu() in bypass mode and
the latter by periodically dropping scx_tasks_lock while iterating tasks.

This patchset contains the following patches:

 0001-Revert-sched_ext-Use-shorter-slice-while-bypassing.patch
 0002-sched_ext-Start-schedulers-with-consistent-p-scx.sli.patch
 0003-sched_ext-Move-scx_buildin_idle_enabled-check-to-scx.patch
 0004-sched_ext-bypass-mode-shouldn-t-depend-on-ops.select.patch
 0005-sched_ext-Move-scx_tasks_lock-handling-into-scx_task.patch
 0006-sched_ext-Don-t-hold-scx_tasks_lock-for-too-long.patch

 0001 reverts an unnecessary earlier change.

 0002 makes sure that p->scx.slice is consistent on scheduler load.

 0003-0004 make bypass mode always use the default select_cpu().

 0005-0006 make task iteration drop scx_tasks_lock periodically.

and is also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-fix-task_iter-stalls

diffstat follows. Thanks.

 kernel/sched/ext.c |  183 +++++++++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 100 insertions(+), 83 deletions(-)

--
tejun

