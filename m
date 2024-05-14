Return-Path: <linux-kernel+bounces-178745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B838C571C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 15:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEF77B23842
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 13:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A26514431F;
	Tue, 14 May 2024 13:19:21 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63820144300
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 13:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692760; cv=none; b=QLkUVCRSA4LUKo/0ukR2I1yW2NyWtgwEd+d3dXI29SnWar0W0w/ahBLSqQKxeERIwVZOa/T4OaqLYOdQ+ikRJKT8//YO3rknWR41jUVvLsxe1vZHDtANoHnCBQ2SI/PjDpjk3ZTZ0VCPgzZ7/yhGX1IZv5HxJic33PIBU7SmAO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692760; c=relaxed/simple;
	bh=cJiBVNeB/ev5QePxtoR/5J6ogoCMOxKP9w9B7a43nD8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n0wZPOj+sdjrQ+yoBn29vnUhgIXv5kS6jGduGS/js4rw4mXQXFe1vsIuq/x/rqGMnFcmP6BPMrBbPnfk524tFX/4Pz+X8UBsirXE7hvxn4sOvNDS2TTDSexSo0E9FwUgqL9jh2dIVPxfoBf4vIkem6jhMHWHLv3JzOBORQw3trI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VdxgM4JRSzkXdf
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:15:43 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
	by mail.maildlp.com (Postfix) with ESMTPS id 6573018007E
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:19:16 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 14 May
 2024 21:19:15 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] genirq: Refactor the irq_chip_xxx_parent()
Date: Tue, 14 May 2024 21:19:10 +0800
Message-ID: <20240514131910.2614027-1-ruanjinjie@huawei.com>
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
 kwepemi500008.china.huawei.com (7.221.188.139)

Refactor the irq_chip_xxx_parent(), which can reduce a few lines of codes,
with no functional changes.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/irq/chip.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index dc94e0bf2c94..0e358d9a5d06 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1345,6 +1345,13 @@ int irq_chip_get_parent_state(struct irq_data *data,
 }
 EXPORT_SYMBOL_GPL(irq_chip_get_parent_state);
 
+static inline void irq_chip_do_common_parent(void (*chip_action)(struct irq_data *),
+					     struct irq_data *data)
+{
+	data = data->parent_data;
+	chip_action(data);
+}
+
 /**
  * irq_chip_enable_parent - Enable the parent interrupt (defaults to unmask if
  * NULL)
@@ -1352,11 +1359,8 @@ EXPORT_SYMBOL_GPL(irq_chip_get_parent_state);
  */
 void irq_chip_enable_parent(struct irq_data *data)
 {
-	data = data->parent_data;
-	if (data->chip->irq_enable)
-		data->chip->irq_enable(data);
-	else
-		data->chip->irq_unmask(data);
+	irq_chip_do_common_parent(data->chip->irq_enable ? : data->chip->irq_unmask,
+				  data);
 }
 EXPORT_SYMBOL_GPL(irq_chip_enable_parent);
 
@@ -1367,11 +1371,8 @@ EXPORT_SYMBOL_GPL(irq_chip_enable_parent);
  */
 void irq_chip_disable_parent(struct irq_data *data)
 {
-	data = data->parent_data;
-	if (data->chip->irq_disable)
-		data->chip->irq_disable(data);
-	else
-		data->chip->irq_mask(data);
+	irq_chip_do_common_parent(data->chip->irq_disable ? : data->chip->irq_mask,
+				  data);
 }
 EXPORT_SYMBOL_GPL(irq_chip_disable_parent);
 
@@ -1381,8 +1382,7 @@ EXPORT_SYMBOL_GPL(irq_chip_disable_parent);
  */
 void irq_chip_ack_parent(struct irq_data *data)
 {
-	data = data->parent_data;
-	data->chip->irq_ack(data);
+	irq_chip_do_common_parent(data->chip->irq_ack, data);
 }
 EXPORT_SYMBOL_GPL(irq_chip_ack_parent);
 
@@ -1392,8 +1392,7 @@ EXPORT_SYMBOL_GPL(irq_chip_ack_parent);
  */
 void irq_chip_mask_parent(struct irq_data *data)
 {
-	data = data->parent_data;
-	data->chip->irq_mask(data);
+	irq_chip_do_common_parent(data->chip->irq_mask, data);
 }
 EXPORT_SYMBOL_GPL(irq_chip_mask_parent);
 
@@ -1403,8 +1402,7 @@ EXPORT_SYMBOL_GPL(irq_chip_mask_parent);
  */
 void irq_chip_mask_ack_parent(struct irq_data *data)
 {
-	data = data->parent_data;
-	data->chip->irq_mask_ack(data);
+	irq_chip_do_common_parent(data->chip->irq_mask_ack, data);
 }
 EXPORT_SYMBOL_GPL(irq_chip_mask_ack_parent);
 
@@ -1414,8 +1412,7 @@ EXPORT_SYMBOL_GPL(irq_chip_mask_ack_parent);
  */
 void irq_chip_unmask_parent(struct irq_data *data)
 {
-	data = data->parent_data;
-	data->chip->irq_unmask(data);
+	irq_chip_do_common_parent(data->chip->irq_unmask, data);
 }
 EXPORT_SYMBOL_GPL(irq_chip_unmask_parent);
 
@@ -1425,8 +1422,7 @@ EXPORT_SYMBOL_GPL(irq_chip_unmask_parent);
  */
 void irq_chip_eoi_parent(struct irq_data *data)
 {
-	data = data->parent_data;
-	data->chip->irq_eoi(data);
+	irq_chip_do_common_parent(data->chip->irq_eoi, data);
 }
 EXPORT_SYMBOL_GPL(irq_chip_eoi_parent);
 
-- 
2.34.1


