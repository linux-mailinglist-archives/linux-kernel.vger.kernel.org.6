Return-Path: <linux-kernel+bounces-190269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 546988CFC3C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D89521F22F0D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B36130482;
	Mon, 27 May 2024 08:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e42BB/8s"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC2369953;
	Mon, 27 May 2024 08:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716800044; cv=fail; b=FbiHtrylZKggG1fWd0ppemT5KpuAe7js1yNxV4ligv4bEvMC4sRZSjtbwj8GiZbtNcAQo/5Xngel8umP4yB4Gt7BXBqy0ws2QCWRdTQ0M98N9tGpB2fBbmiUPZ9X8lpzAnzSVlvhMQraDdELywqzNn9L9R+Oc7AhjbpnDkwmzD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716800044; c=relaxed/simple;
	bh=gFofoEZ8QAhzdFT7ARyCb7CBuv/Q/YorY6ZCpVjYI2g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KBPjh6w1LMozTc16I5fK3kUn90aUouil2nWI6/c+AlfCUp+9gv5YvVGPg+7MSsFIaGRepvYMn2IJxtcZiF2B1Lb1/JvrnxgJhKWO7+CwOi9jtD8MeLkWziQxB87nCi7LPV5l7Y/iLxk0zf/B/NanyaScHx4p8pjP9w+6ht2ndYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e42BB/8s; arc=fail smtp.client-ip=40.107.236.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXBIJhn6mIJB8SzCuq6UEW7xm4wQ23bpGJ5MwXAd6HELYtnc8WB+SYsddbE+TeaIflhV/+VW8i9vHXuzykZh6RbtOrReghTKLBxDox82XhxDieadKISl4j8OTxYx2odJjaY16uYejou2xeJ1f/+zZ76dmUZeFEFFThEw1z3mvzOhPEaXBiGc9mwgHhz3rrEBZPZVywdXK8Gm/0KHzSsguQbLnx69xfWh7mWuI8FX1bdTkIjIFmYQCffP9znaIwFZ3HFkV2b2bFwGIEQNDsOOzyv2PRcTRwbYbdicwc1+u8Ipl3YpgHzGwWS6lZJSHR1DpCQrfiOZWrlNqV2FDCbiTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=beWWMYxrLH3vPvywfuo2sJ7NsrSn6NeYmDTteSrmONA=;
 b=P+NX9ouGPlFi5Lznvz6pdTzmCpR+jIo74jnD/jw9Y3XZCYdfdVFhjSiqJIATx3BpRuT2q+9Bej18Wr53Icx8bIb223S7rDr2evWCiwwmlsNVG70XMbbc/5PScJRC129CRa6b9jLZoQ7zzG4LieCu3t5F1lrxbiEF2swtUPf/uG2y8yvTN0ZMCRtx19GNhhtHqGlA8Or+97MO+4YOTJICca0aa84q9ObTcS72x5W/RhE+FkgDru9mYX1ltkzo5ajBatkhP4H5jeql2QDOFa6RGZ44zLu7mQGBeQwt1Dh1KcTD874/oTDAMfEi/MAhiva3krS6vZh2fg1gtOtJZ2P+6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beWWMYxrLH3vPvywfuo2sJ7NsrSn6NeYmDTteSrmONA=;
 b=e42BB/8sqDO7KwPEGwwp7s2pjcqAnwX64G4nrErPPUGnkYdRqfsgGYcKi5r3lx4TrngRb/R6uf7DSsZL0xMoy2asjklnQnfHuSsta6qIJAmn4Tqt8veyH4bzkfEIhJO7aiRhTcZh8Eynt2jcum3Q9JHOUD3nd17kG2u+v6iwi3Y=
Received: from BL0PR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:2d::40)
 by SJ1PR12MB6242.namprd12.prod.outlook.com (2603:10b6:a03:457::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 08:53:57 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:2d:cafe::d0) by BL0PR03CA0027.outlook.office365.com
 (2603:10b6:208:2d::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29 via Frontend
 Transport; Mon, 27 May 2024 08:53:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 27 May 2024 08:53:57 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 27 May
 2024 03:53:55 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Kalyani Akula <kalyani.akula@amd.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, "Praveen Teja
 Kundanala" <praveen.teja.kundanala@amd.com>, Rob Herring <robh@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, "open list:OPEN
 FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] dt-bindings: nvmem: Use soc-nvmem node name instead of nvmem
Date: Mon, 27 May 2024 10:53:50 +0200
Message-ID: <42c21f3bcd75f821061d047730dbbcd40233e256.1716800023.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1037; i=michal.simek@amd.com; h=from:subject:message-id; bh=gFofoEZ8QAhzdFT7ARyCb7CBuv/Q/YorY6ZCpVjYI2g=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrQQL3HzOrO+wv3Pi67PrJfME3284Ijts23J89jzIvuLp jJaKV7uiGVhEGRikBVTZJG2uXJmb+WMKcIXD8vBzGFlAhnCwMUpABNhu8Qwz0Qy+kaJJ0+rxadX 2YHP5Q+lfzB+zDBP9bqac2D450bNdevn7V+es3HxJ7+fAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|SJ1PR12MB6242:EE_
X-MS-Office365-Filtering-Correlation-Id: a1c61917-95a6-42da-28bc-08dc7e2a8b51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?99Ox0hx+om2LKrVQcgM1pGK6E9lZhj/nyPCtxDzoljPA5nhGIZXxguQsuss6?=
 =?us-ascii?Q?ImryiX7gNuYZOcVQVHTAgxGwcQFzTQxNz9fGhcd8yyEyDGVWLyOPh1F2l6zn?=
 =?us-ascii?Q?HAS6W3nr4+F56qy/gAkxWA0YLy+j/kOjSbKbbYxlo8fxIfSFRX06dKpAM7ZS?=
 =?us-ascii?Q?l1KO4Yjbs9mJfwtAqngbZviKivXODLqLVniAV5XBePwCf5yl88GsjhIIV230?=
 =?us-ascii?Q?MEAFjtybmiVBuJQG18sNMCiW92pmmDIM18caB+JYEukjXYzI3BeIrJne18Dh?=
 =?us-ascii?Q?hnc76Ef2hwmR5JqXsuKsjh8xurg6PTkUpSe/kynU9ICJDPO6gD8aRQLg4jx0?=
 =?us-ascii?Q?hrp5u4qyG5AoupAnLzZWvFJpFg4Bq2qNNGlYyLf6rQYdDFcbOAvUUwwzlojT?=
 =?us-ascii?Q?Gd5uljukf+n1VLC5wP0BxW7XOYEl6+hb0hFyBlLzAhLVmMaK/HAOLM3OAwwj?=
 =?us-ascii?Q?J2Ewyxa+795GHaPQcc15ijXZ37Wm7x05dhjfD5R1GSi9NQN7dGnXseed7dnK?=
 =?us-ascii?Q?ISRQOqCDwLaMJjRBWuQCo3rPRc5ggNmA/D9F+P/uvsKaxXx3MFrqRAeSQFC5?=
 =?us-ascii?Q?Ieix5M0FO8rbBek25sfHwRi8hF4cPU4IRT1y6ogl1f6WhwSXE6jKby0u/5Ha?=
 =?us-ascii?Q?E2/SJiiehcrWx2s976bdgxE+0pZOFdTb233yFTbsZBbvMZguGyGQHm3rHKFr?=
 =?us-ascii?Q?RIZ7UbOJcGh2AtiRBTvBYhdCRNA2qCRePc23wG1yTMs/WsGm5Nl1CMosPar5?=
 =?us-ascii?Q?t/1PwE5eFlllQmDcVW0VOLdeJosthbMYjx3d2H/+G3mTScoA19iMns5P8xgS?=
 =?us-ascii?Q?uJvQtwclbpipe0RYVp2Ic/q41UO6f6M3ws5vgww/9EJv/jhbBU2unC+04Jmd?=
 =?us-ascii?Q?T7u4GtXHHgC33vZ41MKZp/pPYyrWdUrudigyLeh5vq8bEfZ0y/s/V5+KQweu?=
 =?us-ascii?Q?MiOs/wkkFqClP67QF95YR10438aNNDGMzEPlrHW5dAJyXbGntAzccC0fg7WP?=
 =?us-ascii?Q?gOfmh9kAIYAfwKvZxAWyFr9sAXSTDv2iflXY6R92UxcmGGBjSHlJRnEnwVNt?=
 =?us-ascii?Q?Cy0uEfLcNBQMdhjvxy26iqzF5G3HekEUAuS2hbaCdySXum4GXGmCZY+8K4U7?=
 =?us-ascii?Q?/YDqyRXBfDGKSN6cjbv5Cp7wpX/psK6X/eVQrgyxSY+AjDhngt2CM5E8BlbG?=
 =?us-ascii?Q?PPKLTPhh7d3xjfcnQc5aFUv1SPQl0zYknxh2MbJB++OLxMNqgWwkqFnCsbWH?=
 =?us-ascii?Q?eQuPGhVg5zJakXBkpz+AsehGZOkBN46mF2KhvO7cSqKTNQzOXhT2d1y2Ly5g?=
 =?us-ascii?Q?xdovSIRRKOh39ASmW5Ztx39OOOgWGGNe40gGY4Vk2cm4u6chxtjf6b+/ASnJ?=
 =?us-ascii?Q?vYvEiBMxV17PsuX0ylv1jA//FDj/?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 08:53:57.0377
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c61917-95a6-42da-28bc-08dc7e2a8b51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6242

Based on commit d8764d347bd7 ("dt-bindings: firmware: xilinx: Describe
soc-nvmem subnode") soc-nvmem should be used instead of simple nvmem that's
why also update example to have it described correctly everywhere.

Fixes: a0cfd5e99782 ("dt-bindings: nvmem: Convert xlnx,zynqmp-nvmem.txt to yaml")
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml
index 917c40d5c382..1cbe44ab23b1 100644
--- a/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml
@@ -28,7 +28,7 @@ unevaluatedProperties: false
 
 examples:
   - |
-    nvmem {
+    soc-nvmem {
         compatible = "xlnx,zynqmp-nvmem-fw";
         nvmem-layout {
             compatible = "fixed-layout";
-- 
2.40.1


