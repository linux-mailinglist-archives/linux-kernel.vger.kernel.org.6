Return-Path: <linux-kernel+bounces-522889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1278DA3CFB8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 03:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 621A816B2B9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C6F1DCB24;
	Thu, 20 Feb 2025 02:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cmcraZPt"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013010.outbound.protection.outlook.com [40.107.162.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DDC13A3ED;
	Thu, 20 Feb 2025 02:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740020283; cv=fail; b=niVIhWI5yZ9pV2frPRYPCUe33N9fqRreV+jdV0DssR/TuI/n3nWmCeb1Ds2UqfT0Y6OUmByIa7o/gvcpfyBa8+jqnZOkejC2z1El7OZFj9YoCFQlCzXR8WHE2KKDMEkqMGklACpRsysc3IhHGHYqI7GSqhclTlslxwHX1HHCvD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740020283; c=relaxed/simple;
	bh=kQoVl8hc2rv4osapB+aKZtwWVcNJpt8Mj6LbpnF9iOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U16g3oB7V5UpyC8FxLu3jc+olk5VrpjJtCFNh44ku4B8pADy2ErNMwHkoaZrDIxM1PFBf8BfVVDj5qBtgvTBAbv6L5TSsL1cp6iWLkQFfeX5fFavfBBA5/TSZq8TTNQlBKZi7LCqsSO27mkimhT6p+BtdjLt+qfrJXzQPUXy0Sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=cmcraZPt; arc=fail smtp.client-ip=40.107.162.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZhHUV/clYk5M50vuhFytJ66v3Yd5Xfe4n2YLFg+OA/EbLrnguuWQ7zzs2gsOFvJOMSoffGKqvUAaTKJnWBBOWeeuRyb5LpOFBzSDD8rY7B3CeHQM+JTBdpbQWhMYE2626AaPaVLq+KWTGsIzyVifeSEYpozwPUh6M+/AimCglx0SqHTcY+wtOENwrlB7XQ8AQlRg2aCbkJJ7pmEgcTd8eJi2QBrInxLNbMhCrSMjfdz1gdXZQiE53Fq3nKZTTdWzMJcCkDmSZI43C15wcLYW+ZEVH29/fzuOyI729JhPPKZnvwNKIq3SR+RZjwZuka16ITmrs/Scs5vx/0j+4zF0zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQoVl8hc2rv4osapB+aKZtwWVcNJpt8Mj6LbpnF9iOw=;
 b=MfgJcW8+18PuHJPbYblEFRM2k7bqwxm0QKTzShOHY5nV4Hi81bQjMaGj9nVbvIIZpvkLe+enEeD2o12osbz7NbntUrO7tUZfYeUese3zQDO+h2ZUJklTsDiI6Vmf2+IyWW9PSf6vLjvoql9viyh9ig6TSFDv7NqvSu9D5rkxcDg1InFPX3BOtit+TeriwyGNKgPwiSpm42k4oJ+H9ZE42amIKJ4RBuG3NPfQa2i7UVZ+56ha4MlwfRLY71WqlpmbBvPx6lr+y6CvexFhp7kEiY0PQHDFu5gGvLLU5VtdTG23eu8jtfGdgWuiD1u//rlQY7uWEz/tKbpVaBrAatGP8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQoVl8hc2rv4osapB+aKZtwWVcNJpt8Mj6LbpnF9iOw=;
 b=cmcraZPtKhV1Vs483C2y7LDfIaYxRlCcUY2bl+8jbuBWqsXgvvd5KSqkFa7lk7Onhs5Z/821jJAO/bIHePp9WnwWOSPneirvGCyBOTKDMLXTkk58F8piN/XD5xkjjtRasNcJcjFh8w9yMi5l107tt/zxLACQrDUDB/hDPfh6rgRL8KmSA9+/Fo+YnRJVu8kPvDrB7EaoAl5u3zVuwiSyvHudGwh+CyzVWk/TrNHAx+t02EngPAF3dizA3DbrKEBYrpIByLuHEU1pGlOoXK9flGLE4K39sc09i/bLRrAv6lXMX8H/06m6OmZw1oyo0yVCeJIimNrRs1VoXcZoV7G/vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS5PR04MB10020.eurprd04.prod.outlook.com (2603:10a6:20b:682::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 02:57:58 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 02:57:58 +0000
Date: Thu, 20 Feb 2025 10:57:38 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, Frank Li <Frank.li@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Abel Vesa <abel.vesa@linaro.org>, Marek Vasut <marex@denx.de>,
	linux-clk@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/6] arm64: dts: freescale: imx8mp-skov: operate SoC
 in nominal mode
Message-ID: <Z7aaIiq5sQDIdAHM@NXL53680.wbi.nxp.com>
References: <20250218-imx8m-clk-v4-0-b7697dc2dcd0@pengutronix.de>
 <20250218-imx8m-clk-v4-5-b7697dc2dcd0@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218-imx8m-clk-v4-5-b7697dc2dcd0@pengutronix.de>
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS5PR04MB10020:EE_
X-MS-Office365-Filtering-Correlation-Id: b0208e19-d53a-429f-f913-08dd515a6157
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HRgfd98Kp+ZBir2X3NoYZf0r+yXEEi6lwgStPUAJmL7Se+v+aJ69P9utouJp?=
 =?us-ascii?Q?zqVHS8StGoVXKnkH5/yKh36Kk3IhKWZ79DVEiu/pgt47m25DC4tYWycZpBpl?=
 =?us-ascii?Q?1ANgmvumdxPW2Rjj9fxK8Zl9FwEKHKYobH/Zjkn+FjG5RoIuifDvabKkq1PS?=
 =?us-ascii?Q?KdRop8uFFKVOd3UJFwSUA6q2+0QA9PFjlveW6vvzbq1ve8j2yDMpVb3vEevR?=
 =?us-ascii?Q?hzYogYYy1+tYm+aOsSSSVToKx7QZ97fSL3FjqGdn360Dx+c6PZ3NDW3Xm4D6?=
 =?us-ascii?Q?b2jFfGiGJ53HRa/pKxwk89uu327d9rcbkpztANAwN3d49FYJWol7kJ+Ph7kQ?=
 =?us-ascii?Q?JO2j4lC0aF+NwfIkitNbPr3VAn9Po70ORqiVkxzIDABoiew5VYNjZJRaUypr?=
 =?us-ascii?Q?MqXVF/Ft9G5UWDDmuh1YjTUn6oav5wNCezYW29x+SkgIlX6BmlXZy5mQSKs+?=
 =?us-ascii?Q?HwU44hmaxOuuFQAfFXvJWlCPmccct9inpP4DIW9dQuueLwwDlAEXg/210KH4?=
 =?us-ascii?Q?Z3x+15oln3q6JMmbJy4MPeupC0h8oS8KMQ5fBxnzbJxoLQeiE3TQscciHt/g?=
 =?us-ascii?Q?LvZ/CJ0KQVjReL/V0zSM4PbgyQFIRCsWLRGwJPrNAHhmEoe03Pk4dQ61ovBl?=
 =?us-ascii?Q?Vcgf3fLpPQoIL3SBR7GyPI/IQfere56B72gn30n58WNhPsdGOsScc11ZbqPO?=
 =?us-ascii?Q?iK5pcqOlOAfEV0ZezASlhlmy0PdNfCbCTkBKNOjtIAN36+7nuk5qnVTLLxNq?=
 =?us-ascii?Q?Do+IFK0hNzbt0uT4VsMZS31ai3XK6KFu1EoQyQ0Z/YuwrMPcFgLVK+Bo+7hP?=
 =?us-ascii?Q?/bt+uWPQO9k/nTTu9DUU9w21sc+hYo5kujr7qrrC3DWiEyW1mfLFwPy1kPPE?=
 =?us-ascii?Q?SPqTblhPo43CUmYbjsF/7rTJI1zJK4J09dVG3QDm80hCjtojDsfG8w9Vt0G9?=
 =?us-ascii?Q?s2ZjgcLMrVlWTUmFdqDDLNSK7ayZUPoXqFzJiuFHcw5UDLXRKufAQmnE0RGo?=
 =?us-ascii?Q?L1hQ/N3bE6Ib84joTdrVhRn1vDtYaAyXcg6v5b19RVRGDPRaWXgaIk3DB9iw?=
 =?us-ascii?Q?uU+toQuMbkJ4WnoWHMtwrnlVi780ZK9YnlOTk7WXmkPd8ZJzxoiazT7d/RCo?=
 =?us-ascii?Q?S3WYa6cb0c/LTkXcdLLEUwpPuwaPvXB9+FMGbwVLqmBYaSySV8QsI+xQEiRd?=
 =?us-ascii?Q?etQDOXkcUKzP3aAfWahGpigQ4g4eSD9GvO7LseQtKPiIgOrMmDnGhwmJUop7?=
 =?us-ascii?Q?emaHHQaRAGiDjQl9lno/OsCtVlKzsdiZqtNEnOU4C87HYVkHr1DW2eSkNjE/?=
 =?us-ascii?Q?n3qqt6uOe1Gf+Nwm/AWg51SB4xYGkfn6rTFkBA6+6LP9U42VO4edTBKBHAAp?=
 =?us-ascii?Q?hftM10zdxrttTwgeHg57b6TzmPqzmC4fcyj1Ale+pWDetj3gfAxUCfJddAdE?=
 =?us-ascii?Q?PjRPLRcLq6PhvuQoJXrOkFbAXx6as8oR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N4y2IrMKGYfUdUSO7alcWrBcPSXpMe8wiNHipj9p+2aGCUjl0MfuYKBD0tom?=
 =?us-ascii?Q?TFqdwXE1cay4NYOGthLgme47TlwCG6m67wBB1QjtRz6jAYF0clvQQeWtyO3y?=
 =?us-ascii?Q?GTL+sLm6sh7X7kFsV/SEKAXHv5R7SX7NCaCf5HiijMGdgGvzLrpqY11XzLg1?=
 =?us-ascii?Q?1uH08C5HxivXRC+R1xjsmvZBpB9P0vDKXz8f0PcSvXQis7K+inB15uDkmUaI?=
 =?us-ascii?Q?jgnQz79SGEBCJkHW57TyKpTJZaWZHrXlAdOz0d8Z2ycBxs/llVkNJR9lk//a?=
 =?us-ascii?Q?S9zdxLZr/RUWjxjhIgLCfQ7clC7enj1gXFimSufR+f0VOwOX7Nlu66P7YhcB?=
 =?us-ascii?Q?mkgiwTcEDwfqcULFRMg4lLNK6O3oxYslTrRKfjKOZhVxOkJJyNw/Au8W4s/S?=
 =?us-ascii?Q?c/MwcA3TOuOcVnzj2z/YsL4yqSxxCGS2yVPxyI4x+IqYSTbyg72d/KcF0f55?=
 =?us-ascii?Q?71N23BEraogbNErWVFYH7vMOtDiVIyElM3J0lPaKyNkWtn5dCMQL63h0f+UM?=
 =?us-ascii?Q?DT4ZYf3CqCxxP3/1hOQAVbhJ4iFBd5INX+9K+dFyi1h46OohsIvvx2zglX6c?=
 =?us-ascii?Q?qHiPBrI+Rl5TKgnSlKx8h79zO+IJJ4BKoN3pd8GJ7+zo5TmcH7EC9fWJiD0b?=
 =?us-ascii?Q?/C8SBAaBdvJWFLvzR3b3fxbgRmjq0/Hui6wqc5ygV/VtgJjJA+pxSc/cBf3m?=
 =?us-ascii?Q?rLT2bBgb64bXsyh42GA/0oz2YnvPmDcGBCbwGONi+A1Z0Scl+X5A+d5tA9pM?=
 =?us-ascii?Q?9xO/5LdQddOWN3XbNEjivyvaZHEnUQFJ4ubymWyWMjPHYEVHC68fEXEO3ouU?=
 =?us-ascii?Q?Rfz0EY614j5kuXWGYSRWUfRKL0e4UaztChRG64JJJO8CqqvbJYD+hCQyMCNH?=
 =?us-ascii?Q?o2YjwHXY0BqphQkqgTjD4a2/UAlCnskzQFg5iiHAPhWsaN+7aT0+wv/e/txQ?=
 =?us-ascii?Q?M0zS0MaLnuhUpvlZ5dlQR9+3bV3WkYp9TMqW8HN5Wrp62YcT6MjyYOhtlmS3?=
 =?us-ascii?Q?dE97Ayh9mG78OIC/jzmHgeRbnexiKOaSejNlOapEFzvnWwQ6jcGTCWIfm3ku?=
 =?us-ascii?Q?JJWzWj/QYUwxuquZJ7MRMu+dgYCh9VrfVX6gKw6V/38pTB8NxANadhND479o?=
 =?us-ascii?Q?AlqZf1agR5GTcLmi7+e+8dFcgDap8H79HgrsTMtqIBLtBlFQDANtMEzXTB0W?=
 =?us-ascii?Q?uygPqEjfXuLj8wqfU4+AIsHs2SFcE75MNlSHm5zcjLCRn5bE5iZ+AseRqJxM?=
 =?us-ascii?Q?3Ra+YH65bWaYPY5P2yqHNE6/3V5XkwG1BcsN+Quf9xMtXQsf+7sve0vE1XBu?=
 =?us-ascii?Q?Z1TTwgqshF6LiU+aWvs1aJU6djeGBP1vZVbjsni8+MQZnhvh4AssRr6qM+A5?=
 =?us-ascii?Q?/FT1u1S8y27vDKwCml8ljrLhiCIXYYVhaeVGT5PlBP52xkWzWR0bMry62Pil?=
 =?us-ascii?Q?0060xBwleX6sl4jTPdwQvSSkUaK+KgOWFX+IQil1ghY8rBtIe5C7l5kAwxiu?=
 =?us-ascii?Q?gyJyGQmOgXI303SM4bV8t/tChFdaYrUS+i5qUEYOGTUKEPHkCrL62ToNA8QF?=
 =?us-ascii?Q?rPKWLta+CQWPbL87OWyWaGXrNTba8tnRyEO3jBrA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0208e19-d53a-429f-f913-08dd515a6157
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 02:57:57.9795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 186LWcs4q+0jQC6+XWYXiMYzWuqzEyTJbxrgRm2gP/8xrh2YWuW7BAUdaFsqiIIISqqckPKVBp6VWuhmoSMc9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10020

On Tue, Feb 18, 2025 at 07:26:45PM +0100, Ahmad Fatoum wrote:
>To reduce heat generation, the Skov i.MX8MP boards should run in nominal
>drive mode with a VDD_SOC voltage of 850 mV.
>
>At this operating point, not all frequencies that are achievable with
>overdrive mode are possible, so import imx8mp-nominal.dtsi to clock down
>the clocks.
>
>Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

