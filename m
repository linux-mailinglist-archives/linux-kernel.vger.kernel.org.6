Return-Path: <linux-kernel+bounces-364365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F02199D3BC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3DA428389E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A675C1BFE01;
	Mon, 14 Oct 2024 15:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aOJqo4DA"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF71481B3
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728920552; cv=fail; b=BvXToydYXdIofaTofYeXyuM/ivsXppk1EIarUD57g7+QbSg/8BMlFh7ZbqvMJemLEr3VCFmJBDyskVqCjVv0BzoohQC2rLE5q31gKBrpujVQMIsbO6yUT+0WJWHU9fKucaRWRgtrS506wdKQX+g4A2pT6AOOFqfzBegMEZhevqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728920552; c=relaxed/simple;
	bh=A+EC+uAs8ZKr61OELielfS/Ic9bQYY6kcTpwUTUeUp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RL0e2JCiqiiAFPQtaOCFoQF0//yNScb/zsqGgum0NmdiIqTCOCfjPR/Y3Q+V8is/p/O2GnS0iQ9RuUMpubX9AUUN1w7qT73OWMbUP6se4Q7yPE3ZigOzOt+oyqqklLZ1fQP/lLHLfhAuOjiqeVNVM/EGV9Zn3GhfNMBHGzct6Ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aOJqo4DA; arc=fail smtp.client-ip=40.107.223.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTn6jBiIbUi3QpKwksaCRGFXlR82SDMOchHRT2HGBV/WTfj1FmpO/bW+OkFy4rvBWI/C9es3dEDntXGCO3JYrqgTUpRdCsL6hn8YQM7L0yFGPkUeZ/vcuJRaOrNQPCg4jwxvaIjvsYILOKjbF127ZDsqb4Xo+X4esZ72x3jTXiuVbU+Z6jyO2iJkeoq6rOW46mLLFN5vqPRrI5ZO6c8KVYnrK/XhP+slhUKEJ454Dz5WhMnHgf2wjwQOdCzAKpqFePPKvsq5EJEB57P9peZ7vIzUu5cJvn13Ec5Wd8TZRIK4jMjKyfmTI0sBD9xz+J0p9rc97VE3tIx8uXQoKmjPvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2YUsEi9Ryx9bkmehMRrlsEd5CXNBOh2l3Gznu0X1lg=;
 b=I2bJTlrZurQFOr1O/TFnMqCgKSAdgP5kZaYGPOAmXCMNXAVvsZtiaiA/Gk4rfRfRI4RKZ7Mf7HJ+I29azsaQGVw9R48u/4lC3b9KwAh5D8b3Ew/KgPRosByXvKHPDfEqRou4VJHmZ9mRKUWW7WzG0djJvDvspidJfjJVpAgp3mCDqg7DoI/TT1iM2kPPQS45h8xD4i3R2I649RIef6jJhjG9sdAenpMdtt6W24WKee0TYAxTK6hN73qTrUjWUNy12OmGggjOClSRuNa2RxBiup90SkybF+TU6zCRDp3mqEP9gdlya3sPkbYF+sEH657HbwN9U4PHww1TX7k7FziEyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2YUsEi9Ryx9bkmehMRrlsEd5CXNBOh2l3Gznu0X1lg=;
 b=aOJqo4DAYu63Yvu6MkuR8YQ9LduJcs8VR2eHmoaB4cy43hUpaZ/anjLJTCxKrICIvbws/n2y9lCN+dGPWr0Ey7EtimTw+Wj7MXmiG7ItWWlxSjOhg0XnyUb84VuTtLDrG72scaVoW8AFHnAvywrYeCXVoZ/JKhM0JqrrqbEwZpy+h88y+nHsZp0Y+/1+01CocGdUoM1719/1W/rHk61OKP/DsmMkLOyetNf/uuuN2QUfjxShktOb2EX8xv/RFkEMQfweql/GpFfu/8M+kQo3wfUWxOl7uFgZQZsyT8Eg1uK+DuezV7lOnMEY5WjJetYF/vyKwwliHAP+jDKIeM2K3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH0PR12MB7792.namprd12.prod.outlook.com (2603:10b6:510:281::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Mon, 14 Oct
 2024 15:42:24 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%7]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 15:42:24 +0000
From: Zi Yan <ziy@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org,
 david@redhat.com, 21cnbao@gmail.com, ryan.roberts@arm.com,
 shy828301@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: khugepaged: fix the incorrect statistics when
 collapsing large file folios
Date: Mon, 14 Oct 2024 11:42:22 -0400
X-Mailer: MailMate (1.14r6064)
Message-ID: <C40089DF-C1D6-4A62-85FB-DAD3CC76844D@nvidia.com>
In-Reply-To: <c76305d96d12d030a1a346b50503d148364246d2.1728901391.git.baolin.wang@linux.alibaba.com>
References: <c76305d96d12d030a1a346b50503d148364246d2.1728901391.git.baolin.wang@linux.alibaba.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_F42BD5BF-E6C9-4C36-8AC8-FD9B607E1EE5_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAPR03CA0169.namprd03.prod.outlook.com
 (2603:10b6:208:32f::21) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH0PR12MB7792:EE_
X-MS-Office365-Filtering-Correlation-Id: f958f26f-bd96-496d-02a9-08dcec66cca1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vlvEZHD9/PQOY5aYiCueNQztnxu+jiKFXkl/uUi0pqHhJi/xNxcU9c+eKSdA?=
 =?us-ascii?Q?a+D7739KScfAuIfWGWC6UkYh1c/YklsozeIGLAJ9pBQP17uXgFbQQZBh6Uvo?=
 =?us-ascii?Q?nfEYhYmgZ1sQ3gCSrNMe0avjuLAwCtUfwUhE+8Iwik3qnqfx4lguEtfeNjz+?=
 =?us-ascii?Q?dSBgtKcgAR95D62fRpvWeL83AIKFH9tB4m20VAg3PuQ97Bo7zkw6kqygZJek?=
 =?us-ascii?Q?mrwUuVTL1taqJigu31R/eFIBAhWU/5tRROkrJ3P5REZhOUYNJkFibIlhbUuU?=
 =?us-ascii?Q?ExhT1kukVhfru64fAXxTQJ2qAgwHG7n4OdNwtettUtrJaSDdat8SJNmlXoK6?=
 =?us-ascii?Q?61qIDoicFIYqcZvF0sYbGXETDQ2ed9uHcYeVDu4SbTHEZ3uDyjOyTsh1zfgC?=
 =?us-ascii?Q?2UywTZ2kLZhqvL+5gHTav3Re9+teGYaCqzkfG8DeSn2i5NSG3mxSb+1LVCiH?=
 =?us-ascii?Q?D7dkBen8+L6LC62C3iCIBFegr9XcLXIahazdp8QZJ1IPFWjclDXNCtIr460T?=
 =?us-ascii?Q?1Zn/i5kZsk/Y5gVCR5WqUBZEqrQOGyFCXz/dP2KbYPaZGYdVRfmkfixfsl2U?=
 =?us-ascii?Q?IdJnh9CkTa9PLbIIozpOfzd+iTPGxb1ImintVXvbk2Q/qMVbcFY44fZhXBNB?=
 =?us-ascii?Q?jmPlIGtvBjyPIkJWfDzOUHyE5tuq9deWNp5tNZcBni6kFnrfFm45oesACNNR?=
 =?us-ascii?Q?WYSpCAx2T9zlj671P0eB+54G8nlWNhQyzqwZqQX/Jo4xZ3eFhSoNdrdOGn+R?=
 =?us-ascii?Q?WgrumTwISYB0m8cNwuvl0UVe/S4Tz44zflqUd8G/IZobPj/tnathgGSFxlRc?=
 =?us-ascii?Q?9HcTP41yLlx0RR8qALyS0WG53lkJ7uA23k2nuAcZQVN3U4JFNITvyRJaeGC6?=
 =?us-ascii?Q?qH+NkDqau3WxeSKra3sc3/MGKy7TbHBULrjN6fZt+j4zVKzTwkIX2gpNjp/Z?=
 =?us-ascii?Q?zoSWNOZiwPEg/JaviT2z+sY/d8ewRIqm8yngXTkeZFHgYfPYvN4INmCcsvcG?=
 =?us-ascii?Q?9jF70AF4Mq350oQRaG7OoyFxY6LZ8uQnlAPw6OGEdSdjXSAA1mpeXGkd5pCm?=
 =?us-ascii?Q?hmAvUVMBLR0hvBKEbMMTYDlvS+TneIdjGVJn06/CEJH3mrazf1aoFz9GjN+R?=
 =?us-ascii?Q?+pg/M8vGSN36Wg4h+DD5okn+arHjihhuY6n0WJm2TezllUj3LeDGRNH1shil?=
 =?us-ascii?Q?1RSznk3/bxLE7/maHqPu9mJWNyWnFM7kqQmTN8qpXBpSwhRsXvNxtdCfM7yV?=
 =?us-ascii?Q?WTiUyZ8kCxhe0eJWmlEOObtBCC42Nk5t6VlYr8wKsw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sshn4Ah0xQTNZBDA1uha+fMyCLfiJNhusqH0JzjrXYbveBqJUVYkHLBKzjGU?=
 =?us-ascii?Q?xTHwZ92wfZYlw9FCnclyo5aXmCRhoBrFLdIDy5IdVXWVROnk0sbJ96v7qHPV?=
 =?us-ascii?Q?rn1Ovq0AyiD8HAItAhcKmaeNOX2hwnBCTjdGP91wwH09mty5jnOycYlR5+C5?=
 =?us-ascii?Q?V0sPgz2SYxHhgHPuNgsBZNIqKH67otYQ91fQ7evG0V71CgasCjpdT7Qdpc1q?=
 =?us-ascii?Q?UT5Qmk+TsCutnVPUMumVCBC8KJzZ9qVNs+OKKDuRso8MZAduNBPAKIh9BQsW?=
 =?us-ascii?Q?2uyRt1FY8UfUiA/acLIseaTTQqArHWyfgLxtyFX8SdoECGyvvM72g9Bkyc8B?=
 =?us-ascii?Q?gYGENcc7rvwHW4cai5V22d6NSbHUvcV3+jsixHqaVZhaNgYjHR/Q9UI6mqD1?=
 =?us-ascii?Q?S/z7WDGlD/qYD4ouaO3BEHiKGSzN1UZ5InjcyzGIyOGEVZWDvk7vrW2/JAg9?=
 =?us-ascii?Q?RgUbPlTHavku60e4REGPceC0KuoFL8uQvPbrWY3BMx6eX1PKCT1PsPCxfjPp?=
 =?us-ascii?Q?rnWer3cWCcJm/BWeHHgbUVHBcdiD93i2J58rBUKBf+qwt/2Po5asHmm6/2oD?=
 =?us-ascii?Q?BHrIF0F/9Ko2/Ng8sFgs3qVpBKcmmbfdFDqV5y7rcfLmZXRg+03LWtqHjEV0?=
 =?us-ascii?Q?zf574jaT74W7c63oT7RF1BZfuInLn4S8F4S8Fq7jE54WtCtEExlC5OMRBoHP?=
 =?us-ascii?Q?6GKmqcbPu1KNxaleXvsxxNi+I4Q9+oAcAFRc+dR7YDvqNZOTVMlUUecGbYpB?=
 =?us-ascii?Q?tn5IAdj04QlkNraXbmdZ92a+tNmkB198vpVIsSNFQP9L+8n77D8E8FFGvaW4?=
 =?us-ascii?Q?RCCwFQAAdCPN9Q6lIfOJhIpdgHydCj1SkoZRafi2F1kK0M58PQgskUNubiIs?=
 =?us-ascii?Q?QLmWJFKz9hJEL/Vt1ir9l/nIQBoobsym+u1J+0ix4ff7MTB06JrBNOzst1Ov?=
 =?us-ascii?Q?TDIJmXQZW8FD/RUvsR//kA39abFMdn2ghooEW2WNK9g9eH1FasQuYFEdQ2k5?=
 =?us-ascii?Q?H2VjDxxL/JEG0rkvpF1HVR1/4otDp8uYDLUS43EfF5U0SD1ar1hbqLZwB50L?=
 =?us-ascii?Q?M00SRMzScc3hTBq8nR865UY9CVkHXXwnzz3PdvN8tCPjntT7LcmFyxmcGnT5?=
 =?us-ascii?Q?ypdiSQXo0xL/cKX5kXxIMDmA4KxU1GyMXrAMsOLLwdRgGsuAjjYmccCa+H5k?=
 =?us-ascii?Q?hfGEro4nMkF+KeyWk4Zaa3voLOv1NaSzYOlhLebbBP8KuyTfeEJK5mVNS9iA?=
 =?us-ascii?Q?GzFv4J8/0ftTKqgckcqnuGmNkcDXXTBJBB8/alG+HClsyvJ//z2ck1ztE+VM?=
 =?us-ascii?Q?6wD1U8b6WBZgOZ3UwNSxcSN6sy8d0CRdzcQuHHdghapPxv+Wvg+EERkacVbQ?=
 =?us-ascii?Q?qMsTVo/8M7j3ThUfvUWjK/ee9bDNQsDwY5eFAwpXwp80+5H069GQS3UFIydG?=
 =?us-ascii?Q?wj2Ax1nkHdYYrWmKe0+JhVYKuEhLzV+Xm5mF3mo8D5pTDK0358Ra2rlftLR3?=
 =?us-ascii?Q?WqK6MUkQ0ItfuXYZR3Um72XVyptro0mA6MOeLchF55olymLrfYGEaW1S1ppV?=
 =?us-ascii?Q?1XzntvTja/j4MerHRTE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f958f26f-bd96-496d-02a9-08dcec66cca1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 15:42:24.4586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ZGrobmWFAyAZIcQTLsWU2R04gDiAnK9qq5zpPJPxA+LE1WAkSP7wQWhrUAkn/q+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7792

--=_MailMate_F42BD5BF-E6C9-4C36-8AC8-FD9B607E1EE5_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 14 Oct 2024, at 6:24, Baolin Wang wrote:

> Khugepaged already supports collapsing file large folios (including shm=
em mTHP)
> by commit 7de856ffd007 ("mm: khugepaged: support shmem mTHP collapse"),=
 and the
> control parameters in khugepaged: 'khugepaged_max_ptes_swap' and 'khuge=
paged_max_ptes_none',
> still compare based on PTE granularity to determine whether a file coll=
apse is
> needed. However, the statistics for 'present' and 'swap' in hpage_colla=
pse_scan_file()
> do not take into account the large folios, which may lead to incorrect =
judgments
> regarding the khugepaged_max_ptes_swap/none parameters, resulting in un=
necessary
> file collapses.
>
> To fix this issue, take into account the large folios' statistics for '=
present'
> and 'swap' variables in the hpage_collapse_scan_file().
>
> Fixes: 7de856ffd007 ("mm: khugepaged: support shmem mTHP collapse")
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/khugepaged.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index ba28ba09fe89..6f8d46d107b4 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2267,7 +2267,7 @@ static int hpage_collapse_scan_file(struct mm_str=
uct *mm, unsigned long addr,
>  			continue;
>
>  		if (xa_is_value(folio)) {
> -			++swap;
> +			swap +=3D 1 << xas_get_order(&xas);

xas_get_order() scans xarry sibling entries to get the order. You probabl=
y
can call xas_get_order() outside the loop after rcu_read_lock() and use
the result inside, since xas order is not changed, right?

>  			if (cc->is_khugepaged &&
>  			    swap > khugepaged_max_ptes_swap) {
>  				result =3D SCAN_EXCEED_SWAP_PTE;
> @@ -2314,7 +2314,7 @@ static int hpage_collapse_scan_file(struct mm_str=
uct *mm, unsigned long addr,
>  		 * is just too costly...
>  		 */
>
> -		present++;
> +		present +=3D folio_nr_pages(folio);
>
>  		if (need_resched()) {
>  			xas_pause(&xas);
> -- =

> 2.39.3

Otherwise, LGTM. Thanks. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_F42BD5BF-E6C9-4C36-8AC8-FD9B607E1EE5_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmcNO94PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUINIQAKSrXf2hOdMCRgNShjg0ML7HLjWKWWv0AE2D
4gyj5nA/VUlJIghmMtS9Ztyh6xvbsdfabs8mPyXND1JNhQTd6WbR3ks7nPzRQWaX
HvNJlOgBGK22H6Ie1mcDLe1YLkl8F06nYPZ8S9etdU6fsZS/g7sbYBV8iQVhFFtS
HVanPGk/xsf5knq8WHmR2j3BkhVPPeKfzklQpsG1qy7SrFVU9NpZwClEIDwNuiy7
RegubwLtXzlAIapNYrd64YvyfLeCAaJjSCNtfa+vHO8RZwqrFWRt+rah1B2BK1Ys
48bp7WYsep7DWQAla7aAVHVFd0ChlPYKstWW6VXfmGfuRrY/tcUu9q33ivlbJMX0
cZTjgozTOfLuhSt48gDvsPZASdahquFnXuVBjOBeE14m3wZR9f5sV/MzD70mdfZ8
UTkYrN1G1229yT2IrnRY94HGQqdNmRbdrXdS2awJ+qA5gLYFn96JEa7WihvhNZ1f
cMU9py9aV9dS/JZUoU5VmSD5LScWdp43MYzx6L7FMa1PcVFXMJPxmotm87b/ohmF
NQP92zIqGYN7pTbfcnyyg6725dTk4RNrwUy5vbrDvg/Oh0EqEaXv2AOqujwlfbDK
3mBiBYcJ9KGuKOXZe7eyXWKecMBm8KEAYUkeVV2aSOy4bhiktQJCEl0R+Hizgo54
7SRLCdCY
=aiPK
-----END PGP SIGNATURE-----

--=_MailMate_F42BD5BF-E6C9-4C36-8AC8-FD9B607E1EE5_=--

