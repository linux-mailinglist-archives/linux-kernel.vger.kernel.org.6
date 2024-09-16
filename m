Return-Path: <linux-kernel+bounces-330837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDFB97A500
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 17:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1FD52912E6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 15:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E521E15884A;
	Mon, 16 Sep 2024 15:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EVQHe5A8"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2046.outbound.protection.outlook.com [40.107.20.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A5E155CBA
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 15:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726499602; cv=fail; b=n/RSQsw4Q1ZakjUvjkojYOyMry2b2ICpPg+lZvzFLu5NmW7+nLpknrNVkHs6C2L6ctrWILrrp4y6HNc3mFbrP9cd3tfJTVvs0kyJP1tKeSjUnH19MHeZEf1qiGj5UAHuNfbsdkICM3xn5KVro5m8R1Lr58QCfyQW1iRU5EDKk+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726499602; c=relaxed/simple;
	bh=SFMX0MCfViZSvLx7jtj052OYwkxcjvp/5buGLTQTai0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O/soibb58AwWuX8MzlbM8jnxQBdnF+sobZ4bmTO9jON/MN6TXpz+biv+f0hOT1IYA4hJRMZKkuUnvI/qQ+NgDzlgszglXhMamuhZmPR+6ER+x/yL3/00AmVEAOMw5uVHyMzeRXLuRQaa5R8pmoTaEtPJy9nvHbm+XkTHfbvXS9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EVQHe5A8; arc=fail smtp.client-ip=40.107.20.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZOAk57z/YKslMAYQxDHBX5utCG4MVQV6UowKHEbj3P4G3XfhWTEjfFVU+aFQAiAhSV7mUnVQXJ3LEH1kivZvxKVfmXkkiQ78rbBZ5H7Od+Oaghz+QDQCVpL+GOpziglZRsJtBXuu1eVtM7UNzI0CDLGk9Cp5OJg+ULUT7vMn2mwDQ9zJ3gp9G9+cF0+dq8UirLrp+Q3hAno17vfLTKj5IzYBz9YqymCTgGeAY6gmC1xpZbaCIS8wqZE7OD8yh9x6qmOgcsN76VAniTPKwGWcSh5joBWS/tRMOZbTnN2GAGfwfVdjNQ9FlOb6n3h/BKtpXFdakiSABxYfLD39lXNQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QM50yKSG1UWygcQ+luqyvfl9LTkE22/Ha0Ka+3JjXZw=;
 b=VXHKu4PQUxfiaTGavRernCUd2sYirswAQ45B9O9kJsfJuzNGb+kdT1mm1cgROoWFsog2PbnPdDLGAPyk/K/qjYVekZheakJcKwQgDS0h/XoppOwqRu2ppxYf4OlIhuQh5wto8f6LAMJrGOhwA1any+911XPgi/+1Cj907Kd+7PDPiIvGEHYN9R+yxy+IX6SM9y55PwpHx3DJVCcOeveJZHurpIr8LF3nlZxGI5X2cH2CmuQVurcwEiLxdffb58VWL14BkHoxKyCW7tzHwg/yRnGjVxjU+q0xKX3m/ypUJQ5VmL0Ex2kQM0QsarR3nHwaG+L7Dz7qo/D5zfuTO9wbuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QM50yKSG1UWygcQ+luqyvfl9LTkE22/Ha0Ka+3JjXZw=;
 b=EVQHe5A8VzbgRFZ2SEO0p/NTU6XDOZWPwXc5P5oX0JZq8fRSKDzAdNO5WS/yDc1QtlFJjbkDeryBZ5qG0vZqnIGec6uKDCpZbRVXfgUpwE++8t76pzUk2U/W4j4aZCrY9vi5mibWr8S+aRzvw+v9o2iQCPwlaYaz+7Mbc37LQ3LVK7wl8q4Ijzd+z6pGLdaX9YBAt40vwp11wqOtLkWSTaS55iiDFQBmX3c3iiQgTiitYFycYx4Vq3Ji/4IV7hhyjOKSqIxA4zxqSQr791j0Ya7QalrU+sCL1AFPxJFS1535OBEs3wJVDJTMLWX7xdDHwWwJXEGKHSKlNUle1+ulaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7844.eurprd04.prod.outlook.com (2603:10a6:20b:236::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 15:13:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 15:13:17 +0000
Date: Mon, 16 Sep 2024 11:13:08 -0400
From: Frank Li <Frank.li@nxp.com>
To: carlos.song@nxp.com, alexandre.belloni@bootlin.com
Cc: alexandre.belloni@bootlin.com, miquel.raynal@bootlin.com,
	conor.culhane@silvaco.com, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH V5 1/2] i3c: master: support to adjust first broadcast
 address speed
Message-ID: <ZuhLBFQMScBc+PIu@lizhi-Precision-Tower-5810>
References: <20240910051626.4052552-1-carlos.song@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910051626.4052552-1-carlos.song@nxp.com>
X-ClientProxiedBy: BYAPR07CA0026.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::39) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7844:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b038a35-ca74-4465-e47a-08dcd662178b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?90iR+t3+UiC1ehOn+1iT/SlZXUDaYpiuENezDzZMOe33jYii116i3AOl5ci/?=
 =?us-ascii?Q?O/nc/Gc9etpBG0jCaqwy+TKriJqdAqozkUDn+yE1caisTeh5exJt3EXe5LSF?=
 =?us-ascii?Q?gOYANcQTIibzaL7d+ncknn+W5qKiUPW9vQ/QS/xNtSvVBQZa4i2rmDKnOBNl?=
 =?us-ascii?Q?c2OtQ97R6RjAtIxY9vdTKLfPOS9QNTizTDM+XloQNLypoq3GJ6xH02JQUKZ8?=
 =?us-ascii?Q?wbB+v70y2QgXWtNsy1B5XeK1hqRa8FrC2c8nmcK28QGaKxYYLvj6v89BU6K1?=
 =?us-ascii?Q?WqG0u90zPItMTRBGRj9AXibFsUcathdOGZhHuRE7sLL/fWBoYOm0v9KjELJe?=
 =?us-ascii?Q?kFCnffK4bQOry152QsjmXD2UFhTVRrHEfiY+qYWVMh8aItpjSyCzP1J+COw4?=
 =?us-ascii?Q?l0xojAtzeWQIvNdjRoTn5RSLnIeHV368EoPd2LZRt+6/qM4fMat/lO+QoSZQ?=
 =?us-ascii?Q?w/roksOhcElbOb0Og/kFED0XaCqLyxKTpsdr39Oohea27xr/bewmNKOZ5Ksp?=
 =?us-ascii?Q?WtkjldKP2ybwKt9NtlPL2vvlDQ6CI7EfC9TxkzduSa8/6iSBfCqVIkQ7jhTN?=
 =?us-ascii?Q?u2KhF5f2xqLPT8H7xnYYVigIfokn0/ziqJL5gwfpYH1WmXOVoHLB3CBdz/6v?=
 =?us-ascii?Q?Bi7Tc7OmwRSg43FweGjotIB1NmYohJOahac0INXx8tbLwQSmQFMGtRMon86+?=
 =?us-ascii?Q?Tk99pK23KxFn43i+OvpUznwX8NJzeEEwZkqab+hqi6JbHAwhU3hA2kiPz2K3?=
 =?us-ascii?Q?OEHAV6OYeW73ekYRq7N7nSnFpzRaU+MvDr2U1OWMSwPc9ayIczCViNdK/+n3?=
 =?us-ascii?Q?MzXIimmDSksu0j/Nr4jopVWBIHU/rC2fuCjSrdizF1MfwDQB3XHXTlYNqTEw?=
 =?us-ascii?Q?yVh0FltPmmL3JXOmK1uliX6ntcBDWCZieRvUc1shj6UVsTiM+ZwvT/D0G7uW?=
 =?us-ascii?Q?KVTa3Y7pA0vl/tOutksYwJ6EVmJ7Uvz/zG1Tny/wAaEMS+6Y3eguEulj79JV?=
 =?us-ascii?Q?r3FlLkKETVraHGwphX+OHsDPG5OzUi62bp4ZKrT6SpLx3e8Xk8DJahAj51be?=
 =?us-ascii?Q?Ckz6q1mz+RqqMqs0HJvpnWaAV0X5qYSr/J7mJoLxeO9g0+Jzdtz7qCom1ox5?=
 =?us-ascii?Q?jNYlWL/28xHbbziPIaI0afm3mJRT/kX9nWzGwlugOxl4VE4VYIarkAXqgBZP?=
 =?us-ascii?Q?L0WGPwF2o0BIbmT7CGPHTzTiLfq+WR6mm54VtQYDMsWO5e0Z6UlURorkBLla?=
 =?us-ascii?Q?/7ram3aka51U3Dcq9IY/GpnkbBrn8nBtjlTjq60yAHa7UrN1+8ys3/BHfIRy?=
 =?us-ascii?Q?VWZ+J49ymXYmhnHVRPJjNBcJLoSWijua4AZsb/g5sJc+MxpP587tSvUyshsH?=
 =?us-ascii?Q?5pbocSyXSwFu2qE2Esdo/R46BxLk6XbMJf7I4czV6gvOM7ScdA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fPtppx/uCkfbrVlQ+IMth4fVHveZpx3kUF+LtqxDkQ8BHIvRSp3LIzMhtQBk?=
 =?us-ascii?Q?x9RIOD5uTEMC6WjN9byEG84kfOh6Ctr4FgvakfGV3VJSeOM9anBnW18xdA/f?=
 =?us-ascii?Q?3GQZwYvdQgdU5iR0/JcSkFyMjonzzxc7/wrLnB8qNBJ4LA02gABiEUL/YF8C?=
 =?us-ascii?Q?iJi+pr2fGGljbLjlZjoteWLwahj56O0ktaHwJrqNQMnX4Q3PvVKhiiQOldG5?=
 =?us-ascii?Q?fwhgBnCF32U5SX0fIJVw9n0NWgVcTZbCmYvpTZF62z2fNpKNiA64AFYa9w/D?=
 =?us-ascii?Q?Pz/zqdy7dLar7YqsD0gXPYS8oOOeQLeQHzUmGadKYLG1hzB5cgQTCsza+zCz?=
 =?us-ascii?Q?6HasMqIpcDSVBDJa758ku1jMdb9iTpo+sysE3cHD9SrYkRxCsnRnGCuADsOz?=
 =?us-ascii?Q?4tHKTo2RxA0zog9t5M2Odh0zc+AoISlrJfHEW80Wo3W1/XmRhMzctx4xVDvV?=
 =?us-ascii?Q?Ta0G+9N2MTnLN72as5p8ux1dnCSO2ERRztXWMxI6H0MGtXs8b0YVoKA9geCg?=
 =?us-ascii?Q?bQjJUk/pEVotDTY1c0NNHmQ6Bn1aFy3oiQZ4FkJFzMXagLHglRtwn+cja/ra?=
 =?us-ascii?Q?WNDQwnApNcI2QmrZeY+RL59cSvg6ClVaW4ivdzjETHoUmnWwe/JHJe8Gy+xw?=
 =?us-ascii?Q?gOlTrvmDsxIqLdWK4k87/U0QtHIcFeBDrAWNc+gmOos0nqVcgSMngmoRtVtQ?=
 =?us-ascii?Q?6Ifj3A7GUo3WP+Rdo5nFoymCSOSnN7qXcoaGEav9Z+C3ebQOLumYXyUoO9bC?=
 =?us-ascii?Q?4TSUIpPCcmt0lMSPSyi6e79YHGC+VXdao9L5VDAwwcBSdEnT9Iwz4ez1PrQV?=
 =?us-ascii?Q?S4qKmSpGPRpCha5bkBsUULXax8hwr86NmbZeuTCYSvBPKNJ23lvxqLSC0NSi?=
 =?us-ascii?Q?ojSejBGcGA7I+nFt8Ck2mrPKPEQkLIKiYNlZck2nfaIriW1TiJN04tStrlMO?=
 =?us-ascii?Q?3VzoFxCT+1sfSpLoEcz6jR128/o7cBnpDiZHX3qpd6Cq9Ju4GKk0gYfAE9Js?=
 =?us-ascii?Q?wylfoWep2JrHpIDW3IPTmZkUQQGGdsjwwZEweSVjip51yhtv1ZIyyANi4gHB?=
 =?us-ascii?Q?h7B2wtwxT5+rRaFMKbY0qAyrXGR2obKDobPgJ+hg75/d6gri63wOwXPggzjX?=
 =?us-ascii?Q?6FeFEw9I6Xln9EUPvlAk7EUB/wpm1AQCXj1aYNCqJl3ryke9Bv/Owd9xe0Pu?=
 =?us-ascii?Q?D3jif1pfryNMcRUiq1nkuiMEQ+j9D14jcThpR7dTxJ+HtrAnrRC/9+EcipYw?=
 =?us-ascii?Q?RFZBvBRq4uK8ZPIjLeICQ4qVhZE3Z6C/nplXmYweFFD84WqA3XK71ZGbXoUB?=
 =?us-ascii?Q?kmKm5nyTmbSrv3dWkahL/VBcEIgtfmzZPjUO9lW/UZAKjSuIptPaES+eswpU?=
 =?us-ascii?Q?RtiGSpTzSAsOIpcTOWlJKm9Ay5lZIkJdwyvms+mV0uGwjohX+u5mjmXx//Ug?=
 =?us-ascii?Q?bDCwA4uEBWK9J+rPvxhtBeGQaYlURCDv8D9kWpr9BsEPcROZpXLm1qhRM0sD?=
 =?us-ascii?Q?rxid6u92Neaw84cwft+QMD5M75yqfXVDfQrJ7bw0TPCI1ztUhAFeT4RI+5GG?=
 =?us-ascii?Q?tJUGStbnCy8Afp3nKcToevl+rUR6wEZ1QFvUTWe0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b038a35-ca74-4465-e47a-08dcd662178b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 15:13:17.1969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T5mgYTsSdQGBH9CP29Kr+E6IuOg4KGmwnV92fgOt47YL+GVxrUak8+i0dpVoOAQlo6BuH8NxUpESQZD6KwIUyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7844

On Tue, Sep 10, 2024 at 01:16:25PM +0800, carlos.song@nxp.com wrote:
> From: Carlos Song <carlos.song@nxp.com>
>
> According to I3C spec 6.2 Timing Specification, the Open Drain High Period
> of SCL Clock timing for first broadcast address should be adjusted to 200ns
> at least. I3C device working as i2c device will see the broadcast to close
> its Spike Filter then change to work at I3C mode. After that I3C open drain
> SCL high level should be adjusted back.
>
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---

Alex:
	I saw v6.11 tag, These two patches is critical for imx93-9x9-evk
boards. without these two patch, all i3c devices can't be proble. I am
sure if there still have chance to get merged for 6.12.

Frank


> Change for V5:
> - No change. Resend this patch to list after subscribe to mail list.
> Change for V4:
> - No change. Send this patch with svc-i3c-master.c fix patch.
> Change for V3:
> - Modify comments from Miquel's suggestion
> Change for V2:
> - Fix set_speed description from Frank's comment
> ---
>  drivers/i3c/master.c       | 12 ++++++++++++
>  include/linux/i3c/master.h | 16 ++++++++++++++++
>  2 files changed, 28 insertions(+)
>
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 7028f03c2c42..6f3eb710a75d 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -1868,6 +1868,12 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
>  		goto err_bus_cleanup;
>  	}
>
> +	if (master->ops->set_speed) {
> +		ret = master->ops->set_speed(master, I3C_OPEN_DRAIN_SLOW_SPEED);
> +		if (ret)
> +			goto err_bus_cleanup;
> +	}
> +
>  	/*
>  	 * Reset all dynamic address that may have been assigned before
>  	 * (assigned by the bootloader for example).
> @@ -1876,6 +1882,12 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
>  	if (ret && ret != I3C_ERROR_M2)
>  		goto err_bus_cleanup;
>
> +	if (master->ops->set_speed) {
> +		master->ops->set_speed(master, I3C_OPEN_DRAIN_NORMAL_SPEED);
> +		if (ret)
> +			goto err_bus_cleanup;
> +	}
> +
>  	/* Disable all slave events before starting DAA. */
>  	ret = i3c_master_disec_locked(master, I3C_BROADCAST_ADDR,
>  				      I3C_CCC_EVENT_SIR | I3C_CCC_EVENT_MR |
> diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
> index 074f632868d9..2a1ed05d5782 100644
> --- a/include/linux/i3c/master.h
> +++ b/include/linux/i3c/master.h
> @@ -277,6 +277,20 @@ enum i3c_bus_mode {
>  	I3C_BUS_MODE_MIXED_SLOW,
>  };
>
> +/**
> + * enum i3c_open_drain_speed - I3C open-drain speed
> + * @I3C_OPEN_DRAIN_SLOW_SPEED: Slow open-drain speed for sending the first
> + *				broadcast address. The first broadcast address at this speed
> + *				will be visible to all devices on the I3C bus. I3C devices
> + *				working in I2C mode will turn off their spike filter when
> + *				switching into I3C mode.
> + * @I3C_OPEN_DRAIN_NORMAL_SPEED: Normal open-drain speed in I3C bus mode.
> + */
> +enum i3c_open_drain_speed {
> +	I3C_OPEN_DRAIN_SLOW_SPEED,
> +	I3C_OPEN_DRAIN_NORMAL_SPEED,
> +};
> +
>  /**
>   * enum i3c_addr_slot_status - I3C address slot status
>   * @I3C_ADDR_SLOT_FREE: address is free
> @@ -436,6 +450,7 @@ struct i3c_bus {
>   *		      NULL.
>   * @enable_hotjoin: enable hot join event detect.
>   * @disable_hotjoin: disable hot join event detect.
> + * @set_speed: adjust I3C open drain mode timing.
>   */
>  struct i3c_master_controller_ops {
>  	int (*bus_init)(struct i3c_master_controller *master);
> @@ -464,6 +479,7 @@ struct i3c_master_controller_ops {
>  				 struct i3c_ibi_slot *slot);
>  	int (*enable_hotjoin)(struct i3c_master_controller *master);
>  	int (*disable_hotjoin)(struct i3c_master_controller *master);
> +	int (*set_speed)(struct i3c_master_controller *master, enum i3c_open_drain_speed speed);
>  };
>
>  /**
> --
> 2.34.1
>

