Return-Path: <linux-kernel+bounces-269500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 126AA94338E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A85DDB2183B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4471BBBE2;
	Wed, 31 Jul 2024 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xZJiEgQ1"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2074.outbound.protection.outlook.com [40.107.102.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019F917BBF;
	Wed, 31 Jul 2024 15:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722440560; cv=fail; b=gT+nQyKII/zyyffBUsBU7TbYsxSZ6pYqFjXKxrKwRI4Q3JRqqxv+y3lBwpx/NenZUjMKCkE0+F83R410GIbNCtvv1EfLoy8iBa5LIoVyOyYxX7oih9GaNiSDrLWFi2Jl4HdtfZ+XcztPYBfxpjRtAjRdP6EdeNY7awlqFnJKtis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722440560; c=relaxed/simple;
	bh=55QMonueLMwrJ0zbdBV3c3pPnqkHLwtVq81+782Uw6s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VgvmqqL3PxdRGUdw5OZ0Tjsehhqu1+WFA72ASNn//kEZDC6KIb1axZip78PmgNUep06YTt2wqBaiH/rqqwa1kRz2R9ps84GDCS0r7oU+e/HkG431yPJRHw8GQHchIYLV7uzH70QZBjhOtlZ+4Uu4+XNsFyaC69h4lMECYgIolLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xZJiEgQ1; arc=fail smtp.client-ip=40.107.102.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kbdcorhqqO1BMaci7H4QmDIVOk/AN6zchL/sbwrTotjdTtJAtDEUi4uS0V8FCQOJsYkKrLIAFAmg7PBC4BZcV5DivVwNprP4bDAzp9V9ZSqzp6ga8E5MJKiOrjQYlgR1RhRJcZHIoMlLXE3Flp7kGEPOys2x0i7HyI+EffxJtjFOSWB+CxYiaW4oOoA8m+MMNsfoMluubD8lfp7bvMO8mHrMvH86Q9usoaV2RhweQF+duq1yxfOARYcw0CpMr25xymR5sPd0ATq4viOL+5pZ6f/5aQAFs7Vv5Fli+1O327OH0wF1ldRv/G51nyCNWXgc7BrrvCBfpoXPsrPFW2x4mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njoOrsqkI+tI8BnJrq7O+TS9keR++hM/rD5si3zUyvM=;
 b=r5Xps4CnOPsgEFaoHgcxVxrg48DwUibYpALWI3MpJ3SrZYYjawWwuIv2SSXcuk7+9vks9ju0T+GqBp8Z4Y2wM3n1sVVYu5LlsOb1RtXTRhO5zh8DTioiuRvxz/QpnqoHMijuHv8UXCRIuRBiXcxlwq5LxDfcV7y5tGi7aMvey31znVhkY2A8BdupMqKLp0xEpZR12a8FxdU+0BHt9Q+RwFWfBQfsJ+OZ7qUGNq6t9SORlpC+HddBabWuvEcpyOIEe/h9hcKndiktNk2uQaHA7a8N32ZCIRwHGEqev5o82bY5xN5NawAlz2topCQ6xJePARer8X2pDqwRCG6VPCDjPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njoOrsqkI+tI8BnJrq7O+TS9keR++hM/rD5si3zUyvM=;
 b=xZJiEgQ1tcUBQv+CkSYVY9SgL2+a5ImWdlo73Jel4OequF2LjW3YaUhi91CYilRKN6FXAAzTtWb5ZBWPVzGXBa5Vtx4wsj8/EpRiuqkj2NOJ0/VonxZxvH1L6AOD7W4DVERIAkg6GpyNqzgnt01xa+mU1Y25QOZDEx227HD9Z58=
Received: from PH0PR07CA0001.namprd07.prod.outlook.com (2603:10b6:510:5::6) by
 DS0PR12MB6391.namprd12.prod.outlook.com (2603:10b6:8:cd::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.21; Wed, 31 Jul 2024 15:42:36 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:510:5:cafe::b0) by PH0PR07CA0001.outlook.office365.com
 (2603:10b6:510:5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Wed, 31 Jul 2024 15:42:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Wed, 31 Jul 2024 15:42:35 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 31 Jul
 2024 10:42:34 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 31 Jul 2024 10:42:31 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <mka@chromium.org>, <gregkh@linuxfoundation.org>,
	<javier.carrasco@wolfvision.net>, <macpaul.lin@mediatek.com>,
	<jbrunet@baylibre.com>, <stefan.eichenberger@toradex.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<git@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH v3 0/2] usb: misc: onboard_usb_dev: add Microchip usb5744 SMBus support
Date: Wed, 31 Jul 2024 21:12:26 +0530
Message-ID: <1722440548-107682-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: radhey.shyam.pandey@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|DS0PR12MB6391:EE_
X-MS-Office365-Filtering-Correlation-Id: 88a8ef26-e0b6-4b4d-db9a-08dcb177661d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lX/M79I/2L/hCzoGoAB1Q39Rfhqe6mbJiF/WApLiek3wxkA4AU3uaxBZSlLZ?=
 =?us-ascii?Q?sZ1kcUwrLkYYT+C5D4Tr7EDXq2BSQNyeWadWH4Zo875att9bBMKdvnZXYcLQ?=
 =?us-ascii?Q?r/NU+YAOdO509sOPcLec0WRNJzxji+NH/5Fz3UMVtf5QB6zsp+avOOrG3bY8?=
 =?us-ascii?Q?HmHOuEUnCYx4+FuKf422O6cphZ+1yJN0fOsTLVOdkbSDnC6j0IYdIwpZvE0o?=
 =?us-ascii?Q?lFczav3Yc4ScG6IVmkJRRXJKtEbZDIxRd/fhIBRrbiRaCNAigtl2e9ZBZpbg?=
 =?us-ascii?Q?z54UwuL583JS62xm37QFLn+mod3Rf9p06DoMYfuemY/3PZuzvGUj8pqDQKRw?=
 =?us-ascii?Q?/vzhPmg69SbcD6F3xpdMi6HhW1w+LGITmQqa6aadV7HbKmkpfyY2jwPEz+Qw?=
 =?us-ascii?Q?pHkfUSaW1obbJ27w4SDVuxleohO+99VO9Zs4XsgNrt6yvs/6Ty3bh1TpBsc2?=
 =?us-ascii?Q?1iLbCuk7MUBgtk9nwWxrnfiKl2Vvz6tQ0B5UYYWpuGz3ykNVOS7TDcnwBRSh?=
 =?us-ascii?Q?SkP3YXyRGzeDXlC1/SXgv3bz2UZhlvwG/aU99tXLCbf2vS34Ibke7D6C8mF8?=
 =?us-ascii?Q?yt9LZBaddwS8Bbc3gO3/dj+GsEkEIMEIBdr1zRFpPl+1k8ejBnjrzmfSsfEt?=
 =?us-ascii?Q?ezAtT336YPkisV3SnU9oByFWYj8SEDqmZWwwPCiL2RmImr7qwzZAbvNb57ff?=
 =?us-ascii?Q?PapkGg+hl/g8wr68FxfoRq9PpZq9CXYJvQ58ZXV/RlhC499FOop8if/tLP7L?=
 =?us-ascii?Q?6X5I9nWTLquGjKM0ZPderRYr+m8vL5/kQMBT+bVAxtnCjrOLadqoCpcQt0zq?=
 =?us-ascii?Q?+F4hdWBXLaeaNI0b7cljdvWIevpjf028lXXGmGO+vYV/pv7Um9xuBsAcBLtL?=
 =?us-ascii?Q?btpt+yHkwDVlTLK+5S838aTfP523YuSA+BiB820jj3ldANr38/UfSU7RIb+K?=
 =?us-ascii?Q?2fPZ7IZlNTWuO0BAY3SRYS0/l5F+TyXrhu3by3VR8w7WP0I8gdkhgbw6Z3GY?=
 =?us-ascii?Q?RivPw8g3hJVvo1zulhImsuPsvyAFNmzy/JgpKq1zZZBMofMi/Q+VI1Fim7uv?=
 =?us-ascii?Q?cnLr/yZOMuXl3ga1H3flWDMOwCqwqDSFL9q14oNmRIsdiAnd/bfexsR1oTC0?=
 =?us-ascii?Q?q2WVPo2iOKaKIJuFQi89jFgrDvO4saZQAq77r4zY/GGjzu7/NEF2DHt/iuwA?=
 =?us-ascii?Q?6h+suv4HMOHDa6EWTmbLUpMW7SgshPf3sGj+m27POUHdvDa8J4CAARsFhI4K?=
 =?us-ascii?Q?tq7m0FqajjmUMtwMX1LcU5lqkgnYbazNWKBF90fUa3s/GZdcJwCsDTdy7m60?=
 =?us-ascii?Q?4BGpQhkkpn91S4wDiEiSiDLwZ3GE7V++v0PvyOz7kW+kf5LlIbVlz+pdPMBd?=
 =?us-ascii?Q?z5j1sXauhGUkCEumMONTxL2hXMAraeEkFmRo409DjLIvs08SYy0TE795YTsM?=
 =?us-ascii?Q?SPjw8YU+sKLUQv6Y5iZw/2Z+q8M8nVmz?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 15:42:35.1287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a8ef26-e0b6-4b4d-db9a-08dcb177661d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6391

This patchset adds usb5744 SMBus support in onboard usb driver.

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

 drivers/usb/misc/onboard_usb_dev.c | 74 ++++++++++++++++++++++++++++++
 drivers/usb/misc/onboard_usb_dev.h |  2 +
 2 files changed, 76 insertions(+)


base-commit: e4fc196f5ba36eb7b9758cf2c73df49a44199895
-- 
2.34.1


