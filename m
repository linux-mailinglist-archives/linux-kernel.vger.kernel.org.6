Return-Path: <linux-kernel+bounces-257012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B879373ED
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B6C42860A2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 06:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482784084D;
	Fri, 19 Jul 2024 06:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AyT5D7wn"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012045.outbound.protection.outlook.com [52.101.66.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140621C32;
	Fri, 19 Jul 2024 06:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721369371; cv=fail; b=bBoyouV+4JcekpCpVCfXynMauF493MAq3fC7Qp1MFdX+I5JO35Y80+bQkQgxzqsTIdjLlb9SgspkHNZSWnpILVXfAYl8g6UXtectGtjI+1z+NFhLiv9Ok+MkeYOC531nPTFrc8uplpHhKK3DYpxfXzVf3VxauM4LU1WectLKMUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721369371; c=relaxed/simple;
	bh=TQI4//6FbGcAsbWns4Gjn2DFKLQKwYxMTOyBMbC50Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eI7L/Z2hjn94pi+VysOT6D/oqrAEJB/4xtUP/6OxXH1Vyu43N9v3pcE7+f5XILAj7jihwZXTO1FZeiSuLD16J7bGEOr/njABeIprtpznFbbfsOiQIBcapnsDGEGHcGV73Hdb9xgOWHHqmA379D9yvarfMjB19C1si8I257aJgJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=AyT5D7wn; arc=fail smtp.client-ip=52.101.66.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fncaG1uJMUvrDD4iEPOioKYv+02W+qGVCEEuyDIifLDZKizWx7zm6bnicG4oGGlJJ0KL7teMjmJdKELWrv8Cz3Jx0XJpwMcyblUrwfvMp/RgzO2ZtOLhGSuvM+nzRpEDAmVoMLnlhRpwiIMC975EbDuUcnURGBx87TcCqhYt2ad6i232/pZqwTYXAc6dkXt9CzPwgadoql+3KKwLMQKRg4YH7ykrfrRCcxzdF77ho98k2KB3+9OCAiDwsJJrFs0Bnu8OZQbIgQ5Z3cMpIAfxiG8XK7DgoNuFzQpwC4nqv/2RfRE4YKSG7PV/xl7xdtpZrAuWHaK8834KlpMPzQY14Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tj6UU2I4imSQ6qMq5/5vZm+P7RwlJ+I+jIC2BEfYi7E=;
 b=Foi3MFj+OYyNu1Qb2MM51LYh+S+QEkRqZkzn806LgCUAu2hvZGw5m6FReJD8b2uG3kgX5oDA7JUbY8ZlRQNUrd7RcrCwDidi0yziLxnvLOuJSrm51K52cimWbVLNbykXGS6Vg1uBxQ9PPa89E0Wa3HogPw2cRmg+7ECbITmSOdx3N9h2IpOuKvCwCsv2MjgM666E/2THTob4j0xsE8n4caiCGYea8mOot2SYn6rAtwXWRb0hCSZphucn8WD8KBccITZ8/WxmjD1Gc1WHzFqE9dlHNO0zAshnOpOZ4GPZ+sK1AgLXRuxixAHaRMmawjIBKNBUoUwY1dZL7OSRD+2Vbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tj6UU2I4imSQ6qMq5/5vZm+P7RwlJ+I+jIC2BEfYi7E=;
 b=AyT5D7wnTsI8l6S7uaPvB17+7j8zaQUMcu9fK1hiXXiaVjOCIa2dbtmbKpfEaPITeiAEHQddMQhNG/wfsA4ytw+ui6qhJpbkvZJ9pvRJrUiAXXBgK+mQmVcwuEgLdSr+kox3AQcB95WiS/Mnfb5hHwx7xSa9QzvfMwmUVhe6H5M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by PA1PR04MB10170.eurprd04.prod.outlook.com (2603:10a6:102:463::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Fri, 19 Jul
 2024 06:09:25 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%5]) with mapi id 15.20.7784.017; Fri, 19 Jul 2024
 06:09:25 +0000
Date: Fri, 19 Jul 2024 14:08:06 +0800
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
Subject: Re: [PATCH v2 1/2] clk: imx93: Move IMX93_CLK_END macro to clk driver
Message-ID: <ZpoCxmvgKNgvx4Kw@pengfei-OptiPlex-Tower-Plus-7010>
References: <20240627082426.394937-1-pengfei.li_1@nxp.com>
 <20240627082426.394937-2-pengfei.li_1@nxp.com>
 <60f9e733-f5bd-4bfc-9bd5-94ae18bb3901@kernel.org>
 <Zn92TX9ZsHde7g2f@pengfei-OptiPlex-Tower-Plus-7010>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn92TX9ZsHde7g2f@pengfei-OptiPlex-Tower-Plus-7010>
X-ClientProxiedBy: AS4P189CA0043.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::19) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|PA1PR04MB10170:EE_
X-MS-Office365-Filtering-Correlation-Id: 79559ded-e615-4b84-b4c2-08dca7b95716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t89OcK1e9hpwwe2dpFCziHCLqJ2j30ZIaAUfWO69IVzitayHLBucUc47+vod?=
 =?us-ascii?Q?DUzELFiyKPnPabKxghoEneMW3+21u+LJUgD2b2WHWMijAMuBxwIx4Br7JyVi?=
 =?us-ascii?Q?qVvj+2kfHqpNGPhgGFK31qqB5LLoMYc8QtM5S9qvSz2Tlq4nUucY0iXuRtbS?=
 =?us-ascii?Q?1fRO3ErAQc4RMw3+xjywrW1cQPkn0AZbolBxfjKR31EK2ix+bLIL2vXK+QEH?=
 =?us-ascii?Q?33VqJj91dFUeVjwuk7a8+gOSS8hOPDtkGyVaXUVECgTxuYwieXkgyY9gcOU9?=
 =?us-ascii?Q?5wdmQH4zcxyMYU5w9q89drTrnFKkOel3I46kLnDwUGCwmOesh8epvt/NK5eZ?=
 =?us-ascii?Q?NlLjb9q7ZuoADKUJTcZex8Zn00CD0/sUsNUSadktu+XrqaA/tkQ2NQprKpDw?=
 =?us-ascii?Q?PwokBjhzurXCTNOkw0Pgk2IHdu70xNvLd4dYU6Xk1f1SGcDilZVN8bL2PlpZ?=
 =?us-ascii?Q?M7ExBhxtMGF8XlgIR8BplMULfDscL4Px/U7H7rnLP71a+/WODYvM2lrTqY92?=
 =?us-ascii?Q?7sman9cEHMkFhU4UA9YOdedgLdo2f+Z9vPvhBEz0dM49VfgyPz710m4lEsBO?=
 =?us-ascii?Q?+SNMzl1YXDi/JBREuAtxbuFSaPMFWGXy40OguaJ5EQqcFL1/3zCmfOJvWdv3?=
 =?us-ascii?Q?ad+7frz1v/O3QELzYkNfnybAqMpVjCZBB92/0T9VSXGOZtZNTMuxwLcFxQ0m?=
 =?us-ascii?Q?Gx1opNbeQoQMO+SZphnISxhnc08OTsVU2aJAgC8tHTv61GLPWAtSkU977zL8?=
 =?us-ascii?Q?MUrIET4z6hqVsp/yAfEpZXCAGsq82eU4NVnM1llo/sw2kPij8HhRfOjpQBB6?=
 =?us-ascii?Q?pjy4GgDlGK/K1lIW5A0eeewtohzxWjUci0eG0a/hCLP9xQWeVuXir9b9Zl4L?=
 =?us-ascii?Q?jnxK0USo/f5TdjMDV/Z2tMEntFFZRQ7U652mIZTimpCshyxDr3H5bDpwXV31?=
 =?us-ascii?Q?eDFjgW9anDsgxxfPqBa9z1zaOOyqDebACQsfL46aUEomU7kU6IB5sseS9aHP?=
 =?us-ascii?Q?4h44MP/edv3bRioqvLuS0H6uZTOM8xoRr6Fe1lllP96lOki897RXx/WNBXHG?=
 =?us-ascii?Q?GKW7agrS7JAvycCHEtonHiZV6bbRPxod4HEbMaQiVBTLxs5EyCTkpQDsOL/E?=
 =?us-ascii?Q?VMhmMEP/d/zcnYsZrllL0y+wl0Bt5bftk14WF+RAB1SraOLjnUQiU6vjlUtu?=
 =?us-ascii?Q?9rUn0g0BSezgcOdIVNahhy7Ye4jZR5SCSPHjV+H4y14v9kjS03m+2NQQkqEU?=
 =?us-ascii?Q?lFmgTaWqaRmoVdzPW8er7crjnQR7BrdLdBM8jCPNSOsaTUuD4hE8s6DJ/UA9?=
 =?us-ascii?Q?6ltFpg6bC+zK8zZ/YhES7aNVn39TDKD1b1Qo4lLIxw4ki/6B4fIGKd3gdyPs?=
 =?us-ascii?Q?eWHLxR9FPWWuHM9KoHcTE/YKMLg/YwROJLBY3Fr365JYxR3MjQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wUDPeaDHGloTuls1A6JWLL/0rLNSyVVDcnb3PYjv4tA7k52CcmiLGZeNvuV/?=
 =?us-ascii?Q?jbfhJ6vrHMJGJ2AIs81Dux4OuJSUSwpU8LH2Tcghvm0wgP7za42y6WFbO9f3?=
 =?us-ascii?Q?v0q8qAFwCx4s3Ovh07djX2dzmtMG+Net8njnXgMLqnmtpOShwWywIvspQkhk?=
 =?us-ascii?Q?4ZxP/ccga2AuKvOb01a1oK6S/BFGLBkmcIkvvV9NDXTQPkrzKBWvWD52zzwR?=
 =?us-ascii?Q?gS7zGTChQZOZ+o/fgtZx4mQSTNKkxqoraqx/XQ2ufZANgFpfIsd/P2h6v7oG?=
 =?us-ascii?Q?fja8emF+BgvcFDcaR3X514cUmac/uz6DIRK5QfweqtrfsbsbvM067HBF6wQx?=
 =?us-ascii?Q?vUOzbSL4o/jg9eZD3QwIYKCdNI4/o6unuTaTtudLVAbYFajmpTf+dwDtAb2R?=
 =?us-ascii?Q?fmzflYcLQXEGh79SVcWekmsB7Qi9fMqghtYopALvvIecKZCjUHT6geuVUhYe?=
 =?us-ascii?Q?lf3XP9FUzAIsKVmhZe9Fn8v5wJLBh58OlQl7kh1CWGs12yE6s8rbGSNzinvS?=
 =?us-ascii?Q?2KBNAjeTgmFNvro0ud8sLDX/OXDwX4QNkvc1xmb7oUVQdJpfcO3n1qMSEKJJ?=
 =?us-ascii?Q?kUYc0U1iTKR2TfBypNb9BRW9r34K7yKviN//0GkRvnzrvcx4yG0eG2B3NR0Z?=
 =?us-ascii?Q?TO0UWWVCA4T4DbJBxWpqGiCkklZKYEw/2jfL8RLBq2hAbQcovghBj5Z4r5wF?=
 =?us-ascii?Q?vGZLOdCjgNyOd624A8HO+MNI4TDPi7LcE1IckZMHUCzfz91UBNM0dTwfgjlp?=
 =?us-ascii?Q?yaa2UgeQar19Bu0+cCJXNoOuuyN2324Xy2zCw6b7szH9Yge7vJ63mgn9n+9l?=
 =?us-ascii?Q?UhQ3Gs2kPsO68xLf78B8XQMg+3wHv88thyU3Qv2q8GrgavhpmGw2BhkrLz9Z?=
 =?us-ascii?Q?KIoIArJbC1se4kFH8ZSSqYpfbFFfWy32vcRML73KIeAvmoTIetUB0kYrPCl4?=
 =?us-ascii?Q?kC/mOmSH13zaNaTlUno812OY5Du0PDA/4LE11kXAkY5tDNzTwYG2cKQd9G8s?=
 =?us-ascii?Q?hU+nB7ZBD1koBRD6sI7zyHorkAIvYSWzSQiWufrxxjL19yPtSDi/F8IvwLFw?=
 =?us-ascii?Q?h0/Ziaso7gbabg48yUqYlSHg7LJhKSz2PBjh2AgXWUHSdJI8UQBk8iI7IEYb?=
 =?us-ascii?Q?usM/dwixXc/r4YSha20GXkUnnPn0YefAWLpm3S1x6zKoyMVtZ9LbVnIDiAMl?=
 =?us-ascii?Q?07rBCzTwWlwDF4XjCsvEks44GstetpTi4Ih6nefu1mI5Ol5rfUwAozZvZG+5?=
 =?us-ascii?Q?cBwVw9eACcRsuVA+QHw1yaGynmUCZ+Tyv4kx/m4jvF1BvkmtkpSFTw8J5cbD?=
 =?us-ascii?Q?ioXObLdohhPcE5KcVD+IyUoXPc5W/XlUK4I5sEUqxXmcdcWTXxoDJNkcszXe?=
 =?us-ascii?Q?dWYxbG4/6uA6tBaJOvTXLMxUpjDJOxwe7So31dfJGsDRrypIy5duWolj69tc?=
 =?us-ascii?Q?Fg2Cul/WwnOCx6NRaK9CPT42FtfGG2ch02Assw67n9eTrQ/qJmu6dc3X19sz?=
 =?us-ascii?Q?MxpQQXdrUV7s1rKmxtUzxf5o94PZYG/tGDky/ipISQfpSRcAvjRUBfTHAkz9?=
 =?us-ascii?Q?YtBloIse4KdVvm+3XsiF2Z/M8AoW/2JzXNIXrIzg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79559ded-e615-4b84-b4c2-08dca7b95716
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 06:09:25.3082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H6Lr2O/FkIW5Pq7vPC6StZ/RUPNhPOHnaF3X5gfXwhOCmoCu0mqEuWNEDDOSanSjVf4TdwYPotQjWHat5G9Vlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10170

On Sat, Jun 29, 2024 at 10:49:49AM +0800, Pengfei Li wrote:
> On Fri, Jun 28, 2024 at 09:38:54AM +0200, Krzysztof Kozlowski wrote:
> > On 27/06/2024 10:24, Pengfei Li wrote:
> > > IMX93_CLK_END was previously defined in imx93-clock.h to indicate
> > > the number of clocks, but it is not part of the ABI, so it should
> > > be moved to clk driver.
> > > 
> > > Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> > > ---
> > > 
> > > Notes:
> > >     Change for v2:
> > >     - Use pre-processor define to simplify code.
> > > 
> > >  drivers/clk/imx/clk-imx93.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > 
> > Are you sure this builds fine? If you need to define it here, it means
> > some part of that unit file already uses the define. If so, you include
> > the header. If you include the header, you should see fat warning.
> > 
> > Really, people, just build your patches...
> > 
> > Best regards,
> > Krzysztof
> > 
> > 
> 
> Hi Krzysztof,
> 
> Yes, you're right, this macro definition has indeed been used. But
> this clk-imx93.c driver file is the only place where this macro is
> used. So maybe it would be more appropriate to define this macro in
> C rather than in the header file. Meanwhile, I also built my patch,
> but no warnings were found.
> 
> BR,
> Pengfei Li
> 

Hi Krzysztof,

I've built my patches, but no warnings were found. This C file is the only place where this macro definition is used, so why would I see fat warning?

BR,
Pengfei

