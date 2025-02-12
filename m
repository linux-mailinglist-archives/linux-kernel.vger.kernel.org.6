Return-Path: <linux-kernel+bounces-511438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8168A32B0E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D3A81637C4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D4E21129F;
	Wed, 12 Feb 2025 16:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="n9zYIluu"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2077.outbound.protection.outlook.com [40.107.249.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C231B21AD;
	Wed, 12 Feb 2025 16:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739376189; cv=fail; b=HqXewsdaEHd0Yr64ZLn9CKCfF7eyBoUlhK+NxrHNAqD58AJt8e/anZsB8n8GWKblvn0lXEELwsqJUNRBk8jQxDZcAl6/FUdwPjsIY84bWG2BEmy44qpwwJuejQac31zusbYKyD8jraXzA1kLiZ2CVZMSmwYmhnJRi1IwnVc0xgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739376189; c=relaxed/simple;
	bh=G/5Q5cuWnq5Hwwj3MNiNtSTC7xxLOc55ZKGLHWJJLTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OMS9i2G8mdkNns4ZOxniOg5aFodRHvwNNWwHAqFSaGt184oqkVtIYxxDftu/Ib3lUooxqS0zjA6WhfiNTx9np+uYArMRCu1l7CF44UrRAL4fxO6TX2cgVOhl40T45StI7nzu0W60BJwIOfinjbKpxuaMIrgHAGRfHzBw0yaAgjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=n9zYIluu; arc=fail smtp.client-ip=40.107.249.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yukl52Q8T3bYlQTZu+7geQ4tynE3YlJGKR7JGray+n8pMs0BSEc78P7LWBzBd7SD/ZOWZMQlVY6GLle5MHuZuTYjYcZYV+0DXih864HIXnMchcXCl/AzTCAELxhKgh86c7nKPZNRGKpoWHiEOfLibeyPva9B29b6bYl9aI9w9L+3rVZ3St9j8LGPUQAeOVZ5JF8Ofbi2saNUNnTdkfRkTEgqoVi2PTiNxzn2vWnNwVt9X8oC7cDDb5G4TNHFOSWwKf+ecOx+cIRxdEweJudGlJxyFHb5pu7pFwREQvxgTVWRP6WEEAMEy1Vh5UcC/kZLzoYHllO7+S5ecyfBUIW0NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h01tBPiU2ygRwWSeLPL4wTT6oU1ghrAYDYjLDeQtDIY=;
 b=BOz0hKRKLSvFAB1QHgUUHKNzvg0+mrStHsCNkvDmqbw4IW0cgbez8onR1e1KbZmJI06jYXTe4U34taYJCvxcivi7cufaKgxl5IcY8tJy8KRIJbvAZlY31zxa2kHRSewRbQ3DiUZbKSFPlqa6TAnvi8goFb1xZe+aqLqjmCJzWohIOwH7Wf4w0ZN3ygEGtf4D8LrFu6F2w4EUBOoT+rriSAOn12kKd84PCHQP6/Je98OpSR339HMv8jGNPnlzl3Ba4dfyTqxUqFe/ioJwycxgo2sLZATkVxTgmoh1KtWOnZcT1jyhZHjKlzl2Nns6Tk8j7jNWiJ22syz1kSMHn242WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h01tBPiU2ygRwWSeLPL4wTT6oU1ghrAYDYjLDeQtDIY=;
 b=n9zYIluubKgc+CaF9hm/kNJRKn7+k9EiBpTxtETr4Tv13HQZaf6E5VUdCUgkQClitBH7asfXiXMlJV302G1T4B1hYcdEOxhXjILyCaUpLd2+eLETosYik4dwvUWG4yvZDAzaK8ElGzWNtgf5feK+lW/KynSCRrvVFOzKgdTPmCId4G4kZMIapFynnr94IApcEPIK+ci9prc4D4/CcvhMxKorKalAEmlD5XTfbCuL1HTN0zDZ9Qh7ggR+sDLchVSmxq67rwVRfRnuiY1h+6GxLm5ILKmuHBdehWNZaNYmVmXwcF7mQ5oDoEuMAU19Kya9dQkz0txcYPLdfppy7SKlUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8071.eurprd04.prod.outlook.com (2603:10a6:20b:3f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 12 Feb
 2025 16:03:03 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8422.012; Wed, 12 Feb 2025
 16:03:03 +0000
Date: Wed, 12 Feb 2025 11:02:54 -0500
From: Frank Li <Frank.li@nxp.com>
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: shawnguo@kernel.org, robh@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, krzk+dt@kernel.org, conor+dt@kernel.org,
	festevam@gmail.com, devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	aisheng.dong@nxp.com, daniel.baluta@gmail.com,
	laurentiu.mihalcea@nxp.com, shengjiu.wang@nxp.com,
	iuliana.prodan@nxp.com, a.fatoum@pengutronix.de,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v4 5/6] arm64: dts: imx8mp: Add fsl,dsp-ctrl property for
 dsp
Message-ID: <Z6zGLn3B6SVXhTV1@lizhi-Precision-Tower-5810>
References: <20250212085222.107102-1-daniel.baluta@nxp.com>
 <20250212085222.107102-6-daniel.baluta@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212085222.107102-6-daniel.baluta@nxp.com>
X-ClientProxiedBy: BY5PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8071:EE_
X-MS-Office365-Filtering-Correlation-Id: 24a9231b-1e33-415d-990b-08dd4b7ebacc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lpXX6ycfcfwlqce7HB6Azjp7kw3SK6VaYq6+lfttprVpI9hMFfw0lW3Z8QqA?=
 =?us-ascii?Q?HbxaGxb2D/my/UwA+nC3kAyWaAGbJ04XtaBNRY30lPcuXuxZskOM9ajueK95?=
 =?us-ascii?Q?NKCmKmR8KfMZLWL5uKuV7log+yf/mH6vRFkjsx3Mng3kUp6qve63gRHyoSWc?=
 =?us-ascii?Q?iVT4i5L45keiAPuqn7Op1ANiuiAit5PS9ntgxhm6EY2Z9m14hc40JKLJsUqP?=
 =?us-ascii?Q?Ia/rDWQVrLGt8NgdE88YZS/fANsQvnfeYfZ23+lIHLSV+ISXnb5TFGh7PnED?=
 =?us-ascii?Q?eQsObau2FqG3ggvs+9znMOJUbtjruK1AwBqq0HviJ5x6e8sEqZZhVjDhVdWs?=
 =?us-ascii?Q?qoWe1vbysltMaLvlYrpXZVtW/oUTHn72mMMpyDkLQxTq3tUe135eq2g7Iztn?=
 =?us-ascii?Q?M8r9u7dbiDtj4HdQqNyD+hWOAUnTEUgYa4++3OtX+bNhQCydFJo7vkJqrxEV?=
 =?us-ascii?Q?NrxBB0c9CviPouXpDANPPV9D/G6L2GRywmv07CWzFq3XxVoWr4nmwx2UqN3Y?=
 =?us-ascii?Q?ikIBMjKoBNrFpCQ8w2mtktIjgeZ2rhuw7UFJSKrmphJ3kmY4gSzvHNsYW4g/?=
 =?us-ascii?Q?Stzk7UYYGYvZd5ej3FDoRFiwf6cN/ltCpQ7cPzyfPDVEWsQYDe3wur2uQzvS?=
 =?us-ascii?Q?oHzOwQGqWZD0qJj9pndwR6ormvceioBqoDnT1cpnhsNg1KIT6GUDFpSnZZIx?=
 =?us-ascii?Q?kgus7kAVZ5H0sG3c3+EFgSPVWRXw3x3WbnsfPQW7W4kPRUqfHN6n494Zx4U7?=
 =?us-ascii?Q?zfJuhe0Vdrj/fEZJEpDyivgljHHoMYNwS/7TDNR+1w8lYoWmStBOJjQ11dtR?=
 =?us-ascii?Q?9OwZqMzYl6XpNom1e1qNSf7Ctiq4QcjBJG5ZtuFyiKXO5PycGEGSpJEtJXf2?=
 =?us-ascii?Q?hg72reIn+O1+kGuEsDVBM7ClJ0O/xmQRZ2GVzH3NaJNqAKgom5ljG0Jou97D?=
 =?us-ascii?Q?ERuCNXpvCouSdsbhWGmYh8SrWKjiqlaEq0k0zxWqmN3gqq5U9cvRTVUZL0pT?=
 =?us-ascii?Q?aUu1dRKJjOQz9kdN14lrnkVs+0botk1x8iLKfv7NBokiyNxkitOR5i+0YsRV?=
 =?us-ascii?Q?J8UuNTTufTvRO61M3E107spNbi2owEn8H7yijA8kqibuPCgCogXPSYmNLj6d?=
 =?us-ascii?Q?IPOa5LOiZxSkzb85ZvY2oraB9gO+WuAwlO6fqOpPap6Mf6SstX0NY6yK02Ex?=
 =?us-ascii?Q?cQkyF16dET28iSjLhCCcLZrkTbZp4xG30S9gkYtau6Cy5MhZVYcZvyKC9U+7?=
 =?us-ascii?Q?GKQp2FoM4GGcGPBHIygEtb3DVkpPTIhZHeLgjTlZBfWKkkOtMaGLisbsvUTN?=
 =?us-ascii?Q?emvErNpwOJUklB1xmqno7hpemIqyyyodU4jTkYHpRjInbISJ2vKt1wb9Y5Xp?=
 =?us-ascii?Q?3EKfJvJjyJFSCZHfupod2S49mXegHvWgfEDgWJPfZzefCQ83p2v6snZp8FSx?=
 =?us-ascii?Q?bQq6LEy2VwDK1/cL4qTD1fnlvhqEUpbG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D/FTxexSJzURdZtE7cvRjDSW6f+zt3WIz56rO+GKdDSqbW26p1DUxWFUBJtL?=
 =?us-ascii?Q?2MfKFQZBL9VBJZlalJqpidv7vkoLvg74VZ1eHOkBgl8yvjP/0mzAyMgTYE/B?=
 =?us-ascii?Q?D8AAC8Com0Yd0IKxvlcfcf8KFznxNuSNn45upcIDGp1bShB1Bmewxik0wcie?=
 =?us-ascii?Q?aUmOWfwoBEVLrDNR0fhxKFhhDaKyi5HtByFmi9v7O2C4Le+I/7fdGIgm3CGx?=
 =?us-ascii?Q?CBiyYVehO8RxgD/wsU6euumOqtFZc6pvjiwJhw+v9mJ3PW6Wd2pDl4NJQezh?=
 =?us-ascii?Q?kL4hvXi1BK7Ij4Zv5zSfhbQ5DWFb9F8ayOAetmJatJiBIFN3AOIwJHympZwc?=
 =?us-ascii?Q?hwhQ6W3VkoXdOvmiD2lfnjvuV95J0YvUW+drG2IUeW01JIAlpcfTxZGKgkOd?=
 =?us-ascii?Q?iLJrHgz2VuwhgNU8QLq6I848UT+yj8MmqAycrn2Fz2DUhuGXzybIpYsAKAbL?=
 =?us-ascii?Q?bJAQfb0mTDnybmks67VzL5RkuF6Dnmk7Vh8KxjiYAHtzlLU6EM3IEYxN6MRm?=
 =?us-ascii?Q?HiKS0uAREdziRh0qAf0zCnFuLqC+E1Y0UpyN2lteTP7Y7cpevQL8ntmNH3QO?=
 =?us-ascii?Q?HO24OwlPJiNkrhLzLtzGHVZMkueQfAVNr/sOEjVV+qKo/zFcTO32E2KtjizV?=
 =?us-ascii?Q?EVo5F8UNKt+1JVg3bxZ2r8h9ZyZ07QdA3GUv2nK0GCiQKtH/DaJ4RPkaXPcL?=
 =?us-ascii?Q?18uS3Xkj7eEAd7x+mSLlRkx3PdeNDUC4MitEMwW5kGFCn/UuPZtPwDoDYlvL?=
 =?us-ascii?Q?zL0LaOUGdBTHXGQjPgHpdoaJsSCtiXn1E1XAgQXDdVhNazE4Q3RYjT25Dyw0?=
 =?us-ascii?Q?CSSXtsQkRO2fJGmAyQxbZ8HCXr/XhUnvkc8UJHayj4rIKtApYX15faXUMxQP?=
 =?us-ascii?Q?e47mTqplm6wXKo/+ZDxT5HpIYPkrcGFCyTo2DDTdbJvlxjzoas5LU91+lx7E?=
 =?us-ascii?Q?lGOmYsoKXPflzHu09VcD9BvsQA4Z5yRm6LwsrnzVr0rF8FnXrBYNjjb6mTqf?=
 =?us-ascii?Q?7N47utYadD7MxHDs3xgEdb0BAjbXzWYSNAFh9m98AIlf4z0HOxLEwmApV7Sb?=
 =?us-ascii?Q?wDKh5PUAJNr3Pbxa7hjCShPBBFOX3el7b7SQwH6jtlK0HTfZUJkcJGVtBo0i?=
 =?us-ascii?Q?wORIWioP+lM7TYL24UhRAtLMrVzmQlZPDu9fV8TjY9eCyaJXXu0IrKxflyz2?=
 =?us-ascii?Q?/VH/GMwZgSAJ2JzFAPGMikn3DhJFJFzx7qOzZfwby1qaO7lzAo+gAR3GRD8J?=
 =?us-ascii?Q?38ASB9W0TgIArxSzZswl+pYPWCrNloZfGf4GJ9m+M7ZzZy2iF66dhxXgXzs3?=
 =?us-ascii?Q?sIpMD58oJquHnmZXVv9NfpBDgbMdb+eNT72Zj+tUlKGcikeGRlaaxb1yFDb5?=
 =?us-ascii?Q?JU4C06gSR/CWStUKxkJEyNm4O1YJDhVaKFBRdngCzbfr0z2bv1MPy00JSwlY?=
 =?us-ascii?Q?Q6INduV7UTRSvyyGVAOHa8ZU70nPDYse/UuxMKUh2cnBRqIvgiO2bfvRr6Sn?=
 =?us-ascii?Q?CInZMQVsrSuVaktINnbuEqnB1j+Xj6BXTqt8VCOhEua/9kM5RP62GvSCT3HL?=
 =?us-ascii?Q?PGno3EIywU2mnPVL3wFA5mNOdr91hLU2henYHE95?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a9231b-1e33-415d-990b-08dd4b7ebacc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 16:03:03.2078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GV8G33RnOsF+LoZsUwlcReSIa16stuPtuxXAbKdPGPciJ0ub8ERDymCKw6iQJ1om2oQ5jNb6nbbTl15s027BOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8071

On Wed, Feb 12, 2025 at 10:52:21AM +0200, Daniel Baluta wrote:
> Audio block control contains a set of registers and some of them used for
> DSP configuration.
>
> Drivers (rproc, SOF) are using fsl,dsp-ctrl property in order to control
> the DSP, particularly for Run/Stall bit.
>
> Note that audio block control doesn't offer the functionality to reset
> thte DSP. Reset is done via DAP interface.
>
> Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index 14cfbd228b45..46b33fbb9bd1 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -1609,7 +1609,7 @@ sdma2: dma-controller@30e10000 {
>  			};
>
>  			audio_blk_ctrl: clock-controller@30e20000 {
> -				compatible = "fsl,imx8mp-audio-blk-ctrl";
> +				compatible = "fsl,imx8mp-audio-blk-ctrl", "syscon";
>  				reg = <0x30e20000 0x10000>;
>  				#clock-cells = <1>;
>  				#reset-cells = <1>;
> @@ -2425,6 +2425,7 @@ dsp: dsp@3b6e8000 {
>  			mboxes = <&mu2 0 0>, <&mu2 1 0>, <&mu2 3 0>;
>  			firmware-name = "imx/dsp/hifi4.bin";
>  			memory-region = <&dsp_reserved>;
> +			fsl,dsp-ctrl = <&audio_blk_ctrl>;

I think kk's comments in v3

"This should have been implemented as reset controller, not syscon. It's
really poor choice to call everything syscon. It does not scale, does
not provide you runtime PM or probe ordering (device links). Quick look
at your drivers suggest that you have exacvtly that problems."

The above is quite good suggestion.

Your reply "But for Run/Stall bits we need to use a syscon.",

Run/Stall actually is reset, Most system, release reset signal means dsp/core
RUN.

Frank

>  			status = "disabled";
>  		};
>  	};
> --
> 2.43.0
>

