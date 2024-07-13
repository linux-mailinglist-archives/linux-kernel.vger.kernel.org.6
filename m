Return-Path: <linux-kernel+bounces-251364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C668493040F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 08:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B29A1F226A3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 06:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9933A8C0;
	Sat, 13 Jul 2024 06:13:44 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF84381D5
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 06:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720851223; cv=none; b=lgTkAc/t0NTguknQCAM8vmHITRSHjtEuoaL6wFgEqkCymLeaoyRfFKgCxac42jKOGV9iblmler+58C2lJNrssAJQ0MI2+N3B+lCnPUIdykpL27irWruGC0y2qxrUkXL5HhAv3+i+eSi+3SqVO5kqRCZUPE0sJAibJJeeAUwhVv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720851223; c=relaxed/simple;
	bh=pRysUHIv8ye9ZAnFZcRDd5Yr1XT1Elzpnisa/eQLrwg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pTuGLfj9gzdilbWnTyLw5aSVutulncmBfRVdUR57/HghftoAIdqzJ5QyCzdZ0e3axU8QsVfRAAeyQXK4tX/kyHcJOppsd/7jkToYplvvPbECE1bCVXHuLnT9HOBotnVyD8WT3FpIzrOD3N3CCA79YeOhyUjaZNTmogvs1sRCXxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WLdMf6WS7z1X4gK;
	Sat, 13 Jul 2024 14:09:18 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id 2D90F1A0188;
	Sat, 13 Jul 2024 14:13:34 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 13 Jul
 2024 14:13:33 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <james.morse@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6.10-rc1 3/4] arm_mpam: Correct the judgment condition of the CMAX feature
Date: Sat, 13 Jul 2024 14:09:43 +0800
Message-ID: <20240713060944.2725647-4-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240713060944.2725647-1-zengheng4@huawei.com>
References: <20240713060944.2725647-1-zengheng4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf100008.china.huawei.com (7.202.181.222)

According to Arm Architecture MPAM Reference Manual (version DDI 0598D.b),
to check whether hardware supports the CMAX feature or not, not only needs
to check the CMAX_WD field of the MPAMF_CCAP_IDR register, but also needs
to check the NO_CMAX field.

Fixes: a275036b6767 ("arm_mpam: Probe and reset the rest of the features")
Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 drivers/platform/arm64/mpam/mpam_devices.c  | 6 ++++--
 drivers/platform/arm64/mpam/mpam_internal.h | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/arm64/mpam/mpam_devices.c b/drivers/platform/arm64/mpam/mpam_devices.c
index acb91352c524..9acac8a22573 100644
--- a/drivers/platform/arm64/mpam/mpam_devices.c
+++ b/drivers/platform/arm64/mpam/mpam_devices.c
@@ -779,8 +779,10 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
 		u32 ccap_features = mpam_read_partsel_reg(msc, CCAP_IDR);
 
 		props->cmax_wd = FIELD_GET(MPAMF_CCAP_IDR_CMAX_WD, ccap_features);
-		if (props->cmax_wd)
-			mpam_set_feature(mpam_feat_ccap_part, props);
+		if (props->cmax_wd) {
+			if (!FIELD_GET(MPAMF_CCAP_IDR_NO_CMAX, ccap_features))
+				mpam_set_feature(mpam_feat_ccap_part, props);
+		}
 	}
 
 	/* Cache Portion partitioning */
diff --git a/drivers/platform/arm64/mpam/mpam_internal.h b/drivers/platform/arm64/mpam/mpam_internal.h
index 61aea729aa73..0e714ce7fa96 100644
--- a/drivers/platform/arm64/mpam/mpam_internal.h
+++ b/drivers/platform/arm64/mpam/mpam_internal.h
@@ -450,6 +450,7 @@ void mpam_resctrl_exit(void);
 
 /* MPAMF_CCAP_IDR - MPAM features cache capacity partitioning ID register */
 #define MPAMF_CCAP_IDR_CMAX_WD                  GENMASK(5, 0)
+#define MPAMF_CCAP_IDR_NO_CMAX                  BIT(30)
 
 /* MPAMF_MBW_IDR - MPAM features memory bandwidth partitioning ID register */
 #define MPAMF_MBW_IDR_BWA_WD            GENMASK(5, 0)
-- 
2.25.1


