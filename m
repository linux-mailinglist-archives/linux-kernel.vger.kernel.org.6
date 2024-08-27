Return-Path: <linux-kernel+bounces-302609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E79F79600D5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 07:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA361F23034
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 05:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA18145A07;
	Tue, 27 Aug 2024 05:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kXLHy4By"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421F371B3A
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 05:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724735382; cv=none; b=mWpUJh8QYb4pPziWNn8d+lxNeU/IbLcqlCj+eoivrqgRfEAF9JZyHyEA5z7cJ3QWt7+NKZYl9H4jlBRGsiK9bVYdUAb29GCzaXwEWw5gH5YjaUcYjUr8zB7hfOkJoNnszdwYi+qxi0KI9B8l/b4O49KI0VXWW/4/4eS6YBtqrfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724735382; c=relaxed/simple;
	bh=Fxb9EB2+t66KeDUfeYI2ZYfBCt/W8W8Cq7hOkfJ7WVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=O2LP7Tk+wXK6xf56+OiTFeo6dCpdOyoebm50bagomvbGCeJUMpsxyBDZH+ZtbyosE+q22Go5w0oGp0QHEiVp/P0NSmHFLWfgkZyQzynu0kkxZQ32+n6d2iJ/6/2iSo+BWrHoREpgsVnfbAGBY+3/X65SITJfC3SAhy0zEnA5PXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kXLHy4By; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724735381; x=1756271381;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Fxb9EB2+t66KeDUfeYI2ZYfBCt/W8W8Cq7hOkfJ7WVI=;
  b=kXLHy4ByMVMQPnyuR2l/9yymoouWIVkGr8RsA8+yUr7eSxoKR/zwa/uq
   VYiSJnB7kQd5fea4dE+exXtrqJcn9zaaTOvSGfzC5j0CenjO+2UqxhW3E
   /OdiEf6XOdyh/vv7l0t90kv0xmiV66sJWWmpF+QtEBpG/WTEsTWaGYcGE
   xhKxSsdhu5v9T8E5ehwu4+0rltp20PXFUoZorcB9/tN/oNcy7LOJBZz3f
   9OHAKX0aqDD66TL4vkr/BGQ8JiLfUGuZfngPnmuH11m7tholAo2YrYlju
   ThR7vmRnD531u5GJzUghVMSDlHlTjjFJY6uk1BqvMgDTciuGfjrnBQYqE
   g==;
X-CSE-ConnectionGUID: WsD1bKuHT3OtDPdjbsQu1Q==
X-CSE-MsgGUID: 6cvHIx4mTbut/0DwZKol6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="13230488"
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="13230488"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 22:09:39 -0700
X-CSE-ConnectionGUID: QqkpBhfQTISliPkxHFC2yw==
X-CSE-MsgGUID: vX9VQROrRSafoMbq527X4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="62703865"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa009.jf.intel.com with ESMTP; 26 Aug 2024 22:09:39 -0700
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
Subject: [PATCH v5 4/4] x86/cacheinfo: Clean out init_cache_level()
Date: Mon, 26 Aug 2024 22:16:35 -0700
Message-Id: <20240827051635.9114-5-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240827051635.9114-1-ricardo.neri-calderon@linux.intel.com>
References: <20240827051635.9114-1-ricardo.neri-calderon@linux.intel.com>
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

Reviewed-by: Len Brown <len.brown@intel.com>
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
index b5e216677a46..d7375328bc1f 100644
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


