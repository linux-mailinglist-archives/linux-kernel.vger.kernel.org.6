Return-Path: <linux-kernel+bounces-221592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D4E90F5CE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 20:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F005C1F2290B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 18:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C948156F24;
	Wed, 19 Jun 2024 18:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XytBv31o"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ABF156F37
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 18:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718820798; cv=fail; b=dzgpuFkrfVug6ee8fYo2EZbXf6ai11aW3ZorFJtY7Zwv43lUeN/4hB+0IJh0/Fhgze4+b+vDqRoa5BuZsWYyfLbu1CN3finoSyNABPOUC/urYac3AK2nqSfNMnHRB3S7ArMSz+siDRUDp3MCooaKX8pJCj95JiqX3S0w2z/SVbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718820798; c=relaxed/simple;
	bh=xczPZ71NeWCVsuBJUlCk8E7blSr7zJGOS24AoeKVlAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fWJYrHUPU4REp3fqpTRM1YILXheBXSU0nDvq+M2XP7uc5D2sSoEtZH48QabOCFPO8mE57Q2R5XaZwW5aM/vX69cIhpj46q1L9GSe6PF4YtmURiN0dy785C0pn9xSBCYVz4bApvZUL2yTRWTQcVlALxav0kVST+mT01Hsv6AorB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XytBv31o; arc=fail smtp.client-ip=40.107.223.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4bA4JexJdvZAwpBIxbqh9rxI3oaK6BeFbwm+QAkRBZ4SAyMg5cRRnUK7klr0+ngrojEvNeOPGyau3K/NToFOL+n06LGfvQGZRqEs3gvI/zVbpEFoT7nJ9LCe8+H+LoUt5p3SojSA8uWupuU+CnPDBEjD0c2r6e8VsAfuc9IWBDBXwSy65t9YAMfR6pcp7yaCHfDAgeKsjqwvkbatwtVQkMqInJ686bYoZhQwk+wb0cYZUyQCL06ECE2b9hm9v1XLQTjDpKW6Y/lmjfVzlTbuU3M+OrAXm4D+XoEFc2E/zS7dwSJJaNZCdfdqvZR2y6gXp2XpSHOwcLNsu2uA83HgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1RE4x8SJl8Nuq4Z2WHRxkmPt4ZT7Jwx9kncXy92FZQ=;
 b=B0kGbIli83X3kwW9mNfHqyZdPVg94sHu4nTVbIQ7k623+sj/POZKiWBzvgG5p8ILbUnQ5pwMhZznO7wS63BGDOvU5hGd1j4CKlsWO5rSOZ0L8KlpYHRe6PCd1htqVIfhHBULTUkJXxX+i1AuUbJ0+aTJoCwCs4y4jLp7GLE4kCCdUTrDQPck7UACc9ZKuLTxQmQ75jcILmCy2+y/mbyq63zJbyKLyatX4/v4Ilter/7BKbDk3zlt7r3lbpmzNPdfIFYYuSbaQp5oIM9uG81tGIEO+6gHt8rFVBPNde7uMKN0utRugGmPMDFNfG6EdlDCfuWv6Le38Xf+7lSNHXXIHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1RE4x8SJl8Nuq4Z2WHRxkmPt4ZT7Jwx9kncXy92FZQ=;
 b=XytBv31oVwnaKmRUqwIR0Vb/lyjpsc3S8vMW541qV8J8NOcZa9yFi4IPgNCr6bPzH8SLyzA/QaFwBLEosfvAmdiFjYIZIWsSAuG/bs7C0YMhalGVyeE8Fn4cM1HzoIlWGZjceQZerOJXKxIh4qttNlXWVRXngkll4agbtT2FO/rJmqrgXCHRmWFDCet8QRUo8avw7IghaHyDsUhURphi+2z0wWr9uRxYXd2+IaTQVrSc2HpAzaSJM6LhRNBfWFep83nVXyez8F/KS/pi3zRgyCSmmzN3pJ3+wewIt4ANBZhPIryUOo4G5ym6aujQc1mr8WLOT9yoo+9MXjv4bLp4wQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 IA1PR12MB7688.namprd12.prod.outlook.com (2603:10b6:208:420::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Wed, 19 Jun
 2024 18:13:05 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 18:13:05 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, David Hildenbrand <david@redhat.com>,
 Yin Fengwei <fengwei.yin@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/migrate: make migrate_pages_batch() stats consistent.
Date: Wed, 19 Jun 2024 14:13:02 -0400
X-Mailer: MailMate (1.14r6038)
Message-ID: <9D1249AF-CBF9-4283-B1E4-6AF7890C23E0@nvidia.com>
In-Reply-To: <87plsd4co5.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <20240618134151.29214-1-zi.yan@sent.com>
 <87plsd4co5.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_2450C339-B7A2-43C4-AF51-F26C32858B37_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0226.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::21) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|IA1PR12MB7688:EE_
X-MS-Office365-Filtering-Correlation-Id: 02d535c4-32f9-4dc1-08a4-08dc908b76f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0D/IKkRUPyfMuYiQX1BQZCph8BY3LOcHCNgzbRAuNZLoo1maLF77xVNlcDZP?=
 =?us-ascii?Q?+WP/hIXgVManloy6tFwokxARISe+m9E37G2cyjGCTho6F1SJ+AQZ70DSW4/X?=
 =?us-ascii?Q?VFcfr4ORWtWoRpN5fDD4CkaShmziIhNiphmWvRtQb2Kr+eb3P1+XyrKL0pQQ?=
 =?us-ascii?Q?pyCseDVVXHtailj7Ln/nqDz2CJ4607xgPNxJeCRLXG7nQeXveNrNn8apYQBq?=
 =?us-ascii?Q?DftMfF3iuceGmCkQLO5URKhzTusEE5vObcsj73Wdddbyk/90ipLHPtWlMynN?=
 =?us-ascii?Q?YLF2o/H4QlQHLvg9g1n1sIzaB36vBCDKA0XEbKNHxvScDoJqtMRin1fnF0AH?=
 =?us-ascii?Q?aveqnf9w72gEANPTMB7jWW28MVUMVO3cr4K56w6FY9BybD9e8OrQKSyEyTp2?=
 =?us-ascii?Q?cVnUnsldw3cMXGeQZLClGfF7OlfsEwa3ME0EC2iZVqqorch+2a6mswsQnvLr?=
 =?us-ascii?Q?vGa7adxmDEm+2pbbjdbmGXn/SE+4Ym0oHKb+27V2AzNxiA6kg8cDarcMoty5?=
 =?us-ascii?Q?gG55nE7Yne2nJz6M7yhbqQ5RJkhmb+q84T07Mx0Q3QV+/aavNhmq1FWTN9QL?=
 =?us-ascii?Q?1mUQDpj5n8IRbD7RDh1BDZljIZoLifu0K0E/M6Do7TgFTUFHNQUGHUOumbB2?=
 =?us-ascii?Q?d7CzIV7RHnlF8McMUOvn0xPLAH/HONSd5sdzej1CcYDQKaTENtzjYQ4SYUDT?=
 =?us-ascii?Q?IJUj7MSo8MkvXydmnlKpWA+ArcSr06J9EHyhiVrDfQlr8kF1l1tVoL5Kj0JG?=
 =?us-ascii?Q?cHME1UOKPpj2bMR932sp0v3F4ryQ5rCNgqbMnQ8JydMMXtHxSd0U/4xacVEg?=
 =?us-ascii?Q?eDpRt2UgnE1j6bda4MeurLoIGWGVK0Ea6yUVwvJqCbMVNOQLZG+1t0juASMB?=
 =?us-ascii?Q?I0zDrGSNQEpzE3QG2aLSEgX0QzJoFxm7NRDv+ys8jSozcUyxYJQYFoyH4LfR?=
 =?us-ascii?Q?OYgKfSo2arwu6YoG3E5iSf+zBbraHTYyFrJiQ4jTTxJCtwBkv0FkMnqnPnZd?=
 =?us-ascii?Q?DUt35UFKd6Bh/BVJEuq43R9l+9Rqg1e5uwST9J5J5RmSxaktcn5p/LFb6N7K?=
 =?us-ascii?Q?W4gaffPd8j7ZgQMc8izUdnDFPM9+dMtJZ0GepguPbucOxGuA1W4gxEAzdSlQ?=
 =?us-ascii?Q?dCGqE8qdpVtCl80n3ZQPQm2EYrm3/2fr1Nz7brIVUdo1to7sHLOKYJFFwF/U?=
 =?us-ascii?Q?W1qA0oLI9Dj9BQSyH9fbDPofyTjEdAa8/w4juQmlN5Qbg3Fiq2LhWdBORfm1?=
 =?us-ascii?Q?Al2/b/CL/fkOf9vgdnwg+7bsprxsyQuPN69yaLYW2AbGN6iPKjck/7Mjav6e?=
 =?us-ascii?Q?mL9H6EWUOG1wiTgoutLNLOEQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?auwJh9xD5qvGoGtd7QxlMQHaYaRCg3/TYDgoGs6YscWkgX1kwMcmRNo9dbHP?=
 =?us-ascii?Q?fpNprDAyBJugIY0ZvjnCExWsQOMDqAFPA+q9/uWex/VXGIeL4hW1+GqC8/ie?=
 =?us-ascii?Q?w4xH1T8FJwK7A7h9lNtfHBNjrN5l4mTa3XjOgtR34w/Uvm+34XhouJadw2Uc?=
 =?us-ascii?Q?gFb5QTIxoZlnLH69Ksb3zItTC0E86HuoNLlObIB85WcVSUjzx6tciZluzn7O?=
 =?us-ascii?Q?o9Puzby017WeGI9yJ80XRVhrVhljhJ2MROnF2m0DXnQpwkPeKS5unZL+czFc?=
 =?us-ascii?Q?EdtdvJ9+wR4969sZEI3DVPSCZJAgwAT5KIR+jHQeF+f9oQ1fVqtU1yV5836y?=
 =?us-ascii?Q?DuiuQ4+f/ZQJ1x2cuS17luYCzbJfrS9y/fzOqDK5CE6r/A/uNCpCmpp39Hbq?=
 =?us-ascii?Q?DeUuA1B2Zw65IZo0A/Grj4kYQ07RfCkAAU3AVcLAdSNr8kcl95ngHY6BjYRc?=
 =?us-ascii?Q?aPKWo9Mlv3ts+TdjSJIkif72MmLIg3yBphAXmX+xucr9wK4MlztGkyWMNfsb?=
 =?us-ascii?Q?alnUXaBjv5Ox2HhBQtSShYkmi/T8jBA/Glu4fw3YnD6ngZrWJbVD4Sp5xd6M?=
 =?us-ascii?Q?xS8Ktei7rTQA5iJzUi5pMG5DwvqU5ZYmX2PGGpjCNT5rae/eiIOba0XjmbmY?=
 =?us-ascii?Q?Yaa3Wk8qeTXPv1HoJ5LkeTTTtUFRx8TA8lY7jTnOfk4N3aUAMdiT6WjAcvkg?=
 =?us-ascii?Q?nBpSq8V5FHI/TedYndvmoER8ic0kPOp1dFkCBkZyQ4QXisK/L76hYCY9tIrx?=
 =?us-ascii?Q?ZyroUwssVsSI2bJFnsN/SsYkhHGpu9nBF4IOeMwWavroFSMfIjNw7ykE3lIO?=
 =?us-ascii?Q?9zT9tOFSMQhDDtEr770dWa7lSW4h4dmqwXQ/XxyihUpxjpkKejI3ZZWJfw5A?=
 =?us-ascii?Q?Cl/ho8vsHJjUGylHObtoWNR59yehmMrpb3Zd/3vMrcmCJTS/9WsPWKf/LPKE?=
 =?us-ascii?Q?XPuw6anI6CtppiPaRsV8Tg89Wwfrj7MR5e/L0wrNk+pRmu560dXJe4N0rNGt?=
 =?us-ascii?Q?ZRxk3+NZoLeZ1IvLjG5+6bFfw0ezvnCPKOPopY/NMKwWh6e4Rk3OJt157Ivs?=
 =?us-ascii?Q?SmgirQimw8GhPYqhGanJK6SP7+XKQMik/K/D5JKUPVMMQtfyK01b3RWy+nDK?=
 =?us-ascii?Q?vwnOhn6o8LtNVaHy1kpTDM+eRupmpOt7PfvM7z5zREv0kN759NO1K+T51nWd?=
 =?us-ascii?Q?CzLBDlYP5pcMRWl9gnGypTgYuuoeb92F/3y+V+1Cw+r8bCfXTaL+Gi8dLjnb?=
 =?us-ascii?Q?iJEFMoJBaMAqFeloptNRWMlxjhnenL0wNIHn7vTJYeyIhBoPJ7rsdKwfUQLo?=
 =?us-ascii?Q?P59GnrRA3yswyh1aY+xYLws4N/Ha4TwTjgUZ4xogs5n5RhwxEidO1RkOrkE2?=
 =?us-ascii?Q?TGQ4VYVR2HX+GvSMrhe68zft5B0thPOAdKSvIpwAvEVR2VqtpYlQWY6hEWUJ?=
 =?us-ascii?Q?eM8FyZz2IzdyDR7RZU1XxchCT9oUB2mKP4NVsKo34A+W1SARTuWQxaip8T1h?=
 =?us-ascii?Q?GJK+MLD3y61o4y+26Iiq0pFBsUaoXuXRWJ7pfz/IoOCFdicBNs3lKW6vGIMX?=
 =?us-ascii?Q?8Qk/2ZUeiT0iz2hdBwM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d535c4-32f9-4dc1-08a4-08dc908b76f5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 18:13:05.1706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P5GqXee+SMq+dGHcCkDFkITWlVp9nwgZR9sfdMItUx3y4RZltdnxtGCG94bjM0sc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7688

--=_MailMate_2450C339-B7A2-43C4-AF51-F26C32858B37_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 19 Jun 2024, at 3:25, Huang, Ying wrote:

> Zi Yan <zi.yan@sent.com> writes:
>
>> From: Zi Yan <ziy@nvidia.com>
>>
>> As Ying pointed out in [1], stats->nr_thp_failed needs to be updated t=
o
>> avoid stats inconsistency between MIGRATE_SYNC and MIGRATE_ASYNC when
>> calling migrate_pages_batch().

Because if not, when migrate_pages_batch() is called via
migrate_pages(MIGRATE_ASYNC), nr_thp_failed will not be increased and
when migrate_pages_batch() is called via migrate_pages(MIGRATE_SYNC*),
nr_thp_failed will be increase in migrate_pages_sync() by
stats->nr_thp_failed +=3D astats.nr_thp_split.

>>
>> [1] https://lore.kernel.org/linux-mm/87msnq7key.fsf@yhuang6-desk2.ccr.=
corp.intel.com/
>
> IMHO, we shouldn't ask people to use link to understand the patch
> description or commit message.  If so, we can make the link less
> outstanding and maybe add more words about the issue.

I summarized your explanation from the link. You think the summary is not=

enough? I can add more text. Let me know if the above text looks
good to you, then I can resend the patch. Thanks.

--
Best Regards,
Yan, Zi

--=_MailMate_2450C339-B7A2-43C4-AF51-F26C32858B37_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmZzH64PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUcEoP+QGOEKXhMg8ifMskFmwnnIbdHUaxuzmsyS8B
2VKcqgBF2vGDs+oGYcyv/Q9r+FtxjclVJdHW7L3LyxlU/FVYBsCV06jCLAqkMnAT
2jtOytS29s8GkMVFdjWzAWPMid/N1wJsXlnG1xGy9khlmCCY34NKNn113t5cHOxh
MY1J3jqHrFJybnxxV4PBN0C4N09y/pwv4zP6nCnxT2t9GVZL8Sxu8tnGmODKGpWR
ONS37crPDfi71Z9Y59cMfvFGBWmoXvoV9F82P8/ZvtU80/TFvMYTF66K8Po9CJqC
ngBDAL3KWYbzmslIOnupWbQkeGErYscvX2RQou9ZdW9VUAgGPn8ezXtJ1v9FX0Gp
DBVG/63DZXUUfxE4I12NHwfs/bXLubdDAnB+kSA9xUDlfRuh2gBTdrzZQ/9RKimW
s002Kt4hECOc6F6FxAAQKZHPd/gl/wBO0kwXaaL7GjcAvHTyylyNrNhG1rblEJNX
T9yFYC3up7JIO4YEWvqLWHAFLzyW32IqZZvjx5A8UU7p2Cuef/6gNfG9h8FUo1Sj
VtulIY3Qs4QBb5r1EGAKb6lNVm8vADmnL4OTfnEzCtj3dh6KnPm6N1iHelKEO/aV
FTca2UfQvMUvj4cE3OURde60Cg4osxCEJns1OqRfZfp9I2ugnBP0Dkyn6VeWV/UO
jSFItc6p
=crxx
-----END PGP SIGNATURE-----

--=_MailMate_2450C339-B7A2-43C4-AF51-F26C32858B37_=--

