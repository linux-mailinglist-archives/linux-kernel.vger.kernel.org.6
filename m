Return-Path: <linux-kernel+bounces-341993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AB5988963
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 18:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03C55B210E3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 16:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194ED1C1745;
	Fri, 27 Sep 2024 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UpC/zwCC"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013012.outbound.protection.outlook.com [52.101.67.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22150169397
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 16:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727456317; cv=fail; b=JY2HKyvwBF6H1SnaFvDUqmsZrort6QvDLvNWDTxf/TLNjLCbd7wkUe5gRT0jtvWT34XqcLZ8azZrlxX55ZSz8uboogaAsbCN5w4vm5zn2Y9kqKTlovvYLXgMydg29kfoqVb9tpG+K/n709dE7D0H/Gqv08A7GSXfmLx59DizDFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727456317; c=relaxed/simple;
	bh=DEA1+fSvpl/AnJGRl7++WVRh/uNrA2y9NTRK2ZDXjas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YpzrQvAbBTS59Hbq3mk6dWqqyZjeYLypFnIz5W4uesP+l6WyufzCe22HcOqQE5fWPrXZQD86VONen10FwmxT8abHdSB5Ksw0eG5kPYE4Wqm5bgysf2hVJOmJ4n+Wrhtwo9ovUQ56YQeW0UEXuGr0ofYtseAlwozKGVoLMVk0PKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UpC/zwCC; arc=fail smtp.client-ip=52.101.67.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u1z/1u4bJjkoULrjo35GZ0UIu1wGi8Si19VHStMoAYUtlQuiuzj7S8rK98YREdnuwwxYG4jnkSZS6D3PDWidSdhSTLoh9DB4N1VN49pxvuspW+5YfZgKU5FArKhVk+YZKbLkqjVjTQ+U70U9RWCWq740tcbchw1g4sj+4EWdH5YKl1aDAo4NsANDlEoezvCXye7AAtC4zU40IAbNS8tP1vvQmcS48LLHUdG/EMtCd5BnxFrY76z/2b3DkZBZQBpjm4EJj/IPtNXJmlUt0Sc6iODDw7wzqUHDGObcbBtTHqEPd/T0sUQa81NX9V1A2rSAMg3U6QXBAJwmotKfUuM8eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55q796GMsiKr60Psca7znF5N19LZ8zH06ACE8ItKhgc=;
 b=lFf+HILP/pTgWBVcEemhOqXoHRhF7Xl/e4/GG7Aq5fjjb1VwIIXimO2jbmFQ2fq2Y/epp8AVmTrFlbrmeUdnZ1PNk0h74r5a+0syH6HvsL07Y4Uq7hfJYaOk0KAerrH53rycEgK7g7ehbC5mZxFNdlHfxDxfHwArlmpEIeb3+Gx3uXuz2Fyd8Iglke8qvQXwTKRKLx9C+vj4S/CAvRyjHNnT8ummWlSSaLZ/5ImfKJGOL+9kRqkBlgzDqMUCi/CoXAfe2WRrDpaTAn3FSwc/SZms2KD0rhrp7y62IF7Gbmq/oV134YUXUI1Ik3DmY4lN/05CS4GrUAQCqknRzNkFtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55q796GMsiKr60Psca7znF5N19LZ8zH06ACE8ItKhgc=;
 b=UpC/zwCCnXah4jgx0ZK2c2KObo28KNxacnyeqw9QLw6qDQXRCmu+WIWUnta5QqJMVLzkSSKtB6XcYsRtF3Xns8N8InIocPauD6i/zkv9zX6j5uOaNPxST2Co91e3fkvy1GE37AnnClMZGfgRboDS1206Rsam7k005shPpcZhQCZ1DI5Vru+c+M3eoQGno1FOKys5VINPGn5kVLqbbq9zKIs6ppbcrHqdYPrwYFW3Q0tkXwZFRwoEaMNJfSk66UyfbnrSS2pLJVc+VELpZpl0Cg5XhTo7xEZtZN5dG+NJbNzEYzw14gq5nQU6ekQ47+rbam1d8xwZ9W845WBDBvjCog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9480.eurprd04.prod.outlook.com (2603:10a6:20b:4d6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21; Fri, 27 Sep
 2024 16:58:32 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 16:58:32 +0000
Date: Fri, 27 Sep 2024 12:58:23 -0400
From: Frank Li <Frank.li@nxp.com>
To: Marek Vasut <marex@denx.de>
Cc: linux-arm-kernel@lists.infradead.org, kernel@dh-electronics.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Arnd Bergmann <arnd@arndb.de>, Fabio Estevam <festevam@gmail.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Saravana Kannan <saravanak@google.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] soc: imx8m: Remove global soc_uid
Message-ID: <ZvbkL97Ba3CNPjEk@lizhi-Precision-Tower-5810>
References: <20240926213729.2882045-1-marex@denx.de>
 <20240926213729.2882045-2-marex@denx.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926213729.2882045-2-marex@denx.de>
X-ClientProxiedBy: SJ0PR03CA0259.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9480:EE_
X-MS-Office365-Filtering-Correlation-Id: e713d652-90ea-4cfe-ff01-08dcdf159e27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ug7Ao5RoSmilxfHQ9mwHDLk5czjzzn+dM3LZqRVmjtSScEWX8LKBjJie7YYc?=
 =?us-ascii?Q?GrD9Fy8SRI/rkQzdMbYnwbdcqdTW9uFh4Hr5ozmUO8ocqHDCW4/K//8iIHgY?=
 =?us-ascii?Q?5TwZXy4o2Q442ow6KnvKNhPVhVBYolg9RhSXjEGGmCFYZakhitTegvqihQzs?=
 =?us-ascii?Q?Ng5kJ+x/l3ExFilWJlynnn5wfVqaE2BiYnlUOuHiUyWJf8KiLbGsJFdsQpEB?=
 =?us-ascii?Q?CQVwsepo8nf4H/QMWNt0vIFqQkQCyLfCU/k59kiOf5+E+kjCipfCCx8pucZB?=
 =?us-ascii?Q?smJNfgoQ35T7hxu9bRni4tUs0cEoXN17Z++hNdrHf29IuGYpqPI1E7xUe041?=
 =?us-ascii?Q?s1t0xMSaxlLE/KsvKnRAPzzmDunkYtRzAeTXuy4goiGO9MhUhBV2tLDnwLeD?=
 =?us-ascii?Q?l9BpQS8jzwOPoPw0lfWDGj3VP7P4TVC74inNV/iu5wpqVCEVgrAZST7qsvDR?=
 =?us-ascii?Q?EOV1Ds2r0+dOS7w0E/ZaDq3eVuROYEUfl4DlNJggdB3G1Bsie5CVtDIiXzHO?=
 =?us-ascii?Q?5M+GbigHQ95W8RBQrKQ3gFkdV9Ld3Kh+4T4+nqq8xK1EoVLxQq6lzxG9qYg7?=
 =?us-ascii?Q?s+UFEQDjFf+/R0x/B7PKcbpvuk09fM80xCM0DIROdaXwSgMz2qp5eZ6Ac/A3?=
 =?us-ascii?Q?Jk3q8I1h6+4iQxvVxIYkqJnMmLLRpyhbtvPzk8faylr4IzYFr8T30iz2rZYz?=
 =?us-ascii?Q?ulQSQoT8kZEEDUg8Icp5/VP1eAb2IjstOUo09dLHVGWpLTgh1eUjtleGSinh?=
 =?us-ascii?Q?LEGJZZYLB7wPiEDoV/HAMkVlIBQ1r7MRNeDuXlPyHN16/2pBbBdb46kwbFxR?=
 =?us-ascii?Q?nW4Ckr/OnKsh+pa4UMk6paVUEyEhOItxYjSIM1A9EbcmsB6LwmmEOPl7X0U6?=
 =?us-ascii?Q?zB7SyynrSefJRepdvZ3HYMEZ4EudhrTmnMGv8Bi+IFvSKysqzXANe9rQ8iv3?=
 =?us-ascii?Q?aUc+07gNsDCqNaBb8SJnkq/8CUE9sT+s2JaEB703KyUEqAYhhSfC9gl1E8eK?=
 =?us-ascii?Q?c54mswjmtqaIUkvyflYwIaXxrNUtbhEbc4h2le/zDTRKrQT0FFStBnJqtG+B?=
 =?us-ascii?Q?jkLyYpwYGfSQq31MNcsATJ3z9QMU6P/gB8zEhqA5MbRXCLvDDDGH2ZFVShK+?=
 =?us-ascii?Q?3sSC5N4+bRWiy1EqBoiWRbKowuiEbOKs9P4/SdRx+Kq7TJslSwkoAZpNd1MB?=
 =?us-ascii?Q?v/cdK3Er1C//U3SuEyvZIwKMbtg/GZauQChpPVGSdz4LVeVmvhJ3Obz9jiJ1?=
 =?us-ascii?Q?1AcWkkP07rVwrAjcO3a+F2i820DRqwOFDECa68IdDJF6djkUhQUMFHHuxscQ?=
 =?us-ascii?Q?iYtD09fGDwCjKb89TDxw0/DDfP/ZHbNwxh0lDJ3MgaY9ULxgVPeLjVyuyLzo?=
 =?us-ascii?Q?Il3B4r70xHkJsB2qT0n+mHwDwoN8FTK5WLvRLQCftxcGJmqbeg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WyvMWbUG5fGXM1Sel5BuMcxmj1heq0CMjVic6lJKkR8IfKVDrc50k7ebLJ/F?=
 =?us-ascii?Q?yfqu2N+lIbdA5mF3NRy1e4obxEgcvzqYKLw4nBvXlLd8eUYitgPS/TUvvD/Z?=
 =?us-ascii?Q?jWY5jsrbcWzYX3fRVbyyZUmPmnpzNF6oPqwTs39K6dRL+beGUUyny9TcMNPk?=
 =?us-ascii?Q?hQ31E5tr87xHhyEQMA2IBk9XpX6Tni/274J8c0/RxLl+UdDve47+nbybrzxQ?=
 =?us-ascii?Q?9treBKvn72MKE/9pCX/OPNbVduB6bEAzYPEbGDNvwDE9B3lDdvom9NQIKwrZ?=
 =?us-ascii?Q?PNzutUgaLabcSWSq6HUSvVMgxQO4K7JD4fG/El1sDv98CA2YUk1G9aaWzWXm?=
 =?us-ascii?Q?saE44Ieqxv6dsznxclmXPfjGwDo8vs09fXoY4PZM7Kvru1qv9PbAikyBmtAf?=
 =?us-ascii?Q?XoHoeiiaUd28f9OD2SeS2REVgW9sSbWKCWmm967GsdXfqZr/BjAPSHgVnBNu?=
 =?us-ascii?Q?1eJ8FxSFFvJHrXz4g+6ntmx+pluRQ3M8oevy641GuTCh+Vc+5NMnTwfXBG6t?=
 =?us-ascii?Q?UX8bR/gk4ZXb8EoKUvaBoMPVyNzo/AJVhiGrRvf7+N/pe/UunAZc3k95AR4y?=
 =?us-ascii?Q?bWFGgOQP8k+fDe+wicXhFfFXwailj4ZAEedhaAQMm523Y92Do1lJIZtukzec?=
 =?us-ascii?Q?sReHGf74TI2FxaUws7dTQjbD2smvwKqo9m9QkEKIBw1juCJ6z5iVtd5oasyu?=
 =?us-ascii?Q?fmG4TVaxbExfodeCm+0/eIfadZOpW1DVrnbrzwFvfZdC+w2Ha3/el8qEtBXE?=
 =?us-ascii?Q?n42rfIjRBdv4tsJ+gt7YqHVR/gem0SeBIM1x03gdMM8bdWWwmtstUr7PaUvu?=
 =?us-ascii?Q?RBJs4aCAIK0Gnwjg0p3PhS+TgNSWVA+RWF3sfMDXknGmBIbze0nUlHjngt+r?=
 =?us-ascii?Q?S2eBWDbbu2aK3KAbOakydv+UCMIfXaEUJAm9IH4M/JIATG3BXUELmpYCMDzP?=
 =?us-ascii?Q?cif/VBw5TECJ8Ww9qzRx8m4yJVdH0jh6k57b/bKjOmHy5VR2Ky1bzKBuQER6?=
 =?us-ascii?Q?OA2xRAvBUtTOMLYLyvylGIuJsrbo9H9kdm3SUACGMR9T08twoRadIArabp5t?=
 =?us-ascii?Q?fl8AvHK396SynN2RxFIbVfjZrlQdvyqOvyLQT4+1QCZUrAGi98N6VkUqBykg?=
 =?us-ascii?Q?rIeOL9Ymjcv2YxwJVlqEOOtj9ZkIzalpDYyvvnoFOPCSYx4gbPeIpmtVah70?=
 =?us-ascii?Q?anFA6aFfsoxAmmfB8sFotzFuA8LFWwgMNvJiUN8hfJMMTZTYJ9dyMQFHjdJX?=
 =?us-ascii?Q?ZSa5CLJq5HeVkt6cjxuoaKZnCaeR2bFbg1On+HMN9R5nJPLQfFzqnBG7fHop?=
 =?us-ascii?Q?fzD8BOv3AkvJqxgguBYsMb0HNlrHzH6G0yhfvHo/hMmwC6vy8feWhOnufgF2?=
 =?us-ascii?Q?3rhmxbQscUot03jH1TVKsDp5ePE9+t0q+BRKws+ZmyusLSXa+6A3be2f0bR7?=
 =?us-ascii?Q?dCnKBFBEA686ss8H0rpsaZttLsp3knDdpqGBR0nZq8s9Io8num4WexCPPsRv?=
 =?us-ascii?Q?rEKDpPuzYZrnYGYJ2CY+iXnOB69eHOUxoU9IFhFuXlyuux6n4tyR9t8UwD1Y?=
 =?us-ascii?Q?tk6rymDu0dc1gkWEBR1Q5MZuyJOuwXa2EwBF2FL7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e713d652-90ea-4cfe-ff01-08dcdf159e27
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 16:58:32.2828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HugaqMSo9ljGLuNoVloOeQNKfJNtd505U645llG44gYrrZtFPkUQpzZ5sxaNRjmkFDAeIV8W3+bqT5hB636N4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9480

On Thu, Sep 26, 2024 at 11:36:52PM +0200, Marek Vasut wrote:
> The static global soc_uid is only ever used as kasprintf() parameter in
> imx8m_soc_probe(). Pass pointer to local u64 variable to .soc_revision()
> callback instead and let the .soc_revision() callback fill in the content.
> Remove the unnecessary static global variable.

Can you simple said:

Remove the unnecessary static global variable 'soc_uid', which only used
in imx8m_soc_probe().

>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Jeff Johnson <quic_jjohnson@quicinc.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: imx@lists.linux.dev
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
> V3: New patch
> ---
>  drivers/soc/imx/soc-imx8m.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
> index 5ea8887828c06..966593320e28d 100644
> --- a/drivers/soc/imx/soc-imx8m.c
> +++ b/drivers/soc/imx/soc-imx8m.c
> @@ -30,11 +30,9 @@
>
>  struct imx8_soc_data {
>  	char *name;
> -	int (*soc_revision)(u32 *socrev);
> +	int (*soc_revision)(u32 *socrev, u64 *socuid);
>  };
>
> -static u64 soc_uid;
> -
>  #ifdef CONFIG_HAVE_ARM_SMCCC
>  static u32 imx8mq_soc_revision_from_atf(void)
>  {
> @@ -51,7 +49,7 @@ static u32 imx8mq_soc_revision_from_atf(void)
>  static inline u32 imx8mq_soc_revision_from_atf(void) { return 0; };
>  #endif
>
> -static int imx8mq_soc_revision(u32 *socrev)
> +static int imx8mq_soc_revision(u32 *socrev, u64 *socuid)
>  {
>  	struct device_node *np;
>  	void __iomem *ocotp_base;
> @@ -89,9 +87,9 @@ static int imx8mq_soc_revision(u32 *socrev)
>  			rev = REV_B1;
>  	}
>
> -	soc_uid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH);
> -	soc_uid <<= 32;
> -	soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW);
> +	*socuid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH);
> +	*socuid <<= 32;
> +	*socuid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW);
>
>  	*socrev = rev;
>
> @@ -109,7 +107,7 @@ static int imx8mq_soc_revision(u32 *socrev)
>  	return ret;
>  }
>
> -static int imx8mm_soc_uid(void)
> +static int imx8mm_soc_uid(u64 *socuid)
>  {
>  	void __iomem *ocotp_base;
>  	struct device_node *np;
> @@ -136,9 +134,9 @@ static int imx8mm_soc_uid(void)
>
>  	clk_prepare_enable(clk);
>
> -	soc_uid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH + offset);
> -	soc_uid <<= 32;
> -	soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW + offset);
> +	*socuid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH + offset);
> +	*socuid <<= 32;
> +	*socuid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW + offset);
>
>  	clk_disable_unprepare(clk);
>  	clk_put(clk);
> @@ -151,7 +149,7 @@ static int imx8mm_soc_uid(void)
>  	return ret;
>  }
>
> -static int imx8mm_soc_revision(u32 *socrev)
> +static int imx8mm_soc_revision(u32 *socrev, u64 *socuid)
>  {
>  	struct device_node *np;
>  	void __iomem *anatop_base;
> @@ -172,7 +170,7 @@ static int imx8mm_soc_revision(u32 *socrev)
>  	iounmap(anatop_base);
>  	of_node_put(np);
>
> -	return imx8mm_soc_uid();
> +	return imx8mm_soc_uid(socuid);
>
>  err_iomap:
>  	of_node_put(np);
> @@ -215,10 +213,11 @@ static __maybe_unused const struct of_device_id imx8_soc_match[] = {
>  static int imx8m_soc_probe(struct platform_device *pdev)
>  {
>  	struct soc_device_attribute *soc_dev_attr;
> -	struct soc_device *soc_dev;
> +	const struct imx8_soc_data *data;
>  	const struct of_device_id *id;
> +	struct soc_device *soc_dev;
>  	u32 soc_rev = 0;
> -	const struct imx8_soc_data *data;
> +	u64 soc_uid = 0;

unnecessary this these orders in this patch.

>  	int ret;
>
>  	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
> @@ -241,7 +240,7 @@ static int imx8m_soc_probe(struct platform_device *pdev)
>  	if (data) {
>  		soc_dev_attr->soc_id = data->name;
>  		if (data->soc_revision) {
> -			ret = data->soc_revision(&soc_rev);
> +			ret = data->soc_revision(&soc_rev, &soc_uid);
>  			if (ret)
>  				goto free_soc;
>  		}
> --
> 2.45.2
>

