Return-Path: <linux-kernel+bounces-240119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8825F926945
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 22:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 432BD287EC9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 20:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E18194A61;
	Wed,  3 Jul 2024 20:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IlkwOoVo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0C019412A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 20:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720037011; cv=none; b=R/JYzwD3SxUwabaDtBrMVs2zt/D7VQ/ftc+aG+6HkeyK4zdnmfBAy+JVlXBz4ATFSLdu3fCsmofzfth/AUSCViscTfId6XalGWG0zWmlJM9tR7N1Q1LvBDlIZXORbqpVcO3r8z4Auq/rPZ/nwscx0XM7HTDKctFfCCCTEQvWQsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720037011; c=relaxed/simple;
	bh=eRSy0qosXqU6Hszy6JkiW6BncOZYM9c0YyE7hCnYkgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s7Cu6Gb6S5no6sEd7uBd3vraGuK56dsf2gx1JthGCwsjlvshxwA4BQq7lhq3Nf/eMGtixR/VLGakd/vcvhc7Wi7Av/1PAkbS5bnNBUg0HRn2NFwSlQEz68Dz/hAEYhB/EECfxPdpzspv+k7kisJfFrkxN0mjOhkggRaj7+NCqwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IlkwOoVo; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720037010; x=1751573010;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eRSy0qosXqU6Hszy6JkiW6BncOZYM9c0YyE7hCnYkgM=;
  b=IlkwOoVowcbw7vH5Sr9KncvpQF/AG50DkNmgdawzf4bHh9REVlAfwRYV
   uHej9ijd+/Y56ZM/h1mhqQBMVfbm65xaFl+q8ywuNtWPExJ+Ei5neA6pe
   f1KYk0RhTApEDeG5AZKTnEJNXazO8Svg9RuVsKJ4UwxNN5gw+RcZA5dGP
   zFqVJ9tqYAeZjS/UiFTtb5KZD0vu90BdNbb3RSw+xJfL0P8s02Jhl4V/Y
   QacoAzeYvJrgdpJe3r0NSCjK0++eyraZGEcoWJky4ojazPst3cfMOq9Zr
   DiWQ5n6DbKCLj0f23Z5wGUJaQ8sW1GqSU6NW62ea8VygCJHaeZWRR0dwo
   Q==;
X-CSE-ConnectionGUID: im7fI0/nTvmqNS7Dx7cWow==
X-CSE-MsgGUID: SLv3lBlRQtOy75ez/jU4uA==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="39807626"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="39807626"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 13:03:29 -0700
X-CSE-ConnectionGUID: SN1ao3b9Sp+D4mhQnnaw3Q==
X-CSE-MsgGUID: fm4DWIJJTG+of/o+lV4OAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="46442622"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa010.fm.intel.com with ESMTP; 03 Jul 2024 13:03:28 -0700
From: kan.liang@linux.intel.com
To: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	peterz@infradead.org,
	mingo@kernel.org,
	linux-kernel@vger.kernel.org
Cc: adrian.hunter@intel.com,
	ak@linux.intel.com,
	eranian@google.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 9/9] perf test: Add new test cases for the branch counter feature
Date: Wed,  3 Jul 2024 13:03:56 -0700
Message-Id: <20240703200356.852727-10-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240703200356.852727-1-kan.liang@linux.intel.com>
References: <20240703200356.852727-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Enhance the test case for the branch counter feature.

Now, the test verifies
- The new filter can be successfully applied on the supported platforms.
- The counter value can be outputted via the perf report -D
- The counter value and the abbr name can be outputted via the
  perf script (New)

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/tests/shell/record.sh | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 3d1a7759a7b2..7964ebd9007d 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -21,6 +21,7 @@ testprog="perf test -w thloop"
 cpu_pmu_dir="/sys/bus/event_source/devices/cpu*"
 br_cntr_file="/caps/branch_counter_nr"
 br_cntr_output="branch stack counters"
+br_cntr_script_output="br_cntr: A"
 
 cleanup() {
   rm -rf "${perfdata}"
@@ -165,7 +166,7 @@ test_workload() {
 }
 
 test_branch_counter() {
-  echo "Basic branch counter test"
+  echo "Branch counter test"
   # Check if the branch counter feature is supported
   for dir in $cpu_pmu_dir
   do
@@ -175,19 +176,25 @@ test_branch_counter() {
       return
     fi
   done
-  if ! perf record -o "${perfdata}" -j any,counter ${testprog} 2> /dev/null
+  if ! perf record -o "${perfdata}" -e "{branches:p,instructions}" -j any,counter ${testprog} 2> /dev/null
   then
-    echo "Basic branch counter test [Failed record]"
+    echo "Branch counter record test [Failed record]"
     err=1
     return
   fi
   if ! perf report -i "${perfdata}" -D -q | grep -q "$br_cntr_output"
   then
-    echo "Basic branch record test [Failed missing output]"
+    echo "Branch counter report test [Failed missing output]"
     err=1
     return
   fi
-  echo "Basic branch counter test [Success]"
+  if ! perf script -i "${perfdata}" -F +brstackinsn,+brcntr | grep -q "$br_cntr_script_output"
+  then
+    echo " Branch counter script test [Failed missing output]"
+    err=1
+    return
+  fi
+  echo "Branch counter test [Success]"
 }
 
 test_per_thread
-- 
2.38.1


