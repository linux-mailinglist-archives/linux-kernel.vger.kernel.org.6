Return-Path: <linux-kernel+bounces-307715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 632539651EE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E4C91F251FF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86BB1B81DE;
	Thu, 29 Aug 2024 21:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LI816hmi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7577C1B5820
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 21:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724966832; cv=none; b=RAO8vv0C1Y7kxiGwJ2aO0sfV/HI4Oc4C8ZShZVq9ODXVfCxhZNdWGHhhn7RQF5OB5yB2FV94aitYAgMJ/S4mR2HTTKnnIPr+kot8Klae7/PttaXBmNMoiAvGppjjm4b/wZtAA+It4Q/33uFueuBBJldvY/CUua32ESXMjn9btFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724966832; c=relaxed/simple;
	bh=j6MRHvvdb4Y/ecSm2gb8TOi+Txe+Ci0dZeAdkAYjrOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BxnkqAF1VDPue7SGQQ4hkF3q9sP5ESwPdidoiQgnH9lc0m4mgXbltxX+wrzr08M9Fv01aI1Dqju38ERRy2OrUlfO7K5dfBMYh/YJAmkGLWagoYbwOVagUI/g6VHUxXgunv8hZUEPTWuIgijD+821uGF3z4MPV17cwQI/+rvA40A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LI816hmi; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724966830; x=1756502830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j6MRHvvdb4Y/ecSm2gb8TOi+Txe+Ci0dZeAdkAYjrOU=;
  b=LI816hmi1KTigAySKdsWXCiwArOHE9hGK1nrvXin7zczSuMuHWvJ/drb
   ZOiNCZS1u/tmKZ+DfKglo/sKL05HqaZROzLKrV6oqNrHfJPBHN+5NdJ5H
   ghgEtdSMRo3i8rmP+gBQOcPzKOe57EYBnBn9jD6pRs76ZNvZRH7TsSLMu
   UybhpdePV8BmVIP4lOJUhCWKkZrcVa7Jr9TEq1Un+WuuFJZL0Snt8UKY9
   a0SI1yrDyksXDs7ur+u9xMxiZ2VZVI8Yc/SM+Hyjius0F+v0SkmWEIs+f
   mtxLUXZsjwzD9y1j89QMDOxPCF9/z3OJ1egCnGHm+EIXKO0OWIxXCv1l2
   Q==;
X-CSE-ConnectionGUID: 9X3MQI49RNaQU0a/yZOQ2g==
X-CSE-MsgGUID: 1sfq+gvCSYGcRy6Pr7J7Zw==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="23455194"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="23455194"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 14:27:06 -0700
X-CSE-ConnectionGUID: 4beK6VF2R0i5a3dChDlt9Q==
X-CSE-MsgGUID: hxyTs7R9S0yeZGOx0Drw4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="68365406"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by fmviesa004.fm.intel.com with ESMTP; 29 Aug 2024 14:27:07 -0700
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	usamaarif642@gmail.com,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org
Cc: nanhai.zou@intel.com,
	wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v6 1/3] mm: Define obj_cgroup_get() if CONFIG_MEMCG is not defined.
Date: Thu, 29 Aug 2024 14:27:03 -0700
Message-Id: <20240829212705.6714-2-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240829212705.6714-1-kanchana.p.sridhar@intel.com>
References: <20240829212705.6714-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This resolves an issue with obj_cgroup_get() not being defined if
CONFIG_MEMCG is not defined.

Before this patch, we would see build errors if obj_cgroup_get() is
called from code that is agnostic of CONFIG_MEMCG.

The zswap_store() changes for mTHP in subsequent commits will require
the use of obj_cgroup_get() in zswap code that falls into this category.

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 include/linux/memcontrol.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 34d2da05f2f1..15c2716f9aa3 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1282,6 +1282,10 @@ struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css)
 	return NULL;
 }
 
+static inline void obj_cgroup_get(struct obj_cgroup *objcg)
+{
+}
+
 static inline void obj_cgroup_put(struct obj_cgroup *objcg)
 {
 }
-- 
2.27.0


