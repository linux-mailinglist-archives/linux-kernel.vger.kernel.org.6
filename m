Return-Path: <linux-kernel+bounces-258439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CAE9387E4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 06:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DADF7B210DF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 04:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F29012B93;
	Mon, 22 Jul 2024 04:05:43 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FFD17BB6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 04:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721621143; cv=none; b=pMDaM92ETaisruMsAgN/gCy5gZpG3Wv0Royl32zPKOo61gasVnPlwyyKn1plif8kB+fdpEOG+Ucv+A16qvMWbrb4fwSyIp2WE/HAZXjaHr0p/n2ViwPX6hyG5q68I1il0CgCN758E/JRzjFXD4vNXSXTWSj5IChRRt0ofMwGNY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721621143; c=relaxed/simple;
	bh=/FwUgcdl80YqwSBVtTSXOnlfHZUrYZbOTEATrkgSxTI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V2a6DqeRLjt//fdVYu9hunKofoLPD5+qPPoMbJMiAg64LBP9f+NBeakRjCWcW12LRpV/xrRgWWNk8jBKdSa28NljKXOnYEaof081JLVnkq56ucU4RQGBqTCvY0xmrCT7N5cKAaRKWSqcvgFTPbjEf7cviT/U41B26dgb7TZlkeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WS64v3qSgz1JDRb;
	Mon, 22 Jul 2024 12:00:31 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id 807B8180064;
	Mon, 22 Jul 2024 12:05:29 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 22 Jul
 2024 12:05:28 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <james.morse@arm.com>, <rohit.mathew@arm.com>, <amitsinght@marvell.com>,
	<sdonthineni@nvidia.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<zengheng4@huawei.com>, <liwei391@huawei.com>
Subject: [PATCH mpam/v6.10-rc1 RFC 1/4] arm_mpam: Correct MBA granularity calculation
Date: Mon, 22 Jul 2024 12:01:18 +0800
Message-ID: <20240722040121.515021-2-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240722040121.515021-1-zengheng4@huawei.com>
References: <20240722040121.515021-1-zengheng4@huawei.com>
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

Correct MBA granularity calculation function. As said in the comments,
"bwa_wd is the number of bits implemented in the 0.xxx fixed point
fraction".

Fixes: 867471fefd5c ("SPLIT untested: arm_mpam: resctrl: Add support for MB resource")
Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 drivers/platform/arm64/mpam/mpam_resctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/arm64/mpam/mpam_resctrl.c b/drivers/platform/arm64/mpam/mpam_resctrl.c
index 2fa732a42d4f..a217f2e1f350 100644
--- a/drivers/platform/arm64/mpam/mpam_resctrl.c
+++ b/drivers/platform/arm64/mpam/mpam_resctrl.c
@@ -523,7 +523,7 @@ static u32 get_mba_granularity(struct mpam_props *cprops)
 		 * bwa_wd is the number of bits implemented in the 0.xxx
 		 * fixed point fraction. 1 bit is 50%, 2 is 25% etc.
 		 */
-		return MAX_MBA_BW / (cprops->bwa_wd + 1);
+		return MAX_MBA_BW / (1 << cprops->bwa_wd);
 	}
 
 	return 0;
-- 
2.25.1


