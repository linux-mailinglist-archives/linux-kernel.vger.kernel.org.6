Return-Path: <linux-kernel+bounces-539342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAF2A4A353
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FF603BF49E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB27B280A50;
	Fri, 28 Feb 2025 20:00:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F74280A3E
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 20:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772826; cv=none; b=Lm/TtjP0rtReU4v6q/8OYubKxGuhjsYHMSduOBrVusR/cD9e2g64vTh48MbuOfqOtH0niayC2LkVujBlpG2aaBsV6xSvlsBHDNoMKQCUHKVJKzweMh530ujqIRNn+s3/PZYb+SqJp/Lj5lewzBdEgnH5dS3kWvUQZQIGaa5qlLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772826; c=relaxed/simple;
	bh=7nJ1v0KRf1cCuc57f6TfCUwxN2Ydyl0zrm6x1Fy50Do=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VY6cAzqVQqb8MqpfHzMwmE7Z01MQwL54Bq57tMdb41LO0+PMYgqZyIeoAAy7aFAhdH2m78PeGMmcmz3sA6dRimzS6vbR2/V82IUxNUBfDi3Yc3VKd033tMTG0dS27pqX7GbW+yyIPnoc79LzRoLQ9LR03w2/dkSSLIYAdi7wfEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83AAB1515;
	Fri, 28 Feb 2025 12:00:39 -0800 (PST)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E1F83F5A1;
	Fri, 28 Feb 2025 12:00:20 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
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
	Dave Martin <dave.martin@arm.com>,
	Koba Ko <kobak@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	fenghuay@nvidia.com,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v7 07/49] x86/resctrl: Add max_bw to struct resctrl_membw
Date: Fri, 28 Feb 2025 19:58:31 +0000
Message-Id: <20250228195913.24895-8-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250228195913.24895-1-james.morse@arm.com>
References: <20250228195913.24895-1-james.morse@arm.com>
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

Deriving the maximum or default value from the schema format would
avoid the architecture code having to tell resctrl such obvious
things as the maximum percentage is 100, and the maximum bitmap
is all ones.

Maximum bandwidth is always going to vary per platform. Add
max_bw as a special case. This is currently used for the maximum
MBA percentage on Intel platforms, but can be removed from the
architecture code if 'percentage' becomes a schema format resctrl
supports directly.

This value isn't needed for other schema formats.

This will allow the default_ctrl to be generated from the schema
properties when it is needed.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since v5:
 * Removed redundant setting of schema_fmt on AMD platforms.
 * Fixed off by one in cbm_validate().

Changes since v2:
 * This patch is new.
---
 arch/x86/kernel/cpu/resctrl/core.c        | 2 ++
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 4 ++--
 include/linux/resctrl.h                   | 2 ++
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 754fb65565ec..4504a12efc97 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -212,6 +212,7 @@ static __init bool __get_mem_config_intel(struct rdt_resource *r)
 	hw_res->num_closid = edx.split.cos_max + 1;
 	max_delay = eax.split.max_delay + 1;
 	r->default_ctrl = MAX_MBA_BW;
+	r->membw.max_bw = MAX_MBA_BW;
 	r->membw.arch_needs_linear = true;
 	if (ecx & MBA_IS_LINEAR) {
 		r->membw.delay_linear = true;
@@ -250,6 +251,7 @@ static __init bool __rdt_get_mem_config_amd(struct rdt_resource *r)
 	cpuid_count(0x80000020, subleaf, &eax, &ebx, &ecx, &edx);
 	hw_res->num_closid = edx + 1;
 	r->default_ctrl = 1 << eax;
+	r->membw.max_bw = 1 << eax;
 
 	/* AMD does not use delay */
 	r->membw.delay_linear = false;
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 59610b209b4e..23a01eaebd58 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -63,9 +63,9 @@ static bool bw_validate(char *buf, u32 *data, struct rdt_resource *r)
 		return true;
 	}
 
-	if (bw < r->membw.min_bw || bw > r->default_ctrl) {
+	if (bw < r->membw.min_bw || bw > r->membw.max_bw) {
 		rdt_last_cmd_printf("MB value %u out of range [%d,%d]\n",
-				    bw, r->membw.min_bw, r->default_ctrl);
+				    bw, r->membw.min_bw, r->membw.max_bw);
 		return false;
 	}
 
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index e1a982adef45..465f3cf8c4bc 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -165,6 +165,7 @@ enum membw_throttle_mode {
 /**
  * struct resctrl_membw - Memory bandwidth allocation related data
  * @min_bw:		Minimum memory bandwidth percentage user can request
+ * @max_bw:		Maximum memory bandwidth value, used as the reset value
  * @bw_gran:		Granularity at which the memory bandwidth is allocated
  * @delay_linear:	True if memory B/W delay is in linear scale
  * @arch_needs_linear:	True if we can't configure non-linear resources
@@ -175,6 +176,7 @@ enum membw_throttle_mode {
  */
 struct resctrl_membw {
 	u32				min_bw;
+	u32				max_bw;
 	u32				bw_gran;
 	u32				delay_linear;
 	bool				arch_needs_linear;
-- 
2.39.5


