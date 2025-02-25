Return-Path: <linux-kernel+bounces-532359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 151DDA44C0E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47EFC16FEA8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC6420E028;
	Tue, 25 Feb 2025 20:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXUctQDM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80DF20C49C;
	Tue, 25 Feb 2025 20:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740514097; cv=none; b=EdzRt2VMxaV1czbW2IUqvaZXw5KzPy72R3RFBLaPSmW+vD5ou884/oBREPdEoaIycXdk+2heGd2fMQZFBR3ZfFG3TMSoccJ7khcpVDyVKg7sYOmhuytBINAQ5MAsb8aiqF2rTAVNVAoNmg7sX3nyp2S9bzalZc7AFdct/GlbrSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740514097; c=relaxed/simple;
	bh=1X9gti/AqBedO64ZojlHc4HxFQ9alWiuV/NkoEvikIg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rFA86qd1PZ3IXBF5d4DbhFoUzX+IeHck4MQhzOlLd4FGZ4rbgW//EXZnuNr4IQF9eTyYOObhXzDmOn6Ne83P4ahnFbqhVZ9O6rPFtA9z41mKdCwDJ0Kj7Gu43ntMKsI8mVwBsAYGHZn3WROf2z+CowqbjlndWhsF5uMTgyPPkKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXUctQDM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5EACC4CEDD;
	Tue, 25 Feb 2025 20:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740514096;
	bh=1X9gti/AqBedO64ZojlHc4HxFQ9alWiuV/NkoEvikIg=;
	h=From:To:Cc:Subject:Date:From;
	b=GXUctQDMq2dJR5ZYCXwcuvk755B0POltC5zhf8NUQfss9+z4wFY4nnYvZu9kLCwhR
	 RCBDsDNEp0sTpOTO2bNjLX6yo67/kT4Q4BsdqrS0GpVIvtoMGnW+iaQXUUDtWjrFMX
	 2gPyuvBvDYzbeODgfvPmLgW7cg7pvs4IPuuk+6mBH9T9W6EeptdGaC7WHdpe9KTpqy
	 fVUNHWqtk7DBI7n70E94o3F+jYmc3ndJUwtIs+J6QWVz1JlEJ7G6kTAqQG89BUHDbq
	 g1h7swkC84a2d8i3yZuGPBAcSBg/CmfjWO6w75ARxUff94PmMQ/PLDU1LLjnLq0e2w
	 aEhwxAqPF3U9w==
From: Arnd Bergmann <arnd@kernel.org>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] sched: open-code max_rt_runtime definition
Date: Tue, 25 Feb 2025 21:07:39 +0100
Message-Id: <20250225200806.4012494-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Building with clang using "make W=1" normally produces warnings about unused
const variables, but clang does not warn about those in header files.
In case of rt.c it also doesn't warn because this gets included by
from build_policy.c.

Enabling the same warning on gcc also warns about it in included files,
so we end up with a warning when all users of max_rt_runtime are
hidden because both CONFIG_RT_GROUP_SCHED and CONFIG_SYSCTL are
disabled:

ernel/sched/rt.c:9:18: error: 'max_rt_runtime' defined but not used [-Werror=unused-const-variable]

It's not possible to avoid the warning by moving max_rt_runtime
into one of the #ifdef sections, but since it is itself defined
as MAX_BW, simply open-coding that is an easy workaround.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/sched/rt.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 7a9ed4d93397..5dd6280442f0 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -5,8 +5,6 @@
  */
 
 int sched_rr_timeslice = RR_TIMESLICE;
-/* More than 4 hours if BW_SHIFT equals 20. */
-static const u64 max_rt_runtime = MAX_BW;
 
 /*
  * period over which we measure -rt task CPU usage in us.
@@ -2779,7 +2777,7 @@ static int tg_set_rt_bandwidth(struct task_group *tg,
 	/*
 	 * Bound quota to defend quota against overflow during bandwidth shift.
 	 */
-	if (rt_runtime != RUNTIME_INF && rt_runtime > max_rt_runtime)
+	if (rt_runtime != RUNTIME_INF && rt_runtime > MAX_BW)
 		return -EINVAL;
 
 	mutex_lock(&rt_constraints_mutex);
@@ -2891,7 +2889,7 @@ static int sched_rt_global_validate(void)
 	if ((sysctl_sched_rt_runtime != RUNTIME_INF) &&
 		((sysctl_sched_rt_runtime > sysctl_sched_rt_period) ||
 		 ((u64)sysctl_sched_rt_runtime *
-			NSEC_PER_USEC > max_rt_runtime)))
+			NSEC_PER_USEC > MAX_BW)))
 		return -EINVAL;
 
 	return 0;
-- 
2.39.5


