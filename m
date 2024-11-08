Return-Path: <linux-kernel+bounces-401393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C12E9C19AE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B849A286CF6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5BB1E284A;
	Fri,  8 Nov 2024 09:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WqOuVTWv"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2065.outbound.protection.outlook.com [40.107.105.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AC61E22EE;
	Fri,  8 Nov 2024 09:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731059905; cv=fail; b=UL8W03R20eLvbKD3NjcQ6SQTNn2seAilpy+IwJ+xGaZHRwYww+DGP5DC7QKVmL7C4CcO57GRdBUf+UF4xDOtSJM4Cl+J22q5wVyasxk4a4s5XLAwuGCFs1K4bc8X1YXIZEbtFUPXJ1iqsXgSx6/IwGpH4DGs9PPz8zskc0Lispo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731059905; c=relaxed/simple;
	bh=4miP7KTx/vyM7pAQMI0xHtr8QX+9BYZMxUDh1ggN+cw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G9v85IXIb1plgNGXvWgM+lyFP2DSadliVpLoQvBwnee3QAZhLRrvqkQZH26fSnWI54S4KDnhrYRZ8b7MzhK2y9FAXSfycS+gD6fbqAmcGLY2POaaOmw2j49xh4mcw3dMjFDHI/xZ+spJewFjy2dssgRnUEV/YDuxV/17ga6Jdcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WqOuVTWv; arc=fail smtp.client-ip=40.107.105.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cCH+sNFgKQT5AIiNx8cSK065lsqR+KxO1AHhkWnjSxno9UgPSM0HsP/7unRXyR+SwDeE9HgH2gaqfG59arLhA06GlzPjA9g+lJ+fKtlUq+VUT9ATIQWrKTWxYWsE5zITnyhp8zss+hLog+GU1WTQnw7KCIOQj0/BhYhAamYb4X0BCKQXoPaVMS6sezU5cCy1pDcyWZxVVB10jG+jbBK0RDYOTvNmWS7TQEvZwiqQFoD6CVZy4Y3gqEan4HwGTzqwCfNSH1rT2vBIAoBvKPR+6NvnSv2PraCQF0DgY+XzRMoPXP/Xa1aXVdsf/52Af2xAUb0reg3zwBCo/oCfhIdGNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOqJU5Uz4iRFGiPImJR24wPUbgyPC8dYCJuoEOJfNn8=;
 b=usz9HVYa4sc76gzZoVpddHYV3iEq6eMEYVVARKflDbM+T146vwo3amm6UxugHPLHFdoCLrN65TqSoLCGE18O0gzhmVRSk0n4WBV2GlZF7jKxDoEwq2INND8yACVA98pnix6a4mJNabcDtO/zZKqM6uGVE0UB03Vl8eYGy6i4vgxkI2s5s7mY1b/pGOD/gbMqWmfPVQTXNeHKdf9ZczeaeRFrHyv5N5DpdBg5xa6pmcGmtrcnbQnhxbOWpBNGbixUYRbbCVBXCJvl5sqT77opaY7w9fDjkx2e6QfZHL6c+c3emDE/9awdQosg17lu3iemLlanvM0zER8b4s5+FJaDwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOqJU5Uz4iRFGiPImJR24wPUbgyPC8dYCJuoEOJfNn8=;
 b=WqOuVTWvZ7+/6Xk9mLFfx18QjhnfLlmYU+jQVwSzQalXg7LesiO52vbRuxI0hwcg4cyqQDKT1IbklV6nifKDx7kPJUyNzbCSHHMVBVkIcnr4q7sz4imuKUCcmlL6AF8CPGOflQGAGmK9j4DTzBjOTaWnzpfb74jUirrzRDHlKDaWSKUWF7n4T5Yk0BT0/AyT13mTaHVUt7/dcK6nW4ixcpHmLfK8v7e9XWbV1zR0DOrC0u7Z1FrkGYalhGtBR6Z0LIU9jEhuWe8C7biv3hddVkRIls3MrMeSmapIsNnqOGNjARg2fwQjw+Ywc1vsH0Z1EXBuSVz8en/0lZ4rf3Bw7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by GV1PR04MB9216.eurprd04.prod.outlook.com (2603:10a6:150:2b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 09:58:19 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%6]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 09:58:19 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: abelvesa@kernel.org,
	peng.fan@nxp.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	shengjiu.wang@gmail.com
Cc: linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 2/3] clk: imx93: Add IMX93_CLK_SPDIF_IPG clock
Date: Fri,  8 Nov 2024 18:07:58 +0800
Message-Id: <20241108100759.682260-3-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241108100759.682260-1-shengjiu.wang@nxp.com>
References: <20241108100759.682260-1-shengjiu.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0213.apcprd06.prod.outlook.com
 (2603:1096:4:68::21) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|GV1PR04MB9216:EE_
X-MS-Office365-Filtering-Correlation-Id: b5e58988-5706-4ce2-efb0-08dcffdbdf84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?29Ogf/1/Xevd76F45QyZAq/HBJ6C/9Dr9W4YygIsBd2mAS/9Cujbkd1eidUk?=
 =?us-ascii?Q?9zd/FJDgblp29fb5zGUal3F3ieTb8ROHUx9oOtCw7oe+5nm3sJPmYS/Xck+F?=
 =?us-ascii?Q?CHR1pSKnQCbBX16AIm13CRojmh3z616qZTtolMKaMot8XXN7hDk6D0Saw+0u?=
 =?us-ascii?Q?2SAXEcO8uKz+w49wFLlcCKbhYO7m561xkfzTCHFb4+/jg1enlACj/aUf6xrK?=
 =?us-ascii?Q?59TvqEKYOpVTMDVjlLk7ViHaH9S7RyGuE4Ct31FgmC9PEiSWFzYjlcqua4UF?=
 =?us-ascii?Q?SQbTKMaszPI3MOoZdDKOOKmSyuFROMwIdWEzYmacrrcZU0XR4VAktw3FDr75?=
 =?us-ascii?Q?Q1a46d1M8XWqvd3CMNRnwJ1w4oJ5THkZ9GasDsBfdfwzNY8HjpP1LJcQvqqQ?=
 =?us-ascii?Q?Q84kB0AGa0ONWstTko4XVMiqGkdMML71W+naSWbj38mjCMSoIFuNak+Srz8k?=
 =?us-ascii?Q?JjLc3CEHk/eP4jgTE5MsOVk83/DnSGiHODX7IQsiDIzRriZap867RfbF+29K?=
 =?us-ascii?Q?ZQYj7iVMbuCsKWm/tWBc+wSYkroBpLDa5cUPlcJM/6V9/3K6UiG3c9nhTojw?=
 =?us-ascii?Q?Zlop3JMOpLa9ZD1Qg7ewf1E5BS/A0n5ja8kBYzsgPMX4FzPphssk7E7dV9DY?=
 =?us-ascii?Q?h3PwzMD1JQ4vamTmxv2KOx7oJMAjJUf/RRDCjd1hxuwjkWzO7hfw3XjpNufy?=
 =?us-ascii?Q?N26GJCaLKZKV/jxtzDExCkaGYufHN9EqavigyfLMCmW8T79SRdI7DabN+DOj?=
 =?us-ascii?Q?0eIbE0RrQCZtw5ZpcdF/TwNafwuGZjZhK6WkqRO0TmnEhHn4sELZTMX5ck/S?=
 =?us-ascii?Q?AryzVYuLqTi3ttiMYcY1Jh2YpkULPaJSig0A6j6Rpz4V1Z4imr1BeB5aymDi?=
 =?us-ascii?Q?y3uVMFuRRXAJUA4egFyVIRmtMR0ws9w6SaS/ne/ud6ZLo9JWze18IyKl7lJW?=
 =?us-ascii?Q?Or7A3Cl6jYdwlrYMB2OwlI7enDvHiTRWk6hXilZFceEld8opF9xic8BWGrz3?=
 =?us-ascii?Q?Torb9J/90X3eOSzSD64aKRFL61dJ4B2/Qm62EBF/e+u16WCmIha7FAd7l82u?=
 =?us-ascii?Q?gUL4PlOkZ8s5Z9/x+j1+VdAwmK9KRv+jZdkq21Z6rpdUjMlAVKBMzUT3wMlf?=
 =?us-ascii?Q?aNLbn9toGlE35lj0NTy/EjaxBGEjgS4749QmW+T/itc1UBTryymlsHxHMRgN?=
 =?us-ascii?Q?h4H8oHUlCNSR4P6kuCM+kR0MVVfPOEXsmnE1MzrVXchzp+RyNrOnSIuGdyA7?=
 =?us-ascii?Q?MJ3CWknOPZ13MxauL11k6BQmI+7QdsLWzf3jmZ8Z7xAgCSofaN8BHdFibuSP?=
 =?us-ascii?Q?aLugu2B7MCa7H7fRYF5hE18lllXSCTNIBiCCTu+KfyHyvquvY+LpAwJ+U5Ne?=
 =?us-ascii?Q?ChjUX+oq+9kI25xQd8j21A78UXav?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oVjAbGl6WrXGA2gu0Jv8AYltVwlpySfCUmIORd+rAylShAj9BmJ41MKlH8xk?=
 =?us-ascii?Q?YZIbPf/aYfbPFBjTm4RCh87vSZUlugM8fijhpvtDPRJ0Nj+e+UZ8NSA4KWHB?=
 =?us-ascii?Q?tbwowGOH/nfSeZa7Veohh6w3690sVSLhRRttswtR++dCeiwo4yq+eu7IKl8v?=
 =?us-ascii?Q?6Lrnh/7agK+/W46o5TSZXRWz6p0ax7jCtYQdwWwrOgmtMtXCeQ7w/B4FRTCB?=
 =?us-ascii?Q?+Z1Z1/itnuPF1ZJpDcm+J5Oq/yvOeyRSKSAMIXAMektOlH5OUzLM52UHP9XV?=
 =?us-ascii?Q?yWKdmAzNHnij0KgPaAZn/5VduggDSNsourGbgjLJIWx4CzrpFRAANF4itPE6?=
 =?us-ascii?Q?pW8hvjXo8q5Cf2m3OaJI8tAzcfev1B/1NXfx/wGBgLQM/8GejMXsZrcmJBLV?=
 =?us-ascii?Q?hsViO5hgcbUNdTKhLWDgN1BBiuBPlP2ipJR4T5NxKEgOPR3amnrOx8A+jZ3N?=
 =?us-ascii?Q?FB665khD8Em4id+GUOlxeWC4ej57qWkAFmtmDKI6eyLzGqGD0mUPkKYbxKss?=
 =?us-ascii?Q?T0rn0+RGuW6jqdVpCGA9/dSleJhh2dFEdJU9rtKiopCKPuK1W+hCMDiP6KIS?=
 =?us-ascii?Q?Dqz0/jqou1+Sax78sILmEQ4Axxqa83CFhHszHSbhRUZyAZXRjcPei0aCqY72?=
 =?us-ascii?Q?IfPN9Fxao/lES+fMDbM9s3b+fBcAWj/qrojNa/eltqv4k+wFaAmYX0L1UhsF?=
 =?us-ascii?Q?K9Suu+ZuCSeYP7VF8d/oq0ddS8Ob7fgNmzYRT0MLf9Gfh6Yhib/5p5P1x8vt?=
 =?us-ascii?Q?27WyxAzmA8ANfrR8WtZSdoeS7FNAUEQDQNM+yCdbOaMyE34HDJR5+xQuFVQq?=
 =?us-ascii?Q?Lsz1sCqsYCworYAtIE6FKTE1+9rBW9iAJY9ZujUXgQq59sXts3VlcGPe1iUy?=
 =?us-ascii?Q?vgt2Y8YCfLvOu+jF68honk9zklYuAcTeIsPL5xkFPUEh6olx3pOLH6/jszgo?=
 =?us-ascii?Q?CFsKuLcrz8+vLrF9WFAto0qnr5/uF1WzpABhbk7jcVjWUIayJ8DTdEOY7GkQ?=
 =?us-ascii?Q?PFcrF1B1eumDQ4hlRYmiaRR9pIvI0OvYmdqxu44XrInE1JnpwhPK6rcdgPqu?=
 =?us-ascii?Q?+VLTcqiuGYTykGrhUAOdwrDqDJB/wZg0PF/5V8P3f+3Ugg17PMI2XQS0/Gi6?=
 =?us-ascii?Q?kyvWsP1fujPeY1Wq6h6SIboPdmKPjia/ZYNW5oIu/ZbG2hNXFDg9Rt8cbBsE?=
 =?us-ascii?Q?Mq46a6D72TWpuEvqJMtLcqoCjH7QgSoRlofkd79SMVUJeLfYxJm4AiRAhanx?=
 =?us-ascii?Q?1yhYOb+BddCrMKAs7DpHg7RWpD+DppaxENPIiu/PCBdgGfB8okx9h6XwYIfH?=
 =?us-ascii?Q?Zgkjq1JxYoyhnTlhCclmu/I1L2/S0kqCuYJwjfX8DdI/Ys6JFdtf0TYEeSOC?=
 =?us-ascii?Q?BkiRTrEFLn9S1ftwYe1B5n/FCb6MZrfAx5PYv6PtEwRFBCvHT+kAqsrPlfyt?=
 =?us-ascii?Q?M9dRWSNKNZtYMz4fzXUSFeYljt9vfWoY7yaKZUqeRg4rBgJghx/2SATfbnVt?=
 =?us-ascii?Q?aTyrm04qTRAiYR4pBeqFVwAFXgJqt0C+S4uSRZdQcDEKCRXAEg8KhE/xv5vu?=
 =?us-ascii?Q?aW6yCZa8uligJG7U9elG5LbDydtPOS6LVsPscbzS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e58988-5706-4ce2-efb0-08dcffdbdf84
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 09:58:19.5382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2YaOtWzh/eOxRSyAv18TYR8jXs6TL6NxAIRDcQ34rm7BzVkHDGA835LmoWT3vDqlIugZ6xDHt0YpA1gru18dlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9216

Split IMX93_CLK_SPDIF_IPG from IMX93_CLK_SPDIF_GATE
because the IMX93_CLK_SPDIF_GATE controls the gate
of IPG clock and root clock. Without this change,
disabling IMX93_CLK_SPDIF_GATE would also disable
the IPG clock, causing register access failures.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/clk/imx/clk-imx93.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index 58a516dd385b..eb818db008fb 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -15,7 +15,7 @@
 
 #include "clk.h"
 
-#define IMX93_CLK_END 207
+#define IMX93_CLK_END 208
 
 #define PLAT_IMX93 BIT(0)
 #define PLAT_IMX91 BIT(1)
@@ -38,6 +38,7 @@ static u32 share_count_sai2;
 static u32 share_count_sai3;
 static u32 share_count_mub;
 static u32 share_count_pdm;
+static u32 share_count_spdif;
 
 static const char * const a55_core_sels[] = {"a55_alt", "arm_pll"};
 static const char *parent_names[MAX_SEL][4] = {
@@ -252,7 +253,8 @@ static const struct imx93_clk_ccgr {
 	{ IMX93_CLK_MQS1_GATE,		"mqs1",		"sai1_root",		0x9b00, },
 	{ IMX93_CLK_MQS2_GATE,		"mqs2",		"sai3_root",		0x9b40, },
 	{ IMX93_CLK_AUD_XCVR_GATE,	"aud_xcvr",	"audio_xcvr_root",	0x9b80, },
-	{ IMX93_CLK_SPDIF_GATE,		"spdif",	"spdif_root",		0x9c00, },
+	{ IMX93_CLK_SPDIF_IPG,		"spdif_ipg_clk", "bus_wakeup_root",	0x9c00, 0, &share_count_spdif},
+	{ IMX93_CLK_SPDIF_GATE,		"spdif",	"spdif_root",		0x9c00, 0, &share_count_spdif},
 	{ IMX93_CLK_HSIO_32K_GATE,	"hsio_32k",	"osc_32k",		0x9dc0, },
 	{ IMX93_CLK_ENET1_GATE,		"enet1",	"wakeup_axi_root",	0x9e00, 0, NULL, PLAT_IMX93, },
 	{ IMX93_CLK_ENET_QOS_GATE,	"enet_qos",	"wakeup_axi_root",	0x9e40, 0, NULL, PLAT_IMX93, },
-- 
2.34.1


