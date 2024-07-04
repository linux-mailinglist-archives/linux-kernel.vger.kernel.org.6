Return-Path: <linux-kernel+bounces-240932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8155B9274C4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4BBA1C21DF2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DA71AC25D;
	Thu,  4 Jul 2024 11:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qC/dAmFM"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB5D210EE;
	Thu,  4 Jul 2024 11:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720091834; cv=fail; b=r1eDB9w9C/C6uzTfHwZ3ASQveLRzb+fo8ndXcDZxPfpOKJ5+k/hChedMTAyaTErIXj0UuNFvcyGT3yW1ZuWc6nw9PSRHinYAJy5MYmYujPardY4zmlOj3wgLLSlOMvdiTQgXDzK8dfM7xHwxE3/rAF+USne5F98Iwfh+/spLpfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720091834; c=relaxed/simple;
	bh=R1m7ot5FKRzDkYfgVlTA5Ah0kQcf+sSzUZIx+fpSuSc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E2QkvDcYvvzbA8YQf2V2vbNG23wVD8lOjFQvjI66SXD4ORYCKTleF06WwCH2BUmQ89Z0LUIoXTSOrQqqwL1/oayOnCANVptDL6IDr3jUxyMI+YbeWqvoyGuy63Do1/NmSME1t8CC2QKmEpXx9BRY4dy8Bj3hMp+oM1fNTsQdnoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qC/dAmFM; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKv74VslWl2IFuuSAiYj1L1XTWyZxK5LN/LdI0H4P1MlDFDbK+mXOquVHjA4bba++blJvOHsekhudhWMvCMhBSastVwCBbigkizJpNwjcdEIdBBwb8Qs/FYOFOhyoreqkwbpYOl+92z2G4/gWdQat9CSlgXqm8qM+W7oqEp+O1+PnKuR7Y36xFpYbomRPNNCwumMIY6u5uq/ltIscGGWWplVQW1dkpDME0EButVL6rD/37Hf7OUJaEobP9oHO5E4RuM699tA/mfFGrRyVCKpC6+FXqYLwG1hygXiUlK1KX3DM+KieJYfVMYHkJW9yXq7sW8LvnFTxZ/0dAQX3yt8NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LFuiIFk2v2itO9RZXFOhskAM2OUJZTuKvZdA5C5O1g=;
 b=BRI0iAN85MS8luNx5M6whtITSnzIVACdb2z3XtftiMIbFGMsVvmBh6TqG73WemKq8CVHu4iw8sPff+8HAWmVF/TJdJxLdS/7h1xKFRh2Vk4jhXWaPFFWgfpShRFr+cfrOiSXy0Dk2YkAUl/1e6WqXMcPrnaVKeqj54Gk8NqAfw61pkTQoZ5q/VC1N2nBH3NI9BBtqR1YiCghgU6HiC2+GYbpSIcwD93V1eBh1s5/o7ysQ4H8sEpphzwNl81u2+rqTPCyUdprUnD7CoPxwkRmZVzMay71EHgPdBj1+HH10yrDTKn+NiaXzY7jCGoiQs5++rPjaj8ebBbBspsoxYdeBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LFuiIFk2v2itO9RZXFOhskAM2OUJZTuKvZdA5C5O1g=;
 b=qC/dAmFMS+ZnJR9c6qpKjcdR5GXK1wG+Noebj5WgVeL/yk0v1696fAprRZwzwU058JqbhkleYB9tkdtzvnPeOvPiBJnG9MxpQl/MgRYT5GMBLfb6KH8u1wAsytLkVN2KJ5NPFBBo0o6a6KN+CWVWJBpGHYND4zeY+3nx7umxynE=
Received: from CH2PR20CA0014.namprd20.prod.outlook.com (2603:10b6:610:58::24)
 by MN0PR12MB5859.namprd12.prod.outlook.com (2603:10b6:208:37a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 11:17:10 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::a) by CH2PR20CA0014.outlook.office365.com
 (2603:10b6:610:58::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.26 via Frontend
 Transport; Thu, 4 Jul 2024 11:17:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Thu, 4 Jul 2024 11:17:10 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Jul
 2024 06:17:07 -0500
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>
CC: <naveenkrishna.chatradhi@amd.com>, Akshay Gupta <akshay.gupta@amd.com>
Subject: [PATCH 2/6] misc: sbrmi: Add platform device add to create platform device
Date: Thu, 4 Jul 2024 11:16:20 +0000
Message-ID: <20240704111624.1583460-3-akshay.gupta@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240704111624.1583460-1-akshay.gupta@amd.com>
References: <20240704111624.1583460-1-akshay.gupta@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|MN0PR12MB5859:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a7440fd-ea68-4927-17c9-08dc9c1ad8e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0FlUB8d8bo1urbVfbskL3rYsB0Bs3kRkB0xlDCrw6IRrPmk/iW3GHTFZPqbJ?=
 =?us-ascii?Q?wolfwmNO9Y8pcvvJfnQycgFfRqOp6dcExMPmtJMfwZx0GCQDdtXXI9qznA5p?=
 =?us-ascii?Q?X/dkmR9TwNebfp7v1FCYJzCSKZJTpOUhEb/oe2dzGXO1w+/qftkrfOAe2o+p?=
 =?us-ascii?Q?lTPeIuYceVp3JXtjhrjbRZKYnWS1ryIghhZViP6mwRXZacstd0gFx+JxaS11?=
 =?us-ascii?Q?+5qJWbIaw4VQ7XniKX56CaQaze53t6qz3dP7nj/bkZ2gw1oEJwvkaKYDrke6?=
 =?us-ascii?Q?dwypk5cHOfhOHI2sdYt/CmdluETYBQpayU1ReSPLpgzc0qvTVH86f5z0R71M?=
 =?us-ascii?Q?Rbk6TUJq16ZZYv7XWZ24+It5y9hBlzT3C/1b9L+1iTlyKbmwVwQvNd9xU1XE?=
 =?us-ascii?Q?8K01ybiO8if+0j7tZXjtEtlJvQjjl/zpRmNy160X8YzVLskc7Y8yaZnaYfAJ?=
 =?us-ascii?Q?K5nylAANlz5kwaAdiSr7gwImNMzdYfe53K4wsuvEg5BCLLqTwOgmzzcpXoRz?=
 =?us-ascii?Q?ZGzOTdE9TRYxp4myMJz69O/9BAvWO873EXv74EU1DVYXMT6VQxPheLqXs3F4?=
 =?us-ascii?Q?5uYHU7C5lq4XVhm/xOj2I2YVGnq1b6CuTGHpTMt3urfcNuE2m8ulEsqP4TH6?=
 =?us-ascii?Q?xpgGlTMXy6VDunqlu/6lSo8YOCRzSfX4Cqp5rJLwfdTPpNv/vmS8CuYyvl8F?=
 =?us-ascii?Q?srRyhRfxSavoq8cEAEC85E+MSnVuejIw7gJzwiPDIQwq884CAwPLT7lyhhsA?=
 =?us-ascii?Q?sjmDTz6pXu8D1xm0kCTvtP/aIlSHP1aCYE2mf1+wB+hkN2juMLGvg21uhqtT?=
 =?us-ascii?Q?gTngw3oxgRI83GWtr/ituklMQv7qzpKTynOY/h5N/2sSVqqtaKihjpNCILkV?=
 =?us-ascii?Q?90QV6k+R2DG2PLQQQwuMXVrHcj9FCjl+CUMuWw2MDJ4CoChaE37rC75VpzpW?=
 =?us-ascii?Q?71rSUhBxS9nOy+9rS1tzzN79h1gin1TJhbO4qidmrqdUZpqJqZHax79eIF7f?=
 =?us-ascii?Q?79K9ZHjWuiaAFhanNt2Ve3krlBIMEJHNsbODytiZXh232aacJcfr9JXBBxFO?=
 =?us-ascii?Q?yXEAY4R66QBgROMvjEeukhtUS/N6yoQCVQUO8mUmyUBGQ5V9EPoJAOt3v/ID?=
 =?us-ascii?Q?bo2shrmr2oMXoJ5FFPB/yBQAhB4PK6yIDskRv9/ZxmcU174/mHSuul2mcffd?=
 =?us-ascii?Q?c4hg1whkpqP99ko6fyECuR0QUCa8j62qKvVuBpCqzBH+621LYUQuLyJEiGGk?=
 =?us-ascii?Q?MsONHmoYBmEh19vJnEhQ0iKua3Gmg6rfc++XU6xxCMkWcV/lofiSED0y0mI5?=
 =?us-ascii?Q?MsnMaJJsugLIJs7bNI9ClBTdP20ng00Z4I5BfXCdmHd6BR0EywQ7L+mRHbR9?=
 =?us-ascii?Q?hMNPjVLrMb4QUtgvGbwwnoqtWMizs1RD6P1kOVVzd90ZtVqMBOe4xbTrgRL7?=
 =?us-ascii?Q?LsQfGYLa0PMaEAG9DffwihoseVc3IJFm?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 11:17:10.0493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a7440fd-ea68-4927-17c9-08dc9c1ad8e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5859

- AMD provides socket power information from out of band
  which can be read by sensors.
- platform driver will probe drivers/hwmon/sbrmi as a platform device
  and share the sbrmi device data.

Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
---
 drivers/misc/amd-sb/sbrmi-i2c.c | 25 ++++++++++++++++++++++++-
 include/misc/amd-sb.h           |  2 ++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/amd-sb/sbrmi-i2c.c b/drivers/misc/amd-sb/sbrmi-i2c.c
index c4903d9e9f0f..b593bbdd78e0 100644
--- a/drivers/misc/amd-sb/sbrmi-i2c.c
+++ b/drivers/misc/amd-sb/sbrmi-i2c.c
@@ -72,7 +72,29 @@ static int sbrmi_i2c_probe(struct i2c_client *client)
 		return ret;
 
 	/* Cache maximum power limit */
-	return sbrmi_get_max_pwr_limit(data);
+	ret = sbrmi_get_max_pwr_limit(data);
+	if (ret < 0)
+		return ret;
+
+	dev_set_drvdata(dev, (void *)data);
+	data->pdev = platform_device_register_data(dev, "sbrmi-hwmon",
+						   PLATFORM_DEVID_NONE,
+						   data,
+						   sizeof(struct sbrmi_data));
+	if (IS_ERR(data->pdev)) {
+		pr_err("unable to register platform device for sbrmi-hwmon\n");
+		return PTR_ERR(data->pdev);
+	}
+	return ret;
+}
+
+static void sbrmi_i2c_remove(struct i2c_client *client)
+{
+	struct sbrmi_data *data = dev_get_drvdata(&client->dev);
+
+	if (!data)
+		return;
+	platform_device_unregister(data->pdev);
 }
 
 static const struct i2c_device_id sbrmi_id[] = {
@@ -95,6 +117,7 @@ static struct i2c_driver sbrmi_driver = {
 		.of_match_table = of_match_ptr(sbrmi_of_match),
 	},
 	.probe = sbrmi_i2c_probe,
+	.remove = sbrmi_i2c_remove,
 	.id_table = sbrmi_id,
 };
 
diff --git a/include/misc/amd-sb.h b/include/misc/amd-sb.h
index e1a012fcdff9..79b76dd6068a 100644
--- a/include/misc/amd-sb.h
+++ b/include/misc/amd-sb.h
@@ -8,6 +8,7 @@
 
 #include <linux/mutex.h>
 #include <linux/i2c.h>
+#include <linux/platform_device.h>
 /*
  * SB-RMI supports soft mailbox service request to MP1 (power management
  * firmware) through SBRMI inbound/outbound message registers.
@@ -24,6 +25,7 @@ enum sbrmi_msg_id {
 struct sbrmi_data {
 	struct i2c_client *client;
 	struct mutex lock;
+	struct platform_device *pdev;
 	u32 pwr_limit_max;
 };
 
-- 
2.25.1


