Return-Path: <linux-kernel+bounces-547160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDEEA50395
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AA11188D743
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2103224EF93;
	Wed,  5 Mar 2025 15:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EwDZAsr+"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013023.outbound.protection.outlook.com [52.101.67.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BF8230BC6
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 15:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741189254; cv=fail; b=sc+iQd0OaLI4niDKxuIZo8SLRkCVvlKJUoalFoHjSzvzLPIStF4plTprsIIX0R29USb3fd/pylEKGSxVnZdXxZ6vunFleoLTZ5CrltSlJL+Vc399BENWWJmONNEHiz/K9uje8d5juiAc/jkSqQwn1QlQPwzOPuyLWgQQgRfE+rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741189254; c=relaxed/simple;
	bh=ikFrHG1kf0/MgTgyNMxc2ROZl5EnSSUMz6LjI4B2e0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q8KhTV5Vt84mCu1xqfYaGNW+V8HSKw4VbEoieu9T6XiNNa5Q2XQhvHU1uokhbCKHTUsbIpVMEiv5JUz3lhUR9YidkNC2SOhvfZ4GfhGnDlKg9M8NK4POkDAeD1Br0IWd8sB4BfH6O7w27bW5IV1ffP56QkhEBsQELmpMcUzfQXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EwDZAsr+; arc=fail smtp.client-ip=52.101.67.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRAifUkzmuM3Xs7xpsCKgAcyPpb8iljOxaO2RuxHBWtRowFsrbYW4iGZztuMv9ioeYmbc5XiWqJ/rKarOztM5h9g+kh2nYGLVYJM9ZbnDmkz7L9dUARg5YVo4NUTQ5HiC5fQdf7gN0Q2m0RxQ2SirrK8Fcr9yPOx8T7XiGsS2Xgvy6FBMy6xF1GiWlNQMpmyz/J25O1+x1CYS+l69Mr8DjExr6uFMfYfz84aDLOMh8IfWuTJZTDhxZYwEi9xFzxy9NKZ9nOpaJBdlpFd/TvvAqEkdrdOG+VQxgmG9AcNzz0kchi3VfeuzJ4kcoJqB/juGbHBW8jHRY0lyI7GLOSAMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9atSSRmENsknLKlNDsBOc2L2Bg1hnrtuYMZiaOGff4o=;
 b=l5yWvSUyD+f61lc8VdSfIl8wHODPjD6LR1Gy6dwJMMUDUHiNtW9H7/9MqrSCwAxf+kApmUE4tGvZl/FU3TcTkzekektIurjnSDGruiIo4LkffYJbEof+kW+HLwgl712B64tvDCXyh8fnN/ONzChRoK1LU7VLYtu37fctF/um24Z9iP4Il6jqDwSrUMym5Xt2Db/QIJLjmgh7WD7goohV8U26h5S+l2emPOxPaMn2O3GZwbBby9jjA9jka9bG8CN6OlIy0Cnxc7F3sf7q4EyRJoO+LWmOFtY+LawRKAUZ465VYfBWe+1qW0ltRLmz4TYF1UFg1PEl3Kl4e9mFGuofLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9atSSRmENsknLKlNDsBOc2L2Bg1hnrtuYMZiaOGff4o=;
 b=EwDZAsr+DRTztcQU2yR40RpReRStIiZKKB6dQDIS7eGCpQOIjcrLlg/WVruvGDGhqCydlcJvm038gAGTtyUpiNXAV6sPcAOjCnjHHQwLA1Kf/9T7KXj8pT8oNXz2GSLm+CYTVYly7M/xINgaZC8tlHKWAnkF2+cH+y7q7iO6QxZtUkXgY+EPrQbn5Xu4ZYYH9I6s5SINM+PDYBcsDDsdlHKs8iYDVTBoKZaXLWu092YdH7RMDQnXWovelbY7G1h1SNm0ZfGW54boYcSOEbkvmpL8T5Nai2yWPmrFmvLDiBumtb4tGWPaYHAzzM0shzo76fO/YT3FIHMVoYZ/McSwLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AM9PR04MB8162.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 15:40:49 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%4]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 15:40:49 +0000
Date: Wed, 5 Mar 2025 10:40:40 -0500
From: Frank Li <Frank.li@nxp.com>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: vkoul@kernel.org, kishon@kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	p.zabel@pengutronix.de, tharvey@gateworks.com, hongxing.zhu@nxp.com,
	francesco.dolcini@toradex.com, linux-phy@lists.infradead.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v2 1/2] phy: freescale: imx8m-pcie: cleanup reset logic
Message-ID: <Z8hweDIy0AuxzBRR@lizhi-Precision-Tower-5810>
References: <20250305144355.20364-1-eichest@gmail.com>
 <20250305144355.20364-2-eichest@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305144355.20364-2-eichest@gmail.com>
X-ClientProxiedBy: SJ0PR05CA0137.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::22) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AM9PR04MB8162:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c858de7-3496-4ee9-02eb-08dd5bfc1a70
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?1Z9hkwQBfYbZ35SKjhdOsgX5OvnOnafFVIh4I3H2FkhpCm14SWl3PXmj/5UH?=
 =?us-ascii?Q?UEgUUfu745T9CEp2eLFMzkHZON6HesOXNcx5WbxFrsMvlsWyGp2xVuvdI6DM?=
 =?us-ascii?Q?w6GFV++YvexaX+/fA/PktXn/jEQjKIYihaYiCATQodBl5r/9ygxhX5cblkZu?=
 =?us-ascii?Q?AfYKj5mYwFv693cAQiPhVtBmUJntyht/BMmRAtsZhTqh6MahQLUOlCLS0H3M?=
 =?us-ascii?Q?TdSKQO8vnoK3Voh6eEYWZKbLGqXk2MVmDjuEWFJ80jT6VXv6nF/lWJSjA56E?=
 =?us-ascii?Q?z+GYDwhVTU7Dqh/oGb+7oXMHawhzM+0r6QcqJ4ajEE+0oS3dc7dhZJU9yrL0?=
 =?us-ascii?Q?o14oYYdmtJQKik+mk0dieyUCJJQiiX8/aKrDDyQS8dm0P6Ow8X7SEzJzjklq?=
 =?us-ascii?Q?qvZ46uwVp8kTbG46PsdSkohCmobE/y5SeacSz9vKFJI4RkAc/C6K35+2jSXf?=
 =?us-ascii?Q?lWJlbAiQzzecyql+4K4bCXZTHyViM1+OaMYTDwGuQyQHN9Z2Q1tBsHmu3omq?=
 =?us-ascii?Q?mzO58QtZDHRIzVSSSUxR/pEMXEh1GX8SXO6GS2W7Fl+olA6/fpUwI4rzsjjf?=
 =?us-ascii?Q?wIrKSSVQ6OgmP59SpQggSl8Cp+0ATYVUe2H5QG/bLHBMcoCK0AWkOoU5GIxD?=
 =?us-ascii?Q?eALZ7lHaSH97jYSHe1gLcqDkxj5Ts7bpgIymSJl0UGyyTnjWEDS8mJMnT4qY?=
 =?us-ascii?Q?3OUYMt0r9DbjbsfonQKVFUx7N4GY7YemAlEE711uHngvLXly5VbJsUWKZU1H?=
 =?us-ascii?Q?mbs1Tl5Jwwf2M0xh9O5JHZDPuGe8NmmFi/fIY1wjJ/t9Oh9N9zmDmsgiazSC?=
 =?us-ascii?Q?hCUmrbNgqafOgFyGjS8DF7iByEZK91oH7jTlO0XRLC5dwrlzQTwjG1pAO++U?=
 =?us-ascii?Q?PFdVd6/9vtJraf6VczGhnzF/kTz9ha16MsydMpXNP8PRwOlBBuz0pV/l3orR?=
 =?us-ascii?Q?OOERHLZ6PpAG1rXQLv3BrTlfWA3sjmxzj1ZFHo3zsFDUyrCCS5SrhdjfONCs?=
 =?us-ascii?Q?P7yGhZKTBg5nlFBsJuxeapyp0rcI2dc8JR3d1SPobCZq0RJtrpWtXhKY2O0z?=
 =?us-ascii?Q?ikCRPk1w81shd1fsUIlEppdL8cGVJIzbWSQV7eoWM6dD/S9E5uf1rtJMBe6z?=
 =?us-ascii?Q?WW4+0v+9b2sEGWPkLLiALqcu9nvPeYKBTelZaSPIfQIONk0U+zKmPly1cuZr?=
 =?us-ascii?Q?okY2rxrjJHpSjaHfrNqWgIsqYDp654l2IFgctbBPjeSLgxlV4LOtDbCJAnu9?=
 =?us-ascii?Q?CA9D3uiiNtiK8V4JYzoOH6VQA4Yaldqm6H4zjNvDCvaRuSvCXKFlbElkj8qO?=
 =?us-ascii?Q?+7MLyKyYJZ81TMHs5WoxxshSEe58cQQpTc4w/aRPH13DqzJwbf31JpwnJXE/?=
 =?us-ascii?Q?udCnhZZykLLLuX58TS2+2JY3z81agSQdZ2EXLO1bzz46S/n2A0/QLP+yw6zT?=
 =?us-ascii?Q?JS3XwwkwD9S5P/ex4QY6/ayRBi4W5vgQ?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?H6D+xPdSmV/w/J/Cp1+iA59g+q3OhXU5Pc8kdxT8CFE1fYEgAwwh6oVHsn9g?=
 =?us-ascii?Q?u4jK7Bz9KqjlAY6/xJm/zYK144k2WeAqPp2iDeTd757iC4azF4y2b+oRkwp7?=
 =?us-ascii?Q?fqAGqyEo8XsIqma5ROv59QXQxNoKAT0UUYIBk6D/pyggtDz3/DON8YiGeR+S?=
 =?us-ascii?Q?e2zSDnWSY26vNTA6v5dwDZnbtRsJtsdYfdx6vrZUQ56fB3UH9u7G414jZnX5?=
 =?us-ascii?Q?PqdexAiyzl0PXN3T8pVLX+VBRzKwGQzkV076y+d8x7cGkudFeXRhMRBkrc2/?=
 =?us-ascii?Q?vLs+QTFDPk0m2iwFoYuZFkOASPERUkxA2f23p0zUEoadZ0CxWv0FI+yvOVBb?=
 =?us-ascii?Q?cVADGkQw01ao+aPd/QTgHVwsTYxBV7ut/H4ZJdgqtyMbVps7MFzD1C5nOn7P?=
 =?us-ascii?Q?EL9Ep2Zt1MEzKv06ysaJQ3VCIIhe3MXCpDyZw4EcItg2J3kYMlMzZwL7Lbxj?=
 =?us-ascii?Q?YFw8KILqtcG6Hp7s0wKFlwnuhk2nYlTzu5VUeGmJcraD2+RhaKp8mCV3dC78?=
 =?us-ascii?Q?HbBEvn7D0ok5fauu5EIJkv9xjqctfLo8Hf+vTMat2OnObIXW0dQt6lTJd09p?=
 =?us-ascii?Q?Mzg50m/CzjTAF4fE4UIrR7sP7Z1S2AR1cMTyi6dXoH17nZu4rimU+YPbyU2d?=
 =?us-ascii?Q?9I/hmgetYp86BWP4XukAouWUy2ELwzyCOEyygxaix+WZQsqWIyozy0WWGy28?=
 =?us-ascii?Q?ysSi2lTi8RDfQVEgrev8RfsxbOK7Cte6kZXU754o2Wzr5hrLfwuuT1z/pGpN?=
 =?us-ascii?Q?+4NnIsF1LLo+aFRBb0OzCf33ZEkc4XTGMaE1AzhSyI6kW/bSQr0gTOiS/I+y?=
 =?us-ascii?Q?h32JZ6iwZAkRe3mgaHOSoqIF1riLoNHAqKXAfDiZHz+5iKcVETy7p1BSaZvQ?=
 =?us-ascii?Q?9dIg/1jOKku3fasRJ89jrbctMHTVqIrO5yRWe9xmdOOHeyDI4b0RvL958gP4?=
 =?us-ascii?Q?HvOWQ9OpQcz//7dBKGZF7GUHR2+YGmNZt8FaFqwbiti4FuKnBjkrVC1AzSCf?=
 =?us-ascii?Q?XW9MyNiqBpFxxHHHycxzU55ntQ8piYXYRDKS0XG7cj2i4FPKUX96YcxkJo40?=
 =?us-ascii?Q?2KFEpVaVXGWJnn46Zvn1PtzpPshEk/a2ktz28g30KGTF13PGtBq8Hmap/aMv?=
 =?us-ascii?Q?yu3Isx26EuDLyqf23M6aYFf3RyO/4E7mTK8iYSdNtkXgjg2J8Q60UaNzt/zW?=
 =?us-ascii?Q?mtPjZpfEjIZE4sgQLgm7Oiyny56Ml5eI/7lVtCfi8HLJErQw3KCh7jBKALBt?=
 =?us-ascii?Q?uS1BMvUrBrbMXOAxl2WeB3HlWPJwZ/qDkkbB2D+7q6dt7JahDIErKbevfAyN?=
 =?us-ascii?Q?E/tY65CxYfQjfepyr5aw8jn9DJ05ey0H7LoX5BIb5WByNLRdwIPqEDZ9g9un?=
 =?us-ascii?Q?xsfdKl7z9MWkXfaTbak9pb5cEOlsRLqTLqj/f+33Ap8JsP4wNcOS1gTOvusK?=
 =?us-ascii?Q?QX4NXI7OTkm00eALNqdhvm5zlZXbPwGLLDbhnIVjAVUlBuVxgek6hUhNexCD?=
 =?us-ascii?Q?/5d9DWNTNHpOLn9rKjsGxfvWMr/LiZVYLKxR2xDGOIKfmwSgqqIQ7jsxM7Ls?=
 =?us-ascii?Q?JNI2tUWW3EU3x2AYKb9RvyS5COHtwEuCODHseEKc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c858de7-3496-4ee9-02eb-08dd5bfc1a70
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 15:40:49.2917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0sWqJZZC1mJHBVgubHanxboOQ0rN2E23xYLw/CTQ7y3rXtPL3H6MPH8xCZgT2xvvztQL5ReybVg5chz+4iJ1/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8162

On Wed, Mar 05, 2025 at 03:43:15PM +0100, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
>
> Remove the switch statement and base perst release on whether it is
> found in the device tree. The probe function fails without the reset
> property, making it mandatory. Therefore, always release reset
> independent of the variant.

Thanks for clean up this.

"Remove the switch statement for releasing 'perst' and 'reset' since they
are already correctly set at probe and are no-ops for
reset_control_deassert(NULL). Call these unconditionally."

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> This does not change the behavior of the driver but reduces driver
> complexity and allows for easier future modifications.
>
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> ---
>  drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> index e98361dcdeadf..5b505e34ca364 100644
> --- a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> +++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> @@ -141,15 +141,9 @@ static int imx8_pcie_phy_power_on(struct phy *phy)
>  			   IMX8MM_GPR_PCIE_REF_CLK_PLL);
>  	usleep_range(100, 200);
>
> -	switch (imx8_phy->drvdata->variant) {
> -	case IMX8MP:
> -		reset_control_deassert(imx8_phy->perst);
> -		fallthrough;
> -	case IMX8MM:
> -		reset_control_deassert(imx8_phy->reset);
> -		usleep_range(200, 500);
> -		break;
> -	}
> +	reset_control_deassert(imx8_phy->perst);
> +	reset_control_deassert(imx8_phy->reset);
> +	usleep_range(200, 500);
>
>  	/* Do the PHY common block reset */
>  	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
> --
> 2.45.2
>

