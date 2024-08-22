Return-Path: <linux-kernel+bounces-297313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1F595B60E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8953B253AB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 13:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C971CBEA5;
	Thu, 22 Aug 2024 13:09:24 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25A91C9ED2;
	Thu, 22 Aug 2024 13:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724332164; cv=none; b=GcYG0wybnFUJu+c3t0txHPQIJJFwN9RzQBcp4+L1z34d2ajN38cKpbK3GX7wZwdfncV3xUN1QKk/P2LTKEFt3fv3+3aEnrox3JbG5LYEICzFWoI7Exibq9Odm2I6UK4Ev3Pj/bBbW+4Voi+Jfdb+Mo6ECAGpy7+R7sO/3CzQFP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724332164; c=relaxed/simple;
	bh=AGd/cLuQb4A5E0Wiu65Gk84qJp4FBAjx4CHw2Lnfb8k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R+hkdf1kV59PkexmvL4myhPRbYpL3T9nkKsE+KjdEWoE5+5qab88FjvIYOWCBLEdfrkN/1Dt1m7oSku6crCobU+Pg5eQ7eiO57UmI3KuO9Ln00mFRxJTDue6jg8gvi/bMlzdPaWtoatuCD9Ug60kyTFMHU2JaIA4qhW8kgDWb08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WqNhM0HBfz20mJ1;
	Thu, 22 Aug 2024 21:04:35 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id E110C1A0188;
	Thu, 22 Aug 2024 21:09:17 +0800 (CST)
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
Subject: [PATCH -next 1/4] usb: phy: phy-gpio-vbus-usb: fix module autoloading
Date: Thu, 22 Aug 2024 13:01:10 +0000
Message-ID: <20240822130113.164644-2-liaochen4@huawei.com>
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
 drivers/usb/phy/phy-gpio-vbus-usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/phy/phy-gpio-vbus-usb.c b/drivers/usb/phy/phy-gpio-vbus-usb.c
index 817c242a76ca..5428b2b67de1 100644
--- a/drivers/usb/phy/phy-gpio-vbus-usb.c
+++ b/drivers/usb/phy/phy-gpio-vbus-usb.c
@@ -374,6 +374,7 @@ static const struct of_device_id gpio_vbus_of_match[] = {
 	},
 	{},
 };
+MODULE_DEVICE_TABLE(of, gpio_vbus_of_match);
 
 static struct platform_driver gpio_vbus_driver = {
 	.driver = {
-- 
2.34.1


