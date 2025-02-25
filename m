Return-Path: <linux-kernel+bounces-531480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1E2A44102
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2ADA7A5588
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B95269831;
	Tue, 25 Feb 2025 13:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EXHxZaR2"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154B0207DE0;
	Tue, 25 Feb 2025 13:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740490681; cv=fail; b=F2rvRCRK8k7CxicgCaHVXnLub3nGhm/H+IvQH2hg5Q+CNAS5yDHKTrp0n8Eh4p7nSv28zL3xBeuKIZzDb0WW9OKw7+AA9JVqDHGoysRy+LyhKDfeopo2jWQi9zrYZZlOF3DWFdHuOwXoVyiUFL3RxUh3rR8xUwbr6Y4aPkgObv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740490681; c=relaxed/simple;
	bh=3IUrWQr/jI3fXddHP0WC5o6voDcF2dnKqw/6IrWjcBU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LuTiYg/pXNLvXxBnaaAwXHEUeMZqsbSbDpmaPrlayuPwRp8cW4bXqrYPrZGeemzsama+2/I14muYnVnZgRAVTqAbsDRb5sih5h229TTgwCG7XOZKB6f9QrWZIgI0YIS2PzDngqqb3OLoqChYwGxxePF9iYd9rZtrWhBxutmvQck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EXHxZaR2; arc=fail smtp.client-ip=40.107.223.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a3EhWaZm8onhZBEYtD4PcoEvPEcQLjtSpAFSB7VoBwOBBdbIerXVZ8/WvzXzUG9tMbn31NEX7LL9+kY/fV6zmMEpDXyzadU9TLm5/05j18sZQrKOI3GjhJGp98czaKRKYCP54UWzjP2vAWEutTKLrtg1vk8Y9D2D2DEJJsoozF03Ys72qC/RUqU6g+zEp/MusMIss405/XEvQGkg6l/iG2OTHiop0h4cmm8qIUdXPAK+au3x1VxvphGvxOfEdE2a5JeZukpIJq1l9F62rMv21f5g27U/rdu44eCQM6q02raGHNMJINM03RPBeX3WS0tR3F1TYjGLjDMex/Z52nCfpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/60BFhklz65Ca2jcVhNQtMgRNApcO+5AKqMnud5ujk=;
 b=vCE/knLioyjF1c6VhMXmSKei0SkP8dygDtbnuigfv2g0P2+l9drOy0XBnuGnEn0z/T80+G3PY/WKJMrr5zib9fTGOY1xBR78We5DY9mYWwJwOrbo2rr6qUYa8kGm6P8qXV5njbaP91w/rIyo6OlMtR2Ca7qvojykzxdzd9EdJXS/G2xTJ6P8oAwDRAe4cvwQhkHF9wsQREZDWu5dPZXa9pLzkGzH6amsGhAZEh1rkzjRE5f+d1EnIhlPTjoztDlcPZJrG1S7WFP/KPp2750rBugGMfE3MJH8ml3Pmf6qoCBtTUHAORcZBg5T1J64RPB5NtKcxqQcZHTiNCnQ14n8yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/60BFhklz65Ca2jcVhNQtMgRNApcO+5AKqMnud5ujk=;
 b=EXHxZaR2L8/WLvKH96v8TQuobWJqJJbYcAniLUI1LublzMZScvejO85zouomTabILsOuqa+pzspqKREI1lgi2njID1A4Q0S+ka1A2ZQDmAvq0wyb4sl/xCZreyxKU7nKJ/WN5x/6zpyFEh4+5xluW7bt/3I9JbAtiqSYk6l1Gpg=
Received: from SN7PR18CA0014.namprd18.prod.outlook.com (2603:10b6:806:f3::26)
 by BL1PR12MB5779.namprd12.prod.outlook.com (2603:10b6:208:392::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 13:37:57 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:f3:cafe::3d) by SN7PR18CA0014.outlook.office365.com
 (2603:10b6:806:f3::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Tue,
 25 Feb 2025 13:37:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 13:37:56 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 07:37:52 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>, Conor Dooley
	<conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring
	<robh@kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE
 BINDINGS" <devicetree@vger.kernel.org>, "moderated list:I3C SUBSYSTEM"
	<linux-i3c@lists.infradead.org>
Subject: [PATCH] dt-bindings: i3c: dw: Add power-domains
Date: Tue, 25 Feb 2025 14:37:48 +0100
Message-ID: <fb8adcd318b1023ca6b90d294e46ae3b59dc1280.1740490666.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=691; i=michal.simek@amd.com; h=from:subject:message-id; bh=3IUrWQr/jI3fXddHP0WC5o6voDcF2dnKqw/6IrWjcBU=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvS9x9eplXa9dd265+mzbzcdVKYe3vynZ8k3+a7lDT9Fe Nv5Uye97YhlYRBkYpAVU2SRtrlyZm/ljCnCFw/LwcxhZQIZwsDFKQATmXGWYa7Yi1Q9hz8JD37s Nwso+cVWtFZd0p9hnlVs5xzJUr7VBRzPZx08PHHuFNusdwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|BL1PR12MB5779:EE_
X-MS-Office365-Filtering-Correlation-Id: bcfb374b-ff44-457d-848f-08dd55a19c9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uu5PajTlt44rufW1pvwrPnSphFUUAIvMU34i6JG5qVvew8NpM2ZS3+IOsPCJ?=
 =?us-ascii?Q?ArtIJIA4WyXp5/JhqmOH8aiI987UUxEgfC3RAnEhn6YjIGGb5GDKsFn6LK+c?=
 =?us-ascii?Q?nvzIKsomolCdEuw6whKRcJIjC1Ee2/kXzikP2WVewPKbhgLOEi/2vIyoqJZS?=
 =?us-ascii?Q?3L/FnkC9k/5DfI44eV2BudzMhhJ92cZgiJNQLNYj6Ig57C9FW8d9DwW3jg3X?=
 =?us-ascii?Q?kxrHFQ/ZvZwdUrczccuqkD/zjhVdc8DLq2zLK4grFYI5amezBejQshfh8Zj1?=
 =?us-ascii?Q?O8Zv415uzLpfPIXhe1qecTnwPATgrSbAHxNgGPtVx0BF8v6ITEVipS5bboyV?=
 =?us-ascii?Q?GvGpyp/u1yq7op2yujsTnTtYKWMSEOITjV4MqqFyBd1q6gEamvfycyfV3BYm?=
 =?us-ascii?Q?Yo2RP6mPvF+s97iZF/T2xLQZXC1CDcrA1TfYDx7SCYlSLcbJ4iT4hhTiTwI0?=
 =?us-ascii?Q?vCaxhUVr30SIKotkuWT9N4o/k0xmeMJDbw811NHj3GtJxUTDjz/i3z0lqoAZ?=
 =?us-ascii?Q?cP5hdPtNsvtoyaU0V/uagepFLh94cbGFARmLNkcU1Q+924hFsF1N9Cm+UNJ1?=
 =?us-ascii?Q?etOlWoL6dz4aoCDfiKBn7YWTV3KCHyaZopUer0WcqzTJmwf0Cq6CqMA3D68l?=
 =?us-ascii?Q?I4AWNpPD9ljR4BRhxb+BOiATBnyKBm+OuNvu9QDGsC3chdQCgTWbgL7Ptvbl?=
 =?us-ascii?Q?3LImUJCmtbgIH4Z560/a0mz3eJuOKBP7CMGYGHvlov0WeUU0zjt24L1CRpmV?=
 =?us-ascii?Q?xCveKk3ynOsoe5ArLi+tq+Zm30rx0Lz6ZFdMmDzdTF8xJMbJHGa1Fhez5BBm?=
 =?us-ascii?Q?xfU9l/XIIJMPIQR6sJJuTbzqmGntl//9bESzoNhJaG2GvZPzuxJxnPENlfnr?=
 =?us-ascii?Q?eMunsVfIJXkitv98egYl9kN/WzilQnEsSMss7JwVcI05aRl5a8gQvOqRhuuF?=
 =?us-ascii?Q?ljJtIR7JISy2dxMNcLdQnhCnFDBbMTn5Hl88XvthYIrC+mNiWpQIqJ5Jiwvz?=
 =?us-ascii?Q?Z10Pl5sLSzm2YElmFuacubLsyRisDWVKhYetHfOPs9NgXMgfVgVqjUqeSNOJ?=
 =?us-ascii?Q?PFpOz9sZifB3AawFfBhhlYoXcXlPR2Vl0nqJGRK96qfmhHzPj/6h1B4R1kmx?=
 =?us-ascii?Q?/QOX/CRyDLi2IDfoTXu+oiH+jbNPharvEHkn37/qrae2H2JLYFVobQ1gUPzM?=
 =?us-ascii?Q?q2uuCqSNMyYZrXJOYBRtfBQJldzJ7mh+JoBQHSS6HWYH2xl90KGLB6VgamVX?=
 =?us-ascii?Q?JBv9Pvg7GApokaX6mDen8jZj91wwpLi2x7Nr1JnAzFXF+LSgzw7CDf6sAc/+?=
 =?us-ascii?Q?uvLO2MAL8qbNXAyb2Uh05OkbSWYGVRwaPtWDZiXfAZgBYAADDhdyyz+87Kgd?=
 =?us-ascii?Q?iKD+lSebCSpcqaZKbCfxf53FDwqdWQ0lyx0U/Uv3GMFzRuX/vUREatHx102b?=
 =?us-ascii?Q?opMupjeA3cqw8MQIC0VYqhUp8jlE1CokYpeG78eM1gY7OJLTFLfTKg7TlySa?=
 =?us-ascii?Q?ql5klvl0f17FG04=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 13:37:56.1205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcfb374b-ff44-457d-848f-08dd55a19c9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5779

Describe optional power-domains property.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
index 4fc13e3c0f75..5f6467375811 100644
--- a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
+++ b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
@@ -34,6 +34,9 @@ properties:
   interrupts:
     maxItems: 1
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.43.0


