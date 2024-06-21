Return-Path: <linux-kernel+bounces-223790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A79F6911830
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 03:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 074E2B21D38
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 01:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8808287E;
	Fri, 21 Jun 2024 01:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l37Hz3Ji"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2058.outbound.protection.outlook.com [40.107.95.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81AD42052
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 01:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718934564; cv=fail; b=LjFfWGuuahWzIMG93ps92yH6Y/jlyub3I0lNZh//1wMrmeHcSdXUBEh1LnxrNqh1KcLkLxBJ63TV9RzuFuqllaxcNiSyjIMNdgt6mjn5YcrndfyOBCZEBOsscm+GfdrWagPwyAN165b/ZJ9PxiLJcsJf3Mz8kdrqCJ0sBsOwwhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718934564; c=relaxed/simple;
	bh=PAHY2GgIoXvqF+j169QDYG0IZEup1l37f7/8AGKP684=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TWpttL2lbYGeVhI+W9af/60x8s+EdupFkl3CodUd6RLw8mxVphaYosbn+EDDb1hryYNkaAP8e+dFmYaZmygvai44tdqAj7k6VN6gq5xpDsFwny/rxUfSrQTYB0WInEqE27/oC6VURu2Bzr+RmcqGhRFuPRU9k9+E4F/tLOm+Lc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l37Hz3Ji; arc=fail smtp.client-ip=40.107.95.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1ZXA6hZ39I65RWgWfhTGUdWdB3Xdh02HahkvzGTwGDhHq0OChCjEn/9jqPjbBqzpBfaDDCQZW90qcrb2ja5S7NpKJ3ebJZc0AR3DBSSVQ9iqqKqwRGQWzl3wq79QikWYF7ruGzteyJg7H01XUsKoij9vcdPjj9izRaLfJNLMZbek5I+/eoaAScvaOBXvJVOIwsEBhjWcmBmXlA9Uf1UjDtpI9Sj8FGCCCr77jui5Qxh/Udq85ePyczgbfzju3j3DPEND6S6hVSzQwjbQ/QMhxlfvDvcpjQdBzNXiUiSY3VxPzg6kZ7ts5axOv/J2lZQ65fp7gU7e3a980vvbjS3jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m35XQfgiFnccqZpscanjIpRbz6ecx5UqwiOYBRMTatI=;
 b=Ya1BDwgFy9Qg7NwPqFN3TnO4ZOdFwh1EhBEZ/s2ZKoN3p1bXeSvN5Sx+UhQIV0nDormp4j7giRHgDibGFs6qvhgVO3tQLgljeU08UFtD2nMC3xu4WZkSucNxECxHINM8A1SQ8RCepwrXSAuENeVRqsTnyA8Sp7uwZIL/zFS1z8Bwd03MAYwfP3ku9R0eXAZEz6LzUPP1xQBjp68EzVbpT6UCco7VtJxF5a6UEWOtp6/YBwM1ZRCXXpiPbN1IAJ6vlc6EV8zebjz0mdeUZJWYkB5UA4Zbil99JDaWfT1s1gic22pTwacBk7DRNWpwmM6+0dzNZngORIejC5qLUlgeWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m35XQfgiFnccqZpscanjIpRbz6ecx5UqwiOYBRMTatI=;
 b=l37Hz3JivfOyEQuGommcl/5mglqZVk6XtF80M8P8ry4276JmNExbI3UlxlUValbyGezyYQgFRlmeOftn5vgHnmFSrV6n3xH5X2+WaCKgflPUwHc8FHDLyVEDMq7ARSP95zmnZTPJLRHgxiKYb488/8N7MZB3RRFeOlBfMR1QHRcWW11V2Z1nwFMwQIgnu/lBNUU+UX85X6jjRGZnFM8JYgpIGILfF0z9oiTXPtvor3mFabaUuG+cOu12EGVFWVV7fcesYn5mYRokldz9xFmv/RS6yeSn9VvGvqSvo7/xw7HeOOFKOhtPbru+VXq5T21HLMZIbcz8XwmYgOShR8mdaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 BL1PR12MB5706.namprd12.prod.outlook.com (2603:10b6:208:385::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 01:49:14 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 01:49:14 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH v1] mm/rmap: cleanup partially-mapped handling in
 __folio_remove_rmap()
Date: Thu, 20 Jun 2024 21:49:12 -0400
X-Mailer: MailMate (1.14r6038)
Message-ID: <E5B837D4-A5EE-4EFB-A80E-20DEFC80FAD2@nvidia.com>
In-Reply-To: <20240618151026.521019-1-david@redhat.com>
References: <20240618151026.521019-1-david@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_C59290BB-B6E4-4921-8FD7-DDBC0632AD5C_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0261.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::26) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|BL1PR12MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a03e85c-6ece-4c26-ffa8-08dc91945aef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fXmXAIH9U7q9pTjZOtYMrsJsXPxNjnx/5hgRI/FE5Xxas2dUk2zVytwhleVk?=
 =?us-ascii?Q?MiJCstin4p5dZwaxarrp4R03RNA+mOzu8jWIjC0mEURB82HeZxYHoH6qCkfQ?=
 =?us-ascii?Q?XYMvs8dEKNMKUDcyBnABTzsNezu5fjjTLKBoPiy0dlgsh+pC8bEjW2a3Yo+F?=
 =?us-ascii?Q?FWs4xnCcoIHGCM206pFhAlm7F4j2VWJh6ZoZ26R6gM4jEBf1Am3391dUBYBB?=
 =?us-ascii?Q?5VTirckFN12/5itwMvlAGku6wrCHQUaEPvYcGV2zAlZJWERzdFcE880HnsSh?=
 =?us-ascii?Q?IdAH8DzlddmjoBrael0l09DtJW/yNuRNdLEhlckKz9lPYbrS2U5r/5OLwvB9?=
 =?us-ascii?Q?dYpKa4cZyDnhj1JIasn9vfJM2q/wcc1WaYuSxJv7UHcBpBCSONZdQrf6/U3j?=
 =?us-ascii?Q?hL14+JPcI0cmhekE2lg6ECAMvfRuSDocp/GYZU4j6JEXsh0yUu/F3K5nxPmQ?=
 =?us-ascii?Q?mSOopQWdzX5gOQBKHUhVkfY6KEs6WmdC61z1WpjMBgpfnWQc78+gRULbgkFC?=
 =?us-ascii?Q?DbDt36DRf3aX+lIRio/mCa5PAKRQqA7+6OwUJLZlRx/p/i4Cey6uCqfwaGx7?=
 =?us-ascii?Q?xMs2woBUl6qRnsK6+08xAh4ZSomTFTXL5IPbp8HAUI8WLq55/z+3mZu0RR9/?=
 =?us-ascii?Q?nZGpPnitY3/1CAj+1vy4A5FT9oyxupjraaf6XktTqKp8wDyTEPS/YJGo0Pxs?=
 =?us-ascii?Q?KuTUTSUInjiQMy7NXWzAKEMKCS5hYvpzNmByG85E/xz0m/wW0xSDSTAJ5LTF?=
 =?us-ascii?Q?2iApMA88Rf9B+YkU/7h4sfdlWnCQYKrP6e5SQbc9L3YJUPMyni5dcTicX4ly?=
 =?us-ascii?Q?i+VB+gdSiEmZHACGOwROCxbhPUMxcml2CH9ZdbviSBVwkqDSYWPCcg6kNwJD?=
 =?us-ascii?Q?rCBxapWcmcfx1Ph+T1x9j2j3TAwCHwdyuQUgklaHEwVPgiamFXLocxtlrXri?=
 =?us-ascii?Q?iIQWERogjLFsJKdkMoo+VITFICpLqyMimjDrKV0AAvDDj8sjyod2inRVk6fM?=
 =?us-ascii?Q?crFfrlcWZDUPjTc5H469kUuzuJbP4qjZmDp4DBhaGVtc14WBYGjQjieGkNRs?=
 =?us-ascii?Q?iEqeW7mzipFFftYV4jKBkZp8VUVcMUOYiG61tKg7Dury+pLrIcWr0OplCWwN?=
 =?us-ascii?Q?XRv9bDKZSOcyr5ow+KJ7s3x0NVzZEPb63VYnvCjQOJ16d0da2I4vMEFORUGV?=
 =?us-ascii?Q?Z6qG1lwh3QKU3HXcO44vn8dNafEGqidzVNJHQsTZRAEjvK72S/P7AeLdv6eR?=
 =?us-ascii?Q?VhTgl9GL+9VKVd6hNGGgd8lbdWRKYOgfjeU9W8ocMRaOVxSmjw6Nfki+JbEO?=
 =?us-ascii?Q?tOjWiJrmBF7wr/9RzVo/TGON?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/D4TzYVaL/p3FgUxdYtPBM9X2fhZXnCcpHO9kvTyoho7ntVPSVjQalnAB/8a?=
 =?us-ascii?Q?YF97Za0PW5JNVe2168feDqfkOYDavOGwMfwiXtXPwkjZSafot8DPdNGrwIZK?=
 =?us-ascii?Q?l3KE8cWE0FmIUyGg3b1xoAxwWY6I+uiMCOPCUDuYx4gNgBM9JUsgohJra4SL?=
 =?us-ascii?Q?PczoS+yXyD9x/oD89v77tYqhOOxnpSYKMUZ35eLe7cU4yh27u4X1oBta0a6N?=
 =?us-ascii?Q?S7VuNaRvCjwX9S+Yzk9gRdJokBqLgNwRMimzmjxUA2lt/i67XpNUchPyD4Ek?=
 =?us-ascii?Q?eMn3LuYQzsHYu33/XUkBQdm74KcL6chZbsu9UF0wB3c7mm29mjQoqX6moyuO?=
 =?us-ascii?Q?knJCamZlAkYKRUoD1Th2udML0Xo9FWHLEJUUhDw1iFqNz+iI8QCm1QSrmTEt?=
 =?us-ascii?Q?ckhDevlXuk1SISHdCIIUxqe19R+9l3MmHofRydaCZF+53Md4TBf7EE8na2kL?=
 =?us-ascii?Q?i5nVbt9eQbA/9pAU0AbrgiUKcLLbYLyyNillIyWyO0+yh+5XF5OR27KB83K7?=
 =?us-ascii?Q?va/dj67s0KZwz191iy+NnUw1CADPCCC0ZWWfFiGg885ttoP/VRtJinLOfk9G?=
 =?us-ascii?Q?/VUXeZGOnvfHje1JSqq4pPRKn54B2SoFBjMV5he1x6Ret1OOz8MnmwXNTpWh?=
 =?us-ascii?Q?GJdWiu/Ysv1Z27VvR9XlpPKbUzW7n10VL7EAWsgUqICENGLVhTk7vfJE8Iwm?=
 =?us-ascii?Q?uDHiVDl759WbJdo2CjIFuupT3TbjnIiarDeeUbb9iqr1ounCPaXpsmAnHIid?=
 =?us-ascii?Q?fdlawpB1fRWWDkoujbA0+LxG8xc0aPDCZrcIlsu7ITnj3412TzqS0KNobGgv?=
 =?us-ascii?Q?6rPhYceWIf6e4LxctRN+I+7Fvm1dGpayvlt+EhL+VQeSDyfuWDNORoSJ5elZ?=
 =?us-ascii?Q?+f0VTqXF85V30Q2lq0dFBL0wLwqgRlatnaFY+zKeTCJYtDSqzJLLWUz9v5b8?=
 =?us-ascii?Q?riA09BeUHNJ40PGEkveAvzkZScUG/px+WVuYs0y+wD5AvFGTScTsEMh4qt4q?=
 =?us-ascii?Q?iRQLkKCM/4bUxum3g0uL2Az+06jK727MLb6P9cehjI7qhc60PaJxl0DDf7g5?=
 =?us-ascii?Q?s1/6UVkyND38p0jmtCB3L5iRSp0ntcZOh3j7rawEbSEB87aHKPOZJfLn5m1A?=
 =?us-ascii?Q?dOnNYvCQJXpRD8PSijA5O/J08Y0uwV0qos8S7WxFC6Uv90B5Fr2c3CXatfVw?=
 =?us-ascii?Q?87lcVrVeVQRCkpHyERWrgSqbCB9VFNYh/pS/46U3jIpxbC4X+D/QmfNNk+mW?=
 =?us-ascii?Q?7kgqm+6696yo0Rdk4Thsfon0SqhQH9GRpOsXOpLcTu6hFiUP7yiDzwxEsuYY?=
 =?us-ascii?Q?+ViRaVyW2Gt/RCdGhMCmGJqBglyCwVD9eSiENcqtuGQ1DIreehasolkYcuCk?=
 =?us-ascii?Q?Ewbz0wBHI/8Dcn9gjCs/VEVhw1oc3YNtf+mMZG2+NnSh1Dgg5wJLj12z6gdv?=
 =?us-ascii?Q?DdazDpRZE6GNqqdTOo4HvtbDjQEhgH60vwifBCDEnWAth6aMWJk3q6vGRvXk?=
 =?us-ascii?Q?7HHC6lxut7FdCBmcicFUFKeMhCb8kbN1VBrnw1xhAYjB2jlPsXUmngc6L0Wl?=
 =?us-ascii?Q?w9dbGPLSV1xwKFivTQ6LUBRfxBg5hdG/KitxWb1P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a03e85c-6ece-4c26-ffa8-08dc91945aef
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 01:49:14.7568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XceBUSXLSMvDLUQrxQzZgNBIrz4lEv5winRHRKeyeC19HS7/w9yMpeNccwfn+SiT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5706

--=_MailMate_C59290BB-B6E4-4921-8FD7-DDBC0632AD5C_=
Content-Type: text/plain

On 18 Jun 2024, at 11:10, David Hildenbrand wrote:

> Let's simplify and reduce code indentation. In the RMAP_LEVEL_PTE case, we
> already check for nr when computing partially_mapped.
>
> For RMAP_LEVEL_PMD, it's a bit more confusing. Likely, we don't need the
> "nr" check, but we could have "nr < nr_pmdmapped" also if we stumbled
> into the "/* Raced ahead of another remove and an add? */" case. So
> let's simply move the nr check in there.
>
> Note that partially_mapped is always false for small folios.
>
> No functional change intended.
>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/rmap.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_C59290BB-B6E4-4921-8FD7-DDBC0632AD5C_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmZ03BgPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUgv8QAIagX3l3se6HyZHVG3innJ7ku2hAqaVAIjtL
ZnpeqibaSgZkT4aqwJjGdupqqJyiPokjbTiREsiGpujWb/W19ad+1mHoR+jjbPPg
HrCBuggzpbs79aw6iH19TUzNTWYGRMnhxMb0Tdfj8ZZU58gskDF2Ad0e/tFqGpBN
g5wgeDdn6XfBSH7Hb8R2tWGPqCovG7Ak+o6oQa/K7V7+hPvXGVDXdlxOUt9psuRs
z6fzt8QnmrJptuJyWafHmFnWvBM/Wx6w+H0HMvPqyVLOwxY7iZ9dHuWkExvdq8Ko
LjEaplENsdju4rhCmeHEjCSwLyQerl0nvjLgHY7DwVosuCcB7jirbrpNiTGulanr
nHRjmN9m5+wPY+7yKq6C8O5mgthJK9qjGbx/DhzUrfoZQGMiVUShHT7caT2DF0ZE
CYM7vMMSivbN6mb/LjH1Bl2w+rC1rmBmIs+vVqIMLsuAC7W4pGeyc25VZFbkdgNZ
ezasuqPK4ppT0zB+ew8skeS5tsUWnBggKAOaHFBKi70J61zi+PtT6e+ziYc6C4Iv
fPyC0j0OiB6epmPzGcttnSwxmkySJTSIl5JSAqHReTOfqYudBOWcrN5HDBN+Pp0V
a/nELZWL5sMFngrdGW0Sqf8e8o7KNOjQic+zqEmuuvUzRcN8WjIIIiK35Laomu+C
GanuXqGh
=xjSm
-----END PGP SIGNATURE-----

--=_MailMate_C59290BB-B6E4-4921-8FD7-DDBC0632AD5C_=--

