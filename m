Return-Path: <linux-kernel+bounces-392264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1B39B91AD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B6FF1C22796
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 13:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03EC1A08DF;
	Fri,  1 Nov 2024 13:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="MrJ5SUG8"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2111.outbound.protection.outlook.com [40.107.21.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C24E1990C0;
	Fri,  1 Nov 2024 13:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730466889; cv=fail; b=WGtI1VyByphzsE2NjQERrkAR43ke/2pUOE13i8qWHjFuLGP72exGTYKctrs/YmcYxY/r5q2oN58VLLUesNVouOxyaMd20OEPgXJAdadfrC3BNlYwNjSv4jCRTN6McuhBKiRahMPyX6oJOHf+d3zZCblrc8G/D3QBXRoJl6Jlnas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730466889; c=relaxed/simple;
	bh=9UTKZP0FgaOC7FIzuRtDMr4Lw+4xwUDZ+zeR0HVd+hQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NhaNBu7JfEevT35Vw4eWV6oHirZthkMkiZpYcs3lQdgFKbNSLC8MdvwqUnHQew5QUIDK4UnKZFHnps98pmjnnwsQcXlRhLWcCDxr+wjl6JoSEzkMNg5E+Bkd1jhLv1b3AYLNPTemzmFUZ5oYzT+ppI9Fj7xW9Gw8Y8p1+9xoLd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b=MrJ5SUG8; arc=fail smtp.client-ip=40.107.21.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s1HARmNJiLHT3Gv1VpydbGorpPPZ+oA1mOdFjJgsT9VfqQdtmvTKBv9UK+tb3AXVPHZqYMEiXAoFA6MnDqDceMmawEN9wlXg2tqpU5JYsyHP/7XhWH4NNndBDe599ImqYJHg+zpoQRaX2NVvMzlNTUtbrb4pclp9JpaDaqcj55GiDJz1e0LFUfTiggfCo1w/1+vAaxvM0ZVS1YS1PKzKpSCJ5iz8GxQSzp6UroTi2xRT7LTPd9d3Ifoqy/q7zeUOaZLGdiVkn9dCXKtTYTokkdKJzGWt1ylBflDmu8SUKQg8qk1G61P10z9XgPuYDuEn+MnO+K1krUQRRrmXNbzTEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z55SZwvhVAgN5je5qdQ4BBsLOhF5tBC4qDKVum9GnUc=;
 b=rMAwlr/ClPxX5GDB1TvCqyQA4pV0gic/3dumIIAOm50UazpusF9IHm19LLsIXhLqQ1sjhcYG8rqZy7fLgQXGsoOpW3c3pN6duX7UJbbCyZ3m0oIZC2okFgjLdOF1gR9S04OXDRvd6D4j9+Cr+r4vdPVSgoVQfJrFZG1bXwdWleUxpckqYlgHzwq6L2jJ/MZo9U4AXPRu2gSfVw/QaottDuZJKx5t3ZiayXSBgpyqORQmqEwxd3BL8PzMR8IP5a57o76P2lsVKZ/E1fhG8zRzH4g4baEYcdtthL7+Jvav7ztb4bWCjnkKvHh5sHND2r33GgzeiJm3IegZyxsskNOLPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=ti.com smtp.mailfrom=phytec.de; dmarc=none
 action=none header.from=phytec.de; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z55SZwvhVAgN5je5qdQ4BBsLOhF5tBC4qDKVum9GnUc=;
 b=MrJ5SUG8x0vzgA1GmDpxaW4vIHtEahvnKRb5Ll52BlmKqGwINl1bBy+BoSo33cE3ehlFnWiMOel3VJYAJ7lRQc7L7ZYXpKM2+Ad218T6E6rlFNnOsqlik0baMhmzeJgBHJmz3qtPpzth2ixu/J4fWj0zRVLWQcZdJZIoXHlNEt4=
Received: from DUZP191CA0012.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f9::6) by
 AS1P195MB1517.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4a2::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.32; Fri, 1 Nov 2024 13:14:41 +0000
Received: from DU2PEPF00028D0C.eurprd03.prod.outlook.com
 (2603:10a6:10:4f9:cafe::82) by DUZP191CA0012.outlook.office365.com
 (2603:10a6:10:4f9::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.26 via Frontend
 Transport; Fri, 1 Nov 2024 13:14:41 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU2PEPF00028D0C.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 13:14:40 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 1 Nov 2024
 14:14:38 +0100
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 1 Nov 2024
 14:14:38 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <upstream@lists.phytec.de>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] arm64: dts: ti: k3-am62x-phyboard-lyra: Add HDMI bridge regulators
Date: Fri, 1 Nov 2024 14:14:25 +0100
Message-ID: <20241101131427.3815341-2-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241101131427.3815341-1-w.egorov@phytec.de>
References: <20241101131427.3815341-1-w.egorov@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0C:EE_|AS1P195MB1517:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d804235-5d3a-4996-e58b-08dcfa77250d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AmA6QyLtM+84c6643k+IPp6sRsaj5qAXqhqsl0GqfH/eQuoke4j2eY5nerRR?=
 =?us-ascii?Q?DMpLIOAfhm1cZqLjRaPwREogRxxh233eWExAbU73OQJ0tjkrqVDqRHdBFh2s?=
 =?us-ascii?Q?NoLpXd0ffsqDjTjPRNfl3UXQIrPCdy5N6vt87zuzuUBnrtKgmqoWsU+cTEaq?=
 =?us-ascii?Q?zuKWIHzJUKZwFZqocsL8FbY4tgfxRptfBdeH0MtukPG7eH2WKVOuQ2qQPy5c?=
 =?us-ascii?Q?RL3As2axmZGMZxAXmiXt8pqezKWD16F41Pf6rsKvaMwTlrq0CexEvwoZzXMe?=
 =?us-ascii?Q?WgkUP0g/sGg6X5ecgIxuigGkngxmCD0/VUubLjzncZJcTXdmerbdcKoV3J9q?=
 =?us-ascii?Q?UOR74yQVSjc9e9TRaq/BrWtQBFRLDwJd15sOMIMaxAI5srFZAiquRx80Kgoz?=
 =?us-ascii?Q?LCBcgHDXMr9a1eSltglhUsyC1K/G5I6eCdAfv4T/GV171aS4ey2W+x8ed6dz?=
 =?us-ascii?Q?ts8jjQCPRRDWIaKuW7f2hPjWKD/7HO9B6I1oD44Kxrzt2gR+kEO67KZvsrdy?=
 =?us-ascii?Q?14rnAkRj3GhzkNOy9OQbqYwNa9sgMMhMoCwoi28UjHm/tukYfcH7JtNP3b7U?=
 =?us-ascii?Q?iXctRBeCiet8o4HYY1+uWRT5IBRxc1WTamrBehVosevK7I4/CZ2mQj40l4ss?=
 =?us-ascii?Q?PGsYSssYbSpSBc/bqqIKyM5ZQvry50KaHEe36xQLoI3Rl+VUw09JY323y7lb?=
 =?us-ascii?Q?mS2yRyr4KEic+Pxcfgl6LM16ToHOBWSv1C5LXhQxi8/QIUbIPN5luBQajUrt?=
 =?us-ascii?Q?o7CRthxBUYGLJ2p8RJxQJU+MFz9uGvRSmrUteEvig2EVud1rpA+DDydouXGl?=
 =?us-ascii?Q?yfQS/E6uDdajlWVXR/Ziy3W+3b1JOjSBHqxl+EsMiOJbOlT6fzr4dOHmqVJ3?=
 =?us-ascii?Q?MsyGUijzumh19b3sVTanOCafQHFA6Ca1xSfBkaMVy5qFB9UwLY1Hh1fy7ae+?=
 =?us-ascii?Q?ZuEJdj9FwOXo7g1vTIURIL7aFLdwhJ9zU6bc//eTGwtJxOYPJzaYIGFoFzD9?=
 =?us-ascii?Q?CCCOCJFMd3JcdCVBLszF986udUhx9zkbZd/ItmAKaDIRl60v458PqgEoWOM7?=
 =?us-ascii?Q?EvLI+3qR5+5GRElZxzndKthAEScYkf51YR3eFZRP/AspsEqURpFrR3VoJYJP?=
 =?us-ascii?Q?Pdg/wk4tS9DsiIeTCfHkhSSOEFf9GWoKcJKjt5jHI1Do4BBMrxaX9XyVlprN?=
 =?us-ascii?Q?vTijp3bYJL9Qj6W4Dhsx6QZVopHd7NrJQSog6WPFT4pmSkoTTGVwFVnUi2S9?=
 =?us-ascii?Q?+MFhB3OhHM7JZssqQ2J8gELZ9oi7S8O2yWI2WUWjvxB7l3Nic27a9yaCkKS6?=
 =?us-ascii?Q?RPgUIvyKDbQB/Jp6svfz5NG9SMatAwgfcovm2BmAElmLfnP+4xhn21KhRe8M?=
 =?us-ascii?Q?dxJi5Livn9mpwCxxUWGRmnHzjEcezY21CDhXns0sNVPoUh8t2Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:Diagnostix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 13:14:40.8706
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d804235-5d3a-4996-e58b-08dcfa77250d
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0C.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1P195MB1517

Specify I/0 voltage & core supply regulators used by the SII902x
HDMI bridge and make them known to the bridge.
This resolves the following warning:

  sii902x 1-0039: supply iovcc not found, using dummy regulator
  sii902x 1-0039: supply cvcc12 not found, using dummy regulator

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 .../boot/dts/ti/k3-am62x-phyboard-lyra.dtsi   | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi
index 52cd25999511..04fa2bffca79 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi
@@ -112,6 +112,25 @@ vcc_1v8: regulator-vcc-1v8 {
 		regulator-boot-on;
 	};
 
+	vcc_3v3_hdmi: regulator-vcc-3v3-hdmi {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_3V3_HDMI";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_3v3_sw>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vcc_1v2_hdmi: regulator-vcc-1v2-hdmi {
+		compatible = "regulator-fixed";
+		regulator-name = "HDMI_CVCC";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	vcc_3v3_mmc: regulator-vcc-3v3-mmc {
 		compatible = "regulator-fixed";
 		regulator-name = "VCC_3V3_MMC";
@@ -367,6 +386,9 @@ sii9022: bridge-hdmi@39 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&hdmi_int_pins_default>;
 
+		iovcc-supply = <&vcc_3v3_hdmi>;
+		cvcc12-supply = <&vcc_1v2_hdmi>;
+
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.34.1


