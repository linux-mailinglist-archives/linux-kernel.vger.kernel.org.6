Return-Path: <linux-kernel+bounces-525083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB077A3EA91
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 03:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA591702766
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 02:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EF01D516D;
	Fri, 21 Feb 2025 02:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UooTFWvQ"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2482AD0F;
	Fri, 21 Feb 2025 02:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740103729; cv=fail; b=o+YFTGyQJ5OBH2r8fs9GMN+pzOw3DzFDNtPGZMuRNqBioxAARrmES19T1cshrFzvzXuVWe+Zx4e5csnJSDcFaP64uFf23KSX8GSVik+cl6Y5Kd1VP57dGpRakhBKxGfPVOSUPDAVIV/cFpLthTtZ4J96dNbCQhmDedLrJEcBLx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740103729; c=relaxed/simple;
	bh=tTEuNc63ZLsINvbZe9HPgnT0osn/kSlcqoN49e4SFzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KBmwe7q5jKBuA6zKROrMJvZjmMu91gk63jVFkZDpSj9MOr/+rh3w4u4gM9GMnMt0HxBgM+sfT2HOWbfRoiBTY7LJ0fr5gMwjJuSeuf05F5ra0JbqDspoc8/oUtOFhE7Wg3dUhUyh473WTYk2SP1/cjWKxIR9tXxg2pUBjvMX08Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UooTFWvQ; arc=fail smtp.client-ip=40.107.20.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rXXkXxdBnu5jSlvjai3uYFRiSehlY4cX6syl/0TMrY/Hh92JVf9D1DLPz3usxmXAPXkcqB7potdsrOuRP8BRvEN0/HOZWWoFdO9GHkCX5YRkvCiVVg2R8GG9vNQQspLeF6aRT8spFIomMXnqWMU6aSNGCBVXUohqX3gUFFER5elJopIOVE9QiL02XaDLhQ5B/twHitUNRd4TkB1ZreoAESlyG4jMbhunh7mnqQd6+wW2DXWD2G6bx0uEWJ1ovKb7PsUsQUraEzYIJAu1bfvbU6FAI4rbkJQf4RLXH32u6wZdzjh44cQBKV1vcJAJ01OPQ4OsQ6GaAWXSFugAhtp86g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JP4KF5xjTD+SfoOxOR0mLIFhmdiZIngVlbavsdCA7s=;
 b=uHieA2eFtFnv6rX36fxt3URhyx6HA+FpBXhE49sPuXMm2wkepwFESdTBy4ff922Lg85vogofe1PDLW2OYk8Elx0L9XxQGRTnkLxcgBcvle5bAEG1RtIst1kvr/3kYmcTMxMImdnwRiDnISpkMgLQIcZ8vQ945PxEn4dmEYghRuxqtz4lIMEa0FXmDkoJudo7sLHLLefuDa4FoGoWMmemHdJnLXVVDbRfP0cGKgEa3nugjlgLJqE87TE9IQL2Loc/coSVhuv02ktBK6MLQ2pTV/qwBrzOLyEiBJTwAniaxqWhqELPfr8ZYH+I8M0yim53IzhvMVyAmVG0+1all87qwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JP4KF5xjTD+SfoOxOR0mLIFhmdiZIngVlbavsdCA7s=;
 b=UooTFWvQXx4FSCos2c1HIPXzbgXoWsTf34ZYY3+8Q7+R22U4dn7hX59f+iys4GWEp1ZKsSu4D+EgLKdbmBHH4rlojxcCYnh667AwAnjwwZ50lbw0wQO2PbNlpDH0MD5J3sF+qGNoCPoNdNpHMQ+hHweXsDWGSynQK5emGTPdJM+1EBd36QLBtva7TM2xxvRWNJ+kPW6voIzl8x/7kj+vSC4X4CWo0qY/XB+Ews39nUYfSTzcSlqcvlVTywbNj8a8z/byJYxxvBn7LdcKgVp11a3ZJpfWipz94RqAnRXrHwgzj0E9PYsch8v3yRDDZt8YGXfQTaIlwsH78FHOzPrQVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DB9PR04MB8156.eurprd04.prod.outlook.com (2603:10a6:10:246::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 02:08:43 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%6]) with mapi id 15.20.8445.017; Fri, 21 Feb 2025
 02:08:43 +0000
Date: Fri, 21 Feb 2025 10:05:20 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 4/4] arm64: dts: imx95: Add imx95-15x15-evk support
Message-ID: <20250221020520.7d3iz2bvvnsbortp@hippo>
References: <20250220-imx95_15x15-v3-0-247777ed91c4@nxp.com>
 <20250220-imx95_15x15-v3-4-247777ed91c4@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220-imx95_15x15-v3-4-247777ed91c4@nxp.com>
X-ClientProxiedBy: SI2P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::18) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DB9PR04MB8156:EE_
X-MS-Office365-Filtering-Correlation-Id: e9026b03-669c-48bd-1ad7-08dd521caa7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9RABDvvpQsg22mP9y/ArEFrSw2uwZyftf6glv6/t2ZzEhPB54/A3HhwLN0hn?=
 =?us-ascii?Q?bAflQl2txszygcMDhSg/aRsg4Qy8xW+QVTjzGltDX6FhXhdp6j3oBSXAao8/?=
 =?us-ascii?Q?WssNDu0dP8m0wz/xp7J1OOLOku0+orkH3T1sLrnBVnGLpfp3UgzjPEQmG9bj?=
 =?us-ascii?Q?7EwczWVJYa/kQ3FNt+eHSKhH6rIQalGu9f/GCPiiSaTWZL/qFEmjfmsmEMsz?=
 =?us-ascii?Q?p4h1S2kkUtC4lCp0GvVOw4D4kr2yPM8kdEldY+G9FwsCBklKrCa2zH+s0xBF?=
 =?us-ascii?Q?BqOAYk1hqLuw8tzGnFP89Edra3JnyA/gMCS9Dylc4DAJMI/Sr6/xalzQ1FsP?=
 =?us-ascii?Q?qtyC03yOfwWuGux1aH35aH74wFdhdGc6LqvfGRC+AlHxFDxsA27znWRBMkXb?=
 =?us-ascii?Q?oaO7RR05g6QVafJtoUSUdRJbGmkTtYyI80kbg474DZMuRNHVZOIm+9fGCYZE?=
 =?us-ascii?Q?tQb36xdEwxwRUM1sbHdqTtK6E+lxfU2Ix4gRcaYugXZ56QUHkMgaEUEnTWEM?=
 =?us-ascii?Q?Bn/1m8dHWt4LajYJ0qWITfrun+KgADdOGO6WspLZgPzl8Lmq37b9iQ1qYU15?=
 =?us-ascii?Q?BvLbZsrsvGvLKHiBuqVPOdmvmCBC+uKrKDYrF0r/v46REZm75Q2nchePv1C0?=
 =?us-ascii?Q?vczy0cRxHMmunvUyYm22hcPc0nKFx7qT6/H5O9j6ee+jwzvW+Jp79ewoEvHt?=
 =?us-ascii?Q?VXpZe199W3RF00S+ip/h6x7jF2A2PcebHTlH2I1BsuLxTSAaxhTuCA9N8fOJ?=
 =?us-ascii?Q?x4DQui32dFy0ak+xbCzQ22uiQBvv7BA9ypvjjVH5tQ0elxAkhtOgTUHQ4WMf?=
 =?us-ascii?Q?5g6bU0qnmnK6/zu3PM8gRXWIxD9h4dXviaeZ+2gTG2VTD6gVOkS3+qoLmqH1?=
 =?us-ascii?Q?93AfBEBg1vUXambfxo/1uQLzv17H9VMy8tQ7R1Wc/AmKzbMrm7kmfawAS0QU?=
 =?us-ascii?Q?1JjxeY9VDamyAEtrkHNOpn8ZL2+6/6iBZAJDycsxEbidFi0aoYKU34bjM2qU?=
 =?us-ascii?Q?CX5ZPARVFWDDNL0iZiRUMOnoQrzb1iI17kR2+wJQvtfvOnCqvm4XynOslorE?=
 =?us-ascii?Q?zW1rQCrXNBphvOCS0DxvFs6nXQWiAsolrDdjNBOG34cHj5vVgIr0Q7tnPInV?=
 =?us-ascii?Q?vm0iwfWE3aMpnMcYKOiNszQuy1sMbtSvv0FINMrDz/sHQyTxYm3o5jjk/CvA?=
 =?us-ascii?Q?8GGgISDAASLj7YHOEG6rzF89+3s+iL0GSpE/yrRNDFMCI10fCBV8r5eCFM1d?=
 =?us-ascii?Q?OCQjaAfQGHWdD/Fc5e9QU6Tq2yGatloUXnnVLdm2tvvGsJk5IW8WHxR55oGy?=
 =?us-ascii?Q?ug8bUp5pY1HV45DWkAIrY6HWXT8aQB9C9AXD79W+UIlf8YW9+WVbinYTejuW?=
 =?us-ascii?Q?ahye43BkXe8TkyPKd0pN2OHui5dd8SDGy+SQ8s6OMzBtQXMrqaiKLvKph2tX?=
 =?us-ascii?Q?NUQa0S4e/Dc2p+UrrNQRY9JRnd5lCFSp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iQXub82q5qNq4hILXu2ABw7bF4/zBzyt07pWCzx3HhKskh9r+RkvXGj2azFx?=
 =?us-ascii?Q?S0AMSHNQ4RbEZlWVODLK+tJjrNT8Xz0vr/KJDwsGXvKH2kKfYYews8IMNeLT?=
 =?us-ascii?Q?zfaXQ3GkC61sf2GpndsAhqunEJwrrx/B02aknbzTHQkeiG7W4V9EBRXoli4A?=
 =?us-ascii?Q?pya0wL20B+eLhIRgE+blHVeMeQn6vq+K4gO6mI7XgGVS711Ge7oBwM6BtF1y?=
 =?us-ascii?Q?f0/NvdqONVQufzOw9kh3PHBbHjseKFKjCN+G1VdVvkUF2rTW7A+FzqgYVYLx?=
 =?us-ascii?Q?eB6xTEAYRpAMUKNWpd7bBWgZUfrkPMBWLGC/OXTFo1w2Vc8pMFdrCUC8cnHw?=
 =?us-ascii?Q?/GIpCYqR5mL/JYuZlaEQvtBdrxscjnbqZSGJv2894dYbr3HSse4oYLbssCve?=
 =?us-ascii?Q?vpNW/tYrgeiv1Oh6buu2O+qj5uvSe0Ijb2Sm7h/BX1AwhpVLI3n8O442tiEV?=
 =?us-ascii?Q?63Aj4CQ2SMmLSQTMmWn7kTdCiymPM65BXw7vG22nViaD9xT1g+CN0pIyX6z/?=
 =?us-ascii?Q?nx9lK1PElUd0nkb3xS75gmrOiDMPjiCvxl+UKhKSFrtpLH3MJ5jjRo8gVZxt?=
 =?us-ascii?Q?Rr7TDKscq54B56DBKfSlyW9P9TpB79zmNuKsxUdLwpfLX1lYqfrhgyACEBnh?=
 =?us-ascii?Q?HDxz1sWNoFVKIwtv5CtAgsIVoJcFlKM3WJhAPTzMfpGdBWsCAojE1glUcU8b?=
 =?us-ascii?Q?5hjg7qzOUEnaZ4hTpuanuhjuh5KDKxrw9OMBWBaw6aOasABjqRgOyp4iHGOP?=
 =?us-ascii?Q?E1kmQxIjZmNkUuMxDRl9sG35l1EoIJ9JCrkmZAqU6UAZoSFrDM3mL2kjnS1B?=
 =?us-ascii?Q?obvoc7EIwOFrUNhuLH1zOu6tX1jjLAhQC+XO1rAXOJan2rXHk9deqq/qIhZs?=
 =?us-ascii?Q?x1szDBPlXCfrsDYxKuippMSZ7/BOLMoHI4RntyCZ4mPgWa2h91lreCi691wP?=
 =?us-ascii?Q?PQGpfuI6so51bA/05Lp5TzK9fFehW7Xp5qv1mYeDdvj1LI3+BkaLE7lfYhlg?=
 =?us-ascii?Q?Yk3PjlkOHU8Z0dJ5m7wQkWQ4X1VQ7KqDsBhrJaz5sNwOgx6PQLvId2rVbrsK?=
 =?us-ascii?Q?V0mInfg9sXAAhSMDV/rD6Cn2/CWqsXeNkS/iI1ZXFc69uaS+12IjPRdD6cpw?=
 =?us-ascii?Q?uTL6kTdluoX2VLtz5ntDee+ciF9GzVNOypKNuGMI7eCP35M5QTd3bR3bGNIG?=
 =?us-ascii?Q?3kmoEYPRKg+tlisc8ed6wKk92MeYXa+J9Q8hSKJncBo/oX0QPezsuQQTfBBL?=
 =?us-ascii?Q?T29hxCH1gg+U6V7s0PYpHaO6nppR9n8kHDJw70kh1uA4bgvqVaw3YLCk79DZ?=
 =?us-ascii?Q?DzDE26aa9Z8ACDGgniooi4FQJZZsH0a7F7uftqAgBF1aqdeQdZ8zB6RfsPSo?=
 =?us-ascii?Q?Uwxy3rkmKhGYemilE5zJxFfYTPo0+GnkXYngqEasOk6onNvtuYV52+fOJTw+?=
 =?us-ascii?Q?uKbCF3yx7D98xkGJ6DZlHQeTLtaEtlAEFaqzxBLXleMo0BnuqXUzQbWAmegs?=
 =?us-ascii?Q?YseZa5CNjnzdB7A0TuMGepIld8ev+Iu+fgSBvn6OTzTt2RaPWQhvf6voqH2m?=
 =?us-ascii?Q?sA62hh6YMTfGfj7HMvdTLI3NwZYYkXwPFl6NpFsn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9026b03-669c-48bd-1ad7-08dd521caa7d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 02:08:43.4461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJ7srjSbsA3afISx7sEvGcg+LKPAmNvjPD4K0kmdcxHplKH/uWxwvUgqimy2twJaffkxbwxhb3freqB861mFZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8156

On Thu, Feb 20, 2025 at 11:11:19AM -0500, Frank Li wrote:
> Add imx95-15x15-evk support.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change from v2 to v3
> - remove a empty line
> - remove undocument property fsl,cd-gpio-wakeup-disable. (Need double check
> why DTB_CHECK have not report warning for it).
> ---
>  arch/arm64/boot/dts/freescale/Makefile            |    1 +
>  arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts | 1062 +++++++++++++++++++++
>  2 files changed, 1063 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 839432153cc7a..a2fd3a32e351e 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -281,6 +281,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxca.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx93-var-som-symphony.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx95-15x15-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk.dtb
>  
>  imx8mm-kontron-dl-dtbs			:= imx8mm-kontron-bl.dtb imx8mm-kontron-dl.dtbo
> diff --git a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
> new file mode 100644
> index 0000000000000..ff845437efb05
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
> @@ -0,0 +1,1062 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2025 NXP
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/i3c/i3c.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/phy/phy-imx8-pcie.h>
> +#include <dt-bindings/pwm/pwm.h>
> +#include <dt-bindings/usb/pd.h>

This version doesn't contain any USB and Type-C nodes, so some related
code could be removed in this version?

> +#include "imx95.dtsi"
> +
> +#define FALLING_EDGE		BIT(0)
> +#define RISING_EDGE		BIT(1)
> +
> +#define BRD_SM_CTRL_SD3_WAKE		0x8000
> +#define BRD_SM_CTRL_PCIE1_WAKE		0x8001
> +#define BRD_SM_CTRL_BT_WAKE		0x8002
> +#define BRD_SM_CTRL_PCIE2_WAKE		0x8003
> +#define BRD_SM_CTRL_BUTTON		0x8004
> +
> +/ {
> +	compatible = "fsl,imx95-15x15-evk", "fsl,imx95";
> +	model = "NXP i.MX95 15X15 board";
> +
> +	aliases {
> +		ethernet0 = &enetc_port0;
> +		ethernet1 = &enetc_port1;
> +		serial0 = &lpuart1;
> +	};
> +
> +	bt_sco_codec: bt-sco-codec {
> +		compatible = "linux,bt-sco";
> +		#sound-dai-cells = <1>;
> +	};
> +
> +	chosen {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		stdout-path = &lpuart1;
> +	};
> +
> +	fan0: pwm-fan {
> +		compatible = "pwm-fan";
> +		#cooling-cells = <2>;
> +		cooling-levels = <64 128 192 255>;
> +		pwms = <&tpm6 0 4000000 PWM_POLARITY_INVERTED>;
> +	};
> +
> +	reg_1p8v: regulator-1p8v {
> +		compatible = "regulator-fixed";
> +		regulator-max-microvolt = <1800000>;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-name = "+V1.8_SW";
> +	};
> +
> +	reg_3p3v: regulator-3p3v {
> +		compatible = "regulator-fixed";
> +		regulator-max-microvolt = <3300000>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-name = "+V3.3_SW";
> +	};
> +
> +	reg_vref_1v8: regulator-adc-vref {
> +		compatible = "regulator-fixed";
> +		regulator-max-microvolt = <1800000>;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-name = "vref_1v8";
> +	};
> +
> +	reg_audio_pwr: regulator-audio-pwr {
> +		compatible = "regulator-fixed";
> +		regulator-always-on;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-name = "audio-pwr";
> +		gpio = <&pcal6524 13 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	reg_audio_switch1: regulator-audio-switch1 {
> +		compatible = "regulator-fixed";
> +		regulator-always-on;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-name = "audio-switch1";
> +		gpio = <&pcal6524 0 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	reg_can2_stby: regulator-can2-stby {
> +		compatible = "regulator-fixed";
> +		regulator-max-microvolt = <3300000>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-name = "can2-stby";
> +		gpio = <&pcal6524 14 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	reg_m2_pwr: regulator-m2-pwr {
> +		compatible = "regulator-fixed";
> +		regulator-always-on;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-name = "M.2-power";
> +		gpio = <&pcal6524 10 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	reg_usdhc2_vmmc: regulator-usdhc2 {
> +		compatible = "regulator-fixed";
> +		off-on-delay-us = <12000>;
> +		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
> +		pinctrl-names = "default";
> +		regulator-max-microvolt = <3300000>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-name = "VDD_SD2_3V3";
> +		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	reg_usdhc3_vmmc: regulator-usdhc3 {
> +		compatible = "regulator-fixed";
> +		regulator-max-microvolt = <3300000>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-name = "WLAN_EN";
> +		vin-supply = <&reg_m2_pwr>;
> +		gpio = <&pcal6524 11 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		/*
> +		 * IW612 wifi chip needs more delay than other wifi chips to complete
> +		 * the host interface initialization after power up, otherwise the
> +		 * internal state of IW612 may be unstable, resulting in the failure of
> +		 * the SDIO3.0 switch voltage.
> +		 */
> +		startup-delay-us = <20000>;
> +	};
> +
> +	reg_usb_vbus: regulator-vbus {
> +		compatible = "regulator-fixed";
> +		regulator-max-microvolt = <5000000>;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-name = "USB_VBUS";
> +		gpio = <&pcal6524 3 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};

This one. regulator-vbus

> +
> +	reg_vcc_12v: regulator-vcc-12v {
> +		compatible = "regulator-fixed";
> +		regulator-max-microvolt = <12000000>;
> +		regulator-min-microvolt = <12000000>;
> +		regulator-name = "VCC_12V";
> +		gpio = <&pcal6524 1 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	reserved-memory {
> +		ranges;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +
> +		linux_cma: linux,cma {
> +			compatible = "shared-dma-pool";
> +			alloc-ranges = <0 0x80000000 0 0x7F000000>;
> +			reusable;
> +			size = <0 0x3c000000>;
> +			linux,cma-default;
> +		};
> +
> +		vdev0vring0: vdev0vring0@88000000 {
> +			reg = <0 0x88000000 0 0x8000>;
> +			no-map;
> +		};
> +
> +		vdev0vring1: vdev0vring1@88008000 {
> +			reg = <0 0x88008000 0 0x8000>;
> +			no-map;
> +		};
> +
> +		vdev1vring0: vdev1vring0@88010000 {
> +			reg = <0 0x88010000 0 0x8000>;
> +			no-map;
> +		};
> +
> +		vdev1vring1: vdev1vring1@88018000 {
> +			reg = <0 0x88018000 0 0x8000>;
> +			no-map;
> +		};
> +
> +		vdevbuffer: vdevbuffer@88020000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0 0x88020000 0 0x100000>;
> +			no-map;
> +		};
> +
> +		rsc_table: rsc-table@88220000 {
> +			reg = <0 0x88220000 0 0x1000>;
> +			no-map;
> +		};
> +
> +		vpu_boot: vpu_boot@a0000000 {
> +			reg = <0 0xa0000000 0 0x100000>;
> +			no-map;
> +		};
> +	};
> +
> +	sound-bt-sco {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,bitclock-inversion;
> +		simple-audio-card,bitclock-master = <&btcpu>;
> +		simple-audio-card,format = "dsp_a";
> +		simple-audio-card,frame-master = <&btcpu>;
> +		simple-audio-card,name = "bt-sco-audio";
> +
> +		simple-audio-card,codec {
> +			sound-dai = <&bt_sco_codec 1>;
> +		};
> +
> +		btcpu: simple-audio-card,cpu {
> +			dai-tdm-slot-num = <2>;
> +			dai-tdm-slot-width = <16>;
> +			sound-dai = <&sai1>;
> +		};
> +	};
> +
> +	sound-micfil {
> +		compatible = "fsl,imx-audio-card";
> +		model = "micfil-audio";
> +
> +		pri-dai-link {
> +			format = "i2s";
> +			link-name = "micfil hifi";
> +
> +			cpu {
> +				sound-dai = <&micfil>;
> +			};
> +		};
> +	};
> +
> +	sound-wm8962 {
> +		compatible = "fsl,imx-audio-wm8962";
> +		audio-codec = <&wm8962>;
> +		audio-cpu = <&sai3>;
> +		audio-routing = "Headphone Jack", "HPOUTL", "Headphone Jack", "HPOUTR",
> +				"Ext Spk", "SPKOUTL", "Ext Spk", "SPKOUTR", "AMIC", "MICBIAS",
> +				"IN3R", "AMIC", "IN1R", "AMIC";
> +		hp-det-gpio = <&gpio2 21 GPIO_ACTIVE_HIGH>;
> +		model = "wm8962-audio";
> +		pinctrl-0 = <&pinctrl_hp>;
> +		pinctrl-names = "default";
> +	};
> +
> +	sound-xcvr {
> +		compatible = "fsl,imx-audio-card";
> +		model = "imx-audio-xcvr";
> +
> +		pri-dai-link {
> +			link-name = "XCVR PCM";
> +
> +			cpu {
> +				sound-dai = <&xcvr>;
> +			};
> +		};
> +	};
> +
> +	usdhc3_pwrseq: usdhc3-pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		pinctrl-0 = <&pinctrl_usdhc3_pwrseq>;
> +		pinctrl-names = "default";
> +		reset-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	memory@80000000 {
> +		reg = <0x0 0x80000000 0 0x80000000>;
> +		device_type = "memory";
> +	};
> +};
> +
> +&adc1 {
> +	vref-supply = <&reg_vref_1v8>;
> +	status = "okay";
> +};
> +
> +&enetc_port0 {
> +	phy-handle = <&ethphy0>;
> +	phy-mode = "rgmii-id";
> +	pinctrl-0 = <&pinctrl_enetc0>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&enetc_port1 {
> +	phy-handle = <&ethphy1>;
> +	phy-mode = "rgmii-id";
> +	pinctrl-0 = <&pinctrl_enetc1>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&flexcan2 {
> +	pinctrl-0 = <&pinctrl_flexcan2>;
> +	pinctrl-names = "default";
> +	xceiver-supply = <&reg_can2_stby>;
> +	status = "okay";
> +};
> +
> +&i3c2 {
> +	pinctrl-0 = <&pinctrl_i3c2>;
> +	pinctrl-names = "default";
> +	i2c-scl-hz = <400000>;
> +	status = "okay";
> +
> +	pca9570: gpio@24 {
> +		compatible = "nxp,pca9570";
> +		reg = <0x24 0 (I2C_FILTER)>;
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +		gpio-line-names = "OUT1", "OUT2", "OUT3", "OUT4";
> +	};
> +};
> +
> +&lpi2c2 {
> +	clock-frequency = <400000>;
> +	pinctrl-0 = <&pinctrl_lpi2c2>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	wm8962: codec@1a {
> +		compatible = "wlf,wm8962";
> +		reg = <0x1a>;
> +		clocks = <&scmi_clk IMX95_CLK_SAI3>;
> +		AVDD-supply = <&reg_audio_pwr>;
> +		CPVDD-supply = <&reg_audio_pwr>;
> +		DBVDD-supply = <&reg_audio_pwr>;
> +		DCVDD-supply = <&reg_audio_pwr>;
> +		gpio-cfg = <
> +			0x0000
> +			0x0000
> +			0x0000
> +			0x0000
> +			0x0000
> +			0x0000
> +		>;
> +		MICVDD-supply = <&reg_audio_pwr>;
> +		PLLVDD-supply = <&reg_audio_pwr>;
> +		SPKVDD1-supply = <&reg_audio_pwr>;
> +		SPKVDD2-supply = <&reg_audio_pwr>;
> +	};
> +
> +	pcal6524: gpio@22 {
> +		compatible = "nxp,pcal6524";
> +		reg = <0x22>;
> +		#interrupt-cells = <2>;
> +		interrupt-controller;
> +		interrupts = <14 IRQ_TYPE_LEVEL_LOW>;
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +		interrupt-parent = <&gpio5>;
> +		pinctrl-0 = <&pinctrl_pcal6524>;
> +		pinctrl-names = "default";
> +	};
> +};
> +
> +&lpi2c3 {
> +	clock-frequency = <400000>;
> +	pinctrl-0 = <&pinctrl_lpi2c3>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	pca9632: led-controller@62 {
> +		compatible = "nxp,pca9632";
> +		reg = <0x62>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		nxp,inverted-out;
> +
> +		led_backlight0: led@0 {
> +			reg = <0>;
> +			color = <LED_COLOR_ID_WHITE>;
> +			function = LED_FUNCTION_BACKLIGHT;
> +			function-enumerator = <0>;
> +		};
> +
> +		led_backlight1: led@1 {
> +			reg = <1>;
> +			color = <LED_COLOR_ID_WHITE>;
> +			function = LED_FUNCTION_BACKLIGHT;
> +			function-enumerator = <1>;
> +		};
> +	};
> +};
> +
> +&lpi2c4 {
> +	clock-frequency = <400000>;
> +	pinctrl-0 = <&pinctrl_lpi2c4>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&lpi2c6 {
> +	clock-frequency = <100000>;
> +	pinctrl-0 = <&pinctrl_lpi2c6>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&lpuart1 {
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&lpuart5 {
> +	pinctrl-0 = <&pinctrl_uart5>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	bluetooth {
> +		compatible = "nxp,88w8987-bt";
> +	};
> +};
> +
> +&micfil {
> +	assigned-clocks = <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
> +			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
> +			  <&scmi_clk IMX95_CLK_AUDIOPLL1>,
> +			  <&scmi_clk IMX95_CLK_AUDIOPLL2>,
> +			  <&scmi_clk IMX95_CLK_PDM>;
> +	assigned-clock-parents = <0>, <0>, <0>, <0>, <&scmi_clk IMX95_CLK_AUDIOPLL1>;
> +	assigned-clock-rates = <3932160000>, <3612672000>, <393216000>, <361267200>, <49152000>;
> +	#sound-dai-cells = <0>;
> +	pinctrl-0 = <&pinctrl_pdm>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&mu7 {
> +	status = "okay";
> +};
> +
> +&netc_blk_ctrl {
> +	status = "okay";
> +};
> +
> +&netc_emdio {
> +	pinctrl-0 = <&pinctrl_emdio>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	ethphy0: ethernet-phy@1 {
> +		reg = <1>;
> +		reset-assert-us = <10000>;
> +		reset-deassert-us = <80000>;
> +		reset-gpios = <&pcal6524 4 GPIO_ACTIVE_LOW>;
> +		realtek,clkout-disable;
> +	};
> +
> +	ethphy1: ethernet-phy@2 {
> +		reg = <2>;
> +		reset-assert-us = <10000>;
> +		reset-deassert-us = <80000>;
> +		reset-gpios = <&pcal6524 5 GPIO_ACTIVE_LOW>;
> +		realtek,clkout-disable;
> +	};
> +};
> +
> +&netc_timer {
> +	status = "okay";
> +};
> +
> +&netcmix_blk_ctrl {
> +	status = "okay";
> +};
> +
> +&pcie0 {
> +	pinctrl-0 = <&pinctrl_pcie0>;
> +	pinctrl-names = "default";
> +	reset-gpio = <&gpio5 13 GPIO_ACTIVE_LOW>;
> +	vpcie-supply = <&reg_m2_pwr>;
> +	status = "okay";
> +};
> +
> +&netc_bus0 {
> +	msi-map = <0x00 &its 0x60 0x1>,	//ENETC0 PF
> +		  <0x10 &its 0x61 0x1>, //ENETC0 VF0
> +		  <0x20 &its 0x62 0x1>, //ENETC0 VF1
> +		  <0x40 &its 0x63 0x1>, //ENETC1 PF
> +		  <0x50 &its 0x65 0x1>, //ENETC1 VF0
> +		  <0x60 &its 0x66 0x1>, //ENETC1 VF1
> +		  <0x80 &its 0x64 0x1>, //ENETC2 PF
> +		  <0xc0 &its 0x67 0x1>;
> +};
> +
> +&sai1 {
> +	assigned-clocks = <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
> +			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
> +			  <&scmi_clk IMX95_CLK_AUDIOPLL1>,
> +			  <&scmi_clk IMX95_CLK_AUDIOPLL2>,
> +			  <&scmi_clk IMX95_CLK_SAI1>;
> +	assigned-clock-parents = <0>, <0>, <0>, <0>, <&scmi_clk IMX95_CLK_AUDIOPLL1>;
> +	assigned-clock-rates = <3932160000>, <3612672000>, <393216000>, <361267200>, <12288000>;
> +	#sound-dai-cells = <0>;
> +	pinctrl-0 = <&pinctrl_sai1>;
> +	pinctrl-names = "default";
> +	fsl,sai-mclk-direction-output;
> +	status = "okay";
> +};
> +
> +&sai3 {
> +	assigned-clocks = <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
> +			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
> +			  <&scmi_clk IMX95_CLK_AUDIOPLL1>,
> +			  <&scmi_clk IMX95_CLK_AUDIOPLL2>,
> +			  <&scmi_clk IMX95_CLK_SAI3>;
> +	assigned-clock-parents = <0>, <0>, <0>, <0>, <&scmi_clk IMX95_CLK_AUDIOPLL1>;
> +	assigned-clock-rates = <3932160000>, <3612672000>, <393216000>, <361267200>, <12288000>;
> +	#sound-dai-cells = <0>;
> +	pinctrl-0 = <&pinctrl_sai3>;
> +	pinctrl-names = "default";
> +	fsl,sai-mclk-direction-output;
> +	status = "okay";
> +};
> +
> +&scmi_iomuxc {
> +	pinctrl_emdio: emdiogrp {
> +		fsl,pins = <
> +			IMX95_PAD_ENET2_MDC__NETCMIX_TOP_NETC_MDC		0x57e
> +			IMX95_PAD_ENET2_MDIO__NETCMIX_TOP_NETC_MDIO		0x97e
> +		>;
> +	};
> +
> +	pinctrl_enetc0: enetc0grp {
> +		fsl,pins = <
> +			IMX95_PAD_ENET1_TD3__NETCMIX_TOP_ETH0_RGMII_TD3		0x57e
> +			IMX95_PAD_ENET1_TD2__NETCMIX_TOP_ETH0_RGMII_TD2		0x57e
> +			IMX95_PAD_ENET1_TD1__NETCMIX_TOP_ETH0_RGMII_TD1		0x57e
> +			IMX95_PAD_ENET1_TD0__NETCMIX_TOP_ETH0_RGMII_TD0		0x57e
> +			IMX95_PAD_ENET1_TX_CTL__NETCMIX_TOP_ETH0_RGMII_TX_CTL	0x57e
> +			IMX95_PAD_ENET1_TXC__NETCMIX_TOP_ETH0_RGMII_TX_CLK	0x58e
> +			IMX95_PAD_ENET1_RX_CTL__NETCMIX_TOP_ETH0_RGMII_RX_CTL	0x57e
> +			IMX95_PAD_ENET1_RXC__NETCMIX_TOP_ETH0_RGMII_RX_CLK	0x58e
> +			IMX95_PAD_ENET1_RD0__NETCMIX_TOP_ETH0_RGMII_RD0		0x57e
> +			IMX95_PAD_ENET1_RD1__NETCMIX_TOP_ETH0_RGMII_RD1		0x57e
> +			IMX95_PAD_ENET1_RD2__NETCMIX_TOP_ETH0_RGMII_RD2		0x57e
> +			IMX95_PAD_ENET1_RD3__NETCMIX_TOP_ETH0_RGMII_RD3		0x57e
> +		>;
> +	};
> +
> +	pinctrl_enetc1: enetc1grp {
> +		fsl,pins = <
> +			IMX95_PAD_ENET2_TD3__NETCMIX_TOP_ETH1_RGMII_TD3		0x57e
> +			IMX95_PAD_ENET2_TD2__NETCMIX_TOP_ETH1_RGMII_TD2		0x57e
> +			IMX95_PAD_ENET2_TD1__NETCMIX_TOP_ETH1_RGMII_TD1		0x57e
> +			IMX95_PAD_ENET2_TD0__NETCMIX_TOP_ETH1_RGMII_TD0		0x57e
> +			IMX95_PAD_ENET2_TX_CTL__NETCMIX_TOP_ETH1_RGMII_TX_CTL	0x57e
> +			IMX95_PAD_ENET2_TXC__NETCMIX_TOP_ETH1_RGMII_TX_CLK	0x58e
> +			IMX95_PAD_ENET2_RX_CTL__NETCMIX_TOP_ETH1_RGMII_RX_CTL	0x57e
> +			IMX95_PAD_ENET2_RXC__NETCMIX_TOP_ETH1_RGMII_RX_CLK	0x58e
> +			IMX95_PAD_ENET2_RD0__NETCMIX_TOP_ETH1_RGMII_RD0		0x57e
> +			IMX95_PAD_ENET2_RD1__NETCMIX_TOP_ETH1_RGMII_RD1		0x57e
> +			IMX95_PAD_ENET2_RD2__NETCMIX_TOP_ETH1_RGMII_RD2		0x57e
> +			IMX95_PAD_ENET2_RD3__NETCMIX_TOP_ETH1_RGMII_RD3		0x57e
> +		>;
> +	};
> +
> +	pinctrl_flexcan2: flexcan2grp {
> +		fsl,pins = <
> +			IMX95_PAD_GPIO_IO25__CAN2_TX				0x39e
> +			IMX95_PAD_GPIO_IO27__CAN2_RX				0x39e
> +		>;
> +	};
> +
> +	pinctrl_hp: hpgrp {
> +		fsl,pins = <
> +			IMX95_PAD_GPIO_IO21__GPIO2_IO_BIT21			0x31e
> +		>;
> +	};
> +
> +	pinctrl_i3c2: i3c2grp {
> +		fsl,pins = <
> +			IMX95_PAD_ENET1_MDC__I3C2_SCL				0x40000186
> +			IMX95_PAD_ENET1_MDIO__I3C2_SDA				0x40000186
> +		>;
> +	};
> +
> +	pinctrl_lpi2c1: lpi2c1grp {
> +		fsl,pins = <
> +			IMX95_PAD_I2C1_SCL__AONMIX_TOP_LPI2C1_SCL		0x40000b9e
> +			IMX95_PAD_I2C1_SDA__AONMIX_TOP_LPI2C1_SDA		0x40000b9e
> +		>;
> +	};
> +
> +	pinctrl_lpi2c2: lpi2c2grp {
> +		fsl,pins = <
> +			IMX95_PAD_I2C2_SCL__AONMIX_TOP_LPI2C2_SCL		0x40000b9e
> +			IMX95_PAD_I2C2_SDA__AONMIX_TOP_LPI2C2_SDA		0x40000b9e
> +		>;
> +	};
> +
> +	pinctrl_lpi2c3: lpi2c3grp {
> +		fsl,pins = <
> +			IMX95_PAD_GPIO_IO28__LPI2C3_SDA				0x40000b9e
> +			IMX95_PAD_GPIO_IO29__LPI2C3_SCL				0x40000b9e
> +		>;
> +	};
> +
> +	pinctrl_lpi2c4: lpi2c4grp {
> +		fsl,pins = <
> +			IMX95_PAD_GPIO_IO30__LPI2C4_SDA				0x40000b9e
> +			IMX95_PAD_GPIO_IO31__LPI2C4_SCL				0x40000b9e
> +		>;
> +	};
> +
> +	pinctrl_lpi2c6: lpi2c6grp {
> +		fsl,pins = <
> +			IMX95_PAD_GPIO_IO02__LPI2C6_SDA				0x40000b9e
> +			IMX95_PAD_GPIO_IO03__LPI2C6_SCL				0x40000b9e
> +		>;
> +	};
> +
> +	pinctrl_mipi_dsi_csi: mipidsigrp {
> +		fsl,pins = <
> +			IMX95_PAD_XSPI1_DATA6__GPIO5_IO_BIT6			0x31e
> +		>;
> +	};
> +
> +	pinctrl_pcal6524: pcal6524grp {
> +		fsl,pins = <
> +			IMX95_PAD_GPIO_IO34__GPIO5_IO_BIT14			0x31e
> +		>;
> +	};
> +
> +	pinctrl_pcie0: pcie0grp {
> +		fsl,pins = <
> +			IMX95_PAD_GPIO_IO32__HSIOMIX_TOP_PCIE1_CLKREQ_B		0x40000b1e
> +			IMX95_PAD_GPIO_IO33__GPIO5_IO_BIT13			0x31e
> +		>;
> +	};
> +
> +	pinctrl_pdm: pdmgrp {
> +		fsl,pins = <
> +			IMX95_PAD_PDM_CLK__AONMIX_TOP_PDM_CLK				0x31e
> +			IMX95_PAD_PDM_BIT_STREAM0__AONMIX_TOP_PDM_BIT_STREAM_BIT0	0x31e
> +		>;
> +	};
> +
> +	pinctrl_ptn5110: ptn5110grp {
> +		fsl,pins = <
> +			IMX95_PAD_XSPI1_SS1_B__GPIO5_IO_BIT11			0x31e
> +		>;
> +	};

This one. ptn5110grp

Thanks,
Xu Yang

> +
> +	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
> +		fsl,pins = <
> +			IMX95_PAD_SD2_RESET_B__GPIO3_IO_BIT7			0x31e
> +		>;
> +	};
> +
> +	pinctrl_sai1: sai1grp {
> +		fsl,pins = <
> +			IMX95_PAD_SAI1_RXD0__AONMIX_TOP_SAI1_RX_DATA_BIT0	0x31e
> +			IMX95_PAD_SAI1_TXC__AONMIX_TOP_SAI1_TX_BCLK		0x31e
> +			IMX95_PAD_SAI1_TXFS__AONMIX_TOP_SAI1_TX_SYNC		0x31e
> +			IMX95_PAD_SAI1_TXD0__AONMIX_TOP_SAI1_TX_DATA_BIT0	0x31e
> +		>;
> +	};
> +
> +	pinctrl_sai2: sai2grp {
> +		fsl,pins = <
> +			IMX95_PAD_ENET2_MDIO__NETCMIX_TOP_SAI2_RX_BCLK		0x31e
> +			IMX95_PAD_ENET2_MDC__NETCMIX_TOP_SAI2_RX_SYNC		0x31e
> +			IMX95_PAD_ENET2_TD3__NETCMIX_TOP_SAI2_RX_DATA_BIT0	0x31e
> +			IMX95_PAD_ENET2_TD2__NETCMIX_TOP_SAI2_RX_DATA_BIT1	0x31e
> +			IMX95_PAD_ENET2_TXC__NETCMIX_TOP_SAI2_TX_BCLK		0x31e
> +			IMX95_PAD_ENET2_TX_CTL__NETCMIX_TOP_SAI2_TX_SYNC	0x31e
> +			IMX95_PAD_ENET2_RX_CTL__NETCMIX_TOP_SAI2_TX_DATA_BIT0	0x31e
> +			IMX95_PAD_ENET2_RXC__NETCMIX_TOP_SAI2_TX_DATA_BIT1	0x31e
> +			IMX95_PAD_ENET2_RD0__NETCMIX_TOP_SAI2_TX_DATA_BIT2	0x31e
> +			IMX95_PAD_ENET2_RD1__NETCMIX_TOP_SAI2_TX_DATA_BIT3	0x31e
> +			IMX95_PAD_ENET2_RD2__NETCMIX_TOP_SAI2_MCLK		0x31e
> +		>;
> +	};
> +
> +	pinctrl_sai3: sai3grp {
> +		fsl,pins = <
> +			IMX95_PAD_GPIO_IO17__SAI3_MCLK				0x31e
> +			IMX95_PAD_GPIO_IO16__SAI3_TX_BCLK			0x31e
> +			IMX95_PAD_GPIO_IO26__SAI3_TX_SYNC			0x31e
> +			IMX95_PAD_GPIO_IO20__SAI3_RX_DATA_BIT0			0x31e
> +			IMX95_PAD_GPIO_IO19__SAI3_TX_DATA_BIT0			0x31e
> +		>;
> +	};
> +
> +	pinctrl_spdif: spdifgrp {
> +		fsl,pins = <
> +			IMX95_PAD_GPIO_IO22__SPDIF_IN				0x3fe
> +			IMX95_PAD_GPIO_IO23__SPDIF_OUT				0x3fe
> +		>;
> +	};
> +
> +	pinctrl_tpm3: tpm3grp {
> +		fsl,pins = <
> +			IMX95_PAD_CCM_CLKO2__GPIO3_IO_BIT27			0x51e
> +		>;
> +	};
> +
> +	pinctrl_tpm6: tpm6grp {
> +		fsl,pins = <
> +			IMX95_PAD_GPIO_IO08__TPM6_CH0				0x51e
> +		>;
> +	};
> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			IMX95_PAD_UART1_RXD__AONMIX_TOP_LPUART1_RX		0x31e
> +			IMX95_PAD_UART1_TXD__AONMIX_TOP_LPUART1_TX		0x31e
> +		>;
> +	};
> +
> +	pinctrl_uart5: uart5grp {
> +		fsl,pins = <
> +			IMX95_PAD_DAP_TDO_TRACESWO__LPUART5_TX			0x31e
> +			IMX95_PAD_DAP_TDI__LPUART5_RX				0x31e
> +			IMX95_PAD_DAP_TMS_SWDIO__LPUART5_RTS_B			0x31e
> +			IMX95_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B			0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins = <
> +			IMX95_PAD_SD1_CLK__USDHC1_CLK				0x158e
> +			IMX95_PAD_SD1_CMD__USDHC1_CMD				0x138e
> +			IMX95_PAD_SD1_DATA0__USDHC1_DATA0			0x138e
> +			IMX95_PAD_SD1_DATA1__USDHC1_DATA1			0x138e
> +			IMX95_PAD_SD1_DATA2__USDHC1_DATA2			0x138e
> +			IMX95_PAD_SD1_DATA3__USDHC1_DATA3			0x138e
> +			IMX95_PAD_SD1_DATA4__USDHC1_DATA4			0x138e
> +			IMX95_PAD_SD1_DATA5__USDHC1_DATA5			0x138e
> +			IMX95_PAD_SD1_DATA6__USDHC1_DATA6			0x138e
> +			IMX95_PAD_SD1_DATA7__USDHC1_DATA7			0x138e
> +			IMX95_PAD_SD1_STROBE__USDHC1_STROBE			0x158e
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
> +		fsl,pins = <
> +			IMX95_PAD_SD1_CLK__USDHC1_CLK				0x158e
> +			IMX95_PAD_SD1_CMD__USDHC1_CMD				0x138e
> +			IMX95_PAD_SD1_DATA0__USDHC1_DATA0			0x138e
> +			IMX95_PAD_SD1_DATA1__USDHC1_DATA1			0x138e
> +			IMX95_PAD_SD1_DATA2__USDHC1_DATA2			0x138e
> +			IMX95_PAD_SD1_DATA3__USDHC1_DATA3			0x138e
> +			IMX95_PAD_SD1_DATA4__USDHC1_DATA4			0x138e
> +			IMX95_PAD_SD1_DATA5__USDHC1_DATA5			0x138e
> +			IMX95_PAD_SD1_DATA6__USDHC1_DATA6			0x138e
> +			IMX95_PAD_SD1_DATA7__USDHC1_DATA7			0x138e
> +			IMX95_PAD_SD1_STROBE__USDHC1_STROBE			0x158e
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
> +		fsl,pins = <
> +			IMX95_PAD_SD1_CLK__USDHC1_CLK				0x15fe
> +			IMX95_PAD_SD1_CMD__USDHC1_CMD				0x13fe
> +			IMX95_PAD_SD1_DATA0__USDHC1_DATA0			0x13fe
> +			IMX95_PAD_SD1_DATA1__USDHC1_DATA1			0x13fe
> +			IMX95_PAD_SD1_DATA2__USDHC1_DATA2			0x13fe
> +			IMX95_PAD_SD1_DATA3__USDHC1_DATA3			0x13fe
> +			IMX95_PAD_SD1_DATA4__USDHC1_DATA4			0x13fe
> +			IMX95_PAD_SD1_DATA5__USDHC1_DATA5			0x13fe
> +			IMX95_PAD_SD1_DATA6__USDHC1_DATA6			0x13fe
> +			IMX95_PAD_SD1_DATA7__USDHC1_DATA7			0x13fe
> +			IMX95_PAD_SD1_STROBE__USDHC1_STROBE			0x15fe
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
> +		fsl,pins = <
> +			IMX95_PAD_SD2_CD_B__GPIO3_IO_BIT0			0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2: usdhc2grp {
> +		fsl,pins = <
> +			IMX95_PAD_SD2_CLK__USDHC2_CLK				0x158e
> +			IMX95_PAD_SD2_CMD__USDHC2_CMD				0x138e
> +			IMX95_PAD_SD2_DATA0__USDHC2_DATA0			0x138e
> +			IMX95_PAD_SD2_DATA1__USDHC2_DATA1			0x138e
> +			IMX95_PAD_SD2_DATA2__USDHC2_DATA2			0x138e
> +			IMX95_PAD_SD2_DATA3__USDHC2_DATA3			0x138e
> +			IMX95_PAD_SD2_VSELECT__USDHC2_VSELECT			0x51e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
> +		fsl,pins = <
> +			IMX95_PAD_SD2_CLK__USDHC2_CLK				0x158e
> +			IMX95_PAD_SD2_CMD__USDHC2_CMD				0x138e
> +			IMX95_PAD_SD2_DATA0__USDHC2_DATA0			0x138e
> +			IMX95_PAD_SD2_DATA1__USDHC2_DATA1			0x138e
> +			IMX95_PAD_SD2_DATA2__USDHC2_DATA2			0x138e
> +			IMX95_PAD_SD2_DATA3__USDHC2_DATA3			0x138e
> +			IMX95_PAD_SD2_VSELECT__USDHC2_VSELECT			0x51e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
> +		fsl,pins = <
> +			IMX95_PAD_SD2_CLK__USDHC2_CLK				0x15fe
> +			IMX95_PAD_SD2_CMD__USDHC2_CMD				0x13fe
> +			IMX95_PAD_SD2_DATA0__USDHC2_DATA0			0x13fe
> +			IMX95_PAD_SD2_DATA1__USDHC2_DATA1			0x13fe
> +			IMX95_PAD_SD2_DATA2__USDHC2_DATA2			0x13fe
> +			IMX95_PAD_SD2_DATA3__USDHC2_DATA3			0x13fe
> +			IMX95_PAD_SD2_VSELECT__USDHC2_VSELECT			0x51e
> +		>;
> +	};
> +
> +	pinctrl_usdhc3: usdhc3grp {
> +		fsl,pins = <
> +			IMX95_PAD_SD3_CLK__USDHC3_CLK				0x158e
> +			IMX95_PAD_SD3_CMD__USDHC3_CMD				0x138e
> +			IMX95_PAD_SD3_DATA0__USDHC3_DATA0			0x138e
> +			IMX95_PAD_SD3_DATA1__USDHC3_DATA1			0x138e
> +			IMX95_PAD_SD3_DATA2__USDHC3_DATA2			0x138e
> +			IMX95_PAD_SD3_DATA3__USDHC3_DATA3			0x138e
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_pwrseq: usdhc3pwrseqgrp {
> +		fsl,pins = <
> +			IMX95_PAD_XSPI1_SCLK__GPIO5_IO_BIT9			0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
> +		fsl,pins = <
> +			IMX95_PAD_SD3_CLK__USDHC3_CLK				0x158e
> +			IMX95_PAD_SD3_CMD__USDHC3_CMD				0x138e
> +			IMX95_PAD_SD3_DATA0__USDHC3_DATA0			0x138e
> +			IMX95_PAD_SD3_DATA1__USDHC3_DATA1			0x138e
> +			IMX95_PAD_SD3_DATA2__USDHC3_DATA2			0x138e
> +			IMX95_PAD_SD3_DATA3__USDHC3_DATA3			0x138e
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
> +		fsl,pins = <
> +			IMX95_PAD_SD3_CLK__USDHC3_CLK				0x15fe
> +			IMX95_PAD_SD3_CMD__USDHC3_CMD				0x13fe
> +			IMX95_PAD_SD3_DATA0__USDHC3_DATA0			0x13fe
> +			IMX95_PAD_SD3_DATA1__USDHC3_DATA1			0x13fe
> +			IMX95_PAD_SD3_DATA2__USDHC3_DATA2			0x13fe
> +			IMX95_PAD_SD3_DATA3__USDHC3_DATA3			0x13fe
> +		>;
> +	};
> +};
> +
> +&scmi_misc {
> +	nxp,ctrl-ids = <BRD_SM_CTRL_SD3_WAKE		1>,
> +		       <BRD_SM_CTRL_PCIE1_WAKE		1>,
> +		       <BRD_SM_CTRL_BT_WAKE		1>,
> +		       <BRD_SM_CTRL_PCIE2_WAKE		1>,
> +		       <BRD_SM_CTRL_BUTTON		1>;
> +};
> +
> +&thermal_zones {
> +	a55-thermal {
> +		cooling-maps {
> +			map1 {
> +				cooling-device = <&fan0 0 1>;
> +				trip = <&atrip2>;
> +			};
> +
> +			map2 {
> +				cooling-device = <&fan0 1 2>;
> +				trip = <&atrip3>;
> +			};
> +
> +			map3 {
> +				cooling-device = <&fan0 2 3>;
> +				trip = <&atrip4>;
> +			};
> +		};
> +
> +		trips {
> +			atrip2: trip2 {
> +				hysteresis = <2000>;
> +				temperature = <55000>;
> +				type = "active";
> +			};
> +
> +			atrip3: trip3 {
> +				hysteresis = <2000>;
> +				temperature = <65000>;
> +				type = "active";
> +			};
> +
> +			atrip4: trip4 {
> +				hysteresis = <2000>;
> +				temperature = <75000>;
> +				type = "active";
> +			};
> +		};
> +	};
> +
> +	pf09-thermal {
> +		polling-delay = <2000>;
> +		polling-delay-passive = <250>;
> +		thermal-sensors = <&scmi_sensor 2>;
> +
> +		trips {
> +			pf09_alert: trip0 {
> +				hysteresis = <2000>;
> +				temperature = <140000>;
> +				type = "passive";
> +			};
> +
> +			pf09_crit: trip1 {
> +				hysteresis = <2000>;
> +				temperature = <155000>;
> +				type = "critical";
> +			};
> +		};
> +	};
> +
> +	pf53arm-thermal {
> +		polling-delay = <2000>;
> +		polling-delay-passive = <250>;
> +		thermal-sensors = <&scmi_sensor 4>;
> +
> +		cooling-maps {
> +			map0 {
> +				cooling-device = <&A55_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						 <&A55_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						 <&A55_2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						 <&A55_3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						 <&A55_4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						 <&A55_5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				trip = <&pf5301_alert>;
> +			};
> +		};
> +
> +		trips {
> +			pf5301_alert: trip0 {
> +				hysteresis = <2000>;
> +				temperature = <140000>;
> +				type = "passive";
> +			};
> +
> +			pf5301_crit: trip1 {
> +				hysteresis = <2000>;
> +				temperature = <155000>;
> +				type = "critical";
> +			};
> +		};
> +	};
> +
> +	pf53soc-thermal {
> +		polling-delay = <2000>;
> +		polling-delay-passive = <250>;
> +		thermal-sensors = <&scmi_sensor 3>;
> +
> +		trips {
> +			pf5302_alert: trip0 {
> +				hysteresis = <2000>;
> +				temperature = <140000>;
> +				type = "passive";
> +			};
> +
> +			pf5302_crit: trip1 {
> +				hysteresis = <2000>;
> +				temperature = <155000>;
> +				type = "critical";
> +			};
> +		};
> +	};
> +};
> +
> +&tpm3 {
> +	pinctrl-0 = <&pinctrl_tpm3>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&tpm6 {
> +	pinctrl-0 = <&pinctrl_tpm6>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&usdhc1 {
> +	bus-width = <8>;
> +	non-removable;
> +	no-sd;
> +	no-sdio;
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
> +	pinctrl-3 = <&pinctrl_usdhc1>;
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
> +	fsl,tuning-step = <1>;
> +	status = "okay";
> +};
> +
> +&usdhc2 {
> +	bus-width = <4>;
> +	cd-gpios = <&gpio3 00 GPIO_ACTIVE_LOW>;
> +	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-3 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
> +	vmmc-supply = <&reg_usdhc2_vmmc>;
> +	fsl,tuning-step = <1>;
> +	status = "okay";
> +};
> +
> +&usdhc3 {
> +	bus-width = <4>;
> +	keep-power-in-suspend;
> +	mmc-pwrseq = <&usdhc3_pwrseq>;
> +	non-removable;
> +	pinctrl-0 = <&pinctrl_usdhc3>;
> +	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
> +	pinctrl-3 = <&pinctrl_usdhc3>;
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
> +	vmmc-supply = <&reg_usdhc3_vmmc>;
> +	wakeup-source;
> +	status = "okay";
> +};
> +
> +&wdog3 {
> +	status = "okay";
> +};
> +
> +&xcvr {
> +	clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>,
> +		 <&scmi_clk IMX95_CLK_SPDIF>,
> +		 <&dummy>,
> +		 <&scmi_clk IMX95_CLK_AUDIOXCVR>,
> +		 <&scmi_clk IMX95_CLK_AUDIOPLL1>,
> +		 <&scmi_clk IMX95_CLK_AUDIOPLL2>;
> +	clock-names = "ipg", "phy", "spba", "pll_ipg", "pll8k", "pll11k";
> +	assigned-clocks = <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
> +			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
> +			  <&scmi_clk IMX95_CLK_AUDIOPLL1>,
> +			  <&scmi_clk IMX95_CLK_AUDIOPLL2>,
> +			  <&scmi_clk IMX95_CLK_SPDIF>,
> +			  <&scmi_clk IMX95_CLK_AUDIOXCVR>;
> +	assigned-clock-parents = <0>, <0>, <0>, <0>,
> +				 <&scmi_clk IMX95_CLK_AUDIOPLL1>,
> +				 <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
> +	assigned-clock-rates = <3932160000>, <3612672000>,
> +			       <393216000>, <361267200>,
> +			       <12288000>, <0>;
> +	#sound-dai-cells = <0>;
> +	pinctrl-0 = <&pinctrl_spdif>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> 
> -- 
> 2.34.1
> 

