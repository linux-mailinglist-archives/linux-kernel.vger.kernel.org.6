Return-Path: <linux-kernel+bounces-538312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F252A49702
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 504CF1669AF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1F425F978;
	Fri, 28 Feb 2025 10:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="ZesIhxBs"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2119.outbound.protection.outlook.com [40.107.21.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D8725DB0A;
	Fri, 28 Feb 2025 10:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737924; cv=fail; b=rAmI6rSzdA/Lwe8h6gnA459gwSQaJ3Z1YAjjhZZJ6CesfMKsJXoSNjKQMHOReDC9+qOYqJXWfHU9QOga+D2HhzEsjEVYL6wSX11CbFtis+1fluV4IjpPZYaUTeXQ0+WB6KJ9Wj7P7MWkVUB15SADUiuDSou7DVSxBf+Pf9CRU78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737924; c=relaxed/simple;
	bh=/3uO7kd6hz/jYB2M/VE9cSVBC0wdVfjdMxzjJDE4Yr4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K7fL68rf3JrEhdJr6DRC4YkAiLhK6kf6sQwf746VLwkHdFss4eUilq5biop32y1Ii2lRKR/NlRw7HgFIeLbAPZwxxwGaTQh8oqTrhR+rmJyYY2ABU8nDSvOsPY9+TEj/EaswSHEmqZ0t9p0dR1yotWKuOc+wHmgHXlw8sSp3Db4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=ZesIhxBs; arc=fail smtp.client-ip=40.107.21.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bt1ZQymonHZzNLeDenDbZ/ZPiM0+udvMG+TqZPDTxIBHpz/Wk/phqQqzplVqEK5D0EYeWyCYECZL+ZjN+MsROLd/U9EpVngciwnFnqeQezp0VdOTbYt+PukjpnIfP9UNNnwI1DLjbHm7tnzrP6PtbAfntMEbsvfSKHZxmHx8abfbuYpmL0R5n2pazUkYHQZueBAXZVVVQ/vObC7miWgu8WcWNsE8mNA3mpXT4O8jw/b91xAIBSsCzuHLQgXZANBEmWUYk9UPShbA9HXjcHfEJsDD/YZz4OeIVfMhfYqt8akFezThu+/pSjiZEWmTGTRoBfVLZWkm/R/HA+7qBLlGWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6p+kyfX4mJUQ0rC3K61w3i/PRBFGOELkOVP9mDqb/wM=;
 b=b7guEUuS9m2gI6cxNnSxd737kxW72QZkYz8PkV51YltEJ6EkHh5YRvxTy7J7uMrDyAHcV9AezRhPqm7ZlHMO9G8F0jwf4LxVO8V0o2iFsyNwOr5yBy1GTZ/YX49D6mT6EatoB7yex8DP1UAz/ko02AsWoTKE5SJZ51WkJja052SRXsyjyq1VESCdH+GFTnLfSYvB9W693Lgp9OFSZ+0Iy+biCwEgiJzAe04NNvTrMZpbKGCsNnkB5Qiikr6Yi5c/58C5LIif7EyOV7hGQJKETFa/5oKBb+qokzsHEBF5u4YWpWyd1xRMARm9zJwKRPMgw+/dsaAN9L31yMhEh2Jz4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=ti.com smtp.mailfrom=phytec.de; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine header.from=phytec.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6p+kyfX4mJUQ0rC3K61w3i/PRBFGOELkOVP9mDqb/wM=;
 b=ZesIhxBsxec9NDTVJiXAfM2wUXqx9gnyupt4GTO9CX7RTtbM/9lbpbcHDQ/kQWk+7CMzf0/dlY/NB/yusCM+g3uWj2WEbIY65nSqb1VsY4pU4rkmIYsZ7T2GQv5WqiYvjkjG5/9M3LNl9JwLPt7oP/TyJ8pv+ozxFlCP2XL37InRqRGM0VNCXoR0SAzLwdTyEyhtNBL4nRlHeB3o1j1G7uEfwW23y0M7dKHrTQaww+mU9ke2IB4vzKTPZxEWz7qNOzMTZgKp5RqRXK7U4+lpzkg5BxXecd52UpkA5tFig2Q1FZZumzzHcbwdRtqHbs1HsWP1LHh0RnEwD8RXASrycw==
Received: from PR3P193CA0013.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:50::18)
 by DU0P195MB1650.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:3a5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 10:18:35 +0000
Received: from AMS0EPF000001A0.eurprd05.prod.outlook.com
 (2603:10a6:102:50:cafe::29) by PR3P193CA0013.outlook.office365.com
 (2603:10a6:102:50::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.21 via Frontend Transport; Fri,
 28 Feb 2025 10:18:35 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF000001A0.mail.protection.outlook.com (10.167.16.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 10:18:35 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 28 Feb
 2025 11:18:32 +0100
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 28 Feb
 2025 11:18:32 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
Subject: [PATCH 5/5] arm64: dts: ti: k3-am62a-phycore-som: Reorder properties per DTS coding style
Date: Fri, 28 Feb 2025 11:18:17 +0100
Message-ID: <20250228101817.865811-5-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250228101817.865811-1-w.egorov@phytec.de>
References: <20250228101817.865811-1-w.egorov@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A0:EE_|DU0P195MB1650:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c3e5c88-92b0-4d7f-a409-08dd57e142a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LTqID5K9RX3eS6UljqTbvvBEsRDbrtJ34L2kERnTi44RUyxq/fykWw+Jkfva?=
 =?us-ascii?Q?jmfk6n1wjbAYRn9U38y6lujHALCusQyE1QNutyUrSjq4uAxIdbSkhYD4EBsm?=
 =?us-ascii?Q?7Fx6aeD6h5Dr8ZHVOiP3IOEGERinztBDETSvVH6U50+lzIuZSPqclaCoYo7T?=
 =?us-ascii?Q?uyz3osluYrr3avv1E8t5ZzX/psUizQ6pda8K2wxx5aW65YhuLcUXBlTpw/3t?=
 =?us-ascii?Q?59H2r7NWaX1oVRV94et3bYheyQjG3LRKmJJzOpkR9REPQnhUuIxYehWM5Cfy?=
 =?us-ascii?Q?wd5eKylvRWUIZMl/Hg3Sln6FuF876g5M8vlVtY2d7707ztNCy3dm5FQe2h51?=
 =?us-ascii?Q?zQgKbrldJ+JE1KlJmvkhifhvQ/ys6au9yYtRACxo6dI3zqaRKKbQHNia4GOC?=
 =?us-ascii?Q?ZCJeRB0Ecn0E+q+72crd82sDgub9mvuPycOQ/vZxN81XKyHhlipcYqR6/vqS?=
 =?us-ascii?Q?3ZFgY7yS/g+IIU9fQNh+2+cVBBGE1vVBGZGjBUnmD0I5FDp/kKPczDzqyhBt?=
 =?us-ascii?Q?0zDxNZwvJxZ4bljhPoc8rGn5kt6n3tEwDhBxQcK9/h1Ahf7LZaWOQX2I3QoQ?=
 =?us-ascii?Q?cbRCM1qT9mXb7BBEUJ651l4qlw9bdyDHvqwh9kP4EzxY2kd2dwVW3C3yPra+?=
 =?us-ascii?Q?cz8xfTDfwx1nthaKs3Y0E5QrLvTD6tQcv/6y6DtRGE/GdexcjjPzpiw7x725?=
 =?us-ascii?Q?O9NGSNvkcglxTkv5F2lamhPvnxHzIbS4E+r8VZEmbDLhDQQlL61tjO80TO78?=
 =?us-ascii?Q?FVO79jzKWpIkc33Tq2MKP2V25JIeJKCtQEx7GaO34ut6aUL5rubvc4u643pN?=
 =?us-ascii?Q?CR8BcsyC/HtIUFC9GV59PwLzkvs6KiJrdxGACFkCEWpO4lHBC+fty7WYtX6D?=
 =?us-ascii?Q?xXciSs/hv0yLzpkSl13/E6m125l3hIexHr4gkyhJ31e6XAzDuy9HXlTS/S69?=
 =?us-ascii?Q?oar+NFiK16JW69TDqzaLFOeXNhOAQYT9VzBRtpf8tK8alfKXqIi4xtn+XSsQ?=
 =?us-ascii?Q?s2flx5c5V205bGww2BbGhIEn5m4X3VigebKRJYjV0K4Rj8+eVQXbNSZQDKFu?=
 =?us-ascii?Q?Mz4H/Zerw79qbP7RflqlekBJ4koGQCSdgqFIRQsEKqzgTeVoRo0O0CI+5tCn?=
 =?us-ascii?Q?6fLq2boGkyKbPtVOLzuDCIzw5uCBWufJ5n2XxmbSl5U/fi5UphexmBzkXVbb?=
 =?us-ascii?Q?TdcQqPUy4arxMXOWsUHREjKOqjTxGrUu3V56ceb/22m0fTuFMz2EMb0IjD5b?=
 =?us-ascii?Q?cZ3q6lhWhmbtkm5xho2Xxfbweo2TSn0M+5xxRGm0nHnY/M3EYwE15SCx18i2?=
 =?us-ascii?Q?YOu5AAU+9SuhIkkoiiZGKkp2lwkTSjTsGtXDD67IdPpC77v4cenjG5Aa7TQr?=
 =?us-ascii?Q?EtGnaNALCr9JFVpCjFLQH44lLUa4tg27sh9O6nIvShi8b92k7EJDU75lJ7ef?=
 =?us-ascii?Q?Q4afO92yJHalfjlc7x3qx8kFA0FVvPVqnaIzRmnFHlyGBEaV5kymv2mf6jRd?=
 =?us-ascii?Q?nyMrzFoxJNo5/oM=3D?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:Diagnostix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 10:18:35.3379
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c3e5c88-92b0-4d7f-a409-08dd57e142a2
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A0.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P195MB1650

Reorder properties to comply with the DeviceTree coding style guidelines:
https://docs.kernel.org/devicetree/bindings/dts-coding-style.html

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi
index 1387d11f9a78..f567462ceb58 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi
@@ -171,10 +171,10 @@ AM62AX_IOPAD(0x1f4, PIN_INPUT, 0) /* (D16) EXTINTn */
 };
 
 &cpsw3g {
-	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_rgmii1_pins_default>;
 	bootph-all;
+	status = "okay";
 };
 
 &cpsw_port1 {
@@ -224,8 +224,8 @@ pmic@30 {
 		interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
-		ti,power-button;
 		system-power-controller;
+		ti,power-button;
 
 		regulators {
 			vdd_3v3: buck1 {
-- 
2.34.1


