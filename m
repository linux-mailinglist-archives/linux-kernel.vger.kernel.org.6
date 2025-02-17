Return-Path: <linux-kernel+bounces-516941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DEFA37A01
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 04:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0B853AEDD7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 03:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AF517A5BE;
	Mon, 17 Feb 2025 03:09:12 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A341494CC
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 03:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739761752; cv=none; b=sy50mUm7EfqAdsOgOw/CD7fOOVJsbO/ZhLcTS3h1VooH45UGIsoqAy2h/7PGVsbyVt6Ty0FgXTV5V48kS/KvNZwXsKIiJiN+Se0oPRF3c5n8HSJjfPnpI327Qd6+Jhe+SdwNwm+K6ylexmQFuoCYrml2oDi3KRWNvL+abFjyA+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739761752; c=relaxed/simple;
	bh=gTwoTIzj0iPJwyUFOYXQVZShM8sRRvb3nbVHmgKq9m8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FQ18MHrmopfFBkwoq3I1fbLCmnyhZal6Q4JJ9izK1K2p8Rmvwj5iwzeplpTRdJshWI/DbgVze432joTmhwvd0FC2TK9nS87QtWaHM9i3ULJ2wOiXS9e7NoCcc/qpciolx9YgWvHgicaMZ1txG2r+3YZUMCnUWd9ma5OS8auxaQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Yx6ys0f2szrYpg;
	Mon, 17 Feb 2025 11:07:33 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id EEBA61401E9;
	Mon, 17 Feb 2025 11:09:06 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 17 Feb
 2025 11:09:06 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <Dave.Martin@arm.com>, <james.morse@arm.com>
CC: <bobo.shaobowang@huawei.com>, <linux-kernel@vger.kernel.org>,
	<jonathan.cameron@huawei.com>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH mpam mpam/snapshot/v6.14-rc1 4/5] arm_mpam: Set INTERNAL as needed when setting MSC controls
Date: Mon, 17 Feb 2025 11:18:51 +0800
Message-ID: <20250217031852.2014939-5-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250217031852.2014939-1-zengheng4@huawei.com>
References: <20250217031852.2014939-1-zengheng4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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
index c1b690effe29..a1efd08eb914 100644
--- a/drivers/platform/arm64/mpam/mpam_devices.c
+++ b/drivers/platform/arm64/mpam/mpam_devices.c
@@ -200,15 +200,27 @@ static u64 mpam_msc_read_esr(struct mpam_msc *msc)
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
@@ -1531,9 +1543,11 @@ static void mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
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


