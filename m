Return-Path: <linux-kernel+bounces-528360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5C5A416E2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD4A1892F25
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8951188704;
	Mon, 24 Feb 2025 08:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J7OTVnOZ"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7900619E97C;
	Mon, 24 Feb 2025 08:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740384412; cv=fail; b=fR8o1wCMwSEGaQ/WBA1idCb5HJHFqEecds7TKOS1Nh6873sT47yAUI6cP8PfCnC9WM0XDggmX1KCoRjBOMa3CDZyNpqAWaeTawAf7WPLxHAGospEMlrtwsppM/2xy1fpfw35hwE6YgeOpwQc1t9d2PMZ6Qqal08T7TN854mG6bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740384412; c=relaxed/simple;
	bh=Q44NUnc5oJDYwLuWRoNee0ZteCoZidFhrqzDdEWTELc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qDckT0hHEZZdSRouBkF8WlB3x/T2dRl3q3kxvYIvwoXa+tj58ERB503OJmP31xcRH1lZVSZRqPwANXt+XYv/xcW7X787cyD6Qn6K8f6DcLjV1lo2aY55qOOEg1Axbn3/dfc85OAhZ/PdqMm338G2uGa0AdqsYgG3fr9lSO9McpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J7OTVnOZ; arc=fail smtp.client-ip=40.107.244.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bapASHq+uBO2H2VHhygK+UY5AsSCUD77ZXwnPGp+43L6EvSmh/7/kpXn/faXkKBxAHHlndKJKLru4WUlRNjmNORrz+SAZf+fd/VbzJdFZQ5VQZ9o2tmVW5tH0pLA9AnK2JhZ7ZYqNdmmxtBXZpd4vrW6IKrbLulTP2iImFY9qFCJsQ+gUrZjILozoWPLV9gUzbchOz2HvDfUd37kBuZjh6kkgp4Kpnf9meFZPh+mZTNFx3hC+yWHzjHpyKiC/vfzNs7bN9t3UM6iOFyyPRZ2zCqDT0Cl9tISoEODkFawX0cK6/HMBBSCNjpfuIKQgETHCw9IwgNvp2pKqp8htW9Sqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KtV8VHakkYD/FfumiXPdyNKepNkVIAIZNIo036dEbFU=;
 b=X5SrlJ4XSxwJkRIygBuHl0csTR8Ht3xmFAu3PeUJbrBQzyYL3yTAYLmcvMcO6jilodLgaUL0BlsNzj3IO61RP3zKD+X8OLOBHINYk8xqH1NpgaiZ4BZOCzJv3hrHl8TNL4WGZ5zR4/eeDk1JZjKhOcGDxg+XsaWm0wOofBLspS86c65QjM8pSU9fnhtZUGahBqyn89rhmr+8tHN1mP0Q4mGP7o6GoGe93kOJgFM7u/Ec4WzhhOyKzGFHLIkX4j0JwYlMm69XpS1aL/qPG/96Tu+jOs75P3xFSeKX4UPWvLz3lkKN2nq2R8XoY7MJq53NBKYnrehbpP6iUaU24w0HCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KtV8VHakkYD/FfumiXPdyNKepNkVIAIZNIo036dEbFU=;
 b=J7OTVnOZ9/YEptvMK65DFJ3MQ73sKbOlTi0Ju6o5xgYYbBs/KjJu1NUCLBWtU93p8NybGdoBhG1Ijdx66UX9R8Eym2N4BzQ/3txZqIHn5Q3UIx+BAqyhTIgsEJnmHebX1YlpjRFYzxGT6Pr9rMoRcOZo9F3tg3yIz+G9bwvdK7M=
Received: from MW4PR04CA0353.namprd04.prod.outlook.com (2603:10b6:303:8a::28)
 by DS7PR12MB8275.namprd12.prod.outlook.com (2603:10b6:8:ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 08:06:41 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:303:8a:cafe::83) by MW4PR04CA0353.outlook.office365.com
 (2603:10b6:303:8a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.17 via Frontend Transport; Mon,
 24 Feb 2025 08:06:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Mon, 24 Feb 2025 08:06:41 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 02:06:34 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Jonathan Stroud <jonathan.stroud@amd.com>, Conor Dooley
	<conor+dt@kernel.org>, Guenter Roeck <linux@roeck-us.net>, Jean Delvare
	<jdelvare@suse.com>, Jim Wright <wrightj@linux.vnet.ibm.com>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "open list:HARDWARE MONITORING"
	<linux-hwmon@vger.kernel.org>
Subject: [PATCH] dt-bindings: hwmon: Add UCD90320 gpio description
Date: Mon, 24 Feb 2025 09:06:26 +0100
Message-ID: <662a050f3f8160fe7c80d4f19e45eb4fac0f2f0a.1740384385.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=968; i=michal.simek@amd.com; h=from:subject:message-id; bh=Cqy+UOr3MclhATq1eoXL0CL4GCaKyJTr6O784flF4F4=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvQ9Gi1NPRmP8/RerOb9EfHCeENCxxmtC98eP/u0Zz/f6 2eZUlvXdMSyMAgyMciKKbJI21w5s7dyxhThi4flYOawMoEMYeDiFICJMOUzzM/yfGQse/ipYO5D TrvK7fEJ3h0P7zHMD/l2OOCbdPS1KX75zVE1zBzNLBMkAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|DS7PR12MB8275:EE_
X-MS-Office365-Filtering-Correlation-Id: dfc62ae2-7f9f-4e31-81e4-08dd54aa2bc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H/Q7g+qk10DOjlgFP48HXUfhzkwQVrCWDfFOLxvtLNulqlwRAvR0WyBMtUhK?=
 =?us-ascii?Q?o/VliwgRDelqQRqT9UNNz/U5B2xMmANIn+QktgfYekZItLR8XIIBjtRrtUhr?=
 =?us-ascii?Q?9keQm3W+VHry6aRabGzbW02J75GS6q3v9WkHwO48fc+qKY9aZYclXwU+3BvC?=
 =?us-ascii?Q?sEmE5GQVY0Uc+7llBCMVfyA7VisRQEOo23jHvflLxHd2HZdzL/LTWlll0qce?=
 =?us-ascii?Q?0JRk430wHZ7U8HPdcRqYvdTkp18g5ZfRNjDvOsWbHc4TKjbz7/WZLm8fKjrG?=
 =?us-ascii?Q?N/MiTx9YljlBBnp4qZTX/V8+wCT+G6U5aFAG5FTKQx4KDorKFaDEKTD8iHG1?=
 =?us-ascii?Q?mfwVedzWxCdOi+T/cNi+Q4xwG7UOuS7dnmFr6/FJcu4LYaqaSKAyWljTQ+OD?=
 =?us-ascii?Q?syNwftoEG7bzx2og/xYv8KMTkGLcqKN7NmQtB24DudVb3515xg5hgoi+Udtj?=
 =?us-ascii?Q?t3fcvuaL4vNHo9uAu/83sErYV5IXBzSeuuLk63+BAxxJ2iu2tVFttycmCv6L?=
 =?us-ascii?Q?5UAGiF2F7Q2fLBGKi2qpDovl31P8Z6AJkNg376uiw0Gmz7PZhr2+rcl8KanG?=
 =?us-ascii?Q?MYcGtYTZaOzsKdEVPHgVgB7B3rf+Gh+tg0eUdhpleFucHk6OcWBkAM2zi5RN?=
 =?us-ascii?Q?vVLWXZ/8zqdaXxX+ff8YQADyTk/KbHrR4e8HQZ/3h5eNPErk5HcRtYRMGz3j?=
 =?us-ascii?Q?oyqwM1X2kfp+htfD+YP2Pww6IRaZhlhRPemtmHxMbbhZJwhg1NlE7Pa/qbnO?=
 =?us-ascii?Q?K659MM+255ZbAw8DdE5ZQeFWfuroBEc3ilfHGPRlnd4Z24m6vQlRz9pVjhet?=
 =?us-ascii?Q?sDSN9k2elvrLp/GekdzyBZYG9Re64dNyrdn+YhKhfRMRlofTFvGuax+uZsvC?=
 =?us-ascii?Q?1vEMqv1ese9SJ7FcfUspUCYDIIuRcvoWlD5RFVlKWsyN52yuqdZVQL+W03Z4?=
 =?us-ascii?Q?TyLNHYKBHsvlElzWIIwuO7e8Nl14Aslwgv2IAVFarh3A/D5Xe2/q4waTe0j5?=
 =?us-ascii?Q?pMDW12pDTUl5U+xQEuGBXdwbFlc0drePWIawgdkA9zUG1rYH0FpNW3jZPNRS?=
 =?us-ascii?Q?QJMR7/2AdWeiWWBVsd/ouxyf3T27tKRXz2OFZVMKE4x/5BcsJsH88gbbUx8E?=
 =?us-ascii?Q?XAWOS+LuyLi55gQguq19UuWreI3HCkXFQQJPnPWkLOx3qtzJZ6JV7vlltMtG?=
 =?us-ascii?Q?5DLoQqMinjvfsw4JGuo6DiPw4jNPh2p+LbWJCECm6i0KuI/ZBsPvC/oBA3kE?=
 =?us-ascii?Q?thzZQmjEziqheJzK43qIWvSd9V34o3qY16ZpJ9IA4TzWsL50wUMZeoIxguMU?=
 =?us-ascii?Q?nMLOeS3kOxfzEybjZqdXB/jLNBL8HAq6Ua+1TDDXn4IDXUsXUS5YrFzUy1Fn?=
 =?us-ascii?Q?IaPgxGPIiSk+DPRW89D5qjm83aZPaPhmpecWQXDFxq9sDrZEJeQERgLnWR5F?=
 =?us-ascii?Q?pmPm9u4l4j2aCHCMHEJMZ7qGt2hpjtVoTrR+1uwtUbPdZ7bzaAFfiWZvllTA?=
 =?us-ascii?Q?A2PdDXbCsTWuzrA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 08:06:41.0388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc62ae2-7f9f-4e31-81e4-08dd54aa2bc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8275

From: Jonathan Stroud <jonathan.stroud@amd.com>

Add optional gpio device tree bindings to the UCD90320.
The binding's description is already mentioning the number of GPIOs but
without actual gpio controller description.

Signed-off-by: Jonathan Stroud <jonathan.stroud@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 .../devicetree/bindings/hwmon/pmbus/ti,ucd90320.yaml     | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/ti,ucd90320.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/ti,ucd90320.yaml
index e8feee38c76c..f8bea1c0e94a 100644
--- a/Documentation/devicetree/bindings/hwmon/pmbus/ti,ucd90320.yaml
+++ b/Documentation/devicetree/bindings/hwmon/pmbus/ti,ucd90320.yaml
@@ -28,6 +28,15 @@ properties:
   reg:
     maxItems: 1
 
+  gpio-controller: true
+
+  gpio-line-names:
+    minItems: 84
+    maxItems: 84
+
+  '#gpio-cells':
+    const: 1
+
 required:
   - compatible
   - reg
-- 
2.43.0


