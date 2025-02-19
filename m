Return-Path: <linux-kernel+bounces-522511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DD2A3CB42
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C41DB16C6EE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133D7257425;
	Wed, 19 Feb 2025 21:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Md6NnNQD"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2088.outbound.protection.outlook.com [40.107.247.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B6924FC0D;
	Wed, 19 Feb 2025 21:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739999969; cv=fail; b=HSxe2ZS8Y2YwHdf5BTZwB4i6PRbmgMS0h+N0Z1bZKozKF0QzP0sw1Z/B2J4luz+tsenvPQ4LqCitgmhOlt+2phIShqe4yn9fokAngaoW5T5SvBn+LEWNtTBExvSZ5FaL5h5CkO2UMqVKBf3Vr0Gsw0XHsDhUyW70fxS6y0bo7y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739999969; c=relaxed/simple;
	bh=TfcQFtjb7tyocdZyAdfdIpXyoP2xxhYTzbbWk1g/X9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EzctO2w6st+RPMh/6T+FpckoKzSKekOL9Hab4QFNGFfhjFTWbKVQdPZ2gBGIUOat+C/TDo1D9ZIRxjVAti1HjWZ6U5iVl7aSVBhHPGR1LUAAoagcPU2AQIv8HS33HQpBuYeviQyfRLNOo4INv3QePRy1BFN8x8XDKW5Uhbsd+dQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Md6NnNQD; arc=fail smtp.client-ip=40.107.247.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s0hR+SDncxRPnghTDmRfVfBkNHg3QeBU6S6cNfR8VCDDTC5PWrm26YjunQ1z6ISchU8VKr6yr8BRAPMRr9Foz7Jbd7dPbdJHHkiwbc88fy2q/i2YtS9Znot26kdOy+5SgLeyiI7LQGWQd0NVQry+6aHT91GFHZyb4HNq4CFXsoi7Ik44L5YOs5YVMZThbAxbsJvUtTNCnT/pZekOzVbdwYKWX56/L2RSpILc2cQOpDvgAb7ydjwuWu8H/u5IHWAK22Ga6tjv5lqdGNuZGI7T0EvO/pMzEFl1ORZtrb6e6I2Wc67xaT+HmN+52+gxhYGkwRo1cSaq76mSiM2euy+0TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rDyxiOunpG8RZdFESpT3ouUfxWTugOAneKlopBL7rY=;
 b=Ilx3lUP5iag1YX46sqbxASNEJZfFLy2sv4qyG4txfgRuC9Fyd5Lq9AXRFaUQyYMKk1Csh0QxAHSpXBPzwtTrhvuSJC0mQ6Bgz0rePI7BJWhuCHE/vaEegqPv78a/XbtMLMTjvlH3Cer4oXbfuEu12OgwMUxLa8V3ougtGrh/0nX08RHdLtv4SdjTl06KdOE/3YYp8qwPMIRL8tL1h02NkxMCjMEz+3+MGoJrSsrk/YIHvY7tiPVVE5vXmJQVa2uaUN/3YDeBNEHMXuIc36RmTHjYDiwotFR0p+tabBwveKRAIoHZbw4k7N2dEbL3MUzSZ9U3lrjyfK+Jq1NdL2mR3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rDyxiOunpG8RZdFESpT3ouUfxWTugOAneKlopBL7rY=;
 b=Md6NnNQD1MMK80iTqGUXj79P+A3CFUhjLoCOXPMQKSe+hKsLiLdgUItBxMXP0kxLmsbacL1gsOaYvV0VPIz6xBVfmRq0Vl0vsSoHA8/G2m1BDhIElYoGJw3B3nXGsWeQlelcy/5DNXUGEvzqAoDUutq5wzCmQuyOs/EpFaNZHx1N6Vq8d/X+0b1q7yvpcNM5Tvbdsj13zS59aYSuP2Or9Nh22O7kuOzebogeU0h0Fvq709S2oQgozJJ8j+yUQlFxLa05Zu/1sKUyAVZnwnWblY9m3OF4vMo/8UFrBAR7NRcN/lDJvKOOBeAhYqe0MzaK7z0ZiLJQhv8jKUXTmK0YSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8215.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Wed, 19 Feb
 2025 21:19:25 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 21:19:24 +0000
Date: Wed, 19 Feb 2025 16:19:15 -0500
From: Frank Li <Frank.li@nxp.com>
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: p.zabel@pengutronix.de, robh@kernel.org, shawnguo@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	mathieu.poirier@linaro.org, shengjiu.wang@nxp.com, peng.fan@nxp.com,
	laurentiu.mihalcea@nxp.com, iuliana.prodan@nxp.com
Subject: Re: [PATCH v2 1/8] dt-bindings: reset: audiomix: Add reset ids for
 EARC and DSP
Message-ID: <Z7ZK0/Nk/ANBPIkd@lizhi-Precision-Tower-5810>
References: <20250219192102.423850-1-daniel.baluta@nxp.com>
 <20250219192102.423850-2-daniel.baluta@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219192102.423850-2-daniel.baluta@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0145.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8215:EE_
X-MS-Office365-Filtering-Correlation-Id: ed1a9e8d-fc9e-4712-60b6-08dd512b15d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1HB+Rl+TH5pNS0sAx5uhWburdic6Cg8I3OoKdJsxIR8njna3cNaqzRvi1rM/?=
 =?us-ascii?Q?bf1aTpY4ZrRLnvGFbMpMYopE8Pir0Fu3bqMCu2ATpE2HXOVbp5XT6szfW4u7?=
 =?us-ascii?Q?DFDG7C8r5Ansv9partKQ+GQ6X/+LYYc4lZOJzn5txoI4IlYpAhbmqtxBMmOk?=
 =?us-ascii?Q?R27K7j2coj5ZWnxLXvqkwMH4OBggM4Gws2K0Enpmcp+mtnYJxRceRo45hjpk?=
 =?us-ascii?Q?k/HUQw0V/tfrJuVqejHZuC8hJrqg9CWkEZLWRMujN6yifxqTxF95NbwnUTXO?=
 =?us-ascii?Q?kFu/rHO6nRis3XQobxK4cUN+wsxfprq/Y9hb73UxDe+jYqtDCfk95rkzX529?=
 =?us-ascii?Q?X3C6ont51tpvK9R34woNb7ABU+XegYdwnaDobLs07JtojG5imGLIYgNdhQdI?=
 =?us-ascii?Q?RBqpfyS+jN9RFsnqEvTeYMi5QPvzFgj6KoIPI5vMsVfrxGIFpnWu9e/35kRt?=
 =?us-ascii?Q?wRuYtn6B7iYMEYUg9JUaCGbwszEgd/5Z2mmh4mLBha94IHRED9e8skoUsagw?=
 =?us-ascii?Q?vPg/6GjuA9+9JuditEoYBuuEiSHHWpDB/Px/c4Gej5CCC6FvZ6V8G8s5sfA3?=
 =?us-ascii?Q?hwYn5g6kwe8LjXpW4HorO4FZrriTH2Y1cqt5qStaYO4eiUTqJKdtXr74vFOq?=
 =?us-ascii?Q?1WDae5mlmvQD7JPhRfDJ9UJgGMHo81a81zbIg9FaalVZtGC0zeOi/obq1G8m?=
 =?us-ascii?Q?RlWk5RQ/L3wlM1RyLg5I3kU6D7HLb/utiwwLUc08w10rcBL7B/u/yF3X4WHu?=
 =?us-ascii?Q?3Odu8dEC3mbif9XIhHRtaLP4JadP0BMrOr6TXwYpJ98o8Sr5WixTxFwl2Pog?=
 =?us-ascii?Q?CudMp7XfbFiGz+9PVZfd7Ju/qZlinG0cxmO2uWtRYXd1thLHzK1wKrXDIQdG?=
 =?us-ascii?Q?OUSQeUji6vBPiZtB3BkH7iejwAB4Hu7+pw6VnfYndwpmTG6FoT4bgU8sQjIV?=
 =?us-ascii?Q?0KNF8HDFdJpKNJw2tns7qnq79OLcYXNlPAIAGwFCHNiomIEqCSMFAkmJ4u2K?=
 =?us-ascii?Q?vwFi5vjc86aq0lga0j4Qa8k/WwmxItXCKMT9QF/X+8mfrrtKGX11OR/BDyO9?=
 =?us-ascii?Q?la4Y0b1oiuEpDDuXCgcmwMbMholdZL06qlo2VUEX+gC8o5twIiDtOI0rQyWg?=
 =?us-ascii?Q?dBphGM/eQoJDCWP8sX1QOueinQXbY0nsgwdkwaFcDNS2+mGEFAiBWgeWuir5?=
 =?us-ascii?Q?bBd9cqFEDpRywhSoy/IXTrIhwVXIiq83AKhQU7OkNqo/yhb5xmLKfhLoirsu?=
 =?us-ascii?Q?892m8aE/Y394OZm99HQnyijpIAVQ6WXraAPZztbM1JtK98OakxAQVj/cRDiR?=
 =?us-ascii?Q?65rcVF7f7whEELTvq9rfPwvqxb3xrcE+wFyNT29EBLqeYKpGmFYZ98GoT0PJ?=
 =?us-ascii?Q?5MIDw0LjQMLR9rjGqtOQK83Ya87xiENUBmt/4443Gay9KY4VYj5V/fNzsQDB?=
 =?us-ascii?Q?bG0b2w9ksAJh7kD9L2VZvKaX8xvUDyaJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2UH7i52/BVmQyMC9FeDdXEXNZX8K4vIYhlQGGY6Acm88L3uP0dW0+M8Xrh9U?=
 =?us-ascii?Q?gYxSPU1MkRXi7Qn2BmLDI11t3sYfwLQS2rvT/LFjTY135oZAgA56O4uySrrr?=
 =?us-ascii?Q?yOHwLDzDUl0U0J1XRrEVRZY3eks1hoJ3OLSTt87xTLx+0Xz80Loc6vQTWpZw?=
 =?us-ascii?Q?+dR2FzyyH+KSU4uBMji9ZC1nRuGgMvy1HI/crPQGG+Lbvads9pSvfM47UTd3?=
 =?us-ascii?Q?bI8mIL10a8g3I+rL0bWQRP3c84M0YlRmCX6qfGbPP2E77DguIw3EcRGTn3sa?=
 =?us-ascii?Q?omHyJYAmu0ywEoNIIaW39F1kP8q/tZOXUyRHbNtpR5OKhjLHUWxItp3719KJ?=
 =?us-ascii?Q?ZsOQEku04EqOtP3xHctzfgSYZ6pdjeaDjY4KWMVWvTldGPo7fAHWrOh3mASO?=
 =?us-ascii?Q?DW97XintbRQQCYhhrwvw8+TH6E+ilqxQenhk6BvMIkYjL5yqmDlW5BZUG2te?=
 =?us-ascii?Q?T8nAsaC4oaf3QKUiLHlrGUndGIJ8qbmlnh9aR9A9ki9+slhRMuS7MhjbO/n6?=
 =?us-ascii?Q?oBwcHN3DnHbdcmSKI4Wv8qTiaDYZJLSMUdA3l9p3G4x1d5aKI/Ji4IQXPE+1?=
 =?us-ascii?Q?qlgy7os5a84xZeurtzU9k7rkHZ6QqpiX3gsRPxTyDMvsAa76boTPDv4aRlGi?=
 =?us-ascii?Q?0iDZjQ7LdWmlAhqGGJs2WKEqixHZFu8gKxu49fbKMhLs8q6wHbyPUDIDTlNM?=
 =?us-ascii?Q?gch0QOu6D9j3AsnWrVPGJN+oMmFqcPyl12/CXIvvbZE0dC08/zV7kYcJw0oQ?=
 =?us-ascii?Q?V4+N7cacavl3ssLE1dFO3f2MKN5gxRrdX8h/5rvvxerjJwSrJMnEzF1HQ/4H?=
 =?us-ascii?Q?zfhAk8ISdfa+KXQztawwn27YCRCXVNwukmQw45bj8r8POLIEnWUNz1Vzj8SF?=
 =?us-ascii?Q?JRFTQDOhZwk7ZmPyxSAuyN5uYuUZ3xLs8V6YJvmyQ0UndtZvMMdcm5aFtEe1?=
 =?us-ascii?Q?fwfiWbmzaybSi7iy+EWvyMia7rGF4BKUOz0Pc73y1b7ARyrb1LsuBqiRUkzg?=
 =?us-ascii?Q?8p0th9SH9MbUJqebc0a0GWAtFPHrhZ3hWedq2BXMDfGfWm/X1fLG6p2/3KYb?=
 =?us-ascii?Q?+/bvJO6oTlj1vdsj4fFDUtvQihP07Vs7UXLeDsDlY1VcH4Rmi3OmrpzP01SR?=
 =?us-ascii?Q?QFlCgRSBxg7jPCytFiKDK4tGekGRiKZPIbgoMjb0Gdqdy8jSQ4L/a32Ziapt?=
 =?us-ascii?Q?PBUm4kUJ4xfJTN7jB1zPnlAoWbWAUg140ADR7X0TAAfJ0An4klDewPmqla/W?=
 =?us-ascii?Q?B83OrTN6BRETzHOrBMocyrwsmNP1b1STLryy2vr75VUQI3nsMES8wy4+nvze?=
 =?us-ascii?Q?W/UAR0RehT6A5tOLBx3E2uNt1A4g1jM3ohotqO81cmEWjXNvlVzAJtfmRUOF?=
 =?us-ascii?Q?crDw/F3HQbL1Q+7fS9021Vvfa07jGywPpbVxAGR+e+kWZEZBbcWAiGO1E94f?=
 =?us-ascii?Q?yT6OMv5FjyhpnMXIF6W9ohFsSFjVVfHo1Z7GiFxlXakwuAsE9EQ49c+UrJ2/?=
 =?us-ascii?Q?GPCIxEcv/yQto9m4JI2RNofsHdDqPo9JrZVeMxsYflVuc6jamXX1GJ5k9YWp?=
 =?us-ascii?Q?DZZH58GqN9C3KTOvcrYkoqmvrrCilDH4FZwMS8Bg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1a9e8d-fc9e-4712-60b6-08dd512b15d5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 21:19:24.9208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gAbjymHF7MfL4FjEpGt6bOTNd3aqyNoUPkwxvdflJn5Vjtut7yd6fqdHKsLkK9QJrHviB5NBwVq0Wv+MzTerBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8215

On Wed, Feb 19, 2025 at 09:20:55PM +0200, Daniel Baluta wrote:
> Add reset ids used for EARC and DSP on i.MX8MP platform.
>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  include/dt-bindings/reset/imx8mp-reset-audiomix.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 include/dt-bindings/reset/imx8mp-reset-audiomix.h
>
> diff --git a/include/dt-bindings/reset/imx8mp-reset-audiomix.h b/include/dt-bindings/reset/imx8mp-reset-audiomix.h
> new file mode 100644
> index 000000000000..3349bf311764
> --- /dev/null
> +++ b/include/dt-bindings/reset/imx8mp-reset-audiomix.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
> +/*
> + * Copyright 2025 NXP
> + */
> +
> +#ifndef DT_BINDING_RESET_IMX8MP_AUDIOMIX_H
> +#define DT_BINDING_RESET_IMX8MP_AUDIOMIX_H
> +
> +#define IMX8MP_AUDIOMIX_EARC		0
> +#define IMX8MP_AUDIOMIX_EARC_PHY	1
> +#define IMX8MP_AUDIOMIX_DSP		2
> +
> +#endif /* DT_BINDING_RESET_IMX8MP_AUDIOMIX_H */
> --
> 2.25.1
>

