Return-Path: <linux-kernel+bounces-429003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E97C29E16BA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA1BEB26B97
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52EF18734F;
	Tue,  3 Dec 2024 08:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o82dlbFy"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2055.outbound.protection.outlook.com [40.107.212.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908638460
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 08:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733215550; cv=fail; b=EfePKkAHbzFDK/vXmGhWFv43CKnJzQKVkPXgCjZqPt3uC7SbfIG4OWu9xM2+nYSo+8W7TEoaTzROHwm8925Q4BXkUCAu+SA0ndELqw9a2+cirGJ7QmCD8yRy+lqZKzcWFtzeJI4s1AQ47ofc4nf/5qkKfG+7Xj3mZo4woshvcLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733215550; c=relaxed/simple;
	bh=Ui9O/Xcdtl9vrHSFJAnNSqW4VTMWemcezTKttBXZQGU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rr4QO7jYaHbQKcK6lV4Ge7fSvTJlb6USQ8DLe5Hd6vU+6Ae6yblqWdk6h1/Cq+rOP6tds3+EZ7//dOoL9SPlVCVi7vSypUiPkHrttg4uH+FbrlJ7AYuoWu65P3hqVcxZecugZ2SZ/0W51Nr3v9DY/6GAdNdqaNemt+8fvSWJ5dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o82dlbFy; arc=fail smtp.client-ip=40.107.212.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mW6GbK9WOTcoWRzUUCG/KcU5mtDkJIU7cNzFv/4ykmdSnL5s+Kae6+gP7gRysxsyPjZmOAVxdOk5ncuu+VuqVmRnzo2dxz3qLMbB0dtOPk0pjVxRw6YucIEV05Ol+W+RpZMPArpQEn7m8EqC45WLMPIKxsv4GqBjT12QRNE2HlC+tZEyxBRi1TsWccFNiSyC9GqsuUE7ryfsTIvkMeLoiIZ9ZbU2GU+fXaapy7hIy3dB/Umsz5TRgzE1YfhKU4uqOCDbqq2WaVcFunWtiSdBO0fX+20MX8Yk6NUupPdcmLOQZL1BvODyQz9jDSCnD1E3QL6YYsCX1dIt4SnYZlch5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhxcD3ZbkfugLI11+iEFUM7rh+zTs89RnfzJSG6IANI=;
 b=hnRqbjXBOxAKqIBLq0EC3squfuh6nZBaiUBomojJFFNqsenMn3Q+uXSC6Zryea83jHrMQ5kMWxTh+FtwqczZ3S8Ok2znt/wOaEPjOW2cye3dYZkTcVpvv9Zwx6ItyAardz7ggseWN16P722XSNKygHAyO/rALhWIXWJZeA5+zjCn6QDTn57YBYsoGkz13Bvl5Ah+MN1q0DD/3zIW3EHxhf2m8tiIB2Yv9Moy0L6Besy2uC/ozaoqw3fHxrhQC502NP9LSrtSCW9UARbysmH+wpnjZgx841KkYXv6UkXjAcc0QhhbSKqyLK4smu/DtGkRPFOgUZRRJO0e35hBdqn7CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhxcD3ZbkfugLI11+iEFUM7rh+zTs89RnfzJSG6IANI=;
 b=o82dlbFyCRSdShqD08wyHqs0z4b+MJwmOO0lNmbW4+yKYH+OoQIkT8pvnu8k0pUbPeRDFYNMqTGBWIvoJzdoeKjZVsQM/BSDeXviL4SW45Mg6z6fUlJAgAEvhMX/IJ26B5074Lc4PkkTxreAPO9RGOl8DMpllk9H3N4fnrLhw9Y=
Received: from PH7PR17CA0051.namprd17.prod.outlook.com (2603:10b6:510:325::14)
 by DS0PR12MB6462.namprd12.prod.outlook.com (2603:10b6:8:c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 08:45:42 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::24) by PH7PR17CA0051.outlook.office365.com
 (2603:10b6:510:325::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.16 via Frontend Transport; Tue,
 3 Dec 2024 08:45:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 08:45:41 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 02:44:43 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 02:44:37 -0600
Received: from xhdipdslab49.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 3 Dec 2024 02:44:35 -0600
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <nikhil.agarwal@amd.com>, <Nipun.Gupta@amd.com>
CC: <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
	<michal.simek@amd.com>, <git@amd.com>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [PATCH v2 1/2] cdx: register shutdown callback for cdx controller
Date: Tue, 3 Dec 2024 14:14:08 +0530
Message-ID: <20241203084409.2747897-1-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: abhijit.gangurde@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|DS0PR12MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: 74bc713f-6013-48a4-0c5c-08dd1376deae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OwMW69TpSWdyzO/NVmqfXTf9pnLfGNS46RvFGkqwzt+1igqXJ32rqYD7W7lP?=
 =?us-ascii?Q?Mn79/qOmzgefRe2Jtb5H2U4dfFEb99JlNmdT/OWalSE4JLpg4wj4mB3L0b9y?=
 =?us-ascii?Q?rtMJeyMx39pVacRHQNVHlG0/Ytr/pIhztFbX4xvyKqEIrsixQggIA0G5tzGV?=
 =?us-ascii?Q?Foh6DgHSvBVExTA3pNWujjPoVcJ/4kVf7tea3VwyGbml+VzWOtr+qboBqumq?=
 =?us-ascii?Q?YtP2x3AhzzLLNLen9yswukJdm117oz7knoeigs5/t9C2MoIxksix3Pr1Sx5i?=
 =?us-ascii?Q?uXNVL3ochGpsy032LzjVnDOD0A499yvSl++j6MFheMqh69i77cK6DA5UWm8A?=
 =?us-ascii?Q?CmYvvnX7bWFH5ewkId2ItsMNBiYebbyarzT+jqiqU8WkDriUFRZfy/Mf0DEN?=
 =?us-ascii?Q?9f9bafxE99rxU2GIbihaBG3cZcF/v/RtNiZbyIaBshMvygYOiXliJ2YTPAkN?=
 =?us-ascii?Q?v1MpgG2flDpJkVnTNx+p7Oq6IxhuZ9r7cYN+qFAc4WHwIn5TrA3LJ1OOkv7J?=
 =?us-ascii?Q?Ok/O8ZCjLdMNIjCEsI2bU89uOvXP+W2QFK8CyDhbL2Iimav0oNwdmpAqUIPw?=
 =?us-ascii?Q?Pyd8a8PN7+wj5dGnsIWeHFFCwGOkRTz9BjxKyZG/o6KOc2n975HmzIFqq7gO?=
 =?us-ascii?Q?Bg5I0K3k1XNq4dL8MrXhUt6oiUzK6JHgt1TXU90NlJDez4ivUqqtgcDYsPBX?=
 =?us-ascii?Q?yYlLeizyOEjq3mbxPSyQ9ZRdbft5pEYxYa3oqo2dkj6M9kXwxTAXfwKKWmP/?=
 =?us-ascii?Q?4gOz+9X/+7kuuNttJ6caTqOlZywIPq8/Jrr06MvWGAe4lfAmdewTbg4dfHIj?=
 =?us-ascii?Q?z8QZ6zkrMH/j3LNyqOIePHeIuYdMJQVtnJXBMNanuoMeck/Yfsr8TWCQKw4D?=
 =?us-ascii?Q?Qg6NQ/v/v1i23hAhTe79u09DLuaMAei40hInn7ogY7swuf7Iwy1jFTdmEHLa?=
 =?us-ascii?Q?Dx1u1MlcIYw/wUwkm89W5afJbX56AbuuYYqUUrAhR8vp6OAnTkmJH4L4885F?=
 =?us-ascii?Q?+zO8AnRhRUjMi4a46P3gMLIsqFYOLzy+6bjRIIScmxxdW2hinEkTDi8CSAHS?=
 =?us-ascii?Q?KDIUTsdUT8v4HiUpjW86X20ESgdlCGv2Zs/l2ODj7GAiV0gf/zjPLLveJser?=
 =?us-ascii?Q?XbYP6mkNXJ01jBHdnzdm944uqjN8Tycrvu3QBhqEUwADt3Ay+4hd2peK7UAo?=
 =?us-ascii?Q?4TCAkSPY1+JdoF+VfEh9bQvd8tglt92bICDS5/mG/dIRKMugy0Kx+5kAhbQf?=
 =?us-ascii?Q?1xJYpMfE3IcXbffbVO3AXxHm4uE35IrNf0yy9JrR/jKDH0aFswell+0XPGdB?=
 =?us-ascii?Q?PA4qBhClNRV/inzYKUf8CpHYqyIILhSNFPp7yj92kE1/zP6lPrhjbw1aXjk/?=
 =?us-ascii?Q?cmeamyymvwmEgkEXUwjOtgSfidek97Zyk+B9hMcJhgZ2kj/PuAMDqYQG9PT1?=
 =?us-ascii?Q?RU11glUVwFvsR+Z6KQ1+X7G9POsZYL9M?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 08:45:41.7932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74bc713f-6013-48a4-0c5c-08dd1376deae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6462

register shutdown callback for cdx controller platform device
to handle graceful connection closure of rpmsg transport.

Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
Changes v1->v2:
 - Split single patch into two

 drivers/cdx/controller/cdx_controller.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cdx/controller/cdx_controller.c b/drivers/cdx/controller/cdx_controller.c
index 201f9a6fbde7..d0d65fa7bbb2 100644
--- a/drivers/cdx/controller/cdx_controller.c
+++ b/drivers/cdx/controller/cdx_controller.c
@@ -236,6 +236,11 @@ static void xlnx_cdx_remove(struct platform_device *pdev)
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
@@ -251,6 +256,7 @@ static struct platform_driver cdx_pdriver = {
 		   },
 	.probe = xlnx_cdx_probe,
 	.remove_new = xlnx_cdx_remove,
+	.shutdown = xlnx_cdx_shutdown,
 };
 
 static int __init cdx_controller_init(void)
-- 
2.25.1


