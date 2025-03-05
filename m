Return-Path: <linux-kernel+bounces-546329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAF8A4F945
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71AF01892A91
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78921FDA61;
	Wed,  5 Mar 2025 08:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="Xj+5ncyo"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2110.outbound.protection.outlook.com [40.107.21.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FF5191F75;
	Wed,  5 Mar 2025 08:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741164954; cv=fail; b=c4uRNU7/u8f9H95e2i3dyAMAvvBwPLLnkcvNqNLRu0b/5ap+xC0yvjA/HCBHN6FWcP7ms8ApD64rdJTGNGdisB7i6MW4MVfnt2zz/cEaKawmjMUr1bi2ImiIpTQkCOBHsrzFR9d5h38o8Tg67KAKVa5DRKdcB87kCVLPYgk16HA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741164954; c=relaxed/simple;
	bh=sEHe8LRBFyMXrWZ5L/vNqvtk4FTcy0gl08B8WalHSmo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EiCbBgLH6t1Kti3ynJjowsTmgVXXE12qYDNs95a0KslsbDhdBJ9cWiNKcAAAZxKoNwoL7hdaUOitckrK8CJ8uWr4lvuzyHG3anRS4WAtaDeC+GSVxUvQE06/DFs1Q/rt4gvBuM2B7gcRTXaCXSMCXuVekQ1Juad5BEhsxHDk1ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=Xj+5ncyo; arc=fail smtp.client-ip=40.107.21.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XSYyzCf4yfXuOmJumF8XdGYB0bU4G1TU4TRBDbINRJNcTI0iXRxYKkIIoTFVo89S/ONkZXCZ5M+B+Ls4ND+pBZGCt8kW/CbMJHD2YbX0b/lL5z+RyEAKlGbpsDz0rvR8aMpUSYpU3v+wyJMRX1eGuUkVz+rq3NY3W9zKB6YcmxOAfLhbOJiD1FC2A0JyWhzavRlwnbFgFLAKRHswbHPcaOQaQssal2HMPP0QH/7SEX+nAleKfebo5CADrGaRYxngS6YQSmdBcJfaf0EqC8dHE9TIkGVRDW5c22qS5adD0YEi6+S6oTKbgQQOeJWnlDyHdDR70aYWRK+cl6QJpF3Z2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5J8KWPZaiUOD85j35BaOyQLzrFgb+PdKrfMI5Jwu7g=;
 b=mbB3jBdlvzAQps676+1GeW5+S1tNtCHPJDpcNPqoQ5jJYpUKwV/s/ptlL/P6tj3/bVMg7glZGz9mYFmOcJhh5mwamyu682DRdR1sQ/u3QuQOl4Gi6MyYc1FPfNqv40jQq9wIh1z1WWpfPJKCYcMNnSu2Q8YBiNDSB8ng6BB2TLRaF9Cn9Twl1/3TrOJ7IVWeigmw6u5oAAt2oht4x5su864O8MD+MtRv6bJY2qqFaI29Z4PfpYHQRcyvNJ/aCEKMR7yUc24HEYmlzc6sccxEj1kgEL6EInYKNKDdvUgbsNoJNyqWQ0FMEjdb2gUEK++y3ZXHm8/Tvwmdfy7jTZWNlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=ti.com smtp.mailfrom=phytec.de; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine header.from=phytec.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5J8KWPZaiUOD85j35BaOyQLzrFgb+PdKrfMI5Jwu7g=;
 b=Xj+5ncyoQo9qcTnE8Q1CrWhpbR2JYn1Txj5Zv41EESmOVeiyIMSVooWr08ZMmKs1rAqGzCrsNyNERgODqif9FmB/KF0e2EaIyTDuiC1tceeRqnlNk3r4Q6UtRt2D6BodxsWEN3iv7Xxp6u8/26Kx+k/k/qh6wfizJnEPBqQP3gDIh6tWEA979EOZJV2r8Z6JgdtLrXv9Nm4Vhmtx24JrAgQWfDfP8fwvOJhA27WFbvjMXA2dn1lgIzEjjCmX91QjcEz78gwecVvs7Qw/k2sl1atoQtH/hpb8AT2oyptU8WvwhILml79NgvpXYqGv3Lq2e2L8mPj6nnF2/XvuuhuAVQ==
Received: from DB8PR06CA0051.eurprd06.prod.outlook.com (2603:10a6:10:120::25)
 by PAXP195MB1133.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:1ad::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 08:55:48 +0000
Received: from DU6PEPF0000A7DF.eurprd02.prod.outlook.com
 (2603:10a6:10:120:cafe::42) by DB8PR06CA0051.outlook.office365.com
 (2603:10a6:10:120::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.18 via Frontend Transport; Wed,
 5 Mar 2025 08:55:48 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU6PEPF0000A7DF.mail.protection.outlook.com (10.167.8.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 08:55:48 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Mar
 2025 09:55:45 +0100
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Mar
 2025 09:55:45 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
Subject: [PATCH v2 5/5] arm64: dts: ti: k3-am62a-phycore-som: Reorder properties per DTS coding style
Date: Wed, 5 Mar 2025 09:55:37 +0100
Message-ID: <20250305085537.3976579-5-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250305085537.3976579-1-w.egorov@phytec.de>
References: <20250305085537.3976579-1-w.egorov@phytec.de>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7DF:EE_|PAXP195MB1133:EE_
X-MS-Office365-Filtering-Correlation-Id: e3c912de-b777-4bbb-c324-08dd5bc3863e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7Ym3ve4DQ0159KzwRMys+SECbqcskC++X6DDQ2yojpW29rnn/E2y9MrBdi6w?=
 =?us-ascii?Q?VQd7DWdECTI23zDGjo8DbJAhQWtte12crKGiLJbE1xhAaPhkMUvxbj+yfSYr?=
 =?us-ascii?Q?zH4QEMv+6KeLXJvot0YMSW0B36vJWiu9xIuqtS6veQzJOAXYhoEtVXzTHJpB?=
 =?us-ascii?Q?Fv/M+uORdLclfxsXFlMRPwgrShPfakoeRDsTQbj8pbXoycqwlEgVdfkcEmnl?=
 =?us-ascii?Q?P2CbO0/fygEMxitDRk6SK9V654V/a7sJl2HPE3U3BOrpeeiJKUxntZBr+HDn?=
 =?us-ascii?Q?08TG4tqjXftfnAK1SMwKOzuCVGzioka2hbe2V5vNmT0IYexn9IssZ68ipAGR?=
 =?us-ascii?Q?GdqJk0/iEkkKPLEIvcNUO7C/eWddhfzehNUQCT2QItPN4jcPhSuNyiy4uRtn?=
 =?us-ascii?Q?znyQxQW7SqVKV2l8Gm2UHU7Qs8352R0uK68EDoChrVEpgDFFI0i9qQSKc/ly?=
 =?us-ascii?Q?ODvVkFy6X0Q8kvlS8I8YqosxgvSCMzYoDTR5mpoL4XeByBMAXuIRF840lnBI?=
 =?us-ascii?Q?CPVR4xWy5iIBpVomwcECxR+LtH7AnNGrKKl7tFY5jGVKCxcROtSq77fszF0B?=
 =?us-ascii?Q?U9rp0Q02eHznjMH48UK4OzR+l7JJu/zwpw9dPYTgWqpLh0PI5wq7wXRbgcdT?=
 =?us-ascii?Q?4vkEXYeQA4CEjHWT2tsK8FhkxIJ/dAezD4KPHd/ZBTg3wMs92eq/da7oeAme?=
 =?us-ascii?Q?Igjr5AKQyCyy2vhWFJJAKdwl/7QSdO0fKD/FR3tcLnqHfjAj+8jjKKAywQJy?=
 =?us-ascii?Q?2ACpndpaSuluHL9dY1EmnR/yR8DrNCAmQIEh2d7qsRQogZcgfU3xnHCU5VXX?=
 =?us-ascii?Q?pIIo2biMIcDmm53hvyx0rUqPQGETunvQOtpM4C9WlKQ0kQUtx2U55Bf3y0k3?=
 =?us-ascii?Q?8nSMgL6qoTpf7fFM7vQkYhBW7hQWjI5BA9zO3UHxNBYgaPW9Ck25vaOFkO27?=
 =?us-ascii?Q?B/PKKzr3hlwf8xWr/5yDIts4vOaFsxIGx18wJvtEcY7fF/hwZJpG+wgy6KUw?=
 =?us-ascii?Q?FMYpj2BJaDQ6pgcCSU/JagjmmgeLL65PH1AON5zUsgkPVV1zI9YYCxgxAr0l?=
 =?us-ascii?Q?joUNowmT3lOoLZmEynYu9/aD5KJljm9q9AvBWZn23ast8sDaT/VxBHywslUb?=
 =?us-ascii?Q?3C4VG+UKUIdKeo/CbRBZUh6QYQSkoSMoC7LOiywGdgx2KpSJI9snXF3NBJu/?=
 =?us-ascii?Q?4fZqISkJYp8C49UxQ0g6Z/g1NYUz91pyYQg5QQ8LywtYwpfTQ0/7ONJcHyjY?=
 =?us-ascii?Q?VAmunYiD9t8MijssyUpqMmGRMWho9rPfBKGb73agmOrNZOhH1tcWjOZ4ewxj?=
 =?us-ascii?Q?bh3s+hT//wVaxyHfKAUY3Oq5UcWP18nrpXL3s1uFIClEyjAYYc0z/D8H1hXh?=
 =?us-ascii?Q?56nC2KlkQjhHbJwkIelHD/21kfiKmoYu+uMMbZZZ3Gr/IWi18MQssV6QHEfX?=
 =?us-ascii?Q?DbWJynmRJ2y/TK8iXy5Rc2yzbi23uUSsRHNPhdKaW/GC9Q8AF2L2SYYgQMpp?=
 =?us-ascii?Q?72rWAF6jzWqc8VA=3D?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:Diagnostix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 08:55:48.4863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c912de-b777-4bbb-c324-08dd5bc3863e
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP195MB1133

Reorder properties to comply with the DeviceTree coding style guidelines:
https://docs.kernel.org/devicetree/bindings/dts-coding-style.html

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
v2: No changes
---
 arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi
index 7920559e84a3..147d56b87984 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi
@@ -171,7 +171,6 @@ AM62AX_IOPAD(0x1f4, PIN_INPUT, 0) /* (D16) EXTINTn */
 };
 
 &cpsw3g {
-	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_rgmii1_pins_default>;
 	status = "okay";
@@ -225,8 +224,8 @@ pmic@30 {
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


