Return-Path: <linux-kernel+bounces-234615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B6491C8A8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CF382835D7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6F6823CD;
	Fri, 28 Jun 2024 21:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YZ2jR0MK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE22181204
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719611792; cv=none; b=Qnbr3yyQWDMkU1ghi3ySiGpryqTfXDx6pVMBskAP3MnU+rQIV2XzkrphGM2vH3NCACzqWeA6CyWEwLLNCs9r8ZDPkbca60TTllw38jDVn/gEBYPL9tprou3qaS+Y5F34JdVxA+fLYK1vdU675al5QQV0IAkIXMmlnn3nQuSaCxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719611792; c=relaxed/simple;
	bh=SH3mTIpDj2uEXUy+GY0B7A3UVMKQH25ecx2M84QmrdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YEpaS0DZjIpYYsOtCV4920kVTS5YFJyaJ1TIIZzXq2Jqhe4Um+IRr2PfKRjkg9QDexTlYyk3eCJfrMaoS/qnKGTWWWMlIj7bNtX3R99Uj7/1Bnda74EXxkHJr8eR0xqT5dayXIZSdCCQjFJc1eR+oa7BM+UshdoB0dqFNH1YlCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YZ2jR0MK; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719611791; x=1751147791;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SH3mTIpDj2uEXUy+GY0B7A3UVMKQH25ecx2M84QmrdU=;
  b=YZ2jR0MKX+BoDerWHOifimTJSd10AZ/NVXxvbjIv1/0+HEUETUVM4Ql/
   CqpwG0dnss3JGF4O/r5ph6bG01g0/+AT6gBjYAi0/UNAktZ3sOkVAM1a6
   can3UP2KFHqUYzBa4H6NK+otLb787bCp3ES+NPD/YeKcxd+0y9jelZTY9
   IGfpQJaiMzBnMqoE827/a3x5ofRKzuOfs0V0or60KzUUzOxvFA2N6TaX7
   hRrTbdN4/iqt/0S6NaQqBdv3qN8+iw3boD0MHAxmsbQMwnMdz1fkLFKUU
   KkBLljgfyKysVWwMUun3a6P5lkBrnyo3ET0a5dSPDs1PN+ElQaCjHGf0k
   A==;
X-CSE-ConnectionGUID: 2jc4tULBQzuC/yh+1O1FGw==
X-CSE-MsgGUID: ioodP/VXSs6JlGpZLiD6PA==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="16762560"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="16762560"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 14:56:27 -0700
X-CSE-ConnectionGUID: OaEMUvwKSEygZmBJP1jY4Q==
X-CSE-MsgGUID: GprbUlCxQyqW/PSdqCF41w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="68065648"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 14:56:26 -0700
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
Subject: [PATCH v23 05/19] x86/resctrl: Add node-scope to the options for feature scope
Date: Fri, 28 Jun 2024 14:56:05 -0700
Message-ID: <20240628215619.76401-6-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628215619.76401-1-tony.luck@intel.com>
References: <20240628215619.76401-1-tony.luck@intel.com>
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


