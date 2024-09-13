Return-Path: <linux-kernel+bounces-327771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 664CF977AEC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 10:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4DBB2841FE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 08:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713281D6DA6;
	Fri, 13 Sep 2024 08:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SWk22Rrs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6883D1D6C58
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 08:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726215977; cv=none; b=pEOdqXHc3OoRohFytodLEhEVsg/mb23o243gObZy4KLcfyZQtWMa5aQAmfgJEj6LlnFbIhrr69tjBn80NgWFqDGhwppogkkOjwQtYUziplGZlVGJbLMvc/hZtnJgE+sDs36bCubkggjuj1ND8btFIvmTFZn0bZ+hylVPYa/sGe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726215977; c=relaxed/simple;
	bh=IoEbX8ulS4nbWpyE+m+Af6Xb8Zi/WPdDMRA2qcoZ2Vk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Or3j6fxz0ffcGAIGeI5wSUTHRfdZ6n35P1JI5zayl/7N9LrAFWOWjjnDF1bC1OW43Khh4gWQ5jy0Z+iOuCEcxgbhMt1+AhbcQsQP+wk1N+iqweCJD7JIhzAC5BhCTXoc3mtCtmZL9HPK1QNuVmEjpghivABh6K8D7WSlbhP+GiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SWk22Rrs; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726215976; x=1757751976;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=IoEbX8ulS4nbWpyE+m+Af6Xb8Zi/WPdDMRA2qcoZ2Vk=;
  b=SWk22RrsJp3MIbIh07EGCRgFBuuqX0G+zqRl2kDdSvaYB3rZp10afpWG
   QhxQIM/PzspU0wVSTJREGslNgjUGD3m9J9LgaEzbe0hBeFhmT3nbyZOxJ
   mX4zEzZnHUILRf6gG87QvDmQ7e1NPLVuSG9USICe5AaWz7Cu2kiD1d8i0
   eGRT5MvAze31Jfy3LyfDW2LeSTT0Lf1JZdIWARHG3bLoh/P8ySvKVC10d
   +WmpAQKXAHryj09jKfLOjAz9vRGqTct71iRt7gv2kwRXPFSYE6bhVqlyz
   gCpE4nFKshspOnuCq2zqEx0sQPUuWGxrv7fbBu0YRmogsGbehuOs6tYjm
   w==;
X-CSE-ConnectionGUID: Dj+LItcpTJeUK35COsSuMg==
X-CSE-MsgGUID: SLDCI23MTryT7pVfDTlbFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="24977584"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="24977584"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 01:26:14 -0700
X-CSE-ConnectionGUID: 8MuaZbElSnmVru6ZKiyLgg==
X-CSE-MsgGUID: Cqe4l4oeQB2xCFCi1JsDVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="68485439"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa007.jf.intel.com with ESMTP; 13 Sep 2024 01:26:13 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: x86@kernel.org
Cc: Andreas Herrmann <aherrmann@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Len Brown <len.brown@intel.com>,
	Radu Rendec <rrendec@redhat.com>,
	Pierre Gondois <Pierre.Gondois@arm.com>,
	Pu Wen <puwen@hygon.cn>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Will Deacon <will@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Huang Ying <ying.huang@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/3] x86/cacheinfo: Clean out init_cache_level()
Date: Fri, 13 Sep 2024 01:31:55 -0700
Message-Id: <20240913083155.9783-4-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240913083155.9783-1-ricardo.neri-calderon@linux.intel.com>
References: <20240913083155.9783-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

init_cache_level() no longer has a purpose on x86. It no longer needs to
set num_leaves, and it never had to set num_levels, which was unnecessary
on x86.

Replace it with "return 0" simply to override the weak function, which
would return an error.

Reviewed-by: Andreas Herrmann <aherrmann@suse.de>
Reviewed-by: Len Brown <len.brown@intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Tested-by: Andreas Herrmann <aherrmann@suse.de>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Cc: Andreas Herrmann <aherrmann@suse.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Chen Yu <yu.c.chen@intel.com>
CC: Huang Ying <ying.huang@intel.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Nikolay Borisov <nik.borisov@suse.com>
Cc: Radu Rendec <rrendec@redhat.com>
Cc: Pierre Gondois <Pierre.Gondois@arm.com>
Cc: Pu Wen <puwen@hygon.cn>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Will Deacon <will@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: stable@vger.kernel.org # 6.3+
---
Changes since v5:
 * Added Reviewed-by tag from Nikolay and Andreas. Thanks!

Changes since v4:
 * None

Changes since v3:
 * Rebased on v6.7-rc5.

Changes since v2:
 * None

Changes since v1:
 * Introduced this patch.
---
 arch/x86/kernel/cpu/cacheinfo.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 182cacd772b8..2a37f14cc6b1 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -1002,11 +1002,6 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
 
 int init_cache_level(unsigned int cpu)
 {
-	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
-
-	if (!this_cpu_ci)
-		return -EINVAL;
-	this_cpu_ci->num_levels = 3;
 	return 0;
 }
 
-- 
2.34.1


