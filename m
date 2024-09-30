Return-Path: <linux-kernel+bounces-344857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CC498AF01
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75790B22A56
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79281A305C;
	Mon, 30 Sep 2024 21:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="D5jNDzdV"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011048.outbound.protection.outlook.com [52.101.65.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C3F1A2C26;
	Mon, 30 Sep 2024 21:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727731594; cv=fail; b=u05UdRMsvknp6fk/oUKAgq2G98fQ6/77Csydlv4oz8JTVvkQGCZ07BBx5jymma6lY6O2pBZ6KTnRwQtpfspI1w7JWLYbsKHCVkvkV6kUDUqNkyLynLQ1RBpL4oQ40f1YUMKrfn6CVXHBopkCjtwK5j0sJINSpyIQ/N4ImrXsUFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727731594; c=relaxed/simple;
	bh=BMpxKPV0M3VVzuDfWK55PLiwyzdoJtiT6/mwhv8V8T0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FriWvMtAzPxGlV0Bkg3yJWKFabmSTtTccNs7CtjNFv1J559oExHn17ZhWNHLMUAkqDoNxQ4e3FT03WGta/aOj2yBSekQVReUoRkZZYFxc842PNWfQxMo0311qzFLEwoKgB0T4iE6Yxp+Qed9zuTUzeIk2rCtSGNpBcYFIAQu1/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=D5jNDzdV; arc=fail smtp.client-ip=52.101.65.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ROi3gyogb47Lz4TmTY42Kf0ZZgNSlIpbCUHu2wGLFdRjBWmQ0fYKLTWsqmKjOrkAppImD7DwMYInzWdRXrH+Ri46+k+noVZHSylydj78Hn8wdmBxD92XxRoLlWEVB1LciKHBDYsJxYazDrV1+j4Wy79UEp4p3rW+3/eoPrv1IPWozmWqUgh+6e4ARb7b4ap2Y/PWUsWrVH4D0mkgcjwaS7aWmpo1O4Ox97SU4IINmqp+bszOuX4yhBvx3pOPgXvaMRTbFq/WjC814xhoUjBEAyjy69MucF/1qkelbav/VL+4Z2/FETvyRTATdayCxvHa7waqpZ7P3Erzy4Yb69V3TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Eo2Zmje9R3tFvZhzAHPtxYVDV5qjfnxwx1R/DkUiqA=;
 b=gVSP9d7qzuNoTfHEjrQCSQsAcprdR7kefEY61za4o3BtUWmHYrzQiMjI4pgCTIh14PnTVb+1llfDZ6aq80WOe9JOogksOyroRJyHp1BMplJaGRtvrA0N6AUhl2oCuFqk3IyHmaYbgK0yEqTwXa58DyI+LciGDYBxOpcW5SmEIisHosOFOjtERXElvwQSKfPYYPOEwzvfBodm4ELnVB7b6iSJQUgeFxy7npX9Tv84qoCSj4WFR8Wx520kwKwI6HfMQoMBriM+WX75NlzL8cFoeVb7cGuD1iNUaRG8K/nWySqQRBHn70yzWJ7ve6BNuhaCfkLdRptzY6N5paXxs9gR3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Eo2Zmje9R3tFvZhzAHPtxYVDV5qjfnxwx1R/DkUiqA=;
 b=D5jNDzdVGo+v19/U21cAsGSxlGIfI3m8x2Kmaa/WcYSv/69alTRK6St4eeruJEkyHmKsP4MYz7B29XZCRvFhHBCjdvJJsaLLV2Z6iehkidVTqkQvabwzk3Udcm+7YSFklbZFuRnLgSCZ4N21VsiBv6TCNoGNV+x1tBDplPGME8ZEjlTV7DV55hPYlNjOTlicXxrHE0qwa2PzAy9Phk5OTExFKD5r5e0MvwG8PuqikqHP2StkhCUEgulqM9+2yHR43Si7PFl3U3ZHzXqq/J/MOUpduC2ZbziNeWT0nOLTAPIkfSNy1w9FmWO+T2qY5VgF9sKJLG71IljtVt4u6pudJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB7601.eurprd04.prod.outlook.com (2603:10a6:20b:285::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 21:26:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 21:26:28 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 3/6] arm64: dts: imx8qxp-mek: enable jpeg encode and deconde
Date: Mon, 30 Sep 2024 17:26:00 -0400
Message-Id: <20240930212604.118756-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930212604.118756-1-Frank.Li@nxp.com>
References: <20240930212604.118756-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0335.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB7601:EE_
X-MS-Office365-Filtering-Correlation-Id: 63b2c552-8c75-4d76-6353-08dce1968bb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EMeBMn8MD7H8pffeBBUqxASxKaq3YFxr8EtV5V1LUMq04XUrnoTrcpcd//z4?=
 =?us-ascii?Q?YKCOEuNfI4deDO/VneYANu7M7ZLRFFtxQRtrJectyRTQ8MvofywNN3dZP4zB?=
 =?us-ascii?Q?+fs8x0pze5YZpsrkBozs1sC6PE2QHNrXTcmgRBApYkUpXrVkU/+th5pIiJcc?=
 =?us-ascii?Q?H59TW02L0rBviGjJ8GYV4+k0mk4vmCLvv0cN8zj5At635qDIg0leis7niYIl?=
 =?us-ascii?Q?ivTTnfnsn9UXm9JfQTLpa/zDNxu+DRDGqMQ8dk/gzzoX1vDrIhDThFQSbmjb?=
 =?us-ascii?Q?x6mE0W4zSSMaDq+TUey82AdoZ+CQVIlk8dTPdVApGKYlf4jBUt8aZqXJS24+?=
 =?us-ascii?Q?T9WAKzw1QsOXZJUWzQJLMu70Pj/C70Jfi47jgY2x35SFZmZp8ObzFmun1P7W?=
 =?us-ascii?Q?Lrw9hLxF+NY4mRrjP4HAjXjVXNeiRL554fJOy+Wn5I5EJuNtR9jpaScwteY+?=
 =?us-ascii?Q?/E71NYAyp5XDWZsrUVPI9IZ5Td+N3RGKFYOLdnZh2WMTGsPnCPsphRkTDXY1?=
 =?us-ascii?Q?VeItrxJuFBBBi0OwAjm1ItZ8eEGPW5fH0Egq+dIG9+0Nn2xcztsXo99999Yu?=
 =?us-ascii?Q?I61AX5phQ19l9ih79BWQLPldwHRJsRI/0xu0o0NawXTOShMM4Y9UqWwhBE/W?=
 =?us-ascii?Q?dI/CwOVrlxPeseUYFXL0KGu/n+u1PDeUvzexP/hJWm+0JIqed7me1FhJB3Eg?=
 =?us-ascii?Q?rgtZk+9d1Jfj6wOxcUjQeVVzjOx8LENpR09aWunFXRCeF9wvrt4wh5Trs3SZ?=
 =?us-ascii?Q?tEjaZXawXjqlxSBlF4Gg/6OvTQsozkYT8oaoJJr9TONtYBK3v+sqWkLQNCYr?=
 =?us-ascii?Q?81fvy8axy3/zvezgUTmAyPt9WBFQf9ZQ+AMN0OpW9qi0400ChUb2QYIuij5t?=
 =?us-ascii?Q?2JN1xcxu9FGiRNGAmkWOBlrlZYgn91LbGiUynzJmQ5vdhnTucAvWcaLqK8Hx?=
 =?us-ascii?Q?c7fR6702MCee72yCb+g9DXTd/jakRG5vEj/x/M3vTdAGykT96UWu1/LNsd8y?=
 =?us-ascii?Q?4k4hwgm9Uk0M5yw6kxFYvhfeUlzj/zefYSTyAw/fDuS5xYN2ZGxlhaZf/jlf?=
 =?us-ascii?Q?IzyAxBJ8XqB17t3lS0WfEZ7io3qy0SprunUkiX4KMP8sYsSuEaNrf0hCxB0n?=
 =?us-ascii?Q?UgerGWCQknMjCMS9RbbLeg4L1UqPH2PBO9b7U+fWGOdSD6Qe8KK0fGwyI565?=
 =?us-ascii?Q?BiT5dYoOEW7xK3Dkb6sZNip9oubhEw1c/8NC/E0Sc5v4lLzOhiv07YHj92eu?=
 =?us-ascii?Q?B8AgOsZ/r/9rsTxFdL9YlABAR9k1Qr/Wcb7vYFlnarxgr4bNK8cT7bBQURxl?=
 =?us-ascii?Q?ehwzKeZNmWC6gsQkA8YjpIcoxQPu4YQ5kN5fueQCJrINiO4fncJeoN7XIRXp?=
 =?us-ascii?Q?nXNpmZxu4t7dhRFTbeP8UnKKBSYgGWim+gNKCQE2SpBarwfXBw3Evxf8sVyn?=
 =?us-ascii?Q?Jm/cUSkQz4U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qogk9pKFVdpo93S4gfc+IzIGEcSwXbUsJSmGfeXAp3NLilhn9XbDI6ZolI5k?=
 =?us-ascii?Q?y++65IJwo6C2gtP9e4HBnyQhdZBF8zXfPqLvp3oOhc+Vd5YB4jWCP9jhl0jh?=
 =?us-ascii?Q?Xf/euqoOlk0GLWozZ66ANP9hcmave5rQWHjUtHNsOCVDbTriV9x8pR2SqmLL?=
 =?us-ascii?Q?GWNAuJNfCTHCUXl3udRusiu0XAkAQX0QiRaQis3urKTJxGe4YysOB6ICxTLX?=
 =?us-ascii?Q?zN8pMKh0fijazwmLTApjl48c1/HtjQJgurwJheWZezy4FpnFbiELqke1N+rZ?=
 =?us-ascii?Q?E3bkeC8kkcJXGoTJBeK12+i1vEUZTaFlBHegU1YBHN+8KkTXC1m5g6sj2kiZ?=
 =?us-ascii?Q?mOY49Td6eoevY8Wz8S/G69d/RHHYVQ8hlqUvbW2w4y3jn2LBWiIaNoGrdr/N?=
 =?us-ascii?Q?NC33zdDr8gGokHr1qH8Ud82N1nhkAOiJ5Co55h4XcWBEKVvx7DZtq4zhYPT8?=
 =?us-ascii?Q?RlMP1dakCJze6FYtohKgiY9QJBqEZWPJmbuyzN3FpNP6qBEgQIFk5nFiu4RO?=
 =?us-ascii?Q?NzS9AkD0SH5pJhSdOx1+lu2OmdLPieLZ+ijoglW3UQGbf6YKv5do2hAMlpVZ?=
 =?us-ascii?Q?KfMQSHuzcfZLq1IlKjMw5nzlxU3Xj91YoiWAhoTRMMj7vUYqC+gPMUlxafg8?=
 =?us-ascii?Q?myph82bVbpulC55c26WlmZhHusU1W42hJT4Z2RIDDSZuvxZ3PgLHL8qa9POR?=
 =?us-ascii?Q?gTmcrT3sfN9EQvwo9wD5SiZqmWCJFnrix3kI0gKyrryuIDQpAaEY0vX85Y6D?=
 =?us-ascii?Q?a57sE3PL3Zv4f2WbXG+wsROUFWdwZuepW6f8qMYBUHGQouRu4hpTjnrId58Z?=
 =?us-ascii?Q?i39c4xW05oJVagz+gvQDqY8TxxQrLbmtgO+E1pX13IYYv9ctbcZYPWPJw5I1?=
 =?us-ascii?Q?Ui78af8XeTyIAJbtRB1koPedO2/1hrUZwPFXBfbtVwBVlCIVnc+pLlCd1TJs?=
 =?us-ascii?Q?0HfY3ABG1QGvrGqfSuDNtJmn116Da0jWrGQxNZu95NIUuX4coMs/KOyKjBZv?=
 =?us-ascii?Q?4PgD0ZsIUVJrM7j1x/2aVoJ3RV0dBUvxQgUbMvusr8DEcJ50pDYKIIE6uGAM?=
 =?us-ascii?Q?au7Ihvcxk9Vz/UAKg1hpHCbSp3JwvysvPhZsJyFZIWEWqIF+nSAhopkTqlR1?=
 =?us-ascii?Q?tWT2JUJF3AQWUNyOHbe3lrByJ7FHfl+AFzzRIXp2IUZu34r0zFTS/v1Lso+c?=
 =?us-ascii?Q?lmeRNqW/GApk3a6PNfhn/RjRBSqWwXxSYBU65Ms/eEFRk2LV+8jhYNlsksGf?=
 =?us-ascii?Q?GD/Dnidth9LydzrufRvCnxQR3AzHwDY58aJY52oS9swrmHX46D3ljxHWoZ5P?=
 =?us-ascii?Q?PCIhiODo36mIHl+lA2u4pbY40xjKuooWkGjKu27CIaIOviHOwx9U8HoAqBeI?=
 =?us-ascii?Q?oUSFDABGANEoI3sNoTiAvYbmze6SLnxcOeearxM3LNMUUmmT4HYKd4pMllC5?=
 =?us-ascii?Q?df4fwZL0/eqzTGZq0m0DuhTSjcte3nXAiikZ1aW+DxN4+B1VRB9cn33NFlzV?=
 =?us-ascii?Q?UOZAPxw4kYlbXyoKg1jxA0wYkHR7TV1OfepOkAYlUcNmXz7utrv6jh3rKTUk?=
 =?us-ascii?Q?lGyP2EbwvNR6nuxOwGk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b2c552-8c75-4d76-6353-08dce1968bb1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 21:26:28.7447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +TxbkHZMOExflLrgwmlaKwehczz9U5ca8nMOeFZFDfgGifi9wyx9bEzHQy5BsfznfZRGPDjGyLtHDD5ZOAm39w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7601

Enable jpeg encode and decode.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 9b9ad389a807a..505015f91c823 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -339,6 +339,14 @@ &cm40_intmux {
 	status = "okay";
 };
 
+&jpegdec {
+	status = "okay";
+};
+
+&jpegenc {
+	status = "okay";
+};
+
 &lpuart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lpuart0>;
-- 
2.34.1


