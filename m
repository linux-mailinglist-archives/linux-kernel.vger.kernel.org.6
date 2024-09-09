Return-Path: <linux-kernel+bounces-322029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B187B97230B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 21:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0577B22FF5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 19:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE368189F3B;
	Mon,  9 Sep 2024 19:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bfv35pUT"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2074.outbound.protection.outlook.com [40.107.20.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D0518C31
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 19:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725911933; cv=fail; b=CNeGe/pMZgnENrZDXtHIPB2h1KyjIMGSoYnNu7onD75e/L/B+o9uUrrzrcvT3tklKFSTC3GfbB35nyezuhzUchA2sIH6nnnmJZiCHFQGmx9yVawlnyZOcln4mzUqgKU+OnLLTfqx8Jm5AP3To9Zw/IZbF9iJxLf89LiNPlgegBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725911933; c=relaxed/simple;
	bh=eQcYD1JXTmF0dHi2rz0gPXIEgPB0uzUGpw3/SGJuwl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oZA6sV6IflxKDFsdh2a8LniNcpbgduTPjF5i7WMKfw/IJ+nIoqkjzjHfA3SupI7WbQWlppBuZpm+y7ZeGTy4iAs8dxzFwY+fXuRO3sMXAlx1ofyOJ81omWvFXgMPYYi3jj6e4mtGTpc6fYRTfbvXe8rF0efUn+GUZQyZjj2hECE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bfv35pUT; arc=fail smtp.client-ip=40.107.20.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tZeRVStikzQPq9ifzZxaAfC6JspIqygp7UaROnjYwx6Y7e9W15Ou1dDYEefAChqUSpHQcl1VVw/jb6QeyYkMTTjGH1JFh7NYjs9ZkZQxd+BhLveCq0KCTh7h2fIU/YO17D/AqciqFVFNmZeVWYX0Jhb20CnDxr1KdSS3/rHEFu4V6omfmKzniCaw37eH8aAcg/0NiHYfNMw6zvXt0jOij1n/+hImNZnyDrKDAd9cloGBMS++L79VXEi4LVVYL6h/eYcsETpxwqxXCSyMZ1w/kQQsyBz1pweEjV3TPfTJLzWhahGC6jPEEaUAW8LV9qaUsW/tFHFcVFXC1JGSr9es9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ON2yRtmAamrjeP8SDtGS3+NTWDZP7Uc0UHafvhzam3I=;
 b=ajHt+2xrzo5hAsZzeycnob/EHC8YqvxDtDdQM9Axb1HlSQo1q5i+5cdup2bND4pskb0k+5T/aOwe1+3XrvdxWZZ9jw514mi6KnX453yIK1K6abwMoKtz1YRiUfSLTmCm47gJImXnBa9Rf2L+IeCzQ1IQ3Ga8u+EMzsI9btP74ksUIstE1uB87q7CoGWsaeLBvJ/NV2rMEQcKtErOGOS2NChHD0F4ojs5kl9ZOgKw5mtRMPUgLep+jeWA302MjSE/ZvBwvJ70wgQZiBza5zu13FTl30/wyvfdP++udewvJlwjDdbWJgWECDCqq6Nz6O1AT61gMI+BleWAOOIHGn+zOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ON2yRtmAamrjeP8SDtGS3+NTWDZP7Uc0UHafvhzam3I=;
 b=bfv35pUTLOoWZVKNzLIFp1HCnK6oAKJYUnf8kAj/O93jOUVLM4NLEXuPgoNC1ENlURm72ZzRFII9UHIfQFNsCQPWOut3FqmQNX2SRCUwsCpsMifYBiC174sZ91taF6xPXhWJCa1nyUthTaG7e6gb2hb0XBuhpKz+PufSngfM5TbUGJ3s4x7p5P6C4uSIQes7xQzGqoDqN4yQEUgjNRZQyFS0aKfEapIAxuuZ1CEiM6RWDVneG4Dcoztk5f2A6xXqiCUtq+75shwcOAviBu7psajQ5xXrCXqdWuxbnNGbneeOHSG2gRETCWusy2XvcezPlDWGnzDyraXEfx2etUSXhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB10572.eurprd04.prod.outlook.com (2603:10a6:800:27c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 9 Sep
 2024 19:58:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 19:58:47 +0000
Date: Mon, 9 Sep 2024 15:58:40 -0400
From: Frank Li <Frank.li@nxp.com>
To: Carlos Song <carlos.song@nxp.com>
Cc: alexandre.belloni@bootlin.com, miquel.raynal@bootlin.com,
	conor.culhane@silvaco.com, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH V4 1/2] i3c: master: support to adjust first broadcast
 address speed
Message-ID: <Zt9TcLqi34EDlI6b@lizhi-Precision-Tower-5810>
References: <20240905074557.3810026-1-carlos.song@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905074557.3810026-1-carlos.song@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0176.namprd03.prod.outlook.com
 (2603:10b6:a03:338::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI2PR04MB10572:EE_
X-MS-Office365-Filtering-Correlation-Id: ed4bac09-680e-455a-0a78-08dcd109d114
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YIXDlsdm8rTBgbcx5fbB+xJC1vpEVefkBJZSd7R/UjDci2g2QdUmgQ5SGGSi?=
 =?us-ascii?Q?LNVZRGQxjVGn3VRGXV13Pmpn4HUL+ETnGkArvy4GkjBR5NKLaqu6b5zFwMAP?=
 =?us-ascii?Q?8nl5wI2qSgwhqDOZmhIciKqkdF7PM3+40W/gzS0PYQULQ7BrnZy/gIq/uEZ9?=
 =?us-ascii?Q?RFcV0VZ/NiCDD+8ycWmXjzkjRfRTe3lszLrQYNXO7P2XyIUf9/DOEzYOGtA/?=
 =?us-ascii?Q?ki71fLgQJ8LlApYNjYAHMcsbUUKjL6vKzc32dNg39S+nfzSeFQ750iQeyNiw?=
 =?us-ascii?Q?dmfGv38IEcp5ARZA4yCUar/izIeqbXv0BwGh/uV/yf1dHJLT8QsBSvFRQtJ7?=
 =?us-ascii?Q?KgboeZliuzph37wDN63uPh6mtyi9PMgepDkgsImEszaYsn4IbSCOs+8FT8hW?=
 =?us-ascii?Q?ZDrEGGDVZsF8BcUQdAPaYyBEwkgMI6u0hHe3uZ9kNJScPK59yVgJWC6BkFrR?=
 =?us-ascii?Q?GoAqeEjPZvMU/HDN0OucbfLM/fuLD8ksZ/t8Gattf6orcpSUTgGNkUiyVfJw?=
 =?us-ascii?Q?5i7uBYVUO/ktSKsbFikp9DNKr1DSTmo6o1jV4oDzfgY/W3ACD1JktJ/AqN+7?=
 =?us-ascii?Q?tzxPEEVE/WT7FsMD7fun+uCqK0Lv+GqgKsN46kU2oV6fKtaX/it/vK2QF63u?=
 =?us-ascii?Q?JVvdSdSQUfeFXstRYWQjolovkoAJF4i83ucRaf8kBpQPIgQ+UiIL3wagxvJL?=
 =?us-ascii?Q?J26m3Kdoga7JWxZSDl4wa/uefABKAG1Ab9ZPwwbmcfvqkFLzq68m58uGQTWS?=
 =?us-ascii?Q?ZrMfwLMmsCAgNNmHPlUY2W/jZ+3gr3+KwVz6CsOHfKz17MSbAkkd9whZdWdM?=
 =?us-ascii?Q?3h0reivXWYP8DVP+MwScEbKTTpiN/3RceSJKivP3JR1SIeqDGGhwNHKcg3CY?=
 =?us-ascii?Q?o3sXM+AFJxLUIFDn/n8wViLhRibpiR0x7Wl2cUj+ttqOHkrcAY8BBCMBsS/J?=
 =?us-ascii?Q?r0tmOT8IQRtuxAcq0OGrZvsmFj/n/NRHLql2azFZTagoGfDXIvLD5vzby7/L?=
 =?us-ascii?Q?hMQhG/+cWviqbe2b8LpPoNGY5aOJbVx/IiNZbI9ijAc4ADYI1XUa0NNofUZB?=
 =?us-ascii?Q?n05GZq71iJff6s7QT7EFiPV4KZdVcXfsq1rUrwFK0D51QprNtVLEsexk186b?=
 =?us-ascii?Q?YiqDSrasbrBU7ZHrYYnB6JfzBY4x2qrNwMkuCDzFo8NhyQRY46ZSK+x0XRdw?=
 =?us-ascii?Q?zp0DsqIxCt0qM+abNAjpX16Xz4DuGthgsF0rYPV03xcmhq0Sylhl06IDLQc4?=
 =?us-ascii?Q?p/xYvp/Y7qzEl7TPlYleKynDXdLeWGWZzZsifbPr/R0PsoQx+zy46WrQ9FJY?=
 =?us-ascii?Q?mBc74gRO9yBauAlfLfnEYcH4zBc/uoxNYEs7MPznHN6yQBd1DJqQ6+5rWUew?=
 =?us-ascii?Q?yqr6U8MNymL9Jr5YxYRuxcz0HBqtufGi47XLFMktWMfFrT7JIA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E6gnUrrflPhpuo6xw/JQoLCue0N5Jc3f2Gez7EkWnJ/1ql4LzN8KETJFSkNz?=
 =?us-ascii?Q?/3nfH509Xfq8q1dGbbGtUo+Lfego3s6Rzl/zEaE5tROapmVlBuKxZ0Dg4Ybh?=
 =?us-ascii?Q?YPLlt/w6c3qiizXVqdc5Xg+djEaMKH4FnGgGaILStQx+RvZTV0FyFw1EgcAk?=
 =?us-ascii?Q?BDDzQxETVsbK17lW2rF9V1KFYrnauiFxD25KyE9/cNqJSHRGKtfRDp64GlD3?=
 =?us-ascii?Q?Wbb2Bm9k0J92XVMoyK4uFaRQoXGK5AHIDCRd/yyrjx06VKhm7svXL8jFd21G?=
 =?us-ascii?Q?UTUbamhSBuRPaC0lXB21HXVgpiIhu9yNgInZp6ayFUdz2e+olKPkMw50teUS?=
 =?us-ascii?Q?Y43/HHYfTf2Ph12NHGvDR3nYkM4FzlFTdmP57rfWUrB56BDEoRiA9wav08tk?=
 =?us-ascii?Q?bsxc5GWJdMd1G+RGufqhB+tMybXQnAzVP12y6FPDhkql1Mg1c2fBMmyEqfla?=
 =?us-ascii?Q?5nDU/hDi6nhMv0WhRCerJ3Oh5iwvUHTQFe7BRf4OsEnzujg2KtdppsIyYByc?=
 =?us-ascii?Q?G3ELHAD8uOjC1JyELp3pDmni0P09Zlz7HebWQDWxwUuuQ20jQWi3hEq9cim0?=
 =?us-ascii?Q?Y72yoFOnn/ZqdN64z+FhAvxNmD9r69HXCyLHhFSZ7UxmGne11312jx98Oig5?=
 =?us-ascii?Q?0ejFFuKEEK+xMVAnbsYX5p4IkOqdkAYHytnO8K/b8gSjkfXGcjZ8nshL2AZa?=
 =?us-ascii?Q?J2TCwpZgTN8sXo2Nvbni349FEX3aiusKIXDsngihLF9l/tC7HQ/xasN7Vgej?=
 =?us-ascii?Q?h71swd4ndH4AWNHOovIS3LlmFF8Hv+IMDDjqYb37jSkc7RMm0ACF3ARKZdx5?=
 =?us-ascii?Q?WUE9zjiBvQ/6EnNPxuRdeBUHuhipOrwfofUzarVW7Pw+Vvwk0dkh/BDResXq?=
 =?us-ascii?Q?hL6bZTyFXthvjkQCkEDKhHe1+p5w3UODSKbYeau3EbrcLrhVr85E3NMtvqbH?=
 =?us-ascii?Q?SGQ+SE8G87re6nNMcI1NRdbGb2J7qA3wmY2u4rJpzPSRoQcosjUpboYgx7qL?=
 =?us-ascii?Q?QkfVrRNiHbAsMFrt7+UO4lKteYUgzEVuIAAn5r/xpreQAsfHBPvOsTc9zH3L?=
 =?us-ascii?Q?oK5K43gwUaBAMeN7BBM8QPZJ5LjGDuMF0wQleHzX/rRpM3BbvNEmOHVvz59H?=
 =?us-ascii?Q?vrkEff9k1SF1sv1alkTTVwF5wOg2FF67Pyv/l3yQXR/lJxh4vNIMcMR76GSF?=
 =?us-ascii?Q?IzBW8nL6eCH8dtZnfGhvM/AMrL78eHD2lQVxIOL0+M0tK+o06lFhlQcvJ49u?=
 =?us-ascii?Q?8UYShgZ6w9gDA68sKfEPitymfSD1ULGOQ8gQpyf0J9okX5ckIHYDbVhTOv5s?=
 =?us-ascii?Q?lUN4JtDrhwzV2ZdUNPFZw4wUZOSqZjNHgc5UYz93QvVkROyY9iIVuTnnn+Re?=
 =?us-ascii?Q?QrOoHq+FRI/DZ2KgCcNWijS3juuYe7LhF4L4c2XmXqKlty8MEWIDig8tEQjF?=
 =?us-ascii?Q?DXbAjSyGs2bopcAXpm2d0uReH8XH9dXkrwVIpspyVpOZQzGRWfKQzV1NLLiD?=
 =?us-ascii?Q?fUP8ygHIJtgTUg1BMnGYsVRzWM0puMFekCQ3z+vxjO0WAPO7qm+gls76nTi1?=
 =?us-ascii?Q?VLdV8FCRmL7Wb8yZz5Q=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4bac09-680e-455a-0a78-08dcd109d114
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 19:58:47.3798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nBjALMdnv4xeG7ACdsNo+geqNf605tcyfopMM1A2RU6AbDlqsAUt1IgYzTqVy4eMkTJ6vVBjtDb3PMhfllRecA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10572

On Thu, Sep 05, 2024 at 03:45:56PM +0800, Carlos Song wrote:
> According to I3C spec 6.2 Timing Specification, the Open Drain High Period
> of SCL Clock timing for first broadcast address should be adjusted to 200ns
> at least. I3C device working as i2c device will see the broadcast to close
> its Spike Filter then change to work at I3C mode. After that I3C open drain
> SCL high level should be adjusted back.
>
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

Alexandre Belloni:

	I have not seen these in patch work
	https://patchwork.kernel.org/project/linux-i3c/list/

	Any thing wrong. These two patches is critial for some boards.
Could you please take care it?

best regards
Frank Li

> ---
> Change for V4:
> - No change. Send this patch with svc-i3c-master.c fix patch.
> Change for V3:
> - Modify comments from Miquel's suggestion
> Chnage for V2:
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

