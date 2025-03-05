Return-Path: <linux-kernel+bounces-547649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC14EA50BFB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D8FC3AFB05
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E70E255E20;
	Wed,  5 Mar 2025 19:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kDNzKshw"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79EF25332F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 19:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741204532; cv=fail; b=qvY2u7RTCxL4ijyFUBoH7bUO2LK1Ink4uU/+xUvtgy0pfacw/2tmF6RHElJ6JVM8zMUQ++hcSqBi4CUpIMRGT3k/N9j76UpD8J5yPTY6LNQYkjHW+2kiL3WX3I/GI0xIwN8Y/KZtq4XUYSl+Ovzt25QuubWoMxsgGpfC8iMz7Ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741204532; c=relaxed/simple;
	bh=LOWlZPKUGd28oP1/cAcvtGZcOJ9MrTGw6REREATXBks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lpQj700wOBSrmWC7ZmYkaDhbbFBZgicXDErYlyjRt9y5gNxu/wQOaLzrACWYIj3VTYqnM85h0vnyvMrp4Q+bchv9DMBZrRH0i8X6A5sc5awPKHvuJCUfL2htHhKh8rUItKNqPLO2w2ZTJxd13LvJZKl0th7TUvnaswCN4GYiv8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kDNzKshw; arc=fail smtp.client-ip=40.107.237.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bpj0qdzya+aBg3s+my3lIfPbw4ti1ov4ViAp6bE+JeONDocTIGJ7J1b50UkzS0nOaaoln4W31BcpD0hOdpAFx5jFXZ6O86oH7G0q8xdSiiJUawkMKa88z2AY8hlaKnuethS7QfDI7q3qCnVDtmPCr/pXKunaKd5xO6l0U3j3ulBXQwu3Y696Y7OwtjHiIIUALSagOb4btWIyhkLwU9U5d/GcUd9KJeQuR4QhR/9SM74zH8KQwbMWsgsJf0uN2ZInZfKL2y0GadqpsPe6vaXUVbXxI0ItE32ZFJbAWokZSCq/3Es4h+zts/XjSSfp/znVpRTmCrF+cz7GQvXvtC5BzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxFHAglTi/uFkqM5Ds+AQwQPDIGzl0EEH67r7pquxrA=;
 b=VN03vRz56VIrFDSGyuIS/RZYwZtT4B4AL61qNaXHl1Gs5/HnTAYpF3Z1V+D01n0Xr81TXy6oLqHGGVDCF5thIiYv2kqWbvyDXj48XcnfBTX8Fmq1zVan4Z6hN4h087Tp7CKHpU6xiN+7eThczfY9jtJYB6RjPNPHo+06ScW5WqIJ21+1S4tzqxd/cG04BJBWmrveu3BIkpNZGWzXUav2DBqFRXvRgHDa8jXtcU9lxvTECP+oDfrenRf1gI4GnINUUG+/Zf4mFYOiCMeYTVbMmkB7aZkroR2FvR/GexTbqeN6kp72kk6sW0ocb086bDajCliAVqKzRYeGOMDIzhCScw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxFHAglTi/uFkqM5Ds+AQwQPDIGzl0EEH67r7pquxrA=;
 b=kDNzKshw+BRfc3VdstYve5MeGT42th+d/0TwjDhY2x7pKt1DHpPH7/Am3mVaFPFhQyy4ehUHHUG64UPqPiENN/BVRvhE2Yhq+zYRGWfnhEXBQSWFB2VFC/ULlf2bhkiKsBeRGDYAiWQWLyOHPizMAiyjwoClUJGGxQaqMiMa7q+qFoo9mySTcx/1ti7mOf5DMzkPH2IKEHsTcHo8RW60h4PigxZCTPIHgug5vRGW+HruW4K2NnINj7YVR2aUWRNgrYcWnU/RXA95QpoPlX7J3v8Q18MXaxcPesliY8kP7QJVdfhtZizhpMljkgs8IibTNwkyLQkONfmwF80q8PJdLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA3PR12MB7999.namprd12.prod.outlook.com (2603:10b6:806:312::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 19:55:21 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 19:55:21 +0000
From: Zi Yan <ziy@nvidia.com>
To: Hugh Dickins <hughd@google.com>
Cc: Liu Shixin <liushixin2@huawei.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, Barry Song <baohua@kernel.org>,
 David Hildenbrand <david@redhat.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Lance Yang <ioworker0@gmail.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Charan Teja Kalla <quic_charante@quicinc.com>, linux-kernel@vger.kernel.org,
 Shivank Garg <shivankg@amd.com>
Subject: Re: [PATCH v2] mm/migrate: fix shmem xarray update during migration
Date: Wed, 05 Mar 2025 14:55:15 -0500
X-Mailer: MailMate (2.0r6233)
Message-ID: <99E6251B-B0AA-4BEA-9CD8-BBB52B546205@nvidia.com>
In-Reply-To: <23d65532-859a-e88f-9c24-06a6c7ff4006@google.com>
References: <20250228174953.2222831-1-ziy@nvidia.com>
 <23d65532-859a-e88f-9c24-06a6c7ff4006@google.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY5PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::25) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA3PR12MB7999:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f9914d-4c2f-437e-c714-08dd5c1fa964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c4vJGFitsmTkBqUQFFTx+ifpuju3mfBJV1iqgQsBWJIYwhDFt/ap5Mio20ub?=
 =?us-ascii?Q?ByhhEi/zxLRJeyl2N9AP8MNv0ZwA51eAZ7Y6Ep+RthHph6YpkzpxvdVgyngH?=
 =?us-ascii?Q?qjd+tqoQMhDgCyOoA+ht4uT2V+GGegDLErKwT2aOd5SKJqDw8+LKjPp+2TCy?=
 =?us-ascii?Q?Q+66bFSDzQPG4m0M75oaqRQ4xg72qydcHwCs3ICmLnPckTjyTd5po/gCWLcN?=
 =?us-ascii?Q?acXeS/v3IxsNLG4hNGMX8psa8MXRBW+pMffLs03RzJxy0b8vzRUoeU6MUnFF?=
 =?us-ascii?Q?r2Lg6kU78TSJm3/eoT/q+l3HPJQp2okFo5Qs1PPvVmjJuxXAY4yI7m5FdIF2?=
 =?us-ascii?Q?9Yn7IIjpI1Bf6o2IjbHc/EXPmL1Oq5avYuAN/UJEp5Hys4lxZRGbaGE9vPhF?=
 =?us-ascii?Q?at/AtkKuaTre54pjhXmKTLE6yEAW30ktpDM2SGo/ONIa7zjjX/33yLxvxNrQ?=
 =?us-ascii?Q?UybqRWxY9SPWX+OpdQpPV1asZmgFHfzLwmXlDckGeaNg0Rd9MXijzHJYHyjJ?=
 =?us-ascii?Q?Np9sd3B77ar3iuxSEmKgSWOwgJcxNTkNk3+enQ2CEVm99/F/d2569T0Y5AlU?=
 =?us-ascii?Q?L1JafGvaGCXBa2enWlU+4x3ywWgLg620mRPvP7gBXzEBv01i+6+ZYykAKWzZ?=
 =?us-ascii?Q?o+zK85bkWhYj0zIK0+H9oYxjjIS8FmCXuaAshDiMvUizRy61qYb54PrVM9jm?=
 =?us-ascii?Q?U/H8wPNTjCwRj3uFC/Hj05Tq5uBdcBmdh928/Mucu2gYoSAJuSmi3ntR13ye?=
 =?us-ascii?Q?VcPi6ysF7hkkNRj+D7gwkkRMkSwASCKiiOvAEr0k1jUJnS0wOA7dMC7Ve2PG?=
 =?us-ascii?Q?nFdqGlkZ+lE7u4zCNBfUK7xX34h4mKJlMwvWmGqLMd5YWGCtkOBNn3P83a9K?=
 =?us-ascii?Q?DFukDkEfcf2hjtA8EEQioNZFvfZyWuOdjcvKLKZbsALphr5zyknI13ezfeQV?=
 =?us-ascii?Q?dcbtfANTrlVYYVChdphasAWheETKeuaSIk6EcS/wDqHuaA63whQIBIMHlLFi?=
 =?us-ascii?Q?aTTKbL/ojw/mUUucjFpBkL1cJssTjteVWLqxk1lvTESrs8Gx+iFNXys/uurH?=
 =?us-ascii?Q?R1EwsP5zUlnEa7Le06UgJ2RDyaPk7BLAP/PrObvjjMgR23eGlOZkPOB2fFCL?=
 =?us-ascii?Q?ZJj7ooKO1p2wpLbFx3ESARKnJ8H7gReajiehnOjM1EBuWoxrteMhyLbrp8Q4?=
 =?us-ascii?Q?pncbHVsk7D/bdsYyFQRF3uHo2WV5Z0XD/Ke5mnX4CAZdzfHA5H/m8AcThd3+?=
 =?us-ascii?Q?DYrGOhu8J1Yc1j4ZwIWICfssyqF0xThbi1hsn3zpmYdZ0iSOdSdmw4Xe3ql3?=
 =?us-ascii?Q?JLGnRCgx8vhInoSYVLC5Ja29Pa0c4yafUB4EzlbzYfkrqF6CfPubtYXUIP1Y?=
 =?us-ascii?Q?bhzLdrkCXsQYbpy0USgbI+R72MLF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kpphuGxtbeo+n0aMTMMRDyByeiLicH6GCCbNJwHVWkINygBbsjtuYeXMvLMw?=
 =?us-ascii?Q?MRRosdc1bWG/Bt0l5bsGYAAnXx0R2r7Core/1HzZ7guMmErsGxGNn5YLvMf+?=
 =?us-ascii?Q?swcZ7RwJeG/83u73RRxxTyCJUR2CgopxkV4m62e+Q1GAuJhKlfp6K1IxIpfU?=
 =?us-ascii?Q?dvioMT4LUaeHsnvorzrmw5uC2M7xO0QgBRB+Ryohtf9YMeOwFX1X6Er4/aII?=
 =?us-ascii?Q?TLjCErubWzowIwn+Ul7PxJP4L3Zpmhw9fWUaMIJppR2KxhTMubdlHUTAJ7d5?=
 =?us-ascii?Q?7LeggQL+eNcC9h0eiHG+3hduf11BnXfUX8oxlOtnNeTYhGRGUAZ+Z+rNAOmz?=
 =?us-ascii?Q?B0/P680oLzrsePDFOgZ5yqIxcMPJuL6kr02aUFfmM34+8XybsdGCLj4qO5do?=
 =?us-ascii?Q?1xKAx14nu9wz33SE5uCT7326msVru+WYJLnAa9tTBShrbIifmvUiMekIBlxO?=
 =?us-ascii?Q?rmqqqSferxTuHacbwhA8fy1zpvY7sMTm1e5AQAAWYA5gGZ/uwXUjbJHqoPU8?=
 =?us-ascii?Q?xjo62Qo4UE/E4DAj0oyQcLrI13xhlEM57CFXPeUJqMdaEPr6Zf48I0DN7E9v?=
 =?us-ascii?Q?yhIPmlJ8Vi3H2C1qfewWX+l8/VJzEcdVU3Jl3HYLeLLOtxva1+RHFRjb5wad?=
 =?us-ascii?Q?kgKq8Uqix1G0V4CnIqAJg/ZxJbBbSH21zsRAK32Jfk9g+Sl1oIrV+/MWy4+w?=
 =?us-ascii?Q?SVLGEab97lW6x0CUYokQZG55lERlHxhZg0DNzi+D6KjR3nnkM1NjSBx/smWS?=
 =?us-ascii?Q?JJcVcMw7W0Teou7hhwyzY7cK+AqtALK6ub0+Yyfti0OyGnRF5yt6Huy0DBTR?=
 =?us-ascii?Q?rBtADAOv2eccnfWqN6E9CS3zhUBJ5tFWpmp4W4foQ3CtCRi/8PpBs0BNN+8C?=
 =?us-ascii?Q?IZQNwVLwwPnYGVJ0JryEE+ldXWQDSmOwyGCnx/5bFEaV1cIh18evi9zFOS+B?=
 =?us-ascii?Q?esqk+9SHYDz5nksS9Yk3e6G4izwigiJGSsPKJXgbb9LLOaPHQKTOwsSRr0OF?=
 =?us-ascii?Q?j26runjHSxePLZTvmQC18mhwBhXYqEdsZZqtHSzXyLihMVVw0ci2yqXOhMST?=
 =?us-ascii?Q?2YcTpejGLvZr0o1oSSw9xRxlN03IPavBUsO9okJFjAj2zfRKDr4Oj0/jXek0?=
 =?us-ascii?Q?cwtNqrOkYWayqBeqCPdfrj+OA1xwjxYOhRHKJuNtE3v0roi/iDnFntzoR8c5?=
 =?us-ascii?Q?fsqgeeJJO10SraWqnwRondWGcbgxjqDkxn54ZRI4feqysMiy+g0LZ82vnT7X?=
 =?us-ascii?Q?VKZep0Ce4L1AfxOHalw1bil2LTjqcBeQ9TCHsVzy8uBuoFDmbSYd2P8K2fSc?=
 =?us-ascii?Q?q+/7QTiSDnPZy27HulzbgG9jk28Yc0yJ8wzC5uxbWKmX18YBS1PUtEPooci6?=
 =?us-ascii?Q?7w7TELgEGmLznwjZs4hH3uJ1AxOmxQtHyhWAopA/+SvuR2CJjrSQq6deAfSz?=
 =?us-ascii?Q?9LG4bHscVuGvvluASE0XxcVWPMu8mO3+2T3jOr8iuixN/LHPaoxlawqo+VcG?=
 =?us-ascii?Q?KjHWJRyJ80kxCi758xTFk3/x401zaHS+szza99rHrpEz3feCLH2CY2oBm/i3?=
 =?us-ascii?Q?2yJ5GaX3MS20Myr2g0en4DfFFMMV0pkArMdFshjz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f9914d-4c2f-437e-c714-08dd5c1fa964
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 19:55:21.3187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: objMg8k4bTtlBPT7e2ziJ40Q5wMT2NHs3LCd9AQTjyUzoeIW63IqXK6gA856Gkaq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7999

On 4 Mar 2025, at 4:47, Hugh Dickins wrote:

> On Fri, 28 Feb 2025, Zi Yan wrote:
>
>> Pagecache uses multi-index entries for large folio, so does shmem. Onl=
y
>> swap cache still stores multiple entries for a single large folio.
>> Commit fc346d0a70a1 ("mm: migrate high-order folios in swap cache corr=
ectly")
>> fixed swap cache but got shmem wrong by storing multiple entries for
>> a large shmem folio. Fix it by storing a single entry for a shmem
>> folio.
>>
>> Fixes: fc346d0a70a1 ("mm: migrate high-order folios in swap cache corr=
ectly")
>> Reported-by: Liu Shixin <liushixin2@huawei.com>
>> Closes: https://lore.kernel.org/all/28546fb4-5210-bf75-16d6-43e1f86460=
80@huawei.com/
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> Reviewed-by: Shivank Garg <shivankg@amd.com>
>
> It's a great find (I think), and your commit message is okay:
> but unless I'm much mistaken, NAK to the patch itself.
>
> First, I say "(I think)" there, because I don't actually know what the
> loop writing the same folio nr times to the multi-index entry does to
> the xarray: I can imagine it as being completely harmless, just nr
> times more work than was needed.
>
> But I guess it does something bad, since Matthew was horrified,
> and we have all found that your patch appears to improve behaviour
> (or at least improve behaviour in the context of your folio_split()
> series: none of us noticed a problem before that, but it may be
> that your new series is widening our exposure to existing bugs).
>
> Maybe your orginal patch, with the shmem_mapping(mapping) check there,
> was good, and it's only wrong when changed to !folio_test_anon(folio);
> but TBH I find it too confusing, with the conditionals the way they are=
=2E
> See my preferred alternative below.
>
> The vital point is that multi-index entries are not used in swap cache:=

> whether the folio in question orginates from anon or from shmem.  And
> it's easier to understand once you remember that a shmem folio is never=

> in both page cache and swap cache at the same time (well, there may be =
an
> instant of transition from one to other while that folio is held locked=
) -
> once it's in swap cache, folio->mapping is NULL and it's no longer
> recognizable as from a shmem mapping.
>
> The way I read your patch originally, I thought it meant that shmem
> folios go into the swap cache as multi-index, but anon folios do not;
> which seemed a worrying mixture to me.  But crashes on the
> VM_BUG_ON_PAGE(entry !=3D folio, entry) in __delete_from_swap_cache()
> yesterday (with your patch in) led me to see how add_to_swap_cache()
> inserts multiple non-multi-index entries, whether for anon or for shmem=
=2E
>
> If this patch really is needed in old releases, then I suspect that
> mm/huge_memory.c needs correction there too; but let me explain in
> a response to your folio_split() series.

Actually, mm/huge_memory.c does not need the change, because
split_huge_page*() bails with EBUSY when folio->mapping is NULL. So
__split_huge_page() will not encounter large shmem folio in swap cache
case.

Best Regards,
Yan, Zi

