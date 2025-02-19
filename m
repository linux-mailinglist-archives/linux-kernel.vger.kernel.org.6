Return-Path: <linux-kernel+bounces-522299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3930AA3C870
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27AED189101B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C4122ACDA;
	Wed, 19 Feb 2025 19:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DGdWISR/"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013052.outbound.protection.outlook.com [40.107.159.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874F422ACEE;
	Wed, 19 Feb 2025 19:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739992889; cv=fail; b=eDwyNuhZ9jkH89eWUXSqZPpEZHeg0HQtDO2sDxMAqphirS3VwltOu2vJ7WNb9p4Ztof0cEAKLEGUxkBUi8fkTbm5j/SEJwRJhO7/bz8HRBh2f63ZFH1W5qFeejrYTEJx1SwfBiFDxSh0HATINteYy8G7Jb7ALTVxhvTYPH782iE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739992889; c=relaxed/simple;
	bh=Xztqo7o8oaQPAczvgjEWCOGGGWfr3kMZ1zadrChWqJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mij9h+ZhY/1SZsYE9PrEav6GKj4R2MAolhmpvwHisAXApn0pVumZ+YoenRxMngCS1U1K2A/bj4wbCwfJCNeOllJWagcHErY6yvXMGxU6HWeHGFH+ehQfbajQRksI5T72slGVHVtoQ5HmE/SwqXbpsQs04NORmi7TOky2v7BvVF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DGdWISR/; arc=fail smtp.client-ip=40.107.159.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D/SleV+6tL0NJQUTdEHfHOB4mNcGCQ07vq4+LIXfh2jR2kCo5b7lsZMDXfsdaTUIv1vlWvk/9/ZAdFurk7HphQA0tZQttZxTuViqj2QbnQZ6tLGG0ATvpSclsHiIrCwlIbCO9Pa5QvM+jEJrbeAmPYh0E4uZi+SnFRcpokgMjz0qQqwUT/RFd2Zc9R5EQIYNUymXehd0vGATzkEFd98DZGAfvhSUkpnKVIhiAQP74ZukivLKIRgtgeI7o9UKm7XscMif38QYA1sP10xXh34svKWpM4QJXyy7OCA+oEIJUrw0n9GH324OP1HME9axJfhT6wMysTgWMMg1pBZBHbpHQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekpkBahH16Ucoli+JtAzBkRK/seSOTvleIe/z6YHwdk=;
 b=T7n97t54S2HWANUhoHfiUCFkgMY+OScaXxk3gm5xsEm8A2OLZlXoww0VryZ6h3ciAh8deZz5ZCzNOo2++p6BRiv3J9bN1EvvbZW1DrAUQAIq0mSHuuiNTJEBEQZqH7ErAZEX0zGx/c/Uyt7phjJNa526Mwjoy2m8WDRh/gqmWBu9tWQl4J0MBey3HgcE+QTVBXaP+VnkmrOx9R7QIi2j7HYmL3EjMv9F1YDxHkHRSTs1c7F7oeb2rR2B/ZhMMtR5PuGQzaKnODBkfMKqD/gG+b3aorgVy2QNhAVq9r0RZKm1ixajdeQIuhU930+sWitt5Dlr/0A/6BJ3+1le8CIF3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekpkBahH16Ucoli+JtAzBkRK/seSOTvleIe/z6YHwdk=;
 b=DGdWISR/VtmDcg/T2+BflEisMYkG3zehDUdpziNz1lgFrmIEhm8O2viYSmZGUz5jFXlaZs/ksjlCJfySG1FaJpTA7ac819Hu4RMFhTt9RzP0wPwiyZoUpV731iOFVRpEGLIW09Zp4WCWutlx+EMPQmKLxLf5DJ2KXj3anyKPbAP0DAPQxCPb4kQPD4gpMJBNHnwgg8SQH7pUD2sJ9+LrzcHFWTiTTLzlV0JGQRVf65SuH7XZtQNLfJL88qYaM6Y/D/yb6Ql8R9EutkocB7Hkr+9dQubtBWnHSwwxMOgSAKU4mkX5LTuK8DBulP7aCDvwgXo6AmJpPv0lU/mXnsc3YA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13)
 by VI0PR04MB10951.eurprd04.prod.outlook.com (2603:10a6:800:25c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 19:21:22 +0000
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6]) by AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 19:21:22 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: p.zabel@pengutronix.de,
	robh@kernel.org,
	shawnguo@kernel.org
Cc: krzk+dt@kernel.org,
	conor+dt@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	mathieu.poirier@linaro.org,
	shengjiu.wang@nxp.com,
	Frank.Li@nxp.com,
	peng.fan@nxp.com,
	laurentiu.mihalcea@nxp.com,
	iuliana.prodan@nxp.com,
	Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 1/8] dt-bindings: reset: audiomix: Add reset ids for EARC and DSP
Date: Wed, 19 Feb 2025 21:20:55 +0200
Message-Id: <20250219192102.423850-2-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250219192102.423850-1-daniel.baluta@nxp.com>
References: <20250219192102.423850-1-daniel.baluta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0267.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::34) To AS8PR04MB8247.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8247:EE_|VI0PR04MB10951:EE_
X-MS-Office365-Filtering-Correlation-Id: 81d8d5af-fdaa-4a2a-9717-08dd511a9820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|52116014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N6gg1h2KhRxMfMT50vFe/evS+J6IUsixwgGIJXu6gBANEN7sWffk1aBhsnaG?=
 =?us-ascii?Q?jSU79sADCep+Zy1rJjqpiKqXvug8EEpsprdfLTlQ4iOrE+PO4fWp2jI08/s5?=
 =?us-ascii?Q?2P7UCg67+b0XmcmgMEgpHUr+cwu2wyXHpc/0GFGx37FgCOMxRSHeqbFaTI6u?=
 =?us-ascii?Q?y9Ge8xitjsOt/poH9ATMGQGrAo5g9RLZIAliKdyQsWfMgUshyXoxs8nha8Tf?=
 =?us-ascii?Q?ET2RRw/I4E3pb/MS5aZIG0MQInEi49zxNT7paabG2bcdWi19PXAd8VRp7j26?=
 =?us-ascii?Q?lhDMyOXKtRDnUj0IWrm5v0kgIFbRDsRoi2TnUr6M7xl/EWlpcgyZyEa0kDk/?=
 =?us-ascii?Q?o2/RQ+rzz/WjgHxvpUMu3EnfQled4jNkDM0HyTDqc6qfHhYCNWmv5wWZxXPy?=
 =?us-ascii?Q?10rGBh4SvxlMI8F22+KX3YYjjxR52u1xwIWNj2n6KvWdHxrl6Ghjcp9QoQkS?=
 =?us-ascii?Q?Q2OAEc/scg6we3vp7X+S4U1LOlGa+aQVzFUEUnDShR7BD+LRCIPaCC7pGclE?=
 =?us-ascii?Q?OG84gVFjJFubiJm2JxBlzavRBD9tt2GUJeXvQfInveEmdRRFT5AN7x57EgS5?=
 =?us-ascii?Q?HLKfrn//T/xdJ36gD/7mgTZ6yLTz222+/SaSOTNVAnzZWHQruBkl214EB4/I?=
 =?us-ascii?Q?b9286aePL8paqugjNceYGFbpYD9cBbTF+EMOQZ8haiJgc/SxBceZzqJz4RKo?=
 =?us-ascii?Q?QMS9+qmgIoz4DZbNiVp85AVCc7YSpSzhfrzKhl/GixY6sG1DeD7xCmTXBOci?=
 =?us-ascii?Q?y16lbQwOz41fjJnDbuC7LhafEry9XkgF+YNZAxQNnfsgmxJZ+jUpmnR036jn?=
 =?us-ascii?Q?rBlZHGgUUuFhKJxtSktbVfm4+YoarFIm94hjmP8tVTn+3anY9iSYfe4P1dPx?=
 =?us-ascii?Q?zSyAkDiwLnRjVgC2rQ6T80b2WSqvMkTHbyw+Qux3u1/muszfCFbreVyxmh5T?=
 =?us-ascii?Q?BHV7cTci1oNhUuDhKF4E4tbGdSNcj2uTAenPWWR20pUmFP1suUQqFRBEEauG?=
 =?us-ascii?Q?D/dWzCA3CeQsdD3mm9rjPP7WDobsXAT3IfVJdgfSkVTwFyCqoY4eigepg/uG?=
 =?us-ascii?Q?k9ZoGjy658DeUCeL6b+Aa6TIoPS1oIs9//Us9D6pdaApa304tWYxSUbDvNqv?=
 =?us-ascii?Q?gA5H+xFGUgYcvDSVczzmUPe0WdcAbh6iAdgTor8Hicfk5fU4GTatuzZYn1cT?=
 =?us-ascii?Q?43zJDpo3tTRSzdzzskOCCVNSNhNhfBj84ue9K+Plyi98vFe5QKjK7Y1iJEjs?=
 =?us-ascii?Q?uLDZYontTRM5rpWjcEdJ9iVKjqHUeKejgLTmy60zCURtDI2ZOkPlTh0hcEWT?=
 =?us-ascii?Q?ZMBbYeuV7NwEH/2H6bPglIBFI70MpK6TBsrUDSPhDbYDqahucae+JdQHP4v8?=
 =?us-ascii?Q?Q5IyRq2+EK32jyzgEgAxI1Kna+BQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8247.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6vPQTBUfCSlkB9rDbrOmwce64pMtMSCzb+NDo/ZD7e1s1v/7+tuA9rmNlPON?=
 =?us-ascii?Q?x1qg8J2I/HvaCTb/SjSHL9WHOx48xCLEuyc375uoJBQelcMO2eWf7dfi4wnB?=
 =?us-ascii?Q?lubbve9JkUSaONngqwXK7fzDFmAaH/PVuFAhccIc1bpkp/gZdJKywoDxM7jv?=
 =?us-ascii?Q?blDN3LBkjWb4RYzongSU86MMsIvvbX1sEuyNFxqNJEDnY65mWmEdNsVTYLdR?=
 =?us-ascii?Q?ajRuxQu/grPRbO/tHFik/aWlx+aEPyiEop5Nkpeka7nNpwPHsLVTmPnYz3ta?=
 =?us-ascii?Q?Fr3mpJVo8R7gEgrn94NOdHsI71YGSk9oGZARcazUMZbXzn95dKgvPatdFfKM?=
 =?us-ascii?Q?y9tK3ISWXvYgESGMFG+aYjlg1iswf7iQPTgCpXqVUHYDOeQ2003bMvDHT23i?=
 =?us-ascii?Q?TFQPdnugQNI+DYWeDO4VeKjNprxBBFdw698fNHQTOu8QDFmq/7QiovhL/lUj?=
 =?us-ascii?Q?hGgDAIJCQ2AoOHek7aQPyqiKKaRPAZPD2Xz8pSIPXiZLvCpgU+CT02aH8JCg?=
 =?us-ascii?Q?TlGmWCC18uep8sS7gI1KxnEiFMo5YpXQLKPhhKHaTcpcSsPa7U+jDN0zK+rz?=
 =?us-ascii?Q?vLV20SDyszqjecqJXvugHpo4+FOkDy3S/u5ocDENMJ8kltmGtolbaoFYXXv7?=
 =?us-ascii?Q?GcMH6mvEAFExeFoS+pmnC7YbvcVlrfUCaPbwL67NqGjWXsTA3z73jYrGzk/P?=
 =?us-ascii?Q?EQr/dDhiBRgGxW/+YJDDJ368phaRhkGSEc9LBS39H13a9p+KyYHsqAfXlXh2?=
 =?us-ascii?Q?sV9IZSuutXRXnWTd5y1QC7lN0tXqHh9xLzYabQEJpJx7M1lgSZ6Np7+0DEq1?=
 =?us-ascii?Q?AKKdmD7E/sz+SBGrKDlTMJK+bTG6xUU5ppDHXJ2c2mqB0oI0oav/3jIDuEdM?=
 =?us-ascii?Q?jxmmIBHAFlCyK5vuFZ7UfUngXANvCHPWib3tJUcxGQwCv1L5e9EVHSPJ8ihv?=
 =?us-ascii?Q?QMoLX98BWibEIFMuGDfKOy1eAeVqo97YBnH5brvtmBW9W2oPZwuc0NHEvgiW?=
 =?us-ascii?Q?e5dl6vj3sHYaw9lG43G31LRozsVteemKG/Q7+Y9R3nuI4f9s9iUXBBq7D8zP?=
 =?us-ascii?Q?x0mSVu8RrlHASdPpewdgwQeZ3wMUqGaOq7JATPmRVtOsUBdYtuGgBTUG2maI?=
 =?us-ascii?Q?H/MhxKordVr0unxfQ9qRYu8Jd4UolUayFpGDcezLpCUW45sXFC9jw28Q21rA?=
 =?us-ascii?Q?K83ss1hjDqjc59Yx40OqXc8Bsp4FVlIUYpPbQiTIaX+S6bNCa6tDj1bbADa9?=
 =?us-ascii?Q?qbR6PCZYO/qJjlNuEmttcLLlAnDM5PQPC/IlL50AQ5U70pmo1uwZ6twTVaCL?=
 =?us-ascii?Q?qDcRvXKVxzamPXNWrsHiXlYDmnaJBp6aSnMGH9vucTTn7yvDvl0kVg9YyxSF?=
 =?us-ascii?Q?rdnsF4aD69hc91RpSB2ZL8XSVpeZrCuoDCPRr8hZ30+ABIChJ/psTcgh4gSm?=
 =?us-ascii?Q?ue1+oFwFZZxopbrXyLqhEwrUmvUPGiCAFk2p5NfvPYvITx7cdl/iOU4bVyBY?=
 =?us-ascii?Q?X+2EvODdZksW1n37nIn4VWlUZd2pZnJj7BaScvSFWlT3sfLPM1jmUHE1NuY+?=
 =?us-ascii?Q?1QsOy68m1tQ0A8qe1U46e2AzfxhPB7cPUY/hAGp6h/vs0ZGFKOdi3z/8CXAh?=
 =?us-ascii?Q?SbYHZ/OvVgQfzFfIOF5NlbqYsL3IjUJ6vaxHNtEi+ImC2pwkH730V3+Aj/9R?=
 =?us-ascii?Q?jaAo/A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d8d5af-fdaa-4a2a-9717-08dd511a9820
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8247.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 19:21:22.2460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f4sT2iKZ33eQCW+zasnbx8pPoGOPP8vEl0nSLs6SO3Ertb7kiaEbR8H10kA6B4F9UiPTU9GifxPPQwD1sd108Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10951

Add reset ids used for EARC and DSP on i.MX8MP platform.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 include/dt-bindings/reset/imx8mp-reset-audiomix.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 include/dt-bindings/reset/imx8mp-reset-audiomix.h

diff --git a/include/dt-bindings/reset/imx8mp-reset-audiomix.h b/include/dt-bindings/reset/imx8mp-reset-audiomix.h
new file mode 100644
index 000000000000..3349bf311764
--- /dev/null
+++ b/include/dt-bindings/reset/imx8mp-reset-audiomix.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
+/*
+ * Copyright 2025 NXP
+ */
+
+#ifndef DT_BINDING_RESET_IMX8MP_AUDIOMIX_H
+#define DT_BINDING_RESET_IMX8MP_AUDIOMIX_H
+
+#define IMX8MP_AUDIOMIX_EARC		0
+#define IMX8MP_AUDIOMIX_EARC_PHY	1
+#define IMX8MP_AUDIOMIX_DSP		2
+
+#endif /* DT_BINDING_RESET_IMX8MP_AUDIOMIX_H */
-- 
2.25.1


