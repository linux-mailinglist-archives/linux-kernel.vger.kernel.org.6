Return-Path: <linux-kernel+bounces-253822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4FD93277A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41381F22CB6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDE117CA05;
	Tue, 16 Jul 2024 13:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kv8ILBqv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343D319AD6A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721136547; cv=none; b=fNb88m7ITXTSqGh/jpZTUZEuV2m+DJNAkF2GoWzeNk0o+hUaJA0/63tFeeRv83TgkcmHaKLSrtj1mI73P45/O4ydPQ0bn+g+VnCtmNi7ajwbOaFM3C4TUcQDZ8kb6OExRFb40nX0w0pl7xxRdg7jHvskDVh6X/NAZQlRHwHqYaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721136547; c=relaxed/simple;
	bh=en2hpGCOSWHtJ/B1AM+dr+mAW08W/xS33ztxUMt1+Vo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M1gF8sDtnl1eN0I7Wpa+LTtUFBv2FUj3iMExRQdRWvpBe5aa/EVx3u/Z+SGXdG+sIGYKH1EZfzEBxz4karMJsUtlA7xh1p2PaCxnxb7OkPmcFa49/zsf6JHJVDvKhJy0R1ncpEGkeVztVBFj3Y2tbdtv8+NQs6W6cHnI7tNuOdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kv8ILBqv; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721136546; x=1752672546;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=en2hpGCOSWHtJ/B1AM+dr+mAW08W/xS33ztxUMt1+Vo=;
  b=Kv8ILBqvaYTcb73/82CsoeTV9utPAAOWacT37RROdH1VI2upLJNDBgEg
   610D+4p9Cr+/ScGEIaoi5GmgSzlcdlz70SKD4i2Opefjp8RXLEnD0lxaw
   tJG8Sj5WBHRgzMx3+Cp+jCz7L7KYtgNObmBJMJvsogJ+tBsHQ4EEcU50H
   B1t1xj5fVpwugwCjeQ56gyWnMTYRkITRSfmO/dhSZQPIx33d+QBa5ETBN
   vS/Gz4pinJKY1/XPd0ZSpeXz/zoLqoQLvZgsQqsBAblmBPij8g3GmPSTt
   8sWbJQo4w0yZkX7CkF92ZPKr1e4vB07Qlk6kbz6douyTWHyi9ue8Noa52
   w==;
X-CSE-ConnectionGUID: nLFZLsS4R3umg4gqIY2Xhg==
X-CSE-MsgGUID: bP6wzWsLQxWrySjvfsL55Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="29250652"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="29250652"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 06:29:05 -0700
X-CSE-ConnectionGUID: dJPDN9VLRGKcpeMjn4vcYg==
X-CSE-MsgGUID: HDexv/yeT3+D54G7UI/KCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="55158751"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa004.jf.intel.com with ESMTP; 16 Jul 2024 06:29:05 -0700
From: kan.liang@linux.intel.com
To: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	peterz@infradead.org,
	mingo@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kan Liang <kan.liang@linux.intel.com>,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH] perf jevents: Don't stop at the first matched pmu when searching a events table
Date: Tue, 16 Jul 2024 06:29:51 -0700
Message-Id: <20240716132951.1748662-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The "perf all PMU test" fails on a Coffee Lake machine.

The failure is caused by the below change in the commit e2641db83f18
("perf vendor events: Add/update skylake events/metrics").

+    {
+        "BriefDescription": "This 48-bit fixed counter counts the UCLK cycles",
+        "Counter": "FIXED",
+        "EventCode": "0xff",
+        "EventName": "UNC_CLOCK.SOCKET",
+        "PerPkg": "1",
+        "PublicDescription": "This 48-bit fixed counter counts the UCLK cycles.",
+        "Unit": "cbox_0"
     }

The other cbox events have the unit name "CBOX", while the fixed counter
has a unit name "cbox_0". So the events_table will maintain separate
entries for cbox and cbox_0.

The perf_pmus__print_pmu_events() calculates the total number of events,
allocate an aliases buffer, store all the events into the buffer, sort,
and print all the aliases one by one.

The problem is that the calculated total number of events doesn't match
the stored events in the aliases buffer.

The perf_pmu__num_events() is used to calculate the number of events. It
invokes the pmu_events_table__num_events() to go through the entire
events_table to find all events. Because of the
pmu_uncore_alias_match(), the suffix of uncore PMU will be ignored. So
the events for cbox and cbox_0 are all counted.

When storing events into the aliases buffer, the
perf_pmu__for_each_event() only process the events for cbox.

Since a bigger buffer was allocated, the last entry are all 0.
When printing all the aliases, null will be outputted, and trigger the
failure.

The mismatch was introduced from the commit e3edd6cf6399 ("perf
pmu-events: Reduce processed events by passing PMU"). The
pmu_events_table__for_each_event() stops immediately once a pmu is set.
But for uncore, especially this case, the method is wrong and mismatch
what perf does in the perf_pmu__num_events().

With the patch,
$ perf list pmu | grep -A 1 clock.socket
   unc_clock.socket
        [This 48-bit fixed counter counts the UCLK cycles. Unit: uncore_cbox_0
$ perf test "perf all PMU test"
  107: perf all PMU test                                               : Ok

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/all/202407101021.2c8baddb-oliver.sang@intel.com/
Fixes: e3edd6cf6399 ("perf pmu-events: Reduce processed events by passing PMU")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/pmu-events/jevents.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index ac9b7ca41856..97a3b018f865 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -923,7 +923,7 @@ int pmu_events_table__for_each_event(const struct pmu_events_table *table,
                         continue;
 
                 ret = pmu_events_table__for_each_event_pmu(table, table_pmu, fn, data);
-                if (pmu || ret)
+                if (ret)
                         return ret;
         }
         return 0;
-- 
2.38.1


