Return-Path: <linux-kernel+bounces-214959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1A2908CB4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00B421F28125
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 13:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44119D26D;
	Fri, 14 Jun 2024 13:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZQ52wBId"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3161879DE
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 13:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718372874; cv=none; b=hcSN1g1DHIVyYGTf/DGl9Qtp/X/ZDOGIAwgIClNo2Tc238adf96iheY2DIQr0LFhU8ZZ/ENM7csu+2QRmJVl3wpmqJw1Wu16A7FiB2UeiYMe7FQhucp5k5LB5pTBmLejRMWSROpbgShBynyzu+/mWsIx4o27dtaD+J1iz0zhlvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718372874; c=relaxed/simple;
	bh=6AgZGDLslNB+RWTEwU9F5AH76hTo5i/UbmU4dY1Nl1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PMDpjPRNXqpVLQPwwMBB3ZTJEhWHOl1RDsWjWOkaHW3gcerpxLzwnip3JpGSNxI+hQfKnN2oa99EzCMUYsTEwfdcakVRb+OuANNJXiq1qWVtr/OsxHQ5Vq/Zkhb5CROAjx6A1hZZiPEo3VL4153MbZiLXbA/ieUo/fkafSRH3v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZQ52wBId; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718372874; x=1749908874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6AgZGDLslNB+RWTEwU9F5AH76hTo5i/UbmU4dY1Nl1U=;
  b=ZQ52wBId4v8xaMdlCncSeEjVT0JH7qbm48hVFOIA9N7Ojl3NfHJv4lEH
   5AledYc3u+lp6oD/5GIXk8aWnJmhhtFEXmNr9VpOoa5fA4iX4nle9UjUC
   I6lp2Pjk6nWsesAQLUwX+vvJiRcSB+vuruYeGZCzeUDC8VzgwOZuK1Ih0
   KZIAF9yrzVkM8n8mpXKSYuIkhKdtVbJa5LO6Bfy1E4gf+HmLGeiMEqdQp
   NTuVNigdsdWB5V61nP4chfkkPEBjEbbH/6Rk/aZehcn0EQszcw15q3Jvr
   a3prCxuNRwP8dVc5SycRn+8fs1YdgVf0W+N5QyXgqFYP9iatbRQ448+w8
   g==;
X-CSE-ConnectionGUID: ptXLWax6QYmZH/MtLJihMg==
X-CSE-MsgGUID: qtN4HCzARLeElpxpg3Kvtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="19079155"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="19079155"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 06:47:52 -0700
X-CSE-ConnectionGUID: Z+nIzm+kRGio62kx6jb7Fw==
X-CSE-MsgGUID: DkGvG/sdSoOwyApQL+U6Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="40386671"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa006.fm.intel.com with ESMTP; 14 Jun 2024 06:47:51 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@kernel.org,
	linux-kernel@vger.kernel.org
Cc: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	eranian@google.com,
	ak@linux.intel.com,
	yunying.sun@intel.com,
	tim.c.chen@linux.intel.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 3/8] perf/x86/uncore: Retrieve the unit ID from the unit control RB tree
Date: Fri, 14 Jun 2024 06:46:26 -0700
Message-Id: <20240614134631.1092359-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240614134631.1092359-1-kan.liang@linux.intel.com>
References: <20240614134631.1092359-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The box_ids only save the unit ID for the first die. If a unit, e.g., a
CXL unit, doesn't exist in the first die. The unit ID cannot be
retrieved.

The unit control RB tree also stores the unit ID information.
Retrieve the unit ID from the unit control RB tree

Tested-by: Yunying Sun <yunying.sun@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index c2d877d20e31..3ad23527833a 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -862,6 +862,9 @@ static const struct attribute_group uncore_pmu_attr_group = {
 static inline int uncore_get_box_id(struct intel_uncore_type *type,
 				    struct intel_uncore_pmu *pmu)
 {
+	if (type->boxes)
+		return intel_uncore_find_discovery_unit_id(type->boxes, -1, pmu->pmu_idx);
+
 	return type->box_ids ? type->box_ids[pmu->pmu_idx] : pmu->pmu_idx;
 }
 
-- 
2.35.1


