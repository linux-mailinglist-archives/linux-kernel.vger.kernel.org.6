Return-Path: <linux-kernel+bounces-226837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40521914490
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE0281F23886
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B630D71B5B;
	Mon, 24 Jun 2024 08:21:24 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC34961FE1
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719217284; cv=none; b=TEXIn8F+0G7U1NhfocP5eh6REdUDmPvj09NKVo7kC4YKnufhTZsxACepF1/bJahYPhAZPq6dq5AIiNxJb2FmcaOyvNIq30Dc2ubaVwn8ZUuglJc6j+vmkt18L20gLuInV7xEuDnqdxHhaFe/pMD94h97FD1Q9uQLcX6eg8RFzrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719217284; c=relaxed/simple;
	bh=OGI/RW6LinusZct94/SSzXZaBON6c0uVVa057/4TXtQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YrF13G9SPZmf2FMDXFk0oXZD7P3/4/fL7S0oYmLYisRy5dMXHhsN+82g879ZoUyaze5lUHWNDyRrQTqOr+sO522m3JUHWmc3qjuf78LEpNHKIGpZdxZHNtKA6ZSMRA5HR9jut7ER/TWST+trpKXeLucapohlOAKkugXFlkH+t08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 45O8KsBk019217;
	Mon, 24 Jun 2024 16:20:54 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4W714v3FNCz2SwTfL;
	Mon, 24 Jun 2024 16:16:15 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 24 Jun 2024 16:20:50 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <qyousef@layalina.io>
CC: <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <vschneid@redhat.com>,
        <christian.loehle@arm.com>, <vincent.donnefort@arm.com>,
        <ke.wang@unisoc.com>, <di.shen@unisoc.com>, <xuewen.yan94@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 2/2] sched/fair: Use actual_cpu_capacity everywhere in util_fits_cpu()
Date: Mon, 24 Jun 2024 16:20:11 +0800
Message-ID: <20240624082011.4990-3-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240624082011.4990-1-xuewen.yan@unisoc.com>
References: <20240624082011.4990-1-xuewen.yan@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 45O8KsBk019217

Commit f1f8d0a22422 ("sched/cpufreq: Take cpufreq feedback into account")
introduced get_actual_cpu_capacity(), and it had aggregated the
different pressures applied on the capacity of CPUs.
And in util_fits_cpu(), it would return true when uclamp_max
is smaller than SCHED_CAPACITY_SCALE, althought the uclamp_max
is bigger than actual_cpu_capacity.

So use actual_cpu_capacity everywhere in util_fits_cpu() to
cover all cases.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 kernel/sched/fair.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5ca6396ef0b7..9c16ae192217 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4980,7 +4980,7 @@ static inline int util_fits_cpu(unsigned long util,
 				int cpu)
 {
 	unsigned long capacity = capacity_of(cpu);
-	unsigned long capacity_orig;
+	unsigned long capacity_actual;
 	bool fits, uclamp_max_fits;
 
 	/*
@@ -4992,15 +4992,15 @@ static inline int util_fits_cpu(unsigned long util,
 		return fits;
 
 	/*
-	 * We must use arch_scale_cpu_capacity() for comparing against uclamp_min and
+	 * We must use actual_cpu_capacity() for comparing against uclamp_min and
 	 * uclamp_max. We only care about capacity pressure (by using
 	 * capacity_of()) for comparing against the real util.
 	 *
 	 * If a task is boosted to 1024 for example, we don't want a tiny
 	 * pressure to skew the check whether it fits a CPU or not.
 	 *
-	 * Similarly if a task is capped to arch_scale_cpu_capacity(little_cpu), it
-	 * should fit a little cpu even if there's some pressure.
+	 * Similarly if a task is capped to actual_cpu_capacity, it should fit
+	 * the cpu even if there's some pressure.
 	 *
 	 * Only exception is for HW or cpufreq pressure since it has a direct impact
 	 * on available OPP of the system.
@@ -5011,7 +5011,7 @@ static inline int util_fits_cpu(unsigned long util,
 	 * For uclamp_max, we can tolerate a drop in performance level as the
 	 * goal is to cap the task. So it's okay if it's getting less.
 	 */
-	capacity_orig = arch_scale_cpu_capacity(cpu);
+	capacity_actual = get_actual_cpu_capacity(cpu);
 
 	/*
 	 * We want to force a task to fit a cpu as implied by uclamp_max.
@@ -5039,7 +5039,7 @@ static inline int util_fits_cpu(unsigned long util,
 	 *     uclamp_max request.
 	 *
 	 *   which is what we're enforcing here. A task always fits if
-	 *   uclamp_max <= capacity_orig. But when uclamp_max > capacity_orig,
+	 *   uclamp_max <= capacity_actual. But when uclamp_max > capacity_actual,
 	 *   the normal upmigration rules should withhold still.
 	 *
 	 *   Only exception is when we are on max capacity, then we need to be
@@ -5050,8 +5050,8 @@ static inline int util_fits_cpu(unsigned long util,
 	 *     2. The system is being saturated when we're operating near
 	 *        max capacity, it doesn't make sense to block overutilized.
 	 */
-	uclamp_max_fits = (capacity_orig == SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE);
-	uclamp_max_fits = !uclamp_max_fits && (uclamp_max <= capacity_orig);
+	uclamp_max_fits = (capacity_actual == SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE);
+	uclamp_max_fits = !uclamp_max_fits && (uclamp_max <= capacity_actual);
 	fits = fits || uclamp_max_fits;
 
 	/*
@@ -5086,8 +5086,7 @@ static inline int util_fits_cpu(unsigned long util,
 	 * handle the case uclamp_min > uclamp_max.
 	 */
 	uclamp_min = min(uclamp_min, uclamp_max);
-	if (fits && (util < uclamp_min) &&
-	    (uclamp_min > get_actual_cpu_capacity(cpu)))
+	if (fits && (util < uclamp_min) && (uclamp_min > capacity_actual))
 		return -1;
 
 	return fits;
-- 
2.25.1


