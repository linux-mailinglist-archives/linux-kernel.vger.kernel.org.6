Return-Path: <linux-kernel+bounces-549568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41429A553F7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 693DC7A4263
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112A0270048;
	Thu,  6 Mar 2025 18:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kMq8zx2V"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2069.outbound.protection.outlook.com [40.107.21.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD49926E17F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 18:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741284063; cv=fail; b=tP6yMZP59VaMP3xBXOhVGRIm95Vdk0HIyCYau3fWseGNTGIC1kOISDdC+c8yH5FpFWiunv9OEHOwfvOs05bjylu0AbDwnGyVQ5X1DUS8JjXxCxKT7lOnHp8tGxDfyWkiAmP48aFVKlc11M+GmKG1WV4gKEWEw7UEBH/U9/CMy0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741284063; c=relaxed/simple;
	bh=oybcDmm4oC5qEKoDTmm94DFCPOexgDf6rHUS53DRuCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n2pWX35BseLYDrQZRaK2WPQ66LNnYMpZbNGw7hEPXhxEa17qPHiZWiGVrJlm1GIU/YTlqYl6SY8UqKHVMMOJL3T0Yalc00230ZFA76/dQELhpwVoTd5PvzW7qQuRJCrleq8OC6F5rEwY6MrJ5b/ZTPsRHBcQA+DJ6zN/jzemW9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kMq8zx2V; arc=fail smtp.client-ip=40.107.21.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWF3A0k1Kzp9zeq/kFJ/2ipSVxMI14YHkteaPLbVUaTmWkKuSkBxDTD/VrAqlYvkKlS35gPSX0Nc50ow9ZvoVdfYBlnSiS/2Vu0cIrNtAAtT9lMJ8DqcddgPxuOe+OlnmDixEa/wj5mA199loyB6CSYYzYUlSSaEx5f4maFiDz054S1aYYKkj94lSYVCoU2qh+2oaNN0PnpeOodY/LAixBXSJHNi3d4nmwhZvG0f1XHPSXQHXYsv1bUUBi1h6F/zxCaIAm4LdPJIroRsUtOPgFBkfcUJLQkSj0+YSuy0uLHp/f5uio7qmpGbri2s0yJ4KV1NMLG4riKJB9b4TO0A7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJJXpttBSmz8sla8/4n2nNCaQ/ZLlwIn0fmDtCZNOD8=;
 b=YGWHrVmOaRfaeOQ569DBxmQHLxznE0YXdDuq4Zc2eAjzbsJRM4umGpT08p1Mb+CBxnb0kcEnHElLbzgbgXJLkFBdLoBPhWcMv/PIUdlbYlLH/rnHrG7Kc06rM7vgxEtkhpahppKCLkZVZOmYoJm68vbuGEUlCakmoQUh489LHHFVv8qmHS7JZIgFgdbLMYpNHS1PjWuscF/I6/GIK54iFA9k4fMHbSXmv8HA3iqLR9HeCsVVQbDtaWeaN3Zl9e4hETKizdSh+H3LP3YWNYPhQE6cDV0pZvmTClx7ssdy1EuJY3I1jP0yx7uxdM/kP7bAvg8lvH2EvE7jxdLuhlDP9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJJXpttBSmz8sla8/4n2nNCaQ/ZLlwIn0fmDtCZNOD8=;
 b=kMq8zx2VyeVKtwgnML9+jGQaN5BJjAe/zzGafdbU+0IWhtWWna+IauaLpbzkSpw72SQ5D5qY9qpmJ2LXwAtOZEO/YWmuTy+KbPPPGteEj4sxoHlCkAi0FqK2JLQHJMHraa275CXjmkclNu4D8c946Cm7ODwFmTFw23bXTnSkqlcazid2BHgqzP0i7DbDSWvcVzprE06x12x1FNgMyKTxWtSeAyDcPRFenDWX+CZv4EpUGfeXl9EX/dhPE1GWed7KUchmNna8oliIHE02lfJ+sgaF65EtonB86A4iYdXJ6KeikuGte18TH2P23eXoWt0A+YjeyFv/sOVOObW8wl1YLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10550.eurprd04.prod.outlook.com (2603:10a6:10:586::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Thu, 6 Mar
 2025 18:00:56 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 18:00:56 +0000
Date: Thu, 6 Mar 2025 13:00:44 -0500
From: Frank Li <Frank.li@nxp.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Liu Ying <victor.liu@nxp.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/bridge: fsl-ldb: make warning message more
 informative
Message-ID: <Z8nizEsd0QbYgsI/@lizhi-Precision-Tower-5810>
References: <20250306-drm-two-ldb-improvements-v1-0-f139d768b92c@bootlin.com>
 <20250306-drm-two-ldb-improvements-v1-2-f139d768b92c@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306-drm-two-ldb-improvements-v1-2-f139d768b92c@bootlin.com>
X-ClientProxiedBy: BYAPR05CA0107.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::48) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10550:EE_
X-MS-Office365-Filtering-Correlation-Id: 57185105-6d55-42bc-c9a7-08dd5cd8d7ca
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?+gvsKp0RcoQAD2mxU8+DcKpruw7P1H8ANzsHMZwt5h3Wsys/5ofywwM1Q548?=
 =?us-ascii?Q?beAZNf2Nmzl4Br+CLSXzf07aIJQUCTdBH4/p36I4axrvr3rHgECIl3Txk+SU?=
 =?us-ascii?Q?Jqud8xWiL5zSa9CQdNoIimOVIS3/TtKj77xuTjenFFBaKfG1Mh/5xF8NocAi?=
 =?us-ascii?Q?WO+wlETMXL9jx4S1J6Q4XLKuiDg4OA4159M4Mqgf4VfFwMxir99spGmIFBXm?=
 =?us-ascii?Q?ps+NbInbefJZm7HJ6le6KU7Hqx3HuzRguSk8jJZTlFf368nLEJlMIepiygJc?=
 =?us-ascii?Q?YP2eksSYWUuG8lkzqVrQ1z8diUEsL0sVS0sJbKcJDxAvRgUkvnvdurLrT9h6?=
 =?us-ascii?Q?hLeb36uiX0x2GQi4z9y9GSpGIDbvi18/US6jYHEdbXnRMM2Fva5LGCG13Rno?=
 =?us-ascii?Q?aJ/zA//GXlSB+ebMhh+OcV6w4omGvqG16yLoA5VTBJ4qSXyH4QJACpEnWH7i?=
 =?us-ascii?Q?4+tfz8QHmlNBdB66fNcJ92TpAdH6+c2S/wV/FDhLBykxutkpEePlYSyNXmOc?=
 =?us-ascii?Q?V6Env+KTqnwapiGxFHlNnw/vozmVUE+8DeoyfMPyqOLwmF7spK5J3RmuzKPv?=
 =?us-ascii?Q?o0bXA4c7mPhuEpemkCQ2qYMd9yC5xNriYxDPQ6VU5HRNb0Rb8anEc9nGnLmQ?=
 =?us-ascii?Q?EbHaDf/92iS91JsfeTHC4GOSECFv9uE0Tl7WVgPo+sQ+UmkGa6RpcZrjrhQr?=
 =?us-ascii?Q?Eu+tuqpbpLAUY9sulTN4hgmW3PaO79z8QeG7MXiQ5qmjP0m0Tn6W+yIvZxkr?=
 =?us-ascii?Q?KFODRU/8mGpmMvGGQThrJTYBoGp8uPm26XtQ0bp3MdMDxHvgyaV4SiOuHYNV?=
 =?us-ascii?Q?PRtjmeZ5Vccs5K+383FaV+CgMbdsNFhSTxEq+pZ85vtTg/tnkBUPKDTXQqPp?=
 =?us-ascii?Q?Kt7skLFX7D0wPngSI9TYsDCMbblb2abAZPrXDnHX/9kE3wF+FgaL4gneu/ER?=
 =?us-ascii?Q?Jo3sHPzAQ4mR5mLrkgNlOUr4/72Gt78Rhsx+D9hAf4BHSzmcxhsz5fmMFQGP?=
 =?us-ascii?Q?KIdvGo7b86iHhdhS5nPPSsp15mRBfXheuMsbbz000HdDOpxSj+io1JfVn8jM?=
 =?us-ascii?Q?9b/ZTkP4T9bIRt7o+x3qua/XNJajUeQKXLh6nyNSbcyDEV586sWfhnSFheoq?=
 =?us-ascii?Q?IpShCBAz7H/e5j+Or0B/sBDZDFMxz4DdjqQqNA0W23sOKlx97oZi7QSynwhv?=
 =?us-ascii?Q?3wKVkNPUq57qk8UhCfvnqBBXYsjrFBZGOhb0RzOPUO9AD3uad56ivh27+yvk?=
 =?us-ascii?Q?JqnOmQeUPZNIk+ez+obYCaRUAUki16jv8lUKdGaY75iOTDU3whmE1m4Az9bT?=
 =?us-ascii?Q?eGmfxQdrLo0Rg8O3rd6RZs1HhhBKala43m7ZcWnlnrmWPn8DHtM5XdsQsATh?=
 =?us-ascii?Q?uIKE566NGG8BRoCzc2b+Ztm/kBFAWADoOsB/7NkZPZPPNwi70loN2QviOaLK?=
 =?us-ascii?Q?mVNpzpS9TTA=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?LarVKNuMMGkpSdBDStxxnp4m1O1LUYCeM1QF2WXNU/SNph5q8sdtVCw809wf?=
 =?us-ascii?Q?AbNktUSpY4q1G7q3Br+BuubgHrUT+PdBBfbY/giNiUZSHSDQDc+YDrqa8EqE?=
 =?us-ascii?Q?MhFtQI6mfMqRfMvUp8tkZrNfB/oJuBZDs9G6L3yRxcaktIgnVFcGQ+WBSwG7?=
 =?us-ascii?Q?0QiatkMaIky2dHkstHvrmS3c/ibpEXxVJ+UjHmviUJM4xLWsrTv1GuKX6kFO?=
 =?us-ascii?Q?zKxv1w7FG3krUQSjooWsD/7XCxmq07oBD5lZ487tbI6jYYmdtppAl4LpTIQQ?=
 =?us-ascii?Q?svPnfybe4MmxXk8KzakrjSBbNqw7j9NaygpLDpue+rCWzz5+1sxBiyR9kaNc?=
 =?us-ascii?Q?kgyEXMRiJVvmEnZ0qjfIWKn7CctyqCx1kK/GXyIdGH7+Za27sJU25wAYgzV3?=
 =?us-ascii?Q?QY9DLPdeTZuiD3zAqOf48dHOgbGiTnp1Vla9vEU2gDiJL2fdFasyOIK7Ic1x?=
 =?us-ascii?Q?ZG3yo8I0r7MbO6A3lHHbnDgAUU03bgwehx8+J43qjneSLcWxNKPAw+2zcsHf?=
 =?us-ascii?Q?23jaEG1ot0scmh2Seqiv+XImovEGAMA/wAdb+JvsvYz3oG5DD/0z3J9GQqaz?=
 =?us-ascii?Q?Qk4NDoUq7znpt/ajeNmmndfRuKtbIyoMldJIv5vX9TgFfuGiuDXE23OhNqGz?=
 =?us-ascii?Q?DmXVg5an4fc6eY4+xeJitgh0GZsXRCCaBVyvYIyFrsakg0Yc0oTmywUqq7bq?=
 =?us-ascii?Q?PWjNSIze+Go1X2BRR0Uz7wCXslSvzvgyaigmUTGDKzZXBVAgNZYFDJGWhDUR?=
 =?us-ascii?Q?MPwtKvVWXdPUbWNIJS5OrK6wMpF4gtLXLgMQNce4Qr3u5qT75i/myGd7reM4?=
 =?us-ascii?Q?dK71MFZcvjZMhEZxELAOxeC4o2xelDiGph7VzROL9En/O0azn3cDOq2k/vK9?=
 =?us-ascii?Q?6MKzYer0SA68id4zbxTif9QgocFNkU5EygRQFlslnHsV21+2mBSBb8SVysYC?=
 =?us-ascii?Q?JGMY06MI6H26w0/49AFhpxzomf+S8F64uFn3aW/eqWVOrp1WDnKiqgMMg6X3?=
 =?us-ascii?Q?MWRQ7kJkmegk8MPL12USjmBcTZKFEC4GQrEJix8tP7GOSbFXjkZS3ylZud6h?=
 =?us-ascii?Q?xuwJuNvxrb5V939jF/ggKsThP7GjGsVKwtVjRBJX4s26/xU7Zr9KXFBx+6CZ?=
 =?us-ascii?Q?UIjn97Y8tUgJ+3BDwtHRiiehxxOoxGeip6RQBPi457nDUSijT5M6r9gAWj/G?=
 =?us-ascii?Q?FsDqLaoJ3tQeHYVGKYYkmSq2gDffJYrBpx+lmp4jDXpRvk/72bvOq2sISvwQ?=
 =?us-ascii?Q?jKq3flmZrjBf1RVjbIDzFRg61Tn+Y00/aLKKmI4GN4ghGgKCExp1BdjyqGEq?=
 =?us-ascii?Q?W8UcVn/e4dcfa37tvYr88GAtu0E8xELZvrXHlqTh4PK31L4ZjA6HwyH68Jrk?=
 =?us-ascii?Q?O+bWQTDSm095GBcIjmPY7QOEqFnrAFNd8/FBQwGk3823ZAPGU7KiUBdZtryp?=
 =?us-ascii?Q?ELPnrq5Z4dc0WjY39zCAOFG2B3Se3GE2zEXh+UwzFwEhTYyAaDbEXucVlYSN?=
 =?us-ascii?Q?7DGfYN3we/ia3iRYEVeb8RnupXFiE+ZVmMIbEP5juIEzLrf+BeNR4yGqKfzK?=
 =?us-ascii?Q?TBZw6FbTwZeXCneFUJI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57185105-6d55-42bc-c9a7-08dd5cd8d7ca
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 18:00:56.1584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fFwX8jDJ0Sfxf9DdnIqHLKfQsYGW/OSpcrtWkYxlqb0mmnuLAxBM7dHyWaaSro0ioQtrzGUjLAIX8soJD15UzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10550

On Thu, Mar 06, 2025 at 06:28:41PM +0100, Luca Ceresoli wrote:
> This warning notifies a clock was set to an inaccurate value. Modify the
> string to also show the clock name.
>
> While doing that also rewrap the entire function call.
>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/gpu/drm/bridge/fsl-ldb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/fsl-ldb.c b/drivers/gpu/drm/bridge/fsl-ldb.c
> index 0fc8a14fd80062248a43b8b93272101a7ca6158a..c7c899a9644bb827845fb3fe96a9695d79a91474 100644
> --- a/drivers/gpu/drm/bridge/fsl-ldb.c
> +++ b/drivers/gpu/drm/bridge/fsl-ldb.c
> @@ -181,9 +181,9 @@ static void fsl_ldb_atomic_enable(struct drm_bridge *bridge,
>
>  	configured_link_freq = clk_get_rate(fsl_ldb->clk);
>  	if (configured_link_freq != requested_link_freq)
> -		dev_warn(fsl_ldb->dev, "Configured LDB clock (%lu Hz) does not match requested LVDS clock: %lu Hz\n",
> -			 configured_link_freq,
> -			 requested_link_freq);
> +		dev_warn(fsl_ldb->dev,
> +			 "Configured %pC clock (%lu Hz) does not match requested LVDS clock: %lu Hz\n",
> +			 fsl_ldb->clk, configured_link_freq, requested_link_freq);

commit message said show clock name, but %p is for pointer value. Are sure
it show clock name?

Frank

>
>  	clk_prepare_enable(fsl_ldb->clk);
>
>
> --
> 2.48.1
>

