Return-Path: <linux-kernel+bounces-288680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB76953D9D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 00:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 764F11F23736
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 22:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB48155CAC;
	Thu, 15 Aug 2024 22:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hvH3Aupd"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF747155326
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 22:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723762553; cv=fail; b=Z7O3ftxa6E1YHicxOidht3eL63Knrllf1XD8QFHnMhsPTvP1wzMpBMWY7sTDBaIHIBQFm5W2gjLl/dr03zq7IWEMV88x8b/Myjg0BPA9SoxjDRHwDLgkKSToPOANIbZMjEe74hPgdDpLEbA+0ysA5M56OfFH8bcFpW22dmcIj90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723762553; c=relaxed/simple;
	bh=G+DyDcSJ4N2sSceYyBrLfnNTZuOOrgw6WkhY82ig2Wo=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=iDEVsV4hK6zoPXQzTGgt7itbSYNkVEHxQpTxk0jbAfxh8dQofRyIx8nnxHXXarKfLmIT62MBnfBe+fX1B532ue511t3QPvzZTg6aYTf0uu9TNIXMCOPydlI/xNH1fCFDWROhNxKxRDch2e1nPLKx4FUsXURIXt6glWlHUnojRWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hvH3Aupd; arc=fail smtp.client-ip=40.107.223.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fAX+/rXMOeHroE3nLw5PFk/S367Rsjm4N/UaCdfTT6AYjyibx0R3pPXgj8wqwdFavLYauDhZPPcw8vr16HfKxZsM8XUdc72X4BKT1awPqCONR5twA2VRObBFK169kPiNiTaALQX/6+Lo44Mz13tC8jyjkt/a6cZZlY4PR5E64NoR/GQOhuYrZWqUBRD8dd2AHrnxhM5aqy56HXjxkRTPV4kESZo4Nf5wiGs/Wxe+0R8RQMo6pbgrWWEwqBUy6qZStrxGJavkhx5n28JlUeTuYsC7XREOUtbkTfxb06c1sHXvbjfaSWc0HOs0lFx1YbHOdzRpEGcCzdN45On2xfyLBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dAbU+SPNGkVUpPogll4h+jBfTzKTKy2RoVZqQJAYo8=;
 b=COh1hXXNSkhTICn0BDqxYnkiis6vgGr0vbG6q1b/1t0/Lcq0gee3fQzYrfhA85pLnOMkHYeebbaPmDo9Y1+ZGOtATMLHP1+r5m+vuvb4beYH3kqDslvcAJeho21Ku+2k0oYVPeUXgm4k0wROjbjnU3PXIiwGKaYdfdrlN5R2zmIeu0zrfVNDCn0qrcJDISihqkRL+DdVqoX5OU/qnPoFAM3ZhylFkmB4IUVr+wlPi5o5XHmWJNurdUQVTqUw6ZJrNDwdUHX2VPnAPwkfJNEs2plVWrkawUksQlEu1f9eoaM2RJKLcmS9rzNaqGrL5rfBQ4tSLm6Fp2WQYemvv3pTlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dAbU+SPNGkVUpPogll4h+jBfTzKTKy2RoVZqQJAYo8=;
 b=hvH3Aupdlg9Fblkb2+RdLJLGJMkeUVhwTiMZOlRMMDAFKpFbsVBjeKHAp57ai+j7dau9gAxDsTcrqSZ+NQ6G1tOZzbaH2iUJPzdewOnysDki+nbEm+7w9qRSY2mNRCpoan1AyDcPUoteoE7EFNNnL5eMvSO54flue8g2vqhVkzd3hYMmbzSjjkYOZfLK3BdQkPhvmdG+Q1RgoeXjPMp/ZuIRgfQlahpirxyo3ti2YPawOGe0Dn3VwF5rF29yIJb5gu/cwjQMBCdhaqQapFjb1FLz8htDdAXsgp3ygvR5ubHAuosaqXK2Uzx7BiCLbI/qXlWm1x8YkhThvZrfa/cB5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CY8PR12MB8313.namprd12.prod.outlook.com (2603:10b6:930:7d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.17; Thu, 15 Aug 2024 22:55:48 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%2]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 22:55:48 +0000
References: <20240815205606.16051-2-max8rr8@gmail.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: Max Ramanouski <max8rr8@gmail.com>
Cc: x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
 peterz@infradead.org, linux-kernel@vger.kernel.org, jniethe@nvidia.com,
 jhubbard@nvidia.com, linux-mm@kvack.org, tglx@linutronix.de,
 hch@infradead.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3] x86/ioremap: Use is_ioremap_addr() in iounmap()
Date: Fri, 16 Aug 2024 08:55:02 +1000
In-reply-to: <20240815205606.16051-2-max8rr8@gmail.com>
Message-ID: <87y14xpf9r.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0132.ausprd01.prod.outlook.com
 (2603:10c6:10:5::24) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CY8PR12MB8313:EE_
X-MS-Office365-Filtering-Correlation-Id: c799ed6b-cfcc-4738-3f6b-08dcbd7d6748
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nvfEWk6N+Lw9gJJzc90BCEtqc28lRIkD7fvJF+d5POST3YIPm+vhoUT3NOoY?=
 =?us-ascii?Q?lpr5zO2dVgZIGzLzqIDAMlT8vDw+fkhPSnM71+kdDQ1h4tuoc/Fu4kspVD5K?=
 =?us-ascii?Q?rUVRaRqP9bRyCPVrHG1MeOHjs3wcSbjt2zTCdiN4EbJ405Dhb/pLYyVzbPHZ?=
 =?us-ascii?Q?LIRPF7UQLJOWeJwsihhNPXchKePxzCPef3K/n2KwyQCUaLkklKjt/7jkbKic?=
 =?us-ascii?Q?+zyTJ/YbJ7x3bXo+uGbU27LBhrJOCp0eKSX67LGIWdtBt3qKzPzMxtAjD83v?=
 =?us-ascii?Q?Qa1pNvpTZBPYmuN0IU0dE3KArav9f4xl6jxLSROCmAJk3Aa3zf8Kzb72Sq6h?=
 =?us-ascii?Q?3EKNZL6NoV/bjcZT6040QDL55b2PwP9hGlnVyv6gbN6JGk55ZI14aHKNztSQ?=
 =?us-ascii?Q?uNCCjqOMoWqRt3PcR2HKSFOTHsovTr/o/nb62eWQCy1CVlTI+sPV9JC/q0Ft?=
 =?us-ascii?Q?K+9XAa7Rl3DTaOwgjc3DA+pgNmW0GEAocHblYQE4PEb1A0AnnDP0k+uC4F9a?=
 =?us-ascii?Q?7gz2Lx4DtwzAiHER/eWr75ZR2nFRLT98OrvDFHsIBE8nzuEcr/bDfuZ1Oafb?=
 =?us-ascii?Q?Iew0h6t14eoVnNZrdv56cOBoFHQ1LifQFol+OvlzVfMcFMYqTEjgZvQ3+dW1?=
 =?us-ascii?Q?oD6M79iCTdmhWg/Fi1t+Mhtg2WPVfBz76zEzYlP63vqWkZFgeRWurd2cf2j1?=
 =?us-ascii?Q?tZW93wf4T5el61/whyN9FNPrmtUZapLoaOI2DcvKaDugwwB99ygmC9PCsV4u?=
 =?us-ascii?Q?GRm/IhcHYxwf7fQ/+8JTDlNTghvVYW3nEUNaSWIa1ih4715Eop0SGAkGoocv?=
 =?us-ascii?Q?v1EApes8sLCgLQ8uHy7M9VhLPKDaz7iBhQ50pLcicWSmDuoebYafjNFchRPT?=
 =?us-ascii?Q?w+E+UTwD0SQTYFM1M+cBkAM8XO4SoAGny3v5uFc9OZKypjpQM/otsVSoBHpe?=
 =?us-ascii?Q?5mS4Ee7/BmgdAnu0YPoksXx0qvyp3t3aQjpVDCiyFwWWcJteM6VOiFc7iMK0?=
 =?us-ascii?Q?cuXI6l6Dz1AanyvTF83f3Ntim/uhBZFrrp5GazIbEsiz2z7PYS7U4Xh9UXeb?=
 =?us-ascii?Q?zrE/aASRRMlCW1l8w8VLd3AJZRnIgOiL+dI/l3DV0T+r2PRgyG3P8rLRNpqg?=
 =?us-ascii?Q?vBI83yeC4J1QUn96+faljCx4Ct9xkkNEgT0HDVv2nKf5UH2yLRHNvcF18KIZ?=
 =?us-ascii?Q?xIVGPp7U3xSVMI7gUzcRK0Nr/ZdtABJztoeSf7uqfJF7obRQwcrAuuyQVNyz?=
 =?us-ascii?Q?YadavU4ZlyQFwNB0pcL+nRIZdOW6ByUr37bvjawxJG0rF7QudXujg/wlWUH+?=
 =?us-ascii?Q?Ajx8Nrf0AMCpUFxXzckEvovS9GMD0baLzz4T9jzHI/Z5XQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tqHkmcVueBUJ2DFreF7LOEnzyxNvM+5GYhj92wymQpONZOQ6lOL3O6WC8fYY?=
 =?us-ascii?Q?7T9ixV/YnVoXNLUlpFCPeppR6cCOFWq5IXuEJ+CY2AadKhokoCriUj+e1KNb?=
 =?us-ascii?Q?ZQAvk7nr7J+4L6iKmf8gFXvlhB4E9GFnL+oxldDfFZS+JDKiTbGWzw3R3DyI?=
 =?us-ascii?Q?EGebQcJUUtbcud4/nWhEbrox70h6J7bJOcnjFJPaTXr6UahblWyfeGwuY83/?=
 =?us-ascii?Q?GC8HXE1J95yEt2SVenGL2xR8nNv93xPhSyxnMshbLw0gWJBss8YrW6J/dH5t?=
 =?us-ascii?Q?cRgI8ksVYIJN6tWR3giWaGb8jamZlnNmsN+4NkFqIXlUrqFYZN4gKmkfHRyN?=
 =?us-ascii?Q?j3myxI5wUVps2N6CZgB/0Xg43jzft9HPLNzNdMLBgk3cew/KrkL0HdkKp82B?=
 =?us-ascii?Q?q96IhL7cj4nj72STBtlLdQXNgZ9sFMOsnc/FBgot00ap0FzYsHh8EpD8xok7?=
 =?us-ascii?Q?N7Wg1bMHxFx2zenovyt/ogp9JlDxFzj57cZEugZ6I94VkDAKqSgALZBbiY+O?=
 =?us-ascii?Q?KDQvMc3yoK5rm6/dkg0J7P+5dkpu/r9trdYyKw3ma6zKVXjDmft5y1dX8crh?=
 =?us-ascii?Q?Nyo56E0u9V1341/4c9+IkTyOi7SXc7dQIlWhwbO5p4RyP03xXiTYvziKCEkA?=
 =?us-ascii?Q?XwGvammhSFbiMDhoebd/xUst31wEZIImXmSbnBrgNpB+wMHquuQNcwr/trZV?=
 =?us-ascii?Q?aADFB1sxxNNRow6NZR63RCoo5c4QPwrnpaKpSnJS8JETsLHM0eeSf4BCdmZj?=
 =?us-ascii?Q?7cY9p7EnF14vpXoHE1ETm2aRfKVo78SKJhY15BDr3wKcEV8epjFjdEU7QpB7?=
 =?us-ascii?Q?fVMRjWXJfKj8FPO6hxClqGn0zMGDNgpQAE7fqsojIWzvc93EpDMBa8OKrAlx?=
 =?us-ascii?Q?rL0FS8dpQ3wetTL6g/dX59Ph+J9juXZE+VoVJCsrmPNfb4DXkz1zEJGMsdC+?=
 =?us-ascii?Q?1fiBuawKxBzz5L99Hpl3MyMM1Rxl1qHFT2VWT6zeFMUmXUknIH14IUMR2XXl?=
 =?us-ascii?Q?t8R38MYhE7QkoFSPEVsfEd5k2JkuU1MxC3bJnc56+0K4+0/th4wbQplm6bl4?=
 =?us-ascii?Q?kC8rtpDZWidPKRj05ByuhpxMRE8MffKG58hlQ+n7jCuKxIu9KdXOy7SOpq75?=
 =?us-ascii?Q?b/JkvmvZqO2icrFgtjJhB9jy8hVw+NTI0Pz5EVLnTafbOsIYRHu/7AVlIipx?=
 =?us-ascii?Q?lJZYidguLgNzHPWC8CiX1dlkD7QGKx8Wjv9H4vJ3tRmPDlxjJCEb/KvwN7Dg?=
 =?us-ascii?Q?auMRW38haeQXZ8ZQ1rRm4xmnMvdYaTQJ1tnJtZ6peK6BtpGbzcyufMK0pKQf?=
 =?us-ascii?Q?K9HSekYUqTuv8JbiJtAHj2S+AvN1bWaxM5QmFWKhRhQaeVImJ+yDGMqBctSC?=
 =?us-ascii?Q?vViHVwmioYcOMMK6gfdOV9GjFfD9cf1Mweslly2m+xaTon/R3GNg3ei7eBsC?=
 =?us-ascii?Q?bXGZz80Giu9XM3SjgNtC5w7aq3dVUA10KFQT4WtOtwxJNFYceHg8Ny2/FdA6?=
 =?us-ascii?Q?rp2nbfwHoupNAghqq5Hrph5/NPOqIOWonux+Rg7Fyzrz5VmN4lXz7046ScP/?=
 =?us-ascii?Q?IBR7WlVcNI23Rnkkc5f4bPyGEFuRL0n6uLdR+iiT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c799ed6b-cfcc-4738-3f6b-08dcbd7d6748
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 22:55:48.2753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Ha1tQBisUZVZp0osQ7ucyXM6RbQhiON+H5DpP+Kyfi6r/C4XEmgbFxh3L6YIAe/na6jgEcOQTE9Yg19NG16XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8313


Max Ramanouski <max8rr8@gmail.com> writes:

> Restrict iounmap() to memory allocated in ioremap region, by using
> is_ioremap_addr(). Similarly to the generic iounmap() implementation.
>
> Additionally, add warning in case there is an attempt to iounmap()
> invalid memory, instead of silently exiting, thus helping to
> avoid incorrect usage of iounmap().

Looks good, thanks. Feel free to add:

Reviewed-by: Alistair Popple <apopple@nvidia.com>

> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Max Ramanouski <max8rr8@gmail.com>
> ---
>  arch/x86/mm/ioremap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index aa7d279321ea..70b02fc61d93 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -11,6 +11,7 @@
>  #include <linux/init.h>
>  #include <linux/io.h>
>  #include <linux/ioport.h>
> +#include <linux/ioremap.h>
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
>  #include <linux/mmiotrace.h>
> @@ -457,7 +458,7 @@ void iounmap(volatile void __iomem *addr)
>  {
>  	struct vm_struct *p, *o;
>  
> -	if ((void __force *)addr <= high_memory)
> +	if (WARN_ON_ONCE(!is_ioremap_addr((void __force *)addr)))
>  		return;
>  
>  	/*


