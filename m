Return-Path: <linux-kernel+bounces-228694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79532916578
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BDF91C215D6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 10:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DF814A4E9;
	Tue, 25 Jun 2024 10:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MUxHhi4C"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2049.outbound.protection.outlook.com [40.107.103.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49EC132126;
	Tue, 25 Jun 2024 10:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719312298; cv=fail; b=ayZ24Of0fPFtwpSViRkPANPP+DV4EsuhUxC6JBAUEeEP7Fac2oROijO/Jr4BTpqaZqpofUghDXElikcKdUgOKSrP6d8U+bs0lrt7+dtQFe7qJKvFcpGDjrHAjB9B0ZdXPQ7GO2nrIi5weEUA7zx2UthabAOPhYMZyggSyWwxr0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719312298; c=relaxed/simple;
	bh=PISXvJq1bxeu5MhXv6vSYq6NRm1Uv8WT3pJcrFnSIek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RI7eGBxbP+d4NlxQWNk+HYQ/IpmGJLK35YSiUKvb5LxLmlNVX+MdylxDKghplhGGxi0LFAkcWfPjenemWeFoUFm2E5Nq+TyTtxbQVQbnWLz/bKvKcRKUQFtMlcaYvV8T61nUZtAnJS0a2flTX4VP4LiDSebLvjIPcHbrSqDEQVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MUxHhi4C; arc=fail smtp.client-ip=40.107.103.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qy4xMlE+09qlygFI8s4V3SuULo8a4iS5NebAXaKXjZ8uFZZKQ6pUyQh68nYhRsO7BzcUGwyItSLjjGpGjjg/wXW1OKvTU0puKBC5C9TInvpMa0xASy211TUnhG7C4IcjcoXX+Zb6Jvg98AvR4vKCEq3sH0IiTsEpZP4KjfgLhlUF/e8sMJhYDGQ7cY8dqK9rsOv/QChBnTZfLSsk7ZYGvP/UCA3c/NqSMcJWUI0q2iWBD3N4xF6vrd/TFPIQbcmZKtFtRpkFkfYtdb+jTDYXSdPizjfkNJoxcH9wk7RtDsgto+Scv9ZakbC1z/X8b74el0R0MrrTEO1ViI7xvoZjBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUdjBHXNSS+S+2VnCsRcidM2cAQgqmhjIw8egXVuVHk=;
 b=WYRBPtV8VNZ+fTecR3JITmAQqaRJi90bEDNLnikOnDhwancSBiVdgC0EB2d10lNNYM0il4yMIVgAiKK7GqZgU3udFeIZb5sovU5aZ9GQbQ7i6/Wmz6ScIMzeY67QiTpA4/iZq4IUYO+T3Uliq2LqFkrpn7lpV2QAtXXyC3hAF5QI4VTodlGZWOA07amy8CBR8aFurwyedW//9VtyP6Ns5gs/zhcj8K7n6qr57nX29Q/9r1qbEE3Ou5lVt5BUkIxpH3f6+o/CoaeiwP+WaLXf0L7rvyoE1/g2Er6nLf61t+Xalm+G96M/5KuXzoEunZutJTeFFxraymWfSFsgex8Zjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUdjBHXNSS+S+2VnCsRcidM2cAQgqmhjIw8egXVuVHk=;
 b=MUxHhi4CpytZKSF7WuXkFxacWmADYqcYufIc7p/rE8MW/SXa5t1Rp37Mx+snLtwDLBZ7MIFoi0xb9Ur+AgF/VYyI73QZYwKRtt0Mx4od/uGnFNvTrywAB9RRKxbNhC8nU0AAxFus8e6rT0fik1cs+FsN027WAPXITjbpWUGNBpE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by GV1PR04MB10582.eurprd04.prod.outlook.com (2603:10a6:150:211::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Tue, 25 Jun
 2024 10:44:52 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%4]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 10:44:52 +0000
Date: Tue, 25 Jun 2024 18:43:44 +0800
From: Pengfei Li <pengfei.li_1@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: krzk+dt@kernel.org, robh@kernel.org, abelvesa@kernel.org,
	mturquette@baylibre.com, sboyd@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, ping.bai@nxp.com,
	ye.li@nxp.com, peng.fan@nxp.com, aisheng.dong@nxp.com,
	frank.li@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
	linux-clk@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] clk: imx93: Drop macro IMX93_CLK_END
Message-ID: <ZnqfIudepX4sH4oL@pengfei-OptiPlex-Tower-Plus-7010>
References: <20240625175147.94985-1-pengfei.li_1@nxp.com>
 <20240625175147.94985-2-pengfei.li_1@nxp.com>
 <39bcab8b-ed9c-4da9-b1ee-32dbfb2a23a4@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39bcab8b-ed9c-4da9-b1ee-32dbfb2a23a4@kernel.org>
X-ClientProxiedBy: SI2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:196::20) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|GV1PR04MB10582:EE_
X-MS-Office365-Filtering-Correlation-Id: 565a9d0c-935b-4314-208a-08dc9503d80f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|376011|7416011|52116011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WZjFBDrRba8q+IxU4fF+Rl+YXlTHbnLr2fAq24uxGB8HcrVzOxmGUHA0pId3?=
 =?us-ascii?Q?pX9LX86uHFap5vc6ohYhQpQrmSWtfAyXoKIA6wviMGl20VY/ejPbsKbtTYm4?=
 =?us-ascii?Q?bxKFvzHqAKlyiW0Yg/5std88nymGQXdK4Cac7xLuT1hOxtClgtA6TNWcmgp1?=
 =?us-ascii?Q?McGYPJwqSC87sNmrNhSdR4qvmfv7KGlE+mvsXNfr0djM3tr2LVgIQouXc+wt?=
 =?us-ascii?Q?kA61/iKmsVzkwvl20mO52mzi+BFjU8qT4oOvs0LzxCTJf2hGaYqDRJ+5QLD1?=
 =?us-ascii?Q?UteH+FTXQvN7i4GvhEKwBmojU3QSDCblp2pYhhy6zvD6aDOy479zDTETqOJr?=
 =?us-ascii?Q?EJAgV0l8CFXcgIMzY9WPx4qn5LHWrn3Uoi3huvHXUJsDkgdh4dAM6Mbb4qSs?=
 =?us-ascii?Q?EB0TbeHRBgnOJ566KgwxiVN6mMlyDLEPXuIIBJHkL5D600YkibPoNAwBKng7?=
 =?us-ascii?Q?MJQzNMU7cJJAprPWSxS2ASeKpXzunVWk8xROqt+UnSFFCTA7ecw4Q/9JVqQd?=
 =?us-ascii?Q?9g7qMbtEfH51lH6KfeZsPkIdQ4/dou8ywhHrPCNta+06Qx6KXyQ3+B4e0qcT?=
 =?us-ascii?Q?XWXNUJuPy1igJEuC/hsT/Aroxbmp5Nn0ROisB8e0i+UcJo5R+XpbadgMZ3et?=
 =?us-ascii?Q?WeMh8BcZWYikr99NOz+0xvfiutkOZl29cO8aKnR/l6RGUES3YgM1QI11bcpH?=
 =?us-ascii?Q?F6E3WTcp64lbc9Hvu0Pmd52jJKNk+Az1PgbSPKo25eIQnXcmslEvEicZXgYv?=
 =?us-ascii?Q?DGdPQZ75VHKD7XmR6Xv4J+qxKBdbHKxqeiPUeow+yfDTMYEfyauAnSJkxYaJ?=
 =?us-ascii?Q?J872g2Ug3z8/BWrlWg18MVaYzLx9lRcSbrTOWUH2FzfnoZrkRiNcWBW+VSYt?=
 =?us-ascii?Q?xyJKK2rMn/atwZxmMX3hi2QkCy2yVtBlIKH59vKNmAJiqF7XJcLfQ7jK/qcA?=
 =?us-ascii?Q?q1FJHl6fZZ5U0/CMymvsW1x+YtsNZ8sicz76wsRV10L9vxfpEM1Y6pzRbHAX?=
 =?us-ascii?Q?4TWOcc+hKJBncicwiQ0pcKNKJatXuNMBItqLk/TsA8bfBpBmG+hX2rj6u1sh?=
 =?us-ascii?Q?Ki89Eq27M9uq/cWm+d0M8LG+fdzUF/APdtL/ZdagbQnwgfLp6D+KA+IW65Ty?=
 =?us-ascii?Q?UO111fSgY53V2qcusw6YVCFQ1vi1U4pCKzUyVUClZAyrU/pT9jDolmHKG5ta?=
 =?us-ascii?Q?jBAtvExdSk3alCZoyYZYQdIGdqcrD4AaRLKMwXf2cVDW7dcUff1HkFYLqFxD?=
 =?us-ascii?Q?9fA1thE8BlyTVLOXiFK1fpvopjNaSYUq8V7Pb3xWtTlbNQO3ajUnoR7FdUb+?=
 =?us-ascii?Q?cnFtAPcyOZf0U41FT1ohpfH/Dsd1oVytMMeLHyGBz60Y1nuIE8bMVcbToQ9j?=
 =?us-ascii?Q?0zyIC7tEYkVjs12VEUP4MKRVoygw7Tm2WJvCrr/YMxOhTCkArw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(52116011)(1800799021)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?izNeACAzIILk5G7UO2oU2YxJ9NzXDfFQip2KkyrW8fTBlKGgZfWQmZXisUW3?=
 =?us-ascii?Q?l2cqK2yqmJXirha32TjEMb0CQixAf9SJA/msRCl3XK047ARWWRikQcBVP0xg?=
 =?us-ascii?Q?vLcvTIAG84C3An7VTeu/XrptYBgJOZHjURSMlldqLH3li5iBhwwwf29QqpUm?=
 =?us-ascii?Q?fL5/kboHNsQzJ8iYTxpc5FVKF3fBnjvwLEj+y6n7AMxz+Qg/OzE9/69bOD8S?=
 =?us-ascii?Q?n1+2mmGUtHRTdbzYWU2KNUmVMDXz89fhNYP+aPOxQrS9LYU+pUQx2yEpCpYD?=
 =?us-ascii?Q?5qMCyQ60D9H00L7J/h/4bQKJuqT3kWFLmKsYu5rb8/+CmIIAieYMT9iGewCW?=
 =?us-ascii?Q?QaIsrDI7As2xHrwkDEdBwid6BOSAEnmlviGvpcx46AbNnZeN96Tc2ED4aQJV?=
 =?us-ascii?Q?EbfRLMyPIrNP+2uvQqEd+4n/sdT5gVBa9XwR0AqCLZeTH+OHiPYJ8o01BNTt?=
 =?us-ascii?Q?05BnygzLtsmPE3oQkFNEeaPJw6tleQKlRAtf1pgXJPG16kmg7TXn5xb8Q7sZ?=
 =?us-ascii?Q?ObN4yehbxNLN9vTgaD+6iW7tE8NOt0PUDKytIpaDDQ/WfE1LRO4jkHxYM+/7?=
 =?us-ascii?Q?TKKeaA0fAWkDXZgp7OuR2ERwyjCNhs1tv7guFobYfrRN86m4oAMbcw5WYi+O?=
 =?us-ascii?Q?JdSRhU1Szcrh3yLXFtDmY8Oj7wCDDTV9YXR14u4hKVmwD5x6ADmhtu6pHt5A?=
 =?us-ascii?Q?nbOloKooah0utm4C3YBvMPBdszloFs1HRIyf7Ve6nkWyXv0yOrUtaByhBGDo?=
 =?us-ascii?Q?MShyH/bGBaNcnkJPE4Dg6Wa4pacLawffV8epZl6v4udiV1sjmVfQma+2m+pC?=
 =?us-ascii?Q?MUJUxxfwK743xo2Ys64GnhLo2ENZ2KvgqqGH2iXU5Y7ZYbNfmJqZYUMq0khu?=
 =?us-ascii?Q?riXCiUHHccwpD6t986JqjbCgCTef+KwYfqTeMRB6H3ldMPTR0Kf+qH0A+vf7?=
 =?us-ascii?Q?ZLXTtz2kQutvEbSGIAtgWDhoCLrcHt7jHhHsnawePLjg/vMAn9Po2Yng221P?=
 =?us-ascii?Q?pYWRt+diIAPqnG5N2dYGq88uJWwkmhrt46ysHQQy47Tu+zmbKLRgHU5b0jVI?=
 =?us-ascii?Q?snu2rO9sUmvZBsmuv38E4RG01qFSHxSjJwu2sAb7XB4KJGS2YTDxHLk8pIwl?=
 =?us-ascii?Q?6YxvOgRFE8AnbC+6AWvUf/Xf9cp51BCKlyVPONxWV45BiYSd0NNHLHMXfNee?=
 =?us-ascii?Q?Jq1LisNy5D78VEZdb8JnsMsrULckUZsbgHNo6Tv+jiIZMCb/SNjXN980e7ag?=
 =?us-ascii?Q?D/T5wv1tSCUZ/KJD4o0aNuK60CqNBJmO/IyrBfq1zSH0iNjQU7Bgw27P3Yxp?=
 =?us-ascii?Q?y+4iypBStZLkZxtp+kmNtVrr+CTXBWqj72qJ51cWG993YAzpb5+CVeUqU/WK?=
 =?us-ascii?Q?3382S/OJjqCZykzBlSGr4hULXaksLFR94OaczfZg90xuPC3Ph6Gv4MonccZ/?=
 =?us-ascii?Q?ZtqnpUny2XiRAZUqYUfRn6Ka8Xzzp85QJDHoKDBTf/8PCIt76Kff1Mgbj3Fl?=
 =?us-ascii?Q?p9HBzwJnfHZnSs8EO2sYiU9tiwK3d4leENFb5x+9URO24xMtO95A937Z3yGm?=
 =?us-ascii?Q?/aXs+BS1UT9Ob5myUdSemfPpCrAwce9bB0LaLykH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 565a9d0c-935b-4314-208a-08dc9503d80f
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 10:44:52.3494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQMdxlIpKjWlF/esDEPSyDmf2JggL7PHu7vUSYfoPirxTz4ZGyRV5DZENw0smrkZO8vcff61h/bgA2A+g1Z+yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10582

On Tue, Jun 25, 2024 at 09:44:42AM +0200, Krzysztof Kozlowski wrote:
> On 25/06/2024 19:51, Pengfei Li wrote:
> > IMX93_CLK_END was previously defined in imx93-clock.h to
> > indicate the number of clocks, but it is not part of the
> > ABI, so it should be dropped.
> > 
> > Now, the driver gets the number of clks by querying the
> > maximum index in the clk array. Due to the discontinuity
> > in the definition of clk index, with some gaps present,
> > the total count cannot be obtained by summing the array
> > size.
> > 
> > Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> > ---
> >  drivers/clk/imx/clk-imx93.c | 25 +++++++++++++++++++++----
> >  1 file changed, 21 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
> > index c6a9bc8ecc1f..68c929512e16 100644
> > --- a/drivers/clk/imx/clk-imx93.c
> > +++ b/drivers/clk/imx/clk-imx93.c
> > @@ -257,6 +257,20 @@ static const struct imx93_clk_ccgr {
> >  static struct clk_hw_onecell_data *clk_hw_data;
> >  static struct clk_hw **clks;
> >  
> > +static int imx_clks_get_num(void)
> > +{
> > +	u32 val = 0;
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(root_array); i++)
> > +		val = max_t(u32, val, root_array[i].clk);
> > +
> > +	for (i = 0; i < ARRAY_SIZE(ccgr_array); i++)
> > +		val = max_t(u32, val, ccgr_array[i].clk);
> > +
> > +	return val + 1;
> > +}
> > +
> >  static int imx93_clocks_probe(struct platform_device *pdev)
> >  {
> >  	struct device *dev = &pdev->dev;
> > @@ -264,14 +278,17 @@ static int imx93_clocks_probe(struct platform_device *pdev)
> >  	const struct imx93_clk_root *root;
> >  	const struct imx93_clk_ccgr *ccgr;
> >  	void __iomem *base, *anatop_base;
> > +	int clks_num;
> >  	int i, ret;
> >  
> > +	clks_num = imx_clks_get_num();
> > +
> >  	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws,
> > -					  IMX93_CLK_END), GFP_KERNEL);
> > +					  clks_num), GFP_KERNEL);
> >  	if (!clk_hw_data)
> >  		return -ENOMEM;
> >  
> > -	clk_hw_data->num = IMX93_CLK_END;
> > +	clk_hw_data->num = clks_num;
> 
> Why so complicated code instead of pre-processor define or array size?
> 
> Best regards,
> Krzysztof
> 
> 

Hi Krzysztof,

Thanks for the comment, here are some of our thoughts.

Regarding the predefined method, it's easy to forget to update the macro definition when adding some new clocks to
imx93-clock.h in the future.

Also, we cannot use the array size method in this scenario, as some unnecessary clocks have been removed in the past,
resulting in discontinuous definitions of clock indexes. This means that the maximum clock index can be larger than
the allocated clk_hw array size. At this point, using the maximum index to access the clk_hw array will result in an
out of bounds error.

BR,
Pengfei Li


