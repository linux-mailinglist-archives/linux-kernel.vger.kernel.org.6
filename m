Return-Path: <linux-kernel+bounces-251365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D44C8930410
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 08:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7120C1F22066
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 06:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24853D97A;
	Sat, 13 Jul 2024 06:13:44 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF43374F1
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 06:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720851224; cv=none; b=VPkNdax73S6WBUxPeCQDNFVxt0uKV83ghSI9coPF7NycVSyhq9qAtZSLGsuKbOo8sUQEGG34kyUwOXQv3iUCwkNOmriFJ1i+yW7HDduYxZwCewkO2gtdSB9zWvfBieVjSnbCdPr3zJ+TeNLlxts2uuIa0G/KHqQ90Zbt3RA1ATo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720851224; c=relaxed/simple;
	bh=c2a+MUNNmJv4IziUEEbzft8eTTiPu1rIEDhOjFqvxsA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KLckjMnt2arKCiDto2C4/8aFhwelUH7h/Gj+YYOrZVULSjKhvj21eSapgPKNCmW3FnqnZ5mKH0T/iz9ZG1HCjO8mvMgHb/i3bytYPfjhtdSPwly1W1YImTGc5mSLNSfdsODeWvCcw1lb0Gj1ZOYpWJjkn908N1/R0jtUlKAfMtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WLdMf3HwNz1X4dH;
	Sat, 13 Jul 2024 14:09:18 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id B316D1A016C;
	Sat, 13 Jul 2024 14:13:33 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 13 Jul
 2024 14:13:33 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <james.morse@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6.10-rc1 2/4] arm_mpam: Fix the range calculation of the implemented bits
Date: Sat, 13 Jul 2024 14:09:42 +0800
Message-ID: <20240713060944.2725647-3-zengheng4@huawei.com>
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

The implemented bits of the MAX field in the MPAMCFG_{MBW_MAX, CMAX}
register are always to the left of the field, so the validated range
should be like [15, 15 - width + 1].

Fixes: 867471fefd5c ("SPLIT untested: arm_mpam: resctrl: Add support for MB resource")
Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 drivers/platform/arm64/mpam/mpam_resctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/arm64/mpam/mpam_resctrl.c b/drivers/platform/arm64/mpam/mpam_resctrl.c
index a217f2e1f350..e87fca6fc5fd 100644
--- a/drivers/platform/arm64/mpam/mpam_resctrl.c
+++ b/drivers/platform/arm64/mpam/mpam_resctrl.c
@@ -585,7 +585,7 @@ static u16 percent_to_mbw_max(u8 pc, struct mpam_props *cprops)
 			break;
 	}
 
-	value &= GENMASK(15, 15 - cprops->bwa_wd);
+	value &= GENMASK(15, 15 - cprops->bwa_wd + 1);
 
 	return value;
 }
-- 
2.25.1


