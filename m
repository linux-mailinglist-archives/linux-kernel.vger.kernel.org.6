Return-Path: <linux-kernel+bounces-202895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1478FD297
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 18:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C25F1C23A53
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5905188CD5;
	Wed,  5 Jun 2024 16:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cmFtgbHt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1961553B3
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 16:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717604081; cv=none; b=aW8nAGe9zbg26Vw0Esq7FtEuXb5ZPT86PR57l0+naPUmLU5rfGGs5uWYcpOZIPIxQbNIipfry9NOJrkcAtgG362ulUhkCuJy71cWQ+eGTIIgeHdQZ935l6JEiyPY/VVPWYbkJcLOkTin5qQFGgPknpHUmspCPd5NQTPMM/pZBwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717604081; c=relaxed/simple;
	bh=yanHfd6jlJmGT0zmUR9ubQ+HVlgEg5ygOb5UbWWoM5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dy0pJOf9RgndyZ0vtwTrhjAfSh+nuXMRcbEYEhGzECYvvDah3DwqIh2KZ5zWEQ3S6jNEEGQA2j1DrFhBOumIGUEXZsrSMgqm+u220QYoamHaRSMWlPn4ZZgvDtOX70wrAi5SQul9udVOGQiSFBrNP8SN9mPdlqBxcSW4cgwQ77o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cmFtgbHt; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717604079; x=1749140079;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yanHfd6jlJmGT0zmUR9ubQ+HVlgEg5ygOb5UbWWoM5o=;
  b=cmFtgbHt6hfcggoHIqGOyKzpnlG5suMufYExESWAxYU+OcSO8lQqJ4Kq
   LMOX+n10u3sy9Z/EFGcHOedpGeDRM74pIscniGmzuvMkWbn3XIbAH8Cz2
   SKP2wa/51ZFPTSaGPbIVFZ36PZBr99lR7I+AP2injn+yOe52SazSaKDPR
   i721aGLnJ8nyyi/nHmcnaMM451dDsYSy8vQYP58oxUN1uX/GGCRMeGTlM
   K21L9BWfndbMspZTi9CHMzE3A+MeiQlBIGOLwrBXQ/MSBWUIFajFTdrw2
   CjDa2XAmrrGo2HqSLOcks2Jp0AUZ55aaG684yn29wk/VyorpQ7ZiKQldJ
   w==;
X-CSE-ConnectionGUID: p4X7r8y3RCSn9o2VdHqHNQ==
X-CSE-MsgGUID: GNi/YDXITiWV+R8uvCX3aQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="31772289"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="31772289"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 09:14:37 -0700
X-CSE-ConnectionGUID: AQuyBpvDQACNsZSEi0KIFw==
X-CSE-MsgGUID: YmYw7eXRSMuVIMIaAiQw7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="42581898"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 09:14:36 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Dave Martin <Dave.Martin@arm.com>,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v2 1/3] cacheinfo: Add function to get cacheinfo for a given (cpu, cachelevel)
Date: Wed,  5 Jun 2024 09:14:25 -0700
Message-ID: <20240605161427.312994-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240605161427.312994-1-tony.luck@intel.com>
References: <20240605161427.312994-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resctrl code open codes a search for information about a given cache
level in a couple of places (and more are on the way).

Provide a new inline function get_cpu_cacheinfo_level() in
<linux/cacheinfo.h> to do the search and return a pointer to
the cacheinfo structure.

Simplify the existing get_cpu_cacheinfo_id() by using this new
function to do the search.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 include/linux/cacheinfo.h | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index 2cb15fe4fe12..b4d99052d186 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -113,10 +113,11 @@ int acpi_get_cache_info(unsigned int cpu,
 const struct attribute_group *cache_get_priv_group(struct cacheinfo *this_leaf);
 
 /*
- * Get the id of the cache associated with @cpu at level @level.
+ * Get the cacheinfo structure for the cache associated with @cpu at
+ * level @level.
  * cpuhp lock must be held.
  */
-static inline int get_cpu_cacheinfo_id(int cpu, int level)
+static inline struct cacheinfo *get_cpu_cacheinfo_level(int cpu, int level)
 {
 	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(cpu);
 	int i;
@@ -124,12 +125,23 @@ static inline int get_cpu_cacheinfo_id(int cpu, int level)
 	for (i = 0; i < ci->num_leaves; i++) {
 		if (ci->info_list[i].level == level) {
 			if (ci->info_list[i].attributes & CACHE_ID)
-				return ci->info_list[i].id;
-			return -1;
+				return &ci->info_list[i];
+			return NULL;
 		}
 	}
 
-	return -1;
+	return NULL;
+}
+
+/*
+ * Get the id of the cache associated with @cpu at level @level.
+ * cpuhp lock must be held.
+ */
+static inline int get_cpu_cacheinfo_id(int cpu, int level)
+{
+	struct cacheinfo *ci = get_cpu_cacheinfo_level(cpu, level);
+
+	return ci ? ci->id : -1;
 }
 
 #ifdef CONFIG_ARM64
-- 
2.45.0


