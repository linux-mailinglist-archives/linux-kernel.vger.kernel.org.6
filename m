Return-Path: <linux-kernel+bounces-257951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD75938159
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 14:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12F762814A5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 12:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDCD12C486;
	Sat, 20 Jul 2024 12:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y9+/az3U"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2068.outbound.protection.outlook.com [40.107.102.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247E11B86DD
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 12:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721478997; cv=fail; b=SZQ8LXHe1IB5vVFPLqimLt2z2fQPs5ly0BMMqzQHyxvuaEMArsC+odWeg1Qx8Tvz6YY95KQ6uBDpRjzJjxnFT+oYMWHsTGBInpWnVs7ocUkoj+750htFiWmpXNhkkVqToii6CyxT+emDq1U4aK8T+7CzJYFqGo0zLGifEdXm8d8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721478997; c=relaxed/simple;
	bh=qo328iHQUnIYAZzHXEs6VtSed7lwKa9fuW35/oAHCHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n7Q3UT3W7VHUZpnE+Ds8m8gYvgTCacLvfZl10JrPvTxQGObWvXQnI0KizCE8BSk7dAU7xq1tr26jPCf0Gq/mDp96ZM8Wv7DmlI3o3vCH3XX96KqeHjLn1lVhmc+Tpe1IshEp0dE1N71Hj6liywL+fCWdiUO6E5mLg9QFalafzEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y9+/az3U; arc=fail smtp.client-ip=40.107.102.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uk89gmucUg4rXqGvp42rMrS5yjlfmZLRsE6ZGRD93Tq8FoIL3ULpYm48J/Diqk7663QHJF4NUgYb5U3dOBbqMRqk06Max59kK1PBksfijc+CH7FYjQ5RbfnzUr9na89j8Ydf7oYWQ9RDRy1FtkxvoA8eLwvtxqrI2hygOEIuFWhUkKeTew8Yb1ObhfcRkHWnVm8Nyu93b1qkRv7oH4j9ee7z3fSzunCNKvLOUOqY6hbIhI88yu3x8C2uoqTO90Ze302orDYoWff03/XkqE7kyy9Acdr/VOSaL7fpoawI3aevahlJWN0RuBdsXiJVx0Vf5bEmEKtuaMd4E+AMl2g1BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2Z7JCIaVpxvRZcp+l0+IjYxeC8GpAC3q/nJAhfDjUQ=;
 b=IvZsGOm8gfB3Y4j37woFr2QBsvvn9tp0vW+oD5TseK0hGjt6pM+oLQijDtWoojbfuszW4GN7JJETA9lDRevAnBhzntTmzYpDowN5YdVFSmrtzzD3UszE8dbo4TEmh1IsWdXK3kF2lpieJDqGLaTvs0yLu4+kkibILKkJY8B1HsmxKMdOGiDhNeJtPhWjvmYL3cunolL7NHXN4aq4W8zk5Z4S+UC3+hHyOGz/N3g7NVl2xqq98Ygpc8QSdd5b4UxRvCAp/Wone9NnvdTU39xu3hUqFs8TjCsDQhgnKjKsdGOdVEaeLjmkJknBJ05FXyV6lzfAJwC03MuEMboPU4wjfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2Z7JCIaVpxvRZcp+l0+IjYxeC8GpAC3q/nJAhfDjUQ=;
 b=Y9+/az3U4d8bTgPHAeR/AgpKBlx4I4Vy8N50BSzezJz5x6OIWqz8j/SrcQ6h4LuYMclnHB/bhpUPet9YptwGEZ5T+10tZYi24MW0OnkJGmHdyfJnGEoFBhKOsjQPOrw0VhtdD7PkBzA+0k8FFXCgR2G5BTxTO3cX7+/zNZnF4X2De1pFGo/hbW1JcmMSsKdqlZePOZce0unL+tVwltHq9VFSQqdT4OCFaq3kxR1kah3i8+T0ophb3ChvBdYTgGWfQ2X2IUeP218lL7rfwPaBJ6R6+VJxTpj6LtIt4fFZK/vX0A+GIT3qG3Y9c/xtzLzJHIbptKH6v0yQHWV4fK1fBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CH3PR12MB8234.namprd12.prod.outlook.com (2603:10b6:610:125::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Sat, 20 Jul
 2024 12:36:30 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7784.013; Sat, 20 Jul 2024
 12:36:29 +0000
From: Zi Yan <ziy@nvidia.com>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 David Hildenbrand <david@redhat.com>, "Huang, Ying" <ying.huang@intel.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] memory tiering: read last_cpupid correctly in
 do_huge_pmd_numa_page()
Date: Sat, 20 Jul 2024 08:36:27 -0400
X-Mailer: MailMate (1.14r6038)
Message-ID: <22C21849-7ED8-4F89-B7B6-81CA3EBAC4D4@nvidia.com>
In-Reply-To: <f4ae2c9c-fe40-4807-bdb2-64cf2d716c1a@huawei.com>
References: <20240719144306.258018-1-ziy@nvidia.com>
 <f4ae2c9c-fe40-4807-bdb2-64cf2d716c1a@huawei.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_74F88914-A4B7-43C6-8462-BA4FBA32BC83_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL6PEPF0001641F.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:f) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CH3PR12MB8234:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e3ce18a-0dd7-4837-07e1-08dca8b89460
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HQ3mf23RtUhGY/2LOY5wJu4XIBcaNx+/aSj4FwmcZXbJyXcVHj3hAG2Eh4WS?=
 =?us-ascii?Q?laUYX7mZ/Ro6pAGM43R73RjNEco9dwl1jrew5ktAelIRST+GVIU8V8jW5dKm?=
 =?us-ascii?Q?yyWlOOzzumEqrfHsQfMPC5YgTD5A8VZpxWUkWuCCuPjfB2KLe6MThvg5zUsN?=
 =?us-ascii?Q?kQ3ea/tcDQ2xcBQvrXQbTD6/zMz2QY525OpEQQvsSVUTvtdr7wkLnuJc29uF?=
 =?us-ascii?Q?oIjO/qRSZuv9q6lgVvxvGQLsgP6s/3ZtvtLROw5hd3uhWEg3kwpzJ0r8n3mh?=
 =?us-ascii?Q?z1W9C8FQjYzkEJGn6RJVGNNOkiWLogi6Hdgf4bkgyUtvQUayn0FyY86LXWqO?=
 =?us-ascii?Q?5307A2ijEFL3Z/uFbotj3L4PkCmMixSxOM+8V1CSAnWXOWC6G+XwMx5Nlhun?=
 =?us-ascii?Q?QSkON2g/W5ew09GUEvoWsDRyjktWuiliCM8XwwlgaHIDivCaF8SAp1LBttGd?=
 =?us-ascii?Q?bQ+Cwz4+Kvyl9Z1p6ZtdmXMlbJaDDRCRxbrV+ePhUFV3w12lr6/tcEOfnJhg?=
 =?us-ascii?Q?4H/ozHMOmqXeo3vdvWUVW7FokoyIXQN+z9fWNDVT73Jx5uYLonVMtWU+LzrS?=
 =?us-ascii?Q?rQ9cMlmNYN1cjkO09vEVmna2LndSe5tIg9bTCGUCV56YxWGXvBZWlnPw4Fqd?=
 =?us-ascii?Q?zmYDqgENmbHkQeKcIEi1cYp3UKDZnO/CkAXowkrCymzOMyz4XSdKUdh5DJKN?=
 =?us-ascii?Q?Drpk5QKXKWFbTx/9DBnDx/rnuCy3uYynOTzuvp48QNMlAld0TomqI05F7U2A?=
 =?us-ascii?Q?mAUHo+ECV51rabt8XzQGkNzTsk8ta6H0chnvrb4HO6goQocmhNq3YKKbBgic?=
 =?us-ascii?Q?GP/1fnkvYS33OQxfAXcv7aw3bDsB9v17BzHQyjyV+PSUFfEJMJG/jrLjKmrc?=
 =?us-ascii?Q?yhrFO3f6wmCn/v+2WxY0R0LMpfWMflU0HCCS4bj6shGX621+h3zPFejYWk8J?=
 =?us-ascii?Q?GpJECkJjxW/2IrG9CzEo27I5xNDN1wqDeWg5/aqWSOdwslsrjLRLFaQ5qvsm?=
 =?us-ascii?Q?SyjA5KxOubgL5Tjfw52l0vl6fxq+qiCNTkJKLmFSI+c4DWKG3GAqxIDoYDBE?=
 =?us-ascii?Q?Hg9xLY0FMUTxGL/IEnHek+ckIbXeD7AKu6krptlul0oAyS2JvIB7txA8vL9z?=
 =?us-ascii?Q?SL45G11Cq3GPkZ0AxwNJgh3T7NKyNgt4bU6tHZ1+khycL/cWo+PniJBTHEWq?=
 =?us-ascii?Q?1aiGQZ7iMloC1ovIPXeIP6QDE/iCylzMMXRp+FyLKPSXZX2DHrSTTS+19PZ5?=
 =?us-ascii?Q?SZOiDxrQE5xhugqsjlsMQfJKACBHoZ5uRTnfTh9WGhw47eWX7CjNHsWEmAYD?=
 =?us-ascii?Q?zJLNHMuP0DrnDv1OICrdJXKL2rJ1v2eLyIbQamaOOKbbYw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dk5TbGI9hebabmu+bsoKxiSwYga5PUJlAyZUIPDrX9q84aW4dW5/O2timE53?=
 =?us-ascii?Q?hTAAyqaYpkJwGLvm+V162ZQgWFZpjhb2OqM2wzR8C5/GkILepQxNGeTP5OPU?=
 =?us-ascii?Q?0pZ44FtwtgffFdTaS8qnSAX2QwYG/u0DBnTdU+Cg84rVA7uWK8zruWyaiWtO?=
 =?us-ascii?Q?MOm9c7Frbk0SCpPtRSf1jFxsLnjeDLh6uIrypuLq0kMHJvhduR6efmJLaaWn?=
 =?us-ascii?Q?WCEG53QSl17I0/D87luQuINbvkD2KLHCeGGYBDUsY7LL0lW+vWgD2lSzf/vm?=
 =?us-ascii?Q?FGNTQiMB/y9hCcQ76PkKhKDmw25pkMMajNhMpIPNDUO5/0Enfkpg7GG3xqKK?=
 =?us-ascii?Q?CwrDD8WfOGVhX7h5fF9PxJ7nr7jQgk55itq96qrmsk+NzTyXBukeJRJehd3q?=
 =?us-ascii?Q?MEAFAvclele2A2rdLxfnIf3YMt3r7zQQG36fL65hODliKg1cw9fdsQNEeEd0?=
 =?us-ascii?Q?a99RIGrIiK+VCTv8518jCwT88xhpzx4/3yqOZ8vj3wh75T5pWcmvRM32iX/o?=
 =?us-ascii?Q?itEWV185OyI1nHkLZvrqTWh0+NSa/fuUB2OC4FPrsKu2Qk+FvNCiofJ8ScaC?=
 =?us-ascii?Q?GR+aG2BEdVfcYD/b6rBSW5X6POQ8Cqfi+FkbvZlEYIQ98GzNqwtmjWoH845i?=
 =?us-ascii?Q?l+JW5LmkQQ03WvomWKTcQfmVwTnkAExk4AMWsLMcc0EKiIRl1Xu56wSL2v4C?=
 =?us-ascii?Q?hX2LuUebpDLCTzEJH1gP/JLsa7tlIekLakHIu62XGwVRozaxbr8PA2nSilSL?=
 =?us-ascii?Q?ACQBQR6aj43iGMihPHKbKNeYI1bd6IOyJ4KW26p0B+mQ61prjIetcZXMOKQb?=
 =?us-ascii?Q?D2t19bnGEMgED8D5I8w0amU9leh5uoYkHaj+GhAfP6HpMH/1NP5yYwpxWbCM?=
 =?us-ascii?Q?8hnj6efX1IljZWBcrJjqoBdEZKCNOBH1WOeiszLmEn8JNSBURT031IUURmv7?=
 =?us-ascii?Q?YMq4VV1IKL+915l+YXl3H0AsiIdcrqjRYXmnSvdQ42wpiFAR3x9tKwIl/Y5s?=
 =?us-ascii?Q?ehBZmJBhTmdgtXohAi0VWak9oHj61TgSfIvTYBb7zeMnjQwjLA3dZwH3ICxw?=
 =?us-ascii?Q?/Ja6iQPY2TTkpH0hFcFxegfxzMgdtxOQRmoLr8ipLA/XeyGNdTgx4C18pgBo?=
 =?us-ascii?Q?bPHusBE+bFb8m4k358CwYIMntrAXK5TqYS3RjKYjHCeOX3bkFz0J4uEVUQ06?=
 =?us-ascii?Q?DhGxwVyib90+8OU8w5VHFKDAkwib/+43gWp5Ou9Ni0nMwW8w0Js60aIvuORn?=
 =?us-ascii?Q?57GLTNPfAXlhx8LwsbIWPXVIpOblrVWHg0mgrgSgo9guk3avsbMbSbAavTVp?=
 =?us-ascii?Q?nfWQBkpDqKu4ei1yOVkzPiGWiOIGqmM41hZNnn78ycm/mqq6CjmM+mQYNa3H?=
 =?us-ascii?Q?1xlzdoqoBnjFnIKcssQ71ByLwfSk81Z+m7QnjubR5M49r7APePQaRlj+4ahd?=
 =?us-ascii?Q?SSv4f4y4yLl8mdl31THi+1AZNjfICwUdin5dDGP8iSL8sIUx2OA9XgAljljL?=
 =?us-ascii?Q?LArM88mVhN6Sy57KsPKfCl6AQMYWcr+AOr5h3nsk52m0EgErGy2oMR5KO/U+?=
 =?us-ascii?Q?AShZu0bW6HIMEEVbVD0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e3ce18a-0dd7-4837-07e1-08dca8b89460
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2024 12:36:29.7713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SCSfVkpbsJ91XbNOL4jCfDuPpL/2TrIz8WkPZ2k9s18CklwtEfb3cXS0eaNijf/G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8234

--=_MailMate_74F88914-A4B7-43C6-8462-BA4FBA32BC83_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 20 Jul 2024, at 4:11, Kefeng Wang wrote:

> On 2024/7/19 22:43, Zi Yan wrote:
>> last_cpupid is only available when memory tiering is off or the folio
>> is in toptier node. Complete the check to read last_cpupid when it is
>> available.
>>
>> Before the fix, the default last_cpupid will be used even if memory
>> tiering mode is turned off at runtime instead of the actual value. Thi=
s
>> can prevent task_numa_fault() from getting right numa fault stats, but=

>> should not cause any crash. User might see performance changes after t=
he
>> fix.
>>
>> Reported-by: David Hildenbrand <david@redhat.com>
>> Closes: https://lore.kernel.org/linux-mm/9af34a6b-ca56-4a64-8aa6-ade65=
f109288@redhat.com/
>> Fixes: 33024536bafd ("memory tiering: hot page selection with hint pag=
e fault latency")
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
>
> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>
> and we better to check numabalance mode in migrate_misplaced_folio()?
>
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2630,7 +2630,8 @@ int migrate_misplaced_folio(struct folio *folio, =
struct vm_area_struct *vma,
>                 putback_movable_pages(&migratepages);
>         if (nr_succeeded) {
>                 count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
> -               if (!node_is_toptier(folio_nid(folio)) && node_is_topti=
er(node))
> +               if ((sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY=
_TIERING)
> +                   &&!node_is_toptier(folio_nid(folio)) && node_is_top=
tier(node))
>                         mod_node_page_state(pgdat, PGPROMOTE_SUCCESS,
>                                             nr_succeeded);
>         }

Yes, will add this as a separate fix. Thanks.

--
Best Regards,
Yan, Zi

--=_MailMate_74F88914-A4B7-43C6-8462-BA4FBA32BC83_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmabr0wPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUTzsP+wUC/eY/+s/85/1ghEJTSx33Y6RXD2YaE432
3uX7B/BE+W40gAvMFFK5lVtWxHgByouBiOGmH2KPoDn0xgovqszrE4UQKJ3QEwrx
gD8Si1GUpoEaDs4qZAhT/g4upAayFmv9i03q9VPJshQJh61E717Wq3a/nx0GVhvZ
HuAQyBIYp3c0yhuNdk3+FqEXN0iI3Th6J4ZkWqtBqY3kd+/FTeeIrIPmTWqtO17V
wav770ecmwslpTUBpBf9AKkBdH5TUXNjTm9ltJs+vC7vJdKbYdGbjhmdilLFZeH7
jFk0L5Cy2KxAFJQXsb+VGsu+U2rR36cQ88N1L+wKMF/snvj/wo8PrbFk2RObk0iA
lcVn7Fnqv9x2VGEuk9Bj5OmIS/Io0HfrktyqaI8DYNQHRcX2QUMY9xB/je3OupuO
Noima4oWfiLMpr7Ij0W/c9qJDChV90MmtHciO0cWaqKWG/HfF2CKNpsc5t0WWsDc
xTD//I44Wz8TEXTS6D0J4/F84363eJvneQlMxIpqMZMN6z2rj4XVfWY7evg3q8s9
bfEdRlBjGHrpo7vekNgtjk3I/LWFWss27x0t3Bpz7CPANlKUWwwmMEEdYEEuB+Y7
oZjfxuScDSb++TST1JxQStPOBSBizmn9ONCIgp9g6dWXw+ah3NpPTTOXMeT7Vfdx
AF/S9K6e
=EcpI
-----END PGP SIGNATURE-----

--=_MailMate_74F88914-A4B7-43C6-8462-BA4FBA32BC83_=--

