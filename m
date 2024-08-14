Return-Path: <linux-kernel+bounces-285806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 235B99512FE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 05:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C95311F24550
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 03:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279AE376F5;
	Wed, 14 Aug 2024 03:17:59 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1A78485
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 03:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723605478; cv=none; b=gbICU99Hn8etzyzaoltLi50N7lw/nQSvrvTPB2Ca7PsJgPMHvMVmaclqx5w27TN1MsdoOccFrN+9mNkyKM8dBqe5AYkDt5CfEP37MWpeiSvN089u0nCncS+rs47vLvZNQuNrnqnKKXW/A0qT9XNZ+3E0crm1y3FDdbclHVkTRjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723605478; c=relaxed/simple;
	bh=6AbozVIkpxvR7OkVO94M6pGSYikRiDD6pJvOiCdjvg8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nKUy3sSart8pvgjOkTfA7FM1poTs6YOgeM4uMG1P+ok+MM3VnwEo+AfNghw2hq+anzB5Zgymg3E6WlFLOAmtYzHGld6c+EgU3gm6++Dh4ce1S9x5QBc2BAPjhenSQZpZH9LFF7WzBu0iwvpwU/3CwJHHU+8CJck7d3Tg80z3BdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WkD2X2dh9zyPGW;
	Wed, 14 Aug 2024 11:17:24 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id 05D3918006C;
	Wed, 14 Aug 2024 11:17:54 +0800 (CST)
Received: from huawei.com (10.67.174.77) by dggpemm500020.china.huawei.com
 (7.185.36.49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 14 Aug
 2024 11:17:53 +0800
From: Liao Chen <liaochen4@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>
CC: <linux-kernel@vger.kernel.org>, <linusw@kernel.org>, <kaloz@openwrt.org>
Subject: [PATCH -next] soc: ixp4xx/qmgr: fix module autoloading
Date: Wed, 14 Aug 2024 03:10:04 +0000
Message-ID: <20240814031004.3876441-1-liaochen4@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500020.china.huawei.com (7.185.36.49)

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Liao Chen <liaochen4@huawei.com>
---
 drivers/soc/ixp4xx/ixp4xx-qmgr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/ixp4xx/ixp4xx-qmgr.c b/drivers/soc/ixp4xx/ixp4xx-qmgr.c
index cb112f3643e9..dabcf91c3cae 100644
--- a/drivers/soc/ixp4xx/ixp4xx-qmgr.c
+++ b/drivers/soc/ixp4xx/ixp4xx-qmgr.c
@@ -454,6 +454,7 @@ static const struct of_device_id ixp4xx_qmgr_of_match[] = {
         },
 	{},
 };
+MODULE_DEVICE_TABLE(of, ixp4xx_qmgr_of_match);
 
 static struct platform_driver ixp4xx_qmgr_driver = {
 	.driver = {
-- 
2.34.1


