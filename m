Return-Path: <linux-kernel+bounces-240078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 971B69268E4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06EAFB21555
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 19:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978E41891D1;
	Wed,  3 Jul 2024 19:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Sps5jegI"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4EA188CD3
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 19:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720034043; cv=fail; b=WP89pUHnPnBv9SMelJdPY9LYbuMG8bUfL3nCSbkJb/sDOJSeEFMuLJIt01z20MfOI8PUPUeh/R6/J/KOBVYtKH08MX/GIH0PcbWlciV/aDbc5rWLw2SBA0akE3iCa1mhn1KnRSOf+3CgBIG/D6+5gNhHxDO/dkJOWPP7fKXK9DY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720034043; c=relaxed/simple;
	bh=oJfRuw0O/9Q+ruC7ATc6ovAE5HbZ/mOwxv1l8MvQO1k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=STD70CgGfNdNSJSUyHfpTlGn2Feo7LhdaS59jQl6O10F77LjRz+blPepal3D+595W0ekT9H8zMg79OmldwRmux+ZeqgGDHVZAxuM+zB0OC6R1ncKp05OPVsMsCVT5c/QrFsS+C4ez7OL4SyXV1s/CeeSDbti6BpgCGUOQ5opHlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Sps5jegI; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrwqlS2iU0TJ7WfWIhQ5W4Zv7yMl6h0okJwG1y1ZiPqThQb7qO6xUfJXSOfeTYzSiwfBtDo3kZIJjic+U3cyHo+Mu9qE2wW2vrhHyedVV8dNil677fvf4aqQ8VRPIVEpLApSb9JiAaywnm3zJCsqhqErrXyqfKAQOgHxW/j9N3ITE6mcT+FOJgpJhvZ0FaqrXaYvRUK2fNhbOLWht8kBN3Ps6ndMwFDD3a8owez7OjDbZFXjmk6200Rb3mxE0IWrDB6U47EZZHwhwo/sD9pA6b/gGvMumPj5kk1m0k9CKFTWI8EbMC85/ExRx4iJfHenegjszowQJUox4a4njbeq4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvgJmVRQwrD91SYgJaLJgDKnoD3HRu+Gc/adh9e+ufI=;
 b=LZOvY0q8lXby2IU2rIV+kXNGlG/DFMUutwOnW22xw9sFo93USQ20ew++B4fui9C5KExFpWFjns0CqBW4DiH0r4DR6ZoTjFY2oQl0Uc82BPheTQAmuA79qr9A/0zD60C6GaKtIjrRnpmqv235DOs+J7nc+ZYctR2HaAi06E1vp/4tE/j7sU1ot2FYmjaOqwNK9LmfONnnZ3sdP2+Z6p3HEIvQu9aigj4Zjs8MLkNISoN4/zKtYR8HaVtXALDmTUsavBVa4OjkADvkbbfsx7lRg3mW0nWsc3ad//BQHc1GxnXVUXtB30ooHKU8TB04iceWu4PP1VcKzw7CXrayv/CQbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvgJmVRQwrD91SYgJaLJgDKnoD3HRu+Gc/adh9e+ufI=;
 b=Sps5jegI6Iq23mvnvDir4r3H56gUVTw2bJlQwBl+hlG/lidq+R58lgW885Ir7JuAmB0wbyOGJ1t7xEWLyUF/v124WvTz1LrVzcNZmpkNh6Vxa1qBhW44XPCNFzrqOKouRctYVm6sEIyyr0VmJarZ/cRd7QdIndSFJutw9kwBThQ=
Received: from BL0PR02CA0049.namprd02.prod.outlook.com (2603:10b6:207:3d::26)
 by DM6PR12MB4369.namprd12.prod.outlook.com (2603:10b6:5:2a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Wed, 3 Jul
 2024 19:13:58 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:207:3d:cafe::c1) by BL0PR02CA0049.outlook.office365.com
 (2603:10b6:207:3d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33 via Frontend
 Transport; Wed, 3 Jul 2024 19:13:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 19:13:58 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 14:13:56 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Mario
 Limonciello" <mario.limonciello@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
	<christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
	"Rodrigo Siqueira" <rodrigo.siqueira@amd.com>, Chaitanya Dhere
	<chaitanya.dhere@amd.com>, Jun Lei <jun.lei@amd.com>, Harry Wentland
	<harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH] MAINTAINERS: add an entry for AMD DC DML
Date: Wed, 3 Jul 2024 15:13:41 -0400
Message-ID: <20240703191341.239296-1-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.45.1
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|DM6PR12MB4369:EE_
X-MS-Office365-Filtering-Correlation-Id: cce1105b-2105-4689-16d1-08dc9b944a2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MwXPXfqbcjIf43nUfrYjkcOalh/cJB/hevuEL8T5fwCAPbDI6beEq1Jom9qX?=
 =?us-ascii?Q?FFP9nOVTQtCYHPP/x4O47Rri2ZGQFOsdeUqFNNmG0/VlzPCeozLXlIaT3pXG?=
 =?us-ascii?Q?1HF1GmujpJeKNRlht+1x6X5zXbwPneOWbRcp3MY4Zl0j+2sp+aZc30cPWEN8?=
 =?us-ascii?Q?e9bVYZwNi3HMeNLzXZph51edlYAYtZcw0L2xY0X7qFqerpg663xhaUYi63fe?=
 =?us-ascii?Q?jSPJKCIu2Yiu9x9KTSYzx/TC2IiJ8kSxDLuTPNcegVfQqL3mF5DK7WJGa6ut?=
 =?us-ascii?Q?+pV2C5kmJ+PyoS3AZ7pMJuXMhsZOL6DlL3qmpPzERM/2ZUtw+VV/H2RIupY8?=
 =?us-ascii?Q?tCC2dC0pFD5QKFZ6Wn2SWQS63jijcGiNiwHRaHppV4TSAp0zaLzChofuqwOb?=
 =?us-ascii?Q?cfGVMAd2d4lBNrQrlNqEDV3FjHzUFpOfIICiG9PDNtN+bE0xEpQl72NvrePO?=
 =?us-ascii?Q?2IUZ60nZ6QA5LQVsx5hjMGUBcRJe9ImPp//dATlvt3dL5M3/tqtkcGgGL2pb?=
 =?us-ascii?Q?IlOBetkNRHGVnGoYZld6jEYIlkBF2UYvJxtqd59PbHZW7DxL8cVujVqViePB?=
 =?us-ascii?Q?sYM6myKRzE9H08L5Ly/OZEYbFnlYZaFy0e3W9B1z0AvmdUga9VfKBjJ+zjVS?=
 =?us-ascii?Q?dEZgZaOjG/Ct7qsRQxnVPiErFjVmcSJqkfEXdRhqIIJz5gIT7LBeMrr+j74M?=
 =?us-ascii?Q?jcnMwWePr+b8q4ttUGIB6V5NIURrO+4Vazh0SW9Z8QhrstqOfG5dC0BfxDFy?=
 =?us-ascii?Q?g4dFaqyL/Wz13Wbs/X+MqnT3Qev/3cd66qzQ80yLV2axNqMGmkXfThSm9J1h?=
 =?us-ascii?Q?2grqsEqgt8u5cq0mjRC2AyRRTWuJmjyZJddL2Ox4b9cbv6yLZPQRtv4+rfit?=
 =?us-ascii?Q?XccAm85pxDkQbS4SCLTIZzMDgKxGqee09nFDB3TQGE1xIu/ZbI4cWNELEqbV?=
 =?us-ascii?Q?T0aD+GWoDx0P5viVfskxkS3NbCiYx3sCCaxT5JayyT7Xp/HVp5H3x6up/9Vd?=
 =?us-ascii?Q?ZegPiNILCZPVA54MBH5BC6MrencRufkaNC9tyg9XaMTx4eGQbNLVFjBswyNg?=
 =?us-ascii?Q?wgXcAJPTXcTJkbfbEWEGs8mPBNEjSqow/pylW+/m0R1aQoK8jfWATSR9iVhj?=
 =?us-ascii?Q?nQBUgOJwGhfrpGxsVDmsXQ9hawW6liSKG/adn963NSu8op/Uas7F488SxRWU?=
 =?us-ascii?Q?R+yFA1GEm2EJHQHAejpANCWPLVApuFS9ZpYvrC8P8ldrhOkpEc/UEgpMLNyb?=
 =?us-ascii?Q?22Lnu3+38PyEps6DWthNRFKLjpChya2rddJjnSlpo3elbnjN6MWNJV8dH+Pc?=
 =?us-ascii?Q?C3VXzZbO2d1QEGJa5Chs4ZQCA5DxQfiaOLgFj7WpuL4qOfupjoRDjQQK0+2u?=
 =?us-ascii?Q?iLbrE0+L2G47Oqe15PbxNmPH0pd2?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 19:13:58.1207
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cce1105b-2105-4689-16d1-08dc9b944a2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4369

We want all DML changes to be reviewed by Chaitanya or Jun. So, add an
entry for DML to MAINTAINERS.

Suggested-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7fec8ddb8d5b..d2fb60fee7e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -950,6 +950,13 @@ S:	Supported
 T:	git https://gitlab.freedesktop.org/agd5f/linux.git
 F:	drivers/gpu/drm/amd/display/
 
+AMD DISPLAY CORE - DML
+M:	Chaitanya Dhere <chaitanya.dhere@amd.com>
+M:	Jun Lei <jun.lei@amd.com>
+S:	Supported
+F:	drivers/gpu/drm/amd/display/dc/dml/
+F:	drivers/gpu/drm/amd/display/dc/dml2/
+
 AMD FAM15H PROCESSOR POWER MONITORING DRIVER
 M:	Huang Rui <ray.huang@amd.com>
 L:	linux-hwmon@vger.kernel.org
-- 
2.45.1


