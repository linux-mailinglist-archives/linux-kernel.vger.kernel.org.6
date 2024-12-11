Return-Path: <linux-kernel+bounces-441288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94ABD9ECC5C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81CFE1888EFF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79205239BB8;
	Wed, 11 Dec 2024 12:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VJByCOTI"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C66239BA0;
	Wed, 11 Dec 2024 12:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733920949; cv=fail; b=Jmr9P4a46l9Vm5XsECkPdEA5VymDcB+jTpqxEvuhUqo3oe5HMEHNphzMBrKJLXFUFVjGAerIB6S/lny8hB/skzeyTw0l/ic8mRddclOQncGDH1qj9ISSudHu5MjTMfQG7dIFOC4OHcJLC4icJYjpn+MuPJz4xRongZ/A69DZp2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733920949; c=relaxed/simple;
	bh=7ATunKjmzemt91ghMXZc7ULU10aX6uEWV0B9W1clk3g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fY5ojVrp2Sa+802YcytAZxvMo/cpKcxQwoKkWnjtFvl2px+AgqSu2lGpRZxpwdvY3cg9bfSDHJkhKVQ6t3p000I1L/8e+xGP6GMmHTLVDMarIADvAqE+fF2uvQDwyFQ7rt/ZIkzc7Be2ld/108SdwQjFjbSnOQgtL2+hz1ksu7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VJByCOTI; arc=fail smtp.client-ip=40.107.102.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cH1AIb+2k/5dy6AjHYz16qQFy4cyOElcM7hs5s9Hm4eFvCDwnlr0tQ0CufPNf7DAc6uOeytNneopoR11b2fU7cKKwMiFu+AYQ1HxtabZZ/EUHWkqmole/bfAPT1lI6kryg1ybYZHmiegEzFHUFU1nJLaCiUlwUVGtoLL2/SaIRocZ23fcR6cb934bf1Uazar5sIeqC3IQgNRY/LvQGd995GlT17ziSOSeXllFYnq64DHU+zl07eqpSGV583gUstJwWstI2Bmrj9btgFxjuCQu4v2a4E5cyyOv7hs+VtDBRyu/4zfoFTuliqLulMk0Q4bYL5mJcz52hVtQEGjqifWgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEfg+lySbHRHhIGWtFA5Z0NGYBFQY9W6kCB/vQHuUsI=;
 b=Ytdq/q8SU/vgSOvk4D2QrtCNs0C86CivqSDBhFQ6xmlkM25shUVk95rkYmcBVhZc5+qn2OhhEBXOv5omPNaB5LJgjCChFscigrTE/B9ccdKlhcedtqcBRjkCu4gJ110kQg0F6CjE/YWbKG5k2MUPm4HgUhR2yTc3zq4Jb0On+tBtugdc8/ONNvqdRn9NlE/Qmk0Xp0YSjv40cR/cIOMYXUT8dES3UEMzfKCAWsEESpYPTGtIS5LxLQgUr2wzckTji7YtCeQ3LvW+hZ5xuxy9zWxNx3B9Wf4puV7UPQw5LwshmOr2TD955IpRDTDMYVDef7exqrXFpU6tMSZwczyuKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEfg+lySbHRHhIGWtFA5Z0NGYBFQY9W6kCB/vQHuUsI=;
 b=VJByCOTIG4wDurLBFXAeDPcnzRtjL6H/x+L6smk/deqQO8WpJpvxqL5Nvn2Fk5a1Uybh0ug/YwQjMuwutr5Dr+BUhpGCKBkVfO/1nnIUiGXhTyTV9DpN/aAObxBQcUHTXhwaoJue5Ff4LZhh17HJB32kqfiI51KwVvHFwL5zaUs=
Received: from BN6PR17CA0045.namprd17.prod.outlook.com (2603:10b6:405:75::34)
 by IA0PR12MB7652.namprd12.prod.outlook.com (2603:10b6:208:434::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 12:42:22 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:405:75:cafe::94) by BN6PR17CA0045.outlook.office365.com
 (2603:10b6:405:75::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.14 via Frontend Transport; Wed,
 11 Dec 2024 12:42:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 12:42:22 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 06:42:19 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, "open list:OPEN FIRMWARE
 AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated
 list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 11/15] ARM: zynq: Rename i2c?-gpio to i2c?-gpio-grp
Date: Wed, 11 Dec 2024 13:41:30 +0100
Message-ID: <43b2f451bfd2ebce70f3ac6442586838d3e21951.1733920873.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733920873.git.michal.simek@amd.com>
References: <cover.1733920873.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=813; i=michal.simek@amd.com; h=from:subject:message-id; bh=7ATunKjmzemt91ghMXZc7ULU10aX6uEWV0B9W1clk3g=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvTIjtoV15lTb3hWOS3Kf1b4mz9v1a5te0U/Rh1lMHi1y obXUI69I5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEykM5lhfiRj5gqzrb8iX9oc WLSUkbtP9r4FP8OCBhXz7sPuZ4tcna7lrTir7jnjx9lUAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|IA0PR12MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: 19fd18d4-fe45-4eef-2d90-08dd19e14230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kW1y8t93EyOQbzA8ZF6eMhjB9VKJBqOxs3SbAILYi0amm+I8tdyzxaNTim+g?=
 =?us-ascii?Q?MtvIQPgX7LkRgTX/tUFPTu5d+H3iYr5THG8TNg4nMJRWQcdr64ZuGUlpoBzI?=
 =?us-ascii?Q?ortddi+UHWzzmHu1/K5YZpAxQmyxZcN2ycEaWufg8MJhkcyVpsPZEUeb5nDr?=
 =?us-ascii?Q?SaDP6Q2AbjJ7j2rtWlmnw65eiDgTvYYD3jAfV5EpV4Le8zh8KUmQFTEPNVUX?=
 =?us-ascii?Q?aQuIQRPf/3K+yRVq8bavA6IhHNB15cq0lS2s4dttyhyuBwjgISbGmv7L1l1o?=
 =?us-ascii?Q?YSb9J2q03WIA7Fg1Zf+XXGy514K5f4RSCNEh+XX8N+e/lbYfXr9diFOE0tbZ?=
 =?us-ascii?Q?2UdTWwNozrIbrMS/yCfSlymBLKHGq6W2YPaS48XvrqmBMn+0fVSCnZOmOkQ6?=
 =?us-ascii?Q?H5FLu692qrilGCEbTV1KswjIYCXF8ojfVWUuVDNkoZGojQUrjOGipnoDn1qt?=
 =?us-ascii?Q?GfOaz6QUOXspnx5FrpcpAMiL/6emBuFc+tyKJcENP84vciTfjPrbnFdlGzWt?=
 =?us-ascii?Q?2BwXm99+jnkZSBfoce4TAVjP7ga4yV8Hz0eyOEzcYZYEawtUnfBhz9I6XpZc?=
 =?us-ascii?Q?YLFrK2L3pGgdt9FrB/lGgKrlfRHVZ/yBrvBhL71oRKx5nlzySEvb4RZq7gIe?=
 =?us-ascii?Q?1f9Dy5wEKqf0FntL5vQzZBA5wVyNuCNxziHeRBnK83ralKGoLC4b8KFjmlqq?=
 =?us-ascii?Q?/kiM/fwl9PCCI1+EWGeTL7NGYu+kwOc2vkM0vJfkkzqanFbhBZg5qpvFTaUl?=
 =?us-ascii?Q?ryEKJil6l4S6aE1ZAqzQF6XnIpJd5APZoPelXdoyhBpKHfVpYkYSU0JGo+is?=
 =?us-ascii?Q?v4wxf/EqMyJK4et/VHlnKzbxpck68tChkKu93obN49MkQe8DxWVZgG+a0VTo?=
 =?us-ascii?Q?VFrcCa3eBbcLjAuDVQR/k8b6V01u+73PLLmrtMA6bFFHgwop9T60WfReNJ9f?=
 =?us-ascii?Q?hWDslzaJzJ8ZistuRCSjI7z16RH/wyR4+RKGupdLNH36uXX3k8x3h5Ge6aqb?=
 =?us-ascii?Q?IkFQo/HAfWOOd9Lx/LiG57u/OjJWFd1BxuXPTBKATyncUzduQ3FFJtTd1xoG?=
 =?us-ascii?Q?2d5CRQk7g0/eUggsari3WPfGm+QZCpqVj2mobShnvTKgRggPN7SFoWVze0e6?=
 =?us-ascii?Q?lBKP7I3apj2dM+rY7fD3cqa+OBW+h0puzfjZCH9Ql+mSA60ZSuqDDH5Jh1mv?=
 =?us-ascii?Q?s7EybHk/Bej2TKsA6sKg7BrUcM55wvstMm7XUPZ+O26XTMrDHybhHELOAIah?=
 =?us-ascii?Q?Wz8l0JwNME8VT02BuVg1SLbu2qWbHi7Hxyezcx1G/uOID2XR317fqISxHa5w?=
 =?us-ascii?Q?Oa27FXBOT2zx1PVAhkp57vFexzxNxonf5xtHVVMWLp+EMnKbI/IkaFuXe/YB?=
 =?us-ascii?Q?OKdVCwGrhmSxnsK/zz9XVVQpaNpkVvqGKpp2ULovH4q26NZdEyWI94AL5g4F?=
 =?us-ascii?Q?q70yVy5x1+i0wdSckahBfkuJbF6WkrgY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 12:42:22.4486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19fd18d4-fe45-4eef-2d90-08dd19e14230
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7652

Anything ending with gpio/gpios is taken as gpio phande/description which
is reported as the issue coming from gpio-consumer.yaml schema.
That's why rename the gpio suffix to gpio-grp to avoid name collision.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/boot/dts/xilinx/zynq-zc702.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/xilinx/zynq-zc702.dts b/arch/arm/boot/dts/xilinx/zynq-zc702.dts
index b5db97dd7192..e4c9491081f8 100644
--- a/arch/arm/boot/dts/xilinx/zynq-zc702.dts
+++ b/arch/arm/boot/dts/xilinx/zynq-zc702.dts
@@ -292,7 +292,7 @@ conf {
 		};
 	};
 
-	pinctrl_i2c0_gpio: i2c0-gpio {
+	pinctrl_i2c0_gpio: i2c0-gpio-grp {
 		mux {
 			groups = "gpio0_50_grp", "gpio0_51_grp";
 			function = "gpio0";
-- 
2.43.0


