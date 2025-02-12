Return-Path: <linux-kernel+bounces-511873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A2DA330E2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 21:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 862C6166FEA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B591200BB2;
	Wed, 12 Feb 2025 20:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="WWGdWQQt"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010079.outbound.protection.outlook.com [52.103.2.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BD4134A8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 20:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739392552; cv=fail; b=AQ7YHMZxvSSwpSZ5cWDSHOXLs7/IgjnsFzxfostb0jCYfN3Ki1MjPR6RDzbjWB8n7ZJ+HQUSGY7mokuscMJFcXvnV7aSwlWjfEg/OhyuqFWfp/e4+QbSbr0ldXRi1CzrE25gFJjvqjma9EY26p7cUW9yFOqtvKVGnOHsCeQreKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739392552; c=relaxed/simple;
	bh=IdLevnLu0fGDuL8ZKGtHvH+xIiBXnpMikOcxqL/Pbyk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AL/YF62Dx4vISbOyQ0cE6VsOJykCZvIVHjG9WSqsjtRLfXG9UGGecNRTOZpMnqPFjC47D6xl6UCxnWCuVBNkXp8nBcjRsmqxrRs6aCi8wbxnf/I1/Xdp+Ubkc5hmPyLlZVPEddOlVIhYTq13Ich7UTiFqUETqngo1AchftNAuRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=WWGdWQQt; arc=fail smtp.client-ip=52.103.2.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rG0N3Gcpz6hXvH6lgFSrkQEnJHsBxgP+slg0VbcMFIRg/q5HrafCkt7eqXz2jNKR8j7rKz4zfLfJB+Mx2+RElHsy4REVc3Mrykne8Ma/RZ6T1FqjEmb2XZ/LYxnWv8cFtsDxkWChHOsddh76O2dx5dEWy4jaXvSIOxVx+WloMGzXkcM63xgFv1VobQrWVVVUPyXGFDkERYZ1cydAKrdIHl0yzg5nGQAO4+KcaT+6xRes1ZllemDKSek4h+HomCPzvgxDjpHyyDj9eijxO/j5y/REfGCjh1LevCFjxS0yhdJDJs9O+tDGmQ/yU1WXt8FAQhC1HO3ckhKeMYwpjGtfgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBLUX08WfZ67U0ihLqkbMPvt8rd9o99GjPhZSsPgLao=;
 b=BykK5n4otxOoSVZLRf8sVnQEx5kn8RfUZndVLql01jFYkxVKsHWKQM+/IJM4P3Ea5lrtloCzUWvlETNIIUpjaF1GEfy7TqJ+hG+7Kyq9M53k0ScfhRQYT+Bm6uDf2fYZxQ7P45zDVx6PedtWdZug+Hpegca3F9NNTKUhmvM+v6WtGUtzbKHdN1fUgTZbSfOJRjz60pPHLEcVTbc+lNcpdFtUs50k7lsohejVhiOnYJWE1CkRzFCOH8v/3rEHv8X9HXZ+XtSnoltmidtx1/5epkqNpjzWd8a7+207eGEMlXGx0Dfb7q35ujCJf/aZClQJuH16sHguiN2G64N/qyLlew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBLUX08WfZ67U0ihLqkbMPvt8rd9o99GjPhZSsPgLao=;
 b=WWGdWQQtJCf2tURVvDidzKFWjoUpzfDHxxUjSAboRgzNURTdyMl2MpMuhAAQqgMA88CzywDp1SjOKLv+7jFyxrZp7CWVWhAIgnsAU1iHVV0TaRSeUgux59nNPtDmmTQlOPbsXAZPLyZrTTIy14Le/2JJ8EBe8oj0i9kZYh2d8mMGq50k/lfpUFjm6ymH2TDjlLEtklNSFvqLJa3g1YOQX/T7K+pUC9CDyUv7TRmNUxW8gI4uMvcrLwle0kmdmnOOrrdf8ROwydzf8j3Z5nuacYcqVS7unxTnD3kC/6ruqq6PQy/a0rYOAcm/jWPqu3rqgr8VALMP1FowROp7wnmLFg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY5PR02MB6626.namprd02.prod.outlook.com (2603:10b6:a03:20e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 12 Feb
 2025 20:35:47 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8422.010; Wed, 12 Feb 2025
 20:35:47 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "riel@surriel.com" <riel@surriel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "peterz@infradead.org" <peterz@infradead.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"zhengqi.arch@bytedance.com" <zhengqi.arch@bytedance.com>,
	"nadav.amit@gmail.com" <nadav.amit@gmail.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "kernel-team@meta.com" <kernel-team@meta.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "jackmanb@google.com" <jackmanb@google.com>,
	"jannh@google.com" <jannh@google.com>, "andrew.cooper3@citrix.com"
	<andrew.cooper3@citrix.com>
Subject: RE: [PATCH v10 00/12] AMD broadcast TLB invalidation
Thread-Topic: [PATCH v10 00/12] AMD broadcast TLB invalidation
Thread-Index: AQHbfMkzyIcQIooZIU2xh4Lt0pZplLNEHUAA
Date: Wed, 12 Feb 2025 20:35:46 +0000
Message-ID:
 <SN6PR02MB4157BA0DCCBFB5D67CF78B69D4FC2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250211210823.242681-1-riel@surriel.com>
In-Reply-To: <20250211210823.242681-1-riel@surriel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY5PR02MB6626:EE_
x-ms-office365-filtering-correlation-id: 97352595-0613-495d-61ad-08dd4ba4d4a0
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|8060799006|19110799003|15080799006|461199028|3412199025|4302099013|440099028|10035399004|12091999003|41001999003|102099032|1602099012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Mu0m1J278KpM/ZZZJHNNLrXH8nDmCoeVkxIwwwSa12LV3/aSPIfXt3Ero+Ey?=
 =?us-ascii?Q?kRRyIGo/cC0tWaAlpbvjc4p3WwWZvvgs8/whXu8qpZQF8zI37EzWPnxUxEro?=
 =?us-ascii?Q?muwfTQ+78qGp0mCUaPtBjIKRJDgoPAkKWEiMMN/YRmrPm9ZiBOkApU6HG2fz?=
 =?us-ascii?Q?Th0fdMmSE1nVHyfB0eR8Dbzbj0LC8nJuxgv8tLvASIEJD4K8efCGukKWAxAS?=
 =?us-ascii?Q?PX41IqB2EI2pvT0lBEY2hWuIqH9r9f+Q1qoC7VarkqzRb7YwNIfxtn0J5tnl?=
 =?us-ascii?Q?4w1gu6odYvvBDkIruvaAwz4n/j7nEonpM3FnVnz+SfwNYbODoCR6fYhb0/c7?=
 =?us-ascii?Q?F5jClHni9LhcKIFnZtZSmrvrEWOYu3XA5YuO02E1l1MOwrGkH31u8bR6RSsY?=
 =?us-ascii?Q?Yhws/iRd7xQLhKcUX7U8UrMciKXbejTUZ8rTaAwGZfybdSCgU3Rp6y3iwzMK?=
 =?us-ascii?Q?/2LV7xBdhPDPeK1STIqhIpsbstADKnzaMKpIdDRVlNNIPpt3zDLzQMV7bi35?=
 =?us-ascii?Q?m6tAey9wDC9FJqoQirALQm8cbh3aCGK8l/iA2TSR4MesVopO81w2YryEPzCT?=
 =?us-ascii?Q?aXS63x2DeR63GnRJ241+SbZzdJJqaDVhsDboBKYGYzcYOQzZr37987ktMmzf?=
 =?us-ascii?Q?lcpiyMcX2icV0CsO+gBVwemdnOCwB5v5hpaPCpKF7GUKMqlj0ogUzW80egCR?=
 =?us-ascii?Q?v3ExqFRZ7MMYYCdPxKIe8PqJCM9YLQlklpzd8zyRBzcJGXDMgV7W7nOwqFlt?=
 =?us-ascii?Q?tQCdcLOuyy1NMJtU8HsEI24xiCHYSTRBvalNx4cZv5C8//ylyxySksW9KT23?=
 =?us-ascii?Q?phsV72HzuOXA0foIgCzMoZaHdnvOwE2bL2qDhwvQ5PQwTMTzIprZVlHgOihL?=
 =?us-ascii?Q?H7JEPZMHu/GnO8XMtokxyk7ewaltKt954KdvPgior3b8IbZD6F9aUOAKOCMc?=
 =?us-ascii?Q?SNleR29IqGvhNEgUbUdqZrmoY9UCezWvFikzDHrtm6ODsLtSbRwFpqdgfb4X?=
 =?us-ascii?Q?pPCEIFlPKz/rcITZkJ83Sznl1LR3Uup3NjYY4kGn5VDEMOibHcKwwIkc++xX?=
 =?us-ascii?Q?1FuM5bsQs+W95vztOUwxQ6AYUQyBmZIjWWf6c8j4bFKxjct1b4qaYjjjtPit?=
 =?us-ascii?Q?aLShdHGxAW/YoHWl3blFKzqGgWJZVUzzBiz5LurTw/QcVRmdIe/Ey6rDCXXA?=
 =?us-ascii?Q?TwuimakKz3bPXJULSsIoFRr4kMeZEW2jTYR4RM2JTSFrf5tBmwzqHTXgjm4?=
 =?us-ascii?Q?=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KHA+TLx/BFkivqx3zzHSZaPV2AWjwGp7EPTJDyv12jMEuBiK24KMatE7dn/C?=
 =?us-ascii?Q?Nc53hp5HijenWX01FVFM/nBCJ10bbEcmhNZFjhy4IXKnsk/Z05vtwERrfM1z?=
 =?us-ascii?Q?YK+zrxQjrzz5/kxhL6UzevCikB/bkX12xuh48DftKlJ65z74qoCVA8QQ4NE2?=
 =?us-ascii?Q?qtk2u1GC8vfZdTWTTm0dx9rhewxoL4COv1v45ivNj3TRpCSOkt9kCa08vPvV?=
 =?us-ascii?Q?zvpVOvVYYzCS3sIFA/iDfh6bpMcVKLDa4niqxf1ly98K3Bz8xxsT6DnwCDjl?=
 =?us-ascii?Q?tgE34d81G9BRVp412Yvd/Z/q4jUt1MAw0bgQtzNnSxE0k1rt6wWr2jyXyFlA?=
 =?us-ascii?Q?eZsu/o8uRlyGcvC99GoVcGl3LIzdLsELOfTYhuz6C6XxZCNiobZmOIbU3jRN?=
 =?us-ascii?Q?4Tl/R21JoWsjtSuV7Fzr2P8a9j/E0HZAJJ0TYfpivzsGGhgFFpGIrajgxJx/?=
 =?us-ascii?Q?6a6qbAWecKUcSNMZOl1/zMUSR80Ys6IyErysDojBAGYFZ7mVBz/6kVWrB0Hc?=
 =?us-ascii?Q?QTmuRP1P6RhlVI+NlIW7JkzHGE+u5UVv5bQc38YQgy4ahlnxC8aVEq8rf/ZY?=
 =?us-ascii?Q?SKHIRg1HAuuIRGkZ92U8/VTzSwuK6YJeGFGBRMiwxUVr9jzApUdU30GRZU6D?=
 =?us-ascii?Q?21p+nsecuVDAU9Nh7bioMG4+3YKh7DaXGsvPeuXQjQi0SOqNoGXg7iDuX3Jb?=
 =?us-ascii?Q?qM1jvgaXNDUsCxh6WmepS7feQvdWnMmn8g/2ErWDkH7kMwbYt3KiGsz4xa/Q?=
 =?us-ascii?Q?R0PEtE2Oq0/+4R+G8RS2mF5Op1VcgkaxitrHWXH9IvT3r3CcXBUprdbGrJOz?=
 =?us-ascii?Q?kE0VpcmBaZfEkGrhhqNongttCKoisBu4YL8NZg+B5LKKUXv00Wv1YG31EPMd?=
 =?us-ascii?Q?8uVcOT9DHPbVZBxDoto0gMReq1ZDdPQ8ZvDqwDywXIKh0t+lq2PTmXnrkb5z?=
 =?us-ascii?Q?c9Pkd9WmmjLE6LoZitO9vOGsl0XA3/UQlhZUxtsuUA49AMOT7UU4Dx8F0zTT?=
 =?us-ascii?Q?ltC7xbfJRrLUAeHSXJmRhMvLBAtdAUsRwd3mY/94f9D57QTGzxpq7q46m5Hs?=
 =?us-ascii?Q?tVi/7IPtPY1Nx98Nol9up8oZsD3QznuF3OOKQ3iBkG9Jh9KFSREXZMV6lV88?=
 =?us-ascii?Q?3f2AjAcWFoDrcT/uGnLa+ShmYyW/l2rui4BLjyIhWc3DfMQQ/yo65CKImFCe?=
 =?us-ascii?Q?348o/XoIRGePYoPdGwVsYDTS4et+4M+PpTkXQIf5eWswxVu1gAQJuMw/hgk?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 97352595-0613-495d-61ad-08dd4ba4d4a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 20:35:46.9965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6626

From: riel@surriel.com <riel@surriel.com> Sent: Tuesday, February 11, 2025 =
1:08 PM
>=20
> Add support for broadcast TLB invalidation using AMD's INVLPGB instructio=
n.
>=20
> This allows the kernel to invalidate TLB entries on remote CPUs without
> needing to send IPIs, without having to wait for remote CPUs to handle
> those interrupts, and with less interruption to what was running on
> those CPUs.
>=20
> Because x86 PCID space is limited, and there are some very large
> systems out there, broadcast TLB invalidation is only used for
> processes that are active on 3 or more CPUs, with the threshold
> being gradually increased the more the PCID space gets exhausted.
>=20
> Combined with the removal of unnecessary lru_add_drain calls
> (see https://lkml.org/lkml/2024/12/19/1388) this results in a
> nice performance boost for the will-it-scale tlb_flush2_threads
> test on an AMD Milan system with 36 cores:
>=20
> - vanilla kernel:           527k loops/second
> - lru_add_drain removal:    731k loops/second
> - only INVLPGB:             527k loops/second
> - lru_add_drain + INVLPGB: 1157k loops/second
>=20
> Profiling with only the INVLPGB changes showed while
> TLB invalidation went down from 40% of the total CPU
> time to only around 4% of CPU time, the contention
> simply moved to the LRU lock.
>=20
> Fixing both at the same time about doubles the
> number of iterations per second from this case.
>=20
> Some numbers closer to real world performance
> can be found at Phoronix, thanks to Michael:
>=20
> https://www.phoronix.com/news/AMD-INVLPGB-Linux-Benefits
>=20
> My current plan is to implement support for Intel's RAR
> (Remote Action Request) TLB flushing in a follow-up series,
> after this thing has been merged into -tip. Making things
> any larger would just be unwieldy for reviewers.
>=20
> v10:
>  - simplify partial pages with min(nr, 1) in the invlpgb loop (Peter)
>  - document x86 paravirt, AMD invlpgb, and ARM64 flush without IPI (Brend=
an)
>  - remove IS_ENABLED(CONFIG_X86_BROADCAST_TLB_FLUSH) (Brendan)
>  - various cleanups (Brendan)
> v9:
>  - print warning when start or end address was rounded (Peter)
>  - in the reclaim code, tlbsync at context switch time (Peter)
>  - fix !CONFIG_CPU_SUP_AMD compile error in arch_tlbbatch_add_pending (Ja=
n)
> v8:
>  - round start & end to handle non-page-aligned callers (Steven & Jan)
>  - fix up changelog & add tested-by tags (Manali)
> v7:
>  - a few small code cleanups (Nadav)
>  - fix spurious VM_WARN_ON_ONCE in mm_global_asid
>  - code simplifications & better barriers (Peter & Dave)
> v6:
>  - fix info->end check in flush_tlb_kernel_range (Michael)
>  - disable broadcast TLB flushing on 32 bit x86
> v5:
>  - use byte assembly for compatibility with older toolchains (Borislav, M=
ichael)
>  - ensure a panic on an invalid number of extra pages (Dave, Tom)
>  - add cant_migrate() assertion to tlbsync (Jann)
>  - a bunch more cleanups (Nadav)
>  - key TCE enabling off X86_FEATURE_TCE (Andrew)
>  - fix a race between reclaim and ASID transition (Jann)
> v4:
>  - Use only bitmaps to track free global ASIDs (Nadav)
>  - Improved AMD initialization (Borislav & Tom)
>  - Various naming and documentation improvements (Peter, Nadav, Tom, Dave=
)
>  - Fixes for subtle race conditions (Jann)
> v3:
>  - Remove paravirt tlb_remove_table call (thank you Qi Zheng)
>  - More suggested cleanups and changelog fixes by Peter and Nadav
> v2:
>  - Apply suggestions by Peter and Borislav (thank you!)
>  - Fix bug in arch_tlbbatch_flush, where we need to do both
>    the TLBSYNC, and flush the CPUs that are in the cpumask.
>  - Some updates to comments and changelogs based on questions.
>=20

Tested this series in an Azure Confidential VM based on SEV-SNP,
which is running on Hyper-V and exposes INVLPGB in the guest VM.
I applied the patches to 6.13.0 with one minor fixup, but did not
include the patch to remove unnecessary lru_add_drain calls.
I also added some custom telemetry to see when INVLPGB is
being used vs. Hyper-V's paravirt hypercalls for TLB flushing.

I did not see any problems. The custom telemetry looked about
as I expected, showing a mix of INVLPGB and the PV hypercalls.
So for the series:

Tested-by: Michael Kelley <mhklinux@outlook.com>

