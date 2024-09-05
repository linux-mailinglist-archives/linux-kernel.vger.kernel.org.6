Return-Path: <linux-kernel+bounces-317602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DCD96E0EA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 19:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7C971C24DB8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 17:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F951A257F;
	Thu,  5 Sep 2024 17:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QA2FDKB7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F225A19DFB8
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 17:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725556433; cv=none; b=gLbBMrVWsnv9IwohwqN6GaagUwEjKJrsyiV3GpIe27Bn3J4tP1LmHcTIPeVxXtL/pOfVqdPWfAuqfhjiFBbrZp30GqptfYMd2ty1yVV/qX+hnKBm2x3xUn+pmU11mpEMsL6T+KayCLgHRPDi3nacihu1XJRry9Pg4JnA2/7ChCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725556433; c=relaxed/simple;
	bh=OKsws4AYyTGeGlOnUqGnm9T+Wb0mx3BnDDnBXSbo06g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lpYZ27LK0lWA36Nteif6gQbISbmR/bPmFZibxO9MecDPoohbpYNH3KeHUxAmzpi2rUr8eLuMTtv7mARnCpLTahzC/G3/ymqZ9SRaJfREK2gyfj2ap6PaS4iaLYhO6Kn8VgmpA8vj6auMwy2GRgJdv13OsD09fcEqfYkCgjtwBkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QA2FDKB7; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725556432; x=1757092432;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OKsws4AYyTGeGlOnUqGnm9T+Wb0mx3BnDDnBXSbo06g=;
  b=QA2FDKB7fkmaLC3oQlZUzmX78GxAvUVRF1stKOyPs/F7nABNyGI3e2Qv
   As7rKsJpN1mhdHAtMPTiJBCYE295zRzI3DozIBBdkYW5kxIy2kvfUSfOy
   tT5zvgApw34i997zr7/2ia+uhJ+yFMVIYKWnd29YHUTRukOVbEigRHc/N
   uLsEkGXobmvAQxJH10Lug6IyGGIOt34bAkrM1BHka/YIQNvf/7pYFg3kd
   CwQyGLns9RxSjeIImHBEpOlWdeB1rJKTvweJ7+Ru8oYWjPOl8o9a46M8B
   FWbYGpBtlBTys89G7Ng1W8cpTyZe8yUXMNIyKxze0Kz8QNy++qzu7lPOk
   g==;
X-CSE-ConnectionGUID: Ffg5hfHDSm6Ve0wWVg0qrg==
X-CSE-MsgGUID: foyYbklXR8OO2AtdjvaSSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="34863342"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="34863342"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 10:13:52 -0700
X-CSE-ConnectionGUID: t+S3g3I7Q+Kc8My2JXJOcg==
X-CSE-MsgGUID: 8O8VSu/cQgSr5sGAN0d3HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="65409979"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 05 Sep 2024 10:13:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5D4D331E; Thu, 05 Sep 2024 20:13:46 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ingo Molnar <mingo@kernel.org>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] sched/fair: Mark cfs_bandwidth_used() and m*_vruntime() with __maybe_unused
Date: Thu,  5 Sep 2024 20:12:10 +0300
Message-ID: <20240905171210.267626-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When cfs_bandwidth_used() is unused, it prevents kernel builds
with clang, `make W=1` and CONFIG_WERROR=y:

kernel/sched/fair.c:526:19: error: unused function 'max_vruntime' [-Werror,-Wunused-function]
  526 | static inline u64 max_vruntime(u64 max_vruntime, u64 vruntime)
      |                   ^~~~~~~~~~~~
kernel/sched/fair.c:6580:20: error: unused function 'cfs_bandwidth_used' [-Werror,-Wunused-function]
 6580 | static inline bool cfs_bandwidth_used(void)
      |                    ^~~~~~~~~~~~~~~~~~

Fix this by marking them with __maybe_unused (all cases for the sake of
symmetry).

See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
inline functions for W=1 build").

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/sched/fair.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9057584ec06d..b9d35675db50 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -523,7 +523,7 @@ void account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec);
  * Scheduling class tree data structure manipulation methods:
  */
 
-static inline u64 max_vruntime(u64 max_vruntime, u64 vruntime)
+static inline __maybe_unused u64 max_vruntime(u64 max_vruntime, u64 vruntime)
 {
 	s64 delta = (s64)(vruntime - max_vruntime);
 	if (delta > 0)
@@ -532,7 +532,7 @@ static inline u64 max_vruntime(u64 max_vruntime, u64 vruntime)
 	return max_vruntime;
 }
 
-static inline u64 min_vruntime(u64 min_vruntime, u64 vruntime)
+static inline __maybe_unused u64 min_vruntime(u64 min_vruntime, u64 vruntime)
 {
 	s64 delta = (s64)(vruntime - min_vruntime);
 	if (delta < 0)
@@ -5547,7 +5547,7 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
 #ifdef CONFIG_JUMP_LABEL
 static struct static_key __cfs_bandwidth_used;
 
-static inline bool cfs_bandwidth_used(void)
+static inline __maybe_unused bool cfs_bandwidth_used(void)
 {
 	return static_key_false(&__cfs_bandwidth_used);
 }
@@ -5562,7 +5562,7 @@ void cfs_bandwidth_usage_dec(void)
 	static_key_slow_dec_cpuslocked(&__cfs_bandwidth_used);
 }
 #else /* CONFIG_JUMP_LABEL */
-static bool cfs_bandwidth_used(void)
+static inline __maybe_unused bool cfs_bandwidth_used(void)
 {
 	return true;
 }
@@ -6577,7 +6577,7 @@ static void sched_fair_update_stop_tick(struct rq *rq, struct task_struct *p)
 
 #else /* CONFIG_CFS_BANDWIDTH */
 
-static inline bool cfs_bandwidth_used(void)
+static inline __maybe_unused bool cfs_bandwidth_used(void)
 {
 	return false;
 }
-- 
2.43.0.rc1.1336.g36b5255a03ac


