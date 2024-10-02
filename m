Return-Path: <linux-kernel+bounces-347120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EA598CE1F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C9942819CF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 07:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B661946B1;
	Wed,  2 Oct 2024 07:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WIf+8lNl"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2049.outbound.protection.outlook.com [40.107.101.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921D6D517;
	Wed,  2 Oct 2024 07:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727855488; cv=fail; b=QKnXDKciQBwCLyjVuEXA7oKKVkBjt3571lrOm/l+LQEGK0dviTs/t0RBoHfA4uL8oB86Xc7p1hyL3ItvjsWaQBOp8DMuHvu5cKDgAMrjb30Nx41pTjnoFP4nKMX1QDOXgd1AvfjLUySmGqml4batnwhRCiWGBN8/D+aVdvLSzSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727855488; c=relaxed/simple;
	bh=7EaE/CvvU/cFgsjgpD7l4dfeEsy2AeLpeXsx7WCChWE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gnEnz4CBu3jRLembtbs+Q9sv2mLOYX3m73XT41agTjZl3JlpohMz3uNG+BRggLAUiVbMnyR7InrW8ehyiUu/h/yHipiwc1zh4WgoPw9FX3v9gCE2AdEIPb5Xlyn8uEDu6Gf6rieJrUZoDQJa1gO7wpMvA45PuT3M/DSG5fbrJGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WIf+8lNl; arc=fail smtp.client-ip=40.107.101.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GK+rJSt+uiRSubx4blh5P20omKesfzkQrepXnX59sFWUy+ggUX7vhpHd9RBMliEGdoxF8jmXPbC31mieT0nDsCMIRU0ZDPrZayjn3xiJ74n4fS5pcRtfHsNc0z0j8Xzhit1jC0ZXB+L2x1CfZrz16eaB7R2yX1eLA113GY1TOxnrW1Fb4b7ikDzjjA3kNxwxq12UL/IBJwH67eYoVbiXu+UI0NnrViKLjSAi2/NVECa178gZ6BpcC4bndQPIpox8jSbMAdZSCNxFw/KCIHvmdH7wFka+Zmb0fXHmGlN5B65Kyy/mPMFLINKaCgiOuOciMn/Mse4a5Qmq2Wj9eJXWxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vsZgWQe7gol7KfAmv3Pk9owuFCnQdEicb9rWHMxfqm8=;
 b=Rlcb1FHRGSdZGCalTPwlyNwsXUwY6LelvFDzG+SJcGz51hwNGzHV5ZqD4+qsdA2EYR6OHJg2rSr29K3rKvH3nqK51+nc5GBVBtLfRsYZJMZUifSi5bZfOa0RkANbNVlV4vPI/xrMUl+beQQiiE1vE8ZYEBlQO8zSlN25Xl5H2C2BwE8YfxLg5mtFndUWCpbtKCJBiJ9VzdMpH6glPY5ceujRchLSMwjWGqHdH55OL6p/4nhchvo8BRA8kW9PqT7TpvDwlAg/t/baXXH1BaB5NxMH1E/wWueOYD1SFhwlB7QdL9MilhtWNl38DS2k9YQ8toxu8J1QPD2ltRipG39iLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsZgWQe7gol7KfAmv3Pk9owuFCnQdEicb9rWHMxfqm8=;
 b=WIf+8lNlVABJKhMBbwkxWmc7zwSaneYrgVnNYlkvk6xPd03S9nkcLNbROo4K0eX8qBc07UeSEbpe8JBDa91ZFqTGbnCt+3kloi1OvJ1ADKZ0Eh83ZScEZIi2HCGH/lJCS0zcyoIs2kdS+oYdtzJqGm5RcjJcNqXQU7ygQSNyMEg=
Received: from BN9PR03CA0177.namprd03.prod.outlook.com (2603:10b6:408:f4::32)
 by SJ2PR12MB8737.namprd12.prod.outlook.com (2603:10b6:a03:545::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 07:51:23 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:408:f4:cafe::88) by BN9PR03CA0177.outlook.office365.com
 (2603:10b6:408:f4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Wed, 2 Oct 2024 07:51:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Wed, 2 Oct 2024 07:51:23 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Oct
 2024 02:51:19 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>, Conor Dooley
	<conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Michael
 Turquette" <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, "Stephen
 Boyd" <sboyd@kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE
 BINDINGS" <devicetree@vger.kernel.org>, "open list:COMMON CLK FRAMEWORK"
	<linux-clk@vger.kernel.org>
Subject: [PATCH] dt-bindings: clock: si5351: Make compatible string required property
Date: Wed, 2 Oct 2024 09:51:07 +0200
Message-ID: <b4b626c85ef3f75a0de936c818b2fff389e92c6d.1727855465.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=675; i=michal.simek@amd.com; h=from:subject:message-id; bh=7EaE/CvvU/cFgsjgpD7l4dfeEsy2AeLpeXsx7WCChWE=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrQ/vwuvTv/86F5E0v+rxr0Tl81+6cLLZvLpbvvcCXrz2 b45imlUdMSyMAgyMciKKbJI21w5s7dyxhThi4flYOawMoEMYeDiFICJLDrGMIfv5wuRx1NXbPKW 9rufYXsxbFXqYjmGBbOkJsyT+slSqPXyuGTw3ey0+Ue7CgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|SJ2PR12MB8737:EE_
X-MS-Office365-Filtering-Correlation-Id: f3f1127a-e470-42af-12bd-08dce2b702a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FLeQBTYbHHtI+wXsJvfaiTNn2udgl13NgJKUPFXUfxnBNkxrGtGN3gCfLdoN?=
 =?us-ascii?Q?ZWMHtjUfgmHgBKUnYxledjE7OV+mQjKyNff7tHJURUnh4SzQDxdGx4IDFMmc?=
 =?us-ascii?Q?m3rXP+gI0dxSQf8VqUut/RLBUWpeztYfPvwwAfY74E3TLnJoqqX5mFlKSpZM?=
 =?us-ascii?Q?8IlFkZ8YSSGVZWqMMrVT3rYYnSg/4cdRDgaACltfHufhky3KhmOIR3AZq59l?=
 =?us-ascii?Q?DFNbuWzRMZcosDHHHGiQiZkKRa8+ou0D+NS/y9TOKo2a0vznllTgLLg4UQ4J?=
 =?us-ascii?Q?HpsXBMEy/dneDdTWjVIB7jpok6e9B5drizwafJIx7+aZiDx/n8CTmf/ukPZy?=
 =?us-ascii?Q?E5DmeG3Vc1rz++IkgnlDWYehP1zim5zpXu0+jNpJCQoh/oZwcfwW8BgE/xgm?=
 =?us-ascii?Q?v5KhmrwnsOZKmU1S9PmYC9Ce7EvQlFbed5QPPTqarE+/Kc/iVwO1bziZ5Xnc?=
 =?us-ascii?Q?zRgpX/KOD5I2aaFnezSPxUSvg+eT39jNczX78uWunXzDE6KP6plwau7e/Z2Y?=
 =?us-ascii?Q?7zoxuV34uBEG1bvSaEZj4eAztKcc5KAmEpIcVp7jeVY2ogLJvd/WNqLoJyMV?=
 =?us-ascii?Q?oQ+VRvJgcBEGt07sRhBve4TdDUrrQHbdjZ/AtRpCFwX6rbYDdppNdgI7o+Ov?=
 =?us-ascii?Q?GPhuj8iHRqmZLld+MEHrXNNV6nKEUNUtB0i5D6fbouwQpO7+dqgWVgBSvuND?=
 =?us-ascii?Q?IqTJI+qkPrZ/jZf5dT1k4Soqy9ndpi/ZmTmxWyS5Fh0hCHvTwnD70yRWjh4z?=
 =?us-ascii?Q?keixdmFNnL4XPKvFMMMFQ+yBilmWLvSq5qLPcA47ensDG2xxf7kxC8CxYty1?=
 =?us-ascii?Q?ler5QV946rn+FrkX21jd7TIbTWuhpEhVxbHJ+dNItCQtIjY7lpNLsEyB76R4?=
 =?us-ascii?Q?3EJZ9QkF/uN0trT8Q6UsJJn9oxuJKcgyMS4HfBXN6hMtXwEil2G/WPDSQEXm?=
 =?us-ascii?Q?0uS5rWyRP0/rfqXpFMejahdHLYV2q2dgpQTH5TLAYeKW52MYjLOHwSdSbrNs?=
 =?us-ascii?Q?Wt7nsTQQuSn0+2l2OxR6N3OqjweW1xIBc2vM9rHtSo7j8TWbDm5W/a2/Rm7T?=
 =?us-ascii?Q?D3O6gVFqU0CzFM0D9/+vOWHxxn9L5VZHpbqqxRRggwnJctGSibSyJEEudYIe?=
 =?us-ascii?Q?gjSt+szMyU5RAztVSKg1uhbw7nakNG3ebQ9gBkilpy+giy43wNi3qknx7SsA?=
 =?us-ascii?Q?qzW5bGM78s5c2eK2FP3AX9STqTeyRAU2qW2pl4fQbI0Kzp7Egi411VeO+mJs?=
 =?us-ascii?Q?w2mETAKe2pJTiNq36dsN5rY7OGmf5ZFMZhx7ZCU85WcxdVFN54e49kf9fnSh?=
 =?us-ascii?Q?pPOQ8uM7T5weeX5L78rR0E14ZQd+CAAaLIBvC/4U4YDdmjSmOnAhEpudvpCN?=
 =?us-ascii?Q?p0xPg3djptmXNA4A8lMK2r7bSHd1?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 07:51:23.0080
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f1127a-e470-42af-12bd-08dce2b702a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8737

Compatible property is likely also required property.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 Documentation/devicetree/bindings/clock/silabs,si5351.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/silabs,si5351.yaml b/Documentation/devicetree/bindings/clock/silabs,si5351.yaml
index d3e0ec29993b..3442400715d0 100644
--- a/Documentation/devicetree/bindings/clock/silabs,si5351.yaml
+++ b/Documentation/devicetree/bindings/clock/silabs,si5351.yaml
@@ -187,6 +187,7 @@ allOf:
           maxItems: 1
 
 required:
+  - compatible
   - reg
   - "#address-cells"
   - "#size-cells"
-- 
2.43.0


