Return-Path: <linux-kernel+bounces-375789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D569A9ACD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75FB91F2240D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F0F1494AD;
	Tue, 22 Oct 2024 07:19:46 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619D9148FEB
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 07:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729581585; cv=none; b=XipXcoBm+Mm2wJu9TzdP3Ug6N5/MBYDb/ftdIlF554dInRkWmqUMDo8VKigYkuBYLnWF7j7/KRhBJUaoNZXIbdukVpw4YSJZ5cQ2MkHNKU7y9gS+kQN7yPUkATWfjrebTGfgIfKLd00ZL0s2aMMuVj8oQDUnNICipUF24VE/450=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729581585; c=relaxed/simple;
	bh=Q9sdJ/PQd8sUI85C+ZJL6wDJlNxZakeA20Hgrdv84/M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ktn8p4ASyjYjRq7EEx/o9+PlAm2CS1NNCKwIzF2uLSjw6mpnHUM3PwcS1fT2toI0A0h8PoJmpGUcakdjCiYNoReXgUKjx8c3Acu1XyDtvjAH1H7NdifE+uODKG5fEijRw+DzHPblQVHDrevlCI2OlZaRUFx2YYvijliCykUyaEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee867175205919-98957;
	Tue, 22 Oct 2024 15:19:34 +0800 (CST)
X-RM-TRANSID:2ee867175205919-98957
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain.localdomain (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee867175205938-7bce6;
	Tue, 22 Oct 2024 15:19:34 +0800 (CST)
X-RM-TRANSID:2ee867175205938-7bce6
From: Liu Jing <liujing@cmss.chinamobile.com>
To: kbusch@kernel.org
Cc: axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Liu Jing <liujing@cmss.chinamobile.com>
Subject: [PATCH] nvme-pci: After the memory is released, the corresponding pointer needs to point to empty
Date: Tue, 22 Oct 2024 03:01:50 +0800
Message-Id: <20241021190150.5974-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code frees memory pointed to by dev->queues. After freeing memory,
dev->queues should be set to NULL to avoid dangling Pointers.

Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
---
 drivers/nvme/host/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 1cbff7537788..c1500c00f571 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2731,7 +2731,9 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 	nvme_free_tagset(dev);
 	put_device(dev->dev);
 	kfree(dev->queues);
+	dev->queues = NULL;
 	kfree(dev);
+	dev = NULL;
 }
 
 static void nvme_reset_work(struct work_struct *work)
@@ -3055,8 +3057,10 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 out_put_device:
 	put_device(dev->dev);
 	kfree(dev->queues);
+	dev->queues = NULL;
 out_free_dev:
 	kfree(dev);
+	dev = NULL;
 	return ERR_PTR(ret);
 }
 
-- 
2.27.0




