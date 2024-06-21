Return-Path: <linux-kernel+bounces-224794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3D39126EB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60C6628A4A8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92C21CD38;
	Fri, 21 Jun 2024 13:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OozmHnbM"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE92F11CA0
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 13:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718977486; cv=fail; b=cIsUggsRZHH6NtI+7zmpFCKg7FxUi+kG7eQ/D1ScDP0VwHEm/hhdSI/qxfnIJC6mPe0AxWYI4syy+9RiOThPCeit7d33nWbJkfgxdb3khiHXQQB6Um66ktnJHoaum/mQmLGeu1gsYxJNcNkjgdF9jyiO+1y4yDf1xTwYx+DvlNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718977486; c=relaxed/simple;
	bh=+SPzQW+5qprJzpf5agfUCWo1P9S+FSS2+X6zchsNvMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=twl70rLlVksUHMgEuecEeTVToOA7k8eenKRyp6QeivHbvrDrglU0a//XAdAQ6o5WawP1H+NXl1PC+KsFeuuxP4pmG1uhR/KgCtZJyA7NWsZeQiWaUMXBHXoGWlrTbMug/VkNAO/SaWkl7bs/qURNguX78gtv9jThqcaGwrj3EIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OozmHnbM; arc=fail smtp.client-ip=40.107.243.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hk3YpPl+ipUtcaq53ellgPpcJOkqKLZjKnpL5kDfGPvUNxII50Go6dOCnLDbUUpQerlAbSCHqCbLKSPjxXpDOcWmqcQ5BT8DZkGF+qKl6XJWOP5j21VMZS0C2hTGK5OcoZ+fAufuAAjhW7zYKyVAdewpxk8p/aKdFtmKMIHB4zEgG6ot5elbggg6eHFzPFA4moF6d0bYhpbSEbjYTlRqaoky4OfxCM9GxKAkQ5+qXeFD3Pfts81v8d+PhQxPvoME5z+hyADZHGmQTfj14hNLXFvUmwNG+ta4XHllV4htlbD9Lx1L0UYEzHiJ/WSDmMAncQBW5zf18l3cChkqvBMXnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/iuTXRQg7PIvQgQ5mzyi3cKyaXpqXg8UVISaoj8wdyo=;
 b=H+83CRxacQ8CbCiqGEJv46lKSqpxyaTl9CwKxBsgtEOUPTFgfFDKfwIm9Fel19pxItTNlus4QKZChp8pBzLlT/L/BqsYQ/XNUnaUS0HJYXuroeVOgJWrbAsjCj6OgQT8j6beSewQZ7ZQh2vt62fgRGAQRc4jM9EnKAVCoL339BmGWsaPy2UtQGWgH7B37Zg9Zba0L2qHPcejCzhxQk5Ces+gmWkslELpKfCHyq1+7WPlMCc5aQloKgrMV1g6VUUqD5oBNppHpxOGgap8ocRYJkvfEVCQYQWtMm/OxnspkNMM/NJ/UYbI4kGjyBhwLM/MvarLcXX38tEX/xA5x1W/lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/iuTXRQg7PIvQgQ5mzyi3cKyaXpqXg8UVISaoj8wdyo=;
 b=OozmHnbMag3+44gs4GBZPpgaPefhWUWmWUyEwZgn+a+N5Dn8X7TvLl4TkPJv3gARCMdny2jmf9zZGnwWIHv4Urag61zBq6dRps6baT9Z67WcgwGH0lIplMVSeEAh/oMxKfBbwv/SZEu0VlZp8/wMoWYxhoMJ2/8D67qGNyBSsTRs51wbcgP4RFvgaRrQdMfTn/4SqiKjLxaHFEXcxcip6URt6sgb0U/fjFuTbkaUuksUhlunO3i8MB0z88uSsyJrDhpGvV5PLBzsF8LSJqiOmxEyFv9Qv4GXSUvdPgsltHq44olL0qYDFtCUhq4Wmlu3X/GRT3EUWTpF1ZZeYbC0+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH7PR12MB6489.namprd12.prod.outlook.com (2603:10b6:510:1f7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33; Fri, 21 Jun
 2024 13:44:41 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 13:44:41 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 2/2] mm/migrate: move NUMA hinting fault folio
 isolation + checks under PTL
Date: Fri, 21 Jun 2024 09:44:38 -0400
X-Mailer: MailMate (1.14r6038)
Message-ID: <B726B923-E023-4E56-BED1-BFA5CEF644A1@nvidia.com>
In-Reply-To: <20240620212935.656243-3-david@redhat.com>
References: <20240620212935.656243-1-david@redhat.com>
 <20240620212935.656243-3-david@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_A51644BE-4D25-4FCC-BCDE-E6E5EF1C97DF_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0335.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::10) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH7PR12MB6489:EE_
X-MS-Office365-Filtering-Correlation-Id: 1707db30-cd26-445a-4dd3-08dc91f84cd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qUpcMLGWBL4R5C+8O7ptLqoZagSNBHZygTzlE02FoRdHSmxykbwL//gkYKrp?=
 =?us-ascii?Q?2QR+O0kGF8Y97AxwVfl/cHnAMYJht39pUmtHppVACgHTWsu3D0NDo8bQfdfu?=
 =?us-ascii?Q?Fy+hKUf1xboN5S/nTjTS57qdpNhaUt9GbjIToVhB1wzWKupKqxhlO/01Jj1T?=
 =?us-ascii?Q?Eaa7AyHndhX0PAibsgbEBxRrL1DjDsX4iynCeaAPQ3d+qeAx3PP2NHiiqZID?=
 =?us-ascii?Q?Og74rxjUdyzldkQ2i+kPVgG37F07GHXCUfNwJ2VqPBlyIC8iRbaj5jJSMMMu?=
 =?us-ascii?Q?Q3KH8ulCYjljP7J9955pRQ4KkwE09diEOlNuOrqF8VD1yCL/reRbRjFoRHdF?=
 =?us-ascii?Q?kL/UYqMFDEmw/zbhilyKhKM1c0iOlvPQPm/LrU7ZdMdO/4F5gUEI/IbSrVQ4?=
 =?us-ascii?Q?6GSdWi9A5xN5WyQ/8uWf6buS7m1xKKB//N2ITwQgQsfFRcuz0GULJVCEjB4z?=
 =?us-ascii?Q?YVee0CDDMYdQzQDjoOQqiNFen7D6Hy0YuoeL5osu5gU9MmDpVLuJ6v3BLDOs?=
 =?us-ascii?Q?6bIm+Jzw7hljQvNKthuE/2PDVve8+M1e13SogKu0OArrzMD3oa+Wt57Yi8BL?=
 =?us-ascii?Q?QkuAM7iNDw2kQ6swFj9VdpwBEcyLa6v0bDTUo65l7VEHLD/0J0Fh9Mp2EFT/?=
 =?us-ascii?Q?3x8ZcKHTqjvbWx8DjssY+XcSNRVzfMdUK6zJnsS+CvpOGjytcQL1SyUhoZ9l?=
 =?us-ascii?Q?dmF+69s18yJNIZlHly5ySzAR16gP6EFYv45y7NeomPVnQluzsn1W4NVpsQY3?=
 =?us-ascii?Q?t6dPK9bX2GNFwHKzcWkm9a5pSQNeLfpihEKers8wSlg9pHA0wzSHIdiScCOv?=
 =?us-ascii?Q?fHgE6ysHoUkEpFlIXEUqtI/n+BpciRNAehzESokdcLLAJ3omM7G5Kct21ETA?=
 =?us-ascii?Q?TQh/Bru48aTWld0pP4glXT8Fz9F2WV1xqH6AjbLz/7QBh8EfzAWvDlHrEvWT?=
 =?us-ascii?Q?/Pa34SBMBtR3BZlzvuoOMcUCly9rrK689c+O7LPS63dI4VaEdUwpv5NVFADW?=
 =?us-ascii?Q?fpgRVR5oWEXIKd6xbSSy8AnlT8oI4p8q3EqPdXUOuWAq/w1sXLgjelcLtBvr?=
 =?us-ascii?Q?LUaUcvIzYyqZGgPWMEImbbRLeSNFFDngLJVDXt6+AEQknekexPEkiRY04a+W?=
 =?us-ascii?Q?ygvVYRTx7621dFyqrjtIt6TvtuyXo0qCigTKY+Dsqyzq0Pv1qMnib64UxyTr?=
 =?us-ascii?Q?J0fsKXrjQzbi0R5aGcwSRiMh+2/Y7AgaJhNX/ue5YGuUjdaO9YPhrFN0VPY7?=
 =?us-ascii?Q?EZcdeHRWYV9ikWYH3uqrGaZzUsk7sfwBR0Efm81VOVx6Ulgc0QiZdq89w6Dr?=
 =?us-ascii?Q?kek++be0h2VZQIKr4FKrqCuk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N9abD8gjWrPujtEh1m9//jvQdBj5Nq4dfLcUhpsEovCO/qrMuP1Z67irm0bl?=
 =?us-ascii?Q?iPXScS8oXg9+hbAdHnO5ZGvXo5nbwAozorCWotnXjBtaoJ2TH7DjVtz3QfRo?=
 =?us-ascii?Q?2BuhAdjLudCcE8Di2Kmb8wR/dB+NtDr+3+j1X1+PMMY7IntbYCzXbwudsIV2?=
 =?us-ascii?Q?t1MMXCkr4obe3YG//LPiw/H5xPBd7FsfhmdQ53UGLzmEvE/lrj9mzji4RW5l?=
 =?us-ascii?Q?nDvTRsQ01LIhYm9cgZIk1GRfQh9SwSLWd5Gj30CSpJr5wzFSixyMgcBgi56j?=
 =?us-ascii?Q?bOqkZsJ7IDDjcSM4hW3k290Bd0Yb+k+lg5H1iYBne9akiKFLhm8hkK+AqjM1?=
 =?us-ascii?Q?fbdnimfc93SoO7t0D8WTombSoiRM58LPDWhhSyD63J51MuXOmsytFd5ULs8o?=
 =?us-ascii?Q?YPUN4ldLwiFW3XYW37pUxyuE7K6znAQI9FB6JAqxJKk7PY2yrCvIb7OlRRYC?=
 =?us-ascii?Q?LFf2rQ8w94QUEy4gYZBAsnglaNm0sQWMOFq52KX8hGS0c6wEsE+RVcQgA8PL?=
 =?us-ascii?Q?4xaCOhHj3urNksmDySRkgPTVUNR++yOFKQ3ADhxEHsr/NO7bamv8SXbVMQvU?=
 =?us-ascii?Q?/ycxiPEO757ONlDYX368wNOgY/YufCrnjibxMVq6fgfsqzKyzKP2TcPx+xMC?=
 =?us-ascii?Q?I4zuBbtlKnv5LysJjAw0VF6HIJq1NJz2sOZ9PQz/glpnY6HD9MGySiE587j7?=
 =?us-ascii?Q?kZpEC27wWG487T3ObH+tfkcpD1D2Tudw17/SRnfPy9+H7fD9RV6fzzCsnafB?=
 =?us-ascii?Q?io/tafPboVfR1pwthf4sBRqsnPZNve+9seWEx2jeYL/x0mq0PEr5a9GN4cAk?=
 =?us-ascii?Q?cD3U3drA/gI/Tt/rsfj7U8a5qriP3nweBNPTg2kN45pWATbTh+dSI5dsdmIV?=
 =?us-ascii?Q?y4T6d7cQzF+M47PJ5ac0ENaBJqq5DsQITmWOWMcaF2OinkghVdcgA0BtMdqg?=
 =?us-ascii?Q?6Zqw7TQYO1EMF3t/35T/42Eb1qyTxO5lCPR8gOc7Zvdz5cjHgTVoqIhAf+9c?=
 =?us-ascii?Q?bmYmepbkbalPBydrPyR7Q8FobSW0TnlITLur3r3drFys40moOrOMkaSGwHRq?=
 =?us-ascii?Q?1n4M17Hd69ezfsM7RAQ/CRNG1fqSp7yCpj3AVuC2qI3ptEut//LQB41Jvv2n?=
 =?us-ascii?Q?PnVtEnssGmh4O89iiPgRK1iNzixzbwlGqWl22/n8Edq3T4x6CJaLmR1DZXIY?=
 =?us-ascii?Q?rpd3CljFCSJrzad9q5r1OcLdgrqfZm553vzxaggNA8AbvLkMulUZB3HaUoVR?=
 =?us-ascii?Q?5B+mnN9AGE3bb2BEJR2q0vbB5VreY7tOrzElaRGyJeDVc36i9a9XxsjgNDAq?=
 =?us-ascii?Q?bOFnZe+UvZ5Y1C5GJnKjucRQPozFtn2JnXuU5xOOQASWZNhY48Ii0I2QHKKs?=
 =?us-ascii?Q?9XOurMMmPNQOdp4qfvYX+9f03oKopsMtqf+P5LGcyG2YjvgkpS5bQN7e6X5J?=
 =?us-ascii?Q?hU0GZjPSHtXDqpsSrUhF5xNB6FgVfgdra7zWwyHUy0+1oHRnqvJNoYdKNy8h?=
 =?us-ascii?Q?0ZqcPLoLNom3hv68UXVXOL953WF7cOi9Hi5jlYqD876uyS/XGoSEvck81oQv?=
 =?us-ascii?Q?KRcYa1PwWoY/EgsRTNc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1707db30-cd26-445a-4dd3-08dc91f84cd2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 13:44:40.9129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SDeRPW9Ds9p0DL5vMYhrWOc07g8yBIZJ7wnO/Sax1s6okQLA+sNwxnPhbKjZzxrN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6489

--=_MailMate_A51644BE-4D25-4FCC-BCDE-E6E5EF1C97DF_=
Content-Type: text/plain

On 20 Jun 2024, at 17:29, David Hildenbrand wrote:

> Currently we always take a folio reference even if migration will not
> even be tried or isolation failed, requiring us to grab+drop an additional
> reference.
>
> Further, we end up calling folio_likely_mapped_shared() while the folio
> might have already been unmapped, because after we dropped the PTL, that
> can easily happen. We want to stop touching mapcounts and friends from
> such context, and only call folio_likely_mapped_shared() while the folio
> is still mapped: mapcount information is pretty much stale and unreliable
> otherwise.
>
> So let's move checks into numamigrate_isolate_folio(), rename that
> function to migrate_misplaced_folio_prepare(), and call that function
> from callsites where we call migrate_misplaced_folio(), but still with
> the PTL held.
>
> We can now stop taking temporary folio references, and really only take
> a reference if folio isolation succeeded. Doing the
> folio_likely_mapped_shared() + golio isolation under PT lock is now similar
> to how we handle MADV_PAGEOUT.
>
> While at it, combine the folio_is_file_lru() checks.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/migrate.h |  7 ++++
>  mm/huge_memory.c        |  8 ++--
>  mm/memory.c             |  9 +++--
>  mm/migrate.c            | 81 +++++++++++++++++++----------------------
>  4 files changed, 55 insertions(+), 50 deletions(-)

LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

One nit below:

<snip>

> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index fc27dabcd8e3..4b2817bb2c7d 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1688,11 +1688,13 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>  	if (node_is_toptier(nid))
>  		last_cpupid = folio_last_cpupid(folio);
>  	target_nid = numa_migrate_prep(folio, vmf, haddr, nid, &flags);
> -	if (target_nid == NUMA_NO_NODE) {
> -		folio_put(folio);
> +	if (target_nid == NUMA_NO_NODE)
> +		goto out_map;
> +	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
> +		flags |= TNF_MIGRATE_FAIL;
>  		goto out_map;
>  	}
> -
> +	/* The folio is isolated and isolation code holds a folio reference. */
>  	spin_unlock(vmf->ptl);
>  	writable = false;
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 118660de5bcc..4fd1ecfced4d 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c

<snip>

> @@ -5345,10 +5343,13 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>  	else
>  		last_cpupid = folio_last_cpupid(folio);
>  	target_nid = numa_migrate_prep(folio, vmf, vmf->address, nid, &flags);
> -	if (target_nid == NUMA_NO_NODE) {
> -		folio_put(folio);
> +	if (target_nid == NUMA_NO_NODE)
> +		goto out_map;
> +	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
> +		flags |= TNF_MIGRATE_FAIL;
>  		goto out_map;
>  	}

These two locations are repeated code, maybe just merge the ifs into
numa_migrate_prep(). Feel free to ignore if you are not going to send
another version. :)

--
Best Regards,
Yan, Zi

--=_MailMate_A51644BE-4D25-4FCC-BCDE-E6E5EF1C97DF_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmZ1g8cPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUo3MP/0u5BTLl/ev2Is9hHdE5cZOwEsnU4p0BSu6d
e5QqNxj9MN562zrz3dXd4aYZFl+JeGDTFkhL0Mvsu+5L/txlaPUPNuXPuCdoicFJ
PUtGhKVwU2d3YpVtnDuwABBIIZxtf15uRDK++l7CFTqVnoreBnKOjiLKKqOQ0ubR
KCDXYfW5pNBXU79flCnxMajwAttnSPYpQZ2k217/E8lHyyIJjnF1MwoSEGV6+vSM
bbf/m5JfYVHJsrzhj94U24dSYQLhvHE5nFFuX/a4E5Q0aVKBRtd+yPa7cDaJGzQr
P2FVFXqIGf+QuUABESB776RXyS22Gpk0nxyB3JtlKdTfsll490+K19NZPXBecV4+
y2vfRR31NU4wiU+f87zxu5TrDhze77Nuedv8T291HfM86iN4IJtMA0Qn2jx1X54T
IxnLw/N0HDp0CkjBznfUlayj900WJTFmfdGETfY9puKqH0tvRCFML4N1we9d95LP
SsjZEtn1KtEOiAVZ4ZX1HW1hGyb9Urkyxm/XChyOXdNsPJdQT2KFme9+mu5LLLws
ZflptqNsZxM9WzP3ioqFWZ5Wo3KBtwe9WyfoGzr54+bVTPdIXw0ID5+9NgVoXnQs
Oz4gSxIclsyIVXG2EbwfSOy2Qf7pay9lMnG6HrhKKuGMP+L1pCTbffXUIpcAy2vm
IsOUxzzn
=H0eh
-----END PGP SIGNATURE-----

--=_MailMate_A51644BE-4D25-4FCC-BCDE-E6E5EF1C97DF_=--

