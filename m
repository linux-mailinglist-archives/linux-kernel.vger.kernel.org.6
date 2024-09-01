Return-Path: <linux-kernel+bounces-310211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3C3967659
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 14:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F05EEB214E3
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 12:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A611D17ADE1;
	Sun,  1 Sep 2024 12:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yZQZBKfy"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03D61448D9;
	Sun,  1 Sep 2024 12:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725192537; cv=fail; b=VyFU6f3VbKe4q3qBN6XeIfsgt+ejOEpDa9OuRK1Ouaw7MA5H672LKcFAkRtOXfO6gnG+NjE0UZ95JNnY3Zp7lRH0JHdMrzzrkdMvhbHs4PJP0G/x2suIfVe8IpgUDBSYSpNXYzr0LIMg1BtehuSnXw7LiUVUTT8yRbfUyVA6Uzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725192537; c=relaxed/simple;
	bh=tMsn4WgXg/XSbQ2Ohs85msXky9bCO31fXkbtUyQlIc0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oR2P9LIMk560J5Ctbp3sQraPV3NSqTibjmAwOmsI6XH6hiedlFE11s6GIa97FQloFtAUygOTf0Py1nd6qUVPsLq8ZH14o3NUes89DyQ+8re7P+J3ShH0NlQMaszCC7Kbjb5IwO4Fv14HSRxEnQ1YITWY2U0IHn0LvExVUPkCDLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yZQZBKfy; arc=fail smtp.client-ip=40.107.92.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bXFgL/vbX+bi6DzQqJ73+wvRYIVL/0jAnddwulHknyd3liAguK0zu5+F9sGnje8QGBkpMNxZmho0izJULU/FBTtZR20aEQ6GR1zMMf0H69rakSs09+Ca9lGVkLw4CUEBUKPxx5WhQ2vwusre+fRcChn0am8g94U5qB4fMGWJ/QN3Su9rAlhyDDGzGeJgxF/r2Aeqc+5hB8mSOz/yyCEDwJNbAgmFjw8ZQh/+SVTqW6Vfdkp8rDZJ6cHkgICkui2wfUWfSQM76mGNvB7vzOg1E0fg/6f1XqXQBFmLACV6oP0qjnBJjZkterQvuRr3RTIObWhUmS4m/BhelDzoAhEutg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQsIozrlIDEjqmLOOKy9Bp7IkU+Hkxv0GeW1lfRiMrk=;
 b=efcZHHsVnWKCgbdwPimx1ouOPI4qmeH2vy3QWkN9PS3YJxBVmIyGsh01b4B5zMM3FKpH6SIvd9byRf7dvO16GPyi49VOeWeNz8++tnTnsqSPFjxGUdxL3l5l+2I9JTCV0y4HE8W1M2leUX9Ukx2xdM3V3bjHJhTZsPSP1ElgHg6pVSp9KmGolD3UdtoGx5yDZDghW8QztgUV7F/+W2lZuZ7YfGAa6AQOYQt6oAEYZBMeUSAmLzhMbebGfdo/9G/MQiA025Q5wxeU86Dccnvg6VViz4gSV/rbm6LJDLqFpMFCQ5PoxhECgLFldEdjUOY33o/YZQrg7eFZSmBkYzJDRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQsIozrlIDEjqmLOOKy9Bp7IkU+Hkxv0GeW1lfRiMrk=;
 b=yZQZBKfyDpWFpALpAWNRqJP03DQvGchNyj3m04X9ICubC5r71ZPV3H9dXVpb2X73rZ2QrimD8ufYtXSsXbUfAgKjdbrz8wUFcuyxV1/hh+7Qyu+0S+eG7kNdujZzF6+5kA2t++9cMAkTFCPUzGWcaVlIOAwepRkYxPQFn5F26OQ=
Received: from BN9PR03CA0286.namprd03.prod.outlook.com (2603:10b6:408:f5::21)
 by PH8PR12MB6961.namprd12.prod.outlook.com (2603:10b6:510:1bc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Sun, 1 Sep
 2024 12:08:49 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:408:f5:cafe::27) by BN9PR03CA0286.outlook.office365.com
 (2603:10b6:408:f5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23 via Frontend
 Transport; Sun, 1 Sep 2024 12:08:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Sun, 1 Sep 2024 12:08:48 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 1 Sep
 2024 07:08:47 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 1 Sep 2024 07:08:43 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <gregkh@linuxfoundation.org>, <mka@chromium.org>,
	<sakari.ailus@linux.intel.com>, <wentong.wu@intel.com>,
	<javier.carrasco@wolfvision.net>, <stefan.eichenberger@toradex.com>,
	<francesco.dolcini@toradex.com>, <jbrunet@baylibre.com>,
	<macpaul.lin@mediatek.com>, <frieder.schrempf@kontron.de>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<git@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH v4 0/2] usb: misc: onboard_usb_dev: add Microchip usb5744 SMBus support
Date: Sun, 1 Sep 2024 17:38:37 +0530
Message-ID: <1725192519-3867920-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: radhey.shyam.pandey@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|PH8PR12MB6961:EE_
X-MS-Office365-Filtering-Correlation-Id: d778f468-03d5-4302-9470-08dcca7ed61d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a0MyLWHLgoQguio5lyPOQVxbkLze2zAKiXHtBjArG9XTAIHDLPVahtp2S32F?=
 =?us-ascii?Q?jvc3L+k9AdNcCBhokjkErYNw7tpzu081ys3rTdAY7oItrLM7VAOz9rtbL1hD?=
 =?us-ascii?Q?f6+61R7VdriCoNARKOSpHAzAJxrjpVCCc5NkZ7uGtJ5TA0MG5cw/BfNTvaum?=
 =?us-ascii?Q?s1tZ41wIKizyf9bR2TnKqLYH3GehLP7MJ7v4nuaXR6pwb+soQkx1Zhe98qai?=
 =?us-ascii?Q?ikeyU3Ydo5VwSDo8V+vG5BpTP+ZfUzf9hD8wGXDvg3bFbggw9NQ+UHBSWGXb?=
 =?us-ascii?Q?r2NN4zGwLE47zknqXjjOjTz1PuS5HOT38pESbZm/zC1Uf3zBzYLihCQEoZM8?=
 =?us-ascii?Q?TJsNYmXEc5Fnz/cdIHzFb3rQ9b/LFyE0PEAQ4ZodvboCH0onuL3ZczDccltj?=
 =?us-ascii?Q?VdwxHzjveICN5SfjLKdUx9eamh50YDkybiEq1chCrqIul8hmTwQ+dBum1NCb?=
 =?us-ascii?Q?XeiLP/yyFZ+G5Jj5xYSMjXLiCtX9ueholq5xI5taeiZTazbaVHbWLc/67ycM?=
 =?us-ascii?Q?wIahp3C/hiDqFmSiFAsqtnC7ujjbwPxbT/8M9EBJ0I25IZJTSc64CienY8v1?=
 =?us-ascii?Q?IZOvN2AHUmkt8OK+kB79j/w/o7DQWlt02MjSVtEieBfsv85RdaG1e0BpVGWA?=
 =?us-ascii?Q?l7QVNC6sQJVHK/lyk9yjGLtRnY+pHGR4kS9TvyQKPasddWqv9R/3n+IRdkJg?=
 =?us-ascii?Q?nxaImEXm+9pumcUFQDjhNIz5ITsVF/K6y3M6UKcMkUdsxFSzapVUI6o40TLy?=
 =?us-ascii?Q?zuVgYZLvwxgPpJI6RkzfmZjTibv8UZTcWtm+udD6s48XG6RJpQ0FWRpV9ODA?=
 =?us-ascii?Q?CHEmjoLcY5w9b4gCVs6ELCWfVZl+Pf5ZPyffII2TkMkbWrF0hX1mmg6ygYJL?=
 =?us-ascii?Q?NPn80mRC7TGCLJcQ4FZl3SQSTOOYbHzzDJBnVzLNIrY4efPUxiNJXncw3DSw?=
 =?us-ascii?Q?KFYlp0dZQZQMgF1mav9WADXcwVPsXHeVK6cYzn4oXG+2/eL7irxhc2YJ3R8R?=
 =?us-ascii?Q?a5YgGbVEDIeE/+1hyfzFPc+STzHn+x9zTEWjTW9KKqrrBSE7milsnBY4QNPq?=
 =?us-ascii?Q?UzlduEHjI4cEOUQ0OvUhNLVcnJ0xhDvksZPlIOspMRNTtMxeQ15IAjjK6t+p?=
 =?us-ascii?Q?tJKDS8h0BzLUwsD4KpqCnRnZZhVxKYseqpPOWU+5j7fLEeYmZHdOJjm5rv5H?=
 =?us-ascii?Q?KhEvlBRa2WFGF03dJQ2ugpe8J/VZjNNT88P3xv6s4RukCcFYZ0TIR0RuS3b6?=
 =?us-ascii?Q?DzakEnyWwfgC/jtltNDgVM0bOnLTWrYfCvkte6/VnGRlIEeVeMIEaMcrMNlK?=
 =?us-ascii?Q?aG+rE3phbo5TZleBhNrvQ5o9eaCJYpGAhm6EZlqSx6nLllaGIZrLcq8Zxusn?=
 =?us-ascii?Q?0XXmbqCYc5DRT09J3zHIvUMTUvY17mrW79XAcahBHN1CYDCMyY6dEZqiIeZb?=
 =?us-ascii?Q?OTfY9zFiw3u8vyR+jcv2PibCzMNuQkrcP0qnvtVOZkhNw+A8t2ssFA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2024 12:08:48.5001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d778f468-03d5-4302-9470-08dcca7ed61d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6961

This patchset adds usb5744 SMBus support in onboard usb driver.

Changes for v4:
- Fix error: implicit declaration of function 'i2c_smbus_*' APIs by
  introducing a kconfig dependency on I2C_CONFIG. This error is reported
  by kernel test on v3 series and usb:usb-testing 20/25 branch.
  https://lore.kernel.org/all/2024082503-uncoated-chaperone-7f70@gregkh

Changes for v3:
- Modified power_on_delay_us comment.
- Add comment for UDC suspend sequence.
- Drop USB5744_CREG_MEM_NBYTES and USB5744_CREG_NBYTES and replace
  it with literal + comment.
- Move microchip defines to source file.

Changes in v2:
- Fix subsystem "usb: misc: onboard_usb_dev:..."
- Change implementation from introducing onboard_dev_i2c_init
  func pointer and do i2c initialization based on compatible string.
  This is to make onboard_dev_5744_i2c_init() as static.
- Use #define for different register bits instead of magic values.
- Use err_power_off label name.
- Modified commit description to be in sync with v2 changes.
- Move power on reset delay to separate patch.

Radhey Shyam Pandey (2):
  usb: misc: onboard_dev: extend platform data to add power on delay
    field
  usb: misc: onboard_usb_dev: add Microchip usb5744 SMBus programming
    support

 drivers/usb/misc/Kconfig           |  2 +-
 drivers/usb/misc/onboard_usb_dev.c | 74 ++++++++++++++++++++++++++++++
 drivers/usb/misc/onboard_usb_dev.h |  2 +
 3 files changed, 77 insertions(+), 1 deletion(-)


base-commit: 431c1646e1f86b949fa3685efc50b660a364c2b6
-- 
2.34.1


