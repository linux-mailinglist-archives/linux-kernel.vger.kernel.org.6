Return-Path: <linux-kernel+bounces-259105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB8C939144
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90CAE1C21767
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA03816DEA5;
	Mon, 22 Jul 2024 15:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IDUFbk7p"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C7116DC1D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 15:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721660557; cv=fail; b=ULb9OhZ2mvEZY12xtSNIUPx6sbiy0z0V6DDYM+p+0nL2U2hG/jQU4gZ1x8G2xNdpnJ4haQcqUU7k2dpLDdr6KL/shHHcQ1/W5q0YCZ9N29skpYuPvlLESCM4YwKT00XCwdPSGJdx/Y6MknIemMr5vAZrl0GUByeDNbUinpteCMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721660557; c=relaxed/simple;
	bh=q+kyLXQ/6sIGPvHnDtEeVOLZgLTrZnQiZ5a79WvFI5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JMQYNZpm0bmYDWYIgidha6t0YCoSfUyKnW1mOYP2uVrKDAqL/GrvWfl4NCAJ0jPHplqXeLWQjLkcKg/AYC6uYFTysdkrkzgch5MJbKe3EYMigBpoK4KsdpiBFcaaiZEx95zD6v0SiMKMFOadrRwbrhKaOHl8xXkUpGR/j4F/z1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=IDUFbk7p; arc=fail smtp.client-ip=40.107.22.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=okJN+VciGSTjWZu0YTCSe6uvzHmw9N9rsj3IfTrYhAUnivbxNB+NOUegFQMqnQ55n6CJENwDq5oWiYWM07mifUbjzmlwO5jtIj5A+XbbS5ONQhGLbbT2NZp5dDOFOwUeuW4lkONOpRqcCXBe+KOvzEv7BLEQ5r2OI0mKUJ+eK9Jri3wIqdUulNVmL73R0XzdjSKWXOYCqpRss66N+Y17SL95ILQs06zGdjVQnnD44wzJN85tToujo4oNaJOoqaPdC4UpMmsXp3t+XZdjqWrSS5hwfiRZgajyH71tugGhODWjLG9S4W53TEJqDqN+BPQ1/A6Vp8V1P0F8KfU5hQ2VBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XfZaXoYXRx1ao+yBvRghDdC13sAxlW3E5uQKMBXKZPI=;
 b=yT/fftTLc8PV1tyCwf+1mpnfPd09nL6Ef4JwcQ+W5JSTEqSf+sPXCyqcdGuUFgBEnRQld0KMJOjGaAuyj6px1+epHHy8Nu4bbcdelGurzmi21gtqMRw0MAvN8R/eGxSCxmut28L9nLzV+qxwdBFtXiCx8k0Z5cJ5K5R5FZ+YMaERkPS5BJ6QLDuDwodDQFYIGfjgcyO+W0DHGOYUfZImZI1HWkK7u3vqr9wQFxRgk6/fMtk1TuqAU1uhZ7zVb3RBMmHXOQqH4BqlP4mD623T2Mdz0poUPYw/E7U28iokp0FqCcMEj+j91c8Qt/yh7knp9axh3Y4mYm8LAgUQavDqMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfZaXoYXRx1ao+yBvRghDdC13sAxlW3E5uQKMBXKZPI=;
 b=IDUFbk7pcO6HcScp+15JFPfOFT0YhRIP+bTBAjRNuPnDEvMk06h2dNCCdF7eyM9T2EkhCxPM1eO3dUwaBQbsGivYmZrQnFt+FGfKF6kqauRcQJvE4u3J+GNYXcReJDS4qbV34KLyw+EvSbFwOCq5+d4CE/rk49vCOnP9FGBf8Rg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS5PR04MB9771.eurprd04.prod.outlook.com (2603:10a6:20b:650::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Mon, 22 Jul
 2024 15:02:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7784.017; Mon, 22 Jul 2024
 15:02:31 +0000
Date: Mon, 22 Jul 2024 11:02:24 -0400
From: Frank Li <Frank.li@nxp.com>
To: Carlos Song <carlos.song@nxp.com>
Cc: "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
	"conor.culhane@silvaco.com" <conor.culhane@silvaco.com>,
	"alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	"linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v2] i3c: master: svc: adjust the first broadcast speed
Message-ID: <Zp50gJvEN0NOsPpm@lizhi-Precision-Tower-5810>
References: <20240719080351.842848-1-carlos.song@nxp.com>
 <Zpp/uv0yeEhld6We@lizhi-Precision-Tower-5810>
 <VI1PR04MB50058C9E30C4A357E43CB34FE8AD2@VI1PR04MB5005.eurprd04.prod.outlook.com>
 <Zpqvs+ok7UQtlYkZ@lizhi-Precision-Tower-5810>
 <VI1PR04MB5005A8FA5CF72161C7654DB3E8AE2@VI1PR04MB5005.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB5005A8FA5CF72161C7654DB3E8AE2@VI1PR04MB5005.eurprd04.prod.outlook.com>
X-ClientProxiedBy: SA9PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:806:20::9) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS5PR04MB9771:EE_
X-MS-Office365-Filtering-Correlation-Id: 891776b9-8e7f-4e85-4e14-08dcaa5f4f9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hbnxeyi2Tcr7ZEuHM5Wha41HnJqXb5JCf00mapAe8iXfMxyaLh5h7FGikuE2?=
 =?us-ascii?Q?ABMb70zEKbIoc2XuVwrD2gRSPu+cG8zoEBcwG+pGDFP05RPoK35ohjr6+PrN?=
 =?us-ascii?Q?wH5Nqr9tWB4SH4GT9bqB3ZFI8SyQMJP/yuoQuA2Dvt3zPZm4IZJQdLt+ROHd?=
 =?us-ascii?Q?q4H2CjP/+gFWT/jzLg9lEjyhE+r2zoYQmqKwOf9q49OwLPp13kosSPGFCPo2?=
 =?us-ascii?Q?W8q9sw/I5YyAIUy0j55i4iUip0ZAXnGDaxLX5zaQtWMZsI5rMB5j7HyOONzo?=
 =?us-ascii?Q?4WQbcbh+7Gd8FLEuHW7EhY8P16v0RIM31w68HGNPTHBEBpRDj5JFV36tCSZ5?=
 =?us-ascii?Q?MGaoRkZzrHVsWKdDysy4wMmcsLjd5BNEqxivISBiZ14vQjQxSJioG4bSpyAz?=
 =?us-ascii?Q?xfn7k/y1mKPoO4MY+4y1d+Ie9459x6Oskdr52BtxGMlCqI7aucjGKCM+uY0I?=
 =?us-ascii?Q?56jZlzlvCDh8iSdW611ZwwuJuUgaY9CQ5o7lh7xiHnmreuO4s9Be1Zx5Mjiv?=
 =?us-ascii?Q?FpL5z4DsVDi+uELMyR6OuPHic3RuFtzHneMVO+gJCIb//ncF+37YOP8cVERJ?=
 =?us-ascii?Q?Kk+Qz1OzGgmMFSvbTvHWQlwN0CEL4I9Ugx7jLQ612Xo7rAXCn+UsB7+rFWiW?=
 =?us-ascii?Q?T/ZSItFEgkFU6SUZLe7yRwNBkNblMOD5Io8YZ3e1Nxzo+PMSzr+2B8voAHdq?=
 =?us-ascii?Q?ha2dSqSdLWTwOzpG7M3cK0aWbP4xda4g8gHGXQOG+TcT3JE5Pqq1z3N5hYgt?=
 =?us-ascii?Q?uCsUIkboJI8X9a08UHBU6mNbg5amBWA0BZoZO801pFue88/LgZRUP2d42n62?=
 =?us-ascii?Q?c/MkLRKyFq1PbcNJlQZ9kenvPtkrWKOmcYPbG3sQluXWbbj1+aUEQdJA18ux?=
 =?us-ascii?Q?gbX9OEncDU1liCgs4NyzCXuSGla4mUOW0Kvo87caCIDpM5+kTtOMPjx2VadK?=
 =?us-ascii?Q?LRYW3Mpac9COjlGHWSOBjW4g+tMrs4LCKb/ZwfdIcPLFkRBa6jRbzbLDVlck?=
 =?us-ascii?Q?8pmyVh5Pju6KC3086G7p6BbM0AnHb+1qR057Leqtc611T6OHXKrDSfFL1Hvh?=
 =?us-ascii?Q?7nOoSD8AMGhZ0EODumv4VtvvmPagpl0BttA4vGI3QNMOi5WvvuVeQnfl5CJo?=
 =?us-ascii?Q?z2oGcUUGuoUgTV7LSpBLRSeCt07ET/Whtc/ryBSgMtADBICl0hxCm+zLBhoh?=
 =?us-ascii?Q?/2Cqx7czzOSAtWG3YpuwT0uIF/Z25JZzyJGl39rcBhiTxmhbLMC2HjciPL8A?=
 =?us-ascii?Q?6kxBdZBnUJ4QuT3rjCAfITmxTbhXBOYvpc+R6xWlK+cIv6qCuzWJysPsjE/h?=
 =?us-ascii?Q?ISjeyjH4E2SdlryCasz2lJ48ykCTMuGtsicE4sq51cK5AfR9cGYyEeRwQ7Aj?=
 =?us-ascii?Q?XzWfdAPik3/zhBHuii7VjW5KqkpU9459qOGtTCvc4k3rfG+vdw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EYaLwQTYM6ihu7XlzYfAxYhZ+YvLUimAUXppBmOio+jRHySs3JmLt1C5x1go?=
 =?us-ascii?Q?B5DJngc+lBm/MJGrywtRuOOOJq/JWLdlI7T2aqP9Yfo5gIQhyHUUG05o1lw2?=
 =?us-ascii?Q?QBVmnTugGLr/IAnP7sZQZ/SeDQMZ/jh+d7cn11+s6jwP6IphPAHvFLRpXEFH?=
 =?us-ascii?Q?JeFlI0pNeXj7gj3RcYW9Kbh1gojtPs1+O3H7J1HotvAJGXYUg01SNL0J4yiY?=
 =?us-ascii?Q?1ls0sNbd8UCbP9x83lurESLf7GfQ7/jQTXzN4oPS63YxlZ1cJpv9zvR/IeBy?=
 =?us-ascii?Q?SG4ZQx8giT9fK9M68Ri+hR8zPvhC42CFpJSWfBL69jfson1w3IRXmCjzPPfF?=
 =?us-ascii?Q?wpeDBbB0ulWNUiZ6yLBsQIUuvr0q3IRHvVSqZgNlEhbo318fN4XndL9cTJxF?=
 =?us-ascii?Q?FA++D7Qw30VbUctlqg4zHS2wregDlPJpY1165CW4mPsKc9vPibykAntqFPLx?=
 =?us-ascii?Q?aRKzOUYGv7Vt6dcw1peWoqGDQmThL9ZFZQfbfcR8a3sP116/A2fVdyxhGjx1?=
 =?us-ascii?Q?+nZw6GcHUr8PGFsXToTvpPrdkYk5rh19zQGpxzZ1YUIyU3/fBO964ZAKdJNf?=
 =?us-ascii?Q?oIN7Pb6E0UIWOk6v0Rb9NAYx6SvlxY+ReERLrxhvQ4ScZza0b0Dg9xzlXWbh?=
 =?us-ascii?Q?SZANNy6U+w3vwu1fw9+1m/gYhrWmzlmBEk5qTEhSNbcDErpsoFe7cOrcvX8S?=
 =?us-ascii?Q?DeZk1oNsnJLExWR41t3l/c0ogwLL7+TvMuj9473nYLYrJVg6fKKvBfVLBzab?=
 =?us-ascii?Q?sEHgmlVc0x39otOJY0UsVr72vTgtBRks2weS+xirgqwim9WK5GRuu6jWCzXM?=
 =?us-ascii?Q?hyfIzkQQZ3lxG1GWVYPNh1rIQpwR6rLEG2cNFwIm347XYk4kW3QqzVydypJK?=
 =?us-ascii?Q?CGixKsSfr42FiVwtekFA/LZcW4jiMWbtmAjjwuFCpOz9pXYJw8XU3GN4RrQK?=
 =?us-ascii?Q?rJiI4sSkx/cXmD/N8mUGG+Yj5kjOxLbOAOSut+YhuBBeFF2ucsYNKUXUupBI?=
 =?us-ascii?Q?wMJFgVg99uTvGcn6/phMsmz3kxlN7sN4i6pfv9UTFl2Pvjcr2b8/NmCdrf75?=
 =?us-ascii?Q?sryf3J8QJ6F0+yP4QyKIkYpF07mzU0Hq9g/TiEifk9nEg6BQKNvGrzeVrpPZ?=
 =?us-ascii?Q?Vn+96rxzrzU3ijQHbS4iMFCs8I9nLROT/GcG/M4BZ/Mlic+iNzMcigjcRhp3?=
 =?us-ascii?Q?ljkMG77hkQZb2+CHfAgswkEviROOUyoFyZxCHGWXuXM+qWn/rpmsVekQGPe2?=
 =?us-ascii?Q?6Lq7giV3yssJ4ZPKO/tSfKWg3124aoTTyhU/X2hE7kb8eHGgDT5BFU25qz2f?=
 =?us-ascii?Q?4Vsuxy960VeHm32JRYdUA0Nqw7pq2rXNu4Kh1YP8EXrGDUdc/I4bWApP05ym?=
 =?us-ascii?Q?26gcOpWpQn4bneT/pYNTsebST1yztrxg9HiETe4kwIxXZuCfbKtWRKXLiVKL?=
 =?us-ascii?Q?28XoMSoS0VoWXGlOoPz+Qqh2diZbU+6MZ3Y7VOM/9wi+lSZKKfTP2GaubSX9?=
 =?us-ascii?Q?gUAeLfIGnEBnO58vtSQdIakDvcA4uDRAm2HcvtBBPNO12IossUw9hNjlpY3Y?=
 =?us-ascii?Q?kJqAMFLiJzmaaH+NAZv04nYDFuSd+F9M1vQ0sg5Y?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 891776b9-8e7f-4e85-4e14-08dcaa5f4f9c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 15:02:31.7132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xesRsA4j6oD3Xzud8lQiyE7V5jexwdeW7BGqcBQO3gLeJ4NwrF2z399/cFmCoWlZ3rCqi596XN1J+7zVUqUFhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9771

On Sat, Jul 20, 2024 at 04:42:18AM +0000, Carlos Song wrote:
> 
> 
> > -----Original Message-----
> > From: Frank Li <frank.li@nxp.com>
> > Sent: Saturday, July 20, 2024 2:26 AM
> > To: Carlos Song <carlos.song@nxp.com>
> > Cc: miquel.raynal@bootlin.com; conor.culhane@silvaco.com;
> > alexandre.belloni@bootlin.com; linux-i3c@lists.infradead.org;
> > linux-kernel@vger.kernel.org; imx@lists.linux.dev; dl-linux-imx
> > <linux-imx@nxp.com>
> > Subject: Re: [PATCH v2] i3c: master: svc: adjust the first broadcast speed
> > 
> > On Fri, Jul 19, 2024 at 04:37:01PM +0000, Carlos Song wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Frank Li <frank.li@nxp.com>
> > > > Sent: Friday, July 19, 2024 11:01 PM
> > > > To: Carlos Song <carlos.song@nxp.com>
> > > > Cc: miquel.raynal@bootlin.com; conor.culhane@silvaco.com;
> > > > alexandre.belloni@bootlin.com; linux-i3c@lists.infradead.org;
> > > > linux-kernel@vger.kernel.org; imx@lists.linux.dev; dl-linux-imx
> > > > <linux-imx@nxp.com>
> > > > Subject: Re: [PATCH v2] i3c: master: svc: adjust the first broadcast
> > > > speed
> > > >
> > > > On Fri, Jul 19, 2024 at 04:03:51PM +0800, carlos.song@nxp.com wrote:
> > > > > From: Carlos Song <carlos.song@nxp.com>
> > > > >
> > > > > According to the i3c spec 6.2 Timing Specification, the first
> > > > > broadcast open drain timing should be adjust to High Period of SCL
> > > > > Clock is 200ns at least. I3C device working as a i2c device will
> > > > > see the broadcast to close its Spike Filter to change to i3c mode.
> > > > > After that I3C open drain SCL high level should be adjust to 32ns~45ns.
> > > > >
> > > > > Signed-off-by: Carlos Song <carlos.song@nxp.com>
> > > > > ---
> > > > > Change for V2:
> > > > > - use slow_speed instead of first_broadcast
> > > > > - add default_speed variable in svc_i3c_xfer to avoid set default
> > > > >   speed every time
> > > > > - change start_xfer if else for easy understand
> > > > > ---
> > > > >  drivers/i3c/master/svc-i3c-master.c | 55
> > > > > +++++++++++++++++++++++++++++
> > > > >  1 file changed, 55 insertions(+)
> > > > >
> > > > > diff --git a/drivers/i3c/master/svc-i3c-master.c
> > > > > b/drivers/i3c/master/svc-i3c-master.c
> > > > > index 78116530f431..7cd3a9a4d7dd 100644
> > > > > --- a/drivers/i3c/master/svc-i3c-master.c
> > > > > +++ b/drivers/i3c/master/svc-i3c-master.c
> > > > > @@ -142,6 +142,7 @@ struct svc_i3c_cmd {
> > > > >  	unsigned int actual_len;
> > > > >  	struct i3c_priv_xfer *xfer;
> > > > >  	bool continued;
> > > > > +	bool slow_address;
> > > > >  };
> > > > >
> > > > >  struct svc_i3c_xfer {
> > > > > @@ -214,6 +215,11 @@ struct svc_i3c_master {
> > > > >  	} ibi;
> > > > >  	struct mutex lock;
> > > > >  	int enabled_events;
> > > > > +
> > > > > +	unsigned long fclk_rate;
> > > > > +	u32 mctrl_config;
> > > > > +	bool slow_speed;
> > > > > +	bool default_speed;
> > > >
> > > > I think you needn't two varible 'slow_speed' and 'default_speed'.
> > > > 	default_speed should always !slow_speed
> > > >
> > > > Frank
> > > >
> > >
> > > Hi, Frank
> > >
> > > In fact, I am struggling for using just one variable: slow speed. Adding a
> > variable "default_speed "was also a have-to move.
> > >
> > > If I use "if else" in xfer for easy understand, it means I only can change the
> > MCTRL register value one time in every xfer. So in the first xfer, I must change
> > slow_speed to false, then next xfer cmd->slow_address will be false. So in next
> > xfer, I can set initial configuration back to the controller.
> > > But the question is I have to set it every time, so I add the extra variable to
> > avoid writel in every xfer.
> > > It looks bad... Sorry for my poor coding.
> > >
> > > If only one variable " slow_speed " is used , I think "if else" and "writel one
> > time", only one can be used. Maybe there is a better code method but I don't
> > get it?
> > 
> > If I understand correct.
> > 
> > svc_i3c_master_set_slow_address_speed()
> > {
> > 	...
> > 	master->slow_speed = true;
> > }
> > 
> > svc_i3c_master_set_default_speed()
> > {
> > 	if (master->slow_speed) {
> > 		writel();
> > 		master->slow_speed false;
> > 	}
> > }
> > 
> >   if (cmd->slow_address)
> > 	svc_i3c_master_set_slow_address_speed(master);
> >   else
> > 	svc_i3c_master_set_default_speed(master);
> > 
> 
> Above logic will never enter the svc_i3c_master_set_default_speed(master);
> Because this :
> svc_i3c_master_send_bdcast_ccc_cmd(){
>    if (master->slow_speed)

I think, it should be master->first_cmd, which reflect the real means.
Then it means use two variables.

If it is i3c standard, I prefer it should do by framework to avoid every
driver add similar logic.

May Alexandre Belloni can provide comemnts about this.

static int i3c_master_bus_init(struct i3c_master_controller *master)
{
	...
	master->ops->set_speed(low);

	ret = i3c_master_rstdaa_locked(master, I3C_BROADCAST_ADDR);

	master->ops->set_speed(normal);
	...
}

> 		cmd->slow_address = true;
>    else
> 		cmd->slow_address = false;
> }
> 
> Then svc_i3c_master_start_xfer_locked(){
> 	if (cmd->slow_address)
>  		svc_i3c_master_set_slow_address_speed(master);
> 	else
>  		svc_i3c_master_set_default_speed(master);
> }
> 
> In svc_i3c_master_send_bdcast_ccc_cmd, we always need slow_speed to dicide cmd->slow_address is true or false. Then in svc_i3c_master_start_xfer_locked,
> We use cmd->slow_address to chose set slow_speed or default speed.
> when use "if else", it means we put slow_speed true->false into next xfer.
> 
> When first xfer finish, slow_speed is still true. So in next svc_i3c_master_send_bdcast_ccc_cmd:
> then cmd->slow_address=ture, so in next xfer it will continue enter the "if" branch not the "else" branch:
> 
> if (cmd->slow_address)
>  	svc_i3c_master_set_slow_address_speed(master);
> else
>  	svc_i3c_master_set_default_speed(master);
> 
> so whatever we need change master->slow_speed = false in the first xfer, don't put it into next xfer.
> This is the reason I always do taht in my V1 V2 patch.
> 
> Carlos
> 
> > When slow_address is ture, always set slow_speed = ture when slow_address is
> > false, call to set_sefault_speed, if previous
> > 	slow_speed is true, then change to default speed, slow_speed will be false.
> > 	when next time call to set_default_speed() do nothing.
> > 
> > Frank
> > >
> > > Carlos
> > > > >  };
> > > > >
> > > > >  /**
> > > > > @@ -531,6 +537,43 @@ static irqreturn_t
> > > > > svc_i3c_master_irq_handler(int
> > > > irq, void *dev_id)
> > > > >  	return IRQ_HANDLED;
> > > > >  }
> > > > >
> > > > > +static void svc_i3c_master_set_slow_address_speed(struct
> > > > > +svc_i3c_master *master) {
> > > > > +	struct i3c_bus *bus = i3c_master_get_bus(&master->base);
> > > > > +	u32 ppbaud, odbaud, odhpp, mconfig;
> > > > > +
> > > > > +	master->mctrl_config = readl(master->regs + SVC_I3C_MCONFIG);
> > > > > +	mconfig = master->mctrl_config;
> > > > > +
> > > > > +	/*
> > > > > +	 * Set the I3C OPEN-DRAIN mode to the FM speed of 50%
> > > > duty-cycle(400K/2500ns),
> > > > > +	 * so that the first broadcast is visible to all devices on the i3c bus.
> > > > > +	 * I3C device with 50ns filter will turn off the filter.
> > > > > +	 */
> > > > > +
> > > > > +	ppbaud = FIELD_GET(GENMASK(11, 8), mconfig);
> > > > > +	odhpp = 0;
> > > > > +	odbaud = DIV_ROUND_UP(master->fclk_rate, bus->scl_rate.i2c * (2
> > > > > ++ 2 *
> > > > ppbaud)) - 1;
> > > > > +	mconfig &= ~GENMASK(24, 16);
> > > > > +	mconfig |= SVC_I3C_MCONFIG_ODBAUD(odbaud) |
> > > > > +SVC_I3C_MCONFIG_ODHPP(odhpp);
> > > > > +
> > > > > +	writel(mconfig, master->regs + SVC_I3C_MCONFIG);
> > > > > +	master->slow_speed = false;
> > > > > +}
> > > > > +
> > > > > +static void svc_i3c_master_set_default_speed(struct
> > > > > +svc_i3c_master
> > > > > +*master) {
> > > > > +	/*
> > > > > +	 * The bus mode is already determined when the bus is
> > > > > +initialized, so
> > > > setting initial
> > > > > +	 * configuration back to the controller. No need to set it in
> > > > > +every transfer,
> > > > just
> > > > > +	 * restore it once time.
> > > > > +	 */
> > > > > +	if (!master->default_speed) {
> > > > > +		writel(master->mctrl_config, master->regs +
> > SVC_I3C_MCONFIG);
> > > > > +		master->default_speed = true;
> > > > > +	}
> > > > > +}
> > > > > +
> > > > >  static int svc_i3c_master_bus_init(struct i3c_master_controller
> > > > > *m) {
> > > > >  	struct svc_i3c_master *master = to_svc_i3c_master(m); @@ -624,6
> > > > > +667,8 @@ static int svc_i3c_master_bus_init(struct
> > > > > +i3c_master_controller
> > > > *m)
> > > > >  	      SVC_I3C_MCONFIG_I2CBAUD(i2cbaud);
> > > > >  	writel(reg, master->regs + SVC_I3C_MCONFIG);
> > > > >
> > > > > +	master->slow_speed = true;
> > > > > +	master->fclk_rate = fclk_rate;
> > > > >  	/* Master core's registration */
> > > > >  	ret = i3c_master_get_free_addr(m, 0);
> > > > >  	if (ret < 0)
> > > > > @@ -1251,6 +1296,11 @@ static void
> > > > svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
> > > > >  	for (i = 0; i < xfer->ncmds; i++) {
> > > > >  		struct svc_i3c_cmd *cmd = &xfer->cmds[i];
> > > > >
> > > > > +		if (cmd->slow_address)
> > > > > +			svc_i3c_master_set_slow_address_speed(master);
> > > > > +		else
> > > > > +			svc_i3c_master_set_default_speed(master);
> > > > > +
> > > > >  		ret = svc_i3c_master_xfer(master, cmd->rnw, xfer->type,
> > > > >  					  cmd->addr, cmd->in, cmd->out,
> > > > >  					  cmd->len, &cmd->actual_len, @@ -1346,6
> > +1396,11 @@ static
> > > > > int
> > > > svc_i3c_master_send_bdcast_ccc_cmd(struct svc_i3c_master *master,
> > > > >  	cmd->actual_len = 0;
> > > > >  	cmd->continued = false;
> > > > >
> > > > > +	if (master->slow_speed)
> > > > > +		cmd->slow_address = true;
> > > > > +	else
> > > > > +		cmd->slow_address = false;
> > > > > +
> > > > >  	mutex_lock(&master->lock);
> > > > >  	svc_i3c_master_enqueue_xfer(master, xfer);
> > > > >  	if (!wait_for_completion_timeout(&xfer->comp,
> > > > > msecs_to_jiffies(1000)))
> > > > > --
> > > > > 2.34.1
> > > > >

