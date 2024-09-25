Return-Path: <linux-kernel+bounces-337815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E0B984F50
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 02:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A36791C20B16
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A412CA6;
	Wed, 25 Sep 2024 00:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VasiCfVE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0D51876
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 00:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727222787; cv=none; b=XvKJLz/HwXv2OhjXJQMYFSZaNjj3UzylBDCKvc5nicapyGkhAvL6+djGFsr9CYH4pwqaZ2vEaGdxjq1Rj7xO82p/65jG4Zgq6o5GzsRaSVKBCmk5oDRPRRuwVH3vV1soXEBXOiXGV8N+h9LEbLc9saI4BsNtCzzl5PRZ1iZCmhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727222787; c=relaxed/simple;
	bh=C8QkGG+y+qAP2W234siWTw4bspheqUEqHvcDR1XpXvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z6P2RVTpqpyS+IyNik5ZEnIAXzYocwd7Vhdlbz5gBXfmaOceaSRFr+6oz2yOoeNqnXzC1XWEqlcsozXNVr8iIDQzBTh4cs7C1/DALdFBRbMEqT78ntbd+/Lga5uvN5/dZn+1+qyoyuXt56ajL92ZMAOY5MyJheVFZZh6/PE821c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VasiCfVE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0D1C4CEC4;
	Wed, 25 Sep 2024 00:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727222785;
	bh=C8QkGG+y+qAP2W234siWTw4bspheqUEqHvcDR1XpXvE=;
	h=From:To:Cc:Subject:Date:From;
	b=VasiCfVETwQpUO1yCN3fTMDWjOVLIIgF7xa+bY4nlKIKX9UyRHsHCiqAlg6JtwR5A
	 1RzLeINeWfx4spfceOOXhnI5wUJ322uLpcjLm+b4ztq+/b9zwOtUfqQyQ+NHd5jCj1
	 b6IGX2J07KWIFRN8QkmmZL4+wpzF+53NONCDOvv8XEu9sFdQUslrXuGBVhnrP6xveT
	 vYWJJWOrzmtINpeD1pnldbFfXBYHcdzIqo/o1Yt/qF4yT7mYP3zcozOsDfz+8zHERN
	 m7geqrRyShygsjYUniqhLGZlzxYhLnl3RJuRtcK/vBy8OND/cX21YPowyG/qNe/zYJ
	 sllJ9FL6wRPMg==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	sched-ext@meta.com
Subject: [PATCHSET sched_ext/for-6.12-fixes] sched_ext: Split %SCX_DSQ_GLOBAL per-node
Date: Tue, 24 Sep 2024 14:06:02 -1000
Message-ID: <20240925000622.1972325-1-tj@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the bypass mode, the global DSQ is used to schedule all tasks in simple
FIFO order. All tasks are queued into the global DSQ and all CPUs try to
execute tasks from it. This creates a lot of cross-node cacheline accesses
and scheduling across the node boundaries, and can lead to live-lock
conditions where the system takes tens of minutes to disable the BPF
scheduler while executing in the bypass mode.

This patchset splits the global DSQ per NUMA node. Each node has its own
global DSQ. When a task is dispatched to SCX_DSQ_GLOBAL, it's put into the
global DSQ local to the task's CPU and all CPUs in a node only consume its
node-local global DSQ.

This resolves a livelock condition which could be reliably triggered on an
2x EPYC 7642 system by running `stress-ng --race-sched 1024` together with
`stress-ng --workload 80 --workload-threads 10` while repeatedly enabling
and disabling a SCX scheduler.

This patchset contains the following patches:

 0001-scx_flatcg-Use-a-user-DSQ-for-fallback-instead-of-SC.patch
 0002-sched_ext-Allow-only-user-DSQs-for-scx_bpf_consume-s.patch
 0003-sched_ext-Relocate-find_user_dsq.patch
 0004-sched_ext-Split-the-global-DSQ-per-NUMA-node.patch
 0005-sched_ext-Use-shorter-slice-while-bypassing.patch

 0001-0003 are preparations.

 0004 splits %SCX_DSQ_GLOBAL per-node.

 0005 reduces time slice used while bypassing. This can make e.g. unloading
 of the BPF scheduler complete faster under heavy contention.

This patchset can also be found in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-split-global

diffstat follows. Thanks.

 kernel/sched/ext.c               |  109 ++++++++++++++++++++++++++++++++++++++++++-------------------
 tools/sched_ext/scx_flatcg.bpf.c |   17 +++++++--
 2 files changed, 89 insertions(+), 37 deletions(-)

--
tejun

