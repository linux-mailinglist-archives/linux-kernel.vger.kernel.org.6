Return-Path: <linux-kernel+bounces-225432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C93D91306C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 00:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE670B26C0B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 22:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC12416FF4E;
	Fri, 21 Jun 2024 22:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YPE1w11t"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C98616F292
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 22:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719009556; cv=none; b=V3NpGTcgNr/UGNLD4Xme18Tp+dLIbwRp36kmZd9mEkSkSFQNkkl3jM/t/3+o3C7PIFcd9q2Omv35LZFp/uNKVwddzlW1RtRwCm2EjO0Abm6CfNQpoy46yk61J5OUy1bOdeoflWB/oui/8ZMa1mW4DFvrdtsBrFsww5rkh098k54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719009556; c=relaxed/simple;
	bh=SH3mTIpDj2uEXUy+GY0B7A3UVMKQH25ecx2M84QmrdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NR2er6H0IYR0+XM98FvKJsmpdZB2RvVCOEL/FrnnAr/VEdggugYlw/H8BIcrSFLF/00X5cQRXY9CbDmaiuoahnzbhMcUS14nNdww6KP6DjOW+3ev/2ji4UAwkeMPAWF8rumXhDMZD/Tn73j6lrqFd1fKeUxCJzAzt/ZrgoB0opI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YPE1w11t; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719009554; x=1750545554;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SH3mTIpDj2uEXUy+GY0B7A3UVMKQH25ecx2M84QmrdU=;
  b=YPE1w11tXnAcJNkVP8j0jKmw4zTrDbAJs6tdXI6V60pl2JoHicVPO5Q+
   o0xMdlhk60+o/cxcDu/yAxThqtrj3+0GQLy80HLhQd9FkjJGpm+zH2O2X
   1WPXRxSF3xgPFiPT65RdNnt2C0ShVLNNfto7lAXoN6P+r8Ru5OxJ6ZgUv
   r61U+tXXJjOu9ApPcgUzUvHSBIyAtinQ1vCdGoglPvybV92xM4nnjpEcv
   ua5X2CKLWwRL305+diO8KiOyIaEgEC/yTKUeaHJGSQ20EFeu5HG3C2f0E
   vDyREqPBiTI5geKXk5Wn1PKCh2yJMAhVjA0q1RyDZ/W9AAOewWQZnX75a
   g==;
X-CSE-ConnectionGUID: /2Jx8v00SzGnPkOB+ZYd/A==
X-CSE-MsgGUID: Bo8gbLycTnOPyRDyk+/gEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11110"; a="26691284"
X-IronPort-AV: E=Sophos;i="6.08,256,1712646000"; 
   d="scan'208";a="26691284"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 15:39:07 -0700
X-CSE-ConnectionGUID: MMG+Pmc3R7GPU7RjBYBL1A==
X-CSE-MsgGUID: 4gqPE+SxTqqV35Fm2BqZLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,256,1712646000"; 
   d="scan'208";a="73935651"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 15:39:07 -0700
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Dave Martin <Dave.Martin@arm.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v21 05/18] x86/resctrl: Add node-scope to the options for feature scope
Date: Fri, 21 Jun 2024 15:38:46 -0700
Message-ID: <20240621223859.43471-6-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240621223859.43471-1-tony.luck@intel.com>
References: <20240621223859.43471-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently supported resctrl features are all domain scoped the same as the
scope of the L2 or L3 caches.

Add RESCTRL_L3_NODE as a new option for features that are scoped at the
same granularity as NUMA nodes. This is needed for Intel's Sub-NUMA
Cluster (SNC) feature where monitoring features are divided between
nodes that share an L3 cache.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 include/linux/resctrl.h            | 1 +
 arch/x86/kernel/cpu/resctrl/core.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index aa2c22a8e37b..64b6ad1b22a1 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -176,6 +176,7 @@ struct resctrl_schema;
 enum resctrl_scope {
 	RESCTRL_L2_CACHE = 2,
 	RESCTRL_L3_CACHE = 3,
+	RESCTRL_L3_NODE,
 };
 
 /**
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index b4f2be776408..b86c525d0620 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -510,6 +510,8 @@ static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
 	case RESCTRL_L2_CACHE:
 	case RESCTRL_L3_CACHE:
 		return get_cpu_cacheinfo_id(cpu, scope);
+	case RESCTRL_L3_NODE:
+		return cpu_to_node(cpu);
 	default:
 		break;
 	}
-- 
2.45.2


