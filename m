Return-Path: <linux-kernel+bounces-215073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BE8908E15
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65BD51F21C76
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CEA17B437;
	Fri, 14 Jun 2024 15:01:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AF6172BC6
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377293; cv=none; b=bEErkf6mi8bzVTrl6eBAIyNFdsJJFmD/bu0hEaGRX7V+qxEd1ziE3MViBOPPkrY6D9fA1NRc/NuotDQ2SR8RzBfWJ1zvPXRfTX0ph0cg9TjJSsUiafJZostj0eES66Ept3/M9KNOmDcJmTVBFso6O+EJiW9+nDC29V9d/WH8OVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377293; c=relaxed/simple;
	bh=WFJ5aV/5WHWPldHZtEdudASPu4h95Zs1yodmhu80Vbc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B8cJyuG7QgU4DNDsEJY0e/6u8nR2fG4Q1sC+M2zqNNUUowKjFzXArSlXr5O30iQ/k0f0LM1Ec6TF8Rvm2qA/a3kdLS8ZoiIDunF6XW+BkuOHzqGr/dLMXxJxuL0d59+GMEMkpgEZaeWguYEGVLvwp3dCC1gXA59xmuaVnajO1nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47A4C15BF;
	Fri, 14 Jun 2024 08:01:56 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF8753F5A1;
	Fri, 14 Jun 2024 08:01:28 -0700 (PDT)
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
Subject: [PATCH v3 07/38] x86/resctrl: Add max_bw to struct resctrl_membw
Date: Fri, 14 Jun 2024 15:00:02 +0000
Message-Id: <20240614150033.10454-8-james.morse@arm.com>
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

__rdt_get_mem_config_amd() and __get_mem_config_intel() both use
the default_ctrl property as a maximum value. This is because the
MBA schema works differently between these platforms. Doing this
complicates determining whether the default_ctrl property belongs
to the arch code, or can be derived from the schema format.

Add a max_bw property for AMD platforms to specify their maximum
MBA bandwidth. This isn't needed for other schema formats.

This will allow the default_ctrl to be generated from the schema
properties when it is needed.

Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v2:
 * This patch is new.
---
 arch/x86/kernel/cpu/resctrl/core.c        | 2 ++
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 9 +++++----
 include/linux/resctrl.h                   | 2 ++
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 4de7d20aa5aa..c1dfc1466e53 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -206,6 +206,7 @@ static bool __get_mem_config_intel(struct rdt_resource *r)
 	hw_res->num_closid = edx.split.cos_max + 1;
 	max_delay = eax.split.max_delay + 1;
 	r->default_ctrl = MAX_MBA_BW;
+	r->membw.max_bw = MAX_MBA_BW;
 	r->membw.arch_needs_linear = true;
 	if (ecx & MBA_IS_LINEAR) {
 		r->membw.delay_linear = true;
@@ -243,6 +244,7 @@ static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
 	hw_res->num_closid = edx + 1;
 	r->default_ctrl = 1 << eax;
 	r->schema_fmt = RESCTRL_SCHEMA_MBPS;
+	r->membw.max_bw = 1 << eax;
 
 	/* AMD does not use delay */
 	r->membw.delay_linear = false;
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 380b88b69c6e..2ef91e748325 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -57,10 +57,10 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
 		return false;
 	}
 
-	if ((bw < r->membw.min_bw || bw > r->default_ctrl) &&
+	if ((bw < r->membw.min_bw || bw > r->membw.max_bw) &&
 	    !is_mba_sc(r)) {
 		rdt_last_cmd_printf("MB value %ld out of range [%d,%d]\n", bw,
-				    r->membw.min_bw, r->default_ctrl);
+				    r->membw.min_bw, r->membw.max_bw);
 		return false;
 	}
 
@@ -108,8 +108,9 @@ static int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
  */
 static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
 {
-	unsigned long first_bit, zero_bit, val;
+	u32 supported_bits = BIT_MASK(r->cache.cbm_len + 1) - 1;
 	unsigned int cbm_len = r->cache.cbm_len;
+	unsigned long first_bit, zero_bit, val;
 	int ret;
 
 	ret = kstrtoul(buf, 16, &val);
@@ -118,7 +119,7 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
 		return false;
 	}
 
-	if ((r->cache.min_cbm_bits > 0 && val == 0) || val > r->default_ctrl) {
+	if ((r->cache.min_cbm_bits > 0 && val == 0) || val > supported_bits) {
 		rdt_last_cmd_puts("Mask out of range\n");
 		return false;
 	}
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index ddcd938972d2..0dee50530847 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -139,6 +139,7 @@ enum membw_throttle_mode {
 /**
  * struct resctrl_membw - Memory bandwidth allocation related data
  * @min_bw:		Minimum memory bandwidth percentage user can request
+ * @max_bw:		Maximum memory bandwidth value, used as the reset value
  * @bw_gran:		Granularity at which the memory bandwidth is allocated
  * @delay_linear:	True if memory B/W delay is in linear scale
  * @arch_needs_linear:	True if we can't configure non-linear resources
@@ -149,6 +150,7 @@ enum membw_throttle_mode {
  */
 struct resctrl_membw {
 	u32				min_bw;
+	u32				max_bw;
 	u32				bw_gran;
 	u32				delay_linear;
 	bool				arch_needs_linear;
-- 
2.39.2


