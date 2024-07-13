Return-Path: <linux-kernel+bounces-251363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB9A93040E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 08:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EBFD1C22CCD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 06:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BA41CA94;
	Sat, 13 Jul 2024 06:13:39 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF59929401
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 06:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720851219; cv=none; b=Ds9zH+6YC3kldItXWbEBz64RgexesMGM6z6qhEgAxJf0sq4r9th+7ig4/g9AtO+w3xObNjRd+L7RspyZokYKmvRT1jAcx+Ef9g/FtPgeGwtlMOz2yKd3AK20+9p7XYGmnlNfeOtg6u70TZjYEl/XQwLGiWrx1SCqyqzMJPcineY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720851219; c=relaxed/simple;
	bh=/FwUgcdl80YqwSBVtTSXOnlfHZUrYZbOTEATrkgSxTI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GzuvZK55Sd6DIJlDuLz8LDE/QZlaEDa2qhgmfU+9YRpvEHvWziR7hSGcUdyssIMnTX0/CEmMBxAT9CNrVobSSCciOI6PC8DQn3rNMpSgofaouYp3lW2Nx5vw1bGJWGbVdYimKD150P+SUXYbSmzZmXfrXp8I1nhnikWVvw+Ce/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WLdMy2fxgzQlSJ;
	Sat, 13 Jul 2024 14:09:34 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id 44C87140361;
	Sat, 13 Jul 2024 14:13:33 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 13 Jul
 2024 14:13:32 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <james.morse@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6.10-rc1 1/4] arm_mpam: Correct MBA granularity calculation
Date: Sat, 13 Jul 2024 14:09:41 +0800
Message-ID: <20240713060944.2725647-2-zengheng4@huawei.com>
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


