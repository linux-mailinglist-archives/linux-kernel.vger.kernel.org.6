Return-Path: <linux-kernel+bounces-522526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DADA3CB7D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DD6C3A8913
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30822580DA;
	Wed, 19 Feb 2025 21:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GJoBwlpf"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013031.outbound.protection.outlook.com [52.101.67.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F8D257438;
	Wed, 19 Feb 2025 21:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740000732; cv=fail; b=WRSA+OGXN14tNx/gZ0p1CtaTRoanaXn7vBH6Aine6y3cGyOF4JMtRlSpy9yrswPE0QD9mgSfdG0Fg2ZC7svHhuk759fCwCvC+Z6d0/wuCHEIDTcQP6bVEpzD37Z/LogmZDOMm28SkpDDxTIgfLeblnpzj4/5CxZBMMe/9dIANPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740000732; c=relaxed/simple;
	bh=/RGnQrFMzdTyPhEHnxLqxMoB0bnnZtipKIXG3ygQnro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y6ZMy5LccsHkh4meL76q6HNoZKRi82RzGgBzb9vDQLegVZ+1QMmxP734v4aKFDfak6aeBA+NVnAYr8bONrtkrhVTm1IJPBqam+V2+b40U/Ku6On/PeiVcGNYtBluIXovTWpHdT+06EUoNZ9zzZGz8GUGorlXsU5LGa3uyzcFmYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GJoBwlpf; arc=fail smtp.client-ip=52.101.67.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=McAwegSF+fKftCHMeDMqVKwFh5ZcPHvRQWEw6X2E2viTOgpX8GBRPUwFXKWkAC8HKK+tV8pz7Gp2snkJjHgMCSOYtW+5/Podv30EermdKTVlYplMIXlrkhuid60cSYzYpXvN7u5TAEP2cvz6Mpz2J2T5aHpGJLo76nOJXkNnNMSRe8XyH4q6tNMjf9k+1usRTKp48dn0Y5+ITrpcK+MdJ2po5vtj6znu1BFMYgv31hcTaPiWhLcHf7gGaDA61dC0XbthogZb2/U27DYXOfYfjNhkNPDzeflqCJTWabnMeLyylgnpnlY7Z0rfFMFBCaYKL+oJbWnQe+xGLyMmz0AmIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yhl+sO09GgK7EpwYCMyl2uSe3tEPIGr8CxJyzS1CEQ=;
 b=Cp+g5uX2GRJ1YsOnSY457/Z/7zdW/9K1aVZ41m08NRRHHds4b6GiG8nQ4ZypgVKANstPbkAphuYJ1d8zuueZIrHYkMLrhPPLf2hlnis5qPJjJV3YTqoaCRPFClUHvOwp6GwpLhs10xUjGzggFEw+wbvbYwDFelXPKqTl5+GJOoz56dK1jRJ+NbFgbsDmrERbrezd8+Kd7nR16y62nFWnnzTIC83RUU+6D2HuaYrD1Ap75NsjbznfK5Rso/dSdNo0T55Nm+pI+hzC9sgHVxso26PJBg027T1xYhDA/r2x5gqtRtx2vbTv/1XEj2iVwYsk/Xawck1+vwZvm6dvo/iUsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yhl+sO09GgK7EpwYCMyl2uSe3tEPIGr8CxJyzS1CEQ=;
 b=GJoBwlpfZWCAOtXEpoWQ7sWeYDBIcRncNatG/XAn51VJLccnkbv2aC4WxrWXADQ4Fw/mEE2FgcMiSSsc9tDE7ZxCXGhz819C3ew0JxVsjrSdeHfuxVMaHvkNWkAgDU4bWYLyjuH9PsJ+xQL60+a6skKJv50h+PVv0z2IjDKF7Ko4vJjnCO0usn8EMpymMkBhm9VlOoYdA1c/f/zeB9dk5oqEmvCHLpqzpcZpHS48ZbgXa744FvsGDf30cfswzswjSKn5IBLLZXMiA1z687noI/DLYCVCv5o+qYd4H6qeYfi4qPqtGop2kay+Co+y4kzi/AxQw/+XiHHhm/gYqLupoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS5PR04MB10058.eurprd04.prod.outlook.com (2603:10a6:20b:683::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 21:32:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 21:32:08 +0000
Date: Wed, 19 Feb 2025 16:31:59 -0500
From: Frank Li <Frank.li@nxp.com>
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: p.zabel@pengutronix.de, robh@kernel.org, shawnguo@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	mathieu.poirier@linaro.org, shengjiu.wang@nxp.com, peng.fan@nxp.com,
	laurentiu.mihalcea@nxp.com, iuliana.prodan@nxp.com
Subject: Re: [PATCH v2 7/8] reset: imx8mp-audiomix: Add support for DSP
 run/stall
Message-ID: <Z7ZNz4duF4okP2P2@lizhi-Precision-Tower-5810>
References: <20250219192102.423850-1-daniel.baluta@nxp.com>
 <20250219192102.423850-8-daniel.baluta@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219192102.423850-8-daniel.baluta@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0049.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS5PR04MB10058:EE_
X-MS-Office365-Filtering-Correlation-Id: 14c3380d-2bc9-4446-caeb-08dd512cdcf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tm+Vwjqx8kaspTLz3eYd/4aRgt4spd5DEgj4v3bnPF5wxoez9SrFY6kWQW7H?=
 =?us-ascii?Q?3K8ggs92JZdf3iSKKw+LEezDRVXFYFDelcxigm5XV30bw4mmbhyKMYjwkKV8?=
 =?us-ascii?Q?2Nxa1lvd6E7EK7xCMwVkvp2Vf7ikhTpQ6xrbnDgKSeUAnVi9vkv/keMGxedb?=
 =?us-ascii?Q?EO8dHkGtRWaiNXh2jWLeoQBlgHiyTQ4Axz44RvOePFXDpxjTfSKMM2pX2Hww?=
 =?us-ascii?Q?Va5RErh3hRlivQBWRDi6LbL/W7ieUOBZ0/xCYOfji4nbHVC0qUUCgQ2o09am?=
 =?us-ascii?Q?DSwjgTs1+MNfQcTJXB6eTB2qKw2mQS+/16/cAtInZJ1gwV+G9dApyKYp57Sc?=
 =?us-ascii?Q?VQOBjVXH9QcebqmxvSvJjQoE3g2pZJwTayj69+zYEUDC0Mrjb8o+vY6MfFC1?=
 =?us-ascii?Q?8f2VDXHhbRFDVDKIqgB0urIqv2FeFpTB7DnntphWf0JnFPo+6TeuplynVLMh?=
 =?us-ascii?Q?VDMKv6EYNpKK1YdLDgseWv4OEpjhnz7hfCJJaD8wv/lZUOB5fRY/9Bs+EiyT?=
 =?us-ascii?Q?sWzG1BwMNPwuDgXjRj4xmklaRz4CxH3MLwbhNVeJ8ciU+489xRdToTxKw9Et?=
 =?us-ascii?Q?fSXlMkwDb+HlQ6mesLKWu/mgCFoughSNi07rMiUSjUfzt5RQw9YgRX0excjm?=
 =?us-ascii?Q?6YC5Lgvfvbufhd2D3635QPViOPxnYinzU4oSt+nQBWkzIZR5o42VkZM0fHfW?=
 =?us-ascii?Q?k+wOXOGYG5UGKQlKwT62JJhFtwjSLwcSfQAe4w/3fk0qu61TVJOkqwlvWsjL?=
 =?us-ascii?Q?tOdoW4SsdJ5jTWzQzuPdcmN8zQQzeIlKZI9lMwOHVQ4OtA6uMuycevFdu44D?=
 =?us-ascii?Q?JQndYh5hWhdtxmm0JaFPekDMw952RhgyyhFjONA8DWN2oQqAt/GNyEAigOU5?=
 =?us-ascii?Q?ykrWdW63ejehNcnNvY+AliD/8hng1NWe+Oy2BdCDwtaycTRO9AXc03mjDo2I?=
 =?us-ascii?Q?OWh5DM98yCo6l0Oe7wniWrriVw+JrvlVM/4LyPhQgsml1UNEST4CFN8uK9zB?=
 =?us-ascii?Q?2ejZ57I3Bh9QwLXVNqVvVgR/uV/ZY2LIWOk3KUk1DbNz6nw/rNr+6AcxGaDk?=
 =?us-ascii?Q?q3Y81KBkhHiWEU7OsCRJDfvg0L3D2zoheQBPhF26S4k//4FjL9+gqrF/y0XJ?=
 =?us-ascii?Q?mVeilp52lhnsFTUAsbiIObsuymNzbgZix/ZeQTs+n4ow8tKltJIhKCK4iQXA?=
 =?us-ascii?Q?XZ797sLoQHikDLxvmKDrRLdAMpWj6KRPdjgatYW1p9FZ5kgUqV/ZkQO+kUjD?=
 =?us-ascii?Q?BtLLeBNXnJHDFnGth25Vlv3qzUQX/YjPMoTWg2+x2J92b7gr6Ba8y47A1npf?=
 =?us-ascii?Q?wSZnf6/IlKAMz43dp1xAJnA9m8wv9Fwt1odn4pQpHzAsmvfP1KS4Xfu2Zcqi?=
 =?us-ascii?Q?QnaK4Jbo1aPYK0gocNlP3dFMiSBTJkf3m8VR7BZvt2O3vi+aP4vRFWT0gqoT?=
 =?us-ascii?Q?O+B8LsWsSz7Vd+YrfQrGm/XfL7tB8ACG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rDMYk9Zf6SFKHXQFcIVyoukhNmZkw83BPznCLICy3UCjZSsuk2B7i4RSu6hn?=
 =?us-ascii?Q?LfdkADVDLIrXMG5ls3aVRvIshPQsiX0fFWzwZKt1L/ThJSkVEsof7Vad6Fu2?=
 =?us-ascii?Q?ZvUqW5cKoUHQT01IEyCMtBIZaOrFDJ2ai7RYJ0NjutjLlBSDl7BNu8RMS+ce?=
 =?us-ascii?Q?rT+8SDjtB/PoK3Qz077kqspKkytoUPqatjy8gFRg2cUWhN4jCjdOzrWC1q0u?=
 =?us-ascii?Q?4Ch5M1JtiCr8H2FPe16ReF5OI9SRCiPrI++1d/JcUFXUS6D/lhUGSSIEEtM/?=
 =?us-ascii?Q?XkpjvJfyW4PZDJP62VJNpaMfjpR0VR9xdtL8pU7vp+BYRYM8IQ4vvHRwrrcb?=
 =?us-ascii?Q?FZGgf/b49AwpO2iBSK+nPcf/RJvxI9tQ0sHEoZsbzkSuiskS52FnDAQZkhj5?=
 =?us-ascii?Q?5B211Ujew64VZRkfS/c0v8zg1PhNUDzGLS6c2Z3A2xfU737u9Lq+BrD71cxM?=
 =?us-ascii?Q?H+e52/YWh6jdMxn+W+83QN/cqoJAxJfzfOQGe/+aSGGF8X/w+i+04/c+eMNd?=
 =?us-ascii?Q?jFugj0XjsHTS12iYueOLmuZqvhazC4Op+qZoKfdJXvKsS7rOfhIYiDcpKx5D?=
 =?us-ascii?Q?qF9acu1Df6CVjbS13PWo1AaubQGi71LiN69ml0KYz3aKwadN0M8rU8iDDxyt?=
 =?us-ascii?Q?gRXeObqlfInjpwB6WIWOtTzuSPdsM/UrjIibbFi0YLFOa01zJpNxRLk1qdW4?=
 =?us-ascii?Q?jghaBgv6KpT31sLusx01dtGo+aPuVl16OOl6/hNIh9Rpi8m4Z9cUho6j60Iy?=
 =?us-ascii?Q?m9O69UI/xzZrdN3BelUk6/rBUUsDCYHZm3+0RG67IUZlGrXJKf8fZAENVx7V?=
 =?us-ascii?Q?GBYOHlHjgwOoRsX35K8EzUqIhCccwJLGLDvUUV55/p5Mb9cki3DVl69pUy9I?=
 =?us-ascii?Q?3EKBUmv0/n5XdyJZiOvv0XpRjOpnoHzQKpuxZHDfknlbWPUCqkoysvUhJoGF?=
 =?us-ascii?Q?ZB6OhtYfwlOAI+WSwxK31LF8/NdrvJvhF8MOR22NnFMp5MOw7HMrMCGQlT81?=
 =?us-ascii?Q?E0/uKpZQQUAOZAgkyB6YX2UNi4iH8y6fZLBE1HKDp5KFvAGpspdFSljtPLO0?=
 =?us-ascii?Q?THPD+B4Dhv6S1oy/bTLC1ZgACPQVWVgircW+/YoGINyh2GmqN5WOz11yutRS?=
 =?us-ascii?Q?NPRbBy6Ll5Kp4qe6CYyVGszxZe4mk0TAXwyooBJsQtBfQzGDdElL+FCHnkC4?=
 =?us-ascii?Q?Ze3vYCmUIQqgpJ4UhPlUKKfvznVHkHu146f2lpn1uwWGLlRTQchGsRqQCQ9w?=
 =?us-ascii?Q?GnX13oSEPiPpPgCkH352Yj+OBPGyog+55aQ2dtcPTh9b93eIeSM85SrZJNi2?=
 =?us-ascii?Q?eyLtWs+qXK7rOwoE7o+hTfu99uD50U2oNxtTUtKtwbt3MfeUvndwMb1yzJv/?=
 =?us-ascii?Q?r4w6BNjNVeUC/m8EuAuepEuSPavdmMZGNv0Cp+KCxx+R7Ek2UFpdLaLNR5eI?=
 =?us-ascii?Q?gxDsQeDjd6nqP/rsGRUV4usrr/JWa2LpgmGTwYOJyOZGiJadUz8wuN19pjaZ?=
 =?us-ascii?Q?z92bg8z3x/2sFH+0K2v6ar5dCxzslyRIFF74Z2XUtEhcY2Sj8km/0b+tLImy?=
 =?us-ascii?Q?mMjsvkdw5ikdyRzuuOw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c3380d-2bc9-4446-caeb-08dd512cdcf6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 21:32:08.5274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nbFu1T+EY4PjUjvXKf/HX7/uaQ14vc/XvmdjEwpI+NWx6cLswyTF5Pk2GMZzlsomO6k+tWbX6fDNqdiZkj/Tkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10058

On Wed, Feb 19, 2025 at 09:21:01PM +0200, Daniel Baluta wrote:
> We can Run/Stall the DSP via audio block control bits found in audiomix.
> Implement this functionality using the reset controller and use assert
> for Stall and deassert for Run.
>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/reset/reset-imx8mp-audiomix.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-imx8mp-audiomix.c
> index 42539cafbccc..4a713b772429 100644
> --- a/drivers/reset/reset-imx8mp-audiomix.c
> +++ b/drivers/reset/reset-imx8mp-audiomix.c
> @@ -16,6 +16,9 @@
>  #define IMX8MP_AUDIOMIX_EARC_RESET_MASK		BIT(1)
>  #define IMX8MP_AUDIOMIX_EARC_PHY_RESET_MASK	BIT(2)
>
> +#define IMX8MP_AUDIOMIX_DSP_OFFSET		0x108
> +#define IMX8MP_AUDIOMIX_DSP_RUNSTALL_MASK	BIT(5)
> +
>  struct imx8mp_reset_map {
>  	unsigned int offset;
>  	unsigned int mask;
> @@ -33,6 +36,11 @@ static const struct imx8mp_reset_map reset_map[] = {
>  		.mask	= IMX8MP_AUDIOMIX_EARC_PHY_RESET_MASK,
>  		.active_low = true,
>  	},
> +	[IMX8MP_AUDIOMIX_DSP] = {
> +		.offset	= IMX8MP_AUDIOMIX_DSP_OFFSET,
> +		.mask	= IMX8MP_AUDIOMIX_DSP_RUNSTALL_MASK,
> +		.active_low = false,
> +	},
>  };
>
>  struct imx8mp_audiomix_reset {
> --
> 2.25.1
>

