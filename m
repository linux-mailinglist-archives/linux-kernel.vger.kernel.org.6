Return-Path: <linux-kernel+bounces-301044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DB795EBD0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7CAF1F22B9A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2C615B562;
	Mon, 26 Aug 2024 08:21:05 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2865B13E8B6
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724660464; cv=none; b=Q8ZwAuRJ3tsiKZyBDi5suWbZfITwEavbBAKIVhgzd3Qv9HHtW4rU7tUEL2c20OYhOtdMiUjD5TJ1h8HhnAWHld37r0ekWVa/mUy19FXVHAJ1SGRtR1WolH6NdRkPnGP+381clS0JBDarPAEGUmyxt7sftZglC92ovPDhltm7B5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724660464; c=relaxed/simple;
	bh=Mr9hCNs+O49bH0NxD/PEQrOYFZjoMdWusHz8GwZ6rQo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t2H0SPp2Soi3jJg3/2h62G5jhE8vU1MxPTiO2ubzaomFtyP0pAtlabQWErsyPVrnTNKB8H3Yn6A2lt6k5q/xm5qt3EWuAIJtx0bdFiQQ2RZQZnX1HuQny7hk/7LEjfdtDiuhoJwSLb4IIvxBbVedAoJVU8z7P3+SqfvzTTbGpu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Wsk5m36qKz69Lg;
	Mon, 26 Aug 2024 16:16:12 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id DE81014037E;
	Mon, 26 Aug 2024 16:20:59 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Aug
 2024 16:20:59 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <lee@kernel.org>, <linux-kernel@vger.kernel.org>, <krzk@kernel.org>,
	<jic23@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 02/12] mfd: qcom-spmi-pmic: Use for_each_child_of_node_scoped()
Date: Mon, 26 Aug 2024 16:28:37 +0800
Message-ID: <20240826082847.2591036-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826082847.2591036-1-ruanjinjie@huawei.com>
References: <20240826082847.2591036-1-ruanjinjie@huawei.com>
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

Avoids the need for manual cleanup of_node_put() in early exits
from the loop.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/mfd/qcom-spmi-pmic.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mfd/qcom-spmi-pmic.c b/drivers/mfd/qcom-spmi-pmic.c
index eab5bf6cff10..b4b178caf754 100644
--- a/drivers/mfd/qcom-spmi-pmic.c
+++ b/drivers/mfd/qcom-spmi-pmic.c
@@ -84,7 +84,6 @@ static const struct of_device_id pmic_spmi_id_table[] = {
 static struct spmi_device *qcom_pmic_get_base_usid(struct spmi_device *sdev, struct qcom_spmi_dev *ctx)
 {
 	struct device_node *spmi_bus;
-	struct device_node *child;
 	int function_parent_usid, ret;
 	u32 pmic_addr;
 
@@ -108,10 +107,9 @@ static struct spmi_device *qcom_pmic_get_base_usid(struct spmi_device *sdev, str
 	 */
 	spmi_bus = of_get_parent(sdev->dev.of_node);
 	sdev = ERR_PTR(-ENODATA);
-	for_each_child_of_node(spmi_bus, child) {
+	for_each_child_of_node_scoped(spmi_bus, child) {
 		ret = of_property_read_u32_index(child, "reg", 0, &pmic_addr);
 		if (ret) {
-			of_node_put(child);
 			sdev = ERR_PTR(ret);
 			break;
 		}
@@ -125,7 +123,6 @@ static struct spmi_device *qcom_pmic_get_base_usid(struct spmi_device *sdev, str
 				 */
 				sdev = ERR_PTR(-EPROBE_DEFER);
 			}
-			of_node_put(child);
 			break;
 		}
 	}
-- 
2.34.1


