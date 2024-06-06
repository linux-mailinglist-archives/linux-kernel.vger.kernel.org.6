Return-Path: <linux-kernel+bounces-201990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B658FC63A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ADDA1C221A1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82DA194150;
	Wed,  5 Jun 2024 08:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g+CigWJt"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2040.outbound.protection.outlook.com [40.107.104.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DA6190067;
	Wed,  5 Jun 2024 08:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575709; cv=fail; b=UC3Vva2jyd6TZD7NgSUrkLm4Kb/3e2DKrh0dI113El5lOVge3grAa7XnBIWo5KqZbFaY/92bgVwfkodDQV6MfNzNKg01/Hescnn5WXyd0re5KqmpBpoU3Ln5jBx/9SVx6rYYvU9SUYQoHxrMIuJBafXsaZgBhjfN/khKv0NO1fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575709; c=relaxed/simple;
	bh=SOUu4z3JPhJ1W4PFS7A3jVCEZjHGtngjDwLMjoqwkq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eCOezAMRw0gMgCeCAXfrMfMF4JDmQh2heXpmnDkbhERXZN/b1GkKVoypIw1SnfC5Mjh7U2TfoUWXYqsACMZrhpOVINQqN7YzO6rJNL6+hgqImT3NsYmih5j2eEVQVrJBZB+eE3UYxzmDvbSK4hwxoYOBQbPeaoR7t3NJy2g4kzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=g+CigWJt; arc=fail smtp.client-ip=40.107.104.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qnj/ctkEDjG6oHwGxdF2iAOE+1zexpnUvyMf57n/7S1iEgB/MHP989mmsnEIkBhXn7MQruassQ0cAB1jWgDnmQVBmWo/WUWdUeuPqDauKjIkCJs9m/g4UFqLP9fXcZ3EhGduzHwKyjdku2DhlnIwhlKRNMcl7doNe3boy6j3LwTzmGgwdc60mpSniUWoOmbOxvOkpKrmd1a5z8F3fmxNFX8zM70EZhPXoBzT9S8t5vTG22JtU1Zn2tHVZMNwz0fAZRiJDJiev50f3UwvWnj+xtOb+5OXKhIa1Nc3Y1hCK1Hiwsg17Ept5nOcnuN6Msq/Ec2hYdc6Xf8/aYm1uIsjEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfaefXdJqFJsQ2OAbjOVb0JTgPCbYUUYYmkTuFUEWQc=;
 b=ctfNaXj0/vGaRpdmTLHrXYoUQa4xryV9XeUi43nXO2jSQcHE/pB9A+dwweT/nlPq08qL0VhKBTtY6AfIUJqsIuhWq8sugc7Rj3QGmS0gAW3ZGocGTMYzfot+IQ8n7fpBOicqD5RlHDh69kMMIuKLI33/fCojNle4d+vBdteJ3Cn2iww2OlO2HqacV95nu6PmKqCxhc/31Dty7denDP6s7d7G1sNNygcEbJLeR74V6jF6m2T4FEZrZoXFJdngYrYFV2wDA1CdKzoKCToLf/7KBraii4QF/AE+JROHwgS+CFmpTco9SCatYfGtFYnwUhjRV3mtieAGWmQtl9q4MBXnqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfaefXdJqFJsQ2OAbjOVb0JTgPCbYUUYYmkTuFUEWQc=;
 b=g+CigWJt52PaHwywhylBIate3MVQxTK7ITkrKh6UF826nnVoETSzqpUryzXSkTKq5JrTNFm0dSiZOFFZCs7yXZ6sTCpWeUVDr3q1QmnXlz6VqirKBfnEDqAm8C3eFm/2xh91xBfrwxqS/HAsHXughviP3kUtDABXGDj03O5154w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by DBBPR04MB7771.eurprd04.prod.outlook.com (2603:10a6:10:1e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 08:21:43 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 08:21:43 +0000
Date: Wed, 5 Jun 2024 17:23:59 -0700
From: Pengfei Li <pengfei.li_1@nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, abelvesa@kernel.org,
	mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	ping.bai@nxp.com, ye.li@nxp.com, peng.fan@nxp.com,
	aisheng.dong@nxp.com, frank.li@nxp.com, tharvey@gateworks.com,
	alexander.stein@ew.tq-group.com, gregor.herburger@ew.tq-group.com,
	hiago.franco@toradex.com, joao.goncalves@toradex.com,
	hvilleneuve@dimonoff.com, Markus.Niebel@ew.tq-group.com,
	m.felsch@pengutronix.de, m.othacehe@gmail.com, bhelgaas@google.com,
	leoyang.li@nxp.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/5] dt-bindings: clock: Add i.MX91 clock definition
Message-ID: <ZmEBn2E1FPKiXnMc@pengfei-OptiPlex-Tower-Plus-7010>
References: <20240530022634.2062084-1-pengfei.li_1@nxp.com>
 <20240530022634.2062084-3-pengfei.li_1@nxp.com>
 <20240604150447.GA604729-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604150447.GA604729-robh@kernel.org>
X-ClientProxiedBy: SI1PR02CA0058.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::9) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|DBBPR04MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: 17ee2cf5-3637-4dbf-1e65-08dc85388850
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230031|52116005|376005|1800799015|366007|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?quJ3F9IQJ2RKUH8j+Uu567vLv2dNMv8kvZOb5pFO3PM6VFva11uHA9IQnrPF?=
 =?us-ascii?Q?key1EEDMV9bof2kEW46J0AvmelrKAIT7PJbTauCp58R5lI5SYRANl3rYHo3z?=
 =?us-ascii?Q?cqlGHrYQZp/B6Mpk+dUPt1dKd3MVf18QshS/tCCYSr3uJo7CukXOQgfvO/xG?=
 =?us-ascii?Q?hjcdZjcEU7Uh/VTb7I2pIy7OpE2D1uHfIfuV/xgXgSfQp42TajOXYRzRtPe3?=
 =?us-ascii?Q?4gOM+e9a2Wz5pTapQIMgkj4YSYKnzVuXO2syF4iQ/fmBkvivli/3KcjMyNpJ?=
 =?us-ascii?Q?XoJb5S45X5xriRDnlFXKvDhdm6zC0XgRX4YnVI/Rcsz/VfQx+oI6YlISu3aS?=
 =?us-ascii?Q?I3jmxdp/aewVqppNTo5Ho0EGFXBmHIN+AAc4GimBAEJQZgPR4Zd5lupBhHJq?=
 =?us-ascii?Q?jPS7Zrx9EeWPXnJdrnaTukyyTHhCka5L7Ij0SIvDclkyXaYPqskmgxe8xDKC?=
 =?us-ascii?Q?aR6um0bTIp/08raw1wJJ4KijI3vEiRRFlksfh5qJCditZff9JS00NPpsq62T?=
 =?us-ascii?Q?tGcNoon8urNKTz0FmxmuFps2SawL9wxkOxRWR8YTrFXFChcZ8/fYFIWwGj8C?=
 =?us-ascii?Q?BA2BeeIOBX1BosvEy3CmJUmZZKJuFok3b/6J4PgxkcHmCbsFk/27lvK2CQVN?=
 =?us-ascii?Q?FImlj40MFQf5o5deRQosC6gCPEmdxGUWFbdnINySao9Py/uctGPdIe0AOUT+?=
 =?us-ascii?Q?pkST9RM1bFZZ64jjbRwm3bsersmUQT45Ie/mrltg8q+YKnb0o4dKlwYOxvoY?=
 =?us-ascii?Q?4kX51qT32IIAr/Ucu02QGCvTjVPh3h2Pk+1wY5cIe5oxDZpAN5OlomNlAdmZ?=
 =?us-ascii?Q?qfUqYbaoDxC+pYthTOAETj2sBTgNNLNAZzeLjAhXqlGZIyqdK3Oy3QrOhi2G?=
 =?us-ascii?Q?Kqittx8kp9nnu1JSx/zZBFrJy1SuO/OsjE1Pl+V5adv5PPaoA67l33TuSNQo?=
 =?us-ascii?Q?FByjwJvowJroVV0/7fTAJkHdW212EVBIg7cAFlrhmBK/I/7uvR3bIGG4D4K+?=
 =?us-ascii?Q?H1WkOQIFEYFW+pc9Q+vL24ZEw45WiEmJDGbX6nF+ihbxgjJM7CfizPddcb9L?=
 =?us-ascii?Q?AoYEJoVgnsF2zwgvLxUKML0ZQyQuxxBMKO1v3XTfswCArnosTLCNglcwoEmi?=
 =?us-ascii?Q?ZWwsMCkHIQen58x5+Jt9s4QxdnrHZZudUwINEssJzhyusxeX6rgD+sbCt9y5?=
 =?us-ascii?Q?3QRez+LFPXFtDvHZSB2+AaXDpfGSlL1/9AmoP4qiGqHYDlgR3W98qW3++XVB?=
 =?us-ascii?Q?MgXg9SXNIUY9vust+iD3wVF9UdxjK9/RDeyK+NAiCBDb8DCMqB1aeG6FNgue?=
 =?us-ascii?Q?LaNqB3wYcI7/Tzfdr3/VyNlHATq5bbgsFVTsL3VWih2YMA=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(366007)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?hD1uKH2rB3aYIltbEnuUY/o1ZpaUWzTpQ6n+URMJrKrlQ8QILDax6p34RE/D?=
 =?us-ascii?Q?LxnASRb7S+f/RxTqEnniGnMn1miP9P+oJs5dtuCjULsmj8jisZ1tP8az0izr?=
 =?us-ascii?Q?72DIaH9vkLpLkT8RMHfzep9ufhnJq89AOypATfuMukJ2n4alX44K5TF5n9kD?=
 =?us-ascii?Q?DTwefOp7pZ23wvl4/ie+qVVJa2ZXALHnDnzhUcrV0Zmo7yfZ1jAtaYu2Noru?=
 =?us-ascii?Q?XMA7O1fRmQpU8cwC+fxBF+VkyZ74enIdUX5Xp1p7PW0SvP92DOk+RICiZ19N?=
 =?us-ascii?Q?qS9tWvvPJHSRXFZQ9DNGWhQVw57ixcT7Tczg6m9ywJPPxnpYiLKRo3kcMgvk?=
 =?us-ascii?Q?tKPT4Bj3CIirIzR2Ln0gGMKaBqc7zfJD3j9XoFdLx2K2vrBhXsqr1BrgLxk+?=
 =?us-ascii?Q?z/NfWjWzeeP78uvPJODhDW+UH2EzNr2gokkw/HhqsANoyb+ZB9DWhpsXxnRq?=
 =?us-ascii?Q?Zmi9mM5TmO9DG6PBiqcYC/S1Q6cB+rvI+NpY+/XMAl64f9y2tqflIzjm0HO7?=
 =?us-ascii?Q?kKztp98esI4QBGBKBL9HyItKJY8qQNjO3MyOUI2Jg8ElYvlnbZqM5WLwD8zo?=
 =?us-ascii?Q?ax1nMAa+67zhS8JtJNf08b62C0k9aoZ5f3mGeHaTOoAnq4TKBnID98CdSEuh?=
 =?us-ascii?Q?bQFW+v5vhiu8HEamGKbSUa1Y4p3oYUySeIAZRsZ37BLF4kSOcRPLX7GvLdem?=
 =?us-ascii?Q?MQigl1DZokkdbOBqTHNQA2DczCqikyXTf1Va8saj8oQbhb2Lt7393yR84nzb?=
 =?us-ascii?Q?V05L+80wlFjND6bUjb4ZEhnsO0GigeQtFphLMPWS7lf4Hu8woFBU5DxyqcbA?=
 =?us-ascii?Q?qRsuDHrc+6fdOd53M34eNWxIURoGqJjstN5S/nh9VujvoucFSSgfZRWMUlhc?=
 =?us-ascii?Q?+3UF+ksIPRtlzB4IjRqQ8wZ9zo3TY/baFmQHpCO1aN8EQEfoCbMn3UlceFeh?=
 =?us-ascii?Q?792D2KfpD3ve/tzngFMXIh9eOgT933w24KmCZh5sCjmavKLwnnMxAFXEwR9n?=
 =?us-ascii?Q?eG66QF23kE6g32BWscydE11RBu32pE5ivmvh75dBqGxXBxo6iUZo3NJ9ihkK?=
 =?us-ascii?Q?Jdb3hihFvl45gOxm7a6yaQA2HasooWuiyRiuZgMUlkkMNiXuw6E/di8mkX1P?=
 =?us-ascii?Q?Q+9G7tC0tG7ckulJAIZv8hisF7Nm2ohDOwp1lEiBmQLOm4s+m+fL21ie9n9I?=
 =?us-ascii?Q?2Oq0LqmSk9gmUVPY7hGYF/SSIegqJGHXHGbV6n3KAwHq7A3523V05nNVIrv6?=
 =?us-ascii?Q?1TfAKl5J2dRjvnc3AWufR+yRhr08tVD+j/2LJDWKK+SqVCldhAZE6KwcJsJl?=
 =?us-ascii?Q?D9iqkZ3XiwtTWoWBY5KJNJTzA5EkPHHMQr//eAk0ThpbLHqPRQ0vHEqQdQbk?=
 =?us-ascii?Q?7xgISOi33npW5PRulwR26Tlngq/4L97nA7fuBuypL/eRcw13mbNhsYmR05tU?=
 =?us-ascii?Q?J7/1pSjh2ldpBhpoy4yc5XuimmFUBLsb6GI+2lqRLiQnyB1za1rRg1SjOLCZ?=
 =?us-ascii?Q?Pdyz3qfoiy5Fn48L9svLWPbK1HIyjpw5SpVxX+cnkklIi4dn/NgWt2c7T4Et?=
 =?us-ascii?Q?5o2fZlrBbbNAq/j7MN3TfVzzPjqTE9xDt7/pjSEc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ee2cf5-3637-4dbf-1e65-08dc85388850
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 08:21:43.4409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3VzA4hfdZSJJFLwPaGlNcd/deSQWPcJMYm/Bg8UK6UvtxlirTjCivFAd46DEXcLwajvbQxZ30/WqDzMMrqHo3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7771

On Tue, Jun 04, 2024 at 10:04:47AM -0500, Rob Herring wrote:
> On Wed, May 29, 2024 at 07:26:31PM -0700, Pengfei Li wrote:
> > i.MX91 is similar with i.MX93, only add few new clock compared to i.MX93.
> > Add i.MX91 related clock definition.
> > 
> > Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  include/dt-bindings/clock/imx93-clock.h | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/dt-bindings/clock/imx93-clock.h b/include/dt-bindings/clock/imx93-clock.h
> > index 787c9e74dc96..ca0785f35a46 100644
> > --- a/include/dt-bindings/clock/imx93-clock.h
> > +++ b/include/dt-bindings/clock/imx93-clock.h
> > @@ -204,6 +204,11 @@
> >  #define IMX93_CLK_A55_SEL		199
> >  #define IMX93_CLK_A55_CORE		200
> >  #define IMX93_CLK_PDM_IPG		201
> > -#define IMX93_CLK_END			202
> > +#define IMX91_CLK_ENET1_QOS_TSN     202
> > +#define IMX91_CLK_ENET_TIMER        203
> > +#define IMX91_CLK_ENET2_REGULAR     204
> > +#define IMX91_CLK_ENET2_REGULAR_GATE		205
> > +#define IMX91_CLK_ENET1_QOS_TSN_GATE		206
> > +#define IMX93_CLK_END			207
> 
> Drop the END define. If it can change, it's not part of the ABI.
> 
> Rob
> 

Hi Rob Herring,

The 'IMX93_CLK_END' macro definition is indeed not a certain clock, but it is
used in the imx93 ccm driver to indicate the number of clocks. And this macro
already existed before this patch, so it may not be able to be deleted.

BR,
Pengfei Li

