Return-Path: <linux-kernel+bounces-293952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6129586DD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE9851C21929
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C4E18FC91;
	Tue, 20 Aug 2024 12:26:05 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9142745C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 12:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724156764; cv=none; b=q2Xhn75oXeCwmk/tBwvRgY6wrWh+lIFEG9xQlsjjDIRylrjJr28OHJc5+l3osCRurgjXCA01QDP3MWDNd9973+L2/vf+nuivGzRX3YSfF0O9XUFY0QyrT9/bsDqc26tfq4xBsl1MrMCmMxjZ3TGd4Rh0Ioynt+V8rxt2lbfbI8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724156764; c=relaxed/simple;
	bh=deYYuOR4P9RZKkJUnXpSlKB3PQJQvhtt4hUgN9b92r4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KBqZcyiTNxhmtE6FEvd+aWI6xRVfotSuDbrtp2qFB0p+SKfGSmt5tayWYu9R9gjQmMioMtqfWEz37bLPip86+W52+ITU4gZM2ywwZZheGwwzcltxROy9sxtTsRx6mFCGp2nVlBycWFnrTadpi39QRb666vsmiZzda9TKSxFB58Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wp7pz0Vy1z2Cn7T;
	Tue, 20 Aug 2024 20:20:59 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id DB2D81A0188;
	Tue, 20 Aug 2024 20:25:58 +0800 (CST)
Received: from huawei.com (10.67.174.77) by dggpemm500020.china.huawei.com
 (7.185.36.49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 20 Aug
 2024 20:25:58 +0800
From: Liao Chen <liaochen4@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: <dinguyen@kernel.org>
Subject: [PATCH -next] firmware: stratix10-svc: fix module autoloading
Date: Tue, 20 Aug 2024 12:17:58 +0000
Message-ID: <20240820121758.42398-1-liaochen4@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500020.china.huawei.com (7.185.36.49)

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Liao Chen <liaochen4@huawei.com>
---
 drivers/firmware/stratix10-svc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 528f37417aea..d7d6b1d771df 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -1122,6 +1122,7 @@ static const struct of_device_id stratix10_svc_drv_match[] = {
 	{.compatible = "intel,agilex-svc"},
 	{},
 };
+MODULE_DEVICE_TABLE(of, stratix10_svc_drv_match);
 
 static int stratix10_svc_drv_probe(struct platform_device *pdev)
 {
-- 
2.34.1


