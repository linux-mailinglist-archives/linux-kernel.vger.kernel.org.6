Return-Path: <linux-kernel+bounces-413436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1F59D1904
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 20:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F6EB283846
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1FD1E570D;
	Mon, 18 Nov 2024 19:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y3mOIQPU"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2051.outbound.protection.outlook.com [40.107.22.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02691E1312;
	Mon, 18 Nov 2024 19:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731958523; cv=fail; b=dDnbbpsgaPhsLDRVZyTpmvvr9Vih7OiJ0H9jFhIsiXeamd16eoe+V6b8OGurU8ASo2rHJYYJTvSyYjCpLwZc7bt9JWk/DKWDpiotVeYrnSFnYvhJhgIjDacWkg5Ff3/yQ2Z7Qs+g+n3w8wkUToQeDIcxlkXOfzUcMTyI0atBPck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731958523; c=relaxed/simple;
	bh=9R3aMlgOCp3QpC0YWnvFIeEC382ISTtl1SalpWZHt0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X+WgBx3Zi+vMjW+4w7muEm3f7rEkdWusGU1c5Pq8ydnDhqe4CD06vo453xDAZvlnoQaQzjyLrIa8nbaOINp9AARJdrFiGDact9dafKQRKd5V6cYJ0TwzE+FJxm+XZFxikpk1+RDs67vTHo8BVn8eDG+dR2Vwx+Km5y14B2wP2l0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y3mOIQPU; arc=fail smtp.client-ip=40.107.22.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XjMPBipzhOAq6/KaUX7jEYg7aTX1xIDarUsPNFWYcGapn7fZJId17AsmuE5ugBSnzKcmYyUITnMxJm5J69Y+g9g8arCgqMnqvO4dtLjfotQqVMjhg7GjMrkzRKED89EpStrF2BRC3SaVXyymGvM4FKWkXqg4mJx5Cpjuh2dbgFErTh2+Hxzk/GFy0rMzHhfv8nH7nrqrf9D/X6+tN8ND0LidZ6op9yM5dxHqt0dAmNbIlAwTEzXTqj5IHpzUYq9r3+F+llyK8m2qwVVuYEFly8Sun5eWynLM9mdsqDoeiEYzEkW7AsvdnoHO8ieEl+fEYHkJNUF7lSxT0rsjEjftMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvGEweNhe1/pKdUtJqt+QQhaVQI2OZWZAu1khBsN3GA=;
 b=Zb7T5puEMJ4qnTyOsvCP4Jm0SgpMwNLMRsNsgNCLGVJRySpd3AtzN6h1ISrgwI01sc+3G3gw++lqCpF388CSwCthIsJfV9EwJ4tfLprWz8OGmV9oL/a5cPvH290NVLjMAF/tp6p5njYV6A0yNsLugGiU7auelZwx4Oie9d+5cySQHhyHB27BkHWePigUBoDOEcjcCNp6xDqhDGsPDxlnpv7rMd0PHxGsus0734top6eXV/ByoitYlIp4JIGgOXoVstVSgqzbA0Cvemc/jw+X3pCUighiJm/lcHtTB2YgU44BDtwVGlKEUJKT1dJzm7JOBPMfcCjmwQo7x0ffElRY9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvGEweNhe1/pKdUtJqt+QQhaVQI2OZWZAu1khBsN3GA=;
 b=Y3mOIQPUPJs8/AJjNZ+sS7fqnDeHxfu+4cLLhIC9gSIpMcj2wr1JZ7r2qR0yfRlaCaShkNlF4f9R1XFuqH08IOnzQxtyYhbrPlm51mGzwiQ0+hz5ZtGD2b8ABM1eDGRwRu3aoTIeb7mIlTWh2sZsNkJZAZMmefztgKALRH2407x4GPfgexXAetMq2KS9n28xmy7AUv2qHCSbqyiLd8ukufszaxuG+3bRxi32qrZpWdYp8jXznnKdqirpomTkUfYVxDOi4wuicNAEzPy4gKm3b28q7Tjqz+k9K1dk0YREJ7Ylu5Lu3RFPn/IoREooqXKTE9kzcQq/pyD4fIwrN0iDIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB11070.eurprd04.prod.outlook.com (2603:10a6:800:264::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 19:35:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 19:35:15 +0000
Date: Mon, 18 Nov 2024 14:35:02 -0500
From: Frank Li <Frank.li@nxp.com>
To: Pengfei Li <pengfei.li_1@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de,
	catalin.marinas@arm.com, will@kernel.org, kernel@pengutronix.de,
	festevam@gmail.com, francesco.dolcini@toradex.com,
	joao.goncalves@toradex.com, marex@denx.de, hvilleneuve@dimonoff.com,
	peng.fan@nxp.com, hiago.franco@toradex.com,
	frieder.schrempf@kontron.de, alexander.stein@ew.tq-group.com,
	mwalle@kernel.org, m.othacehe@gmail.com,
	Max.Merchel@ew.tq-group.com, tharvey@gateworks.com,
	quic_bjorande@quicinc.com, geert+renesas@glider.be,
	dmitry.baryshkov@linaro.org, konradybcio@kernel.org,
	neil.armstrong@linaro.org, arnd@arndb.de, nfraprado@collabora.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	ping.bai@nxp.com, ye.li@nxp.com, aisheng.dong@nxp.com
Subject: Re: [PATCH v2 3/4] arm64: dts: freescale: Add i.MX91 11x11 EVK basic
 support
Message-ID: <ZzuW5o5ThWFXWEs3@lizhi-Precision-Tower-5810>
References: <20241118051541.2621360-1-pengfei.li_1@nxp.com>
 <20241118051541.2621360-4-pengfei.li_1@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118051541.2621360-4-pengfei.li_1@nxp.com>
X-ClientProxiedBy: BYAPR01CA0045.prod.exchangelabs.com (2603:10b6:a03:94::22)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB11070:EE_
X-MS-Office365-Filtering-Correlation-Id: fc45a58f-ca03-4151-ba67-08dd0808208b
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?vPMfcJzhvm6Ln7b8OsIdfEUQQeyU7dGcb2qnlr7x1uPapXK2xtI2ohJNwl34?=
 =?us-ascii?Q?FCj4xMX+tKVUIO5iTRpqKBeqoGMutfVSfuHIfBn6LpWhe+vcfxyUj2RDc9bT?=
 =?us-ascii?Q?L6205EjTt868sG8VjOq7jznZeWhbXfdoSYfL6ghVpcUq1YYog7Wll2E3mDwP?=
 =?us-ascii?Q?hE6DzbWHCQp+wEbKnpzWpQ+4mUEz8auGXG642L2OrpFmFVi8m7/rx17UwcyU?=
 =?us-ascii?Q?sKTnbB/vbQ+nSAhtW0gM+VLknNUNpsXCLqD59gHa9/YfuXqVr5JHdrhrAdpT?=
 =?us-ascii?Q?yu9tkmjTgZEriMvfwidy1/VxB5ce+at6CIZr/PR+QXoAcWedSXTCarEd4f22?=
 =?us-ascii?Q?vM4cQAEGw0dhTw8kChrp+hUeeSLgXvIeuyBPJ4+fwFh6Mx2aEQnJf+c7bUGp?=
 =?us-ascii?Q?JD3YudZvxPC5ZajAr0O0g3bK3wiCNHIvIrEg/yB0xo9nU4YMm7PZnv3mUx5N?=
 =?us-ascii?Q?xMIiBNrs+nqwoDQIcdycIOkDpS+S88NcYFEOYelje6K8Rlk7GHt+1VjQ6i3A?=
 =?us-ascii?Q?CAyPqVAqVUmzxnLyR0gzodLV5FbkOgLp8cmYvVd5Rx+byLJr26rSeoScSnvf?=
 =?us-ascii?Q?/18C3Q9FYzuMPKn9dTixQcy5h+45OkORbhu7aXHWde8Q0BXZAfNkngS8bjRR?=
 =?us-ascii?Q?/D3GcG3AEY7CibMxicAQ/uVMbY2A7l1qqBJnNNEnTWEFy3VmsX3fUhV/+khi?=
 =?us-ascii?Q?znlqyO2cwuDoO3j0OgzFCTEC0m4QzdjliwHSz28XhoWOMuSU9XUOEASl7gef?=
 =?us-ascii?Q?cPe14IrLFN5div7NKKEsWBLAdLXdXdZGcLRhLVHuK49l2z2BNRqppa483Y05?=
 =?us-ascii?Q?+5PlVnNws1jP6dTpmA42kSZVBzYusvLzSkwsWgjw5iKP2iCMMePY4fYajHvg?=
 =?us-ascii?Q?XVLg5AsfqpoLCFJ0zu3h1fJSHEkFi3XfiuhYWMRYzeNVqRLQwxBHtgVfc4yM?=
 =?us-ascii?Q?ZfkHo6qN7DEL9SC14MPbLS2yeAxshToqOmjL2EgV0Sx4LVzJk1+HWI4gPhg7?=
 =?us-ascii?Q?n2ymMCDC9kqg5Ptf3H88iqMrmfoLnzhYQIKB4o8WMu1d9U+BWZK0T5lidxB0?=
 =?us-ascii?Q?G6HDvz5/s77VMZtbD3VFQp4tyLaylPZ9yEuQyQI8Ww8GUNMUmO2RKnutqku1?=
 =?us-ascii?Q?MSHjaffLiG+gZOSOJ2IUKI4YKJAWvbw5D+qlk6zAPcTizMOZBVCha1X38By2?=
 =?us-ascii?Q?LFKo84cHKWQ1V/HiOoyWyj+Rsjm+Luj57+wAhFELGkcmGSInfdECOGzl21Ne?=
 =?us-ascii?Q?NXQ/otSSPskVCYh6RSwPf/et5Gnm/n8SWr6c3tDaTCkAe3vGo7K2GooSkhQL?=
 =?us-ascii?Q?npDqa5X5uY7wEFs6zAInTg9n?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?7nX7CfEwyQVMMUUuNVY+6ndz1sSLAw3a/ke6QofVZgVK+U7GQuqATeqX+Bfp?=
 =?us-ascii?Q?6zw5nBy0NbGL2UOc1JXOm6TpGM6DjYMsTd/kz28HsddX8ETn4d4GDXEuREGS?=
 =?us-ascii?Q?bSvo5GN4qYGlJ7Uk1CysZrT+ChNk6BQPOJttVVN0MP5Xzdx8lm7g3iyMLwvM?=
 =?us-ascii?Q?jveaF10NDNbjYEClIuTVlC6VeI06jSKpfcnGF/1sh+dnncwbM/VSvxY0QBxV?=
 =?us-ascii?Q?BS93GNUB/IXH5w00qfjt1zeIJknquwLggkZuVsWsp3Ikn9Tfa+G7ok7wvNTj?=
 =?us-ascii?Q?m10MUk0kKNpjZ5h7+V9sU7gXg2oO9gZNRoPCcAiEg2raA9YJO6NpR2RiBXyN?=
 =?us-ascii?Q?YVSnOBofMLYvsbTjrYSMVENG82sZglYKSxraUsX+ZzipOX+HxyxJmK9hLfOW?=
 =?us-ascii?Q?V7xqr9yqFfYTND9lI5DJicItlA5tTg3dzLyOR+2vEalrCp0EfDaCZ0lkVzt0?=
 =?us-ascii?Q?b6OwpwAfu6swACg7UuLhP+dCCoGjTLDEuRVq247mZv/qxOPKL/qjcSazjorL?=
 =?us-ascii?Q?HmWu0JXJzUqHRPK7nU98WFi4WFWsXfGNpXQW6kSWVpyDXz8d1vHCJCdD9e6K?=
 =?us-ascii?Q?Hgq2ye0XT4osNOwDNi6lycEVz/hJ4legs+VtnIgFfjPjJaq8X7hhlneXnSOp?=
 =?us-ascii?Q?t+kT5kLbw9H72T+g5z+8x8rKU/z+UCDzPe91qelrAXo5bHQP1uTOO2ShgVLx?=
 =?us-ascii?Q?Zk6uJymUwxNGs8qEM3zBcrMeAsm3ypmksSGffqNAnOJUkGpswve1f76fOJEZ?=
 =?us-ascii?Q?PJyw27SjFVESIrASqBV1Y1OG+3JjidmPfs4uNManXS8TEDC3eQQFZMSdMtC2?=
 =?us-ascii?Q?6UBLy16ljGZ9LB3AFxhjXFYIjBZ0btGRKJUL7orRok92Alz1WOq1O97aIHaD?=
 =?us-ascii?Q?LlLziiSwjbXX7V/gIoJQgwhqXmcq/PTRstcfysTQgIyfJohQXQfKsLMN/TQb?=
 =?us-ascii?Q?W0ZlaXEPe8d8R8L4t9cBs3/8GJ/fF+FeO24Gzdjv8HAg936Y5boRZ/W/mPLy?=
 =?us-ascii?Q?RJz1ymTJkzD2BWiQaXLJ7LygFtigGz6BK3AXckLyZocOSO0VzUAzpKG1mo4J?=
 =?us-ascii?Q?V8wSKXFlj/jdfpn6/s2MVSt8r4NuNyqbpKy6QK3ReoQGcT2Rik84EZxl/3lH?=
 =?us-ascii?Q?Sz16An8KyrLr8rTc4JH6glOSYwirus9LLNIKAM4C8a1Dvs2gy94fZIJhUipW?=
 =?us-ascii?Q?3MYALQe3q+KxcKjvdOoLz22HapRWmlgZ0vmdmpEKFHFBdJdilwVQZJnP8IO/?=
 =?us-ascii?Q?bsKE2qetug6JBxbQ/ajnpx6mBkEfU4IVzeTQqM1VBowi9TKAvgAmF/Nyh4YB?=
 =?us-ascii?Q?ibejo+HdANcGetLQuVU7z7itPWUd7St2lT64PKK+A29AFlYqa0dcjlmh/5OJ?=
 =?us-ascii?Q?MTsAeyBM3LjDxsaQ6q4gFmUm3vRHCheFwXhiqdm2pvab8RasY3YHY7Jkwc/k?=
 =?us-ascii?Q?S6FYigBJpwAC35slN3FsYZUGaRSrPD3s1dMM1TCKzVE8AvL3wunQ3i+NwRf+?=
 =?us-ascii?Q?dNlo+aAFzOKyzaCRGkUAy/uc87fLfEN0r+eEeJ1StOI1/2O/3UmqBdqeK+PW?=
 =?us-ascii?Q?5Psb4nVRF1A94T/1JB0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc45a58f-ca03-4151-ba67-08dd0808208b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 19:35:15.8154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JNlXTWZ5t9RTmgzkUpS1jO3PsJvhQtiP68FRMT3wnbpy8uKeVujVSENbV30+j39Y7NycbFlcvgi3LksduHR/kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11070

On Mon, Nov 18, 2024 at 01:15:40PM +0800, Pengfei Li wrote:
> Add i.MX91 11x11 EVK board support.
> - Enable ADC1.
> - Enable lpuart1 and lpuart5.
> - Enable network eqos and fec.
> - Enable I2C bus and children nodes under I2C bus.
> - Enable USB and related nodes.
> - Enable uSDHC1 and uSDHC2.
> - Enable Watchdog3.
>
> Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../boot/dts/freescale/imx91-11x11-evk.dts    | 812 ++++++++++++++++++
>  2 files changed, 813 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
>
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 42e6482a31cb..9174c9e215d5 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -256,6 +256,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qxp-colibri-iris-v2.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8qxp-tqma8xqp-mba8xx.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx91-11x11-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx93-9x9-qsb.dtb
>
>  imx93-9x9-qsb-i3c-dtbs += imx93-9x9-qsb.dtb imx93-9x9-qsb-i3c.dtbo
> diff --git a/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
> new file mode 100644
> index 000000000000..309bca672ac2
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
> @@ -0,0 +1,812 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/usb/pd.h>
> +#include "imx91.dtsi"
> +
> +/ {
> +	model = "NXP i.MX91 11X11 EVK board";
> +	compatible = "fsl,imx91-11x11-evk", "fsl,imx91";
> +
> +	aliases {
> +		ethernet0 = &fec;
> +		ethernet1 = &eqos;
> +		rtc0 = &bbnsm_rtc;
> +	};
> +
> +	chosen {
> +		stdout-path = &lpuart1;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		linux,cma {
> +			compatible = "shared-dma-pool";
> +			reusable;
> +			alloc-ranges = <0 0x80000000 0 0x40000000>;
> +			size = <0 0x10000000>;
> +			linux,cma-default;
> +		};
> +	};
> +
> +	reg_vref_1v8: regulator-adc-vref {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vref_1v8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +	};
> +
> +	reg_usdhc2_vmmc: regulator-usdhc2 {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
> +		regulator-name = "VSD_3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
> +		off-on-delay-us = <12000>;
> +		enable-active-high;
> +	};
> +
> +	reg_vdd_12v: regulator-vdd-12v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "reg_vdd_12v";
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +		gpio = <&pcal6524 14 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	reg_vrpi_3v3: regulator-vrpi-3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VRPI_3V3";
> +		gpio = <&pcal6524 2 GPIO_ACTIVE_HIGH>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		enable-active-high;
> +		vin-supply = <&buck4>;
> +	};
> +
> +	reg_vrpi_5v: regulator-vrpi-5v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VRPI_5V";
> +		gpio = <&pcal6524 8 GPIO_ACTIVE_HIGH>;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		enable-active-high;
> +	};
> +
> +	reg_usdhc3_vmmc: regulator-usdhc3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "WLAN_EN";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&pcal6524 20 GPIO_ACTIVE_HIGH>;
> +		/*
> +		 * IW612 wifi chip needs more delay than other wifi chips to complete
> +		 * the host interface initialization after power up, otherwise the
> +		 * internal state of IW612 may be unstable, resulting in the failure of
> +		 * the SDIO3.0 switch voltage.
> +		 */
> +		startup-delay-us = <20000>;
> +		enable-active-high;
> +	};
> +};
> +
> +&adc1 {
> +	vref-supply = <&reg_vref_1v8>;
> +	status = "okay";
> +};
> +
> +&eqos {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&pinctrl_eqos>;
> +	pinctrl-1 = <&pinctrl_eqos_sleep>;
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ethphy1>;
> +	status = "okay";
> +
> +	mdio {
> +		compatible = "snps,dwmac-mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clock-frequency = <5000000>;
> +
> +		ethphy1: ethernet-phy@1 {
> +			reg = <1>;
> +			eee-broken-1000t;
> +		};
> +	};
> +};
> +
> +&fec {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&pinctrl_fec>;
> +	pinctrl-1 = <&pinctrl_fec_sleep>;
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ethphy2>;
> +	fsl,magic-packet;
> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clock-frequency = <5000000>;
> +
> +		ethphy2: ethernet-phy@2 {
> +			reg = <2>;
> +			eee-broken-1000t;
> +		};
> +	};
> +};
> +
> +&lpi2c2 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&pinctrl_lpi2c2>;
> +	pinctrl-1 = <&pinctrl_lpi2c2>;
> +	status = "okay";
> +
> +	pcal6524: gpio@22 {
> +		compatible = "nxp,pcal6524";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pcal6524>;
> +		reg = <0x22>;

reg should be after compatible.

Suggest use https://github.com/lznuaa/dt-format format new dts file.


> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +
> +	pmic@25 {
> +		compatible = "nxp,pca9451a";
> +		reg = <0x25>;
> +		interrupt-parent = <&pcal6524>;
> +		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
> +
> +		regulators {
> +			buck1: BUCK1 {
> +				regulator-name = "BUCK1";
> +				regulator-min-microvolt = <650000>;
> +				regulator-max-microvolt = <2237500>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <3125>;
> +			};
> +
> +			buck2: BUCK2 {
> +				regulator-name = "BUCK2";
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <2187500>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <3125>;
> +			};
> +
> +			buck4: BUCK4{
> +				regulator-name = "BUCK4";
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <3400000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck5: BUCK5{
> +				regulator-name = "BUCK5";
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <3400000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck6: BUCK6 {
> +				regulator-name = "BUCK6";
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <3400000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo1: LDO1 {
> +				regulator-name = "LDO1";
> +				regulator-min-microvolt = <1600000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo4: LDO4 {
> +				regulator-name = "LDO4";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo5: LDO5 {
> +				regulator-name = "LDO5";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +};
> +
> +&lpi2c3 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&pinctrl_lpi2c3>;
> +	pinctrl-1 = <&pinctrl_lpi2c3>;
> +	status = "okay";
> +
> +	ptn5110: tcpc@50 {
> +		compatible = "nxp,ptn5110", "tcpci";
> +		reg = <0x50>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
> +		status = "okay";
> +
> +		typec1_con: connector {
> +			compatible = "usb-c-connector";
> +			label = "USB-C";
> +			power-role = "dual";
> +			data-role = "dual";
> +			try-power-role = "sink";
> +			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
> +			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
> +				     PDO_VAR(5000, 20000, 3000)>;
> +			op-sink-microwatt = <15000000>;
> +			self-powered;
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +
> +					typec1_dr_sw: endpoint {
> +						remote-endpoint = <&usb1_drd_sw>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +
> +	ptn5110_2: tcpc@51 {
> +		compatible = "nxp,ptn5110", "tcpci";
> +		reg = <0x51>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
> +		status = "okay";
> +
> +		typec2_con: connector {
> +			compatible = "usb-c-connector";
> +			label = "USB-C";
> +			power-role = "dual";
> +			data-role = "dual";
> +			try-power-role = "sink";
> +			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
> +			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
> +				     PDO_VAR(5000, 20000, 3000)>;
> +			op-sink-microwatt = <15000000>;
> +			self-powered;
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +
> +					typec2_dr_sw: endpoint {
> +						remote-endpoint = <&usb2_drd_sw>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +
> +	pcf2131: rtc@53 {
> +			compatible = "nxp,pcf2131";
> +			reg = <0x53>;
> +			interrupt-parent = <&pcal6524>;
> +			interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
> +			status = "okay";
> +	};
> +};
> +
> +&lpuart1 { /* console */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	status = "okay";
> +};
> +
> +&lpuart5 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart5>;
> +	status = "okay";
> +};
> +
> +&usbotg1 {
> +	dr_mode = "otg";
> +	hnp-disable;
> +	srp-disable;
> +	adp-disable;
> +	usb-role-switch;
> +	disable-over-current;
> +	samsung,picophy-pre-emp-curr-control = <3>;
> +	samsung,picophy-dc-vol-level-adjust = <7>;
> +	status = "okay";
> +
> +	port {
> +		usb1_drd_sw: endpoint {
> +			remote-endpoint = <&typec1_dr_sw>;
> +		};
> +	};
> +};
> +
> +&usbotg2 {
> +	dr_mode = "otg";
> +	hnp-disable;
> +	srp-disable;
> +	adp-disable;
> +	usb-role-switch;
> +	disable-over-current;
> +	samsung,picophy-pre-emp-curr-control = <3>;
> +	samsung,picophy-dc-vol-level-adjust = <7>;
> +	status = "okay";
> +
> +	port {
> +		usb2_drd_sw: endpoint {
> +			remote-endpoint = <&typec2_dr_sw>;
> +		};
> +	};
> +};
> +
> +&usdhc1 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
> +	bus-width = <8>;
> +	non-removable;
> +	status = "okay";
> +};
> +
> +&usdhc2 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
> +	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-3 = <&pinctrl_usdhc2_sleep>, <&pinctrl_usdhc2_gpio_sleep>;
> +	cd-gpios = <&gpio3 00 GPIO_ACTIVE_LOW>;
> +	vmmc-supply = <&reg_usdhc2_vmmc>;
> +	bus-width = <4>;
> +	status = "okay";
> +	no-sdio;
> +	no-mmc;
> +};
> +
> +&wdog3 {
> +	fsl,ext-reset-output;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_eqos: eqosgrp {
> +		fsl,pins = <
> +			MX91_PAD_ENET1_MDC__ENET1_MDC			0x57e
> +			MX91_PAD_ENET1_MDIO__ENET_QOS_MDIO			0x57e
> +			MX91_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0			0x57e
> +			MX91_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1			0x57e
> +			MX91_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2			0x57e
> +			MX91_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3			0x57e
> +			MX91_PAD_ENET1_RXC__ENET_QOS_RGMII_RXC	0x5fe
> +			MX91_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL		0x57e
> +			MX91_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0			0x57e
> +			MX91_PAD_ENET1_TD1__ENET1_RGMII_TD1			0x57e
> +			MX91_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2			0x57e
> +			MX91_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3			0x57e
> +			MX91_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x5fe
> +			MX91_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL		0x57e
> +		>;
> +	};
> +
> +	pinctrl_eqos_sleep: eqossleepgrp {
> +		fsl,pins = <
> +			MX91_PAD_ENET1_MDC__GPIO4_IO0				0x31e
> +			MX91_PAD_ENET1_MDIO__GPIO4_IO1				0x31e
> +			MX91_PAD_ENET1_RD0__GPIO4_IO10                          0x31e
> +			MX91_PAD_ENET1_RD1__GPIO4_IO11				0x31e
> +			MX91_PAD_ENET1_RD2__GPIO4_IO12				0x31e
> +			MX91_PAD_ENET1_RD3__GPIO4_IO13				0x31e
> +			MX91_PAD_ENET1_RXC__GPIO4_IO9                          0x31e
> +			MX91_PAD_ENET1_RX_CTL__GPIO4_IO8			0x31e
> +			MX91_PAD_ENET1_TD0__GPIO4_IO5                          0x31e
> +			MX91_PAD_ENET1_TD1__GPIO4_IO4                          0x31e
> +			MX91_PAD_ENET1_TD2__GPIO4_IO3				0x31e
> +			MX91_PAD_ENET1_TD3__GPIO4_IO3				0x31e
> +			MX91_PAD_ENET1_TXC__GPIO4_IO7                          0x31e
> +			MX91_PAD_ENET1_TX_CTL__GPIO4_IO6                       0x31e
> +		>;
> +	};
> +
> +	pinctrl_fec: fecgrp {
> +		fsl,pins = <
> +			MX91_PAD_ENET2_MDC__ENET2_MDC			0x57e
> +			MX91_PAD_ENET2_MDIO__ENET2_MDIO			0x57e
> +			MX91_PAD_ENET2_RD0__ENET2_RGMII_RD0		0x57e
> +			MX91_PAD_ENET2_RD1__ENET2_RGMII_RD1		0x57e
> +			MX91_PAD_ENET2_RD2__ENET2_RGMII_RD2		0x57e
> +			MX91_PAD_ENET2_RD3__ENET2_RGMII_RD3		0x57e
> +			MX91_PAD_ENET2_RXC__ENET2_RGMII_RXC		0x5fe
> +			MX91_PAD_ENET2_RX_CTL__ENET2_RGMII_RX_CTL	0x57e
> +			MX91_PAD_ENET2_TD0__ENET2_RGMII_TD0		0x57e
> +			MX91_PAD_ENET2_TD1__ENET2_RGMII_TD1		0x57e
> +			MX91_PAD_ENET2_TD2__ENET2_RGMII_TD2		0x57e
> +			MX91_PAD_ENET2_TD3__ENET2_RGMII_TD3		0x57e
> +			MX91_PAD_ENET2_TXC__ENET2_RGMII_TXC		0x5fe
> +			MX91_PAD_ENET2_TX_CTL__ENET2_RGMII_TX_CTL	0x57e
> +		>;
> +	};
> +
> +	pinctrl_fec_sleep: fecsleepgrp {
> +		fsl,pins = <
> +			MX91_PAD_ENET2_MDC__GPIO4_IO14			0x51e
> +			MX91_PAD_ENET2_MDIO__GPIO4_IO15			0x51e
> +			MX91_PAD_ENET2_RD0__GPIO4_IO24			0x51e
> +			MX91_PAD_ENET2_RD1__GPIO4_IO25			0x51e
> +			MX91_PAD_ENET2_RD2__GPIO4_IO26			0x51e
> +			MX91_PAD_ENET2_RD3__GPIO4_IO27			0x51e
> +			MX91_PAD_ENET2_RXC__GPIO4_IO23                  0x51e
> +			MX91_PAD_ENET2_RX_CTL__GPIO4_IO22		0x51e
> +			MX91_PAD_ENET2_TD0__GPIO4_IO19			0x51e
> +			MX91_PAD_ENET2_TD1__GPIO4_IO18			0x51e
> +			MX91_PAD_ENET2_TD2__GPIO4_IO17			0x51e
> +			MX91_PAD_ENET2_TD3__GPIO4_IO16			0x51e
> +			MX91_PAD_ENET2_TXC__GPIO4_IO21                  0x51e
> +			MX91_PAD_ENET2_TX_CTL__GPIO4_IO20               0x51e
> +		>;
> +	};
> +
> +	pinctrl_flexcan2: flexcan2grp {
> +		fsl,pins = <
> +			MX91_PAD_GPIO_IO25__CAN2_TX	0x139e
> +			MX91_PAD_GPIO_IO27__CAN2_RX	0x139e
> +		>;
> +	};
> +	pinctrl_flexcan2_sleep: flexcan2sleepgrp {
> +		fsl,pins = <
> +			MX91_PAD_GPIO_IO25__GPIO2_IO25  0x31e
> +			MX91_PAD_GPIO_IO27__GPIO2_IO27	0x31e
> +		>;
> +	};
> +
> +	pinctrl_lcdif: lcdifgrp {
> +		fsl,pins = <
> +			MX91_PAD_GPIO_IO00__MEDIAMIX_DISP_CLK		0x31e
> +			MX91_PAD_GPIO_IO01__MEDIAMIX_DISP_DE		0x31e
> +			MX91_PAD_GPIO_IO02__MEDIAMIX_DISP_VSYNC		0x31e
> +			MX91_PAD_GPIO_IO03__MEDIAMIX_DISP_HSYNC		0x31e
> +			MX91_PAD_GPIO_IO04__MEDIAMIX_DISP_DATA0		0x31e
> +			MX91_PAD_GPIO_IO05__MEDIAMIX_DISP_DATA1		0x31e
> +			MX91_PAD_GPIO_IO06__MEDIAMIX_DISP_DATA2		0x31e
> +			MX91_PAD_GPIO_IO07__MEDIAMIX_DISP_DATA3		0x31e
> +			MX91_PAD_GPIO_IO08__MEDIAMIX_DISP_DATA4		0x31e
> +			MX91_PAD_GPIO_IO09__MEDIAMIX_DISP_DATA5		0x31e
> +			MX91_PAD_GPIO_IO10__MEDIAMIX_DISP_DATA6		0x31e
> +			MX91_PAD_GPIO_IO11__MEDIAMIX_DISP_DATA7		0x31e
> +			MX91_PAD_GPIO_IO12__MEDIAMIX_DISP_DATA8		0x31e
> +			MX91_PAD_GPIO_IO13__MEDIAMIX_DISP_DATA9		0x31e
> +			MX91_PAD_GPIO_IO14__MEDIAMIX_DISP_DATA10	0x31e
> +			MX91_PAD_GPIO_IO15__MEDIAMIX_DISP_DATA11	0x31e
> +			MX91_PAD_GPIO_IO16__MEDIAMIX_DISP_DATA12	0x31e
> +			MX91_PAD_GPIO_IO17__MEDIAMIX_DISP_DATA13	0x31e
> +			MX91_PAD_GPIO_IO18__MEDIAMIX_DISP_DATA14	0x31e
> +			MX91_PAD_GPIO_IO19__MEDIAMIX_DISP_DATA15	0x31e
> +			MX91_PAD_GPIO_IO20__MEDIAMIX_DISP_DATA16	0x31e
> +			MX91_PAD_GPIO_IO21__MEDIAMIX_DISP_DATA17	0x31e
> +			MX91_PAD_GPIO_IO27__GPIO2_IO27			0x31e
> +		>;
> +	};
> +
> +	pinctrl_lcdif_gpio: lcdifgpiogrp {
> +		fsl,pins = <
> +			MX91_PAD_GPIO_IO00__GPIO2_IO0			0x51e
> +			MX91_PAD_GPIO_IO01__GPIO2_IO1			0x51e
> +			MX91_PAD_GPIO_IO02__GPIO2_IO2			0x51e
> +			MX91_PAD_GPIO_IO03__GPIO2_IO3			0x51e
> +		>;
> +	};
> +
> +	pinctrl_lpi2c1: lpi2c1grp {
> +		fsl,pins = <
> +			MX91_PAD_I2C1_SCL__LPI2C1_SCL			0x40000b9e
> +			MX91_PAD_I2C1_SDA__LPI2C1_SDA			0x40000b9e
> +		>;
> +	};
> +
> +	pinctrl_lpi2c2: lpi2c2grp {
> +		fsl,pins = <
> +			MX91_PAD_I2C2_SCL__LPI2C2_SCL			0x40000b9e
> +			MX91_PAD_I2C2_SDA__LPI2C2_SDA			0x40000b9e
> +		>;
> +	};
> +
> +	pinctrl_lpi2c3: lpi2c3grp {
> +		fsl,pins = <
> +			MX91_PAD_GPIO_IO28__LPI2C3_SDA			0x40000b9e
> +			MX91_PAD_GPIO_IO29__LPI2C3_SCL			0x40000b9e
> +		>;
> +	};
> +
> +	pinctrl_pcal6524: pcal6524grp {
> +		fsl,pins = <
> +			MX91_PAD_CCM_CLKO2__GPIO3_IO27			0x31e
> +		>;
> +	};
> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			MX91_PAD_UART1_RXD__LPUART1_RX			0x31e
> +			MX91_PAD_UART1_TXD__LPUART1_TX			0x31e
> +		>;
> +	};
> +
> +	pinctrl_uart5: uart5grp {
> +		fsl,pins = <
> +			MX91_PAD_DAP_TDO_TRACESWO__LPUART5_TX	0x31e
> +			MX91_PAD_DAP_TDI__LPUART5_RX		0x31e
> +			MX91_PAD_DAP_TMS_SWDIO__LPUART5_RTS_B	0x31e
> +			MX91_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B	0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins = <
> +			MX91_PAD_SD1_CLK__USDHC1_CLK		0x1582
> +			MX91_PAD_SD1_CMD__USDHC1_CMD		0x1382
> +			MX91_PAD_SD1_DATA0__USDHC1_DATA0	0x1382
> +			MX91_PAD_SD1_DATA1__USDHC1_DATA1	0x1382
> +			MX91_PAD_SD1_DATA2__USDHC1_DATA2	0x1382
> +			MX91_PAD_SD1_DATA3__USDHC1_DATA3	0x1382
> +			MX91_PAD_SD1_DATA4__USDHC1_DATA4	0x1382
> +			MX91_PAD_SD1_DATA5__USDHC1_DATA5	0x1382
> +			MX91_PAD_SD1_DATA6__USDHC1_DATA6	0x1382
> +			MX91_PAD_SD1_DATA7__USDHC1_DATA7	0x1382
> +			MX91_PAD_SD1_STROBE__USDHC1_STROBE	0x1582
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
> +		fsl,pins = <
> +			MX91_PAD_SD1_CLK__USDHC1_CLK		0x158e
> +			MX91_PAD_SD1_CMD__USDHC1_CMD		0x138e
> +			MX91_PAD_SD1_DATA0__USDHC1_DATA0	0x138e
> +			MX91_PAD_SD1_DATA1__USDHC1_DATA1	0x138e
> +			MX91_PAD_SD1_DATA2__USDHC1_DATA2	0x138e
> +			MX91_PAD_SD1_DATA3__USDHC1_DATA3	0x138e
> +			MX91_PAD_SD1_DATA4__USDHC1_DATA4	0x138e
> +			MX91_PAD_SD1_DATA5__USDHC1_DATA5	0x138e
> +			MX91_PAD_SD1_DATA6__USDHC1_DATA6	0x138e
> +			MX91_PAD_SD1_DATA7__USDHC1_DATA7	0x138e
> +			MX91_PAD_SD1_STROBE__USDHC1_STROBE	0x158e
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
> +		fsl,pins = <
> +			MX91_PAD_SD1_CLK__USDHC1_CLK		0x15fe
> +			MX91_PAD_SD1_CMD__USDHC1_CMD		0x13fe
> +			MX91_PAD_SD1_DATA0__USDHC1_DATA0	0x13fe
> +			MX91_PAD_SD1_DATA1__USDHC1_DATA1	0x13fe
> +			MX91_PAD_SD1_DATA2__USDHC1_DATA2	0x13fe
> +			MX91_PAD_SD1_DATA3__USDHC1_DATA3	0x13fe
> +			MX91_PAD_SD1_DATA4__USDHC1_DATA4	0x13fe
> +			MX91_PAD_SD1_DATA5__USDHC1_DATA5	0x13fe
> +			MX91_PAD_SD1_DATA6__USDHC1_DATA6	0x13fe
> +			MX91_PAD_SD1_DATA7__USDHC1_DATA7	0x13fe
> +			MX91_PAD_SD1_STROBE__USDHC1_STROBE	0x15fe
> +		>;
> +	};
> +
> +	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
> +		fsl,pins = <
> +			MX91_PAD_SD2_RESET_B__GPIO3_IO7	0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
> +		fsl,pins = <
> +			MX91_PAD_SD2_CD_B__GPIO3_IO0		0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_gpio_sleep: usdhc2gpiosleepgrp {
> +		fsl,pins = <
> +			MX91_PAD_SD2_CD_B__GPIO3_IO0		0x51e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2: usdhc2grp {
> +		fsl,pins = <
> +			MX91_PAD_SD2_CLK__USDHC2_CLK		0x1582
> +			MX91_PAD_SD2_CMD__USDHC2_CMD		0x1382
> +			MX91_PAD_SD2_DATA0__USDHC2_DATA0	0x1382
> +			MX91_PAD_SD2_DATA1__USDHC2_DATA1	0x1382
> +			MX91_PAD_SD2_DATA2__USDHC2_DATA2	0x1382
> +			MX91_PAD_SD2_DATA3__USDHC2_DATA3	0x1382
> +			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
> +		fsl,pins = <
> +			MX91_PAD_SD2_CLK__USDHC2_CLK		0x158e
> +			MX91_PAD_SD2_CMD__USDHC2_CMD		0x138e
> +			MX91_PAD_SD2_DATA0__USDHC2_DATA0	0x138e
> +			MX91_PAD_SD2_DATA1__USDHC2_DATA1	0x138e
> +			MX91_PAD_SD2_DATA2__USDHC2_DATA2	0x138e
> +			MX91_PAD_SD2_DATA3__USDHC2_DATA3	0x138e
> +			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
> +		fsl,pins = <
> +			MX91_PAD_SD2_CLK__USDHC2_CLK		0x15fe
> +			MX91_PAD_SD2_CMD__USDHC2_CMD		0x13fe
> +			MX91_PAD_SD2_DATA0__USDHC2_DATA0	0x13fe
> +			MX91_PAD_SD2_DATA1__USDHC2_DATA1	0x13fe
> +			MX91_PAD_SD2_DATA2__USDHC2_DATA2	0x13fe
> +			MX91_PAD_SD2_DATA3__USDHC2_DATA3	0x13fe
> +			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_sleep: usdhc2sleepgrp {
> +		fsl,pins = <
> +			MX91_PAD_SD2_CLK__GPIO3_IO1            0x51e
> +			MX91_PAD_SD2_CMD__GPIO3_IO2		0x51e
> +			MX91_PAD_SD2_DATA0__GPIO3_IO3		0x51e
> +			MX91_PAD_SD2_DATA1__GPIO3_IO4		0x51e
> +			MX91_PAD_SD2_DATA2__GPIO3_IO5		0x51e
> +			MX91_PAD_SD2_DATA3__GPIO3_IO6		0x51e
> +			MX91_PAD_SD2_VSELECT__GPIO3_IO19	0x51e
> +		>;
> +	};
> +
> +	pinctrl_usdhc3: usdhc3grp {
> +		fsl,pins = <
> +			MX91_PAD_SD3_CLK__USDHC3_CLK		0x1582
> +			MX91_PAD_SD3_CMD__USDHC3_CMD		0x1382
> +			MX91_PAD_SD3_DATA0__USDHC3_DATA0	0x1382
> +			MX91_PAD_SD3_DATA1__USDHC3_DATA1	0x1382
> +			MX91_PAD_SD3_DATA2__USDHC3_DATA2	0x1382
> +			MX91_PAD_SD3_DATA3__USDHC3_DATA3	0x1382
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
> +		fsl,pins = <
> +			MX91_PAD_SD3_CLK__USDHC3_CLK		0x158e
> +			MX91_PAD_SD3_CMD__USDHC3_CMD		0x138e
> +			MX91_PAD_SD3_DATA0__USDHC3_DATA0	0x138e
> +			MX91_PAD_SD3_DATA1__USDHC3_DATA1	0x138e
> +			MX91_PAD_SD3_DATA2__USDHC3_DATA2	0x138e
> +			MX91_PAD_SD3_DATA3__USDHC3_DATA3	0x138e
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
> +		fsl,pins = <
> +			MX91_PAD_SD3_CLK__USDHC3_CLK		0x15fe
> +			MX91_PAD_SD3_CMD__USDHC3_CMD		0x13fe
> +			MX91_PAD_SD3_DATA0__USDHC3_DATA0	0x13fe
> +			MX91_PAD_SD3_DATA1__USDHC3_DATA1	0x13fe
> +			MX91_PAD_SD3_DATA2__USDHC3_DATA2	0x13fe
> +			MX91_PAD_SD3_DATA3__USDHC3_DATA3	0x13fe
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_sleep: usdhc3sleepgrp {
> +		fsl,pins = <
> +			MX91_PAD_SD3_CLK__GPIO3_IO20		0x31e
> +			MX91_PAD_SD3_CMD__GPIO3_IO21		0x31e
> +			MX91_PAD_SD3_DATA0__GPIO3_IO22		0x31e
> +			MX91_PAD_SD3_DATA1__GPIO3_IO23		0x31e
> +			MX91_PAD_SD3_DATA2__GPIO3_IO24		0x31e
> +			MX91_PAD_SD3_DATA3__GPIO3_IO25		0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_wlan: usdhc3wlangrp {
> +		fsl,pins = <
> +			MX91_PAD_CCM_CLKO1__GPIO3_IO26		0x31e
> +		>;
> +	};
> +
> +	pinctrl_sai1: sai1grp {
> +		fsl,pins = <
> +			MX91_PAD_SAI1_TXC__SAI1_TX_BCLK			0x31e
> +			MX91_PAD_SAI1_TXFS__SAI1_TX_SYNC		0x31e
> +			MX91_PAD_SAI1_TXD0__SAI1_TX_DATA0		0x31e
> +			MX91_PAD_SAI1_RXD0__SAI1_RX_DATA0		0x31e
> +		>;
> +	};
> +
> +	pinctrl_sai1_sleep: sai1sleepgrp {
> +		fsl,pins = <
> +			MX91_PAD_SAI1_TXC__GPIO1_IO12                   0x51e
> +			MX91_PAD_SAI1_TXFS__GPIO1_IO11			0x51e
> +			MX91_PAD_SAI1_TXD0__GPIO1_IO13			0x51e
> +			MX91_PAD_SAI1_RXD0__GPIO1_IO14			0x51e
> +		>;
> +	};
> +
> +	pinctrl_sai3: sai3grp {
> +		fsl,pins = <
> +			MX91_PAD_GPIO_IO26__SAI3_TX_SYNC		0x31e
> +			MX91_PAD_GPIO_IO16__SAI3_TX_BCLK		0x31e
> +			MX91_PAD_GPIO_IO17__SAI3_MCLK			0x31e
> +			MX91_PAD_GPIO_IO19__SAI3_TX_DATA0		0x31e
> +			MX91_PAD_GPIO_IO20__SAI3_RX_DATA0		0x31e
> +		>;
> +	};
> +
> +	pinctrl_sai3_sleep: sai3sleepgrp {
> +		fsl,pins = <
> +			MX91_PAD_GPIO_IO26__GPIO2_IO26			0x51e
> +			MX91_PAD_GPIO_IO16__GPIO2_IO16			0x51e
> +			MX91_PAD_GPIO_IO17__GPIO2_IO17			0x51e
> +			MX91_PAD_GPIO_IO19__GPIO2_IO19			0x51e
> +			MX91_PAD_GPIO_IO20__GPIO2_IO20			0x51e
> +		>;
> +	};
> +
> +	pinctrl_pdm: pdmgrp {
> +		fsl,pins = <
> +			MX91_PAD_PDM_CLK__PDM_CLK			0x31e
> +			MX91_PAD_PDM_BIT_STREAM0__PDM_BIT_STREAM0	0x31e
> +			MX91_PAD_PDM_BIT_STREAM1__PDM_BIT_STREAM1	0x31e
> +		>;
> +	};
> +
> +	pinctrl_pdm_sleep: pdmsleepgrp {
> +		fsl,pins = <
> +			MX91_PAD_PDM_CLK__GPIO1_IO8			0x31e
> +			MX91_PAD_PDM_BIT_STREAM0__GPIO1_IO9		0x31e
> +			MX91_PAD_PDM_BIT_STREAM1__GPIO1_IO10		0x31e
> +		>;
> +	};
> +
> +	pinctrl_spdif: spdifgrp {
> +		fsl,pins = <
> +			MX91_PAD_GPIO_IO22__SPDIF_IN		0x31e
> +			MX91_PAD_GPIO_IO23__SPDIF_OUT		0x31e
> +		>;
> +	};
> +
> +	pinctrl_spdif_sleep: spdifsleepgrp {
> +		fsl,pins = <
> +			MX91_PAD_GPIO_IO22__GPIO2_IO22		0x31e
> +			MX91_PAD_GPIO_IO23__GPIO2_IO23		0x31e
> +		>;
> +	};
> +};
> --
> 2.34.1
>

