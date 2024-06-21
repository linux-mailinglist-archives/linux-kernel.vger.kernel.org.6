Return-Path: <linux-kernel+bounces-223782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E968B91181D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 03:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F79CB21030
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 01:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02A4824AD;
	Fri, 21 Jun 2024 01:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KXgNwLsW"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFB1823AF
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 01:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718934066; cv=fail; b=bu7gnO5TuBOhmKmvoO5pGeZ4iCzjQ9FpLO6O+/JahzDRGYGieSjj4tTOp9Yt87q/fKOtkYSvlMwcwqNC11IHYe07p8xCW4jRKhsLN5i/kyWBnQTsOvPrp7b+iODvFd4KsM3YXhMdDb0yk4Yp5y3VdmStr9mg3B2hP2dsMOG8g74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718934066; c=relaxed/simple;
	bh=KW31seLq4JPtG9msXOYezACiXDyoycA4VDIwY+OqXt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uOlpUESD4rBq0Wx6eswbMATbfnAEw+U/r1eEJYspieytgR1caYDV6piPJ58TizMiN4+GQpv7FhhfxSi+IEnyKeIOzKvahJquRd73Dy5UuUD++bmeEXfjkSyRtQB1yoygwtB2xzWkv4CriIyRKepP6YZpIYGonM7hYQg+xztXfHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KXgNwLsW; arc=fail smtp.client-ip=40.107.237.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnUP3HEaPIdOmxuZBMW7a9xJRmk0i3fN4xpnNBfBPjXblIeQIhZMFw4d6MvR/Jj2Pp+4Zs1U5NT2uTQSmEq70qyS9PsUWWO5uUUz1Ib1QUpysUzPCrGqi0dR9+Q/lc9x+OF1wHfwwntL+iIaA+ACkHAmJQIBVJpejhzVpS82wp89YEs1SroJQ5JG5VHOr9vdN0M8ds0Y6b/oOriQqT4HVQMW/39X13G9ATXQm4vSmTpqADshI00vCDjKJ70DUmX2GkzL+c9yE7qExbCajgf/+mHbSdAjuqF2FoqlWQpPj33OxTv7LAkhe6xr8YfiJ5RlCMOdwZG4qCpfm3I28sN7KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/QbJLkWyOez7nDqRpqz0A9QllJM+BMSxBvvEaLzsG8=;
 b=YIzaILurlF1c/XNEkRlld8O5kaMIbmnYrSfJjvAXbf9MFttbGdBPtnz6PGoQtY60JZ3x2SUuEslZ4wCf0OIfkvI54CqRiwYt5lvnhEI2CIyrvPooqDHN4R+ftvloTeQKeRH2VNtq80PVcmYcWLJigPxxMGT8dbJvhx59dp5zq55ewUbdDVWWSHtDzXJQH2PUI5am0EDIRPi+8nVNtQTvlYl8t19fYxxwua5wYNJgj4r7bCK/sfxXhYnkBMB4PXOZSNmCv4ODf+R2ZNPYg3ekylQLqMotQw4boGfzDH/K91EqSy6N11JfDBXE5l0qOrLUP1Btv33U3JuFLvLvVVcXZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/QbJLkWyOez7nDqRpqz0A9QllJM+BMSxBvvEaLzsG8=;
 b=KXgNwLsWc3UxVW48OOpgkJhxwF6QMCYSaBuq5uzitL+kKGH4YKoSZ1lHD9OgUhseElebmtJWbmODi/rBjS4VWhhB9Z0yrK0dyXZKs14RKtF7KI03R9U+LsyCZEBuCt6daHqQdeDziqtglE3WjQ77F6Tf4AlNH3zPs+5e+3byHrsAy0RbZ+T9NfxQnxGegxUyNjpJluldQYxKOphrAS01tOlisR1yhUDgCysd49QwE+3X/R0lE00ed1R7Z32KhvxBGTSd7YGh/jzhCEc37YqlX2W9fwmadr/cSZZV7W35rhXC2jx1xtcyUlXdgCU1kzJudSD4zIU2XT7Cm9TsxZicRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.22; Fri, 21 Jun 2024 01:40:58 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 01:40:58 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 1/2] mm/migrate: make migrate_misplaced_folio() return
 0 on success
Date: Thu, 20 Jun 2024 21:40:56 -0400
X-Mailer: MailMate (1.14r6038)
Message-ID: <6C1F89D6-7093-4225-A1D1-E64655BD8A4C@nvidia.com>
In-Reply-To: <20240620212935.656243-2-david@redhat.com>
References: <20240620212935.656243-1-david@redhat.com>
 <20240620212935.656243-2-david@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_1EACE0E5-65C2-4AFC-BBFA-CFBD002ECE7F_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR18CA0009.namprd18.prod.outlook.com
 (2603:10b6:208:23c::14) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH0PR12MB7486:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a628a6c-3977-443e-6de6-08dc919332f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HK63EiOOyJBCQr1uslnMMzzcwlDQtsc13xD323ZcxNOIWumg83oQEU0pqZby?=
 =?us-ascii?Q?SQ/I+Nn7q+SEjzKDJ5P3ZALTHmceL2EUm7ZfNfhUBUhedVs67xreTYqyemt4?=
 =?us-ascii?Q?W/vESfI4AN7bG0P7urfIQPwXO4e9s8KL1+z03KGpCE0oLS1KgOh1iEWwzLV4?=
 =?us-ascii?Q?DRhlQHiDaCMPbWzoS8koflecQtLzaU8pB+m+CTyP/iYMlm7MFpr8joHEtxIe?=
 =?us-ascii?Q?Ox7c1wQNvVt2KDTwZreixHQIiJB2swS7a9InhYOjaRShHV+BMPbBI9JAapbV?=
 =?us-ascii?Q?+HaiX4oYO0nqTMi9EXAo+60LDUDYUArIcYHBsJk0tHblXxF7KJVpPOP7MsWX?=
 =?us-ascii?Q?2lCwUwo/EyvHnSThEIERf7868sh4e9K1akOGPgJ39PIXadIEt9W9CVq9t2i1?=
 =?us-ascii?Q?YFh3WX2vI4zwwX1ZJAxipI29tzQR0PeLv5U+jtY3GQz0i94j80Qkz36ziXWV?=
 =?us-ascii?Q?Ttr0fu7uYrIaz9Rce1PJm+ZKzZeF+v8uubIYVEogmcT2P6bKPgQKS4FXF/em?=
 =?us-ascii?Q?gBDhlt+66FQTCZnn7f/YtiWz29Wv7We0Ndm99k0q74hASu/8Ynj/xaRWbFLK?=
 =?us-ascii?Q?fV7nC4zReOvbLyf+QU9/WZHIGBupoMZf/AHjy9W7BDRDPErukhrgrgK0opoF?=
 =?us-ascii?Q?cnO6wjY6k7bl2iFBopDSLYHITo27mYSc0VacGowil2OPiQZ3X9OlMh5XOETP?=
 =?us-ascii?Q?EdH2aY9Ca4SFAHX2xwHCgnze1wC8zp906snBHs1+ALOtOWkXhSp/j2YSSJqD?=
 =?us-ascii?Q?mnJnn5fU5D1MaZf6vp6kcXvD8vjg2HeJUMP1kA3ihxng+5hjoREwAP6CtcKy?=
 =?us-ascii?Q?rHE10xMEuSCvDdVbzK9XhU3KNfuVnheP000g1cBbcrTveo9CYIOBXXYlcY6n?=
 =?us-ascii?Q?D/f1kwN57oAXgHNxtqB0XZrNbkUMrrQz3rifFeDKukL0xNsxgMoXbNBOthM2?=
 =?us-ascii?Q?PhBQRFgV8HssrMIjPOlAC+Uaonb/3nC570sC5PmsMb5GFYopwAHTqSOxC70Y?=
 =?us-ascii?Q?nRaQhiK6ofl+spxkRukz2Utf+R0BPDvUv6fl7KZtXQCQrkFSO6+3BqVhSJKk?=
 =?us-ascii?Q?bgBd7sw9rWzV7jevACDNvz6gRfWsUXyz8I/QRJ/qcB0/5rrZlZGMY1ETlyn/?=
 =?us-ascii?Q?vi+CxVa9gT2gk3hO8ljUY0S9ej43GBaBK9jXKASfz9p/Ia1vvnr4vLOq2B/Z?=
 =?us-ascii?Q?f/izCERX1kVqYLRBHZo7cxRPBznS96ygJkW1H/fNKghWCtNglaTCfTvEx2qM?=
 =?us-ascii?Q?mkIDVJ0ZJTAIwtDlJVVGc86RnQ4+OtzNqMtDu43Y2KtDFicHinbsYcSTX8ib?=
 =?us-ascii?Q?rjNaIu8rtGWJQgjMAUcIi0eb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+o6QELk4vIDKvA5ORqr6LLiPM9jOOfzjvwXi+zczdW/GdkaEf3XW3/2ljKtP?=
 =?us-ascii?Q?JdbxjcZwJ0KISSnzYCOnKuR/gAoiPWYcuMam5RtZlqMc3RClidUbt2Km8vm8?=
 =?us-ascii?Q?Hq5cg7v8HlAGygh0XecxMyE9B28GAKTaZfl1Fmef9Uv9+98l1mHwVgEFFwr4?=
 =?us-ascii?Q?niggRd34OKKCE3EaX0/sU6W3CFZuQnQ0ucRay/Khc2zGEvnQSvxwtYxpxQew?=
 =?us-ascii?Q?OSSd0bBSSESVwoZaUpU4U8TLhYDXj4oyS/qp5FoENhq6ZLgCUD12M4awXPut?=
 =?us-ascii?Q?aAunq+JQ6PmJqbqiAhIqyWPB/Fzbydb4VFMbqpBYTMN4cVZVeyjUgzEI6iNq?=
 =?us-ascii?Q?5tiIIpdpW2b+2N+UNI3jlLdUEMjb9oaZSX4/kEM3TDTY/JELO6tmeVsfJdHH?=
 =?us-ascii?Q?EHQR2TI5soW5RJJcjHGusx+Fo+1r4b07NuUh8eRMOFnguaGF8qit6lojKC81?=
 =?us-ascii?Q?EwMulNnWUhPeLpBXEic3WxbwG0f6ChPlMT2iiSntb+g7Xm7L20tN6NbEz3Xd?=
 =?us-ascii?Q?daZhk+xt+j/SPWF/eqMI+z84536+7HHly3jcMHm8192iqniIa4EjiWUMgQ+5?=
 =?us-ascii?Q?zZoCsSGFVeaCPSntwtzmjQxK9t3Wf0N88RpbR3J2HyRBIcpP0wi6aoBAPrVl?=
 =?us-ascii?Q?SMH5Vn0AY9PfOEwXuuIH9O90t68xQKhOttfRjCIVhXQGvZyK3XTqddxYkVl1?=
 =?us-ascii?Q?4KBfV7hy7oKFOb5xONp1TDQaJP+o7z7n9OBsXOr9xWOyWecyQRyUJDMyrt1X?=
 =?us-ascii?Q?Kkw+xBdcRGK/i81g+FNlIa/YU2jNZh5l4bpAOvEeriA5O0H8mXS1Ap7s22LR?=
 =?us-ascii?Q?NtPKMLSlXU70Oe0a6FQ7ZS9Jbe5zRVABxzCB7s/jowkXGmf7v0cwhUefnX+l?=
 =?us-ascii?Q?5Cu1H1KTt8+AHVMmkhws6Pjn9DVgvQ3AIBhG/BkTqJ3MmG/v2mWriLgoj8Mp?=
 =?us-ascii?Q?njSRSD1ZT7v8DE4tWhpQHmQQpzPEwcodq6QPB72bxYxgsN1jvOCF9c22icbc?=
 =?us-ascii?Q?BwHiPGrn3em03wAj/VfqtFif7qYFA0MCA5H0wxB2fGqDLCuh+FhcmUz7DJH2?=
 =?us-ascii?Q?Vm5sS6ia0HJLbK/pnnVJELfbGceDdqKgMK913cbjmpFtq5HiPU3CRC8GJamB?=
 =?us-ascii?Q?aSAW4LKGyJURTb6Svh71uYfk+T2ckta64+PAcVn8dTp1EuU0u5bfGrW9eFB3?=
 =?us-ascii?Q?jHkm4BCZbCkz6+VckxC+rA5aHDuBUIhwYpK6GageT74t9cCIdvq9LBt3AZFr?=
 =?us-ascii?Q?K+aV0Kiz1ulP+gV2mUXqAJ2zXOITMtoFthY9Cx8j0IY8kJQ4CZ+9jPsVb+wZ?=
 =?us-ascii?Q?1E52OgZnYYulQBA5lD5EfuTWjjNs1Xl+iInpMgUIc3udTt2d/5TUWKiG7fTR?=
 =?us-ascii?Q?emfhti6R1hfbOvstJy+7wck+1Qjfpl6YngiXJIz9BmGSrILqYCgHsLDBAeyR?=
 =?us-ascii?Q?mKzREXghVNWLm4R+dwhUf/RkKhZ9l78lWvCbydGyO1zZTZFPumvPry3YH9gY?=
 =?us-ascii?Q?+CZv2Bd7Zqj3sJhuzPYkwG+Wf08MfuATIDAvXPIrVF3V9DmqePtWni1JaGbX?=
 =?us-ascii?Q?rPamJogP8byuUWfasIY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a628a6c-3977-443e-6de6-08dc919332f6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 01:40:58.3655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8+/ovwYYAcPDRzh8cxp9pmX+xX103uJG9mPajTLq/L4vl69Tto0MgnZn+9NgbB+r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7486

--=_MailMate_1EACE0E5-65C2-4AFC-BBFA-CFBD002ECE7F_=
Content-Type: text/plain

On 20 Jun 2024, at 17:29, David Hildenbrand wrote:

> Let's just return 0 on success, which is less confusing.
>
> ... especially because we got it wrong in the migrate.h stub where we
> have "return -EAGAIN; /* can't migrate now */" instead of "return 0;".
> Likely this wrong return value doesn't currently matter, but it
> certainly adds confusion.
>
> We'll add migrate_misplaced_folio_prepare() next, where we want to use
> the same "return 0 on success" approach, so let's just clean this up.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/huge_memory.c | 5 ++---
>  mm/memory.c      | 2 +-
>  mm/migrate.c     | 4 ++--
>  3 files changed, 5 insertions(+), 6 deletions(-)
>

LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_1EACE0E5-65C2-4AFC-BBFA-CFBD002ECE7F_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmZ02igPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUddMQAKjHJbbTxECe91jwbPdHxLYCoRHTs4ZMLHo+
T8S9Iz+RnQ7neluZN2A4VXEA1R4yfFa9kD5z+tdJL1n4nb4ko259+rz6q6Eorwzo
ifVdkhku5X5GZDuPlFXDjG6jHhsKVvC9PSxC8m9KYj3hgm5Dqxibp78OTfJsLDVN
ActZKrhbPetx5lSOMWNxwatv/roGKud3Pvni1enBIkXX8YO+Z8mIp6Q4iG01W5z/
Xd7xlrs1+xOIjCYMKB/L7xz+Y2x5xx2bAgBvo1b62CJeoV7EF+FWYzXFnr6RWgkq
MmZX6U3vAUgJkb46OASemtUV4+WFajEk2GdtKh0LE6z0xSv37Adp2ifVTkXelApw
5hrD2uQKXNcjYfHJi0qS8wMc90QPc9zOg2lIaaDDEY8Mx8z+42839w318KgjhADw
GtttsGB8GixHqOdaoFp4H8mexUMtwT2LNCAwafXcs2Y/KOR9feBwr4Zz7DJILSfG
3/5SQuZ4rmCZ9neKxXspaJyXkkzV3ijtJrFSDBdA+ezs6jiS4yxVB5sHQqmFtQW6
CZeDztv7MHEPUF2augaW+BW4N7gnejSD81jN4mFDbTnRysLMXSozknUFY4ChTKsT
KW4NZ5mJl4+D0YgEYqwAHngoSQ1sikHvGfCWML0owIXBVV7UarsalWeYXdCvOLcZ
sQtRd64R
=MrYq
-----END PGP SIGNATURE-----

--=_MailMate_1EACE0E5-65C2-4AFC-BBFA-CFBD002ECE7F_=--

