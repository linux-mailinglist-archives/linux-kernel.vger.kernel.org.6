Return-Path: <linux-kernel+bounces-367065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E24BD99FE38
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FBA71C24528
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 01:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BBC12B143;
	Wed, 16 Oct 2024 01:25:29 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE21828EA
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 01:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729041928; cv=none; b=u36ql3jZz4feHbfO/vh39dG2CTInGxRdxtrQq2VLEJ/uylzwMrSKkZNdNqjU6AHHpyL1t5utZaqUtjVnviuoSno3PQK7eRiL33d5L63e8teUGvnWudkzVAYBeDyA1GqVJ0ufkJjsKg82x6I/rxYxXK2Iopgb99yzrC0A37cURbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729041928; c=relaxed/simple;
	bh=Waa6azyHClNCo+LV96c108RxeW+WZlMoUystoOV9iXA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nJx/K1QGeRodCkndgv6JBsb/rYlshAAH/Xkjky7H5YIVYr+gom4SIrdElpI+8KopEGK1QNOlIYM/oXqVaxe5F3JZK5c1/OZ3x5GIAtXFTmt4Ekirqyex3F5pV7kj5GkFgnJaCrS5za3kbtBMgWCtJjTXkvyzGpfDGR6s5aHw5ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XStWx4nkLzpX3B;
	Wed, 16 Oct 2024 09:23:25 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id 22DBC140157;
	Wed, 16 Oct 2024 09:25:24 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 16 Oct
 2024 09:25:23 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <nm@ti.com>, <kristo@kernel.org>, <ssantosh@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<bobo.shaobowang@huawei.com>
Subject: [PATCH] firmware: ti_sci: Fix compilation failure when CONFIG_TI_SCI_PROTOCOL=m
Date: Wed, 16 Oct 2024 09:39:22 +0800
Message-ID: <20241016013922.1392290-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
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

When build with CONFIG_TI_SCI_PROTOCOL=m && CONFIG_TI_K3_M4_REMOTEPROC=y,
compilation tool chain would throw the following error message:

   arm-linux-gnueabi-ld: drivers/remoteproc/ti_k3_m4_remoteproc.o:
   in function `k3_m4_rproc_probe':
   ti_k3_m4_remoteproc.c:(.text+0xc24):
   undefined reference to `devm_ti_sci_get_by_phandle'

This is because devm_ti_sci_get_by_phandle() is compiled into the driver
module rather than compiled into kernel, it causes compilation couldn't
find the reference of devm_ti_sci_get_by_phandle() when tool chain tries
to link ti_k3_m4_remoteproc.o into kernel image.

Replace IS_ENABLED with IS_REACHABLE to fix the problem.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/all/202410150837.FOGlkGvW-lkp@intel.com/
Fixes: aa276781a64a ("firmware: Add basic support for TI System Control Interface (TI-SCI) protocol")
Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 include/linux/soc/ti/ti_sci_protocol.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
index bd0d11af76c5..cd44ee7f294b 100644
--- a/include/linux/soc/ti/ti_sci_protocol.h
+++ b/include/linux/soc/ti/ti_sci_protocol.h
@@ -572,7 +572,7 @@ struct ti_sci_resource {
 	struct ti_sci_resource_desc *desc;
 };
 
-#if IS_ENABLED(CONFIG_TI_SCI_PROTOCOL)
+#if IS_REACHABLE(CONFIG_TI_SCI_PROTOCOL)
 const struct ti_sci_handle *ti_sci_get_handle(struct device *dev);
 int ti_sci_put_handle(const struct ti_sci_handle *handle);
 const struct ti_sci_handle *devm_ti_sci_get_handle(struct device *dev);
-- 
2.25.1


