Return-Path: <linux-kernel+bounces-535271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF728A470C7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F05203AFB3C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB20022F01;
	Thu, 27 Feb 2025 01:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tAyjIaKx"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5C14A35;
	Thu, 27 Feb 2025 01:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740618943; cv=fail; b=Ho7Iumt8x9ZBJsDexRoEZE8hw5wdvLFIcHom+kvKE+BJvHKtrrKDALmfxmoocaNsLT8wZG6DO54Vx0Ifi3TI4LiX78uqYT/Pgc0eIdy5Ihj6z6AI8JuZ3e86ljqauCc8d95jpuZCi3UdoymOEkpwsFjOh6++LDrZbbkVhkMHM2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740618943; c=relaxed/simple;
	bh=wjswY1jrfZqOonVlzZ6+jNBsm1BV2bJZV6aDMbVnpfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B9DtKqLdAutw/lUDjv11C0o8vT0qGrGEmNe0VAk67/H4chQU0yNtZhG8kBCnXS0KGqLioSr2mNOc8/fvqQJQh8PD0VPlhvtH5+g9/aHahIw9QOefDX31kdCTReUVw7YztjFqNp7Fv5fCpk8O11D4nIlfr1qE6ywFSyl+nn5gPY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=tAyjIaKx; arc=fail smtp.client-ip=40.107.21.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vutPxSEr/h9CG5ImpZSLMQU1zRuyMQXRIxaWcBr+c8wAr8N9iO+t1W+EtOt3NZnflM2mfZ3xi08tOIqaFspMQkWJTRn21/ApslD5L9C1xc4GnRD7ICKA8IYtOZjl6+CSMNsyXU61MXTUPYeSs+PQiGFz2RcEO6Xoo+5JqpNW5EM737MeeDEvCsDPOrKv/eD1JWIGWv87eYfe1cGdjWXc6LZX6yxAIJXmsIQlc5RFQCtf3EkubERWzDd/j0/HY2H3YHH7+5A52/Wzr4pnHx7F+c6c4pLIJkAG+Y56AcLow0iHwiYWPO6G7Qn2jQ6P6BG4YTSJCe7rH6PAc6X1knEklg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zK1RUbXKHlzXrcZALk/0mfFlGY+1QVGfGd4ueKGGMs=;
 b=Y+SSliUfuYK7Hm/u2Je+lTtQbgzcMnCDNRQlU4jjKfVRp7lQKD4qr1rl81jjWxlrt6ChRJwZ7gvE77apPvcDl0JsRUeOUbFv6rs20LO8nc9cejhqkLdcdLz71P19YVQfSxP+iD4FmAcg4Ew0Mbwi24LCIPOPbUwZpWDxxV7fz+XoZBRd26jOf7uXBozcWZkiGB1xvYd+w5LHu0f8jOmIdHEC9G/4HrzrMvP2KNQ2J/otUPYdxCRKMxy6Iqjl6GZ24z9Sq0jnrt669CYgAgT7g3OMAWIQqO68+C/cGLCze9Alu2haDZi2TpaESkGMO6ww04i3nnLOz1wlXCilCFXCvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zK1RUbXKHlzXrcZALk/0mfFlGY+1QVGfGd4ueKGGMs=;
 b=tAyjIaKx6suLe3wHr+xZWb97hV86shmmiQwmzWTDuaVGOz8bSb0MUBdJrFvJBA+LieqNRegRLed30Ax+s1Gw0HyWLx1KzThULBZGYmLeYCB0/++oe80FM4g8wDBvHpBaF4RHqT4AqH883gNsjIxXA76A3eO6owTw/eCLewfGpnlveQMn1j5bhTdqAfwCkxUYWu+UZjESsfz95vGV48cimqM6qLHO2dn5D0aJ7Awiu8E2ybvO1HGOoVU7QespFyNcVn4sBVOaI9h+n75danVB9cTlfXlzChCAdpkn6kMBCB2oLywIhgQHfffzFts5pQ2NNl5hDyL/j5fwLVM8eZhf5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7704.eurprd04.prod.outlook.com (2603:10a6:20b:296::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Thu, 27 Feb
 2025 01:15:36 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8466.013; Thu, 27 Feb 2025
 01:15:36 +0000
Date: Thu, 27 Feb 2025 10:22:48 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@denx.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Adam Ford <aford173@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-clk@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] clk: imx8mp: fix parents of AUDIOMIX DSP/OCRAM_A
Message-ID: <20250227022248.GA11411@nxa18884-linux>
References: <20250226164513.33822-1-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226164513.33822-1-laurentiumihalcea111@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: de557f3d-5dc0-495c-5fa4-08dd56cc3d31
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OWJ1P8tsBCKC7TNNEe2VDMr5xxtAjxXqbYPkyEWzW3V3iWOiIowS3fljS5Wh?=
 =?us-ascii?Q?pAHDwuLo2HBePdf/FeNXQ7CTR+aQ612zDl2N1m6Kgl4vWUfp8o1hHlVuL4LU?=
 =?us-ascii?Q?4tUVIGMTxVlFn2gYIgX1Acor6WXG2qKSDrknPQL2bGAXo0Wy59yBlYMTS9P6?=
 =?us-ascii?Q?X7cynSVjziIpKFOtvGYNwJ67usmGnl1nnLlEeEql0T2U2FELs8aHuyEXQJqZ?=
 =?us-ascii?Q?CqzWae9kkazY7ZH7ijGmfHLbZfcGsf+Ek5AbDuv/GJAu/9mTP4oiXN/mk9Sm?=
 =?us-ascii?Q?7M9FAdWk8cHEkA5g1SUrf8w8UdGjrZn88D+4+luAZfzm+mwwc19HQ12y2Gz8?=
 =?us-ascii?Q?FGXjmKDaVa2hPZLzhRzJnTklAqxivYCGd18bG5t7TcCEaXnj+BlC0DSVDa6J?=
 =?us-ascii?Q?CIIX12gopRKlHy7n1Mgn/HbVx1RZBrfQ3N84/Y35qYvZjO4obdRkIfD430S+?=
 =?us-ascii?Q?XYQAzLCkSBuuYl5Qycqi38pE4NN4AaujTNdVv0DICGQM0NIa/Cjt+Z7iemzX?=
 =?us-ascii?Q?YdjwnIxkLiYfjwSAnLtGLIBQkclqE36pzJe20eHrtJnn1Y3Ro8XyUcssF4Ls?=
 =?us-ascii?Q?TMqE8+gqmIIGG52VLUFpXIOjzSIO3gceMnhBDq6swIOfO1KzEBZOTmzrYem9?=
 =?us-ascii?Q?JEGerQyh9Jx/76p6FJ/GIWPjy4IjbIBDbtd3ZK0mjd0rVu9NE0P4W8/CaOo9?=
 =?us-ascii?Q?suYvr+0J8YuI6KQjp7v9YltpxCD+nhGXC4aRFmw0bQQYm0M1bD/ONDXxHYrY?=
 =?us-ascii?Q?5FPolBKl4yLrlCQ/qTse0DhIw6SHm37Qd1PATUdlKDjQxRT96qG1oOLdkexZ?=
 =?us-ascii?Q?uC6fQy9ndk/i0Yyj4zAIRtPz3LfO0Eu/lo+A3hdM4XljLYAucI6BNdF1pk+y?=
 =?us-ascii?Q?pzZAXv84R7q4pVLIxBOz5QWPLrVq7Y/njOqrRKsLNDMVLlhlTG2IU/nRjJS7?=
 =?us-ascii?Q?CHGCqq/gyiTE/pjpgQGJq8b2M70SP727r23tBmQFNzH3aLpCcJITCdA7qmJx?=
 =?us-ascii?Q?harSblS5O74AMsTDSYYrd2ZqGKZPElC/xRjjr+9cp3eloSzQDAdH5jr9QRUO?=
 =?us-ascii?Q?+TQ+uxwdX0Oh2tuj0tEsGm0yZVf78DBRt6c3BgUb3ynN9O2nQVXkS8fBrAXE?=
 =?us-ascii?Q?FL3YPdaHUZpzNKK59PClHWBcF8P7/gp9Jniwh4uztM1ruXGKFsV8g885lXYK?=
 =?us-ascii?Q?x1D9NnwkZTiaf7L1+dQaLw40NM9mQoovYmmpaCb8DK0UqnB/O5/m29//1qVZ?=
 =?us-ascii?Q?pgXM0qZjdCi+BAu2jIjN6I2x9BPTCFrlceWleEVw4TkMEABHysU/r/nXEc3e?=
 =?us-ascii?Q?dhtvCtigMWhsOBM3a4QObBVBlS5E71qryxJYnIp7Eq9UQAN7A8h5sWxvdcnd?=
 =?us-ascii?Q?BW4UaMIbsAMWm/UcGsOo8YtYWxjxtgKUF0YTQ36dVX4XFubifoP8WYhHVEtK?=
 =?us-ascii?Q?d1W7XIEACuGFdrNg5wiKYfqIgIMPVXANP2YECOP2Kux1obw9qRyOSg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WxE63zPAeCD0Z8iekoNq6C1gwXiq8sTzOMil1wwuDHxRRNVeZ4+EHaX6+lQP?=
 =?us-ascii?Q?wUWFwPho+eg4Wx/JCvsRb3C3+Zi4KqBwCT7WJLBLGswABu76jd/sKMJ2q79u?=
 =?us-ascii?Q?CTRB43sSnKHOP6wx9WWeo46I5/g4zfF1PeP1dKPUKW7lB7OmH8paVgi7IVaW?=
 =?us-ascii?Q?GWxG85ZwnjZrXIZ/VYlqkpjJy4xdGOnMPGr8dCMF0aAipRKGknXBusTdi/G0?=
 =?us-ascii?Q?990yQtO14uGJ1ikYJa2LFz2yCjeg+KVaMV3Y8eLD9/bfKGtj1jwMlaCdul70?=
 =?us-ascii?Q?ol3o0EVvLh6/3W0pddoPnYrknH/5T+0imruVGTdYrcatSwWwRE/TC2rx5w7w?=
 =?us-ascii?Q?1qDTNbgXEOrOnDNk0lOt+j0FgcAMaTGdUxbIkWcwXlsY+Ib3FYRQ7Wh3PEXj?=
 =?us-ascii?Q?jJ0ZXS6Cj6nT54pONEhlGrJZnrKIVgCnaCWh3vipkJzBMGY9KEANeVqcNiJp?=
 =?us-ascii?Q?+DeJgDkmSxLbMvVd852Z+EjEPKTAtH5Q5ff7Emq29sPYZOJ12Q7t1SDmOU9y?=
 =?us-ascii?Q?WDFSDvBOplQKZyWNZ0sFd4O2ADMTwEZbnoJ+576vN1+Aih6+FL5pkWNlTOL2?=
 =?us-ascii?Q?CfCqkTFjuNxFWptjdKl9eG2gt6OShBe/LXTmwuzv1zqazNGiYaOxB6db+tVO?=
 =?us-ascii?Q?kNe8MdWxhNVWobR0en1Dj+gpt3Qv1EqFU2bwiiQF1cPu9DsszK7jPAlgxqnT?=
 =?us-ascii?Q?3BEMgbH6msbsyu5d7pF4F8vR135mGKdaLaIDnGOUi96q5o/cCVIN4rTM5A+K?=
 =?us-ascii?Q?GaPahZ/b07JaBpwWjmUVUdy2/9rQCQxV6gbDpdQ5vP5eRSLAKdkW0bGjVdLv?=
 =?us-ascii?Q?8jSgD5zLlyio6zGF4pFWVMnFVYMUhr14sG+6kuMctwa42Ed6KW+n5IQUikpe?=
 =?us-ascii?Q?W6axwk6TLt3/cjjPe6ybwstTinWDSOwIQV6l7Fb3RrVVR/iMlhVUV6vpG9CU?=
 =?us-ascii?Q?9XuZnJc0pftW7maas/7g53ut/UKFOuaeqDrYU4/vm5BpZXKfoW1/hAz3ExY5?=
 =?us-ascii?Q?EurMFDezspKXd8SKlezaqmx8vUGhCbH1OfhJd9LzXa2pqPDGYrk7g3mIAbBZ?=
 =?us-ascii?Q?UozvAn1mrPt5EzSVdMUm/sv7uS9XfzPN++SU5zoIPC6/5C7mnJ9yN5rgMh0h?=
 =?us-ascii?Q?wORIVy73TxYO9RtJU902wxDWLMxde9hV6kCVYAiZcr3RJHkNWVa2wqCcrikX?=
 =?us-ascii?Q?nWazV8mwpL57QJYO8xsSm4X/iK/uC36Aae/IPCuKqxh5H1mempu+u1XKAElH?=
 =?us-ascii?Q?GEVTpM6ToGX7Uv9/uxGWLahJAlFCcQELvVK8EmKtGu9lbAqJ92cGTio2iYd4?=
 =?us-ascii?Q?5ut7k1F1cr54vwE3BsjvH+vQ6gryYSP0VpkfdxAmTXeUSL1Hiw27GN9xnCpc?=
 =?us-ascii?Q?SYOWGqKyyqWBGQ4X+xcHOFzwtpj8wX4aHUcOaaP5rIHwpUoyqR/iSfmdSMQl?=
 =?us-ascii?Q?HVG2fx+Kf+R1g+/kyX2TMf6nGG9HngVillmGWbh6i67mXTFn5NBnmTLCkp8O?=
 =?us-ascii?Q?sc90hhaUHJHtP26C7Cd7mKeQ5PJNnW3NhZsDTFRZ7QvB0abifmTEJPL/gBK6?=
 =?us-ascii?Q?NnLI/9LOnZf4D80T6GLhFyAsFBWUBVdvCt2RHxc7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de557f3d-5dc0-495c-5fa4-08dd56cc3d31
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 01:15:35.9479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JG6TqAtyCNd+tZ4BP5J4CSSEGaJ3IlnLiLAYlYMAxdm6N3K5xAItRFIoxFvb0olz5VSEQ+NRO/3kRgVPm4cayA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7704

On Wed, Feb 26, 2025 at 11:45:09AM -0500, Laurentiu Mihalcea wrote:
>From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
>Correct the parent of the AUDIOMIX DSP and OCRAM_A clock gates by setting
>it to AUDIO_AXI_CLK_ROOT, instead of AUDIO_AHB_CLK_ROOT. Additionally, set
>the frequency of AUDIO_AXI_CLK_ROOT to 800MHz instead of the current
>400MHz.
>
>---
>Changes in v3:
>* add missing Fixes tag for binding patch
>* improve the commit message of the binding patch
>* link to v2: https://lore.kernel.org/imx/20250221190929.31469-1-laurentiumihalcea111@gmail.com/
>
>Changes in v2:
>* add Fixes tags
>* add Iulia's R-b
>* link to v1: https://lore.kernel.org/imx/20250217165718.74619-1-laurentiumihalcea111@gmail.com/
>---
>
>Laurentiu Mihalcea (4):
>  dt-bindings: clock: imx8mp: add axi clock
>  clk: clk-imx8mp-audiomix: fix dsp/ocram_a clock parents
>  arm64: dts: imx8mp: add AUDIO_AXI_CLK_ROOT to AUDIOMIX block
>  arm64: dts: imx8mp: change AUDIO_AXI_CLK_ROOT freq. to 800MHz
>
> .../devicetree/bindings/clock/imx8mp-audiomix.yaml     | 10 ++++++----
> arch/arm64/boot/dts/freescale/imx8mp.dtsi              |  7 ++++---
> drivers/clk/imx/clk-imx8mp-audiomix.c                  |  6 +++---
> 3 files changed, 13 insertions(+), 10 deletions(-)

For the patchset:
Reviewed-by: Peng Fan <peng.fan@nxp.com>

>
>-- 
>2.34.1
>

