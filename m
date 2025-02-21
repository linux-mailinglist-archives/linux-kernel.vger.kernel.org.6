Return-Path: <linux-kernel+bounces-526558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58849A40043
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66D7B3B360D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB73253B7B;
	Fri, 21 Feb 2025 19:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d+v3d3Xf"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2075.outbound.protection.outlook.com [40.107.105.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CE8253B69;
	Fri, 21 Feb 2025 19:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740167956; cv=fail; b=uSHNzmFpi0amZI5FyBi0apINf2RJXpuVlXBx0IkxAkk3gI2Jhs540PUjG3hxea0JWGUY29UD02Emei4bPAW3q4QXdn8FYg9ZmyW0DW65m40KwiS5qqTV1pkDboVwxpAQ3Uq5Xl316K9/RK1yTD4sY2Nywug3fKKYUT+6CeY89wY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740167956; c=relaxed/simple;
	bh=GOwKuKgA11D5/VNFoHuQb7o+JMGLOpGlYFEOHLg0jGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VZSvUGyEoaPmllBC8NaSwhQZV3lVNRiTedZP7Ic0cXdHR7EbO6AOBAsMbct99wwrkQriG96cl5XwSF41vE5y2zlfouW/0Waixy/UUlBqfEA2sObL8HZY19ty+UuKdA535Q3uBwqZn3hMU3+4pGEBujUblQdi+49tx/JNGmWvovg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d+v3d3Xf; arc=fail smtp.client-ip=40.107.105.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lbLfuC/qpT2mMJBkSKIeHXIVkGM2lcC3+ZEHpsTv3Q6DG+v5WXVN/i29WrDwoJiCi9K74H77AviN2NPHqeALYOyIcEpYAvRQV9n4rBPmd9pESFKkPB/HclaeVMYkOidDquBWM+zGglFpsoDQblTtxxEMH2fsiwzvLupvNNjiYs8gvzC669WlAimA1Bdp0jaR1lTuI1lS7WyXKiL4OpaYmOm11m04o7NFmEmbHHyi/yL57/ynvWbD97xePqyI4aolNWOhyxijreaMhVddREvLe8xY9XhISme1Z6bvQDdKo090PMqzdclGos71+U4Z1wj8OU/bc+SjjfM/GaZQzJpmBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VaTGTathdebxy6pmgw1VvmO1ZAoLbv2L0SIdr48RPf4=;
 b=r7NofLVQIvj6U1L8R2OEJfiTsd7uSGY6PaEXQ6G+lNib7vnEIxjH1mK1H0B/DTERHwsJ/44bDafzturyd1DK0dL6rf6aUlhTWX+jxNp1wEwNCbTWaDKrs+mj8n48VvgYKn6Me6g/M6oW96iXcKjhzCHcif9mwvrtGd2vpXpgZ5zYMLI4+mZ46ugkNcGOzpxd7oTqb+UsfU9aSok6Ed7EcQPcU2od6jS0OZvCF6NrJXxULJATeUkS9CzohI+4c4wdh0ixMiozfjif7sJWtrLB+Dj6N2Y1MMwF4jr3emF6XuH3kB8YKeBqQEHVR8XjKE0Cxo2K9LjItLD+r31VzsRFPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VaTGTathdebxy6pmgw1VvmO1ZAoLbv2L0SIdr48RPf4=;
 b=d+v3d3Xfd1st632YomMjYw//D1gGAHmTjYxzRypgTfnK3tfUb4rdirW4JKkNlwIeaBu9R1AISlK5Wc6VfZd8kHb7m11hzULWMC+o2iYZ8nOoogVYAHCO9plmi/yq8QXT6zozKi3XQQLOYaGvaxWuL0Z6o9V2VfTlISBhwGIK1HNTeD/89hqV3dgwqpuEkbafSD+21O1uBikAydTGQz+e63cliEmT+435sAwZ1XK6VJzDjhbhVe72pQJWGycDg3fj9QvdBulmzL3GviP4gTmD9ojmfT2Mtd0PH7mwQzP5t+aBES4af1lapIhTqGLa8aqEjSa1jRyxaLoEFQOUb5mJVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9833.eurprd04.prod.outlook.com (2603:10a6:800:1da::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 19:59:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 19:59:11 +0000
Date: Fri, 21 Feb 2025 14:59:03 -0500
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] arm64: dts: imx8mp: make 'dsp' node depend on 'aips5'
Message-ID: <Z7jbBxZregUUKSuQ@lizhi-Precision-Tower-5810>
References: <20250221191909.31874-1-laurentiumihalcea111@gmail.com>
 <20250221191909.31874-6-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221191909.31874-6-laurentiumihalcea111@gmail.com>
X-ClientProxiedBy: BY5PR17CA0016.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB9833:EE_
X-MS-Office365-Filtering-Correlation-Id: 641794f6-a9ec-402d-fa6c-08dd52b235dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7Wo2GNVD5pZlVkS4bkvEMu5w6rO6FFq3ObOfVLlHarc8LWK+EjnTtuzcN1dC?=
 =?us-ascii?Q?6cr825A0b9XKyX/xGL3Y18XN0VHxYvcmdqaiHhhTWPFf923dQxuRVWAh2AD4?=
 =?us-ascii?Q?/W7GVEJEQihnhSoPmeKPYE3BOqYWZCasPeoRt/mM9gVwilQFEeyWJTEYm3dj?=
 =?us-ascii?Q?VxRInpP9/GgMpUHEJOLioNPT28TxX7i32K+WwOlRn8Y4IpSEzwsiwDWvLp7c?=
 =?us-ascii?Q?+kE3ir9IEe/ly06gicZ0w6mQR14JwGxNQ0Haa9vf3hTzRYl4h5km6xBHu4sv?=
 =?us-ascii?Q?6ihxUdE0h3xo1b8+IYwNKa3f/lorkyTxXYdinpYG+1ZB2x+CibahO0NwWdwy?=
 =?us-ascii?Q?Z4SOgNaXCCQgkZ3Fdq/HRg/Qjd0mSYLBLh1rO7oZEPYwJGFzN5g8aQTjezPT?=
 =?us-ascii?Q?1dRIhA8Or7kG3LItyunpSfVnim6EAKAdtJ0XxcWZ3GIN87+iWrFiqNZC2oKJ?=
 =?us-ascii?Q?saqL8l+8DTu4KB/xoi11+Wq31FjfuJJh1HU8hTQILcbe20QCOQPUSxBqjshV?=
 =?us-ascii?Q?iA2DUcGuA2dv4dYaTsb6A27woWtjSUxleWmWXQSpdsHyDwMLHXAD0cXyL9Zp?=
 =?us-ascii?Q?QCW1zSOmisxZnG/urZyho3/pAwCH5OeAfgHTVm8gp6CP1r9tTNAqzSwOWXu7?=
 =?us-ascii?Q?V7homWrr4f5WEPqFGb+h+g57o6hbpC8JRxCwP6uCJs8iJpw0dxdAvnQ16u/B?=
 =?us-ascii?Q?AVSZ44gJv0VpgkCQrbJpe21HFNSOItSD1vfmJbRYYMatlE8QMvQb4Ge7GSab?=
 =?us-ascii?Q?qLQwYUNmNAuiY1uaXARO6y7Ld8C7g/nujJftlKT2u2WikYJ39yz+e47ERP/t?=
 =?us-ascii?Q?2H3aJOfRMHbDoRLPNd4PLGaup1zI8zlWHG92cZL7hhbT/fE2vpJVIKVvQ/UI?=
 =?us-ascii?Q?vGcKUWixE5w49hl0tLIRvNeZqd5GTgXOCzS4dPpcci1Rml6Qdfz7A1sIkE7Y?=
 =?us-ascii?Q?PKcgWzc/XBaEeLatVJ5wYX2TqI1vdO+P6UWnUcXNZUo/PNn5HHOGWmkKK5Kc?=
 =?us-ascii?Q?DNmOGDLB3Zv+96o2yQEMS8zG7X/Cz/cx0uVDkbWiwc+6onLOE9tlbZJQFJLV?=
 =?us-ascii?Q?bxhmyALgYZzeLdbkI6RyQpkpUHDCVvS3TEpHSDZgcCZOFD0CpgWi+Hfo01hq?=
 =?us-ascii?Q?o3Kem+rzZ/MP+wlAu+mjJy1fnBdzKLC8WRYYmKjEWf0M9bwF23mWQK7ZpIcR?=
 =?us-ascii?Q?YrMwIeSNK9Jk70b+9TE7xXj90cdVELd4RBVss40t+cffzzDBkochEDa64yZF?=
 =?us-ascii?Q?HO311OhAzPHNZdqMn7IQIeNhcQmn4/cei/UYAT9TrNQXYceYzx3WgjR5G/r0?=
 =?us-ascii?Q?IPabalX0GIo158CjrUIdNjTshedtw65bWxs3BdI8WoYvj45qKsr74xzdveG/?=
 =?us-ascii?Q?ByXUFwUv17yJYXE3OuDBOngVlAaA4A4LOvHGX7cgmPR+vD74N2I1MONwYGeZ?=
 =?us-ascii?Q?133xvh6FvIBe+DsShnJ2nnqZh5KzCXsk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PIctf7V3jLAFcz3CQo+jAyFvpqk5F53Rj0uu/2ZIaU8hmk/FllHEuKLtv4uh?=
 =?us-ascii?Q?3HoCVm4+rlUq3zTmkuV87nZC6ffphTRx3cFw2C0BthUCAVyzveA2YFP1FyMy?=
 =?us-ascii?Q?2XsBBXZngeqHfwcOVbOhqdSPBYgcmIZVGP+7r2pzn6IULvLMuVvThPNlJ3GP?=
 =?us-ascii?Q?kpHZ46aDePGd3EWmspIHVJB+ETj3slT3M1Ay4QwLQ6/a5lun1p8ZM9P5MOfB?=
 =?us-ascii?Q?D6fvBp03kPBN7uOmWXYCwStiaD/1paEIgBExDuurrB+uPbQ9/Y7Y2CNvaAwu?=
 =?us-ascii?Q?smCd0FTejK6CTr/SCTfzbd+Lp7kfWPQTyrBVDB9syBV6bMbwyPaGMCfNz+6G?=
 =?us-ascii?Q?gwaEXCH9MMIgzix6e5FYIfMJtmUMtxAvD8Ln7wTe00ywojYR//J4DVZaEad6?=
 =?us-ascii?Q?EhN+sAd0Odt11FaG5yq7z8U3LSuzv5Tmgmyn/LwHed8F36GlIvM6PdOaV0BA?=
 =?us-ascii?Q?akFPyxLdqDBYY8nOJkIWyi9N1XVEB/9vzg1a7w8ycbTpQREpL0iEztl+sh4v?=
 =?us-ascii?Q?usf5Smx/9qcaGuZ6K9xyN4g8mJ1KPeuL2VqYUWRpZn+upcAmUhGimCTWJSzd?=
 =?us-ascii?Q?KFv87TlggBZEyBmGxAoaG84DvYHWpfuRJJX1C2Zs0igbPRW1jN0teYmzOb0K?=
 =?us-ascii?Q?r6iO2mJpNuqNRSg1LIQfCKV+wbo3sL/4kcAWQ3Nr42Oba16w9//0vyCdQflZ?=
 =?us-ascii?Q?6PY0rMuZ/helfdhSN5omjL71S3Punycyjnrcr9o0dNVhaENPOvWg6eS/0dVu?=
 =?us-ascii?Q?XOaTOxoDn3x8ErMpqAfMPIGDa5PvYQw415vF3gmfznSWRR1W+aUau4Nflt0g?=
 =?us-ascii?Q?jsgDBXLcBFsU9CAQCNsnQUGEOEwvzcZM7TEGkIivLt7bF0/+O/CCUbZpSzIX?=
 =?us-ascii?Q?MEqB54n8E96qRdRgQndVQhm0pBreVbB3peV1cT17C3omqGGb7Q9EUii1i9hI?=
 =?us-ascii?Q?wRqosdebY1/oVjOYnV2wKblSzmKu9F3wQQOIw3M9K51RFD2o7mJ+Of+2VwYV?=
 =?us-ascii?Q?YXXbpJ7nPkcDEyqrXE+o/SA5PG0tUFlmUGgBQMcO/RamGCla1LpbEpED0lv1?=
 =?us-ascii?Q?zNZj+RyhmuDTqxStsrL45AR3ycM7poUedcTHj6ghzmdrPiZ5Q2R2gPCEscLT?=
 =?us-ascii?Q?kW0WKuyq70k3VchXnz7TZo4ZOleRbXdIP+txY1HhJ7l6r+KWyN7Kx5G6OGhl?=
 =?us-ascii?Q?0xVGc+mlAI7cQZw5qpql7YvDcX0Kw9S/v2TjxGZ/x2xOPBdHfXyqo6/MOzXz?=
 =?us-ascii?Q?KyTgEw1GRbBcIP8oGg6mPq0RPt+L2ePwxZq3wf0lX5rWV4uq9kalzD3dfz+y?=
 =?us-ascii?Q?bJ/Hw2q1qj8OPYDW9NNTKGZ/o/ifwwh8ny0VoQnyiYuCzjvYtY/BV8j6KkwV?=
 =?us-ascii?Q?Lu2JvjQB2JF+IWXLKRQxbN7BKWV4yh6bCTlfB0hw1DpoDw2qeMGbCDYfOOO9?=
 =?us-ascii?Q?4XRnZa/waUL7dUojNXTdWvqsrQIkVRF0DwZwDb4/xV5hP39U5XmtTjCdyo33?=
 =?us-ascii?Q?21Bu71D6sURJA/7IDSN0bvrhs+TVlhrBXIC1GJW+Nvkbj075z8fXt+gI1YjC?=
 =?us-ascii?Q?QXMLNjxm6NMH/uyk0cKRpdl0MpOqc0rapEHcLv24?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 641794f6-a9ec-402d-fa6c-08dd52b235dd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 19:59:11.8805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vLK3c2AXR+iL0zffTR2LVyFj8DyygKqbNAvHH+XlYbstu8PhuY2P95tlBKseBGJXG/r+bu/mVzrohI2WKlVIiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9833

On Fri, Feb 21, 2025 at 02:19:09PM -0500, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> The DSP may want to access peripherals on AIPSTZ5. To do so, the

It'd better descript as

The DSP need access ... at ... case.

Frank

> security-related registers of the bridge have to be configured before
> the DSP is started. Enforce a dependency on AIPSTZ5 by adding the
> 'access-controllers' property to the 'dsp' node.
>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index a1d9b834d2da..9ec51e7e6678 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -2423,6 +2423,7 @@ dsp: dsp@3b6e8000 {
>  			mboxes = <&mu2 2 0>, <&mu2 2 1>,
>  				<&mu2 3 0>, <&mu2 3 1>;
>  			memory-region = <&dsp_reserved>;
> +			access-controllers = <&aips5>;
>  			status = "disabled";
>  		};
>  	};
> --
> 2.34.1
>

