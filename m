Return-Path: <linux-kernel+bounces-385133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CAB9B32E6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927851F22AA2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5837C1DE3DF;
	Mon, 28 Oct 2024 14:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="b5G3wPDM"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2080.outbound.protection.outlook.com [40.107.22.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3D31DE2D6
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 14:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730124660; cv=fail; b=jI3wEfFkF676iQTrNEDaMNH8gWaszTraUy2uR+fwv7K8hSk7kI0X9yQogstkMUKl7+8gqH173zzpZ+2MAx41z0WxqU+/S5cbc7qzqCscirIOdEdhvka0my5OmcJzR+og7+gcoVx24TbQHxTdcO0opeAAkca11XwZ2nRoJF34xxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730124660; c=relaxed/simple;
	bh=7yDdlr6W5WFN42r27WB813Ppg1AbvHGUvGhvxjQGs4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m8YpecxYHh1c+G+26v+g53vg9iZbtE1Rd4LBBNCMtqfNLSxmLdYMNqvJdlbWEF6xjNh8FVUoSVqRv65QQeFCyflLJJnpn4G51mLSwFMKwzPify7QtfIewkHF7Amq2YB0LE279TKK64uOVpzSL5pMPw0ZGT4oZ3l/aKcs8h/GTvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=b5G3wPDM; arc=fail smtp.client-ip=40.107.22.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3rZtsu0vQm+JWz4wafKCBuY238PC2GgeZ9fh58UwZ/cxvk8zC2u/Iyto0cNTy6pY7vF75mGKB36JgpQuBguaBI1y1x97NsoH4AJF/HufagQe1MjQT2LIHPj2I8qdcqAjHwQxMnRgx8QzNYjO5RRKfKim0MzMXZOwbjuqlysncyJOK1Voax/RTzLga3ududrhCZCz1Fm9x1IzprSdUWdPYr0ymiLWcwkfF3E46JEM6flRTk9fqwjK2zz8bY6H3hV+RmDJ4ZKM/zJTWblsR/A1nzWartB793xRI1c9WQ7bKy7qKKZ8cQfZr82aqeRz/Cvmu6+7RFQiyqaqAYeNoAR/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4IVus9xsml9D4vHOnQtodqZqDSuVIIYgWQydMTPe3A=;
 b=SXlQ0nVFYt2Vd+vhbswrjCGwPaTpaC4VQMxpdDib5fZ+G73y1MXXVNDDdgAcSU8NAXxkEZYIj9rI0DRgUusPG4vnVKN8VWApbRfKs87VhvDuFPW65cAgXgraZr/Ss+dA0IRb0AbgOsKmYUuK915dhKSXGH0GxSNdqHdUHHZk5Q+SCy/sgTiPJYbFGCnYYumBxnm2MNr5/2I7T4xFEFs8Bk09KLOD3T8N3SzOLpIY7s6uJWJ4PdKDdRewRvr6Ja7blcmW8cD4uWO3yMJ8ow7+tSpeM2lzPTzshSi4mPsCc+B6LTTydfu/qGG5yQyFC3vukzvkkvAtRiRXY5DSyj5QFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4IVus9xsml9D4vHOnQtodqZqDSuVIIYgWQydMTPe3A=;
 b=b5G3wPDMTh6Red9M7TzBSlAGUMx7ef9GxRAMmpXXmBSSshGLxJgnqpNomdgKyqYGCfpoGy0T9t8fZBpNH+GLjqXCTnprAi9ntUaLhgiV0Vv/vh/PDPAmsQaf6sHEPB6++KBw8v6M+h5Q+pf2zUSpqu3D+s5kZIGxDj8MgTzuGfjsSpYlY8hB3xWjiVu3HDnvW/gS4QJtKm+Y00860iSj5dDMU8vte15R6kkNzHCuyfCqclP46hsvmaD+neQm48a1lrt3CUg3PvCwU8MS67wHxFFWtDVl3yrojh97tJwZe9eYXLKuTS1Cpcjpu7QPN8ra0VktcMlttizJFwro5JaW0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DB9PR04MB9578.eurprd04.prod.outlook.com (2603:10a6:10:305::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 14:10:54 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 14:10:54 +0000
Date: Mon, 28 Oct 2024 16:10:51 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Breno Leitao <leitao@debian.org>
Cc: kernel test robot <lkp@intel.com>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: drivers/net/ethernet/freescale/dpaa/dpaa_eth.c:2745:24: sparse:
 sparse: cast to restricted __be32
Message-ID: <20241028141051.eoltcyf37lf5dsyp@skbuf>
References: <202410271721.jiVrriXD-lkp@intel.com>
 <20241028-sticky-refined-lionfish-b06c0c@leitao>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028-sticky-refined-lionfish-b06c0c@leitao>
X-ClientProxiedBy: VE1PR08CA0033.eurprd08.prod.outlook.com
 (2603:10a6:803:104::46) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DB9PR04MB9578:EE_
X-MS-Office365-Filtering-Correlation-Id: adc95475-1dad-4f35-31ed-08dcf75a55de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BmCrSaeE8gDYCw8B7MlqDM3sf50v3e68egkMsdi4HsKYiZIvxBai4x3kI1VK?=
 =?us-ascii?Q?NY/GvpHo98djCcwKSS0ZqcF3DTor8tuXdD4SmYBDmgq4BrTL0i7FChrSGvO0?=
 =?us-ascii?Q?LZWzTxo0dZE2zV6PxMxtAHSj+0fPxuTK/TDCmphLI6X7DwgOCzr81ZdJczaA?=
 =?us-ascii?Q?omD7R1RGWV++VLtQVbSH9tRuR5UXksIyDVewXx+c+V/D+yf+XJnbGLB6ROZ6?=
 =?us-ascii?Q?HSo1vDxjes163wWN25W5s3dmHM9tdmmg6V+s6Sh+ZTpzJSBUnMPXsk0KoZml?=
 =?us-ascii?Q?pv19230ta+iZ2eD014h8ts97lwD0Sf65qOkXDboictvafjN22RaWj73/DGB4?=
 =?us-ascii?Q?TG/j/Ze0o69GSJCgc3QlDAsy8EOjtvtLh3kxFHTusJqMYSY9UE05pH+reEzv?=
 =?us-ascii?Q?8R9t+huUKSvPdLLXo4C76XTjVbnA5h/Nhq1RvguzxVvZrRWG2ntvtvVMAVNI?=
 =?us-ascii?Q?vyxgtor6HoeaSZsvTov7P3vqTZG4KduEtiWHdOuWeoWc3kZP22V/5nRh7rYg?=
 =?us-ascii?Q?Dfk5JdaOOSTgpNjM6cpXzoHdbpYRd22WUC9h8IQZjf1sTZViIQ/a8qBzkxso?=
 =?us-ascii?Q?ZNFhjX1Omo6aJ80EOJ3NVc4yYYwOdut3Td7X7Y1Y3DVrEFHYg9u/AKbatIxO?=
 =?us-ascii?Q?A6eYEwl0t6jnddGZ4+7LQi9If94t/zhr32LsBPTxpRNM/0iWJB9gKCCV5Rtg?=
 =?us-ascii?Q?Pcun0BoyNOQEZHopFCf8xtqIkyLc+a1FQk9t/ODz5XkdlALtiNaCp6FCa6Xf?=
 =?us-ascii?Q?JJqIwk6MHQcSDD6k8AuWcNwaXy94vcL/i6x6tb+o5CYWDoOMr7doyXpBBhD3?=
 =?us-ascii?Q?xyNWvO6RmcC1KxaYIBkTWA4rTFQfxSE/5DwpKMaRe8dCZhknNmSfN5d4luSh?=
 =?us-ascii?Q?k0qg2ik2bATXA+07IsxR4FHowm6qW7kSUhk2E9RLRIARSs2VX9w5BhStTOGa?=
 =?us-ascii?Q?0n1VKSldVkNV+dEX0l8qf9BivNGO73jCDXDzr7MvSp5oFt67rvmo5pDNOVwR?=
 =?us-ascii?Q?KQQVkdTgiAKCthFm80ctgLoY93b5GcDzE/cz6lrTq7+I2FzwKUwO+yKZuzS0?=
 =?us-ascii?Q?JKOxh1V8GnJ6JdRzluDmBdLEWNI+4gBAalnMkXBPwK3TBfPW20MOPB5BDqmK?=
 =?us-ascii?Q?BPVpjhtoBV57TxgAOiD3m9/+2B6o8sqLDmjmgMisFO7GJHFtk96xwpaDshlg?=
 =?us-ascii?Q?B4m6Ab6syWwiNCA7TvhSZswvkGp1YClvYchstIh9TIJAI/pSnznlinSjUktT?=
 =?us-ascii?Q?GOAZBkOeVdBaamtOFJ7V?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2JA9FvnT9v5fbkej/ezArKrXo/YE8pUVg0JvQ9GHVx9MywPyjTTpskiK6zTk?=
 =?us-ascii?Q?XvTx3udVFmnHsY37tA3iW1bxcEygHJj+1EjL3s3IcVQSvaVOoUhqY7rLcKYQ?=
 =?us-ascii?Q?5QMThISCZOnpy/CRnwX7e/Wp3ddYgs0bB0bz+l6UxEnNsjEaJLOR+MWMtehF?=
 =?us-ascii?Q?rbJIJiOhoCu37nOXLIGhbWus//BqWR7qw8PsApF0EPcg/l1gd57A6ViTpB1n?=
 =?us-ascii?Q?5KQjZlG6Efj8AvZiNKvnBggtmolt/C9bzGbZU7eRGlT2u0Sm1of5wCpGSHCo?=
 =?us-ascii?Q?fBlDZm+OviwicWwJ2ngIms7UGaKFwzAtrUkttKvot5mt4y2/7hBXh0HO5y0z?=
 =?us-ascii?Q?V4qy3XftxnEYlPgcAmWSrpJjLDICelAFl+TfGV1PgPC1TXS39taKnRqOi6GS?=
 =?us-ascii?Q?0Qi8IJni4AN1GYVCnX9JGevzYAlq1gZarLKtbntldHU97aNRsyXkcr/7mzp1?=
 =?us-ascii?Q?c8Cp31W7jRXfoHxZe6LFB2AvxOkp/3QxvZ1kQiXyo0KtCK6KbfeFu06ERK+6?=
 =?us-ascii?Q?nTDqbyNjYN4SCmgE8fsYMVJBrAL4DQaIeK47MCMeoQHbbhMyPVNECz4cVgur?=
 =?us-ascii?Q?GlvRkhr0xUXRECPhm+7YcOpvQEZw/isffgO26/fJu4TELeNbY7k+GfbOpEtp?=
 =?us-ascii?Q?vIBwwWa8OwrvSBLQvJvCOm4Xsx9L6VEqyW/g+uZ9A0Eg3subRMH2hT0FlLTW?=
 =?us-ascii?Q?rACzrJBly+ekzkDwlsnAG7XvYJ12sqIgb3Ys8pc643syRQhR05q7MZ329tGN?=
 =?us-ascii?Q?RsGMokMWMo2pV3PeZaOxhJxhLNQJZSKWHg0hs7ZDfpxtoUQSfcY7mQsbfRBD?=
 =?us-ascii?Q?RsYNoLqjUDfsgskdqMq4gJcCsEgXG5sKhVMgAe40nUAPdfbEsrNyGa+MBB/r?=
 =?us-ascii?Q?mtdxHEwZjqKf5XbHga6no22XpHJRYBGyBdBaGqyihaLJzQXBbDaKucnavyKe?=
 =?us-ascii?Q?W/F6zqp/PcfZ6KAJxhkhYPmQGH1fJBbkim3bMJRvnZqOPBT6JTb0iHupcpKg?=
 =?us-ascii?Q?zqATB6XAAbO6GE/pLohstPf4Joecrw/hh5X4sPqhfD0YnNo+7aigNXqOx4G8?=
 =?us-ascii?Q?c+c3+MZVTVO6OYfda+8GBtHmtaRYfnHpc3P+z9j6ZegwrniLqWqvEfy6pjQO?=
 =?us-ascii?Q?TSGVkOLl5b18HrRQGYsY4baPTy49OCLK/DBYbNA1znJNTe65B1Ixzy/2v/Ic?=
 =?us-ascii?Q?eF2HhukM3c6lt3ERmzyn/ZbITapg9yO/W3368FfRo7OnrCD2aa0Um4G38S8b?=
 =?us-ascii?Q?wIdGiWEyWoIYROjKeVB7C7ENXX4baZB1Rg9i16yaym0VRda7wCE2+E87pbdf?=
 =?us-ascii?Q?ELDvmYkxBlJA44pTY+g8h+z2idD3u5xnAyTv33G3jbptr8zASLQv5Qc5dtiI?=
 =?us-ascii?Q?x73IcI2d4xzWbqZoIzmN9NVnvzLLEyk6WnNj3Wu8yzdWY9ouooaVm/gdyxNb?=
 =?us-ascii?Q?HYFwcL+ngQud4sPSbdARte84baNxfOj3VuRkMF2HPalizgnNgVryLNBB+nqI?=
 =?us-ascii?Q?Z4ZqMiRYQfj85m/ZHgHPHmzMzvzUhi9MH3U/iAnnByUOcl85RZ1kSWw/Z4c9?=
 =?us-ascii?Q?xEoHrC7jp8PcnKua5ptMtvHmjVL7n9LaFf8dLh6kmTP8uMOSvZH19CytFksV?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adc95475-1dad-4f35-31ed-08dcf75a55de
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 14:10:54.0914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A3/Pc7+fcZ/vdq8IpFhEHPd7QFAIriylGp9LOky8a4HFbNaPtbEoyM2Fp64dLmATzqxyqc5TWa8sLkHM0vzQlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9578

Hi Breno,

On Mon, Oct 28, 2024 at 03:56:50AM -0700, Breno Leitao wrote:
> On Sun, Oct 27, 2024 at 05:36:56PM +0800, kernel test robot wrote:
> > Hi Breno,
> > 
> > First bad commit (maybe != root cause):
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   850925a8133c73c4a2453c360b2c3beb3bab67c9
> > commit: 782fe08e9861d00ce8aca370453dd9ceb9a23d50 soc: fsl: qbman: FSL_DPAA depends on COMPILE_TEST
> > date:   3 months ago
> > config: arm-randconfig-r123-20241027 (https://download.01.org/0day-ci/archive/20241027/202410271721.jiVrriXD-lkp@intel.com/config)
> > compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 5886454669c3c9026f7f27eab13509dd0241f2d6)
> > reproduce: (https://download.01.org/0day-ci/archive/20241027/202410271721.jiVrriXD-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202410271721.jiVrriXD-lkp@intel.com/
> > 
> > sparse warnings: (new ones prefixed by >>)
> > >> drivers/net/ethernet/freescale/dpaa/dpaa_eth.c:2745:24: sparse: sparse: cast to restricted __be32
> >    drivers/net/ethernet/freescale/dpaa/dpaa_eth.c: note: in included file (through include/linux/module.h):
> >    include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
> >    drivers/net/ethernet/freescale/dpaa/dpaa_eth.c: note: in included file:
> > >> include/soc/fsl/qman.h:245:16: sparse: sparse: cast to restricted __be32
> > >> include/soc/fsl/qman.h:245:16: sparse: sparse: cast from restricted __be16
> 
> Thanks. The commit above "782fe08e98 ("soc: fsl: qbman: FSL_DPAA depends
> on COMPILE_TEST") was created to detect problems like this, since it is
> not possible to compile-test dpaa driver. 
> 
> Copying Madalin Bucur <madalin.bucur@nxp.com>, who currently maintains
> this driver.

I will handle the sparse warnings exposed by your COMPILE_TEST change,
there is nothing actionable for you, except review if you wish.

