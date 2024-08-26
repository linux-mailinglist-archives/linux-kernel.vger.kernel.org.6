Return-Path: <linux-kernel+bounces-302057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5294B95F946
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77241B22730
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBB9192B91;
	Mon, 26 Aug 2024 18:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iJmCTwgB"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2075.outbound.protection.outlook.com [40.107.22.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3B87406F
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 18:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724698554; cv=fail; b=u06eSGkqxhLYTw2r0qzr5TefR3AYfQNFQilR+1ZlMWSAmoHK20Yx+3cK3Lb05A0vlDhzOw4n4v/TllknTsFiLZAB6aAVtWw13MNi/U3QmCmNuAucU4g/hDxZxDgE38A+luIvspktA5rqRzTWoruwB7rti89i/5W33/rfWbSo454=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724698554; c=relaxed/simple;
	bh=85wgkMG75gUrFhRCAWeOLLZELU9Hic6v1NqprH8+/bA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NJ5FyUAvGz3xRSRM4l1LnkSJUYq2cLSRpobTB0HO/U1Yj+23iGnROeAADPolDsp7z2v7sXCMTbmylE0bvne4Og3E1DHEPShYfoFUDfXs01hNIB8EgORnuCeVcBCPaX84UUyUnB7m4BeRlkOdb24JByv3QnJdAib8ay2xmigotc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iJmCTwgB reason="signature verification failed"; arc=fail smtp.client-ip=40.107.22.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K9eMSyICQEdJ4YUXKOg6sMRTbJiT63aoT8/Ry3pJFa8goE8VkIJc5OrLgBXlPlha5TUQWxmx/G3MsmoxpvcyzUphacHVrdciGa8a/GBPD8MLekzGMInAPqAEIXIRcR5CtJYB9O6UCot0vd6iLIT836JXMF6mSec/I9uc70wKXK5ipUETTjVLlKxWKOuc0dYxdqZhBIkSNytZbLvGxhmpGarTROgMmi6JMWc/IGX5kpzOp7eLg9hLsYegSCMbAvTHOieTNlAAiIeRHwPGvApWkOB3+LOLZqiuo+ColMCwjNcc0b6xkV0R14J58QGKW4Yl9JdnY/n6uK6Hjjz/dUDpRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUFqpkKOl2X4c1AJaXP6zgca6H6OjbsVKLEbKkDKzCk=;
 b=kxlj6dNy5hQ83LhW6A2R2aOSxWqg4YYlBT4CeHYFUyYuQi1n62XS5u3TBKSqa5wrVcfw3G4FfrTptEZ0N+BvUk4pQNIEgwaX9Fyqt2yoIEa+nndBTUX2/xEazuKm3stEckWaqlsBwpP+JiItmoo5FbEgIMEXA4nGJXWQKTimZfsERyBbZcYY2Oozc1NF5USCkBZ0/8jLvR2QkLk8WotL87EBr/wMGc0NgWaOSMmH4q2S8Q7J+hY08ZCHIikn/U/Tx4dOTFBcze5oBUf51z6EF98MGa+vk3dNnj6RQb9sZFWIWYfgDb+ZOEG/I/14dUrVD3TjiwdrvSB7rKq0aLRgcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUFqpkKOl2X4c1AJaXP6zgca6H6OjbsVKLEbKkDKzCk=;
 b=iJmCTwgBx+2ZFL/+OARnnBA/S13UZPp7KdyF4nbYGplbVfLic/pzcBscBiUGk5nab020ckNWneZaDVhLwzOleUD8lKi0gVGhYwpN1JT3d+mauhT3dbmCp6EeRI6DoapRkbaKUsY+IO9oPEvsupqTmiY1Vwc6MvzmBZvZRC7vDrlx+UCCyXOHgid7C3A9yJGeKuk/DH1C34QgjZQhABN44KhP3dQRBnl0zIkSAO8Wzfnb2IMnX7ZJo7cW5+5pI3DpSIVnvK8KCfZ0ise2nPvKS8CkZLfLMa7/S6sp68Rfnde2PPaOSXO0+82u9tuWzxhhTktuFXwyNZjJavp5NL0KfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8816.eurprd04.prod.outlook.com (2603:10a6:102:20f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Mon, 26 Aug
 2024 18:55:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7875.019; Mon, 26 Aug 2024
 18:55:48 +0000
Date: Mon, 26 Aug 2024 14:55:40 -0400
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
Message-ID: <ZszPrBeoPehGsocC@lizhi-Precision-Tower-5810>
References: <20240819-i3c_fix-v3-0-7d69f7b0a05e@nxp.com>
 <20240819-i3c_fix-v3-3-7d69f7b0a05e@nxp.com>
 <20240823180426.056ac093@xps-13>
 <ZsjNA9JV0UKONV32@lizhi-Precision-Tower-5810>
 <20240826100430.33194702@xps-13>
 <Zsylya9TN4mVFL79@lizhi-Precision-Tower-5810>
 <20240826184924.53b48861@xps-13>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240826184924.53b48861@xps-13>
X-ClientProxiedBy: BYAPR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::41) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8816:EE_
X-MS-Office365-Filtering-Correlation-Id: be06fb37-4091-4202-51b3-08dcc600b2d9
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?iso-8859-1?Q?R/Lw8I6JE4F/uAxj+Ffmxlj44xtmAUNYKqW+zF+YZ07mFNRbD/ICcx5zPN?=
 =?iso-8859-1?Q?hNqfLwnUPeu7IfTppjopR9BJqPFLJow7ON3vN7xJdvGGmo7ytNl8JXZIKd?=
 =?iso-8859-1?Q?QdGUT9nCsYux4KI5a1aQqto8hMEgFsyJEluAHvcdPExxXM1M/m1ogomp0q?=
 =?iso-8859-1?Q?C1BZU5rYB0s45x2ycnMkU1rq1NS5wx3f3q/ZlsloBpaPHWtJQtzcAP5rZp?=
 =?iso-8859-1?Q?rE/zCpexzjvbwwrvqPFd4A43QQ2esiavKTtyfd30orzf3rploN64LCEb86?=
 =?iso-8859-1?Q?JJQckC8Lzr9GIxu5j491no7R9U3ceoG6N0Ajju9rEIH8vVyzb2bAQD+56v?=
 =?iso-8859-1?Q?4KuNzhHWJPb+FJPbM4mM8CZGJVZsk7YNVIFQMCoWWws063LI7lUqSMByDq?=
 =?iso-8859-1?Q?SO2nxpCqcXlEyhEHfxHhZKVQqHDJFbLC08S+1v7u4IX0WyalHJtSyY0F91?=
 =?iso-8859-1?Q?nPDZIBIYOZpfyI2K8UxQjEpIRKFVUdifulaQEPc2f0iKAcsXbI7f/WKJR9?=
 =?iso-8859-1?Q?yZMTTQURajicdnLtFlxxD9gbFfBO5TP06jHm7eNOUgSr4dIiP+ixwlHnTJ?=
 =?iso-8859-1?Q?XOeKQQgoLyhPWSR85w00Hx6Eu3R82viLo3sEWeoDtT5lK36vbU9Uz7w21v?=
 =?iso-8859-1?Q?bkhhLc9xs09bf5+lZtdWcbZku6LMqsV4Hxxyz//3XmfOl1rRtmOpjEdJli?=
 =?iso-8859-1?Q?9CUb7enTlyJG6pgj3MiFztDvG/vKXC8n2qRLuhIAZ9yuk+AXI+tgiUV7mI?=
 =?iso-8859-1?Q?VAGXI9YaMgWP1fJMo9F33AHNyoO8LpOkUn01w/sTxsNbsZZpJZ4856NDdW?=
 =?iso-8859-1?Q?N2LJjlDNTgclxJm7XHq55AAD1UYp5GpJpb0JGHqO543Hz4ZhWronAW4PG0?=
 =?iso-8859-1?Q?b/y0wR4LLTITfjjvX84U1CzO1w4zyC3D/lgctC5k8WCpIF6eeqH7A7b8hW?=
 =?iso-8859-1?Q?8n6SUisxzeB0nc+SVVhHV/wB4h5UMoCBP5Ao1E9/2MPymekTYoXWHNiBE8?=
 =?iso-8859-1?Q?Twzk5jYBLXabXHDJ06p9P7mObcETnKTgGxGxEM/qe4w+ZOXfiUYxGGFqBa?=
 =?iso-8859-1?Q?CVUyTHmyuyJFQdtXP+XgQRHE34/9lsQ31RgU34BFAvVOD7Qdgbm1xNbmRA?=
 =?iso-8859-1?Q?/V4onoJce2o2RUkb/RhYfL7FsLXqxF4PC5zwPq+Q8SuHTR7R8UJrFSC9d1?=
 =?iso-8859-1?Q?+xxV1BLoyAiw0/RyKoGiBREPpMirQLX0l0r8fTByRqUUGsvVoCi5Lz8JuM?=
 =?iso-8859-1?Q?QjLFOUmM1sfcpQIRYw6ibpuySRYo/Z0BZaWToOWVZSzwLMTXMnzDZxRPkP?=
 =?iso-8859-1?Q?5ujZSbCVd2saQANQoPiJfTzeGBaxGYBf8iExlCmve0/NRKcDgK5MNUbmav?=
 =?iso-8859-1?Q?U8ztdfbFgMOFY9UMRnwAyr7v7Dvj+QhvyrDcszf3OnBrnUCuft4YKseBEL?=
 =?iso-8859-1?Q?LamHnE1cz0Vbekt0sYZ2hxagbsTrdktBDKAt3A=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?iso-8859-1?Q?PzkYmQbBX30TnM4AZLexxuaSLQLm0Ltwxg/RyJKJ59adtoIb3p0iKR/de9?=
 =?iso-8859-1?Q?SIyg0sxjB23pMcXhWzT/DkYyMheKAkB4vryzr+ARrpKwrKpprW2MSQ2hKZ?=
 =?iso-8859-1?Q?A24LOHOnr++Z0kSkebJp8hjItdTarkv3Y9S3C7epX7WkHuGai8LH3mCl+b?=
 =?iso-8859-1?Q?fULdlDeU/44KTrjbPcwnBK8+imzaWPWQjEMy/IxEhjG3OtJzCF9ziEYpWO?=
 =?iso-8859-1?Q?qsmF626TZgAG54hZd55kiPHC/ZTc7W7fTi3ZZsv3KPwQ45G8I7oEQ9iT8I?=
 =?iso-8859-1?Q?6sCZo+U5WIcYplmcF5qX5duKMixEjaUlbjKOJT+GfLBRaLvDiFsflmd31I?=
 =?iso-8859-1?Q?EjClcpx83MbJrlD2/qQjr3DXyFpW9NZCcvV0IMlzbiuVAnRa+SwptI0a3e?=
 =?iso-8859-1?Q?3LxbXPN8V9Vpbp+4m1ii4ngZpOHY23JN++SlJRy2RBqsxWLoic5LHq//ls?=
 =?iso-8859-1?Q?a1PvyFZUMzCh6UQTlSwJR8DE439svBy7OL7LA5x8rdYMW5v2L3SNvTARCX?=
 =?iso-8859-1?Q?FPCorWB3PCA74dNxtaFscWavt/ebCdvuMMkY0S8Rpk3tciWGNwC8nbglCN?=
 =?iso-8859-1?Q?DZ26hTwwsykjKXx0dS8sTCylVflav5HXulX7HUgp9abBkTV26g1ZcK8DVN?=
 =?iso-8859-1?Q?bmQCuyVnOhsguKpIZTVDQghy79ONke7EI9vwjrWA5ckaK+l7doTxPXddaH?=
 =?iso-8859-1?Q?ySvenkd8qaBMl8XaXTxvUSZWD3KnZNXs8aCFIkPgu6zYdWPJ2KweUPpD3D?=
 =?iso-8859-1?Q?DwuuUG/6kDcQxO7jhP17W1ySO64cZh1BW0JnwVFpO95orYw3bi8I+uug70?=
 =?iso-8859-1?Q?ATR+Ah9sPcS9SLirpHwZWP9FgRxmKKs0rSbxZGxsjDxOUobkhwxRCTD7Yd?=
 =?iso-8859-1?Q?Q6Jqkr3gIMsa5JH+zp9rB2GtjescSXoCezOeE6XVufviLWSLV2zzf+QpY8?=
 =?iso-8859-1?Q?Sc6jLPcVSiF+b3VderdQqSNvM7hnoEXFLWhkRxAv+nRUNObzz+JW/tPF20?=
 =?iso-8859-1?Q?5DD7mdsxxO3QgzSDj7pK8ymOWaM8jpB2BX8yTyrTEHFSq2we4otCEZ32Tu?=
 =?iso-8859-1?Q?RTVGPyUS9xwBzuXgDazEm0+5BSsR0A/7OKJmVxQTbrmAhlblVfk080PFS4?=
 =?iso-8859-1?Q?6EDVU7nJt4PgPPLMB7kty6heIVRmdBzwZ8zCqAuGjguLYtjkv2ITdpCsi/?=
 =?iso-8859-1?Q?OV/BgoYq+ccr1iS5iBwhBQKjQkirauzWw65hrzz4J5s/7f+9kFF7w8g46c?=
 =?iso-8859-1?Q?TFXGOyal859R4N0j6GDYImWAP8ML1enEJKhxvtGLlv/vPelCBIIzgw429g?=
 =?iso-8859-1?Q?qUpL2hzYqGgTuzdwFP9D/tLYCmrtPaVKq7U+qjgsve+K39eWbJJ7a15alE?=
 =?iso-8859-1?Q?4WlesJ1sLUBOhlwfJuTi+4FiK/52qxAg5E7gQC5m615QHgq/zlaoOzDUHz?=
 =?iso-8859-1?Q?V//bbGGCio641MrncCj/UdvahGt0Ehtz0vH7OaTjmf4dfoQ44DdsRrbDyH?=
 =?iso-8859-1?Q?aEXYy1OHP2z/k2Sce2rPu4zsrljmGsVqW8DKrHdzCQ9G8QzMAvnFSkJEYa?=
 =?iso-8859-1?Q?1j1gA8iaVpIXW2BmcXNgTWpz2ZXvB4D53fmI4qVozeAjk3t2bCe4VLUv6o?=
 =?iso-8859-1?Q?7p6xxKt0wEerGz5JeaSxQ1bgcMgUWX6vop?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be06fb37-4091-4202-51b3-08dcc600b2d9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 18:55:48.4074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LeNFiYRjL2rgTFnRsSuld7SROM7jc46Xl574R3wL4SymB53e07YEs7mPuOwUctGMenjB6QYIkt8Bo8e8h1fNkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8816

On Mon, Aug 26, 2024 at 06:49:24PM +0200, Miquel Raynal wrote:
> Hi Frank,
>
> Frank.li@nxp.com wrote on Mon, 26 Aug 2024 11:56:57 -0400:
>
> > On Mon, Aug 26, 2024 at 10:04:30AM +0200, Miquel Raynal wrote:
> > > Hi Frank,
> > >
> > > Frank.li@nxp.com wrote on Fri, 23 Aug 2024 13:55:15 -0400:
> > >
> > > > On Fri, Aug 23, 2024 at 06:04:26PM +0200, Miquel Raynal wrote:
> > > > > Hi Frank,
> > > > >
> > > > >
> > > > > >  static bool i3c_bus_dev_addr_is_avail(struct i3c_bus *bus, u8 addr)
> > > > > >  {
> > > > > >  	enum i3c_addr_slot_status status;
> > > > > > @@ -388,6 +405,14 @@ static int i3c_bus_get_free_addr(struct i3c_bus *bus, u8 start_addr)
> > > > > >  	enum i3c_addr_slot_status status;
> > > > > >  	u8 addr;
> > > > > >
> > > > > > +	/* try find an address, which have not pre-allocated by assigned-address */
> > > > >
> > > > > 	Try	to find			has   been
> > > > >
> > > > > pre-allocated?
> > > > >
> > > > > > +	for (addr = start_addr; addr < I3C_MAX_ADDR; addr++) {
> > > > > > +		status = i3c_bus_get_addr_slot_status_ext(bus, addr);
> > > > > > +		if (status == I3C_ADDR_SLOT_FREE)
> > > > > > +			return addr;
> > > > > > +	}
> > > > > > +
> > > > > > +	/* use pre-allocoated by assigned-address because such device was removed at bus*/
> > > > >
> > > > > 	  Use      allocated
> > > > >
> > > > > pre-allocated or assigned?
> > > > >
> > > > > I guess the logic should be:
> > > > > - try the assigned-address
> > > > > - look for a free slot
> > > > > - look for an already in use slot that must concern a disconnected
> > > > >   device
> > > > >
> > > > > But the comments are not precise enough IMHO. Can you rephrase them?
> > > >
> > > > How about:
> > > >
> > > > Follow the steps below to obtain the I3C dynamic address:
> > > >
> > > > 1. Retrieve the assigned-address from the device tree (DT).
> > >
> > > I guess here you mean that you try to pick that address, unless if
> > > already in use on the bus, right?
> > >
> >
> > Sorry, It should be typo. See below
> >
> >
> > > > 2. Look for an available slot address.
> > >
> > > "available address slot"?
> > >
> > > > 3. Look for an address that is pre-reserved by another device with
> > > > assigned-address in DT, but where the device is currently offline.
> > >
> > > I don't think this part is precise enough. You don't look for addresses
> > > "pre-reserved" but rather more for busy address slots, which might no
> > > longer be in-use because the device is currently offline. The fact that
> > > the slot might have been pre-reserved in the DT is a detail that may,
> > > in some cases, not be true. And as far as I understand your changes,
> > > you're not checking the DT addresses but rather more the addresses that
> > > have been allocated live (which is anyway better, because i3c might
> > > very well be used on a !OF platform).
> > >
> > > Once we settle on a description, maybe this can be part of the kdoc for
> > > the main function searching for the best dynamic address?
> >
> > I am not sure I understand what's your means here. The current framework
> > is
> >
> > 1. Get a free address first, the get more infromation from devices, like
> > BCR, DCR ...
> > 2. Check if it is old device, or dt node have assigned-address property.
> > 3. if it is old device, switch to use old address (if old address is free)
> > according to i3c spec. If dt pre-reserved address is free, switch to use
> > dt pre-reserved address.
> >
> > To match 3's requirement as much as possible, when 1 return address, which
> > should avoid return dt's assigned-address.
> >
> >
> > /*
> >  * I3C Framework Address Assignment Flow:
>
> 	 f	   a	   a	      f
>
> >  * 1 Initial Address Assignment: Attempt to obtain a free address first,
>
>      1.	       a       a
>
> > then gather additional information such as PID, BCR, and DRCR
> >  * 2 Address switch:
>
>      2.
>
> >        - 2a: Check if this target device is appeared before. Switch
> > to use prevous address of this device.
>
> 	 the previous	for
>
> >  *     - 2b: Check if this target device have assigned-address property in dt,
>
> 				    has a preferred address based on
> 				    firmware data (DT). Switch to it if
> 				    it is the case and the address is
> 				    free.
>
> Today it's the DT, maybe not tomorrow. You take these values from the
> firmware on the board, that feels more generic than talking about a DT
> property name.
>
> > switch to this address if it is free.
> >  *
> > In step 1, i3c_bus_get_free_addr() is called. To optimize for step 2b, this
> > function should return an address that is not pre-reserved by any target
> > device with an assigned address in the device tree (DT).
>
> This does not make sense, if you want to optimize for 2b, why not
> selecting the assigned-address property in the first place if it's
> available?

This is my first idea. But I gived up this way.

Select an assigned-address here will involve a big change in i3c framework.
There are no PID information in i3c_master_get_free_addr().

In DAA flow:
- SVC is get PID first, the get_free_addr(). This case, we can use PID to
get dt assigned address.(if change/add API)
- But HCI, it is difference, hci_cmd_v2_daa(), get_free_addr() firstly then
send out DAA command. So no PID information when call get_free_addr().

To cover both case, return a *real* free address here is simplest solution.


>  Also, I don't understand why you would care to specifically
> *not* return an address that might be the default one for another
> device in the first place.

If devices A (want adddress 0xA), device B (want address 0xB), if both
device send hot join at the same time. device B's PID less than device A,

Device B will be found firstly, call get_free_addr(), 0xA will be return
if no this patch.

Device A, call try_get_freeaddr() to get 0xB.

So Devcie B will be assign to 0xA, and Device A will be assign to address 0xB.

After do_daa command, framework will add device B and device A into i3c bus.

When framework try to add device B to i3c bus, framework will try switch
device B's address to 0xB from 0xA, but it will be fail because 0xB already
assigned to device A.


> Changing to a free slot (if possible) not
> reserved by another device might be done in 2b, which makes operation 1
> much more simple, so you put all the complexity at the same time.

I am sure if I understand your means here.

I put all address (not reserved by another device) to free slot.

reserved addr by another devices but offline, should be used only when not
free slot avaible.

> Even
> if you are proceeding with two devices asking the DAA at the same time,
> the procedure should work in a way which does not impact the fact that
> the second device will get its desired address if the first can take
> another one.

I am sure if this is still validate if you understand HCI case.

Frank
>
> > If no such address
> > is available, it can return an address that was pre-reserved by a target
> > device that is currently offline.
>
> Thanks,
> Miquèl

