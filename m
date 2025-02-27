Return-Path: <linux-kernel+bounces-536711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6404A4834B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2C8616D2E4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5575A26E63E;
	Thu, 27 Feb 2025 15:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="sfwcRV5N"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2099.outbound.protection.outlook.com [40.107.103.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1F226B2CF;
	Thu, 27 Feb 2025 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740670823; cv=fail; b=gnV8FN4ui6eK1GEjT/nkDc3YWy5FF+XfxGKhPop0/NaBBJdeCirDLpHLoMPMa9/ZZoyYWe52PmbA86SG3hsBX8s3PLBtEGkSK9jwTUS7VI+rt6FDwu2A56vdg/Bqn5lMzeSL3bQlSVUvRS4C5lfMumkri1Ia8biz0NZ4dW5sDM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740670823; c=relaxed/simple;
	bh=KYfd9NeM0NnbJufuXmV40N3UnLHSjZSOWynwDe5TiT0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CcjuPV2xPz/u/+BT/nyZMwgGvXcdNU6z0mTb5mFjNeadQdsTo0XSlzDdjX7t4qA3UVAc/VvrSxuIJq5ptW9UZSu6/Dj3+204fsPdphAywVp7fsD+tgc8kQ/Erh4MOuAL2JOFgIePxjrnq1yvjN3n2xEHwZvfyyYQIzTKNQoZw8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.fr; spf=pass smtp.mailfrom=phytec.fr; dkim=pass (1024-bit key) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b=sfwcRV5N; arc=fail smtp.client-ip=40.107.103.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UC5G+KYDctD/d9ZusShTEz+n9wCy9K79a7jqbrH9A6T8ANrKivf4kCL+CDKXD69rk4C69iuyDrZGL4WZSiLP+EUoiklk8ESfVMlhWCzjtMlJ+y2sbDTwryuDTeBBwr9U/NIJl81zg5G6XHzs7EHvjCx0+uGOc4yM2WdkEbhUAilrroxzTW0SqidyaJLEKU6yX9v6F1j8ZLY31ySwtp5YDi5W3HFDhm1bg9lto+cj2zA76Mc9OHYlGEeLRCqJBYeWAx2YJX7LxWwU8cM8+A/HuNkY0/vzZk964RN24QvK4gI35M9+N3ekHroMj4Ibxd/aH0sereym9HDRmxlInKkxPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlkBo13gAAMFxY69YUO/r2kEBTxBz8AgO2heyKDlsH0=;
 b=cxN+QjGfcv6V2a/nEyyY6H4isyyye8aKiCAxlrgPVQBCLtmgUKiqz/3yajsY7sQc+ax9U/P2IJFnjwVT9Xz5z58YGmlcJXB8wKrbQfiMEgTD4HGx6X0A/DX9gWnFx6ZZfTrw45VvQ5apUTUKDrU4KRgB31mJ1ILtLWKLjbS0nFDNKkubhuCUVtPiY/rUK7LySEXRCeUBCgFtdLBLe1js05bxwkyYgyQFTRGEZMWQ3iv4LBOnuyTcS5YAH9Bf2W0W2DBJAEO/dghPHy2808xSPTv6kw+1RfE93skbKkM3rmstE63x6sQNGKBrxCPn0dHEyIfG9ttQieGSsngvmL9VsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 91.26.50.189) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=phytec.fr;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.fr; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlkBo13gAAMFxY69YUO/r2kEBTxBz8AgO2heyKDlsH0=;
 b=sfwcRV5N5WZtlLnLpkZ/BAmNGVYUQ6E2a9C8nzFX+yWpbo4rL8ELOSjpR0s3MHwOX5VdXrQ2pO/jezFCyXgOXY8x+D19zIC22mxt3aEKAKlIJzGm7G195rwG0sR6WrcZGUtY7qc6QcwRMSkCiS3/4CLjnBPmlyrc2u7jDsMxft4=
Received: from CWLP123CA0086.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:5b::26)
 by DB8P195MB0677.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:151::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Thu, 27 Feb
 2025 15:40:17 +0000
Received: from AM2PEPF0001C70E.eurprd05.prod.outlook.com
 (2603:10a6:401:5b:cafe::78) by CWLP123CA0086.outlook.office365.com
 (2603:10a6:401:5b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.21 via Frontend Transport; Thu,
 27 Feb 2025 15:40:17 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.fr; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.fr;
Received-SPF: Fail (protection.outlook.com: domain of phytec.fr does not
 designate 91.26.50.189 as permitted sender) receiver=protection.outlook.com;
 client-ip=91.26.50.189; helo=Diagnostix.phytec.de;
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM2PEPF0001C70E.mail.protection.outlook.com (10.167.16.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 15:40:17 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 27 Feb
 2025 16:40:16 +0100
Received: from Florix.phytec.de (172.25.0.13) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 27 Feb
 2025 16:40:16 +0100
Received: from idefix.phytec.de (172.25.0.20) by mailrelayint.phytec.de
 (172.25.0.13) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Thu, 27 Feb 2025 16:40:16 +0100
Received: from localhost.localdomain ([172.25.39.2])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2025022716401639-90 ;
          Thu, 27 Feb 2025 16:40:16 +0100 
From: Christophe Parant <c.parant@phytec.fr>
To: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	<upstream@lists.phytec.de>
Subject: [PATCH 07/11] ARM: dts: stm32: phycore-stm32mp15: Add dummy memory-node
Date: Thu, 27 Feb 2025 16:40:08 +0100
Message-ID: <20250227154012.259566-8-c.parant@phytec.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250227154012.259566-1-c.parant@phytec.fr>
References: <20250227154012.259566-1-c.parant@phytec.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 27.02.2025 16:40:16,
	Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 27.02.2025 16:40:16
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70E:EE_|DB8P195MB0677:EE_
X-MS-Office365-Filtering-Correlation-Id: d1aa5a89-598e-49d2-622c-08dd57450934
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Aojs5x7NVBRHhKVRfKuWRHNy7Hy2a/P44a42NSTXH3w/6+8l5y9je5FM6ldf?=
 =?us-ascii?Q?Ttae+Rfn+ttRL9Tr4QFqqBEjZwq5Q2UJANUpmJ5M/9L5h+MrnnNne/iM9ZW1?=
 =?us-ascii?Q?gnp7EIWWS6wIjIadq2OSTgqxeZZlHvbz1e0i5LKoCkW26UewUlcd23vH3IyN?=
 =?us-ascii?Q?TEZv3OsS27wgBLIvO5Mr/y8EfKMIEFu5OxDy2Fb61TUFU+I0/jne5LGolKPy?=
 =?us-ascii?Q?KWKrWNEqbVhQNE1AC/HzPKaDt2ATNpH0cPlhU+O9nRPbvUGPX1S4kCjW0Wi3?=
 =?us-ascii?Q?zX7SoUkuX7y4GVh2BX0tx3bRoPxLn+ksR9rAI4j2k8lRwFYYbG5bB7/V87cs?=
 =?us-ascii?Q?O6aepL+1kEPQTQdhfrMbUFmMn/tkb6wfufEdA7uHDBihG1cL/ad0j2LxML9X?=
 =?us-ascii?Q?JphlgDfoTF2WpKieU7c1nd9+5uOhWcutlbZJELiOsAEtUWaxR30OABAPGNVE?=
 =?us-ascii?Q?AR9Im+Ram8NZq6QWatGYlcJseUBqNMyyp962719fEvxHu/KRZH+KkzjcGo7q?=
 =?us-ascii?Q?y5mJzZhoWkdC+HPkPDes0q3zOj2kEyQYDYiWJjc53+UxotaxZeJJEpGjDNu2?=
 =?us-ascii?Q?RJEfegHe0A2skW4CA1A1NdZ1/+X68/wGXoDuar5HNYhhExx/WTFxen0CfNAr?=
 =?us-ascii?Q?PE48vIDXurkBpDLBOScbo4P9KQrrw17Lkx1FV1X6dd/rTaHfATKQrKXdIiq9?=
 =?us-ascii?Q?yrF4I2UwBkUcJj35Gx+YwbWLbHDOAOC2j0/gx189cWRxM1SNDkoMCTQ9MAN2?=
 =?us-ascii?Q?wCFy/gvxO44/e/slmCO3dC1qi6MrHomfevPN/IDokcVFCdEcxm64i/VKshkS?=
 =?us-ascii?Q?OV2j6XP65qJqbAjG7TPefa+S7BFohRNgDL0Zd6aC93p4GSWtSdQagWZBBBp4?=
 =?us-ascii?Q?SHptUl+nf75RY5/MFQVPaGz7xNvOVwYElOgb5fVnmvmfbRWWpLoqCTUjCpPa?=
 =?us-ascii?Q?/1W9p6en39YVAJDTGXdKfbrYDu6ih7ZEh5CsKASVXc/ELB0yQ7dgfMt0CYjF?=
 =?us-ascii?Q?dzLD89jPpnxdiKTr6YFjxss5jxOGyVLHEamPAJPbWVvMVYWyMXqOwUSoc4AF?=
 =?us-ascii?Q?wNdEybdRXa4KIPdRT/NWqOiCcP8McK066ySnCaNvIQF9k+GG/5pIc/P5ECau?=
 =?us-ascii?Q?9TlsMEUErXVK6r/aJKHbQ42VdLKuoVkdYy+yvseFUi3QPA3oDBcQQ4TErtYs?=
 =?us-ascii?Q?sRlxJwUa4RSdd9qrcfhkS3yQ6eQH4OaofhRLRpQcpaDjiho5wCI7z0IFMeCc?=
 =?us-ascii?Q?r9vKfXx/QjmG6VNl5Xl36JlEkDz7Tom9PNlr1SPkD5uoRRiG2hYAR96k3iGq?=
 =?us-ascii?Q?uw7TO/Cad8SA35l3hKf544VYwgZOAkfbn3rNaqXBx8q6Ohob8eD8EqUXM/q9?=
 =?us-ascii?Q?ziwhBobyz2lhK03jrK1Wa1B769Vo1ZHBhzGh35nCEblAiDYHQvW9rA1+y/3W?=
 =?us-ascii?Q?42jazPogXZoW+80rD/vyFHrnOOqgSXRzEqPbad8LKmM6uDfbUOQFMw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:Diagnostix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.fr
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 15:40:17.4797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1aa5a89-598e-49d2-622c-08dd57450934
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P195MB0677

"memory" node is not necessary as the bootloader is taking care of
passing the correct DDR size.
However keep a dummy memory node with the minimum DDR size (512MB) with
comment explaining that.

Signed-off-by: Christophe Parant <c.parant@phytec.fr>
---
 arch/arm/boot/dts/st/stm32mp15xx-phycore-som.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp15xx-phycore-som.dtsi b/arch/arm/b=
oot/dts/st/stm32mp15xx-phycore-som.dtsi
index 72926c3de52c..ce859b94ae26 100644
--- a/arch/arm/boot/dts/st/stm32mp15xx-phycore-som.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15xx-phycore-som.dtsi
@@ -22,6 +22,15 @@ aliases {
 		rtc1 =3D &rtc;
 	};
=20
+	/*
+	 * Set the minimum memory size here and
+	 * let the bootloader set the real size.
+	 */
+	memory@c0000000 {
+		device=5Ftype =3D "memory";
+		reg =3D <0xc0000000 0x20000000>;
+	};
+
 	reserved-memory {
 		#address-cells =3D <1>;
 		#size-cells =3D <1>;
--=20
2.34.1


