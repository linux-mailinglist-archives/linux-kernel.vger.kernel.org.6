Return-Path: <linux-kernel+bounces-369632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 744CD9A2015
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 12:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 955D41C21942
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 10:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D241D414F;
	Thu, 17 Oct 2024 10:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ssg652cC"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365681B0F08
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 10:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729161271; cv=fail; b=Iq0BetNn0Z045JOu6y78JPdNMqrlNbAcsAqC81crsY2NJCIamJACic35ef+EvQxq2ZgJNxixF0j8+M1lMqdKCLrAILQe83trD5ruDO9eXdCbUVAUyAfyTN5zNaWeGoyy0o9U0X76azlGHypFEY5e2J/Hab+BvqKBLFvGTQsAkSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729161271; c=relaxed/simple;
	bh=mC7QtOcQ63ajPzne2BdnxKDtROV9rEPor7Kv+ZXXib8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LNygIxEoA/YN6Xe9FIHBheul3Or0MIHDJbvYDwIM0BGpk9h38T8dooI/Z53R/5AWXbHMdwoBVSihgtuR+qb2G/yQ27tIjH3ueMEeyOHY/ZgoPyDKMEg3RXuVmoYbHWzXJpmonntvzQTpPnbBdPWPvpR4Yx1fT5Iz59Knu+zVgBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ssg652cC; arc=fail smtp.client-ip=40.107.220.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lcMYn/OvFwlBmlOaGv36cA2G48mNHz1rOtORR7Go7ZuG/AzARQstTfVbVR+G/OQtGk2QFFOE1+GeZ7T7B0gSCFSikZKcgJA4Gnksrq3ZsnTqMUP2b785vjfrqbeepzj+ayOcmQdm7bNBVutbWuudZqY6hx8hEb/DhtN0L6X6LTlRsRJ2IILAuAqa1i7A6mXsOoVO1xbcbkRSYXegugqRirmeMyNGe5slpC4Vn3aR1RYXGCuNoU6610umQIKQ3frQEdAKzWRo+Rsmu8lmjPpSuuQ7xmcxgq6qr9TUcGYI2k2S1Omd013ha53MPcM1QfMk1rS0pGmbBJSctmkf0hc6Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SU03uVRsk/Pw14MgcjzsU/FexzXzhZ43HOb9BhRFHcY=;
 b=cQtE8Ge6Njlh2l7yXDLbWYD1iU/UWydEafuQdKRXjA8e3DIhMwhQlKLQozxl3wlNpEf02YDMYtXbVDkIxXtnd+hgm17/lcxdOVFRpl3BdSninzD1a+gs+CabubmnjhkMQMNYCRNl9L4uARvPDx56vqWPrUqketcZcAaPY6aMRQwUDgqsScpxFeXCAh1WSbcE0Ix10fqZ84yZ+Lwn7hxHfojTYURvSjJ85Cff0T8F3xdkjMcxtiZrRDgZ8jmcJmNbpfg9WwQv40yy0c7CIRLDljX+/hUWlGprPXM6+ZA3GM9x+I9sTDgZ9vNyXa2zCqoLMBx1zFbXMgVlXmoqlqnEig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SU03uVRsk/Pw14MgcjzsU/FexzXzhZ43HOb9BhRFHcY=;
 b=Ssg652cCqlP7HfaUP7bVwcx6yBntSBMnRsbto89uxAOQlnhrllY98tNZkBusmqx0ZdTVYVdGS0Eowe2SZD/XHmNbxS6P2D6hKujY5HkYWB/lUCwSFcVETjt4EppuODSXdyXUwKTHM5Mwc0haLPUtR6M0DLgKO9yZZpIGOahhDaY=
Received: from SA1PR03CA0009.namprd03.prod.outlook.com (2603:10b6:806:2d3::20)
 by DS0PR12MB7704.namprd12.prod.outlook.com (2603:10b6:8:138::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 10:34:23 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:2d3:cafe::1b) by SA1PR03CA0009.outlook.office365.com
 (2603:10b6:806:2d3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20 via Frontend
 Transport; Thu, 17 Oct 2024 10:34:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 10:34:23 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 05:34:23 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 05:34:21 -0500
Received: from xhdipdslab49.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 17 Oct 2024 05:34:19 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
CC: <git@amd.com>, <michal.simek@amd.com>, <Nipun.Gupta@amd.com>,
	<nikhil.agarwal@amd.com>, Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH 1/1] cdx: register shutdown callback for cdx controller
Date: Thu, 17 Oct 2024 16:02:16 +0530
Message-ID: <20241017103216.316114-1-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|DS0PR12MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: 17b82e02-eff3-4c56-9a2c-08dcee974472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S7GxBr3I05g0eBqvT9Ru0a5MmpPgUwUAKK2Ekc3RS8aNYdP0fSBc1itvslM0?=
 =?us-ascii?Q?t6q39pLozjfum9R53aOYYr14ToWhr3JqHCrvpgkorlM4kgw1apX2jcURq2aa?=
 =?us-ascii?Q?kEaUsDa7Vj2V5XtdMLRQVdN9KsnaebzhUPfoUXqF4ZRW5EI+kDb8fz1c0KZ4?=
 =?us-ascii?Q?LAr0aRP9YvquS5nZDU3n0Qs74sao8nzrQVAAzM0i4ff62CHoSytXYDBQdL4O?=
 =?us-ascii?Q?9F7PgZfLzRT9SwZVSUSHlEH693g+l2Kz78TBU3oxEwEfSbPevmnfInHDyB1D?=
 =?us-ascii?Q?4yzKon7mWTbajc8oPugx0meN5AO4iqTZGlqrp9ZuhFyq0nZjZscEhLaibj0M?=
 =?us-ascii?Q?8jqvNZ2rkKMI8fTmfGhexWKjLRiOmCn2ctzMntVBTbaSCsHZVplAUFDBFNzV?=
 =?us-ascii?Q?QPhYHwCsDyavsdCMx31lxzctaQ8Y+SYuE1JhQBd5KB6JlrNihmkoF8vBbiW1?=
 =?us-ascii?Q?wbIXaMag4AC1iSYeiI1LsXeebwl0s+wjcFxzCcL1FhRPDmfcQVN3NmM0bEdz?=
 =?us-ascii?Q?Fr/ic0ILzPfWudcs8/VCrXTFMTv5PBDxTQLmaOkkdb0th1JP0qUVk83H/pBG?=
 =?us-ascii?Q?ayoU/JBuLXr4DxHh0pNemzTjkG+tLkYmYcNoqey8xXKsN5rHpwAkgm0cfVe+?=
 =?us-ascii?Q?nx0wm7MOdquZGMjDd39lLkWu+J+uQntHLnRcl/0aSz3J2U6Zn6OfMhyQCvzj?=
 =?us-ascii?Q?HiUTygKcdhKVve26Bi1NcpXVA9wokTvGhCK/9fK9tnj8jSbHcj1PLsQL7Cub?=
 =?us-ascii?Q?tDA2uLm/3F+uY0OMEeKDpPrNm0JHqM5jKjksv11l1RHIoy5g7kk3M9EQb6g/?=
 =?us-ascii?Q?CQAQcGtvFK4vbW+syGUbO1kGv5H9iQD8CcbpcLaY7yT9W6E/Y5ZfgF8Z8Tmk?=
 =?us-ascii?Q?nXnA9MkEBRY1K0z3gjkIKRarwsz4SYw3rHRsWrVbCXp49dhMK6uDF+ak4Eqd?=
 =?us-ascii?Q?lJzzjLdXQp2GvSPh8l5Tgd3PjSCmWqMardB1QOJoTirKygoXKo61SiH1TD6/?=
 =?us-ascii?Q?XxrpMjZqn8rVgbQM3uTFFytIIsFtteHWvD7Da00SzLaMPxn1Y044LseY3arM?=
 =?us-ascii?Q?P6NS0p6Wgzn3iGgRFmdCnLfBt9zDgZLm8XKNytBjv8q95X2L/tN3dicaPH+t?=
 =?us-ascii?Q?c6kBmxLn42LJFg3heeRc2/5up0mk9mFhVYqJ4xgQ//8xw035pAyGy2+eBkYm?=
 =?us-ascii?Q?/COZEFi+T2QnAHmvf7a2oMPRsS4wkLKyQxvaboJBPI7Q23y+oHTp433YrG9e?=
 =?us-ascii?Q?D06Iah2Ylj3wFZG9fk1WdV9R9YZ+2GGaKlPqaewp0oRg/19PFzgBz/7ZviUI?=
 =?us-ascii?Q?YX9UeLSJZBPppyok90tlMq7vkZMbhIgeh5JdHPSyo6Xnle3A4BmZ+4mF9VP7?=
 =?us-ascii?Q?WfHkVyQ7mVNrQxTpSOaAidNk8EPdezsVZhGiZeHhWur05oTWZw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 10:34:23.4820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b82e02-eff3-4c56-9a2c-08dcee974472
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7704

register shutdown callback for cdx controller platform device
to handle graceful connection closure of rpmsg transport.
Also, handle shutdown of cdx bus device by disabling the bus.

Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 drivers/cdx/cdx.c                       | 5 ++++-
 drivers/cdx/controller/cdx_controller.c | 6 ++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index 07371cb653d3..655a056bca4e 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -338,8 +338,11 @@ static void cdx_shutdown(struct device *dev)
 {
 	struct cdx_driver *cdx_drv = to_cdx_driver(dev->driver);
 	struct cdx_device *cdx_dev = to_cdx_device(dev);
+	struct cdx_controller *cdx = cdx_dev->cdx;
 
-	if (cdx_drv && cdx_drv->shutdown)
+	if (cdx_dev->is_bus && cdx_dev->enabled && cdx->ops->bus_disable)
+		cdx->ops->bus_disable(cdx, cdx_dev->bus_num);
+	else if (cdx_drv && cdx_drv->shutdown)
 		cdx_drv->shutdown(cdx_dev);
 }
 
diff --git a/drivers/cdx/controller/cdx_controller.c b/drivers/cdx/controller/cdx_controller.c
index 7c1ea5373b12..9aad5a9b328c 100644
--- a/drivers/cdx/controller/cdx_controller.c
+++ b/drivers/cdx/controller/cdx_controller.c
@@ -261,6 +261,11 @@ static void xlnx_cdx_remove(struct platform_device *pdev)
 	kfree(cdx_mcdi);
 }
 
+static void xlnx_cdx_shutdown(struct platform_device *pdev)
+{
+	cdx_destroy_rpmsg(pdev);
+}
+
 static const struct of_device_id cdx_match_table[] = {
 	{.compatible = "xlnx,versal-net-cdx",},
 	{ },
@@ -276,6 +281,7 @@ static struct platform_driver cdx_pdriver = {
 		   },
 	.probe = xlnx_cdx_probe,
 	.remove_new = xlnx_cdx_remove,
+	.shutdown = xlnx_cdx_shutdown,
 };
 
 static int __init cdx_controller_init(void)
-- 
2.25.1


