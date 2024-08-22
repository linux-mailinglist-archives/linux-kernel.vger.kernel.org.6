Return-Path: <linux-kernel+bounces-297312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D1B95B60A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE0792843A7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 13:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188C21CB32B;
	Thu, 22 Aug 2024 13:09:24 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A912B1C9DCF;
	Thu, 22 Aug 2024 13:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724332163; cv=none; b=eC2jIficPiTXcRYmt11RZ3/Rgk4wdyHqY17tc/qL8PPhC44puBYveJSmukf+RguB31c0u2brhSMJRv1bOD2m8A66GlGn/d0jcku8bTHni9Km3ZVXoSZIoz3R2EwfQ3POuLGIv6inczwjfLWj+p4uw5uBJ9fEM9dIOJqtyikQljI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724332163; c=relaxed/simple;
	bh=fH3w72nY5fA9CMZhrk/oeUUB1Q6HiXo45T87f9KunIE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C5oms+HMllVGpSJ3VuICLZhhzuTgs3snb/gk9TLWkh+miVE54jaW8RVVm5vC+GMR8KUQEIzCtD6daHJx+McSdrttD9Mt+fcNS88C+e5XJzhA0p38647iS4UhzXSw6FiA3YXVhuG7uO15v/rzz2D0Pgi86tH0s0fWmwmuPVSg1bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WqNhL6gb8z69Nl;
	Thu, 22 Aug 2024 21:04:34 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id 3E09F1800FF;
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
Subject: [PATCH -next 3/4] usb: typec: fix module autoloading
Date: Thu, 22 Aug 2024 13:01:12 +0000
Message-ID: <20240822130113.164644-4-liaochen4@huawei.com>
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
 drivers/usb/typec/anx7411.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/anx7411.c b/drivers/usb/typec/anx7411.c
index 5a5bf3532ad7..33ff301b918f 100644
--- a/drivers/usb/typec/anx7411.c
+++ b/drivers/usb/typec/anx7411.c
@@ -1576,6 +1576,7 @@ static const struct of_device_id anx_match_table[] = {
 	{.compatible = "analogix,anx7411",},
 	{},
 };
+MODULE_DEVICE_TABLE(of, anx_match_table);
 
 static struct i2c_driver anx7411_driver = {
 	.driver = {
-- 
2.34.1


