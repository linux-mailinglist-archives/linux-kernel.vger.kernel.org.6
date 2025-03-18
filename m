Return-Path: <linux-kernel+bounces-566691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B63AAA67B52
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D72373BED9B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2A1212B13;
	Tue, 18 Mar 2025 17:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W1NzH48c"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CDA1917FB;
	Tue, 18 Mar 2025 17:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742320077; cv=fail; b=WLgkKnp1EMIfhWqfqy8wUjCSjj9p1Cfaru2CvuNucdoQM+P0HZxwBalV8lrLVU/XU4ZXx9q1mBwWVqPJToUIY0aMvPnftbZ1ruhIslIdEC/UPSZ76oFyWUusX1UFBz9qE3iclzbZEB049tqH1TIBNZta7e3xZwEXPWSiuszHp60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742320077; c=relaxed/simple;
	bh=yBl/mmg9WjZ2Wy8rmqC/swM/e6Hsw6FqasoZyyhiIBA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gJgTd1Tr5O3mqKU3891d8KcLOUGJmb6VgzvlTQusu5ocUhhYCkF7Y3oAp1jKUZ6VSJE7jUGyzumElahX6kNzMoGS2Z2u5VVmoQWK8NmawYQCTnKiV8SPEmFWSBEC3IzfQN37U48eMthyVwcAaiBq7+5nTiStDan+hVhMk7jwYBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W1NzH48c; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TbU3oGqyaKCCIy4hyhSFLVijSH5lu+U0YVfU4Q40iB7soSQNBCJhwfqwDzPRQOjwz4iNBsEZEzhWZ5fNGjRb3ayrOxjWl/od95OsMRtPPi6DZlFM9UhpB9gz+qEuFIRdIC9g4ay7PakBGhkmZViHUSk6NjC5APKFU3xj1jdEQSLSYBlySCJyANNBdnL26oLT/vF557ic3eCDWedGnd7z9JaaIYgBzaWX+vJ9jl7NtJH4zYH/rMCuHfsDr5XKwlFcgPAalsqbEQrxj9VfcSRbfT1vauv4W2EVwBXLp5h8FdT8bofZO89DBqas9DOQNIRweOAJzg1gwfVb5F6iOm13FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TX84Y6pPK9YOw1FeEOyRUN9cFVqfhBUGf9QAX8ddxMs=;
 b=CzCfAdX+vqpZvOfv55/iU8I5JHa3cZiqf8ik+7Hi7OIkDiC6ImZInZT1jorG9HjivxokdRflkwh+nQOzDu/Ff5a80HnVSpTWjtx9U/NEq35uNWrNp/q1c/5sL2GRkJ7MMMboAwwSQjkChlFIrA0SyXuy8t2X2lYsoecM+Cvee8Qhnp3hPlM7v38v1lcXoDKAv5Zaqo02M+yaHKTuSFTLZ5EtOLU4GI1I4d7r83L+R36hZnzEJnb1ljG+/CyTXdnmQnX7Uq1dsZE46aevj9H+1aTZj19figESSqRjR1tEHetPW31fWmpTlY5JLIRPOBLnyZNjBXl2PYswnd0jXHvVew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TX84Y6pPK9YOw1FeEOyRUN9cFVqfhBUGf9QAX8ddxMs=;
 b=W1NzH48crAhb/SpK/THEwrUvF8tPWDO6mr++E1Kb5wuUCSFMDHkScMCCYNbfLwPJdkkqDh1aPZdYWxYTt8XEaZ38S+5+MM5ITWCpttvKJgZe1gXEoV1lIPPc6CK1ieDFFKyahzQ6LLrg5oZ/MkG0KyD+Qsb+GhI4XoT7vgtdkjg=
Received: from BN0PR10CA0001.namprd10.prod.outlook.com (2603:10b6:408:143::31)
 by CH2PR12MB4247.namprd12.prod.outlook.com (2603:10b6:610:7c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 17:47:52 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:408:143:cafe::a8) by BN0PR10CA0001.outlook.office365.com
 (2603:10b6:408:143::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Tue,
 18 Mar 2025 17:47:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 17:47:51 +0000
Received: from BMCDEV-TH5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Mar
 2025 12:47:49 -0500
From: Rajaganesh Rathinasabapathi <Rajaganesh.Rathinasabapathi@amd.com>
To: <devicetree@vger.kernel.org>, <openbmc@lists.ozlabs.org>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>
CC: <robh+dt@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <jothayot@amd.com>, "Rajaganesh
 Rathinasabapathi" <Rajaganesh.Rathinasabapathi@amd.com>
Subject: [PATCH v4 1/2] dt-bindings: arm: aspeed: Add AMD Onyx BMC compatible
Date: Tue, 18 Mar 2025 12:47:29 -0500
Message-ID: <20250318174730.1921983-1-Rajaganesh.Rathinasabapathi@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|CH2PR12MB4247:EE_
X-MS-Office365-Filtering-Correlation-Id: e9067c53-8719-410e-4de0-08dd66450156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fol6UWQYmiRAACopbzDVWFb20ElCV05C0TkT+dw9KMZhfXYQAmhSJY8Jdmww?=
 =?us-ascii?Q?w2hcBKoMkvfpCjS2CYSrXirE7HuqwgfQK14vFXAXQlqGRD0c0dv5z1g+3iTS?=
 =?us-ascii?Q?3P+VOW9pj3xEF0OeHxKbto3z30BPz7y1JjDwst8Dv9JhRhCHJ+s5zBnUTxA+?=
 =?us-ascii?Q?5drA6i2DZU/4xl4zXU3b/7VDlDtBbxBH72dgpoeREQGOx0dxP52lGPThRYK0?=
 =?us-ascii?Q?0D+MLS0RXj2DdqQaCsDyLL3Iqb4F/pgdz9YSzAQ4LeavfAUYlpNDbngjutCH?=
 =?us-ascii?Q?R/k03GbQinY2ZlOPxknDEbgswC3E44cF3CnGQhPegfOtqnPgOZdJHA3ZzK4i?=
 =?us-ascii?Q?EO/qKykCyEphq0hUmn0VazZj4vuonVBKAopgDFR26HAHv68LOXkvJVJHT/6t?=
 =?us-ascii?Q?BTybFJEiQUoUuRIelnmdJ+be1p8Vv6zvIx1BqgRLg46xhg8RDEg8PXvWRiHH?=
 =?us-ascii?Q?15YNyakvaxEJuBYIAqj0/YkiZ9jqwL/Q9cElA5sFV5R/AlNpJy/fY3v8Z2z2?=
 =?us-ascii?Q?VQdOhl1TDK7H6d4GjmUHjc0JkTWtuU/Zp1J1y/IJuMOFNgSMrw2W3pc6EiWJ?=
 =?us-ascii?Q?gXhxHFaYihUwhN/87zgO0/6Pvje1LjnEmI9ihjGCKbj4/IU4xXu4LZ2UfCjV?=
 =?us-ascii?Q?23l1sIjvGjNs7BIQVTkLqe+3R5f+l3vjfghux0ZW5NI6+anhrQiUmwVI1IYi?=
 =?us-ascii?Q?0tJhg12pj39oAAmW3xn3+OocVcz43cVoohVBDVZlvzDaUq+Cijf40R+vQnhX?=
 =?us-ascii?Q?m03nxigf2cXjs10M1aonJakHos+oQvY8gvMKoogrICNtsudGsDNuekWu8p3J?=
 =?us-ascii?Q?bkyN7tsCm2Z49WMkgG908QIc1sdWRg0AZlMtO0z2VFWAa/e9+NNBYDz/8zUN?=
 =?us-ascii?Q?DSaUG9SZESRJrjkYFoQ1BkGDaR8ut5rO9gCU/fPP4lJLt1L/3kk6o+yBf2vB?=
 =?us-ascii?Q?2F7RJD6gXg9G50CnXorr6hNQfdQqY9oI2hl5XkG3XBmGB8AvDwoslFN5+ljv?=
 =?us-ascii?Q?VgIp7Ij2J89isBaAsaoi3nTJ57aGOSLp9yCfizvaBlapjCXKJecsn0Vds0x0?=
 =?us-ascii?Q?V3g67Zj1s1Ytn+Uq8cjNu/7BlP9eu8VGqQPHWsLp2O2HsKX49GTh47oExc9b?=
 =?us-ascii?Q?9DOwRSy3c7TubVnlW7jRmLsarElKjoFcbzMAkbTUjc8TIksW0i5hSk7Ibe8N?=
 =?us-ascii?Q?KWVcN6dyOXDaXTSdraTKQOGEfbmh0952D7jSiiEtq7qLcDEApi1G6wFGcISp?=
 =?us-ascii?Q?6KdEZfjf1D/fPf2ZbfTESKW/QjrwJmBVH8JZNwwm22anpqOJiHoCRMIaZnGa?=
 =?us-ascii?Q?DYWEQnrltC1dG/i15f75EHu9qf1MMjuFf21/iVIV04gg+DQRha1PVOt5o9fW?=
 =?us-ascii?Q?rizrAtcoaDRgfqwOKr22xGgtrp+BG8iGnDlVA+J8j7XpavZFGorHUU9VqX65?=
 =?us-ascii?Q?RcFtpDVslHI7BJdG+OcULwTOc1pSuRa5ZCfJ1i1xT1rSvrXZ3gBzvUorySkq?=
 =?us-ascii?Q?qZQH6yU6UrTpeUE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 17:47:51.7219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9067c53-8719-410e-4de0-08dd66450156
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4247

Document new AMD Onyx BMC board compatibles

Signed-off-by: Rajaganesh Rathinasabapathi <Rajaganesh.Rathinasabapathi@amd.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 01333ac111fb..98f92c16e342 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -74,6 +74,7 @@ properties:
       - description: AST2600 based boards
         items:
           - enum:
+              - amd,onyx-bmc
               - ampere,mtjefferson-bmc
               - ampere,mtmitchell-bmc
               - aspeed,ast2600-evb
-- 
2.34.1


