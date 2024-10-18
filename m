Return-Path: <linux-kernel+bounces-371993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C49EF9A430F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47E291F23E79
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9832022EC;
	Fri, 18 Oct 2024 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HddFHXAH"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2518165EFC
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 15:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729267114; cv=fail; b=rVLYZG4OAaZEmAYp61TJmFuznQrpcxbOmH4sZ7rtwq4O0Z6BVtMvZEECd//UxA4orwqWfF9px2W3w7c7Pal2u4n6t9USSTVFa0334D+9O2755aUPcM5uYXpjAUeB+U0sOz5VrBNRqpZ9OsOxKDhXnM4djkH01l85XytYfhcqR2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729267114; c=relaxed/simple;
	bh=slX1Dc3HMeY/BCktULi5SzGDaMdh/tkIC1LlQQOBCBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GYkbAIQrSLBChDugRRgsONxGdBggXL8KbdnXMg4/6OaR89HN4FeO7yYoaD70Hq8grk2dnGMh/CrIb2Ubz2AJ0jRGO4JloHVhEiG4EsYLT1nrSCSkyz40vw1gBXDSUkEm8+jsR0ESm+1q2BIfiYbaCwuIgXRNzXJhaSN5wmPZbfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HddFHXAH; arc=fail smtp.client-ip=40.107.236.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iKGQmHx7Ycg2/s6KL8VP0uONfgRbwIQxb/aepIyDcqMHqwjpvlGW5YG6/Xa8hNFhuXhf5hlgWrLi18CZ+0Z7QplxKCjZHfo//ov+H6tM3vLBRWBEcTCQKm2e6NS/lcOxthBE8J+3gezFtv7AVyi7qcuWaCHtM7Z+hJVEJnATZ/+PKxolAi1ifhtfu44EraQbiXoV6p90gU6Ixw93Qebm8b8iV6B/8N8Z1Sr8j5GE6+Lc/7Suak9y/ugwZgLhJScWQjG9qw5cVWbNz1ZAykPDb5kuqQY8cH7ixXiAED5ex7jihGuZAe1bJd7vFbYPbOPWCSUvFmIm5PZiKYIY4lN0lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zO8WAKaEjnfYyRGY/fXxNvZ1CTwhNohFMma6wJQplmQ=;
 b=GTftGMx5rpyzvhUTf3URYS/alCYbLBVOArpwq4VU+KfQDvJHAneSxHN/m7yLPgBG/NE4HS70HZQ9NjfHkYdb3iC27OuS7MQatxpKKGAJ1EnCilU3mqoAsHsCyVArLg+81XUF3vee7Mj57uYSNds5lfMphtf7OfHxoE2pveuwIm0vNBu2tymPt2gu+VdXQFHY0Ce5y5SH+RlvcYv2wfPg2ajThhZPlhoYRUuEA6jnP2qlij+c/EsC6zQuProYrheSnWZs9Qx4RXGNfHUK9Eprj4OgPtH9G2gSL9rt5LEfzyJiXldGCgsOEaW4mP5iW8dnMB6AbJKz3I75Kcuvsg5dfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zO8WAKaEjnfYyRGY/fXxNvZ1CTwhNohFMma6wJQplmQ=;
 b=HddFHXAHo9ecYXJCkjQwZKvctvusf9FoPsK2rDt5KQhfl4urfgbIlQYUu2Iy3iBxXXHQqg1gVebUWpUTDZalMpmhnOpX50WnuHqiZR2v6Rqwl9VgW/zfSF/cFjq/RhypIa9E51SP98iIp2VqvntObFA+6xrIrM9sR/0dMOcjxrEckhxPJOnBoGt3rX/yrCkHWUKg3/Efp2TU/rtYBFPwHO8NVhWhV7jPyvn0TCG+OJ1/VcEvL/w+h/jSNtUgJ/AjGR/FoBh4kNtJuVXPD+r7e1FlwXE23biXazIOxlPz304TvkmcKuGz2J5Csefb1jFiLqe66HSdslhkPogcXDaonQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 BL3PR12MB6404.namprd12.prod.outlook.com (2603:10b6:208:3b4::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.26; Fri, 18 Oct 2024 15:58:28 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%7]) with mapi id 15.20.8069.019; Fri, 18 Oct 2024
 15:58:28 +0000
From: Zi Yan <ziy@nvidia.com>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com, willy@infradead.org,
 ying.huang@intel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: Remove redundant condition for THP folio
Date: Fri, 18 Oct 2024 11:58:24 -0400
X-Mailer: MailMate (1.14r6065)
Message-ID: <E73135A3-D4A9-43BB-815E-91B9A5F6B2FD@nvidia.com>
In-Reply-To: <20241018094151.3458-1-dev.jain@arm.com>
References: <20241018094151.3458-1-dev.jain@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_9699920B-9047-4D4E-9F0E-7CA634E3FA6C_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR01CA0031.prod.exchangelabs.com (2603:10b6:208:71::44)
 To DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|BL3PR12MB6404:EE_
X-MS-Office365-Filtering-Correlation-Id: 70542427-0744-472c-1b1f-08dcef8db50e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y4ukMVhogRHlSvGBfMdXcp8ajUyLHVp8cVRvKKkWPzjXhiYCLRqVEjMKNe3d?=
 =?us-ascii?Q?oPxAI5EaSokzliFBnWuMEn4bhJq296X4w6aCiu1p1yjhieBESq9+nznwXAw8?=
 =?us-ascii?Q?0aAn+uRwF1dnmdNOMCMgBpR0pUCD4ZUh1RVwy8Ml6PhmS06a+aeGSa4adgtK?=
 =?us-ascii?Q?NHAt7p+17VWD7WHAwFrnD7PDqSPpG89mDtccXX7r2XtFKyjVoQ2GSkmas7Ar?=
 =?us-ascii?Q?3LB8k0UBB2P+mUQDLHP8Gx+LlnW8PpBOgeeYAAc3veAKMF6qPOIKurUDs49T?=
 =?us-ascii?Q?1VlddbKzVwcxRL7acEjRKnOadg4GgH32KrWazlgy4ez9LfbCh1Hy7GJHeO+h?=
 =?us-ascii?Q?11JN0TqmtzVYr/ucIW9NMwOlqpUoKj05zmFucGHuPeyoruLL3+UTtU8tIhi3?=
 =?us-ascii?Q?9bAx04OzPBTGwRVe6eCXZYr9GxzzVth0xtF+O0Sbcex7YolqhCSX4enu3e/6?=
 =?us-ascii?Q?VrXaPBMLNzqObiA9aZidZPf+B1cWMeW1UEwcuiS5T27+n0tIxMeRVHFEqCTW?=
 =?us-ascii?Q?p2VzmuqYNi4iQsWoJxl9H0JximxGiiIwGNkMfYdK4SeqAPvYifeZW+yI6YnI?=
 =?us-ascii?Q?20mDkHVQmp/ftMU5sSZdi0JGqZNPoR4Xko+n4/YzL2ZMf2kqtcrX7LYmy9co?=
 =?us-ascii?Q?EMMbjDvzo/KU35xZRxD1tYnUAdTp5afgKGlvYLutP3Bns0FHymoCRqzDVVXg?=
 =?us-ascii?Q?54VCRfzFEwAIJ4IWf1AOwxBOAj3sCM9hSwB3iecX4LlHgLAFwVaI5C1bDr/t?=
 =?us-ascii?Q?qY5e2r/uJ/MsP/C3ugZoJ9koAbXe4Mox0w2LuHHj7Pe9BUFQ7nJ/ud4Ibjre?=
 =?us-ascii?Q?BRl0pgzxvIy5tzzEnpDJ10hHy59aLBbQ7jqCmvN5J6gm/3MXj6bRhAEAJY4c?=
 =?us-ascii?Q?RdEP8/M7Efp2RmIqDQk8eV5l5tfiG8vkc37cEp3fs7VWiUgO59oJJccrrznr?=
 =?us-ascii?Q?J/VJH0ne6W6BbMshipNgUujMfyPpodDxs7MSopzV3iHs6dkR4Z/umh+I2mjZ?=
 =?us-ascii?Q?tdfdTGRvq/rCI4xqHCrMOXW47erDtXn3W3PhXTOXuOtnwzKezw6iqA2ieko0?=
 =?us-ascii?Q?v/LRvLG/B6icRfZIdZTVBlslNC+4aF36X15grLXaVMKq7/GjX1zq8sWk7It7?=
 =?us-ascii?Q?woa4tqCIROpiwAMuJf1cXzj4lVyCenTJ4TJZdQRe5+YStV2NVPEHjo56hFk0?=
 =?us-ascii?Q?IYzKeZdspzp5EBo09jX3IyyCtTQZk8l7lJCHtpMm1ZxZRGVADxWr+T6Ves3L?=
 =?us-ascii?Q?9cbA3JxjONhu7OPJGAQm3pIeMMs6bhWfzoLkEqIVqQL2sAIj66wvtLTDt6c6?=
 =?us-ascii?Q?WSnMf+vMohxFtijZmuJB/Jyv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5C4tTixMFijIWig3Mhbu16TFlfjNGyTgqO3MGFRBABgqLwuJU1Dqgad5O/vy?=
 =?us-ascii?Q?gEsU/4jJ7MXCF3nv3ndoyeMov8iCg8pMPimXzg4UEiaAWy3LX3ujas/hBFFj?=
 =?us-ascii?Q?DID/cs8mZSlbCQOiozfZIuJsS1tHTJbhMrcqyUrn7SzG4gvvzJnWZGB1e2wF?=
 =?us-ascii?Q?Di9j44tMTeZpohu4F6XipBMNPdVKZALai6ikACYNJ2iUX1R2+xG7g6Mgtvyj?=
 =?us-ascii?Q?7R/aS5RYP9EIAQ8dtCRQ2/I4ZuLuSH4i1fDigHf17D24uybevECXwuXfh0xz?=
 =?us-ascii?Q?e/Zt0xbOr3muel0E093/WGcTVq4+24gGJ0XAdJSypUKbA89F3dzGJ2k+iRMt?=
 =?us-ascii?Q?kUYVbmHqkVD+3CfwSwL0+UiPD333rNai22jqu6POBFRxyHn8Yuy09XG2uuOG?=
 =?us-ascii?Q?RFIcXPcSSaSXRnJduyBNZXlBaRlSEx2CnDtUfcW4n5Or95feE0GOgf1AuD9o?=
 =?us-ascii?Q?lJAnO7GhS2qRx49NMphfdlZ71OPfchiq+xywcOFz/wSdjpqrEKeVej/wxJr9?=
 =?us-ascii?Q?FpMG1t22m5nAAwjjwWyEQ9Aqa1iVpDgsq4waJv5bOoKoBSCRGE3mrDs+UZfA?=
 =?us-ascii?Q?Nv3L7V3hqwHRNZDjAXY9qYRzcpiwk+vF9GlkUW1Wv5SpLZm5CJ968KVHBrjd?=
 =?us-ascii?Q?DoXjo8WXzSX17vu7ilUoZVQBKL186vWmIDU2d4GH1uQNckctcjO9PzfXtHVm?=
 =?us-ascii?Q?/gPV+LOB/OsIFQJJ9vqwUdZzvInPRwa+AQdRw6Q9MtPdDIvQZKyg9EYy0PXs?=
 =?us-ascii?Q?d0+Kzl54VKvO72sgH5qnTk0FUdOHMS6F8rpeSJ2oD+lxl7SZtmc8oC1LfISM?=
 =?us-ascii?Q?+0gVhDbO7RUEMgkUUCkz4nDdNJNeXc3uR2acMfzJeXPauoYYsUCVzAGGL1fc?=
 =?us-ascii?Q?6pPIZQYoGVoorJryB8Py17WBqvKS/bNUp4IQirS+B3bncjRR27RDfGE1u4yc?=
 =?us-ascii?Q?TplgXTXUdOcv2FneKuakEFt9xQP1I2NNull/Y0orKM7PlpWnoS9yOOBRTyjF?=
 =?us-ascii?Q?VFyoEgOOnwS51yCtM1uOpIl91s3nlBnp574WczGwH/LR7gFnqRW43qKPckD7?=
 =?us-ascii?Q?DvZubwVMzO/CHW8JvQ1CSoQemDkjCg0Q2z66dnL2CNPyE+zswlPJip73R94T?=
 =?us-ascii?Q?5ZGfbaYKd8dlHBoOgwdbqf6kBz1RcCt3qsTXFZVgfHmFKqBqH82Ep4PTjiyI?=
 =?us-ascii?Q?TU1qot0gl8omB0C3zfQ0BvH2H36XfmZ1WGuyEyXF6wBScOGi9QrGZehgt3R2?=
 =?us-ascii?Q?DmatPD6gM9Y1yUq5PzP3ioqEXhjogGHc0vRZnqaRyhbE+WWNZ6Wpeus6ec2+?=
 =?us-ascii?Q?GFoKKXJzKrDHIgSavzc+aY9Rhl1NT19aiQbJA/Brs3OqTSgwtwOxjpRGpVQ2?=
 =?us-ascii?Q?2MkHFF3wKeWF1Cp6JrgW5wFqvbo0q4y/4m/KiAHcvLRdfzG2ugk2VrLNkWaG?=
 =?us-ascii?Q?w0k1AbtnVmBX9LXlEmVQWhH3xR7fwKNOtEMA5HSaq8GpCbRwPPm2NRnvBJ5S?=
 =?us-ascii?Q?RonxGsXp29+2rU8xfAtlpNXsFhgakrGQrgrEM8r6eShgL8VpwWIsyRCmvXEV?=
 =?us-ascii?Q?KGTsr27gomKUZCcumwctY6qwzlRcQbZjeFRzz6bL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70542427-0744-472c-1b1f-08dcef8db50e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 15:58:28.7951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GDXFUfifcfFkwwpt1XP5om75oTHIdHc1y8qSzNLoG+HXA/RUmbDlr9dMieb/ZDxe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6404

--=_MailMate_9699920B-9047-4D4E-9F0E-7CA634E3FA6C_=
Content-Type: text/plain

On 18 Oct 2024, at 5:41, Dev Jain wrote:

> folio_test_pmd_mappable() implies folio_test_large(), therefore,
> simplify the expression for is_thp.
>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>  mm/migrate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

LGTM. Thanks. Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

--=_MailMate_9699920B-9047-4D4E-9F0E-7CA634E3FA6C_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmcShaEPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKtkcP/RbEeTtI3MdPNXhJw4znfGQYLCw8zvGyf5Xt
LoNDqMTc1uBhkaNC8SjcSIFJEdiWh3nOGp89qs+8HzSZRt3Y67e76CLZyKud+z8/
PdnorGOKC2Z5Xbrq3BCGbORPBpVCsPVVRRWnC27lMdh3Uva9+j2BY8KYMNHJrLMS
XugjrAgfEBbMeQehJUo3CPm1EUCcyeB/QHW4+iHjUF9k1PCK9fF4bw7B4ATwuykm
gGyCwjZOWSZ/hBAGsC32L2I0s9RnZeck04NOpGB0oFzj//Bvbp5K5G/EzuN5uZSv
UHXTY8DxuzyBo7+SdIV2x/JHMZU6vVZ2msOI6qDSbWLVK2Z42kS9rmVh6k1zDRzC
qFDuwsBB829YNy+Bc01fQ2tf0ZweUCw8Mw8b+nFHoHIMLCpc7Asnl/WgNs7eovuj
+xw3WUSQ7EoM78PIytnMzhp+h6P4dNDHNohbng9OoSUwDzGj5XVOjaIVv8Er6Mm9
BjkyeSdnUKYTx0ixTL3SOiwcY2SgHcmxxZ3KR/MyoZSePvgteTcsMdpPvXx6YFLK
utwlcM/Uqa1ze/jtOaXPIxQU6N64eWADTiS4zPMzFCePDN+4vXjFUXOo5D2UjzaR
2NA+Xdq0aK8cypD5QBLQ1GOKKt2gSSExxTT1o3Xk1lmqTQMrUdTLM1QfxzjOvnFq
rPBCvJwy
=0j20
-----END PGP SIGNATURE-----

--=_MailMate_9699920B-9047-4D4E-9F0E-7CA634E3FA6C_=--

