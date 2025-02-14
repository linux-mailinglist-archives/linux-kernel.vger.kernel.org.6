Return-Path: <linux-kernel+bounces-514300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4260CA35545
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 04:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E1A13A9B2B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 03:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615431519AD;
	Fri, 14 Feb 2025 03:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="L7WubBIR"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011018.outbound.protection.outlook.com [52.101.70.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CCC14830C;
	Fri, 14 Feb 2025 03:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739503375; cv=fail; b=QMeYVLJ/QgTpvyJJm9fnai+1U86hMUFILiMPFRc4vkaHnelam+a/7kgEgA4WOxDLLbPy5UOyqFVfdRPpe0HPFvddG7QXNrZfG5x/uA+rDN9tNhUmDm+UiNFngdDhvT+x6F2cWc+Bsqt1fmEBtHIQS7hrfVCiN5H4pwWtVxKK0ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739503375; c=relaxed/simple;
	bh=OBUE4Zuk7kpcWPp8dfjCeCBqdWjtJiOfZQYZ6ZRO+t0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CE2S4+Xgw9KIEyK8uOsIhpVAi5H/So9hpQ/gUL7rb/QntslcX9mEx3GBBzuGEAdiEiUCvrYrEHbJXUWDE/mAsVeaifibX4KsUyWsi6kb87csqINen4NkKW3MWP6VKzX/wxCsb0l8jdAYZoYSsLFi79Dz/huY8D6WIti7vxHrbrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=L7WubBIR; arc=fail smtp.client-ip=52.101.70.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AaUUZdROYkVPqUabb5HUXn96Dce/UwwvpCgRF9c8U2X3v/59IhTunfPI/7AqJBeCtUJW61C+JS6sl6ow5DvhIMmXXRxMXP2bJyL6cvx+FbslK6iNjYMf7lxZX41qwGTOmnc4xL+LRPpfuHR/eZOPSzb4TgeURS14wehNCBJnUmoiF3xGEITH25QzGzPdW0U6JW/7U9s0PyhMpaLWHJf7lJBQXqIATj7m4pZAwkWA74Yw9kBf77qZ0gGvyriIFY37Wpr7yNWSTLL7yVL+ngq45z4l9mNSCxrWuSWpSedc+sg3RukrQnd5jYc5PdIiuM8Zd9YxPQeD3RXOyH/x61Z+Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxAgfswHGrcO91ObFU6qe0TY17S3Ma858F1tucbCVH0=;
 b=IP3n9UPB3konEPc5kYWbezKQtX3pxceoBb9CetVy5/4rhAkPfKtlA5Wv/kEi46lMO3VWiUyt8BO1NebRaNU3vGe7BunpYVTDWAJPd9XFhc5/OEO3z9mgrmvp190e26yZhK9x5GDfGDNOifbbWBjEdiuKtYcq5nv+lMSufZssv0dFQ/Emegz65qVH5Q4Cgf2k1JhJhS9mvs38FYYbalyc1kK1hXDunAqyz1yqoJJC+vE4vYAXt+Nn3d7gcvFRBJ1gQXodzbVwSIz2/ODeHdPX1HNpMkDkcXZbIzpAQREeJBA/sss8S71yr7OyAtJzi3FOWTo5xS13FTY0HHdqOzpN2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxAgfswHGrcO91ObFU6qe0TY17S3Ma858F1tucbCVH0=;
 b=L7WubBIR5DKoCKdOA4jri1NdtfsayyZT+CFNS3TWZB3LM/G9fzD4tUc0BJDQ4I47dC3vUSTa+D1Ke+HqLqJ8EsQli3I6wEk6v4kgKWuy5uofhKccRXf0KJO8xI1QV7jI8Pey13n4gut7xeiQwnP2TsLqkvw9HwSkvVcCGcsHtC9x+BK2ZiXEMPMAS0CcA6uI7vzorGtelbIRDK3NFoyF1mxQOyqqjdeGAwvvWl5RGP/AxVL7WzITr1oh4TtFKWk/pYbQESaTEn3WXLUEFTK2D05/H3cCGuygXSWJywSWjZMEbhR/aT4umsE6NgT4q6KZsS2RzUX0TGmHFvhtXdIdpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10937.eurprd04.prod.outlook.com (2603:10a6:102:48d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 03:22:48 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8445.008; Fri, 14 Feb 2025
 03:22:48 +0000
Date: Fri, 14 Feb 2025 12:29:44 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] clk: imx: clk-fracn-gppll: Do not access
 num/denom register for integer PLL
Message-ID: <20250214042944.GD20275@localhost.localdomain>
References: <20250210160012.783446-1-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210160012.783446-1-alexander.stein@ew.tq-group.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2P153CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB10937:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d5f74f5-57ba-4daa-7939-08dd4ca6daef
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|366016|376014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WIA/aTxSFn4VJB6KnK/Ic0Q66O0VLYNGSQWQZt76Brf4GP16la6gub6ehIBv?=
 =?us-ascii?Q?PCFMsN4woufm9w2HAjiOxHwfNZqPPm0QJda1J3b5pLMpzc+lbPOeKdqvdO0M?=
 =?us-ascii?Q?/fRIADV5xhw00PKYCQeEVC49vGJsyHRqijbVGkwIqkO16I+gkyl10sfCcGfh?=
 =?us-ascii?Q?97NVKnTn9BNo7x989emGKNxegLSXVZY4lSPjFizrm9WZzhsfo7RtDHcUEtdq?=
 =?us-ascii?Q?T0XU8ZxGZcygU8EWeW1DwnKKaqRs+kfXqy/Aco/93PsuQSOeQiKxVchAoNEe?=
 =?us-ascii?Q?vn9Fd8lL/n6YvcrdL84vFToN8cpto79FZJR0uLRLOZcAio6EpTxuWyBRlsX9?=
 =?us-ascii?Q?l+NC/g8Sc7Ktg9faXjYHV+AVWfmoV8Y3NoCoIrjIeSDFT0w8n2kBJ5dnBIFw?=
 =?us-ascii?Q?5WBFzFwfocseLKCZPaS5r3ZMTgTdUUcgPhojhpIBaYvqniHTmO1CEgoM7OQr?=
 =?us-ascii?Q?ucACaV5DyJHG9VJRqJMZ3EJgCzPp1q34IBpf2fA06BEkoD12hZpr7w+eYYOk?=
 =?us-ascii?Q?4dCahjAUWkO+EI/DQ4r5cKj3KO9D99/asZTtuoI5M00wLqBsjGYWFzerPE1t?=
 =?us-ascii?Q?MeE1pqzZJfQd+chnZmmhkDulIedrIRvBsLNmrJnc57QA4VrZ5isHaGniDafs?=
 =?us-ascii?Q?uUzTaSn9ezbAZM8htccdKNspaDnfR9k42Kxzf5avQ/j209I8pBxMl2OyNgM3?=
 =?us-ascii?Q?mqcrYPGWcIQ2W6Lm94tAzBOUJU5cuJRnc+A9VAXdIVwVZOUZ2u/1njGjioA9?=
 =?us-ascii?Q?oimKPwj98TuYIZMG3vDluj2znUnhjvWs3Z+wSEjsP84GB7wBmP/pzDO//q8R?=
 =?us-ascii?Q?SVyvZ2tymO2RO7dcdXLfjeqlaZRq7NBSSZ85uD1sOWgEn2tG5dMvFxZXbY2o?=
 =?us-ascii?Q?jZf8batQnrHinaBbIdlDd9CYgHWLOBDFwx9KV8KdX+lV6Kg1zeg0bzIkiOpR?=
 =?us-ascii?Q?Dr/H0Y/gfvF+W3FAEWcg3f7Luq3yoVbgEby5Zb1MAAiHWFBhQ1ZB8oy94yUz?=
 =?us-ascii?Q?ljFULfgAlhdKE4soO++LZxs55lfdvX7R+98YFg36opS0HhWzU6hD3tW/YOTK?=
 =?us-ascii?Q?Y/yahzhK8dTRlNNtc7w5in2IALJXsT+cRbxUG/2Wgu8offSEE2wCFL5SLt14?=
 =?us-ascii?Q?QwfpcB/9D01JBYwVgomvIo7n2Z495AixQA6fFB2s0oT7unxgihx52a762e3f?=
 =?us-ascii?Q?OVF37F107kPQR8ulvPraBnhKgdPpOAoC5BsAUTbtRZWo9aXAK/XEbEkiRiyS?=
 =?us-ascii?Q?Z9ZyqweZamsfbvL+fIAdVPJWp08KWgBzGeEFMdzhiEZf9GXm4TF1uTItwuKv?=
 =?us-ascii?Q?9BBjUcm+R/VuyMQPvVM9muSQyTFm6LAWs7WHvldtqgG2tr/MzN5KGkVo1Bgm?=
 =?us-ascii?Q?2h+w5xPewXzqaChvZHet1Y9LX8haSo4xi/GIAP8/4PWRwzPc28Tuwxqo/8t1?=
 =?us-ascii?Q?MZhReUMrVowoT84tH0WB8RD9/1hhqyPp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(366016)(376014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WstiDfIdXjM2xuMsq/6L6zxKDwLFQyeUNiDvoj6p+ubq+KkvpLMnHOMrBtrJ?=
 =?us-ascii?Q?Ae32cyKnsxPZCNmlqAKUCOvYTV5MbTAiqbDBehjxCJvqqW7IG51pUShlMRfx?=
 =?us-ascii?Q?Jkb9FIGLWytBNI/V8vP1IU7cRs8YeofzRePPaky+TIFX3cUifuVWOy3FFLNF?=
 =?us-ascii?Q?VbQ/0eiS4uhIBZffStPJ6dKCvcXN9R2yt2nTBseoEv9rvEEqiv1zPDX2iCu6?=
 =?us-ascii?Q?E3/zAijGt7OZsfb1T1d3/0yRQ+c2U8FyfTNEUSnsvyw/1JDTtwAlZ/gNG7XN?=
 =?us-ascii?Q?/b6tVgB0UZSu1t8FsLIbfeisDL71rS0hFQpe5cvGKDsbqBXhXukjUG+1cigW?=
 =?us-ascii?Q?9x3u566iDA+f6lHjlLaTN0iR3jdsQeop6Ks9QNQduqO3uawrXk4JlWE8op7G?=
 =?us-ascii?Q?d/mvJ+csqrcrOQM7of1fSU5ogxGuTw+IPLXDzFMxzG6hV9BS7fRKeU9cu7il?=
 =?us-ascii?Q?DbeppCL+M02Kg6PsBeM4EjcRMZU1sc9FhEndLTqzq6MlqfVSLFQp2BFqPyIf?=
 =?us-ascii?Q?J5gGuqcyW55tzc8i7Dtqwlt5GsO0f6euqXsQt+5ddOOYH43kX+2iQwqyiL/v?=
 =?us-ascii?Q?TKK56FJnddSmS2AQPk5A1XFhgbmmSaOvOb8LmZ+XMiUijVtzNJEd3zBSR5fF?=
 =?us-ascii?Q?ETi9VGRbADvxjy4RNqwYFMkrhzbW7HOEb6I/PeW9XAqOM+1af6/NuP4AcBBk?=
 =?us-ascii?Q?v/TRiaDpuDpGO70hHeQJPDgjM7z3v0lkV8i9voZNRUPvAioFW4Hph5Ew2RId?=
 =?us-ascii?Q?D3q7UA9wgdMqtT0toKrtH6abjLv584CQL2jtQkvukE7vjQyD3ejSzucil5Gg?=
 =?us-ascii?Q?IG3FR5KJY2n8Sf2bC/AHw7P4CAkbo1V5FZ9Cyxc92ehVoBT3nFH2BY54Gpkc?=
 =?us-ascii?Q?hLBIdXAIdkiJuui5wAeRjzyN1zWBDW2AQ3Vju7lEkwMRT1KU/Q1Jwn/paju8?=
 =?us-ascii?Q?gxJF5Zp8gRYpBiG3Hs4jE+UpOVPQsRVB7WM2MgVpll2a7GidKhzi61BUfZee?=
 =?us-ascii?Q?0mxMlthclv8IBmmVKTE0+4jFBCHBMknTlXYcjxtv8VbQSd0SaooDMtDZbvI7?=
 =?us-ascii?Q?PJqXeezk1Ee4KkFqqLk2AzBxftyBxQISedNgawffZfAqQ1M5iRXUGYwviJok?=
 =?us-ascii?Q?vCDzB72CV2/kR/fwQYjd33kgrnIbTOAJVigcOYLH9MKqNr4NwCI/5M1A4WiP?=
 =?us-ascii?Q?uNAa42nWp3N2PkKeK3JdPyrfYB/fPNQnq/EmAK5JClsYiFtFvZd4mXG2d8pu?=
 =?us-ascii?Q?z19ZKhYxfIByFSf+oaGg3a5e5NOUQQZuPgEnHt3qX5kdrNZBIIHnDHTlEo2G?=
 =?us-ascii?Q?vt8D4E5b4fM4HpjUfbZoNCbQqrK3tQThH0mfI5qY4nlCiS8UyqarA2S5BqFg?=
 =?us-ascii?Q?X1FpZ1V6ywnDqBfUHbN3mYS8mlBMa1uX2l2g1tGRY7pFdMd184Pm3XalIuWX?=
 =?us-ascii?Q?wTbzye8SWBfMXFPvXYtyWV8y9gwEkEeM0TizTteHWSAR2sCM3kP2PCv9URzk?=
 =?us-ascii?Q?2J7EiQg115es2ZHrmQpAspb+zqHec38CYUmFs7BGwjqEI74wGG871pXNRrWt?=
 =?us-ascii?Q?YLgiSEct2IL1GQYtZpYPfVu7obXnmI2GRRiRM/QU?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d5f74f5-57ba-4daa-7939-08dd4ca6daef
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 03:22:48.2429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hKK/hinpjs6RfwXumFkWsFtrysM1rB7aiJN1vbj9w3jXr+bfahzdNBCEwKn0MXCJv07lyAW5DnQUSlieIjpiWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10937

On Mon, Feb 10, 2025 at 05:00:09PM +0100, Alexander Stein wrote:
>Similar to clk_fracn_gppll_set_rate(), do not access the numerator and
>denominator register for integer PLL. Set MFD/MFN to 0 instead, so the
>table lookup will match.

For integer, the calculation will not take mfn/mfi into consideration.

Do you see this in test or just code inspection?

>See i.MX93 RM section 74.5.2.1 (PLL memory map) for ARMPLL, addresses
>0x40 and 0x50 are not listed/reserved.
>
>Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
>---
> drivers/clk/imx/clk-fracn-gppll.c | 17 ++++++++++++-----
> 1 file changed, 12 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-fracn-gppll.c
>index 85771afd4698a..3aef548110e25 100644
>--- a/drivers/clk/imx/clk-fracn-gppll.c
>+++ b/drivers/clk/imx/clk-fracn-gppll.c
>@@ -154,17 +154,24 @@ static unsigned long clk_fracn_gppll_recalc_rate(struct clk_hw *hw, unsigned lon
> {
> 	struct clk_fracn_gppll *pll = to_clk_fracn_gppll(hw);
> 	const struct imx_fracn_gppll_rate_table *rate_table = pll->rate_table;
>-	u32 pll_numerator, pll_denominator, pll_div;
>+	u32 pll_div;
> 	u32 mfi, mfn, mfd, rdiv, odiv;
> 	u64 fvco = parent_rate;
> 	long rate = 0;
> 	int i;
> 
>-	pll_numerator = readl_relaxed(pll->base + PLL_NUMERATOR);
>-	mfn = FIELD_GET(PLL_MFN_MASK, pll_numerator);
>+	if (pll->flags & CLK_FRACN_GPPLL_FRACN) {
>+		u32 pll_numerator, pll_denominator;
>+
>+		pll_numerator = readl_relaxed(pll->base + PLL_NUMERATOR);
>+		mfn = FIELD_GET(PLL_MFN_MASK, pll_numerator);
> 
>-	pll_denominator = readl_relaxed(pll->base + PLL_DENOMINATOR);
>-	mfd = FIELD_GET(PLL_MFD_MASK, pll_denominator);
>+		pll_denominator = readl_relaxed(pll->base + PLL_DENOMINATOR);
>+		mfd = FIELD_GET(PLL_MFD_MASK, pll_denominator);
>+	} else {
>+		mfd = 0;
>+		mfn = 0;
>+	}

Reading the registers for ARM PLL, should be 0 even RM not list.
But it is good that using a check here. So I am ok with this change.

Regards,
Peng

> 
> 	pll_div = readl_relaxed(pll->base + PLL_DIV);
> 	mfi = FIELD_GET(PLL_MFI_MASK, pll_div);
>-- 
>2.34.1
>

