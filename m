Return-Path: <linux-kernel+bounces-240111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 199C992693D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 22:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B73CC1F230EF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 20:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3990418FC82;
	Wed,  3 Jul 2024 20:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TK3OCq0c"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC7B567D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 20:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720037006; cv=none; b=p63QDBpvCsQf00VnD213TYYQq+n45KgfCp+QrrWFEpsEr4ubiiRk3NXDkyQUOab1anpFKcTefi7cL9jR1sQnY6L7BWBTsOBpWkvg5l5XqQksm+SOCAnOO2dzdvzc4dF7hq512/L/Vp4IbvRxoQN6GEyesYpTtxfsUR+GdlUH3DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720037006; c=relaxed/simple;
	bh=1lnmijjEyM+iKRxKs5E+zqzgewb6VXfpWqoba3U+K2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eWeFkjemHuAXCgQNd7LFlhiXmoMQVNFd9H8qTbO6JJtIP68scz58VRdCCWgiImngIN+qZTKNt53HRT2m3IMvjpoJS7F4h1kN3+vBaQ2BHVNgVbpWRR0Z/NbXwcHQ2vmM7yeZSuJ5LiwVkrABblCzGgZ0SRoo6kvubXjcpW5BcJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TK3OCq0c; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720037005; x=1751573005;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1lnmijjEyM+iKRxKs5E+zqzgewb6VXfpWqoba3U+K2Q=;
  b=TK3OCq0cd2SVP6s8cLGqs9WrnMj4WXKTRbxizot3luuJLEOM4fGwL/Le
   cBAzt6oliT2XNK17aKmkBS4pyjIuyV8ilPYYnSaI9s3kuhdoE9v2aALr2
   2D29rzFNh2Rdk71LUaLxoXacuX80UJ2JzYvmTGU5ClGtrpeycL8wCVBZr
   ag72cmvvXcOi/eJ67jRIr5c1Rh5z7uDfKBA82tJlx4Zvb0I+UXFT1sVl6
   NrHIsyTB9aqlunscgxoNmDTFPMr/X4LFEHXPFgu6PVEBI4cN4V813ktpI
   6/Cu22vEHC5Xznu9xLuGKoCgIlOgsU/4gnP02SBd7nsQVrW6F80HQHEUW
   g==;
X-CSE-ConnectionGUID: jOYy8V41TEaIM+ltSfKLKA==
X-CSE-MsgGUID: XS1wBnRLQPC9YkQmpfGrCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="39807563"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="39807563"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 13:03:24 -0700
X-CSE-ConnectionGUID: Y5WAf1T+SeS/YCSKEmZ/rg==
X-CSE-MsgGUID: sxmAv0xBR3etZDlum39Epw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="46442543"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa010.fm.intel.com with ESMTP; 03 Jul 2024 13:03:23 -0700
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
Subject: [PATCH 1/9] perf report: Fix --total-cycles --stdio output error
Date: Wed,  3 Jul 2024 13:03:48 -0700
Message-Id: <20240703200356.852727-2-kan.liang@linux.intel.com>
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

The --total-cycles may output wrong information with the --stdio.

For example,
  perf record -e "{cycles,instructions}",cache-misses -b sleep 1
  perf report --total-cycles --stdio

The total cycles output of {cycles,instructions} and cache-misses are
almost the same.

 # Samples: 938  of events 'anon group { cycles, instructions }'
 # Event count (approx.): 938
 #
 # Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles
 # ...............  ..............  ...........  ..........
  ..................................................>
 #
           11.19%            2.6K        0.10%          21
                          [perf_iterate_ctx+48 -> >
            5.79%            1.4K        0.45%          97
            [__intel_pmu_enable_all.constprop.0+80 -> __intel_>
            5.11%            1.2K        0.33%          71
                             [native_write_msr+0 ->>

 # Samples: 293  of event 'cache-misses'
 # Event count (approx.): 293
 #
 # Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles
                                                  [>
 # ...............  ..............  ...........  ..........
   ..................................................>
 #
           11.19%            2.6K        0.13%          21
                          [perf_iterate_ctx+48 -> >
            5.79%            1.4K        0.59%          97
[__intel_pmu_enable_all.constprop.0+80 -> __intel_>
            5.11%            1.2K        0.43%          71
                             [native_write_msr+0 ->>

With the symbol_conf.event_group, the perf report should only report the
block information of the leader event in a group.
However, the current implementation retrieves the next event's block
information, rather than the next group leader's block information.

Make sure the index is updated even if the event is skipped.

With the patch,

 # Samples: 293  of event 'cache-misses'
 # Event count (approx.): 293
 #
 # Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles
                                                  [>
 # ...............  ..............  ...........  ..........
   ..................................................>
 #
           37.98%            9.0K        4.05%         299
   [perf_event_addr_filters_exec+0 -> perf_event_a>
           11.19%            2.6K        0.28%          21
                          [perf_iterate_ctx+48 -> >
            5.79%            1.4K        1.32%          97
[__intel_pmu_enable_all.constprop.0+80 -> __intel_>

Fixes: 6f7164fa231a ("perf report: Sort by sampled cycles percent per block for stdio")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/builtin-report.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 9718770facb5..b9f22c5321da 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -565,6 +565,7 @@ static int evlist__tty_browse_hists(struct evlist *evlist, struct report *rep, c
 		struct hists *hists = evsel__hists(pos);
 		const char *evname = evsel__name(pos);
 
+		i++;
 		if (symbol_conf.event_group && !evsel__is_group_leader(pos))
 			continue;
 
@@ -574,7 +575,7 @@ static int evlist__tty_browse_hists(struct evlist *evlist, struct report *rep, c
 		hists__fprintf_nr_sample_events(hists, rep, evname, stdout);
 
 		if (rep->total_cycles_mode) {
-			report__browse_block_hists(&rep->block_reports[i++].hist,
+			report__browse_block_hists(&rep->block_reports[i - 1].hist,
 						   rep->min_percent, pos, NULL);
 			continue;
 		}
-- 
2.38.1


