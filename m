Return-Path: <linux-kernel+bounces-258444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6EF9387EF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 06:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66F1F281A9C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 04:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E08A41;
	Mon, 22 Jul 2024 04:06:14 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDB7171CD
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 04:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721621174; cv=none; b=PhRzjLEk1T4tE5/M7DBqN/SykVSXiiA5jh320TYhjf8dmeDrEvSa5ELnzHVtRUK+NpNziN1JHvD9CjrmB2aWmVjW2ziSjrk+qApAlucNxievYWYaIsNw4aGtQY9HoHXLLjnO/9r0GLBcYKwaNn2xJs4uWnjSTqMwR2rLXCqizKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721621174; c=relaxed/simple;
	bh=OmWu9roJ8Ekx1OC9ld+LTwlVUjG9XH4xD1JTTUre6so=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LMTChsbzQFyzsaHVYTradOu/pFCEp5i3b9wtJGe3GE5tLZVfuc7Wlm7scctxJP3F6qnU/X3jmda/wMx04MaGZbMSPi/qnasY6sf+jD+HdknxvUUg404KIAju1wX/6Rrb043XClZHZtVoF9uFjuCr5mBo5EB988F1bRR1L2F76uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WS65z2p9tz1X4k0;
	Mon, 22 Jul 2024 12:01:27 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id 8D0BE1A0188;
	Mon, 22 Jul 2024 12:05:50 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 22 Jul
 2024 12:05:49 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <james.morse@arm.com>, <rohit.mathew@arm.com>, <amitsinght@marvell.com>,
	<sdonthineni@nvidia.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<zengheng4@huawei.com>, <liwei391@huawei.com>
Subject: [PATCH mpam/v6.10-rc1 RFC 4/4] arm_mpam: Fix typo about mbw_min controls
Date: Mon, 22 Jul 2024 12:01:40 +0800
Message-ID: <20240722040140.515173-5-zengheng4@huawei.com>
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

Correct the judgment condition about mbw_min default value.

Fixes: 099f47353bc5 ("arm_mpam: Generate a configuration for min controls")
Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 drivers/platform/arm64/mpam/mpam_devices.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/arm64/mpam/mpam_devices.c b/drivers/platform/arm64/mpam/mpam_devices.c
index 9acac8a22573..64a1f1767a68 100644
--- a/drivers/platform/arm64/mpam/mpam_devices.c
+++ b/drivers/platform/arm64/mpam/mpam_devices.c
@@ -1483,7 +1483,7 @@ static void mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
 	}
 
 	if (mpam_has_feature(mpam_feat_mbw_min, rprops)) {
-		if (mpam_has_feature(mpam_feat_mbw_max, cfg))
+		if (mpam_has_feature(mpam_feat_mbw_min, cfg))
 			mpam_write_partsel_reg(msc, MBW_MIN, cfg->mbw_min);
 		else
 			mpam_write_partsel_reg(msc, MBW_MIN, 0);
-- 
2.25.1


