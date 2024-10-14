Return-Path: <linux-kernel+bounces-364811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D1B99D9BB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 00:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED7F81C215AB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 22:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8994D1586DB;
	Mon, 14 Oct 2024 22:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KzLPxOzC"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3F913BC02
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 22:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728944522; cv=fail; b=oq18z+TLI8UBUGPBcbwP2bFA8LcNe6sszDKLbXKQsJ/4GghPrdS2dV+WSNuSi+thYpzWrryVA1J4aFNEQdS75TdyAI28jcnCWhEldjUZZTAXy3wBULkxYDgsw+K4dbZO9kUU/ectEv3o4JaewrkJIfai8j9FBz6ZiMnCjs1FBXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728944522; c=relaxed/simple;
	bh=mpOZUzlC/i5Jtbg4pmMC8v7HQeig4pa6DUm3MVfKZlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FUA8SrJG6TqlggrnHGslrI4snTferbv3eBIqCr+lEOty1qK81Ntie3iOzlJY34Sm0xLFIZOrpg8I+rbSQQJq+3xA3FGTa1vX07BljSEjSLZmODnOCmKHdtbugmfo3kbypME6wJRjvetqSp+8c2MlpONjamfS/16Blk8RUZzrwzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KzLPxOzC; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHIimo0Z3fBm/NRTu6uv9it238h+Up71PTEt5ESwOZ4fQtVBqZIZz8Y+hJc1MtowZSVJtFv5xlU4iGu9LRzdb7t+aYYL+0/xnmSeC1MXpF5TmQsG/MGWRphnzv6XaAO7l8OIujvgJH+4zUkuJ3i6VJvGDenuRvIvITDjoR8mnG2QhHlFxAbrqeqjoACPmWs8sQaFs7YQNG6LHwQwkhSwHYym5GGcfSW6lRUVe8L4GaUYJ3BtATGV45tK6WwzD9LVd//b4KdOZCqyhae2SchA0IhzLHKOnSic0o5zHXJX9vQZ1l+lTbDDgujWRZft4Mn30SGfSOluftnhtgIsG4skZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jI+4jTO453uAl6TtVY4RQ0BeFrBP/dGRU5pk836Dksw=;
 b=wZoKrKCLLuXg7DEWT3HxEGCfl7Y+uXyEBf2nIH9M6daj9CMpcgalTcwaNzFWa/xQXgWqvSkB5alKE2HfQGLCKM4ndqC8y7tSeH1H2wXQpUE42h81+wKR+3hAxaVDey8isEbqfkxkiLH2YZYZzP9AtXsWlsYBdGo2l8kOsrC8IyDzy36Wq2GMEGERHKAk52pbPnv1YAHUphnCudrmJdzCMBqg67dlS2RYDWnLkGpSZtjY6UdabySv4RKxnAq/IBKXhmDhDsDLJZ0hoxbugnYc2H160F1Tvi/isRd+cx5nQXnhcyW/t3gs7YJZE8IdgjMlXqG/zuBdXBTv8Csxd6YTFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jI+4jTO453uAl6TtVY4RQ0BeFrBP/dGRU5pk836Dksw=;
 b=KzLPxOzCz9EpUJWDL7bvasrHmPgR9TyWP/JWMNaL9gpurJweD3VLQsLsfEQ3SwOPeoKxIeaN6fXgICDcPFtU5G2LWpiPeMqRavneU6DhcG6OJGdX1gcClV6RGkFHkGhwHnlxt0ajSeQ/7RZsb0ej0Sb3ED7uyWTIbJbIar0FxW4lPqkBfevkGDizsYojfPO6655Epdsrg5smRY/KeIjOjFIawur+WYPbDeuFtzNR1bBaLNEzWsIgpTs9K5WFHmE2YNj68e2B8HTjUwb1cH6uzQ9kKqsL4nKItldFAV2eVRr0116UUrin+//M6kl5gmXZgAkX9euZggS/NL+4ju9uTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA1PR12MB6996.namprd12.prod.outlook.com (2603:10b6:806:24f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 22:21:56 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%7]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 22:21:56 +0000
From: Zi Yan <ziy@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org,
 david@redhat.com, 21cnbao@gmail.com, ryan.roberts@arm.com,
 shy828301@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: khugepaged: fix the incorrect statistics when
 collapsing large file folios
Date: Mon, 14 Oct 2024 18:21:53 -0400
X-Mailer: MailMate (1.14r6065)
Message-ID: <0632D5EE-F89C-4767-80E4-B990B5219F95@nvidia.com>
In-Reply-To: <C40089DF-C1D6-4A62-85FB-DAD3CC76844D@nvidia.com>
References: <c76305d96d12d030a1a346b50503d148364246d2.1728901391.git.baolin.wang@linux.alibaba.com>
 <C40089DF-C1D6-4A62-85FB-DAD3CC76844D@nvidia.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_6E284E4D-D8E8-436D-BEDB-4B12CC9C927C_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BN0PR04CA0083.namprd04.prod.outlook.com
 (2603:10b6:408:ea::28) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA1PR12MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: 78607b91-0687-4b6d-6e79-08dcec9e9cdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/wiojiae5AqU2rsMKU/SItnTZjykUHRZiCfJy0lomDfS7vpsvt0/G0YVUShF?=
 =?us-ascii?Q?ENoQBKGaBPeGUgsfjS3n9vWCr5/4DcyiF7BC3LUJ+qSmaDLAt2+DnxFXDPbX?=
 =?us-ascii?Q?GRlWb9ie2wxjj95L9u8hBut9Q0bpcF7p6UVEjTPQdgHhOF5PFnMMGtIpyxsE?=
 =?us-ascii?Q?FPuXSfED+V0nO4W4ZxIHcEF0NXeMeAFbwEiSxZQtH0BDVsfzR/NWsR7xpxZW?=
 =?us-ascii?Q?7Co2pJHev7xs93iQvQ9sUrQ2ZIv8TP4y37AHHJ4D0csbb2Xn3TB+hBtfN9ZQ?=
 =?us-ascii?Q?IT7QVkTD7KyBAAp2rjp9PeBLua9d9AL1DAkEZBt/PpOMFAldqE324tKlTVDa?=
 =?us-ascii?Q?kOAa7u6Fz4hbwzCedA6kuEx3sSa/6paigOS5JqSWW9f2izSR3peVCa6nOI5N?=
 =?us-ascii?Q?6mmueyQqFN5U6599JQNPzHeUtkNFcdOYlOYKMSChDvUbrXGPW/4cVsZt45b/?=
 =?us-ascii?Q?hG61Z0zZi6pwom76DpGt9xLHLyjOQi78dLIWF0ux4HmExz/lHDFlAujw6l4w?=
 =?us-ascii?Q?ruLCexWcoEMpl14ePZSdSACO+BcMrf+phCYLP+azXxraux7nfzMKy1OR/VWP?=
 =?us-ascii?Q?uLALUWB2IIehmEZ39FibtjpCPyMpDych7s2ctg2DQ/jFDztPFuIJELZeC0Tk?=
 =?us-ascii?Q?QwlhwPMKYdrEZXH2gzCFRqCqHfUrdn3ITqImMCkWE2JuVFIsIU9fOmNwbfZq?=
 =?us-ascii?Q?HxRK56Tdn9jNLT8oRDN/53ZDSBinCjREZZEKtCP97GRHWXQg8qYLCh3VzITO?=
 =?us-ascii?Q?7xD+faDQksbfuV/asQ7KTQDeuZKOZ4IkqfQFGrc5ykvtfG4GFVgMuPXGVqKC?=
 =?us-ascii?Q?ExH8KarlD4oVXCgLMhOW6Cmyw9NwBPvAqFTI+fou7tH+SG1NsQnoI4KHdAb0?=
 =?us-ascii?Q?zsZz/4cyGLV9e1GWaLU+asE6wJpmM+oP3NbmsSQtA3ZP//Ky+P15JHZ6xG2f?=
 =?us-ascii?Q?UfUi5bs7JdETEKPrz9k+Y4Xzv5Em6FBlpE0n5iCxi/03vb6c8B/hTIjTtv2F?=
 =?us-ascii?Q?5rwWXYXUA9e8LRW5/nDS5FvRRn3j7sbYZOZZh6tQCTqdzh3EAd6Wx07cyk6s?=
 =?us-ascii?Q?fIoKlUuVSHbCix3h+1bdillSZzKUgVFvJ/UIbZHn/Daikc5OO+JDbjKZnCLp?=
 =?us-ascii?Q?0+96QvWhhEWMfjHqQRTcbuKLe2rc4IgtchdD8s17ezwszTY9SKnCln7sHOvM?=
 =?us-ascii?Q?4zHPTeSbFD5D9QSf73PbhijYvMwjTcFjQs0ewXos5oTwmuiiBVYdJs1hTK85?=
 =?us-ascii?Q?C1Wk40vkXAFrxWThc6c2pItVhbNW/mZucBmE6FMwWQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?krZA1JXakS5xmf7Pyzp97yGDLXEVXAZzFrUtjvDHmoexcjquR9s0qZB3iiGw?=
 =?us-ascii?Q?qLwU7E7vJc/5S6CScBA49QPTAdbUDKpCh5YdnzshClrHZSb5nSNUKJghcuQj?=
 =?us-ascii?Q?InrTMU/ddK31msgMR4+zOwZuZBrtkRvodkiZEaalSHZ+u6EUETtglQNGOLs1?=
 =?us-ascii?Q?zVWJWM523hyRUDEcCzPAbTcHMSxY7ekqAPQ6oAcHNDeKgl2XanDAfdxxTtyr?=
 =?us-ascii?Q?0Fb03L5jXR8tINIqoeX3VprrHLQv/SntYQjiFHYrQFpj6e30OuWNf72T0pRS?=
 =?us-ascii?Q?Pwo/2JOBd5/w2APyK6K/lwwzbQjC/SuKYAILFk+94NaGiSLTN98xuEyUApWA?=
 =?us-ascii?Q?GA9Yvi2jALmjsJCuvWz8myJFK63ETOySkz7MoXuVr3JhEcxNBcDb64fxWvlz?=
 =?us-ascii?Q?IP2pbRsxkyj/BmR+3OHGn3rDTqYC23sPDmuRJBJM2NsWk7yjWT2dnNnuniIa?=
 =?us-ascii?Q?84VjAyvJMwkmAz/ge9U0q3c5koQ13fjyViZth4RxQyOLTN5aumAK5VlMBbDS?=
 =?us-ascii?Q?dgbafJVaHsYcClhxUXNBDSS4cFugBdfUTGE+DRmlZNFtEKOjQLzWY4TgSlT8?=
 =?us-ascii?Q?iyQo7O+AwO0v0FAm9WjLgASn8Lf0icVr/oMZQNFEeC6i1DvSf7mvvP7dSnJH?=
 =?us-ascii?Q?qMS3OmV6fbotyApEfuxJuiNl6BSugdQs6Q+6AxygVmwhZ00ATbOybBz50VLy?=
 =?us-ascii?Q?TQRhgcDkwPtCqy+ay0p7wkbvqe0vAiDW7oycur0E9LzORJM4smgzNjq3mivj?=
 =?us-ascii?Q?XtUsqi6C38CaeBCyG7FsJwz3aJOi+xEOGxPXinnvnDZTyFAUpF9fQD2BlQuG?=
 =?us-ascii?Q?zLLCDQWwPYwC1md/881+HW5pch1PHAd/eS+qwVB2SBIiI/ItMzyJNPPS+qzW?=
 =?us-ascii?Q?p2tP36BhJkWuvRVk8DcSHTuWC6im8BPu3jmFnoxjmeIQjgqyZz+bf9BhxTq3?=
 =?us-ascii?Q?j3nPrFtVVHPqgTv14cq3I1uymu466eopED1Co+aoe1oSvN/wjgeeshMfaCCt?=
 =?us-ascii?Q?tG1Fse+KpjjXAA7gXKW08hEJomi2Pvs1HmXz+R6zZ8AacGv1HjHubCp3eo/C?=
 =?us-ascii?Q?YDoVaOMG6uqYBB4Z1gDsev+7uXulBDgqI40ZmaUZoXWMbqON/8oadwoh5mg+?=
 =?us-ascii?Q?rIcBTews4sL5VZC/EC1nhsmB1IH9OpqfrbqD5wFmYnHJnAGyNgzX6WzpHu2i?=
 =?us-ascii?Q?vCVeAN25gqgT3Q0QmVGhB4f5fOqNLOMZHNpIwH2MWQy/AHFzqpQE9STBLgvZ?=
 =?us-ascii?Q?w3l31KtSMJ1KkfXANwPzaI8B6Vtwc+XrKzHEMd8biBt8LNqumPCkvUQj9xQi?=
 =?us-ascii?Q?37M5JMRLZrygPowsVUbJWr/e9xe7Vcc8QAl+iRLmyepP84G9gn+ztBxKkm/4?=
 =?us-ascii?Q?RuePhMTgYawDrFzM1rZJfnH+cR+1ZQkpWrkHO2FO3xlH36x0wgTART/xPWSs?=
 =?us-ascii?Q?zVys45Jl9gJvrXM7SjNZF3coE2uNo2rIQvnurVVsty3yke4z92aRlEohSMn0?=
 =?us-ascii?Q?W+8KFp//PWb87p66slOgYPsGXZDQlLXB5ivueuh87tuOoNkeMfer136Ntm6d?=
 =?us-ascii?Q?K+o5kJEcRXUZlc3DxOGV3ET19nMW51sHfRumudk+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78607b91-0687-4b6d-6e79-08dcec9e9cdc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 22:21:56.1970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eYh0L+oddgjlrjNWI+1egbVMQTVCB+75xIRWdnOpSbef74Xu/Y4n8qEPKgwniiKF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6996

--=_MailMate_6E284E4D-D8E8-436D-BEDB-4B12CC9C927C_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 14 Oct 2024, at 11:42, Zi Yan wrote:

> On 14 Oct 2024, at 6:24, Baolin Wang wrote:
>
>> Khugepaged already supports collapsing file large folios (including sh=
mem mTHP)
>> by commit 7de856ffd007 ("mm: khugepaged: support shmem mTHP collapse")=
, and the
>> control parameters in khugepaged: 'khugepaged_max_ptes_swap' and 'khug=
epaged_max_ptes_none',
>> still compare based on PTE granularity to determine whether a file col=
lapse is
>> needed. However, the statistics for 'present' and 'swap' in hpage_coll=
apse_scan_file()
>> do not take into account the large folios, which may lead to incorrect=
 judgments
>> regarding the khugepaged_max_ptes_swap/none parameters, resulting in u=
nnecessary
>> file collapses.
>>
>> To fix this issue, take into account the large folios' statistics for =
'present'
>> and 'swap' variables in the hpage_collapse_scan_file().
>>
>> Fixes: 7de856ffd007 ("mm: khugepaged: support shmem mTHP collapse")
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>  mm/khugepaged.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index ba28ba09fe89..6f8d46d107b4 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -2267,7 +2267,7 @@ static int hpage_collapse_scan_file(struct mm_st=
ruct *mm, unsigned long addr,
>>  			continue;
>>
>>  		if (xa_is_value(folio)) {
>> -			++swap;
>> +			swap +=3D 1 << xas_get_order(&xas);
>
> xas_get_order() scans xarry sibling entries to get the order. You proba=
bly
> can call xas_get_order() outside the loop after rcu_read_lock() and use=

> the result inside, since xas order is not changed, right?

Forget about this. Order can change. Sorry for the noise.

>
>>  			if (cc->is_khugepaged &&
>>  			    swap > khugepaged_max_ptes_swap) {
>>  				result =3D SCAN_EXCEED_SWAP_PTE;
>> @@ -2314,7 +2314,7 @@ static int hpage_collapse_scan_file(struct mm_st=
ruct *mm, unsigned long addr,
>>  		 * is just too costly...
>>  		 */
>>
>> -		present++;
>> +		present +=3D folio_nr_pages(folio);
>>
>>  		if (need_resched()) {
>>  			xas_pause(&xas);
>> -- =

>> 2.39.3
>
> Otherwise, LGTM. Thanks. Reviewed-by: Zi Yan <ziy@nvidia.com>

Feel free to take this RB.


Best Regards,
Yan, Zi

--=_MailMate_6E284E4D-D8E8-436D-BEDB-4B12CC9C927C_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmcNmYEPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK1h4P/2aOiRryt/o85HNSAob26ls7uIkowI8Iwgyu
0A5tsVmS6739vO+/tN3UxL+tM68rZE1TlFPrfMYN9yKGtxntQRu5NHRRCLeCVIVM
aplo8BbGSMgAFP1s8k0j/ZHtClT4xGwbdjFVV8vNpI2PmDjhpuJ6S8RZFYJiix7o
cIxqomoJERopUVz8Ru5+vUp29yw3EjskdBaLo0a0paMYbCFkMhjarDxkC2q+tKz2
frjt8C+RC05/Wyaxtesq9IvIpcgN7ddxC+UFKb8nBgIAc9K60X0wmqwvML+oeATb
L0WKkVgS51dU+G+kcY1kyRxeBouenWq3HZ5XUjHftQ3Y4gdLHKpe19JRRn/bIt7k
rdGI0Z8W8uIDd0sbVm56Hm7R/9JOwhnnnsmYlAlJQ8w3Ffl6ecBC0Kq+JyO7htuC
cljuSm4HqbPuRtbCEHLCH55xvHxhgH3aWNlKIM4PpmeDJGuEgsF7lbRVnpD4EMgJ
gZFeinyNNWGkOaokAbCjc4tuxrQeel1zqmfGihsuFmVyg+sEwXXx6R7JXZ6R4NU0
uSwaD5vwgVeMdDvSnzWfOZW2n5N+eNxXZoea8JV7GpmGVls0Z63kj+/A8/LpeMSR
FJ9fKsFwrqp5bGnRSXVmqAylPq1Wummw/7NnO1dxZ6YWLfGyDqXY0dOdjZqwg2eX
g/QyO/dJ
=c4m5
-----END PGP SIGNATURE-----

--=_MailMate_6E284E4D-D8E8-436D-BEDB-4B12CC9C927C_=--

