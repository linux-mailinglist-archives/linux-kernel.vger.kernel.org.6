Return-Path: <linux-kernel+bounces-568741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0AFA69A02
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2E71651A5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B83214814;
	Wed, 19 Mar 2025 20:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b="sCzUzvFu"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2120.outbound.protection.outlook.com [40.107.94.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31271A072A;
	Wed, 19 Mar 2025 20:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742414898; cv=fail; b=ERcv6tASi3ydaT8lJskK7DTN7P0khsxz0E2sIBsDKAV1Tkv6AMcqR46MedBA2Q36KyDxpgo7n0fHVIJFrY+GVRJYYwc3ACVlj8i5xL9pqtciRlmDWtf4LZjPVhITBW3mmfnnWp5WzXadMUdt8hPn0KoYVRZeGLWPuViBpxmUfg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742414898; c=relaxed/simple;
	bh=nSUqU2fzSiubt7VOI4QLeuucGVmvPJeaQXMS8yZKezo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IkQt/AHvCkMr4OnneKtEF9YE7lv7pSmNqcniXrT/HjRYF0wcxzzbtq2eu6Bjx55i3fNDHubpFSsB/OxR9ZhvyJrkPBGeMzlg86+8VvVS3zH9UPaWJLE+YZ594OGE9+V84sA3Enrr/MpjTdU0CPzthJYS4N5TsVQsxUuwyOhIdPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com; spf=pass smtp.mailfrom=in-advantage.com; dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b=sCzUzvFu; arc=fail smtp.client-ip=40.107.94.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in-advantage.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fvi4WKhBZbYLtV6VOVvmcoyr0hqcSaPx4L7CzQTy7Q4+cWHaENGTuH1NWIG6fYZIeuVt9S8q54sqG4V9fWerk7nIb2C1NDxxJGcro//F8ZNMymPXF2PKh0MikofMkGDUZ6Iz1XrNH4VEk5o5c1TBIn9wtcfcLZkXqPTVYKlWNJI7AG84ElECwPcA0XnRWBGt57OhmR2cR/rcJJNZ2pEMcpmvyS+YPEajCNohG6zGQrzTFyzrxMRocjK1GMfb/nnrItWIL5VOM8UJP4J+VzsBMjjubi7XHG8g7pXIJW6qNiDtB1IhaJ81tw+QoFMfJLZv5QsWV/9XR0BxoeUe5eJBQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAHSiqcaL/ursgkHtKpDz5hoiFVhSSrR89bkujQySRA=;
 b=FLxZrxHPDZgfnOtlby8nyvNc/tEwbk77kQH3YJDe38WmZoo7LaCkatNBrtER77Lj1/NTQ8U5z6Z2ynJSjvEacjGF/IFjVJBA2Bz0yD0t5fBaY1Mthdz6jP/PfJcDlrZoSD3sCTerGWfxy/WO6tf99QqifcK1C7YCep2Thou6RYEfQyE8/7xy/O4blB7SKzIa1eIcbwwRdhoeUeLyIxmsnwdVR93E0A6wE6OTg8d8ZeaGouZFgZwtB7L/A06LK583/K2dxrbkLBGmWXL1bFZiuRt18zuS26gmu0dG8MQA+Ocnluww3jXxUWQkpmbYAII1kWTXNr6RDBqpCACEkuM/Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YAHSiqcaL/ursgkHtKpDz5hoiFVhSSrR89bkujQySRA=;
 b=sCzUzvFuVXptDNaWrRYj31J0OgSoiUetnTOal4PRABrgk2O6No3NxLvB9ehf8POfZKC7M6kXTagt84vXdHyIF+8ERvL12zOzigjAKg1pUBldnrPDe6FRV52Q6EQt+cN6YwyXeYyjF1Mq4q0YyEpPpv67XAu/wttX2j8PJ2IUgfw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from DS0PR10MB6974.namprd10.prod.outlook.com (2603:10b6:8:148::12)
 by DM4PR10MB6037.namprd10.prod.outlook.com (2603:10b6:8:bb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.34; Wed, 19 Mar 2025 20:08:13 +0000
Received: from DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::7603:d234:e4ab:3fea]) by DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::7603:d234:e4ab:3fea%6]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 20:08:13 +0000
Date: Wed, 19 Mar 2025 15:08:09 -0500
From: Colin Foster <colin.foster@in-advantage.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Felix Blix Everberg <felix.blix@prevas.dk>
Subject: Re: [PATCH 1/8] mfd: ocelot: refactor bus-specific regmap
 initialization
Message-ID: <Z9skKTf30m9DVaC5@colin-ia-desktop>
References: <20250319123058.452202-1-ravi@prevas.dk>
 <20250319123058.452202-2-ravi@prevas.dk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319123058.452202-2-ravi@prevas.dk>
X-ClientProxiedBy: BL1PR13CA0128.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::13) To DS0PR10MB6974.namprd10.prod.outlook.com
 (2603:10b6:8:148::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6974:EE_|DM4PR10MB6037:EE_
X-MS-Office365-Filtering-Correlation-Id: 67b6f601-25ec-4cb3-46f0-08dd6721c737
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IQLUZpa521CeAyWZiRubdIflsUPT/LhPXKwARnKypeClUDilu+94k+Q6TOWz?=
 =?us-ascii?Q?uninc2AS+CbxmUsDBKc+I+iC5B6bq9SrE4Qxdu8b1BKTLBf8Z55JF6cNGwcp?=
 =?us-ascii?Q?CTAHKcGZYK3H30Jj0rIs/y0eu2bdWlba+yYY/Z6tXg1WzuR9tLjxErslsmAy?=
 =?us-ascii?Q?36C3/uANLMgbVkmitAoqhS3hLcEO/9yK/sF53QewRV7+qMf7xuSDfB5Jb9tF?=
 =?us-ascii?Q?EIWmFXakbU+CC/OCLtkntkw53+byJpTXnb+DWX7jZeQxiPzrR/8+a60vbZhi?=
 =?us-ascii?Q?C1fgkywrveMODBKVMGI52a/UA0w2TkWup/BbkAF5/Ug3wj1W0CjerL3Z0Pwt?=
 =?us-ascii?Q?2DmPd7l/4jSfblS5XIa9RQwfFrcB6tqD88D+nBBBsTaYId+ULRjPkTO081M1?=
 =?us-ascii?Q?luH9rbX3km9zGXG3OZRLiZtoJaq9tH6mQbnBDQjwR2sZDZI1jXyu+urBU5iu?=
 =?us-ascii?Q?jwrjYPg2Vq4ijyAdaEje1/MdCVuqZn+SeYOWXwOkwgPekao4DSbQDGITFuZt?=
 =?us-ascii?Q?kLn6Q4OTrGXSqZ848ZqrBwrrqUxWGicSRUwZAS97lwJhkPxgk+FkThem/XCu?=
 =?us-ascii?Q?nNkzE7KTJCA8Wj/WNfeZCgCuiDepT6lc4CMzaNS3FwjBxcPCCzCEht29/xRC?=
 =?us-ascii?Q?zNsxfmv6JlJ+N5nImOBjac2+JwRCX9dMlxBvfHVAF+xpPSlYSBOX38xopSfy?=
 =?us-ascii?Q?M4LEhYEIgyb3bSOlhIdhyR0Wsqk3UG56aW/4KKjUTSwN9MhyBxX7xO4S9Qad?=
 =?us-ascii?Q?oe7XkZJHlPYHviqYUSW/tlye7dYFf+n7Tu53Rskmcy/7p5lS4w9r1Pp8n6Nf?=
 =?us-ascii?Q?dEpqoCExILdHeFRudFCIFq18ZvjG5zTUeDgu2Glk4zj5fnqax4n9S7ryoisE?=
 =?us-ascii?Q?qer4TQ/jJjtM64FKqHD26qiS8PejTzhm8yttKaXvj6QVdIS1w9Yc6ELDy1Q/?=
 =?us-ascii?Q?xGg6cwP3bfuJhKkP1YuItqaZ3ZzalF4H1lcuuvVnnkGaZ2q/uIjMiWHWVNIZ?=
 =?us-ascii?Q?auBHZD4AAzhBFjrJCT/gxsU2w+9aEYWbbXLH8OxaTszQcLbqVXf1qaMyRE1H?=
 =?us-ascii?Q?xgdw52QMuI/FjZRztJYbAv7Tyc67z6tcg71yaCsLd5+JTZY3N9YLiRs6FmVM?=
 =?us-ascii?Q?aLwxSUm6Af2Vx6um9kDMFXEGcFv71YNrbfQVnjoQs6nEnkMalmYLwG3IA4Ds?=
 =?us-ascii?Q?pKnb49JhXaLUOR0nWBOWhPFbXA2lj6NukW2w3RqEIf1o/Jkh/qH3d/eddBL8?=
 =?us-ascii?Q?oXH4+VVGwF+jQOidZXMwLl7L4ih6V3+PJjLr2a6/CoO//YQjvNtvlekIKAb3?=
 =?us-ascii?Q?sbiklJqhQsZWlfaTd608/cOKaFLMtXD2Lpng4Q44ZCnfy7KISWqBsO7aGuKg?=
 =?us-ascii?Q?yCf2QfTT44FWV3caV5MD2NIq3vqL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6974.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PERmQ+UjAl6SsSc8ZFavheSghOuqjIrlHcrzVlaqIEwX8eEPqFBcMupLeLcl?=
 =?us-ascii?Q?1Di6oAj1drEw7mboqMN7qiZqR3Km98yI+BIugoqOwuKINO2gHA6fxHq74j7n?=
 =?us-ascii?Q?k3yWlUQmoFk1rtRclJcaZabGTgQCcA/BeDM/UKitY5gtQ+DXJiuYJz39UNz7?=
 =?us-ascii?Q?osA1FecfsV+6c/tLflhVoRsHj2T9yvYWTgpIpQCis0uqs6rjCDErOSz8Ol1Z?=
 =?us-ascii?Q?DAPETdgeXLvaAKldzv/rSZHeOabzF7yTDMWN1Mn+AJsWXN/Q244CfdglsCZp?=
 =?us-ascii?Q?vKfKoVARFYMUhhX2vXFZKWsDqt5idQmJWoUufv+Ng9o21jkVNejIMf/kGeZx?=
 =?us-ascii?Q?ewo7W+te7NjjjibVLKDf1G92zvd1wvUWExyhIWPpzCs1Urw/vnJZl+rAXnrD?=
 =?us-ascii?Q?yhETNf1xSuNgulEPTaMYXdB3pqEaFYAXy+TzqKeVmgD1plpAjn3lBsQ1UVsz?=
 =?us-ascii?Q?YSk4LagNccplHtakYRki9sKlqv9UFYtkskymEJF90RZFP4a8BEzS/q2Xokx7?=
 =?us-ascii?Q?dv+10X6uhQpTp9SAHSPhOffrCXE6udTyV5DNF9DfCKfzyjtPjbwWX1O0prB9?=
 =?us-ascii?Q?Iy1IbW+rdilLcoFZ6LqjzoaELus2xDsVAhQLQiDusoumBFOXovU6qVpxhzdx?=
 =?us-ascii?Q?PyTh/lnmkrZOlOmDRTYBiqitLUPUUKv9DE5LrNgqbiatu2vudTsXas5xcoi8?=
 =?us-ascii?Q?npZ+dPjjDyPOlW2STPTewAqaX50pRERQtBoDDbdafG0X9u1FhUZxkjp5ESmY?=
 =?us-ascii?Q?nXd5Zt1zO9k/swE6wPh+mIwfJLnSRy2UHrWRXnO23/7A8wUT6KLw6bbjIF7g?=
 =?us-ascii?Q?IgtDKBtvKYdpY8v6o3TCsuPMEvaki6zYmV9C1yRt/eDcjpNp6quIV8gjWZQu?=
 =?us-ascii?Q?8GWc4X0IUF0AZK1EIoVQfL+T09zOAz1PhcXDthKnsIZBH5SolRs+G2is0eLA?=
 =?us-ascii?Q?MIYeuQ3Ye+eY/PoiK5cG+uo52pahsL91PjJHoHom/nHxPlnDYNIgFxIFTsXW?=
 =?us-ascii?Q?pWn9Dra6l4NzTAPl1ClSz7c35bkFqlZjFyVUB3kW9Ik8L1JpP881KpS5JOUO?=
 =?us-ascii?Q?yLVubLWAQuHSh2qk1GYOqrVRvu1NrfAf2MMS0VYKHvPv3Q7edX/ahIejhqSz?=
 =?us-ascii?Q?hg9aWBHpYHAs/h23GHdHAXerd38atsGLRIOyT0hCNxYgZ6B9ssic/Mh4nXrt?=
 =?us-ascii?Q?/Cbd0wEAKDgeuOfeQ16U68qJDjU4gf5IPsxjrEbPUR0bLBE8fwEX7E9T5WqH?=
 =?us-ascii?Q?3wqriGGx8t17BJo4uuaFtNuGqO/uJ0aSWMGsAe8Gb0f+nEXFZ+5Z5AmP4vpP?=
 =?us-ascii?Q?QU8svEGAinDhl1vXUKpVhSmkWyr3ets38eN4u3n7y1jwmDsjAQ5TUAILQ4Ix?=
 =?us-ascii?Q?/Z2vDeFjDXd0d3rpTOOp+BrlDRyyvsCTQ71ErtqRh+KdD/1XO/914XQ0wK+N?=
 =?us-ascii?Q?/fPkpOsq+1rhMjuRrcq7w6VY0DrpTLNbsObhKDVKUePmSQdHdVcyv2T0SbRK?=
 =?us-ascii?Q?s+5TvqdOuXbGywMgJgMLAIe6afil9gb0ySr1aKeKP5OGyH1KPCO1lQNlRCYs?=
 =?us-ascii?Q?WcvehZEVbV6AVK1pOBvdib5dDU6vblarI26xn9XEWuXh3X6duyTuM9h8vwk1?=
 =?us-ascii?Q?28VvCRCm1KA+cRkMM+LK5FA=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b6f601-25ec-4cb3-46f0-08dd6721c737
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6974.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 20:08:13.2205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zwJZeiSkJyov8vu8MfRMrgjhFzt19pg8jK//OC7H8mVSjZ1IXsix/7cu/S+3nm6cXaLwuS19a9jasF5BN7iB4nuM8gytdMHPg9xNRNAd8CM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6037

On Wed, Mar 19, 2025 at 01:30:51PM +0100, Rasmus Villemoes wrote:
> diff --git a/drivers/mfd/ocelot-core.c b/drivers/mfd/ocelot-core.c
> index 41aff27088548..78b5fe15efdd2 100644
> --- a/drivers/mfd/ocelot-core.c
> +++ b/drivers/mfd/ocelot-core.c
> @@ -200,10 +200,12 @@ static const struct mfd_cell vsc7512_devs[] = {
>  static void ocelot_core_try_add_regmap(struct device *dev,
>                                        const struct resource *res)
>  {
> +       struct ocelot_ddata *ddata = dev_get_drvdata(dev);
> +
>         if (dev_get_regmap(dev, res->name))
>                 return;
> 
> -       ocelot_spi_init_regmap(dev, res);
> +       ddata->init_regmap(dev, res);

I remember changing this from function pointers to the direct function
call during initial development, per Lee's suggestion. I like it though,
and I'm glad to see multiple users now.

Reviewed-by: Colin Foster <colin.foster@in-advantage.com>
Tested-by: Colin Foster <colin.foster@in-advantage.com>

