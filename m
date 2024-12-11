Return-Path: <linux-kernel+bounces-441284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC689ECC52
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A55591631DD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3D2236915;
	Wed, 11 Dec 2024 12:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="edpe/ST4"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ECA229146;
	Wed, 11 Dec 2024 12:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733920936; cv=fail; b=ukN7Y4O53tiQziaivEbuOcqysyozcJi6cYU7qRoF/3A+rr5uMpHXIebwK1IhGGZCVc00JeALPLrBNBCn1Kw8K7wx/VyUuc0TypPCoPjcq5fgdL+ACVNrUPU6OYRrhOHcLtadjQY/LoR++qcYOaRR0H/w/HANYk5V+9j0kR70TNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733920936; c=relaxed/simple;
	bh=4/vrP59J09kHMXgyv2HJjVBHZRWZSQKTYNEFdQ/kCV0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rYu5Dx0VcnFIj3CcgWapxGzqdeK1n2lm8g5jPoSx8kjPb8jEp/HPpTY7xkLVOKQ7N2MrN5KcH1fGU8Pd58y9HPk1W5qSZCqZnT9pLYZ59Ss93lGkG28LGAcCwguDA4u0QvSt9l62iSMhnVgwEy6oBIPErLoIPieF0iyAmGMK5Gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=edpe/ST4; arc=fail smtp.client-ip=40.107.94.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PlxXXdYhmqISy4/V9a8eT4ku5+Jm7Nn9x8zkgbSbWkFHBMN+JlMdRK3Pm9HOtKjlBGt0RwLe9Z9MwpKlTWKqCQzTipoCR/N4BP+eIjIO1R54VJ6AiUYLgjlpeE/8/tSbstgf2AIit9JMbCOsQ9x1NsH4C1s4jgzulfN/4G4T6jioBPJf1dxkLWV5wKKHf15vQAY5EyLJqXz1FfsCDhuuFy9Or/Vitf0Ip9LKLiZVGJhhMOYUpyryYjGZwS89RP2a6xELYQJ3fUKIh3Qd1+Bo/+/0CdqlXYSd8iGSU5GqHEGec+2YR+tLzeWxJaIG73cKrc9oIhpRnwPyuc8lZa4kWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJWmuXlWZoDFIVA6RqJ0g4hT8uIa09kZPqIh8U19ZTo=;
 b=dYU7Qn6ALhZHW1UhztMJCEF9ToB/leErxMCkvPg2mhw/uyki5aJ/yBERFkKDc8EnqbvFJXZ9KsjjVKhWXDuuxGw+/EEsWT5H/ZX+8oDd6l3VnX7GHG22Q9RqKJIggkYgbddU9K39eDjdAl1t73GorExBYQ4Gn1lW9yfd0QKHtvqZnOyo6rnuxMqnu6UIPspGE3741HPS1R3PfRdzEY8Ggl5hxPYiscsLHO28RgvJNCF9pn0yNniv3A7gWcWj/T6bcpZXzHkyELpdVCfdII5Fu99OjXN6wmJiDvNcgMCGYvB4iw9q5deKEbrfNzUzHT5USTZH2TI9Q8Pbv8mmtow6lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJWmuXlWZoDFIVA6RqJ0g4hT8uIa09kZPqIh8U19ZTo=;
 b=edpe/ST4WHOGGlFgbq1hK7/BaCxR9bYTxmCMeAaO2vkGoU8TJZRv6GqmpRE07tsowYT9kRuZjWklZEVAccqLykl55qCV/2cG1EtRKgaOCJ1Gkz6VyGeRw7R3Qv7ndsFklojLomxCDB8GNxLERMTzHd9zp+oSS0FTRm9R91EXVws=
Received: from BN0PR03CA0019.namprd03.prod.outlook.com (2603:10b6:408:e6::24)
 by BL3PR12MB6426.namprd12.prod.outlook.com (2603:10b6:208:3b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Wed, 11 Dec
 2024 12:42:12 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:408:e6:cafe::b8) by BN0PR03CA0019.outlook.office365.com
 (2603:10b6:408:e6::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.22 via Frontend Transport; Wed,
 11 Dec 2024 12:42:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 12:42:12 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 06:42:08 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, "open list:OPEN FIRMWARE
 AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated
 list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 08/15] ARM: zynq: Define u-boot bootscrip addr via DT
Date: Wed, 11 Dec 2024 13:41:27 +0100
Message-ID: <9252bb464c5c82fda6018ea450c6f453a5d8412c.1733920873.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733920873.git.michal.simek@amd.com>
References: <cover.1733920873.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=870; i=michal.simek@amd.com; h=from:subject:message-id; bh=4/vrP59J09kHMXgyv2HJjVBHZRWZSQKTYNEFdQ/kCV0=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvTIjpqgJYYuk5T6JvOd3LVB2deb3feqU/gKJ4UdU9YK/ z9y7qFoRywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZhISyvD/KjcKKVbVw7bHz9u 7HbOZv4f8x8WcxnmWUvoGrPcSNtUtdDu18fJSXWrY4SyAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|BL3PR12MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: c37eb3b4-a684-4b72-be47-08dd19e13c29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pfAvdjLmD/lGrsHuAkxYGlXb1vTh2TfwANbPyF0a/PFwFP+j1vtbiNtncj2z?=
 =?us-ascii?Q?16RdZ0/z5so8kp9v4+YrtDRNeG4ezaQ+7L18QSmn7hw15Ix+2V3QiY+20DB3?=
 =?us-ascii?Q?usAqVCREANzHKqn6k1uK/9LDrEooBxB90TwEghILTS0wA+W5RyX8r0nuE+Ej?=
 =?us-ascii?Q?jn/FmeFm1BkBVvhoRORTQOJUikDpsJwq57+2ZKEqc3h6y2J7QO5J0mu3BiJK?=
 =?us-ascii?Q?lblb9Op7tZvyyqDMDe7yB5iPdDJX75d8pYA8f0ge0Iqj9Fjf/XiewVuaToAP?=
 =?us-ascii?Q?Ceg2F7gfS1JY0aOBM0lKsRvi+b/fSN0WYVrKdHjjFI6bNC99H6yzwGhhoMdk?=
 =?us-ascii?Q?dwnuvlI/7GCF0bHCJmwV6lKgv1Y/a/KRYXPTjb4gVncinNDdNDlAEdS+FLbw?=
 =?us-ascii?Q?nQjm6wx5nw4dZTl4CoGc8xPbBks8bw/ZcI1sSfDMyQpKIg/g1CNFfalBd+Oc?=
 =?us-ascii?Q?RHCk2+2NinRozcAWTx+D4IzEMJ7MIBKgd3AfswOCWBYzRRZtNX/buuXsy+ZZ?=
 =?us-ascii?Q?XfFNM5S+qgSQcJfiwC+1Q9VJzX+8Bm6NySmwktBsqRJGxTrpmgaEHXce6n6+?=
 =?us-ascii?Q?jh2CeUnerJRPzD2T+VfpGT7sOxjq6mNXMQ2+mL/PI+R0DD1f0tyZ+5f75oy3?=
 =?us-ascii?Q?j64WYBCm9sRhH37ToIWgwsMSMShgiwbr3fSSAzimgWaS0gET5wa4HRCs6RD0?=
 =?us-ascii?Q?QjKcuIpumFC3MkEWCLbgdyPMcTlmthvPnuti7qGZLSdcs5fpD+zb/yu5aV3j?=
 =?us-ascii?Q?YXOw1rNGx1IjxIeLMowswcZ+abBsVJgFLxsG7Qeq5do/8F2Fe6E8tgIFzEnZ?=
 =?us-ascii?Q?/jch1Yjjrzv+2zugY0XHM41VtZ56ViKEtqFRmLJALwcSS5lW0jmzphfDpmzg?=
 =?us-ascii?Q?5t4cD521U8g+Ps3kXAL9JhX+DVqp66xv4hDk6+Y6u+7cn9+nD/RV8KEJiHOk?=
 =?us-ascii?Q?zhTSAKCCy1lu6mbz3rKNW+lTE/Z9vHllVhGRiNBSeFJ7mrBmnL2eZNI09J51?=
 =?us-ascii?Q?mP9zjRFCkmF3JfkoeBkNQZK28FAvy4AtHNT8JSS7+2IJ5AYse0JCqNVRTVLm?=
 =?us-ascii?Q?m8elPe2ymohMbKdq5J+rRtTFFuBtuV9iH+GjtWJlRrGbXbbglQE7rZqF5Amk?=
 =?us-ascii?Q?jRYUNz2Yy35xGz86lwM/WT72XSksoTOiP50lXRqiGa5msjv9qxugw5UTURDZ?=
 =?us-ascii?Q?Z+paZ1wQtX96brUMu6ehkU7lkeR16X+fRB91IHIfjlMjagaFUrZ/sMm6XSgf?=
 =?us-ascii?Q?HzwMMPiB4SYkeuVVszpRfPjxvWUvzuL5jzFJn6RDXbQygq0i6AWgV/Y3PaRH?=
 =?us-ascii?Q?42JH0Y82KN+f8IO+b65fQzaPcR716R48fIdadhE5TwH/0ySj251kEBoDSxF1?=
 =?us-ascii?Q?F3bri9mwRZpu6wLtn/uBREyMlnqa0kr1lpWvj3OV9cSSbDuHPzETshUBDsWz?=
 =?us-ascii?Q?h+P+EDMSFOIJNL8v/aanS7xX+DXt0WlU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 12:42:12.3558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c37eb3b4-a684-4b72-be47-08dd19e13c29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6426

Define bootscript address in RAM via DT property. Adding default value to
common DTSI. Platform DT description can remove this property or rewrite
it.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

bootscr-address is documented in dt-schema already.
---
 arch/arm/boot/dts/xilinx/zynq-7000.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/xilinx/zynq-7000.dtsi b/arch/arm/boot/dts/xilinx/zynq-7000.dtsi
index 268647668db2..46182a5690b8 100644
--- a/arch/arm/boot/dts/xilinx/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/xilinx/zynq-7000.dtsi
@@ -8,6 +8,13 @@ / {
 	#size-cells = <1>;
 	compatible = "xlnx,zynq-7000";
 
+	options {
+		u-boot {
+			compatible = "u-boot,config";
+			bootscr-address = /bits/ 64 <0x3000000>;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.43.0


