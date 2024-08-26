Return-Path: <linux-kernel+bounces-301796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE56B95F5B0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D9F51F22E43
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 15:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C78619342E;
	Mon, 26 Aug 2024 15:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Yag04vIc"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682301940BC
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724687833; cv=fail; b=DXplXVf86mivLB1hlisi5ihRoUMaVecFaJOmXU39mylrVo7iRlww8K8ZezfpeCCtkjCJhOr8XoeJKzqG/bYEEylMlsoGhHGeB/FFryB4EZ6JR/k7VFLInSp5oiv7tsZcdwDK5o6PeX6rhStxLvGJShtBmEjvafzsFMsgcOPKokc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724687833; c=relaxed/simple;
	bh=tZjVhEWTXYXJduxXsYqVPTLZzLPKKGmwGPn/ERiDdHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I3q1rt2kGNifPIqAU3D3O8MgBm5yBO9polanoaX1iSzvO3Chzg1GVi19+FEwlSegftd2+VrpBGVBbWHqTgmXruPxbr1zFB67//Ji+Cbda5n0yT9MX1wgRy4xKenbFUdGo6vOYMS824RxGq3grzQvjYMF7xEk4zQUMf/njIxIOOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Yag04vIc reason="signature verification failed"; arc=fail smtp.client-ip=40.107.21.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aP8ocDmHI40gJMu4V7JGt5KNxQ1q7076EShuzQV9RmEwoq38SgHBZcjevUdSQowCaVnAQrIfWbIrTguxHqqIrLMlxQ3kL2urRhxKwJwZKG/ez0ff4KPZaTL5qwDwYocA+WMJ97+KHuwt8S9OGKZPjK4YI3g8qBQqL5TFCiOQCLmD5cyNO41J9ndr5JklFBUjSHrFebSCBW8gtQuRO+7s2q7s3kxjxpOnl3ehHoDF+jfZg/25kn5PR5eAO2I65NDGQQzGN9idOKFiFHUyDbfIfvd8BtDl/dMmK6IquZFO9hp4JYBzMVhiVAWttAe9vKRyhkcLlqogNkoTMJ3foh1dbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKp1TofDTHdFFNF8llcFGmKtNUrVB3lcWnWY66Kj0mI=;
 b=tMk7NPTlsphmYCv/dWX5ybVDLWSNaYgG4DrIANoi2mEEL37hiZ8tNCWgCQHsRo4UrnZEnxdzMULgKXcDhnWBQ22VrLxAgaUxSapVNSiyKqi0pNrQ1FpFyOTnUEt2BFzPaaCi4n63c7B1W1lx8+JDP7O/KJuqWNbCSswWsz58BVp5pZNqzBmhQP8AZ0MTYcVMnEVU3451MJNupMpTd54H56Jx4pf+2YBZ1RIIh20UIicnzqETXPHxuoDDyQfuxWm8knd2Cp4b4LwNS5OXjCSxaj4IAzG+4zrkKamgsA/eYn5iGHjaNgyu0R8fz9gH66YAQ0obnyL2gU0+mFEJJSsftA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKp1TofDTHdFFNF8llcFGmKtNUrVB3lcWnWY66Kj0mI=;
 b=Yag04vIcwjJiWH37qc57uPGV+Oqe7JpeQQZUqIg/b71asvY/LU8KCtnA2sQ9WAwBg6c8LJf3YtLaBoMXK3i8t0io1zW7DBXZPNWz1+AcgqseSOI9viNFlb+coAlFzraRSdAwZz9zDULmULm0eVIdxh7rVDJpHOYJ2enve/V0HKP+tKLdTD0bWdEV8DrDZNFPmEmyxxkAIqncMplvGRf1QpsHiF6z2iBB/twAjIay+xg4uVaSrQd+g+EWdfN6U93Fk5wVaXg6vRwBt5/xO5T8kU9CIamNR/eJdCnD1GsV7aD0N3T7FTPIoDzjngqheDw2DwD+EGPFFSk36N5CZX3eIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8690.eurprd04.prod.outlook.com (2603:10a6:20b:429::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 15:57:07 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7875.019; Mon, 26 Aug 2024
 15:57:07 +0000
Date: Mon, 26 Aug 2024 11:56:57 -0400
From: Frank Li <Frank.li@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Parshuram Thombare <pthombar@cadence.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Conor Culhane <conor.culhane@silvaco.com>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v3 03/11] i3c: master: Extend address status bit to 4 and
 add I3C_ADDR_SLOT_EXT_INIT
Message-ID: <Zsylya9TN4mVFL79@lizhi-Precision-Tower-5810>
References: <20240819-i3c_fix-v3-0-7d69f7b0a05e@nxp.com>
 <20240819-i3c_fix-v3-3-7d69f7b0a05e@nxp.com>
 <20240823180426.056ac093@xps-13>
 <ZsjNA9JV0UKONV32@lizhi-Precision-Tower-5810>
 <20240826100430.33194702@xps-13>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240826100430.33194702@xps-13>
X-ClientProxiedBy: SJ0PR13CA0220.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8690:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cef0c46-de5f-4170-bd6b-08dcc5e7bc79
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?iso-8859-1?Q?05w9wK3h0c7eSnW6tirZYtmxtrhim9ro4ynTD1iMfaPm5wznxa3ZuN2dtz?=
 =?iso-8859-1?Q?8VVHOja8czS1mHvWPbIhjpNfdBIaI/1hXn5xDTdJDkesOW8aVZRgPr2Xa+?=
 =?iso-8859-1?Q?X2H7XJkv0k2MVrYYX6fpHikuK8UpSOfeHIG6Q2+RfC6mtfPAkgnnth8aQG?=
 =?iso-8859-1?Q?vLp5ZbjxrH7MzQyvpyDGxjDsLjXsupGSrOMAgTu3NI+kKAYEVIWyudlZ39?=
 =?iso-8859-1?Q?253CDMlfTFfvd5ZEI9r4c73IcutQNwq02dHJlmVGd6QD0z+PABWWTouQzN?=
 =?iso-8859-1?Q?9sf3fQ+qtl0IAWIBhiC5RHqozYiVJEys1G6MwZKRs/dDgby4lDPUZW5RDe?=
 =?iso-8859-1?Q?JItj1WO3wyf4IVbSm+EbjVeX9rvKaWig5Z+JK5f14C1s1MJr6qon0tUxee?=
 =?iso-8859-1?Q?e6zJzJNkv1N686Xd7qXadacydFR63hHZCzHX0gdKEoAhnZ+KhqAn92o04v?=
 =?iso-8859-1?Q?bk3VSm1xQp5xpkP1Hb7YLpb++RR4EOGKrnegdBrp3cez56pQLJ8I/NmS/l?=
 =?iso-8859-1?Q?SkmIWFxaPmZoLdCTScedpn+Q+Jaj/5a10YMjFpla6fPPmIj2y/mkBqSiXe?=
 =?iso-8859-1?Q?sPRyEeTuId9yMJ/Joh3sR4Gkgq6r5084VfdQwPeD39QRrpKVJIozrm+dfs?=
 =?iso-8859-1?Q?4xiLVGR5Y8MWQ+fM3PpzAboyuWuzTkTJqAo/r6w0fFOUz+uy+F7722u63l?=
 =?iso-8859-1?Q?lzy6m6Hdu1TRzHECdxqT7t5FAQaLvSE7gFm0ypdZtUSpQ4XjFR2LXVPhjV?=
 =?iso-8859-1?Q?ESJpZHbJ1xbCK/0aVFl3KeARPBcQyGl74iGtnrOPqQFFun3Ajb8pWfkriP?=
 =?iso-8859-1?Q?Ncy3KxX1JpEqIzLln1bVK4wjARSQPWf1jfW6tc3tbiJvPgHJVJpg4xCnhd?=
 =?iso-8859-1?Q?k+/gEGOwEJ/iLVULjr6AYYLUp76m/10pWyT+xGfuopq4Nybgf610C0hIBq?=
 =?iso-8859-1?Q?YGBO4jDEaApC7qlMNTkDUbCEzOUW3mZ8QoijKrzOBd0Kl0QsTRrdoNvlxB?=
 =?iso-8859-1?Q?7R0UP3yxIU+8ijlg5Oo6B+u45iqGE29tV/BEQyFflEj9dhoKBcGt1AGvcG?=
 =?iso-8859-1?Q?SSgr5EKND6qfIU/Z7UDnRUK1pP5FhQf6GBdsHe8gGrOmVBKfJpmn7IPVPZ?=
 =?iso-8859-1?Q?m6KJgmW+dlGd2H9L3JXk9To+vW3mj4rIf8Le/23uF9/NpIPVJwwXamOpzV?=
 =?iso-8859-1?Q?ECWb0dZpjcHynl6XLK3fnd5atopj/O3DM4ue+PPkp0/bymDtDqIbnuYV2w?=
 =?iso-8859-1?Q?Uce0qWrVBLqyPU7zfifZFVJ6RZEn4sEveWnYBIFecYWPMKTemRF7i8ENf3?=
 =?iso-8859-1?Q?8OIIzzgdopUlLXD3kFjXe0I5CM4/nKcEuzfmGTsYFkgfTz5CM/8pQoRllL?=
 =?iso-8859-1?Q?bBO4Fecprq5Gbv/QI+Nz4vE/JnaFw18aB9bgy4V+qAu2nB8BS+ecqyelF/?=
 =?iso-8859-1?Q?YIUajCqscILdPRDnay/KOOfiaXqHKed+vELZTw=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?iso-8859-1?Q?qx5xfv8BNhRaBy/OF53kdVpclSbxhjP7JK/sV2wWbAWaGoQE3rOLPlN8D6?=
 =?iso-8859-1?Q?vF/fDhuClVp8qHJ7hVHQAiE+3vH4QgKURlAinWGimg/fbdBEA2lMKm5GCE?=
 =?iso-8859-1?Q?BwJtR21imLp50gYytND9ecSDL6iei4G2DSs03P0cPWyXzjUIQfLgMUJo3+?=
 =?iso-8859-1?Q?g4qE7nGtuRkmxez4hbVdJe48T8oZFZEXSHVGBiyL9VhwvrHeKWBoVjgwlI?=
 =?iso-8859-1?Q?uEZOo1Ku2eMsXkLP/iaQM/JB9Klce1lpokTXx2vFfg0pz8yFieQQku4Jvg?=
 =?iso-8859-1?Q?myNTU9xtu+AlaNZoei2yHyaIEsEz8wC9kpNPsvHxxl6ZHStd9QK87mt3DS?=
 =?iso-8859-1?Q?hJJlK5lW+Xy+hDN4MUVlBD3iUPc40rjdFlCwC4hqZRpu/8f2b7hwocgNBn?=
 =?iso-8859-1?Q?xsLMGHAOn1XwU5/jceVzglX4wL/A1VcpkcbjXhoG2RrsEUSrm79Lwh/omO?=
 =?iso-8859-1?Q?b4d2yi4KDiL0gVs2oz8D4sZN5Wd9HGUwimcrPhh5IuNh7FV9X/TCFbbwiO?=
 =?iso-8859-1?Q?4/t3Wf/axqdERkFYb3USJMLKdLFoYsT9fYFMwDUR3oXa8wuubL9hamOmSp?=
 =?iso-8859-1?Q?ILzT57xcE6NIOGOZtwPqzQQ/2tLplShKiGQH4goJCk1YAJcJfN2uPpwct0?=
 =?iso-8859-1?Q?9NUXzPlRUDj4IcITEslmKCPVi4Ppiw3DEzIxscLrCBeLkJm6FKsPnvXIbg?=
 =?iso-8859-1?Q?R3hDjJGZjR4yh9sfQf9Y1Fvo56RSwWPZWYZbq9fvbzbzbmSEn0P4SArfNh?=
 =?iso-8859-1?Q?F2Cn9ydODCts2/OuPwZOIP/5vk9oqa6fkTc8Z4FXkN9oER12n3rbLM/XOj?=
 =?iso-8859-1?Q?ifXCIeu8qxT3juOfewX2oT8VUerlQMSK1R8PspnjDphr5IEwdsAuq22s8v?=
 =?iso-8859-1?Q?lTXgzWpNtwZsRsIehUwRqsRIS3JCto/F4DMHTslvM/SVz/zALH4WNF4pNr?=
 =?iso-8859-1?Q?SlZnXyPE1xVcp7NfP6CvzK8kZ2OMWOU5PuJ0j23xWnH3kvy6C66lKlkjc7?=
 =?iso-8859-1?Q?u1SVVptqFLNjLnsie5cyCN1ydi1+Gr4U5mUsaZZSACP3w7cLPJNTpOmbyJ?=
 =?iso-8859-1?Q?2cGKdVqJfVeK3cIXwDOmh4j3PeTeways2Baes6JJVVuSG+ssCzRj5XVOzO?=
 =?iso-8859-1?Q?oGKSf4Gk7/GfwIPoCB/EPUgHOgSI5XrG3ktM4AS0MandOReWDbfqxtcBA3?=
 =?iso-8859-1?Q?57apYkKhZoIT4bg7bNDEp03ftNUrgGJ8J93JUXU/4mImKmGlKuiTdxEQKM?=
 =?iso-8859-1?Q?h9jsagx8CErvdFfulVA0K5Muw/1LTIuyYN4o07ryaGVaRyI6XmOMSxR7XV?=
 =?iso-8859-1?Q?ly9UfvRk2cSSR/wqHJc0lodA/+EXdDdu1kX/AS30cLE2zI/BBULfqSPV8M?=
 =?iso-8859-1?Q?/4NfDjiFV5rqr86b62ma5sio9oCIEfTV8TCpmhbyjwSJizS7Npu8hDKEzV?=
 =?iso-8859-1?Q?uy3TqEf4uKr227Fwf6wgqTwwu0NPbkqi5ZW/lsebo+0UF7497W37mqYILA?=
 =?iso-8859-1?Q?oSZX5tXFUfnD7UbGKi6/cXUS96DZVsp3j7e2X3FWTIi5B8P49FIClfC/La?=
 =?iso-8859-1?Q?sYXO4oydJhrpIdFaDUvsKrBpmugk6a7/nEGWlnnBnbeXv0R29BJE8UQyxi?=
 =?iso-8859-1?Q?/pokDMwul+Lyeh35ds0W7SRfZqhz2hZ2XW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cef0c46-de5f-4170-bd6b-08dcc5e7bc79
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 15:57:07.1585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Iyt9HyzqUYnTUEk7cM7xPs2RRcLy2Lr50sR9LSiaOb4KYvKuzq5cP/njX27hSFr3rb7G0+wcrxOTzt6WEud6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8690

On Mon, Aug 26, 2024 at 10:04:30AM +0200, Miquel Raynal wrote:
> Hi Frank,
>
> Frank.li@nxp.com wrote on Fri, 23 Aug 2024 13:55:15 -0400:
>
> > On Fri, Aug 23, 2024 at 06:04:26PM +0200, Miquel Raynal wrote:
> > > Hi Frank,
> > >
> > >
> > > >  static bool i3c_bus_dev_addr_is_avail(struct i3c_bus *bus, u8 addr)
> > > >  {
> > > >  	enum i3c_addr_slot_status status;
> > > > @@ -388,6 +405,14 @@ static int i3c_bus_get_free_addr(struct i3c_bus *bus, u8 start_addr)
> > > >  	enum i3c_addr_slot_status status;
> > > >  	u8 addr;
> > > >
> > > > +	/* try find an address, which have not pre-allocated by assigned-address */
> > >
> > > 	Try	to find			has   been
> > >
> > > pre-allocated?
> > >
> > > > +	for (addr = start_addr; addr < I3C_MAX_ADDR; addr++) {
> > > > +		status = i3c_bus_get_addr_slot_status_ext(bus, addr);
> > > > +		if (status == I3C_ADDR_SLOT_FREE)
> > > > +			return addr;
> > > > +	}
> > > > +
> > > > +	/* use pre-allocoated by assigned-address because such device was removed at bus*/
> > >
> > > 	  Use      allocated
> > >
> > > pre-allocated or assigned?
> > >
> > > I guess the logic should be:
> > > - try the assigned-address
> > > - look for a free slot
> > > - look for an already in use slot that must concern a disconnected
> > >   device
> > >
> > > But the comments are not precise enough IMHO. Can you rephrase them?
> >
> > How about:
> >
> > Follow the steps below to obtain the I3C dynamic address:
> >
> > 1. Retrieve the assigned-address from the device tree (DT).
>
> I guess here you mean that you try to pick that address, unless if
> already in use on the bus, right?
>

Sorry, It should be typo. See below


> > 2. Look for an available slot address.
>
> "available address slot"?
>
> > 3. Look for an address that is pre-reserved by another device with
> > assigned-address in DT, but where the device is currently offline.
>
> I don't think this part is precise enough. You don't look for addresses
> "pre-reserved" but rather more for busy address slots, which might no
> longer be in-use because the device is currently offline. The fact that
> the slot might have been pre-reserved in the DT is a detail that may,
> in some cases, not be true. And as far as I understand your changes,
> you're not checking the DT addresses but rather more the addresses that
> have been allocated live (which is anyway better, because i3c might
> very well be used on a !OF platform).
>
> Once we settle on a description, maybe this can be part of the kdoc for
> the main function searching for the best dynamic address?

I am not sure I understand what's your means here. The current framework
is

1. Get a free address first, the get more infromation from devices, like
BCR, DCR ...
2. Check if it is old device, or dt node have assigned-address property.
3. if it is old device, switch to use old address (if old address is free)
according to i3c spec. If dt pre-reserved address is free, switch to use
dt pre-reserved address.

To match 3's requirement as much as possible, when 1 return address, which
should avoid return dt's assigned-address.


/*
 * I3C Framework Address Assignment Flow:
 * 1 Initial Address Assignment: Attempt to obtain a free address first,
then gather additional information such as PID, BCR, and DRCR
 * 2 Address switch:
       - 2a: Check if this target device is appeared before. Switch
to use prevous address of this device.
 *     - 2b: Check if this target device have assigned-address property in dt,
switch to this address if it is free.
 *
In step 1, i3c_bus_get_free_addr() is called. To optimize for step 2b, this
function should return an address that is not pre-reserved by any target
device with an assigned address in the device tree (DT). If no such address
is available, it can return an address that was pre-reserved by a target
device that is currently offline.

 */

>
> Thanks,
> Miquèl

