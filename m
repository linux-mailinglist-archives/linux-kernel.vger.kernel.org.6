Return-Path: <linux-kernel+bounces-404244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD30E9C415F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 16:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29E79B20A4D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF9774068;
	Mon, 11 Nov 2024 15:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="inK+V407"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2051.outbound.protection.outlook.com [40.107.103.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981C71B95B;
	Mon, 11 Nov 2024 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731337271; cv=fail; b=Snxtixu9ie+YnJrG7Vr1RuJWtRxLsq+UUUH/mFt3xVwN+WQ9OFjRFvHLFys2Kfcbr7TPQ8o3S7G/lgMvDHJ8D/H6UK1lgCKxZ6XMULSu5l4/TRToIvIpxZmhcqEf+4f99rYNK+bd06sj93n++uLVOTKw8ZwxSho+eqyg8cfn3x4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731337271; c=relaxed/simple;
	bh=hHxGeSL7KxeFBG/OESfoGf+GrFpvMWUjC+imTOUrLRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=byvUFXTKzhDUwoprOaJkB2uLPnFUYhR2FNozyhIqOWeOj4VPQ8Y/JyCndEnMfHf5DzlZklPb6CXggjdoHAEhty3D0FXpcEJL/Q3TP3GVhvaDTINk1Ie+ktZEloWFow/gNXBoS9qsBam8rt1gu+RwYhpO+2++dKcg2ioHAq/g47c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=inK+V407 reason="signature verification failed"; arc=fail smtp.client-ip=40.107.103.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+Nw7CrOXZ1aMaHf//YN6w0eHZraGqKRsU0UhpHt9gJm5QKqyb93ez1ltl0hkxCXKEgXAxLlLSn4eooQmYMPaNNJJRW58xL0VmW7pXuZ1qTip9NAKHD+G5YVRH30PHQxKBVT5bOjNPDmzZLXVONFVxmN45kfZbrJPxz8k/Zn0zSBS4l6CU5mnafrJVZB8xVzga6MJbivPGeCdKxrE1o9Jz/mo8ZKT5IemQiCagODHrAc4ycJRtAviNN02nm54U3GOq0NvrBp2qF6jiyYKqlkHFQNjO3FTASJxy3anpE8TOVD3DUf9JZD+SpFpCwnPEPZxazTLYUt2xIBoqAjnemCGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTIu3W0BjaKMt6SAWvEhylkzYq+53U2qhAt4g9mzpjI=;
 b=WAcmj8lOaYbFrYkwN+0epWOqq49tsuA9nA1tsdEkSgFN05MGNDS5VsWjJYDPOTsSfE8GDA3av2slo35MuF3avQNZ49p82VoZVo1836Kg2y5umNYSdOTYaoHd0r0jzXv30YfBM+sq49xuHlAl5KkYD0DuU+ew2ElTthY1HQPAX4ABQzNJHjGEDDg79uRMikH+6G63dSrbTVAjJQ0n5D1zG9RNO9zX6VO/8LOHOrWoDPLTTmelitK1QcAnYIB0aFurWGWj2OPG8S+q5RW7u9tPACrO483fbdNs42ekBboKS+/dl3sw4JMrJdLqAUQSb6gDv4JKdgEWXmKBlKFOPrTQtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTIu3W0BjaKMt6SAWvEhylkzYq+53U2qhAt4g9mzpjI=;
 b=inK+V4078skziJEyKzUkH+apHVbvML227eUPT/JNrTDhPfiKY+KhRSPzo7/ju3g2LDCkcHjwFMFgZMJ25/q+vygAOzy3GPKvoqDX8boAjPovwgyfNmdOkqfERCEUSDDx8Ss8FVRbK1OpahT12UTJaS3CHAXkxYpvRuyg8r+gWbPU9rneZxSFSgxp8QyNaYdoraZCOHOqSdp2wcwG/Dmv4CH/+3VRw0+o5rMKatuHb3X/+Q737j1n15R+gdwIBK2SsWRPPvQKPhrUsIKSdSEu3fStpRKtcQ3crrQvBCACcIBBkdHOeadvAOOUBDzKOz9fNavtZmgbGfQ1/lVjv/zUzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PA1PR04MB10144.eurprd04.prod.outlook.com (2603:10a6:102:460::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Mon, 11 Nov
 2024 15:01:05 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%3]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 15:01:04 +0000
Date: Mon, 11 Nov 2024 10:00:52 -0500
From: Frank Li <Frank.li@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Pengfei Li <pengfei.li_1@nxp.com>, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	joao.goncalves@toradex.com, frieder.schrempf@kontron.de,
	marex@denx.de, hvilleneuve@dimonoff.com, peng.fan@nxp.com,
	m.othacehe@gmail.com, mwalle@kernel.org,
	Max.Merchel@ew.tq-group.com, hiago.franco@toradex.com,
	tharvey@gateworks.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, ping.bai@nxp.com,
	ye.li@nxp.com, aisheng.dong@nxp.com
Subject: Re: [PATCH 2/3] arm64: dts: freescale: Add i.MX91 dtsi support
Message-ID: <ZzIcJKaEXEp5emLz@lizhi-Precision-Tower-5810>
References: <20241108022703.1877171-1-pengfei.li_1@nxp.com>
 <20241108022703.1877171-3-pengfei.li_1@nxp.com>
 <ZyzXcktk/sjAtNCg@lizhi-Precision-Tower-5810>
 <2966679.e9J7NaK4W3@steina-w>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2966679.e9J7NaK4W3@steina-w>
X-ClientProxiedBy: BY3PR10CA0011.namprd10.prod.outlook.com
 (2603:10b6:a03:255::16) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PA1PR04MB10144:EE_
X-MS-Office365-Filtering-Correlation-Id: 737bf78d-a942-45ec-471a-08dd0261a9aa
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?iso-8859-1?Q?mRArUKa4qO6F4420tpNtDge4fPhthZDkklhs8f25ZEaY2HpDqzVss78En3?=
 =?iso-8859-1?Q?9OJAej4YIajaoyUTHbShONYX6/iJKKpejYslAlUFcAhAfqtLIT+2nyGHR2?=
 =?iso-8859-1?Q?ruV6ol6t9LYiI4PrVGdla6Ncty54iES1+KZ5OR8DA4oCFlCuPzgCEqrvHc?=
 =?iso-8859-1?Q?c2mcwKDz9h3gGIoC4wgETNxxN/chLzFSBkB94MM+wJT+VblVA7I02JlP9P?=
 =?iso-8859-1?Q?I+jZEqai6ISf46JMlQqhyXRwM00WYWwb6CDEr/r0uE7MW/iecitXGinCAI?=
 =?iso-8859-1?Q?GsowvjQf1M6mXqbIci6ftdcaJ0YjKR+pXiSjx+hojklPfyyCbGQhX9oRvC?=
 =?iso-8859-1?Q?fTEBwt17Ct+dAl3fyZ7p9PptzZwb9eBeu/o3A26g3ci7x7CBuOuV0XXl28?=
 =?iso-8859-1?Q?IshGubokJ8IK6whPvjiizg9lDgZwKK/JSu3DGUo3l31VAPmm9QQQeiSwkv?=
 =?iso-8859-1?Q?ArToAhc7Dj0p0SQOxWCOoR1aJE2Am3aZVqJNroZNcL53ossJ+w6Esh7KJi?=
 =?iso-8859-1?Q?Kq1uujkIfDHRf2dS2Lr9pEGS7dkDvof0MnhRWgZetRMdQhMmi5V9RrE8vh?=
 =?iso-8859-1?Q?a6w9OBQNIMTOAW9UB0JMQoKLow3M1E20auBsw2niv7EkK+8/hZ3LEyKNa5?=
 =?iso-8859-1?Q?iVi6kSQ4+b4FR/2ZivhdzTrcoMHKCK79co2Bssbq1lTfnJ7ZL8RIuAvYuR?=
 =?iso-8859-1?Q?dfAM4UVY/wK5qyVuQTdwipKcbYCBMhFBgVP4r476GNfngrywOVlH4Sl9jf?=
 =?iso-8859-1?Q?zzQXZZvXzM382o+3+jlUjYBh+dRRzaJaBJhsntEyC7OlPAbmR8Sch6+Uuj?=
 =?iso-8859-1?Q?ZtL+IHoE9PqBHRLjFPO2ns8U5sBNdIXqTgPt4m/F6GpX5OKWlXDo57FMsU?=
 =?iso-8859-1?Q?DFGvBT454I2yAcw+q/QUi8dB88bciNNnrj9EY2ApM/0cjUMR5S/F8TXfZo?=
 =?iso-8859-1?Q?oVA8ilDPHZuHzEusPwm/IWE1ZZ0bZHT7f4a4JDPWaIx/2B9pKy92MZnxUW?=
 =?iso-8859-1?Q?ytDKIZ6XwZ2K0UP5D8bVifqQ3/7k0IY3xIbdEh6C+QJfZ5aV30fmKhPPil?=
 =?iso-8859-1?Q?7B/n6SLx9TEnShnWz8NAEBfCJ/rdqnGniMQGe0JsJkpFXnlk7plianoLFu?=
 =?iso-8859-1?Q?TzdF7MVxG6e/8WuWLcge87A+VyNB057o8C5p8XHsDbd+FRSkl4L4uMJrOC?=
 =?iso-8859-1?Q?MctNLN9qR0h8Y1SuFSWoLaSouz7M1sJ99D2kEkQf9TWaCfyFA/xsI/oWrC?=
 =?iso-8859-1?Q?TnRu856g/Tf7SUzXWoKb0EWz1DPkDzEHaqVp/uTOWtk17iSIcnSDDyIVVL?=
 =?iso-8859-1?Q?HJuV2+A87c8GAad77otAJJdxJ1W4FSfWpMa5gnL2oEHBaqnfJ7cf92qDp3?=
 =?iso-8859-1?Q?hTMwm4Y/qi?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?iso-8859-1?Q?8KVcj/MVykU7hE7T3Z6q920hTy7tx681CwTtq93IYCJvFS2siMpoYm5JAS?=
 =?iso-8859-1?Q?RcQmDbDAgwY0qMrUoNF61Wcdb5hYQKO1x3pzL4UghnoRHQu50btXS7X7b4?=
 =?iso-8859-1?Q?bCmXWkMAzn6Ua1sS+wLcX1d1UwvRI+yfeBdy7fCmleR3KP41wTSde8nvjJ?=
 =?iso-8859-1?Q?mqaX4mvqkRI82KGHg9QDBaiLYazs6Y0vbWg7TlQYpvf3CrXg8Ksim0AvOd?=
 =?iso-8859-1?Q?1nFLvsXU4RikrjCVPIqX6fewQDJk7I9gkKxP74KHbfgghtIw7RHJ7pqsGd?=
 =?iso-8859-1?Q?XwJ635765MOXDc9EeXigp6uue/cbYePs5wTofL99vULGFZ0NaND7m/1iPE?=
 =?iso-8859-1?Q?50PoxYKtTUKQbtsPNuhHRGxa63GYc4KPcEKtNWVxkoUJ2VfWlBIlYHHxlW?=
 =?iso-8859-1?Q?vN+Ff0X+qlJBH7aJB315rPTmw6vb4VrY9r2a0pYhIY3EmBADorbxWjzv8t?=
 =?iso-8859-1?Q?SOUT1Nr48E3XBVG4dYoyQ5ZKQctKe41wC5HMCV/zR/Tpno0T5dvAcB1k56?=
 =?iso-8859-1?Q?Lmx3DtzQb222nrRJeMEb8qirxaOhtzbvjc4Iz8pJauOdxUoR5Xm08nVIck?=
 =?iso-8859-1?Q?0uo16TkK162Y38UU3gmjnwSwrmdXrOCaJ2i5OYSxOU55rKbFTL0t8Yg8Hd?=
 =?iso-8859-1?Q?xSXLsUKEdk+B9JPtB24gkij2rzlbAYaC33QoNMD9yWm1FzdQbbB09yoIm7?=
 =?iso-8859-1?Q?TF2pBwrirkvqYDXsA5sy7+Fai0rRq7hoV5N/3LedQ3CDc4395LUq3a02zn?=
 =?iso-8859-1?Q?yNjKCo7VCgVqYbaTJMe8Azuo4eGpBQwSYb92NNTX4SWsghAJ7qQOxSyC9K?=
 =?iso-8859-1?Q?Zd9O32g8hIPA9t1x9Mpp3rhH7kuG7DTQGv8uM+a6eSNHPPFTYGoVVpzxNH?=
 =?iso-8859-1?Q?U3kKIx+Qc22CEJm8X4lSHETMahPfK5wQz5ck0QPbEwscxy/MA8mzujUjeo?=
 =?iso-8859-1?Q?x5XkwoFkpxRsd/v5305U5MrDrIsg6uiB+b2Cz28754imxkel3IOwZgnu/A?=
 =?iso-8859-1?Q?3rGPAiLsKBNvqB23ITLv5p1EPL0Ml799o+PZJ3ba09cT4XG6upxelOjpq0?=
 =?iso-8859-1?Q?1a96UhWgWzjgFA84hFCuqNvkpcOo0d76Gp8m49vKTLNRSLx8yrU3Pjj9Id?=
 =?iso-8859-1?Q?4NQ2Z/kVOaZP5HNrJkb/ZgcSlrBGXaVixoICgU0ctBnK0aaIV3rj59uVvb?=
 =?iso-8859-1?Q?/yofrZQjZL3Rvb6r9EkkuoquXK3966f2O+NRKWT+tMGWH7QacmkLPfakkH?=
 =?iso-8859-1?Q?5MiTvchmsK5JasHLg8mnNNeASQl6bPMlYZJ5igZEq//3DmeFnAJdIMluRS?=
 =?iso-8859-1?Q?xJ7gcycCyYg+nPMphldWuMwimcKqk69SpJO0Cf0y+bJXn//DgzgCGZWHoq?=
 =?iso-8859-1?Q?E5HvHJo1i/oemyskP5Vgtbkk4bqwW/I5d4kwsFKdbvHbhKQJRcZ0QXd8ew?=
 =?iso-8859-1?Q?JW7ms+JwnZMe6iBIiYUyKCBHhjMErhbRhPPSr4vl7qb7nkpqLgi4pEmYYC?=
 =?iso-8859-1?Q?2cawepTSOw3lxBjAUoVUSR5kurQxmndKfP6v9crnZ4/m2p7vS9vyxZTTra?=
 =?iso-8859-1?Q?Rxr4f+eKTKROuxa7RTttZSkZIdWDvXc+TEBH6Sb/zTJL/WUPSAE6/yGMO+?=
 =?iso-8859-1?Q?2d05wj+FEyGoQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 737bf78d-a942-45ec-471a-08dd0261a9aa
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 15:01:04.7827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3RzlsXB/T+bhjNQSCjfebh6kIRQdnDvRAfZauLBNY2bK2slKwi8S7gzJ8IrlAdsYR8oRFG3nwnOwCfBh/avWcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10144

On Thu, Nov 07, 2024 at 04:54:34PM +0100, Alexander Stein wrote:
> Hi Frank,
>
> Am Donnerstag, 7. November 2024, 16:06:26 CET schrieb Frank Li:
> > On Thu, Nov 07, 2024 at 06:27:02PM -0800, Pengfei Li wrote:
> > > The i.MX 91 family features an Arm Cortex-A55 running at up to
> > > 1.4GHz, support for modern LPDDR4 memory to enable platform longevity,
> > > along with a rich set of peripherals targeting medical, industrial
> > > and consumer IoT market segments.
> > >
> > > The design of the i.MX91 platform is very similar to i.MX93.
> > > The mainly difference between i.MX91 and i.MX93 is as follows:
> > > - i.MX91 removed some clocks and modified the names of some clocks.
> > > - i.MX91 only has one A core
> >
> > - pinmux change
> >
> > >
> > > Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  arch/arm64/boot/dts/freescale/imx91-pinfunc.h | 770 ++++++++++++++++++
> > >  arch/arm64/boot/dts/freescale/imx91.dtsi      |  66 ++
> > >  2 files changed, 836 insertions(+)
> > >  create mode 100644 arch/arm64/boot/dts/freescale/imx91-pinfunc.h
> > >  create mode 100644 arch/arm64/boot/dts/freescale/imx91.dtsi
> > >
> > [snip]
> > > diff --git a/arch/arm64/boot/dts/freescale/imx91.dtsi b/arch/arm64/boot/dts/freescale/imx91.dtsi
> > > new file mode 100644
> > > index 000000000000..a9f4c1fe61cc
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/freescale/imx91.dtsi
> > > @@ -0,0 +1,66 @@
> > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > +/*
> > > + * Copyright 2024 NXP
> > > + */
> > > +
> > > +#include "imx91-pinfunc.h"
> > > +#include "imx93.dtsi"
> > > +
> > > +&{/thermal-zones/cpu-thermal/cooling-maps/map0} {
> > > +	cooling-device =
> > > +		<&A55_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> > > +};
> > > +
> > > +&clk {
> > > +	compatible = "fsl,imx91-ccm";
> > > +};
> > > +
> > > +&eqos {
> > > +	clocks = <&clk IMX91_CLK_ENET1_QOS_TSN_GATE>,
> > > +			<&clk IMX91_CLK_ENET1_QOS_TSN_GATE>,
> > > +			<&clk IMX91_CLK_ENET_TIMER>,
> > > +			<&clk IMX91_CLK_ENET1_QOS_TSN>,
> > > +			<&clk IMX91_CLK_ENET1_QOS_TSN_GATE>;
> > > +	assigned-clocks = <&clk IMX91_CLK_ENET_TIMER>,
> > > +				<&clk IMX91_CLK_ENET1_QOS_TSN>;
> > > +	assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
> > > +					<&clk IMX93_CLK_SYS_PLL_PFD0_DIV2>;
> > > +};
> > > +
> > > +&fec {
> > > +	clocks = <&clk IMX91_CLK_ENET2_REGULAR_GATE>,
> > > +			<&clk IMX91_CLK_ENET2_REGULAR_GATE>,
> > > +			<&clk IMX91_CLK_ENET_TIMER>,
> > > +			<&clk IMX91_CLK_ENET2_REGULAR>,
> > > +			<&clk IMX93_CLK_DUMMY>;
> > > +	assigned-clocks = <&clk IMX91_CLK_ENET_TIMER>,
> > > +				<&clk IMX91_CLK_ENET2_REGULAR>;
> > > +	assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
> > > +					<&clk IMX93_CLK_SYS_PLL_PFD0_DIV2>;
> > > +	assigned-clock-rates = <100000000>, <250000000>;
> > > +};
> > > +
> > > +&i3c1 {
> > > +	clocks = <&clk IMX93_CLK_BUS_AON>,
> > > +			<&clk IMX93_CLK_I3C1_GATE>,
> > > +			<&clk IMX93_CLK_DUMMY>;
> > > +};
> > > +
> > > +&i3c2 {
> > > +	clocks = <&clk IMX93_CLK_BUS_WAKEUP>,
> > > +			<&clk IMX93_CLK_I3C2_GATE>,
> > > +			<&clk IMX93_CLK_DUMMY>;
> > > +};
> > > +
> > > +&tmu {
> > > +	status = "disabled";
> > > +};
> > > +
> > > +/* i.MX91 only has one A core */
> > > +/delete-node/ &A55_1;
> > > +
> > > +/* i.MX91 not has cm33 */
> > > +/delete-node/ &cm33;
> > > +
> > > +/* i.MX91 not has power-domain@44461800 */
> > > +/delete-node/ &mlmix;
> >
> > If someone want to use it in overlay file, /delete-node/ will not work.
>
> Do you expect someone including this SoC-dtsi in an overlay?
> I personally don't, well I'll welcome other comments.

Many boards of imx91 is the same as imx93. We should use overlay file to
avoid duplicate every imx93's boards.

There already have 14x14, 11x11, 9x9 boards dts file and some other
overlay file base on these boards.

If the board is totally new for imx91, still can include both imx93.dtsi
and imx91.dtsi to create new boards dts.

Frank

>
> As imx93 is an upgrade to imx91, there is also the possibility to do it
> the other way around, similar to imx7s and imx7d. The latter one including
> imx7.dtsi and adding additionally peripherals.
>
> Best regards
> Alexander
> --
> TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
> Amtsgericht München, HRB 105018
> Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
> http://www.tq-group.com/
>
>

