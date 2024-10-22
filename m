Return-Path: <linux-kernel+bounces-376404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 988FB9AB0EB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12B011F24111
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C48F1A072C;
	Tue, 22 Oct 2024 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NsTc+Bpt"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5510319DF75
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 14:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729607629; cv=fail; b=pJkMrSDcfCAg0raFyJQPjXDIeZ6tVhar+VExqP+VFLR2WnPFVv0G6nKhrzC9qeAhW48WOvlmAVVkwEchfQCT521yd9enLPOy5JRzxpW5wX90rov8bqK2MKVoB0U1JC5nCduLQxUulYUXeZrI7eRRFdjQw4xF3uIm4CZEzDunNeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729607629; c=relaxed/simple;
	bh=umWusJwVaL85v5ni4oxrLFcTU+URYmy+0thkN5DrMFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VL1iVgfd3fY4GV6J4aot5fr3spk3iJW2A9wSN5kxYSF9u11LWVFeg19s0YDn6qG2MrYUnw2Ht1pNQpP7fUcZiRarJXbvH5bVL6pQeyFZv7hqVEhNK8PJONLQD+Viees8IgKFLtxVfxn6iB/q6Fgq5lGzShUX9U4G0QswDUaFLX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NsTc+Bpt; arc=fail smtp.client-ip=40.107.237.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYUUuQyY4HAi3Ydpm0Z4AtHx/GbH8eGsqCzXph6OsaNOTRr68dm+wGafqaEYVdRQQA63pwZJqHXcXTroWxLWu4RncGyQO3PprAy5+kxPhe9ya6zye6GxMN8ZjW6WPR57N+dcckg6DFwu55yP373aFBLdW8jfgVetK65eBerEBeBEGZTDURalsrAT/ukULUx83kwqoO2Y2DNHvfMwiY73LK11DoHZFUuoFKuJ/+SVXFsLE5gWiOZpQOVhinpUPEP2LfDYQI3cmbKbJNrnUI3ajiDUa7bK1rO6Ja041SUNUEGtwadud+mUoxz4TsGEAEmBxE+Mrtzm16QQ5RmZBXauEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1xD/CbE/lc+zROufC7/O2Ow03xpl9GZigDIf/t0S/A=;
 b=CCdHoUKxkkMJhK//kDRHV4YMgzGAVMEcBQEaeWG0T8CTgXX+065DNrUaA903EcSKXmLP3XoIWjyHkXrQtmPw4tPKhuH26EBC6fEiQArZXAh9GayUtmt51L4zax+PAxHZgs+qVipB+mLM+mfP/EGuWkVECGwdmaIo6f2KD5OcpHvigRgZodZOqFf5RU9UDEKcuuadkoK40ByASHazjU+V3fNx4Knof6d0useX6RuZ/Dje/kmwNaAEy83jki2fWue2fUv/5u7gxW0WuaSVKrvgUDndgOtf7Pw514XyES8eSoBuUWlh2fBfmm60jdiAFFCZtGkWQ0l01P8/5P6HOAn7rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1xD/CbE/lc+zROufC7/O2Ow03xpl9GZigDIf/t0S/A=;
 b=NsTc+BptpsKR3bakfhKIJ/aEY9z3bzdpcBnTaEkIoKZHvFZDgrkjkrumYi3Ju5TwpvfFFsO62Qc4bWdNDE7BW1nGFXUnQP1e/nIOrDzM2sR4iJil4f6awbJAB+hokye41MWFuirHw2CZmYJta8BHHrEu79GtKBL8oL4pHJk/jH+0zkZXRVvUVa9Rb1+QA0pUVy2DtPumrpc3J16gWJYYm9jpUQIx2pwGSeAC3jIG+KeO+fr26EgrYoQUAdD18Xnh6zUuxALCjssG7Cq+/GlZt/+pq6FAR68LRQFcuM6vO5MuXx6/LImZCa4i7cEAP8vdcdFheREW6HKUavEsOTnnfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH7PR12MB5653.namprd12.prod.outlook.com (2603:10b6:510:132::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 14:33:42 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%7]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 14:33:42 +0000
From: Zi Yan <ziy@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Miaohe Lin <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 John Hubbard <jhubbard@nvidia.com>, "Huang, Ying" <ying.huang@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Alexander Potapenko <glider@google.com>,
 Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: avoid zeroing user movable page twice with
 init_on_alloc=1
Date: Tue, 22 Oct 2024 10:33:40 -0400
X-Mailer: MailMate (1.14r6065)
Message-ID: <97DB52E1-C594-49B5-9736-89AC302FAB01@nvidia.com>
In-Reply-To: <7762D266-82C6-48E2-BF80-211413BDA1EB@nvidia.com>
References: <20241011150304.709590-1-ziy@nvidia.com>
 <a7279751-b9cd-4197-9c98-3aa70b1f5fe8@redhat.com>
 <7762D266-82C6-48E2-BF80-211413BDA1EB@nvidia.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_1B6BF428-0B9E-4647-8C11-5E8793324CB4_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR07CA0029.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::39) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH7PR12MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: e0d9ff9c-5d0b-4083-a5a7-08dcf2a686e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FHZZYVZAQYSodBDwUFmansfFqRfKL2y+zKj2pozXMsFnv8YRaqrJIHy4NwhZ?=
 =?us-ascii?Q?Uh0H+3ZAWhHLLak/Pm4zEuElEp6Tj3oJykrpPCvckZUQQgHEQgBzWtvHnlKS?=
 =?us-ascii?Q?eIqU85i7J8GRUO8+inVhR8Oqy//fOHrrpLmcby97hwZFwNak9Taopf45gKMd?=
 =?us-ascii?Q?IVzyIxgJ20uAZ5NC+UdsP20NXb3AQ4xkxcvTC3MY1CRplzKL8A+h67mZMJw9?=
 =?us-ascii?Q?DG/56wRJO6S2fpYsO3eSk0ljYW431js1ckMkas1MrZTxgQmvbUFnGHBqU8gZ?=
 =?us-ascii?Q?r5AyNIA2nyyRqQw9AHmQjC5z9gAamhyJDzY1RY3tHQ6vOghgZUqMuf+NY5jB?=
 =?us-ascii?Q?nMjHsbpOFBhTA6E1C0dH6C3FN/y9zqtFbZ9zPYNCx+RJqD1Kzw9Bb+kCzDq/?=
 =?us-ascii?Q?0X+fXmDdPRvf9/MpoypXDXhTbW7F2vhApMsqL6M+Afn3yl0vKDtzYlgjallf?=
 =?us-ascii?Q?7RMBcyScWCld8ClomT1qJ+a5YCjrQJ6ug0g8cj+/Yf8tNoSEpyWa9q9/vQUb?=
 =?us-ascii?Q?bePWtaVt0IrEb5zeJ4AfdbqaWJVaW0Z5bKFqGX7CM2Ydf1y/R3h0iP6/4mhj?=
 =?us-ascii?Q?gFB1Mu3FlS5hzBqzk7jc3jE7cjyuF0qzttEmsK4G28y18h+/U55mO0OT+zAA?=
 =?us-ascii?Q?89xX7pefrivzEs7C+PufiUYZWa6nDw1GXAiUz/P2jqW4Nz/UDc0tKBqiTCsM?=
 =?us-ascii?Q?cnefiFr/lzOoOihxFKf3UnYX3SNb9CYkZmYsYRnCuncxzPNKvyMr0g+IBYjO?=
 =?us-ascii?Q?kNqGvS7hde/H8+EruUB2wmSoXY2W5tgdkfOzlyytfL11v8NR951oFa8FsN4I?=
 =?us-ascii?Q?OdP2p1T9Mc3wvzYmP12uCwZ7p3ku8uYt3V0DUYR1hmLT/Sb+wb2cDnmyHRlc?=
 =?us-ascii?Q?Fdg18v0qRmizEYX8CJPzEEBt0zpw4YkTqiPSjR5FLciGWwvNy6wJavYa5jLB?=
 =?us-ascii?Q?cVSWhOl1cVJfYifjuLL13qPkWxcE3bR2JDWexfT0xVDcfsQ/hbQ8C7ka4LPZ?=
 =?us-ascii?Q?xzUA6vrfLR+Wl1bBRiSv6TXB79EROmfVJdMcQ4nF+6ZV8R4tzTIgboSFYGRW?=
 =?us-ascii?Q?nuu+Ximu2u7R9RHJKJCwUPAiJ7609KklcnBhMsgYZ/c+GpFIbcmSxfzMumbv?=
 =?us-ascii?Q?dNqyn4PZOlHqfoxOBBFdYJirAahmOdS9GO28qiezlzThztcdSv5yaEb/NOvL?=
 =?us-ascii?Q?70Xf62o72GHzPRHcxWHIEkQubyIxVF4idqyRgCTbSdgTkHqJTG4TsDpOP4Bu?=
 =?us-ascii?Q?acN+EMfhQ+qyb+PbSx1t3s6fjxNNaVArXTIPALVHQPHTjxWjzO0Q8/TPIpVK?=
 =?us-ascii?Q?d+pVqdtXGyyYxvYurdxFEeRk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l5ZO1EyS/iDLbq7X+AQpocxTZyFmGQAfo00pahOKZlTjhKdXO5cLt/PpjWS7?=
 =?us-ascii?Q?5hRzTKdKTUnLqjORE2sWgw7EVmpqh4hZ6laTs87uH7ZofYL6g8kTbzDCydCn?=
 =?us-ascii?Q?+nvZ94UWxMlttnRw5RVOES72InVBJKRlfN/LYnSC4so13IRdOGmn53jaoUAF?=
 =?us-ascii?Q?Po152HaxGgB2PUiB/A1JbBrskdYiT6RwWMlEjU2wWrLJoabeVQOVrlBI/rPH?=
 =?us-ascii?Q?2kXFpstla/YvxHu1sX1q+rMjKJ2Dp7wijfJ4rO+z9q4KN2kqUkl+hkdHmbb8?=
 =?us-ascii?Q?iQpk6qw+RSSkc9geMDhQ1samrHLgaWHA4IRhY9AR3roY+DtCQmR40Av1XYGy?=
 =?us-ascii?Q?BPmsMfEjp8a5R0/9eYusG9hRosJpjKaO3ACfaewJadLiyg8LimGc4RKCrCcm?=
 =?us-ascii?Q?zVJ91dzmGlmykAlSnDWM316miCEc+asOu80PixJlRWTkRPo/Yx23LxU6may5?=
 =?us-ascii?Q?jHAWoyOeal41a1bRNeUUH8WXpnkG9oun0j5SkxaNsKCPJyAlgnqn1MnrEBex?=
 =?us-ascii?Q?RmCqNqDiebA95TXtM5P30WRs8NtmPmCsMdxbPL8o4Qu6k8cjpYhGxnzNdAgT?=
 =?us-ascii?Q?DE16Lc78jdvdJUtijI6vBamoKDASeXosAgIVEXovlmnxWsG+lSvHIkvFHoK5?=
 =?us-ascii?Q?fciyXiiVmV7j6VzOEbr5bcafinG6HxD6BT+rY17ySibwTT1gEEkP+/fgvPeR?=
 =?us-ascii?Q?wl1LdGG1Y40HYhepAw/U9RdXM3oa0MU5aOPodJk2iK3NCd4ZXzCVheGIpWD1?=
 =?us-ascii?Q?y0NWMBQlViPWfKonAwqqIfllBDgrfBSKcrOddIcnXHLxWECdWlq+swhkEowA?=
 =?us-ascii?Q?j+N4EDXITZxYVBRmSHu3JCuCZzJzTrW2p0OAP2fewcvx+KamV8JVA4S7MWJH?=
 =?us-ascii?Q?eoVdkQa0n+U6QLJJ+FHS3PvwDV51YAXu5FOsVoMnXaKMqVSEP/Sa/OyY8ARf?=
 =?us-ascii?Q?s+V0B6Ez3hRiCiqDOYSoqQdNmic9ulWAZEUW2YC81qDEg7qogACUctTnpPAA?=
 =?us-ascii?Q?tPw2Gix20XAtFnbI5R0miFaFhrzR8xga69RelWoK/HQUrkUacgRxXhqzpDqP?=
 =?us-ascii?Q?E1yCQSwaWtOY67lyUqlpuCdJ6ySB+NwzkT1zu7ekxZUkSJpAjVEfjtJE18wV?=
 =?us-ascii?Q?qroucicEE3+1ZhHuaSu4cM9Qs/WbgAC3ADhozVGSmvC0d4uGmcBgZzR4yNgA?=
 =?us-ascii?Q?f9Nm8Dpn2ABzmJxO6MtoOFDChv7HE/J5LUQz5iva1Y+50qkqohzT0vj7d1GD?=
 =?us-ascii?Q?g/ITUcyfbPgrEMYVtjBhTZMJrX11/V3OTUbG65JaRZH3AbUHIHremt24zUZn?=
 =?us-ascii?Q?McKBMe6wCDjxL1Lm1vSnx9UlY0SwM21PNB7X74eEn2FHahIfpoVAEuTrjzbx?=
 =?us-ascii?Q?ESx8UKmqHxRGK52PIrUSnWFjO6o4kLAQhR0mjbxBMVNBgvXUIUqQlTERaYG6?=
 =?us-ascii?Q?UFCBEEVYWQgDhw3Io4yoDHW/FPTOGhGu3NbfLNsjBItrxfZWh1SSVWjz5HGp?=
 =?us-ascii?Q?CaBIl+0TvMmmIDoNuBj4cQB6W1/MloDuDnsE46YVbik0KPaNUyFtejk9Vgxa?=
 =?us-ascii?Q?0ZbCZtxAvGblzTA/CfI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d9ff9c-5d0b-4083-a5a7-08dcf2a686e2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 14:33:42.2565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LAS3wHPgkzPPMmQy68BWRepbPR+nJq+X5YHnnXsUFsNTLi9JPnbxk9FXt7Fg8fDE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5653

--=_MailMate_1B6BF428-0B9E-4647-8C11-5E8793324CB4_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 21 Oct 2024, at 10:21, Zi Yan wrote:

> On 21 Oct 2024, at 8:23, David Hildenbrand wrote:
>
>> Am 11.10.24 um 17:03 schrieb Zi Yan:
>>> Commit 6471384af2a6 ("mm: security: introduce init_on_alloc=3D1 and
>>> init_on_free=3D1 boot options") forces allocated page to be zeroed in=

>>> post_alloc_hook() when init_on_alloc=3D1.
>>>
>>> For order-0 folios, if arch does not define
>>> vma_alloc_zeroed_movable_folio(), the default implementation again ze=
ros
>>> the page return from the buddy allocator. So the page is zeroed twice=
=2E
>>> Fix it by passing __GFP_ZERO instead to avoid double page zeroing.
>>> At the moment, s390,arm64,x86,alpha,m68k are not impacted since they
>>> define their own vma_alloc_zeroed_movable_folio().
>>>
>>> For >0 order folios (mTHP and PMD THP), folio_zero_user() is called t=
o
>>> zero the folio again. Fix it by calling folio_zero_user() only if
>>> init_on_alloc is set. All arch are impacted.
>>>
>>> Added alloc_zeroed() helper to encapsulate the init_on_alloc check.
>>>
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>> ---
>>>   include/linux/highmem.h | 8 +-------
>>>   mm/huge_memory.c        | 3 ++-
>>>   mm/internal.h           | 6 ++++++
>>>   mm/memory.c             | 3 ++-
>>>   4 files changed, 11 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
>>> index bec9bd715acf..6e452bd8e7e3 100644
>>> --- a/include/linux/highmem.h
>>> +++ b/include/linux/highmem.h
>>> @@ -224,13 +224,7 @@ static inline
>>>   struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct =
*vma,
>>>   				   unsigned long vaddr)
>>>   {
>>> -	struct folio *folio;
>>> -
>>> -	folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vaddr);
>>> -	if (folio)
>>> -		clear_user_highpage(&folio->page, vaddr);
>>> -
>>> -	return folio;
>>> +	return vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, v=
addr);
>>>   }
>>>   #endif
>>>  diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 82f464865570..5dcbea96edb7 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -1176,7 +1176,8 @@ static struct folio *vma_alloc_anon_folio_pmd(s=
truct vm_area_struct *vma,
>>>   	}
>>>   	folio_throttle_swaprate(folio, gfp);
>>>  -	folio_zero_user(folio, addr);
>>> +	if (!alloc_zeroed())
>>> +		folio_zero_user(folio, addr);
>>
>>
>>
>> It might be reasonable to spell out why we are not using GFP_ZERO some=
where, something like
>>
>> /*
>>  * We are not using __GFP_ZERO because folio_zero_user() will make sur=
e that the
>>  * page corresponding to the faulting address will be hot in the cache=
=2E
>>  */
>>
>> Sth. like that maybe.
>
> I changed the wording a bit to fit the if statement and put the comment=
 in both
> call sites. Let me know how it looks. Thanks.

Hi Andrew,

Do you mind folding the changes below into the original patch?

Thanks.

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


>>
>> Acked-by: David Hildenbrand <david@redhat.com>
>
> Thanks.

--
Best Regards,
Yan, Zi

--=_MailMate_1B6BF428-0B9E-4647-8C11-5E8793324CB4_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmcXt8QPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUqSEP/3hEK5i8b0xtdw0XX9LInCO4N4TZqDJPaFM1
8WSm4+aZoG8bLqNtIlsN0P6g5Mh2IjWmPFBL5E4E+HF3NrWAgEhERuOgZqe70PGP
FiQia6Chr6ZlW/YPch8/dTdww3eVprhbpxTmZjH1knCIXQqwF4OUqsrXqh1NsPVl
v/kW3oJLxkLikstekPlwxFP3a8ZS+gR54ErP42dRzajDgQ9QkD11sKSvkzbT+w99
1nFBglDf7/jogPPYfuQ5G/HzavIek5hjbF6bwpz3wcZvMAbyZhFoGaNGJ4sLuRUS
CsfUmZPVrgj2PlBsQ8+bseRYIyHWQIwIXgEObQE8DclK4fJRQgachYfe/WcorlAF
GO5nASvNAloipU5Z4XjVzsLJJ9KzU3j9ZZraDb4uthkIwUOabuhOPSSAK/dpkqlT
jJns26o9ctQGSHYQmN6LLkH6E2EGjJbGA+AGkwFPh3K06ngPkPT5RXSsY+PwszBE
ITu5RC7AaplD/T1zkqAxYQ39vClUrS6iuPXl6s1bC+fp2bk2IIWRY9Usuamo8JmN
EkK/Ur+onMhjo5EJVEo7JgZ2N5GQZUs1gyRz0MPDmbQOAKL1KgdbSgLsS77n/ZBF
poRsVwDzO5QVtkpnskdtDtlLO72iUamY88GFTkQNRKkG6YEZF2RHNM7ZWW49JibG
EwVCKBxT
=PwxD
-----END PGP SIGNATURE-----

--=_MailMate_1B6BF428-0B9E-4647-8C11-5E8793324CB4_=--

