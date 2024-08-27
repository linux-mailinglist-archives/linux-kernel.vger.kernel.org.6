Return-Path: <linux-kernel+bounces-303626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 525E89611D0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB7C91F21ADD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5A91C7B61;
	Tue, 27 Aug 2024 15:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OKmUzT4e"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC891C4EE6;
	Tue, 27 Aug 2024 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772206; cv=fail; b=WNdGPL9m1jz2CFmNwd89KpVKmAvpNo4gNod9eOIdvhYsLokx7igHqB52tGjvyXRBTT8dvKCpfkFANjZQ0SD5DPc80xA9mZz7Kh/1lmKXlGU9WHaybKFgGP1UUjSjJlMdoLcMrErHSr51xuVCqOJfV64qRMyZQuPlSN/8Pmq/U5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772206; c=relaxed/simple;
	bh=JLi/9qcX4U/jgygK7IJc0OIX6JXg0mRQAtwzWzUW2Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MZK7Jo46awSwJdVdqW9LOnx2KwI23pvuJxbn0T6RF05MZqLfx7DwMaUrS5az+PQxS7Jc0OHCJkimxrEl2E4r9qWrQ9909wc0xR31gQMhxj6VSi+JKcqg2J/D8Bn1OmQKRD/ScCXyZdYpchA+QZ2Lk8jBm8nUMyk+457mC6yDzWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OKmUzT4e; arc=fail smtp.client-ip=40.107.20.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tuK4Pg48KgSR8i1fY7UkO55Ygn+VgyQuHG05ZLK409yt9hBcM1cHaUv3ruNtCMcVDFfn58Mf1JY35o/2hPr51YVmvgDnvKMrdYoB3kgHjCiygDBNEBHTA1h5kRAnnP2qC3T3uZJ3HoTiXSltIh4TXQ6x8ZWC4Mu3zhn58m6kxNODJxfaP4tbXZ4eIK1KDjUFl5ZZ0mrco0yB8QJ2M36szqAOhCMG0vMnXnb8voORLPXT0f+ZNnHBYmoJsFRQzzhtgw4gvJp5hzgQBP0++qvb0YXiZoLI16Juf81AxZLvLITOGjtRd/xaku/ovHOABxIcytlSG/HZWPqCFAvdcK5C/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvmuY+L8YKOP0xSDBNI80AMlld8EP9fpv46sLClLGQ4=;
 b=HOSWHXD+js2JPd89HVoXh8bVRF7ROXM9A+UXgga/c/d8sqAMbKqYWxZZNgIiCcBbJ0lTHE6z3kKuH8XGCCYLhUZzvg27TqzsKhtGUo5czFMvYB7W43oj7Wgm1oUMMkFtX5uyasMyHOC0CVmpLeD3stZ3kPWQowIbN2zVdJ82z+GKNlOyjTpFTJiZHwl4VRDsmDoNdpd32Sxz6VQ8XNdtcDJ81nIPPFM2mcfxynTf0JLbU282FcEG1WyNSMVJaSeV9JQMZtAaysZqZtstkW4RdhG+69ML63lnd6vPwFzAMe4JYxH5WZUhSDb8FIN1c0eMGJ6aiyI03G+PHdLhmlxlDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvmuY+L8YKOP0xSDBNI80AMlld8EP9fpv46sLClLGQ4=;
 b=OKmUzT4edBHo1gJbUhubwaQJCSIqnP/jqk9cm/AJEEygzljPJIJtpjiBp+u4e3nxQkrv/SUhI1aHu/Gxyorf2pf0jrlo6VjfGedcHTkUTOFf2n9yhMm0ktwNTQmXhax838xaqBPoFEoc7r0y7rbWq4gJLZCfLfFa2nFGn0RAgiK0EbA6DJGkF4QFKdrtKCEVTASAfE+vs2Y9clAQ/ROhJuEUdKYjCQ8R7DzBC8WrKAY8VjKKl7qoLKb4/WE/Ve+7YZcHEf4w5g2X/2mZtnlArS26wz9rAelqVKKijc8M+5o3j8/XEYuDFY2g/OStmxl/XUQrmkeDkdYcoqWAE/dRrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7427.eurprd04.prod.outlook.com (2603:10a6:20b:1d4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 15:23:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7875.019; Tue, 27 Aug 2024
 15:23:19 +0000
Date: Tue, 27 Aug 2024 11:23:10 -0400
From: Frank Li <Frank.li@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 01/10] arm64: dts: colibri-imx8x: Add usb support
Message-ID: <Zs3vXqMJGlV/ciWC@lizhi-Precision-Tower-5810>
References: <20240826215922.13225-1-francesco@dolcini.it>
 <20240826215922.13225-2-francesco@dolcini.it>
 <Zsz+YjOyGoReEqUm@lizhi-Precision-Tower-5810>
 <Zs0BdnJM536YQd-B@gaggiata.pivistrello.it>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs0BdnJM536YQd-B@gaggiata.pivistrello.it>
X-ClientProxiedBy: SJ0PR03CA0216.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dffbee4-cfe4-4b8a-b2b4-08dcc6ac2e4c
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?2ex6xh4qra0Id4EaKG5hYC7F1Zk6sldVFIHhMWTFcsA8TreWuYjGAaBInja/?=
 =?us-ascii?Q?ublayROz/TfTuCtTJWfqrCNfG/7kYtMTYTObpY25u2vsh3SNZWgMWejj98YG?=
 =?us-ascii?Q?daOCO1rs7IPd0BcZKXn0sEbd7V2hbo24TrxyIulpuvhde6Ty5ye4RC2KDWGL?=
 =?us-ascii?Q?Pb3wBP9gcD90xp59asjAi/RqSz4Cz4ztQGBrShpnNqV064azz1Ua7S/EAquN?=
 =?us-ascii?Q?oAQqw4pP+vvLmE5OA0S2oWRfxuCc0Fl8WGG9Lir4FzdiNDOB6gf88IKK0UE0?=
 =?us-ascii?Q?Q15ohSgFFjhjmnuBLh+7faf3kEVHOFrfJmycGANczlJ6If9iscsjgadlGIyF?=
 =?us-ascii?Q?+d1OKfBaPBirdmPk5aXSPwWtGY877JaF7TsspvT4CEjkrc1TCyzDtHmguRa9?=
 =?us-ascii?Q?QrRz6a8FYWXdqIcNMjkfbSUHtz4CPf2JmMQwCnDxGDvdJUJ4rbptnM1TsUhF?=
 =?us-ascii?Q?x/EJJzCcenNYtbFJGqGEYGZ2Cz8M914MaEqnHDPscANBiV56PcI8aoMM9sAD?=
 =?us-ascii?Q?vcp8YUZHkx8VK5NLzVBLFf7DzBAy+OAWbUYA7GdGSLQrz37HtDdliyVH7JMx?=
 =?us-ascii?Q?xmWrJGX907F9BwVLoYLSI2z95zN4qZi1abYeiDaYqkq17LPoWtqDhPGV5lx1?=
 =?us-ascii?Q?NsZAWE3WnJFP+xoJ0MKsodbj2dls15mSpUgE9nwquJ7HsPhFYXgDjhA8X61E?=
 =?us-ascii?Q?1c+rgzP67n3SsH+MoTC85lw/FZtB7GCXyfXZ/zChkOoRRaoNwxVIW/Gtzpr7?=
 =?us-ascii?Q?GITLj6uCK8mpk7jwFEw8sM7Q/0u8ccs/Qbtvgiz+YnmD/Pkhw7vJjSe17Lc9?=
 =?us-ascii?Q?oMj//LMEbVwHnsHWc7njJQJqVIX5My5x8KeqZOlF96musGxZOf3P+lLijsPq?=
 =?us-ascii?Q?aqi3jsp6JpNZX9FvkTiLITLU3PmMqJ/JPi7JoO3CAXktmxttT+5jEvHDWGEh?=
 =?us-ascii?Q?5kCyrcjvPlXh/JYB119yTxRXy3qX1MoVs/iLCC1uRp1BnGoWhrHe6DwY2Jzb?=
 =?us-ascii?Q?EdrTykDJ60Zx/pqgOp4tJuE4l5grxvcn3O3pUQPOG0GKcqBvjYR7wSlB4v/n?=
 =?us-ascii?Q?T/Z5jpgiJoKw4g03J4/0916ab4mKzwSLL1f2vpq0rdCExggayvPHb3C9sbiM?=
 =?us-ascii?Q?9dJa1BtySa1M51FT/GpYUvcVYxuYZqYjU2qAqo+LPnnaHi7LIUiKLd4Ldywr?=
 =?us-ascii?Q?zEEC5RKTTZumSoYM5IjNTj+ld2+wYalhjArhZgKiAa4LG9OWCx9h/mMWnZsD?=
 =?us-ascii?Q?1Rnjfkhx0+Z1S3iIWM++WS7nviMgEpUYqTfS9vt0ePCwvKJhqEZl+Koo0pp0?=
 =?us-ascii?Q?eUxBDZdl1RKFvqb0+mVBm84oGN5rWaYQwH+UfkgmShilcL0cyPQ0Wou3fNDy?=
 =?us-ascii?Q?ipJOif4=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?diB9ibeaxUxGFSo2fpUtAUmpQ1H1oZeb1hbbd/ERcAJD2ZlQZ7jiK/DGGOxz?=
 =?us-ascii?Q?depxEeqZ80FxILPjqo2Q5kpyi70cfqmW4aUI91oI2iQIMrjcinkAEX/iXf+F?=
 =?us-ascii?Q?EjLyKPeWTfFxafTGhHXos2+3VUD4cS2KvSN3bS1Cbi7LU+xTHpAxK9YgTucz?=
 =?us-ascii?Q?25G1xE1VPCPZW01PEr4oaDPcEDpM0ZCw8YpdIJklBTzHjCXBpaeJGMrY29eQ?=
 =?us-ascii?Q?H/ohnz5acHGoKtdQuJ2PC7Le7nGk60UE+IrduKwPjmlHufamoh9wNwzERGbB?=
 =?us-ascii?Q?WCRNOgeLcosY1+b4GJrgWwkEHiTtKw1hm+oTn2UQYj4ctBcBRMQew/Rxj7oc?=
 =?us-ascii?Q?hx60Bu64n6Q31x8rmLxKxgHdhaMUHWHW/rDVEmVlshCSe0Dz6a9em/BlFq5Z?=
 =?us-ascii?Q?EBKyUFEsv5InBv6VpwrRAjClVMmMEVkAJiV51A+FL0wpoP3KUwrEizJG5Tux?=
 =?us-ascii?Q?mC4bXEDIf6eJ5I/ij2zhX1aw5sduT8JwcgOhTeJLr+e/Y/55LLAEDg51Z0ue?=
 =?us-ascii?Q?4S7KmKrXeMe+XzNI88Xu/yiRPq9s87qHhnnNmMVnhL1jpmINN2KmmaJVyQt7?=
 =?us-ascii?Q?gX5qQ9SG+jNTtQX49/xuA3LTf2Mi9JIsyvnQmLGvucP8StE/bI85NzRc9YRe?=
 =?us-ascii?Q?NtuOO0GgM3KwKXR5A+vTc01O78LytIY3g1VGqfzof/icZP9xgYjZcYuJ7mDa?=
 =?us-ascii?Q?THGjtCd+cLtIJnZbl7dtKick3BIq7wkzTgZ/zgs29tX15aQi7iNfspLsHmag?=
 =?us-ascii?Q?Qu88XRRHjV3WKH/6US3HRyr5dbZxtFjjfXsY3iSszlwv9FgCohOL+/ssrNxR?=
 =?us-ascii?Q?PqhFM1Hp9SwpPQE0c1VSvnSSQKilkAVxV8Kl6+/hWzK8rj2H/zQ9JCnvnj+w?=
 =?us-ascii?Q?lMtOJ4D9Fgw0WcjcOdxqLqwy8aDb7xfN8RDEZOkkUZMkpacIDbZETxmiX6Wu?=
 =?us-ascii?Q?RWzoeW/aVUueCouZyqQC1rR+VRWemWPOwwTx+zbIL3STmXKY/WcY57oCTmUO?=
 =?us-ascii?Q?qjeRP+GRJ3TYvvR2Sb8MeQZ9xQFqDFT+PoNReGf/wc1dCwXUWUoLUZfqo1IC?=
 =?us-ascii?Q?HICZKcQVg18gPuUleS+q2Bi/dRZc7UfHKVDTZ4y4YNQhdbG9QNK18/UKP5PB?=
 =?us-ascii?Q?q7ASRq/yX39CgEEZoQQvmIbh2v4QnOzl2eB5UHPGa8/z7QwiWlc+j5CCvs1O?=
 =?us-ascii?Q?SnGTkNjWtsBoTGIAZyor34acIOeK/ZPAjr18ABll7mAUxmcxpZrfve59vjYe?=
 =?us-ascii?Q?IuL8KZI+dp4kYfayT7E0CQ9mZ5apWD4vDs6tuWIIXz3o48nmWGlDrkJyjSbo?=
 =?us-ascii?Q?bNcwophDipe+Ymg1EHwAg3juU+/f27Rh4TvevlOsyXnZrOG0Mi9P6jt/TSJN?=
 =?us-ascii?Q?jcbpMnUgeI/VYJ4oxXAaZLkBgIVDT3L9TucUfNKgrh8F2BX8+3O+ThkHORPD?=
 =?us-ascii?Q?LxmhAbwDhy5nZ77bDOdHM7zxuLoMOYL32BxtOqFUOVSTVyGkbo8GwfEsJA5I?=
 =?us-ascii?Q?1HgrLja8JcDLhG0Q79IckEdFr5R1Y/FmzBYXSZoSqV6yjC3z2VfIA9cAOh6n?=
 =?us-ascii?Q?ueLb2FyG0u6renK5X3B6Cf0QnPGRwcD4AfV9GjKU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dffbee4-cfe4-4b8a-b2b4-08dcc6ac2e4c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 15:23:19.4319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VIDMmcLGSDaQoHtZeXeJm34hsiNm4lJ2ytPMCnMZ6iPpe1msGn+E+h3/tl9SG+/mhgQjEfOyziidj4VR3MmgrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7427

On Tue, Aug 27, 2024 at 12:28:06AM +0200, Francesco Dolcini wrote:
> On Mon, Aug 26, 2024 at 06:14:58PM -0400, Frank Li wrote:
> > On Mon, Aug 26, 2024 at 11:59:13PM +0200, Francesco Dolcini wrote:
> > > From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> > >
> > > Add USB HOST and OTG support to Colibri-iMX8X carrier boards.
> > >
> > > Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> > > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > ---
> > >  .../dts/freescale/imx8x-colibri-aster.dtsi    | 26 +++++++++++++
> > >  .../dts/freescale/imx8x-colibri-eval-v3.dtsi  | 26 +++++++++++++
> > >  .../dts/freescale/imx8x-colibri-iris.dtsi     | 26 +++++++++++++
> > >  .../boot/dts/freescale/imx8x-colibri.dtsi     | 37 +++++++++++++++++--
> > >  4 files changed, 111 insertions(+), 4 deletions(-)
>
> ...
>
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
> > > index 49d105eb4769..1199e311d6f9 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
> > > @@ -23,12 +23,31 @@ key-wakeup {
> > >  		};
> > >  	};
> > >
> > > +	extcon_usbc_det: usbc-det {
> > > +		compatible = "linux,extcon-usb-gpio";
> > > +		pinctrl-names = "default";
> > > +		pinctrl-0 = <&pinctrl_usbc_det>;
> > > +		id-gpio = <&lsio_gpio5 9 GPIO_ACTIVE_HIGH>;
> >
> > Not sure if I missed something, CHECK_DTBS report below warning.
> >
> > arch/arm64/boot/dts/freescale/imx8qxp-colibri-iris.dtb: usbc-det: 'id-gpio' does not match any of the regexes: 'pinctrl-[0-9]+'
> > 	from schema $id: http://devicetree.org/schemas/extcon/linux,extcon-usb-gpio.yaml
>
> This should be `id-gpios`. The binding for "linux,extcon-usb-gpio" was recently
> added, and this was not tested on the latest next (my fault), but on shawn imx branch and
> the old txt doc documented just `id-gpio`.
>
> We'll fix it. And thanks for catching it.
>
>
> > > +	reg_usbh_vbus: regulator-usbh-vbus {
> > > +		compatible = "regulator-fixed";
> > > +		pinctrl-names = "default";
> > > +		pinctrl-0 = <&pinctrl_usbh1_reg>;
> > > +		gpio = <&lsio_gpio4 3 GPIO_ACTIVE_LOW>;
> > > +		regulator-always-on;
> >
> > Needn't regulator-always-on, because reg_usbh_vbus referece by other node.
>
> Is this an issue? we expect this regulator to be always on, therefore this is
> described this way in the DT.

No a issue. If some device refer this regulator, suppose it only need power
on when this device probe. No sure why need always on.

>
> Francesco
>

