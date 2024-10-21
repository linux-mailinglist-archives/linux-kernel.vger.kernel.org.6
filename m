Return-Path: <linux-kernel+bounces-374561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F3C9A6BF8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D616F1C21B22
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5FD1F1310;
	Mon, 21 Oct 2024 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CpLquCOr"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93901E5722
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 14:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729520509; cv=fail; b=qC6/Ml4cMvlrgghDsLPmWCrAK77v2JzwHkycuiXV3sL0cJR4U0OcW3kNL6Sayd0//EOEJCF8oB2deLQ8xFEFkr+4wxgHGJsSQP5UcE2eEACg2Q8P2zt7PHk/UEnxsZ6hQsy41zkda+ArNFJsyWeuXM7tLWMkxN9ioIzrbMH9Fzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729520509; c=relaxed/simple;
	bh=/LCm3BgVpL37ccq6YpWdcSrqWuui5VIJcxg4TXlroGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ngNv8Oj2VXitmQVjEjZogzslRuMDUs+OmdhRaNMBukrurZvZu2szHpAuS9xYBUi9mR9PLhqL+7GBPPxClx6igB0jfHjBbUPA+oAlsIrTA4394PvWyP+PZ1L5kAk2Duku35NTWUIjva1t+YFYvJCiQsj+arxXTUUya4Xuq6B5/Gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CpLquCOr; arc=fail smtp.client-ip=40.107.237.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mi1Ioj7aYenOSO6nNLY36VnPxkvTm/ev4vsnxQLj1Q5UZLSbJClKrhpuA7fTQa7WVKZiML54wB+DMcTlskGpcvBk6QGSozuQORaQ7a5ixClfVHvY5e+iJ72V4UZdzIcyw3uYIoYs7hQFD2fw+tvTnpVkITjYZM7Wmoe4pEzd7WmlpyYztTYCYZHXLjttV0mNIAsDmwCowfNmkSTRhk4WE0tA6nMf8qfrSUUsq3KXuFVWaYmnGcM3WIwd4AFDzMO6p/KrXYBr3w+Mb8t06Wg0QFnm/tGrxErgeIjCA9//YPSqdGCtO8vrmMc+mVdPm6W+0hIdz9LopmB3otAoCmBS0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2jjRBres8gDtVCBv5yI/18rzcIGuN7gZO3Qj5b6gcM=;
 b=zIEldCAvM1UDDIPRyu0UOj1xiZVj6KuiS98x5XpitgXXqE7zTsbFR3iqNBm8OH6HlrXLwUAmgrLHEepdJpLo1YWr559kTp5TgWfvaVBc5sS88e6hn0ReRFqDuehwDs4raPrI8QwBRw3lo40Nq7t8hJvm1O6t3aEzGRaf6oyryXUABJL+XMKt6BJP12ivxfiMeNkj9jIK4waRqxlwu9H5+2148JwlyrdQd6wQU+qJMo/ZSeLTcPFladgiTteIW0H4pO3qJtCgRHWGNMhKLg4RMI+SXGabv8RVKEHsg4IiglzR7uo7DubhsZiAuERwVWoMpBsJkG/XA7bOtSYgPJtaNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2jjRBres8gDtVCBv5yI/18rzcIGuN7gZO3Qj5b6gcM=;
 b=CpLquCOrKn/H7+Ymg4I28uP3N5WmikQsFjGC8eGhzzCvpEY5DL8pGlcgGC+d9xqiOJzrOckmA/n5Rmakk2TEr46vo5/EpHDoTEMPb99LyAzFIFq9Jquck6lvbTqzMWxkHIMqgShV+li2dWwWN9/RGb/LjOP8DBzKm1ncTAVtfuGo36qvSXbrWRsDkrz/3PDbQrLqLrH5vVGjDGUu/9/8x82MMIvnbpRG+ObbTk7SKm7n4/R7mkGPOX0hA3v+cGUeyzv8JzmhrUqY9ewtPCnwrZcundRpoIZDnQD3utzQ2Uf8/HOAzuZit+IrHZzrpDFHwGsOONMJ6KqIKvyVzifddA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH3PR12MB8546.namprd12.prod.outlook.com (2603:10b6:610:15f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 14:21:43 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%7]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 14:21:43 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Miaohe Lin <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 John Hubbard <jhubbard@nvidia.com>, "Huang, Ying" <ying.huang@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Alexander Potapenko <glider@google.com>,
 Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: avoid zeroing user movable page twice with
 init_on_alloc=1
Date: Mon, 21 Oct 2024 10:21:39 -0400
X-Mailer: MailMate (1.14r6065)
Message-ID: <7762D266-82C6-48E2-BF80-211413BDA1EB@nvidia.com>
In-Reply-To: <a7279751-b9cd-4197-9c98-3aa70b1f5fe8@redhat.com>
References: <20241011150304.709590-1-ziy@nvidia.com>
 <a7279751-b9cd-4197-9c98-3aa70b1f5fe8@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_6BBA8066-D75E-4FA5-9A56-2E289A520C57_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0324.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::29) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH3PR12MB8546:EE_
X-MS-Office365-Filtering-Correlation-Id: c47ac52b-3009-429f-9eb8-08dcf1dbaffa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6VmgXncaF/x6wwuJ6vGPYO8y8OrDGnj60OEwsBJe4F9AzJQFiBYcU/DqWEt5?=
 =?us-ascii?Q?s7t7pIICiVg7OfUXNWA5XEi4ykZd4npzmCDexj5/PvMKOjsAo6yL0BoI3HCU?=
 =?us-ascii?Q?hcTgaaSWCwIqdYUnni0qMIJUn5nyjzhytGaDHZv7VIoPEGfaUGw4guro/VHY?=
 =?us-ascii?Q?j6oG2tuQd5wr4fAokV3fCpGakHy2pIf5LHPTcpajwbavmhW7uMkXYtwLrN3D?=
 =?us-ascii?Q?cEwKGdBPUmUgzK+WsxrBlq6OL6K878hZw9YSfKZIVjm+d+iqRBXwJpFvMzlN?=
 =?us-ascii?Q?9hmkug8+Py3XlTDlYpNXlOSyG0PRLYMb3UM+ap+TlcdJoVpXUGpIpEOOWQ6b?=
 =?us-ascii?Q?dpNUm93AmlASEGTKjrO5EH308FXl8yDstjYgbrDh34WgeH2GPjnTvjzVrNdu?=
 =?us-ascii?Q?n2/6v2MPrGzi2Wz5EEH5W4df9PquUSjulQA8aClFNg99ic4RE7q8Cm1dtdtx?=
 =?us-ascii?Q?LMN0CUf1KSh/hfuaH+liPkevjoDZvZOVGLS+Tok6NvxE+ftLhHUw6KMfJgdF?=
 =?us-ascii?Q?s7sUUE/YtG9jXKNfqVty4HKtWi5PBGdwp8/w3J3XmQriMYXuFrYLT2CWMHaq?=
 =?us-ascii?Q?oOivg3AOHRS7qtQkY7B5UwnFapQ6QRei2Ql6I93eHolAueO0QemaeX7QRrMo?=
 =?us-ascii?Q?9KOEWz6cIj1klcsU+3s1qPdBcGfb4+LHT7+CGU1CPPDBAMoYAB9CWQVerhhc?=
 =?us-ascii?Q?cXu+8lZClgd/L5eHLl6T8NRBwlJejLggWyeC7gcdC7STRLVO3falQqPg1Rau?=
 =?us-ascii?Q?fHm4raI2jPZH/mdawk9tOcb58IvVAmgFYJQYj5Yl4LtC4pIx1Fm/GVhnwUr+?=
 =?us-ascii?Q?JUhStG5LLJLievHn8uljkJhLq78Parwvz8KLf50eWIV65axvkQIo33JPuAEb?=
 =?us-ascii?Q?DxMVUiyRZrtCIXBay+KpES/Uh7ZzLF8LMRsfL67k59tW46LNBANQh1fh4Cqp?=
 =?us-ascii?Q?0EtHtrGvKngjwt9EgtVu1ImD5UXKpoMf7j5C1MlAn3UYfEARWPBgdKliumos?=
 =?us-ascii?Q?7YFYXIva9jNdOCQWYRmUy0u0g/NuwklMWmqQ5UMPjQ2cwfizlncQlOqDHmIr?=
 =?us-ascii?Q?/3Ll7boYeJd+T1tL2f88xCnA1K1oLhw8CzayQhB/ouMRS3iyyZSLTzlId2/V?=
 =?us-ascii?Q?6Fw8qaQ61rkN0rgY6EL80eKhhxQu/RhwgWuXLIHlq3Y8PSFE4hJ23HoWoA2l?=
 =?us-ascii?Q?BSrohAAPmJZTT2pHpKa9JWhqS9qfTnjotK1QiFVUqjNZ2jjjs04Kc7EOO3Ll?=
 =?us-ascii?Q?OSSkH7YCEq/cgwUdM20wtBptw04xP2HmbGwKqzi9e3riI3Pk+aUirWHD5r4O?=
 =?us-ascii?Q?vvbBEZ4krxpoj9/26yT+AtcT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Cm8g3mX7rOKwf+tY+SBbi/jArthRWH8hpIhL86JvUWI4IO7kUpuKEZK5MS6q?=
 =?us-ascii?Q?FJ4/onkOZVSyAoU+ohegUX6rnDMuFdZMsOthMWN9pA37fVtGp8rTjN4ZxfiH?=
 =?us-ascii?Q?R+Qb35fvsbuZWuEL6Wi0RoEtWN89If1wQuiKEm5pGU09ABUEhb7OEU8OYo9F?=
 =?us-ascii?Q?/7bZLhtE9eqnJtaywQ5fNZsFA3VB2ADKxNighXmf4ztJxCdxAWezn58B3eYB?=
 =?us-ascii?Q?rfw6t8aC7d1fue+I56vDTEEgPe0Dk00Wn8E2f6brNw1zkZv1IPILPbe3SBeV?=
 =?us-ascii?Q?sANtMqsnE7n+H0dVD9a5VYP6ZHBuVm/oSTwAriLuPiBcFqK4u9lhSHFnCVht?=
 =?us-ascii?Q?87ghMgtsuAHpbhfiIN9zqiwG3RQ+05Akpnn0f8fH/8JUpNv4tL08ZZvLRYqc?=
 =?us-ascii?Q?wBMEyCIAzEr1FwUrvhSlA5MNULF4Eu0jYq92nDNTsbGMM795dbhRnj/Pv7A9?=
 =?us-ascii?Q?sLpB/+zXHBRObOzXonw5IRfyNkOOSM2DgKOFr1O8ilR+dvvCR4vHlzVpZf++?=
 =?us-ascii?Q?6UnQjlXzjQPrCdiqWbGNBOmFjtlF0n62Q0nLQYX/8uJ8pJr6XI2M1y6iC9fS?=
 =?us-ascii?Q?nOF2x0zuAqvgVn/YLgsa4e9dyfVLw19xcm3XEUBkkjBYqnh5Ks4eXgC8/5af?=
 =?us-ascii?Q?qr80Hu1OWtb8BGArOwOT3JC9LZEE6yojuKXN4OVj0Ol5Ts6Y9OXcX+rhpq75?=
 =?us-ascii?Q?oOBzmnyHqNf6QCohuAsZhf6dYmBW10TiVDx57MsvQ4zCx8UTR3jXssJ7DaCU?=
 =?us-ascii?Q?Iuupq61kKO+FNcubarET1/og489u8QYWgDUhyfBthGGhgBh2klkbyGArFnHf?=
 =?us-ascii?Q?i5iUQt7GYtgkR8lIrbSYLMAXtKxHEGRjQjXrs6iUYQpA8+Mpfdq1mJwAb/g1?=
 =?us-ascii?Q?s2OvbmxTygYgz5kCiL7v37kOBUw10aGqB7awV0mbdk2KOfYjDqb94c2ya8Gp?=
 =?us-ascii?Q?Rvt1GFzBLnEOdLqd3TRBsAhcaz9tigbdb3Bly/Sh3c0jdS8/hAZ6Pnz47Nhp?=
 =?us-ascii?Q?InI/OrcTXnOFIrLcHLxKXSruH+OR7eE+xHGEjrzc/jMaZK9SWFtPTYS9TIn+?=
 =?us-ascii?Q?WjerDoKeSv90nn97vVFXQdCV9DRp+JO4NCAetCxpGFrRyeZ7sKMllGIQyand?=
 =?us-ascii?Q?som58Jv8tWuyeC9IPxxewY5BTT7XJri4gvBfYID1VH3+WcDy0GGX4SHMD5rd?=
 =?us-ascii?Q?ixOHXMBLGSqtoC8it7+c+bHAVi4UxyUC5Kxwh73FiJpfgswtHo8YqKk6zEhN?=
 =?us-ascii?Q?f+fLVV+p3rOf0ExDmrQnMlUlkkDQGpMofGESB2Pz4nDYoPDCE1+TUWQdsKWA?=
 =?us-ascii?Q?ubQUSit8YiCSUuS9kAR0jKGR8W2kXsLp2pZCIan7QiQickdkigKlDjxeeHyd?=
 =?us-ascii?Q?8401AulwRZQ2lZKjcx0k9zodnpx4B+Bx2qm8mtZWytrfdOtlg+5JH/lR+hlc?=
 =?us-ascii?Q?HYXZRSLJKyOgrAqo2rSrWj3+Y8jtFNAYlmtgn+d5p/F1pK3pRD0VNCNFroLk?=
 =?us-ascii?Q?VNvMVRgUqtlH48HxRbkifiN1zhYPGIR6uLbznwnOR+a1rqw8igjE8lpleJh+?=
 =?us-ascii?Q?965X6AH0E5rJZv0muSqvcevUc1XvrU7WrBEFIG/O?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c47ac52b-3009-429f-9eb8-08dcf1dbaffa
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 14:21:43.3775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r7kkx+cJWX+ajMypXO1sKecFjg8M82wMw/ymMDDX1GKXlkrcGihbBXV28mUH973O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8546

--=_MailMate_6BBA8066-D75E-4FA5-9A56-2E289A520C57_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 21 Oct 2024, at 8:23, David Hildenbrand wrote:

> Am 11.10.24 um 17:03 schrieb Zi Yan:
>> Commit 6471384af2a6 ("mm: security: introduce init_on_alloc=3D1 and
>> init_on_free=3D1 boot options") forces allocated page to be zeroed in
>> post_alloc_hook() when init_on_alloc=3D1.
>>
>> For order-0 folios, if arch does not define
>> vma_alloc_zeroed_movable_folio(), the default implementation again zer=
os
>> the page return from the buddy allocator. So the page is zeroed twice.=

>> Fix it by passing __GFP_ZERO instead to avoid double page zeroing.
>> At the moment, s390,arm64,x86,alpha,m68k are not impacted since they
>> define their own vma_alloc_zeroed_movable_folio().
>>
>> For >0 order folios (mTHP and PMD THP), folio_zero_user() is called to=

>> zero the folio again. Fix it by calling folio_zero_user() only if
>> init_on_alloc is set. All arch are impacted.
>>
>> Added alloc_zeroed() helper to encapsulate the init_on_alloc check.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>   include/linux/highmem.h | 8 +-------
>>   mm/huge_memory.c        | 3 ++-
>>   mm/internal.h           | 6 ++++++
>>   mm/memory.c             | 3 ++-
>>   4 files changed, 11 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
>> index bec9bd715acf..6e452bd8e7e3 100644
>> --- a/include/linux/highmem.h
>> +++ b/include/linux/highmem.h
>> @@ -224,13 +224,7 @@ static inline
>>   struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *=
vma,
>>   				   unsigned long vaddr)
>>   {
>> -	struct folio *folio;
>> -
>> -	folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vaddr);
>> -	if (folio)
>> -		clear_user_highpage(&folio->page, vaddr);
>> -
>> -	return folio;
>> +	return vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, va=
ddr);
>>   }
>>   #endif
>>  diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 82f464865570..5dcbea96edb7 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1176,7 +1176,8 @@ static struct folio *vma_alloc_anon_folio_pmd(st=
ruct vm_area_struct *vma,
>>   	}
>>   	folio_throttle_swaprate(folio, gfp);
>>  -	folio_zero_user(folio, addr);
>> +	if (!alloc_zeroed())
>> +		folio_zero_user(folio, addr);
>
>
>
> It might be reasonable to spell out why we are not using GFP_ZERO somew=
here, something like
>
> /*
>  * We are not using __GFP_ZERO because folio_zero_user() will make sure=
 that the
>  * page corresponding to the faulting address will be hot in the cache.=

>  */
>
> Sth. like that maybe.

I changed the wording a bit to fit the if statement and put the comment i=
n both
call sites. Let me know how it looks. Thanks.

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 830d6aa5bf97..b304bb3ffcef 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1180,6 +1180,11 @@ static struct folio *vma_alloc_anon_folio_pmd(stru=
ct vm_area_struct *vma,
        }
        folio_throttle_swaprate(folio, gfp);

+       /*
+        * When a folio is not zeroed during allocation (__GFP_ZERO not u=
sed),
+        * folio_zero_user() is used to make sure that the page correspon=
ding
+        * to the faulting address will be hot in the cache after zeroing=
=2E
+        */
        if (!alloc_zeroed())
                folio_zero_user(folio, addr);
        /*
diff --git a/mm/memory.c b/mm/memory.c
index 0f614523b9f4..42c8bb5fcd8e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4719,6 +4719,13 @@ static struct folio *alloc_anon_folio(struct vm_fa=
ult *vmf)
                                goto next;
                        }
                        folio_throttle_swaprate(folio, gfp);
+                       /*
+                        * When a folio is not zeroed during allocation
+                        * (__GFP_ZERO not used), folio_zero_user() is us=
ed
+                        * to make sure that the page corresponding to th=
e
+                        * faulting address will be hot in the cache afte=
r
+                        * zeroing.
+                        */
                        if (!alloc_zeroed())
                                folio_zero_user(folio, vmf->address);
                        return folio;


>
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks.

--
Best Regards,
Yan, Zi

--=_MailMate_6BBA8066-D75E-4FA5-9A56-2E289A520C57_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmcWY3MPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUPWsP/i7mLDKdNzlabxPHLT9Suj2+GdYXc6j5QoJx
SBtFljE+gngdzo9g7YUNTJrXS9LmMSrgJkgsuko86IdOMf6OcdVkgeaie9MFGqZY
BdiztgrncPB0E0PQmEz+XDEsqNynBcCUaMIO4xS7aCy9jaZ2OH+ECeMJS/jbEM3+
VXvPkDta6XK5GBN61vbi4c3NxdPY/vVoRon28YEZXSk4bATSNSAr1qnZvZKK4x/X
/gpy9lYrGB8JeHoUL6TLn3g9AUrlWZsgbCWgWoGmnMhWj8zYR88BSfdyyqzBQB8e
Myo3M8pNq6YGOI3awgQCCrvsgp15BrdATxsCmkAfys4VM9YcWGhQ9ysbW5ANX1DV
r0TGLCypQZtOiDFlwP+RZgERx89+e9UsheeZyhVSkw48u8McOV8PeHEomx4LkUei
ADtpZJQkUt89CzRV0Nc5GgapCFvZRAQuzMoVWD0wAbUSdoBMBDQyBzGWoAaJNfUn
XhMb4CHkDUzJtNV2dhfIBBkr9OQj/OlTdfq8Pl0Lfk82+dNWG58RjF7goqApT35U
LCG5dohvOgKPFpU/NtWGl+5VoXdUioXxUWQeJm4r8I4l9pjU8GMiyjkUIyqAysdC
hhbwiuWbpIUAysNy4bSfvyk1seZZr02WJQM1rUrwdofACzlxhcxVOJwjJn4cX4nE
IyWscRP6
=+F1c
-----END PGP SIGNATURE-----

--=_MailMate_6BBA8066-D75E-4FA5-9A56-2E289A520C57_=--

