Return-Path: <linux-kernel+bounces-178502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 398888C4EA7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 11:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B8D528121D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 09:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25575A109;
	Tue, 14 May 2024 09:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="RHocDRCL"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2052.outbound.protection.outlook.com [40.107.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFD1537FF;
	Tue, 14 May 2024 09:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715678574; cv=fail; b=uLqnfCXTbmy+qTbaAsCg5R+0Lpa9c6XC87SDoo2fZE7MF4MtRb0eQByt19V1POE2yvRimrzZ3+eKdXvCV0PM/EjcWiVVr1+3nfU+oTmBUpdOs2DNwkM3fTR9WFpGLwbY887FEK+KKT6vij+CEhxNrRM0MKq374lN+VnGCxm444A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715678574; c=relaxed/simple;
	bh=MMdhuDHz3q7n2UdBy+o6QjLOutATyAMtgB4XaFAoc0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kD+h8pay8qva+m/CfKWd/YugkTg+sINs2ieDOCU1MYtSvcRUnUHd6fHe27BHTvB0VAsM1cNqE+ru+RJsi9cP9zXg9wM2CGO30fjIJL5M3uHZfZRnr2WXsDLOFM71zZLnoyrgvX/59oC2r+l7vF+85gy1FU4OUTXGzOoT7QhsaAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=RHocDRCL; arc=fail smtp.client-ip=40.107.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkS0loKnkBpJfuge5E30EQ4RRWEELugj1rf3r4qmw7TpMsppCBdvAoIy21xmZNGtw87OhC+RS6pTnKV9nsGZx5lSBASfqw/hfB2rXeKybHclkCMr9PwAzdmVMZNrzNcUQ7x12Jd7c3r6ddUBZ35kjg2z24i8sv4s1uHbahaBZ2wbtAoGiLGIZsqHBMldIaaJB0TUxpypBx9B8Jd+zc2i675hGUC+hS7yxfpbmWEzUYjZROFsuJ9NDMEJHFInieJyrrENxin97B9PFuy9CwB1of4Qs0qyaLhyVFMO1uKrfbmYVTihoP3dMJqDWT8PUP2ZBI3doWu4HUbrMqKzF0O26w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ERQ1A6ZjlFfEEZPsxOc3FefacY8EY6BhaM+pjLt03g=;
 b=kM/rwpC+ibMINlYDs+TxYT2F5XR5tgC+cjSPsNx/1lkzZMwtcHNHiL2L7itR9imlSA5BlLTwAaFDqHd39QAsBTnHdEh73qAPVgh/vGDjK0hIbQX1VsTyla82ntxtvzxYbFwOECgn2w46HfCtHQos5xvm4f11Yo93wNq7pvrwVyJBJH3XH2+t7PLtjyOM5cfZi/ZoFukrBNd6Shx0+tXtuHP6EsNc1pUsIpB9vZeV4ubbfol/4yEHiNeylcAzXZ+8kFVe6qzyBCY2OLdHoL9cThaiURGHEeoTRNFHu1voYnEDkeyLhxFg/8xomQw/JYImobadgAyNLH+YyMt0sB9jOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ERQ1A6ZjlFfEEZPsxOc3FefacY8EY6BhaM+pjLt03g=;
 b=RHocDRCL07GllcyvhHcETu1b8hgYG8PYyoeedyh0dGogWRDnQfRSAiWgVCwm7fRCoOp0ekIWigz5IJmZTPcnwXLNPZ6TMqkuN2hUaFLKy6BX4PDz7CJBjTKLZQKaQr8bIbAiX7rdHZ4+KWeoYJwMnq3Fb6W20DErG9kbDWjfmFj2lgOb/ShLYIomFtimbXD30UCwFxwcRdy6yS3oXKTNFvsTvQl3Rr5RpFVW4SJ3MbuuXU3sRtpFm0UMYe+Nikh2a/LOMnTz02BDinyzgFqXHCySOPuuABB0ixBcW1FDFfE19KL9cswVZ/uVVHBBlwr/M020+6RCCQRbdDOHrtlxAA==
Received: from SG2PR02CA0051.apcprd02.prod.outlook.com (2603:1096:4:54::15) by
 JH0PR04MB8108.apcprd04.prod.outlook.com (2603:1096:990:a2::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.55; Tue, 14 May 2024 09:22:48 +0000
Received: from HK2PEPF00006FB3.apcprd02.prod.outlook.com
 (2603:1096:4:54:cafe::9) by SG2PR02CA0051.outlook.office365.com
 (2603:1096:4:54::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Tue, 14 May 2024 09:22:47 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB3.mail.protection.outlook.com (10.167.8.9) with Microsoft SMTP
 Server id 15.20.7587.21 via Frontend Transport; Tue, 14 May 2024 09:22:46
 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz
Cc: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] hwmon: Add support for ina233
Date: Tue, 14 May 2024 17:22:40 +0800
Message-Id: <20240514092242.2739662-1-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB3:EE_|JH0PR04MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c99bb41-a955-47a3-34f1-08dc73f76af5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|36860700004|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1Q0QWlFbFpNc2lUQklNQjMrNGZQVnNRVTljakpYaTVNYi9qc1hsUkk1Y2dr?=
 =?utf-8?B?aEh2dEZzWElGaXIzb082RmVLcFR0OHhKcHhJY2xvOXlnSm5IaWRXdHBxR2NS?=
 =?utf-8?B?dld2TTJjR2xEaVVYWTk2OG10UW9DbndwNGtUV0JEQkFsQVdsQjNid3ZQRjds?=
 =?utf-8?B?bG00TlB3OXFKT2o5NzUzNUtqZnZNMHZScWhRcklJSFlYL0ZVZ2VUTVFLdFF4?=
 =?utf-8?B?S3lORjBXRHBnR3dnOTcrSnVxVFZFU2tNRW5vbzBCK1RQVGQrSFREazgrUU44?=
 =?utf-8?B?akF4ZEdocTR5bkRxN0ZaQnZoTVY2YVJ0OFFYMS9pb29kVjZWZ2prWHJqVVJF?=
 =?utf-8?B?ZEJuL2hxQ2lHZGE1VVQvMkRMZi83Q1BLTVRuMklqZFZQcVlTb1J1UWlJOGxG?=
 =?utf-8?B?bXpKanJ2b2p5aEVsOTBQdGxSVFlWZFNHQUdPdXUxbVZHQmx4b2Mra3BxT2t5?=
 =?utf-8?B?MzVlVHlTL29ZbGc4R1czc3ZuQmxuMkV0N3M0dSt2T0FtU01TWlRadmlmUjN6?=
 =?utf-8?B?Qk9XTE4yRUJSQjJZK3BCQzlQQjBrODdFSExXU1J6eWV2K1hZK1hlZ2c1ZExt?=
 =?utf-8?B?aXBoQnJqclNCNU5TalVuN3IrYjNNc2pyUHh3TFp1U2VBWlFhWWxJcWhKSG1l?=
 =?utf-8?B?RXNPK21MVk5HcHlXcXZydkJtT3ZmbThFbktVSlNTY2oyZ0pkUnlIRDFvaDJs?=
 =?utf-8?B?dkhxdmxaTWltMk1tQyt4RjlsTEhDRjhySFlNR2lyc3lIN2NiSTNETlNuNE1Y?=
 =?utf-8?B?bUI1U0NXdjlpajJ2T0tNcHlTYThYVUdTcEVkVEtBaW8xelpPdDliREhMbWM3?=
 =?utf-8?B?V21pNW0zb01MN0UyWTJidG5ISU56eXNZZnBJaW1oM2xrcGlLV0s1YkFweFZQ?=
 =?utf-8?B?aXdoSGluZnN0elp2YWdGK1lrNWh4djZFTVV5aHZScG5WY0I4RUNJUU56Z1di?=
 =?utf-8?B?d1RRWnoyeHg1QmZ4MVZsQnFZTi9SZ0t2SkI4TmliVjgxRHM5WmxYUUhZR1Qz?=
 =?utf-8?B?NENzdUlQRys1M3gveGozbTVWbzB1dS9RcDhJUWdreWxrdUNJdUFKSWJHWGp5?=
 =?utf-8?B?bkU4TllDeGZpazhMblFlbjlPdkUwMHYxb2kxeGFRS1NHWWtnT3dUUUdXN1ZU?=
 =?utf-8?B?TENobjlSdy9RcDFmS3oxQzlTZ2FnY1hHbTRZZmxWWUVjUFBDMzh3UU1WRVYr?=
 =?utf-8?B?RFB6dW5RRG1UZVNPb2dkQWxHR3BzWEIreVhNMlVDdGdRdmZoaEx5Mm5BeWpG?=
 =?utf-8?B?Z0I5cDJvb20wQnJJWDlqN3VhWmdRc2FqNDFVZlBSZDdJcU1VT0F1RjVjQnJI?=
 =?utf-8?B?OTFIcU0reUoyYmdlWXRCdFl3THRsbldsanBPS1F1UHdtM0ZjN0ozUXRoSkFS?=
 =?utf-8?B?T3RnQk42QWNrWHFtZ3J5clM0QjljdnVkZ1dlWThESHhsMC8vcURqdXJrNisv?=
 =?utf-8?B?Z1hPMFp2ZnJrWWFsSjBSaENwdGxmbjhLL25hWXFWenZDakJVUUFETEU2YldF?=
 =?utf-8?B?YU1ZUVdwMzBtdFhlMElmTE56KzUvOG5hSDdQV1I0c0R3NjMxRFM3WXVUOFVJ?=
 =?utf-8?B?UzNxU2prSENrRWdzNm9kNHhLNTIzaXpXMndYb2xGbW1EV1JpTE5FU1dobTZV?=
 =?utf-8?B?RXBRUzEvMWJSaSt5TWJnMzEwNWhFcGdJWm1EN1lTd1hneGlpSkxFclNUaGZk?=
 =?utf-8?B?eThxU0h0MTYwR2NnUmx5cDUrd3ArTTR3SGg1eTYrVllKVm1hZ2RSM3B1a3Ix?=
 =?utf-8?B?SFdPTzBLbGxkRXFPUnBURW9BTUppMGZMQUFOaUloVUFiL0FIZ0JUSzRWcXdH?=
 =?utf-8?B?c3JLUk51UDI3TVZlVkhSRU81UnFCVGVsRmNSRXBDUGJJNVRuSzlaN01EVEZm?=
 =?utf-8?Q?lwy5fglNvFAbq?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 09:22:46.7088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c99bb41-a955-47a3-34f1-08dc73f76af5
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB3.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB8108

Support ina233 with vshunt

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 drivers/hwmon/pmbus/ina233.c | 37 +++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/ina233.c b/drivers/hwmon/pmbus/ina233.c
index d5c7d7408ac3..33736e5049a9 100644
--- a/drivers/hwmon/pmbus/ina233.c
+++ b/drivers/hwmon/pmbus/ina233.c
@@ -11,9 +11,43 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/hwmon-sysfs.h>
 #include "pmbus.h"
 
 #define MFR_CALIBRATION	0xd4
+#define MFR_READ_VSHUNT 0xd1
+
+#define HIGHEST_BIT 15
+
+static ssize_t ina233_vshunt_show(struct device *dev,
+				  struct device_attribute *devattr, char *buf)
+{
+	int shunt_volt;
+	struct i2c_client *client = to_i2c_client(dev->parent);
+
+	shunt_volt = i2c_smbus_read_word_data(client, MFR_READ_VSHUNT);
+	if (shunt_volt < 0)
+		return shunt_volt;
+
+	// Is negative
+	if (shunt_volt & (1 << HIGHEST_BIT))
+		shunt_volt = ~(shunt_volt & ~(1 << HIGHEST_BIT)) + 1;
+
+	// This unit is mV.
+	// LSB 2.5 μV is reference from spec 7.6.3.2 MFR_READ_VSHUNT
+	int val = DIV_ROUND_UP(shunt_volt * 25, 10000);
+
+	return sysfs_emit(buf, "%d\n", val);
+}
+
+static SENSOR_DEVICE_ATTR_RO(vshunt, ina233_vshunt, 1);
+
+static struct attribute *ina233_attrs[] = {
+	&sensor_dev_attr_vshunt.dev_attr.attr,
+	NULL,
+};
+
+ATTRIBUTE_GROUPS(ina233);
 
 struct pmbus_driver_info ina233_info = {
 	.pages = 1,
@@ -29,6 +63,7 @@ struct pmbus_driver_info ina233_info = {
 	.m[PSC_VOLTAGE_OUT] = 8,
 	.R[PSC_VOLTAGE_IN] = 2,
 	.R[PSC_VOLTAGE_OUT] = 2,
+	.groups = ina233_groups,
 };
 
 static int ina233_probe(struct i2c_client *client)
@@ -82,7 +117,7 @@ static struct i2c_driver ina233_driver = {
 
 module_i2c_driver(ina233_driver);
 
-MODULE_AUTHOR("Eli Huang <eli_huang@wiwynn.com>");
+MODULE_AUTHOR("Delphine_CC_Chiu <Delphine_CC_Chiu@wiwynn.com>");
 MODULE_DESCRIPTION("PMBus driver for Texas Instruments INA233 and compatible chips");
 MODULE_LICENSE("GPL");
 MODULE_IMPORT_NS(PMBUS);
-- 
2.25.1


