Return-Path: <linux-kernel+bounces-281024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B7094D1FD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E793A1C21478
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645C4195F3B;
	Fri,  9 Aug 2024 14:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EZ4zoIqE"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F304B183CD5
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 14:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723213067; cv=fail; b=cVD1e98ignM9td4NDEW4nntjPZG5kkhZ7pNISZMZVpoxgstt1LrtlSjgXC0uuwNnpAI1zliX/GEjHOPRpoLGHmedfyfI5fg4vvwacrdpsNyF4ETv1csBP6x8h22QwQggJJcJHRfr7jQQ5Zf+xTQFJixxsp4qCKWAgO2XfO3/lUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723213067; c=relaxed/simple;
	bh=fzAYrra3+uUg/32rYPPFpupIUp9CRf8e9bBzD545fiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eRT7TNQ8S3DvOy9uKiTZpHCkta7cvf9TSGVbZMNza3ycO4nlSyBUv+dbAYLfXB6EykZOrvzvjT1y/MGKN9dfw3Z5NKNMjXD9Zfy7JZDbeHdCHUOvNO1OnWAGt07vqpPp/FQQNpkIvGX/6DYkUWNM1p/hznVIGCdTnPcXCJ3ntak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EZ4zoIqE; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eKMGkVvrbHvOMotiGsdBygyr7Vbkmy26TZ/IlLg5NtKk90IvOGpXQs+0PXPiEQSZ/AmazpU8ti3c5vp2ydYNxw3zLlbSaVaUSeJeNRuj+kp9vwszLp+iZiThAYvaW5g2y/FVFZDVBCYnvx6vcf6iF2lpuNkEvvfAtmY/1+8vkLqFoz455NYJOGFfFvJH6YCTjGy4v+OmHUFpwiMeUPqsHZQG8paIbPD5DstLbrJcqguIVX8pE3cM4aa7bvklsIGDh+09oK6wpfpnw78J1UqFo+in0KvwTM9lQyW0RbucPanQfau28mzexTrlJWqyRqDrckHS4vkIIbgZJkuRnnx39w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzAYrra3+uUg/32rYPPFpupIUp9CRf8e9bBzD545fiw=;
 b=enoo8DruZ+xnIVfXhPsD3Y5Wr45VfV3B9Rxnwqeb9p9o8Blru78JhlcnxNiMAazipgX3bhA/+yN89770coELZXrfRfLs8LCwOwFf4QAjgyVik5CBSYUiN0xQq5bbVOtQWA9/JWRYlXYyPffUSOa47gPsXHQL8/c8c4i1OeZFV30jUhlvFMH/qcjlxEsoMszn8Sql3l3WXEAmKpItN1n9x5FEOpX63eaJMYQVaqJ5DWr3NQVBTruhf/TiyIPiDeATJmugbSVYjL1XDnp4pnzM3GGqUB5qUZeK8OKpSrG2DAqqlrEO9hTIvYTdEZSYhnpYnrmcJFmxhSdyJhIZRIIUdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzAYrra3+uUg/32rYPPFpupIUp9CRf8e9bBzD545fiw=;
 b=EZ4zoIqEAS8xKi9BkVvTU/K8UmBUw4YHvgSyb7oQ6nMtdBWmx28194dJNOoWhBGq/35kCgwgxYeXuyYFY3Qu0QPng6hm4XdxoNVCX5gs/PYgXA8f9Ph2FkXXc0DM+gbAzpio64g8+txsGdWrItlELZasfe+7atPvb/21RX0ggeVnJzc8tsQWFgNkw6ZygmI7w2FrOBx1aflW50GoiQTWnHS3Y1cSLAMy9hM23mOHkvBFEU6P+m/CKbRlAX//LTAbpFAsGIpJbZYKQI+DBjBvDhkv7hdJfRy37+49fSyZFUPBkYxp+djK2hTgzT4vBclwayAsCGO706T3nTkI3iGjjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
 by DS7PR12MB8274.namprd12.prod.outlook.com (2603:10b6:8:da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Fri, 9 Aug
 2024 14:17:43 +0000
Received: from CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f]) by CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f%3]) with mapi id 15.20.7849.014; Fri, 9 Aug 2024
 14:17:43 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, "Huang, Ying" <ying.huang@intel.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, linux-kernel@vger.kernel.org,
 Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH] mm/numa: do_numa_page() do_huge_pmd_numa_page() code
 clean up.
Date: Fri, 09 Aug 2024 10:17:42 -0400
X-Mailer: MailMate (1.14r6052)
Message-ID: <7E6B78D5-8AE0-4A20-82D4-B17365F6E364@nvidia.com>
In-Reply-To: <20240809134502.1504111-1-ziy@nvidia.com>
References: <20240809134502.1504111-1-ziy@nvidia.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_928A8D5E-BAF0-4D46-A108-365F29363E29_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR06CA0022.namprd06.prod.outlook.com
 (2603:10b6:208:23d::27) To CYXPR12MB9320.namprd12.prod.outlook.com
 (2603:10b6:930:e6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9320:EE_|DS7PR12MB8274:EE_
X-MS-Office365-Filtering-Correlation-Id: f6b56903-6649-40ad-3c72-08dcb87e08da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wLeLfyh2+idehRyycRfonbEc7DCQT920XyAhGs8FME7tdq8pna8hGmYeKkNq?=
 =?us-ascii?Q?WgbWNQMotId49NbNrwqQwjwLfSty6j0Jg3Yjxeunk761Au09zb5SkdUUTVyg?=
 =?us-ascii?Q?N2xkbuKCs+4xN5hNLMCrH6ONlZ8ywMGu6tHedAZ14ZFJAvhgVzOFocjKwlh4?=
 =?us-ascii?Q?ka0QG2hO6jEHX2TUud+T98MftP0Ufkb7CUhEjgeXMnAIBkqbwwIcPQchCW2G?=
 =?us-ascii?Q?9n28rzv8ioRmGsVh/PYZ4DnvfltuNtoy6bg54Ui4gGjtbY2GaUCORtk+bRux?=
 =?us-ascii?Q?FwqRyZNmiwgrkp0JYUYau3gRs/cuWcdrYx3PXvUmCDRg/M2P4h8yQRP1fe8o?=
 =?us-ascii?Q?HADO5W4fITLXrBYeuU7TOWmFYC1cBLXYCChkuIJFyg101+tE3XjZO85H5g4o?=
 =?us-ascii?Q?z6qt+P9XQpbmL3sMAA5yEiKPMQXt9mSDZBejiEL74QlxHK11oU4V4wV8jy7T?=
 =?us-ascii?Q?zPBmogaSqT1VQH6bjnKWl3AkMCto44lD+4ijHJo1TwkdTGssgPNXxYroFmoO?=
 =?us-ascii?Q?W8Z6R8YLfJxQBGldLrEkKDtXgcYxpUUh1oFyo8BMfVlp2w2pbcxw2Nxx9tMv?=
 =?us-ascii?Q?drC/CTEQSLuehO2BqLWsf+32N+0xy8o/MIzgw0dM71rDDPmyC2PCA+I0GIPu?=
 =?us-ascii?Q?9FhtoRCJS9qZu6Q2vZxbfa4s/Ef92Ft2ZhWyMpmJr8Pn632e+8xa2yVrcaco?=
 =?us-ascii?Q?EGZpPKPVg8A5KK7dmlyPgosUX2CFYIyXZbuCVeDo5fBfn+nphj9+2/lffd4R?=
 =?us-ascii?Q?1Q/cW2dxUsHoMdEx/eaLl5lQpSnHBiGDYokeBSLzgSJ1MKzKuTU9fxxhMwe9?=
 =?us-ascii?Q?Pzx0NatAEgveSnEYx5mku8KaieNowHHZqqZiHzSddK4nMcC+69TufTnV6unr?=
 =?us-ascii?Q?SCE8kPudi4sMPp3Iskjehxft3Ys2sAi+fOm5EH1X5VFTmspHRYqXYmy3st62?=
 =?us-ascii?Q?wOTPxOCA3a5mgVyRe8H6VWO3+3v1nAWloJxljQy0h2vfqojD6mkrXh2NXi8C?=
 =?us-ascii?Q?onqXkLUYnuQSludGhGPcdfpDSdKMFpxgRv9AS0Iry2yvaWCqGk7OfqMk3uDU?=
 =?us-ascii?Q?v2oQioDEZCHiMlz+5lzl0YyM+7+GSsYCKTJkpRbBcug798IQD/nVDFb46zJK?=
 =?us-ascii?Q?R6vtu7NGa2o2dqWbjoSo6d4mS+WBMD/Ic9rjAcYzmjktSZS6SHyNQgQ85gpm?=
 =?us-ascii?Q?9BFpSphjtHWJjOQ1wOyJkghOeTDZ9JpqVV83pd3bGO5Q57cDaGQqgevFP/SY?=
 =?us-ascii?Q?cJrdjKA5VwYp2iooDqnGc4YYh/wlEFNvci1Ty51VvDes3ikuSun5Q2/R7P6q?=
 =?us-ascii?Q?UzzNQwG+sGzHckHvFahV+00GUy6yyj7GkBBoenAlaCuW5g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/dGoKE6w7D/pFbeDg93ox/JtKAjyIlP33ZKK9yP91q0HDCEoNTPr9MFYcc4Z?=
 =?us-ascii?Q?ZVsrW0q7x9BYyZN6tKr4VKDRaNHoFtwBMfW4NhWYKdSj9uSASXdH5Q1aGca0?=
 =?us-ascii?Q?Xy8T1Rd36JYcV71XEIrQIbfyYSunA9mr3MDb4LiRBs9t7w+KB9mF3mHx26eJ?=
 =?us-ascii?Q?dtLXzgq29ffkTI+FTTTDJ+mpoBc0YlA+h8HC1eq1OFcnwFVnUI1biMsW//0v?=
 =?us-ascii?Q?yqlK+VTzNI33e3xzE/EOZQh7aKb1YjpmS3dY6wALicF4uhRJkiOYnp9KeDbZ?=
 =?us-ascii?Q?gI52xzvdNQQOQwsKV4FhK9PibVzF+dp3kto2RPEmbbHNwqyn4H6um+5f4xaM?=
 =?us-ascii?Q?Uuv30bbOkJmSGujFMVumHeulwGGXNGx9quGEQ4QbmfMlukTMo6xNcaIG/gj9?=
 =?us-ascii?Q?jctBliEdfONM+A+LVM04yT8rGu07fDxZ79jYU4SfM9Iz+yIjN1hPax/7HtgA?=
 =?us-ascii?Q?UY8PONe8OwEFn2wZwcM7IMd4aISpPFDho5lkdQRPggw69N+6gyJ+zkokbwch?=
 =?us-ascii?Q?ILF0I7ODYizDj9d/GB52tZWGnJz+7ZaDWblyUYqf1z8rtAq4msEm046fxqBd?=
 =?us-ascii?Q?yWfAEzIRt2H+gQnsPrZN/NbljRuJRp7C+OHJdaEBuc/m4sqyfujY5Qe7A5Qx?=
 =?us-ascii?Q?MgfpnijGvAOoMHgf+olOIv0ESg/6upGwZgPTY6ejR4b7tN1rGDcn0LRtn9Xn?=
 =?us-ascii?Q?IVLEn+NJAmP247W3jo9hQ1DooNRq2zZb+VrcuygK/MNvOi2n4d//vME9s+el?=
 =?us-ascii?Q?rH5JV043r6JUINzT2isrSAzhfVmhLigG3N3WLNpGR3myyNCPbVK7qnXVzQR/?=
 =?us-ascii?Q?rQksfEevzLk+Uq4qPOYevRdQ2b7b35UIDyOEZQ01Mbr7PwOJvvL7s5mGtBON?=
 =?us-ascii?Q?l/x38rdpSLcQXikHEzqRDmEPKyGTwpJfxT5Bsar1yejdw9awDZL6D+OEslSY?=
 =?us-ascii?Q?7KbydDyt3sSZ9XbSIExAkt33z/aNgOoddgYPfvZkLmGInGG947h/f+5K29uj?=
 =?us-ascii?Q?6r/qQObmyOdA9lUYAVr0cWAfn2pgm34xzabXaVJ5XkeBmdGbt9enTckltHvB?=
 =?us-ascii?Q?5xttkbBX4PX929jGKjLGwOzgz+TOpj4z/aj2eshN700WfRcsPTCAk/F8/qvX?=
 =?us-ascii?Q?2BCG+GfF61QY4a2eLYhQycAlTAUziEv0Bfvw+CMADZUC6Jj/fubZHSgpaQmz?=
 =?us-ascii?Q?HvqdNg4RLtSNIudm+TAx3d4QEt/K8TjzXOcB0lkpq+5aBkqPXRix/FO0Mfg0?=
 =?us-ascii?Q?pjyDMm1i+uSTqJ8NQNKKvOn1VCM2LG4cTTM9GdKbbzfx5GwB3+iAu2tElnMb?=
 =?us-ascii?Q?n7ibSpNoTpMshTGKRugHyWgzzyKtw4l61XsSyOLJZB8OZRSpFIpOlD9BzWCQ?=
 =?us-ascii?Q?wXB0OKKBPs+4jGh5U3rEyl6fOfezJYeErzWO4lN9RmJ9RgoxXrOpnQmva3zt?=
 =?us-ascii?Q?ROeZ6a2sTA9914tp6XHV3pBKLcJwU8Lxbn5DzdgAKT+xIVBaMaebWGqLmDrF?=
 =?us-ascii?Q?YzLl7FHTqSukAlgGfENgB4thjUNpP91LUmFd7/qu8PXVkQ3regMol+BLrppx?=
 =?us-ascii?Q?WLSBGkNzPYkM+XIYzMJzmlGfoSi282LTEfuizWnz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b56903-6649-40ad-3c72-08dcb87e08da
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 14:17:43.4358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RqfmMKmuF6+xbZLZI5gMehhRWMFSOXOaLE5jHGrUnObR2py8uAj2kSQHOYC2K+as
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8274

--=_MailMate_928A8D5E-BAF0-4D46-A108-365F29363E29_=
Content-Type: text/plain

On 9 Aug 2024, at 9:45, Zi Yan wrote:

> Remove unnecessary else branch to reduce code indentation.
>
> Suggested-by: "Huang, Ying" <ying.huang@intel.com>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---

Please ignore this for now. I will send it with other patches.

Best Regards,
Yan, Zi

--=_MailMate_928A8D5E-BAF0-4D46-A108-365F29363E29_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAma2JQYPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKKoUP/RgteeOUdlMBUp9LJwtm2OgI1eDjDlNtaxwX
+Wjfj4wdn2K+F+4dHQdJiSyxFn7qP7pjggjnRk0cfn7pCHgt0ha64QJhluqZ9Ew/
C83c4kLHVVxTtynz+0fL4u7yRTz7nsEse2xqTmGCffFoq6Cawk857/2iT5/Fu+1h
x1O0NB1H5FTP7ur0T4/3XKqvY1W69Fipi6tQUl94m1gnoSnlgOvAmTpB43TQyrsA
CsGNg496ajkGoRnOG4V54Ko/vtZFZwMzU628lIYG7ol+OXgoVVKCn0E3xn9/mFKs
kb/hPv6b/pdsiOaOmz2NFldCUyQQ6r4G4djrWXg3RoCh9T8YbK6jBAibRuOZfdzn
qs8s11ldA1Y4q+i2ykso5L02OwgRlT1qpCehYkSKEWIdWKu8otFYZXgApIhBT0ol
KwGxeSvqWwUzExWHSkpTuARCrF8BsqVVejUyaE2YVLUK8/altvsqSpTjZb2UmD16
806HA8nVhRbpnafsF4oyg8ZnuWq44h+C4ChOF4k968VD2YjA0mQ9PASOyd5gRTDt
o1B8J858BOtJgxFF0lZz1/qjbLt0nrdyCMadqSGNzXfb9F1iEbr5URlNafrXJd1j
+JxO859vlKX6rytZ01PUDAZfIbjc73nDYRu/NHi6hW7R1VVxGgclnj5gFnKhzhpY
irYS/Yle
=WlqA
-----END PGP SIGNATURE-----

--=_MailMate_928A8D5E-BAF0-4D46-A108-365F29363E29_=--

