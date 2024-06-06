Return-Path: <linux-kernel+bounces-204269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C81CA8FE67F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C08CE1C21E41
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C546195983;
	Thu,  6 Jun 2024 12:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="umeUt3Hb"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9110113BC26;
	Thu,  6 Jun 2024 12:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717676897; cv=fail; b=tXDFLqT4gGMb29Yh0l7e383+DV6rNv9QhploL0VwRwYC570Te8JMmITu+2PcENNcVmqJMnQyKvOsjxNPuA57vm+j0/2P0ANtujQ//GSMdkctW+q93fqIZBNcXngzlYKDmx4r3IH1j9G2HzFRWI+3YReAhQVN7vCyLpOxR63nl1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717676897; c=relaxed/simple;
	bh=rATL2xZDXqRCAfuNkC9JErA87OvAaAO0FuJFwwXt1Wo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hKDMyr/t7KS3IcqsAyySA+wGVTM7+gKve75eLwYV0sswM6UrqsFwuj4Y0Pkx2CWfDucLC4hOO+x7k+ciYS+T7Fojv7puPDz3OLgLyvBq6W81pKcgryNoe986m4mctpaWH92QTQfqOXpHBsZR3AylazPjizpyz+gPKly3HIrgTAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=umeUt3Hb; arc=fail smtp.client-ip=40.107.236.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Igg+I/Lb3AxJHI+GB/1XwSSisqXacvT6nofsdCv7x0pym/SPMwt2v0peah0sKdmqK8kkiPwuA9hSAyfj6+KAPGK3z0JLx7D6TIWz5V9R7HeaYHK/guQZ+j3HVoEfNMYsWjjV5ldLH911aMNET7Hv3Arme9MODL18X6kvc2dFBvb6MPN4AYlcCZ4y7cYcJ0h28n/xDKdzqeJmDQqCZLfQI3Vrv3dwwqwJF1Ir9LcjmeiQyYzWC4ZjdenkZbXljdXZKjEXfTzHCIsEua0nBTar5QHtMQucVd2/DAuRUASUO6b0gO0KbtZF0LgIgiEqVXbPFfA63NxCUM9QZCX35DpigQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sv74yfQbBGBr8keMdOkogwljlQFjfWlxhAAFrs7lIbk=;
 b=PLG4zMprgiiH+EwwMBW2nIHWdtoZRE6TfUcVWzODEBvPBDdbwXyRXCuyVNFXYRdvw2E/GbSjqk15c1rKW4sDKnbm5PzsR+vs/7w/HsKhsUrBqefWlAEMtkVfzOlSA9bdLCTJAxeX9DSYplsDMvANdoMDyjbR+fe3JrOEvnywDwbADmw7fcVNgqPVmurCS3bk5MQBTaICKlWXAZ4Dq5tfXuZ0yU3QFaiiiCvyp52pEO5TeMXLuLiWaB4wxzK5fQVeWrEmTtc86DBKT7X7drCyoEmfMk1aAxn7KLJOnVYoIh4eSPExOsI+rATorkRRtqN23vuaU46y8vG72huSnqFDng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sv74yfQbBGBr8keMdOkogwljlQFjfWlxhAAFrs7lIbk=;
 b=umeUt3Hb6diibzPYnQrLlBH6D03JkewUhHD6vtPKYmxTRH0EPFnw0klvbxdfRWt9rL8nsjkqM9Ruj4eiI153JLW+nlWw4ErMgk2mrnC1SFksixoyViOSd2Cipw/6uERt/b8M+f9GI9492HT58SXPjojlt0XP+sQc/p497EsxIFU=
Received: from BN9PR03CA0775.namprd03.prod.outlook.com (2603:10b6:408:13a::30)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 12:28:11 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2603:10b6:408:13a:cafe::45) by BN9PR03CA0775.outlook.office365.com
 (2603:10b6:408:13a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.20 via Frontend
 Transport; Thu, 6 Jun 2024 12:28:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.0 via Frontend Transport; Thu, 6 Jun 2024 12:28:11 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 07:28:10 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 6 Jun 2024 07:28:07 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <mka@chromium.org>, <gregkh@linuxfoundation.org>,
	<javier.carrasco@wolfvision.net>, <benjamin.bara@skidata.com>,
	<m.felsch@pengutronix.de>, <jbrunet@baylibre.com>,
	<frieder.schrempf@kontron.de>, <stefan.eichenberger@toradex.com>,
	<michal.simek@amd.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<git@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH] usb: misc: add Microchip usb5744 SMBus programming support
Date: Thu, 6 Jun 2024 17:58:03 +0530
Message-ID: <1717676883-2876611-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: radhey.shyam.pandey@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|MN2PR12MB4406:EE_
X-MS-Office365-Filtering-Correlation-Id: 55e24e17-8946-44de-ee38-08dc86242139
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|7416005|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0FTc1laUnFCcU1mbEdBMTdJSHZnemlsSUFTQWhxQjZiRnN5b0VSOGhtczR3?=
 =?utf-8?B?RnVDSFdGMjVLWGR0aVlmNDcwcFFTSTBsZmdkRGtaSW91dzN3WGZQZ1JyendF?=
 =?utf-8?B?U1MxQmZVZlg5VFg1cU5BcG51WUlEa2lSSGFkM1AwNDRvY2dsTkowNmJZRkdP?=
 =?utf-8?B?Sm5FeURmLzJQb1JkYkl4N1ZTNHVZTDNjYWk1K1pERC8yVURtR3FEZHJZZkNF?=
 =?utf-8?B?RGZrcjdzMHUwTnZoV3FzdEg3Ym15U3h4QzVnZStPbzVkV2pZVkxGMHQ3VU1Y?=
 =?utf-8?B?NVRWdStLVmVzQmNZajRNbVZEbUtsWVVzYk9haWhDYlYzVDRUaTV2VHRFaUZ6?=
 =?utf-8?B?ZDNSK01MeHk1YUZySkN4ZGxnOFBYZDBiUVBsQ3NWWUNhV214N3VCN3ZkbEZh?=
 =?utf-8?B?UER0N3ZNVU1pN2hnbkNObWRvNUpTb3d0OGM1dUNvQzdUcURzWXhYRzJVV1BP?=
 =?utf-8?B?MVQyZU93YkFGQjg1QjUvZGZTalJPK3Q1OGh1QjJFUnNZN3FUemtQbENWY0ZH?=
 =?utf-8?B?ZmF1VThyazZUMFBHWmhVKzBVRkQ2NldmSFg1TFhjUHF5ak1iOENNRTE5cU9Z?=
 =?utf-8?B?cmcyTFpLUFh1U1hsNlExMlU2eFVZcG14WjZwY1o4UisvRTFiZkcxRVRqUitl?=
 =?utf-8?B?MVlpYjZuZ1J2dzV3bFVHcjhIQ1pZWkt3Ny9ucW1jck5Wa1FYOEFxNno3eHdy?=
 =?utf-8?B?UGpOM09PeUtoYnhOMUhFQzNoNU4zVzJnUnE1U0Y4QnhheityciswNExaRXp3?=
 =?utf-8?B?QlpGazBpZkZuTHVFeDJTQXBxc1IvV0ZnSTlveU9TRndMTkZlcjllbjQwOThU?=
 =?utf-8?B?aFRrcGZuQ05iVmFwVWxwZ0hiNTRqRHJKL001dk1vamc1enNETHlIYW9LQ0RP?=
 =?utf-8?B?ZDNwTFF4L0NpT1RLSWtPZ3pQWjIveE5TL0gvZ29XSDZuc21jd0xUWTJLSWJJ?=
 =?utf-8?B?dWtTSndobndqTWVwRHpuSFc0VmxheXk0MGlMamk3OTJscjh6d2ExQmZRYnBs?=
 =?utf-8?B?V3Z6UzBpM2NkQVlhSHdQNExIYngxaUlJTzZhUmw0WGM4RnpydHpBeGd0bkNX?=
 =?utf-8?B?RlltVE1XbmRvNkhyVVlnYWpZSWdkODdLU0g3MXM4Z2UzRnhndy9QMm1ObE1i?=
 =?utf-8?B?aGFyaGdiWGdaNlFtRFM2MklsNFU0bDZtNFgvMWlPQk81a28ybFpSUXE4RjNN?=
 =?utf-8?B?djRkTit4ZkJUS1dsL3RRemlybE1IaHBaQU1TMnFLSnhZN0l1aFlCWlYxemdt?=
 =?utf-8?B?UWNZcGsxanJ6eVZSTHZTR2IydmJ6RGI3YUZBRllvalVyQ3NTVDVNS2RLbitB?=
 =?utf-8?B?M21US1BsSjZvc0dWeFdqTWNlU1YyTVBneFRoa0xCWWhsUnhpdnRhWGxtR1VF?=
 =?utf-8?B?SVFtSndMY25VYTNERDhiMEFsdGpBcnVyQVE2eC9iZEp5azFWSEVzaG9DY1c3?=
 =?utf-8?B?M1AwR2tOS0dkb1dSMEU0OENMdkRQaUpOVFRETzJCdVI5K3pHQ3pFK0tiRk9q?=
 =?utf-8?B?SEZiR2I5eTdqY2tKTXVWVWtUdEtkMjdXMzJuQ2ViSXBzdUQ3UUpvMlFpSGwy?=
 =?utf-8?B?enRJMFhSajZlbHBFMklGYjlReVhNMVNtMXlSb1FFL2hpUG1SWEtGKzh6SW1C?=
 =?utf-8?B?VDBFSFVLTTVGN2V4T01Mb0ZkRTlya29vS2FSWHUvalROa0RUL3FSenJTcFdv?=
 =?utf-8?B?ZmtWY2JUMEM4TFZ6bkhFYU1pd2VpbzNIUlY2enVDMzNrb2lKdlBXWGJXZ1or?=
 =?utf-8?B?eUF3VDg1OHlUdjMvZytIUzNEVkxkVHRUWEpwWXRoTHo3eXpJUVRVODNFcDNr?=
 =?utf-8?B?M05GTm9LMG9MSzJ1WW9kbGQ0Wk1PWmhmbW5YMXkxYVJIejdCSkdLYXhkK1RB?=
 =?utf-8?B?QXRUTHJtc2J5eG1laTQ5bjNTM3ZUNlZzY2R1TW9uQVl5Y2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(7416005)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 12:28:11.3532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e24e17-8946-44de-ee38-08dc86242139
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406

usb5744 supports SMBus Configuration and it may be configured via the
SMBus slave interface during the hub’s start-up configuration stage.

To program it introduce i2c initialization hook and set usb5744 platform
data with function having required smbus initialization sequence. Core
driver uses i2c-bus phandle (added in commit '02be19e914b8 dt-bindings:
usb: Add support for Microchip usb5744 hub controller') to get i2c client
device and then calls usb5744 i2c default initialization sequence.

Apart from the USB command attach, prevent the hub from suspend.
when the “USB Attach with SMBus (0xAA56)” command is issued to the hub,
the hub is getting enumerated and then it puts in a suspend mode.
This causes the hub to NAK any SMBus access made by the SMBus Master
during this period and not able to see the hub's slave address while
running the "i2c probe" command.

Prevent the MCU from the putting the HUB in suspend mode through
register write. The BYPASS_UDC_SUSPEND bit (Bit 3) of the RuntimeFlags2
register at address 0x411D controls this aspect of the hub. The
BYPASS_UDC_SUSPEND bit in register 0x411Dh must be set to ensure that the
MCU is always enabled and ready to respond to SMBus runtime commands.
This register needs to be written before the USB attach command is issued.

The byte sequence is as follows:
Slave addr: 0x2d           00 00 05 00 01 41 1D 08
Slave addr: 0x2d           99 37 00
Slave addr: 0x2d           AA 56 00

In addition to SMBus programming sequence also update post reset
delay as without it there is a failure on first SMBus write.
i2c 2-002d: error -ENXIO: BYPASS_UDC_SUSPEND bit configuration failed

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
---
 drivers/usb/misc/onboard_usb_dev.c | 46 ++++++++++++++++++++++++++++++
 drivers/usb/misc/onboard_usb_dev.h |  8 +++++-
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/misc/onboard_usb_dev.c b/drivers/usb/misc/onboard_usb_dev.c
index f2bcc1a8b95f..5621c1273a12 100644
--- a/drivers/usb/misc/onboard_usb_dev.c
+++ b/drivers/usb/misc/onboard_usb_dev.c
@@ -98,6 +98,7 @@ static int onboard_dev_power_on(struct onboard_dev *onboard_dev)
 
 	fsleep(onboard_dev->pdata->reset_us);
 	gpiod_set_value_cansleep(onboard_dev->reset_gpio, 0);
+	fsleep(onboard_dev->pdata->reset_us);
 
 	onboard_dev->is_powered_on = true;
 
@@ -296,10 +297,34 @@ static void onboard_dev_attach_usb_driver(struct work_struct *work)
 		pr_err("Failed to attach USB driver: %pe\n", ERR_PTR(err));
 }
 
+int onboard_dev_5744_i2c_init(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	int ret;
+
+	char wr_buf[7] = {0x00, 0x05, 0x00, 0x01, 0x41, 0x1D, 0x08};
+
+	ret = i2c_smbus_write_block_data(client, 0, sizeof(wr_buf), wr_buf);
+	if (ret)
+		return dev_err_probe(dev, ret, "BYPASS_UDC_SUSPEND bit configuration failed\n");
+
+	ret = i2c_smbus_write_word_data(client, 0x99, htons(0x3700));
+	if (ret)
+		return dev_err_probe(dev, ret, "Configuration Register Access Command failed\n");
+
+	/* Send SMBus command to boot hub. */
+	ret = i2c_smbus_write_word_data(client, 0xAA, htons(0x5600));
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "USB Attach with SMBus command failed\n");
+
+	return ret;
+}
+
 static int onboard_dev_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct onboard_dev *onboard_dev;
+	struct device_node *i2c_node;
 	int err;
 
 	onboard_dev = devm_kzalloc(dev, sizeof(*onboard_dev), GFP_KERNEL);
@@ -339,6 +364,23 @@ static int onboard_dev_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	i2c_node = of_parse_phandle(pdev->dev.of_node, "i2c-bus", 0);
+	if (i2c_node) {
+		struct i2c_client *client;
+
+		client = of_find_i2c_device_by_node(i2c_node);
+		of_node_put(i2c_node);
+
+		if (!client) {
+			err = -EPROBE_DEFER;
+			goto err_dev_power_off;
+		}
+		err = onboard_dev->pdata->onboard_dev_i2c_init(client);
+		put_device(&client->dev);
+		if (err < 0)
+			goto err_dev_power_off;
+	}
+
 	/*
 	 * The USB driver might have been detached from the USB devices by
 	 * onboard_dev_remove() (e.g. through an 'unbind' by userspace),
@@ -350,6 +392,10 @@ static int onboard_dev_probe(struct platform_device *pdev)
 	schedule_work(&attach_usb_driver_work);
 
 	return 0;
+
+err_dev_power_off:
+	onboard_dev_power_off(onboard_dev);
+	return err;
 }
 
 static void onboard_dev_remove(struct platform_device *pdev)
diff --git a/drivers/usb/misc/onboard_usb_dev.h b/drivers/usb/misc/onboard_usb_dev.h
index fbba549c0f47..17311ea7bacd 100644
--- a/drivers/usb/misc/onboard_usb_dev.h
+++ b/drivers/usb/misc/onboard_usb_dev.h
@@ -6,6 +6,8 @@
 #ifndef _USB_MISC_ONBOARD_USB_DEV_H
 #define _USB_MISC_ONBOARD_USB_DEV_H
 
+#include <linux/i2c.h>
+
 #define MAX_SUPPLIES 2
 
 struct onboard_dev_pdata {
@@ -13,6 +15,7 @@ struct onboard_dev_pdata {
 	unsigned int num_supplies;	/* number of supplies */
 	const char * const supply_names[MAX_SUPPLIES];
 	bool is_hub;
+	int (*onboard_dev_i2c_init)(struct i2c_client *client);
 };
 
 static const struct onboard_dev_pdata microchip_usb424_data = {
@@ -22,11 +25,14 @@ static const struct onboard_dev_pdata microchip_usb424_data = {
 	.is_hub = true,
 };
 
+int onboard_dev_5744_i2c_init(struct i2c_client *client);
+
 static const struct onboard_dev_pdata microchip_usb5744_data = {
-	.reset_us = 0,
+	.reset_us = 10000,
 	.num_supplies = 2,
 	.supply_names = { "vdd", "vdd2" },
 	.is_hub = true,
+	.onboard_dev_i2c_init = onboard_dev_5744_i2c_init,
 };
 
 static const struct onboard_dev_pdata realtek_rts5411_data = {
-- 
2.34.1


