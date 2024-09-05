Return-Path: <linux-kernel+bounces-316382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6C296CEC7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B1D31C2299C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBB218C345;
	Thu,  5 Sep 2024 05:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nNv3pHrD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B601898EB
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 05:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725515695; cv=none; b=uKTMHhYh8ZERv5sGftZhndUf9tg8Au8Cj8oER9bTu94gnQ4twxIRQpIe02p5sDSZ2DeVU22pvYtSsHz7a9GtBgP+a5/yHtJpbet/02ZSu8weGwaOEtCcSuynq3B0RsqzZ1j0fy1mMp5Y0pveoDvIyqmzyoGiJywxqdPesCUpVmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725515695; c=relaxed/simple;
	bh=IoEbX8ulS4nbWpyE+m+Af6Xb8Zi/WPdDMRA2qcoZ2Vk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=q2tIjMZ/yV2pQkB94IDx9JKz1ggiugzBX1mXlGFeq+sjGmb/GMoZbbc88od9+hkzHE/dEB6KWRJX8Xshy1/o96K1I6upSpEo9sulbHFz9cHqZXzOrE31zlhUkkIHlKvHx0SLFMg3UyEUM9Bsy/OvOv8NuYyq+6h+EmA1ILnkXyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nNv3pHrD; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725515693; x=1757051693;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=IoEbX8ulS4nbWpyE+m+Af6Xb8Zi/WPdDMRA2qcoZ2Vk=;
  b=nNv3pHrDfrzXlOnZvAR1e9xMm8gkclfFzukasj98PAOsHa+AgrePqtgP
   FTLBTPn4OKUQZbiMvK4+uPS2gAyOthyUp8pxSRwVjq3cl1l7F4ZRG0Aed
   vK3bqQBXgRCuGp6NgDoaoZqzxKMzyfTqW4AzPFmmarvCiTEuPT1rq2IxB
   q2ka3oHR3bvLP/aq6YRDpMGZZsh1qlDhRhXiT6kvb+xvU0kFK9IZOGNSb
   CRoxO8yGs+BbwTZ6ExiCjgjJwZDfdwS6Qr0gzOGIHuO3XQ6smyemPOTUD
   Ron7buylPA22QmWPZ8lq9yAd4t8E0FqrMR6XFy8Kkev8r0oXBOQYksawF
   g==;
X-CSE-ConnectionGUID: Zf2HuIOnSL2OAPo0gFRBQw==
X-CSE-MsgGUID: 3Pvzm9H2Q3C8Rbzqk5sVOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="35567211"
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="35567211"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 22:54:51 -0700
X-CSE-ConnectionGUID: /KnsrvVgRESsnoDRbQ1YLg==
X-CSE-MsgGUID: MIeozWI0R2a6JzHwHSOiOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="70421572"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa004.jf.intel.com with ESMTP; 04 Sep 2024 22:54:50 -0700
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
Subject: [PATCH v6 4/4] x86/cacheinfo: Clean out init_cache_level()
Date: Wed,  4 Sep 2024 23:00:36 -0700
Message-Id: <20240905060036.5655-5-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240905060036.5655-1-ricardo.neri-calderon@linux.intel.com>
References: <20240905060036.5655-1-ricardo.neri-calderon@linux.intel.com>
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


