Return-Path: <linux-kernel+bounces-522494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0DCA3CB14
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 437663A5A11
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA08F184F;
	Wed, 19 Feb 2025 21:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CcnjiLRm"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013065.outbound.protection.outlook.com [40.107.162.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA9A215053
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 21:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739999356; cv=fail; b=KOuqnWZCwgUQzvnQQLhPZv79sSxF4ymhD/F86RbAiPPRi79fBSRMVArtMZXLUoURIRJ2hePS3LloKKEGzR4sLSGPlxUBblDeZFyJvUE7iCQ/DIDv4yKw26XqIVhjy/C8e7KUAN5jHyVHf64etRmVaAvGv4ZYJy9M8w+TZjgyLSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739999356; c=relaxed/simple;
	bh=ZfRcCZHRkPAtPsfT3Qu5SUH3EGIxReRokfJVnSmRvRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fiZyKWMCqG/laxidFeFkZD1Rn+46qMPK7dN+b6HzuUPDqg5IX/G9XkCG+bNzqmUliilDCNQSqBDoUae1/l7D9Ytx15avKJSYAnTypyArZJmQcwvNH1j+e93PgVxYD0shqt9yKvUPth/ML9OQUlhBUjgQKcuwjLm1tGNnF64EsUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CcnjiLRm; arc=fail smtp.client-ip=40.107.162.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LaCkhUnmbkHJ0HryNXeMwcQgk/coiYWTuiWeJPtaAiCvLNg2y/OThqQP0tQM/y3R2DuqMuTj2Sa79GDbLaBu5C41sxfWlTi5xOD76RZP9XnqRlR9AfqjkYsek3UWH+j2GRzuOXoYKFtPc0jrR+mn3sa8nu4SF3PqFSi6yTXQVqeBjtjNRJzRKE9HgHDsKxuGZCSl9Cz1iu0gIzpjwXGoa9L3h+/Iz9J7HJZnvDdQ/Qh17dRgCCOQFQQGeDk3YvjHIWpIh1CNX35IxxdjlfRBEXWHuuSqBAopCeodvIvHSJ+Ur0c+eXUC6PWKfdacalPACI8cIlh9lacWcDbf0YM51w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=StZuM41BBEkN7LbbfbkWdpwYv/ghXoMGv1SYoSib4Ek=;
 b=cAQhhMXL2d4aZPG5BNMNiz9QdIABq82VI4QmoSJuiPObARmO0j6w8j3lfK1kMcNiWNH5HP7uhpeHX27W+bDHEtXPaBmIs+mbGKA5DuYUTrz7Biecnhsbplb4eA1lNak4W0xbXHcKUBLIDsAJnMVdbY3q991qkmRXhCD4rvN+T3n5g6wU4Y7euJWO5Nt1f/0wUJTPGyMq7Zd1MImz8gZsnxl/HTcIzBtXFshiqS1lW4SNs4FoiXDEDM8zG9FrxwYPAdg5GMkSDn/KixeMb5qQ4yYH5xdke4lNkuEo26G5lMk9X3LANTd45gTc5VsWDO3udz1fPOWJV337en2G92XH2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=StZuM41BBEkN7LbbfbkWdpwYv/ghXoMGv1SYoSib4Ek=;
 b=CcnjiLRmh9RRjgz1+3lBPdRXm8H/RiuOniqK1rXSRgYkXaJzh4d3gi+Ah2SAxmjaQA0QG2wL+13vmS9LpEUneqj+lK34+cyfD1PA0cHz8YAWPlqr9GEt9StpcXf3tKJRcO+DF5Y1qvkMHJbV6wmPfQezMkg2fTcvvTAtzASF3gY38g6QKEKPGnVqCSsYmJxZT3/MkLNmHegyaKrSt5N34TBvjunIGSiy5VV0+5wTDr+/826SP5KLMLjCcC/H15fGR1VSaFIxCJOQJJgXxsFHPVIN7ER6ahEeTDlcfvCKjMgYZ2nQzqpUVNnbIWFn54mGMbN/FTlvn8tTDIMgIukOxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB6857.eurprd04.prod.outlook.com (2603:10a6:10:114::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Wed, 19 Feb
 2025 21:09:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 21:09:11 +0000
Date: Wed, 19 Feb 2025 16:09:03 -0500
From: Frank Li <Frank.li@nxp.com>
To: Stanley Chu <stanley.chuys@gmail.com>
Cc: miquel.raynal@bootlin.com, alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	tomer.maimon@nuvoton.com, kwliu@nuvoton.com, yschu@nuvoton.com
Subject: Re: [PATCH v1 2/3] i3c: master: svc: fix npcm845 FIFO empty issue
Message-ID: <Z7ZIb3OpSdHw1w1Z@lizhi-Precision-Tower-5810>
References: <20250219011019.1600058-1-yschu@nuvoton.com>
 <20250219011019.1600058-3-yschu@nuvoton.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219011019.1600058-3-yschu@nuvoton.com>
X-ClientProxiedBy: SJ0PR05CA0154.namprd05.prod.outlook.com
 (2603:10b6:a03:339::9) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: 00e9f148-8479-487b-9aea-08dd5129a7f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OYSm1J7S3UbOi0DWZRm5I0ghWuR3aFgzUyMembgKjBeI9QZViomDc9KzOIef?=
 =?us-ascii?Q?Nzny05BM1BfLayn1GnXpW1SeR32+cehvYbMfraGy544QCp63MJZ9YVKNfusb?=
 =?us-ascii?Q?iBYw3jFBqLmRUJhxG+cAbhQVtVkI77+90tgBdYHbjUKNh+xNMyWt4EIMoSxV?=
 =?us-ascii?Q?SSDa9vmZCJnJ7pDgbQMdN4+Gb8NtDzmdtmiOn4jOd7hZu9H55MhDRbN+6/Xk?=
 =?us-ascii?Q?IZdzI1KlRSu8D68Xem2G1DM+el4Oup53R22oG0TBIr3B139WMgbiBBqWlXSS?=
 =?us-ascii?Q?HouC4mqxrpiQa8a9WLvdRx4vib0NS7/5/f1dRZcEEsZ+7m6uTCCef92o+TVr?=
 =?us-ascii?Q?eNWG4mHEvSbFi4zt1wgXHyx00Qj8zqFCbUgEgqf/B8PRTtLQdMj6AlkKCWv2?=
 =?us-ascii?Q?8RFS4ceRln8eyq3IFaLjKowOcCkV4j4eVBw351myFmXXYw81Z7jZs05NQDrN?=
 =?us-ascii?Q?OzBvlsefjt9IwAR63x7K0QFzgRuxk+J5Zy3JB7eOvs58LtiSzyYHmGaFB5s4?=
 =?us-ascii?Q?gWmSDD3/qvFnQzDVU8FUVIAB75tfFkvkwF6+i8/gor0pASQTJ3tCShe7TRPd?=
 =?us-ascii?Q?HmWnLBBVSMdiN698IUnsGgwZl2DNfm9SymmlwzcYhP0P5TXotjmIOgokSbf7?=
 =?us-ascii?Q?yZriEmCXPRZwymr7rPKQZSmvX+0X7fSnxRI86f2sNqGtwrtkFrFAcwrzB/h7?=
 =?us-ascii?Q?oGfDpjlMVVfoQLsG8RjOuEcPs1shCoIO6/2CQmUkvnXmh3+5NDhHVoXI0HsH?=
 =?us-ascii?Q?QvNyARQyoZbmBtLOVDyUG/8idVb3o6ayBRzWLH7l6xCUYHFQj1x413jLGtMk?=
 =?us-ascii?Q?zeEOldzmCU412KjsyKn/TdxhKxphxVLgDMIiJNWNHUeAIG+/dTIAo4KsLGZP?=
 =?us-ascii?Q?/jlJvXsIz2iDSZIMsuXTcCZBqbiHt7l+5YuU55+UodDESTS8STyWkU7JiWYf?=
 =?us-ascii?Q?e9aQ6zNl+LUB9KdC85Iljydg1yAtrwtYnsay5wKGqFM/jKLFXcBidE78jg+h?=
 =?us-ascii?Q?0yWkNotjJtEp0Er7kx4MjIz/O9gh8Pe56w4M1U+qergYHBYlN7lBQufF8f+N?=
 =?us-ascii?Q?9cfu2+lqBXPEOE5eZiOeD/YYXn2zfl9fTZfFxFaPZm9oiDlgz6ksA/eJoKUG?=
 =?us-ascii?Q?l3A17rEli0G0TF4Wt6UQi8DG20LqauyS1rW2O4bLOkGWj+bsyo3l1FlmVqXW?=
 =?us-ascii?Q?HmQnuorUqj5c5V1sKUHYEg+fMjuVYOjHXGoVp7nwKsUFgsdsZkROphEN12as?=
 =?us-ascii?Q?4mRWMJi7RjnI9y4H2v82y1q2L14mDXDOEqyK1PpDIc+8Q4rlgCsvUIrQoWIs?=
 =?us-ascii?Q?252lM3Vg1+w8F89iippqEaceNvez3vQFifD37lt9J2vyKa8M8ScgTKotJWES?=
 =?us-ascii?Q?6vJQlcrf0IafuvlabUkfY1IFd2zHDTrsdghv+QLnR8RQaT+JZmUHoY20yyyG?=
 =?us-ascii?Q?ZW3XTI//XhU/Zjjjdm7vZaCcbRWjXnRa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jtYQkF1kmWjCKhpbCG6+oUreH/iICl1m61rNsEG8vkCNj2N55KGh3nO43EGP?=
 =?us-ascii?Q?4KhApFnptdoqHyetQmJTmouTDciy11gokfHcsvKtWXCI1iyQZrqKXzTGSMuS?=
 =?us-ascii?Q?YdZC2ZOIHYVpYvpg0zR6btQCp5IbdOTQ1AEKWwFVqiMI9LQBTWfyndTKyZPn?=
 =?us-ascii?Q?sO+8T/WyC3OVBZoMZp1/m86Wg2yPjPv9um5Uw8Qnlh0YOF8c/tv4/gKE1xIB?=
 =?us-ascii?Q?gt7IWPT6uej4InOkdTyus/TOjROawH5P9XDP+qrFajyvmfh7VfclLxrEGPoU?=
 =?us-ascii?Q?kcQX5XvGegrxLtmnQ65hI96lHxrjn9QfCdaBpLGu0ZStZjWf1Bn5v7yNNKup?=
 =?us-ascii?Q?VhA3ZkWjtTkk42KVfAQBJ7a9C1fIeC6tuQ4/dSedrr4ysrp78G3uFEowSCn/?=
 =?us-ascii?Q?bnfx/++tK41Ma8xhKVatY/1HPnuiGcY+BZXQmA2NUfDeb4o/lkJhyQ7B4rJe?=
 =?us-ascii?Q?pioM/acPnFqWoATrY39QKHsvFKvmCFc3Lb6OmRlL8bNrdXAaMelGfTPnjLNj?=
 =?us-ascii?Q?c94M74GBer6Iza5k0f2d1xBxA56aM/JvXOxWYshjlZr7jGDW1nvam2stvSiG?=
 =?us-ascii?Q?gagWrZ6WeH2Kpx6WZaB1Ku3IiAYazTjMD8xeSG8R7sR/1D8cdoqHullkx1kP?=
 =?us-ascii?Q?8C3SiA9XpexUEDLfyL3/6b0/yTRzSPCu6XnIb/Mfu5mP0hWLzzT2dt5REg0+?=
 =?us-ascii?Q?J+Pij6Nl15Dl8UxeQYKZb3xcBlmHIICGMBWGSHnUUk8hva9a/8A8wcOjudqa?=
 =?us-ascii?Q?y8DhC1x0qtm7iCCFsd5VZnQh5h8Az1XDfFy9eQ+qBDQwms6of34cuMXqa4DV?=
 =?us-ascii?Q?DwlhwlsW8JgAYiMSGKI8ZxcZGvxx5ihJ4dIiBBUfTQJnZQHTPrJk51Yl+ZCa?=
 =?us-ascii?Q?VInmHFeDTrZU15YfEp1ZWShuQkctyAAyBlw4DV/Vhcd1z6K3cegCzEuWZ/PN?=
 =?us-ascii?Q?35SZWiVpmTbpWra7klD7dmcQkpZFS2h/j1DkmKL5qeXakUDKEdX+mf42nUSl?=
 =?us-ascii?Q?cXEqSeWFhK9j8sdudqCbqJmjgjSA5KPVfF7GbyVitYZf19IFV1ooZYSt3zgU?=
 =?us-ascii?Q?NN4FdXqEDebI/6qBePV1yvdE30wNwXbOkbOPXM9Kuetu6yH2kMfVqhlTtxpV?=
 =?us-ascii?Q?B0sUnAaEI3d1bZNOfAweg9Obfk10hY7ld1qScHykMAKjXPkoUSJBCKBFDCcP?=
 =?us-ascii?Q?AawwCTJoTCViKBCd2Dxms6FhXve3iYXp7JH03GRiI9sm+DVEZowUhoAawxwY?=
 =?us-ascii?Q?RtuREpFx9IZlzzXGNxIPV7ZRQOk9bv4qNm5PM4d82rulW6+LbkGxlV/JfK1h?=
 =?us-ascii?Q?DTkhupn/hNkLlemZF1p8zYTbmokOhOYmJ8mhh7XKmhYhfkLVXcohpNgsC4FS?=
 =?us-ascii?Q?Hyyiibx/KI16RYDFSaVaGI/nuGeLm//mv4o0jxLtzW5Ys4k3jdJWtFjJRlzJ?=
 =?us-ascii?Q?BBSivjGc7oxT7TArn23vEoXlutvY8esU5+iBa6FFTznqLFORcts7PLS9+Q6O?=
 =?us-ascii?Q?ZIYUVBir/BsN/RhtxSni/LTTdGHHED2RKQ1Qto9JzYcPutlPvEaWgUXfbhJx?=
 =?us-ascii?Q?3pMa3yHpVGvxcWAgxbbkz1G03BaxmH65WQbUl/vB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e9f148-8479-487b-9aea-08dd5129a7f0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 21:09:11.0394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3+HPDBiw6LLh4iSaEgvFFn3z2slgOZRbpETbI8qVOaONtsc+hmMfBdn36RATp5jplChJrFhL88GFq0NVMVcz0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6857

On Wed, Feb 19, 2025 at 09:10:18AM +0800, Stanley Chu wrote:
> npcm845 HW issue:
> I3C HW stalls the write transfer if the transmit FIFO becomes empty,
> when new data is written to FIFO, I3C HW resumes the transfer but
> the first transmitted data bit may have the wrong value.
> Workaround:
> Fill the FIFO in advance to prevent FIFO from becoming empty.
>
> Signed-off-by: Stanley Chu <yschu@nuvoton.com>
> ---
>  drivers/i3c/master/svc-i3c-master.c | 58 ++++++++++++++++++++++++-----
>  1 file changed, 49 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index 813839498b2b..22cb1f1c1fdc 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -102,6 +102,7 @@
>  #define   SVC_I3C_MDATACTRL_TXTRIG_FIFO_NOT_FULL GENMASK(5, 4)
>  #define   SVC_I3C_MDATACTRL_RXTRIG_FIFO_NOT_EMPTY 0
>  #define   SVC_I3C_MDATACTRL_RXCOUNT(x) FIELD_GET(GENMASK(28, 24), (x))
> +#define   SVC_I3C_MDATACTRL_TXCOUNT(x) FIELD_GET(GENMASK(20, 16), (x))
>  #define   SVC_I3C_MDATACTRL_TXFULL BIT(30)
>  #define   SVC_I3C_MDATACTRL_RXEMPTY BIT(31)
>
> @@ -133,6 +134,16 @@
>  #define SVC_I3C_EVENT_IBI	GENMASK(7, 0)
>  #define SVC_I3C_EVENT_HOTJOIN	BIT(31)
>
> +/*
> + * SVC_I3C_QUIRK_FIFO_EMPTY:
> + * I3C HW stalls the write transfer if the transmit FIFO becomes empty,
> + * when new data is written to FIFO, I3C HW resumes the transfer but
> + * the first transmitted data bit may have the wrong value.
> + * Workaround:
> + * Fill the FIFO in advance to prevent FIFO from becoming empty.
> + */
> +#define SVC_I3C_QUIRK_FIFO_EMPTY	BIT(0)
> +
>  struct svc_i3c_cmd {
>  	u8 addr;
>  	bool rnw;
> @@ -216,6 +227,7 @@ struct svc_i3c_master {
>  	struct mutex lock;
>  	u32 enabled_events;
>  	u32 mctrl_config;
> +	u32 quirks;
>  };
>
>  /**
> @@ -891,6 +903,7 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
>  	unsigned int dev_nb = 0, last_addr = 0;
>  	u32 reg;
>  	int ret, i;
> +	u32 dyn_addr;
>
>  	while (true) {
>  		/* clean SVC_I3C_MINT_IBIWON w1c bits */
> @@ -931,6 +944,15 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
>  		if (SVC_I3C_MSTATUS_RXPEND(reg)) {
>  			u8 data[6];
>
> +			/*
> +			 * SVC_I3C_QUIRK_FIFO_EMPTY fix:
> +			 * The TX FIFO should be ready before the TX transmission is starting.
> +			 */
> +			dyn_addr = i3c_master_get_free_addr(&master->base, last_addr + 1);
> +			if (dyn_addr < 0)
> +				return dyn_addr;
> +			writel(dyn_addr, master->regs + SVC_I3C_MWDATAB);
> +

I think it should work for new svc controller. Fill data advance to avoid
stall SCL clock. If it is true, comments/commit message need be updated.

>  			/*
>  			 * We only care about the 48-bit provisioned ID yet to
>  			 * be sure a device does not nack an address twice.
> @@ -1009,21 +1031,20 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
>  		if (ret)
>  			break;
>
> -		/* Give the slave device a suitable dynamic address */
> -		ret = i3c_master_get_free_addr(&master->base, last_addr + 1);
> -		if (ret < 0)
> -			break;
> -
> -		addrs[dev_nb] = ret;
> +		addrs[dev_nb] = dyn_addr;
>  		dev_dbg(master->dev, "DAA: device %d assigned to 0x%02x\n",
>  			dev_nb, addrs[dev_nb]);
> -
> -		writel(addrs[dev_nb], master->regs + SVC_I3C_MWDATAB);
>  		last_addr = addrs[dev_nb++];
>  	}
>
>  	/* Need manual issue STOP except for Complete condition */
>  	svc_i3c_master_emit_stop(master);
> +	/*
> +	 * Dynamic address is written to FIFO in advance for SVC_I3C_QUIRK_FIFO_EMPTY fix.
> +	 * Flush FIFO in the failed case.
> +	 */
> +	if (ret)
> +		svc_i3c_master_flush_fifo(master);

Needn't check ret, flash fifo unconditional should be fine and avoid left
any data in fifo.

>  	return ret;
>  }
>
> @@ -1210,7 +1231,6 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
>  	/* clean SVC_I3C_MINT_IBIWON w1c bits */
>  	writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
>
> -
>  	while (retry--) {
>  		writel(SVC_I3C_MCTRL_REQUEST_START_ADDR |
>  		       xfer_type |
> @@ -1220,6 +1240,22 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
>  		       SVC_I3C_MCTRL_RDTERM(*actual_len),
>  		       master->regs + SVC_I3C_MCTRL);
>
> +		if ((master->quirks & SVC_I3C_QUIRK_FIFO_EMPTY) && !rnw && xfer_len) {
> +			int i, count, space;
> +
> +			reg = readl(master->regs + SVC_I3C_MDATACTRL);
> +			space = SVC_I3C_FIFO_SIZE - SVC_I3C_MDATACTRL_TXCOUNT(reg);
> +			count = xfer_len > space ? space : xfer_len;
> +			for (i = 0; i < count; i++) {
> +				if (i == xfer_len - 1)
> +					writel(out[0], master->regs + SVC_I3C_MWDATABE);
> +				else
> +					writel(out[0], master->regs + SVC_I3C_MWDATAB);
> +				out++;
> +			}
> +			xfer_len -= count;

I think you can call svc_i3c_master_write(),
or improve svc_i3c_master_write(..., bool b_max_space)

		ret = svc_i3c_master_write(master, out, count);
		xfer_len -= ret;
		out += ret;

> +		}
> +
>  		ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
>  				 SVC_I3C_MSTATUS_MCTRLDONE(reg), 0, 1000);
>  		if (ret)
> @@ -1308,6 +1344,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
>  emit_stop:
>  	svc_i3c_master_emit_stop(master);
>  	svc_i3c_master_clear_merrwarn(master);
> +	svc_i3c_master_flush_fifo(master);
>
>  	return ret;
>  }
> @@ -1877,6 +1914,9 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
>
>  	svc_i3c_master_reset(master);
>
> +	if (device_is_compatible(master->dev, "nuvoton,npcm845-i3c"))
> +		master->quirks = SVC_I3C_QUIRK_FIFO_EMPTY;
> +

Generally, it'd better to add drvdata such as

struct svc_i3c_drvdata {
	u32 quirks;
};

const struct svc_i3c_drvdata nutoton = {
	.quirks = SVC_I3C_QUIRK_FIFO_EMPTY;
}

static const struct of_device_id svc_i3c_master_of_match_tbl[] = {
	...
	{ .compatible = "nuvoton,npcm845-i3c", data = &nutoton },
	...
}

Frank

>  	/* Register the master */
>  	ret = i3c_master_register(&master->base, &pdev->dev,
>  				  &svc_i3c_master_ops, false);
> --
> 2.34.1
>

