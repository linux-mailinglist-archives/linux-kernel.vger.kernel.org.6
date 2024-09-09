Return-Path: <linux-kernel+bounces-320596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0D6970C6E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 05:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8A711F2246C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 03:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9DA18E025;
	Mon,  9 Sep 2024 03:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="TFQBUcrR"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2047.outbound.protection.outlook.com [40.92.23.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC73193
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 03:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725853650; cv=fail; b=tCJiu0c6V/ydjmZFrYgkcTgd2JuD417hH6Faw9vDANkQgk6ysAa3L+r7fRUugYVRABCZczZzHcuo9F9fpj/3ZcfLe7SftkVrqHb65UR+ygnrrRDd+ILsnOHZPywn3xRbkTs+OtjZppCvsynCDKHsosrK3fLCOFusSLT4q6a3C8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725853650; c=relaxed/simple;
	bh=NhCYT1E5NQ2k4cPDBXcLvxWbCI2R4xUkFMC4T4RVlmw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mfmBoDRixvSvHHzFlJeCPPD9a5fVTkppvXoKokkdcDBJm6g86nVz16yjlwEWF2+y5RW9tf+47x5vfw3VAZyzORZkutrIfnOnmtK+Ud5d+3CCQUs4cEj6nifHB9Esw2LK6xtUHbwa1w32FHrI89z6ec+w1hMmqo4xDeS9nDyXDbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=TFQBUcrR; arc=fail smtp.client-ip=40.92.23.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=knnW0azLRFRdcDZ9nTE3Jy/ZFBPL0hlhyAsezcB/nRizJbSeMo2zgWq4f9VXix0AEtv8kzjulW2BCk48V5Cao2PzkGNBHz5iG5x7yesVWAMAiC3QXwF6uOeMon4CC6i82BkqPEm1ooCMtCa/aQXgUpWU87IBpUaaWyUeHOM82ZjnV+R/RxDxEIJSHlWRrUhVHcLAxGykRBTqWbCBTzLdfO57sn9DOC4oENpb7WAB+L/iP6N6eFtlHrnCFK0F3c+vZZHgDswpjenX9SWJATyY9xZ1jae3iGnLddRCIS1ExpLE4y+gGTqRcEMxEA25xhMghJISz4Jj0/6I5gcV0XHynQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HuQ7J54si+A8+wyfjtHFU4D2JTmAGc10IoSN7cTwAs=;
 b=OI8ki5FeiX9jLg32WySV187RzKz8SMSXXxzO5ewJOGmLbUhXf7SkudGbZkhjxM6PsXgzQ/jj6QKk4lSgdxlsQJNsGXGPpELclhXGbKHiVKsAzlc8sQCtKpEtkk2eLaeklvPMGcEAWPA6Mq3XiIbAnH5ljLmhoofwaFNBF6tEv9w+lHW/lSTLaiIGSqbFeS2M91b1KJLVrKIitw44+3/UR3Nnq7s2PCKWLDIlO7ObGAOh1FR2iU0MLnGbjgM2rvO7TB8eqw/mlk3O32AkEiijjZhYdDaJUWA7Ree9BLkCIXoI3qAWg4pfqQw4S/6ZcmU6d6s+HPn9uTOgdqOrLYLkdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HuQ7J54si+A8+wyfjtHFU4D2JTmAGc10IoSN7cTwAs=;
 b=TFQBUcrR1/xaFsNc4yK6xdddtdLSEuQvQHvflvWHa9whyhyFGyn1sa1r6L3f2AtwHaUDGp2Pr6xZ5diwLCLUZgtr9pK2HH9llpUW7Su3Dx0yLzwfMmj5AlNL1PbNjZlNjOot4X1XRDRfei15KC93Nvqco+NGz4hGSGFXrBIyHP1gju5m5RJQmuyWFtgCexU4iOW1jp5qkdD/rfZH7R96f3HFc0iKqfgG7jQh6GS4yH5XpswVZcaDxDOO1I19F+VS78PH825ezKeRGh2xpSAx7mvMrAtQQXazZo9y56i/CHbQOmuh4GyajEVrRgPq42/nASQgKrVzVpUbvDqBdqxFvg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS0PR02MB9273.namprd02.prod.outlook.com (2603:10b6:8:14b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Mon, 9 Sep
 2024 03:47:26 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.7918.024; Mon, 9 Sep 2024
 03:47:26 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Steven Price <steven.price@arm.com>, Marc Zyngier <maz@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Will Deacon <will@kernel.org>, Suzuki K
 Poulose <suzuki.poulose@arm.com>
Subject: RE: [PATCH 1/2] irqchip/gic-v3-its: Share ITS tables with a
 non-trusted hypervisor
Thread-Topic: [PATCH 1/2] irqchip/gic-v3-its: Share ITS tables with a
 non-trusted hypervisor
Thread-Index: AQHa/3SMIKEwXnQ2HUGvGeXE6k0H7LJO0ieQ
Date: Mon, 9 Sep 2024 03:47:26 +0000
Message-ID:
 <SN6PR02MB41579C5C46B4F5F72A888743D4992@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240905091738.28544-1-steven.price@arm.com>
 <20240905091738.28544-2-steven.price@arm.com>
In-Reply-To: <20240905091738.28544-2-steven.price@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [ToNriqxlV5Eqn6sSdz5BydDvgTO8S7gm]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS0PR02MB9273:EE_
x-ms-office365-filtering-correlation-id: 509ebd53-b320-45c1-f037-08dcd0821ee9
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|15080799006|19110799003|8060799006|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 dTnGzGVnTtI07VdDjOPoug7APhfS/TRHtSekWNmEXQdc69yJrfLHISpoXu6zf/8tFuZvPkGoDNQSFCvY8WMz7rEXoHc84v/HAHDnc1onJhtu4B/ApJ5d5DVopikTeAiFachqcS61zzPo+Ny0RNVnKE9n5Lin0aXuRKtDg8tjAy2rMV0Ryxq6ZzIIjMkFniQGR8fW032Z/c6NqN8OBe34KbogIbNGpvK0UmmQWmZAexROHMRBGamL8DYyyZZ31R7IkrLhK7hv95A/BmD09vrny4BQatp3g6XUwiYHYS2yvB7Y0oWSn/qp4YO9Qu6leN5t4MHORS8qv1jMtVpofcQxQAwYpGb1xIi/zF44pxGntXJzNTletm4lbdTQdRf+tOEqhJrAQvNMCVmXHKAwi/QWqMUTRQoRVws5vQ780dOBrw4IkQnm/C03qtStvW3/Pvv99gWkkTRWr2OAAVmOmKhDOaJif+dCIztW3iBan21UQoTS3zpO4lpxhx2hWc/cM1rH7IU6O1XBXJBRY+VqPW4M537G+DnRGC4hfjvtX2mQPkE3SC7qYHnU5LD4Y4Nv+k5HKpcelv8/rF9DrFgDdL3x5N8eyBlaJZaSjlcMy8IpDfkBnAbup0q8wpzt7ir25Zc0EFDSpYLhEjacWRGypdAF39Hv5U0UylI5IvvbQHlvJitpnO6Yp3of0g8UrfZqWdrN
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uGaOsCTN/fv6bTeh1wM4ruS2KO22JpuqBrBiSmG4sunIqPcUmzdiowRMNsKL?=
 =?us-ascii?Q?iHSDWg3vnQwT3/5TC+eUNJr/kcS9PxOHzyXvoZmScbv8sHRZIIFOFZKb9Jy+?=
 =?us-ascii?Q?8fdgilLwg/M8sHwh145COct/aAhoMsrHDmbd3c+rR09U8Q2J/G+yqhmLFomS?=
 =?us-ascii?Q?9uXza5qYoyZbFJ4rr7jxzvOihQJNodqfHRc8TBNgN8MSQgOjJXWiKhz0fqNO?=
 =?us-ascii?Q?WBcnRChXdCNIScdLvOkQCwMg4tiLCW4YSGC4Bhwrc7A8mlNlwqGIuPtS9mq9?=
 =?us-ascii?Q?RIjUOv1A4g6FgYaK9aZ3OTDEWwOh+oRjiTnGirUS6SH9RFoQ4Tvi/SmFvM7/?=
 =?us-ascii?Q?eHhL5xgp6VOTC/9YbJCpGA1VjEcWUhMLgS1Hgg7yD3hXtWgq7ajza+1KA40t?=
 =?us-ascii?Q?rOF7VX/zWUjOFuUoCSiJSb6xW4zmsAbfjis/32jgmQzwn0CVU3KJEIekzI2Q?=
 =?us-ascii?Q?2QKyom1hLzODAOrCYDMEmkJ6kOw5pa3kugqiesKcy+Z6wEfXyBgr4aK68yVR?=
 =?us-ascii?Q?XHMGJeXOdXZZ0tc+wKS6QGdZY13KAiSGP57Y0McfTmjtpxJnGKxPd73OTVut?=
 =?us-ascii?Q?v7thbih23Qlx5W4Q/82MtAKrEURcLgTwAPuV5j1SLuUJKIbQTiupOUULhes+?=
 =?us-ascii?Q?i4V7cyzo8YRrWejECtQOEl4/FSZs3i4hL3CSU+gBSTQIyMqn1sobvlQZFQ24?=
 =?us-ascii?Q?ojuEeqnBeKxpLQIc7dtZYRKKz+p8YKXPQVqb9ihPBDlJyujaaP8BoyPY2SyC?=
 =?us-ascii?Q?Z8V9ytyO9EpgjKWOEJF8yuRljDgBr9UEBmJYSS2WxNT7OArkPM3lrjDT4Im+?=
 =?us-ascii?Q?BvfoJtnf1sfcFZKL35HHnuLHUm3CI6N3p8JYA7kALCfxcFNsTHeePDMJnQTO?=
 =?us-ascii?Q?e36WZw29gHgF58HJbLT0ArxMcKTDpUC5vwG+Ux5G9jnbhvKEhCjd8LuHcQo1?=
 =?us-ascii?Q?quBq98t7zxfwbakHCUKpl2D2J3mM2oabqsXWhTKpe85HbMoJTauvKxHZBWIs?=
 =?us-ascii?Q?OWw9+cnGxN0MSWK1T3HArzdgU5OWZXJfMQYxdqfw0PJK7eRNKMUBRZ9jIPBU?=
 =?us-ascii?Q?+VwrEG5lj50r0emfPgHyACzsktwaK2TNwSSOCPn0ZUM4jH86hQvlmun6OD6e?=
 =?us-ascii?Q?9PQIrrmMloZFSVCOlFtgH/cmiwaNDF+1I20Z0GYL6YN/6MkFhODKXF/f/VSK?=
 =?us-ascii?Q?wgWMYsWl3BfjOA6vR+P8hBaTPDlOXAYl38fPsyIoW5oxitknzGctNhmr66A?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 509ebd53-b320-45c1-f037-08dcd0821ee9
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2024 03:47:26.2438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9273

From: Steven Price <steven.price@arm.com> Sent: Thursday, September 5, 2024=
 2:18 AM
>=20
> Within a realm guest the ITS is emulated by the host. This means the
> allocations must have been made available to the host by a call to
> set_memory_decrypted(). Introduce an allocation function which performs
> this extra call.
>=20
> For the ITT use a custom genpool-based allocator that calls
> set_memory_decrypted() for each page allocated, but then suballocates
> the size needed for each ITT. Note that there is no mechanism
> implemented to return pages from the genpool, but it is unlikely the
> peak number of devices will so much larger than the normal level - so
> this isn't expected to be an issue.
>=20
> Co-developed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Tested-by: Will Deacon <will@kernel.org>
> Reviewed-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 139 ++++++++++++++++++++++++++-----
>  1 file changed, 116 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v=
3-its.c
> index 9b34596b3542..557214c774c3 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -12,12 +12,14 @@
>  #include <linux/crash_dump.h>
>  #include <linux/delay.h>
>  #include <linux/efi.h>
> +#include <linux/genalloc.h>
>  #include <linux/interrupt.h>
>  #include <linux/iommu.h>
>  #include <linux/iopoll.h>
>  #include <linux/irqdomain.h>
>  #include <linux/list.h>
>  #include <linux/log2.h>
> +#include <linux/mem_encrypt.h>
>  #include <linux/memblock.h>
>  #include <linux/mm.h>
>  #include <linux/msi.h>
> @@ -27,6 +29,7 @@
>  #include <linux/of_pci.h>
>  #include <linux/of_platform.h>
>  #include <linux/percpu.h>
> +#include <linux/set_memory.h>
>  #include <linux/slab.h>
>  #include <linux/syscore_ops.h>
>=20
> @@ -164,6 +167,7 @@ struct its_device {
>  	struct its_node		*its;
>  	struct event_lpi_map	event_map;
>  	void			*itt;
> +	u32			itt_sz;
>  	u32			nr_ites;
>  	u32			device_id;
>  	bool			shared;
> @@ -199,6 +203,81 @@ static DEFINE_IDA(its_vpeid_ida);
>  #define gic_data_rdist_rd_base()	(gic_data_rdist()->rd_base)
>  #define gic_data_rdist_vlpi_base()	(gic_data_rdist_rd_base() + SZ_128K)
>=20
> +static struct page *its_alloc_pages_node(int node, gfp_t gfp,
> +					 unsigned int order)
> +{
> +	struct page *page;
> +	int ret =3D 0;
> +
> +	page =3D alloc_pages_node(node, gfp, order);
> +
> +	if (!page)
> +		return NULL;
> +
> +	ret =3D set_memory_decrypted((unsigned long)page_address(page),
> +				   1 << order);
> +	if (WARN_ON(ret))

On the x86 side, the WARN is done in the implementation of
set_memory_decrypted()/encrypted() so that each call site doesn't
need to do the WARN. Each call site must only leak the memory
if the return value indicates other than success. There are call sites
in architecture neutral code (such as for swiotlb and DMA direct)
that expect the WARN is in set_memory_decrypted()/encrypted().
To recap a previous discussion, we want the WARN for notification,
but also so the most security-conscious users can set
kernel.panic_on_warn=3D1 to stop further processing if there are
problems in the decryption/encryption operation.

> +		return NULL;
> +
> +	return page;
> +}
> +
> +static struct page *its_alloc_pages(gfp_t gfp, unsigned int order)
> +{
> +	return its_alloc_pages_node(NUMA_NO_NODE, gfp, order);
> +}
> +
> +static void its_free_pages(void *addr, unsigned int order)
> +{
> +	if (WARN_ON(set_memory_encrypted((unsigned long)addr, 1 << order)))

Same here.

Michael

> +		return;
> +	free_pages((unsigned long)addr, order);
> +}
> +
> +static struct gen_pool *itt_pool;
> +
> +static void *itt_alloc_pool(int node, int size)
> +{
> +	unsigned long addr;
> +	struct page *page;
> +
> +	if (size >=3D PAGE_SIZE) {
> +		page =3D its_alloc_pages_node(node,
> +					    GFP_KERNEL | __GFP_ZERO,
> +					    get_order(size));
> +
> +		return page_address(page);
> +	}
> +
> +	do {
> +		addr =3D gen_pool_alloc(itt_pool, size);
> +		if (addr)
> +			break;
> +
> +		page =3D its_alloc_pages_node(node, GFP_KERNEL | __GFP_ZERO, 1);
> +		if (!page)
> +			break;
> +
> +		gen_pool_add(itt_pool, (unsigned long)page_address(page),
> +			     PAGE_SIZE, node);
> +	} while (!addr);
> +
> +	return (void *)addr;
> +}
> +
> +static void itt_free_pool(void *addr, int size)
> +{
> +	if (!addr)
> +		return;
> +
> +	if (size >=3D PAGE_SIZE) {
> +		its_free_pages(addr, get_order(size));
> +		return;
> +	}
> +
> +	gen_pool_free(itt_pool, (unsigned long)addr, size);
> +}
> +
>  /*
>   * Skip ITSs that have no vLPIs mapped, unless we're on GICv4.1, as we
>   * always have vSGIs mapped.
> @@ -2187,7 +2266,8 @@ static struct page *its_allocate_prop_table(gfp_t g=
fp_flags)
>  {
>  	struct page *prop_page;
>=20
> -	prop_page =3D alloc_pages(gfp_flags, get_order(LPI_PROPBASE_SZ));
> +	prop_page =3D its_alloc_pages(gfp_flags,
> +				    get_order(LPI_PROPBASE_SZ));
>  	if (!prop_page)
>  		return NULL;
>=20
> @@ -2198,8 +2278,8 @@ static struct page *its_allocate_prop_table(gfp_t g=
fp_flags)
>=20
>  static void its_free_prop_table(struct page *prop_page)
>  {
> -	free_pages((unsigned long)page_address(prop_page),
> -		   get_order(LPI_PROPBASE_SZ));
> +	its_free_pages(page_address(prop_page),
> +		       get_order(LPI_PROPBASE_SZ));
>  }
>=20
>  static bool gic_check_reserved_range(phys_addr_t addr, unsigned long siz=
e)
> @@ -2321,7 +2401,8 @@ static int its_setup_baser(struct its_node *its, st=
ruct
> its_baser *baser,
>  		order =3D get_order(GITS_BASER_PAGES_MAX * psz);
>  	}
>=20
> -	page =3D alloc_pages_node(its->numa_node, GFP_KERNEL | __GFP_ZERO, orde=
r);
> +	page =3D its_alloc_pages_node(its->numa_node,
> +				    GFP_KERNEL | __GFP_ZERO, order);
>  	if (!page)
>  		return -ENOMEM;
>=20
> @@ -2334,7 +2415,7 @@ static int its_setup_baser(struct its_node *its, st=
ruct
> its_baser *baser,
>  		/* 52bit PA is supported only when PageSize=3D64K */
>  		if (psz !=3D SZ_64K) {
>  			pr_err("ITS: no 52bit PA support when psz=3D%d\n", psz);
> -			free_pages((unsigned long)base, order);
> +			its_free_pages(base, order);
>  			return -ENXIO;
>  		}
>=20
> @@ -2390,7 +2471,7 @@ static int its_setup_baser(struct its_node *its, st=
ruct
> its_baser *baser,
>  		pr_err("ITS@%pa: %s doesn't stick: %llx %llx\n",
>  		       &its->phys_base, its_base_type_string[type],
>  		       val, tmp);
> -		free_pages((unsigned long)base, order);
> +		its_free_pages(base, order);
>  		return -ENXIO;
>  	}
>=20
> @@ -2529,8 +2610,8 @@ static void its_free_tables(struct its_node *its)
>=20
>  	for (i =3D 0; i < GITS_BASER_NR_REGS; i++) {
>  		if (its->tables[i].base) {
> -			free_pages((unsigned long)its->tables[i].base,
> -				   its->tables[i].order);
> +			its_free_pages(its->tables[i].base,
> +				       its->tables[i].order);
>  			its->tables[i].base =3D NULL;
>  		}
>  	}
> @@ -2796,7 +2877,8 @@ static bool allocate_vpe_l2_table(int cpu, u32 id)
>=20
>  	/* Allocate memory for 2nd level table */
>  	if (!table[idx]) {
> -		page =3D alloc_pages(GFP_KERNEL | __GFP_ZERO, get_order(psz));
> +		page =3D its_alloc_pages(GFP_KERNEL | __GFP_ZERO,
> +				       get_order(psz));
>  		if (!page)
>  			return false;
>=20
> @@ -2915,7 +2997,8 @@ static int allocate_vpe_l1_table(void)
>=20
>  	pr_debug("np =3D %d, npg =3D %lld, psz =3D %d, epp =3D %d, esz =3D %d\n=
",
>  		 np, npg, psz, epp, esz);
> -	page =3D alloc_pages(GFP_ATOMIC | __GFP_ZERO, get_order(np * PAGE_SIZE)=
);
> +	page =3D its_alloc_pages(GFP_ATOMIC | __GFP_ZERO,
> +			       get_order(np * PAGE_SIZE));
>  	if (!page)
>  		return -ENOMEM;
>=20
> @@ -2961,8 +3044,8 @@ static struct page *its_allocate_pending_table(gfp_=
t
> gfp_flags)
>  {
>  	struct page *pend_page;
>=20
> -	pend_page =3D alloc_pages(gfp_flags | __GFP_ZERO,
> -				get_order(LPI_PENDBASE_SZ));
> +	pend_page =3D its_alloc_pages(gfp_flags | __GFP_ZERO,
> +				    get_order(LPI_PENDBASE_SZ));
>  	if (!pend_page)
>  		return NULL;
>=20
> @@ -2974,7 +3057,7 @@ static struct page *its_allocate_pending_table(gfp_=
t
> gfp_flags)
>=20
>  static void its_free_pending_table(struct page *pt)
>  {
> -	free_pages((unsigned long)page_address(pt), get_order(LPI_PENDBASE_SZ))=
;
> +	its_free_pages(page_address(pt), get_order(LPI_PENDBASE_SZ));
>  }
>=20
>  /*
> @@ -3309,8 +3392,9 @@ static bool its_alloc_table_entry(struct its_node *=
its,
>=20
>  	/* Allocate memory for 2nd level table */
>  	if (!table[idx]) {
> -		page =3D alloc_pages_node(its->numa_node, GFP_KERNEL | __GFP_ZERO,
> -					get_order(baser->psz));
> +		page =3D its_alloc_pages_node(its->numa_node,
> +					    GFP_KERNEL | __GFP_ZERO,
> +					    get_order(baser->psz));
>  		if (!page)
>  			return false;
>=20
> @@ -3405,7 +3489,6 @@ static struct its_device *its_create_device(struct =
its_node
> *its, u32 dev_id,
>  	if (WARN_ON(!is_power_of_2(nvecs)))
>  		nvecs =3D roundup_pow_of_two(nvecs);
>=20
> -	dev =3D kzalloc(sizeof(*dev), GFP_KERNEL);
>  	/*
>  	 * Even if the device wants a single LPI, the ITT must be
>  	 * sized as a power of two (and you need at least one bit...).
> @@ -3413,7 +3496,11 @@ static struct its_device *its_create_device(struct=
 its_node
> *its, u32 dev_id,
>  	nr_ites =3D max(2, nvecs);
>  	sz =3D nr_ites * (FIELD_GET(GITS_TYPER_ITT_ENTRY_SIZE, its->typer) + 1)=
;
>  	sz =3D max(sz, ITS_ITT_ALIGN) + ITS_ITT_ALIGN - 1;
> -	itt =3D kzalloc_node(sz, GFP_KERNEL, its->numa_node);
> +
> +	itt =3D itt_alloc_pool(its->numa_node, sz);
> +
> +	dev =3D kzalloc(sizeof(*dev), GFP_KERNEL);
> +
>  	if (alloc_lpis) {
>  		lpi_map =3D its_lpi_alloc(nvecs, &lpi_base, &nr_lpis);
>  		if (lpi_map)
> @@ -3425,9 +3512,9 @@ static struct its_device *its_create_device(struct =
its_node
> *its, u32 dev_id,
>  		lpi_base =3D 0;
>  	}
>=20
> -	if (!dev || !itt ||  !col_map || (!lpi_map && alloc_lpis)) {
> +	if (!dev || !itt || !col_map || (!lpi_map && alloc_lpis)) {
>  		kfree(dev);
> -		kfree(itt);
> +		itt_free_pool(itt, sz);
>  		bitmap_free(lpi_map);
>  		kfree(col_map);
>  		return NULL;
> @@ -3437,6 +3524,7 @@ static struct its_device *its_create_device(struct =
its_node
> *its, u32 dev_id,
>=20
>  	dev->its =3D its;
>  	dev->itt =3D itt;
> +	dev->itt_sz =3D sz;
>  	dev->nr_ites =3D nr_ites;
>  	dev->event_map.lpi_map =3D lpi_map;
>  	dev->event_map.col_map =3D col_map;
> @@ -3464,7 +3552,7 @@ static void its_free_device(struct its_device *its_=
dev)
>  	list_del(&its_dev->entry);
>  	raw_spin_unlock_irqrestore(&its_dev->its->lock, flags);
>  	kfree(its_dev->event_map.col_map);
> -	kfree(its_dev->itt);
> +	itt_free_pool(its_dev->itt, its_dev->itt_sz);
>  	kfree(its_dev);
>  }
>=20
> @@ -5112,8 +5200,9 @@ static int __init its_probe_one(struct its_node *it=
s)
>  		}
>  	}
>=20
> -	page =3D alloc_pages_node(its->numa_node, GFP_KERNEL | __GFP_ZERO,
> -				get_order(ITS_CMD_QUEUE_SZ));
> +	page =3D its_alloc_pages_node(its->numa_node,
> +				    GFP_KERNEL | __GFP_ZERO,
> +				    get_order(ITS_CMD_QUEUE_SZ));
>  	if (!page) {
>  		err =3D -ENOMEM;
>  		goto out_unmap_sgir;
> @@ -5177,7 +5266,7 @@ static int __init its_probe_one(struct its_node *it=
s)
>  out_free_tables:
>  	its_free_tables(its);
>  out_free_cmd:
> -	free_pages((unsigned long)its->cmd_base, get_order(ITS_CMD_QUEUE_SZ));
> +	its_free_pages(its->cmd_base, get_order(ITS_CMD_QUEUE_SZ));
>  out_unmap_sgir:
>  	if (its->sgir_base)
>  		iounmap(its->sgir_base);
> @@ -5663,6 +5752,10 @@ int __init its_init(struct fwnode_handle *handle, =
struct
> rdists *rdists,
>  	bool has_v4_1 =3D false;
>  	int err;
>=20
> +	itt_pool =3D gen_pool_create(get_order(ITS_ITT_ALIGN), -1);
> +	if (!itt_pool)
> +		return -ENOMEM;
> +
>  	gic_rdists =3D rdists;
>=20
>  	lpi_prop_prio =3D irq_prio;
> --
> 2.34.1
>=20


