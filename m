Return-Path: <linux-kernel+bounces-319893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 033DF97037D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 20:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB606282E74
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 18:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FFC1607B7;
	Sat,  7 Sep 2024 18:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BabmKaYZ"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435C93A28B;
	Sat,  7 Sep 2024 18:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725732210; cv=fail; b=QuPCMz4pQMXmBrujjFVWDZS2LKBeRul1kvLkFITxPFp97RK1MWyRNfeWe35lPHd3dXJP7XLUaq58LMJ58oXD5F7JD5vHId3ZYc/PQxtEMaifVwoMx9z89SRqXKqRRD3R+1+lf9bdTZAV5bzL0r82uWPELLxtV+EyW4m/dvYCtk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725732210; c=relaxed/simple;
	bh=/RcZ+sA1IgvtjMCNEHCVvL0wAL7ujyG4+yN/BOEMgQw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PQIeIh8eX54sFg1BYv/mcwWpXgNF+Q2LPw72roz5S/Kef7xy3X5EJT7eoZOT+dPlTTAPQIkWscYsnCuLIR8MyBSiP8XNu3O34HFAMwDVasUBHguOjXa5WIfQbVhy7zLhgt8mmHNRVFRTBD6gx4JmoEccRPzaEK8MSksar7KtAB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BabmKaYZ; arc=fail smtp.client-ip=40.107.237.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b6Kis0BNkPD+dwQ6qMv5+9w3thYS2CStinpl1HkSXcrvOVsn+afrT0O0Uo2qxsr4udGHsxYqIJck74MZLXvTRERRbVvUk1b2wS4ztwBTl+76/cELMRPKFzFd1FLX6u4rQ0cXgO5Uuhu8/Px/ur9hZ6MSGIcu/1UArGAxkoPt0TJbCh3kqKrr+f2upIV/TkIfmo/cbbWyrMgnG+tjVX4qcuCYAjw9NqIhXGMJsr+UbkvN/18UZYaBqBGOpidURcjUQB/MPWTHwe22F51k7yPnbQM3fbIi2A0B/QV/uGczyUyO3ngCbtWBfWrlTXhJZSn3IYXJXr5XiwKFLtkMw0Xq9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MNLOrK9vM1SyU4QfzPylVkNVZiGp04vM+TwRs9RfuM=;
 b=pShL6ZKrp2cVIp3tIPnRF3rUdYbgyGf+PT/rJKIKs8EqC7UdyksSXh8A3f4k+ww5OdEogJIBM2Oq/9qKW6VSAvhfBRZhUkcrt25lYXPHF66LudtoXenrV7tQH+FiYMQYjXFVkdamFnt25l3YW0QeVG7Jb3UzEc/rPO2WytUOYZCVV7muA7w68WCBBur6ALRW/dAkqXln+KhZ8XqYZLFn1vksImWVtpB25z4o5mtiLrRoADqTcsI5lGIbuKnhJOpRMbyOSHPwE1hcPF7osenjdCbSnBczMR5NA2yAGqlry4qV8nEtJNAyJhXLEdMw45g6MG2An5oEVl6vPLsDyvJHLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MNLOrK9vM1SyU4QfzPylVkNVZiGp04vM+TwRs9RfuM=;
 b=BabmKaYZ/mf9xMVQb6gKwqzq5Pn1Ogh8x1zcVGzivp0hZKF5l26WYJaXjAs1AOD2/SDaiZs8ZMJkrqfgXOoY7gOnyzhjj7BgLJjuCV/1PMWNcTizfR/IFan8vvKEMXgW61XR9oNQs3R+6KhO+sSLXlBSzAgtgH8Dz65BsFfEFeI=
Received: from CH0PR04CA0036.namprd04.prod.outlook.com (2603:10b6:610:77::11)
 by DM6PR12MB4372.namprd12.prod.outlook.com (2603:10b6:5:2af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Sat, 7 Sep
 2024 18:03:24 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:610:77:cafe::b4) by CH0PR04CA0036.outlook.office365.com
 (2603:10b6:610:77::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Sat, 7 Sep 2024 18:03:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Sat, 7 Sep 2024 18:03:23 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Sep
 2024 13:03:22 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sat, 7 Sep 2024 13:03:19 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <mka@chromium.org>, <gregkh@linuxfoundation.org>,
	<javier.carrasco@wolfvision.net>, <frieder.schrempf@kontron.de>,
	<macpaul.lin@mediatek.com>, <stefan.eichenberger@toradex.com>,
	<jbrunet@baylibre.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<git@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH v6 0/2] usb: misc: onboard_usb_dev: add Microchip usb5744 SMBus support
Date: Sat, 7 Sep 2024 23:33:14 +0530
Message-ID: <1725732196-70975-1-git-send-email-radhey.shyam.pandey@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|DM6PR12MB4372:EE_
X-MS-Office365-Filtering-Correlation-Id: 574b27d2-1a16-4b5b-8b07-08dccf675d9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tAG0Hrkrcdkk+kppJlECfkUk8mN3q6mMcCkOckEyMtH367dM/RcM7MnUO0ML?=
 =?us-ascii?Q?MpedAzliu6A+gF37NPL7I/vRlFDC7cvuWrxRaDPG9bJDEr9xaSsEilOg/fxw?=
 =?us-ascii?Q?SCDD1Py9dRjFUplya+kK/lFriW+drNXTg84NaJpWdy3Dukx1uUZt8I6ILrTf?=
 =?us-ascii?Q?Vby4fXnhKa208C14yBbiGHFztdrX6kTFgQqAAE+dZcotDi47ZS/i2J3u8T3S?=
 =?us-ascii?Q?vWjw4Biss4RdFo0ztHPpCJMKYzXIZgNwSX/Xb1VZN3a2JXGCIrUWgksRvA/Y?=
 =?us-ascii?Q?6OMRDmHeEC/w8fPYWbX9U5GhMxTc2wUyhoKPaS1ZkkFMnooZoOSVe/TvSXr/?=
 =?us-ascii?Q?/VnqmISIANEU1cFoQIrh9Qr0FVwds7RiD/C6+iTsemMchAvR+wUHJHuj+My7?=
 =?us-ascii?Q?8PkjrzX68tNXZN/rCzmh7xHoiuSuZqoDUS6l9/h/XAuURy/dQAJ9ZX3NhHsa?=
 =?us-ascii?Q?Ga5alcbXHPm1AuKiYt36ZsjM3KkZ06bhhXrRSagE1LuHnl1OVmpMufBq6vBC?=
 =?us-ascii?Q?HqvbrONg7fb9KbXYe3tmcLoMqaoDNpnxYLHH1h4zlsp4Ob0i0KefW9Oh5NHy?=
 =?us-ascii?Q?G+BsM8/bsMUte9uzIaw7si943JWvQ2MERbSaqXEOnTk2FpnT35U982LWfmrK?=
 =?us-ascii?Q?7u/OUpVgC+S4D2G1kV8NNzhH3exCoyVOI0BaTz42cZRORguT/f4jVNlzqkVJ?=
 =?us-ascii?Q?mLF0kkLLf7cLxrj8I2emQnlSoiauBPJUov2P0HCGSzvphb4mqBxCfAIBRZ+8?=
 =?us-ascii?Q?OHbY0MS5gvLoaXF/+FhMx8k8C5lELjTsv8Bv76sIWrYkxvbzxzd+vJ5omcM7?=
 =?us-ascii?Q?aIIU47bcp+GPCRiB0kHMqgMTPDGLL333gAw3xH+qz/1RsSrHd5V0YVxJXE3e?=
 =?us-ascii?Q?ug2F11WzYhSvFQbebsPV48jcZoCCcVbcwDAhzJnsYc/JDozi82VEnRLpFIRk?=
 =?us-ascii?Q?fgbU+GhpSSlYdOYoR1BSpJymI5GWZiGutjzEodnTk06FjshjBs+HGm4FVrO0?=
 =?us-ascii?Q?m5ViWJR0EUzT59VLLVFVS79YGJKWDO/hsqFJrzUCDGwqc66P2nZdsqBhgU+B?=
 =?us-ascii?Q?ClXwT7uou5DYWhJaEZpMdH7whTbDA84m05nbt04qmG34msnlgyY9jf/jPM9u?=
 =?us-ascii?Q?x3Q25ftppK86+2/Ri7zMOn3srS8sjs50S5JzvDpVTif2OrFvXv7Jgnj2ueVG?=
 =?us-ascii?Q?IR1SX6w5xLqq2by4V7vMGJgO+U0UqCg/+JAHLotwe7fydR/25FhLJZxnWEPq?=
 =?us-ascii?Q?hrvBJjtMx+SEBHmdvVSv9dc28Bp8RHHVou4K1IFHh2qUFkgVZ62P5L+2xj9s?=
 =?us-ascii?Q?26PNdPhaVSTz/6PxT6q0MW/69IyNVfQXAYE0DGeMJuLcU1RkCmjzqb9C65yP?=
 =?us-ascii?Q?pMwylrt2oI/H1P+ssPkfoNcaClJbBrJVCWrERmayK1Nr0vWQZfr52mtB3fP3?=
 =?us-ascii?Q?yDD8JrE0kjV39RL5bMRtPc1rU7B6zo3R?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2024 18:03:23.7729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 574b27d2-1a16-4b5b-8b07-08dccf675d9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4372

This patchset adds usb5744 SMBus support in onboard usb driver.

Changes for v6:
- Return -ENODEV in _i2c_init() if I2C_CONFIG is not defined.

Changes for v5:
- Drop Kconfig I2C_CONFIG dependency and instead put the _i2c_init()
  implementation inside IS_ENABLED(CONFIG_I2C) check.

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

 drivers/usb/misc/onboard_usb_dev.c | 78 ++++++++++++++++++++++++++++++
 drivers/usb/misc/onboard_usb_dev.h |  2 +
 2 files changed, 80 insertions(+)

-- 
2.34.1


