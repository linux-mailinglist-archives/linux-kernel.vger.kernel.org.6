Return-Path: <linux-kernel+bounces-441285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D98A9ECC54
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FF6D188874E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3E222C34E;
	Wed, 11 Dec 2024 12:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UCP6PVqu"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EC322915D;
	Wed, 11 Dec 2024 12:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733920937; cv=fail; b=laAlyidMSLlIWzRlH83fwuLUMPLJbkbYj9BeN4i1QymHXgL6Nch2z8JZQGuG0pjHkff7tetD88H6tV40qb/B7lzmobmjsolBrxMykFtRt47eEV+617PQY/baEwJVyzYjMTNOwO6r3k2PZXM2aToZe976D2awrxQm/XwY1vFwfpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733920937; c=relaxed/simple;
	bh=ryTe0ccOewfhtxznZZWZKkJZm6f6ZAD4pusPVNgRNJI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=etur+hvI3VJigOaq5TCPCzEy2nXbTTSna8mafGt1rAY8JTPjsOljC8d4djQEoOpH1EORSbUJQB/GjkLIc+JymQa+tF+v5rVLp3HS7bTIh4m+2MrirAPjika7JGjPyevW6OQL/5FRAeXMTlrHrsdvA5GCvHWD1CoOyWL60q63lmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UCP6PVqu; arc=fail smtp.client-ip=40.107.243.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kNDjaNpOTChzuSoy2ofuulZ6ywUaPGuYy+AVeLljZXpSlPt3F4XnKq0OtboimH7pcLLXE8LCywMpZJUC42Hs6W04VgMHHPKQyQYQ6AtDoaysKO9Hu/4tUh9ij1ClgOOpQxxQ4OOHv67p0IB1r1R6mYQ3oM/cXBhZbkdRLT8dz9b9YIjhCHPwPvBJhZNz/YikCbEsvPxFGmQuv3P2qhTz2QDHDqWvp19nDqwP/4C+LwYv4xiCFymZ2HA3u3suggCu+4LAF8zc3TDXNPRUUYgGN01xix6ZXOXHqppjhn6/2jgjwN3VMJ2mQOuaZLzmddGo958e2lgS3yv/bKrt9YvOKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhixRDcNji+IuqOD6ViXUy131PEz1AOyp9MD1FZ4nx4=;
 b=jGI28nfVkG1P8rItG9XxOW9nP++de25xSzR84mU+NXDTu1j9chA2cy83cU5wIvJc9k+bO+DDWceUbpVj3B21PRVRpYcOACkVUQY2w+ghEi9ne5BX/4/pfsBEgyEFcLq+FFIlinEkU/FhOepTBkcsgk725fuY+rOqobeHNdNWoKsfEs0L9/fWvexgugPLxaYv1qOcItJhVb8nd2Tep3MgrHImy8tAbRm9AHLh/AmBd78UfZacMLoj3dG6L2FZBfkCDExki6tuHxCiYcA5kJLpKt8yr6jshhriy2TqrYXy6Fk3opdcJ/refmN017zKfp1SWqzcnrEA9m489PzrpApPRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhixRDcNji+IuqOD6ViXUy131PEz1AOyp9MD1FZ4nx4=;
 b=UCP6PVquZlu2k9j1OnU6N6U3o1uzPA8/7r9g0n1EeL4yfXVstsULPCplj4ykYILdcEwl6O6m06pun2sTlj7B6EvKWzEeA3wm77ZEJ9MqQXOX4Mlku/oTVaWo/f3hBZKtNfPsa/xhBbsLQKpvRFQH2904tcldAtWUTm7Z5SlQIoY=
Received: from BN0PR03CA0017.namprd03.prod.outlook.com (2603:10b6:408:e6::22)
 by IA1PR12MB7566.namprd12.prod.outlook.com (2603:10b6:208:42e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.22; Wed, 11 Dec
 2024 12:42:11 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:408:e6:cafe::bc) by BN0PR03CA0017.outlook.office365.com
 (2603:10b6:408:e6::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Wed,
 11 Dec 2024 12:42:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 12:42:11 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 06:42:04 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, "open list:OPEN FIRMWARE
 AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated
 list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 07/15] ARM: zynq: Add ethernet phy reset information to DT(zc702)
Date: Wed, 11 Dec 2024 13:41:26 +0100
Message-ID: <9e18d59ca339804320d2a5e3c7362aefa3bb7c99.1733920873.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733920873.git.michal.simek@amd.com>
References: <cover.1733920873.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=676; i=michal.simek@amd.com; h=from:subject:message-id; bh=ryTe0ccOewfhtxznZZWZKkJZm6f6ZAD4pusPVNgRNJI=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvTIjurc6ulvQqR8DkRaVxldM8ut3/SnY/PEbcGOS9/E2 S9N8P/aEcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACbC4MAwP3BXhP7m0w/CFQ7v Otnvs+vkkq5b2xnmOwSICnz5EfTpuZZ07oSV15Y+3FVnDQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|IA1PR12MB7566:EE_
X-MS-Office365-Filtering-Correlation-Id: f903e11c-ab85-49db-62a5-08dd19e13b8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SJgJ/b4Q7t6LqjV6uvU06HxbBmW2mFfTrw+EBkFRvGEKMbpcKU/YfwH47OTF?=
 =?us-ascii?Q?GgKO/Jjp+SYGDuNFhI805UyvP9hNdZa0yjRsCHSM+45wAN+Cnti1T+6sCT3q?=
 =?us-ascii?Q?ncqExoJeNw0cl3vnsmXIMSpTgV2O5nBqy3ClBeBUdx33CDCS3Db/tA3t0BDB?=
 =?us-ascii?Q?6JMkwO6poYEbXvhEq1WWiopdKnmTOIDDj3Xg5897nduOdR8Qo3HmecOFYgrt?=
 =?us-ascii?Q?QTxFC78sOK2JwhtyWVdx18NSiCIW+rcqkd+XyZLmqQurV9BwehC8hgnZzLro?=
 =?us-ascii?Q?i6fbCA1ij6QkmR61p+C999iaFWlDX7e4Hxrhj1/GveQ596NgDu+LDXQF3rmz?=
 =?us-ascii?Q?RI9eBdCzFbAYrNH0I7UmD6PLdgiCtMpTMkF2MyeW44Qf+WumVmOHoF8u+R7J?=
 =?us-ascii?Q?Ub2cJ6Dh6S4exWkV1leL41Srau766gOtZoDYJDWZ1NX+eXMslsrCQeFaHlLC?=
 =?us-ascii?Q?8I1VgyIpPnE+t8sd37I73fZoW9C8e9oHNIg/kFOtqvJVC5G+whbh+e2sH9Is?=
 =?us-ascii?Q?w1DlUkwvLg0lFYW+7q2JtFmWKENNX31ZSR7Dz7IchJIqCnuYucXuv74HSIsx?=
 =?us-ascii?Q?NC7DwTYM6eYqsTk5Vg6V+vdMLxvTbj1pqejLnq4WL2r8XLyagJb7gq8Od31M?=
 =?us-ascii?Q?s4AQUqu3v0HHUIODFdbvoUSpvFi//y/TAXIahxQvUU74ydyxWEvaHRfcH3P6?=
 =?us-ascii?Q?6y/Mj2HHzhSFJbDXsieQXDwcYKAOUYv7Yu0WYoMUDpzKrZjVVRcJJO2f4xtv?=
 =?us-ascii?Q?C+R+ph7J/krvXdY0Jo2LLAQQincpZ9vYID75AYOEqBs+Oww4nN/n9ggTnTTb?=
 =?us-ascii?Q?gKH71bd5iyJymObK67B4lZTzh7YLFXHLTAmtCCJ/Cx/siIVgOzlc6zBG/fKI?=
 =?us-ascii?Q?ZJeUykz7pq+CPrZUw4Za31JXS5u6f4WrIPVK+5rOqTSj1LPQWBCWgPupeENV?=
 =?us-ascii?Q?UAN1X8AkSgTwPKIT+44+5LH6T4litTgkUhkJ7Z+OuV6S8znU7EETZA7vzfVF?=
 =?us-ascii?Q?bFBoO3rxy07WhvYa+KVoI82LFmLYRPkuqDFaHnvSqNHbO0WL9X9YSiXH443p?=
 =?us-ascii?Q?imN2yHa7ab1LzQ1vO8wYV7Rvbxdd3sbpEOt50Hai9iv6g6ellBN6xgo76SK2?=
 =?us-ascii?Q?DDloAFNtpoAp4kqntnU+HncU+FqpR9cCzVybv8gzdz6t/X8VSz8FfFgvcBrg?=
 =?us-ascii?Q?uO1ixObr5NCmjNNLUhCIGeXNDujIy67IuC2KkmCCF0rsLY9n6eY4W5UizuRF?=
 =?us-ascii?Q?/JuIyDlw9p+7fFIm8ca3mphFpWDWlwh7+PD4Dd7RAp48CvoqiFnCZkVAmpFv?=
 =?us-ascii?Q?D1Tqm1EUtyaV/b9xSocWUI81Trm73VyOW1yFSumfTPQyeCZsZ8cUlrFB83aO?=
 =?us-ascii?Q?36hyvw87lPtRh7RVNHq57/ShoEh0x3GcWEqyVHcEqh3F7p3bU17GnGbnKe97?=
 =?us-ascii?Q?3GAPyvJfhzux68YNIQczHeWCrS+dOPG5?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 12:42:11.3245
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f903e11c-ab85-49db-62a5-08dd19e13b8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7566

Added phy reset gpio information for gem0.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/boot/dts/xilinx/zynq-zc702.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/xilinx/zynq-zc702.dts b/arch/arm/boot/dts/xilinx/zynq-zc702.dts
index 424e78f6c148..975385f4ac01 100644
--- a/arch/arm/boot/dts/xilinx/zynq-zc702.dts
+++ b/arch/arm/boot/dts/xilinx/zynq-zc702.dts
@@ -79,6 +79,8 @@ &gem0 {
 	phy-handle = <&ethernet_phy>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gem0_default>;
+	phy-reset-gpio = <&gpio0 11 0>;
+	phy-reset-active-low;
 
 	ethernet_phy: ethernet-phy@7 {
 		reg = <7>;
-- 
2.43.0


