Return-Path: <linux-kernel+bounces-304923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 893399626C6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1491B22B7A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D19175D2C;
	Wed, 28 Aug 2024 12:19:26 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D799816BE1D
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 12:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724847565; cv=none; b=U62b/tRh8HMR9V3+aZJFhX1IVXZ3zktPjPWu3HEWbOyD21JyVuc37ysDA2VQDWUkADmlaCS4wC8wIv7NoFDA498aMj1RkL8epNEmoQMnQcdTKAXTzWkrd0zGdjEqEMlXEMa9l+wPHdEO3K3pihUOTZNhbMZV9X87imO88kqX2rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724847565; c=relaxed/simple;
	bh=c/zCIgUSExh4xtw72YdYU01LGignukwUnWvDlSBvPE0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RA2MfhYhWrkdZ+hUIgvGsL/Bnwr4GFtpP92j1NbTJZPZkI55e+/Wz/oQ+uwuQxJ2M54Nh1RcPvHTmIS5+0z/rV6OA1IRhIolUasSljHUshpP5HW6sOLqM6C9xumAGDGX8gUv+45SS4wDnYmzqDshQy9krNpqEPF62S4l5m03b9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wv3KZ17wNz1HHJh
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 20:16:02 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 0378D14013B
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 20:19:22 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 Aug
 2024 20:19:21 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <tglx@linutronix.de>
CC: <lihongbo22@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] irqdomain: Use IS_ERR_OR_NULL() helper function
Date: Wed, 28 Aug 2024 20:27:24 +0800
Message-ID: <20240828122724.3697447-1-lihongbo22@huawei.com>
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
 dggpeml500022.china.huawei.com (7.185.36.66)

Use the IS_ERR_OR_NULL() helper instead of open-coding a
NULL and an error pointer checks to simplify the code and
improve readability.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 kernel/irq/irqdomain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 5df8780100bb..e0bff21f30e0 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1403,7 +1403,7 @@ static int irq_domain_trim_hierarchy(unsigned int virq)
 	tail = NULL;
 
 	/* The first entry must have a valid irqchip */
-	if (!irq_data->chip || IS_ERR(irq_data->chip))
+	if (IS_ERR_OR_NULL(irq_data->chip))
 		return -EINVAL;
 
 	/*
-- 
2.34.1


