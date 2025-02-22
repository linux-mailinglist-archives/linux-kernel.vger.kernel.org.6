Return-Path: <linux-kernel+bounces-527141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 706A3A407D7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 12:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDB5D700CF3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 11:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527F820B213;
	Sat, 22 Feb 2025 11:15:27 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E57620ADCF
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740222926; cv=none; b=jlzfpUpmanJd/u4KnVD/6Yn7xa4SjDgX34hcKTl02fjRo2hmacTC4U68ZJefA44JNOrOKh3Vazf7cF6cJ4aSy3l6UVuuoBABXOpl4sef+zGnFSRs6wQ4zVigu7ATTNoMXWjgPFa11GT5E6/Nt5jd66jWMiuMsS52v64qfp2Me3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740222926; c=relaxed/simple;
	bh=vyhLF7JKFB2kr6xXUSjwsji2XVtyeQzKGf5o7v1m04s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gern0DG2HxSI7Q+7hRTyRtgM7H6uwn1re2cDxaXuYxYlz2QQ69XVdPT/SJQyWySAPTXEBRCjPb1yhegtnCnb9IUqCNmQkVrBTPjJsuCg66vnh+NvHSF3HUKmHXfDx2M3gaVSXAQvBsuA2MyFUuiGCSCJWc/XsaF/yErLsDoYvgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Z0PYv46FKznl3F;
	Sat, 22 Feb 2025 19:15:47 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id 248141400CB;
	Sat, 22 Feb 2025 19:15:16 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 22 Feb
 2025 19:15:15 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <Dave.Martin@arm.com>, <james.morse@arm.com>
CC: <bobo.shaobowang@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <jonathan.cameron@huawei.com>
Subject: [PATCH mpam mpam/snapshot/v6.14-rc1 v2 1/5] arm_mpam: Introduce the definitions of intPARTID and reqPARTID
Date: Sat, 22 Feb 2025 19:24:44 +0800
Message-ID: <20250222112448.2438586-2-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250222112448.2438586-1-zengheng4@huawei.com>
References: <20250222112448.2438586-1-zengheng4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf100008.china.huawei.com (7.202.181.222)

The narrow-partid feature in MPAM allows for a more efficient use of
PARTIDs by enabling a many-to-one mapping of reqpartids (requested PARTIDs)
to intpartids (internal PARTIDs). This mapping reduces the number of unique
PARTIDs needed, thus allowing more tasks or processes to be monitored and
managed with the available resources.

Regarding intPARTID, MPAM uses it as the unit for control group
configuration delivery. MPAM will synchronize the delivered configuration
to all reqPARTIDs mapped to the same intPARTIDs. The number of intPARTIDs
is indicated by MPAMF_PARTID_NRW_IDR.INTPARTID_MAX if implemented, or
directly use the number of PARTID as intpartid_max if narrow-partid feature
is not supported.

reqPARTIDs can be used to expand the number of monitors, for each control
group is no longer simply restricted by the range of PMG. By mapping
between intPARTID and reqPARTID, the number of monitors would be greatly
expanded and more fine-grained monitoring under a control group will be
achieved.

As a MPAM driver applicable to general scenarios, it needs to be compatible
with systems not supporting narrow-partid and mixed MSCs (some MSCs support
narrow-partid and some do not) systems.

We determine the number of closids in the following manner:

  reqPARTID-np -- The number of reqPARTIDs supported by MSCs that support
                  narrow-partid.
  intPARTID-np -- The number of intPARTIDs supported by MSCs that support
                  narrow partid.
  PARTID       -- The number of PARTIDs supported by MSCs that do not
                  support narrow partid.

  n - Indicates the maximum number of control groups
  l - Represents the total number of reqpartids
  m - Indicates the number of reqpartids per control group

  n = min(intPARTID-np, PARTID)
  l = min(reqPARTID-np, PARTID)
  m = l // n

To illustrate how to determine n, l, and m through examples, we can assume
a specific example:

l3   - Does not support the narrow PARTID feature, supports a range of 256
       PARTIDs.
mata - Supports the narrow-partid feature, supports 32 intPARTIDs, and
       supports 256 reqPARTIDs.

Then,
n = min(PARTID-l3, intPARTID-mata) = min(256, 32) = 32
l = min(PARTID-l3, reqPARTID-mata) = min(256,256) = 256
m = 256 / 32 = 8

After initialization, the driver determines the 'n' parameter returned by
resctrl_arch_get_num_closid() and the 'l' parameter returned by
get_num_reqpartid().

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 drivers/platform/arm64/mpam/mpam_devices.c  | 12 +++++++++++-
 drivers/platform/arm64/mpam/mpam_internal.h |  2 ++
 drivers/platform/arm64/mpam/mpam_resctrl.c  |  9 +++++++--
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/arm64/mpam/mpam_devices.c b/drivers/platform/arm64/mpam/mpam_devices.c
index 30e94dab6c25..c1b690effe29 100644
--- a/drivers/platform/arm64/mpam/mpam_devices.c
+++ b/drivers/platform/arm64/mpam/mpam_devices.c
@@ -66,6 +66,7 @@ static DEFINE_MUTEX(mpam_cpuhp_state_lock);
  * Generating traffic outside this range will result in screaming interrupts.
  */
 u16 mpam_partid_max;
+u16 mpam_intpartid_max;
 u8 mpam_pmg_max;
 static bool partid_max_init, partid_max_published;
 static DEFINE_SPINLOCK(partid_max_lock);
@@ -217,10 +218,16 @@ int mpam_register_requestor(u16 partid_max, u8 pmg_max)
 	spin_lock(&partid_max_lock);
 	if (!partid_max_init) {
 		mpam_partid_max = partid_max;
+		/*
+		 * Update mpam_intpartid_max here, in case the
+		 * system doesn't have narrow-partid feature.
+		 */
+		mpam_intpartid_max = partid_max;
 		mpam_pmg_max = pmg_max;
 		partid_max_init = true;
 	} else if (!partid_max_published) {
 		mpam_partid_max = min(mpam_partid_max, partid_max);
+		mpam_intpartid_max = min(mpam_intpartid_max, partid_max);
 		mpam_pmg_max = min(mpam_pmg_max, pmg_max);
 	} else {
 		/* New requestors can't lower the values */
@@ -978,7 +985,9 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
 		u16 partid_max = FIELD_GET(MPAMF_PARTID_NRW_IDR_INTPARTID_MAX, nrwidr);
 
 		mpam_set_feature(mpam_feat_partid_nrw, props);
-		msc->partid_max = min(msc->partid_max, partid_max);
+		msc->intpartid_max = min(msc->partid_max, partid_max);
+	} else {
+		msc->intpartid_max = msc->partid_max;
 	}
 
 	mpam_mon_sel_outer_unlock(msc);
@@ -1039,6 +1048,7 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
 
 	spin_lock(&partid_max_lock);
 	mpam_partid_max = min(mpam_partid_max, msc->partid_max);
+	mpam_intpartid_max = min(mpam_intpartid_max, msc->intpartid_max);
 	mpam_pmg_max = min(mpam_pmg_max, msc->pmg_max);
 	spin_unlock(&partid_max_lock);
 
diff --git a/drivers/platform/arm64/mpam/mpam_internal.h b/drivers/platform/arm64/mpam/mpam_internal.h
index 831ae17345d7..7bc4694df23a 100644
--- a/drivers/platform/arm64/mpam/mpam_internal.h
+++ b/drivers/platform/arm64/mpam/mpam_internal.h
@@ -84,6 +84,7 @@ struct mpam_msc {
 	bool			error_irq_requested;
 	bool			error_irq_hw_enabled;
 	u16			partid_max;
+	u16			intpartid_max;
 	u8			pmg_max;
 	unsigned long		ris_idxs[128 / BITS_PER_LONG];
 	u32			ris_max;
@@ -463,6 +464,7 @@ static inline void mpam_assert_srcu_read_lock_held(void)
 
 /* System wide partid/pmg values */
 extern u16 mpam_partid_max;
+extern u16 mpam_intpartid_max;
 extern u8 mpam_pmg_max;
 
 /* Scheduled work callback to enable mpam once all MSC have been probed */
diff --git a/drivers/platform/arm64/mpam/mpam_resctrl.c b/drivers/platform/arm64/mpam/mpam_resctrl.c
index f444c306134d..eedd308d9c88 100644
--- a/drivers/platform/arm64/mpam/mpam_resctrl.c
+++ b/drivers/platform/arm64/mpam/mpam_resctrl.c
@@ -162,6 +162,11 @@ static bool mpam_resctrl_hide_cdp(enum resctrl_res_level rid)
  * only the system wide safe value is safe to use.
  */
 u32 resctrl_arch_get_num_closid(struct rdt_resource *ignored)
+{
+	return mpam_intpartid_max + 1;
+}
+
+static u32 get_num_reqpartid(void)
 {
 	return mpam_partid_max + 1;
 }
@@ -169,9 +174,9 @@ u32 resctrl_arch_get_num_closid(struct rdt_resource *ignored)
 u32 resctrl_arch_system_num_rmid_idx(void)
 {
 	u8 closid_shift = fls(mpam_pmg_max);
-	u32 num_partid = resctrl_arch_get_num_closid(NULL);
+	u32 num_reqpartid = get_num_reqpartid();
 
-	return num_partid << closid_shift;
+	return num_reqpartid << closid_shift;
 }
 
 u32 resctrl_arch_rmid_idx_encode(u32 closid, u32 rmid)
-- 
2.25.1


