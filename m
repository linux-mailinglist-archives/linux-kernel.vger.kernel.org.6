Return-Path: <linux-kernel+bounces-316273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E73496CD61
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D9251F26230
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 03:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BC714F9F9;
	Thu,  5 Sep 2024 03:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XGTB9TQh"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0324E14B06A;
	Thu,  5 Sep 2024 03:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725507262; cv=fail; b=ck97qP8QX6sQovrfgOo7bXA8ZOub3v7ob7YBYHbyUdusiyTKE+jCqdN0ckrcCyAfi4VMJ3cxCm6vOZcWUXsVb/gjRys71Ul4/LNena5hKJGriL01WiRJz8z9wxZFuypJ9WZaEL/a0v1sbTvzOWlb7Lw5PlTE3dlylJTIl/ttl94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725507262; c=relaxed/simple;
	bh=0bsM33vfh2buIeVUXxjI591tdFaZyNeLVbu2U0m+jAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C6vA+dXLQYFlcNssMbmOO0vzX4W5UH17gXSjp+cRTPwkcEqJp3vf/LTsCiQ//EnJ8oZ/bbYdj8xWO7Ctvdz5VnFWfoGR4gv3zuCV8l2wOmfsbhGRO1sYA7sRjYGVsvIdsaxtx1sT2ayZKKfGJAjpO+RNKx0D5qpDbwSRftoJlYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XGTB9TQh; arc=fail smtp.client-ip=40.107.21.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=on4G4PS1mldAmCx9oEaywLS+VRor/GYqtareUaHukbpnpX3fV4RcncKi3kNiRFMsj0nQ0wgKTwRyxX77jVfYikP1KwVfNXkTWwgOk8gnmyQcwhZ8zQVehRPAhbw5YTcBZVLPS/YTT5r9U8MRD2UI0cTdwV4UL6E2NQgH375G7kq2T5ytmNjWJ7XDOdwWvEiIuAkMWrfKh2zAtVte66a1ODD18kh4OzmXkBwr9g45BCedCJbElD9vhLcdRqsmO/9vcea6SY4Gvlv7G4NEkpfPW7+ovF3uzDFyFcOnam0/YThdVUrMGClk0KKKwLLg+CYBXci/vSLwrD1lW0Z7HUCF5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OcpQZ+TD8u9hMFJ8Fidjayk/UB8p0EVsJo4Mv/pdsM=;
 b=HWSj30kuEgea5JP+ki2p0vUPdKqBthgiaVBe+RPouoGpHkkB1jtV4AjdzAYGuuOIlhQMoIYvU4mwTCsWimhjpGV4wGDfyUH3OpRCqmMqt7O2tSIVxlMvSm7c4q4a9c269nD+jK6GiYmz3dLTIYFoBb3qGhenXpJb/zQ7ybllAfWxFaTPogHnUDjxEgRZLtj8MlvzM/Vxl+s3Rm2SxbuET33NFWXzGEf10vuk9yr89XBvg6oE/f+Jp4qWiIclaOz9sGTc8kHSFaqO0BG2LFKr0mQlTJ+uHP8J7Ng4JaBQuhEPrw2dpgCcnmgJ/KJMjwmfrnMDyChzRZ83UPfdXoSTAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OcpQZ+TD8u9hMFJ8Fidjayk/UB8p0EVsJo4Mv/pdsM=;
 b=XGTB9TQh4uRRyWVEOmIb/0FiwgYKOAihzKw09Hla5OYV+++V3IG23E3cMZCoXtc1Y1x/IakU14+NhRtOpf2cTeuuOKDDRUhP48WIw57qg0xakjEg9Olfgv3Pk/iHEquq2DcQSpoFYShNgPOxCowPRyCwwLRgKog38BIl0CfcLlo35Jq/20HnNm2+pdNnLqxfmRD3yw2nnwRU3vgQt6HiRc3JgR9oFJBNosqpVGi3rf8rzmyhEXO1JwxbVu08NKeLA+vqXKlmilPRa/taq5fg0osG3pysYuKT9zXcspKWW7dF0wAhmQgdE3tf0t08St22e3W4ASLMUMifkhkPMECiWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10175.eurprd04.prod.outlook.com (2603:10a6:800:242::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 03:34:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 03:34:17 +0000
Date: Wed, 4 Sep 2024 23:34:08 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com,
	sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	festevam@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org, imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: Re: [PATCH v2 3/3] clk: imx95-blk-ctl: Add one clock gate for HSIO
 block
Message-ID: <ZtkmsMP5y4KdIOXA@lizhi-Precision-Tower-5810>
References: <1725503468-22105-1-git-send-email-hongxing.zhu@nxp.com>
 <1725503468-22105-4-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1725503468-22105-4-git-send-email-hongxing.zhu@nxp.com>
X-ClientProxiedBy: BY3PR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:a03:217::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10175:EE_
X-MS-Office365-Filtering-Correlation-Id: a70dfa7b-4e15-4498-206d-08dccd5b9efe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gYv/empCHiw8TlT8fOidlTB7QIZ5hO2rV/mez/GsCJncL1bVjumDjrmxz+Vl?=
 =?us-ascii?Q?DARcpJp4KFtS2Emw+UYo/iPtmdzfa5ZgWm85KbJV3mMvHiZd6wtqHzTPXU/j?=
 =?us-ascii?Q?QCNw2dPxcvO1kHEq8IFW/UzBnMIU7vX1YWU8KWHlu7PP1N57c2afwLVB75Oy?=
 =?us-ascii?Q?2jlbExG96dm++e2/PovS3n5LdxhaNprZgBdtWtYjf7768IUmFi4AQKxuKab7?=
 =?us-ascii?Q?DLNeb8iOnCfhJouAxVv74mgUply36kYZ8ELKqFQqndw/qFeiUUe7TnbHspEQ?=
 =?us-ascii?Q?91jEi40qCxfH/FZKAwV+YZsGO4cbUFkoNDsYaKhQvtmAL12utyvk8e009nnt?=
 =?us-ascii?Q?ykg6CozD5XlGFKSebRyouLagZtj+50WNEC7n5KcfIeuoWrjtLTUBRetCNhXM?=
 =?us-ascii?Q?/GVesFZHZKCGBWX7U2KZFhlKC0Ee21+IyWwsucIyZWhNJp/dthjXg8gUXzdN?=
 =?us-ascii?Q?iBFW35JTBW8PByf4iM+N2qBa9stOsCiJkb6YoUYDs7sEIgxVIKGXOlEKpNIb?=
 =?us-ascii?Q?I7dN+IdEr2d83+JHS1vtiBKkhUF1T6g5Bjf7gEWuuFGk2YiVD5mmwD6DebKm?=
 =?us-ascii?Q?Vi+4F/9QuRnfZhh5YWS4pZ9943WLcQblbU24RcGdMcGPh7un9NFEvJI35tCG?=
 =?us-ascii?Q?3GC75Pg3QW7XMJTw3bToOr7cKKXA75ziNw6ttqlFPZayITSAos0iUzYvE3Di?=
 =?us-ascii?Q?QRLvYECTkuv5wEhB4HDfKmqEzVzTm3CC8QMbDvfL142UfzrL96nc82FkCZSy?=
 =?us-ascii?Q?RKF7cNJMPmmwStrrkA54rNNroVSq6MYgQ8382f2Rd6IkPGsCSilczfYDe9aN?=
 =?us-ascii?Q?pLGdD7masgg4HDtZqZuppKzruSrDKydXh3Tq/YqPdIpVKLt5adfL4uvKZDjG?=
 =?us-ascii?Q?QeUOMXJlruRJK1qOro09HAVekPWxdyNIHhPkDkeVgMh1QB6tQjZqVWi2LFKz?=
 =?us-ascii?Q?04fqd4fhcAMaJokz7h1WXVmiK7T60xLbK/1OC+iMsuEaFDl8l6QtEHZcSuZR?=
 =?us-ascii?Q?v28P2vvSbG8kKgexRzwz1UYDikXFR9euugdvU1cAR1QrNFJ+CG39cQh//qQ2?=
 =?us-ascii?Q?VOXIaX3IE0DFx5nlRI3J/0PLGDglHP4U4DVoL5CuMfBCiD2QJqdGgPbVU55r?=
 =?us-ascii?Q?zpZ0QSrdfq0AOuVOoQOyaTwyzt27dRlJB4s4owg4H7noI9O0QEOOqjGY0Za4?=
 =?us-ascii?Q?d0Ly7MW5Zjgkf27Rlp+K+g4FBVsYuzMvr9JfZfKDlzyFiq92/vV4nXszy15t?=
 =?us-ascii?Q?tJUcEv2A4JLvir4k/pwUAPWM+K4NCUH9/ay5GbnGYgYSSqv/OMyyful+c9v9?=
 =?us-ascii?Q?9N7UKGQczNijkbkBLbk+tOGNzeuGTgN/BAyd/pO6wfX7J0RGHaW/5p1KXVnE?=
 =?us-ascii?Q?77tfSetSBqpkmjHNg0wyK6njwzebSicnT/8vDw3xOAMeu2Q20w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d/OTqvFUtxiA0yO6ZS6MjcRjtK/K+f4BqxHuaC4twf8Iyg7mZTyEzSHiYDbG?=
 =?us-ascii?Q?5ToEUo/qnyOvyCtZ2hu2wxamOqmbsKARhitp6jLxFmogpNdJVvqUZ1M3ZgiN?=
 =?us-ascii?Q?ogeumoSBjrdoUmvyoNWF0MIVpAvv6YV3PhLw0CLjndsNJPpHRUkQwhUHWZUv?=
 =?us-ascii?Q?U5Osr6HJ2vsngqn5y9hoqbOYg664bTDASlPbuGIF/mfUuBvqS+MPvXouuUWw?=
 =?us-ascii?Q?lTL4kjMLts9rw1sn5JsMZDv8usLeQtrfMJzUbDWRVkwPzr2f2GEzApA7YDwe?=
 =?us-ascii?Q?XpBQWpjr4oSsWyXjgZ0F7iG7VT/uVw5cbY+0jZPX2stY7oP+3qBi15C1DcRD?=
 =?us-ascii?Q?kbuads+syWsJJ964Sk0mRnZnnEdy3IfP2FTbXkyEjU3z4VEeqAdZJclzeOd/?=
 =?us-ascii?Q?sh7vyrnIkjyIU48oUpZNEV3sPsoS0soxd7ywhHgTo4la5w3Q3JhdGJpASrEB?=
 =?us-ascii?Q?blRb/pz5d8olqpMHxL6CgMqIWmWMKKs1wYisgBJijtr/ZrA8ClZi6oRUpCxE?=
 =?us-ascii?Q?pYDCkNweXY93i6RfXG1dz2cd1XKB+5OVc3E/J605Jvjbf9zlHRxUYgdU7ugy?=
 =?us-ascii?Q?tos5ky7QtlD7FPimafAZL+VcZyYftRB6Pd/JlE55hsDEVeZ2MeJsh5Y/ZhiN?=
 =?us-ascii?Q?6Q1tS2lzOUMhGHEW5Op2k8yPs6wqYyOKkxDbWyP+oi14ctPkthGVsPKmxHBi?=
 =?us-ascii?Q?bCv7aW+7QV5bszkpr/rJhJKML7YM6YRW1FeXJUIkOhx9ODWT6VTKixK7LTzh?=
 =?us-ascii?Q?EZeJtSAmGEkBRkbV9+sVBUVZBYX95BH3Jy3qwOezaDIytbtMt5b1FmSNbEP1?=
 =?us-ascii?Q?l1BTCjifUFuN8OZLObB9/kShA8Xrf0O5tW9oPJuTZPQTejej0AA1FDvVjqAt?=
 =?us-ascii?Q?s6psaci+u7CWbBh8M+EihQBUSEvqlJKZrJCrXekU24co7fnmeQ7H2qTVCAUC?=
 =?us-ascii?Q?oO88ClIHIjoUfyqsIbw5QLXE+sv0bBgfuekDSgakM0BP2kFPjPAC1f9NDVPC?=
 =?us-ascii?Q?UdlrfeQ34OlkG2KgsPflgHHqjyUbMe/nYkX5lMdT8g4lRS9F8xeGq/FRAysn?=
 =?us-ascii?Q?h6aJ8EkMdkWLV/MtxSri8mvEaRSYYXBYZgjZX4ImUHUmztpCj2D7JziDzJts?=
 =?us-ascii?Q?3p01u3ONFJavHlPuQVNvg+pnI61Qnge15OfGU065fN0/1sRHBiN644v1QsyN?=
 =?us-ascii?Q?8pSlO+teuMKOBnPr1OyyoidejAEX6jNDbQWASS5wXB2BdYFzom9ps+3E4ABm?=
 =?us-ascii?Q?OFe2LC+dknCv5plltJEF7cPQzIfkoFAKcopdJ1c73/xDcIuKzx61hSDnaGC7?=
 =?us-ascii?Q?D060p6Ed37BQ3kVNjR3IMCf8IMNWqwrJDiyy/jlWvncdYu4/iBTUsdu/xZ63?=
 =?us-ascii?Q?A1Sm4u91iR+b9J2d+ccX+p4f/KG8Gq42qnPTPvhe24zeYMEEcPc0DBreFjZK?=
 =?us-ascii?Q?+Hia3ymZoAXG2rfRmOi/QAkguUYLfxBgof2FrdHDtY284l0k58reLy/on4UO?=
 =?us-ascii?Q?7IR92C8WI6FnYLut36Fm7AFGIANKZxxbb2KBcpJKsHrhKwUmv0/Ft6lIWjaY?=
 =?us-ascii?Q?79F1iPxidtod5Op+5aG6hRzR2u2Zbygorpk7ZgVl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a70dfa7b-4e15-4498-206d-08dccd5b9efe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 03:34:17.4456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4IvQPwl3QYySYCWVZL/1Fti/Te6zXeOEDHD2l0LAk7z8ic4r6oElGPS/3KnfTBaNACW6AfCKiJPGsis/fVMEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10175

On Thu, Sep 05, 2024 at 10:31:08AM +0800, Richard Zhu wrote:
> CREF_EN (Bit6) of LFAST_IO_REG control i.MX95 PCIe REF clock out
> enable/disable.
>
> Add compatible string "fsl,imx95-hsio-blk-ctl" to support PCIe REF clock
> out gate.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/clk/imx/clk-imx95-blk-ctl.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/drivers/clk/imx/clk-imx95-blk-ctl.c b/drivers/clk/imx/clk-imx95-blk-ctl.c
> index 74f595f9e5e3..596dfb2f3b75 100644
> --- a/drivers/clk/imx/clk-imx95-blk-ctl.c
> +++ b/drivers/clk/imx/clk-imx95-blk-ctl.c
> @@ -248,6 +248,25 @@ static const struct imx95_blk_ctl_dev_data dispmix_csr_dev_data = {
>  	.clk_reg_offset = 0,
>  };
>
> +static const struct imx95_blk_ctl_clk_dev_data hsio_blk_ctl_clk_dev_data[] = {
> +	[0] = {
> +		.name = "hsio_blk_ctl_clk",
> +		.parent_names = (const char *[]){ "hsio_pll", },
> +		.num_parents = 1,
> +		.reg = 0,
> +		.bit_idx = 6,
> +		.bit_width = 1,
> +		.type = CLK_GATE,
> +		.flags = CLK_SET_RATE_PARENT,
> +	}
> +};
> +
> +static const struct imx95_blk_ctl_dev_data hsio_blk_ctl_dev_data = {
> +	.num_clks = 1,
> +	.clk_dev_data = hsio_blk_ctl_clk_dev_data,
> +	.clk_reg_offset = 0,
> +};
> +
>  static int imx95_bc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -418,6 +437,7 @@ static const struct of_device_id imx95_bc_of_match[] = {
>  	{ .compatible = "nxp,imx95-display-master-csr", },
>  	{ .compatible = "nxp,imx95-lvds-csr", .data = &lvds_csr_dev_data },
>  	{ .compatible = "nxp,imx95-display-csr", .data = &dispmix_csr_dev_data },
> +	{ .compatible = "nxp,imx95-hsio-blk-ctl", .data = &hsio_blk_ctl_dev_data },
>  	{ .compatible = "nxp,imx95-vpu-csr", .data = &vpublk_dev_data },
>  	{ /* Sentinel */ },
>  };
> --
> 2.37.1
>

