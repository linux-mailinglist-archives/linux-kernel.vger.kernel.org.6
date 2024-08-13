Return-Path: <linux-kernel+bounces-285222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD41950AD9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35024280E0B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0D61A2567;
	Tue, 13 Aug 2024 16:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E5n+EdQ7"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2054.outbound.protection.outlook.com [40.107.21.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5C955892;
	Tue, 13 Aug 2024 16:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723568245; cv=fail; b=hhVR65ezwDKxi8nt9cYC2PKEngfuUflAyvrE8slpNYXJI3mN5LMrMQW4W9zZvzZ1c7diqt7TinncevYWbSjzxbM6b8T72lsr/10tIrkszLlea3cXx0APqLTN0wLazqw6kDKaI/STiS7MlpItTVBMkGI0j5inuYGD18wKGOKvWHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723568245; c=relaxed/simple;
	bh=KxW7Na5P4OEjhYlGdx3SkWjOuVipVGbyNM2Dj8lLcCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jElD+Hyxhh23mM4D0n11/i94bU8/7HsnzO+OkHwFdVrhvJSOVti84Hage2fXUWMoxUW7cT1vk1u6ZA2xwMmY/7GteUX3Yo/CyF0PGm82JdIl60+IU+ugEzUhgg8XYAt46e3AiEBWxYCoaAPVHhCnEBo2I0S1+tgaVFqTS1bLEB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E5n+EdQ7; arc=fail smtp.client-ip=40.107.21.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J89fRP2QQrHM02DGgyZpbsVPODo0PGyklSDYhCXg9LVHTeAd5/Vqby80m4xQYa4xvE8qy4kM7jbj/PZfOx4xVZzMbgERcZCj+VyzdAABO/r15+SgQ30zdobBcXWHRHIye/olMynZC2fQF0PfzhmUN80cI5B4t1ElZfi6Nt5MsPAFaSAzy2I7i9748CMErlafrZ7kJD9zyVQg12/RUybFjT0zd3M2avlxvSrFWWUNaUSsoZxdjyBHt0TIMAvKgIA5NeF1F5u80F9c+qF5qBybA9hFoIVgHxwsMVXpkLpB7z89NEFRakyKFUiQA/B7cscb4ihPSvsVZfYipB4J2esaKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0TPo/D0vDO42eZJLlH8uD46KCeaQQL1p66ZoH+/Z+c=;
 b=S7QSrN3hm3acc6LKbEpFT5JAUH0A2euepkuC69fFY902ZryV6qhWNNejY4RJK6tCP74V9dVlujYR+ClYVmSSeY3H681iog31mlXiTlmcFQ1lmxg+szy/WRqUOx3Orqv6kJEN9G4g4kPfCorw1DbqISikpQvNy7yEao/6BbRdPTMNL6SYttNtfPNQDZB8udEPGUpAK4Fg8fv1LIEYtm6j+qjKc1siMfu8XrORzeF/w+4HdMR5HZ2BbMAROsk9CobUL2JZUmVqGW1qpXfTCIGWG9B0PJ8ZvvxED7iBbq12VszGeDZFD/OK3dypPDf658ZAntjRSbjUB1KY544fiXKfBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0TPo/D0vDO42eZJLlH8uD46KCeaQQL1p66ZoH+/Z+c=;
 b=E5n+EdQ7J8IScLrrP40vpAwYyyjnBZaMagsNYRRViMBZiowTpnFIXoO1ehDxEAs6bAUM7YJow5NAbCLTiEAgWtiOl/nK89OjVBogQyaI9hg1k0TQZp05Sy68WIkHdXjesJOvwl49cEhTlVyNQGYnOqZJH9fn2/LXj0zMoIchqphb3ptN+aBYSpZZrw4kan/U9aSadhiwcjRCf+KBqf11Z4XC6ZKZd0u1dHX0neRyne+c0E2jyKktbKcit8HEIOfWNSkbnQKL3XMn5Iu108cXhkRzaLKf+VO06lUB9U78ETIs70KwdrA4b9NhjXaJyymdfOS0VoqL8+aFM3Vx5ceIZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB8060.eurprd04.prod.outlook.com (2603:10a6:10:1e6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 16:57:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 16:57:19 +0000
Date: Tue, 13 Aug 2024 12:57:11 -0400
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
Message-ID: <ZruQZ/Y/aqIcO0tq@lizhi-Precision-Tower-5810>
References: <20240712-dwc-mp-v1-0-295e5c4e3ec9@nxp.com>
 <20240712-dwc-mp-v1-3-295e5c4e3ec9@nxp.com>
 <20240807011347.ucxlxmcikizreioj@synopsys.com>
 <ZrZC8AFtmR3Zn1c9@lizhi-Precision-Tower-5810>
 <20240809231844.okzwndlds3zh75rh@synopsys.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809231844.okzwndlds3zh75rh@synopsys.com>
X-ClientProxiedBy: SJ0PR03CA0358.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB8060:EE_
X-MS-Office365-Filtering-Correlation-Id: 066273ac-bebb-4d34-0433-08dcbbb8fe2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b24a3/rQidMqXNSr8oow7ZhHwu/2meZvSn76LHzSmcwwKz7/qqPx8oh1Wb1o?=
 =?us-ascii?Q?7DifEnGQIqMQgaKdA5fOsG6u0qtC8zSXr0zIeFBLQ8vT9EC+sh96LJwNwXD7?=
 =?us-ascii?Q?dUPQddHn7j88rvoLfu1y2oRZ3n5kKd7nnIixcIZg/i7kVKZOIRT6WWaQPTjB?=
 =?us-ascii?Q?oGxLzrWi8D3mr3wGgoaOih4duE0biRed78KPg7zqV28X257uh2mWLZ+Amkwa?=
 =?us-ascii?Q?waj3V7UsBg28e6k+iyQ+rDR5sohMLenadNVNbIJeG+T3ePqqDUnqJSXoQ1J0?=
 =?us-ascii?Q?nS/OaTQkYe1bDftVfKMWOOlA8u658yiwml7TaTRcYtPWTubxmT1CuHSgCY0E?=
 =?us-ascii?Q?qR59WhP1gbzbkMKJ6hVyzQ0HWqNC7A9oExKbaI3HWkQt1AU3ip7Kk7f7bydT?=
 =?us-ascii?Q?9h9NvyIXr9b1Kxi/q/N1cvYp9gpzGvDtUlEMrjZdKm8np2LaO1k1jFlWGs+3?=
 =?us-ascii?Q?JD8wWKmbaABv6fl12Y5rdqbtpyJUzIJOSALK4EjIlZigVxpTDYe1hrvg9qnE?=
 =?us-ascii?Q?Acyu3U0MBSbxcrlB8z43qX/Z1hLCTvMJ0vltZJ6+LoqmOSeWCQzvw0p6VkYB?=
 =?us-ascii?Q?8+GqHf27jF9AonUQ5Ue/7QAz2/5OBJLOqR4u8rjzuhOb4718DVeYBDw9NLIV?=
 =?us-ascii?Q?7PWGBR0klDA0BG2bZO7/CvYwFWvLbv8OMEDIQsletKx1qb+zIdCnOh3/adoR?=
 =?us-ascii?Q?5fXI/ITo2HVWQmJzha8/l1wa264UUNroSgqSvu7jGApJCHgEZdLR6cpZZryd?=
 =?us-ascii?Q?7Xjc5MfA4XfzSU1Yv/GP6DvOiQox3wNKh1lgxMvc2iRtTpMki7VaIiMyMuZt?=
 =?us-ascii?Q?RHYHFfNrEPYN439NiqzMRPxi/Ok3UmE3aBdZYT+mcSZPHfdS+4IJVHSg45qI?=
 =?us-ascii?Q?BffmkY96oFGi8MzkwXrBw4baHBuFuvtu60uClWV1d2b6TIkPcDAxjS/zujDk?=
 =?us-ascii?Q?teyMHRa0yZOibqnCmFbqBRd819NGmX7dctgi9Zl5nyXNwKh/Ue641wANklhr?=
 =?us-ascii?Q?kp6G8jKSzYh+LwCja/iWRVrdhe0YdZZWSm+stwleyrXD1/3+e9o4ZZ7eZTSm?=
 =?us-ascii?Q?xmi1tNjsayPSOOuAbpm1mhqxnYFQ+948090SPjU0O2HI+L4/rthz+AEqL0ly?=
 =?us-ascii?Q?XXreqldWXa1X426MP9Xa+K8xxSqnqkK+jNrgyEcM2/VObpd0Y1M+dwQb/cRz?=
 =?us-ascii?Q?eNhU5FoixLerxmNVa3iCljukFvXoDeNAytueLFcB/E9q1R99ohiup8EEQqis?=
 =?us-ascii?Q?Y6BxI8zp6BgP4VLJ6ARzL/T1jbQB3czayOBrHPlfUO52BBasc+Pr9GTEnPoi?=
 =?us-ascii?Q?T1oMCEZ2kE8lzUilcksl2jQjoitbmO6Jgak1QZMrarlOav+tYBqROkQJXX+t?=
 =?us-ascii?Q?CnIIw0OD5xYvVPnag5erJ0jwWl/Q6K9sjIKs/B79uLD2VzMkFw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z/ejW7z+vF8KhGLHGynhpt+P2gczWDGQkoPOeyFaZSjpd2akGRYg+4CtNrOC?=
 =?us-ascii?Q?Vq7Td7FnCCinHH1nEJzZWPOxHxZ86Oiwrkh5ZRBIspqx4DRz6C+OdLZx2AXy?=
 =?us-ascii?Q?tcoqI4OpXybs9/b9+ggbddr7MZm3hSYFK68rymDyAVwK5HrvweslVOROKIoU?=
 =?us-ascii?Q?6DjnE4wmaePHjA/H6EyHl9cCwXTF4uurhQ8XR8xh/5hYQkcHDYhqRF3r96yU?=
 =?us-ascii?Q?ZKt6O6ejIUrq2urm/kLuZ4S3k0hWCRFaOwAlASI9bYsnJauVl61ZJEE6WE1D?=
 =?us-ascii?Q?Mi4uZpsKwb3weU3gcynbVRKS0Abr/nUpgrJs927fr2IzpFaevN+rQGbu2t8+?=
 =?us-ascii?Q?Vcb7Ypu6q8CzAZ05rjd9NxuddW4SwUyu16rC9Fbc22UykIsQldExmZQC3EXm?=
 =?us-ascii?Q?jMhNJHQ4DSGq2kAWRzOhV8/G1TBLyC/WcNE82xhLMQZG4VHpXIScSER7PjP2?=
 =?us-ascii?Q?K3p9+h8gaZzA/oF+TwfS4MqIhz1XyRfH9Xb0GtMuAHVt66c3jWoibfAjUECF?=
 =?us-ascii?Q?tvRbrAqZt7QWtCqGsbK4IXr7ddDgQLmixN8bMq2J5zVJfV82hbjHtnQFM+PN?=
 =?us-ascii?Q?FoDFjmWy+4hSmZtgri9eo9UmSnioZrGaBQMgdPjBFxTkCUVrN7nJWjHuPMzi?=
 =?us-ascii?Q?x9L0m1m1vNN1t+coyB3wjboxoZKMEJJh8hwaaGe/qsiScCLZ81LXZtW0fuUZ?=
 =?us-ascii?Q?D6bqURwIT7n0eWp6Q4PosfNlhfuik1GeHllkb63syDo0nXNJe0PUJ4KJkCkS?=
 =?us-ascii?Q?3ryrcJpi/0/zObvGetPAaAJYBZks8t7imOHG5w9/2cCuRF2yLXBSZYzqRzNw?=
 =?us-ascii?Q?UZGeLMMZ60Nn0+Sc3IHyZXkarNbUEXpdcw1F//bh0xDkxDEmDOvzkBIDWVUl?=
 =?us-ascii?Q?eCBm478nWClHgPgPwCP+Q5WVadPb5J9K4+xjCh9k+JZJcIf1efoTHLZX8VCG?=
 =?us-ascii?Q?rZn4kXL7O0eGOqx+JygnYmdw/5D0yg2np2TOPNqnqu8IFQzvEiTxJwVbYa17?=
 =?us-ascii?Q?eTsZURxaOb9jX5KylbATDTkWW+kjHSXV9GbliZ5w7glea9hM1CYPbVL2fRaT?=
 =?us-ascii?Q?T82B+hvT4BEmXQeDBs34MV4TOARmVNtyg+OQwL8JTYENASYNla+EXMVzBCRD?=
 =?us-ascii?Q?XTFVUg5HwkLFI1z19mJFK/QYAg8+AYZVv46sltJ43KmXA6pgFW6+p+TgKDBi?=
 =?us-ascii?Q?qRt2SLtEFZ7zJ4soAio/vzj+n6CzOZPddUyadcGR1vcisfXgmTHQejwydcPY?=
 =?us-ascii?Q?/Ug8a2Ma1eGegv9YrMWQUfpaq36d20GhmjhntWoBswpR6aJBaLKCXpoJ3CzY?=
 =?us-ascii?Q?AAAkiqqwrhCQ5wQVKlNLa4kqPMSja6t+rglB1iAgG8G/xcaN3olic5qS5dQy?=
 =?us-ascii?Q?gDnDkOQvwOKa9PBCQisb3l3Auo2DaldxlM3/y1snK2VNqtIhPLKWISXzvvMH?=
 =?us-ascii?Q?bX4hWqKvq2d8rj6kcLLzhua3CYfQzCXBlp9cBqRehI0A5e0SyBj6tl8mLrFk?=
 =?us-ascii?Q?OmjTJrdNe6Z2TsW8NPPqH6iHArknv1V46z3Q1mhTqnLMH6O9PyuWFmKaxqbA?=
 =?us-ascii?Q?ofw6I0zKYtAhisy5y2ZH8ykpgTakb5KnXFwuyljg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 066273ac-bebb-4d34-0433-08dcbbb8fe2d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 16:57:19.3832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9EsvggJWtEQ8UVabmjz/MxcHlNAlwUyKAQoH8gKPB8wKUDZQXwC8tmowvWhW/Woq5PAzY8jp++zMM5eWy50uEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8060

On Fri, Aug 09, 2024 at 11:18:53PM +0000, Thinh Nguyen wrote:
> On Fri, Aug 09, 2024, Frank Li wrote:
> > On Wed, Aug 07, 2024 at 01:13:52AM +0000, Thinh Nguyen wrote:
> > > On Fri, Jul 12, 2024, Frank Li wrote:
> > > > From: Li Jun <jun.li@nxp.com>
> > > >
> > > > The runtime resume will happen before system resume if system wakeup by
> > > > device mode wakeup event(e.g, VBUS). Add a flag to avoid init twice.
> > >
> > > What's the consequence of going through the resuming sequence twice?
> > > Will this cause any functional issue?
> >
> > static int dwc3_core_init_for_resume(struct dwc3 *dwc)
> > {
> >
> > 	...
> >         ret = dwc3_clk_enable(dwc);
> >         if (ret)
> >                 goto assert_reset;
> >
> > 	...
> > }
> >
> > clk will be enabled twice, the reference count in clk will be wrong because
> > clk_disable() only once at suspend.
>
> Please capture these info in the commit message.
>
> >
> > So clk will be always ON at next suspend.
> >
> > Frank Li
> >
>
> dwc3_clk_enable() happens in probe() and dwc3_core_init_for_resume(),
> but you're checking dwc->core_inited in dwc3_core_init(). Why?

I have not check dwc->core_inited in dwc3_core_init(). Just set init value
dwc->core_inited = true

Do you means dwc3_core_init() as dwc3_resume_common()?

>
> If the issue is only related to clk_enable(), perhaps just check that?

This should be major one. Any paired operator between suspend/resume should
have issue.

Frank

>
> (minor nit: rename core_inited to core_initialized if you plan to do
> that)
>
> Thanks,
> Thinh
>
> > > >
> > > > Reviewed-by: Peter Chen <peter.chen@nxp.com>
> > > > Signed-off-by: Li Jun <jun.li@nxp.com>
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > >  drivers/usb/dwc3/core.c | 13 +++++++++++++
> > > >  drivers/usb/dwc3/core.h |  1 +
> > > >  2 files changed, 14 insertions(+)
> > > >
> > > > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > > > index 734de2a8bd212..d60917fad8c52 100644
> > > > --- a/drivers/usb/dwc3/core.c
> > > > +++ b/drivers/usb/dwc3/core.c
> > > > @@ -950,6 +950,8 @@ static void dwc3_core_exit(struct dwc3 *dwc)
> > > >  	dwc3_phy_exit(dwc);
> > > >  	dwc3_clk_disable(dwc);
> > > >  	reset_control_assert(dwc->reset);
> > > > +
> > > > +	dwc->core_inited = false;
> > > >  }
> > > >
> > > >  static bool dwc3_core_is_valid(struct dwc3 *dwc)
> > > > @@ -1446,6 +1448,8 @@ static int dwc3_core_init(struct dwc3 *dwc)
> > > >  		dwc3_writel(dwc->regs, DWC3_LLUCTL, reg);
> > > >  	}
> > > >
> > > > +	dwc->core_inited = true;
> > > > +
> > > >  	return 0;
> > > >
> > > >  err_power_off_phy:
> > > > @@ -2375,6 +2379,15 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
> > > >
> > > >  	switch (dwc->current_dr_role) {
> > > >  	case DWC3_GCTL_PRTCAP_DEVICE:
> > > > +		/*
> > > > +		 * system resume may come after runtime resume
> > > > +		 * e.g. rpm suspend -> pm suspend -> wakeup
> > > > +		 * -> rpm resume -> system resume, so if already
> > > > +		 *  runtime resumed, system resume should skip it.
> > > > +		 */
> > > > +		if (dwc->core_inited)
> > > > +			break;
> > > > +
> > > >  		ret = dwc3_core_init_for_resume(dwc);
> > > >  		if (ret)
> > > >  			return ret;
> > > > diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> > > > index 1e561fd8b86e2..8a4bfd9a25b19 100644
> > > > --- a/drivers/usb/dwc3/core.h
> > > > +++ b/drivers/usb/dwc3/core.h
> > > > @@ -1195,6 +1195,7 @@ struct dwc3 {
> > > >  	struct clk		*utmi_clk;
> > > >  	struct clk		*pipe_clk;
> > > >
> > > > +	bool			core_inited;
> > > >  	struct reset_control	*reset;
> > > >
> > > >  	struct usb_phy		*usb2_phy;
> > > >
> > > > --
> > > > 2.34.1
> > > >

