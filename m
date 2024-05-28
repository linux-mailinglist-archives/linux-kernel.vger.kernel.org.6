Return-Path: <linux-kernel+bounces-192616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACD98D1FC4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF4F8B22261
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7068172BD4;
	Tue, 28 May 2024 15:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NnUjsmc7"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2080.outbound.protection.outlook.com [40.107.22.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DF2F9D6;
	Tue, 28 May 2024 15:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716908883; cv=fail; b=tVu60TGwXAjs7AE6bzp7PEAkmi1JS5ZOFhhu52hvn3g5N99zf0mib3r3mjFO+BAq/vHwaTQG+4JfaCUyAdAYwvwRS1SJ03F0Cb/fzNZ1ldheYnM89zPWPPJ29waeKxfg06Fiv8wfj+4zBSu2EezujKRMIECfU6Sq0DRVkB7/C14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716908883; c=relaxed/simple;
	bh=HLe6IxOLguZPKClP9iMGv0PA5OYHnLG4OY18rAJZsRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NerGI1DP+TdQ+/jlbApBKb26IOG2KIBiSG9kjhbdrOIdPfeHP9fBrPjlMa5p/S/eE8UeEFJAQyYgPHVJxZywWJJdpFE8F2bCxOJrcKF6Jfyas/K7s8psXCPZUnqI9+XYA7aW03IeXz7Ac/qMSaCZqrApVyL1mBmwBb4G4rFRBck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NnUjsmc7; arc=fail smtp.client-ip=40.107.22.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbNLLllOYs7L1CZm7GMC6lyDySEGFKbbWNCbvH+mUMumOazHFD4Hj9KjkjbFx44CpNAKoim95+B0lVLCtlWLxye+gW8eQqupO2MW2FRjB8YGMgJF4FmP9l7rd+iFcs04z/PprI2gejxCI714HPWAIxpHQuCWC2C0izV7PE+tvebWz1XDZLQFLCSVs2ILVKGq2t5pV0zVNlY9Xzp41/GuLeuvqgVtgqbCBoNTi4qaP3sVF0lyZRgDrxhMLLFWqzbtCA2OlHT01kjUvtLdOlDaAlwsnpM0m6qInK8Yn06mR60bvFO9+B1s0F/8UwO9sXBBpTfnJdbA1cbfq02W2qg/+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/wd15CfZW+Eal+hdQZZiJDZ0IOkxscnbZZGk+AQVHU=;
 b=DVBFCSN+pHsQz6NR1S1xnJroiSbM3A1nC7nNlv7xAkkgJK6CgHlI/cDS/zACyJopkAmBsS3L4f5+g+t3qHdQaXLybvYGuX2uKiiNuJvWhjmsTq21NVXivjDSG2yKWr3jQu00o0/1eesF31t/fgx4tUf8ISDqgi7V2fZgRcdMeKlV9W9tOq11pmZjNNs4Y5PHBYCn64wWott8EEfln+OvD8dFJ3eMTw7scLzouAzRV0jefNYYSFPhUvK4nqarUM/dOlcoLEaRka4k3yp7r/ZtfijGPnEIIYp4kqSEZ2F+nT+oIE6ArO3zPBCmVNjR4l/q4pERBqgORT52rfEA0F2tsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/wd15CfZW+Eal+hdQZZiJDZ0IOkxscnbZZGk+AQVHU=;
 b=NnUjsmc7FnWqXyhfP9nI1aDaCM3sOksOAsz/FlEDgfEGhsIBDP7cVeSCDOG5ynPnyuM1UOdmoTmrwviYu+ZafJkE/9yCRH03Qjz5oERaAjpk+ESiwWB45OV8hrOPPjO/KS2Ufx1F/j7za0BUPQ80Cs5lRy2FhMXr/uLQGYsZfOY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB8045.eurprd04.prod.outlook.com (2603:10a6:102:bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 15:07:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7611.016; Tue, 28 May 2024
 15:07:59 +0000
Date: Tue, 28 May 2024 11:07:47 -0400
From: Frank Li <Frank.li@nxp.com>
To: Pengfei Li <pengfei.li_1@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, ping.bai@nxp.com, ye.li@nxp.com,
	peng.fan@nxp.com, aisheng.dong@nxp.com, tharvey@gateworks.com,
	alexander.stein@ew.tq-group.com, gregor.herburger@ew.tq-group.com,
	hiago.franco@toradex.com, joao.goncalves@toradex.com,
	hvilleneuve@dimonoff.com, Markus.Niebel@ew.tq-group.com,
	m.felsch@pengutronix.de, m.othacehe@gmail.com, bhelgaas@google.com,
	leoyang.li@nxp.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/5] dt-bindings: clock: Add i.MX91 clock support
Message-ID: <ZlXzQ7sWm1q86X6o@lizhi-Precision-Tower-5810>
References: <20240527235158.1037971-1-pengfei.li_1@nxp.com>
 <20240527235158.1037971-2-pengfei.li_1@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527235158.1037971-2-pengfei.li_1@nxp.com>
X-ClientProxiedBy: BYAPR06CA0033.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::46) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB8045:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ed65754-2868-46b8-2350-08dc7f27f63a
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230031|52116005|1800799015|7416005|366007|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?e+A4754/NWpRq+1VWohVn6gB7m8GHIH0OGyASJhjUVAmSq7XGYc9/B1rQ0SX?=
 =?us-ascii?Q?nSLlU8rdOE1uEApnQ+a0tyK3iYXYfi6ibjorHvrZzqn2bjgbBBt8Fi81ws6O?=
 =?us-ascii?Q?RLXTlrrnwawNpcZka3aeHyOvuaWEPAcPAK1nQdS4hNmxPCt1zMShKxSWVLl8?=
 =?us-ascii?Q?3rXrf/k+aS4pn6u/kADu/LYxuVoCyPKNm/SyidVQxpLe5lxMoCoi0K73L8th?=
 =?us-ascii?Q?at5Vps2d/MpPV/KhEbOUkgMBz30Wqqe5PYXNoGeGkXkvlxHju+w/V88dszwx?=
 =?us-ascii?Q?iWsma/W8CYhdW8kBCzYu1ijTuidlzh+OL5tHfLfrwJVFFQ0Y5YoPKCEPdDJV?=
 =?us-ascii?Q?24KEnPWdhMaAWMRZRy6XWkkDVwmuwJsblc+tJN2OxVxgMIVnLQN5Fae/QXri?=
 =?us-ascii?Q?Ifq5uyNL69XX679AoPle0LV5sE9Jc6ZAjq+Jb3bCEvXEA1PkcVfrDmvelGuS?=
 =?us-ascii?Q?EC3nBWahiyZrX5Bu7GV9ftk0DChBUs6107Mw2eZl7LIkxTjoFolLF8yjkjEG?=
 =?us-ascii?Q?0wCD1spHrPxYts3sShyXZvs6RL0dvgVOx1dRtI9MiKQT5IcpITg6O1lM9fY4?=
 =?us-ascii?Q?jLdaHYQtj3d7LLB/b2AYpNge7/+Eknz9cK6tU2SSnDu+dwq5buQONwZqLAh9?=
 =?us-ascii?Q?XQl9V84qrFZ7K9zVYcWsJYHOh4fQK93hllM+YNnXDAQB4QE8uys1vy9I4BG/?=
 =?us-ascii?Q?PYTdbSwir0o8h937ogbnCkDDyT2YjErM741h3uLyYuR6nDAZhkq7hL4OPl7h?=
 =?us-ascii?Q?DT7WBCLfazE+5Ri6KBYVocZqyIBC5KW7FXObRtJjSfmuPyIayZpqp3z8qKUu?=
 =?us-ascii?Q?m5zcFdEoVST3kGmFf/HIiFz+s2Z1MrJZwH5YveEal8E0YqrTH5PD11mXVGIR?=
 =?us-ascii?Q?cn2WhNIY6+UKKw1582EJ846gWQyZJjAGXeqTGZClQwRd2tmGWPgjoK0h/o4F?=
 =?us-ascii?Q?ldOfhZqD0RccdibKGPhrOGJj4T2DZeCrOl8MZp7G6PAlRosJDS3nAvmd+rP1?=
 =?us-ascii?Q?QgwhCKOYd206a2C5zED+ZVrRjiFP+DrQDWKhVq9ssdvC06WIiF4AF8Rwfc5G?=
 =?us-ascii?Q?6RyD1g6AVvmvMLQ0NXGtew7BuuE1c/ObfzdkZtBCWLbrbS+w3drjxCr1LHBC?=
 =?us-ascii?Q?tkk9qFTST1BlQbw7cD3VQ03lLFATtcA4/bBuACdo5MlMYI6kce2gBgVWopXQ?=
 =?us-ascii?Q?QKTIP/N9mS0BDlnNi2Kz76jHLWqGObHhc7r6z5+HTE9clKN8YSGIpLJaxWvI?=
 =?us-ascii?Q?FYBk+rX3vlbJhV1Ngx05EgyOfpRsiy6MbYfLTLmoDT+FdVSRMmZGT70qYVuP?=
 =?us-ascii?Q?1UI14bZFW5Oxb0/dJME3IVb7u+rR0i0MU24RlGY5EfTYGA=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(7416005)(366007)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?WbiVRjau9SmSHvgo1ejR5ZH7CEa2XUFEoovYuOPO77GIKe4mKqbhEvLI0IkS?=
 =?us-ascii?Q?Z69fQN7GtkwgK4Ptq8DqvQvRA36qn2mZxkeWwV/jmpWHmr2h3wb43K4hBja6?=
 =?us-ascii?Q?KS7FhM5yczVs8oXYptgCkX9cNx3qFl5g9+7q62LwxxpTj3TQtSYvj68e+MJp?=
 =?us-ascii?Q?aweyAGyNDAT0O45rpt+gTY9nvNvdtQFOORQW7ZJ0gyJNEctB17KvQX8LnXev?=
 =?us-ascii?Q?4he+8FG2+QLavcqJxkUoTY85I9CATcl+sKt9yDHCa6dXraVRqhAo2Lk+Cdmb?=
 =?us-ascii?Q?5jrdoJTI+mqwaT7ieDxMMvrLrXBDswP/vDNygF8FLVyL2uQHpODLq0H13upC?=
 =?us-ascii?Q?NUjc/il67Denqhr6qTczCaUfOtpCUOL6UjbrI0AREgaX76hVYevQJRrmMUni?=
 =?us-ascii?Q?TuJJMJhgGWD2jYcNPUBdvX2alB+fzJn5w0FGLPeiOieyTmDNHnf/dFHttATx?=
 =?us-ascii?Q?a56b9u0kkObz0wzKsQr/LZsRb8uWUANLWrI1gyN7jgjOSk7WzvxHwXCHgUBZ?=
 =?us-ascii?Q?Lun/+tnsp/TegLYB68+gPRbcxBMoGWtgYdcDN5KeE/yH9LSuhUthd5jJeyAD?=
 =?us-ascii?Q?srU0qJZBojMpDBIkAIGvVR/0eta6AbjwDEN0776hbBFCP4UwFi+0vgiuVBrY?=
 =?us-ascii?Q?4lajMibK/3b21Oi7kxpZbDeHsuSLLN4Q/YvoQ4CLW1s58bSTQwAaHXtx6YM5?=
 =?us-ascii?Q?+hrROh0DutEl31IeewfIATKV80G3dlntG4BkRazZk3kJ3TNeiuvvDVRlM/Zg?=
 =?us-ascii?Q?FyNLN2Fei5bRAiec9En/RJGbylSZOq2gY/AdM/3HOkXoKHVTnlJ7QgmsBcdl?=
 =?us-ascii?Q?o2YlMIVbOl6bnUKldBuY6rqnV86XYfgIDEDKK3jjEYiPVIML4IL4MBBzmm9+?=
 =?us-ascii?Q?GC0gsuuEDaVU0WdxjilLSPzr6ifOJuWcwITbhlSe7qA4vfclIcs7hoR0n2JB?=
 =?us-ascii?Q?1ZYskakE2n0XX3WxqP5lfRMKbAIfv6u0tSyz3cVE5JQbSgZppE+8tQGFCVKc?=
 =?us-ascii?Q?cWQK0lnxiO8Q8qaStzSa/lBgNh4Ta/ojc8IMUkmgjOu6kcocwgkVeRk6Dq1V?=
 =?us-ascii?Q?kQihBkBJM45UN3sswuAXIe5t3jAqPP8IKGkn7KvbjHA+Ikim255/+KyBi7jq?=
 =?us-ascii?Q?RivQfFW93hBVBCJSj89cYvGVi1528HhABWxsyd5X89OCiR9e1rMhwFOsJulp?=
 =?us-ascii?Q?FGCsrDay5pHmYmhjSecerdgDkDO8P5FdqD7wsKqbsaRYlod5u6jd5R6vdN/Y?=
 =?us-ascii?Q?79zVTzNRYuG3d+/gRpzh30nfPG/88AqlWiyr/kwjeIYN7uH2GbQFwdoozwfn?=
 =?us-ascii?Q?TzPOdRbw+8Bw9034Q3job7X5ZP86o0uWe3mizrCBnzYTy3FoKppgi+RWgOYu?=
 =?us-ascii?Q?s6JEDZvgcDA5BWM66VRVM/ISUkTO6r6wB73X11UzjUTw55We+aS8Nc5m/sf0?=
 =?us-ascii?Q?dSMAc/oh/JXJANyqVar3yjkS5FMi7KWMvhMayADVv+Dzg0HnnvlgIQc4PRv5?=
 =?us-ascii?Q?dSY66fGY10WbvdweDofi5htxeBBOj+dcv9gladIiRIV+axWQCHa6g+ag38j7?=
 =?us-ascii?Q?R+Hm3Y1fwuW9EZwt3xjxGB1yA56xzsTXpZOiShN2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed65754-2868-46b8-2350-08dc7f27f63a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 15:07:59.2214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hIzEAJdpzoDV7FEvwZWhj6pv4wYv8aLeFBzZMlqmgiggZzdvtwBDL6wD+sGNJ/AQdnkfgHWURx1fFKm8J2b7bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8045

On Mon, May 27, 2024 at 04:51:54PM -0700, Pengfei Li wrote:
> i.MX91 has similar Clock Control Module(CCM) design as i.MX93.
> Add a new compatible string for i.MX91.
> 
> Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  Documentation/devicetree/bindings/clock/imx93-clock.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/imx93-clock.yaml b/Documentation/devicetree/bindings/clock/imx93-clock.yaml
> index ccb53c6b96c1..98c0800732ef 100644
> --- a/Documentation/devicetree/bindings/clock/imx93-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/imx93-clock.yaml
> @@ -16,6 +16,7 @@ description: |
>  properties:
>    compatible:
>      enum:
> +      - fsl,imx91-ccm
>        - fsl,imx93-ccm
>  
>    reg:
> -- 
> 2.34.1
> 

