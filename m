Return-Path: <linux-kernel+bounces-255302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 071C3933EAB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1B2628148F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 14:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1B8181B85;
	Wed, 17 Jul 2024 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VGuKegzJ"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010054.outbound.protection.outlook.com [52.101.69.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB8D18131A;
	Wed, 17 Jul 2024 14:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721226993; cv=fail; b=qxP0A2F5Ow1HGbUuAnsRUVBqH1/xyH3r+crdWdBGK2k+B0D0iCTt7BNwk1IuAT+erv5uvTUol3b2Sw0uhM3wykh5ehCWCra/qhDhtlJuv2thWbc2Bmz/LJg5qAVTMjyAO/GpQtMW0JXFzW0R8eLL6gcgzDRht+66Zx2iwI6UPw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721226993; c=relaxed/simple;
	bh=DeMgzgJKbWBq+5wvwmGQhn7Tc90PhnecIKMO4BR5wYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NKMjGZyrjby9brWEYnh4DFAqzyjDulUoQGou3VyUUpbaa8didDiEYKv7C8XdDX7/SOtZ508VNmIW1Xzl5GDUG1TmNp04/t99aEPnIBoLnonBzjzvELoa2tlORrPGRJ1UIeEU3pdfw63A3JPuR6kPgnv4VUv1o1Y9RnA/g0JyFcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=VGuKegzJ; arc=fail smtp.client-ip=52.101.69.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQ3Kp3+nl+xxIhbS7FPA/J4BhhnIJtGotofTDzBI3m+cZLwEQiFII1DSbHcCCzb7i9kE5LevIiIQRlzWj6V4GdCghLqx54vkZPrSF3pHLI5VaSLvDwyu10HjoCfJHGBT1rJIZvEwPRAnpbhwpqHWuyAoFw69pI/Mu+vh7D/+ZI44QxjKVZ50orrv64kvxyJiNxMEi5KzlwUd9PVc90y13N/jy93euvbhCK3y5KXUiuKlTyZcw+PUu3VYw31Pbt5SoxgE7GRxwBOM11hPtZDdnER4JCXYqB/+mhL53lWN/RBbocL8CYm5faCHMvGSnGvITtZ8kfMiay8oCk7sm7SHlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IzqcGDOBU1qFL5x7IGD21OaOMY8PQiypW1m+JzGbqsg=;
 b=tam3w5mFso/9rcbxZORy5zQNSrkexS3C7oSnw3tUMxc78pFBMBO2SrSQ8juKExl740CMcPAYyQtUDxJqxn24VZv4wgOJtfan80aMPMsf3Hdny4e0BUaGMTMvyrwi/g3PDh6zUrQWaXGJDe59xm3hGV0cYOGnXpIGH4QCdPA3k3dEfJzLNw7YvyIaLEP+jnIc9VmCDxDqnQ2EDuJHajZPntdyC0nGIxjG3SP+f2q6BtdG5DRSwRY9hU+R9Lj3ebTjQow2WQnu68PTUwG0deuVwcmdYlZPQk9WhGxwZ8kCnOcApLu8a5pAo7E4GRKJgCZIHJJzcnLfF67GXuP64j7pvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzqcGDOBU1qFL5x7IGD21OaOMY8PQiypW1m+JzGbqsg=;
 b=VGuKegzJLtp9SNunT4Nk/mglPjSyuyaExDXakTs9AGySaKpimdUBxMx3vq+IESODWVD2AT6KXBvQCvRslBaUawYGqsxo0+8lFtJKVjW3IwiGtaVSi66UDrNyAYc3NBIekn5PH6n4SMYVpf22So9lZ4urC+jcnhcBew3sSPzI7Ug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7015.eurprd04.prod.outlook.com (2603:10a6:20b:117::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 17 Jul
 2024 14:36:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 14:36:28 +0000
Date: Wed, 17 Jul 2024 10:36:20 -0400
From: Frank Li <Frank.li@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: imx8-ss-dma: Fix adc0 closing brace
 location
Message-ID: <ZpfW5FzJ31QRwKex@lizhi-Precision-Tower-5810>
References: <20240717135027.4116101-1-alexander.stein@ew.tq-group.com>
 <20240717135027.4116101-2-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717135027.4116101-2-alexander.stein@ew.tq-group.com>
X-ClientProxiedBy: BY5PR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:a03:180::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7015:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a414adc-34cd-48d2-43da-08dca66dd7ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gQiEPHRpkVFls6WyIg+xIikc8ga9vaXPQkT/DxXBtUazalsJ0fGrX2OtysSY?=
 =?us-ascii?Q?L/KrZ8w/tmTphcnYWArACH03nDc/TxoZHCOc2gNaczenX0SqdBf8ykrBaQ1E?=
 =?us-ascii?Q?3Cp8tkc2vzf8P87BZSMhhKLfasCE6/dy1WflowTBtfgGR4se93XpSQv9WZC+?=
 =?us-ascii?Q?pyii4qLG28xsCrDojJ+Bfe7HzBDj/iVeKFKwf31Ks3chJozerHDrwM7UlTZR?=
 =?us-ascii?Q?Ap2hlKUW3/9o/ANYEvHxAb0nLjfXqrAVK8/EOdNG4bUBi4dDHxngjEDAR97U?=
 =?us-ascii?Q?cftUFZnoPdISxnUOiUS2xPXN6Iw72WmbVjk2iWaEYsP3bI/QKETZkv6OZQML?=
 =?us-ascii?Q?8DH92mEy7MRV+ylGNTQtkO6RBPmgWeX6x+5Shm2Wp4MGpbQwX3fHwrBLJTK3?=
 =?us-ascii?Q?KZ9Tw9fGC5vQ+uxckHLMmposJdqdaz0uS1R2wwAS9WTfMTo9KSl3lDUhgBM5?=
 =?us-ascii?Q?0XIk9O/dryCJrvlhCupgEJgf3fPON+XLBUcX3tFPV/ipfl4Bu0HrMYkvOG+r?=
 =?us-ascii?Q?DBNyo69L1LWeyv4PRNOULX8/plqjiEJQl+7giPbGIkG5tWx4KVZ6PLLHre+V?=
 =?us-ascii?Q?p+/hffptwXdEnbYwtfIEf+SJiPNOypD046VngO6sAZVFNfkyYOAHiJkufLZR?=
 =?us-ascii?Q?jf5WQe61Jy2OUyvWwNqftU/oWRLZdKLMS6x1dzKrQrAY9y4zv/RYacM/GGOw?=
 =?us-ascii?Q?YqHV5qS57y7OgG3JbBNQX7gvSPR8Uj/4rRSnHn4xnHdCjWG2nGEsunUNgrDx?=
 =?us-ascii?Q?n5X+OxZ9PNnU1ZegOMxbMamhJIGx7AXe0xPec6YLZ3zFJFjN/YLIR7wQsywE?=
 =?us-ascii?Q?GtGwTDwjDYWrS5ScJN4Njrf+iwY3BOGr8oyF5WnXzJpjYSrWWVPxLBjNYi0T?=
 =?us-ascii?Q?N4gfnW0JW8DXICWEOIH6EaiwZ6DKcRcHHZa5AP3SwwBx+TL8OymPMHiTrmRC?=
 =?us-ascii?Q?U1pr27SjILFEF/3a30FJGjZP8IECdFt/puNniwE2LbBXwwY/Xc0tf39AHckX?=
 =?us-ascii?Q?piC6loc9O9PBlPU9rDVRqK+t9Cqwq1AvdJh4PV0buZxMLHjHrogOEL6dpZ/u?=
 =?us-ascii?Q?jGUKIHpK7xM+oE9YleYMZ8CZEKgdqtk9QT1s/Ztmeeu4vK+ekqkEvwyHoITj?=
 =?us-ascii?Q?aeWDYMkJaopNckI9jHYO9b03dwcdRu1dhKi67FuNGn5xsI4W49dC3bjlb1n/?=
 =?us-ascii?Q?kg88AqnOHsG7L2f9ZyqA3zNoBKPdeZZVL4GgCdiRp+u2c6TnZuHpFlgL8wMn?=
 =?us-ascii?Q?58vMFbkZO0IHcpvaSaUf8FM72kVTsfbokrSAYSrmm12kIMj5d1GOiD0L+fGW?=
 =?us-ascii?Q?lMfLEOp5vt5y2AcwZLExTQdKudDbz/4GuRsTvwmz7EwMA1z4qTzPRpppSJlQ?=
 =?us-ascii?Q?HV8Po8QRo9kyLra3xACdGhoUT+pMYQsSgiX4FqzG3USz8oZUWw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K4p8aLFi9Z2D6bA8TzzRlrtcbmRmAPngZRIWp62GNzzfSPdYC9xnz6HQPvzA?=
 =?us-ascii?Q?4Y3bjkotPqlpO58Nt3FqEZei7t232eg66lQrtZY9QMaGjbjGr0mHfWSUIpRu?=
 =?us-ascii?Q?FhevZZw4DoRAftlwVfgo9R2XATun2CZsPAojiTJQkhfeNkf0XlM8rR5krtNY?=
 =?us-ascii?Q?+Rl7LEHd49JAT2xppgIDvkZjNiAFTE5MdTcfWfk91GmYNNgMGiUmJgkUtEQ6?=
 =?us-ascii?Q?dF1+9RaB6FnmuH02QSDxzsOrZk9jJmr+Npyobfi+UJlb7Sj/OdQkNi82mV1u?=
 =?us-ascii?Q?U2HqD0fdvZUo5zafneAxMIivBjMKNim7p3tFoSDu3PnulKmtqpCjkJglAwKq?=
 =?us-ascii?Q?x/gJ5eRxy4nz+JSdy3nPHAzL4eXIlEJIhP9H9+WGtqJvr5rVt9gs+IvEH/Ad?=
 =?us-ascii?Q?zLJqnnEt1tsaqGJiS6ZbjTXn21EP2hqvIWA2I7h+giXx3rFVHpnNXoNsryhi?=
 =?us-ascii?Q?3Pf9Krv42H2kzTHBrgrpY5G6+UqAls3nxYZCmXvBW+A9rLZY3cUg9tmWXIEV?=
 =?us-ascii?Q?SVOPHkn8U4GihlIR9tUmX39BUAm81RpcAF7yu+Hj2HD01e8z9QFoeXHEQTGe?=
 =?us-ascii?Q?puWevlCF+2hSPQjnSh3EeANT9+Ro4hDXNsT4HgB7Bt6c+GMaqLrbRIJHy1kT?=
 =?us-ascii?Q?0tvXleW1MKRiBKNJP3CkI69MR7pm2UDvDw2naEZ1Nshku5S6J9+SjPX3LioT?=
 =?us-ascii?Q?c/FlUG/eEK8aHHYW4bm9JyBl9S2HpFnDHfjZ6m0dgkb4IgAthUINhudsJ8IF?=
 =?us-ascii?Q?2bzsLNIzCy6YJLDsr0dcTNSwUH3aczT2r/K3BGiVcZSug6Pj2He6cZn59Thg?=
 =?us-ascii?Q?1oUfEETuv0UaE2aQzWfhP6Mq5djms8ZDhseMc7Fc9LvHeCHAJJV9ooDqaw59?=
 =?us-ascii?Q?N39yAeUcXCSnzW/5AAFLRAwU41WjxiSCFkaT47ICJQh2YjsezzQFnIJYu915?=
 =?us-ascii?Q?f9r5oT39kwKb77YjMYtitrNiBB1FeE4mxYyJPRNsfbHmA+axq8BeFcXiwPU2?=
 =?us-ascii?Q?zaFKike9IIZERn2tbWn/qkk4kE8DpVZu/fT8KqqGnyDQYS6JIlhWELMEbRWb?=
 =?us-ascii?Q?yZvVZDODqRjOr5UDJmR7lAfuuBpYC07+sI39qJXWkBOiS9jkxSIOW+tLiW9a?=
 =?us-ascii?Q?T3XqirjFMKfBHfR3+Vck9V6GYk7yoMwMKqmAHLGdfsjAOEdbO/AjADOatSN+?=
 =?us-ascii?Q?NdsXpcREGPG/ngR+o4rHHgbcxtFYV/YyktMVfewl7bz8a4Lg+VHLEfVGINJO?=
 =?us-ascii?Q?JplMnlFmL7fdLhX3S4aox7NTHpoKUcUDA1sUMti74wLDSjb3IRoBHWJbeqB9?=
 =?us-ascii?Q?Ak/zO3VtRQgOOyhbVoQPLAEY8c8+TZbh5NNGsRa7sMve+R+jZcchc5LNBuF4?=
 =?us-ascii?Q?UjkmlIDCGj5pWvJChNM9jRVN+NiAK0nDLMAqSK/aCrKIh77Kb/lZI8oO4FmQ?=
 =?us-ascii?Q?Meepa45aMlOWUTPqvA1TLsdofVzCuJP9QlNy3al8pdc6iw4H7TGjpCcc3HHC?=
 =?us-ascii?Q?Jg0kVy77Ygu04AoR7UJKSaexR2qKGtS9t9+dbozDWRb3SLQE+yYcO3ajJTXA?=
 =?us-ascii?Q?odCExI4zmE6YyiCqbl0P1dSO7sBiIOu9IE+unLKu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a414adc-34cd-48d2-43da-08dca66dd7ef
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 14:36:28.5141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQYd34Zq/ohzLmscjTdBSqN+v421UkM/N4w58qCTW86lmQVLJTxe+2rcpFYWCHGNluRW7gXjG9zFqfIC/S9AlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7015

On Wed, Jul 17, 2024 at 03:50:26PM +0200, Alexander Stein wrote:
> Align the closing brace to opening line.
> 
> Fixes: 1db044b25d2e ("arm64: dts: imx8dxl: add adc0 support")
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
> index 3f521441faf7e..1ee9496c988c5 100644
> --- a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
> @@ -370,7 +370,7 @@ adc0: adc@5a880000 {
>  		assigned-clock-rates = <24000000>;
>  		power-domains = <&pd IMX_SC_R_ADC_0>;
>  		status = "disabled";
> -	 };
> +	};
>  
>  	adc1: adc@5a890000 {
>  		compatible = "nxp,imx8qxp-adc";
> -- 
> 2.34.1
> 

