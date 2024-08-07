Return-Path: <linux-kernel+bounces-278518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC68894B13D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 22:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54C631F22E1E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 20:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780ED145A14;
	Wed,  7 Aug 2024 20:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HQZ4WZx4"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010014.outbound.protection.outlook.com [52.101.69.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261DC364BC;
	Wed,  7 Aug 2024 20:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723062344; cv=fail; b=OWY4fldiqtMrtNJTadRJQ9Q6uvCxzPlg9yPuMjx3YCeBZnBDOmmK4jgu14Bss7YZCemU2jQhBwP6rlfj+/KXy5KY33q2+gLKZbKwiLhmCVy7LcNgT+hp65Ym4t1flMK8Lz4ODJ/vN1ouzJlLblzQyHBoh1kbLTiszlDXRM8+R0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723062344; c=relaxed/simple;
	bh=n+WPo3hRRAAUCP8eMs6yUt+UyOBGzn/bF30+BGYQ+Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a/1bb4EFK3kFsN7BD9z7tu+n+NMjHkeaH9L//L+41jWVZyOjb6frFvFCiuLW74Nj1YFbzfPoYDdaNa89W4mGd1GfaHvz7AUyUMBOAfbFjQTR/QNx3PXaagA6DG4vMpbFaeWrWNR02T5qYXR8os9twvMRJQ6v+CerXDMuDTikiIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HQZ4WZx4; arc=fail smtp.client-ip=52.101.69.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZT20f5sf8g0yc6/4Vcn+EF0rJMOZjx9uE3Ytq7Po9hopoFYg7FzkL4Ee3gHBPJX+x+0T0swUKwZiQCscPVKg8z7/AqIkjNEsHqvzP3Ku85NHw1jn9SLSDkwddeCZ/TVzP2lQzY4/LN1v4O0QrOJZhiAr2uGmZlIZougiI2tGEzg0fR5B5yc/LGuUUr3vQTb4Xwn97hJUS4UbRO/M8yFZIZhrsjzDx0fmgJFiUiZ0pAg2Azd6JxrK2nmjhbJjYS4ohv3JZTmm59+tjalceUBJeMHabroaFMXg5mvxq5kvw5jsQoo52gfm2YA+3+XI9qUjkm9pzH2669S9ey3JkT/Cmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FG5U6Prn8OB5lrBZICzOUlY/+jERG/Qn0mVAPf6+PQ=;
 b=xI5Bac0G+sl2XaC/t5m8LPRWeMDR8JaMOd7iDUwgaoVBNFxC75i+OF2p2YCdhSnJ0pxQFo2YXPW53aNmeVqNmiCu31P3z9pzPXwj+cS3fRDfK02OF6jCzF3UK0Wg+El7PGKseoebCMMqCBZk0AUvP8d9UQPBc+mHz2KGkXslXsjpJN1JvbSgqaeVlxSwSPabTJBsevkZswXQ8MxGLE0TxtKAunbyrURuFsUohO8XKHv/biYVVmbasuBwfphnJTJtyfp5vncdmm2dBVMXe7cfNro2Kuw5DawYSa3jrHFD/38LSXJCyyn/9G2ve2Wup/GbHYxI6J5fcIK0NUbCTw6S5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FG5U6Prn8OB5lrBZICzOUlY/+jERG/Qn0mVAPf6+PQ=;
 b=HQZ4WZx4hZS1OZPcwzJt+Z1VR80pGtgHy/EnEaBk8rmT7FUNYmle1o/ERCF24hSGpAH0QAzSt+N/Rwv8H02fo9ToHW/fgC5ZFZ+ecBg9v+GkSmoFJgl+1kl0ISzK5hG3UAXNqOIWX3d/zyV+S7zOTEXnDyy4lxnsv8bs6jqRTNcZ4M0/hSIMSsZM3QcDD7964KDLctNrqm5/WOKSMoZx9na9Pfm3N14fVSXwzhoQgPmKx5fx4QjeY8UIPmTDhin35au1DXMuVLvzIcoesQtOSkaH8/9ujkjab/UHceYv15cAxU2NFjer6u4mtusZhuG89Sioqbzsa/kiDMEXmC7cow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9399.eurprd04.prod.outlook.com (2603:10a6:102:2b3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 20:25:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 20:25:38 +0000
Date: Wed, 7 Aug 2024 16:25:29 -0400
From: Frank Li <Frank.li@nxp.com>
To: Rafael Beims <rafael@beims.me>
Cc: Francesco Dolcini <francesco@dolcini.it>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	rafael.beims@toradex.com
Subject: Re: [PATCH v1 4/4] arm64: dts: imx8-ss-conn: add PPS channel to the
 FEC nodes
Message-ID: <ZrPYOWA3FESx197L@lizhi-Precision-Tower-5810>
References: <20240807144349.297342-1-francesco@dolcini.it>
 <20240807144349.297342-5-francesco@dolcini.it>
 <ZrOUGLJPYC/K4MlP@lizhi-Precision-Tower-5810>
 <20240807175148.GA299582@francesco-nb>
 <ee39f8ce-683d-4144-909a-972ce74b95d8@beims.me>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee39f8ce-683d-4144-909a-972ce74b95d8@beims.me>
X-ClientProxiedBy: SJ0PR03CA0282.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9399:EE_
X-MS-Office365-Filtering-Correlation-Id: f8e879ac-7659-4492-6426-08dcb71f19e0
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?CkqpLDlDtbqSLGMUJ5CtgQcRZdAwczNkp1EZtFFAckcjwPW5oX/KJzFV2Igr?=
 =?us-ascii?Q?NPUcQ5YLnmdPPIVuICNSi+sD88fFC0YZJ4D3WWzscqy/gapllHLaOC6bct+p?=
 =?us-ascii?Q?0vWcXx/PUE6/ecJxov0bZqYbQFierq25KkPqAtPbtdSm4EWmZfhWhPbyJIxb?=
 =?us-ascii?Q?v8HSjFMJgfOA6U2RCMaCNk9SsWoyshn8zS1FzN2WHm4+mI79mUcguwHaU0f1?=
 =?us-ascii?Q?Ja/PiuLGZ1h9l5OpK/ymO3hqir8l0Fq1rShIbZhWK7EreHcgGhCc7NCdDk14?=
 =?us-ascii?Q?Li/NiVQR0PzjYGkSci1TbdT5ZcxuYpsGyT7r8mm8pC7AS8pYR/U+/DShMFUu?=
 =?us-ascii?Q?rGSqT3HyR0FY8IOffZ+8DM/N7Wdh9rmU80d75NQl7HUETRvW1PX04e5vBVmY?=
 =?us-ascii?Q?IuUEMT8RP5sBK+OHm5I9U2kvOwSFoI4KPXi8kkcdTump9OzaPfla8CcLtS3x?=
 =?us-ascii?Q?muqE31I3+2ShoHVytruLzQHqSseQVFGvGlYvZLuWVWpRGvy7hM/0U6+NzRAp?=
 =?us-ascii?Q?sJj7/MKyadlwO5N/sgHMsaZbr+qI6EsVGXKzmx6ECTHYUsNZgvUvAAOeVPEa?=
 =?us-ascii?Q?nKkQiLLuMcslm0oWWuZ3eKEORf2hn8L28JuzIQXBOFvj7Jqh3KlFtgdvSpAQ?=
 =?us-ascii?Q?vRG6QRYmittuuEPCB5H1u8JSrbqvp19ga+sCva0TihLvSISjxByR9zc1tFVN?=
 =?us-ascii?Q?PPWD2PIeksJBt4rPGM3nHMssliu7KWSmAOdf6NR6ikpe7tU+Gj9/kOoXMKyr?=
 =?us-ascii?Q?1BfL8qgqBez9IYj3ZzioIJtQM08ZU8AyhB82Wzp3YpEN6EJDjvx3jHxcqTCB?=
 =?us-ascii?Q?8/+gSwg7xSY79R3bfRkQJ1On/AJZTJ4NgCqAc+r/mn4dq+Z8io5Ok13WqYfR?=
 =?us-ascii?Q?feitRM4tzMp6Bzjgn6TQh0W2wSzCFrD7OKQTgYpNpOLp3rRB/JbSeDMgdlZY?=
 =?us-ascii?Q?4Bz5wxd+Dm2JZb7QQBGWFoB2E1k30qYrOme5z02P0J7r+oaaDlcfx0QwCXUt?=
 =?us-ascii?Q?zLE8Zw1Z3jReZWT4SAAGddqCZ0nTbimNukpKS7Pws92OScLlrfj3971My5lR?=
 =?us-ascii?Q?HTMU4/qNumagsbHm7oz+RWQvU28ovtoXoG0pBBfe2OF+AIDDEj2RXRWWi7Fz?=
 =?us-ascii?Q?LvuXPnG3eqog0QkETlh4yQ1jGBoq6yyUPzN9Uk+MEbHrI2TzDRFR0+KqMTcj?=
 =?us-ascii?Q?osQ9NWMaedauLQ0vXSs2ovzII28+tzSx7YdWpQU3Daf0dbf+KHOc9BolJb2D?=
 =?us-ascii?Q?yGkRvBuOGan2ZJoyEWglvKQlDchnHdVy6D7f3AwPPiAdYJESV2ctHYTsnIxU?=
 =?us-ascii?Q?01lvfkTFf938gNzBiaRi2FFgDdji4pUoSkWG+jqfkKKpyUWeiKT0fcUEX8Y7?=
 =?us-ascii?Q?Q+YKYC41HXswWHvfFpkBHUrMcH0v+clUzh8kSj52eKkTWvkf9A=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?u50qLpnjGJt2i5MW3Vdv3wGd2YFMuBKneroREKFD9jgzVGVeO6U4EIsC6dLc?=
 =?us-ascii?Q?8jtaTmrcedtNqw+cVViF8GK7nUVXcwF++4dRF1kmd6T2F0oyEZwpFzO0Yfjl?=
 =?us-ascii?Q?w/AAYnXRnFrnxFbTG5skXrH5RK3zrDxkUhnPumewPyF9Bw/CxtTdEMze5trX?=
 =?us-ascii?Q?5XOZFVjQb58P3UDzMffs4gXybatchoY7LAciStz/dRZ6nPHfxmZ0Sid14eFx?=
 =?us-ascii?Q?JPzb4II1Zl8Q65Gm1FfU69UOc+5ohaNfNmfXKVERXO48D6QVyojKMk/D/tCq?=
 =?us-ascii?Q?iMt9aQhJCQ4JC1YG0LBIRsGykry7qUYJnvb600JYhGleEuSmyRwR0EJ5cAQA?=
 =?us-ascii?Q?K0ZhH1D3CltHqPxQakOxKsytUBpZ6LndL5zh2fyJJjLymWNrMhF7pZhYW/ia?=
 =?us-ascii?Q?pcmSLLTVw8kjmPLJGD8fnfWFRsTMrJXB20Qq2/RghAwcoXZSkYDthtYZNzfJ?=
 =?us-ascii?Q?hPdymoNrgp5ANvHSmBOA75t0ldp6pNvzjAfo+dAenzrPsBCS19GRyT48DxJZ?=
 =?us-ascii?Q?wY879bCQnMjtS9oNrQuEFQPrLJn3+6y/Gj3R1sgMf8xwFg5OKNbPMM65UhFU?=
 =?us-ascii?Q?YO4/yRA/6EeMAE3CSk1VtuKfIWc3krypbtBdB+MnWuccjzmIks1de/h+36Tw?=
 =?us-ascii?Q?XAkcidytFlHjBpQYPotuY4drrfN6MkIyuKdHPaRg0lUOOED2yHM10R47IThb?=
 =?us-ascii?Q?88lHLjCxt9ttEOeThY6alxtjZui2c0qaBUL+8DOvKy6Cn4i6iMtlPgkoXDVO?=
 =?us-ascii?Q?+2b7eK9ty/4SP2z6R2r1IVxhB+xZmodcUv4Dsv5CFJj/BQ9LlLCvktXz2mEo?=
 =?us-ascii?Q?Vv0YJ6fZD/YwbFe/ZAhE09uIshb+7wNpWZ8uIeYCUaHnEpXYhN4RrIP7SRzO?=
 =?us-ascii?Q?XxH9IHlbl4IlXDZvTvARp9Ja4dFfsbDK1K+kSr/RYNmuxsAgTynTHOamXyio?=
 =?us-ascii?Q?R3am2yrr1XY9Ob17pIA81ANqIPaSPnwsHZuswY+KXdmpLaBX1GzoTsqdEKci?=
 =?us-ascii?Q?CWvW3zc0gclkL7VPmq04/o3V82u1Gro7VppNNilKpnQn6NUJdig/Qxf+Fss+?=
 =?us-ascii?Q?Y2sDZu0WL5A/oF8LaUvbeBGK1lbQJT8ILUskbEUbIxkzrUPpdwCmAKTX0a2W?=
 =?us-ascii?Q?7nvfwKgA/ra6bNtzsxM9I/0Dhiv97mD0zoheN3RHYDE5qqkw2VHDkiTIR9ti?=
 =?us-ascii?Q?uCpTYpOxxwlkntUfWVhso3qSDl0eLmlEEeimqw+I57/JQj9r6w3Dpx8FmvT5?=
 =?us-ascii?Q?cnM4h2PomFBc5cwMANsg9X6F0auJjL18FbCKFIzApUgBQ6TqKCER+7p7DDNe?=
 =?us-ascii?Q?eT1BGFUD4JPgUk8i8IjUQe6KmkZ7dV93ztgOPS4+4wanOHTSQIYEf25ElChd?=
 =?us-ascii?Q?KDsbLFvtVwqPNAECs0doW12uoWKOGBu/vns44CVfK1u/Gxo3NJCj1VWUfDTv?=
 =?us-ascii?Q?w/hD6CFJlP1fIXDL4jCtvN7OanaPNoQActgv76bAIZ+IcXGlsgWcrSAIlI9E?=
 =?us-ascii?Q?l7gEkbXDAMQXRDixLrTcx1DvMOvZuc5c7032yHB+2et1UKQMQoIcdzRjZBxS?=
 =?us-ascii?Q?HsrBQBL1xlosV9eIOm/0IM27dc06AjanQBYEX/NO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e879ac-7659-4492-6426-08dcb71f19e0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 20:25:38.6910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o2INInEhtWtUSadeAwYchcslJUG1qxwORqzRsuMaSTuSL5PsamXwUfF9+d8k4w/faAcyOwEUlI/1K+/Eke7Zbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9399

On Wed, Aug 07, 2024 at 04:48:19PM -0300, Rafael Beims wrote:
> On 07/08/2024 14:51, Francesco Dolcini wrote:
> > Hello Frank,
> >
> > +Rafael
> >
> > On Wed, Aug 07, 2024 at 11:34:48AM -0400, Frank Li wrote:
> > > On Wed, Aug 07, 2024 at 04:43:49PM +0200, Francesco Dolcini wrote:
> > > > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > >
> > > > On i.MX8 the FEC PPS channel is routed to the instance 1, not to the
> > > > default 0.
> > > According to my understand, it should be board level configuration. FEC
> > > support output pps to any one. choose which one by board design.
> > This seems different from the information we got from NXP some time ago,
> > unfortunately this was happening over some private email exchange and
> > not documented anywhere public. But the message was about SoC internal
> > routing, not something at the board level, at least for i.MX8 SoCs that
> > is what this patch is changing.
> >
> > For example to use PPS on i.MX8QXP we need to have this
> >
> > IMX8QM_ENET0_REFCLK_125M_25M_CONN_ENET0_PPS 0x06000020
> >
> > pinctrl configuration _and_ use PPS channel 1. Same is for i.MX8QP.
> >
> > Maybe Rafael can provide you some more details and the name of the
> > person that provided this information.
> >
> > And maybe you can also try to double check this internally within NXP.
> >
> > Depending on what we find out we can decide if this patch needs to be
> > dropped or not.
> >
> > Francesco
> >
> Hello Frank,
>
> We have received the information from NXP support that the iMX8X only
> supports channel 1. Here's the link of the public question I asked:
>
> https://community.nxp.com/t5/i-MX-Processors/IMX8X-PPS-output-configuration/m-p/1552154
>
> Unfortunately, the response came directly to my e-mail address with no
> public update, but you can probably check the internal support case number
> 00500877.
>
> Here's an excerpt from the response:
>
> > I have checked this issue from soc level, the pps signal is routed to
> the 1588_timer1, not routed to 1588_timer0( being used in code default).
>
> At the time, I asked a followup question:
>
> > Can I assume that  IMX8QM_ENET0_REFCLK_125M_25M_CONN_ENET1_PPS is
> > connected to
> 1588_timer3 then?
>
> To which I got the reply:
>
> > No, ENET1_PPS is also routed through timer1. One can't use ENET0_PPS and
> ENET1_PPS at a same time because of same routing path.
>
> I also asked for confirmation if this behavior was the same on the iMX8Q,
> which I didn't get. However, we had another customer also reporting problems
> getting the PPS output to work on our Apalis iMX8QM module, and in this
> case, the change to channel 1 also made it work. This leads me to believe
> that the iMX8X and iMX8Q are behaving the same way in this regard.
>
> We would really appreciate some clarification if we got some of the details
> wrong.

I checked some documents. channel0 route to internal eDMA as dma-request.
If some boards use it as AVB/MCR. it should be set to 0. If need route
out chip, it should use channel 1 as pps.

So I prefer put it into board level files for difference user case.

Frank

>
> Rafael
>

