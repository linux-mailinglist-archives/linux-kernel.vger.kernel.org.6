Return-Path: <linux-kernel+bounces-389758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E88F19B70D5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 01:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0823A1C20F41
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 00:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D55733F7;
	Thu, 31 Oct 2024 00:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="av9PTRoS"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F57328E8
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 00:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730332944; cv=fail; b=YLKMaM/M9CcAVQVClcvG1e7lckBqMA0jQ+YChHSLST0eK3A0ayQTbq/wHSoqVOiI8SGiVlTr9k1Orrs6HST0mbGs4TV6mxexiLuwSq0TuOByWrcEOjbqbPv+wSCDXt/TGzrDNYqN6t+OK4OBS0nrO+dnBR2MO2nFgzz/vHOIm60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730332944; c=relaxed/simple;
	bh=MdueRF3M6OKsWHgsTqudYiM1AvZQ5edHqStCQqmNvbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GijXoyWyWNpY1gvZ2hDAL8aoO9YQ/WyhTjBG2NjY+1HtkvsJhNMvv61wrA3MXPlFrotewU1j184HSx94xeltrzjIuATXeydRbh3yuwdArf2XxPe4QvpwEOeUO2xXVr8WASb4l0v2seS3XpFwp+xE3zQmEXayAbxKjL4GxxnxJPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=av9PTRoS; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m/JbTPl4/YHfx+aoaQHfwYla42i4DLBVwGad+avv3goE/z7GExao0K7rSTfXCPoqmB1qQv0C8K/ppPTNuJQSfqS7jmRGh8FTpZVdC1TfT2Ss6vlM/7YjLZv71Sc8kmnBRiGJDBPuyxw3hufSh9gJngbHsm3IU5pnkh4tHnJw7FUWcpPI5jhl1/oJcfvEocMxAA14DtJ+JTocmm0dZlI3Qjm2jrtzapruIKaJqii+tj4HDfieH31XCs680WK4AbbJmHp8VkYLx5HPapGVr6nt+J5EmF2ar7SLMx8I4fnnYGDRElSTbeRNV7W67UtzgmKLeKf7SVrbcA6IKqZEKLAxCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdueRF3M6OKsWHgsTqudYiM1AvZQ5edHqStCQqmNvbU=;
 b=SnrsFlAkZBFnG1ZPm4KOkUVxcOUkHWSOQgSEqs7L+sQOvQBXGJjzLgDttH1bYH3AGnaa6YoUPRl0LeC1mQBl8yj5+RnVSCMMSVsYj8bVje40+vMzZziv7Vh5/fadWJxWNKqfbE5rGMEIFg3dFcuaeKqFhjnsgmKynuMccuc5Gx1LEiHh1wR7Qt8Bj9rlHQZGfBokbLWr5hbXYzxiSeaWEOlDvV1Hc2+hKt3bbQpOlahzE8YqAvuVovJeHs4+sMUgTAVMUqe1udS7mcjfAdj9qNUd4uEH5ki2i+A70Z2dQwcP6gnim5PrCCtYybRnyzBwbOk1gWV+8ch3R8sA7xLO5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdueRF3M6OKsWHgsTqudYiM1AvZQ5edHqStCQqmNvbU=;
 b=av9PTRoSECnhv45fvYy6cY8zCl5P43vQgiYoGY/RLwngt3uHwwWk9FjKhW5XKN9JmsxNr9UzjwimYwuURKftiDbKEF98Qr+vgiK3AW2e9xOHtmbrU4Y0eFsthp8qaPpj08uxtWLpWu/2h5SFGKUaz9/Snni4Zb0yeC8J4E1VQc1iJ4VX+bbFw6V0/GI4UbbFnV8vFRVcVWq7SXW32pmbItoY90TFZN1M5VHOnMVTztHtR8Rxsyjsncv244owEpdIkWUTr/bOGmYfHxq61nQfwgdbfHOkTgJWUICjC/lS00M2CeRslP+LhBk6qmPmI6cNmWf+PF0Jyafk+Y/3NShZEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB9148.namprd12.prod.outlook.com (2603:10b6:610:19d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Thu, 31 Oct
 2024 00:02:19 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Thu, 31 Oct 2024
 00:02:19 +0000
Date: Wed, 30 Oct 2024 21:02:18 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>,
	Alistair Popple <apopple@nvidia.com>,
	Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
	linux-stable@vger.kernel.org,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, Peter Xu <peterx@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dongwon Kim <dongwon.kim@intel.com>,
	Hugh Dickins <hughd@google.com>,
	Junxiao Chang <junxiao.chang@intel.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH] mm/gup: restore the ability to pin more than 2GB at a
 time
Message-ID: <20241031000218.GA6900@nvidia.com>
References: <249d2614-0bcc-4ca8-b24e-7c0578a81dce@nvidia.com>
 <ZyG3GAvTHpRL9tnU@infradead.org>
 <ea81f12a-95a3-4b9d-90e7-53a5d9c910be@nvidia.com>
 <ZyG5IumNPMUDBQOq@infradead.org>
 <fa766610-4a0c-4d75-90fd-6c781fadee73@nvidia.com>
 <87r07yp0ng.fsf@nvdebian.thelocal>
 <128d04dd-2d48-4a98-8537-49589b4db1c3@nvidia.com>
 <bfee966f-807d-4668-b353-159a6e8066f2@redhat.com>
 <8d9dc103-47c5-4719-971a-31efb091432a@redhat.com>
 <cdfadcd5-d9fe-4f90-8794-a563744ce207@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdfadcd5-d9fe-4f90-8794-a563744ce207@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:408:fb::31) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB9148:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f0cea52-2f1b-4a57-b364-08dcf93f498b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9eK4CNw4ceYPZfr0sIQ0JC0FrzSvhkUaN/UPBcPYU2tyO7DX8bykTdlFYedw?=
 =?us-ascii?Q?fuJrLMksY6nUGmNE0gfaw5N6X5mGMeF1TQID2pqYgjnJyJmNHjavE2ELfQ8t?=
 =?us-ascii?Q?rYOHYPUcWkius2vjH9UGcf05/UpObK+gQcsYn5egJNNKOHAsIB2kHUsYwsr4?=
 =?us-ascii?Q?DhTv8mP+XF8aG4DLG23WlmmApCAb5arxDiKNHyVul+NSUZGR1aoIJg8HjCu6?=
 =?us-ascii?Q?xx18QU8+yATYwf/oZHXxHJYV6br4kpGZ8z+l4xjPtxJv/pHkV3wd9n4A+nYG?=
 =?us-ascii?Q?qtl1o5rCth9S7hypti3F5RczbjUF48egLc9mKriQpIRX4YlU6F0jBMi8EsUf?=
 =?us-ascii?Q?55/zHGLe2pnN5mahwe3YPbmXbkSqMAb0UvNmR5JsvaN7oeH4/y0eR1zRqfco?=
 =?us-ascii?Q?af66d5xrTmRqe8o8a+JXEkyDi+jJzBGKxPZV+jOllWNPKaBmTG14TNbo3rvG?=
 =?us-ascii?Q?fiMB8b/xMAAB6T6ySh8Sj8yHF+PvUvysFxS2jan99Z3S2BAAuzhM9Y3Te7u5?=
 =?us-ascii?Q?0hC7ERbCmcCZU2lpO8eIDGjG7Xb5SzkD8Cci5KV9eaZfUlsudm6Z9R5g3Lz9?=
 =?us-ascii?Q?vGVS4t8uCcClbcnqvYazmNrUg1D2cq/Ebw5MMmjeZ+6LV5qj26arC1NkxLL5?=
 =?us-ascii?Q?NkOVjYcEvmnXqYeO3CNl/i+/+ZFmXqOjAznEtV7ZBX1ufvpe1XGVXy4skZJ9?=
 =?us-ascii?Q?arYHsYpmo10vgoLAQkn2BvwM+HQRUa/nnImK69ocuDqSxe5bSo/Iq00aadXt?=
 =?us-ascii?Q?VMejqNPKjoA0hoP8xiCCNWhQ+wNUIOs6bDgMfWfLkiBnz2S4ymHfAJzzjkh1?=
 =?us-ascii?Q?kAuPQUR8GsGsOec8PDshX2d37f/MXho60+95pSKqSTXsVHPcZc4jbgPnc1dr?=
 =?us-ascii?Q?4NjPia1kSv3AzbuOi4eklkn6HQkaVoqyTjTaAMhI8GTUvPbpE2A5Zghxjs2u?=
 =?us-ascii?Q?m9KudEG81F0Z17Y29xhXnXeJDcnzg3hldn7VfJmMXseL6zhj7D3hDtPXbkfY?=
 =?us-ascii?Q?3GCYY3wCq279htpoqZ7fJDaUpItnwgyRg9ukvPsQwbLgHJ7PR4fWMS9WEHDu?=
 =?us-ascii?Q?5psDPRCtA7cDALRBiXkAp2FDonTARYZuZgr8GnIibPbPMn9FtH66ftmfY1r6?=
 =?us-ascii?Q?OYVaQsPCfv3f3upIpIH5N/3q3B+2CItX66/buS0lr/v8qNVoaX1tGh8ZhVwh?=
 =?us-ascii?Q?c1PeFwuBmHGIq+oKcpU4aiaeX7eGJJHaez0tldGzYVJdga+b+RZ4QLalisTK?=
 =?us-ascii?Q?QPPlfGewzpQQ9eUC4EwmCtTk3ODanNzNMvKfKanftKk2J7FXfYEG1d5f51Jc?=
 =?us-ascii?Q?lCrkBvlkLmRSyZwcxNKeU/eq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nxi1V36aS4oIvp+9BwZRqnJWRM/QdehgJTQfvgaQ583fyTkvFEHN0pQ6msLJ?=
 =?us-ascii?Q?x46+KQsdONH6U0nMLA1NQejJGEgdVsxqvVXEt11r8CkgwuKfNXLZYz4uvb/K?=
 =?us-ascii?Q?q9x31kcWUsMtmP/sS9fWvYnyWFFa3aQKzxNCOLNzIyD4tguHVlaMkwCTR8qF?=
 =?us-ascii?Q?ut0Yyn8NujO9QV0yvbxSt+JNO0tPeSVbFQIpjQVligJUWclZNnoCDEx1s3Ie?=
 =?us-ascii?Q?+4aOrGLoIzhNHPP4EDZVVK4o7/LD2q4YKfYvXgD77XR0uR3Ri0JA/PuqmBzr?=
 =?us-ascii?Q?VgG8xE/a9KZB9rrsjxjID/7TL2Jnk2NXw+WQ0zwhT3bIANhmTSD7vTREAVBd?=
 =?us-ascii?Q?HlHoMwNQMrYQt4CTmtQqk+2mHa9etpFNvAiVIMWbj7IPiPIjbBPk7oa0YWW0?=
 =?us-ascii?Q?GSKcCzKhrcZ4GlaaiKi03NQX/zfZQyn6QCfww2rhU9sUuF8KIi/26vMZLh4f?=
 =?us-ascii?Q?xIaIcM77lc8hpyAK2SGqAE0yUDe3XoUPb8hM7ip2lsjI1ythOuHWj9oDMpim?=
 =?us-ascii?Q?93OL39JkMDmOoLfwlBoxGmfsof8touVPEP+iEIrsYkpeta03wgbjeG/Yo0pj?=
 =?us-ascii?Q?j8h8Q7dPC2zIdEl0zVOUu+6Jy6e6CqabvvKU7oiCKRFV0moYeZkJRwoxhtPW?=
 =?us-ascii?Q?koT/ldWQge7du8VgBJRUVsQ8Z/34e6/uX9KL3uYNgIF+R6/zRelwEv8pMc9z?=
 =?us-ascii?Q?uwGehyFkPnfkSz5m9Idmh70f0OcM0bLeP2A7wKabN28+kl8guQYYnXTJIhvb?=
 =?us-ascii?Q?9R+4ylPXqHVDBUR5CsRxGx0jK+sxxE7xjHpgkSGs6g1tMNYE/+ZJFZxxawmg?=
 =?us-ascii?Q?665nKVSw4CLtZBqww1sVpgHa3lFClaqSwgT2KMjVI14wiogVA7iVphhhf3hf?=
 =?us-ascii?Q?bLmPv69W8/ce3z3E+upQQep4oks6fZ6Kyd1n8nCG4Qfcz2Vk/PcaT3F1j6Pu?=
 =?us-ascii?Q?DswnYY4WXZvpzebc7NCfA3cuF9+wsJ6q33EfbaxW0j7fP1vx8886aBQka9/I?=
 =?us-ascii?Q?83LTboXCPG6y8eCHyjm7eLsKf2Dr5tluuvj0izsFFiZfPWM/4xheQIxfGuns?=
 =?us-ascii?Q?up7y0KtKWuJQbYz8pnDZ3A+fRKY8mNXvB/9G1JS0IIzflMzfWdB7E04dnWOp?=
 =?us-ascii?Q?kX5uMtW6TrzDL01oVyWMpuGnbrhZcPe+Yihr4E0UY57VqjvJS734RDLNeNj4?=
 =?us-ascii?Q?fVzVLEnsvkYe1Z6Hf4xStMJZzeAPdgHtppbDheSUCVi6Lo+VXUlQUgOKlxHI?=
 =?us-ascii?Q?aVnT8QaBt4wFrTYPcwOU1kGP9Qu/XS/oXfTAtCndbFLjEiQ0cF9H7OAt0VnO?=
 =?us-ascii?Q?hpNwCryiTpgXHvg/jkDCa5SNuNKmKzhwe2/Qri4q7lpCzrkl2OzKoj3FgmbP?=
 =?us-ascii?Q?yPK68FEIywYQX2N+fgxDc3RXW5r6G3DrGtups71j7SgvrLU1rXuY5UaRt/pN?=
 =?us-ascii?Q?0a8PIGZz2ED7bj21LNH7CjrAcJeY9UgDBeA0H2WBMrC8Q3t+9/eUhUipLfWN?=
 =?us-ascii?Q?rLmSVPfgDw8XifAulK/Pmd3P7gFNdDaOIhxW5NZIude4JFXEwyN7A0vcwcXu?=
 =?us-ascii?Q?PHuBQHnVnJYGinIsxtyKoPUFDVVHC1j8kBnTUr6q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f0cea52-2f1b-4a57-b364-08dcf93f498b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 00:02:19.4087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: goO7PIpI/Op8Xu0Z3cgcTzsU9IjCqt96W/k9wx3J175UZ5bZ+u54dPbvWByVUcSF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9148

On Wed, Oct 30, 2024 at 11:34:49AM -0700, John Hubbard wrote:

> From a very high level design perspective, it's not yet clear to me
> that there is either a "preferred" or "not recommended" aspect to
> pinning in batches vs. all at once here, as long as one stays
> below the type (int, long, unsigned...) limits of the API. Batching
> seems like what you do if the internal implementation is crippled
> and unable to meet its API requirements. So the fact that many
> callers do batching is sort of "tail wags dog".

No.. all things need to do batching because nothing should be storing
a linear struct page array that is so enormous. That is going to
create vmemap pressure that is not desirable.

For instance rdma pins in batches and copies the pins into a scatter
list and never has an allocation over PAGE_SIZE.

iommufd transfers them into a radix tree.

It is not so much that there is a limit, but that good kernel code
just *shouldn't* be allocating gigantic contiguous memory arrays at
all.

Jason

