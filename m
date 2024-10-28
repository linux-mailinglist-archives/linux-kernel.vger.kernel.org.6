Return-Path: <linux-kernel+bounces-384183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D3A9B25BF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48247281753
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 06:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEA6190052;
	Mon, 28 Oct 2024 06:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UXtup0Q8"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B1718FC79
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 06:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730097211; cv=none; b=FErGe/bOvUqd7RBX8cAkKFN7CnGhmTZ6puDl/Y/79xzq6yf1AbJr0XjMNIYetAXfJ3/KW2ORdW1IS6zQugP5fHDoi82kT2NMstpYBrtU/CJ79jfIe6KrHaIBChN3UMJmaZyWbjATD2rFT45BpRbZENdffUDseFmskEjP0tpVIWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730097211; c=relaxed/simple;
	bh=GGnmFs2KOkeQRAZwq2CEIotYvBcCc2K4a9fCaF0cr3w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ObTwz1piryHZCSpVDqtJm7OSxSi0v8QUKeWVcJ4ci0uFGmJNcvcQEfAtKUu/I+kU2cS5FUe/byiW11AGtl5XpVBpo8wk4wpvJRX6p3p3pxkybsZlz21rRSh3mGHKhAnU9ctJalA/DfmE6Y1H2U3688ixWRAeiKRvrWcwDunXDgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UXtup0Q8; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730097201; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=BXcDfxkMi956UbB8kccvw5bm5E9JN1/RebAMoZNIh4o=;
	b=UXtup0Q8MYjwu5B1JYwBKcf5Od+1QuiqBP9u9RmHhi5hBlniHzQpwF3+pU4/VK8dZkk9HaX5Jv/ed6jHwilek0/Coe7oyxUZP0q64SjoG51CikQPUpJsohDBRoP3UeeYQOGy+cNOJPxaSjKdx5UU8PCR3Y6nT9V2e+NMSWO6Y5w=
Received: from localhost.localdomain(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0WI.X8st_1730097193 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 28 Oct 2024 14:33:20 +0800
From: Tianchen Ding <dtcccc@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>
Subject: [RFC PATCH 0/2] sched/eevdf: Introduce a cgroup interface for slice
Date: Mon, 28 Oct 2024 14:33:11 +0800
Message-Id: <20241028063313.8039-1-dtcccc@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 1st patch is a minor fix for the existing cgroup propagating.

The 2nd patch is the main part and RFC. If the design is ok, I'll send
another patch later for documents about the new cgroup interface.

Thanks.

Tianchen Ding (2):
  sched/eevdf: Force propagating min_slice of cfs_rq when a task
    changing slice
  sched/eevdf: Introduce a cgroup interface for slice

 kernel/sched/core.c  | 34 +++++++++++++++++++++++++++++
 kernel/sched/fair.c  | 51 +++++++++++++++++++++++++++++++++++++++-----
 kernel/sched/sched.h |  3 +++
 3 files changed, 83 insertions(+), 5 deletions(-)

-- 
2.39.3


