Return-Path: <linux-kernel+bounces-577554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA19A71EA9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB7763BC08A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD4C2517B2;
	Wed, 26 Mar 2025 18:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="L4p0HXMB"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2082.outbound.protection.outlook.com [40.107.20.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC0317F7;
	Wed, 26 Mar 2025 18:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743015116; cv=fail; b=Q1oC5Q3eezaxLvJfQtQpQ4FymikQyVyBycaBSt60RJBzlPxLLWcGrtWUN+2mhkitu6Kaumz5OOR6A7X7dtuUWKozTAOTf6hAAFyAwoPskXcbj9SdrgW4gB/ZdNaOh6A15gw5ZpnREhWdp+v/lhP9RFg+xUjnOIfnqCVFSHCfP5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743015116; c=relaxed/simple;
	bh=GZ3LSMoCfeGSm5xPH4ttqm0N7cGfbkgPDtXmU6onzRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NSNnh0KZoczA41vXeLfufrNlR+6ik5wHg9/OTbd/CQMv0szeMJaV/GSnpW4K9FQfKTnxqh7cvhL04vXGePKSpZpF1JtZiRKRlZBYPElSfq28Ecj9qo2nn/YGmmdrTwiAviVmAyayUhA+Kz1oViFJ8ojK+fhZvg+Qr8GlsF60vvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=L4p0HXMB; arc=fail smtp.client-ip=40.107.20.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NfwJCq/t9ducNRaLx2qQjDtCyCvFWODqXz84Ti4FbsQnLgbERsnL6/2VtPFLEfleaECP68ZhtINOLAhVxd0PPSBjRlKhi2/q3itTLblON5xgtoitacyDAld0O8AOrPS2OxY0O5UwpAlfM+1SA9r41AjButBw1oumqU/yJ3RlGcAyVoYASd8iRoq2dQ13StRLcoSXLG8OlFJr3Il1Mt8r++DReLQoPJfeEqHbFlVGyWuQ4Hlf4jVMvph2UnRSO0HWMv7+RinpEbX5DYQL3jhR2oYkNtsUNhSuBKU9SwQBTWaEbAjMUTsygQbNurEAUuX8gQae4Gl5odbabIiDgiDVMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+KNP8OqTYw9MQ+DgCBgwcxKuJJoj51nlpNspN6AiT4=;
 b=SqXhH+vMa6uz/GQz4v2fVNlLoyRDc1W7/wjlI6ZwrEA0FMIm7W/CNsfNufOdlT/w5xzJt+PnbdAgmKaovcMXTWeXWoB4K8rmZKXUzg1OesqN5WvXLWCIdc/REwHQ9UMFV3T9yFR/kQ+P64Rv4Ac119/x/arRqAk7i0eZ55jomAWR9JMFMVFlMBzldnr2X6ED/NpKOP7vuWLHufWXAH2vuNQ/frv4wrEWDYOgxIkCc021HNYIDWKi0zcK/p75l0KNykFGG4+Y+BKJTF3m4TQmH/NwhpInEHwQdoAK7n5KT7mQjXDueX/rk7ka6emEGxZmIPtJ2pfQL/xUVNbUsZ2Pvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+KNP8OqTYw9MQ+DgCBgwcxKuJJoj51nlpNspN6AiT4=;
 b=L4p0HXMB1Zu3McFI4RPAivOhoKPj+eJNwommEjEyWOMSNEBkI9dMj2EjpeUwg+82tO7sa29sYjP4skT/sCyViMAqSw/d3+r3d/amaMaGPQP48VcqDm26uowT9zTi/d+EaVh1IASZrcEImcTfgBLef8FYZ6+hkAGdKQ16WeS+nJeQ6KvcENBTwBwFOES1uIDymYssaS4p9swvxfE7QAszWeCQByD+JrrByWrQ23NFNn5bkGvzRapgR17gNzHQqCxnREtIl8TEtJqRp/vlTFxfFayUMspHU/AGiW1CXqz0rCy0LgDi+Ev7dE6p2EPFW7yGBg48SfxaFIDPxnUoSA4Asg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9704.eurprd04.prod.outlook.com (2603:10a6:10:303::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Wed, 26 Mar
 2025 18:51:51 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 18:51:50 +0000
Date: Wed, 26 Mar 2025 14:51:06 -0400
From: Frank Li <Frank.li@nxp.com>
To: Lukasz Majewski <lukma@denx.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] ARM: dts: mxs: Add support for second revision of
 the XEA board (imx287)
Message-ID: <Z+RMmm7YKN1IjsCC@lizhi-Precision-Tower-5810>
References: <20250326173400.2697684-1-lukma@denx.de>
 <20250326173400.2697684-2-lukma@denx.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326173400.2697684-2-lukma@denx.de>
X-ClientProxiedBy: PH8PR22CA0004.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9704:EE_
X-MS-Office365-Filtering-Correlation-Id: b48cc5b8-9991-482c-587c-08dd6c9744cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|366016|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zPFjsABfJ/HuuJPT4MHM1vSlKQLKhlkqowKiWqqTLpBNM9qpWQVw8JpOA6Yk?=
 =?us-ascii?Q?GxVaHRL2Vcx2pCS3BT64514MTPUaAC+Bj02/goAck75H5hb2MZTeAnHInFoJ?=
 =?us-ascii?Q?w/XRHwZ9W3XXwOYnFd7qNgfLsYl/GNmVf6KiMwNib/oEY7/JNvPZNjTOMSFc?=
 =?us-ascii?Q?zyADl5FZ0jDgL/0SGTkzSXxQ8QOAqWIWPqt2QV2+58RwNlaZ0ndPnPUAo/oc?=
 =?us-ascii?Q?f3US5yFFJc1zgyKBQRKZY6ykrzUTMSKKOUCa/Z+hz7Vs1I5/JE8PQfoU9ebu?=
 =?us-ascii?Q?R3CPbJ+Ed1b5o32EhpKj8aeUX0/61svwo/Mt6fw3eTPffolTFs46rYaYWZ94?=
 =?us-ascii?Q?YCO1D1K+cMYLX/xTYrOfllwoEJcaRemRvh974tOrYV9+hAm0oFvTLHnlVIvc?=
 =?us-ascii?Q?Uj9SZSAGtuM8rHysSPsCGY7U5sLxKSFjkkKmh0GDglc4DG4rdfZnbJAxmSws?=
 =?us-ascii?Q?ZFig+khRQxO7cFUn7nmxQkMRBLQXBAVPT0bTTpDMun42q601T7iFpV0m+wSt?=
 =?us-ascii?Q?6XkdwHkT9M//3ajCOlAbhXIw1zFZCmHKhiCincMFM/xU4+8+qcHN7K/Wt2ii?=
 =?us-ascii?Q?aBeBv7FuCMsJZi0j+RQVHue430/NKo77DrpjQ4kfpq5FDG+xtH+oEDUX0xc6?=
 =?us-ascii?Q?PP5u/T3BxPMf6ep0x5SwFzDGVKwoK+aLzh7cpYj+XKj1q9cQPeEsqdZicP1I?=
 =?us-ascii?Q?XPIUlbfCd5rr4N+t8jVje3rI38k8nZg9wcRGglj8gkeDNQiv09MnKRg7aFMK?=
 =?us-ascii?Q?OOt4z+0oMA4qKXgYn6qGKxUv7FUt5iqxEGEx6O/9D9pAjpxCx2OKNu3WploG?=
 =?us-ascii?Q?EnnB/Z7ZoLJkuFCmpTIgwe2laaBmbYwHU1GVRpfajkgBoLusfSU6p3qO27D2?=
 =?us-ascii?Q?lO3iU9Ys4ypQQHVFzXFuMb0p7DdVP6BjQ8xdKL2x5oKky8m5Y/7f7ukGVjEE?=
 =?us-ascii?Q?hlt2VlypqvWIgxQPatzOI+LdSxwkOKDSKyuL73Vqr35QpxnpfxRpfjiY0XGD?=
 =?us-ascii?Q?EwsQZIGzuu2VvVgEH2grhP0xnr6zCFqoGGmJbNv0PnysqU9gppwHcWigeB03?=
 =?us-ascii?Q?XPYGALp+wIL29PThY7j9PlG/aZCBN/v/SWxoeOdVKvMg7++S8F4egu2QiU4A?=
 =?us-ascii?Q?c612splZ8k70ADVNoOdtEE709SJHzOL5ayOuQFwLNzbP1kyqUWzNEwjPhEb2?=
 =?us-ascii?Q?CD/Ba7nbs4DO5Mc4e8V1+dTGh0cjDq1mlzJOyEgLTQGmO9Iqx6/gKDxYp0Uu?=
 =?us-ascii?Q?vgtoe1pa43drUq7g/nUZNjkvTRHs1P7oS5yd94Z9OTkwEZylOosSKbL7H2/8?=
 =?us-ascii?Q?frqjQWtNoYtZ6A3YXvF/Rt8re4aKvOyaUjrQQc2SJoUyCOhWpAH1BUJvUVsE?=
 =?us-ascii?Q?mWKjpjUDsDcHo8UBp0YUTLrcxJisbggGJ7cmMUw2zafmlY/gYZPy3AajTtCl?=
 =?us-ascii?Q?F+ca3sY8v9dhL74M4DZ3TN/fNa25kzzl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(366016)(376014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9KhalWrZeg9CJM8rzwu6NBO+oy6y/p3IuejBBJtlUkNIiUAdKlbiPVekrUXb?=
 =?us-ascii?Q?QuPZVGqmMRMQRL4gxiWLiadwzdQu5lIr5qKL5G5vJ4j6mVhBaHdt7NiY18Xe?=
 =?us-ascii?Q?cadpNcp/Elp67FfzNy3Axqnk2s42m0wLNQ5igBcfmNZ3z6HsfKlIrXHxVgk6?=
 =?us-ascii?Q?729wNZLk7ccl1d/GrHg20dNF6u/E/lNsfBCkXhD3/KF4xzuiH2iA//IPG6G6?=
 =?us-ascii?Q?AQAxXyHLTiYdYmkvIg34C72b7+GFqqmop0y2tjOFlTWTUE0f+hkq1pPn5Loq?=
 =?us-ascii?Q?QC4TIusDOsVw+Yga4FynpPhK5gfk2+QU6PTDak2X86w/diTf8z/c3J+9H0iF?=
 =?us-ascii?Q?uA1JAzvULwG/1CaOieZqD3kccOZHdMep88KluGLiHRl/QIcs1pnIWibFs43G?=
 =?us-ascii?Q?pqkoDMX0+zl4OtQEkSVUf25aPi/XBVCrvNxPWd0pmZIbEsgM8X7BQCmjytB3?=
 =?us-ascii?Q?A7EUEjrf9Q0thfQPk8/VDFVHe4YyVosIrbRzc6T3OBwrOOZVivYjSZFkQ0jL?=
 =?us-ascii?Q?nUdxkCkpTYOtvN5ZtG/z3t4ltfERImaU2g/WKv4NxsWvcsCCCnlswxD/qg0A?=
 =?us-ascii?Q?geGGYxWj9jJkAzSE00DT5Ryquf1QDAORWHX/gtSUjoQGU57e6kGHvNMFTjo4?=
 =?us-ascii?Q?RnLqqFIl7lo6my9JICTUyqZqb8MbTzjBAuFpYsAFVAnPYoY7/HNqO1fSwowA?=
 =?us-ascii?Q?xaaVBuOPsGxNbHOVszXE0Ki2PkZrsLcUQrYkRzoC6D+XnDCR2DfO0ZgcIFzg?=
 =?us-ascii?Q?Opjw+JjnGvtqRbxdcOK85hsSHI3urwv75muZZ0FWQJS6kpXs8xxZhFmkJHIp?=
 =?us-ascii?Q?GY+Nb0Enm9ZKPZ/R2yS7k8Uo4kxZeRy7tiJh/M6Vq6OP7jcmJ4gcfZO4Ouy+?=
 =?us-ascii?Q?PpSzPgzzCE9o1/WGHWW0RRNL0gbbVMx3hjUxhLgDR5EV6kvr1lE2AaVmgnVD?=
 =?us-ascii?Q?JpC5P3PnwyBjkd4sFUfvSzBLAQW24xyYMqjJXtSnQodoEc4J7GTnrBoxUH24?=
 =?us-ascii?Q?Ob497OdZNWK3nsnewKRM26P5IGXMu5NlhEHH+KlTcga7T4Fgos2BC7KDFs9b?=
 =?us-ascii?Q?H680YXfz2ujrMKq+BUHb/QJS1HobCOUjE+ztjpUHJsdD641iu3ICnBhwCjoF?=
 =?us-ascii?Q?twbrP4/iSAWj/0Uqck2Jfoy/SqJIA/5w1Ir9nq0refTt/1rjzqekyFpzNQnR?=
 =?us-ascii?Q?qXkU45etH69CrFBOjA75E7I5qub04n9F14+bs4o2SDQsD4neGzFS5tbaKyWa?=
 =?us-ascii?Q?azl9qddgiJFjySviVx5LAD/Yzq15VFLSu4n6lQtkx/U8L00Wl4Eyi5HDxRX9?=
 =?us-ascii?Q?6/qzZV03RWscGR5Sq8qfqVtRcl5vB/PE/gEJEEchSkZnswHkrAta2puoRBPh?=
 =?us-ascii?Q?UoFIihgkucJlFEGd9Qa+aAamIfQNJAHycsKPy7q1Qs9Ck5PyR7SVjHPPB7Xc?=
 =?us-ascii?Q?tGvcuy8OdjkekgglWfMpH2UfRDDPNWmtjCfIGKF6PVgWYc+OBP2+7Bz962kN?=
 =?us-ascii?Q?zZGMAqz3gtK4DcfkEYRfgBJMABnmlCluVY7rK7E4khsUWMBojz2cT4YFGSuc?=
 =?us-ascii?Q?RgjzDHO1T/8xDScJB1VFiPsgNgCAiP+PMUHvJ8pJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b48cc5b8-9991-482c-587c-08dd6c9744cc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 18:51:50.8478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z/dsdsgg5ldR1KvRNHb1jpZZKNYgJyhpwkwYp0kC6ch1uHbhTpAgbCLN5hOpesrjjL3RUenOyUNrPlG6rOr2fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9704

On Wed, Mar 26, 2025 at 06:34:00PM +0100, Lukasz Majewski wrote:
> Up till now the XEA had only single revision supported in Linux kernel.
>
> As some in-HW adjustments were made - it has been required to extend
> the support with second version.
>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  arch/arm/boot/dts/nxp/mxs/Makefile        |   3 +-
>  arch/arm/boot/dts/nxp/mxs/imx28-xea-1.dts |  29 ++++
>  arch/arm/boot/dts/nxp/mxs/imx28-xea-2.dts |  66 ++++++++
>  arch/arm/boot/dts/nxp/mxs/imx28-xea.dts   | 100 -----------
>  arch/arm/boot/dts/nxp/mxs/imx28-xea.dtsi  | 191 ++++++++++++++++++++++
>  5 files changed, 288 insertions(+), 101 deletions(-)
>  create mode 100644 arch/arm/boot/dts/nxp/mxs/imx28-xea-1.dts
>  create mode 100644 arch/arm/boot/dts/nxp/mxs/imx28-xea-2.dts
>  delete mode 100644 arch/arm/boot/dts/nxp/mxs/imx28-xea.dts
>  create mode 100644 arch/arm/boot/dts/nxp/mxs/imx28-xea.dtsi
>
> diff --git a/arch/arm/boot/dts/nxp/mxs/Makefile b/arch/arm/boot/dts/nxp/mxs/Makefile
> index 96dd31ea19ba..de4cafd820c2 100644
> --- a/arch/arm/boot/dts/nxp/mxs/Makefile
> +++ b/arch/arm/boot/dts/nxp/mxs/Makefile
> @@ -31,4 +31,5 @@ dtb-$(CONFIG_ARCH_MXS) += \
>  	imx28-sps1.dtb \
>  	imx28-ts4600.dtb \
>  	imx28-tx28.dtb \
> -	imx28-xea.dtb
> +	imx28-xea-1.dtb \
> +	imx28-xea-2.dtb
> diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-xea-1.dts b/arch/arm/boot/dts/nxp/mxs/imx28-xea-1.dts
> new file mode 100644
> index 000000000000..a56c9930752a
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/mxs/imx28-xea-1.dts
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Copyright 2025
> + * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
> + */
> +
> +/dts-v1/;
> +#include "imx28-xea.dtsi"
> +
> +/ {
> +	model = "XEA v1";
> +};
> +
> +&pinctrl {
> +	pinctrl-0 = <&hog_pins_a &hog_pins_tiva &hog_pins_rev1>;
> +
> +	hog_pins_rev1: hog@3 {
> +		reg = <3>;
> +		fsl,pinmux-ids = <
> +			MX28_PAD_SSP1_SCK__GPIO_2_12
> +			MX28_PAD_SSP1_SCK__GPIO_2_12
> +			MX28_PAD_SSP2_SS1__GPIO_2_20
> +			MX28_PAD_SSP2_SS2__GPIO_2_21
> +		>;
> +		fsl,drive-strength = <MXS_DRIVE_4mA>;
> +		fsl,voltage = <MXS_VOLTAGE_HIGH>;
> +		fsl,pull-up = <MXS_PULL_DISABLE>;
> +	};
> +};
> diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-xea-2.dts b/arch/arm/boot/dts/nxp/mxs/imx28-xea-2.dts
> new file mode 100644
> index 000000000000..498905def9c1
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/mxs/imx28-xea-2.dts
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Copyright 2025
> + * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
> + */
> +
> +/dts-v1/;
> +#include "imx28-xea.dtsi"
> +
> +/ {
> +	model = "XEA v2";
> +};
> +
> +&pinctrl {
> +	pinctrl-0 = <&hog_pins_a &hog_pins_tiva &hog_pins_rev1>;
> +
> +	hog_pins_rev1: hog@3 {
> +		reg = <3>;
> +		fsl,pinmux-ids = <
> +			MX28_PAD_SAIF0_LRCLK__GPIO_3_21
> +		>;
> +		fsl,drive-strength = <MXS_DRIVE_4mA>;
> +		fsl,voltage = <MXS_VOLTAGE_HIGH>;
> +		fsl,pull-up = <MXS_PULL_DISABLE>;
> +	};
> +
> +	spi1_pins_a: spi1@0 {
> +		reg = <0>;
> +		fsl,pinmux-ids = <
> +			MX28_PAD_SSP1_SCK__SSP1_SCK
> +			MX28_PAD_SSP1_CMD__SSP1_CMD
> +			MX28_PAD_SSP1_DATA0__SSP1_D0
> +			MX28_PAD_SSP1_DATA3__GPIO_2_15
> +		>;
> +		fsl,drive-strength = <MXS_DRIVE_8mA>;
> +		fsl,voltage = <MXS_VOLTAGE_HIGH>;
> +		fsl,pull-up = <MXS_PULL_ENABLE>;
> +	};
> +};
> +
> +&ssp1 {
> +	compatible = "fsl,imx28-spi";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi1_pins_a>;
> +	status = "okay";
> +
> +	spidev0@0 {
> +		compatible = "lwn,btt";
> +		spi-max-frequency = <100000000>;
> +		reg = <0>;

reg should after compatible.

> +	};
> +
> +	spidev2@2 {
> +		compatible = "lwn,btt";
> +		spi-max-frequency = <100000000>;
> +		reg = <2>;
> +	};
> +};
> +
> +&ssp3 {
> +	spidev1@1 {
> +		compatible = "lwn,btt";
> +		spi-max-frequency = <100000000>;
> +		reg = <1>;
> +	};
> +};
> diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-xea.dts b/arch/arm/boot/dts/nxp/mxs/imx28-xea.dts
> deleted file mode 100644
> index 6c5e6856648a..000000000000
> --- a/arch/arm/boot/dts/nxp/mxs/imx28-xea.dts
> +++ /dev/null
> @@ -1,100 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> -/*
> - * Copyright 2021
> - * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
> - */
> -
> -/dts-v1/;
> -#include "imx28-lwe.dtsi"
> -
> -/ {
> -	model = "Liebherr XEA board";
> -	compatible = "lwn,imx28-xea", "fsl,imx28";
> -};
> -
> -&can0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&can1_pins_a>;
> -	status = "okay";
> -};
> -
> -&i2c1 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2c1_pins_b>;
> -	status = "okay";
> -};
> -
> -&pinctrl {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&hog_pins_a &hog_pins_tiva>;
> -
> -	hog_pins_a: hog@0 {
> -		reg = <0>;
> -		fsl,pinmux-ids = <
> -			MX28_PAD_GPMI_D00__GPIO_0_0
> -			MX28_PAD_GPMI_D02__GPIO_0_2
> -			MX28_PAD_GPMI_D05__GPIO_0_5
> -			MX28_PAD_GPMI_CE1N__GPIO_0_17
> -			MX28_PAD_GPMI_RDY0__GPIO_0_20
> -			MX28_PAD_GPMI_RDY1__GPIO_0_21
> -			MX28_PAD_GPMI_RDY2__GPIO_0_22
> -			MX28_PAD_GPMI_RDN__GPIO_0_24
> -			MX28_PAD_GPMI_CLE__GPIO_0_27
> -			MX28_PAD_LCD_VSYNC__GPIO_1_28
> -			MX28_PAD_SSP1_SCK__GPIO_2_12
> -			MX28_PAD_SSP1_CMD__GPIO_2_13
> -			MX28_PAD_SSP2_SS1__GPIO_2_20
> -			MX28_PAD_SSP2_SS2__GPIO_2_21
> -			MX28_PAD_LCD_D00__GPIO_1_0
> -			MX28_PAD_LCD_D01__GPIO_1_1
> -			MX28_PAD_LCD_D02__GPIO_1_2
> -			MX28_PAD_LCD_D03__GPIO_1_3
> -			MX28_PAD_LCD_D04__GPIO_1_4
> -			MX28_PAD_LCD_D05__GPIO_1_5
> -			MX28_PAD_LCD_D06__GPIO_1_6
> -		>;
> -		fsl,drive-strength = <MXS_DRIVE_4mA>;
> -		fsl,voltage = <MXS_VOLTAGE_HIGH>;
> -		fsl,pull-up = <MXS_PULL_DISABLE>;
> -	};
> -
> -	hog_pins_tiva: hog@1 {
> -		reg = <1>;
> -		fsl,pinmux-ids = <
> -			MX28_PAD_GPMI_RDY3__GPIO_0_23
> -			MX28_PAD_GPMI_WRN__GPIO_0_25
> -		>;
> -		fsl,voltage = <MXS_VOLTAGE_HIGH>;
> -		fsl,pull-up = <MXS_PULL_DISABLE>;
> -	};
> -
> -	hog_pins_coding: hog@2 {
> -		reg = <2>;
> -		fsl,pinmux-ids = <
> -			MX28_PAD_GPMI_D01__GPIO_0_1
> -			MX28_PAD_GPMI_D03__GPIO_0_3
> -			MX28_PAD_GPMI_D04__GPIO_0_4
> -			MX28_PAD_GPMI_D06__GPIO_0_6
> -			MX28_PAD_GPMI_D07__GPIO_0_7
> -		>;
> -		fsl,voltage = <MXS_VOLTAGE_HIGH>;
> -		fsl,pull-up = <MXS_PULL_DISABLE>;
> -	};
> -};
> -
> -&reg_fec_3v3 {
> -	gpio = <&gpio0 0 0>;
> -};
> -
> -&reg_usb_5v {
> -	gpio = <&gpio0 2 0>;
> -};
> -
> -&spi2_pins_a {
> -	fsl,pinmux-ids = <
> -		MX28_PAD_SSP2_SCK__SSP2_SCK
> -		MX28_PAD_SSP2_MOSI__SSP2_CMD
> -		MX28_PAD_SSP2_MISO__SSP2_D0
> -		MX28_PAD_SSP2_SS0__GPIO_2_19
> -	>;
> -};
> diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-xea.dtsi b/arch/arm/boot/dts/nxp/mxs/imx28-xea.dtsi
> new file mode 100644
> index 000000000000..adbdc3871045
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/mxs/imx28-xea.dtsi
> @@ -0,0 +1,191 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Copyright 2025
> + * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include "imx28-lwe.dtsi"
> +
> +/ {
> +	compatible = "lwn,imx28-xea", "fsl,imx28";
> +
> +	reg_standby: regulator-standby {
> +		compatible = "regulator-fixed";
> +		gpio = <&gpio0 20 GPIO_ACTIVE_LOW>;
> +		regulator-name = "enable-standby";
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +};
> +
> +&can1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&can1_pins_a>;
> +	xceiver-supply = <&reg_usb_5v>;
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1_pins_b>;
> +	status = "okay";
> +};
> +
> +&eth_switch {


This is new file, suggest order by name

You can use https://github.com/lznuaa/dt-format to order it.

Frank

> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mac0_pins_a>, <&mac1_pins_a>;
> +	phy-supply = <&reg_fec_3v3>;
> +	phy-reset-duration = <25>;
> +	phy-reset-post-delay = <10>;
> +	status = "okay";
> +
> +	ethernet-ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		mtip_port1: port@1 {
> +			reg = <1>;
> +			label = "lan0";
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			phy-mode = "rmii";
> +			phy-handle = <&ethphy0>;
> +		};
> +
> +		mtip_port2: port@2 {
> +			reg = <2>;
> +			label = "lan1";
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			phy-mode = "rmii";
> +			phy-handle = <&ethphy1>;
> +		};
> +	};
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethphy0: ethernet-phy@0 {
> +			reg = <0>;
> +			smsc,disable-energy-detect;
> +			/* Both PHYs (i.e. 0,1) have the same, single GPIO, */
> +			/* line to handle both, their interrupts (AND'ed) */
> +			interrupt-parent = <&gpio4>;
> +			interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
> +		};
> +
> +		ethphy1: ethernet-phy@1 {
> +			reg = <1>;
> +			smsc,disable-energy-detect;
> +			interrupt-parent = <&gpio4>;
> +			interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
> +		};
> +	};
> +};
> +
> +&mac0 {
> +	phy-mode = "rmii";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mac0_pins_a>;
> +	phy-supply = <&reg_fec_3v3>;
> +	phy-reset-duration = <100>;
> +	local-mac-address = [ 00 11 B8 00 BF 8A ];
> +	status = "okay";
> +};
> +
> +&mac1 {
> +	phy-mode = "rmii";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mac1_pins_a>;
> +	status = "okay";
> +};
> +
> +&pinctrl {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&hog_pins_a &hog_pins_tiva>;
> +
> +	hog_pins_a: hog@0 {
> +		reg = <0>;
> +		fsl,pinmux-ids = <
> +			MX28_PAD_GPMI_D00__GPIO_0_0
> +			MX28_PAD_GPMI_D02__GPIO_0_2
> +			MX28_PAD_GPMI_D05__GPIO_0_5
> +			MX28_PAD_GPMI_CE1N__GPIO_0_17
> +			MX28_PAD_GPMI_RDY0__GPIO_0_20
> +			MX28_PAD_GPMI_RDY1__GPIO_0_21
> +			MX28_PAD_GPMI_RDY2__GPIO_0_22
> +			MX28_PAD_GPMI_RDN__GPIO_0_24
> +			MX28_PAD_GPMI_CLE__GPIO_0_27
> +			MX28_PAD_LCD_VSYNC__GPIO_1_28
> +			MX28_PAD_LCD_D00__GPIO_1_0
> +			MX28_PAD_LCD_D01__GPIO_1_1
> +			MX28_PAD_LCD_D02__GPIO_1_2
> +			MX28_PAD_LCD_D03__GPIO_1_3
> +			MX28_PAD_LCD_D04__GPIO_1_4
> +			MX28_PAD_LCD_D05__GPIO_1_5
> +			MX28_PAD_LCD_D06__GPIO_1_6
> +			MX28_PAD_LCD_D15__GPIO_1_15
> +			MX28_PAD_LCD_D16__GPIO_1_16
> +			MX28_PAD_LCD_D17__GPIO_1_17
> +			MX28_PAD_LCD_D18__GPIO_1_18
> +		>;
> +		fsl,drive-strength = <MXS_DRIVE_4mA>;
> +		fsl,voltage = <MXS_VOLTAGE_HIGH>;
> +		fsl,pull-up = <MXS_PULL_DISABLE>;
> +	};
> +
> +	hog_pins_tiva: hog@1 {
> +		reg = <1>;
> +		fsl,pinmux-ids = <
> +			MX28_PAD_GPMI_RDY3__GPIO_0_23
> +			MX28_PAD_GPMI_WRN__GPIO_0_25
> +		>;
> +		fsl,voltage = <MXS_VOLTAGE_HIGH>;
> +		fsl,pull-up = <MXS_PULL_DISABLE>;
> +	};
> +
> +	hog_pins_coding: hog@2 {
> +		reg = <2>;
> +		fsl,pinmux-ids = <
> +			MX28_PAD_GPMI_D01__GPIO_0_1
> +			MX28_PAD_GPMI_D03__GPIO_0_3
> +			MX28_PAD_GPMI_D04__GPIO_0_4
> +			MX28_PAD_GPMI_D06__GPIO_0_6
> +			MX28_PAD_GPMI_D07__GPIO_0_7
> +		>;
> +		fsl,voltage = <MXS_VOLTAGE_HIGH>;
> +		fsl,pull-up = <MXS_PULL_DISABLE>;
> +	};
> +};
> +
> +&reg_fec_3v3 {
> +	gpio = <&gpio0 0 0>;
> +};
> +
> +&reg_usb_5v {
> +	gpio = <&gpio0 2 0>;
> +};
> +
> +&ssp2 {
> +	spidev1@1 {
> +		compatible = "lwn,btt";
> +		spi-max-frequency = <100000000>;
> +		reg = <1>;
> +	};
> +
> +	spidev2@2 {
> +		compatible = "lwn,btt";
> +		spi-max-frequency = <100000000>;
> +		reg = <2>;
> +	};
> +};
> +
> +&spi2_pins_a {
> +	fsl,pinmux-ids = <
> +		MX28_PAD_SSP2_SCK__SSP2_SCK
> +		MX28_PAD_SSP2_MOSI__SSP2_CMD
> +		MX28_PAD_SSP2_MISO__SSP2_D0
> +		MX28_PAD_SSP2_SS0__GPIO_2_19
> +	>;
> +};
> --
> 2.39.5
>

