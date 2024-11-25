Return-Path: <linux-kernel+bounces-421294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DD59D8930
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6999416299B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876951B3945;
	Mon, 25 Nov 2024 15:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E4/pXH5L"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2070.outbound.protection.outlook.com [40.107.104.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27FD1B3941;
	Mon, 25 Nov 2024 15:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732548208; cv=fail; b=je6sa9YjeZRNldTIfvtKfeCd2JMNfSR+209eyFa+t45IY18/aRj2t444wBc91Hg5CzBS+sig1RCc98Tnz/wA5w+My7aKM+bx1WoZlAkYoZjM9POUO+3rTjwtV53i4G/5QqDaRL7pQUt7U/kko3bzkdO0lPJ2V9XhZDZ1TtN6v3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732548208; c=relaxed/simple;
	bh=MK2zSAducN3Dd3UqGak2qaVJabPXjt85J1SIZ3ulJsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IqheMsEd6sPYso1fk0ixp+pn6qgHTufA5Sn/rIfIr6hUEANZEHHmbqvjx4oR1Zr7B/oTcAzmfyiWh3m/YxCYuL9dyHDxEXHn4jmBXjfude+tKbDtBKvaBdka5skgKGsNbTlpJnhVrLKSt6eErfq0VSjOuSYVEUsvwmELLYDlo9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E4/pXH5L; arc=fail smtp.client-ip=40.107.104.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yRMlza/tepPL79rwzsY8h+AR34dlTEeqU13vt4OoUtx7ehA67QDlDoGeXP3ko9s/6mB/A1a09sU0Cd4QyOs29DJB+fpPedWlIsTJ/agbfA3tpSqaborQvcauBfZrW3Fulo4dHQ5pW3bCJsSyRcm9exk4ood50HUBjVszzKpjGeBsWTs0L6tFNOpTNC7s/+Sm3z7WX84Bg0kFx6Ga8uHQwnkXhKTNjJvqcFCkxdAmNva3RME/03pPHhDeJw77TDp2jF+4Cn0tMkOKO6PP9kCZ5sOPz78Xh3l2o8lNny3I8a0EfBtblOr0SmczNKre32BXUB45/6q7uLji3XiItffPhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k037+Rfep/E8s9/0tx5OFVUSG9fTiHnLvRaW3QHDXyE=;
 b=sd1mIcmehFhParLSGENcTe9uodg1P56UmfVA+Hzw9sV2mHl888Lv/b7RVn2PjKukP8bPUGmoCNzuXh1TG5IBypDv23OXpCjFbd8jtg3TQbnBG0AmjBxhI1KYHz7tutmfV99AafK/GfKJf+zAX5VXi/jy2jZRTP/pA1u8DzA76y276P2F+SVD7EcsBkWcfhxZ3LRsiuxC3TUwxgDeTBXmOM951FiwULP8hN4cBUpC/x024Hp/GJ/gbauBjLy3ejQgb9gEo6UJ23gWoxT9INtK+w2vqmjfivvCHe3qT3y0vslaXUSoc1OrVyeRQ5A2ejEK/MVQHoqGLhwNO/zfhQQXOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k037+Rfep/E8s9/0tx5OFVUSG9fTiHnLvRaW3QHDXyE=;
 b=E4/pXH5LmfUOFrAL9ka+noydiIej1wmD24spbAmZ8dZeazQ73w5EDAEHY0o7fa6NRnFJF7zWlTMG3Bb6ADbz6fSZ6qy8a53eYQehXztj3RSv8HZ3RjdbnxyvrxqVIQchFtuRQMxO8oP6eVKdvOS8bpWlAUmUNJwLGT1Gs4050dzXeazPvW1iABJ0SuIWIBsrJL1gpN6ymf0rvkUD3H+kbOrWhI3Iy4SMJlMG1MtBj4BfdrtfWUYYymWjFyDCCP1hPOOQJQL6oq0yByrukUdE7pbJrhKvqJIbLuAMk19WNgWBrYvM6VipHGiZzIZImO/3h2rullOjHs+Km7lJrWiiyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13)
 by DU4PR04MB10886.eurprd04.prod.outlook.com (2603:10a6:10:580::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Mon, 25 Nov
 2024 15:23:25 +0000
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6]) by AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6%4]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 15:23:25 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	festevam@gmail.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	frank.li@nxp.com,
	aisheng.dong@nxp.com,
	daniel.baluta@gmail.com,
	laurentiu.mihalcea@nxp.com,
	shengjiu.wang@nxp.com,
	iuliana.prodan@nxp.com,
	a.fatoum@pengutronix.de,
	Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 4/6] dt-bindings: clock: imx8mp: Add syscon compatible
Date: Mon, 25 Nov 2024 17:24:24 +0200
Message-ID: <20241125152427.136883-5-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241125152427.136883-1-daniel.baluta@nxp.com>
References: <20241125152427.136883-1-daniel.baluta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE0P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:a::13) To AS8PR04MB8247.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8247:EE_|DU4PR04MB10886:EE_
X-MS-Office365-Filtering-Correlation-Id: 12e3c0e1-87ec-466a-5741-08dd0d651ab4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bysTVsTlIYyCSYmulZ6ZihK5C+4nDSbmoPNXUUpk7e5Cv4VfIfm5tmOPl0iJ?=
 =?us-ascii?Q?wwKOLWy6UL1VRA55bajXNf51IZFUGlGAE78RV/urJ4zVGoAyR2XPeTLdA/38?=
 =?us-ascii?Q?E3lOf5g+Rg3umZjKdatXVREH2n/K2tUGgyUS+qwuTqKpzgCV9teKmYQTwR64?=
 =?us-ascii?Q?Bvzti0IHp9zVgcuRsvPFZqwa98G3Ff3/SJgdVUYTZtfNVUSHCt9aTPLQZdnK?=
 =?us-ascii?Q?G/xHPtosEeZSgonWzJ5onrqDdDHIq6ixSYszlpma7lvNjkr5kTjTkJIcHqvI?=
 =?us-ascii?Q?O0kQNlt/kaQh9/RU/HeIwEcqd25GiwDmP3eui6eUZ2sy2ucqIwgVj/k5hBYT?=
 =?us-ascii?Q?KAwauokfKZKdKvlfzQrSlXz7MnUc9XGvkm8oxKRvLS7p1+SGQNk9zUxytB0m?=
 =?us-ascii?Q?FU4mqaQ4ACKVK47e0Fxbw9yvNWLR8EDSer/taDtfcQ9oHYvzSj03ckET1xc5?=
 =?us-ascii?Q?0fx6VL7T2YZX4e9EvWMwY9+EFdj0zR2R6lVnZBKG1NadwfkFqxBYDxKkIaDr?=
 =?us-ascii?Q?wbTHEPv2w4VMSBwr3YJ0K8ferXiOo6NjQYLd0A5TI+PTFNvAOvnEw3E/TQzx?=
 =?us-ascii?Q?eazeBuO6bIT8R6oB2DV4lWpf7m4W4Ui1qaT1viN3T9ScZCWLUGlUR9uL9aNf?=
 =?us-ascii?Q?Gvj9XGOwvX2ofen90+q2JkA0rBhYpXihvLuDpU8xaGwePaUXFNgInAs7CfTM?=
 =?us-ascii?Q?YtYBNJTf/3fWV2i+K960DcrKQK1G/S6NgVi/GUmwa5s5yDFjfTUKGtHtGUq5?=
 =?us-ascii?Q?JFhl4iA0heBdHwV0iSE9JiIB/UFUqkq3LuUm9PwI4kpZX4DJgbomHRwttuMv?=
 =?us-ascii?Q?SJUywY+6ZCsulQPUXyGDaplNJiPGFVW4/aOcF2dbF0EGROcWYzrOZTGg1udb?=
 =?us-ascii?Q?Pjqd+fMlRLnCi22quAvmbzak787JNOCQtNK8k1MpmqGX84aqEKQ8lpi/5uYa?=
 =?us-ascii?Q?7eZHOQa5iosqHqkVHhlU4tnBQGt7rel7VAuEMIqTGuInPeifg3gXWKNQjkbF?=
 =?us-ascii?Q?P3+gSh7lVXZJrqA6/Rg9XZ+QjgNR88So3qLW6HkZCyETKM9rZ3x+DPa7dwfm?=
 =?us-ascii?Q?KOrWoBy/xFUdoLY2JOPQsGaXX2cCzuIYvDCvUzsogynQZvSFydsLDWQ+IFvx?=
 =?us-ascii?Q?ozgvPu0xTybGkvRtJ9fZ5GXnEO4JVDXSJdkhkm60PWgk+kfSQFyQDFVx2uOG?=
 =?us-ascii?Q?dicswHj3qBE1XKQLIW1IhHC1PQdW7TB9Cd8Z5ZJ7f4BtakH/YNWYP2w538CU?=
 =?us-ascii?Q?KgDL5m4Y8JAbbQA3I5mG8KmrdtjyzliJC5ki33XMECBDZ86N3m0bAUMSk1O+?=
 =?us-ascii?Q?NvQhM5hj3e9XGvAp8WholB5h74/KWPHXIl7swHF5qZoa6X4g/gq0Z+YzeU2M?=
 =?us-ascii?Q?LSl8LM+Di2GOhivZrBUK9zLYJk+AbnlvhoZJ5HE1C+pBZSDfxg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8247.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mrUXNGkSNC65AWsXCrihvdJ2hLePM3uJcdb7TfRYyA8dO9VP0cuOLzgTldlz?=
 =?us-ascii?Q?CZ1/IeGwWUON3BUrFDTEJ9MXCXRc1eYXv1O4JGow+nm3dF5CaLFve3gNBBjB?=
 =?us-ascii?Q?wuDeeYzuo5EgKaWjzvaJk6ocMM6PaPCwaEE4b9uSL2O3cGOhzwOrWJWqD0hS?=
 =?us-ascii?Q?ptu3hlM3eD09RAIiiDDh6liRoc+UProYK5XBgOojNckg45ogZPqDM5/QbIup?=
 =?us-ascii?Q?2k0avtKRGqVAYK2plQp2fpG8ujqMZy9g24aYCMQrPmIClLa/zxP8pxbsvU5O?=
 =?us-ascii?Q?Evamak9qQnCgNF8KkNR5cV9bRyu61U7WqiFA7r0k8xE9W3BlN8lzTuBdJC60?=
 =?us-ascii?Q?OCtWn1TigjQp6QJt9gnZQeZFxUG/9WZj+lsDLe3epGAhOFi51aXxX70XEOSp?=
 =?us-ascii?Q?SfmRcOBl4i60rB4e9VrEOQAmXc/kiD0TP4hS5ycZSJly/iq1vNCqV2RoTT9m?=
 =?us-ascii?Q?GKq4F1wEK2YbwK7F1GdszM9iOf5KEE8zCslbsUB2cZoTfhr+UWeSCu0IYPsk?=
 =?us-ascii?Q?ZyCpXs1JxDXHfq5y0uGeVPP3Cz/BdlXL3UA9XL31b3iQu4v01atRQmh+RgRY?=
 =?us-ascii?Q?k2Wr/w2JNtYfa9SnBHaFpBrEI8unqb973c0JT9XYgysKftFm0Ofd0DD0YjjM?=
 =?us-ascii?Q?33vu6VOwi3PqOn1vkUYnTMwlk06boQI6ANed/rQCect9CrLLrVNA+YZ4ylEj?=
 =?us-ascii?Q?7g/LCRd6PYEE2XjvZkqcqMv5LpIZlVNQZfMEvgBLfLojNHru+XnIomkEvnT/?=
 =?us-ascii?Q?NmOMlkmedTLWHfEsN1GrAPXfsl6BgyMfMElqEe8USwLtUHlLIsim5ompySo0?=
 =?us-ascii?Q?XyLNEIihe942x9AhQRDOwFtkytTkIGXhDrgsDVQ+2ob51jYaGTD7RSX/xcoY?=
 =?us-ascii?Q?miYzbneCaoOAVWi40RT5ee3nvDoRlYaEX6v83HLh3CPuDVfINDHX5yIXzZEV?=
 =?us-ascii?Q?0sgXZdQeVD1/ShB+r3mJXuxedOt2kN6tdfA0DvAEmQKj0LV9NXEbcqWAK8U7?=
 =?us-ascii?Q?jvktX2xBn7U0nXFrWmGUZOg0VqBd6nEwxwius8QRWlLuBPyxnMxpjXLthTU0?=
 =?us-ascii?Q?LZldLJQI9mrYkjSnJlaSCxzokw1Wp6KCTSNKnuC/bsVuHbIdrm5VOCYFD65T?=
 =?us-ascii?Q?1ueXMDblspju/i8d/bLEbfXJ4usy280XeRp4beSFpEMW/HJvYZw2MvCbtUOs?=
 =?us-ascii?Q?r/+KXVuLyGsMnAgQVzWXmVCZsG2svvzLoP3G+SYJUQGcsDe9h26QebgcYN4O?=
 =?us-ascii?Q?OhbQg0BDfPq0D5GrPsEqFsMKNt0ru1yuUY15WV/hYA3Rjtkt2Iopr8oHRXUV?=
 =?us-ascii?Q?WNepRU3CmWmJnaK1k5mUFkT0MV/vkGmm6VSufSOSvXHxQ9QTc8kW2kH7pS8F?=
 =?us-ascii?Q?rouE2rzyot8K9ql7ad0Qg+2k4dpTtI2FsKmtT5Nr6FjCVdz5qKLs0KepU/3r?=
 =?us-ascii?Q?bHTsr2gmdmoYe9BbbAzZnTBi7ejGqPGsW4JRsX2Bf83NkY+/YcbyQYGKFQQG?=
 =?us-ascii?Q?93vS+7tZoBy2Vi0iuoE8q9KYf+ThSNIsmRouvHHfADf1MXqHlqfXN1nqEwEN?=
 =?us-ascii?Q?bjz8SxA+6sKXGO0ZYCfFQcU0czrnxTJjYanvSg++?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e3c0e1-87ec-466a-5741-08dd0d651ab4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8247.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 15:23:24.9905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JaeOaZHwF3lse81g/jo9OM7Vm9fsKWoB8FaL3fVrBnUjRRBllFVN38S+XpOEOYLPwF912Pim9HSQ4cgtQip8gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10886

imx8mp audiomix contains a set of registers used to control
the DSP.

The dsp will use this to acquire o reference to audiomix registers
and handle the registers to control the dsp.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml b/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
index 6588a17a7d9a..f368682f3633 100644
--- a/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
+++ b/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
@@ -15,7 +15,9 @@ description: |
 
 properties:
   compatible:
-    const: fsl,imx8mp-audio-blk-ctrl
+    items:
+      - const: fsl,imx8mp-audio-blk-ctrl
+      - const: syscon
 
   reg:
     maxItems: 1
-- 
2.43.0


