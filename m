Return-Path: <linux-kernel+bounces-522306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 678AAA3C890
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CCFE3B80FB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9B122FF33;
	Wed, 19 Feb 2025 19:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HCKYOaF/"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013052.outbound.protection.outlook.com [40.107.159.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F35E22D7AE;
	Wed, 19 Feb 2025 19:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739992903; cv=fail; b=bJAItwhKNwBi2kbBPVGzw8mrcbrtBGy4OTLIpfqxqXcmT3Avekz0vqb78rgzX2Z9YC5fDvrG3vVmrbru1Fy0+DpFERhRbtOKFelNI3+nnuPQSNve+6yl1aqxrpy8vamx3kuPibgScvHk/e/DrBYMlBc+ulbJSHQ+OZsjfDWzfbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739992903; c=relaxed/simple;
	bh=U5CLXvnsBzatKLAm/uN26VXbfOfd97ayFShsk/FBx/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZONi0g1iAv0p4N46bHpfxh9Ng94X3JOvCAB65gjLJUdJeEpR5vZjYYHhhVFqaqPtTqI54XLqICWn1ZMfPXvtWulwx5yxmrcx8vnr3hd/eUZ98U2l41xcgUG4FQdFia06J3WS0XPzy5Zpn2Vo92QeriXTuU8fmS24rk2a23o6D14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HCKYOaF/; arc=fail smtp.client-ip=40.107.159.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r8hF3w10fm59iPVJmSsEbtqyGvRABnjzFSSUAg57BMNk9XApkMuvTMmOT++BG93NH5foKR/ha2isoJvPUGrIDyDcifQjLQ3fvxY4AGvkkSD4WfvYKbfqa9EgVXK5fbwGuFfEteKDx+wu5mk26vOZl5YfnVt9p5FxhzuT5/9t8LnKgXqN2Q1r3Koe/1ydRTM+r5eaVHij3SWpxIA0hfRLxvU0OEGNhjplbhHsG5UHFp0QcEM9Xi/Kn20NQlfb8VcAcRKFQGT/ILulXyed6pe0Inp9abA1jS9dIC1MMMfUV1asXFrL9ucKssnwcYqH6HtMRPCoBK08gL3mcDyY+M7MkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPOKqEJeCmWWLIhcO9XMH0OhhNUpUlopqz2+jjUtYP0=;
 b=LjTHIkquvp9ArLPjSMHFed2/FcRF4h4rm9lhdZQAC6iwX+kafmQ+nuGUq+5gNz2KmlCTBX6WSjAt5EHQfjETtG00ipKG2TPy86hQZgKvualRCmYcFvQuLwQOrZ+G13wVkyoDhw/yEa9dcZXbnXqRM5J9mkw44Q3pFTgqbBO/tPTMF8lBmHHssL9yU7g4pq6ppUJ9PhVTb8b776bTHY7WU+uYmOl0cN2MAIUBUaSo40QT2Hxz9ZI3qMFVricB+it0vLkI7Iw5ggCVjhSQBaunwVxBEYadTmtoGi9tdZ1OTuCAOg2/1XpPD+Xa0bvC5AmxaTrAUGwis6+43gqtrho6ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPOKqEJeCmWWLIhcO9XMH0OhhNUpUlopqz2+jjUtYP0=;
 b=HCKYOaF/HxR+aohAuVhvX01+hcw7ktwWSWpx36gnsw/ntOLdRbNJTu1iW1XdgzSQF0CWs3vyamyj5cucnbg9vVyLHm2sNyQ6g7U6QKuVAJZ0jlC1moD/mbrGnhXd5IorieaYHX9VNIt/x4Rt+u2pWnKvti5/gRBGIL9Eo/KLKZu7lEj694PYeyNEghLRGUeGfGKilnkleRZw3YIXzPXd91ua8KZDZOVJJHR9VJk3CVcACvWwD7nqfVsqUujSCIB/wweV9qlid5b8UpASeqAf2kVdKeAEc3yt+KfOGUOixlct3G0YSvvLnLIRt7KNdg2Cb1/UUnpm0w71giTOOu09lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13)
 by VI0PR04MB10951.eurprd04.prod.outlook.com (2603:10a6:800:25c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 19:21:32 +0000
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6]) by AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 19:21:32 +0000
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
Subject: [PATCH v2 8/8] imx_dsp_rproc: Use reset controller API to control the DSP
Date: Wed, 19 Feb 2025 21:21:02 +0200
Message-Id: <20250219192102.423850-9-daniel.baluta@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 21e2e6c1-7a02-43d1-062b-08dd511a9e78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|52116014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8zCx9FCm11beQKkFW9tsHg86YFVvgmnE2a4N0jJZb1vso2vbrNUToAoPnYgj?=
 =?us-ascii?Q?jA/18AdVRvMGsVUqNh/MaWIwA9EnoaJ3Q0hO+CLJZUb6ms5iWnIYSP1swkwJ?=
 =?us-ascii?Q?I+iYdwGZ6ErmWDdqg9TLjeDxaOo1M0ciLSC7I2w7B9RvNSoKuByA7zdQtL4K?=
 =?us-ascii?Q?vlzajrproKq5Tv5PIFYMFbuDB9M5qnTN32PcJVY0OocKxMC2bDzyfap7rft7?=
 =?us-ascii?Q?aIO9KmeE8iqZNWTl1y0duQNI2FDD4QAZXp1EQdh6f1nHCZxFSyelK6vaY9bJ?=
 =?us-ascii?Q?MgTdng9OcxJT5F5CvCSvc2LaEhWED6US0gnuYGT8swCVByMA53XXxna2Kfsd?=
 =?us-ascii?Q?sn/kYBfr10lK/e8WtrkjAj+EX1PNAD8XpiZ/3OT7HXt25TUmovhO/l0NJsLp?=
 =?us-ascii?Q?mFVhTiXal/sIAaFlMuPeYDCyKrxues6WAt/sGbskSa7EK2HrlEg6vKAVDng9?=
 =?us-ascii?Q?lrgVJwIeF7jIm9dvBpZ7Vu71KKee3/przWiXMkoA7wrwKYHT5vOWreAN506n?=
 =?us-ascii?Q?jfJHWPNCP4dwG6IsCCivFfI1MGmuR/FwvHCiFPxA4Xq4r+QdQtfo1m38hJpW?=
 =?us-ascii?Q?ZzOotNywM4CZ1JDn60ywnPEWVMTDu3JeVUk1vjOCmJqNtzKleFxtPEWULV0z?=
 =?us-ascii?Q?Z53/LHRVeL/r9kLUmtkNaiy3F5IAMnDsnr+7sk4bxF9UQfyo7/KWt0f2OdcO?=
 =?us-ascii?Q?JPWfO+yIh8hShi1HX5X3OqSwpLo7HyMbqQ1k+FHAjcoFtGc6rj8M3LMBIDlt?=
 =?us-ascii?Q?nfHRmJTVkKEu575Un9FJMX8wkpu0DgBWk9Tt0jfoLGmarL4V1u8iMaRgX45D?=
 =?us-ascii?Q?MfQiHpTAnsF92jpc1ImXO6sreQiuB+FRk1WiWQP0n6PL0ZKFELH08MN9GG4i?=
 =?us-ascii?Q?//yguYcvVXGvdro1Dyx77disDbPSj7d3JrVkM0aP3Ua0dSnJxZp22E5aKGAL?=
 =?us-ascii?Q?rKhTiHEN0BFYeQ97LhS8mLC2vRve7lNhHqvqnpgE3oQOxSqKG0WN7+51Esv9?=
 =?us-ascii?Q?9/AUu9fS39AajLIvpmC8ESSE+LJo6uaY+LDsuZ1JBgmMcZOt2w4cd7rrFmH2?=
 =?us-ascii?Q?aZZNayD81gkoUCeOXtMc1UHSnHyxwSXhwA/KaYjXjOh14U4qjEsXsoFjkrvG?=
 =?us-ascii?Q?GTzufPnXu//yQY1ljvHYPYPUUR2IWyVoYCmOpIjz9GzHwkSxKG1xU8tDxaX9?=
 =?us-ascii?Q?QFMvk/xARVbsF4B/DMw/71Ce7vMREyUcS9zMNhWenBm64LLTpNf+j3USgNBs?=
 =?us-ascii?Q?4G1HxQS5bRdy9fIx6GhtOTwrzRXKMStrdf1aFIbjkcG2aX21W0Rni7rIlObX?=
 =?us-ascii?Q?xw3TkDSikdT68w1FE5TL1QkGg7QL7CAI5tt2wtPUAZLLZ2UonFkI41NkuiZo?=
 =?us-ascii?Q?xUNqiY+/GP0WQaMbr2KrJgh82KYA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8247.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RTWpewEqrPV8D0sINl+Bpg8wWD2llCAzvcjG1GJfv78ghOyMCa+o2m54mmyZ?=
 =?us-ascii?Q?f/il+ByZHcnStfcwhQvLvviUWIj9phd0RFlag5lQkixDgyfk0+nVzX3C/m5j?=
 =?us-ascii?Q?jXF+DbHSQHWb8btSVA3jKYw/16uUhuXZTfMjbXaDj6/g3ssgtQN2KYHGhuhH?=
 =?us-ascii?Q?6K1NYCJalMc3hHLQOK26aPwzkQuIkUr14aJdqHBL/yvcvSNy8SYH0L0uIQad?=
 =?us-ascii?Q?6hbFZOIa4DZiJjb0MNk1mG25F3FuvEsH75ycwStLLhbnDrTfkSqZHMInvFoA?=
 =?us-ascii?Q?0J8r358S2KYfroOBpjtTEwClAC/h51HC22zZ72eUj2b7BwfdfeUiRiaQFQ4E?=
 =?us-ascii?Q?ttv1lILgXPDBQmkhkAtP83xOe7+LfOapGX0Hf0K/jrUmtZtRytU8u3910A5r?=
 =?us-ascii?Q?0sRb+L4UxDCHaAP+U/Pe1ySRLNOFJju2TA64j3aHXEUEmYStyl7nzjsFwW7p?=
 =?us-ascii?Q?6h3dLZIl8OmNuObFUC3L/9xfsnOYHmGhjgk/ZabThc77PixvctnQd4GZiNnb?=
 =?us-ascii?Q?PJrRk/NQUDp+aVKmIHdyWsHj99af2ytKSC4o0lwvkY/8ImOcI9eCVUdDMT+Q?=
 =?us-ascii?Q?DOiCIn2f+If714Aqeal3CqA3hH343oh7S4BU81EqpDaW7jrIstmKWl2DUE1x?=
 =?us-ascii?Q?KcYm7YdIFAoNdciVquDaixs81p/5ZahyxprxWTCrOyogqVxYilQNJ96A+uT3?=
 =?us-ascii?Q?gqeBhHNJEbsOd5M8u2hhYjQsRhM2Jbng9aL6FovNijo1J0DgWmZhtZbtafsq?=
 =?us-ascii?Q?qGiynZZOpNyvKnhImjpvvx0dJ6aZ+zKoscLnA3D6lYsJRBMZPmetSySzvHVG?=
 =?us-ascii?Q?7pOPhtFOl2KVxNqi6ml/Io8uyzw2z0mlngAfaANpCtaBXLR16FtM2CJ0iIWL?=
 =?us-ascii?Q?3X3iEzuuDTT1b6fkTl0oHpX5wt7qUb1iN0SVGCjeCDJy3fOVgSoQtni9ra3k?=
 =?us-ascii?Q?skGQjrTtnBMn3LZv2nTYUhw7emEjuLd01pNnUv/nNN6Sc7kW/RSnVPwsI6Y3?=
 =?us-ascii?Q?fQ+JahalIVeoP+P4kKI6BPardtT4CIV4RpND8G+3ROYM994E0drd7du0hpqq?=
 =?us-ascii?Q?7kXftGiYB3mR4oAlhk7a7hbkWCle+Mw858jrer6UuvAoa7GVhPCU5EjM2xWO?=
 =?us-ascii?Q?fn9VaQuExQFotxHr3Lbl8vv+KoGkYOjjOz0UrKqB7fBuzd0AnztaIVSE1+9H?=
 =?us-ascii?Q?io21UceA3ZSpi4xEA8eXmYrkFQL4U4eTHws2NEs6K0iKBq1C2+6Pswo8kjTs?=
 =?us-ascii?Q?/+3vMQ/+UgqDW4BWEm+vy39lweokSv/WQAuakWJZeLMqHOiH1cHpfV6inbZa?=
 =?us-ascii?Q?HnEqfDuUhUCp+Mh9xcM0qWycQ32QSMFRDn955inkxIOgL50J+1eyEmg6LOVf?=
 =?us-ascii?Q?5WkIwBMwYnLY8c7X1Ndcl0PyaRVTUH5yu8MrnXGqYQJhZTv43yjgWgabzl4y?=
 =?us-ascii?Q?Qty1sc92fbPfVnsEkouNOGkFsoIqiDJlisCM3AZI+7Wxnbe5ViwsPWhGGhWy?=
 =?us-ascii?Q?8cnHZsNVBn6RdPTOu4nEKA/m7Jqkymk8Cu+RHTAJ8tQEnUzoV46pkAHEHfom?=
 =?us-ascii?Q?MPzqChG9ZItF9/vnIaAAMYYWuznYRBOZUJH0ffgs3LDXM7wb13UKPgLEuqqx?=
 =?us-ascii?Q?tKdG70JJXDygIUjVAMju4eVmyIM0bTVq08DtqrFX0cit092kl8XKgBiVR1SA?=
 =?us-ascii?Q?kekmDA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e2e6c1-7a02-43d1-062b-08dd511a9e78
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8247.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 19:21:32.7662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XYkx7Z49fZse5+NDde8Olb6ClWVG1+Vl+BTK4jJJ7mFtbPlP4zqBdvItYcj1JrLVvB+oR+mV5YyaajQNpdb7bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10951

Use the reset controller API to control the DSP on i.MX8MP. This way
we can have a better control of the resources and avoid using a syscon
to access the audiomix bits.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_dsp_rproc.c | 25 +++++++++++++++++--------
 drivers/remoteproc/imx_rproc.h     |  2 ++
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
index ea5024919c2f..631563e4f86d 100644
--- a/drivers/remoteproc/imx_dsp_rproc.c
+++ b/drivers/remoteproc/imx_dsp_rproc.c
@@ -19,6 +19,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/remoteproc.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 
 #include "imx_rproc.h"
@@ -111,6 +112,7 @@ enum imx_dsp_rp_mbox_messages {
  */
 struct imx_dsp_rproc {
 	struct regmap				*regmap;
+	struct reset_control			*reset;
 	struct rproc				*rproc;
 	const struct imx_dsp_rproc_dcfg		*dsp_dcfg;
 	struct clk_bulk_data			clks[DSP_RPROC_CLK_MAX];
@@ -192,9 +194,7 @@ static int imx8mp_dsp_reset(struct imx_dsp_rproc *priv)
 	/* Keep reset asserted for 10 cycles */
 	usleep_range(1, 2);
 
-	regmap_update_bits(priv->regmap, IMX8M_AudioDSP_REG2,
-			   IMX8M_AudioDSP_REG2_RUNSTALL,
-			   IMX8M_AudioDSP_REG2_RUNSTALL);
+	reset_control_assert(priv->reset);
 
 	/* Take the DSP out of reset and keep stalled for FW loading */
 	pwrctl = readl(dap + IMX8M_DAP_PWRCTL);
@@ -231,13 +231,9 @@ static int imx8ulp_dsp_reset(struct imx_dsp_rproc *priv)
 
 /* Specific configuration for i.MX8MP */
 static const struct imx_rproc_dcfg dsp_rproc_cfg_imx8mp = {
-	.src_reg	= IMX8M_AudioDSP_REG2,
-	.src_mask	= IMX8M_AudioDSP_REG2_RUNSTALL,
-	.src_start	= 0,
-	.src_stop	= IMX8M_AudioDSP_REG2_RUNSTALL,
 	.att		= imx_dsp_rproc_att_imx8mp,
 	.att_size	= ARRAY_SIZE(imx_dsp_rproc_att_imx8mp),
-	.method		= IMX_RPROC_MMIO,
+	.method		= IMX_RPROC_RESET_CONTROLLER,
 };
 
 static const struct imx_dsp_rproc_dcfg imx_dsp_rproc_cfg_imx8mp = {
@@ -329,6 +325,9 @@ static int imx_dsp_rproc_start(struct rproc *rproc)
 					  true,
 					  rproc->bootaddr);
 		break;
+	case IMX_RPROC_RESET_CONTROLLER:
+		ret = reset_control_deassert(priv->reset);
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -369,6 +368,9 @@ static int imx_dsp_rproc_stop(struct rproc *rproc)
 					  false,
 					  rproc->bootaddr);
 		break;
+	case IMX_RPROC_RESET_CONTROLLER:
+		ret = reset_control_assert(priv->reset);
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -995,6 +997,13 @@ static int imx_dsp_rproc_detect_mode(struct imx_dsp_rproc *priv)
 
 		priv->regmap = regmap;
 		break;
+	case IMX_RPROC_RESET_CONTROLLER:
+		priv->reset = devm_reset_control_get_exclusive(dev, NULL);
+		if (IS_ERR(priv->reset)) {
+			dev_err(dev, "Failed to get DSP reset control\n");
+			return PTR_ERR(priv->reset);
+		}
+		break;
 	default:
 		ret = -EOPNOTSUPP;
 		break;
diff --git a/drivers/remoteproc/imx_rproc.h b/drivers/remoteproc/imx_rproc.h
index 17a7d051c531..cfd38d37e146 100644
--- a/drivers/remoteproc/imx_rproc.h
+++ b/drivers/remoteproc/imx_rproc.h
@@ -24,6 +24,8 @@ enum imx_rproc_method {
 	IMX_RPROC_SMC,
 	/* Through System Control Unit API */
 	IMX_RPROC_SCU_API,
+	/* Through Reset Controller API */
+	IMX_RPROC_RESET_CONTROLLER,
 };
 
 /* dcfg flags */
-- 
2.25.1


