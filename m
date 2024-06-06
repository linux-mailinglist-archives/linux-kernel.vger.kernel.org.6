Return-Path: <linux-kernel+bounces-205094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEF68FF6FE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 23:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDF361F2320D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 21:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A8013AD0F;
	Thu,  6 Jun 2024 21:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W57x5txb"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68094F5EC
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 21:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717710278; cv=fail; b=r2eGbe54GEvyiYM0w8nwvyd1/DNl9dRJqnD/SJlNkIrrXFJdZhpzzV11H8IaZGFgpLjFde3V6TfEiibbiOjsVHi6HdB6NOV5Vzkc7cT57IDIf0BaRpNCS5SpeRcgT0KK6RELg+QYkstHEtdZKkJFUX37oIEX4HsOgzUUmdT6U4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717710278; c=relaxed/simple;
	bh=+zEKi82LZwb31j2Qqqmemc2GGiU6ZdAVMLK3s7jtd9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mocvH0nvMrPgnVb7Pr6+vqN2IyDGb+9e8cdJltFjEIFlwk/Ouu2JDWgbFC3KSQUwu+noNVJF0yiHhhCKs4IQbQ1M5mapuaHWagPpgHLdu8J53ee4z+aSX9XLO9T5lgLaGxRhhP4MuXXRJaXjrVugK5E6EtC9U6tgfUIqVaNPjjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W57x5txb; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGyYxATVanZXacqYlH87AnggKPCDBd1+rrDDeoYVcR1ZgP28rk/KX0LRXfYGbYIE+5lwL90s3dfwqUxyZJn7IE/FlHIJ+dGCEISHoir47eLERu/u7q2zRgc3eS69AxB31niz4bBBbu2K8i31avroF7q2l6erBwkc39Bh9UzrqkeB8pdUkSLG6NuzWnAS4758ubAvXYTwwpfD4ggznB29zSUX3XXZ2Ej5/fb7Uf/lr9ZsUJP7/cFeSwTf5eypT82kWICY6YWXcDzL3PFnComsrUV4uiS+y15WHXHR47iRkauvZROG6HFDsvtfW7GPM+zgEOkIXSAnmgp3NSGKwWycqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iuZK9zl4zpU6woVyi2xfJSrPchBXbK4+fk/DxgDUcL0=;
 b=TjRrj0Oe7O5T2//XHsKyjJUn8X9kzXuSdDaitQq2igvDXRqf0ZW9jwinAfuh/C8a0Z0DjZuA/dltwsfBN4FtDUsRMFKK1kBYr9xTBCWDjwIufXCNZDWIOPQpqPIBqGBI43nowfWwr1SsRvzlqJQo7h/2CxGWTB2lhZXLqedBFud9+wv5oLSPIgcg5MLtVPgU6dwZrHP8bdjDQuQDezs9+Zb8pwZoJA2YtPJS4F9hoZZEtAlLzHWWD0DMtmA2LhoLCnoYLn4dYUbv+nAan/DSY9YxffmxUvVgfZBo15w2lSa5Y/hWQQBj/NA6Wq8WA1/XpUGA7RDQT99wQWaTpacl8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuZK9zl4zpU6woVyi2xfJSrPchBXbK4+fk/DxgDUcL0=;
 b=W57x5txb44P5OcVnEEV0lIVyrTE4OyRBNwPNeG2ewihgpN5l0H8d3j7ilxQIxZohYNRj0p36DXTLaBtqDtZHv/Ej7JIYTOaew+73fyzmkJKLepWIz8jnhDJLsg0azLa4c+kE7V00dbOVIQp7tQpbviWfaO503Vy0vcVhNlVhK7c6hCX4mxkfFWH0VKP21IaOXuPCAS/4V4+U5WozCu2qJOjvUyNZO77lC8awqe6V0yTU1X3WFWDgagnUErBJnQxSb0wJ8U1EKcwIIZdqk1uTBH5WH6T7hWf0iypGJHzktX3P6ddgQmaPdRU1iBMA8jZq9WxVxk+YRDfy60ayclPZrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DS0PR12MB7535.namprd12.prod.outlook.com (2603:10b6:8:13a::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.32; Thu, 6 Jun 2024 21:44:33 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 21:44:33 +0000
From: Zi Yan <ziy@nvidia.com>
To: xu.xin16@zte.com.cn
Cc: david@redhat.com, v-songbaohua@oppo.com, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org,
 yang.yang29@zte.com.cn, ran.xiaokai@zte.com.cn
Subject: Re: [PATCH linux-next v2] mm: huge_memory: fix misused
 =?utf-8?q?mapping=5Flarge=5Ffolio=5Fsupport=28=29=C2=A0for?= anon folios
Date: Thu, 06 Jun 2024 14:44:28 -0700
X-Mailer: MailMate (1.14r6030)
Message-ID: <7F148A60-5BF0-4745-B61D-9AF5DD2F977C@nvidia.com>
In-Reply-To: <20240606174203124_OW-VQZ_ZLm4lGEimA-K9@zte.com.cn>
References: <20240606174203124_OW-VQZ_ZLm4lGEimA-K9@zte.com.cn>
Content-Type: multipart/signed;
 boundary="=_MailMate_8F064AE0-CC61-4222-94F6-4FE5D5C3BB46_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BYAPR08CA0061.namprd08.prod.outlook.com
 (2603:10b6:a03:117::38) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DS0PR12MB7535:EE_
X-MS-Office365-Filtering-Correlation-Id: a038c0ee-95e5-43b0-4625-08dc8671da24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZPOiN0MkHk55uint2UdaduIlxcuxj9EyOni8WVFit3DkgwZcRd0qqBXu2F5Y?=
 =?us-ascii?Q?zd8RSeUHvYypi0GsoOlgAIIc7mt1JO9ELQYZswSkTbAAThYCgsddkWnTi9ez?=
 =?us-ascii?Q?ydj+WPnTJCwKo+PTNBg+7inEsI0yfTVt25ckoSdLuATLf11UVGJvNd1TyZPJ?=
 =?us-ascii?Q?FRfykJ446oDGU49pp8VDagfGKW0p0wVfQcvXnMZjdbwKe2rcobW019KHv3R8?=
 =?us-ascii?Q?hMUZFoAGBx6ekMrMKvSYmbJoiFoENoEfYx5tVUUkewJE/LdAKx62UNA8lYl3?=
 =?us-ascii?Q?Jl5V0KmFi9EAmNonzeZ1nQTAY3Odqan0oiWw26boLeV94W3FdPhF2IWsU95y?=
 =?us-ascii?Q?aWLstD8Cw+U2u9trkkyE1IACUudrEefneFOgytgkEoJonhnfe7POLVkzPkIA?=
 =?us-ascii?Q?N3eOfc7xO2zgVZ6Zkl457b55RysVnFrcLPM0A7mAE2d3wdRd60oSIIpGDDpx?=
 =?us-ascii?Q?iTeg7lVQe0K8Fbf5xQW38hprdWijwZun5xXAR8b8j7dc99CJ5VCqLt6BfHCV?=
 =?us-ascii?Q?Tz+1ZZRQfbEy4pKGUmy0c0EMqJcV7gDxxpiz3AYMPozK9hHutuypOWFZyRSn?=
 =?us-ascii?Q?Q5TktiBanKfIiTJe/DCMdYPbedZdfneBHPwH2cejpBMsXBE14FHMfsHdtbYX?=
 =?us-ascii?Q?LcEYiQ5YWcn2ypuCP148rrv6qy4/l3zDvPYr6Bh432hz9c9Z9mgWOhIto3Ue?=
 =?us-ascii?Q?TZFsWE1tvD3wOxOVgCNz4+dzpuYkBtaWXXAmvam0iwDJbTgTaw6ISqkRDTFb?=
 =?us-ascii?Q?yDFKVuDzPQxmEv/8nFnAniUMraivAi3r+zW410NVw+awV1CIgMTrY8tO/iqF?=
 =?us-ascii?Q?4oDHP/YFHVvN33JSrs9yr76O6KnmrMhCx/PHOa1QDu7MZrmKvG9rf3H+l6aO?=
 =?us-ascii?Q?Y5uRYeRMqjODO2hU/me+64/C7ogXXfsTd8pJbxXzseO3C+K6ZZvTk/UzKsUj?=
 =?us-ascii?Q?5YQzItEELtMgR7pJx5SlsAliQJRxAUBflY2nbFsokMYZ4cYRH9MXcZ9i00+z?=
 =?us-ascii?Q?xTGO1ZTQPvPpySxyLyVx8Mawzs24+4M2l8lbxuQrNH9sE2bJHPUudz5kwvgG?=
 =?us-ascii?Q?9U3yHhCFTmemiFRyjYxYMZrR/S2gWsAKq2UDESPAPK9PUmJNidcduqslPkJM?=
 =?us-ascii?Q?eMoI3zjK37l2O+lMtqXt4i/zeS7S2DsMfqV8SISY0OEfnnDqwGOuyRJahlg6?=
 =?us-ascii?Q?6rbSquaZB/ZqNIwcB9ckMMCIzk5Ask9CIOerT89YwmatgEkp/M1ZxPSU350b?=
 =?us-ascii?Q?5mDuCOOjXAfynZApycdhV57PRDeElGtV0Lbrbt0y5evj8UyrgjpAhEqs6Knf?=
 =?us-ascii?Q?HBScliLPxGW9V1FYsTSr4uUe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uG6GUGNfDew482B/+TnwqYojQddP1/IyiHoEbnrbExvkJyXcpZEYq5IjCFkC?=
 =?us-ascii?Q?TuWxqEaXkaa29VRqXM4pYWNOz3q6zfHK48rgjCHBwNAV6qbkrIUBdgY2jeYj?=
 =?us-ascii?Q?L+ph9/GsKXI2hbUES9YaiueEYUoRJhl1SFdRn8VbRPqqVWbX1CPL9tkD+dTY?=
 =?us-ascii?Q?c9dLgqMVGjcHuv7WZgBF8GSJdpsFEFG4GKOTCQcXO8vVwoOjANqUQoNKK+On?=
 =?us-ascii?Q?eppEV2K6yLM+ln+ERamK6I+DvI8Pi9c3rG7dWaxbvNJDDuZ2v+INjQ1WsVdu?=
 =?us-ascii?Q?KdSxl0Q89nsvNuUX3FfIDmTNQ9X9Hsj17y+EW3rDkfP9/cJNCHeV8IiwK87x?=
 =?us-ascii?Q?6X3j8eLGcv2KP1aQ3g7PY4Z9bk8eSVlOEvedM27BWR9k9cylPAC1YYBcW9th?=
 =?us-ascii?Q?Hf8RVhMaTY+h8a+Igq5hRWaNKEX+2CrJ+YSD0hjdbpEryZFPQKE1CuvS90LN?=
 =?us-ascii?Q?cIaGbbhsJFmT0yjNpnocjuT1llmkw0j7QvpGk33NxmsWLhAh3E2EoKatYbo1?=
 =?us-ascii?Q?tlYi5Wjd2jJOO4eEp1MbMubDCh9spP0SfJt/Cb6J4dKk7zVkZGNzhP76X2R/?=
 =?us-ascii?Q?G8qsQhCbcD4QrS/Vp+u8tuS7BP8xYKs+kQzZtkw8lVix9QACbvb4tc1l/afq?=
 =?us-ascii?Q?4NO2XckqBvjgEL94goXMouROgWvB/SicQxIPi4UDQV+rPuYhLcgXue8q6g/y?=
 =?us-ascii?Q?3PlnnGd8z4MeBvCIpPsKm5epMHAJQZ4yAWq59s25YzvryDv6DcTmpPM6fWcx?=
 =?us-ascii?Q?aTCJfI4ekp6nSdvesTd9OCK/bca5ki0fza6gt4TY6lNy6qElACmlWPLuc87l?=
 =?us-ascii?Q?jwIEFfFl9pY16xOKv7xvHcXYZhy6crx+j3IkP7yenfvd/zmBcHcrOZj7IihX?=
 =?us-ascii?Q?zhp2Kf0FiIceQ7ZVQ7v7PMELOd/KgfJQf+fF0T/MZArBdSl2lPS3o8aK9g/G?=
 =?us-ascii?Q?8qE8vO1HN5tkXCPoyCcCh8S/Xb7A0h2IxNaRqh5bUFpvczX/B1QnsgD7vNb7?=
 =?us-ascii?Q?ntUI11jjh0c0Axt3CbIYewnUaNSyjgngTpUPvWgEpzUaUfDevtW/RCaDL9uH?=
 =?us-ascii?Q?X7JcAaLyNtM1HqbHrOJ0qBpMoagWMFQScu1d+NTU97qP/6mls6ottgX5Il+F?=
 =?us-ascii?Q?wXkUXNledSEzSlxMbsbftG7dNrgMOsr+t7rinDg7C5aceiMuSCCID3Sp1YvK?=
 =?us-ascii?Q?IGOdc3/NwoiQvlO9Q1ZiyXlnn6xPi0QZIopwD+He/MgIWwXY+NK7d2JJ/Hij?=
 =?us-ascii?Q?iQGlAUTnrchakZlg7Vcsqi0ZtBQKO+CG/5XtPaRIYF0KN7iz40VKrIJpbiQz?=
 =?us-ascii?Q?O2zL3dfPa3FRX5cSqlni/R0p5aMI+rAXYwCgJz8bMp3g3qod6e5gd1etYGYY?=
 =?us-ascii?Q?PDZWNJPSftXSsG84z4yNo8ZxCaWIVcVIgSvDBffr08w2+XKht45D7p6KCon0?=
 =?us-ascii?Q?Y3BTwR8j2VKV7ehO/ZrkACDDW/4FvuRbUEjWXvyB0sYTqF3Xk9tU14SpJoMD?=
 =?us-ascii?Q?Nc5Mm7RSx02f7rrNcPbX6HyPtkKI7vTLhJTgOLsZj3TN9ZZUiduVUJl+Cd5y?=
 =?us-ascii?Q?ILur7+wH1sf2lVpxpME=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a038c0ee-95e5-43b0-4625-08dc8671da24
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:44:33.0229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M6bfq8wq+9r5JAcdnakU4aItCIjMh3GH8CEHdTo9cEHAH+KYIz46vlXfibO8B43L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7535

--=_MailMate_8F064AE0-CC61-4222-94F6-4FE5D5C3BB46_=
Content-Type: text/plain

On 6 Jun 2024, at 2:42, xu.xin16@zte.com.cn wrote:

> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>
> When I did a large folios split test, a WARNING
> "[ 5059.122759][  T166] Cannot split file folio to non-0 order"
> was triggered. But the test cases are only for anonmous folios.
> while mapping_large_folio_support() is only reasonable for page
> cache folios.
>
> In split_huge_page_to_list_to_order(), the folio passed to
> mapping_large_folio_support() maybe anonmous folio. The
> folio_test_anon() check is missing. So the split of the anonmous THP
> is failed. This is also the same for shmem_mapping(). We'd better add
> a check for both. But the shmem_mapping() in __split_huge_page() is
> not involved, as for anonmous folios, the end parameter is set to -1, so
> (head[i].index >= end) is always false. shmem_mapping() is not called.
>
> Also add a VM_WARN_ON_ONCE() in mapping_large_folio_support()
> for anon mapping, So we can detect the wrong use more easily.
>
> THP folios maybe exist in the pagecache even the file system doesn't
> support large folio, it is because when CONFIG_TRANSPARENT_HUGEPAGE
> is enabled, khugepaged will try to collapse read-only file-backed pages
> to THP. But the mapping does not actually support multi order
> large folios properly.
>
> Using /sys/kernel/debug/split_huge_pages to verify this, with this
> patch, large anon THP is successfully split and the warning is ceased.
>
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> ---
>  include/linux/pagemap.h |  4 ++++
>  mm/huge_memory.c        | 27 ++++++++++++++++-----------
>  2 files changed, 20 insertions(+), 11 deletions(-)

Reviewed-by: Zi Yan <ziy@nvidia.com>

Thanks.

Best Regards,
Yan, Zi

--=_MailMate_8F064AE0-CC61-4222-94F6-4FE5D5C3BB46_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmZiLbwPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK84gP/0aLzlx+Xn31V4aGDj+0GLTyLVdMkgEdAs7x
h2l5aCfwGeCjocyw39Dh8Xgucx/tccaugi+jmkb5QgBQ4ocpWAvDCrT+rW1maQrv
agIoE7vBiBK+wni7XeCRx8/SKBnnKx5lLo/kW4sOKVYlfcV1Xccu2mHdw3wsfC3R
H1eSo3Q9FL+OsHgvd1xnFQWUIUBBApeHCKt2lXD3RzLq/hq91ZMwZDBQze8TSOyg
HCbF9JjaOHWomLNew1EsUAl+UPHJpT+uzC+SIYfCKdyXSonfeXyZr2Hvu5vsGjX3
LgNTDb0waRWw9jFtV4Wz8ZlidHbr947I+Xl/yyDlBXF3yZDrjkk5dOi2F8LssyWa
R/7j04xHMTax81K2ZMhuGncLcYZ86k75rwAtEqybtKbC2U4Wyb/a5/FN+Vj9k6UW
RKddMNX4e/ToKFGt2PPRE5z7B8NQWvgiA7gNrQjhyP6Q2OUwWvXij92cOGrIWL2T
6zQgRD2ZVqhsPpcL5PzkYbKv1WH+B29cSdWOpYE+17zdPIMMDgmWal7olI1xrTG3
ZWZhFCl5nQRDZvkGd5oKtp2P2IWlZh70oePb7IfSJgvcifoEdH6CUBEW6BPcm3+l
BVQ48FaadFo0R2Nn5tiM9bqljKV/YSbu+0EPttAPkoR9rxWOpYMLodlA6qlVH42O
iueIztHc
=unfZ
-----END PGP SIGNATURE-----

--=_MailMate_8F064AE0-CC61-4222-94F6-4FE5D5C3BB46_=--

