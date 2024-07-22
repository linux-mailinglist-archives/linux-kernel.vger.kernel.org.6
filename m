Return-Path: <linux-kernel+bounces-258443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 112309387EE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 06:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A514B21337
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 04:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDCD175B1;
	Mon, 22 Jul 2024 04:06:07 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF939171CD
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 04:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721621166; cv=none; b=iVUyNoMJSSPBKaFX6mE/AD93+D41TAtM5HiRzkz0wkCUerThOa+e58U+OjoxpzMHU9l495vi9F8D/Ac9cjpZXTRjtRKivWILc5GK6ynWMShtwqHVJ//ciWW6e4Q62PXh9ahZMv2DMHqJzqNQE6gVNOu+lpfONMzs3X55lWbwpRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721621166; c=relaxed/simple;
	bh=pRysUHIv8ye9ZAnFZcRDd5Yr1XT1Elzpnisa/eQLrwg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZH8F8fbKtSyCtrdIcypTkyZKax04UYaubUXH4e8S+oOUb0ZYYCICVBPaNCK0E5o/SpMCH++QlAq6k8sDLrNKsR+mwaRdGuSwuVwcPgaAcC0cSsTwVe2k3eWlCZobZs/+8avmUtISiZR2CUV5cd4F7AeiOuwDNBy9/dqRxfDg/Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WS66F487Tz20ks1;
	Mon, 22 Jul 2024 12:01:41 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id D0ABD14035E;
	Mon, 22 Jul 2024 12:05:49 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 22 Jul
 2024 12:05:49 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <james.morse@arm.com>, <rohit.mathew@arm.com>, <amitsinght@marvell.com>,
	<sdonthineni@nvidia.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<zengheng4@huawei.com>, <liwei391@huawei.com>
Subject: [PATCH mpam/v6.10-rc1 RFC 3/4] arm_mpam: Correct the judgment condition of the CMAX feature
Date: Mon, 22 Jul 2024 12:01:39 +0800
Message-ID: <20240722040140.515173-4-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240722040140.515173-1-zengheng4@huawei.com>
References: <20240722040140.515173-1-zengheng4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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


