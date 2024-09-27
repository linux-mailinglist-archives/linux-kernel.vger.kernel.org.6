Return-Path: <linux-kernel+bounces-342277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C840988D0A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 01:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A13B7B2151C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 23:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6911B3F21;
	Fri, 27 Sep 2024 23:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBXs/mut"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF829443
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 23:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727480921; cv=none; b=fqVRvKHmGCi98jMsgcDedrksiyIz6LDJE6cDOmqavDBcTC7nzWL2oA08nbob6MnV8CzLUCfoSWF/w+ngpQtnZbUvQ7BQvs3MsWP/fXN+ztjuN8a8PsmQ+S9+06eGL1UTdxcHe8dKz/NqhUW1jjGX5fQNSA42GhI5AbdtJP88Xps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727480921; c=relaxed/simple;
	bh=a+Rk+PQXrVjXnfbKNLhS+TPJo9auIHLOf14dn7KCPKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mt/IrWvRK1myMEUbrkTvovvc8IPqSsSnFYVrk7HH3McNpUrX80c1G6Zsxlki0vcc0G5U9XNnGoPSCc6rg6d4P549tbCFjcIAAxllRca7CoB3TftvdXA6WAYnMUBqcffBx6aC773h/ucrFNoVWm/aVU3+r5mBftZ65QLnFtQScAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBXs/mut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA502C4CEC4;
	Fri, 27 Sep 2024 23:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727480920;
	bh=a+Rk+PQXrVjXnfbKNLhS+TPJo9auIHLOf14dn7KCPKY=;
	h=From:To:Cc:Subject:Date:From;
	b=BBXs/mutAZz7KbWSFqg7bupOQZhvQEbogrXP+va8lhadJnYXymd27X5WxRAUbEu/D
	 3GF0K3UrW9GuEHH503+mPw6oYr5OSLXbPJg37LiugRhn1CPqnOadCBkhLcDhxtZNXb
	 OIw7l2n5y/sz55LRt9sykSC220ujSgZmvHW2NR0LrfOr3JVHcqRKmq74ITlV3i0no0
	 UBXhur+Fhqv2aank3yd2qTyDcgwHYkJOW7W58ImdcrkTOx7V3tDLBX+zB+jBzEi+aI
	 DQssfg36tHLVZnIahxzEV1j7tqHxjNr7RZxMSY7b5BQlbLNGOZNBbkomf0qKT4mrC7
	 AXP6TtJoUpP+g==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	peterz@infradead.org,
	mingo@redhat.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	sched-ext@meta.com
Subject: [PATCHSET sched/urgent, sched_ext/for-6.12-fixes] sched/core, sched_ext: Add ENQUEUE_RQ_SELECTED to fix ->select_task_rq() skip detection in sched_ext schedulers
Date: Fri, 27 Sep 2024 13:46:10 -1000
Message-ID: <20240927234838.152112-1-tj@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During ttwu, ->select_task_rq() can be skipped if only one CPU is allowed or
migration is disabled. sched_ext schedulers may perform operations such as
direct dispatch from ->select_task_rq() path and it is useful for them to
know whether ->select_task_rq() was skipped in the ->enqueue_task() path.

Currently, sched_ext schedulers are using ENQUEUE_WAKEUP for this purpose
and end up assuming incorrectly that ->select_task_rq() was called for tasks
that are bound to a single CPU or migration disabled.

This patchset adds ENQUEUE_RQ_SELECTED to indicate whether
->select_task_rq() was called to ->enqueue_task() and propagate that to
sched_ext schedulers so that they can reliably detect whether
->select_task_rq() was skipped.

Peter, please let me know how 0001-0002 should be routed. If they get
applied to sched/urgent (when it opens), I'll pull it into
sched_ext/for-6.12-fixes and apply 0003 on top. If you'd prefer, I can take
all three through sched_ext/for-6.12-fixes too.

This patchset contains the following patches:

 0001-sched-core-Make-select_task_rq-take-the-pointer-to-w.patch
 0002-sched-core-Add-ENQUEUE_RQ_SELECTED-to-indicate-wheth.patch
 0003-sched_ext-scx_qmap-Add-and-use-SCX_ENQ_CPU_SELECTED.patch

 0001-0002 are sched/core patches to add ENQUEUE_RQ_SELECTED.

 0003 makes sched_ext propagate the flag as SCX_ENQ_CPU_SELECTED and fix
 scx_qmap using the new flag.

and can also be found in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-ENQUEUE_RQ_SELECTED

diffstat follows. Thanks.

 kernel/sched/core.c            |   21 ++++++++++++++-------
 kernel/sched/ext.c             |    1 +
 kernel/sched/sched.h           |    3 +++
 tools/sched_ext/scx_qmap.bpf.c |    4 ++--
 4 files changed, 20 insertions(+), 9 deletions(-)

--
tejun

