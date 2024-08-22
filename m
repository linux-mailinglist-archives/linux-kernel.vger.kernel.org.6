Return-Path: <linux-kernel+bounces-297310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A7495B605
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A14D2840EB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 13:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496B81CB150;
	Thu, 22 Aug 2024 13:09:23 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8D21C9454;
	Thu, 22 Aug 2024 13:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724332162; cv=none; b=h5UaDrzrVldo9Vo4Ma7zxtsiTC9XNZUkcvozTYqZ7pOqJ0nQFy0X2g5y5t2WJei62pGOjI0rh65Z5b/qGgqrs/YVAKuNqti/cvpo+W5guHjUwT952f9QZ9NOAX/xucdGgcyYagVKG9nviwuNF2M+ZUbTaCk6zrBbk1sSVp7crRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724332162; c=relaxed/simple;
	bh=lVg1GtkG/UXPw6eLBm3vM/+bHlQwcWAnCvNdakzy1nE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pdOLeLD2M7C/+M3BnEN//xJJfViKpHVZGJsqAcncceVDBpkHTqX6IFgUBAFNxyiBODHy+iVjpcu1ETX5S7zXnUX9Y1Jxf3WrdhBTg7yJnecduE4AF4EfcZJVI7inOXwlDj0LyjuM/5Z3w0bd7jRIQmRIovVH+f+pf6Z92mWqYkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WqNnk0vTNz1S8c1;
	Thu, 22 Aug 2024 21:09:14 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id 6D05F1400DD;
	Thu, 22 Aug 2024 21:09:18 +0800 (CST)
Received: from huawei.com (10.67.174.77) by dggpemm500020.china.huawei.com
 (7.185.36.49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 22 Aug
 2024 21:09:18 +0800
From: Liao Chen <liaochen4@huawei.com>
To: <linux-usb@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<alcooperx@gmail.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<heikki.krogerus@linux.intel.com>, <stern@rowland.harvard.edu>,
	<justin.chen@broadcom.com>
Subject: [PATCH -next 4/4] usb: ehci-brcm: fix module autoloading
Date: Thu, 22 Aug 2024 13:01:13 +0000
Message-ID: <20240822130113.164644-5-liaochen4@huawei.com>
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
 drivers/usb/host/ehci-brcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/ehci-brcm.c b/drivers/usb/host/ehci-brcm.c
index 77e42c739c58..68cad0620f1a 100644
--- a/drivers/usb/host/ehci-brcm.c
+++ b/drivers/usb/host/ehci-brcm.c
@@ -246,6 +246,7 @@ static const struct of_device_id brcm_ehci_of_match[] = {
 	{ .compatible = "brcm,bcm7445-ehci", },
 	{}
 };
+MODULE_DEVICE_TABLE(of, brcm_ehci_of_match);
 
 static struct platform_driver ehci_brcm_driver = {
 	.probe		= ehci_brcm_probe,
-- 
2.34.1


