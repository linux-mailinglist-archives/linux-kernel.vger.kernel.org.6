Return-Path: <linux-kernel+bounces-215101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 787B9908E32
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB59D28BDDC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA13317FAA4;
	Fri, 14 Jun 2024 15:03:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0271AD9FF
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377381; cv=none; b=kqj9bJbm0PazFV6Pm6t6AQPInkUobbbllKj4j5RtESCQ0E+MIObfYBy0pljbz6YBFZr0jQeUNE7Fm4hsj98iEzRxuFrG57kJXrav44geWMR3KOGf3Ow740jmp+2lbfPcugfHi0q9HeqWqKeOdAYeWISeJIb/sAt7qxnEoghW6vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377381; c=relaxed/simple;
	bh=/nxzx6XM4ztv30myhh5qXB7yzV0eEKB/Q0ERFzhYLDo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MZpl93ZpH6T4Sfk/1MiX+ve5CPYEpa6zGi5GfqPzSXkiuBhynAku5V+SoxBYaBImYIWJEl2Mj622WKOeJTMagRkTpunrcbSpe3mILhlTGUbh+IshiKSCqMzOjrwzihMZhclG5f3A0Liipvp5HXqpT7h4YsJAIuQzUHbjFCghmIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEBF81BF7;
	Fri, 14 Jun 2024 08:03:23 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 52A333F5A1;
	Fri, 14 Jun 2024 08:02:56 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	James Morse <james.morse@arm.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	peternewman@google.com,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>
Subject: [PATCH v3 33/38] x86/resctrl: Move is_mba_sc() out of core.c
Date: Fri, 14 Jun 2024 15:00:28 +0000
Message-Id: <20240614150033.10454-34-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240614150033.10454-1-james.morse@arm.com>
References: <20240614150033.10454-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

is_mba_sc() is defined in core.c, but has no callers there. It does
not access any architecture private structures.

Move this to rdtgroup.c where the majority of callers are. This makes
the move of the filesystem code to /fs/ cleaner.

Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v2:
 * This patch is new.
---
 arch/x86/kernel/cpu/resctrl/core.c     | 15 ---------------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 258e0a945f87..cb8119d58c30 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -160,21 +160,6 @@ static inline void cache_alloc_hsw_probe(void)
 	rdt_alloc_capable = true;
 }
 
-bool is_mba_sc(struct rdt_resource *r)
-{
-	if (!r)
-		r = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
-
-	/*
-	 * The software controller support is only applicable to MBA resource.
-	 * Make sure to check for resource type.
-	 */
-	if (r->rid != RDT_RESOURCE_MBA)
-		return false;
-
-	return r->membw.mba_sc;
-}
-
 /*
  * rdt_get_mb_table() - get a mapping of bandwidth(b/w) percentage values
  * exposed to user interface and the h/w understandable delay values.
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 0936a4cddc9e..f13b5b0404e4 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1500,6 +1500,21 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
 	return size;
 }
 
+bool is_mba_sc(struct rdt_resource *r)
+{
+	if (!r)
+		r = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
+
+	/*
+	 * The software controller support is only applicable to MBA resource.
+	 * Make sure to check for resource type.
+	 */
+	if (r->rid != RDT_RESOURCE_MBA)
+		return false;
+
+	return r->membw.mba_sc;
+}
+
 /*
  * rdtgroup_size_show - Display size in bytes of allocated regions
  *
-- 
2.39.2


