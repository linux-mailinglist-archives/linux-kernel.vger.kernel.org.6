Return-Path: <linux-kernel+bounces-413351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E019D17E8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28841282C8A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAA31DF757;
	Mon, 18 Nov 2024 18:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="TZl6G2ik"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023129.outbound.protection.outlook.com [40.93.201.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606A21DF278
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 18:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731953868; cv=fail; b=HPRs4QBxL9Uj+wDwftetG1VIMeZzz7pNzoCNkElOtrgA/CGlJ4GOBwbjmCLslStP33Ig3qqTsT+AY5NTnFqDPoN43LMrZyuqfzOO8RZydrU+XP2nWKa47U/0nChC/qNKk4kYr6eRTRUYAYiQsY5z6V0MewuHJbkYHINBrFhHogU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731953868; c=relaxed/simple;
	bh=ChGVSzLjAWGmzoUFB+n8oqFIU102JGUEpuyN4M7klaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HoyGaF/W/nq3FYBPt4fU4h+7EU880bGaEZtOm/M1kZpp9C9raSW95YU0v+eEEfTLX+2dFpeJF5oWy+dUMljjC96OV6VOBwnJCDa1fsAhpw6uSdVbyoX8oXaW+DYUtZhJMGA4aBZnvCuFDxDW9HB3zJU9Ryo+ZyZx9LJhzXZBTxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=TZl6G2ik; arc=fail smtp.client-ip=40.93.201.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xcw8zp5M7kSVWFZg6qN3SNnkcZ55+GQuD3lvxFS5I+zfLTYrBG3Ih1uEp+AOJnGlPx+0VFnIZv5ns5//yvTcbNJJBz5vVZ5uvow2lOImLas7FusQXqMR33K2FchQLYqVeOVMwM7IKyAHspgIOBIJ/m4PhidhgghYs0DCThaJxQQ+wvkZq4b+SucCMNjX+lxwZMYAaPNIh/20X5pqsoAralolQc0PimHjWRu3C9pWxOOGM3XRgV/8c9iVqYh0pJKHJFa/VuxSLzXud8XQleLwr9+hgEAg3FYiceG2ykQ6UzMtTNdnCi+lOfMfcRO+tJuNzPoyEeeYRXVXranlKwTcDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwhb2/6B0cSjLz3HSByelLgDMMOQl4Nq5+24O+ATC/E=;
 b=KtIwM5iNa1GgMkI1wU/+hgoG3Ap7KIkcXMf0tIliITTPoz8+HWPu026jIwdRvBtEx/W0D9z2hq6jDo2jb4zmnGyLphOMX9gZEHgO9G7EB6yIWAUtJdffxBB8EiqlPNJByzgzv2eEcaQRSTCcm+zpqoWAQ+XvqlxfSl05SkylT72p+nAkdcQ+99NEKoMTwlZFr1GWQsFYwZbwqAbqnuGrDqZg9Opw6JWKLbEUxZOg8XRrwGvNSzqBV3ZIIvpi6NBCc08fRv5GnHPFspF2q9jUHFYvbc01DTtG7YALlBhYqcMKQ5JlIJWs5yw3sSExzUMxG1g8lIQEj1bxir9PeGZv9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwhb2/6B0cSjLz3HSByelLgDMMOQl4Nq5+24O+ATC/E=;
 b=TZl6G2ikiXTIYp8/ih7PktVn6oDU9ZImzRrZqgGG0OHyjI8QkIYGs7kpP9lAeNYALF1ofYwMUODUpNe2inGnSAn1XYHur5iXWKJYoOVN+OmBrnGZqPOvnsnJd6kC8A1JLlxbuNkBFWyEp/tU6CamzZpJxaEeIVjhAp3IDy2KdFo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 CYYPR01MB8601.prod.exchangelabs.com (2603:10b6:930:c5::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.20; Mon, 18 Nov 2024 18:17:41 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%4]) with mapi id 15.20.8182.013; Mon, 18 Nov 2024
 18:17:41 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: catalin.marinas@arm.com,
	will@kernel.org
Cc: cl@gentwo.org,
	scott@os.amperecomputing.com,
	yang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: mm: support large block mapping when rodata=full
Date: Mon, 18 Nov 2024 10:16:09 -0800
Message-ID: <20241118181711.962576-3-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20241118181711.962576-1-yang@os.amperecomputing.com>
References: <20241118181711.962576-1-yang@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR13CA0038.namprd13.prod.outlook.com
 (2603:10b6:610:b2::13) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|CYYPR01MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: d9ae7aa2-ba32-4f81-11a9-08dd07fd4a25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NNdD+qhKXN8K9huuDaac2zdVldt7oYEdRkIhtlztDDHzvjN38q/FwEitsYyw?=
 =?us-ascii?Q?DBgagsoVaRWhsiO2r4qvsxRT7F7Uv/YWWTtWF5+ZEW83/GouCYWvchrxDVSU?=
 =?us-ascii?Q?HKWcL1GBKpwu2WnfzNkxv3jVGrWVHX6xh9aANJEIDE30cWEVc9Qytfx2BZuh?=
 =?us-ascii?Q?qZbwrwiS6XocMNBzaShTI65qdluV5+LvZt1F2FldKLKA8cPqEPNXopQlSXh/?=
 =?us-ascii?Q?XtpRNRCNOSWBFmU29O2t1T2q0JJJ5MhZiFcMNnkvVLYQZxasxD5swioLJYnh?=
 =?us-ascii?Q?8AFYmIw9DBgTKMQln3QF7cFLq/8bio4Vnyiy2I9+BjFkiVvjlWNGhys7oFrB?=
 =?us-ascii?Q?/kedhwMq+qJgWto58b00+6qvh7x3PFiSCs0uVL7twe+6ojEvzwFsEPOGjD6C?=
 =?us-ascii?Q?V6g6cxjE2EKcGcjGfH59BZMk40Dm4V85098xiuqeZJ5BXMxgshz3loLg/9EX?=
 =?us-ascii?Q?rVXzpDOOAWCJD30j8dsRXhGpST0J0FTKG2Z272yXy36VRKRXunlJOjua0uTu?=
 =?us-ascii?Q?CTBVfJMktXd77SeWDwmf/Uzk9+aTo2TRGjKmtqOoDD4xGMv9pkpes2Cxi4vU?=
 =?us-ascii?Q?FLxtp/fkBd3dbI4GebwU5LldLUCOeaH/J3Sy8o1KjrWXvnwpm0bVIgJNMa3V?=
 =?us-ascii?Q?W/ROlvq/AxljwWfiDWC1diof+caBAaot2gi9piGMyW0LWacXmV3vnnQd/UX4?=
 =?us-ascii?Q?zUzd1HA068mdfhVbCvcQLvSnnLqN/2uEtYqqYyyqqBGY7ZWubImGtuq4slKz?=
 =?us-ascii?Q?+eSw7Gs4SN5AUbIRhR8ViO3gMo/NqpP5gknh/nl4tFIscx5xID+cImBQWv2N?=
 =?us-ascii?Q?/H0UD8KHPEZYDL5GhTLOYyO4Rhdp8JH3NIMiedTXUOnPU9B6h1nFlLDGhd9n?=
 =?us-ascii?Q?dqYJ7OOmj+ZXcyGxXQx548hjnKef+v5aMr8O8+mF1UJ1z/TIg1eH2O5Koa9w?=
 =?us-ascii?Q?v0Mj9YcTGbPFgmfHb5EVAhlmGRkRZbWXd+8D4wnFgL2bw1mo45QrUgMV09in?=
 =?us-ascii?Q?+IVRT5oAHbmvL/H+UBShbjlULcIhdKcRIjxWkbmd7OjnpJnw3GHGEzY3r/hx?=
 =?us-ascii?Q?ki0pP2MsbYjTe7qe+w4cwkoWLYvenSUuA1/ECPQRc6m2vJdZFlb+wI79NfME?=
 =?us-ascii?Q?Y1N2PNncYUlPWmIkGdTecxUM8FG/A1lk/Wkboc9LdbICWoh1sNe2mmOq9vBG?=
 =?us-ascii?Q?Q97YIdg/SmZO+IlAPYac/YhjUKNvaJqt1kE6H9BcEPqMNXo8jPfaE6dBvwnT?=
 =?us-ascii?Q?dsfJ8Yj3SnSkSA+kC8l1SFS+nQ56NtaBPcxZMn9oIbmPG0Nspbwl0n91Qa3Z?=
 =?us-ascii?Q?VhC+A9Wdz/r/J6kU5O6mXSv1MSlHLhz8+cPtpRPj2sFkotSF+JpsWQ447zDI?=
 =?us-ascii?Q?i8QGgEU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CqXmBIjl/UmbgIdv40EP/zh6Feruc1hDlA52H7UsUH73b/DWOopun6lUDhMh?=
 =?us-ascii?Q?Yap/kR8pK26N3M7U/WyJvc6ZQSUgHf1iEMEwpPxhfwjFMurlPFQ6eE0HxP43?=
 =?us-ascii?Q?52U3dl9bdUQmETSjnRQpinjz5lKndAXykATIzv+i1QYJIKDuNEDyiPLZWjMr?=
 =?us-ascii?Q?lSXE9WYdxkHkWD2bXUvOdgbTfmbCkIkBLB0uW2rvq0JLPX9PM7wM8/tiX0hq?=
 =?us-ascii?Q?X8zDJhRFnESjLSr+0g62Ymw1KcZgxVRQEw0b0V13wM0plspbD6ZDUDftq7ri?=
 =?us-ascii?Q?8Lti8RGQZ/S2bsXZktRZPBGs9piEwhC5hDm8VKqO9chKP61bJpRpgGkbO3/e?=
 =?us-ascii?Q?VsYIMOUtQxUvVBDTxKMXlq8y9X3y2Wft2o/86zMp2GEeCsFPAOkd5j05tMss?=
 =?us-ascii?Q?I5qNVwiwccs0TKtMVJT3rX+rZsENC7mj1snI9qHvUgIInhZkpd+zfWwsrFof?=
 =?us-ascii?Q?Z+jb+KMa80NaZgIWRcwmRFoUl+uX+FHadMsuujja+qNXKbL27uLVWeyauZCw?=
 =?us-ascii?Q?W0idBAJpNlvEyjD/hoQGJbRMw3k3INo3Z6XCAvaOdDNbUImY/d01leFJCH4A?=
 =?us-ascii?Q?OyCyqb1Lxl76tezenwRHzWgl/DS5sXN4Dt936fwM/84G3rCp6NG9xfQdMtK9?=
 =?us-ascii?Q?iXCEncBitQ/vTszJwTq/9zqrHTSv8CloiArKnRIUHlVrrqsJbBUEOl/zJzDu?=
 =?us-ascii?Q?xlZe9bmQAHaHRWVHV93GN7VZ0gCSynIE/AMFBm0/ElzXLKCStiCW9J29x7KQ?=
 =?us-ascii?Q?XNN0ZRVhbEL1FSaVCxe24rEn8XMioavU4Qn33VXt7/Nb/lTxWtf6bDCQA/MN?=
 =?us-ascii?Q?2jKuVa3kCwVQw2D/qEBKw9veAfK+WgsIVkYjyhNieiOveg/n4FDgY5Xg3qOU?=
 =?us-ascii?Q?wPzypByzICSOTS42nnITDeu9IRPKDxaL1Y+yttFP3cwsUZY/rZWbfvqgww2x?=
 =?us-ascii?Q?SifoKDZXkvCAf+A+q+nBz6dhBg6LrWBBmMh+4EUJsaNiNa9z3Ne3+nrDnPwY?=
 =?us-ascii?Q?H4mTLuLrxy0a44kODdSp3Rg83zxP5ix+LziX0vvjQkwbXFxKKzviLdrYFs+C?=
 =?us-ascii?Q?Vj9kixChvTXPAKc5GbGCHqbzy64Gt2MyNioAQYZHf2cDPEPpgFS9Vx83sx42?=
 =?us-ascii?Q?L3t9YbrgxN3R8Ffj66Fto08jrKs9r+hzBC3K5HA/a2Rl8gVwQYTl/7O9j6/r?=
 =?us-ascii?Q?/XYTMVgcGlR2kphLTT6pvGKIOjOlL11h7g5jDciw/v0w/ICoMKxAiV5qdR7D?=
 =?us-ascii?Q?+Ypn7Tlpw45trFvEhcSLzIEE+r6Tpgl7p9AmPojIoDRzP4fua72wGecnM2SS?=
 =?us-ascii?Q?Y0bE1M+vslLZbdFWKsYFg9Ck0pmouBbFAme2G6QEdPRcyNApoezF0YEdM747?=
 =?us-ascii?Q?1ethZAAMLzTYf80ZpL1RhyGxwkx5cn5c+ElupFSBFQCoLvMiWZyNMofP61Ze?=
 =?us-ascii?Q?W3W5yTN+25KePm3l+E6gkdh1AoVYMZNOnLAaHGfkZhTNWIWF600FcZ0RAx1s?=
 =?us-ascii?Q?PLx3/ARZLKPsNm9nXSQWAqKekim8vJENd2zPuWQSgEqQ2GCYGDI1M6nHOn8y?=
 =?us-ascii?Q?GqpuwUdxQCDNb3rndhb77AxW9Hf296PYBV4JiRvrsv6t00Fq/rGGCGOBjn9B?=
 =?us-ascii?Q?7lsSHroiHVMEyheiCo41uzo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ae7aa2-ba32-4f81-11a9-08dd07fd4a25
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 18:17:41.0000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eWbMCbKLBaxUyVJZf+iDIn2/+PFtQhzA9cwV5S7GBdPajz2RtkSTvAimry7oDwliuEcOyaIwJX22CnenPTifwWsMnbIRqHBShv4tbENq8kk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR01MB8601

When rodata=full is specified, kernel linear mapping has to be mapped at
PTE level since large page table can't be split due to break-before-make
rule on ARM64.

This resulted in a couple of problems:
  - performance degradation
  - more TLB pressure
  - memory waste for kernel page table

With FEAT_BBM level 2 support, splitting large block page table to
smaller ones doesn't need to make the page table entry invalid anymore.
This allows kernel split large block mapping on the fly.

Add kernel page table split support and use large block mapping by
default when FEAT_BBM level 2 is supported for rodata=full.  When
changing permissions for kernel linear mapping, the page table will be
split to PTE level.

The machine without FEAT_BBM level 2 will fallback to have kernel linear
mapping PTE-mapped when rodata=full.

With this we saw significant performance boost with some benchmarks and
much less memory consumption on my AmpereOne machine (192 cores, 1P) with
256GB memory.

* Memory use after boot
Before:
MemTotal:       258988984 kB
MemFree:        254821700 kB

After:
MemTotal:       259505132 kB
MemFree:        255410264 kB

Around 500MB more memory are free to use.  The larger the machine, the
more memory saved.

* Memcached
We saw performance degradation when running Memcached benchmark with
rodata=full vs rodata=on.  Our profiling pointed to kernel TLB pressure.
With this patchset we saw ops/sec is increased by around 3.5%, P99
latency is reduced by around 9.6%.
The gain mainly came from reduced kernel TLB misses.  The kernel TLB
MPKI is reduced by 28.5%.

The benchmark data is now on par with rodata=on too.

* Disk encryption (dm-crypt) benchmark
Ran fio benchmark with the below command on a 128G ramdisk (ext4) with disk
encryption (by dm-crypt).
fio --directory=/data --random_generator=lfsr --norandommap --randrepeat 1 \
    --status-interval=999 --rw=write --bs=4k --loops=1 --ioengine=sync \
    --iodepth=1 --numjobs=1 --fsync_on_close=1 --group_reporting --thread \
    --name=iops-test-job --eta-newline=1 --size 100G

The IOPS is increased by 90% - 150% (the variance is high, but the worst
number of good case is around 90% more than the best number of bad case).
The bandwidth is increased and the avg clat is reduced proportionally.

* Sequential file read
Read 100G file sequentially on XFS (xfs_io read with page cache populated).
The bandwidth is increased by 150%.

Keep using PTE mapping when pagealloc debug is enabled.  It is not worth
the complexity.

Kfence can be converted to use page block mapping later.

Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 arch/arm64/include/asm/pgtable.h |   7 +-
 arch/arm64/mm/mmu.c              |  31 +++++-
 arch/arm64/mm/pageattr.c         | 173 +++++++++++++++++++++++++++++--
 3 files changed, 202 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index c329ea061dc9..473c133ce10c 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -750,7 +750,7 @@ static inline bool in_swapper_pgdir(void *addr)
 	        ((unsigned long)swapper_pg_dir & PAGE_MASK);
 }
 
-static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
+static inline void __set_pmd_nosync(pmd_t *pmdp, pmd_t pmd)
 {
 #ifdef __PAGETABLE_PMD_FOLDED
 	if (in_swapper_pgdir(pmdp)) {
@@ -760,6 +760,11 @@ static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
 #endif /* __PAGETABLE_PMD_FOLDED */
 
 	WRITE_ONCE(*pmdp, pmd);
+}
+
+static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
+{
+	__set_pmd_nosync(pmdp, pmd);
 
 	if (pmd_valid(pmd)) {
 		dsb(ishst);
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index e55b02fbddc8..09ccb4f8964a 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -620,6 +620,18 @@ static inline void arm64_kfence_map_pool(phys_addr_t kfence_pool, pgd_t *pgdp) {
 
 #endif /* CONFIG_KFENCE */
 
+static inline bool force_pte_mapping(void)
+{
+	/*
+	 * Can't use cpufeature API to determine whether BBM level 2
+	 * is supported or not since cpufeature have not been
+	 * finalized yet.
+	 */
+	return (rodata_full && !bbmlv2_available()) ||
+		debug_pagealloc_enabled() ||
+		arm64_kfence_can_set_direct_map();
+}
+
 static void __init map_mem(pgd_t *pgdp)
 {
 	static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
@@ -645,9 +657,21 @@ static void __init map_mem(pgd_t *pgdp)
 
 	early_kfence_pool = arm64_kfence_alloc_pool();
 
-	if (can_set_direct_map())
+	if (force_pte_mapping())
 		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
+	/*
+	 * With FEAT_BBM level 2 we can split large block mapping without
+	 * making it invalid.  So kernel linear mapping can be mapped with
+	 * large block instead of PTE level.
+	 *
+	 * Need to break cont for CONT_MAPPINGS when changing permission,
+	 * and need to inspect the adjacent page table entries to make
+	 * them cont again later.  It sounds not worth the complexity.
+	 */
+	if (rodata_full)
+		flags |= NO_CONT_MAPPINGS;
+
 	/*
 	 * Take care not to create a writable alias for the
 	 * read-only text and rodata sections of the kernel image.
@@ -1342,9 +1366,12 @@ int arch_add_memory(int nid, u64 start, u64 size,
 
 	VM_BUG_ON(!mhp_range_allowed(start, size, true));
 
-	if (can_set_direct_map())
+	if (force_pte_mapping())
 		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
+	if (rodata_full)
+		flags |= NO_CONT_MAPPINGS;
+
 	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
 			     size, params->pgprot, __pgd_pgtable_alloc,
 			     flags);
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 0e270a1c51e6..dbb2b709d184 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -45,6 +45,145 @@ static int change_page_range(pte_t *ptep, unsigned long addr, void *data)
 	return 0;
 }
 
+static int __split_linear_mapping_pmd(pud_t *pudp,
+				      unsigned long vaddr, unsigned long end)
+{
+	pmd_t *pmdp;
+	unsigned long next;
+
+	pmdp = pmd_offset(pudp, vaddr);
+
+	do {
+		next = pmd_addr_end(vaddr, end);
+
+		if (pmd_leaf(pmdp_get(pmdp))) {
+			struct page *pte_page;
+			unsigned long pfn = pmd_pfn(pmdp_get(pmdp));
+			pgprot_t prot = pmd_pgprot(pmdp_get(pmdp));
+			pte_t *ptep_new;
+			int i;
+
+			pte_page = alloc_page(GFP_KERNEL);
+			if (!pte_page)
+				return -ENOMEM;
+
+			prot = __pgprot(pgprot_val(prot) | PTE_TYPE_PAGE);
+			ptep_new = (pte_t *)page_address(pte_page);
+			for (i = 0; i < PTRS_PER_PTE; ++i, ++ptep_new)
+				__set_pte_nosync(ptep_new,
+						 pfn_pte(pfn + i, prot));
+
+			dsb(ishst);
+			isb();
+
+			set_pmd(pmdp, pfn_pmd(page_to_pfn(pte_page),
+				__pgprot(PMD_TYPE_TABLE)));
+		}
+	} while (pmdp++, vaddr = next, vaddr != end);
+
+	return 0;
+}
+
+static int __split_linear_mapping_pud(p4d_t *p4dp,
+				      unsigned long vaddr, unsigned long end)
+{
+	pud_t *pudp;
+	unsigned long next;
+	int ret;
+
+	pudp = pud_offset(p4dp, vaddr);
+
+	do {
+		next = pud_addr_end(vaddr, end);
+
+		if (pud_leaf(pudp_get(pudp))) {
+			struct page *pmd_page;
+			unsigned long pfn = pud_pfn(pudp_get(pudp));
+			pgprot_t prot = pud_pgprot(pudp_get(pudp));
+			pmd_t *pmdp_new;
+			int i;
+			unsigned int step;
+
+			pmd_page = alloc_page(GFP_KERNEL);
+			if (!pmd_page)
+				return -ENOMEM;
+
+			pmdp_new = (pmd_t *)page_address(pmd_page);
+			for (i = 0; i < PTRS_PER_PMD; ++i, ++pmdp_new) {
+				step = (i * PMD_SIZE) >> PAGE_SHIFT;
+				__set_pmd_nosync(pmdp_new,
+						 pfn_pmd(pfn + step, prot));
+			}
+
+			dsb(ishst);
+			isb();
+
+			set_pud(pudp, pfn_pud(page_to_pfn(pmd_page),
+				__pgprot(PUD_TYPE_TABLE)));
+		}
+
+		ret = __split_linear_mapping_pmd(pudp, vaddr, next);
+		if (ret)
+			return ret;
+	} while (pudp++, vaddr = next, vaddr != end);
+
+	return 0;
+}
+
+static int __split_linear_mapping_p4d(pgd_t *pgdp,
+				      unsigned long vaddr, unsigned long end)
+{
+	p4d_t *p4dp;
+	unsigned long next;
+	int ret;
+
+	p4dp = p4d_offset(pgdp, vaddr);
+
+	do {
+		next = p4d_addr_end(vaddr, end);
+
+		ret = __split_linear_mapping_pud(p4dp, vaddr, next);
+		if (ret)
+			return ret;
+	} while (p4dp++, vaddr = next, vaddr != end);
+
+	return 0;
+}
+
+static int __split_linear_mapping_pgd(pgd_t *pgdp,
+				      unsigned long vaddr,
+				      unsigned long end)
+{
+	unsigned long next;
+	int ret = 0;
+
+	mmap_write_lock(&init_mm);
+
+	do {
+		next = pgd_addr_end(vaddr, end);
+		ret = __split_linear_mapping_p4d(pgdp, vaddr, next);
+		if (ret)
+			break;
+	} while (pgdp++, vaddr = next, vaddr != end);
+
+	mmap_write_unlock(&init_mm);
+
+	return ret;
+}
+
+static int split_linear_mapping(unsigned long start, unsigned long end)
+{
+	int ret;
+
+	if (!system_supports_bbmlv2())
+		return 0;
+
+	ret = __split_linear_mapping_pgd(pgd_offset_k(start), start, end);
+	flush_tlb_kernel_range(start, end);
+
+	return ret;
+}
+
 /*
  * This function assumes that the range is mapped with PAGE_SIZE pages.
  */
@@ -70,8 +209,9 @@ static int change_memory_common(unsigned long addr, int numpages,
 	unsigned long start = addr;
 	unsigned long size = PAGE_SIZE * numpages;
 	unsigned long end = start + size;
+	unsigned long l_start;
 	struct vm_struct *area;
-	int i;
+	int i, ret;
 
 	if (!PAGE_ALIGNED(addr)) {
 		start &= PAGE_MASK;
@@ -108,7 +248,12 @@ static int change_memory_common(unsigned long addr, int numpages,
 	if (rodata_full && (pgprot_val(set_mask) == PTE_RDONLY ||
 			    pgprot_val(clear_mask) == PTE_RDONLY)) {
 		for (i = 0; i < area->nr_pages; i++) {
-			__change_memory_common((u64)page_address(area->pages[i]),
+			l_start = (u64)page_address(area->pages[i]);
+			ret = split_linear_mapping(l_start, l_start + PAGE_SIZE);
+			if (WARN_ON_ONCE(ret))
+				return ret;
+
+			__change_memory_common(l_start,
 					       PAGE_SIZE, set_mask, clear_mask);
 		}
 	}
@@ -164,6 +309,9 @@ int set_memory_valid(unsigned long addr, int numpages, int enable)
 
 int set_direct_map_invalid_noflush(struct page *page)
 {
+	unsigned long l_start;
+	int ret;
+
 	struct page_change_data data = {
 		.set_mask = __pgprot(0),
 		.clear_mask = __pgprot(PTE_VALID),
@@ -172,13 +320,21 @@ int set_direct_map_invalid_noflush(struct page *page)
 	if (!can_set_direct_map())
 		return 0;
 
+	l_start = (unsigned long)page_address(page);
+	ret = split_linear_mapping(l_start, l_start + PAGE_SIZE);
+	if (WARN_ON_ONCE(ret))
+		return ret;
+
 	return apply_to_page_range(&init_mm,
-				   (unsigned long)page_address(page),
-				   PAGE_SIZE, change_page_range, &data);
+				   l_start, PAGE_SIZE, change_page_range,
+				   &data);
 }
 
 int set_direct_map_default_noflush(struct page *page)
 {
+	unsigned long l_start;
+	int ret;
+
 	struct page_change_data data = {
 		.set_mask = __pgprot(PTE_VALID | PTE_WRITE),
 		.clear_mask = __pgprot(PTE_RDONLY),
@@ -187,9 +343,14 @@ int set_direct_map_default_noflush(struct page *page)
 	if (!can_set_direct_map())
 		return 0;
 
+	l_start = (unsigned long)page_address(page);
+	ret = split_linear_mapping(l_start, l_start + PAGE_SIZE);
+	if (WARN_ON_ONCE(ret))
+		return ret;
+
 	return apply_to_page_range(&init_mm,
-				   (unsigned long)page_address(page),
-				   PAGE_SIZE, change_page_range, &data);
+				   l_start, PAGE_SIZE, change_page_range,
+				   &data);
 }
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
-- 
2.41.0


