Return-Path: <linux-kernel+bounces-549434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8567FA5528B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A40116E1E9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AB325CC88;
	Thu,  6 Mar 2025 17:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RriOG+7g"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2088.outbound.protection.outlook.com [40.107.247.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79CF25CC6F;
	Thu,  6 Mar 2025 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741281031; cv=fail; b=vAEoGmPPN6rE0iAJ+MHy0EzWmS+o1T4KAxE925IalROMChf5DO8Oc743fkEiazmLvQNbm2YMSQy3LNhnogBWzssNyxnSrOlcnoyP0g34T0IfIKC2J/SGECEFqJ4n2vjPhxCogx4NXhcoFVyQi9d678O8n5E9UITEH4izITIfEj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741281031; c=relaxed/simple;
	bh=RhgcWecCB5ymIJAP9q5she1u5wTru4WT5+PSthAlN9U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Kkj+BWkI5rSv90ZS5hhU3VotmMzmmGRpjX63Ng7KewWTUpREvoC7qMZJ6EtlY0eG0zZybyeCPRFweknpDi8qQCFmzhJ6IRN3hjvVmCQeg1juPUVvSwCpr4PRmdBnt4e5+oyuUZ1EAwNsWzldDF9fQaAj8pWfG+nUcZPqdW6zIas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RriOG+7g; arc=fail smtp.client-ip=40.107.247.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ThImhpGVr0e9lt0NBubKchmzFuTT84B7uS+WkwHqNCYD8fgmLT0LWzv8Debqi7MW8b+x/HS7npZW8BamJeT5uSV9i8dPy0czU9bFf3qSiyHfF612rMlqpsO+RZwQw/Mq77/OHYAkzjER4Xo0wRhZEXffLyMPHGuHz6zylhDyonu7UaFdF3NBgxFIh9vjFcOyJnSdIMmmSULarlkUclsqVk0nhTapPM06Hm6RMPmMPeB8bAQslg6VjWyXzgYN3nfs8kzRGYkaVp6K6UmuNfFH7SqlVdggEQMHAJyUAt2R2YRGmYnc3WcwU19iLnkTII99vdWKO+vE3NN+h3APV5zPZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N8uYzWSlcfh17KN31ATOpS25wVc7en56G7rXDXNMZC0=;
 b=xf32YaLAbaLLujy2ESKelcF9JcF7fQku0Bo/kbOiNEVFtFHCSPjj9zjxHvXCHj2H30qzTsM79N02ZnP73QEVHr90FCRAj3uFK3orR0OD62fY9QJaoHDAVU0Gs7pVC3l9PckCI8mTzkGkuMCKeiitaanHAW4qZozO52Je8ez4W6swiDDfR6p29Od8HPPpYmdvwV3+Pyx16lX4IQjOCOQNkUkp5IcRLi80RrqI4REE516Z14IbTK2S09BbsXAIDKSvzISz4e1qRxxAAlyhvzMyd5cMOXvJ4kKain37zFHTiLokxfpLC2jsWS0BSdhrmzM9flop9Jl7RLFBAOXC3Yx+aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8uYzWSlcfh17KN31ATOpS25wVc7en56G7rXDXNMZC0=;
 b=RriOG+7g7pb1turvJp82YjGTdYCDlBom2KKLhDiNy+wtZ4q/JrXrQoyjdEZxmgGBkuwFv7A46RRaE7TBH72kOipkJNjJSSGb/odvhfWWZdQCh8bCTdIOy+Tz3ZxGM4T82N8VcT9QND+DKiNfLxIHkaqe/JYJC6KvS8hy1w0YHM6jE+CBtljVio/xvvCJI2coZVJU6du8dWtjIF0SD57WDR9+cfrqWT1XClkeC1FvaRRanj+NWJ/59uP6nSAXdcyLLfxCkvDwRy7tAvNtzkslMpSzq0/3SBW2hcPZfY+5EP3pHW5gCMqK9RCoDqC+9EG81XLxonEm9Co5zGRcAz3lLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7306.eurprd04.prod.outlook.com (2603:10a6:102:81::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Thu, 6 Mar
 2025 17:10:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 17:10:26 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	linux-sound@vger.kernel.org (open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM...),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH] ASoC: dt-bindings: fsl,sai: Add i.MX94 support
Date: Thu,  6 Mar 2025 12:10:13 -0500
Message-Id: <20250306171013.243332-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::9) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: c3423acd-968d-4ffb-4fea-08dd5cd1c9d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eM24sis6LXoV/jkRyopT/mEyA2X9a7myVMmE8p6sI1o0oNzrUN9Hx8lhE1df?=
 =?us-ascii?Q?/Di/+1HMr/4N34M7sExp6quZZ4C/QGQTcPXF10oUg72uD2ZnLYDwWbU5yq2e?=
 =?us-ascii?Q?uVmiLCBxXCHaFxq2vXpxRoZ24uunPFJ+6C0xmXUNFERFiSOotgtlkyJuhSeA?=
 =?us-ascii?Q?oYhsh7h/ZmfjlQuz7D7oLQ9JKi+fEvK3bvd/yvVBg225RIvJkJ86qfgo7k7k?=
 =?us-ascii?Q?HjonhSJMP4z6O3SjysElO2NwN3q4XXlmXW/cfBHUvVnytbm/IbFb1uI3E+M2?=
 =?us-ascii?Q?iTi0g2yun+Wr90a83ezEcQLlzaOEyjzVkTwA/Sx33cG2qHcEmaASh6td+/kJ?=
 =?us-ascii?Q?Qx0HyqDmzn/ZFM85+DGU4h70L+TMWwjQYOuHJ3W1oabEkbdd5LwqFiQfR4Fb?=
 =?us-ascii?Q?f1h+f5AHU9zT8hJLpixhGcinho0ZKd6HIPm+pxBxwZP2gkMPQetPjMQlfM4w?=
 =?us-ascii?Q?bVRSwtynDTYg3IsHinMDxjZr//ps5RjP8i3JE7kgKqV9ZPIrREydLIT37Ohu?=
 =?us-ascii?Q?WUwHeJV0FZ8+3Pjadxxp9A9RipOUklty/wOlg0B21jBnR7Xlds4m4OKtJTIe?=
 =?us-ascii?Q?20rG4wq0vjWmj983Ue16DxoSfqmU7NT4dhusLriYNtN8rHW8zoC3FGI0k8rz?=
 =?us-ascii?Q?MuSL0ORocJ2QPYNt4rSjV9hl3/UndNEtBK6hg6xj/+DdwcqZXJQ8Qj6rwY9x?=
 =?us-ascii?Q?yWNBcbTr+a2UuYufNKPAZMpatdnfr7qDQt+RJgUwK8kDdSD0p5tIFHK3Kjwl?=
 =?us-ascii?Q?XuCdc3n64Rvk6Dy9LDJA4mjhtiAQbq60+1faFMi40OzS3fBzMKkLpfJUVZBI?=
 =?us-ascii?Q?cA9EpQ84osRCI+h2oi996SN01mTeYkmi3OrBu+IXM+7/L3D41snakNODZBCa?=
 =?us-ascii?Q?ZtChSOmVV7ba9O4k40rBgdSiiABTFs4b+2Iz51lkR/0Y6/coroe+RPSK12zJ?=
 =?us-ascii?Q?gN8DwQDx1/2g54pYpDGf7GBoXNeeCK7aAd6x74dvFq2GDebrLTW9iEvhcOzr?=
 =?us-ascii?Q?QOTvJgsb8V3NOCvfW4MwZ2rgRvzfTvELDHQ6UH1woIZJGDGiOWhzcieDC4lw?=
 =?us-ascii?Q?iSstZPbeQ+DXLRZT98Icad8mndTM3Jlve6OuTJfPwkRSQC/f5MdVOIDKu2Bw?=
 =?us-ascii?Q?PjpVaotu3jo4lnpVdfE89RI0ApAGRJ1ifq4oqcSKg2wnK8ug2GWzJ6CkwDnU?=
 =?us-ascii?Q?/wyyw8q92dKJq8yX1P1I/c7XfawEEJS9OKRyzm9awVb/5TFNDk3FqGV9sFfJ?=
 =?us-ascii?Q?URnJYZ6SdEP/JkrnKniY+Syx8XkXhaZi+cLQf349/hR1czo2GfcoKWyD/X4I?=
 =?us-ascii?Q?fUlXpTdHTM1CasqDjHadZG5ydtOt69e/zNjJpU2ugso2Hauif8YdXPxEwfsi?=
 =?us-ascii?Q?gy/MJqoxnMhR1srnqFQriZVaAih+1m6bU08VujfpjDNIqh9OvykxgWnrPGLq?=
 =?us-ascii?Q?V7zJWU/FnF9l1TdEnoCKazo99gLJFO5t?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+69QuoFnzhCObFX3LZO9bEXoIpHDihrOMFyyOBC8Sfz5RDYccQ+gUkw5aFgS?=
 =?us-ascii?Q?ZkalNvgM58r0vxdGvct5RrAQFkRXgPqmm+Xh/FFnU1r+rTHHxjAX5gUA6WYJ?=
 =?us-ascii?Q?n14e+uhxWYNE1hW+xkLmO0ZNI0w2YJcaECGM0zQiczYhocwKzD5ImZiXEbV1?=
 =?us-ascii?Q?UYU/agJ2cMZEi7Jg+hHNzHd0zZN2E/Ip6pyBF6NyfzrrNpxu32O4kWVGNWuO?=
 =?us-ascii?Q?XO7ZujAWeJhYU58/Y9rwLOYkzEvHt35s0KOdqRPsL31Dr6MPmHdDOz1Q2ns8?=
 =?us-ascii?Q?T01TypnSbPxWTGk8KLrbfOnilqFjYw6aNIAVvbpsMJDTA4pdoO7G9mDoulqb?=
 =?us-ascii?Q?d3OZLYHnxrEQARw5C5/dGhVNxyDA/WcO3lInVgX/r+AJr19zc6uZvqE8y6wi?=
 =?us-ascii?Q?EZ92bMBAyzdu+45Blk0V/lD0p3yXZd1d+uQgyBsPvtgZqTsFMYcnwB5RqJ8q?=
 =?us-ascii?Q?JFDos2EBCXhPkJpsXw3isPJ7VJDti6WMVbF9TSwJCXt2nTXM/3BDrQtGxpFV?=
 =?us-ascii?Q?xqMnVjWjFkRkW/g6wVMk0OkkPwcFr9iD1WBL3qs3yo1wbN+ZHb2OTsnu6V49?=
 =?us-ascii?Q?8stk+e1EjAOnMfxGfU+HPQVaKMFyx9ajYU5GWd5Mw4RyCh7P+w0fwAlaXaIU?=
 =?us-ascii?Q?4Fl1/cnNYBY7DWLV6+0TU1Mx4mBVIP6/f/J/RpiCUWiDMaAC61CqiNx2/VzU?=
 =?us-ascii?Q?9QhLKZXoV279bcWzMgO2Z06RiS8ec6f8zIKWda14olyQ55kGE6lCedGZPKVO?=
 =?us-ascii?Q?pzIfDel0qAP34qAt9AN09dYTD2KrvMfvcChAhQ6bw2U2YRdkJEiLpIiBn8LT?=
 =?us-ascii?Q?fYNwv2k33dCWwAW4rnT+wgrtz318Fi8Flz611vIGBOsNlSOLeE57pTheXDeL?=
 =?us-ascii?Q?yLFKZ1iB5U9YhcgQgvb8XAQ8DAi+nn/CQrymZEaN/Bildj2vDfPi5KogXKan?=
 =?us-ascii?Q?uzXmQvUrRgCxURG7U1/tWTiAzSyKcfkvjTc4xKfknCfxIBEOhU8paCyogFT7?=
 =?us-ascii?Q?BU7p9vd1RQREMpelMa/x566oO90Git6Pj7OPOwzDBj8RfSeqk7+lsv8DHEQ2?=
 =?us-ascii?Q?l/6OsaTntrYlsgJ5M6FrwEvz5CXwJcGOqOCXnOOS/WZn6VgEMudUwpQRKIoi?=
 =?us-ascii?Q?U1CxRQsdns1RxU8IECDZKUfgnFE95vLihgq9hGxSKP/IYVbJf9+RS1mYftyn?=
 =?us-ascii?Q?dWDy8/u+xyz1vheXSdnZV0CV14Fl9hVCSSTdEbCLXXwEm1agcpFOTomaF8Sb?=
 =?us-ascii?Q?jQvFy0a/2jrNoZqlEhn87gJN+D2rDXfbgXzlXkZkbVBaZxNgMa8FX/KfVzuy?=
 =?us-ascii?Q?ZsWFeuei1vx5UZ40ACcqk7qp67GDlnh5gmFbsTkLP4HuP3kXSs9kCw38DYHA?=
 =?us-ascii?Q?H2JJimZJinFJWsQM4NDid9yEr3LCsEXZheQeFdbfWEUEkE2SjpCgizFod0IC?=
 =?us-ascii?Q?iDluspPLI/h68fJFyQJTh+okOQspq3N7hnxehgu6ZhZYyZYO9NvSsyZFCGLx?=
 =?us-ascii?Q?V63cx4vYkay0F9hx/N7c+Er2WBTSFaaBtCPhjnRr8y1R1VC9V+jXGoXwixgV?=
 =?us-ascii?Q?XTGJONvwQdT6YOX0451UuSLtwZnGpTUJJkl4xp52?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3423acd-968d-4ffb-4fea-08dd5cd1c9d9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 17:10:26.3787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XLI1qZM050ATmJ6Mo+soSvIsjay68dGz6bN9Nzw9R/sjG8xIJorgKtjJI3YbReK/aOZAp9pWD41lAXKAUKo0iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7306

Add compatible string "fsl,imx94-sai" for the i.MX94 chip, which is
backward compatible with i.MX95. Set it to fall back to "fsl,imx95-sai".

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl,sai.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl,sai.yaml b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
index 5c95508ee7075..0d733e5b08a4e 100644
--- a/Documentation/devicetree/bindings/sound/fsl,sai.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
@@ -41,6 +41,10 @@ properties:
               - fsl,imx93-sai
               - fsl,imx95-sai
               - fsl,vf610-sai
+      - items:
+          - enum:
+              - fsl,imx94-sai
+          - const: fsl,imx95-sai
 
   reg:
     maxItems: 1
-- 
2.34.1


