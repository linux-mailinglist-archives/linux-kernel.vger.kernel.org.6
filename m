Return-Path: <linux-kernel+bounces-332491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECA397BA69
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 11:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9B9E282021
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 09:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A15717DFF3;
	Wed, 18 Sep 2024 09:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="4ZRtxD/I"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2078.outbound.protection.outlook.com [40.107.117.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FECD17C205;
	Wed, 18 Sep 2024 09:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726653295; cv=fail; b=cB/LRib1YULdhSBYje6VVuFuN4Y1AznIYtNi7wVp5v9O186mEPSqACFBTMp/LcYq/rMDZwgZFaGmjAkeU9W6dx05e3votaImq5ATKY7pBzy2UBU2VqmuIKMxoySbBzjp+6DNAh0urUyyLXzJRfm1c83jJbXqbqKTD8OvMGx9Vdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726653295; c=relaxed/simple;
	bh=X5QpbEBTjdRv2rUDY5Gex6uy/fBOR8NKkxQc88NIlkg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s6nsyo+J5pamKD6Y57Tm0zOkjYv8PKP9deOR97zIcvL695wBylezpdvpA9JM45JTg4FvMH/fsR1nTGWx/K3NxywPzBiTfp4z4jtfahEd8gxKUIz74qAcNXlFrjz/cdSEFKNnjZ0JPzpHPiPNY2RNmUv2B+GwWJA2FOce3ccN8mQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=4ZRtxD/I; arc=fail smtp.client-ip=40.107.117.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ptyGMVxvwPYreZf0rXMgs/9q6MLUhPoi34VbwT7ID9G+xBW+Uh6GttnrdBBwCHRIsy13BxSqNo/OzJCBDQLv3hX5YoNlkAd6E0EN4/9Mg2mWT22GNtkRvIiDJNL3TgoGysfXqDFN46TQCKCe6f4sayfdGZf4MjYflwD2NrEypYgBvAVVZdUJU6OPBqMVa7+RzcRPRYGLMnR3WrVx9B62NmwBi9JfASdoPaLgmOV3X6e62GOrUR34OXrbh1t7rub36pUkUlDjjScxZzLnSDoNiPiHQ2JCTd0BwPOTJEIE8zJ6Dplyd+ux0x3JUoSA8qVq2psnPIcXDc4MXfJKmOtLQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBdAsQdX8AH9FC/6zaDseouFX2rDXfeOyaJtjKcsayI=;
 b=kAwzdzcWcm3jfhoAYsgM9nsIFizpH9FzSrWAdk9YgIoO2d293VUQFceII7i8dXM5jnUdw6yM0oD+OhcikZVB2SH0oPthKgnRUl+tkmB4R1IuCts0gVQ7j6M/QsGntAA/IT6gBXYolvUPXqQdkEli5cfSNLQvbkiSrm++hhEAHulhVk+NzKDJfkS95gpbFKJCGqSj40UuGJgQ8/6fPnHx9EcnI62LzMjs8i2hXnxyAm+FkbbUaVdNLv7cBgYDaXx7uf05f5Oa2Y+DBKyPrLMkzf6NvrKBqKkFxhrJLA4h9nTSb5jO9CCr0VxkDhioywYmQ2Jywl852yPYEgOqi9ZVPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBdAsQdX8AH9FC/6zaDseouFX2rDXfeOyaJtjKcsayI=;
 b=4ZRtxD/IgBps7tDQ8tRiJo5Ee+rgks5PBvqE/QIqh5l/28257Ur5oUCsmhhprLa14DHz38s4cAu59j04b/1BF5/HMu8kRpqlOIKLxJFErbolfC1d04qNUk9FaZqqcsuZDIApcqk/f/o5rsQmltOJi79sDUB1P3xhbV79Pk0WMl99t3lZHhIw1OLHO8XFIKv/+u0hSm3wGKvMtLPv3biNE6uevawQSpdREFaw6MKf72j1CNWGxtYsnss3A+HcsoUhIvHCM55LbrpMcq2xHRtXQqpPzTNDRxGswGMX+LIjOJpuH60ISAcfyjSpO250yl79HuFlAtNN2ampg7LQ3PjtbA==
Received: from SG2PR01CA0123.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::27) by SEZPR04MB6369.apcprd04.prod.outlook.com
 (2603:1096:101:cd::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Wed, 18 Sep
 2024 09:54:47 +0000
Received: from SG1PEPF000082E4.apcprd02.prod.outlook.com
 (2603:1096:4:40:cafe::8a) by SG2PR01CA0123.outlook.office365.com
 (2603:1096:4:40::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.25 via Frontend
 Transport; Wed, 18 Sep 2024 09:54:46 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E4.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server id 15.20.7918.13 via Frontend Transport; Wed, 18 Sep 2024
 09:54:45 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>,
	Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Guenter Roeck <linux@roeck-us.net>,
	Noah Wang <noahwang.wang@outlook.com>,
	Peter Yin <peteryin.openbmc@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org
Subject: [PATCH v2 1/3] dt-bindings: trivial-devices: support pmbus compatible string
Date: Wed, 18 Sep 2024 17:54:34 +0800
Message-Id: <20240918095438.1345886-2-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240918095438.1345886-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240918095438.1345886-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E4:EE_|SEZPR04MB6369:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: feb08758-317b-40e3-df57-08dcd7c7edcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|82310400026|1800799024|376014|32650700017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Af712vtEwleV+ldPW3yQsJr/0B2SmN5RAsibtyFCZtn2weJuXTsA/yCpWNqx?=
 =?us-ascii?Q?vxdxiye11fMrAJV+5XSYwBTLK9MkQSIhoQHaWbjFSYNOkF1dXv65CxuJ8Smo?=
 =?us-ascii?Q?CiCiPxqeYloy7uvZ6+AkvxWc0RixXIfKjFhNWi/+X1CPnH8V7e9hbO3zQOeo?=
 =?us-ascii?Q?bTO02P6VtJ5DfWLApClcarrbuMhfzOUqi5euQ6HouyAqEqzky66wjP3QLWUg?=
 =?us-ascii?Q?/6XeIAbvjmMiAp0oab/z9asjQpw1N3pRCjWcQ3muKazOq2blJGzoZHT33qvb?=
 =?us-ascii?Q?OpPAEKXvMQYhO13lFLlWAJhGCvXChObp5wUZwrUrroJ1O1zIFw3UWqImdesk?=
 =?us-ascii?Q?mvGiGCgvKSPhpwvOLJZf1Nnob2RjwCltXuBVgSCxYgFuTTNzOQXYgQQffRZW?=
 =?us-ascii?Q?b6OhXnY5snyLYXNj5D2R1O1HUp/cWdEv46g20o61s1+kwIMBFRVGd4zdp1I7?=
 =?us-ascii?Q?mabG1Nu88u/BXKan3ZPX8MFoir+G/y1KHv84hTAcrM1xZt1d97nSzOyeC5hN?=
 =?us-ascii?Q?gyHxebtSsKSAewt4qHIyMH3kp/yud3oTujVAJmZCDNcjBdWDBi+cHacT0fIm?=
 =?us-ascii?Q?Um2rsRr7w2K3PSZ0EBEhqLsHn5CJ68CsZTAz5LHxIQ/CvcH8ZbfrpKA5+FJu?=
 =?us-ascii?Q?gzBKkpADPGURa+y0UElLk5qlD94GuiO5SDiJYoEwHTkIUjp5bsdmeO/l15YM?=
 =?us-ascii?Q?xyXXaoRiwdBF7XF5IT4/9GYwv6ihzpe+DErYwB2WCd3bvLQ8TYh50T0I6Brg?=
 =?us-ascii?Q?Pg7VzZpt2Y9eaes9ISlw+dbf1SV1kqV/G512DxFqtMg/AgWeH7RdIF/ZfRSH?=
 =?us-ascii?Q?NlaTA62Q7HLqquORfkBRulIEVylMp6SHsj+xsSNNHgSqy8TJHp6q1p6pDaRj?=
 =?us-ascii?Q?36wsQKHshp4xhS/lh2Vx4SM09I9EIqjRamDtWZGQ3nN9vlUSVm9IiR4uIy9e?=
 =?us-ascii?Q?Q6nJN0X86DnOq/rxNjlWAEm+U9cN7lpsR9q3HqJt2o9qIGecHGNM97QtA8bw?=
 =?us-ascii?Q?DUgVWKdPg0ewxrr0j/iBmIbx6Nd1A8wrdoRde/hLg6UVlzbQIo0yHA07hYmw?=
 =?us-ascii?Q?fz58TsjIIl+TuC4d/kQAcZUgq/llJ0tW0CmBBux/BCEFhj2v0pO/2UKLE6Gl?=
 =?us-ascii?Q?3C2AV2aKcVnr1yuH0NK5hGaNVAR4f0wehlTtkjQPyC353Pli2l+FUmwloGcQ?=
 =?us-ascii?Q?CwDOju7vpgQ7AAjxrOmPj4r5WUIPaM3//NblNegv/oZzVByxl8f3rcAXVzXz?=
 =?us-ascii?Q?2JpJ8ppPlFChpSzGK3eK8KuOtQFIHCZJGPPLTzx3T7JRw9wu6D9m4e8Cm/5D?=
 =?us-ascii?Q?xMmOmGD5wtiU1N+ZynjJP5QNnln4rOlm/eK3Aj/Y9imv+AeyIJ/l5l+A2drd?=
 =?us-ascii?Q?g5TjSZu3igu4jftSoAkwDLGBT6kgxrjNycjvkvlUAZdiv7OIu3zJ9u31uWCP?=
 =?us-ascii?Q?wvjQ8owC8eFHBQUERgZZjXgwAwCLRLoo?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(82310400026)(1800799024)(376014)(32650700017);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 09:54:45.7480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: feb08758-317b-40e3-df57-08dcd7c7edcb
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6369

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Add pmbus compatibale string for the Generic PMbus devices that could
be monitor by pmbus driver.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 8a9a00705b23..cbb9b94e5b3b 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -320,6 +320,8 @@ properties:
           - oki,ml86v7667
             # 48-Lane, 12-Port PCI Express Gen 2 (5.0 GT/s) Switch
           - plx,pex8648
+            # Generic PMBus devices
+          - pmbus
             # Pulsedlight LIDAR range-finding sensor
           - pulsedlight,lidar-lite-v2
             # Renesas HS3001 Temperature and Relative Humidity Sensors
-- 
2.25.1


