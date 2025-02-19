Return-Path: <linux-kernel+bounces-522425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E65CBA3CA4D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EFD016AB1F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BA323E25D;
	Wed, 19 Feb 2025 20:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NOS03Uyn"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2066.outbound.protection.outlook.com [40.107.241.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D4622AE55
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 20:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997841; cv=fail; b=e1fUfbuCusIDU0RAs8OjzUtrpQQ4RCZO2IJH7fI/nb+2F3RdwMd/swnBX/0u7ymoK9KGnj57h/Ik1wUwTyp1Xi8kSIa4EX89gC+N86PFbhqjydfReM98TDB/7MtDi5pdQtMU2eCtuFXOWGlLAVUwwqXreioZn/cU7kobhD1BtuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997841; c=relaxed/simple;
	bh=JjQ1f0SnHL11ACxa1m9Ng+1wtHId7/66r9ZcDVyXg3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MqzyMGwT1NY7uZpBI5WLoy6WJ29j82E0UhYTruVkexXY6j4AklcqnUDMwRREjeJeKt3uzuiFGx0HM075yPjlC6PKNwUcElP2GRF4YCSQ/BHbMgNSBIh7bR/iNiTB5w93QBeHqmvcTZMg9bMCvYAT6yCc7DC4vc5bRkNJ5+Boy/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NOS03Uyn; arc=fail smtp.client-ip=40.107.241.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vzmZlS+XPl9fe7DHcjl1zss3HEYxGoZwO/VTnylJNFCeBaLt1HmtIvljo1wdsKK6q8wxYeNbJyz5gfdDwSC/FXXrGS6rZUeYh2TNlPmbQZy6Y+x0cXlsTyeKCsALB0Kxwst3jtUJ1UaiB1S3qPheK1c6Zxg55GmoZixUZQE93YDllYXyS1IX8BCkqWFP1Z9Ee82U1S6v3mCUqgk9mW/7IO8NHD9zSfFnYrJNlWbCq7xP8ZSlKJUvPHehBo/NANGqwXSvUw2W6VRWfx2wAPYOar9TURAF0nq1RSJVxVAAA0NmUxZCVHgt1plJpDckhlzBS4imlvNp4BqWVUnLThLMLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSk/i0Xqp/94bDVPTEANXv7c6RGsPgR2OoG4EAblRh0=;
 b=CM9Fvsg3pz54TP2Z0JMxN1RSOXYqWyELGKy8mkNPsONlVBjOVyYtCWqsQAGDWmeTGUS1QU6NUbD9szqM5TC1PwxCSKdXFD0L3ubdiemY9H6p7+Jy30Qk3YSI8Zyv0Fm78ADnNTMH55+dvmt25/4//jXJXVrSYaXALiwxxOixUHN6F/gj5KsSeKEgpAaRf1KWbu98q5gvB4DWITeMgMX5saDo7dIbLANgUJ5qEYOkSWTWwfWH6AowYfJFOr8Dmslhs7PNQQrZVlj2zIntTCqvefilJFTilhuT2BVws5LcpP1wc+RahNcQuIH256NrV0M4i5cTM4k4CTPI1rO/ravjjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSk/i0Xqp/94bDVPTEANXv7c6RGsPgR2OoG4EAblRh0=;
 b=NOS03UynSKLGFOLWsJNWCY33ASaUxwDTc/jLQcDKm7e+WoQ1EkgBKPOaHVviBZTtr3Y6H22I7Kgh1B8rvTnUBxbZ/aRnl1uvFHi6MIApuLxwu/bbkZ4MnG/cKV8dxSDUVYKIzuCKrAm++UifUs2gu/7tOZdicU5m8hs3wtQxqk38bUWOS/N2jYn8PZl3lt8SxPZCvyg3tKqM52X1CH2RF54bjcK3eW5fxIcoNaFya4lKSmx0cZUgXPR0Gk3d3kWu8HVuSKXQxWddTdUAmy/aYWc5Q7sgRIrE/Xah950pmnjIfW/NK2hKjAYlJu2F4guYzTBCrLxQMGwRT3tFyxbyBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8301.eurprd04.prod.outlook.com (2603:10a6:102:1c5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 20:43:56 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 20:43:56 +0000
Date: Wed, 19 Feb 2025 15:43:49 -0500
From: Frank Li <Frank.li@nxp.com>
To: Stanley Chu <stanley.chuys@gmail.com>
Cc: miquel.raynal@bootlin.com, alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	tomer.maimon@nuvoton.com, kwliu@nuvoton.com, yschu@nuvoton.com
Subject: Re: [PATCH v1 1/3] i3c: master: svc: add support for Nuvoton npcm845
 i3c
Message-ID: <Z7ZChfx9HzySO1x8@lizhi-Precision-Tower-5810>
References: <20250219011019.1600058-1-yschu@nuvoton.com>
 <20250219011019.1600058-2-yschu@nuvoton.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219011019.1600058-2-yschu@nuvoton.com>
X-ClientProxiedBy: SJ0PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8301:EE_
X-MS-Office365-Filtering-Correlation-Id: 508e6333-60b2-42de-029a-08dd51262102
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tda3/YGDX13+zQQH/f3X48TBeQmiR8VUmnqEZiSU+oLeYLDt/fqfgKM52I4z?=
 =?us-ascii?Q?jtQsnJ9nl2frdLJEQaDMbBXbqnt3vVpr0R6IsZLhsyTCcasRGZUbYw/q0wJw?=
 =?us-ascii?Q?ClxNDA+Xp6trdVSAi6wOIQrSFkhNCKzUzP7PGDVg4vJj4KOVlyqgttA6rJOi?=
 =?us-ascii?Q?XN5TywGN+xoeyDZMrIxCZ73LRfTFsldcDkoAhPUe7CqIKjf4DB9S46OvAzX0?=
 =?us-ascii?Q?jK5oCUu5P8CnRk5vReOqWWd29ZcDN8HshhNnOstm2LsvOERwxu6dafVzIR5u?=
 =?us-ascii?Q?Y6nZGKfKnoTr/WPba9SjHc7ikka0f5HfJpT1haRSxpHOzIOrqFhApMbWuviq?=
 =?us-ascii?Q?F78hE2zCIyyX1PLFxGqmcBpYlnZofdg8Bnj10Z98+1bOP7v1Yv6YM3Zs5Gru?=
 =?us-ascii?Q?9f4PQCGkdMlvWbkwVng+g96kHXivXuaP5KFgPo0gXCsZ6Du+PlCdk67UqWjz?=
 =?us-ascii?Q?kZMdRcHGS+C9xLtdNR/OU98RlQE/IymL4FHtSeq01AkjNeHcnTTgkE3gMQuk?=
 =?us-ascii?Q?3IWjqXBzBv9TtJkqNV7vm1lAlIzCte1iQwQYNHdtx0MdDWj1qzL3tKF3vSMD?=
 =?us-ascii?Q?6eDgMC8PFCcpfTTIirUdd5kYntIB1e0LcuzmXvg2ww0zLen0PcUrEZwI4QBp?=
 =?us-ascii?Q?ZtE0RYBS1iKu0FnfAkEYAGtiKZaYOrytx10Qp1dy10p0tUD0RBTjDgHZ8lTH?=
 =?us-ascii?Q?8vwARN3POS2Fgee4oiekqGj4H+g/UUKY736MWNfTr3w0nlg8eybtpbj20cr8?=
 =?us-ascii?Q?4oAz7pxptSN3+mGdhR3vLHwH4UdkyZHRNp4e7kT3TRG+om7gc6YNArTwMA80?=
 =?us-ascii?Q?iQn3rJuRbv9Gr76ADXNbx+THp1dHzuTi+91yCMYR26qjYypa+xsgZR3+WP5y?=
 =?us-ascii?Q?GYn0ar1EW6jvUq7CY6Q37NAe37tRu9D1DDeuxcYKXHuiT3bj3mMyORz80XHt?=
 =?us-ascii?Q?XZD0pbUkw6AhYNvlZ3kDBk6CpN96dNUAGMbv/OWoHdlMec1YECVt+penU5EG?=
 =?us-ascii?Q?xvuV7w8tuw/JAT/FTlTBDR8cFzCMocO9kGGrIXZmTyJQRnDJiecOnYBu8joj?=
 =?us-ascii?Q?B+0SXVotejNfamcUqtGBvyh0ZC9yzz7fpvZG87QUoIijBcGWAZgi2OmHo+N9?=
 =?us-ascii?Q?mb7txG0oFkkGlRo9FcCBlZVX2qgDXjiBtwhclTxPHEj8iQ+odI339CBXRzXA?=
 =?us-ascii?Q?ASBdOzd6n003gfrUPtYAkXVfz7FU5SjxY6s9f5oc3S5rH27PSeA3UiDSRXmu?=
 =?us-ascii?Q?mzoAaQoM70EBpOL8IfE2xdtn88lyx3nVBja3pfGPs6eUa9loveDCY7GExNrc?=
 =?us-ascii?Q?jot9ktVnfZZRC/Buhnhu9vFggEvJPc6lRKg9nxNh5kGxZQvcMOmiTuW4ilDx?=
 =?us-ascii?Q?IA/Fv08gZ5IWwgDpFVcqFXHCTBsCQRlYCZEBxavvlueuIJDW5oGIlDTlvMXi?=
 =?us-ascii?Q?GzCdOUCEZhHaBRWO1za9JSMXlj5NwLNl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VDJ5Rys3WyHjC77LyT7eSNlIkQ/ETOzOy3Tro40VmCxo0m763rdyCbfOtxQJ?=
 =?us-ascii?Q?+1HT/bjKH6wy0O/9djBFPF5+YgwUJLiMc6FSi08ww8782wgoDp8RXycUWjMs?=
 =?us-ascii?Q?ZYJr/qyNwgkFWq1uC5snCdtL47JFkx+j5ew6DY3y8ezhfA0D8Hgnr1YPmFev?=
 =?us-ascii?Q?dl3w0IwPXOZS09BPmQiSzIClagkW8bta9IOr0u8fozYxWLU5OGeV8T+o6Ih9?=
 =?us-ascii?Q?wJzgBBqGWLGJjWTrKS1LBwl2/wH+xtoleTLy/OAvUk7E/aoRCDgpFmAIQRv6?=
 =?us-ascii?Q?wrVYC1JD3icZRGTGIzs6uR+R7ZSzt/aEXItmp2nP0Fy7yosHJKDdPpBiHh/p?=
 =?us-ascii?Q?mAoxS2WFNT7XkUgzAu5GjjeqIq5gPLkd2IGjgo4DZJGon5i8WfHrF1oF7qDc?=
 =?us-ascii?Q?Vf2OnmtuXkOWfVPTkZqpqzKrnQomy/0E6+LqVhUuX3m6AY7a3t47Ju/fmt96?=
 =?us-ascii?Q?3Ro3ALh+O+Eiz4aNvgJIVLJs+HTATF3CYa+y81GuG5Ocg4hRLDjpmhO81gpM?=
 =?us-ascii?Q?1rPi4T1AlKDgV5bgw37Uz5sXzm++piAqeM40vaK1o20+WRwwuK9NL3ta8piY?=
 =?us-ascii?Q?YWlzNMh6zp9Bdgx21C4rfLO111KFwK0+dLPbk9rInpRSqGsqjwNIi5utPN53?=
 =?us-ascii?Q?f7WLKo0YFBgcl4Z2WKvRYhis5Je3xYvfBFrMbtvsdX6rpHJ0Cqv5E7aTpspx?=
 =?us-ascii?Q?6CsdXS/Mnfd+fZz2HFy1CzYB+3kTFDH4H56QuV/5bxy/ALIAWAkkuyqAAohb?=
 =?us-ascii?Q?9FDMoBGMTqxUNHr2FOZ+5IL2xsemsw16yV8IOyk0WGWk9JjDOQp70UW9mcZk?=
 =?us-ascii?Q?vwbKPE1X7R0P7J8Q5XqCVNmkDrVOWiY5MzS66tzEkBygYUUL7fliVP4zW0zg?=
 =?us-ascii?Q?1oZ+Rqgf8ZiqXgt8qsOas/7jZdRUY6OqndhjR7uEoUUtuPho6pROvbkTBLtZ?=
 =?us-ascii?Q?VEJfPletpCxgUyYq6l3ZtQOw9hDiQ8xG73P5z21iE5rkIWLzGB2HeAZFZYwI?=
 =?us-ascii?Q?Zt0GwIk9Emu3AXBxoB9HsFTdIO2SkfNyqL1uO4w2YdDoaa1lWUZ+XoO+YEF+?=
 =?us-ascii?Q?/MlmpolHXrbPZlOZghrad55Hd+MxAp11U7CMO27MKkKEOWcrYoxj4ko0uzLi?=
 =?us-ascii?Q?rMiQr+w/iuch2L/ZB+UO7yYghkHX2LWw5HPO2dujIIEBhlGJGRVpA8ddQ1uy?=
 =?us-ascii?Q?QTdUgTirHmDfaGB5998LBsnZqtunoTPtv2OOKs7kHWal3g7l+Aa598macqw6?=
 =?us-ascii?Q?DCxAG/U5QbK8d3Hzlgwmsx9ifNNkqtca6NETs7CZWoq1OZsnYowu3tqcylwZ?=
 =?us-ascii?Q?5H/29vIheloVLBVJ+Sxbf3QbQ9lGuZkopXNSEeY44hkC04AByWr/iiKnNi1y?=
 =?us-ascii?Q?Nh8H/6UfJIANE7uaAWY0MOLDxplXsgqtlJ3PBf3GGCDqInxD72Scg98WQu5D?=
 =?us-ascii?Q?R7RMhcMa+NWIs6CXJnVJnTbwsQvMWRbzVVunA5S//IAMIzH9F0ETW1K55BSp?=
 =?us-ascii?Q?Eu/vtELSfd5ZImQB/EVuZn54BYrupsxvGwvTZoDPOAw1456kOXqZ31pQJymD?=
 =?us-ascii?Q?lDJFYRHRrIKgd5Y0e9uOXhrB/gzjaF+LAq3vraCF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 508e6333-60b2-42de-029a-08dd51262102
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 20:43:56.1819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /E3IwGRcBRegfnHcwj7ReJ1RTNEjJMZ07MiWWiT6bfJOEVbdr7WXlvMY0mvhDhQZalUX17wdETUEplt/40W45w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8301

On Wed, Feb 19, 2025 at 09:10:17AM +0800, Stanley Chu wrote:
> Nuvoton npcm845 SoC uses the same Silvico IP but an older version.
> Add a new comptaible string to distinguish between different
> hardware versions.

try wrap at 75 chars.

>
> Signed-off-by: Stanley Chu <yschu@nuvoton.com>
> ---
>  drivers/i3c/master/svc-i3c-master.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index d6057d8c7dec..813839498b2b 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -1960,6 +1960,7 @@ static const struct dev_pm_ops svc_i3c_pm_ops = {
>
>  static const struct of_device_id svc_i3c_master_of_match_tbl[] = {
>  	{ .compatible = "silvaco,i3c-master-v1"},
> +	{ .compatible = "nuvoton,npcm845-i3c" },

Need update binding doc and cc linux-devicetree mail list.

Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml

binding doc change should be first patch.

Frank

>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, svc_i3c_master_of_match_tbl);
> --
> 2.34.1
>

