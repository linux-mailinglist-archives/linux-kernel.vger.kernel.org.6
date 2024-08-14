Return-Path: <linux-kernel+bounces-285789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7519512B8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 04:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DA392858D5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 02:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8802C6BD;
	Wed, 14 Aug 2024 02:53:50 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E924E32C85;
	Wed, 14 Aug 2024 02:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723604030; cv=none; b=ZNUqy/6OPNON5xrB0u8bjvMrTFN6gxUHVMeNlCjP+YY5wEhYSChFYJHIkt/s4ahPTY7BW4BoMTCPAUk4EfEqgQz7kkasaJix0TXxhJuL009IOEwr2NTzk8h6PgcIXMaOKVatz4Kh61bSUf9g8zPWYIkG2q8DKDPYqA2rTLlrUXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723604030; c=relaxed/simple;
	bh=ek3xqSMCCGg5HeJYVtiUDEtTeC2TkWuZXkEKbYTSn1g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WeFxQAiqgDCW4Vm8bes5qmC+KZqo2lWDcMVDgQD73XXf6THL/hQ2KpHg+I4A+hvEBgZoNbNXdwRyOuCNWEYDRlefhvnY/+ZnnSeg38SC1hPF+XT9hXVFhPeAXQRpMHChCnTAXsbMPr7OELqvwgCHNgAUtdNOytHdCYgfNsgQmDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WkCTg6X4RzndtW;
	Wed, 14 Aug 2024 10:52:23 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id 2E3FE1800D0;
	Wed, 14 Aug 2024 10:53:44 +0800 (CST)
Received: from huawei.com (10.67.174.77) by dggpemm500020.china.huawei.com
 (7.185.36.49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 14 Aug
 2024 10:53:43 +0800
From: Liao Chen <liaochen4@huawei.com>
To: <linux-hwmon@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tharvey@gateworks.com>,
	<jdelvare@suse.com>, <linux@roeck-us.net>
Subject: [PATCH -next] hwmon: (gsc-hwmon) fix module autoloading
Date: Wed, 14 Aug 2024 02:45:55 +0000
Message-ID: <20240814024555.3875387-1-liaochen4@huawei.com>
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
 dggpemm500020.china.huawei.com (7.185.36.49)

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Liao Chen <liaochen4@huawei.com>
---
 drivers/hwmon/gsc-hwmon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/gsc-hwmon.c b/drivers/hwmon/gsc-hwmon.c
index cb2f01dc4326..4514f3ed90cc 100644
--- a/drivers/hwmon/gsc-hwmon.c
+++ b/drivers/hwmon/gsc-hwmon.c
@@ -400,6 +400,7 @@ static const struct of_device_id gsc_hwmon_of_match[] = {
 	{ .compatible = "gw,gsc-adc", },
 	{}
 };
+MODULE_DEVICE_TABLE(of, gsc_hwmon_of_match);
 
 static struct platform_driver gsc_hwmon_driver = {
 	.driver = {
-- 
2.34.1


