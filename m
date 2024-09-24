Return-Path: <linux-kernel+bounces-337430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B50F0984A09
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11A08B20E2B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BE81AC423;
	Tue, 24 Sep 2024 16:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XUJQqil2"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011036.outbound.protection.outlook.com [52.101.65.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB8D1AB6E2;
	Tue, 24 Sep 2024 16:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727197002; cv=fail; b=AaE/xuxIzTm2EVs8ZL4y9U/TgPQTCGp/QDvRhyhnd/f1d1bkzyL77o5hXSSqt/g8xBFvZiYLnl85gBRe9hQQD9GZ5cuXQchSJsmfP6UYy3SUd2Y6izaa0PiDPWi4heuPUd6pP2TqcouPzb3ElDiOqo2zlVCnVenM7/405drGNYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727197002; c=relaxed/simple;
	bh=lG8/boLpOO0MhjxE0oYASyXJrvz1OwV5TgXIr24vZWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KGhd94xfqk3l24bmMheQd3zkPNxBMRb86xtW6Qc6w7UqF4BKhAzhxu8hMY+2pJb1efC+T0yT8aCWswMNzCCq5PH4MW8cw0iBI1dcnC+kk0RqKBFf7KNPHuHf4zBCGaPcDcdHckap9l2wBYQMMPuygeE/4wp7oAhuUJeX+Sqat0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XUJQqil2 reason="signature verification failed"; arc=fail smtp.client-ip=52.101.65.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJwHDcsU/l165O/9uSdUkXnHSQ5mgrSt+0LhZLmieHvpiE0eNNy/tbEya6viOq0pXqW9Ahn3fRhkMgrSFE6Uq3ivjRv80dZxitveHOM9gh9G/288M5wDnOb54ofXrMostp9+HcG4x7BYJVOfkJIPiqOdjAPtLSw7+RI9wqjZ4a2VSf1Gc4EKRwRA56BZ5GxMYULPfi8sxWes7QkDQ62g1ZRaNnBfsB/VpCK2dQKEjmlX6MTrveh06aM7hBIMSHh5v3o7Eujt401g3jbaTCiD/nxC7bQc3YgdHi8vItTGFOjoQsEnT0mGLEjf6mV6YSr10RpvAblkBrGB4CgmH2sexg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2aav4my2M1IsI5UFXV6X8a9ZcTVppiRTWtlHtWcozAw=;
 b=ecHrWLrPuEBXdzrpTATU4aJXyvwEmIBiJOk7x+Uab2fHIyBy7ayQdRS52iAC1uH+PURc+fhl0gKgXrQVral9cDD5XKHApdsWJ3vhuME4yoSE5yv6XlytUDopeYjNHZZ8xiyAsOJQAOB/j+p/1+mi2ctbslv98B6OGpNfCNeCla1+G8KR1Gyu3/8WQsZ2TbAbIKgP4zkSXaf1LS3JfzdC+DPlu0GAQ0lZWQhTnGHv1MGbII83M2HHp4Htc9WaM1j65Dn7A/IX4PQkKV1EuuoKp9sYd/1WvsHTYU78K/IVa5QdkrRc5BvhpnWang4g7/mXD8wu51KJKPlwLaJlsapTrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aav4my2M1IsI5UFXV6X8a9ZcTVppiRTWtlHtWcozAw=;
 b=XUJQqil2kHa2C3Bz0F+/70q82jKMiL73s1zt0/TmXuf7ySMWSkekTbgL0nFJUkKSHZ29bguR1Ra1ihwfKRRFEkPjlfSENzJH42Dr+ehKK3q2WC5ZIc4OWLw7Q9Wlv3TFgkTB+2QUB7To1peuW1ZBqoidFS2HRMV1Opbe0y8xTFFIK7U2KIIMErGCjt5+a0UX0UmTpaCnZ69qvPyugcHcnPL1BZVW5bSoi5vdklRAVqFDhjSZ8MzIH9PVZqHNxmHTowAccGEre+6DD9GN2/YnfPI58h88qjrOTyncsNZcGFapMu8Tl8Ci6JtGiDhMRUm4OKquLLnVfMOY/UzxqvWwIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8704.eurprd04.prod.outlook.com (2603:10a6:102:21f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 24 Sep
 2024 16:56:36 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 16:56:36 +0000
Date: Tue, 24 Sep 2024 12:56:28 -0400
From: Frank Li <Frank.li@nxp.com>
To: =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 3/3] arm64: dts: freescale: imx8mp-verdin: Add Ivy
 carrier board
Message-ID: <ZvLvPL+/gL0WHXWB@lizhi-Precision-Tower-5810>
References: <20240924114053.127737-1-francesco@dolcini.it>
 <20240924114053.127737-4-francesco@dolcini.it>
 <ZvLWP62Gw0nygxaF@lizhi-Precision-Tower-5810>
 <20240924165021.n6lln424llsfzhtu@joaog-nb>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240924165021.n6lln424llsfzhtu@joaog-nb>
X-ClientProxiedBy: SJ0PR05CA0181.namprd05.prod.outlook.com
 (2603:10b6:a03:330::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8704:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ea1eeae-cac4-43a4-e880-08dcdcb9da28
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|376014|52116014|1800799024|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?iso-8859-1?Q?G/rhlBLwzYg1s7Y9Hh9Xp1B1MbcVnBgCUL/7pSeTDQPfRVzylxGYIjKhqf?=
 =?iso-8859-1?Q?NerVEWTwaV5RcHfytlxfftLUjbKLuXLJ8BILdIbpaVoCBUFAdM6K0xYXT0?=
 =?iso-8859-1?Q?NCWxQmlAr5zzJknTRDJsRrR8jNNb8B8fiXbdkJrptBklhTZIg99wiwFqpi?=
 =?iso-8859-1?Q?7Kw63MNfpzyTGld4xFJDN+mHbx9bfmaosO5nrbrgiYCr+hkGDk72+UHv4m?=
 =?iso-8859-1?Q?vDX8cvyvgXXD93ALIFijeWHVP8PwyvHfJ5UaGfxymY8uPulsWn5kpSsm07?=
 =?iso-8859-1?Q?W4BwVTQuxI4z+cF6ptB5/FJdTBeQdjBsgdKAVWJ8iO6ENxvKkDdttzCH/T?=
 =?iso-8859-1?Q?9sVrlLPwQ349HlqQzTkRBGSZswHc4drG5O697bgWNPm3fjrBoJ84Pmyuca?=
 =?iso-8859-1?Q?q+7gsocCEZZt7XbGXUy1LMDrsKSwE4mWERr9wm4QY5ICkYv4gcyPF2XOkj?=
 =?iso-8859-1?Q?EjtKRin1EBaiCFjUtx4FHJvez7At1ur8oyCPhtpo3+3i+yG1BQuEizUL1D?=
 =?iso-8859-1?Q?wF9E4Ak3bgkheIp6hqktI1vgYuYGAimi9z07/rZYRBxEXAUQVTBaYWCGrS?=
 =?iso-8859-1?Q?xPYtz724kkcyKuwPIiZ/VPwOXpRa61cqmdOTTIVGP3DVHi1rNqYKbAfkCV?=
 =?iso-8859-1?Q?nvQMC1FA9gweY/vgEDIvsBnZ2ea6xALpGM/EuaBHssSdGleN3MtEfXzrEL?=
 =?iso-8859-1?Q?LlzRb9lh/1Ng0UUvSz4bOQqMb19KcD0jeFOmSv8+QyjHp5oE9qvgiNjqOp?=
 =?iso-8859-1?Q?/Ff3YL2rHK790qtA5d32gqmeLr467L0rrZvDsfap1j8nNOTjJS5uHhdlMz?=
 =?iso-8859-1?Q?q8VSr6Lo/Uo8HltMCaF1rjNwlVLIT7ieK4z3GKSeZIY2Al4RRboPuc5tZR?=
 =?iso-8859-1?Q?rE3Wd62EtA8C8k74GnVaP7dI16MWuR8bjRA/lvC6b3Ctk2gybk8kbDMBtA?=
 =?iso-8859-1?Q?xUkm7RPlDGMwvXuDruU1kjUWv5l//fuEGqSLSqO/XEBijHws1Ca8kg1LSf?=
 =?iso-8859-1?Q?l6CLryPbE1/7YLePIyd+XrPY6o3L0dDTnFAeWO02pmplBUiFAEHdjv+LXY?=
 =?iso-8859-1?Q?kWhPhwkeiy421t0EwmRF852CSQKdrBwWWDnNFqbf9lELnm0F9kLINl9CR4?=
 =?iso-8859-1?Q?8vDEAkqp1iT/LnL+osNJv0+SqPbWX77JXT//WNyU/dWtf+vw1RDOrRiAEl?=
 =?iso-8859-1?Q?Wn4H5jF8K1w7vlwd9YWKbIMTjDJQF3QPIcO404oIloBTpRlhp0jVHcbTnJ?=
 =?iso-8859-1?Q?MFg5zKFfHB0EeYixR49m50W/+ZoD4Cm/a26im9W+p10AM9gdf4WQag4/N4?=
 =?iso-8859-1?Q?i3xvdpOg9xM1RvglmrVk77mVBh6yEvlXEzl1/caHOevLUSM1Qf+LXxA27v?=
 =?iso-8859-1?Q?UpBi/LzDnfmrpSXWHUN9xeJ+3nkWuNcgMsELI+PaJ+4LmRVpXD5EmS2SVK?=
 =?iso-8859-1?Q?EPSODL5mb1+cD8LdLzZAgJJYlBRVmKM6XpTANw=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?iso-8859-1?Q?wGqKj9qbm3Y33w/zdtDdUW8hA8wsCM1WOPmiclCw7tqvAZdwEFNOYGv3CF?=
 =?iso-8859-1?Q?at7V+NXWRJfA0E2hHGpCJ0ZBmTYn1ZksGwe/5XuFYdbYjjTIGSQovTExpU?=
 =?iso-8859-1?Q?DuVPXgxRpYb9qiRMGoMh937E8VnPgdOlp7zQSvovW8TXPZmg732kXlVJyP?=
 =?iso-8859-1?Q?8mOtrlyfNwf1R3AJvZ3ZVa4hekaETHERAkfXGFZL8a0I7KEvZVLPjtPimr?=
 =?iso-8859-1?Q?MkmcE6UlAoqsWMz3NxoWfp0v3KxQ0C5hYqgIWK4O1sLTC1FlFggLii0blW?=
 =?iso-8859-1?Q?HARf82RD7MfGnhmprW6fvywbZfYcWiL0AW87xoKqY9RbnxC7++o4MsOLj2?=
 =?iso-8859-1?Q?YOox45kg3v5+vrBrPi5AGYo8SWLyh887gtMZ7057tnkfB5k6bdOcy/mQQN?=
 =?iso-8859-1?Q?yCootcaK3kCLDQn9WMTEe06zaMvTTsumqw3CDBCNarKxK8105FYs4NOuBr?=
 =?iso-8859-1?Q?Zm21OXF8xzeN3WzZ0O3ky2wRh13SEAMkhwSfHVsTaYTInI5XTT1rq9b/xR?=
 =?iso-8859-1?Q?RD3LgmtHXU0u/pbgss53aBbB/TPoCa/yjiC0tcU7EprREyjM7t6Kwm2/1l?=
 =?iso-8859-1?Q?5l9/256CcVlrm0wU3SK0B35uxBrzej+g0SA/XajNQ5xp9AwUbaWl6/voN9?=
 =?iso-8859-1?Q?Y31hVl47+Oc63BweKywMoyPnV4GDFacSwD7vQgOrgIJUBHbo+R1nzNciIt?=
 =?iso-8859-1?Q?fZBA1Q2CdIISPOozaDwHdkPcUnPCZbUweesxwgYYOKdgBTuOrr+3oRspe1?=
 =?iso-8859-1?Q?svTSeHiL8v+RM46H+zf6JQX5LVUpzGRjfito0apuhtwvQTUFz/ful3RDzB?=
 =?iso-8859-1?Q?VQTycnDxTtHl9whgX8ivjMprRIx0MMvq+Sk9kE+uZWOHlT3vUUiVaAlzGf?=
 =?iso-8859-1?Q?IBGqJbm95DSdIGg6P0nW2ubQ+X7zp2iIe4sJI8YqNoUPewQySKUBaZeSIF?=
 =?iso-8859-1?Q?I2YB4k/QWgV+arRQATsJjdD4mtFqz5bNxCYAuGmyYuEW7CkRw1vfEw4wfi?=
 =?iso-8859-1?Q?1ObyeYRn5rwg5iIg1x8lpXCYFpWA5VbFGwuhLR6I5BrnnAS+lxNOiCF3QO?=
 =?iso-8859-1?Q?4ULRasDeDa7X0AEca/AHtmCqJS+FB1vAnuBOiGyMG0pQC6B7jcMQiQUGK6?=
 =?iso-8859-1?Q?HKl0C7WTr0a+M2ypW+OoCVupMcHdL+zewO8rU84bEqOmu6oyf9mNR0O0wD?=
 =?iso-8859-1?Q?IJE1ErewWKj6Eqv2uyg1jyjSsUX5ZQUZklBgf4XNv64whlHSfiEMrEsw/T?=
 =?iso-8859-1?Q?NtTE1fXc6ACjtqt1dwTP+V9jCOBzPBYWZjyv2WzUhPeQSXYbK+ihghVX9W?=
 =?iso-8859-1?Q?8GL3p0z/lQEjfK8EeE3ybHZA+lxJO8RTDCv3kEJizwTKm6FQP6JEq4B3gT?=
 =?iso-8859-1?Q?G3vSE2FpzTqoSnYe86kdHfuOMNvdCNxPCWjxALNVQulb4OOI6GzDcFGWOE?=
 =?iso-8859-1?Q?xvEcdQp9nEcfyExRTQLDr0bOgLr4qzL2FGQkkXO6TZULW8E0vpX1GKWoJA?=
 =?iso-8859-1?Q?TOjyNOb5SfKwgCUz67rOEO1tahellK53dkgOn/jNZzZFxufjceN8zDHgcb?=
 =?iso-8859-1?Q?Ml/WP7OqCnE3wcU9UxJo8UjK1vHGFqf1CSM5SRr/lgLaQFGiLmH2GDO5KP?=
 =?iso-8859-1?Q?h7r33hnzIzuulhOXootPEA+LW3yVtMF3YN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea1eeae-cac4-43a4-e880-08dcdcb9da28
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 16:56:36.7806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QTZA4A+ZJss2HDy4kn29dy3calYLuqgqE0Lix6c7Qvwmf29rN3k+szh/M2LSm9cbjitGWv8yQjXQicCRzmo9mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8704

On Tue, Sep 24, 2024 at 01:50:21PM -0300, João Paulo Gonçalves wrote:
> Hi Frank,
>
> On Tue, Sep 24, 2024 at 11:09:51AM -0400, Frank Li wrote:
> > On Tue, Sep 24, 2024 at 01:40:53PM +0200, Francesco Dolcini wrote:
> > > From: João Paulo Gonçalves <joao.goncalves@toradex.com>
> > >
> > > Add Toradex Verdin Ivy carrier board support. One notable feature of Ivy
> > > is the analog inputs. These inputs are multiplexed, allowing the same
> > > input to measure either voltage or current. For current measurements,
> > > a GPIO switch enables or disables the shunt resistor. This process is
> > > automatically managed by the Linux kernel using the IIO and MUX
> > > subsystems. Voltage measurement is always enabled, but the voltage
> > > measured by the ADC is scaled by a cascade voltage divider. In the
> > > device tree, the equivalent gain of the voltage divider is used, which
> > > can be calculated as follows:
> > >
> > >                ------------
> > >                +          |
> > >                          .-.
> > >                   R1=30K | |
> > >                          | |
> > >                          '-'
> > >                           |-------------------
> > >     Analog Input (AIN)    |                  |
> > >                          .-.                .-.
> > >                   R2=10K | |         R3=30K | |
> > >                          | |                | |
> > >                          '-'                '-'
> > >                           |                  |
> > >                           |                  |--------
> > >                           |                 .-.      +
> > >                           |          R4=10K | |
> > >                           |                 | |      ADC Input (Channels 0 and 1)
> > >                           |                 '-'
> > >                -          |                  |       -
> > >                -----------|                  |--------
> > >                          ===                ===
> > >                          GND                GND
> > >
> > > Vin  = Analog Input (AIN)
> > > Vout = ADC Input
> > > Rth  = Thevenin Equiv. Resistance
> > > Vth  = Thevenin Equiv. Voltage
> > > RL   = Load Resistor
> > >
> > > R1 = 30K, R2 = 10K, R3 = 30K, R4 = 10K
> > > RL = R4 = 10K
> > >
> > > Rth  = (R1 // R2) + R3 = 37500 Ohms
> > > Vth  = (Vin * R2) / (R1 + R2) = Vin/4;
> > > Vout = (Vth * RL)/ (Rth + RL) = Vth/4.75 = Vin/19
> > > Gain = Vout/Vin = 1/19
> >
> > which properties related these value?
>
> The gain value is used on the "ain1_voltage_unmanaged" node for the full-ohms
> and output-ohms properties.

Okay, why not define a C macros, which calculate value base on input R<n>
's number.

Frank

>
> Best Regards,
> João Paulo Gonçalves

