Return-Path: <linux-kernel+bounces-232965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D823591B099
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 22:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9511128227E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 20:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365EA1A08AB;
	Thu, 27 Jun 2024 20:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VM/Fq2Gh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837BB1A00CE
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 20:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719520753; cv=none; b=BIKhrjbSmGUasmNC5xhiixj+7lsTXGnl8W4J8Izm1tkE3fQ5Ycxu1Kv+gbvv0iHQk8PyJANGe4oIavXIUrCWfNvGYC29+2Aq4tsk7qLFuKOD1O0zO1rq7jRr7+sUBdrdDKAMvUkP/X9ZElzhwDNL0Adt6Wer7VSbO4OJhp9mOro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719520753; c=relaxed/simple;
	bh=SH3mTIpDj2uEXUy+GY0B7A3UVMKQH25ecx2M84QmrdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WjeWdzCPol5wB40jpie4NjVvGkWREvXfCLIn0EpSHivNaqaGiutFIgNYQIbGi2wi8KVnhY4fysThNXaenQ2ZarXFQQx8Zjk0g5cNFnGj8HuhwIJJJs+IiyO/eDFWI7KIa1IfdVp2oaUY/aWtBMAKdqrKLNpvTJKy4FqdwkPkSf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VM/Fq2Gh; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719520752; x=1751056752;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SH3mTIpDj2uEXUy+GY0B7A3UVMKQH25ecx2M84QmrdU=;
  b=VM/Fq2GhlV3ZTUXiim72nVqJTtYrU/Mu5kMHTNMGKjTR6vILNCybn6La
   MaAHTZ9DXLP8IU0QqspWTvn8ETF45pSUZaw1uDrgjGAEmvcZl2YlmkzVi
   KveHS/RqWev9uIPHkdEwjMx94v9s+bduHie2+Mo1RQD8hD6pSxDOGE3fJ
   RTaij56Qid2gEOPSk8OtyeCe6OAFDprKpO1JDeJSaBhMd/xtIMa6rQDma
   mc5OKk1OLCCqAoa3PgNqIyS8hBOmJjuf8Z9o9t5USSMCNDpENpsQMfSRE
   mbA4VYK+icFjr057UcgxjSXFXCUswaE/cwv5FDoPiYqGbJKFTzeXrG4eE
   w==;
X-CSE-ConnectionGUID: rcVk7zT3TLiqGzY6Oi1oUg==
X-CSE-MsgGUID: SS0DmevMRfSgC5emP9B8Zw==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16809770"
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="16809770"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 13:39:08 -0700
X-CSE-ConnectionGUID: YACErSB9SQGOkU8NeO0PFQ==
X-CSE-MsgGUID: 1Qx2OtIgRbixf/44m7qS8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="82052891"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 13:39:07 -0700
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
Subject: [PATCH v22 05/18] x86/resctrl: Add node-scope to the options for feature scope
Date: Thu, 27 Jun 2024 13:38:43 -0700
Message-ID: <20240627203856.66628-6-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627203856.66628-1-tony.luck@intel.com>
References: <20240627203856.66628-1-tony.luck@intel.com>
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


