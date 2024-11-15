Return-Path: <linux-kernel+bounces-411162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 006A79CF443
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84B4AB3C605
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 18:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BC116A956;
	Fri, 15 Nov 2024 18:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BsKOm78Z"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2067.outbound.protection.outlook.com [40.107.100.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB4C17C219;
	Fri, 15 Nov 2024 18:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731695476; cv=fail; b=TSAngbmXARF3WGUZzzrClAIA8WBIisB22uyxme5xCdtsNxVgIhMoiuQ9q3wxSTycnBemuQWNIfc1MIKwVHJhAK+RoZ3Lidy5/jIcxBtYTVWhAvPzEZWlS2J+CPJ4av3P5d9vvYdsW1ioknbMUvn0CJStak1isZ8uK+1TuTgnW8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731695476; c=relaxed/simple;
	bh=0ugU788vk7Fb62AEGTI7mZh359w91op68HqwObrcctA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G+Dn3T8TobjX/bKnanyak9FCjpZhicXFdZCWrtbmo3/qjb4y0eJnF9ZZzFFN4mNw182RDeEpdkzwmXWobzcSEqHZQ1v70Y1YQVFc5hLBGHflyF3RhWOQAg0fHC7ByKicVq/lsuqMvmEGVATKsGc/nhipDGPMc8tZ9bmaQ6RagwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BsKOm78Z; arc=fail smtp.client-ip=40.107.100.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xkNxq0GLFfvO2AiNtNlhpA7SI6CsWlbnq6V2ub2JD50l0x1L790RNBAP4xKkt5ZxpRfRFbHitaFjh5g7/2SCSIo4AaYLIP/UniI5ZOMMqWUo1JR1nj8SfUULtLnOYKCpY0obaBZ2HmS2JKVQveGfHacVvAo7giE1Kp0fLXmcjO+40Qvv/Il1Y+cOgCoNkjDUk03RCKhEy403Hra+OjNqmKgrPKY5tGaeGL4I0RJWW8PAluDP9GT1yvMpfN5Dmz3R7nOEuxECPeNpB+xORjiU0KEhpaNtH0QBYtWdHDsabcp2uhkFF3MvwpbfFK0LidccBC7YcYcI86oqYf0F2rrouQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDhn6omm2PDSvjgVva+Q//55lVdH7bDG6FPk8U1Yjnc=;
 b=lXeGQM0SR5g226bqfYNdafm0Mil0GAYuLKvQJss3siZ1uII3IxtD/keKAM0Av7iTKt/9MX7vkV0dox5Ww3LaQI/X4+w2MG7LfN1npEGfECmJUieYgFhm2G6H8dxV4pajQRqPfC38qjRs9vUSdhBim/0Dpsu1hN7ofg7olsyHdOxjIGootV8IZ7uiPmA9i018eI9kIckfVJ3K9F+//t7Cqc2iVTkhVyk8MYH4yncBHRLVLHkWoddNMgXj93ZNgS+I8K4qCyhwwP0rolpyz+LuUcNs0ilpeRXJWiKbLgAC3ZA0PWKmH2+PHGtWNP10mYaQfPMVaIDHAbXMGuWiE31I5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=synopsys.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDhn6omm2PDSvjgVva+Q//55lVdH7bDG6FPk8U1Yjnc=;
 b=BsKOm78Z/kGHrlAYNYJ4A2oFTvhD+a4UBAJalp2IbmhvS94gdLlC4/GVGhj6/s1HNjKAjczqmOA/loMfDXmxcG0mEhf8m4us+uug/w65Sv8wAfHrFOhigRCryUk0Vxn12C2mTi6+HAy3akn3COKGsmwn/Xfuetgjy0noThVr90Y=
Received: from BYAPR02CA0071.namprd02.prod.outlook.com (2603:10b6:a03:54::48)
 by CY5PR12MB6598.namprd12.prod.outlook.com (2603:10b6:930:42::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 18:31:10 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:54:cafe::da) by BYAPR02CA0071.outlook.office365.com
 (2603:10b6:a03:54::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Fri, 15 Nov 2024 18:31:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Fri, 15 Nov 2024 18:31:10 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 12:31:09 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 12:31:08 -0600
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 15 Nov 2024 12:31:05 -0600
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <Thinh.Nguyen@synopsys.com>, <gregkh@linuxfoundation.org>,
	<michal.simek@amd.com>, <robert.hancock@calian.com>
CC: <linux-usb@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Neal Frager
	<neal.frager@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH] usb: dwc3: xilinx: make sure pipe clock is deselected in usb2 only mode
Date: Sat, 16 Nov 2024 00:01:00 +0530
Message-ID: <1731695460-1814409-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: radhey.shyam.pandey@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|CY5PR12MB6598:EE_
X-MS-Office365-Filtering-Correlation-Id: d37f9438-61a2-4e2a-3676-08dd05a3ad9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dJm3/uaImGQOdcfySngY3jjlyqUqeElHPL1wf/ISYTQ/7g6FgPhA4WjodsN0?=
 =?us-ascii?Q?ubBrv7/dKEcuTqYix90E4zLRFdRkX/rO6VpSDgpSp7UDKyeg7JmKcQSFerEA?=
 =?us-ascii?Q?XQHFbO99OvfMCTifnaVMFMmwuK0gMnewquIOjG27o8BQAgoFkMpq0KMXhzd0?=
 =?us-ascii?Q?/LMCCDk2uBtDXuvru/+190EkFMCOsJTAfE4WAfaK7siWVlWub+4cHpnSr/0j?=
 =?us-ascii?Q?8TSWCXTeMNSSsEqMX1GAW50mIaKeNbUvn1C3r5omKZGQKJmNfQwHaHCdAt+A?=
 =?us-ascii?Q?VcROdExYtgU6MUTEiX6vlq/0393j/Glkktn7buVuKx9Dw/hDZGv07RFu6mSY?=
 =?us-ascii?Q?MnvVYpGFktxE7Xon8Nmt0pGQ+sWbJ5XG4V2dy4rlPqSEwQO5I1X6LjKoCVi8?=
 =?us-ascii?Q?M82LXJwpO5BaDtbxQQKMx7/GAxCfoeTl8MD1nQOOhY3PHeEyaY7GzfNOOMT3?=
 =?us-ascii?Q?eIqI+exM/Er5npk/aEi9xAsg1qpCQdAJRH+Gy/nA5Jr4s5b/MEk4kAhHATzs?=
 =?us-ascii?Q?Of3kaSvtLuHotKgtwjPwgGcXSBZ4QxqjROu2jB+vtYMpxNkUIpi4FMBGu9nL?=
 =?us-ascii?Q?J/FcYYUL6nygHZrc9jsPoF8pMQIk9GaUzYcHRReLApqs+VsmyKx7/8EUe0KW?=
 =?us-ascii?Q?ma5knuYdfWCAVs0cax6yCxPyGARc0YKF33OHSwknIygh0+C1IwwHnrXViQmL?=
 =?us-ascii?Q?my+4+qBFyLb+DaylH6vF+H5NgmLbMeqlZhXMFfImm96YD0HGxirg006yYiTW?=
 =?us-ascii?Q?GTc2pKq0jktmMBsESI+awtMQVPYplBhrdEyuorZ1bM0QOF9rFed9J6Y+y/WA?=
 =?us-ascii?Q?68W8KZkUJYUz4ttaooZGHEEeOFdqjbeeDmcxiJvPcgUMLI385M7Swq1ff6SR?=
 =?us-ascii?Q?+lzIhNKjJdA2RiOdoG9Uvwr22SVPRAivWLAniRyda3Ca23zmQ6/5pLU1qxRC?=
 =?us-ascii?Q?+FWmW2oHkrBESHONMbdXUJXNqCRpd77HX0WXQJdf7j4gXyaaovByvNK9R6rX?=
 =?us-ascii?Q?ejs+fHx8EnlFoQqCno+xPKFI0ZwOstr6ICvzQUfOFBq7rjIhcXsRBHDQbaD9?=
 =?us-ascii?Q?zAuGs2ChcuSAgLt48E5CrX6hpEcJ8YCGvwUX+d+ZruB9AbSIl5D1dNedi4KZ?=
 =?us-ascii?Q?cX7ZzuYWxKX3arC/pqVgjsH9GrgFkBUQULPcxsBR8/VyqDF5XRuy7ST4ZjJA?=
 =?us-ascii?Q?TrhSaBndlG0+UzU5oe3LF+QARu8G2DT0SQS0KHmRBz8oKHt0y1jEe40yzBan?=
 =?us-ascii?Q?7yT8sN3y2rjH0k8lSw6QmOX5wIhodLpId8L6JBMLCagP3IAYteWq+7PiM7jS?=
 =?us-ascii?Q?okyoosfhhlg9id9hrTwqyUZW+n7lr/quF3IfaZ65Q00irMx9kYe8dmTqiq18?=
 =?us-ascii?Q?fasKAKRyEUWd8Q1FTa0HO76icZCpi0/mY5dDBfowP0K6op7zTw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 18:31:10.5263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d37f9438-61a2-4e2a-3676-08dd05a3ad9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6598

From: Neal Frager <neal.frager@amd.com>

When the USB3 PHY is not defined in the Linux device tree, there could
still be a case where there is a USB3 PHY is active on the board and
enabled by the first stage bootloader.  If serdes clock is being used
then the USB will fail to enumerate devices in 2.0 only mode.

To solve this, make sure that the PIPE clock is deselected whenever the
USB3 PHY is not defined and guarantees that the USB2 only mode will work
in all cases.

Fixes: 9678f3361afc ("usb: dwc3: xilinx: Skip resets and USB3 register settings for USB2.0 mode")
Signed-off-by: Neal Frager <neal.frager@amd.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
 drivers/usb/dwc3/dwc3-xilinx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index e3738e1610db..a33a42ba0249 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -121,8 +121,11 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 	 * in use but the usb3-phy entry is missing from the device tree.
 	 * Therefore, skip these operations in this case.
 	 */
-	if (!priv_data->usb3_phy)
+	if (!priv_data->usb3_phy) {
+		/* Deselect the PIPE Clock Select bit in FPD PIPE Clock register */
+		writel(PIPE_CLK_DESELECT, priv_data->regs + XLNX_USB_FPD_PIPE_CLK);
 		goto skip_usb3_phy;
+	}
 
 	crst = devm_reset_control_get_exclusive(dev, "usb_crst");
 	if (IS_ERR(crst)) {

base-commit: 744cf71b8bdfcdd77aaf58395e068b7457634b2c
-- 
2.34.1


