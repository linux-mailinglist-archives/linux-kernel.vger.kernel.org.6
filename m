Return-Path: <linux-kernel+bounces-304686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B935596238E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 772D1285FAB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FA116BE29;
	Wed, 28 Aug 2024 09:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mY91gBjX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB6516B72D
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 09:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724837723; cv=none; b=NUV+De5frFB/eZLC+aN7cyBA+XOmJKozUAPD1C2XaE3Pd+LdTvxQxnQCVpeh2nTfikU7Cw2jvu1kO4ND0cRihH0w+sOWNAuZKiqjJgWtR/GHPxK97lEBMp/OENBu8JWsIsMhBWjH2Kdje+r+CQIqmFEt1KjW2pP+4kRUpFhCv1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724837723; c=relaxed/simple;
	bh=AeqSRk7TDyGPqnrVN5BCXf4W+HLcFRFHZnOza8fR2pk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=smZx8+xL9bpGhdqB5boDv1tlV6tJ5a6T4FXevYdfkgRD2Knb82I7Qqkmk4k0UNq1zkyiWc6eQ/AS56sSwB6F2KykMIQrGHUWFQeWaF4LBgBCwXe7L0T8WISyzP1GSQ9HU4ivvXdrl68082yYEkOw/5zAAcpk81SZKyvWs4zk54k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mY91gBjX; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724837722; x=1756373722;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AeqSRk7TDyGPqnrVN5BCXf4W+HLcFRFHZnOza8fR2pk=;
  b=mY91gBjXwrYhmh8oWmdTKam610nXreXJuAZuVzlJ8WfOsdLSRWHiFuBB
   zV74INHQre2KpW9u9NvcQwNtKlef/KRlOuoku31JGwtmAOpuAtWW/mQJ4
   lstnpaDehzv3Oh/6OCFkx9HqXtdkDSHzbZ2D8Zj/bZwr7YX+x4Qx7EyY0
   JTBuE0O7fFTL4Ag0NvPpsXdLFgmkXaRjuVXpBh0AOLt2MdCfBvsjZDNFX
   Q2AL1YkwKdXiMbovLQ31Tw/5KB6UcvR7ikLLa965W46EwMjY3kI/r8+VV
   R/3uDS5z0vQa5cjnNpCNYKwZkB/96I0aG7Wbv+LCcxXt1J/rkXiaRk1jh
   g==;
X-CSE-ConnectionGUID: N4zZ0IuLTEi4MoXjoFBFXQ==
X-CSE-MsgGUID: R2eLHdPPQpahbKu3PBwcSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="34763868"
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="34763868"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 02:35:17 -0700
X-CSE-ConnectionGUID: pxwLaIv9QNKK2iVMFyiFEg==
X-CSE-MsgGUID: ToDHsLGZRnyyoT3XdFWnww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="100678971"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by orviesa001.jf.intel.com with ESMTP; 28 Aug 2024 02:35:16 -0700
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org
Cc: nanhai.zou@intel.com,
	wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v5 1/3] mm: Define obj_cgroup_get() if CONFIG_MEMCG is not defined.
Date: Wed, 28 Aug 2024 02:35:14 -0700
Message-Id: <20240828093516.30228-2-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240828093516.30228-1-kanchana.p.sridhar@intel.com>
References: <20240828093516.30228-1-kanchana.p.sridhar@intel.com>
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
index fe05fdb92779..f693d254ab2a 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1281,6 +1281,10 @@ struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css)
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


