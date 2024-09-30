Return-Path: <linux-kernel+bounces-343265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA8B9898C3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 03:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96BB11F21878
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 01:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7C64C85;
	Mon, 30 Sep 2024 01:11:53 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4079B18EA2;
	Mon, 30 Sep 2024 01:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727658713; cv=none; b=NwGLhvnKoQBQ2dTcL1s0Y9Kl79mi7cHQRod1wq1w3WLw0KWQQr/0m3SmDu97bgrRIOgnSoqt2n4Osi5DN9Qzhm5LP+MDkhlz3w16/NJQofjmcPhWvEBn7nuD3kNXKZysXUi2Mn9tcm4aw2t0yPnzjWTWZo0Wqx7xy1hdsuifdiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727658713; c=relaxed/simple;
	bh=cV3dIfCsFw0OkSjWqt0dxqZXGka2Xb4ezjREudoyS7M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sGazX4S6YJFvJXvF6p0iDD88Gvwg73YRTwevtgMB0m6NcjS4EIxwK20Vpa1iyCmzcqYFx522za20/QBhPmedRq8Zh6P3UqdveivyUfHUGAN9csghxlsIUlAWBrqqCIWBfCSbRdR7azaVSSqM6pTencDXXFoUCQ5zJHwy4+j6Vys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XH2xM5VQqz1HKPF;
	Mon, 30 Sep 2024 09:07:51 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 4675C140360;
	Mon, 30 Sep 2024 09:11:47 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 30 Sep
 2024 09:11:46 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <robh@kernel.org>, <saravanak@google.com>, <sboyd@kernel.org>,
	<davidgow@google.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] of: Fix unbalanced of node refcount in of_overlay_apply_kunit_cleanup()
Date: Mon, 30 Sep 2024 09:22:17 +0800
Message-ID: <20240930012217.138786-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Got following report when doing overlay_test:

	OF: ERROR: memory leak, expected refcount 1 instead of 2,
	of_node_get()/of_node_put() unbalanced - destroy cset entry:
	attach overlay node            /kunit-test

	OF: ERROR: memory leak before free overlay changeset,  /kunit-test

In of_overlay_apply_kunit_cleanup(), the "np" will be overwritten by the
second of_find_node_by_name(), and the error message came from
kunit_cleanup(), just call of_node_put() before it to fix it.

Fixes: 5c9dd72d8385 ("of: Add a KUnit test for overlays and test managed APIs")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/of/overlay_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/overlay_test.c b/drivers/of/overlay_test.c
index 19a292cdeee3..e95b1152612c 100644
--- a/drivers/of/overlay_test.c
+++ b/drivers/of/overlay_test.c
@@ -73,12 +73,12 @@ static void of_overlay_apply_kunit_cleanup(struct kunit *test)
 
 	np = of_find_node_by_name(NULL, kunit_node_name);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, np);
-	of_node_put_kunit(test, np);
 
 	pdev = of_find_device_by_node(np);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
 	put_device(&pdev->dev); /* Not derefing 'pdev' after this */
 
+	of_node_put(np);
 	/* Remove overlay */
 	kunit_cleanup(&fake);
 
-- 
2.34.1


