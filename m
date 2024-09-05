Return-Path: <linux-kernel+bounces-317859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D0D96E49F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 23:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 899DE1F22BDA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 21:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311201A7274;
	Thu,  5 Sep 2024 21:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="drLlJxF1"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013026.outbound.protection.outlook.com [52.101.67.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2F0165F0E;
	Thu,  5 Sep 2024 21:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725570436; cv=fail; b=Xdu/nPhSdEy0eaaGMSjoAG8bJ96d6wF5DwURB2QRrfrQmUTNjrq3tnszDuH3LfIW3cUaR7JMC5boxmm7STsFP+izX3dzHprYAxGpiYZPJTPEJZ0NzJiO1vOBP/M/LV7xJeN4Er81sLTRSjNHQcbbmC6gkDwPsYxuN6VIMSLh0H4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725570436; c=relaxed/simple;
	bh=V89ZrhfAB/qTFem5LamoMaP8Rs4D8E1kbXWLNgBdRTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NSsL+6c/JzMObgY38Rcvhuj/oQaSm7K7u6YQ4s73GzCWUupntHP2p9DO4e5nM3KTmb4ZJ853PYOenVEfTX4WEqsKILflT7sTsSuwyRwXw36KnJf5PxPNXlGx6zLmg3PTaJ+FZZhOgv0x4tX4wsbt3uK18eNVoEX1ZaSM6RvoQQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=drLlJxF1; arc=fail smtp.client-ip=52.101.67.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cqNB23516/GmLNTmqhfLdAhekqdf2XiyUMeWr2hBhIljlCkWlEjRNa/0mbHNUanz2fT9SyjQuN3AP7dN9WLWjCB9+r0xgnH92UM8jTUQjMG0BLsYo7AExqCcQZwZNRFrUmFLOoNRjkWXvX7Jkl+Rn32LlTMLNdaJD24LaDmYI5jC2KDSGakiRZFa2wT35CfTCa90zRxezlheXmI3aINK7nRP2ARnZaeFAc4BOMMdwUN2BYmB0QlErXx4mBkawq+xlS5rXEKmWWJ5Q0dCcDtlHtjUlnBNjuRbmQadbQ8/hKFSpAvPOqe/NQCylIon47244aY5T8Az8r4iJWA154RjFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jdb0LXbeG531TKmRCeMMN9FzKlJNzj2IIvhAWacmas=;
 b=kmiu6/aZMuk+Xuj+0u1MvXRAxBafKFWTIgg4QjG4EvnOkTMTRN6nZb7nUoK2I6anE2py6h+GQSeHJOQNoC/d9aQWgqsehJj4RSCyzIw1MZIQVdOFY/IDDX/6yI0zbqjxl6EjGVRS0tE2944hDEqdUoLXh2n31fYjciB0wFp1tt795vbj1ZwJeo5reuTdq8K7kPO8oGjB5cWyWzrrXD5B6Cf0vqY7zPbceYuZWpVb81ymckUhbe8UwS42l6WP9NR4t9FsnQHidz66cUnjXJFxm+UZlZKVzLDAMaauiApdUunUTuTOOFdDe9tfOGNo9xrv0WtoE0pERefmnHPxUjWcLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jdb0LXbeG531TKmRCeMMN9FzKlJNzj2IIvhAWacmas=;
 b=drLlJxF1nF46LQswZtAYBgrzPAYJzec/FykUeNtXvw13q7VRk00lYaPQ7RlDcQ6YB4jN+WPXqnl6prynzX/Wwd3iOm4iA2HbxOC6cG8q8KsQv52EZn/g1hLO2hiCpXyRmQs2Hn/IZqz4pfhc3IakXGzzupGvGsq/S5w71o1Fb4eEIx8HhVEBA1hiV570I6D1VhZbl51qEyJAL9Uq1CTiYewtbiE9QSf/WtD1une2Ggzw5Jd/P6IJqJ66chcc0AkdN5Ig2XC07PFTEM18Aheipwn+tjQb6kvRPo8nOJ9T0J1SyPa6ePbqNsgkJmB1uaIJqHu0r7X5NFQFU9xrOAaiqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8832.eurprd04.prod.outlook.com (2603:10a6:102:20f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 21:07:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 21:07:10 +0000
Date: Thu, 5 Sep 2024 17:07:04 -0400
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
	"jun.li@nxp.com" <jun.li@nxp.com>
Subject: Re: [PATCH v4 2/3] usb: dwc3: imx8mp: add 2 software managed quirk
 properties for host mode
Message-ID: <ZtodeJBfEDcluGfx@lizhi-Precision-Tower-5810>
References: <20240905-dwc-mp-v4-0-aedaeacf0556@nxp.com>
 <20240905-dwc-mp-v4-2-aedaeacf0556@nxp.com>
 <20240905205850.jsq25jlws2k75sq4@synopsys.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905205850.jsq25jlws2k75sq4@synopsys.com>
X-ClientProxiedBy: SN7PR04CA0172.namprd04.prod.outlook.com
 (2603:10b6:806:125::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8832:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cc9a31e-7682-46ac-b14d-08dccdeeb521
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vGBL4YJF+MaF5HfkYvevZQje+pZl0aOEQjDexA1p4WW490CyjNRNtFGq8hO7?=
 =?us-ascii?Q?trfhuL28SmnET2U7ddoD9WXrqd1PqxhSb8y73azCAuE0HY8W+yA4DQfQeIaS?=
 =?us-ascii?Q?GG44BWcE+H0Ktmi62WNVDjzF3vi35T/KHDsMuO98Age9wadfuulhurzU+VtT?=
 =?us-ascii?Q?azZ5BXghiel73ga9jYxoH1F8TeWHvqAoTJYN1f0VfJ0jChb/2UOFTloIhAWE?=
 =?us-ascii?Q?athl2Ppkua1QKtBdZm6WUctq5HfeS2TI5pZNtZ9BvII3laNPD7qDz0naApRz?=
 =?us-ascii?Q?mG9aj0KGc5sZiXZzlkVzdyfAF/etdC/jh7XJeLvSbXaZ7oz0HpcvNKgRxG5n?=
 =?us-ascii?Q?bo38XgtTK565/c6LuxCeIAjP1KT0HS86dWmt31rs13UhQNSVie93QJSc/rJi?=
 =?us-ascii?Q?VHIPVSA0egar372meCivXBZssLCajh+ellggNLcdE+Ef1AtettjTn1e0SSLm?=
 =?us-ascii?Q?XCjqD3LbHc6+jNhxtz/1bcndRksb4ho7nnYv1uJtXybc6ZeCWXIRbGYYCdXi?=
 =?us-ascii?Q?q2i8Up1c+CHipYjewTmhngcml3c14iYlO1R3vDy5PKeFQgaJ1975cbe3cohE?=
 =?us-ascii?Q?B2sAAG3rWm9KFWI/bctr26muUhwkCMnqrRdp1ixXbNUuKT8wy4DGqb+IF39i?=
 =?us-ascii?Q?yxpHBiZ7Nh0P1jNU+2iL7A5egDsiwepIVi9xRQLyq357xKGJhSR4w+3DAWzV?=
 =?us-ascii?Q?xsj4VkYAcutHxbMd/IkxaED6ngy9/BgBKicF/ljSLeQTsOUZXLLlZ+JDoX8e?=
 =?us-ascii?Q?UpsxNvdrtbRj3wZow1w2I98CTwTR85mRnSd+qqgKifqPVdcghi4iJbA4dwY5?=
 =?us-ascii?Q?yGy16fCMM7Q/XKhXA+Es0P+SnAp0Hdw2bzKm8OkIyd6jvOyrD9PMNkRGUDQv?=
 =?us-ascii?Q?f+YSTO0Ji0dLU76spvtwPRJx42PBN8NQSgTTMtwJmuM689ucEq9G/H4OXDkf?=
 =?us-ascii?Q?hqQg+s1OsWpMjmo0FWov+7MudcIC8ak19x3V9+ERw8d9yf/yvSIIEk73Ynud?=
 =?us-ascii?Q?EYcNhlzyh4XUa4BksRDME/2a4j5sixROWlQbgd5v7mbumsbVMTe54pxtk8sG?=
 =?us-ascii?Q?h+v6onB4SKjXVLvk75JIuXrFKeQHrslTnn8tuwgSNKA4bwgKaZphVNa5pWYp?=
 =?us-ascii?Q?mDq3Ixg6HLpl/AR33MyvwqSTiYRtgQN4y8ovpUqJvYdZ+JrU8Gb3oNaGhDmf?=
 =?us-ascii?Q?v9VZyNxO9tvPg52cIUOB2mQOpMRf+nzWfaJfnGrGH8/sD3LyfOwX6w9ELhWF?=
 =?us-ascii?Q?nLQxqhbEPCJa1cAxranDYrkU6xiUkPby86TNgJHTNpc41UB2hcf/Bu1PNtBM?=
 =?us-ascii?Q?KRgM5hVoBInrqpn8oeX4Omh1njLQlVWwfBGd25nUDJXv48GFtRlPlY+Bq62U?=
 =?us-ascii?Q?N1sRxD3QiCcrkazGPNb3vZkHg6w8pmLYlSEdXELcZIsvZ+fi/Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Cgh8vglv5AJTTg+2AQhxjOXXjI+X7/1pNigXOQQUXPTP3C3fROQvBe4BD3S5?=
 =?us-ascii?Q?aiGGr+wqI6+4Fa5GFrvkMCFMRVQiGVtePArYtLeGEryMDfwk+QJNh68BAxHV?=
 =?us-ascii?Q?BcpGg8Oma7pvas3PL4eED5hSbK8I7mCbMtFv8oxDTe/E0wK/U2LEMtoNMmWi?=
 =?us-ascii?Q?MNh/82wFqDlfGynnE7ml17cZGkMA5okKeeAt82CZAk8x4KgUN/rk5QV3r1dJ?=
 =?us-ascii?Q?S6exOH06Gyctf/6rOM2oEd3dx1vRyRB7UV05VgckrFKrxVKGeiRyjisz7Vab?=
 =?us-ascii?Q?osMbVrGkMSDwXLDpw9vFYuNIDQclhl6ZDYS6muMSZGS5BfnriOAVbfTBN6FS?=
 =?us-ascii?Q?QZp0hqVYvoGpx69Ax2ColGIuCIncuGjt1/SBHIqgOFVY9jgnFvzkFKmmEyBQ?=
 =?us-ascii?Q?ZG3cUNAut0F3z5DgK1uzfUPx9WHMp4YBTmkXrmvDt5/TX/8kg3olbIeOICJw?=
 =?us-ascii?Q?2Xru8BokV0ht3ob12Lq3Q7lYlk4tkZgyCudBl7drdAzoGYNEWo3WobCksAXg?=
 =?us-ascii?Q?yQEgzp5LbSjM1VRXT7YVXrQ9QpVCY/tqc4vd9t1b78vFMvY1cLWvUenLe1xL?=
 =?us-ascii?Q?fdqVcd0hSQzYHjRoXnFK+kM6xs1cVT1bYQnkKOvQHLKuEpTUbv7UuZV89WjS?=
 =?us-ascii?Q?LPpu/wRBvfhoPyk+xpHoIkHPaU8qPc1kOTemWPmKAqNECsgy5ciVLl/Srsl0?=
 =?us-ascii?Q?0Mz3Z1kAQBOz8BPRJkSFO7mwY5rqABbQPbytF4qu/HwYxqEvUW3GxSAY8g9E?=
 =?us-ascii?Q?U4H0/v13ythSMokjBZW/goVQGzCR0X912llZ8tiXyxM0xlYzVPA+T0SnSHy6?=
 =?us-ascii?Q?eekUcddxaSpoeyqLkx3vvzvaJ1dhIAmYNSr4Xm+aVeBEst+phSTnDOezR7Ys?=
 =?us-ascii?Q?yGo+g3w+HvDLdw1oyX1XZkKhpVRfFcU4x8gPU/19nTuJGVIsd3squc9unFjL?=
 =?us-ascii?Q?dIvl7G7BSiBSbYI2FnVyiq0xs+q8fOdk+cLYoj9sAmTwJ6k4N8rlMBX6dgca?=
 =?us-ascii?Q?lEFd8wF/X9MdKsEUnVeO9hyKXZLffjBny4azoULHohgrhMDpKK+AndFmpEX5?=
 =?us-ascii?Q?shTovX8WL2bpNSZym7RO0z5O5Dwz4YVKGKfgshu/8nS1CXbqkIwlrXDcAGu6?=
 =?us-ascii?Q?d7CWd3jrPNcbIlSirM1mza0tOVSHbNhtJfawzWAMonyyNS4AecQA1ayjBhwK?=
 =?us-ascii?Q?4YT7SmvU9JIngVAgCA1dnJSMQSk+9dUPHGLvBHYIke1qsbClKC6xotou2N/G?=
 =?us-ascii?Q?/LII4zH5pfBMBnq67qpwCj2475SF2pOZDAXMNGzljhqqplF9ChbW61WtrnGP?=
 =?us-ascii?Q?dm7QGQr6CerMvLd6tUEgNmHflfG5INZhx5jxAUJDGcxHqFPexWpXIEWNr4nD?=
 =?us-ascii?Q?5SudM3vY3h8n4FYwoipZD5OvJFAS0IME+gN2HxS8SY4e6PB589reFtfZnNuO?=
 =?us-ascii?Q?8gdJ6N+S3U34zb7BJ81p3m+K+KXRvCyvBPP7wGYtkQlaOe8BQ+gAbJG+6xRK?=
 =?us-ascii?Q?aizEtGrtyAmFeF4Ycu4aYIZxom09a7TE5ir9dbz34oBxWvnupGfeH8lbZWZz?=
 =?us-ascii?Q?2tIJCMCwOKBiZ2Y3gRDW/sgh8O0iJwmDz85TgKbd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc9a31e-7682-46ac-b14d-08dccdeeb521
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 21:07:10.6225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WOp6cFmcCkI4hBs9YGmNc9PDnnxlEtoNsdDquDFPNn5Nr4CEIGtisyH7bt3VblP+fWCIBZcE2+KT+CGDNbv+hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8832

On Thu, Sep 05, 2024 at 08:58:55PM +0000, Thinh Nguyen wrote:
> On Thu, Sep 05, 2024, Frank Li wrote:
> > Add 2 software manage quirk properties (xhci-missing-cas-quirk and
> > xhci-skip-phy-init-quirk) for xhci host.
> >
> > dwc3 driver have PHY management to cover both device and host mode, so add
> > xhci-skip-phy-init-quirk to skip PHY management from HCD core.
> >
> > Cold Attach Status (CAS) bit can't be set at i.MX8MP after resume from
> > suspend state. So set xhci-missing-cas-quirk.
> >
> > Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
>
> You're missing changes from v3 to v4
>
> > Change from v2 to v3
> > - rework commit message to descript why need set quirk.
> >
> > Change from v1 to v2
> > - use {0}
> > ---
> >  drivers/usb/dwc3/dwc3-imx8mp.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/drivers/usb/dwc3/dwc3-imx8mp.c b/drivers/usb/dwc3/dwc3-imx8mp.c
> > index 8b88649b569fe..f62f6f960e501 100644
> > --- a/drivers/usb/dwc3/dwc3-imx8mp.c
> > +++ b/drivers/usb/dwc3/dwc3-imx8mp.c
> > @@ -145,6 +145,17 @@ static irqreturn_t dwc3_imx8mp_interrupt(int irq, void *_dwc3_imx)
> >  	return IRQ_HANDLED;
> >  }
> >
> > +static int dwc3_imx8mp_set_software_node(struct device *dev)
> > +{
> > +	struct property_entry props[3] = { 0 };
> > +	int prop_idx = 0;
> > +
> > +	props[prop_idx++] = PROPERTY_ENTRY_BOOL("xhci-missing-cas-quirk");
> > +	props[prop_idx++] = PROPERTY_ENTRY_BOOL("xhci-skip-phy-init-quirk");
> > +
> > +	return device_create_managed_software_node(dev, props, NULL);
> > +}
> > +
> >  static int dwc3_imx8mp_probe(struct platform_device *pdev)
> >  {
> >  	struct device		*dev = &pdev->dev;
> > @@ -207,6 +218,20 @@ static int dwc3_imx8mp_probe(struct platform_device *pdev)
> >  	if (err < 0)
> >  		goto disable_rpm;
> >
> > +	dwc3_np = of_get_compatible_child(node, "snps,dwc3");
> > +	if (!dwc3_np) {
> > +		err = -ENODEV;
> > +		dev_err(dev, "failed to find dwc3 core child\n");
> > +		goto disable_rpm;
> > +	}
>
> This looks very different than the previous version. Did you review the
> change before rebase? We should already do of_get_compatible_child() a
> few lines above.

Sorry, mass up at rebase

Frank

>
> > +
> > +	err = dwc3_imx8mp_set_software_node(dev);
> > +	if (err) {
> > +		err = -ENODEV;
> > +		dev_err(dev, "failed to create software node\n");
> > +		goto disable_rpm;
> > +	}
> > +
> >  	err = of_platform_populate(node, NULL, NULL, dev);
> >  	if (err) {
> >  		dev_err(&pdev->dev, "failed to create dwc3 core\n");
> >
> > --
> > 2.34.1
> >
>
> Please remove the Acked-by for now.
>
> Thanks,
> Thinh

