Return-Path: <linux-kernel+bounces-240112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4469E92693E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 22:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C354EB21D26
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 20:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FBC18FC81;
	Wed,  3 Jul 2024 20:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h1LyIaPS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CD8138495
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 20:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720037007; cv=none; b=n2EilQhHJhbZ3nBgx0adKXUnYHvfNIfgSZ/dBDK/4svQDSw3eZid1VZuFdEn9iQmk+b2pFBnnzXmpcpTJIsHoJX/Il/uE8x+7C377nDFonLmNgUn0uf1V6uTOn7SUqFkKgrp49qs8BuM1WjQWADe7BfmAqyhC22ZARbVBZQMwvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720037007; c=relaxed/simple;
	bh=Vaax5cGGtoogj26pRgneNRu+6h5uUKF5KLvkOclKNA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OGNZ6YsNuGb6REons9SqaZKiZ/UI0ilxRjVFcc+Zrg8zWo4JtyNKv8Q9342gNOGHanGIr2KAWZc+UL3q151oTGyAWOb30OhW1A2d8R/JiatAbV4MJEZ4cm6rJJimiIux4nBvBLPQyaf1OgDgzRflk9S+oYy9IX+6j+PMxKAXEJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h1LyIaPS; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720037006; x=1751573006;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vaax5cGGtoogj26pRgneNRu+6h5uUKF5KLvkOclKNA0=;
  b=h1LyIaPS7y/5bikmW5GxMKAVNTmTrhw2P0NOyXE6Xz/ahIICagpMPs/K
   1eHYezNB5whBOQW58vVoZKtNGeqvPIxdcinwYVrocrRNKv0GiUgqCa7Xh
   XubdxfdwEOyg4O9cITOCa8q8XhO+B0J2MQDCl1o8VqDD2b2PH8q+YloH4
   M/ivg2s6+T7PrcXGTJvMk3Ngf/2aNkOEDMFrCWTFLhr5uwb66i6oPJ7d0
   2y8EMeL6rTtNF6a8L0+r32PBznhHE/17TIMkbg1DNrJicmxrBLduPOagL
   GrindiUU7bgpGkA2j3NLYi2dR+p3bjw49PQ8p38M9vRmAIChAJNTMZ/QC
   g==;
X-CSE-ConnectionGUID: /61+Nte2T/qzs7NtYhmBog==
X-CSE-MsgGUID: MdTPXA8wQqquiYtGCHQBGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="39807567"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="39807567"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 13:03:24 -0700
X-CSE-ConnectionGUID: eMHOJnlmR3qSo51fIsEGtg==
X-CSE-MsgGUID: F+mjZy/aTHGCt4BZhZ2uzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="46442554"
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
Subject: [PATCH 2/9] perf report: Remove the first overflow check for branch counters
Date: Wed,  3 Jul 2024 13:03:49 -0700
Message-Id: <20240703200356.852727-3-kan.liang@linux.intel.com>
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

A false overflow warning is triggered if a sample doesn't have any LBRs
recorded and the branch counters feature is enabled.

The current code does OVERFLOW_CHECK_u64() at the very beginning when
reading the information of branch counters. It assumes that there is at
least one LBR in the PEBS record. But it is a valid case that 0 LBR is
recorded especially in a high context switch.

Remove the OVERFLOW_CHECK_u64(). The later OVERFLOW_CHECK() should be
good enough to check the overflow when reading the information of the
branch counters.

Fixes: 9fbb4b02302b ("perf tools: Add branch counter knob")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/evsel.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index bc603193c477..a5dd031c9080 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2810,8 +2810,6 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		array = (void *)array + sz;
 
 		if (evsel__has_branch_counters(evsel)) {
-			OVERFLOW_CHECK_u64(array);
-
 			data->branch_stack_cntr = (u64 *)array;
 			sz = data->branch_stack->nr * sizeof(u64);
 
-- 
2.38.1


