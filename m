Return-Path: <linux-kernel+bounces-239641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B480926374
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9025BB25853
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FB817BB16;
	Wed,  3 Jul 2024 14:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dy3oyi3v"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6457816F293
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720017046; cv=fail; b=Wq47ow730hT0AI7W6Xw2dySCATXLpFvswLfJjqAl4lzX4TAJUQgrtAV0D1OiBq1do/W7Qdh2V9LN5zLfz/x8n/+tfZBKAb+PY33s8ra0RlNSxVH06bdbGz86zPaxngU2+v3N3GuGnEhS6s5NqCX9Kf2yLo9x/sBX/TG6dwEDFIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720017046; c=relaxed/simple;
	bh=psQYBNbRrYVJoVL3FadgUt7EsmWYMDbF5BqPxYZuAJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h7P658G8IGWfSGGEXZaHHxBahT/mQQp5CNXU3U3A7MPoO8Ajy5yhEFZuV6tYWUACSYETRknrHrbf3r8IE1q+1dcSE1+k9Z09iAOhOdRgJFIS1pKShyYrmuKHpeUUIW2ok/m9AXnc4Y3Fh4rUYaLKpbQMFfaRTlDRRiufqL4YzPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dy3oyi3v; arc=fail smtp.client-ip=40.107.243.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/BWwqVMqeIo8unvrHXd85TMucaijXWY0n5i95FpEAgYtXZ6jOaXsd2iFQaeM6gSIGzKYKo5VUp+LoiR+numH2lo7rn1+Nn9VM93R20ScNmPXTu1/e6j7CVq5I696wP9L4VOgHPGpB8l5v4D5C30k5p3nv4y71NQL/ZSrlTno0IrCnhIHAVgMQyh2lM2a1WJDoVAQ56V+8UpdR2jU5YQwxtmb0IXPWyHrcbJuzuA6oOSGmH9SE3wgMj7XayJVR3IKJUJ9uDImHyim2scNVu/5Tm1yX0kYdKI4x3Raii2neNFm2wD5IMkEyc5+eNVGjjhJ0D1TJP6cjh5NsAGRyN5nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZ45P6Fb/rgKNy5Q/D7U6fOxpjdpUyIE8puTl/uWfrM=;
 b=V6vzPDsxoOivR9e7gLsLx66v/oD0wpJYTaIO2vJ30hnCoNPTmm3hInk+oGnFsPA05J/oVFrcqU0uQX7PqDICkm3pxiuBrvh0FodWr219EFgfOf6Pxe1YSlnsgu7UJB5ihY9y3729UsTOyLfdJ6IhjUfz8FEdY6lKqlZYiFa4tr6Q8ElwcLQTEpZG+3ZuSLnOJdT04vZ5cI0x9BzV26La673kVvXWxvZNSRO6mGF8t7bXSs6GXARLRAtDPHc2eIrSlsoVk3d4YxzWCOibMy3NnpquaGu34kquREXwjmgGi6Wss9TrRl+/nZMAcgLAAemes4GhcImSj14I+D3niPbzOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZ45P6Fb/rgKNy5Q/D7U6fOxpjdpUyIE8puTl/uWfrM=;
 b=Dy3oyi3v7ZhRvGhDAkQG2HQj0MYy94CUKBA80nBcfVS7/YclYedgR3Djk1C+Ep++ePJ14o7IZCVz/mSl2azcBOUOq+5JvyQCfeHb1sMNIJ3ehxwNTEeScPtu81+AsVprKTfaFIVOvo8K+BzfIzuBZcvVIylxUcR26mRMYSWJ792/qCEE5n57bdWQACsHgKAEP65WYWKIoN4ZouQCdEQVCky+rmVE4RWjeTm50pw7JXJvWmcZtg68YpLuULRXDGkvJ5tSdONQCDYFrw1DIoRbs351U+oGEUMIO/4bfAfQ5bNDveniLOlMpLZy41zc5NMNmJMdbPzPhFcXwJBPjEvpoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 LV2PR12MB5752.namprd12.prod.outlook.com (2603:10b6:408:177::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Wed, 3 Jul
 2024 14:30:40 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 14:30:39 +0000
From: Zi Yan <ziy@nvidia.com>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nhat Pham <nphamcs@gmail.com>,
 Yang Shi <shy828301@gmail.com>, Barry Song <baohua@kernel.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH hotfix] mm: fix crashes from deferred split racing folio
 migration
Date: Wed, 03 Jul 2024 10:30:37 -0400
X-Mailer: MailMate (1.14r6038)
Message-ID: <B6E5E92E-DCA0-47E8-9217-DCE843BAC122@nvidia.com>
In-Reply-To: <29c83d1a-11ca-b6c9-f92e-6ccb322af510@google.com>
References: <29c83d1a-11ca-b6c9-f92e-6ccb322af510@google.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_3E67FEFF-2E98-4C37-833B-AAA5C289B536_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0294.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::29) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|LV2PR12MB5752:EE_
X-MS-Office365-Filtering-Correlation-Id: 7710cffe-c4c2-4f61-81fc-08dc9b6cb64f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2CrH8v5XxjS80oeJOUydQSIBrKzib23mrFatpbaq4nZ80UQv+YvcBNsEomk4?=
 =?us-ascii?Q?t3bVAS3/ou7qvSr5Cdnfe+0rVKTmUXHfodnFdcmBQLyDHmE4OeRbE99v1w6Z?=
 =?us-ascii?Q?Kjp+ekkyNUg5yIF545ho+ITUf4h7fKDJIRVxemIzU/96mw+sng1vp2doCczh?=
 =?us-ascii?Q?koZb34KaKr6SJIe9v7eig+qXMT0O8HMFZBBVVla3KjFqneISX0PY98+BiwcX?=
 =?us-ascii?Q?yGMWdSLFC/hMqs59cE+G4e23GtnC7Hj1kQbbyDCg4+hK46YeQT6DKCtHnODz?=
 =?us-ascii?Q?Qc8Gs6lqaGIF3n6CuunNDouh3nGgeJLztl+92F5knBeccn6GNa+ExqEVizjN?=
 =?us-ascii?Q?fmb/PQazxAIdEF5ynCMjbohc/AhXXRrumRBlhIbz+F8nq/8phDwEpmy8An5w?=
 =?us-ascii?Q?v7TlBePiFmO23bBPXIWxf9QTeofRqkjebiacdigcGYsraVVnWNAf62rtCVbc?=
 =?us-ascii?Q?b4lUcdBE+/HjuPwuAbiyETHVqJYDtWMK0yDUq+n7zMlU65wEueZRUxQTk9C2?=
 =?us-ascii?Q?rZcyXsWM26uvlN8pYRJgqCQ7GfYrYThuVRxeARFyLiqlWgVuNxo012r+SwSE?=
 =?us-ascii?Q?WD1RlslYsn4wuau5PlhfhkviBS7tOdyzpkKXtvY2ccFE6OlebK8aIEOGTodC?=
 =?us-ascii?Q?3KJsPsnLNtzDWu839o2NcGyFN0/w6U7+MtVaBvzP4Shx9vATWwf9N8/9z74O?=
 =?us-ascii?Q?/6J1JRKhKJYj9ftfOcye7LsZOsOttyppqY3nOC78MKqCaLirDU3WtMycaCV4?=
 =?us-ascii?Q?RW7O6PfMZMWGXB7Wm1zpsxSvlwFWmr8lWF6tfr+L0Y0JXeaaag3dpYHBdOsc?=
 =?us-ascii?Q?5uSceFhNwSpNW02WJSMgtK4IEHozBOZzibNTfXdy2fQnDG7POFqOVMG00xAy?=
 =?us-ascii?Q?7+vFfCITkgrFH6MQMjrwzm5xx2iCpXitp1C3zGgriSaa0jrISLi/S502+sis?=
 =?us-ascii?Q?br08urvqZoa0wRL0UR5utQEbC8LM8FR8ay99W56QaC5wZ/txnH5wsmELl2en?=
 =?us-ascii?Q?YKSWBqN0kH+jOaNz1q4wpm4gi48ojDVjuQM1gfBg9qhrpgDD9sf3ymp1mjKF?=
 =?us-ascii?Q?tQ2W1J2DOAyh8ITwduF3f3GdSEO/LepKxf1j8/UIo2q+pAEIYO6cuOFdMlOg?=
 =?us-ascii?Q?7iGA4oZLXIj5n8689uip+5KPMTcSjx/pAzpWzWH1HXlE+pdDSldcr+DIRb14?=
 =?us-ascii?Q?G3eiigG8U2Z08wUn3wNvFWRMBsgFfGLCDtLwAfZLadoQaUAGZ38Y218jYAka?=
 =?us-ascii?Q?mvZz1wvek/8G6PS/yzy6Wnvo9KkQOLrD4pIIQ07S/AkXNZVQGozSioM7WSYA?=
 =?us-ascii?Q?Xzx/vTDNuzx+pSeRPobMvhrmgZBg7Uig5VZHYYn0NYkY168xx73imghQgsNQ?=
 =?us-ascii?Q?JUHXpr4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QoAHqTEFWMOZYXH7Vu3Zp3oAJkyt29IuudCgYWIakJwdKP4LFVIwWYxXwWIa?=
 =?us-ascii?Q?TmjO+BHts1HsO+NVdWhJY91dm156LRjcSZ2G8uB+MBAJ7BUNZhviwASUzCBj?=
 =?us-ascii?Q?btmjT7j9fFw2fin4dfCYmU44NPszU5mYSMMWNgI4qHxnk25SkeeDMTF4nJVk?=
 =?us-ascii?Q?dAyN9DWZN/ke81pZTe7QNJ09zLQqTXDDloXxQ//Z2vTildH3Vf3BXBNuGVy2?=
 =?us-ascii?Q?Lk1AZKGiFMgcDZuooQ9JO2+45OJyrDUoPkxfhcuX5rBv5WoMaNruK/nIWJP8?=
 =?us-ascii?Q?8dvmusnkyLg36m9DBvDj2H9V4co+OlRUWJMWBBHA3Cz3AJKjKl9NwUJVoww2?=
 =?us-ascii?Q?BiBkOqVb/WopMAqRTw5YDn4Eqps/WD/obKEpS4b63ASmXiAK6gx0YU/xymxV?=
 =?us-ascii?Q?VaVFgQr4qvp4IkU3oH6jKUpwFzLpK3hC0qPYk3d60Va6S+Gb96DLSwmDta7u?=
 =?us-ascii?Q?gBhiMAD7SV13I2GoEsyCwGhukTmC4Kku3Ad1MX4Dze0YiVTsBFo80RAE9Oje?=
 =?us-ascii?Q?8qpqvVUCmazTT5oiTHITmngqiG5OsMucsicvqKNjmJcLP6gAtiysM3wzBoH4?=
 =?us-ascii?Q?oFzZmJN1JnaOc05egDpzFLLdYH8zoJja2GFl7aZa/JBGeOEYpSLVdP6Pj8Qq?=
 =?us-ascii?Q?jg4MEiS3OvosGofyE0o7y0eN2A37lWt9ots/1+dssgwO2fl/q2balh9q13Pg?=
 =?us-ascii?Q?Qk/j9/bDWad7Xm52A365sWM2FEbQ31wGg+pcuoBzk4I8GZZzz7BxVVUM+3on?=
 =?us-ascii?Q?nlT5ovz+kcGTDd2WMUq4nJOfwgPs/K71KDlA/peicEaaMDJAOEQ7iO7m84DT?=
 =?us-ascii?Q?eGMyYLsxJw4PnDTlfBQJqtlpTf4DDymgXDoW5ZDIlMJWIaidW2m1GOrYQKqS?=
 =?us-ascii?Q?Q7pLfrgeGZLjdc/POx4MQo7+g/cozqLdDXf+YyfgbTjOI3e5LgAtzKHwg8/I?=
 =?us-ascii?Q?NncnMWBE19P/Geo2mQXZIqu4eA6TkbU8FYeQwO+r8ZKyoPpPbr0HsJNPSZHw?=
 =?us-ascii?Q?P4NdZQd+9nBsz3ZXgIbJVIHtt50sDzq+u+5nQgwIsJQp6aPeVOD1Qy+KKMj3?=
 =?us-ascii?Q?Rq+nK5S55UTcGHebpNQakJcyO5k4IyjXZv86xnu6e5WYNzZ8nrkYPWJzXuMk?=
 =?us-ascii?Q?ZjcTSldxT/AbaykENGdIUqCpjnlgd/QG4kkHA2XEAXdxf6kbUTHRG/X4QdZs?=
 =?us-ascii?Q?JSHIbjXhXQxVbaAqlRSuTboPN+vPQYka8HEjHQpV8Z4sZ8W9S3mW8VC2N9r4?=
 =?us-ascii?Q?qVGlb/zUjbmObl21GU5hdOEdeJASIjvQdVJKMJq8lruMiAWOPsBm0Uu8ltA1?=
 =?us-ascii?Q?ZCPS8tGuoSToyoyd9I/vOmUvWNdCSvjz83WSrxwnIfc7OJtwCuQrxlhGDHiA?=
 =?us-ascii?Q?vRk/1arnML0s1i+iAG4fAgeQNY1SExX+rax20iNK93NFcEbt+TxjzNCEpTuS?=
 =?us-ascii?Q?aASdbYLcQcT8BLPiXWMU26Hb3IbsIvY7qu9HqZChg5VHvAsjKrhtkbQnCXWD?=
 =?us-ascii?Q?HeUIdManFQBz3wcR0/u56e79FrQ2xXEWbpcoq7IlzkLQyKVLZyo0+7BYXjEj?=
 =?us-ascii?Q?qxyu52d36rPZx6b5TVk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7710cffe-c4c2-4f61-81fc-08dc9b6cb64f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 14:30:39.8974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qQWAsaOADYd1bVm+QOdgHLItqgaQZfie+RwZcVUwLfl4Tf/Spkqq1Rs721E7YNLp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5752

--=_MailMate_3E67FEFF-2E98-4C37-833B-AAA5C289B536_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 2 Jul 2024, at 3:40, Hugh Dickins wrote:

> Even on 6.10-rc6, I've been seeing elusive "Bad page state"s (often on
> flags when freeing, yet the flags shown are not bad: PG_locked had been=

> set and cleared??), and VM_BUG_ON_PAGE(page_ref_count(page) =3D=3D 0)s =
from
> deferred_split_scan()'s folio_put(), and a variety of other BUG and WAR=
N
> symptoms implying double free by deferred split and large folio migrati=
on.
>
> 6.7 commit 9bcef5973e31 ("mm: memcg: fix split queue list crash when la=
rge
> folio migration") was right to fix the memcg-dependent locking broken i=
n
> 85ce2c517ade ("memcontrol: only transfer the memcg data for migration")=
,
> but missed a subtlety of deferred_split_scan(): it moves folios to its =
own
> local list to work on them without split_queue_lock, during which time
> folio->_deferred_list is not empty, but even the "right" lock does noth=
ing
> to secure the folio and the list it is on.
>
> Fortunately, deferred_split_scan() is careful to use folio_try_get(): s=
o
> folio_migrate_mapping() can avoid the race by folio_undo_large_rmappabl=
e()
> while the old folio's reference count is temporarily frozen to 0 - addi=
ng
> such a freeze in the !mapping case too (originally, folio lock and
> unmapping and no swap cache left an anon folio unreachable, so no freez=
ing
> was needed there: but the deferred split queue offers a way to reach it=
).
>
> Fixes: 9bcef5973e31 ("mm: memcg: fix split queue list crash when large =
folio migration")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: stable@vger.kernel.org
> ---
> This patch against 6.10-rc6: Kefeng has commits in the mm-tree which
> which will need adjustment to go over this, but we can both check the
> result.  I have wondered whether just reverting 85ce2c517ade and its
> subsequent fixups would be better: but that would be a bigger job,
> and probably not the right choice.
>
>  mm/memcontrol.c | 11 -----------
>  mm/migrate.c    | 13 +++++++++++++
>  2 files changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 71fe2a95b8bd..8f2f1bb18c9c 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -7823,17 +7823,6 @@ void mem_cgroup_migrate(struct folio *old, struc=
t folio *new)
>
>  	/* Transfer the charge and the css ref */
>  	commit_charge(new, memcg);
> -	/*
> -	 * If the old folio is a large folio and is in the split queue, it ne=
eds
> -	 * to be removed from the split queue now, in case getting an incorre=
ct
> -	 * split queue in destroy_large_folio() after the memcg of the old fo=
lio
> -	 * is cleared.
> -	 *
> -	 * In addition, the old folio is about to be freed after migration, s=
o
> -	 * removing from the split queue a bit earlier seems reasonable.
> -	 */
> -	if (folio_test_large(old) && folio_test_large_rmappable(old))
> -		folio_undo_large_rmappable(old);
>  	old->memcg_data =3D 0;
>  }
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 20cb9f5f7446..a8c6f466e33a 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -415,6 +415,15 @@ int folio_migrate_mapping(struct address_space *ma=
pping,
>  		if (folio_ref_count(folio) !=3D expected_count)
>  			return -EAGAIN;
>
> +		/* Take off deferred split queue while frozen and memcg set */
> +		if (folio_test_large(folio) &&
> +		    folio_test_large_rmappable(folio)) {
> +			if (!folio_ref_freeze(folio, expected_count))
> +				return -EAGAIN;
> +			folio_undo_large_rmappable(folio);
> +			folio_ref_unfreeze(folio, expected_count);
> +		}
> +

I wonder if the patch below would make the code look better by using
the same freeze/unfreeze pattern like file-backed path. After
reading the emails between you and Baolin and checking the code,
I think the patch looks good to me. Feel free to add
Reviewed-by: Zi Yan <ziy@nvidia.com>

BTW, this subtlety is very error prone, as Matthew, Ryan, and I all
encountered errors because of this[1][2]. Matthew has a good summary
of the subtlety:

"the (undocumented) logic in deferred_split_scan() that a folio
with a positive refcount will not be removed from the list."

[1] https://lore.kernel.org/linux-mm/Ze9EFdFLXQEUVtKl@casper.infradead.or=
g/
[2] https://lore.kernel.org/linux-mm/Ze_P6xagdTbcu1Kz@casper.infradead.or=
g/

diff --git a/mm/migrate.c b/mm/migrate.c
index a8c6f466e33a..afcc0653dcb7 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -412,17 +412,15 @@ int folio_migrate_mapping(struct address_space *map=
ping,

        if (!mapping) {
                /* Anonymous page without mapping */
-               if (folio_ref_count(folio) !=3D expected_count)
+               if (!folio_ref_freeze(folio, expected_count))
                        return -EAGAIN;

                /* Take off deferred split queue while frozen and memcg s=
et */
                if (folio_test_large(folio) &&
-                   folio_test_large_rmappable(folio)) {
-                       if (!folio_ref_freeze(folio, expected_count))
-                               return -EAGAIN;
+                   folio_test_large_rmappable(folio))
                        folio_undo_large_rmappable(folio);
-                       folio_ref_unfreeze(folio, expected_count);
-               }
+
+               folio_ref_unfreeze(folio, expected_count);

                /* No turning back from here */
                newfolio->index =3D folio->index;


>  		/* No turning back from here */
>  		newfolio->index =3D folio->index;
>  		newfolio->mapping =3D folio->mapping;
> @@ -433,6 +442,10 @@ int folio_migrate_mapping(struct address_space *ma=
pping,
>  		return -EAGAIN;
>  	}
>
> +	/* Take off deferred split queue while frozen and memcg set */
> +	if (folio_test_large(folio) && folio_test_large_rmappable(folio))
> +		folio_undo_large_rmappable(folio);
> +
>  	/*
>  	 * Now we know that no one else is looking at the folio:
>  	 * no turning back from here.
> -- =

> 2.35.3


--
Best Regards,
Yan, Zi

--=_MailMate_3E67FEFF-2E98-4C37-833B-AAA5C289B536_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmaFYI0PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU1e0P/A38FGlnMXd5O++6iMGF6PtbzaW98nT4acOE
QFRW5V5wO/Qhc8CaOXzNq2jnYRlTIhIvaujaKTz+fjPtsMZrXznCDAIUivBw6iSc
N4w2uEvvfGl9B2wmIwYlloOYUmqk8txkY7HEqqOcG7X1/wHyaFlvXm4f0KbW2G9o
x+gkJUXB3bDYLHmVSOkWpQrDhl5EuTpWfHwf182JX+L4ukc7jrtGyPMnvGbNuxEX
jAtHIG2/7a2Svi9jT81fXoE0myXP55RwHM3SABqs3uaPLJaDenrszUjx425ZT/4I
TYAthvdV2ydflhRRsoahQ+oKU/itb/fOP0pWrh139pOUTPng9bARSVunH6M7mhng
O5AtggZERRXRTd/SpW6aLYYYWsNV6RaNfAQwvkmfAaaDzzYcwHqZNVmEvtvXqhSb
Jg38/ub4tcf2cPi0cn6wcUL3Dd3ObsMJF5FOfphK/zVNUh+ec9zig1RiMsyHQ4WP
TadacbsX8QpM48ouEjd22ERnABifG8lyZ9A8V7A3MIzRhL5j0mwk1mE4YaLeoF06
MrHeO9ShmrvQKIVjm06NG49WV3dY1mLlO1n7cOIrZGcxm0unFo1ktve6d6Yai38L
p7rUKkuClrgYfsQHtGNrn5W/QHTgIt7QdEpFRbuAHCjRNTlMniCPcVZLN6MRyIjn
73Aou0IK
=SwYh
-----END PGP SIGNATURE-----

--=_MailMate_3E67FEFF-2E98-4C37-833B-AAA5C289B536_=--

