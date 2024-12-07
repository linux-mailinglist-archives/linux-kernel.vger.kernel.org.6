Return-Path: <linux-kernel+bounces-435976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3E89E7F4C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 10:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD31B1884969
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 09:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C599A144304;
	Sat,  7 Dec 2024 09:09:27 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D163C12E1CD
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 09:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733562567; cv=none; b=e/wEpDFb6PZPQLU45XWVXFpKj1MNYGaXUj3YRMEVo/0wU0Pl6LWylj1UKQ50H3vlYG8ifyq/XAHJkWbhwt74hagF/8dPAIBIXZo4CF7ewCIfCOVBlhdIhw0jjfqzFv8F4yrHZUzWTxRiTwNj4Ra+ySWySK+t/R2mJGaMmKtWi10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733562567; c=relaxed/simple;
	bh=Dw9s7sDSOGhEg5E9v/O0gOK1xEqgry46VjEW+CN8E58=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TdeNR++CbkYcILnM+6dGfaXFtN4U0vvjZL3Pf/NvRNFEI/GS2cNdFFCINgM5j9kblSN6BelHaCM3U9b4qIvu1yUg/xrMAf59cMakjizbpqyQ82FbSrswWW+Dbm02b4ERKPWGLD5bV7XLbiQ7anqMIX0Zxyn4vDwyQJWCwQbh2wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Y52Ls1vKqz1T6RH;
	Sat,  7 Dec 2024 17:07:01 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id 6F37D1A0188;
	Sat,  7 Dec 2024 17:09:22 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 7 Dec
 2024 17:09:21 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <Dave.Martin@arm.com>, <james.morse@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<jonathan.cameron@huawei.com>, <xiexiuqi@huawei.com>
Subject: [RFC PATCH mpam mpam/snapshot/v6.12-rc1 v3 4/5] arm_mpam: Automatically synchronize the configuration of all sub-monitoring groups
Date: Sat, 7 Dec 2024 17:21:35 +0800
Message-ID: <20241207092136.2488426-5-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241207092136.2488426-1-zengheng4@huawei.com>
References: <20241207092136.2488426-1-zengheng4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf100008.china.huawei.com (7.202.181.222)

After the system expands the narrow-partid feature and statically assigns
all (req)PARTIDs to each control group, the following scenarios require
configuration synchronization operations:

  1. MSCs that support narrow-partid need to establish a mapping between
     reqPARTID and intPARTID after creating a new monitoring group.
  2. MSCs that do not support narrow-partid need to synchronize the
     configuration of sub-monitoring groups after users update the control
     group configuration.

In __write_config(), we synchronize a control group's configuration to each
sub-monitoring group.

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 drivers/platform/arm64/mpam/mpam_devices.c  | 25 ++++++++++++++++++---
 drivers/platform/arm64/mpam/mpam_internal.h |  3 +++
 drivers/platform/arm64/mpam/mpam_resctrl.c  | 10 ++++++++-
 3 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/arm64/mpam/mpam_devices.c b/drivers/platform/arm64/mpam/mpam_devices.c
index 781c9146718d..91c5849f76e3 100644
--- a/drivers/platform/arm64/mpam/mpam_devices.c
+++ b/drivers/platform/arm64/mpam/mpam_devices.c
@@ -1544,6 +1544,7 @@ static void mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
 	u32 pri_val = 0;
 	u16 cmax = MPAMCFG_CMAX_CMAX;
 	u16 bwa_fract = MPAMCFG_MBW_MAX_MAX;
+	u16 intpartid = req2intpartid(partid);
 	struct mpam_msc *msc = ris->vmsc->msc;
 	struct mpam_props *rprops = &ris->props;
 	u16 dspri = GENMASK(rprops->dspri_wd, 0);
@@ -1554,8 +1555,14 @@ static void mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
 
 	if (mpam_has_feature(mpam_feat_partid_nrw, rprops)) {
 		mpam_write_partsel_reg(msc, INTPARTID,
-				       MPAMCFG_INTPARTID_INTERNAL | partid);
-		__mpam_intpart_sel(ris->ris_idx, partid, msc);
+				       MPAMCFG_INTPARTID_INTERNAL |
+				       intpartid);
+
+		/* Already finish mapping reqPARTID to intPARTID */
+		if (partid != intpartid)
+			goto out;
+
+		__mpam_intpart_sel(ris->ris_idx, intpartid, msc);
 	}
 
 	if (mpam_has_feature(mpam_feat_cpor_part, rprops)) {
@@ -1615,6 +1622,7 @@ static void mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
 
 	mpam_quirk_post_config_change(ris, partid, cfg);
 
+out:
 	mutex_unlock(&msc->part_sel_lock);
 }
 
@@ -3072,9 +3080,20 @@ struct mpam_write_config_arg {
 
 static int __write_config(void *arg)
 {
+	int closid_num = resctrl_arch_get_num_closid(NULL);
 	struct mpam_write_config_arg *c = arg;
+	u32 reqpartid, req_idx;
+
+	WARN_ON(c->partid >= closid_num);
 
-	mpam_reprogram_ris_partid(c->ris, c->partid, &c->comp->cfg[c->partid]);
+	/* Synchronize the configuration to each sub-monitoring group. */
+	for (req_idx = 0; req_idx < get_num_reqpartid_per_closid();
+	     req_idx++) {
+		reqpartid = req_idx * closid_num + c->partid;
+
+		mpam_reprogram_ris_partid(c->ris, reqpartid,
+					 &c->comp->cfg[c->partid]);
+	}
 
 	return 0;
 }
diff --git a/drivers/platform/arm64/mpam/mpam_internal.h b/drivers/platform/arm64/mpam/mpam_internal.h
index 5fc9f09b6945..c02365338b21 100644
--- a/drivers/platform/arm64/mpam/mpam_internal.h
+++ b/drivers/platform/arm64/mpam/mpam_internal.h
@@ -773,4 +773,7 @@ static inline void mpam_resctrl_teardown_class(struct mpam_class *class) { }
  */
 #define MSMON_CAPT_EVNT_NOW    BIT(0)
 
+u32 get_num_reqpartid_per_closid(void);
+u32 req2intpartid(u32 reqpartid);
+
 #endif /* MPAM_INTERNAL_H */
diff --git a/drivers/platform/arm64/mpam/mpam_resctrl.c b/drivers/platform/arm64/mpam/mpam_resctrl.c
index 965ff9fd45d3..47e3a51b0942 100644
--- a/drivers/platform/arm64/mpam/mpam_resctrl.c
+++ b/drivers/platform/arm64/mpam/mpam_resctrl.c
@@ -171,11 +171,19 @@ static u32 get_num_reqpartid(void)
 	return mpam_partid_max + 1;
 }
 
-static u32 get_num_reqpartid_per_closid(void)
+u32 get_num_reqpartid_per_closid(void)
 {
 	return get_num_reqpartid() / resctrl_arch_get_num_closid(NULL);
 }
 
+u32 req2intpartid(u32 reqpartid)
+{
+	u8 intpartid_shift = fls(mpam_intpartid_max);
+	u32 intpartid_mask = ~(~0 << intpartid_shift);
+
+	return reqpartid & intpartid_mask;
+}
+
 u32 resctrl_arch_system_num_rmid_idx(void)
 {
 	u8 closid_shift = fls(mpam_pmg_max);
-- 
2.25.1


