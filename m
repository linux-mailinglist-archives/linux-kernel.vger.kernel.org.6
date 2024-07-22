Return-Path: <linux-kernel+bounces-258442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B20999387ED
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 06:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68EAB280ABA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 04:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97F01758B;
	Mon, 22 Jul 2024 04:05:57 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09029171AF
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 04:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721621157; cv=none; b=fOxNhfGjTfvNFB5/XIeF3bPQNJyx+AMt45h1AO40972xcborNAxarFw0v2q47tnQcoxANmHqS0oUJeqpzGP/p1HpNXDx0Cz2CrXGtJb6ZEpyMKf9a+68jmrp8OHujJo+BPDYwoKwh74tmKES+mK8+Lyan2fhSozj6X8Dc7fcpgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721621157; c=relaxed/simple;
	bh=/FwUgcdl80YqwSBVtTSXOnlfHZUrYZbOTEATrkgSxTI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nHh39gDRbEUJG6QGgFeFhISMeyyuAdEcl2pNtPdVBYIo+9hY+UmTzY6XZny99FbUZPFd/4+GQms1tL0kPqTyncu/TlJBE/xJjQeTmGuXCsZ/8vUweuKFSMYR7IW9E7WOXOYGYc6xK4zpTrmLa0pV82FIcBe1k3tb2g+kwfw6Olc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WS65K4ncKzxThN;
	Mon, 22 Jul 2024 12:00:53 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id 6ABAB1402CA;
	Mon, 22 Jul 2024 12:05:48 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 22 Jul
 2024 12:05:47 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <james.morse@arm.com>, <rohit.mathew@arm.com>, <amitsinght@marvell.com>,
	<sdonthineni@nvidia.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<zengheng4@huawei.com>, <liwei391@huawei.com>
Subject: [PATCH mpam/v6.10-rc1 RFC 1/4] arm_mpam: Correct MBA granularity calculation
Date: Mon, 22 Jul 2024 12:01:37 +0800
Message-ID: <20240722040140.515173-2-zengheng4@huawei.com>
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


