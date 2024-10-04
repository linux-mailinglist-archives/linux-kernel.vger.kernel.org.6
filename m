Return-Path: <linux-kernel+bounces-349806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2838698FBBD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 02:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B7C283A66
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 00:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24221D5AC7;
	Fri,  4 Oct 2024 00:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="XNy2l/uE"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30901862
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 00:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728002807; cv=none; b=KPGcpoJ5vH4VefnCfpgM0TmuXjVEQ/WjJMJUS0CSFLhYc8FSl1fEx0gk3YOktnHte8tCiHAq6z66Ery25I5Oef0E338Pbnr3j1Y2NA6jwG2K1/I40QdZWNobcmmBV42MPCxeGxdmUGeTJ7z65r6jnbF5pRMN79xoUmds1CIvajY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728002807; c=relaxed/simple;
	bh=y/s7rAvg0k8bAB4FhKTb+hqr0D7eJwWQtfKJQ6p/268=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PAs9D5N2tlGAWqKd6Bf7AfqWLclg7LQ17NDQKy1qikgE4X4RdLa2SNXUAetLSKSr0Vi8N/+01xMBRJ942ixJl6ZtD5/NQ+dkfLeMZotdJKQ3vAjOT24Ely6QK+7wXeR2/aSoglmfGg1lx8YIFRAdPThT5SDaPgw0rX1lEBCbl+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=XNy2l/uE; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728002804;
	bh=y/s7rAvg0k8bAB4FhKTb+hqr0D7eJwWQtfKJQ6p/268=;
	h=From:To:Cc:Subject:Date:From;
	b=XNy2l/uEFZqxSZjPRsNaLPr7YDdyRgaTyMVJfZ42vve3g32WI5IW8VRUdQC/E8ur7
	 3LHDoRpzaYOp8kSe+kR9c59b4a3BOlh9+dTnEeF33bwveuhzT9h27XfSg7AAUOtlZc
	 g8/hekb0VacwNc9PWM0R5leaCWR66dKl7tFCoV9kPCzL8CsozkXwnQgH26IZwmGQD3
	 uyu5YP9iOoD3l11XDNdcsOSchYJOfhlJjlJDp3vrlTe+Y2e68GH9YLfDq9Lslr6w/D
	 x3m7bVkacyqQ09OaTLmO7f826QCYwS9w1mnj+gOknyY+SnaOIH1xXlc+pSMvu1NcRt
	 0uCS3tTYfx0Cg==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XKVH84NgszBZm;
	Thu,  3 Oct 2024 20:46:44 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Mel Gorman <mgorman@suse.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v1 0/2] RSEQ updates for 6.12
Date: Thu,  3 Oct 2024 20:44:37 -0400
Message-Id: <20241004004439.1673801-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Peter,

This an updated series that contains my rseq updates for 6.12.
Sice v0 I've updated the short log of the selftests patch.

It is based on tag v6.12-rc1.

Can you pick it up through the tip tree ?

Thanks,

Mathieu

Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ben Segall <bsegall@google.com>
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Mathieu Desnoyers (2):
  sched: Improve cache locality of RSEQ concurrency IDs for intermittent
    workloads
  selftests/rseq: Fix mm_cid test failure

 fs/exec.c                           |   2 +-
 include/linux/mm_types.h            |  72 +++++++++++++++---
 kernel/fork.c                       |   2 +-
 kernel/sched/core.c                 |  22 +++---
 kernel/sched/sched.h                |  47 ++++++++----
 tools/testing/selftests/rseq/rseq.c | 109 +++++++++++++++++++---------
 tools/testing/selftests/rseq/rseq.h |  10 +--
 7 files changed, 187 insertions(+), 77 deletions(-)

-- 
2.39.2

