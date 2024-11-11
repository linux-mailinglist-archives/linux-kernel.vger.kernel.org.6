Return-Path: <linux-kernel+bounces-403528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8324C9C36E2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 04:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ADF01C215BF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 03:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1361448C1;
	Mon, 11 Nov 2024 03:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fne/knme"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F9913E022
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 03:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731294667; cv=fail; b=uLxi+jAoX3gr4f/E1XtMz955ckyI3acwMMpYDMT0gafesIv8zpb/ZKSbikN1R9y4NEupEfM0uHabGkGp6bP+haoimaMtSqj+xyigEGp6f039euUIZC/7epzDFZdnZAsQPgx0BKG0jGP6RTQIh7FZLWunxJgYILJd+fo4fblt9e4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731294667; c=relaxed/simple;
	bh=VmnDixYmNCCvezyC22Q1kbcNicBbPqSDQuEKYRPO9fI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SFACh7s/aijZyQR/NTy2U0XFkWU8sUg8DOl4Myq6OU82UcpaJtIKqU+ireKMRzKv8MejSFbMLFRsteKVjikljjiz5cr3iuXF8dKN/XbucHQBJ7aEbbPgY3YZsj6ANwtbgSHQ9Ta1UdQlGUzVOx1os9jqWJR2kgH12ixZTneh2vY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fne/knme; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qr2Wie87BV22MeJA/gDxr93guQeQtmm8mOt4Sm9qQfTXedNX2YPREdfRtM/v86SAB865UtlGFcdW/QmPG/MLTkifx4HQTvfQvp2nmGK7k1ch2XWL61Fxmq8d7/gRQiKk2TD8OWhyXvGkt/qInGO2eO8H9wMrtOftHJDtWF+dome9kFJymMBMMc1wUTKjilX7WhAjsVN9KUweW9s1Df20EtxBdRVlvlXI6UvHl2tmZ2X7gUJCt8YHVWbLL4AtPEzMoVZ34t0swIgIsRUpXaPqL6lqL3uyN73syzbvSX3k+x5piV5OeN94bahwKEZQlbVxA2hCXcBT1kvcwD/AIzavOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMRd0twL+hQahmwAGAE/wrovqS1YOOtN9b0qBxkHclU=;
 b=jG8+SjbV7FyuuSnoDHb//f3Hgb67V/m+l5nibD6/YrycfuG3l4B1LTfNT3ECpuzYxEAOdqxAvP09p2tG3YLN/3H0O3yWmuF81Itlk3mtZatOg8AUaR73mTV0Gtj4yHKdL0rD3G/bqsTsOKIZyfywpYWKYLzOdoPdsTI9gU52y2AoCpXN+T4tbvljRbZc1PwaiXbjFVYhYE2gDdShJWIp6alV97ipukZoUEY482Wkriyfwha7qCh/6xN/uRdes+g+Dvw4Aw3UesjfyN/W7Jei7qUmiD/agFpFLSnLaVM/QKcHtJRSOW6xQD5dgci2Zh7qMiCYoA1WuhGs+RNac97Bww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMRd0twL+hQahmwAGAE/wrovqS1YOOtN9b0qBxkHclU=;
 b=fne/knmeLESGKrLC2C+yY5wwlgK81d4Z2gSdOGR72T3z3MAQym9gNeR8EmdJ1jWeDbyWxqcO2OViLL+cvzmmkHDwBSfUQt2ZdLbwfJ/DsJ7hFv2Ke++nOfOBR2zPOYkYKH7g8qM75dmV+Wu4wrfP1lqtLqCOOPgpGl8ZooqpJMF9FQnAlwUho9zs7kRO2DbwRn/yGd9tf/EfzcMG3HLqRb9gXi+uVDKfXgg0n/7vNCAGW89j6WAiwaweCXCJs4K7AEHS54+nTE56FHOdOCanGHZqECywoZ7dzLDtiRNoUsI5JG8OP6aRXLeP06JfPhfSIYvE1Wm1pjxPY4Ue4WZXtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH7PR12MB5853.namprd12.prod.outlook.com (2603:10b6:510:1d4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26; Mon, 11 Nov
 2024 03:10:58 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%7]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 03:10:57 +0000
From: Zi Yan <ziy@nvidia.com>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Usama Arif <usamaarif642@gmail.com>, Yang Shi <shy828301@gmail.com>,
 Wei Yang <richard.weiyang@gmail.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Nhat Pham <nphamcs@gmail.com>,
 Chris Li <chrisl@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH hotfix] mm/thp: fix deferred split queue not
 partially_mapped: fix
Date: Sun, 10 Nov 2024 22:10:54 -0500
X-Mailer: MailMate (1.14r6065)
Message-ID: <4E83DD3C-C657-493F-A36B-12A806F1F6E0@nvidia.com>
In-Reply-To: <3c995a30-31ce-0998-1b9f-3a2cb9354c91@google.com>
References: <81e34a8b-113a-0701-740e-2135c97eb1d7@google.com>
 <C4ECCA8C-FBF6-41AA-9877-4376EC94E021@nvidia.com>
 <6fcaaa72-4ef6-ebda-cf37-b6f49874d966@google.com>
 <3c995a30-31ce-0998-1b9f-3a2cb9354c91@google.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_FCF5FD43-8093-4425-ADF4-6C253EDD0666_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0193.namprd13.prod.outlook.com
 (2603:10b6:208:2be::18) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH7PR12MB5853:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c197e71-b8cb-4951-a8c7-08dd01fe75d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B/BE3pzT1/hKgf2kKQ4amZ9quWFkUWDOt5RfPOoXGtBlfEM8AP5cq1aUMyPF?=
 =?us-ascii?Q?AnwRlWDz1CDEj5aQxT7tW8J+kdchvl3q8iTsXKPyzIfQf32EsFZLS7pchYWd?=
 =?us-ascii?Q?EWBohfRZupx7HzYSAVcxvieGpxdDclvAMJFt6SzWv45Ff6D9c7ITIk4BdJXS?=
 =?us-ascii?Q?+nNIcUcXAONbZOqLG7wnAB6kL6wptp51fJSI24AUlbFzjQKa0q+ZaIQ2iTxM?=
 =?us-ascii?Q?B3ZfwMs/vIsg6I9ugoePLsR/SulpEbG6fImrhrnuphEeQGsiWcj92VnGV9aL?=
 =?us-ascii?Q?+IuG7eLIK/lhAN3yh23ocHeaaFIKaInUEeOxLkNwhX3pDdba9AHcrA7bIfmr?=
 =?us-ascii?Q?sQdSvqeKqrtGR8+yw748LspRRT6tupmyPS0MS0s9+m1OxHdLDRnueEP1NSmX?=
 =?us-ascii?Q?EmZgP3D98aMPCL6tPvoyXVU7l4Q+oaNJO+oFF1jb7zRNmNPjtpuIrdZMAMJd?=
 =?us-ascii?Q?2OCV9j+I0FaJeSnowJ6eJ6Byf5qmVW06Tsoj8A4swLuIdtbE1vuHZqhxOg//?=
 =?us-ascii?Q?g2eCi6EHcFhilqpIUa0KjJrQjdqL5vSiksnyzeew5/2zIlxFZl39VuapYZwq?=
 =?us-ascii?Q?++8u7AalMe281PRPYyTMvLlROF/j4lEh+mwbuukG6yK4Sf4TwT09yxa3Ue1R?=
 =?us-ascii?Q?4RNfrjnoWZC2RYgJmu+J3bPRjBO0G3OgjYCstXzbB8ingam2GlEeWYfmiEMv?=
 =?us-ascii?Q?Vf4iQkIx4aTkFJRq5u0ZXnAtA5voeY2rQFySB1x4UY+YNx3k2aIaPavvQRgO?=
 =?us-ascii?Q?xCuqxcz+AbVVkZES1j6GWTy6QGmyo+wKkVSAdg50iwi3q8nMOT6LENQAJt+J?=
 =?us-ascii?Q?y33TNke8TyB3UFxXmY08AykqU+go1F1X6rbbVtYRbdeGuu1B5gY6u8WPHyQl?=
 =?us-ascii?Q?PBkAGQgUv6HRTbn5iqqy7kh1q/mfHJVRHYU/U9Dj65bxLI2KcZ7fWvSPxyfy?=
 =?us-ascii?Q?UwckgSBPNprCAs5nV77bkxKfsJI8PKfVdrM588RLelVYWtQS9qx4LUFTnN+z?=
 =?us-ascii?Q?zlZ4gaylFiCpbFK2LRi/yYaqpPFjz2OJYqKnmsN8wBV4fh8fGomveRZwL7It?=
 =?us-ascii?Q?mQ2IvVbFoJPeTUeRVJYo6/nNYId/wt6JIsgzG58mWEXkO0oonY17XD2oglPF?=
 =?us-ascii?Q?zcSSd/Wd4AJUyb+FHQAG6r/B1VsyatpnlO+7Nk0GQ2qiu8HqJ3yzQ4+Grvjm?=
 =?us-ascii?Q?B6aBI9zycvHXwxZ7kevqEOGP5AH9I1t9uO/FYfX5/tmKyQgneynBatVIjyfO?=
 =?us-ascii?Q?Dts9ZE4Uz0MQV8TlvkAQ93CkuMgh7C0KuntfKl4UApXTdxIfAsWbYZKiS9yn?=
 =?us-ascii?Q?HFQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nDOygyaX/FQ1Jgrl/xNh1/lvw/+L9D0cEHJjkqvvnXzA06HwUzn2f+9Ly/G0?=
 =?us-ascii?Q?jSOcQLkQxAVEHBZtDok1piV7VFB+aUgb+B04ULooL/KAnR8yJoBcorV3eaDq?=
 =?us-ascii?Q?fMscrS1H5RmBxlcWfMqsI6o3lO8dt+BZ0W0iHNMEC//CXzu6PZIyNs1ekDh3?=
 =?us-ascii?Q?RQ12hurZ8MsHnoJ9nsgnqL+OIbkwgtz2C73Vica97Y7lNj52Li/uWSdONVAi?=
 =?us-ascii?Q?sLnHPaY8B6xL2E2UAcPsgA6pvkML/CA0G08XvDJo/NgbHzGVnAt5+9Pi2ZBK?=
 =?us-ascii?Q?NGfVuVX9Xf2fDWs0Nb3kfTfD5uDrFnuSSlnwSGZ3OqyyVw48lxBJYBDqS4k/?=
 =?us-ascii?Q?MANSnLwVCRN0W0CQSY9o1Sfv/fq6Xi8u+K4zayhKJud1aSAB6UHRQe6HUmy+?=
 =?us-ascii?Q?WajxYkQcF/hC0NQrmDWZgx1LPFUapT+PvYgrrQ1d+LOa5pPbIXO3uoQPCkLt?=
 =?us-ascii?Q?Qq9enJ0qjQMFAsscLOFU4hmIrqC9eat+VVDXelhhu5Z1QA6a8QJvxCUJCc5R?=
 =?us-ascii?Q?ZwuXNHaLVUkh/GzXgNDLw4zpA203M/6+aXThzVjA7wYJZygFBpw0VifmPFsY?=
 =?us-ascii?Q?L3EV5cWgRihGya50e2Hu79JIbl3UzPx3ESghBtYimX1yUbNxTapYRI5Fmzg8?=
 =?us-ascii?Q?POQeq8cIOLGHANhIab7grl1yqLlKMgM1SFYHxamSiZSDXShZE6ZwNubYCxe4?=
 =?us-ascii?Q?el6xpoUcA3ZEps5sEVSz6eJ1ctDTLpvE9Avu8mU59Qr8lY/1rR7aTBL0fRql?=
 =?us-ascii?Q?6yE+0Jlc+G8x5V6ymyYcdhYYqrKRhlCQh4bN/BI9QsTpPBaeU8scW8xzeU7b?=
 =?us-ascii?Q?kfavVZRWfFcLWInA5qaz4RRlSGwd9XjJcm+/ntzgeI/h28MromjMQ2J+Eqks?=
 =?us-ascii?Q?MkmJ7NIfAzX+2JeVnORFGot2VHWDnXMyTcRZjLOp7Ng4RvaXzmdPUex3Oy59?=
 =?us-ascii?Q?prXqR2cgmHU6JA5LA7TjS977s73JiMO2yeGX6agT+O2xq25/jQUprmZ+TAtZ?=
 =?us-ascii?Q?HBGTmZeagSLAhS/M1nIkge5nE09nhVnt5tN8CIiW7wwGiajZR8Qv2jbf9Xhq?=
 =?us-ascii?Q?4fIn3yPKTlpJt028cTLOD/ZeFzanzoU1t3clWSLBMxBQtOQH4v55iWMmmXBf?=
 =?us-ascii?Q?tXMUImJHhAsMVKN9DrOJSE/ZQskzbdbA+g9OKS4lj+Zgb9rj2b8orZlQlp9K?=
 =?us-ascii?Q?yUOy6xURq7ic/EFCw66jYJm5QQuhuQam1WbhFmPZvITjeSPDZWg/aDCFpGtl?=
 =?us-ascii?Q?HqEoDEo9DBya1KXRAUusIlfBgvkxpgJajR8n/0L3ZKxLYqutZQKAMFN9kHbl?=
 =?us-ascii?Q?rsHHfidnTMZ/nffIOIdkWnMnlKPUM+Nn8UVSZrQNzSFO+8MCwefxGzl/QJf9?=
 =?us-ascii?Q?T4WJD2X9zUeqTUevAGRuIi80WvrdmueIEeBYqlyMTfD7Ue5bC4VB0dGcdO6k?=
 =?us-ascii?Q?BNspGTmzJ6uiKI1rh03GKtAF1fL6gL4Xc8yLU/GykuncGu26dn4TYrHzgY7R?=
 =?us-ascii?Q?zzw7kDty1ntxpdB2rVbkvtkmhVg9018o3UNtCihIWfYqfN/I2xh0QM7DbCPu?=
 =?us-ascii?Q?iDHxcUUojmmRrp1BDLg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c197e71-b8cb-4951-a8c7-08dd01fe75d6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 03:10:56.8019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1KVLiRkB02bEzmKqja7uNNf4cphpStZJG+2JmcYloRepEFSw0qYtxGN8KJHMjdge
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5853

--=_MailMate_FCF5FD43-8093-4425-ADF4-6C253EDD0666_=
Content-Type: text/plain

On 10 Nov 2024, at 16:11, Hugh Dickins wrote:

> Though even more elusive than before, list_del corruption has still been
> seen on THP's deferred split queue.
>
> The idea in commit e66f3185fa04 was right, but its implementation wrong.
> The context omitted an important comment just before the critical test:
> "split_folio() removes folio from list on success."  In ignoring that
> comment, when a THP split succeeded, the code went on to release the
> preceding safe folio, preserving instead an irrelevant (formerly head)
> folio: which gives no safety because it's not on the list. Fix the logic.
>
> Fixes: e66f3185fa04 ("mm/thp: fix deferred split queue not partially_mapped")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  mm/huge_memory.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Thanks. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_FCF5FD43-8093-4425-ADF4-6C253EDD0666_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmcxdb4PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUoJwP/2ZIx+EayANR5PtZMNvg2vGeg2WYFbpA2Y0l
WaMl2BNH3h45NwJy+kgaN+OpCaQeINi+GnM0HP6dNbQPaXPhwmyDHh/pjaqb/Pup
70dcDfxn39oAzKSlhbYGTOmJaOvC1/a6JeceNSxcA0iBMp8fGzG82/UIYAe/RTY5
YSTpeebSNbgYCs5LvGmVDI+z3DVPku/o0SStVc90QQfb12y2WDpLjyzQGOxDMbzJ
6zInB52UBynHNqWFJ/8GJTsNOziBFA+UUu/3dioJSA2qWbQieMeUW8CSy5hGXyBE
zFTCJkgdtg93tFIeayq6hB180s3vbYcOGRgI4wsoV2QSYQ4Su6bUGIUZdkEl10AD
bquN0xsbgPRTbdovzLckzjtNyvhZP0eDN5kf+gWVSoWEktFOC7QxJPnEB8pdfDdn
qOZM4PpINXiF9MkvkvSoBdokcgptMljSBV4VF9A030hI/AcYIiSCtAJ4asgy0qTl
zvJFkG0cdY+2cHBZdCBD2D8gmmgmddHU55DGaZdxYoDmAhfnWusQU7XsFFBv7Rga
Xt6Jk5NjWfcAJ0s4w6Fl5DwO9TwZiD4L2fN5Fk8zUstsjOTM+iR9PcGI/8pySVs4
2EyYi/wvwfJ09kU4mmtNTXPVZPjckudjkUBUnypaWq/Y0ojBPlOLHI9SXfGgu40a
4ZhMTsS6
=SzWy
-----END PGP SIGNATURE-----

--=_MailMate_FCF5FD43-8093-4425-ADF4-6C253EDD0666_=--

