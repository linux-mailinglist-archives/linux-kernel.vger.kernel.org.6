Return-Path: <linux-kernel+bounces-395900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6719BC4BD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 06:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33B1B1F2250A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 05:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5C41BAEDC;
	Tue,  5 Nov 2024 05:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pNk0NC5s"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E921B652C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 05:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730785001; cv=none; b=ozlIvW3K2dEUwj4bjWFHue2gFuAEl/nDQk0uPn8mf/Kqg/R1ew0rBzOy7RNrmhhtYAygOlsRIywkmB+efeG7xUpW/UaJpmX/nFft32Jx9dB5T3a6xs/UDW0yjptymmZJhkBCywzXdGNMiNYKIKsnvsMS/axTN8F65H5t6AUt4tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730785001; c=relaxed/simple;
	bh=gsqi8UWYwZW+FFKHRC3djIqnm2yhVz86vrz/ef4JhaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lYHiZuxaiCe2qhOqeEVRBjwIcpupnf3hYWlX7dUo8QdmSuDVyM1Ya4CT0kz7UV0UE7b4SyWDd3vFqH+EK044LKNSyRMate48i6gOFPhYrcsLoIQabtuJhRQZRUKA3kuIY6mT8kKoZflHLbcbYu4aMOfdRp3K22IjgYPOqnhIWZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pNk0NC5s; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=NmYQI
	qNL67zkFkSfFu+pBgVdo0xBn6QfVDfDg3MWx3M=; b=pNk0NC5sJQGjVvxDKsvvC
	Od0Y7Nr/DDAvzH2Cn+ET7Tm+i6CUmNqayaCHWv6Q8zg8FU72JDphhw/IKdUNdMxM
	/0EzhthMjPyoGFUtGuEhkmveTpnuqfY9CvfCTd0SRmSyuQvSe5zOeWOqhkeNF4OM
	uXhcFCI9H06KIsvSVh9DyQ=
Received: from localhost.localdomain (unknown [124.16.141.247])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDn75zGrilnWUHdAw--.23436S4;
	Tue, 05 Nov 2024 13:36:09 +0800 (CST)
From: Wentao Liang <Wentao_liang_g@163.com>
To: shannon.nelson@amd.com,
	brett.creeley@amd.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Wentao Liang <Wentao_liang_g@163.com>
Subject: [PATCH] ionic: fix memory leak in ionic_probe
Date: Tue,  5 Nov 2024 13:34:33 +0800
Message-ID: <20241105053433.1614-1-Wentao_liang_g@163.com>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn75zGrilnWUHdAw--.23436S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr43JFy7tFWkJw1kAr1xAFb_yoWkWrc_K3
	48Zr9xJ3y5Gr18tw17Kr43Z34a9FZagr18Ja1SgFWfKa429r4DAF1DZFnrXa1rWr1xAFZ8
	ZFn3tFy5Z340qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRWnQUUUUUUU==
X-CM-SenderInfo: xzhq3t5rboxtpqjbwqqrwthudrp/1tbiDxCOL2cpqyZI8wAAsG

In line 334, the ionic_setup_one() creates a debugfs entry for
ionic upon successful execution. However, the ionic_probe() does
not release the dentry before returning, resulting in a memory
leak. To fix this bug, we add the ionic_debugfs_del_dev() before
line 397 to release the resources before the function returns.

Signed-off-by: Wentao Liang <Wentao_liang_g@163.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
index b93791d6b593..f5dc876eb500 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -394,6 +394,7 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 err_out_pci:
 	ionic_dev_teardown(ionic);
 	ionic_clear_pci(ionic);
+	ionic_debugfs_del_dev(ionic);
 err_out:
 	mutex_destroy(&ionic->dev_cmd_lock);
 	ionic_devlink_free(ionic);
-- 
2.42.0.windows.2


