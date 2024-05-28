Return-Path: <linux-kernel+bounces-193159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A970F8D27DE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 00:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64B8C288E1A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022C913E41A;
	Tue, 28 May 2024 22:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jt7vrM2L"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B4613E3E8
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 22:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716934821; cv=none; b=RoQnAUuIofC0GY8cT9WTBiywHZZHssLaq+IJMfadr6XBzzoLO4pYcRkFnyo7gQYYcDI/SJqP/ulFoLUnYx1MeDkQEeo2BtZfvcBFQNiMZXBMFFMfWjz+wbGg7SK4wtaQ6JNK0X4URMVFRnF49MnW9+goCeji944pN13nxYM7H9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716934821; c=relaxed/simple;
	bh=rn0KrBbaxmxIvcwnUxg9RXSoxA6CbEQejJ+AMhDKEk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eci3zl9MwzbzvJWfzOsoBr48YSFYBHzvkQ8DK7ONl9Oi1FqMbofarX9J+x/C/CVuDkA+TiWIsuNHVKagJyYBTysX1jfTZ+DZxgRdo8INOOVO/9usfqh0/5D3OOqI0A1TMCBFb3Iu4pFlpnCrwPekmP/ti/X3/ww3HVwSRJRIR8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jt7vrM2L; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716934820; x=1748470820;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rn0KrBbaxmxIvcwnUxg9RXSoxA6CbEQejJ+AMhDKEk0=;
  b=jt7vrM2LXJwMMZ28hWwqVzaao0l41knt9ItwGw06Q2ZSqkK0CHMOSH0U
   M9Omlu/BM4CZ6BWcf6JoeiHtc97PQhnWWS2+LY9tAMlWVk/rUajyKpjEN
   uhk5GPgXbRH2JKGCKqDj0lJMPKGxeVA1biZsfIaSMfCAOVD7PCiJeUwVH
   LoaooccCOcJSuzCbuFEOBj0nsrPj1XS277PJLVyJaZ/R4gpnupjtKnbjY
   QQRmRUh94iUlQ0vKtJHXom9ZYdDVdlDWMwNXQPXMdfJdJ2HORYw8PTnY9
   LKNi+7JYmR4FNRXV/V1Pf305Vf8kAXBDpZB5psi5Rwds2THaWU9wQw8oP
   A==;
X-CSE-ConnectionGUID: Uzcbj/MMT5OjPlBl78AAjw==
X-CSE-MsgGUID: rt7HWSZpTVGGuZ8UYQq9Fg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="30812167"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="30812167"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 15:20:16 -0700
X-CSE-ConnectionGUID: M7/367ZzQhair+rR5lcFNg==
X-CSE-MsgGUID: VYdtSlOZQm+m2JExil5zUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="40090725"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 15:20:16 -0700
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
Subject: [PATCH v19 05/20] x86/resctrl: Add node-scope to the options for feature scope
Date: Tue, 28 May 2024 15:19:50 -0700
Message-ID: <20240528222006.58283-6-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240528222006.58283-1-tony.luck@intel.com>
References: <20240528222006.58283-1-tony.luck@intel.com>
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
2.45.0


