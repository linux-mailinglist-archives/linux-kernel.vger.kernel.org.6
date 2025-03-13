Return-Path: <linux-kernel+bounces-559977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB794A5FBE1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 343AF3A47A8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D430269CF2;
	Thu, 13 Mar 2025 16:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RAKjGYPQ"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A836A268C5A;
	Thu, 13 Mar 2025 16:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741883605; cv=fail; b=VH3HcxclI9O5L8I/3EzEY5aekqALJZ7KN3c/6UqPWEUQ1/zeUcnvAey1O7JAqYkXNzGnwJgbyOxq5KmT/CzPNDuu2CNjGh7UYUsLdGrW3M5LCMN5kDek06NordKFzgRqW4gFHgNVBNu7qlD9RTFghTBiw6wlahTHbu8YTafBkPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741883605; c=relaxed/simple;
	bh=ZnjvFZoi+JqytVIG/9wqjaR0HT3blX4BfcqG/U66IXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lRVnIpWJGqyfLnSoslgKYq8CtdkvK7wf9g9YovwAfq6Cj7DicJl4JhLe3TwS+gEYb/NJ8xPF+GwDklde4bu1Q8IoO7tJ6/Ka6bdkzSTASHa5gMEAVupGFTiMh8mDZINWqAjAptiEIS8CuZXrhQUmZPPUYyoNKESg7eWJtU7pI+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RAKjGYPQ; arc=fail smtp.client-ip=40.107.20.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJqacpm8LBRVdoXXDs3cUDD/voj0as8WnIoHWZcDSoCcHGO9CHH6sCVbyCFQEMwR7blcu2nHNe0IdYXXswf/vPuIoUNSC6yvRrdM2OCREN7ZAmMWzr9n/n5sXw8L5iuM/EPA8FwwMEs36DXm0C1KbSe8asgE+6GXIwRhX9qwN4OPHc9OicLdT2ik8qCwMJDnh+uDkr50bZodSc4Pq5Gj06BwMSaSeXBVorvOSENf0hgZlvgZ3H+gEPe6zq5tNirhAFLW+K2uhxQTov/vsMk8A8W/JE7tYxZdLhHqKLsUcx8UmkobHrWay7cO6k/AbUjcGEoiIjyJ+vF4Q5sbs+pdbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Uqkg6lNyGKStWD9xo9TPLY5bucNCSOSZeWhHSvU1PQ=;
 b=Jmc9MQoYzmP2o8xZuM7XqPOzuwim1LhYtStu/1fQ99h6QHcd+x7yQrNQ+jjEV+4Gr20eALvxD8XdjZLNznFnciMRX5Ife4PvPbHu9iazJU/QDufSL8LW6eY5qOIifjmnqZwmnj1E10V+bZvhspHInKA4/3MEB/iH8mI6Wte0mI1JX/oeCr253MoZj883712LsKvC9G9YPMenpV/uXD8MXMCI5w6kuL9iil7kX5E4CePefyAMi3dbrCQo9svCS92OKn2zucjOxMX0I5gMy8MAobV7keRovyIQInlOi4veufpmZqSxbZu9w503tyg2X8wCVjIHorZwPy6hGXDGI/D3hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Uqkg6lNyGKStWD9xo9TPLY5bucNCSOSZeWhHSvU1PQ=;
 b=RAKjGYPQ9N4MNphozaCFcwQ6X/r9MrJE+dR+Gt6vpDngjAsV8PN9/uXEFV7iTT0NH4DR2BPAXQ2xPnIGL132AMq0tN9RI86Jw7iyj6jxSl0h8bNH/BKW0rXO1YfQQ1zBktRupbvwA4ohUbgBgppJQYK4F+YcoFlSbcn+ZJeJ38MvD/KEAb2f3tXVe6SZSAobQ2i/VMWXaZq8aoQ8rP+qFu8f2P3JS1jnGgxBkdi1nWjUAVdERg2VmDKIzHeSbM+Gu81WwhFR7VAcXgR52nDjv7sIBAktWLBkoKkE42J3H6bqDYeaHHw0hL2QOY+G1+YUwMitfZI8yDpt8+wyzieS4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10759.eurprd04.prod.outlook.com (2603:10a6:800:260::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 16:33:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 16:33:19 +0000
Date: Thu, 13 Mar 2025 12:33:10 -0400
From: Frank Li <Frank.li@nxp.com>
To: florin.leotescu@oss.nxp.com
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Shych <michaelsh@nvidia.com>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	viorel.suman@nxp.com, carlos.song@nxp.com,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	festevam@gmail.com, Florin Leotescu <florin.leotescu@nxp.com>
Subject: Re: [PATCH v4 2/3] hwmon: emc2305: Add OF support
Message-ID: <Z9MIxuelKSdT0rUK@lizhi-Precision-Tower-5810>
References: <20250313125746.2901904-1-florin.leotescu@oss.nxp.com>
 <20250313125746.2901904-3-florin.leotescu@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313125746.2901904-3-florin.leotescu@oss.nxp.com>
X-ClientProxiedBy: SJ0PR13CA0141.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10759:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ba82905-7247-40be-a414-08dd624cc386
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?58a0ZcmyYbjceKeTCx31o++NKCLy3p+jrBT+VUUfGuVg2TcBvVWq8I4BnFZf?=
 =?us-ascii?Q?ivwMALQilEynaroravbVhglvUbq1GGwdjVqsfcdphDcu5cITGYsmqFKsAgcL?=
 =?us-ascii?Q?KmyF16UeL+4UvYiUzR8z78NbZmFrUNd6MsMepZrijlJ6AANnH56MfAgwGiCH?=
 =?us-ascii?Q?iYPQ6Fd8C/MZ3xHzDju0pUQJNh0uAHKcrnpUpEuvjvkfpRtahKxQbGxGCTf3?=
 =?us-ascii?Q?tIo6zA4z3iMpB1tHJbmlDZI2w9oj6JzJjtDybYd5a1UrMe6vpcrZTzwZOMa7?=
 =?us-ascii?Q?yTiHH4kfY/L6nZ8/DmgYrQo/xzyXNJBiAnkPmQ84HPwdyPxxfovI+ulSi1A9?=
 =?us-ascii?Q?dXvV2CFZ0lLg5gdf3E4mENo3vT2i+Ph6nCKXnyTGzzmNivXDrtklMEGkcWx6?=
 =?us-ascii?Q?b8E5rU/CXDuKrQW1wnVPp4da/2mdXCgVQbjCUEn7iRvcJ5K8SywCZDCRkCOm?=
 =?us-ascii?Q?Pts75n3babFSgvl1NTCenBRlmwj7JC576PYg6AXqDrshSwGBwG93sXKriIsk?=
 =?us-ascii?Q?FEIpuYyoEfSbQZnSfnYkJPlNt9e15JReMU/GQceDHxgtyY3bZoOooew/L6ZX?=
 =?us-ascii?Q?/Hj0SIh0ZHkQyERGmCSkJ9H4olo+0FUT7o85+tHtrOk3I9axUqsEx2FEPvaG?=
 =?us-ascii?Q?TzJXn79Id06JekvVZ9z9/12pCCZFRqpF18YLTF6reQFSsUA0xcbtoyAb3LCx?=
 =?us-ascii?Q?2Iz+5h0N2M7cdCS+hk2x8hIAD+c6s57i4hi6f6oiFgcTXXAseK7iPXJm4UEW?=
 =?us-ascii?Q?G/W6Yqv+W6C4Ly3MTSIs/RmN8ovYDj6hp7stqGZvXZ3m7nWzHbrVCKAT0Dvk?=
 =?us-ascii?Q?5E72S8vEjBsI+KVjML2EiYDIBk6br6TwN7PYUt/jb9ppiNViB/hvmKthJRAG?=
 =?us-ascii?Q?58jdafKiE5Q/5TcGiHrYJv6a+tAcbJ8Th7UaxK36FRLwDzuUNhOFsOBHaFuU?=
 =?us-ascii?Q?nrkmvfIat9/OceDcMx1D0xR2LVCcFtny7z1lolwRTZy7NZ+i3wjoe2zcleZa?=
 =?us-ascii?Q?Q/IdQ7T9KX1LVA1HLWWh5Zce3lKdM92gLZvQr8HlieTdnQLjEH3TUfGDrHr3?=
 =?us-ascii?Q?HSYwxyx+Eug+QIyaR1EjIfkuaaRDc7jsFwMknEYJmnF/hQOk5h8B/FP5gCCs?=
 =?us-ascii?Q?W00GQjCbGK8F177VfmnAHWRZB0gBv54HVlWl11PUsnmb0N1bvEAPRnO0YsMq?=
 =?us-ascii?Q?sB7iTbOrGtPgRL+J1dDI4rvD7Wo8A9MxBHLeHcg6mtvm2WLSoGS7+C34HcPa?=
 =?us-ascii?Q?lo9E7dNICLTrJsQEyde4s6eJAqRu/PchwxCluNaIh8F1h06wqOpsbVfA6v8H?=
 =?us-ascii?Q?EYYPyS2eXmbV2bGSngLVwG2U+MQmDbCZoZwK2ygCNCakeZ7+hNIrVfYtw+Ot?=
 =?us-ascii?Q?KFX7/WnNSSX8ASu38k6LrLDY4zD8zcJCe+lUlUmGsasZR5rgs5Z7QjPvEXW9?=
 =?us-ascii?Q?NrgvYag2h9mMXcTokQzN+KwLtj76qMNn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9sC9cUC9XDcq5onZqqwZx0Ji65CF2fV3L8mGmkkzT8srwHaFX/7CcvCvuV3G?=
 =?us-ascii?Q?DGugE0EYpXVTuWvzHIsoyvzECQzqfS0RpE7cKDmVBezDROJgxbx6vQL/1mA7?=
 =?us-ascii?Q?7vrcooH36agKsFAhr1kPdNBfkPOyuE1B9qhmcxHu/LyIovENSwSHuL/Eff2p?=
 =?us-ascii?Q?vP9MNKuiglDyU3+pWioYjXE11U53IcLR+FtWoHrkQG4jZr5ZFA9stL9O1BdT?=
 =?us-ascii?Q?ikKx6rjl0fDTNzk+wW/2b8zOqkoHsJN1N9uSU4eauewOU5shQv79BRfprHme?=
 =?us-ascii?Q?oPRwSHfLM2ENGbvj+TezC8lX8qIN0gvPHD7AuECI1nB0inoaMEvdXEj7WOIk?=
 =?us-ascii?Q?uAShWbaz+TUCiJ6FKKLjuKZrv+88OIlXiX6rE7hthRAjlhPDLKRaMa82R3gk?=
 =?us-ascii?Q?wIxNn6J0fxuD1OpNruPNsuXKKPXuXTR8+1w8/r3O5p4u9WMHABp+sXKOOfWv?=
 =?us-ascii?Q?eJDkUHdWEBLY7h7PX7LN1LvW79tUK2RLrIrRuji0ubwngohPsQ5VTH6AiPHG?=
 =?us-ascii?Q?vL1WVdzG+psLPkmRbHhL45Po75rgSpUhveruDgWeCwOxCt0ZRQvrEQX1UZDK?=
 =?us-ascii?Q?1QOLEWmPpRbm3pzh0VA//PzGkeCkH0sljxAIAdWaV5eZQGstqzttYPS+kW4z?=
 =?us-ascii?Q?1FxNDd1B3Yba2w6OGlA6J7y3TV8Y6jVLzbcYh/DViFwxiAtUvMoMbAzxcwf0?=
 =?us-ascii?Q?FnRFSQuD74TIWJp3HxDYoH/4ZpAiDfmMWdInbNIKeDF4tkWrNxE4+3glTGek?=
 =?us-ascii?Q?By9FUBKawwixz4FkMa0ul/yU7agUqKJeHp5N91P66fQGu/tz0lws8Fuomaln?=
 =?us-ascii?Q?A2G3obdE+gszCFPjfLodeZclWCQ7pEpyDCsJwnPzsWTW6m7yDqNHMzE7Axn9?=
 =?us-ascii?Q?seZZSa+q6+YXd6JgMf+rbxZCIOiJnpi/ql0BkTzFI8FNWxEnqddAjloT4UTe?=
 =?us-ascii?Q?E2I8EBev/+5l0wez398auK28D7On0pGZ55XvHmag+X0lLI8wn4EVe9e3wimK?=
 =?us-ascii?Q?bOK1Pa1DjUB3ANnItlE4T5BDzc8iklGuElb7RQVHjWCeRkilc4YeWFGtCyLL?=
 =?us-ascii?Q?LGMzQ2GYI7zTewdCf1CqRr6pKbsWYy20oyqUMsnlE7txQ9qwdKsQ/t4EIG4D?=
 =?us-ascii?Q?JxnqH/+LmnVhDyIDlv9lhtDyqtQ9SqSYsU42pX5K/jCHzQf8qupduk1aW9il?=
 =?us-ascii?Q?3JExlX3ja49FqSnuR6PR57idKRlbipCh9nwPABXmRdzEk+1oiqQv6y2VZNyS?=
 =?us-ascii?Q?KWraofLTvjzNAS5ARf6rqjBT1Q++JfZNB63tAZs/odCnx+IaO/LZRTvCrhPt?=
 =?us-ascii?Q?Bk2dKLAShf7wAA0i556DOyOWO2KOyWQNfZX3QfhZRjhImBNpAM9rDmMBGJSD?=
 =?us-ascii?Q?YGMY7fztYgCqDfL7ue9CjMCNAaLJvEjnuyJjzGq8kECtdCYXqLe8NnHeHec/?=
 =?us-ascii?Q?nXid3ZsjJ4xHHPDOGbCABlWEHhh3CVRMp1loG4YB/eC8YKKoEnUJvInp30CO?=
 =?us-ascii?Q?Fj1c2J8cGJn/1ZCrj5kS/I7iAFB7KhChu/KZ8pUKAZELg8dSQ4FlDHGLsnjR?=
 =?us-ascii?Q?dRg/93pcd7qAUmFLvGzVGbO2QnyhN0A2jqhXKKLe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba82905-7247-40be-a414-08dd624cc386
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 16:33:19.5793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tP4cGNhkLKfcOOKWRB3AJr83pXgeAiMGCmG4ei4krWWJMyxlA4GWIQ/ExOtW/rwM8lu+loH4swcxcCcARQmnBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10759

On Thu, Mar 13, 2025 at 02:57:45PM +0200, florin.leotescu@oss.nxp.com wrote:
> From: Florin Leotescu <florin.leotescu@nxp.com>
>
> Introduce OF support for Microchip emc2305 pwm fan controller.
>
> Signed-off-by: Florin Leotescu <florin.leotescu@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/hwmon/emc2305.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/hwmon/emc2305.c b/drivers/hwmon/emc2305.c
> index 4d39fbd83769..f8a4c76fcadd 100644
> --- a/drivers/hwmon/emc2305.c
> +++ b/drivers/hwmon/emc2305.c
> @@ -607,9 +607,16 @@ static void emc2305_remove(struct i2c_client *client)
>  		emc2305_unset_tz(dev);
>  }
>
> +static const struct of_device_id of_emc2305_match_table[] = {
> +	{ .compatible = "microchip,emc2305", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, of_emc2305_match_table);
> +
>  static struct i2c_driver emc2305_driver = {
>  	.driver = {
>  		.name = "emc2305",
> +		.of_match_table = of_emc2305_match_table,
>  	},
>  	.probe = emc2305_probe,
>  	.remove	  = emc2305_remove,
> --
> 2.34.1
>

