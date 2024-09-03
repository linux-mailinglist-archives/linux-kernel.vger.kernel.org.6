Return-Path: <linux-kernel+bounces-313566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9655196A71B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 21:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52BCD285EBB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 19:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E7E1D5CE0;
	Tue,  3 Sep 2024 19:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Jhpmg772"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E624C1D5CC0
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 19:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725390443; cv=none; b=SGmsPwiiqG/WntQh2jrrU+HHF+qNUKO9WsioP2iSmhm0GPHb003tXfvP2XWd+aaau4tvSKpYROkmowaydDjpFT3GCMX9+R+if2wI7IZ1MfheYuKDF8TfW8h+aFDoxGV6XC86owkyUuFJFqcB+KqFflT2Mfk8pb7/6H6oWMTAA44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725390443; c=relaxed/simple;
	bh=mWzIzxSnlZb45ios1Kw/2hOV20AhADLv8WxVIVy6kCw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZjIff3R02yUAnQmQppt3vWH1mvUJO844HyEeB42nqeQnuw3Z7RsMSND7uu0zw5+xADSXFi0POXG+OdhdirtsttrUq8K/K0FOLWinRzzleyqqCaNLm6fnPuD/vmOngRFaE11B53WnpwbmufViZqzePbcl8s8z7aZq+S+JQ5RKgXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Jhpmg772; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1725390436;
	bh=mWzIzxSnlZb45ios1Kw/2hOV20AhADLv8WxVIVy6kCw=;
	h=From:To:Cc:Subject:Date:From;
	b=Jhpmg772eg+O+DuR5E9UEQsywAH+aKMP4JwhLWVq22/OmJAtMBHVXOb27jx3ojv8e
	 xfDkQhmKooA4ta+c8eKBihEtzsnSbo9eQZEPC+jc0nxOagwWlely1t1Eiej+lkDCng
	 tv8TV7+YA0cKO9bvVfJHrQ9bZXi+fyPfI05ePou237/WcukHDPibKOS97EWwXuuTCr
	 mWT9TIw7M27jhlKzpaCwV0LDHCtVcGb7omVIiBPVzhNcROsqWudfv1Aexrka9tuFY1
	 lnT3PgmBs64j1G+RxeE/edQFIpD9yq+3EbiuZlFdj0RAJZxtizGfrCN2ERLmaP4bSi
	 n2lss7QgUrrjQ==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Wyw9H6JQtz1Jxx;
	Tue,  3 Sep 2024 15:07:15 -0400 (EDT)
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
Subject: [RFC PATCH 0/2] sched: Improve cache locality of RSEQ concurrency IDs
Date: Tue,  3 Sep 2024 15:06:48 -0400
Message-Id: <20240903190650.53644-1-mathieu.desnoyers@efficios.com>
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

Mathieu Desnoyers (2):
  cpumask: Implement cpumask_next_andnot
  sched: Improve cache locality of RSEQ concurrency IDs for intermittent
    workloads

 fs/exec.c                |  2 +-
 include/linux/cpumask.h  | 17 +++++++++++
 include/linux/mm_types.h | 66 ++++++++++++++++++++++++++++++++++------
 kernel/fork.c            |  2 +-
 kernel/sched/core.c      |  7 +++--
 kernel/sched/sched.h     | 47 +++++++++++++++++++---------
 6 files changed, 114 insertions(+), 27 deletions(-)

-- 
2.39.2

