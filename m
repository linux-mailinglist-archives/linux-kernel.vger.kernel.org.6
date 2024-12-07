Return-Path: <linux-kernel+bounces-435975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE369E7F4B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 10:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2D82168806
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 09:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B6513DBBE;
	Sat,  7 Dec 2024 09:09:27 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6607485626
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 09:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733562567; cv=none; b=le4KMdCAu3540380aLQELg41expi6ZkWSFfTv5YGW5PgyolP9jUz7hNIjEly26AZuPdpV1c3wHwSWY3WwgT1idwi2zvpeLmTJRZZc8vroBIq3faFDT7M5V7qQhWheDQfq9fOxy6eTTczHkVsTAMpWqfNpkYZHlzall9MN5pGxrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733562567; c=relaxed/simple;
	bh=FuKFh6wNU5A8Phu2FWq4BsQGwDQkyWTwYUN4oowWQbA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a3MAhBK6Ef5eb62S1B7Z0f9IMwx+cWVkWjIlgrpkyGg6ykrJEYxcn1aqk0grNjkQQ96FwICV1LoN5KwWRbDnyjQat3+15Qg+N/MXi6KoPa2PlwNTWgeNMUhtCNdW1jEUtGLJXnpBQBwrHelT+OyCCn7H8SANzPwxEDJGFF7hkiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Y52Md1BL5zRhpr;
	Sat,  7 Dec 2024 17:07:41 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id D23001800FD;
	Sat,  7 Dec 2024 17:09:21 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 7 Dec
 2024 17:09:21 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <Dave.Martin@arm.com>, <james.morse@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<jonathan.cameron@huawei.com>, <xiexiuqi@huawei.com>
Subject: [RFC PATCH mpam mpam/snapshot/v6.12-rc1 v3 3/5] arm_mpam: Set INTERNAL as needed when setting MSC controls
Date: Sat, 7 Dec 2024 17:21:34 +0800
Message-ID: <20241207092136.2488426-4-zengheng4@huawei.com>
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

From: Dave Martin <Dave.Martin@arm.com>

Currently, when an MSC implements PARTID narrowing, MPAMCFG_PART_SEL is
left set to the reqPARTID while programming resource controls in
an MSC.

The MPAM architecture does not guarantee that any particular resource
controls will be updated correctly in this scenario.  Instead,
MPAMCFG_PART_SEL must be written with the corresponding intPARTID and
with the INTERNAL bit set before attempting to program resource controls.
Only the PARTID->intPARTID mappings can be written without the INTERNAL
bit set in MPAMCFG_PART_SEL.

Fix it, by rewriting MPAMCFG_PART_SEL appropriately after setting the
intPARTID mapping.

The MPAMCFG_INTPARTID_INTERNAL flag is not currently accepted as
input to the __mpam_part_sel() helper.  In the interest of keeping
the code clean, break this helper up.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/platform/arm64/mpam/mpam_devices.c | 26 +++++++++++++++++-----
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/arm64/mpam/mpam_devices.c b/drivers/platform/arm64/mpam/mpam_devices.c
index ca621bb132e9..781c9146718d 100644
--- a/drivers/platform/arm64/mpam/mpam_devices.c
+++ b/drivers/platform/arm64/mpam/mpam_devices.c
@@ -205,15 +205,27 @@ static u64 mpam_msc_read_esr(struct mpam_msc *msc)
 	return (esr_high << 32) | esr_low;
 }
 
+static void __mpam_part_sel_raw(u32 partsel, struct mpam_msc *msc)
+{
+	lockdep_assert_held(&msc->part_sel_lock);
+	mpam_write_partsel_reg(msc, PART_SEL, partsel);
+}
+
 static void __mpam_part_sel(u8 ris_idx, u16 partid, struct mpam_msc *msc)
 {
-	u32 partsel;
+	u32 partsel = FIELD_PREP(MPAMCFG_PART_SEL_RIS, ris_idx) |
+		      FIELD_PREP(MPAMCFG_PART_SEL_PARTID_SEL, partid);
 
-	lockdep_assert_held(&msc->part_sel_lock);
+	__mpam_part_sel_raw(partsel, msc);
+}
 
-	partsel = FIELD_PREP(MPAMCFG_PART_SEL_RIS, ris_idx) |
-		  FIELD_PREP(MPAMCFG_PART_SEL_PARTID_SEL, partid);
-	mpam_write_partsel_reg(msc, PART_SEL, partsel);
+static void __mpam_intpart_sel(u8 ris_idx, u16 intpartid, struct mpam_msc *msc)
+{
+	u32 partsel = FIELD_PREP(MPAMCFG_PART_SEL_RIS, ris_idx) |
+		      FIELD_PREP(MPAMCFG_PART_SEL_PARTID_SEL, intpartid) |
+		      MPAMCFG_PART_SEL_INTERNAL;
+
+	__mpam_part_sel_raw(partsel, msc);
 }
 
 int mpam_register_requestor(u16 partid_max, u8 pmg_max)
@@ -1540,9 +1552,11 @@ static void mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
 	mutex_lock(&msc->part_sel_lock);
 	__mpam_part_sel(ris->ris_idx, partid, msc);
 
-	if (mpam_has_feature(mpam_feat_partid_nrw, rprops))
+	if (mpam_has_feature(mpam_feat_partid_nrw, rprops)) {
 		mpam_write_partsel_reg(msc, INTPARTID,
 				       MPAMCFG_INTPARTID_INTERNAL | partid);
+		__mpam_intpart_sel(ris->ris_idx, partid, msc);
+	}
 
 	if (mpam_has_feature(mpam_feat_cpor_part, rprops)) {
 		if (mpam_has_feature(mpam_feat_cpor_part, cfg))
-- 
2.25.1


