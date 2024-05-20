Return-Path: <linux-kernel+bounces-183982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2638CA0F2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 18:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D5101C20EE0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 16:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B070D13793A;
	Mon, 20 May 2024 16:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="rMvlXGst"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2120.outbound.protection.outlook.com [40.107.237.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB711CD39
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 16:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716224219; cv=fail; b=G6w2xXo1undAkKK/uuA9NMIxq/oZENcoFqrIx6IYccys7PueLtH/i+OhRXU3AjUEZCCr1cQr1+Un5hQeQ3IQvNy/tUU546b9sC23MYt9NrcLXlmqs6eLcm/wtN9zZb6Qs9oq8w7Gaq2jo4QDP8vr551svClvkugn0K2Cg9Viu70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716224219; c=relaxed/simple;
	bh=i93o8riTieRdYl5azCkfFmLIi2xu7OawpTUaqJUHZ/M=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PAWwIUQ0FzpjIFbWstKufSd6ka4cOnZvHeLnQ48lHaUiUpwlgfjUPiShKrMn3D3EFKtNFOJ2TOW1uBJj+mcdpcEGhOx0cDJ8ofSWC1vdd38fGRQPdTte5boRcL2nO+wx+BPnl3uMEp5X+HVJWDvJkrc4FOlCVSpItJCgBhDdxCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=rMvlXGst; arc=fail smtp.client-ip=40.107.237.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PkWMMxy3WTh1seB3MG+p6ZaLPIgfKT7inpmZ/dd5Pg/Ht43aWynK6ahvbqlHLrxbt82rbEzZuYQVLEucPKsrFp+I8LuiT1dD9IARKlVb50be8U9CR1iB6vqSFhNIpemG4djnQWbgYz1EKB3B99hdOOXiONDLhppLyxhtk+oOO2xhdaFVHs7Js8l8s6Z98//DPbpZ5Vh7SlpqlcCSvECD48TKtvQwS/RGWOroUZCbxuYaWfHT9N1D68Q6F6Mc229Zo3m0MU89qgrJhm7442W7jYGBtDALVX4VI+37t5HnxmGtjt8SWv1Mx8/M18kAEbobjAwnJJlb51lClcN3iWcncQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+Viu1N/haBIm9yQB84t2VpMMxz37y9cbV7/gCu0vjY=;
 b=Ozi8dmjZFy8p9fDdxpRjgOqnOUP70X9gYQ8C0PAxJcPwicr80udcxZxVsa8AxsU906VC/QiXzIdnMgwtGAW2PCv7FmtQVFNDzQt/MzqaCo8UNJjOz5u5ZXmpmishBfYyx2CAhtKOYyiH7cXdY/VgrRcP+o3w4X7eDihMnByZLbgB9bLHYE7TeMO3BncsvYnd8ZHyIy4+d+tQyC81UOTdVqCYzaVsBMIJRFjd7+jAWHMvteOP3LjXFt/XQrHpoLuSZjBCtFvu21YANNvjohwgXaivrpwxxKjZQFmiNdioH+PjERVULoxNT+GncMkvoG/MZ7NranLFpgHKsIzQmUy92g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+Viu1N/haBIm9yQB84t2VpMMxz37y9cbV7/gCu0vjY=;
 b=rMvlXGstLSeaBrGIAiFKvWhVx+tUs6/I4MIapZRi8Fw6pEuldpW4+DWucUoiOdKlNtOCCS6z7q9oFa5IUzaTDIFwrX0RqCoMoiCkEdHAJ2ePwFymM2AqkHBaHqdhM61HTdrOX85nwWmiPrVpsUBR9YkAAWly95Dnwtt4pj3/5xc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BYAPR01MB5463.prod.exchangelabs.com (2603:10b6:a03:11b::20) by
 SJ2PR01MB8008.prod.exchangelabs.com (2603:10b6:a03:4cb::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.36; Mon, 20 May 2024 16:56:54 +0000
Received: from BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955]) by BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955%4]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 16:56:54 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	anshuman.khandual@arm.com,
	scott@os.amperecomputing.com,
	cl@gentwo.org
Cc: yang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [v2 PATCH] arm64: mm: force write fault for atomic RMW instructions
Date: Mon, 20 May 2024 09:56:36 -0700
Message-ID: <20240520165636.802268-1-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR18CA0011.namprd18.prod.outlook.com
 (2603:10b6:610:4f::21) To BYAPR01MB5463.prod.exchangelabs.com
 (2603:10b6:a03:11b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR01MB5463:EE_|SJ2PR01MB8008:EE_
X-MS-Office365-Filtering-Correlation-Id: 525e9039-e274-45b2-eec5-08dc78edda0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|1800799015|52116005|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AGzNzw1nV8tJNQjK3LLKL2NnG7dwd4IcO9FGdlOnasSizjtNNDoHY/JMBNsN?=
 =?us-ascii?Q?ho4EsKMBRLmz/Ut0GFO12ffRVv+SZrGCGqLS9rLd1ijpKk1HapCfBAfUFqTd?=
 =?us-ascii?Q?Kr7OCnZhPXTBGnGjNHvz+BgRiay6jFTOrndVd/Bkvc+Y008Czk0usArMS1nt?=
 =?us-ascii?Q?/9IFJzitZX1u8TKg+oeV+BB09KKi5DvjzqHhmAD+zJB82sSfpPYxdMgupSH6?=
 =?us-ascii?Q?/7GoVQGxkrJnT9kcD27e5nifK0iuY7SNzYc9irX5zaSwb8/MrzElZrXpgPa0?=
 =?us-ascii?Q?MYzBMOIO2yy3KtGEs+l9P+fEtdYNcvoZJdh5gSfAdV5xjAWkECOb9r0uh1vr?=
 =?us-ascii?Q?N7vKmSK+0Kq71fVxc6GXd6cAjy6hwR99KCsuIN72jl0qNlz8MXmyZlk9diVd?=
 =?us-ascii?Q?kxYMsVw1PiVUN4tkFV+KGDbXSN1v4XjjeF8yp6F0HYrTNzJPVZ+/VkEiCfet?=
 =?us-ascii?Q?GmtBjitcufNxIsrbD6wld3jvstBWcoi/x+swAFeiRx+JIULfRQdnQUd9o3Ly?=
 =?us-ascii?Q?lHO9jN2qa5Jim+vDBDQHs3pr4Xbb8au23GENm9P9uhSrW3J19VVOC/MisD5m?=
 =?us-ascii?Q?zLmKYKbpJu9NipCJfTxwQjQQq2yyk6WGkCOOeEmUb8PiGXsyys4Ax3lxI0fW?=
 =?us-ascii?Q?KU1f9pyx5JhA5ZNeIZvo7Bi5Vehz1N4OVmX799wDAPx+MuemC+E8fdUDlzyn?=
 =?us-ascii?Q?uzk+fBT7B3Ijb5Gwlghyc3e62H5p6/GvIO33pSdDdNyLZ2vLQqIKcetMr/Cx?=
 =?us-ascii?Q?WkXvBngRr7cQo0NzQRU3V6T0POzJMUoOKBw9zsuXjTIab196elIrBejsCLn9?=
 =?us-ascii?Q?QKK1gx0Yk1nq7Y+y8jqADXnxBRUFZ/50c2slyw4iyk+CT6qVrZHa2RgUVmiu?=
 =?us-ascii?Q?M5luhHf0pyqXCozx3AUgC1Td1cHRD8ypYdGtB+XsKxoiTaukZTGoSv7Sp45I?=
 =?us-ascii?Q?VDX/A96nuElO74SU4NedLmN9zyXyQ5Hbf3wJN3A7Np/AtGD5EclUqkW/ZOrg?=
 =?us-ascii?Q?zYwx5uAM3KZ8/VwG8cSUjddPm7nyHZysoqbDuCykvdXR0ttgAhac9Wg3/dk+?=
 =?us-ascii?Q?7MsUfwCmezoSProjteSRhPxVfsC+CHHhRMAYndu/lo0NGeC2hJaLkGtL4Tsz?=
 =?us-ascii?Q?emUYENZSjW9bjAFs2capR5XLSHzX588LixAydn6ipA6SSzVdm7gKsmESHT7v?=
 =?us-ascii?Q?L/jg/9dCBVCHZzKL0g9VzuwSxSgY4r/LygFS3AIPbcWCs4SHtlz65IkSKFca?=
 =?us-ascii?Q?p3u6cJCiBRU5CozGwH+njauql3hfnqmx6pUBdsxwrpgk7Gp0L8B5M13kGbUo?=
 =?us-ascii?Q?O+EEtboaV1x9Q1AJOMRMCUia5VzD0OB9fwZ13tAEgBYi8Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB5463.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oJw3SgbBZGiGSw4aj2kbo8zKjCRY5wbDqQrHPS1gZjKefS0nmc5njppz7mn8?=
 =?us-ascii?Q?RhxrK2A1FdgE0Wx6mvn6CziqEW4LFujR9Ccr32BA2oQP2ARMRHj5u3/FUu5+?=
 =?us-ascii?Q?/MxInA48BuL7NwG0WQ0GeM9qERU96ACI/6rHrHE9WG4MoQWbNM8fWJ6aahfl?=
 =?us-ascii?Q?R2ybMdRKLI2AvCAVIAGgRJx6RWehk7GFOZ4i8eQNQi95fJ9nlr9hlQqqL4cl?=
 =?us-ascii?Q?3cRym0HlLD9FycXAredQ19Wy5rIZ1KQrYWfNHpHgjDbKZIAtwvweTtr3Gsti?=
 =?us-ascii?Q?R81uX9tTMgY0sx8X2JPQLzy4DXTuuqybrtO5UeX5d4KtxfRXs6CC+rhMVkZf?=
 =?us-ascii?Q?xg/rLz3de9BSHHQN9qwxpp/7ZhBkq0ozGa0JneRqCYMrEWGg6KWaViJUBs0c?=
 =?us-ascii?Q?0BtsSJbNEOIZfCYk54hc8d8KzpcMZB4EPbMO9CXrCpFHgoRB0IO5i+0UQX6F?=
 =?us-ascii?Q?3alAFSKggMOofubh6a49gr5Tcy1wZmUSHGZdQk+RRTNV6toqz27gCzC4uO+r?=
 =?us-ascii?Q?oc70Gmj1A/Ztsm0LXusHkgtA1mA4RZSw4jnnbGjm/SzCwXdl2j5/YsJN4IW/?=
 =?us-ascii?Q?c9cEEnTALyy0iWVI3H9tZ8yJrFmT59t6BgNq/HS1KTncq6UCxFbfw+/iAG9i?=
 =?us-ascii?Q?xyHeV1Jopb2edwuLIVBY5AiCxn/lRa1h8o0bfCcNH8m9R3q/7VnO+kThzgLM?=
 =?us-ascii?Q?rZ3wJ8KReEoQRUWZNeFPVmncVcl/ilOta2s/yRCcga2Xvb8ZZ/P4YCI0R2QM?=
 =?us-ascii?Q?n+gDnsGmk5PZV477Qnb3rg5IMoQzXBddmLZfBE2XuC4iQLKPHdYDBxJHtTRk?=
 =?us-ascii?Q?krRK6Mm/e8s7ltsgK/YUA5N12jOiuy0oKuoVumfd56Qyv/Qr5jfStri6FLc8?=
 =?us-ascii?Q?g2NGAZWpsCh5NNjigbP0dol/Ow8C906ZiBv5GuGlP/jCTavqDzzXorl8txIp?=
 =?us-ascii?Q?yvnFMwyIZIuey+aZdxy5XB+uM7OOvnqlTRtL4BPUWWxkkm+haWQwhIH8NsVm?=
 =?us-ascii?Q?In2QOSvPv/bPn2E3IwaXRcAjCJ8TcD9GGSwuHHemQssJOZbjeqshPI1o3PxD?=
 =?us-ascii?Q?6cbweg8VLvdL8HUmVPD3ygTK7v9lCogXPzZBxqVBHvXWQOMCsLgcwBivX/XT?=
 =?us-ascii?Q?hyOhPy8pFJE60iuBs0f/e26j1Gd5wz15IGb5MeXHSIYtfMSp6Yebq+HIjVQP?=
 =?us-ascii?Q?aHJhad08ykUGKlk1v86U7Z2Kcx6cTCAwPypxj+6sm684lGRytEaM/z3lXP23?=
 =?us-ascii?Q?ZHqw8mEF+Yr6gkcmjP9c1ohiTj5F/HyLVJAQRwvgO3HvNc8Wvw1pNhJek5XB?=
 =?us-ascii?Q?HfkyVWscGuKywHKUrHfxYhSJufGx2pIrIkgJrfvBeQxXGqEpb5Ri7c21b0dn?=
 =?us-ascii?Q?g5NdchRh6tSuH+IMUrUd8MA0cVCgNXusS3YcpncTXfqZk9LpjyJhT3mgwPSO?=
 =?us-ascii?Q?qhcKyIZo4l18ZrX3aNrIntBy88koDMwhJF4am7DEHmQG0bpXpCLWnAEdBdDl?=
 =?us-ascii?Q?iX5SIqYEgjJaYCg02Q2P9efKGTvI83gkrgojXnOu8CiT1XGZYa45ZniNAZqN?=
 =?us-ascii?Q?Q6JHLEQJfr8KrXljJkOckoDpzvxXU5ufQooxF2iorjt0rbONHIulDf/OL423?=
 =?us-ascii?Q?0yymO7I3I4sLkaWkIxnuZPU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 525e9039-e274-45b2-eec5-08dc78edda0b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB5463.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 16:56:54.2659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eo0ub764BuEpAYw9+cZUuFlZ+dZl2WSlammiTuyejCpPQ8fYUV1WwpMLCBMrvZ6RkBsJr85b6skfVZZTK6igiPqSUzg+MIqVS/VUzZTVOGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8008

The atomic RMW instructions, for example, ldadd, actually does load +
add + store in one instruction, it will trigger two page faults per the
ARM64 architecture spec, the first fault is a read fault, the second
fault is a write fault.

Some applications use atomic RMW instructions to populate memory, for
example, openjdk uses atomic-add-0 to do pretouch (populate heap memory
at launch time) between v18 and v22 in order to permit use of memory
concurrently with pretouch.

But the double page fault has some problems:

1. Noticeable TLB overhead.  The kernel actually installs zero page with
   readonly PTE for the read fault.  The write fault will trigger a
   write-protection fault (CoW).  The CoW will allocate a new page and
   make the PTE point to the new page, this needs TLB invalidations.  The
   tlb invalidation and the mandatory memory barriers may incur
   significant overhead, particularly on the machines with many cores.

2. Break up huge pages.  If THP is on the read fault will install huge
   zero pages.  The later CoW will break up the huge page and allocate
   base pages instead of huge page.  The applications have to rely on
   khugepaged (kernel thread) to collapse huge pages asynchronously.
   This also incurs noticeable performance penalty.

3. 512x page faults with huge page.  Due to #2, the applications have to
   have page faults for every 4K area for the write, this makes the speed
   up by using huge page actually gone.

So it sounds pointless to have two page faults since we know the memory
will be definitely written very soon.  Forcing write fault for atomic RMW
instruction makes some sense and it can solve the aforementioned problems:

Firstly, it just allocates zero'ed page, no tlb invalidation and memory
barriers anymore.
Secondly, it can populate writable huge pages in the first place and
don't break them up.  Just one page fault is needed for 2M area instrad
of 512 faults and also save cpu time by not using khugepaged.

A simple micro benchmark which populates 1G memory shows the number of
page faults is reduced by half and the time spent by system is reduced
by 60% on a VM running on Ampere Altra platform.

And the benchmark for anonymous read fault on 1G memory, file read fault
on 1G file (cold page cache and warm page cache) don't show noticeable
regression.

Some other architectures also have code inspection in page fault path,
for example, SPARC and x86.

Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 arch/arm64/include/asm/insn.h |  8 ++++++++
 arch/arm64/mm/fault.c         | 38 +++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

v2: 1. Made commit log more precise per Anshuman and Catalin
    2. Made pagefault_disable/enable window narrower per Anshuman
    3. Covered CAS and CASP variants per Catalin
    4. Put instruction fetching and decoding into a helper function and
       take into account endianess per Catalin
    5. Don't fetch and decode insn for 32 bit mode (compat) per Catalin
    6. More performance tests and exec-only test per Anshuman and Catalin

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index db1aeacd4cd9..1cc73664fc55 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -319,6 +319,7 @@ static __always_inline u32 aarch64_insn_get_##abbr##_value(void)	\
  * "-" means "don't care"
  */
 __AARCH64_INSN_FUNCS(class_branch_sys,	0x1c000000, 0x14000000)
+__AARCH64_INSN_FUNCS(class_atomic,	0x3b200c00, 0x38200000)
 
 __AARCH64_INSN_FUNCS(adr,	0x9F000000, 0x10000000)
 __AARCH64_INSN_FUNCS(adrp,	0x9F000000, 0x90000000)
@@ -339,6 +340,7 @@ __AARCH64_INSN_FUNCS(ldeor,	0x3F20FC00, 0x38202000)
 __AARCH64_INSN_FUNCS(ldset,	0x3F20FC00, 0x38203000)
 __AARCH64_INSN_FUNCS(swp,	0x3F20FC00, 0x38208000)
 __AARCH64_INSN_FUNCS(cas,	0x3FA07C00, 0x08A07C00)
+__AARCH64_INSN_FUNCS(casp,	0xBFA07C00, 0x08207C00)
 __AARCH64_INSN_FUNCS(ldr_reg,	0x3FE0EC00, 0x38606800)
 __AARCH64_INSN_FUNCS(signed_ldr_reg, 0X3FE0FC00, 0x38A0E800)
 __AARCH64_INSN_FUNCS(ldr_imm,	0x3FC00000, 0x39400000)
@@ -543,6 +545,12 @@ static __always_inline bool aarch64_insn_uses_literal(u32 insn)
 	       aarch64_insn_is_prfm_lit(insn);
 }
 
+static __always_inline bool aarch64_insn_is_class_cas(u32 insn)
+{
+	return aarch64_insn_is_cas(insn) ||
+	       aarch64_insn_is_casp(insn);
+}
+
 enum aarch64_insn_encoding_class aarch64_get_insn_class(u32 insn);
 u64 aarch64_insn_decode_immediate(enum aarch64_insn_imm_type type, u32 insn);
 u32 aarch64_insn_encode_immediate(enum aarch64_insn_imm_type type,
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 8251e2fea9c7..73f954fcb8c7 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -519,6 +519,30 @@ static bool is_write_abort(unsigned long esr)
 	return (esr & ESR_ELx_WNR) && !(esr & ESR_ELx_CM);
 }
 
+static bool is_el0_atomic_instr(struct pt_regs *regs)
+{
+	u32 insn;
+	__le32 insn_le;
+	unsigned long pc = instruction_pointer(regs);
+
+	if (!user_mode(regs) || compat_user_mode(regs))
+		return false;
+
+	pagefault_disable();
+	if (get_user(insn_le, (__le32 __user *)pc)) {
+		pagefault_enable();
+		return false;
+	}
+	pagefault_enable();
+
+	insn = le32_to_cpu(insn_le);
+	if (aarch64_insn_is_class_atomic(insn) ||
+	    aarch64_insn_is_class_cas(insn))
+		return true;
+
+	return false;
+}
+
 static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 				   struct pt_regs *regs)
 {
@@ -529,6 +553,7 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 	unsigned int mm_flags = FAULT_FLAG_DEFAULT;
 	unsigned long addr = untagged_addr(far);
 	struct vm_area_struct *vma;
+	bool force_write = false;
 
 	if (kprobe_page_fault(regs, esr))
 		return 0;
@@ -557,6 +582,11 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 		/* It was write fault */
 		vm_flags = VM_WRITE;
 		mm_flags |= FAULT_FLAG_WRITE;
+	} else if (is_el0_atomic_instr(regs)) {
+		/* Force write fault */
+		vm_flags = VM_WRITE;
+		mm_flags |= FAULT_FLAG_WRITE;
+		force_write = true;
 	} else {
 		/* It was read fault */
 		vm_flags = VM_READ;
@@ -586,6 +616,14 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 	if (!vma)
 		goto lock_mmap;
 
+	/* vma flags don't allow write, undo force write */
+	if (force_write && !(vma->vm_flags & VM_WRITE)) {
+		vm_flags |= VM_READ;
+		if (!alternative_has_cap_unlikely(ARM64_HAS_EPAN))
+			vm_flags |= VM_EXEC;
+		mm_flags &= ~FAULT_FLAG_WRITE;
+	}
+
 	if (!(vma->vm_flags & vm_flags)) {
 		vma_end_read(vma);
 		goto lock_mmap;
-- 
2.41.0


