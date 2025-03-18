Return-Path: <linux-kernel+bounces-566231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9DBA6753E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 334461888CA9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CA220C02F;
	Tue, 18 Mar 2025 13:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LMKcLY8l"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011022.outbound.protection.outlook.com [52.101.70.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2461C1A3159
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742304869; cv=fail; b=b9yehP0Qvkr2iQZ8e0h+dz1PBMiEDksokhKsw7v1J8ppGdWILCisW9wjNAxqVTEB7ux90a5f1dnmbiGEKEz8l0qgXZfdaOY6IIhQVGq5i3mvWFsMrl4X5A8e+FNfNYC7nrHiGPhlSxwSwpBNJJpNPg3T+t2ffivAj1FW28OOiig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742304869; c=relaxed/simple;
	bh=pb5IstEe9cvATmUC79nLRHM2OLJlGASzS5Lo+9q/rPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gwqvzhGjbtZZ9nB5y+dRPJ7fors7BuRYtB9iE8KBAdQz0p1DpjgXQ59V5N+epmc9FT2nfBAaAWWKYl64L/n8V5F2KGIL2oY8Izm9az2xylKTy1xgEpF9I0eOT/g8mQV6bu1zq7fJJEwuxkj7v8eCUx8HWkWcYWKsLJwzoWVbtME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LMKcLY8l; arc=fail smtp.client-ip=52.101.70.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4k9gZNjow4iKwZa7fJ4DGtFoPfRI7jbrebcNDQe45VSNF17ruISSoToZnajr1VMHVig2Wd4LfA69foQAWz+ZIGD47zgrkBITeGsAAudP7qfcNEcGAhenQxhIOHD/20wGzjawo5EBh19E5f7yIEbJADMA7NAiWe1fhrzuUpQl5nTFPXJqL1JoILgY9CH7+DuJw+iNnXUYZIh8vZfWjyAnmWXUJ+bEXzyGpdu/2rLVXCUsR1mtRu2lQ7RPoVQ0TPu8OgIACJHz4LUxqLe37BnKEBzIc0cV9fVEZjWnWWkkSPw+9AR2catMUOWiLCn22U3itgDEznQ3nSW8G/evYXnjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbQftePHNcCeXQzE5z6Vcoa3tcZaDPldwTuCjqs8Jy4=;
 b=reAmLivlxToNRVQrJ5dnpmNvAvyqECXU5Xk9Vfu/NMxAkPRJFG1wC3z3jviIxENiYbmynM4OnIPExDPSMPKzo2wv6O8T9u9pf5JNqWDDltgt50Gu8yPTOkOU1nD3rC6LuvSX+u0MQgKuIyE8SNpl39M0Q9T05JzjiC+mTnuQZ2hjWyr4RpXvbvR5fuMdhwqqGbVD4xEQZykB+rR6ECQ1YQ98Tq/nT0VUYswSWok9Xd0iAdFWMqC+rdhAYhCQun9Glx+vj4pLB8Pf6uGe9aIZKRFmw3uU8pnLnCnaiJ0iYgIxcg6JBEtODD8I1S8yLaZ8hQOaBqqNARvBJX4KyG4vog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbQftePHNcCeXQzE5z6Vcoa3tcZaDPldwTuCjqs8Jy4=;
 b=LMKcLY8lgEosn50J5KvtUiI4rciOR2wBq0H/w05dg3rAb7NpppBlcN/oFPDGbPLNiDkDQ7WA4XDGfux4a/GrIwEtrGdwRPZueEVJ7Sv3di+2txSBKR9gqWJRYtkqlirYVYncsO1Up+hTtsI7fgqxomhrwQL9h9G5nLUelkRayB1Cus5O+LPJMQdyAWiEXOII0FqE8R0KZa7IkvXuGQNllHoc0ak4jpNTxdbgeGa3YRVU1Gy3R9PC3r/G92ZyrUVif2pMdEV8EPJMyGJpjGRQSOog/YVVeagWyGUfpmGwef4gVbhc1VYuOUIqXvH6iT46A4MEbJ0PuzHobIBpCP2qzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAWPR04MB10030.eurprd04.prod.outlook.com (2603:10a6:102:387::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 13:34:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 13:34:19 +0000
Date: Tue, 18 Mar 2025 09:34:11 -0400
From: Frank Li <Frank.li@nxp.com>
To: Stanley Chu <stanley.chuys@gmail.com>
Cc: miquel.raynal@bootlin.com, alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	tomer.maimon@nuvoton.com, kwliu@nuvoton.com, yschu@nuvoton.com,
	stable@kernel.org
Subject: Re: [PATCH v2 2/3] i3c: master: svc: Use readsb helper for reading
 MDB
Message-ID: <Z9l2U0lG28KlxPzX@lizhi-Precision-Tower-5810>
References: <20250318053606.3087121-1-yschu@nuvoton.com>
 <20250318053606.3087121-3-yschu@nuvoton.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318053606.3087121-3-yschu@nuvoton.com>
X-ClientProxiedBy: SJ0PR13CA0185.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAWPR04MB10030:EE_
X-MS-Office365-Filtering-Correlation-Id: 97429123-8a2b-4dad-5568-08dd66219616
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dWyMw4G0ULEXSeIc9UUie/Q+8rp/2PtPeCafkpq267Nnn/jrFCdxcGI6UWbp?=
 =?us-ascii?Q?XHwO6K6WlXj0R3Gpa+by0/WufhHGSEZForGm8jD4G/UMzCOtdhLoK3RO4vLh?=
 =?us-ascii?Q?x91yiixwxuQria7QBHhX4/dX99pn/u+JDfyCXqMHCq5zf+DaAjfBJC2FaS4s?=
 =?us-ascii?Q?2rKiMRs9yoBTpcL6kWfVy1Wj0qAY5+AMxtcjlxCfS4vA95cRn/IgCiNQqq9N?=
 =?us-ascii?Q?1FX3qwVWbqr1oxM/kYknZYWFJorcreQ3KOvtnDUa0wxW1tLjpIObywTZgnMr?=
 =?us-ascii?Q?evEOnvLK1WbZ6ZYA2KdS8sWWqRMUFqCuZipzSaH+0WZSd8q7+5WZT7C2V74T?=
 =?us-ascii?Q?lu9Ma+1hDOqD2leYSqIdnpd+y0jLaPQY4ccd2qlWGkcT2ZnGkRosvHLq96Wn?=
 =?us-ascii?Q?lfPEVBC90PZ2xAIlpviORwLo/rnHG3A3h9iM6Au16KaEUBHMVG+lX2db/jjx?=
 =?us-ascii?Q?43TCmCfR0pRQiCy/obCWon4Z+/Yeu5vM2cJjqZWkL0Pvlicnxyt9TrBEtRxA?=
 =?us-ascii?Q?4bx8vC8td/Fv3Ub/BlkUx0I2zn0cYCFaLcCifZ+J6/70mCgzdyjD+ftwv6L5?=
 =?us-ascii?Q?Ar24Nw/hTF7v5eWzL6c3ICsmJPwaaKrDtPrpeDCS1G6nwUQg8Vr/tN/82t3Q?=
 =?us-ascii?Q?ZOfNYcMHoDhJ7+Lr0tULVkk4+GgYGFRy5tHu3hEpVoelDGC2aFSi02n+Kgzt?=
 =?us-ascii?Q?pTk9Z60ZyoKF7zFItxap106eZfifeBbqnL59El52IbdL875+In7j+nRM7oD0?=
 =?us-ascii?Q?Vt1FmLkdNfH/eFHhJ6EdBlqWBnR6A/H++uq1raO5L7LNLZS46MH2wBljRHAZ?=
 =?us-ascii?Q?huQwFQw7JWZlAXPxUUIbGDdichK0EK4iejF7FhC09QvdT3hBqWa37Guo9sT4?=
 =?us-ascii?Q?EO8MJRdfC34Q/nhX/vtsRm5p+rB0dUkEtovojBYgGf0LX7ZLFvR87VaKz7fb?=
 =?us-ascii?Q?WXnRWSlgGMZ/+0q49bhyHpXAdUmlefLvjFZ7OKQoY3YAmtKZ4itYawWhKyi5?=
 =?us-ascii?Q?e3nxujI4YNOqicFiZ1vEV6ThPp+xfG2hg6u9X6IGeHkJ0yqqgC8D+ztq9THS?=
 =?us-ascii?Q?EEzTCEEY099hDFO79RR6tu7WadJ9RzCXmr/9KsNAgbQaVQwqxv/Bum+0vOpT?=
 =?us-ascii?Q?K7kz4DZ7GmrlHMEvYHxvZXvTTrUNLKjqN0s0dQ9JwYYmoKtSE+YCahH+RQ75?=
 =?us-ascii?Q?+npcJD8RRiSbczNkEwTZ16BDxbVzzhMd2zDQalJ69YrEyboU1wNf+UpMk/9t?=
 =?us-ascii?Q?YhD2yJkPKDn6DRbaE92i/ERiUkILzXuNYOERbOflybiUHthdMqda4YsLJ0xa?=
 =?us-ascii?Q?gR03GeT1hMPI8xprJIsXg9Xm/qOPRmKleHiLorwu0HhQUb4aHqaGJrxaTust?=
 =?us-ascii?Q?O0Te7qb8THiipDYromW3aGObG2bxrsBC1a2th31spuMJcLQiJ2sr/gS/7mc7?=
 =?us-ascii?Q?vHFLAgBVOTXyrOeQsNAcOqyRKG7RZUtG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CnwjoLciY8KraI1l97kE3FMPcRyWfJXPpkqWKO4466++/fZIPoaWrVWz4h8M?=
 =?us-ascii?Q?IJ+0sfTJJ+B6DWfnj/HsyIe8qdDq62EVdCHZezr6avqur6WZD7hMTIy3wnON?=
 =?us-ascii?Q?72To+yO9GcvV/2tmUhgXgDvyNAiXWm6W/7N3WB+aQzsv5xcgATG9EsNgrBWo?=
 =?us-ascii?Q?J17zvpY2xvPe7a3TR4TbHvldmhRts+RfShcg93P0YTH9yob309Kv417/EH3Y?=
 =?us-ascii?Q?ruWkbl28G4fhTlIutm2x+kHnLdFO46lZ95884e8BkgjwicPRWzxu+dc2cQvR?=
 =?us-ascii?Q?ZAblHuzGZ8NyXOavISS28Ux/O1UoJvf3KMipDLiWwXXA7ZtPeZ/Uc9Lr61BH?=
 =?us-ascii?Q?660LZ5K/3ff3nl5SarjGjUjql+8kX4fZM461GnHbMvMcmOhcdDQjO6uYEOjC?=
 =?us-ascii?Q?v4zu6YnGzfl40MJYqisNWUNP/Mbv0Lp1gloGK2KJfQNBcTrFaT457/+viAMQ?=
 =?us-ascii?Q?FpZZcJ8ud9L+6AMpQDeyDyKocW94OrxT6aGmzt5Tr6vADe1vNTiBHU1IT9k1?=
 =?us-ascii?Q?f+fPNsT/WDKajXSFIuRSk0cxxZM8MlDXvOi/SZD/wEBMIQ/gmeqBdZy2LwHL?=
 =?us-ascii?Q?uuHuM9j1MnxzLli8WJe3qYQuzgPsmt9WiD16KkUn9Hb03m9OU2GZT58JYZr9?=
 =?us-ascii?Q?Va3pmRqPvmuAzC2zMXmcF/0VVJffmbY5eyrNed4T7FXFA5mkqvmvCPLy5W8q?=
 =?us-ascii?Q?VjnY8L+OvRBOj7MJMaP/szdqgfF8//y6kh7UdHh3E45pn3WLEpr9BGnx/Nab?=
 =?us-ascii?Q?zSCpncbwhvnwsvMII69OourTdpzphtj7J87RNfAeHwSzTJckAcPK7zXfg7D0?=
 =?us-ascii?Q?WN600EK7EgJkFdLc1PlgRjyxOnmy5IyO0Y9m1bdHOjwBMRR5127vCP3aTLj9?=
 =?us-ascii?Q?+NoPuxpoq2mWVRPpTcawwHMtkE6I8W2WUPjeoWid2dD+ObZbZA9PQ7oX2jT5?=
 =?us-ascii?Q?WbgeQrVngtqjGdOxdQZlt+rF11ueNVrmbz8pwLs2Grw00bIX31BHaq+Wmd16?=
 =?us-ascii?Q?ECh7YJ2k5Q5fIPHp+g31YoAuWKsPYsQFWW3db1fTznYwoV3zSj63qcG0pPzx?=
 =?us-ascii?Q?uRKW0d8lDHXZi/6s67EUThud3anXfaMQeYQmJXU7bJurBoLQZ7x+S0WrQsuk?=
 =?us-ascii?Q?+ujx+h7oUu05j3eqm3hLQ1ZEaaHZtxVHc4kJpcfh85zmXqNkjIX3oEBwt2a2?=
 =?us-ascii?Q?4qt3XhxvziDyw+/D+RBc0MdtxHYKovs4fpfWprrcGUCAt2x28qL7zpPx4TxW?=
 =?us-ascii?Q?E/kCrlV7aOw5Wt8y+jJ2iEROYjy/7Eq4PUZw4LNc9N8pwWnqtUCXFd3OvXNO?=
 =?us-ascii?Q?nFS/G5XpFAgpkcg+xT2eHwYG7861ceieqdK1AUrK2NXu1EQi/LXBpXU8B2VZ?=
 =?us-ascii?Q?omTlomiKZYx9i4AsirwEFNCUsOpDRzF5f0z70GSQms9HwLWmML6HxGcH4r3n?=
 =?us-ascii?Q?Pbx8MC5/m/q1cNKUR8Qz3hfW83z1opZXl8xHdE3GTNkOp8AsWb30LXWuMUXE?=
 =?us-ascii?Q?aQcHAxcCIBFnYvKs+zyCfypjaMN2LM62C4sOvJa4GE2HR/qdlMEkmdzncAsE?=
 =?us-ascii?Q?MRrkCu/Jj9MYIwQZCfIDhTjNSz/7zYLTOxYpYlnF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97429123-8a2b-4dad-5568-08dd66219616
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 13:34:19.6264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tRkoPiJbMoY4tvmFYcT2va1mcmqGUQ8T1gl8LJKfQTMG168EJkO8iJaJUgH7DXjNn6HVewb0RsLgEfYRwUsAZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10030

On Tue, Mar 18, 2025 at 01:36:05PM +0800, Stanley Chu wrote:
> From: Stanley Chu <yschu@nuvoton.com>
>
> The target can send the MDB byte followed by additional data bytes.
> The readl on MRDATAB reads one actual byte, but the readsl advances
> the destination pointer by 4 bytes. This causes the subsequent payload
> to be copied to wrong position in the destination buffer.
>
> Cc: stable@kernel.org
> Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
> Signed-off-by: Stanley Chu <yschu@nuvoton.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/i3c/master/svc-i3c-master.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index a72ba5a7edd4..57b9dec6b5a8 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -425,7 +425,7 @@ static int svc_i3c_master_handle_ibi(struct svc_i3c_master *master,
>  	       slot->len < SVC_I3C_FIFO_SIZE) {
>  		mdatactrl = readl(master->regs + SVC_I3C_MDATACTRL);
>  		count = SVC_I3C_MDATACTRL_RXCOUNT(mdatactrl);
> -		readsl(master->regs + SVC_I3C_MRDATAB, buf, count);
> +		readsb(master->regs + SVC_I3C_MRDATAB, buf, count);
>  		slot->len += count;
>  		buf += count;
>  	}
> --
> 2.34.1
>

