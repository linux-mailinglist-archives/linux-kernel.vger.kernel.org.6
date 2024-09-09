Return-Path: <linux-kernel+bounces-322119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2726897245A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 23:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB4E4284ED6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 21:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C64D18C326;
	Mon,  9 Sep 2024 21:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Zn0wfo0j"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432C317085C
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 21:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725916530; cv=none; b=f6kANfriwmDm0dngdW79phknldxW0uutGOO8WTVg9Ol46tQacxmJYgQ8gohgrrbu+Fmfl0PIVQPAb25L2WDonJim/j0UwWU0sKIAnD61hyjkXMAgZZ1qaHJF5b0KeWbZVwZJimW6CX56aOepxOdvZx17XDAlKPCM/vG/zfBERww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725916530; c=relaxed/simple;
	bh=CTMpg23m6EnAzEar4/tnxuxdSKdScELZnFfMCgrFyWg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bfbc7x5HwiBaTgpP+hWK6ni5FLcXoqUO/mVM3ye2vYL/frTWlC6+QFwVY+wD5SeNUx4yFrhRDx7uQhGqtAwk+tq/IpPjAJTOHhf/V/RjLGAaHbrD9DYIswBU9MLDHmO1YjprSVeVDYZ6CLXDYqo6/aXfe2t3Aikb+krcjuMGfds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Zn0wfo0j; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1725916527;
	bh=CTMpg23m6EnAzEar4/tnxuxdSKdScELZnFfMCgrFyWg=;
	h=From:To:Cc:Subject:Date:From;
	b=Zn0wfo0jDKdficN0LbM3OV5KFiaQIqijSMqRZ20Nmq87zRlrA25DDMm2KmpPVDQxY
	 OjTplyoHO76CfyOouLsN+ZENjJmyMPHOYDSlKCUfolmzy3SxxJ1X2pFij4dKYmrtAl
	 B1St1lZ1cJSkUcj/TIsOdcCRbjkqqzNrioh0fT1JbbEx5K/lphd7l/1AJ3+Jue+9cP
	 iYXZvI3KZXc387v/oMZLKYs2vmztMP7ekkQl7KW4cPKAy/wY84n9IM8GERMR8Yfc/6
	 /gEAGZ4Xs6oeblWZFmZvNwJJNKaKzvBl+oBU7dXgea4XS7rwI3G9a/fW2Oto09AIkG
	 ZOg2OFrkLHziQ==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4X2fkQ62hwz1Kqk;
	Mon,  9 Sep 2024 17:15:26 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Mel Gorman <mgorman@suse.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 0/1] sched: Improve cache locality of RSEQ concurrency IDs
Date: Mon,  9 Sep 2024 17:15:05 -0400
Message-Id: <20240909211506.326648-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intermittent workloads behaving in bursts spaced by more than 100ms
on each CPU exhibit bad cache locality and degraded performance compared
to purely per-cpu data indexing, because concurrency IDs are allocated
over various CPUs and cores, therefore losing cache locality of the
associated data.

This series addresses this shortcoming. I observed speedups up to 16.7x
compared to plain mm_cid indexing in benchmarks.

It applies on top of v6.10.6.

This deprecates the prior "sched: NUMA-aware per-memory-map concurrency
IDs" patch series with a simpler and more general approach.

Feedback is welcome!

Thanks,

Mathieu

Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ben Segall <bsegall@google.com>
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Mathieu Desnoyers (1):
  sched: Improve cache locality of RSEQ concurrency IDs for intermittent
    workloads

 fs/exec.c                |  2 +-
 include/linux/mm_types.h | 72 +++++++++++++++++++++++++++++++++++-----
 kernel/fork.c            |  2 +-
 kernel/sched/core.c      |  7 ++--
 kernel/sched/sched.h     | 47 ++++++++++++++++++--------
 5 files changed, 103 insertions(+), 27 deletions(-)

-- 
2.39.2

