Return-Path: <linux-kernel+bounces-297311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBB195B607
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 474A72852A0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 13:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB1F1CB307;
	Thu, 22 Aug 2024 13:09:23 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8AC1C9DDE;
	Thu, 22 Aug 2024 13:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724332163; cv=none; b=gdeSD/zZb0oHzVIY+pKgrZRYd4CLSzPoLHW19tg4/SE/bXki4qMT0i/sCnHNzJrldz++7+B03wh9Sdc6oGmqVSX070/vXl3jYiBQJw7j8UMEskTlYAnMhhl39YJSYpl+6ZJ0XMZCtxLQ//1dN+asRXLHTiz0bE0+we8Ek9snxag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724332163; c=relaxed/simple;
	bh=WY8yCk7jyloSUPJCJcz2c8B4mqrFr0PJkfactdGuonc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YnTLrfWRcuAglJZRLr3BFUZ/IVXJbIdGtSeo0ujkbOIUVGeCQ6BZMlGXM1fXWZg31LCVlQBGTLUfQ9fQvdMJosKc17ncrOhYo6mqoyvebM5OEyKa+mANOO3FBV2kos5RY2iK1xL6B+BNi9RBzY83K3guiNUN/Btb6G3eFB5j+04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WqNn12kjGzyQPt;
	Thu, 22 Aug 2024 21:08:37 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id 162471800D3;
	Thu, 22 Aug 2024 21:09:18 +0800 (CST)
Received: from huawei.com (10.67.174.77) by dggpemm500020.china.huawei.com
 (7.185.36.49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 22 Aug
 2024 21:09:17 +0800
From: Liao Chen <liaochen4@huawei.com>
To: <linux-usb@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<alcooperx@gmail.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<heikki.krogerus@linux.intel.com>, <stern@rowland.harvard.edu>,
	<justin.chen@broadcom.com>
Subject: [PATCH -next 2/4] usb: misc: brcmstb-usb-pinmap: fix module autoloading
Date: Thu, 22 Aug 2024 13:01:11 +0000
Message-ID: <20240822130113.164644-3-liaochen4@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822130113.164644-1-liaochen4@huawei.com>
References: <20240822130113.164644-1-liaochen4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500020.china.huawei.com (7.185.36.49)

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Liao Chen <liaochen4@huawei.com>
---
 drivers/usb/misc/brcmstb-usb-pinmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/misc/brcmstb-usb-pinmap.c b/drivers/usb/misc/brcmstb-usb-pinmap.c
index 2b2019c19cde..1ce885e4184c 100644
--- a/drivers/usb/misc/brcmstb-usb-pinmap.c
+++ b/drivers/usb/misc/brcmstb-usb-pinmap.c
@@ -335,6 +335,7 @@ static const struct of_device_id brcmstb_usb_pinmap_of_match[] = {
 	{ .compatible = "brcm,usb-pinmap" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, brcmstb_usb_pinmap_of_match);
 
 static struct platform_driver brcmstb_usb_pinmap_driver = {
 	.driver = {
-- 
2.34.1


