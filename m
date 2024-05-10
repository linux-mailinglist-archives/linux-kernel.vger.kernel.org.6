Return-Path: <linux-kernel+bounces-175996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 626B28C2887
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 18:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 858931C2434B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 16:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC529171E4F;
	Fri, 10 May 2024 16:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UxxZL7XC"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2052.outbound.protection.outlook.com [40.107.249.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEBF171648;
	Fri, 10 May 2024 16:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715357420; cv=fail; b=NMR/Kh7LJgBq6v+G1g7I0U+f8iheI1/oD0I6jN3LjBdd27AujVpHf5BpgHxh1Pv3p3qu+b9ZF0aqN2Ddd0h0u0JyjHJWo+gSxuLb6GhdYcoHGcwLflg2KkKevlbo3X3Pys+WbtZqNSHfK4BjI46VB4rY74B1bfsAQvx0iqywGzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715357420; c=relaxed/simple;
	bh=6UR38EMEMB9Ns2WBy5Nosjv5aUm1jOp4+fcDHEwwsl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oxLpRJslAyY3HC2s+wC//YP0NLNc3nDh8JV4URf58Ox3gD8HRwIJEJftD66byYagwMfpr7l7TCsDokATMKUuYSSuyFR3GN1mMcmmsQhR4CiY7VDuHHBq5rBGDVISp4waGwHTnOqTSZZqGVh1HTp70og9pNxLMRMFmkhmUfSli5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UxxZL7XC; arc=fail smtp.client-ip=40.107.249.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLBH4a+rVGeOXSmFZY9eEuE9vpXq6QbBNBsLf/atmJS9TOqjTt4FEhx3sUogob7M8UDVnkOD2WoHpj6q5UbOCIRz/ISenpF6ELRryPH12pPd426RUxXUiQIa3qyu1Fw1uY5PUexr80Cf3BtsA2IAwPDA+Iqk+b9OsPCQH9kiGhHI0cXQcZqukJhwlcPLLwMc+yBODVxFbLIE6M7HL4G5Bq2vhlGaeD8MEosQP/boH5GCMDt6xRsXE3IyB5WI0VQgejNhd8ejmA4h1uo0f/2lP/vraAbahmdP4ga5xOjFXz8j64qk0exBP2dVmzAwSYsJpB/aauCf3z5qnbEDt8culQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UpKHArUMoU3LjJ2Y855biENvGWQdckdFTIaN0cgs64Q=;
 b=oO6/Wjh0FAMiTdGNBCUDcr8gjkUfyXk6L06lxJAc5iJxGgYTtAuU3CiWoM2h5kV1613lyINvWffU82o/09dX1PwNNnpGviou0Cv97BJlrq/LFRo2Fqsms+ieMNlJReO+22uHx58KS+omjMzul2QRvkaRaKVFWuL/Jy8sPL8mN+1Vn83QiJtVygVbK0bCee8XDECs6GeJqzTDr1iC5GZASjhrY/ZqfHp974P9rwE/r9/SPwC8yeqrWPtXlfXI/oaeoicwt4+gpcOJdRu7J0x1lEwHafULJVYIX1HpWmc+9phK0pEag/GsmatQ3j5sMEwFLKdU0XL1wjsbv5puBwarwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpKHArUMoU3LjJ2Y855biENvGWQdckdFTIaN0cgs64Q=;
 b=UxxZL7XC0L/zdxLKb9PtJT0e88UpgJlaLx73xl9r/TcnF6LaUaRWt4onFBpUM+6WK4zao6ysRcq0/U+oj9PYBA7Df3spoH27WnnJs5k9OMoQuBrZvJs9K8VzeRnz9D3IV5oVtdF07f4T3/HBfL3J7NqG8CX1azz7D1+DE/IOBPc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8988.eurprd04.prod.outlook.com (2603:10a6:20b:40b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 16:10:16 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 16:10:16 +0000
Date: Fri, 10 May 2024 12:10:08 -0400
From: Frank Li <Frank.li@nxp.com>
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>,
	vkoul@kernel.org, kishon@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, imx@lists.linux.dev
Subject: Re: [PATCH v4 2/3] dt-bindings: phy: Add i.MX8Q HSIO SerDes PHY
 binding
Message-ID: <Zj5G4B/aHq4WlunT@lizhi-Precision-Tower-5810>
References: <1715234181-672-1-git-send-email-hongxing.zhu@nxp.com>
 <1715234181-672-3-git-send-email-hongxing.zhu@nxp.com>
 <20240510153849.GA308062-robh@kernel.org>
 <20240510-daisy-overkill-99c4bee476c0@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510-daisy-overkill-99c4bee476c0@spud>
X-ClientProxiedBy: SN7P222CA0011.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8988:EE_
X-MS-Office365-Filtering-Correlation-Id: 08bb7d35-6abc-4ec5-1d9f-08dc710bae3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|366007|1800799015|376005|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ErIkggW1E1dgGukgBAfna5YppSBKmOMn75KegYKLj/y3K8o6T7jnkj6/TgfW?=
 =?us-ascii?Q?N68DPWGHreYtquGPc69WN0Ef/kRYCPSy3xqrnEM0d1ZFmOPDltAZR6E9lcVi?=
 =?us-ascii?Q?APMeuxZrjVQYex9/+dQwxLGG4TDw5MQ1WMLItMEn4/TmmxKWqhcqX70DCiis?=
 =?us-ascii?Q?DWn10x+OryceKtwTdjGD7mi+VVDAsfGQxPs0rZ9UQczR93N26gHB0LNEdNNr?=
 =?us-ascii?Q?RYYkE1nQ4LMkQafQQlybMZOYA7r0ydSMvx1ovoQ/bzBK0aMoomRhu+XX7T7+?=
 =?us-ascii?Q?AEF+TUk5+8q0GRcrLMLzygHf9Uj7p7R59xN5hLidbpGB6YDBmdDj6tJoahLw?=
 =?us-ascii?Q?V2ksYaZkhyNjxrdTt3NpST7gmGs7WhGThiGLwbPvH28nwS+Y5qjYdLWqDOxj?=
 =?us-ascii?Q?TQYEYTyp7E4C44DSiHJ3w8NFs8xOfTisaydkgFjDQOa7JgcknGiqRhFE4/xc?=
 =?us-ascii?Q?TPSxhN3zXRloQR2kdG+6GoINPr0/utqglKROWgfIxSSjRov4Wn+bIV1Y32JX?=
 =?us-ascii?Q?cDfOzq+VSu1IzUyKW2Hiv4r7xwTL2Tsqs6JbUKs0o+ZQRWqKn/w+KqoPA8o4?=
 =?us-ascii?Q?Gd8PgmKq0y/ntAUb5J5dh+p/jyMZJQM4RVaXdf1Yu5BDgGNJG6hmrJxeC/i8?=
 =?us-ascii?Q?z2mJ/4dC1dAI6Z5sbKSOPae5Z5VaJSXFhnRwKX7AdUbPQzNMYmkB8G/lF5SA?=
 =?us-ascii?Q?E8uHmVrTYQ3QUiMN7Kx8Xe31vu077RtFreQ4Z7uhQwxheIUhP8zCZL7A782D?=
 =?us-ascii?Q?+mmnLS6SHJ+8UamEucfMNQN72Zwf1QbuT0aobo2IfkJ/Pxr/bC/p+kusGxtm?=
 =?us-ascii?Q?kLIMSkjSr8vLg0QmnT4LDhKJzUR5WNiubzAEfvW1wn1D+R/CiIkHabVUUBbR?=
 =?us-ascii?Q?BQMblYF5N0Yq/UOzXIBfXR+jXhZgDD/X6uRs2liqjCemAnYa8CUm1A14ch5w?=
 =?us-ascii?Q?Dax62huUh/ceY75pti44gfZiju+TXo180bx/zv73xXNWYYaDqka3b21koVO+?=
 =?us-ascii?Q?misZxZbVnBQ41yGSjjd88+v/NkB/j5T+hiUhj/Y8CTsb7g6w2kchm4qig5EX?=
 =?us-ascii?Q?gqg5SlRBx8/Lc2BNmDlaB+zfeWYkgEkIqQKKfJcTyaH4opoCmRa+g2g+90Qe?=
 =?us-ascii?Q?7VtDTWmmVBxJtFICFXf3GR/1Q4f29mkP+slSop0CiyIzCQn850eKfHXAHrXd?=
 =?us-ascii?Q?gMwZfYVc+HoytquJKzhepo4Ll5XCbnlxTfp8V/W6wFA0CUufBSpS7bFFMjVx?=
 =?us-ascii?Q?5LtcCAXvckUdTVEgJZih78/bWe058XIIh+db2YEBX1vy40u0ARfpgk0Miphq?=
 =?us-ascii?Q?k0kHe/cAMG0Uq6bQIIC0zOc/xgnb8fCEcstL0ob4mNpk8A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(1800799015)(376005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yvKprQylRHe+UNLmB1Uek2K+xhvLW6mPnWKSQ1zGA0I9Rxw5fldIKIgAeDyQ?=
 =?us-ascii?Q?eAX481Wle6nndMasvA/8DgiL2LFZ5H3jIPudGciCmK959aYcDkfgKDqVfdLp?=
 =?us-ascii?Q?K+dUOMm/obrWGJYRsZWAR43TJXBfRRN99ms4/Zy5JlaetGAFtUitHHe3vzA9?=
 =?us-ascii?Q?ZhODrJOuD26ACsf0uPKxHabzwzGnuDN/OqDNrCC/QKC/IchdvtZj3Ks3KZ0Q?=
 =?us-ascii?Q?lf8LusvlncVju2nQcST/byudcYqaNByC81/IZWJPcaKV0+HNixlwBX8zHj+z?=
 =?us-ascii?Q?nNnYakcdF/MV3sLncxSJXaG7qMy3YyX6rkYWYNNeMKAopevXs35uzpxOeV0G?=
 =?us-ascii?Q?D6sdNFA9IKQl4jRcJNn2FjdNhvbMAIZfNNHzaZ4WKf08NdlAvqe1CnMx46X6?=
 =?us-ascii?Q?xNcbmFfrL8Y9f7S5oGyxHtqQ+cKrsQx/AlugPn3Bv4OJuDqrNcyjfuaTs6RU?=
 =?us-ascii?Q?/gFdd2fdZm5uFvajHPxG4ayFKR/afiPQhHw/8VN/LIQpSPZkXuHKcn/ZBoKo?=
 =?us-ascii?Q?VZxrsJOJCwpgYzkB1jwT27qisk+WWbCwvNQSkJ99Iqm2BaOpy/L4PLJvhfLH?=
 =?us-ascii?Q?nImnOEIzTmMhcZFLIE9+uJGfvS6u87aE79J9lQ2wZrXSSNzqAaZBeX4kU3PQ?=
 =?us-ascii?Q?xMTK0Tte2FeeV30ZF1oLBrc134A8ZRdOeVCxwku+2/4aZOvjuDQgvz/sxb+v?=
 =?us-ascii?Q?QLSHWUmW6moKHWx0oiWX9K3GyRckDD7D79rYDe7MCCcQWNal29OoF6vqELx6?=
 =?us-ascii?Q?C0vNHSkaiOHZlpmmTvk5J6HTj4UjYH2b4NZ6R75Pdi9F3h2EyVnSOeya0CwM?=
 =?us-ascii?Q?Tu1pG4P+jLtdcvi+bBdvdcauG23OO/j1bVkkZjhSM+xDkGFVy0GdIIoXl/5P?=
 =?us-ascii?Q?rdxoXkQ27mVC9cTT1/004y1eV4KcirO6g4sfvbQEWJx+RW/UVj6IlULQd2fN?=
 =?us-ascii?Q?YuFXIcplh3pNQAgFKAnkDoah3thdeVxeWwjEybeezaYfwDT7qLSk6A/YyUNk?=
 =?us-ascii?Q?oW92pQXrfhtwnuOJBMq2Xzf+tMEIIiTPiCXeaGozvis9tHAvbLvJbDmuz/K+?=
 =?us-ascii?Q?0ngjlc14AjNyoKwWwNSyOV7m7sR/3Vm2xD4Bu1c8XzmFafvPx6WmqxMatd4A?=
 =?us-ascii?Q?oEmEhsdnzGQPb2QSZ7Dba95LnNQBcE1Hu2q+D1KTaUiTWTmAKhZWsBrU0yjI?=
 =?us-ascii?Q?p6Ssun26T83qrOVDslYUWtjX8vpbcqPzKkeIsKxTP2xO/lLI5jpOZVZMcpaC?=
 =?us-ascii?Q?UxD8bjR3pEdhj+EEOcycDCk8QgZEcW1OxvxA9KymtGmx2gFLqbGERwsv5BjN?=
 =?us-ascii?Q?pZndKKOtbPkCTAykf2ZZeDCLIQhwV1wSU7UAgIvuxFkvE5nLQNiyPIZ27HPE?=
 =?us-ascii?Q?578orvVr0Ukw553LbgGb7XZopwOXokZuydI6PP4UT97fJwt1ZRHFsU7fU5hQ?=
 =?us-ascii?Q?0nJheuC7oGZ1CyNpynwqyCxKlfT0TDhioi8TI8xhCZ1fIFxmviUX74TgFM/w?=
 =?us-ascii?Q?e8dG6krP/f0jk8aON2YsodBZDVrxt4pska3nvgON8LQu3nQTTVTVmmvlwCW7?=
 =?us-ascii?Q?gGkddWBMAI+IQxZ7/UkAwLIyiUvXGH8agmBf3+gY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08bb7d35-6abc-4ec5-1d9f-08dc710bae3f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 16:10:16.3022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PHSlpK82dB9WpF3JYLqm34erPOmakvkCncfxOOziVn14d2NWtoMw+2Pv/ryxr72stOiHbKlAKG/HBw6j3pVIbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8988

On Fri, May 10, 2024 at 04:52:22PM +0100, Conor Dooley wrote:
> On Fri, May 10, 2024 at 10:38:49AM -0500, Rob Herring wrote:
> > On Thu, May 09, 2024 at 01:56:20PM +0800, Richard Zhu wrote:
> > > +  fsl,refclk-pad-mode:
> > > +    description:
> > > +      Specifies the mode of the refclk pad used. INPUT(PHY refclock is
> > > +      provided externally via the refclk pad) or OUTPUT(PHY refclock is
> > > +      derived from SoC internal source and provided on the refclk pad).
> > > +    $ref: /schemas/types.yaml#/definitions/string
> > > +    enum: [ "input", "output" ]
> > 
> > default?
> > 
> > Really, this could just be a boolean for the non-default mode.
> 
> There's actually a third option, or at least there was in v1, unused.
> The description in v1 was:
> 
>       It can be UNUSED(PHY
>       refclock is derived from SoC internal source), INPUT(PHY refclock
>       is provided externally via the refclk pad) or OUTPUT(PHY refclock
>       is derived from SoC internal source and provided on the refclk pad).
> 
> I suggested that there should be 3 strings and not having the property
> would mean unused. But all mention of unused seems to have vanished :/

Yes, missed mention about unused.

Is it okay about "fsl,refclk-pad-mode not exist means unused ?

Of course, need mention in description. 


Frank


