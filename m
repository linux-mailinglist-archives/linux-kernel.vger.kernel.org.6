Return-Path: <linux-kernel+bounces-247678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F8792D2EA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 15:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7B5B1C21AF7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 13:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381BB192479;
	Wed, 10 Jul 2024 13:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ql5OXv80"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686C412C530
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 13:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720618471; cv=fail; b=slka3OpmSPwJaBO8PG1KGsWRTnTN4zY2kqoPvhl2AAqNzKJVVkJeMD9edCDRR00WZjDBvicELL4fYvOOlbP+lfg4fAreR9hVU/Q30NoCsMElAcLnznacUQl8cI5fWE64QVXHjXPc0b0jbIVZOtRHEA4o/Zhrh6536/qPP08NnTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720618471; c=relaxed/simple;
	bh=ws55ts8VRkbKIXibOISSHO3jzQgluayhiVfM2OmUGe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cU90BrVSFCjqSjczuQr12YZPvMwtVvtTDWtESBTVT3CTJENQaY8LBWQXyOuyNmOCRpo+uKAR6nzeQWwMpCSLr/6x3mVBkli0H7morv5+Osg2Afkm1+B/Pu5T+0EjUCrN4aU3Fp2VjbQg/b8yvhjHCtC90vU8B52gjFrew30z7Rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ql5OXv80; arc=fail smtp.client-ip=40.107.236.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEpovZQ4cZR9EM8xx8zp8qfEIBFL1DTg+3kPL5x3tkgCmUgHujLk5tv+tBhVW2qZVJQsfjdg/6Q+XhXlTyHAmmX7l0197mBX+MfFv+tGiJbRSJ1sjYj6licoc7YK60OEojMHRGyaPtYK273zIhNENyOKcjLTgDt1zrum37Lc92GCqPGitssqFs4Cc6cfj2grEFxjclu36j18zGIjhnC1jABDnCqS1OcqMQdwAekVOiMhZgVx1oXrwILnw9fqk9wXDSQElNdogvomg1crCYx/rhFksRh19Ee/rApPLUdi/JRw4NPm52xvyV82RcDQycuspLDThOpk4IhjIIiIMDkd2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lL8VbBSYiADxy0yD/LdMo74jXjOoVhSu6Ge3Sd30iFA=;
 b=DBk4ojWiw7ieXC1I050BnuJWC+5isM9yhmwtHRC4Mh6D7xMbqA/+E6o2GA3Hbgf5zJnlspjWaNHXU0HCQ6OLdC5Vc4AgtClg/R1qQPrxhWDrm847fDTcm2z+2TjZm6P8WPimOH2DZxgam0gz+6KBZgU/Qu8hRVkU4Ti6wIaYcL0EyobUwRNVagNkP5e/0yUHYB8IKuOutx/PUId8f/xEXWHRKXWuB9G6wE9Rk0rqb6tWD/yFN7v1b8ZaqDjLNmwhVuU1hUfm27Nf3D+Ol+0ZWlRQmjlmlDwJbFasj1Ph4sKz8pO6ZW0YpHNBCztUn3vF2Fq1Xi/03wTXEAH++T8DSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lL8VbBSYiADxy0yD/LdMo74jXjOoVhSu6Ge3Sd30iFA=;
 b=ql5OXv80UJhUMUTj/ZS68EHkjWr9iJtSZCMvCTeiThbpYcNfsDOs7A/sg+BalkWyIXGyClIYKO7GuHtcPm+ZEevvNLVuc4uZsX1dVUFOUgiP7t61Wv1eIyMOndnhly3ZJjyk+Z7ahYbPCYbLhi/XYub09NeHS8LAo2Tg87lZn5zfYDlb8PaOAu3iWqzMiMJKCbY8hxIhD37l92AARExUu/Uam3/2PS+NC8r39DAD0bXJrkE+s8+VePy2fa7J//u/GFEaKEMfEwZZVf918nvjYAuoe87XeqV4gml6fRMk3mXNSJ5FacAwrv5VNvsICCDPqYQKVmcPzFLCNFsaJ183Bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MW4PR12MB6952.namprd12.prod.outlook.com (2603:10b6:303:207::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Wed, 10 Jul
 2024 13:34:24 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 13:34:24 +0000
From: Zi Yan <ziy@nvidia.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Hugh Dickins <hughd@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Barry Song <baohua@kernel.org>, David Hildenbrand <david@redhat.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Lance Yang <ioworker0@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 Daniel Gomez <da.gomez@samsung.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: shmem: Rename mTHP shmem counters
Date: Wed, 10 Jul 2024 09:34:22 -0400
X-Mailer: MailMate (1.14r6038)
Message-ID: <82B24EA6-7207-4C36-8CFD-7BA372CE9482@nvidia.com>
In-Reply-To: <20240710095503.3193901-1-ryan.roberts@arm.com>
References: <20240710095503.3193901-1-ryan.roberts@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_87E09A56-76BE-413C-850E-1CAC2B1D3586_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR14CA0021.namprd14.prod.outlook.com
 (2603:10b6:208:23e::26) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|MW4PR12MB6952:EE_
X-MS-Office365-Filtering-Correlation-Id: e671b675-8f0a-4fb3-8f3a-08dca0e50366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nt3mLRM6aZfOSzbtyU12X58QnaInZcTo5QJO7VIrUMIyw8KF1UEGO42q6MM8?=
 =?us-ascii?Q?vAo7gVqTbKsy39KOzKuPhsUm1PhsT5j+2A8bdqpAnQkYyRTw0rnyNrzHrq6b?=
 =?us-ascii?Q?LnB9rQDSZTnVrzfq2uAwDnLb/94IRM7S/LCu7Kgiawc3H88EgMQqyoN+0yGg?=
 =?us-ascii?Q?KJjz1VFJaGtLX7o6IB0YyuO61RAbjIBdSklhWBMZr0ersRMegIqFwY5VK97Y?=
 =?us-ascii?Q?AnzFDVo5nQFH4pvsJ4ku95cMdCI8DwFrdMFt0lKYXN0ep3CBGkR+fDB+FFLm?=
 =?us-ascii?Q?Cww2XiQHzg7MUgva4ShSa0fdes8Tr9cheC4YrJ8ITLhuND+H0QAzF0Q0OCGC?=
 =?us-ascii?Q?MQSMqVKu1xoicj8AFrgvfdGSJ9ed7mQAHSphel53Q5rsiTCznXCGrLsl6d4O?=
 =?us-ascii?Q?D1xsoc4T4t5x+ANhXeFilsxWYAm2hccXKZzicjpr234EGcCZJfiG9FxmiWMN?=
 =?us-ascii?Q?vIZvHfZUt6g+aYOhta6o4skdC+5QNlQ2EehZyojGvUU4RBpaUDq83uWDuzOL?=
 =?us-ascii?Q?1ggm/NhOC15I8aJKSOIgFWD6bOmgnq7bRncq02fhbwiw831WwSqnom3VI4s3?=
 =?us-ascii?Q?A6vuem9tA4xo0jc/hI1x7SSI08YqtZejKa8Sl6Xy6c+XbmVP6yVmAVV2yIFu?=
 =?us-ascii?Q?RxHe77DhKQkzZmmW3aABMeF+KVoiwaqqshOgtj5q6IQp88iXMsA+6pcsjLsl?=
 =?us-ascii?Q?AaFABSM89cjP10kscBxtnXbPcW+s5UattgXqiwswKCYxWm1N9DjGbqmuzgK9?=
 =?us-ascii?Q?tadmq+gVH2QHWr07osYrK9FaT94unXYqNf+jOia6VLV+WK3J5UDg8y6XuQlS?=
 =?us-ascii?Q?e37bXAsFvuqPpBIddUc332dlZnSEO/b042Stf5imuaFpLBVtkS2x9dNzpHhi?=
 =?us-ascii?Q?urTHf39FTPry+Pamq23LanpS3KV55tVDXyNZNNfsXCqmmc7mYi1zrgEf0sBR?=
 =?us-ascii?Q?anVZKGaHgRwL9bM5aYtPMk5M+uSWx1JtL+F13Oghc6nSleoWI/QRTblDaq28?=
 =?us-ascii?Q?/kjQlWOKNFDUHF4GRxqhyjj+D5EJPsDvChBDdh0ToO7S/lQwOmaPRjIVkfWU?=
 =?us-ascii?Q?MQYKFfixjTQvghvCsLw2M0BKFcx8hBZEVcJD0rrPY/gbmzmFV0UiJZ/LrUx8?=
 =?us-ascii?Q?xJDzWUdWM7x+ijLyrT/QkcdedpopsmUxxstJTl7EKqE1VI9oBLKkB1mUHiIP?=
 =?us-ascii?Q?2fqIOiPmX89HhkU5jCnsEDy7JhuSqYVEhjhvB4HoEZJDEWAxNT0pjivUr1oL?=
 =?us-ascii?Q?1zNGRPvZGdqTpCkXygZuUb7FLvNkR7TceIlTZnAoNYH8WNyPeNbI9Eiu3HUB?=
 =?us-ascii?Q?nyCQnvdeEB3XAZ7m97Em0CSf/hB66+E4ykdOO0nZRwE8s+DIXyRRg7GUOSPT?=
 =?us-ascii?Q?IbZjYMc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?do4T6SX3c7L5AM7ClNzxKVSnztvmxywjXOFiBwdZjvif0CG+FfIwVaUoXRDn?=
 =?us-ascii?Q?UjMmli1yPJMJfcokdmtp533Iu58R0vB1qrY1ciG6isF9erRLlVOn2mGtU2rC?=
 =?us-ascii?Q?WqjVB+WIO8FNst1DZs3oSPubyGogmBkkj6CJ0TPP93b9rZ8P8vhGrbc8IFe4?=
 =?us-ascii?Q?FYnXtY9kTkP/fJAhfgs3b8GjlTmQqJPzFrYS6fXN/osWPEB/cXp+jchpadx5?=
 =?us-ascii?Q?KWYGj4Y/dIbA2Dc2WNDwSV7saHnZrPodcMty3Mr7iNOqtRJ8cMideAgSmlgd?=
 =?us-ascii?Q?rOuxaBTuQZq4udpQpTgAwMNk0jDaR9AeicrhLLAobyG98KeLtxuKzR49/Yn6?=
 =?us-ascii?Q?L/xO9Cqhl73reBshkaVj8HA4NBfY2pkjPFSDIaTUyH/QgLeLUNsOY2RC2tsc?=
 =?us-ascii?Q?G5XztLOt0jMWhH3xbkjOEa1iuW53URvjF+OJB/M+ixt4Pf+sOoJ9zrw7OPlL?=
 =?us-ascii?Q?GyIyspOhdaolLzJkIg8Ms9YKzCH4I3w27Q4E/f/f8TVdpApnSNFuj8xMj4vy?=
 =?us-ascii?Q?x8DTz6GPfSclg/Fyt0B9DoyRrGK07iYNj8ujHEbLPnxkASFL4dJeTGN/XlRE?=
 =?us-ascii?Q?o6NEFDqg7buKp1Q5Ve4WefGU7wBxernumjjsC+ffD2EFj7HS4+9hq5OW9xai?=
 =?us-ascii?Q?nAJpMsdvJl9pvyRDURMK9ZxEmnGvDnK8J5lestZ/92YqdpKKeLvBClahoYZz?=
 =?us-ascii?Q?33DDESR2TWrG0CCi35MY5lrIgG72Y8augdfRFWlSHaw3YHHQDCOP2OIt1LuH?=
 =?us-ascii?Q?30vyIayPoLLR3g2WsyaWuHZ6vuKKQqhfJ0abzSXTiz65fR97K89P01fi74QG?=
 =?us-ascii?Q?xUGX+5GXXTr0m/8WyHyoDHXlLjSzcwIqs3Wr8W/uFo3ZgpImllSOEgqx2vJ8?=
 =?us-ascii?Q?j8/3biNSkzQZZEDOHqIfVINBIGuwX3Q677Iafh31KF98qw/IXfQEpeeCtTR2?=
 =?us-ascii?Q?6uw/2dcDsSAgPzCDRfESHEjsS9ej0nqBNVEs4Rjn73JutPKFIPW1TRlrLNxd?=
 =?us-ascii?Q?kA6rivFJKl8PeeuzE0RgDT6pyNRp1PiafE0QI9s8yvfu/11TiBP53bMHZdss?=
 =?us-ascii?Q?5zqHGTyBOQ1/i3DFCpwfCp24VgUrzWq3g5ST7IZiEXcwQ/iKURT3J9ONyZR1?=
 =?us-ascii?Q?BENct1auYmzqu1HnE7ulLdtd16MM2hlUmO4xkve+v/NG9SsMol81kYPKgDh7?=
 =?us-ascii?Q?LpDVl8pNXRemi2jxT6gXvD5dO0lhedQ/m4x+cADMDpDUdBXBzP69jQt9pWNt?=
 =?us-ascii?Q?bj3LSH1vNmTIf7xvMvFcnCbNZJkejX8d+j4wK8b12+7Lv07bHfdGpzB/H3L5?=
 =?us-ascii?Q?sYUQnAF8q54XxV/pYiyPA9ZXl8GLB1BF357rStE6QzLcCwHagnGgvAmj0T+s?=
 =?us-ascii?Q?JqRvxbS7Y2BTtcw+7XEeTh4UH2luSs9ZJKsE2YYlnPZm7Vp2n316DhymxmUT?=
 =?us-ascii?Q?35fPzsEjwcdSaT0mjgLkxzkLalcQ4jtFk85nuIsPRuOIe5VZtGUonWBey8Cb?=
 =?us-ascii?Q?lptVmgKc8+zannDe08UDTyLks7ppoPTgbXC/aA05CGs/Svok+3nY5ErNVKka?=
 =?us-ascii?Q?so3vve/h+2WICclHCVw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e671b675-8f0a-4fb3-8f3a-08dca0e50366
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 13:34:24.6310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2E+eGssepZOkvd+APCPsiAFxsguyajEuP8TOscn4pBibWS8+/ik/yv0eifiGWIl2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6952

--=_MailMate_87E09A56-76BE-413C-850E-1CAC2B1D3586_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 10 Jul 2024, at 5:55, Ryan Roberts wrote:

> The legacy PMD-sized THP counters at /proc/vmstat include
> thp_file_alloc, thp_file_fallback and thp_file_fallback_charge, which
> rather confusingly refer to shmem THP and do not include any other type=
s
> of file pages. This is inconsistent since in most other places in the
> kernel, THP counters are explicitly separated for anon, shmem and file
> flavours. However, we are stuck with it since it constitutes a user ABI=
=2E
>
> Recently, commit 66f44583f9b6 ("mm: shmem: add mTHP counters for
> anonymous shmem") added equivalent mTHP stats for shmem, keeping the
> same "file_" prefix in the names. But in future, we may want to add
> extra stats to cover actual file pages, at which point, it would all
> become very confusing.
>
> So let's take the opportunity to rename these new counters "shmem_"
> before the change makes it upstream and the ABI becomes immutable. Whil=
e
> we are at it, let's improve the documentation for the legacy counters t=
o
> make it clear that they count shmem pages only.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Lance Yang <ioworker0@gmail.com>
> ---
>
> Hi All,
>
> Applies on top of yesterday's mm-unstable (2073cda629a4) and tested wit=
h mm
> selftests; no regressions observed.
>
> The backstory here is that I'd like to introduce some counters for regu=
lar file
> folio allocations to observe how often large folio allocation succeeds,=
 but
> these shmem counters are named "file" which is going to make things con=
fusing.
> So hoping to solve that before commit 66f44583f9b6 ("mm: shmem: add mTH=
P
> counters for anonymous shmem") goes upstream (it is currently in mm-sta=
ble).
>
> Changes since v1 [1]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   - Updated documentation for existing legacy "file_" counters to make =
it clear
>     they only count shmem pages.
>
> [1] https://lore.kernel.org/linux-mm/20240708112445.2690631-1-ryan.robe=
rts@arm.com/
>
> Thanks,
> Ryan
>
>  Documentation/admin-guide/mm/transhuge.rst | 29 ++++++++++++----------=

>  include/linux/huge_mm.h                    |  6 ++---
>  mm/huge_memory.c                           | 12 ++++-----
>  mm/shmem.c                                 |  8 +++---
>  4 files changed, 29 insertions(+), 26 deletions(-)
>
LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_87E09A56-76BE-413C-850E-1CAC2B1D3586_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmaOjd4PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUxKYP/1MGYuQzeW4166o8S4TQAGhVRK95HmRu9Of3
udAO4py/QnRYcIjgHWahmpYPRBg9pUApryPUv1Uz1fUI51itbaB097+T7jzVJgiR
IKjhrLiyVnm/m1aeJJd6peUEQmNKLLrvj1TIOHQ4Rsjh/mkmfBdrQsiZNNuE8nOB
aKEHNov2KlW8QZWLOy8n2S+qTrFucAr92KUX71b/9tCWdNRTB/94RFztiAYfxBtk
ayd97qP3dRHvaFYrHlI0wLmH6kUeo6rEa+YLRmy43Ft3KKmutdEQdpcQt/Nzf5Ki
zI5ukJHmeMdCehSHEVLgOXCPm766gXHKMn2ImIG/zoYHquQ3XvttbEZXpR8wuWPg
1DVf9weaOz9iZ1kJV4TSUFo8RkoOtMFGMP13z7AK4bt6Xdjv7YLmfzKiKevmXjF2
w76TWjWgKrPGvupuD7+ogYXM48AHHwy/QSYjtajxCLG8QgN8cm8nEG31T4wqdV2v
O/nW9JHhfNXnBnLXxyCGL9dLgOsOimoz/1rw0NHVgTCWuG7wZuhC/DtwdCPXjXO9
HR5n64WfIHULZCQMaxomsKFF+p0bhqjHt5XwKJlWM5f3mn8NDXbPR5mue5BXSLTM
kspLwfkAQFDk9JIQPW3uzkLijJ+wz8B2F0OC9aBTvFgBoFnWjm8IAkKVq6nhQ4Qn
/un2balW
=Yf23
-----END PGP SIGNATURE-----

--=_MailMate_87E09A56-76BE-413C-850E-1CAC2B1D3586_=--

