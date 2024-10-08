Return-Path: <linux-kernel+bounces-355764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D94479956BA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A206C28310F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B2B213EFF;
	Tue,  8 Oct 2024 18:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TJ2pfb3o"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A942213ED7
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 18:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412541; cv=none; b=IVGR2LmYVUDYKsARIt79dR8xAIHrPRL9JKs8xEjkNxC7uqy6NrUFUeIX70E3IDgSE9qVP29+HU9xWYXAcMb9GnK6IDJSTnOKZIhlGnAMAeGh9fzTDzHhqAX+NM2lexzgP6Ofw/eQ0euGBNeOb1oUZ+0QnUFGFM2mJGhlgBtTNGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412541; c=relaxed/simple;
	bh=NF8wAROMOzFMcdExLwjtr/ohn+EHVISxj9yvB+SoDkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ksrmb6CqjH4G8ofxBzjokZOAAZccXkBn+r1VFZdZLCisrhgk5NbAdBEEamATgg2EPkzYD+nx8sOLFLxnKQ5MrAdyyYbetg5W9REtXMwChuBx3mut3EauYfwfkO7XYM2iPcHva3duJDL+PGfQbmj+SoQ3wgwLSxoO3DVYFFWFapE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TJ2pfb3o; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728412540; x=1759948540;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NF8wAROMOzFMcdExLwjtr/ohn+EHVISxj9yvB+SoDkg=;
  b=TJ2pfb3ocJRzE0VAUpg/5GkRoahQUIY2fll2kAdyK4FqzZd/c2Zm+LAN
   Iz93S+G9SysqOq9CbU6602oPGToUucyPOuLy94ZYRRWIxw21ZxUkNxVos
   h7rt8ImHFoWSpxUHOKdJBmxNr2OPht3KLR4A5lLBH2iBlPizCAbpreWlU
   vIqaqq+pvm4e+039hcKVCYTOF2WUCGc/WdcjYQSraka//dZeFc81kT/kK
   Lu560X1MbUIXFCqmFZQ/FtIoWAWV4haOKDQ/ZSdKoJfPOHP+2N+1xLLJa
   nN9KtJip6uRL6nxyIMij8xhajF16w6r6F6V2aqECVAkgwcHfxL6I3WGY3
   w==;
X-CSE-ConnectionGUID: qP5xhnqyRiGhJAwS0jdeaQ==
X-CSE-MsgGUID: z7J5eEOjSwCGXPWGVbKeAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="38295344"
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="38295344"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 11:35:39 -0700
X-CSE-ConnectionGUID: uW9SEAZ9SHi/ZAaJsRS5Sw==
X-CSE-MsgGUID: wmi9BkTXSzOHjlW7L/92sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="80530912"
Received: from ldmartin-desk2.corp.intel.com (HELO ldmartin-desk2.intel.com) ([10.125.110.138])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 11:35:38 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
	Ian Rogers <irogers@google.com>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 2/5] perf: Move free outside of the mutex
Date: Tue,  8 Oct 2024 13:34:58 -0500
Message-ID: <20241008183501.1354695-3-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008183501.1354695-1-lucas.demarchi@intel.com>
References: <20241008183501.1354695-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's not needed to hold the mutex to free the percpu variables stored in
pmu. Move them outside of the mutex protection in preparation for
possibly allowing them to live longer, according to the lifecycle of the
object owning/containing the pmu.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 kernel/events/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3b8b85adb10a..6395dbf67671 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11845,7 +11845,6 @@ void perf_pmu_unregister(struct pmu *pmu)
 	synchronize_srcu(&pmus_srcu);
 	synchronize_rcu();
 
-	free_percpu(pmu->pmu_disable_count);
 	idr_remove(&pmu_idr, pmu->type);
 	if (pmu_bus_running && pmu->dev && pmu->dev != PMU_NULL_DEV) {
 		if (pmu->nr_addr_filters)
@@ -11853,8 +11852,11 @@ void perf_pmu_unregister(struct pmu *pmu)
 		device_del(pmu->dev);
 		put_device(pmu->dev);
 	}
-	free_pmu_context(pmu);
+
 	mutex_unlock(&pmus_lock);
+
+	free_percpu(pmu->pmu_disable_count);
+	free_pmu_context(pmu);
 }
 EXPORT_SYMBOL_GPL(perf_pmu_unregister);
 
-- 
2.46.2


