Return-Path: <linux-kernel+bounces-281231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B52C94D4A7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E2EE28140F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A951991B3;
	Fri,  9 Aug 2024 16:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Kx1j9pCF"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2068.outbound.protection.outlook.com [40.107.241.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D1F195F3A;
	Fri,  9 Aug 2024 16:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723220735; cv=fail; b=bTLFTE8UzexmlNCwEuUElDVjpbcQWbZzp2iqvXDscamrIWb4ygRnqKfRDL+JBQnnkDfYso66T3iQJwX1uN3SxqbhlXqo9M4gxNOgF2njxWOBbISBBlfTlUKIKqDvftcbI8fYBmo16AHj04N0PzQ+J4tndGeH/Kv7UpT6vt5i5AQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723220735; c=relaxed/simple;
	bh=XWIyEbpvjeBj2BRDA0rh9eSqegJ5w7RoshhoBxdXmiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Uphu7wxFmnCKhSzZQ0/VWyJ/clQXOWUcYNNwh061nxQThAbW1enQ2h8MOh/wgi3a+63SDZiAde6u902cpSrfo4psYL7wgq5l+dXQVsLUjjCHB2gjkIXSkSMCjad3JPBkJrAKSkLTE6hkW8OrPs79sUJWa5Koi1orWBQudgDeD4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Kx1j9pCF; arc=fail smtp.client-ip=40.107.241.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZZKlE1fErFKK/NoF/FuLpI6/WYAYsdsQ9DtP1//hZE81YD+yyNB11Jp1XvSWvkZ4zF5TGoMdEv4KaaAVod7BU2MQPYztUO+FskuU/CJUKB2uB4RU7lLEZ5TwCTiECbZW0ERS8SAdcnd6MZzqRBPDNdcVvznEHBVofdGYJ2t3gAVAoORgWOvGSfF0ATGy3K8djA/KzTMpvWaGVZ9XFjEsIebSn+up9VTiULxp56Tpd3KGWBOIzJC2+DSJYFCkJFdod6ttTOEoUfT9bdu0vEO37ttRIV+NEQ7EOG4ktZAdI4lPbaLGBuXfbiiWEZTOkV3O7KYRyBAcYg/4+kr6T1wIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpO6EDnjUFYm80Avh3mlClu397uY4sizVXsPqM/nKUs=;
 b=YsHbDkaZ4IZOh/OnD6NN6hty8LKTRRM2PvZywvvtNbVKLqjeDYe15Sg1DxOOgarKJLOZlNVAb9nv1imLCyLcQ3RgKUetuTRnqTjcx4KIeII68WEvpUaaxAxXBu5oSncf+89hN5UcJm4UUc2CHU1hVCcpvCyB7vBq3Rcm4SRYYeBPY5TfImGPkrS6LeVntXJNN3RP2JJTont+vA1Ba2AML0AsvijlFrQcazQpcoMDNSizNvHYFaX3HcwL4kGF4c2N8OhOlUQx/l0P86ysoAqCwHF1xjvrcaWZ43DZ7uV11xfBXBbUaGSD6Lxfgp/Dj6ycRcxipLlU+Pqe19Hbe06RWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpO6EDnjUFYm80Avh3mlClu397uY4sizVXsPqM/nKUs=;
 b=Kx1j9pCFeu66JuZsIzycF92VA9+9zATOIR3TZkayKMiDZw33buqzkDY2u9z9BTUIjuzgPuDd2rNkvE4Q7QyBATFbDxshH8v+iTCbeHoaCDT1vh+7gyms6HIUUN4fCtoZbwyQqAn6DxAjb2NHOATOGiyFmjXQ9ha0JGP7tfkHwmz2/6Ke0vOn0sU8JHtgHXtrdncyDLSlIdmNU7Hl/m4SSwxUqlwf7iTo1idgE56LTgEu/h9VuWTDlu/hClVVXo+lKH5y2r+veSJRaljlHjJwVzoA09aOSGa7QjeIZuyKmlrl4Xlf/YEv46C0ndNEm9QTlyohr8WJukmPrL/hnJO+sQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB7699.eurprd04.prod.outlook.com (2603:10a6:20b:284::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Fri, 9 Aug
 2024 16:25:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 16:25:29 +0000
Date: Fri, 9 Aug 2024 12:25:20 -0400
From: Frank Li <Frank.li@nxp.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"jun.li@nxp.com" <jun.li@nxp.com>, Peter Chen <peter.chen@nxp.com>
Subject: Re: [PATCH 3/4] usb: dwc3: core: add a core init flag for device
 mode resume
Message-ID: <ZrZC8AFtmR3Zn1c9@lizhi-Precision-Tower-5810>
References: <20240712-dwc-mp-v1-0-295e5c4e3ec9@nxp.com>
 <20240712-dwc-mp-v1-3-295e5c4e3ec9@nxp.com>
 <20240807011347.ucxlxmcikizreioj@synopsys.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807011347.ucxlxmcikizreioj@synopsys.com>
X-ClientProxiedBy: SJ0P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB7699:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b0497b6-f98d-4e76-f687-08dcb88fe22e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fDt2BKcleADzDGA/P27Sq/rbqar1l7mMvYdwrrRCoa3f53GZraxveDS/xYRe?=
 =?us-ascii?Q?kOqM3JSEeiFm7P3s/UAKonzxCRkYI8YXP9erLb313Q0HG8Rvrt57AgOt2D4i?=
 =?us-ascii?Q?HJ/oevBmTs7bqK4DjzziETaWsO+7Y1AOrdQWAMF+ew+n4PBJBxfl6VT3tWr5?=
 =?us-ascii?Q?5wNCxNYHIXaLfBycGrnk5lLMBBdG6BptdyvMI75sxQ9UNvcNiqsNhPlgIn8V?=
 =?us-ascii?Q?PZbOjr/b7i8JCX3TUPRwCJMmp/jYYtNNH3Ktks4ikhiUv6Y2+wloQl9tNFVk?=
 =?us-ascii?Q?WaJtaEHte8KG0gmAT4Ji7FqJ6FzObycqaEchY06AMp0T6ecljmp73K+FSPrx?=
 =?us-ascii?Q?m3qyZsXNvA1Zt6WgL87pbDF0iK3F+C+tEXEq9E5Vjb1/yt9ofT0ucJV4+p+m?=
 =?us-ascii?Q?YQ2NHRzrVGFEu9fXBJA4Qjds6QfHsbq36XlvrKP6RmhH25knlM03SAn+KKP6?=
 =?us-ascii?Q?63maSvcNUnfh/ch0FjNSwncaXPCd4UzhxAkbwYRpFlMJHDBt9GnizCRpDwKt?=
 =?us-ascii?Q?8KpnsObwIHScrX/uMxhX81IbvwxjhUk7EHSls2AUTEA3ZzGuzvlnwm5JWL3D?=
 =?us-ascii?Q?XC3A/WRsEOrQ0XeK3AQwZoJN0wPvTbohCDvgCU0CjYz4nUWPzE9CClg8FIYc?=
 =?us-ascii?Q?qCwjl2LiTMEOoSMxeDk1poabxrYBkCNtbuOpjFBYkNGPIrTxxzc7IE0xfxa7?=
 =?us-ascii?Q?q+MeGRtzicaaBMAs1SGR3XXC3KjjcuBGpIrK8TDZGQMT/3laWgqJFROmaSE0?=
 =?us-ascii?Q?kNw8ogzBOVHlQh5qfzx6RKcjQ2l9mQba1rbnZejt0JNiP42xnj8THkX+m+Dt?=
 =?us-ascii?Q?13/JJf2//K3MGClFHAWLE8ZCdeHaMLf4vHZxNLsgUIAA9n0VAuQHBdG3WQyz?=
 =?us-ascii?Q?iGFwptP+i0rp5uqQ3glGpANadb8wEBdZLoA5ja/ZBe+WvoLVr5hvBHAJgpOe?=
 =?us-ascii?Q?7KyOIsgq5BaocI1CItLoTMszNFxZncA2zBK47Vg8tQrVziGx2jbtrR04niYt?=
 =?us-ascii?Q?EWTGd+CO7KO8nyvgTDW0HgJGSkAdyGBPDt/LIglxPWbJuXsJABHDtOzFfPI7?=
 =?us-ascii?Q?elfbfkEP/aIVqJcaO1CuWfCF59xIq09k1UnfpApB/0QPV67+F4YSvEmsE7xt?=
 =?us-ascii?Q?Zs3lVNVb4dPXpeAkzAVdZ1mmm1EPWiQOjCSxuZiT0yU4KjGXcoU/h3zYcM5f?=
 =?us-ascii?Q?vcLw/UcwBpEfsdj01QWesWtID/Yh142Ii5089KCZ+DlY4ww/6FGRrHg1GcN/?=
 =?us-ascii?Q?39LQVzugPVkcJe0BThCDyNbbNISF5CoPU5I8iBDxRFZxe8e6Is6kR0rmqk53?=
 =?us-ascii?Q?0k0bpgh3CAcGWrwpLOTL3riFSz0hBkvzn3/wrdygQKElBKNqNh+FxSX/N+eS?=
 =?us-ascii?Q?12G1hd4hIzCQbYICg7lvCTKxIOEk7gHhDqdYKgSWSzBJys5jcQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6LZZmFj4ZWEp5EPGxpnttvf9sGvl3SS0IKeRjUEoh4axumBojspeb3IVcn8u?=
 =?us-ascii?Q?NqNik883JFpHKrtMyiL9i+qn9lqTOrIZGcBlk6bjY4kBzVGsXoeNRknQhOM8?=
 =?us-ascii?Q?JWT9ja1x4iHbNi1zvLlUk7Iyx6lg84gPKK02GIE2BuRnI1SW1rROMmOHW9v8?=
 =?us-ascii?Q?I/8p4R778OiT7gnPPsfcvVoyuD9zIURCv+IEnsWKGBOejRqc7W2j+fAcDMwk?=
 =?us-ascii?Q?iZ20YAeUkhbB9xAUpVsJ7Jgm4sDfFPdv0iprNABCI+ZS5am4SDKVxFhKiq2i?=
 =?us-ascii?Q?hPXYhOYDWHHXm+qx0y44Y9LKoQFRmgzRM9rwQRCtXIODKKgjDx0n6+VBemOJ?=
 =?us-ascii?Q?Zw6sdA0LEyg02xHHtwVMtF1pePT8XtNArbB8zYcCK8cjktBez3o6dX5XuK9E?=
 =?us-ascii?Q?kZmNPF/I2UeB5COonPDZbqsBoYXLXZRN/qpKxhQe/ikJEJWFU45JYt0InyMl?=
 =?us-ascii?Q?Mi7l3gZkBdS4q5OnMF9G799moCnYE/Yhtizz1C/+qzSqliXjR8Imr8ky3FHj?=
 =?us-ascii?Q?osuMA2btaUV9k/Q5csvg1qYVg/Z3NK9JvdT1cvI7UR3BTfZNj+/wzmPrchCO?=
 =?us-ascii?Q?hTbYpvKV7oL+Q9n3z6kOGjPoTxAtmEhXjIaDLoMdJOFbiwBzHExVLJ+qx0nY?=
 =?us-ascii?Q?EObKt36Wh6EJmuzGopMyTB+FdIp2sTID0xYkX9sTFH54ILl9U/tEqWN1r7/f?=
 =?us-ascii?Q?jJ1/bf6gX6qk3OvCZTdceveOTPt5eAFjp03+GEtKbPOYDRxhS09ZcSMy4L+n?=
 =?us-ascii?Q?TKfF9M7AhLrI9d3F9fVKM4LdovMmfDerh1Rg7fzCL+wXcP2yeMhkHfZxyqXm?=
 =?us-ascii?Q?qWzkG+YapZx3obqCzzMYDEyuSFq+ACPfI3I1LvnLHm8yIR3mieutO5GwBvoa?=
 =?us-ascii?Q?4PNMbXqq2T78N8JKSXqCiGcD14Y9KEthCdipfoeHMXjQ1oKBj3zP1oHzs2gk?=
 =?us-ascii?Q?pgMAIrGyh+FudhvAmjubQmEJfq4wuVcXxgOk8+zdHOBbM3lIJo8BOR/WwqkT?=
 =?us-ascii?Q?IzGcVt6s16C1vEvfN5kUF0URlUkhQsi8WTvP07VKcrgPGRL8CPbzairWEBXx?=
 =?us-ascii?Q?4PLwH+2dGz5E6qqwcXxIQyuNyMjk39GL29xYtagzNKiC5Jxmzg2YtpZ/EPE0?=
 =?us-ascii?Q?cmNDv9Pk9BhgNhHEYIZRdqFkSJe0mP0dQJw2owPOpAapRYzzdXjcPEIcgN+G?=
 =?us-ascii?Q?YEzRqEX4hwhuLf0Q9SpiEuPJxwF3VzYo7eufT+pcxdu5UXXCFrAjdM40oFSS?=
 =?us-ascii?Q?+WEvRdZ4lfocwwUpGb9ot1TxOWu/t9ZCvG86FCTg6ywMlKMUE/Z5+8nJ4ZND?=
 =?us-ascii?Q?yTM5gBUVAMMhuXUcow1zdyx/Hm6E8XXWu4eZaj2aND7Y55LQu701lkuogSVq?=
 =?us-ascii?Q?z9sRjdviMbkY2ECi2pp3LdiPJS/D/DF8QzaxBhtE/tKz/R+tXKzVGHYhx8UM?=
 =?us-ascii?Q?NgMgvNg61stIuLHzB+jLv9DlXgHQ/voFro0aZxR/fcSFxL9mk1rMAgbTYflY?=
 =?us-ascii?Q?H8D3jsfxb+jUgU6Z1MkFA/8fjFpzFZ/zGjUmayXiKqTMscKxYArbf3Q+ktY8?=
 =?us-ascii?Q?/Lgx++k0UfrcMLXhS3Taw2vdS0Gxqov9relNknS0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0497b6-f98d-4e76-f687-08dcb88fe22e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 16:25:29.5381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: azURiMoMV+FNsPca4LbQDNGHkPtlNlcTEZwjcXWZdL+viE4cRDLjhM9Y02PxWhM+qQuMyS/zEOZZfemOKMd3Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7699

On Wed, Aug 07, 2024 at 01:13:52AM +0000, Thinh Nguyen wrote:
> On Fri, Jul 12, 2024, Frank Li wrote:
> > From: Li Jun <jun.li@nxp.com>
> >
> > The runtime resume will happen before system resume if system wakeup by
> > device mode wakeup event(e.g, VBUS). Add a flag to avoid init twice.
>
> What's the consequence of going through the resuming sequence twice?
> Will this cause any functional issue?

static int dwc3_core_init_for_resume(struct dwc3 *dwc)
{

	...
        ret = dwc3_clk_enable(dwc);
        if (ret)
                goto assert_reset;

	...
}

clk will be enabled twice, the reference count in clk will be wrong because
clk_disable() only once at suspend.

So clk will be always ON at next suspend.

Frank Li

>
> Thanks,
> Thinh
>
> >
> > Reviewed-by: Peter Chen <peter.chen@nxp.com>
> > Signed-off-by: Li Jun <jun.li@nxp.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/usb/dwc3/core.c | 13 +++++++++++++
> >  drivers/usb/dwc3/core.h |  1 +
> >  2 files changed, 14 insertions(+)
> >
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index 734de2a8bd212..d60917fad8c52 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -950,6 +950,8 @@ static void dwc3_core_exit(struct dwc3 *dwc)
> >  	dwc3_phy_exit(dwc);
> >  	dwc3_clk_disable(dwc);
> >  	reset_control_assert(dwc->reset);
> > +
> > +	dwc->core_inited = false;
> >  }
> >
> >  static bool dwc3_core_is_valid(struct dwc3 *dwc)
> > @@ -1446,6 +1448,8 @@ static int dwc3_core_init(struct dwc3 *dwc)
> >  		dwc3_writel(dwc->regs, DWC3_LLUCTL, reg);
> >  	}
> >
> > +	dwc->core_inited = true;
> > +
> >  	return 0;
> >
> >  err_power_off_phy:
> > @@ -2375,6 +2379,15 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
> >
> >  	switch (dwc->current_dr_role) {
> >  	case DWC3_GCTL_PRTCAP_DEVICE:
> > +		/*
> > +		 * system resume may come after runtime resume
> > +		 * e.g. rpm suspend -> pm suspend -> wakeup
> > +		 * -> rpm resume -> system resume, so if already
> > +		 *  runtime resumed, system resume should skip it.
> > +		 */
> > +		if (dwc->core_inited)
> > +			break;
> > +
> >  		ret = dwc3_core_init_for_resume(dwc);
> >  		if (ret)
> >  			return ret;
> > diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> > index 1e561fd8b86e2..8a4bfd9a25b19 100644
> > --- a/drivers/usb/dwc3/core.h
> > +++ b/drivers/usb/dwc3/core.h
> > @@ -1195,6 +1195,7 @@ struct dwc3 {
> >  	struct clk		*utmi_clk;
> >  	struct clk		*pipe_clk;
> >
> > +	bool			core_inited;
> >  	struct reset_control	*reset;
> >
> >  	struct usb_phy		*usb2_phy;
> >
> > --
> > 2.34.1
> >

