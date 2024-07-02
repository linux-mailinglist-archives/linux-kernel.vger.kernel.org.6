Return-Path: <linux-kernel+bounces-237745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D954923DA8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 14:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9861B252FC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E214316C6A5;
	Tue,  2 Jul 2024 12:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bN6K9HND"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2068.outbound.protection.outlook.com [40.107.103.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0506317164F;
	Tue,  2 Jul 2024 12:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719923086; cv=fail; b=szSVCx4ncJegSXhj1UL3zyVi0leDT505CfLu8wap7JrKZIZF7rWqPxCn7BAcaXFemxdJ2+nTElk8FQaajm7Y9XDhXg1B1PEmqqdOc14ZUvlSTid2ujtqeGhaKPuODufFezMs4LnLhCjvbWaBL9vFBbMQU+bguH5HbUGdGZy9Lhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719923086; c=relaxed/simple;
	bh=K6HDru9uclgM8I/czTuHdRJk87cr1dmAwdj9eyVO0x4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kQXzCA5AWe1oJUGw+np3USygXwNRPs10lCOohhcdRFB3bR07EE6eE7MlNMhjmQTTf+FM1FQDHPkQ4xxWeS5Bc5L7xkWjzQPM50bbkqRyIBSENAQ/ahphn9iOAa4thlprCqR3VqGOXn+X6NL966v4yIqcK7OqucJRuHn7asd9l5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=bN6K9HND; arc=fail smtp.client-ip=40.107.103.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cITimwSdLzelxhA/rusRslNohlzKP2SL9YwmAZQwqB3u7xwXbcmls7tyi7FL2iYcKzLgLWgZ29uu/7Mg30/rDVe8cjLoBAFurAeJqsPVF7gwpTpZ8xCms7+HpEDGk3CeuSy3sgKzzKMO1knbdHo+A/VAW2gh4t1x3VYqxzp9T3HcRhlE7gyx/V0XP64NOpJfHm+kNsGJUzbT47HmkG9MNXXrQUz8+oN/3oU1+/V3E47SikWSXNcJHIunxRPoQdwnbUEIrtEqWPT2fSoQsvZdPWBV5/7CqYQUYIJ1UeMr4zYqaKHT+HSVqEHIEoLRvpA+H7TcEDv//i6Q9MJd0bISBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZyScmXg/s/YqmSnxTxcznnWRa5HCUQUxZxKsGFXFsXY=;
 b=IxedoPWxEueLrW9lKkwoPKpcQKKj0brJxH1oYkayOVoklAXVq4MhOjutHOtuTL5ZW1NrJWaPhY8pkTdQnbF6gWPT+FDcxRvf9z04ILgA3GBPdjGP/7N6XTZTUBcAcq5bb9CWrUHrFku5nK4d4+geicGKMYVr0O+pTZfayO6Y3uVkmDEiiWMHEAj8W3CEBAB0DZxLuiZESlKwuGmj9B9+eSOM+BoMlvlpIXIXPyNCDvpsHqI+DsshFm1Jo2SLSYBLSaiVZ5mFV1GsYezOJQ5yLirlGm4WohjihhM5GORQhuLPGaQ2fTvlDFoIJYzC7P48aVpZim43uHJbSv5M6Df25A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyScmXg/s/YqmSnxTxcznnWRa5HCUQUxZxKsGFXFsXY=;
 b=bN6K9HNDPHni1NJc4QcP/SH1ByGhKzaljgw2Hf8rF3ShO2ihDqQYrgmdMVMgPkMkrKDVDcAp4r3mMfAMUrmRD2ND+q05e15/cM6TkTxSGlNz9NGDuC8RUZB2dgLoMvmSgqyM/HWh7ef/HKZyus7ay8hjTXKQVWLysKLMPHk8YoM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9448.eurprd04.prod.outlook.com (2603:10a6:102:2b1::21)
 by AM7PR04MB6870.eurprd04.prod.outlook.com (2603:10a6:20b:107::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Tue, 2 Jul
 2024 12:24:41 +0000
Received: from PAXPR04MB9448.eurprd04.prod.outlook.com
 ([fe80::51ae:5f12:9744:1abc]) by PAXPR04MB9448.eurprd04.prod.outlook.com
 ([fe80::51ae:5f12:9744:1abc%4]) with mapi id 15.20.7719.028; Tue, 2 Jul 2024
 12:24:41 +0000
From: Sandor Yu <Sandor.yu@nxp.com>
To: dmitry.baryshkov@linaro.org,
	andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	vkoul@kernel.org,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	mripard@kernel.org
Cc: kernel@pengutronix.de,
	linux-imx@nxp.com,
	Sandor.yu@nxp.com,
	oliver.brown@nxp.com,
	alexander.stein@ew.tq-group.com,
	sam@ravnborg.org
Subject: [PATCH v16 7/8] arm64: dts: imx8mq: Add DCSS + HDMI/DP display pipeline
Date: Tue,  2 Jul 2024 20:22:39 +0800
Message-Id: <727edb97281798454951ddf03cfdab5a428bc9de.1719903904.git.Sandor.yu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1719903904.git.Sandor.yu@nxp.com>
References: <cover.1719903904.git.Sandor.yu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To PAXPR04MB9448.eurprd04.prod.outlook.com
 (2603:10a6:102:2b1::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9448:EE_|AM7PR04MB6870:EE_
X-MS-Office365-Filtering-Correlation-Id: e42357eb-e1d6-41ac-eb6c-08dc9a91f2ba
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|52116014|1800799024|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?VCvoDK3nv+eWVK6XboKP2A84vl0XYJeXZVFRB4nG38cARqGYTqkq4tGgBbDM?=
 =?us-ascii?Q?2VRPwpZoaJNxbggrEmHZzq61YeZMwyOzVR6w8vNma4u/xkK2XznoZJolYHLH?=
 =?us-ascii?Q?RhZlrDKt7yN1+EZ+Jh1i2z1ZzgJ8CN3GnLCeSOmoriQDSyBZI8tw9ZaT9up3?=
 =?us-ascii?Q?Xpd3eXSjkifzfxSD+qZXQY5iGhST35bZURriJkRT58J0RPeCxU23O5DjfwQg?=
 =?us-ascii?Q?PluvoCwbaw7/SD6UgWnoWEURFWIPbHoeRKh9dN0MfNa7vfcs6Q9qamNqAWZc?=
 =?us-ascii?Q?xNsQKEbfdgXsRW0Pxcvk6jS3Sjpbb9hFXwAEN4JqWQAtGchFi8wn81Ek/L7/?=
 =?us-ascii?Q?1z9XdFW5IUWHCTMbZjsYP2DFbEDHJgfU3ZyrHrCWQJrTIr8vXuM5MZne8lSc?=
 =?us-ascii?Q?hd9F97v6DCCXy71AH0TrELb67lMVkswW+jcGIm6p8ypxJ/sFtQt8iPyXAKck?=
 =?us-ascii?Q?GOgkgp7XWTGYxWASizSsALqAYGepcAf7o13UXY/tD44bhlZSlPO7kZ0Oc3bk?=
 =?us-ascii?Q?Rga9QDtdL8sjPWhg+U0UtRZRNMCNOV0jLFd8ZsyXMflo0HAwddRRru2f4TEy?=
 =?us-ascii?Q?ocAAeCvQWtRkDX949Q1RbyA5rKyhDSakpH6xJuKWYkPw2sdVv9KSBA2LVSy7?=
 =?us-ascii?Q?b4kT/1y7ogWXWYmlgyhWzJkuvlRbBK05H3TdXlqBrOCruOKfigFa2UJgbJYt?=
 =?us-ascii?Q?T2SxN3ykmPsYGqvWNqofCmzm2mSQEpm49CpYj74r7ZUgZazvKh21+lRpF0/8?=
 =?us-ascii?Q?4NJSf4Xfxd1yc72D7e0X/wwTJdxX85UR0V0pSnLCbnkKHNDyaUh1EnSG/rKA?=
 =?us-ascii?Q?gJlieGcEYXwOmr22dSCoh8cOcJPP3QSEw3vG88mFAPMYYzPXS2rIovkcBLUe?=
 =?us-ascii?Q?fceJ+o4zpV3J4Hbq+C+EuCFakZndPVopauS+CAFttc3Zg+Vm3sYXGBBl5cze?=
 =?us-ascii?Q?hGm7GG40dkhB7/7mQaiNSeSPfsTyuQIM3AI8ZnF+uMYTCy2uoOtrKbuj8Z3+?=
 =?us-ascii?Q?qj9s1f2HlLjT2RhnD6SDQhyT8XlS4BP6N7jhAa5Z7lB6EUpjuedAq+0pknRo?=
 =?us-ascii?Q?y+FPCbHq2fHeprl/IQrqWiC+pGZlzFTUAnDpupaiUnj81/SeX8CWIXSdy3FV?=
 =?us-ascii?Q?pYLNdi1obBiFAGxS90BQ5cq++BCBsDEJKPBdM1sLpVsiTobc4g88C2HtpsCH?=
 =?us-ascii?Q?Ha+ECSjyk0bvg6JPENSyczKPp3CLTIYlqYIOQJR9/qQLjkkNlItJ3TxIB1pN?=
 =?us-ascii?Q?Il5uavc6NuUhxDmRsrjqhL2DJ7PlFezkNE9Otb+55Mp7SccNOp6NESg/yX10?=
 =?us-ascii?Q?Nml9m1YKwh16lGmVrbckRjePWA1CIPi6kvPsVEPt/KVch6VO+ae4JYKU29G0?=
 =?us-ascii?Q?KbczXBG3B7rY7kRor36tW5fQCia06YzrfdL2RrKqsNNFX5H9mumkWdpzjvpr?=
 =?us-ascii?Q?h0znsdrTaE8=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9448.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?WN0cL7XVglq65leU8MD9kmc0lNsvbBRzpDpFObLI7h5gyXEFxzEr5qJDYHUV?=
 =?us-ascii?Q?Fbnwcr8gA/MMvGZqERZNJ1O/Di++htyFV3uwpHf2yoNhvM5FTzNGscc3vvU5?=
 =?us-ascii?Q?zhHf87Bfn3UNHJos17fSShnzo2BVJbOa7XGpj93aPfUE3hvL7+3jfhz2ZoTF?=
 =?us-ascii?Q?cqh+9w/cQflo54lklryMmm6hhSbnuqlEvTIybED/A4weZdl9H4WnHu9cQdI/?=
 =?us-ascii?Q?hjmregCtXBbR+vlTYFkkuqLprVkBo/r4p5vMhmcOivni2WmtUWBYN9LpsO6O?=
 =?us-ascii?Q?BEC77EPHotkJ0XyblczyktOgy1nkPGwS82y0FQRVuWTrlg/zLXJj3HX7ONVd?=
 =?us-ascii?Q?b7AZTzEQBQezOszNDte+HWlLFooAgTupIjp7Sm5N/ArseCXf2ZDWVXqtEPZD?=
 =?us-ascii?Q?XebBKMz8QhnlZQHZg/S//jEgwrDhb4rhZkzGhjqPBY05IYvYE0p5ZjGPJlCP?=
 =?us-ascii?Q?g8MMMG0Pfb0qncdP07sw8sbK45+NLnXs/JDaG4kDGnhBvKPIm8J1LLWfDIEo?=
 =?us-ascii?Q?o833SXsMRuwuVst56U6t9lj+qzLx5cgjjzOAabp84ZseIJFjMoFBuLaEGETY?=
 =?us-ascii?Q?h5Q1KE7wmPOCKvNqb6NjNHkjmYlcACSC8TQerNP//ZV9SbfXmlHeiOiVSISa?=
 =?us-ascii?Q?d57vcRkq5D1aqgS/51NK6BljwUR44yniNOYutgk/Uew8GEFc4b+tK7gmL5cH?=
 =?us-ascii?Q?JZqheiPTE0Q+SMzLHog3taFaWgUPJJtBDRtG/t/bNNuV1XTzFBfyJIxD29i+?=
 =?us-ascii?Q?LoFf/GvR9Qrw052mUqfQOx6h+I3lUrbU1Bad0wiVlE00nAGqiZucRO/cx79j?=
 =?us-ascii?Q?BnmJ26PLSo3jh6pubEsdqCRBQDDXpZy6KQ6mjKl+0s3YW684b7NAfTnZonLe?=
 =?us-ascii?Q?NTyhtmcwzDG1ogWA+xCll4Oo+hP2ChrHGw6g09ec4ATrDFvjcF9hi14TIkYd?=
 =?us-ascii?Q?nbDfs3HQWeeRY+GhKntnxLSpUcu1w1RwKFGpH9Inamlq5ybHk0mgMnINq0lI?=
 =?us-ascii?Q?vdSilIZjQZFE4YkY0PT5ljnu84j3ksF8dl1rfB+W2SSODUcVNOhGDnwqJkna?=
 =?us-ascii?Q?VU3C94TbmNSuSz9NoEI/78WNAR4rdLTJZpxyVOOKeI+FoAN4rtpRHyPF9a6v?=
 =?us-ascii?Q?uDOXOiAUZXs9cMAXHBB2yCZ/p8+5pBGsorBAx2Puc4+d5yBR4amdabsxRMwS?=
 =?us-ascii?Q?B91eY8HlhdjhBaaLyuefUur0wMV7shbUqcN/qbhS58a0IJXFEiMh/CrRfLYs?=
 =?us-ascii?Q?yE3QU8Oiz+kpuJy0Xf760vWYDeD7EW7ImGhA2VtfFHu3pAOXwr4JIwnWjkZB?=
 =?us-ascii?Q?N75lPkF41W/y6QpEiktoycKqMYBWFSfRjAgyCdX57jWNtehKifRQBUonA+Ql?=
 =?us-ascii?Q?gZkIqwcq3cJBjdUxrdf6UHuser9V2w1jD7TXSw3KWKamwMn0YMeXLe4HMZH6?=
 =?us-ascii?Q?2DunyC8YXvHwadFfalTgljyOqhJ9wGfKyLsr1762eH9L5aTfTJLeYGw8LPqb?=
 =?us-ascii?Q?BqPOF5RPSRsL6Og3lWn5ieaK0GhSMx1dwXyurHXLi6+sUpulcaBgcIeECSgE?=
 =?us-ascii?Q?KZ1VywcQ/DqaKPaq18q+EYpXBGMhbAVcnXfMroAB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e42357eb-e1d6-41ac-eb6c-08dc9a91f2ba
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9448.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 12:24:41.5303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vjDBR2lRJT1/l0IAhwocSPCMQJKjnNuhehesi9hs/1RWr2BpNbG7oSqEZa5tHV+K1fUKMLRqxxfsySbHHS4vPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6870

From: Alexander Stein <alexander.stein@ew.tq-group.com>

This adds DCSS + MHDP + MHDP PHY nodes. PHY mode (DP/HDMI) is selected
by the connector type connected to mhdp port@1 endpoint.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 68 +++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index e03186bbc415..6bd7d2b2aba2 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1602,6 +1602,74 @@ aips4: bus@32c00000 { /* AIPS4 */
 			#size-cells = <1>;
 			ranges = <0x32c00000 0x32c00000 0x400000>;
 
+			mdhp_phy: phy@32c00000 {
+				compatible = "fsl,imx8mq-hdptx-phy";
+				reg = <0x32c00000 0x100000>;
+				#phy-cells = <0>;
+				clocks = <&hdmi_phy_27m>, <&clk IMX8MQ_CLK_DISP_APB_ROOT>;
+				clock-names = "ref", "apb";
+			};
+
+			mhdp: bridge@32c00000 {
+				compatible = "fsl,imx8mq-mhdp8501";
+				reg = <0x32c00000 0x100000>;
+				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "plug_in", "plug_out";
+				clocks = <&clk IMX8MQ_CLK_DISP_APB_ROOT>;
+				phys = <&mdhp_phy>;
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						mhdp_in: endpoint {
+							remote-endpoint = <&dcss_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						mhdp_out: endpoint {
+						};
+					};
+				};
+			};
+
+			dcss: display-controller@32e00000 {
+				compatible = "nxp,imx8mq-dcss";
+				reg = <0x32e00000 0x2d000>, <0x32e2f000 0x1000>;
+				interrupt-parent = <&irqsteer>;
+				interrupts = <6>, <8>, <9>;
+				interrupt-names = "ctxld", "ctxld_kick", "vblank";
+				clocks = <&clk IMX8MQ_CLK_DISP_APB_ROOT>,
+					 <&clk IMX8MQ_CLK_DISP_AXI_ROOT>,
+					 <&clk IMX8MQ_CLK_DISP_RTRM_ROOT>,
+					 <&clk IMX8MQ_VIDEO2_PLL_OUT>,
+					 <&clk IMX8MQ_CLK_DISP_DTRC>;
+				clock-names = "apb", "axi", "rtrm", "pix", "dtrc";
+				assigned-clocks = <&clk IMX8MQ_CLK_DISP_AXI>,
+						  <&clk IMX8MQ_CLK_DISP_RTRM>,
+						  <&clk IMX8MQ_VIDEO2_PLL1_REF_SEL>;
+				assigned-clock-parents = <&clk IMX8MQ_SYS1_PLL_800M>,
+							 <&clk IMX8MQ_SYS1_PLL_800M>,
+							 <&clk IMX8MQ_CLK_27M>;
+				assigned-clock-rates = <800000000>,
+						       <400000000>;
+				status = "disabled";
+
+				port {
+					dcss_out: endpoint {
+						remote-endpoint = <&mhdp_in>;
+					};
+				};
+			};
+
 			irqsteer: interrupt-controller@32e2d000 {
 				compatible = "fsl,imx8m-irqsteer", "fsl,imx-irqsteer";
 				reg = <0x32e2d000 0x1000>;
-- 
2.34.1


