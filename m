Return-Path: <linux-kernel+bounces-399634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 246F59C01FE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 456AB1C21BDA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FD91EF0AD;
	Thu,  7 Nov 2024 10:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="f2ROS9N+"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2046.outbound.protection.outlook.com [40.107.20.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17491EABB4;
	Thu,  7 Nov 2024 10:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730974266; cv=fail; b=iPmv81W3FQJR1LQzK0+AGy4V/yrNkX6nkKJM/YQlHmSKJ6G4TmNgpcViRxgl5Wfs+oE95V6fFjZSVViNh7he43ihKV+IXCwaqNaBWWIMzzuNQ3rQ9PYA/CuayQvhlbcrGjTDlwP8R+oQpwH55AcEssDhfHcdquheh/SIwClh4YI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730974266; c=relaxed/simple;
	bh=p4BEwSj8gXoI2hTV3CE8Y5QGdxSDVlBDow1xm415EGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P//mvJ1uX8IgBGsLkpCX4fkB7cN+EDMW9fVtSqy0VHmLngZt3Q5QSvV7t5SN/xA4cReJ20yn/yhhyoXr7eVrqQtWTbCUDnzo8BlWWHQ5sk+DPqWInflvRv0yDz/vjhxV8rEDpJrnxqCRBe/1WYp98ZAY2n8KhNNebB2q8o4Ol40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f2ROS9N+; arc=fail smtp.client-ip=40.107.20.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PPfYEDJ2VVk2J7B2w9bcwLxtBpN97ufYe6fmE/ayG9D+iudei39nKulctVUEBN0o4m4kAPc0SAkY1CaB4t+ijruslEEUP0tpGC+0lF33Zs1vDso6P+btmzqhGMUucI3KGM2nyHvP1+jJvV5JXMJxcNJtuiCKP1zsKTDPEup3s0gQQgy9UGxzrLHt8Hz/7QGPFtOiIb9FAe9TIPImjr25mhEqUp1zsW2njMtCZtDfKYeeZY1q4CQMqEcI/T08KF95Cm2JhXb79vi58avdQrswkg7KJFj/jr0f42p9ESZxKHQbFhrzYZ2ISHQ/6yHWrPM843ZUW/mZsU8ZEfDo5FMPhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2ZqRaKKEXfE4yU+gdYBhY+45dFlriq5DQBDWAPOAj8=;
 b=WzagxcnEcOZBHmppt8YZo5XliAg8xlhKLe1oRFVHXYKKQAG3I2S7sfcz38zXtilwCFRHMMi5hayXqIR9f+k0KRE40jJ98zsYm2aRAbS+5JsYdSeRSJLJ/SFLe2O/pogSeF0zm/OkAyHUmMbzZx+L+h4Zd/N6+zmUyrtWj5N2vbVw/9x7shTODLP+iVzXcR2zaOQz17AMsiyJIpxWbxOUq4T0o0vnSIEo5Y0Z3AbHZpC2l7AdvDv98MEPrP7JQKoxJrPWu/aTlTnleFsN3o9wWuTEG7oQkaT/VwyYkC2xjkDpsYK8uM7EamTIqQy2axDjez8gL6HpVLGKhm1I+FgXhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2ZqRaKKEXfE4yU+gdYBhY+45dFlriq5DQBDWAPOAj8=;
 b=f2ROS9N+H4thf1slyD2OZYAO/Xper4ATFXqbo8CdOExyWzo2ll1905JoKeJzguZFP8XxuYN52rAOsaB00GBh7v9eYgSGHyiBudzelt6tOCAXLt0Hfq4o14ALP+xQPpMFsSR8mKeU9+ujW2ZczUOxzGi1mAthEsLL+PZaxcFkW0lJwGy4wM1CkXf0foKDtt45zTzNUMRthYeHVFnEVHnlNOaqjmPKh8hfjq0eohj6uS2W0s3dqrmlcJvXxdC6+nntNW9Jnh9EjeGQC7+ZRwpvbMo4Gi3FaBiRDIaaxBtxeQLSNYd+4Esjk+dQjZyl/HC63EvzK21TCXY7xy2RgDA5xw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB7055.eurprd04.prod.outlook.com (2603:10a6:800:123::21)
 by PAXPR04MB8991.eurprd04.prod.outlook.com (2603:10a6:102:20e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 10:10:51 +0000
Received: from VI1PR04MB7055.eurprd04.prod.outlook.com
 ([fe80::d6ab:1538:d868:bf8]) by VI1PR04MB7055.eurprd04.prod.outlook.com
 ([fe80::d6ab:1538:d868:bf8%3]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 10:10:50 +0000
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
Subject: [PATCH 3/3] arm64: dts: imx93: Use IMX93_CLK_SPDIF_IPG as SPDIF IPG clock
Date: Thu,  7 Nov 2024 18:20:08 +0800
Message-Id: <20241107102008.3626023-4-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241107102008.3626023-1-shengjiu.wang@nxp.com>
References: <20241107102008.3626023-1-shengjiu.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:3:18::16) To VI1PR04MB7055.eurprd04.prod.outlook.com
 (2603:10a6:800:123::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7055:EE_|PAXPR04MB8991:EE_
X-MS-Office365-Filtering-Correlation-Id: 36831b53-b82f-4d4f-0e9a-08dcff147220
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wFVOhW3sK6nMMF2xDRrOM0THlpC7Q7wOWJiQg6JXcV1ObXkgIPSHrIClkOWT?=
 =?us-ascii?Q?eG5dW8IpydbmvW3XE39B7Xf+Wa1ykkDkVK+YhFcqycDRa8rPvHvRR8pGInzg?=
 =?us-ascii?Q?hMxSJ1SEjnd/uBKjD4X5/I0hMHw0FKtjSf/UYDcF97yVVoCE/lThg0t9jb9d?=
 =?us-ascii?Q?W0T9urWy5xYont252YvKPwByu/OyYqKGFk8iNBSLAxd0Kj1w3EqwTDebn66S?=
 =?us-ascii?Q?Zi08Lq5D8T1iRW9mK1ca4sjCQttTSHZUmEV+pebNeAoGVHKtMmrXPyBolS+o?=
 =?us-ascii?Q?G7DFfVQvDCj/qVUJq+a5HBGvC2TrCoGnhCFbo3luy1zJm+RLFj4USrxCipCO?=
 =?us-ascii?Q?fI7T31yjhYg6hstwair7ZWjqHVf3zqxlKGPpnEIS7eSZ7Tt5ccCRisNdtWUd?=
 =?us-ascii?Q?IIBwRU0Xfaug2Te9ew+b+saACCA9DhZ8AxelNzn3qfoqOhKNwIupaCoU1wrI?=
 =?us-ascii?Q?+Qq3UgaJzPa5pKBcNjWIpiuWe1lGxHZOoCesIC0vGmobp6T7UIA6mrNxKYkl?=
 =?us-ascii?Q?85nZp44ZVyu8DDnARwpi49og3nlE3RQE1P/JuRj6S6YS8iZlv90yroy9vyBN?=
 =?us-ascii?Q?zAacHTPpApZKWdExkP0kASGJneAhDz6BNhQcbucRi8g71Fy927RADlErXObo?=
 =?us-ascii?Q?2m0eNmBnuGJ2cV/KXzjJ+t495d8MsmvbXSnMtAbs28OALdrOrHrkvnYqa3+u?=
 =?us-ascii?Q?kpfZK2xN+yO6xB5fQAQRwDwPBB0hVa6tuljuvUib5ntPSSSH2ePxIUoCOmiC?=
 =?us-ascii?Q?G3ZpMnoIcJ1+hngsy8BB/syhiTk75m24M2Pa9NiLAdBEV7BNCo9+EzapS8fm?=
 =?us-ascii?Q?ooYqx9Fr3XULTS4bz1IaQbr9aHqCbGcvPeENBdTVGDsw0fAAyCE+FYFqjg/A?=
 =?us-ascii?Q?khRYuEvKanPy8jqJq/Blo1iS+o3Zfk/HLtAA3BQ9br4TboqOQuOXhi/QgkiJ?=
 =?us-ascii?Q?qRQvKFAqieNj9rtmGGfTDJJt4QfbNWjKoRcvjbqswwbo5uQeOPoXwmCtbud3?=
 =?us-ascii?Q?8Uy8micAQD3IAaocCj33vFhRIUSQLnoyPTFjq5F7kAhuHjg+lt2rsN88yl7u?=
 =?us-ascii?Q?AiJqWanGB4gIWMlXf0g8LQgj1e0rr6W/JB8wD+rP2IEUVm9Q86Ua+RHhcefR?=
 =?us-ascii?Q?Ia53Lk+5avt/RFKbBxY4G/ibCqF0opeDp0EqFh2E4W/XW9QXa0iniUSBBKeQ?=
 =?us-ascii?Q?9iHJCS3Z3r70PYE4Gb0kQC/nvvFFvwASn221rvyedebapQMNw5klRWf4gD99?=
 =?us-ascii?Q?EvqRWwnCGYzM7Q2fxWguJafxC17h4KLZmRqFv/vohd83Ylt71vvdLp+WCL3m?=
 =?us-ascii?Q?+z7Mkm2L7hNpT21ffjzmxOwgKFuCyJK1HQkwnkYEE37w9yc21qnRO2UlbrZw?=
 =?us-ascii?Q?fi9EIjHQob9ehAVgHprKS2u/59KY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7055.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a5Mqtif7GjYhZSFF+SgRTAoweDtq3YkVFh4kD8Dy5v0ED+rUWpIXvAQkIR0C?=
 =?us-ascii?Q?wb05U6QLAGBIWyK0uLfFQP6vO93o2D0MBJ/oqdlWtNA7BxtiIykiEIzoONS8?=
 =?us-ascii?Q?vmGlqXq+MzySEyLSI/aOuDg32wZiP/fJh/xU5t3EsbZZG6W2ie1rko+2Quji?=
 =?us-ascii?Q?JVUFCDFELpNfeYk+QWVjVpRNxO2AqC1URdv2dGHsWRWC2gL81mFAmkCQ4Fgm?=
 =?us-ascii?Q?jlIY2NdgObmnMgFKWtcIb/C/qcnZtsAH6wh6PUHO4uzQTl804dXQMjG4knUz?=
 =?us-ascii?Q?i6EPR9OsrxEmuzld6YB7B/fuL4WY8utNyOAGBBtuLtjUeBYJh2xfQ/1zCWsu?=
 =?us-ascii?Q?xbE6c22Hj4aJJzAcD3KfIy8r9/w2aC0H/v4mniheVi9ukO0Rx3ou16KjG5bE?=
 =?us-ascii?Q?tb/sFslWXMsIpJFIfg3z3P5t5cvjTuK0kzPj6+C0SSc6U3gI75Z8kNeyCvo4?=
 =?us-ascii?Q?m1X6W3T7r+mEjNh+8yn2rfJQpN+y7lGLgsFks5kR54//RWU04B+2ilU3XR03?=
 =?us-ascii?Q?UBq3uTs3dMQ1yryv5rzeqjs5+bOC3IvVQqtJt9xPMDo5JH/P47eyXPrRL7Zt?=
 =?us-ascii?Q?vOWrfymk+quMILEz28ngurWHteUbVU9JqGMt+bRFEhIO06KsSd4vMZfmlhsE?=
 =?us-ascii?Q?zqdtZ7vGJk8ZoMSkIwBKrGE2jmNlYYQJmBiWymKXHPScEr7wDHZoFc8hC70e?=
 =?us-ascii?Q?qRzC0UrzIUYJjhgC8uh77rGBuz+IGgQKHREEA/FXdji++opjYyWyrIJVlEkx?=
 =?us-ascii?Q?ryAN9RrrIzdZ8FOzV8ZssnhEA7E/Bm7747+sBYdjci0zz6fDWCqkzuU7wJPL?=
 =?us-ascii?Q?6TolX8BIWnFSX2TwXfx1mdX4kr0r126nwuzGuQgDEZkkDAJVlwtK9wV5frVu?=
 =?us-ascii?Q?6y1Pj+7ZlsadUIFuazQUu8dz3FZ2+88DV8jk/LlmssqkikDJ+mdQLbB0PsTI?=
 =?us-ascii?Q?4WWt62q2gh1JT0V8HVPHbqxmFkLaAuoZLEgVDg/rbRkWInJ1PJKSm8DTQHXa?=
 =?us-ascii?Q?pxaKzI578w76Is9bSX5Ohpu8E0+660FIBfDvF9dgtyYSZ0RipU03hgmO9f+S?=
 =?us-ascii?Q?V3xBv5AFkH15YfrNLGtMM2NeNPcLI2D24Q4CStuBgefJ2RAK3EFWMO/dvSb5?=
 =?us-ascii?Q?6TyMGed9TLwRSkasPlE5Q4ajnQAyA4wJFJWpzMbcIxm5BkMsKekKtrbtmMGi?=
 =?us-ascii?Q?hyBFFCMEOypchIjyO2xxWMQVFjAevxrDCu6ps08zWLtVD+mtuU5Lhnm04Iyn?=
 =?us-ascii?Q?sJ8DpuUwsWTdXt0MkNjM0tnWx+Oh5a2zdmG0iLYJNuwJkQrfR3pKbmo4tpiF?=
 =?us-ascii?Q?rMrH6b7zmx+vjOwcYcWI8HAfZleI61CR9Ax2joTbudNPphIlgirZMiM067u1?=
 =?us-ascii?Q?VBYS9OLV+j9IWWVxyu0Hx5lD9HdPBRe/pyt7T/Jd/Q8TksZvFr8JJYTRlvma?=
 =?us-ascii?Q?zmTKMLNrDuuDTTFaFWShHtxPbaxgM1FrtUfQh/8s6F8f1NV69Z4BAvh/sar2?=
 =?us-ascii?Q?O2zNygejcg/0KM65nhHTI9kLlmxLw6G4gZfWfDLzZZP03tjy/jQlwxzsRs21?=
 =?us-ascii?Q?IowJT06lMmq1L4mou4qMCBuNr6EgwoLa3A5+ErHD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36831b53-b82f-4d4f-0e9a-08dcff147220
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7055.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 10:10:46.2441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FJV8vi6IurZg2zUyboAfTq4SP4uVIKKQ6FZNn0GjObcnNdOi+DQdPJw9RGx2BlEm++gM9yo2BjoXNfbFGD4shw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8991

IMX93_CLK_BUS_WAKEUP is not accurate IPG clock, which missed
the clock gate. IMX93_CLK_SPDIF_IPG is the correct clock.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 688488de8cd2..56766fdb0b1e 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -925,7 +925,7 @@ xcvr: xcvr@42680000 {
 				reg-names = "ram", "regs", "rxfifo", "txfifo";
 				interrupts = <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_BUS_WAKEUP>,
+				clocks = <&clk IMX93_CLK_SPDIF_IPG>,
 					 <&clk IMX93_CLK_SPDIF_GATE>,
 					 <&clk IMX93_CLK_DUMMY>,
 					 <&clk IMX93_CLK_AUD_XCVR_GATE>;
-- 
2.34.1


