Return-Path: <linux-kernel+bounces-295677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC0D959FF3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6EA928421A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4F11B2510;
	Wed, 21 Aug 2024 14:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HZUeO/1j"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012013.outbound.protection.outlook.com [52.101.66.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0555196D90;
	Wed, 21 Aug 2024 14:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724250778; cv=fail; b=XX8xKL2On6w2XwDTEKZ/8bsNV99DcnSOmcQfT+JXHbQWfSF23N8vs/nWOFV17LZCiBEz3sstItF6T5CUVl8voqpz3qW1Dga+aRk0tmfq1rT1QlySdORYVVpGZD7OyuNgQM3aDjyLwdTFoosxDdcK3wEHcUK7TQ+EYhE4O0Xh+BU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724250778; c=relaxed/simple;
	bh=6t+FPwZUf8c9FldL8etJ0768fWzUwiBrcVylQSdno7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TNPpvroWdWSnIemw/Xen15cNJEoN1jabGZ96/3+kkbT81FEAaMHVpmG9VDnmK2jyLbkVcCfIEYuv/pfBQ9lUp5SxeIcwKcDowE18ttYW/DDhbLj569QVTfSawEJ1gpI6jqypWPLAv2aek/taZmDm8cuBS6kGs7Y2GQG6IdF5fo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HZUeO/1j reason="signature verification failed"; arc=fail smtp.client-ip=52.101.66.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mbRiUzjBxjmhBsKIKMKpc6otLlTFczknmxKEogTWVfRkSV8MZy1RCeoowvRBhYSl5A3gE7o3WttZN/KbbOi0HwVRA4ufPG3IxaoVBCQvfCT/0fstG1nPUf54NQXli1o5B3NFq+CN1azHreU3Z1A6YGKnCikmOrQRbpxrnzI71l+4jFzppz3SYT9I3g8+FkglbnpD2pGTx0+1/1VC2QrSMwINwIq8Ob7zE9oLO7d3Hf2TsK1XiLQu0vL0qSXIHpqZx9oK+omECN4UDVea5bEmu2vamBAYjaAnLIJc9VMoK37hKEc6F9sPtmTwiHWyt3jvCPUY3Upi5HRxtRcBOaL9Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Z33HooWno/y0G3z8LOb+ABTr7PeEOrysMC1FmPvLW4=;
 b=jkRT5MONCdG0uWUdqm2gFoq2DFuPFvNZ6ZfJzwz9rwkjhOEmwEZxmXPphm0/ZnA0LKI6ZdPNPc71nBxrXG7WcI4LstMUrcDCvzqNB1xdCmjh9upfS2DxiVFexqyacFHG6bco0LNlvQWsI5CSe6yi5HFH/A1gJwD5npEFQkVFZatlE5hkz1YycBvHr0k3Gs6v2kk0hCHcBaU7sR1BHZCiBKzZofowZZ71RTJIi5f0TM26ZMpJe9KybEETeEu7L/KLKOFI4pkxFSsOiRBzZcgu2tim/q//ZVAamaZFj7cWIlizbgYPKSQxLemQRBPRq6xQgH8BOfJX8c5nznA3UoC/tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Z33HooWno/y0G3z8LOb+ABTr7PeEOrysMC1FmPvLW4=;
 b=HZUeO/1jjGatKIL3wHDf2ugStoM4HMi6m6uc6asRJu04PAzRqjJNk+QfpP/UtPVIpkyXtD1MZ0AkzsIwx7C8Rr+1N+QXE5Y95op5BqT4OOyQI/hoZMusyYIrNCShN3v8RAG3es/RNnfdQI6tlolYW6Nta8TjFcZ+kuGHBhBO0Z2Ryxrzr+ry4oWydvzFT1PuYM9HoMjo25tTawB2RA6O7o1o9+H/LkszPpz2M/OUvaALD+5LUQuYEzHoUtAFwHOd7zPhqP2KyNfsMaj6EU2Q9S12Art+qxTxdwihlX2L3iLWS7xnU8Q/swfGC3JqrS9oDtjRa0jYc68Bs1gGb4hEKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7832.eurprd04.prod.outlook.com (2603:10a6:20b:2af::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Wed, 21 Aug
 2024 14:32:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 14:32:50 +0000
Date: Wed, 21 Aug 2024 10:32:40 -0400
From: Frank Li <Frank.li@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: Re: [PATCH 1/3] arm64: dts: freescale: imx93-11x11-evk: enable fsl,
 ext-reset-output for wdog3
Message-ID: <ZsX6iCUToi+VRCkK@lizhi-Precision-Tower-5810>
References: <20240820-imx93-wdog-v1-0-5dafda0d4319@nxp.com>
 <20240820-imx93-wdog-v1-1-5dafda0d4319@nxp.com>
 <2954135.e9J7NaK4W3@steina-w>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2954135.e9J7NaK4W3@steina-w>
X-ClientProxiedBy: BY3PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:a03:217::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7832:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ceedc28-b17c-48c8-1c61-08dcc1ee222e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?1LZgOtm3d+dPN1xO0ygLP2wo+qmZqG2SFAVBgb+3eDJCWxfkRS11OJNPEp?=
 =?iso-8859-1?Q?bbWlyL/CjaKAM3ds3uDkN4EHGgd0a2xjsURIW/Q0pmnksZwFG9ndI09JO3?=
 =?iso-8859-1?Q?w9ZT3wleeyiE/Ms6ffjHo/BaAd4kEv5fZnNS593hHfwZ1bspn5CtvKL2A5?=
 =?iso-8859-1?Q?xGhNmg+R801Fm2AIwM/4AwfFjCIwMYlLKIjgaClSNsOe5hHpQ+t8heJAJz?=
 =?iso-8859-1?Q?Llsj9UAftbHPzv3puwysecRiWwqn1CuO/JQhu0a6mQqr8ps7mJfQtY5ldQ?=
 =?iso-8859-1?Q?GbGfVepB/1MpX3h7ijSHSK3OIlZWkVB0EKL6FS+7z4SVV8dPn87CrDYgJU?=
 =?iso-8859-1?Q?zMSPoiIkc3TEzLmQu/dHtLMsYkIjo2QwPOBFTMiFj8wvDEVE0ROmwZtkFw?=
 =?iso-8859-1?Q?E/YfkhUdvM3Nt+YconvU9ypydW6Asa9a21DDgQX7rDkodJsKcdgcb94SzR?=
 =?iso-8859-1?Q?Zc2AukXXV6Ozbl5t6NwIh5va6/aHoWpCKVtRbp6axnqtYaCfBiEkKOGAWz?=
 =?iso-8859-1?Q?LXXP5wrW9iv8cT6JuXrpPtIN+zOSxdTjI/NE4yCDqVmabEYvczPvFMCffY?=
 =?iso-8859-1?Q?tz+zUo+/bSH+VQkG2/h6/Wg4AhhN21W02yVUpqGz29BYNnNzD+c3RWDttY?=
 =?iso-8859-1?Q?94FENl+uwNp3pnCgaOpVHe96JV/3i5kJ9SBwKwEyNxQut5RscCrrLltCDl?=
 =?iso-8859-1?Q?Fko5isgsPsP28XXRPIRlL5F4yRp9FEhXGLl9NdvwEOx0xLbD2A4+tyi/22?=
 =?iso-8859-1?Q?fI07KQV412OPHRZrC0dXiRG3oradV9aBYpHMSEGlbB0eKigu8zq3UwZYnD?=
 =?iso-8859-1?Q?q4EXKyfbMkbu8P7qY5uG5k80f4qTK33HBk5fkYscvZ/KmOneXiXEZv5cTU?=
 =?iso-8859-1?Q?rkAy/pk+JcTpCZ6EzDemmFxvlkyNCmaGL53cZFvbAzQUJGt2c5uBSWAnVB?=
 =?iso-8859-1?Q?eeNv7Gs9IztJSOLr9wTzMRWlaAXa4hSpTJsQ7BSpaKGZjsBp5aEYuK1Y5c?=
 =?iso-8859-1?Q?mk2SH58i3xnOxxls7GZsZ1Sm7TN2jUse7oWZeHV+vpxJqlhTX3kWea1ntA?=
 =?iso-8859-1?Q?dSV9ijmVGo3Al54jwCV7g/+idW+bVzGzoRQMC6lVI8ONdzYUf0CbWTGVyT?=
 =?iso-8859-1?Q?5kq7bHbwjoceAXP1giPPgEKO2IkVYMtJZcAStRsb7tr2IQKzitVWhPu5UH?=
 =?iso-8859-1?Q?G0PfalWZh6QYweR5BDP0o/R5mpurfuZPzo0L+b4pqDXVkTLMHGHG26xZQl?=
 =?iso-8859-1?Q?h0NwyGEWBwbBZrc3wrpHBBevBjginWUxw84L7OyN70z734Vvp27XmLK80i?=
 =?iso-8859-1?Q?ksyV4+lPP6PZ2BnxOFaiqoK+avPuNHRgsOTXoP4ecDoSJriCiK2s4P3Pr+?=
 =?iso-8859-1?Q?Anmh/4jnS69HNTGrU7e9fhpAL32phK+zSKjm8hp9qYbNAajcfpcVk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?R65uVD8eNCWJgl1iTgA1RD9bZ5/iQSGJky86ZjHSuerhdfe9xgDsA4UWiH?=
 =?iso-8859-1?Q?7JfkX4C2HJdzKj3Q50KIxvLf7yT/Z1o+D2LtmW3JDQkKi2UGkRm1lkLdN9?=
 =?iso-8859-1?Q?2wO6ttvYeX6oPypvUUW88U5qEKK1gBputIsrs922U6q3+MUnbVXUg2dS6s?=
 =?iso-8859-1?Q?Y2/te0FbUfsiAplh3SPrmD/XN5bhhKHt0AE4OeXYx8EsmElsDoIE/5Wtpi?=
 =?iso-8859-1?Q?j1t8vRnAw3Og9lvaBJnVXKIm7YDjfrcQ8wRL2LodPqW+Oh8p/Vas9nqTL+?=
 =?iso-8859-1?Q?QlyNdEJqH/NXa3hvCVOI9INecHrm7zflHLZ5G5xedkeMmDF4qXsTr0Lwxm?=
 =?iso-8859-1?Q?L/uATImX9MPc1QUTrhEqPK5EQ7F2guKy/vUq+BHy7BoQJvBAMn4kOGA2aR?=
 =?iso-8859-1?Q?xUHH1+UXCgUHroF0lQuIc6hRp5OpYlu++tmTDRfTowHHD2OKa62xJWRqfH?=
 =?iso-8859-1?Q?5HL5KiMbp8zTmbmIic96PcpHk56q+so/+qbOLtfgmPz5CFO+DnHQbx4O9z?=
 =?iso-8859-1?Q?Bq7/nh0lEa554hvlVjUzhwPkMQMVslWU1fhzeAVXzT4C3vMrD0460CdFRM?=
 =?iso-8859-1?Q?77BR8M98urX08g3pQJnYQNKe8JwoIeV1I2Dtipk7Ky7q25JMiHXwNQQSUf?=
 =?iso-8859-1?Q?6mYPrOqld5zEFmRE54iBaoMxlFOFbqdgOg1PNANbcA9Zn2ODBpKT5D1MMj?=
 =?iso-8859-1?Q?uLl7vqnX44rj3tEGKLBcw2wzePBEe7wOw2iZPe1ASQI91swWKKDQp5upQI?=
 =?iso-8859-1?Q?xP1RH0DCv1YQDWEYdiDALGtMkoKSIVABmiX4L216yxO1SRwhtwifLgcjRS?=
 =?iso-8859-1?Q?K+zNa/qQLadEf0YRDRzrSLHclTjBhM7xVoFu0T0Eecufzi+bqagCbGLCTK?=
 =?iso-8859-1?Q?ooj2OHtW9CV3W1Zd3/aY8EiflHZsnpZiGKkW2FwiOp72PblaQtdF8OjVw1?=
 =?iso-8859-1?Q?XOfI7ksRC/Efhodhn5lyEOlZSnGvSKkGUpOJe9wXBpVUoFj2sRskY9SzAg?=
 =?iso-8859-1?Q?jhO/jJ0XqJhQIylVEXuWSK2U1psOWgQDpS89czO8V+gPDy5tvYI7aG7Fmk?=
 =?iso-8859-1?Q?c76CbjbnhpK91RF/XHseNfbBdxsT/lLOT9WkChiyqPpfRPQsmXndIYo+9S?=
 =?iso-8859-1?Q?6Efb3yDb4lhiB1zpoXrAs6zINEz13Xh8Y6kNEXhyOPKGx5/+MrFYcxhwUN?=
 =?iso-8859-1?Q?fQAr9x3mTxsWhWObUFRdDTh4gM8S/n9WIJMBzp3PUZfwEZc8L7v8mQ1tZJ?=
 =?iso-8859-1?Q?B89iF0eif3qSwlU4O+y2kADea0sdRxwmNsQRNsYCnTQ/EB0Pcjft5cxNJU?=
 =?iso-8859-1?Q?/agSJS0lMd1GDwGkPFUYcR1qMk6nGvIbOb6SOL57xR4KBinW2UKggNCicl?=
 =?iso-8859-1?Q?1f87sYTHzzK3AvFiDqesHv3DplLqb7qlBXrpVYUO+RytScHN/q9dJQqNbJ?=
 =?iso-8859-1?Q?60L1T+SXjrTzl17lCFj2xiAxzNsutd143jMHqqtw0/iD3r1mcS9goC4/u1?=
 =?iso-8859-1?Q?KuBN53VJY6riho6GCIkzQzrnwHI4CXg1Uca/n7mIdISCHY9JpQ9yiYtbIl?=
 =?iso-8859-1?Q?oLKsvAQuq6gbsvOT2JieuyPpYf1il8ffPrxtm855yt1E3tDfBOnhTOts7J?=
 =?iso-8859-1?Q?4WIxaQkOniIhIivXhuiVVokuN2tuzLCaO0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ceedc28-b17c-48c8-1c61-08dcc1ee222e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 14:32:50.0867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pfy3xo83mQJ9tOPyftTQ/sd/53wz9wLyGUxaG0Sv4d0lMLh/Nukl0+S+jElpoHO5e/Qyjs1+pHyTSEbROHatQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7832

On Wed, Aug 21, 2024 at 08:32:06AM +0200, Alexander Stein wrote:
> Hi,
>
> Am Dienstag, 20. August 2024, 17:02:39 CEST schrieb Peng Fan (OSS):
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > The WDOG_B is connected to external PMIC, so set "fsl,ext-reset-output"
> > to enable triggering PMIC reset.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> > index 60eb64761392..fb93ae654a2b 100644
> > --- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> > @@ -485,6 +485,7 @@ &usdhc2 {
> >  };
> >
> >  &wdog3 {
> > +	fsl,ext-reset-output;
>
> The MX93_PAD_WDOG_ANY__WDOG1_WDOG_ANY pinctrl is missing, no?
> Same for the other boards.

I think it should be already set in uboot. Otherwise if system halt before
kernel pin-mux driver probe, Wdog will not reset board.

Anyways, add pinctrl have not harmful here.

Frank

>
> Best regards,
> Alexander
>
> >  	status = "okay";
> >  };
> >
> >
> >
>
>
> --
> TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
> Amtsgericht München, HRB 105018
> Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
> http://www.tq-group.com/
>
>

