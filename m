Return-Path: <linux-kernel+bounces-568579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD08A697D4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C60C7AF357
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7641320A5F7;
	Wed, 19 Mar 2025 18:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ec0wjAhn"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2371D1DF98E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 18:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742408216; cv=fail; b=CRzTB1cYZu3cJ4pGPM0AUMLGYuBqMx3gqAf31zQg23YkVhqd/X4w3Nif3KWsJ/Gz9BsMWMahcrqkCT9tVaDDh6XUyrUmYZ6DBlVu9xE+0DpZmWXJhuq/5Ftwzz1p7VgRXDu7HoGuW3aSWZOrjBqTirb8JgdD2kJkMGhNAs1Zd3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742408216; c=relaxed/simple;
	bh=wsCEnzguNhEkXB/428+wkvt4vw8XrY/282NJ3TqQ/2E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=llycVpIBj+5MW5Uegr5mxsmIh6rJpWb+n273x/kzX+cmm6VsHBHUZ9hi5asJImzcnctaaQ3Tb4nbuDJEvbcQ7wD+3geWtD+p9ukJViBxW99Wnjdpb7fy7+x53NAcgccm5EvhJo4U7g/rK5wPonrKFRAaR8/UKAPDDPts55AqPXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ec0wjAhn; arc=fail smtp.client-ip=40.107.236.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GelVuWJuj43czGtRbLQsoTnD2Uu1BXD4zbjqWHtcLAmGaQOMgYA9B56UYE7FAEQBsXktHQAKNuarPrCERm9kmv+sbPnPPrqpbRjC76DKId2khPKmQaacUWDtEQvSEI1h/HkssO6S8F9RrmF3EMQM8OlGeE87Q1pKQBnEO8uPpXgPZzCO7vOYzSbcB0xlRXP8i7AQ5okGurFyicx+SBz+L3Rb463whKWaArW+fi1NelcI+oWLNzUXDN8MoycrYSqdm65Xcenjg7P1CLcpL3LWdqxEirw8lVWiD5CT3TTOrB8E2i5dFf2gFMaFcXZmuW6CVJkNDODN0axT8OH2lwPV3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SuI0T/rePseVBfncDnahvv/rTpljh1DUVgjvxv4ftGs=;
 b=ZH+tZlj8t+z7QxM645Xtf/NrtK0m8q1hZTYQPssZNYFdmBRDvu3POszYpWIZf8Yqq8YdMPXSf2+yf07YAY3VQHduXjOBXnySdCGl9S8PhGP135OWXl5BFKsjA2EjR9jlgAqX8d70qZyPLELAe1L7A1HatSmwGX9JxahT8uI0cGRH0qB4mkO7yWd0Qcwqnq3gHBD87a58zIXSzFmKYWmSBSPNsJ143hyDg3SViSfRto2A6SR82g8GBxvW1NNzLrESmGxWpizVLQAx8/Q+a/UxRWypZ5gC5BOwQSOpueKVXBQgzekESoWqboAevP16/0oL3SNF4Q8fl98g1iPvNIxuFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=alien8.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuI0T/rePseVBfncDnahvv/rTpljh1DUVgjvxv4ftGs=;
 b=Ec0wjAhnMEhXKqZzpjtC0pZCztnMHZynKpCPdelBHbq+CB6LVt76hLTiKqJF08Tn9Muyu8gJGvxa0DlRM/iCqWCXfL2RALPLm9dia/Ah52Zybb2fBwJFMqMfHE3IG2l68zpue+Ta0vFGnUlm8LxHRiGMYKdYFWW1dOQ9V1J6dlIEOK/aD5sUsSii3MWJFqvyWpnfBnqrbfRPfF94Zwb5dZjoiYs+wxZbyPSqw33rvUAVZ05ySwU1ixRnHVj1UJ8cL7xz2VqJBEmUCuHYNDjKn+mVx3dCUKJQlLE6y8XqZkGliUlcs99hxzbn2y7A4H2gPsL866GN8V1P8SJ2OfehEQ==
Received: from DM6PR02CA0118.namprd02.prod.outlook.com (2603:10b6:5:1b4::20)
 by SJ0PR12MB8167.namprd12.prod.outlook.com (2603:10b6:a03:4e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 18:16:50 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:5:1b4:cafe::f8) by DM6PR02CA0118.outlook.office365.com
 (2603:10b6:5:1b4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Wed,
 19 Mar 2025 18:16:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 18:16:49 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Mar
 2025 11:16:35 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 19 Mar
 2025 11:16:35 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 19
 Mar 2025 11:16:34 -0700
From: David Thompson <davthompson@nvidia.com>
To: <bp@alien8.de>, <linux-kernel@vger.kernel.org>
CC: <shravankr@nvidia.com>, David Thompson <davthompson@nvidia.com>
Subject: [PATCH] MAINTAINERS: add secondary maintainer for bluefield_edac driver
Date: Wed, 19 Mar 2025 14:16:30 -0400
Message-ID: <20250319181630.2673-1-davthompson@nvidia.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|SJ0PR12MB8167:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f977d2f-cc68-4fc6-aa48-08dd6712376f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iNDI9T3YZYmSQsslyujg4mmsUT92NAGnskTHR6T2BCk68SvWvQYDGAFWUvFq?=
 =?us-ascii?Q?dj8mdK9XPaQiTcIgMa1o5We+czREHMK24dhip6pTkmjPoXY2BrngcqbSi0M9?=
 =?us-ascii?Q?OA8Q4pmRuxk3rcsMx4qKud5xYsOSzbUpJMUSGWDWrmi8w3A5Ob/Hc+Xp5JqV?=
 =?us-ascii?Q?eXKd1ihWE+uSlBOLBrfBhpJGI8xud/zkzqutAn3JwSV+XAmVHsVYn6Rubin0?=
 =?us-ascii?Q?gueoaLbOeG+EkXjTIb+/HNbFp8eqLNVB+bABEVRYC+Y0LVHS1VJ2V7Jl9iSy?=
 =?us-ascii?Q?cA7v3QfRnrPjOwswml7oyKa91+qi8Rg+vXh3IHkRQnpkNuuOCXWTTmYoEMZO?=
 =?us-ascii?Q?5QF3DJW4aBC0Nsv3p3uh/CuwEyyeUa7xCXiNTmvzSnXm8SvkWcWjj+urgsHA?=
 =?us-ascii?Q?qdu+51u59nWrjIVIdaPb9ybzDDEQmAjbl9G1d6oTKyzPKlqVB7wmD9C/G3oG?=
 =?us-ascii?Q?W77wYBblrp6qiWwjySGcuDMil7hL/SowbYi5keMDFzoSwahZlKQ6dHqFrpni?=
 =?us-ascii?Q?M4x/VehDb4ikhaHIeCEswMGe18HGYsYxdAJK75Ejnm7sojBlkwfxZZgN1cUJ?=
 =?us-ascii?Q?txUtmb4z6U7+6oLKfgXdQgXHeIs2BQQqN6/WVaUxdcPvE/2fNVc/bqzX33Ij?=
 =?us-ascii?Q?MSfpOiK3sEoss233wbYe3eg5Za/EWipTJTVNe/JW07NyrI6w7hYGV20e5MR7?=
 =?us-ascii?Q?MtWlncu4YjY19QzMQdGuCFwaABt3EuZ534EmLKE/dp/gXv/XyQwg+wMdLMeo?=
 =?us-ascii?Q?8+zkipeN6GWnjldF1ePe5nLO6zjqX3QTSbMaM7yJSI+OlO78RoSQE9rzchYj?=
 =?us-ascii?Q?KwjKLxvxqA1Mrd6zfX0tOh3zVNRGxgvY+Tl4jybOnrU+fLS3n83cs4bFnHKI?=
 =?us-ascii?Q?Llro1tP5LN7xuqxhmWbZUOV8/OJ61Ttg2wWtH/RBxZUNVIsir+iAIfokqn3h?=
 =?us-ascii?Q?Xfk6Hn4ukPksYDd55IHdbB9an3EZM4aI99/v/ejafzE78dWGpHhDtdlLN4YL?=
 =?us-ascii?Q?Dh3jd4TW6Nj2rMs+cAvp5KfmSd2x7TI6WPRbh9vQ7nQIpu7JdgJ+crZHlcNn?=
 =?us-ascii?Q?83WLrsl2QqS+7MljugxeuU7MV9+yy5kiqdzJ3MvBEh5WbS+agI799XR2kFQZ?=
 =?us-ascii?Q?dwhWyzkq1+PCUII8fkVjJI1wv7xb7rPpwBRI/zuqGt6EcR1tMDV4FlG4CJsU?=
 =?us-ascii?Q?NEcOPCUIVb2mV6h32P6uhF4xtyWASnLETlrM16T/MAtUl6H/n9GmMr14XOwD?=
 =?us-ascii?Q?STeqo81/t2Pb/xKLpBNO3wZmmjia7QUJJPJ/SvwrqlfRD4JQVnoRMmhz40LX?=
 =?us-ascii?Q?OhjQxD5GAcluV/VMKxYlbiFA4quWCQyBGrwmBn9a4oekoVpmZ2oW9fStl8wQ?=
 =?us-ascii?Q?Y9j80nThCcOpChpNfE9S9sKSaWa1EMwl5Kqzy1fgULzG9+ZnLyhE+/nENXkv?=
 =?us-ascii?Q?4ltkudrCMLIho7eDFa+mxGhp+UgSJPIMr8w3vgfGNemyIHeRiop+sK7weFOM?=
 =?us-ascii?Q?yvQaWrn3NqKhGMc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 18:16:49.2521
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f977d2f-cc68-4fc6-aa48-08dd6712376f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8167

Add a new line to bluefield_edac driver's section of MAINTAINERS
file, providing secondary maintainer's name and contact information.

Signed-off-by: David Thompson <davthompson@nvidia.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index efee40ea589f..570411b580ad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8214,6 +8214,7 @@ F:	drivers/edac/aspeed_edac.c
 
 EDAC-BLUEFIELD
 M:	Shravan Kumar Ramani <shravankr@nvidia.com>
+M:	David Thompson <davthompson@nvidia.com>
 S:	Supported
 F:	drivers/edac/bluefield_edac.c
 
-- 
2.30.1


