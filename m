Return-Path: <linux-kernel+bounces-201144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D748FBA1A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00012B24FB1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C2E13D269;
	Tue,  4 Jun 2024 17:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="QsQmKMky"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2090.outbound.protection.outlook.com [40.107.92.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B118713CFA3
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 17:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717521339; cv=fail; b=DGyWm/vnvUQO1WanEzHj17es4mpax5fVdNHgPNfRyqQ11tg8LjQVHPz7OPCc4UqFbpOgyqHRm4CgtU/fiCftw9I09y0Rz0kcVYTCYm+3ykvvcb9+8mXUMYhP9K+ngspFj6Se3XcoFIEk96hWlHwzuzhMFyiDtagwgPFr0ULcdQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717521339; c=relaxed/simple;
	bh=JkyH4vc8nuuMJ0vJeL/g/PwxqKKNgE9H7HuYOO8r5Fw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HCaSHVygcNY5BG1y+1lOxLFgdSi1jg1re587+JbazYola2fWx9p2O+uX37kei++6FzBT85zRcsmUf6KCUgmq88XwiFZ4GKuaaKDuOCj5pUEKwwpxMnK3zVMmyZhTOchhpx/JBlvS6ol0ZY9MPSVvw8CL62pjwj3leQzAQJc7lVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=QsQmKMky; arc=fail smtp.client-ip=40.107.92.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmaVthWn/FvPL2lLmSbi9f/q2etG/nnxVHlFCQlSlUhG8kI6Hvw1U9Hs1gm2CFrq1lyhmMXPwA1QQpwa0f7RmANOJtLZbWW+WlNUpkXqj0VuvW4NK00D/7/nq2FzvP9vzwEn6m1meSW95eXlon28tyfNMarlkW0KHwICZPvXWvWna1oJfkNOKBZUpVtKIT249rDaqZE0+XDdGB8XjXWsCjHdhBlXBusFKZmrXgnG5gvy18KgdEyFz0mhGLcWcxU+nm8HJsTT4AXZNpWtoG3FF41J6DueMPE38g1FDioAvr0PYh3dHgRKXicAXFzYQX6+lRb7b4cqr0qqQadnHO4CfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQmukWzNDbyQo+bJWBZJDNKMXkcVz6KzmFuoLrFxs4o=;
 b=LtbRuM9HiFWkHTb9cfKqFCoErXcAbv7RNRU+1yaP8Q1xG+07SJt2Ux7nj0mjSRHuQBxPooM8bv8Y5i7tFj1D7UT1P/0ZcmBzZkjXlg6oqfH0QEmiSrd/r8wpw8e5fvvovfY1en4gP7bWUKwgtZvJ1UpH7Kwdcik5AfKEWdMSG70PaRlF09ONuEnXcFQ1XKAXwu5UpztXrvWJVbW5a7H93/EBhZ2OxD1R7SsYxHT/fZeNrA0Gf6UhOkbpsQ0Nr6oX0fHXUa3Ja3ICo2tBji1gfZfgblRsR+u3/OYre7QbQ3yh+f5kQZ+dG4VEtjfoulzGxLKpbijy5Eu5OvvS0Tvxwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQmukWzNDbyQo+bJWBZJDNKMXkcVz6KzmFuoLrFxs4o=;
 b=QsQmKMkyqsixFf9CRbzIWpp4CQAZb+/rtWSOHgPVoEbEZ/75tDNPnqfApc28daHgzMiqbBrr0rHBgsKTRWsWy7MOtE8oytwG2WMEN6HnvLL5eV7wGACBbeMOk5J2a7HcI24rDn1S/1Cc2cYS3qvkILMbcWxbPHhfWkqR22TExu0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BYAPR01MB5463.prod.exchangelabs.com (2603:10b6:a03:11b::20) by
 PH0PR01MB6488.prod.exchangelabs.com (2603:10b6:510:18::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.27; Tue, 4 Jun 2024 17:15:32 +0000
Received: from BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955]) by BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955%6]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 17:15:32 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	anshuman.khandual@arm.com,
	scott@os.amperecomputing.com,
	cl@gentwo.org
Cc: yang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [v3 PATCH] arm64: mm: force write fault for atomic RMW instructions
Date: Tue,  4 Jun 2024 10:15:16 -0700
Message-ID: <20240604171516.2361853-1-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY8PR19CA0018.namprd19.prod.outlook.com
 (2603:10b6:930:44::15) To BYAPR01MB5463.prod.exchangelabs.com
 (2603:10b6:a03:11b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR01MB5463:EE_|PH0PR01MB6488:EE_
X-MS-Office365-Filtering-Correlation-Id: 62318e38-9772-4c36-99f1-08dc84b9f086
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|1800799015|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZdC1MRyPD1HR6/Cb36HqSLGIj3krWuzQffWHgQ7RSt1zZGjbjL4n5lVlaBBm?=
 =?us-ascii?Q?MRWBSNMhdItVNNk6ul2+O7VbWnKi0pcN80+P0DfNEg3XHrwDS4nmnHSU8KpM?=
 =?us-ascii?Q?KLg0S0imGQU0Yzd/srg7hj4+fvRttFS7z/BIdA1wMyBfB2QL8ri5VcC8QB75?=
 =?us-ascii?Q?ysdNvYh8MfYGVauprbd/RkrRQxhVQ1xS81TCA90E5tk+y1kDGG4gweDxZmYG?=
 =?us-ascii?Q?tS91I8F9EyspW49XnO4A3KfhzpgiQurIuFpfggn/USwQJbAQSs3ogpMigGwa?=
 =?us-ascii?Q?tgbqedpkm6xYuIzfy1o3jUzqKYIWsGdfenq+New0jlqWMD9/13To/uZHpA5X?=
 =?us-ascii?Q?ZQyyMi8WY0TAqpH1rngHYBcqKBEFlMKRrDEdvZimWnCkV0EopJuTq0/SrW5N?=
 =?us-ascii?Q?xlcetIEvzV1RshNJiXzqUDg23eV7zkz5LGdiNH/KRwEJdOSSLHozgjWHW0mW?=
 =?us-ascii?Q?6sBLj5LC3r8hu/GpTONXjYCCR7o8Nd2Tt+ELLQzjw9A0K/CSlJcgAZi5a2Y2?=
 =?us-ascii?Q?2fJgGw8PhfWitGNIqUcM8FD5E6l7969g0I5Q5Px3f25kGHYvs3yX/YBCbb5Z?=
 =?us-ascii?Q?jJ6KsjpWDwUS/kHgUKhOaOLBwug3gWcNCaEQaczulDFOE5jxWBlpB+8B+GLp?=
 =?us-ascii?Q?bM2CTUHdmg9VyVQqRkPnnnMxW3fExfYSg+okn1lLkC72Virz2RrpNJugCsw3?=
 =?us-ascii?Q?d4l+ldPxLg+siuwWmZsWkyCHLWUrrYaQrcuKXrN9g7HZ1IGVZR0WBZWH0mri?=
 =?us-ascii?Q?d9aH/FRxi0dD7x2MykcZUGxfGo0RDoD7NPNPz3zUAClKc6717wymXKQm4PjW?=
 =?us-ascii?Q?6mKDu0dWSpbSg+DzOpzJslbob56GBPwOBopBEqFkRSsDuZjF+Oh6+pZaF/b1?=
 =?us-ascii?Q?35++r4lOQlysQpkP23hqbCoHQ/VEvqkR5jwyLUAa9Uc8d/wdmAdLFSK5VO5s?=
 =?us-ascii?Q?cbiH7JzMnQL/EGGsGad5yXoEwJUzTBJzON4HnfNxJCEV/fMflsEzb14WA+o3?=
 =?us-ascii?Q?F/InnJo7qyYUKyCYscwm3MGNmSuaaKntNE699bqpc0L/Y54E1bg4GOhgc1Rb?=
 =?us-ascii?Q?5N9sP0zF1pzwO2JyiVyT4mzgMEyE7xj9z+5um1yRuEhVYzt0OSeyQi7V+t3b?=
 =?us-ascii?Q?hA0l/ZQVTh4l4Nw4y67eZpRHn9KAmMWHm/KXXxGVlWsXmTh/vPYOeajCKTXD?=
 =?us-ascii?Q?5jEmNf5wHD9CFm/hw5+IwNTdaCWoiQesxqbHbJa28kBc+U1YwTQT8FlitNXs?=
 =?us-ascii?Q?ea37qNaAh2kXXhbQ/p1DKeDD0Pbhk3plN2fvSK554uv3WK9xKFMb8YW+3bi5?=
 =?us-ascii?Q?yMaRPGkGIWqiYnj3W8esifhtcMujoA5B6pd6sOSQLBVpjg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB5463.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h2BqOBBAC0RVWGV0Xplv4FeRbJGM/ZNzCR0137GbJirVcy8xrgq//VLeuUvi?=
 =?us-ascii?Q?9L7SbPQKgxqhE28/YhiVIfL8uT6NU2EEt7v/TjIkTcMWfUoRbYVvS+mWD50O?=
 =?us-ascii?Q?Uqqsb+ma95U4ORYYyCp5/AbRE4gnzYJdg29NMYZP+b33AERVU5bQ7gZWldHv?=
 =?us-ascii?Q?EWew0LL4jLaN8chsg4Pt5BwTA54uy71t9Dar9BrVCQZTALz4L1lEy6XHr3KD?=
 =?us-ascii?Q?HIrfxlxeDktX/Y5JT20qnhtqwLi8Bo1E9tSH1h9/+OLCd51MIdUKSl25EAfG?=
 =?us-ascii?Q?m0icfuA207P8OMNcvLi2ulugMjoNtXOmh39l04IjBh9rJx8JgOIHppZUZmOE?=
 =?us-ascii?Q?IikEq0yMangO7moT+DN2JQ9hUhhjJLqtVJEVE/WYdqSs8Wm5b5Ofg+UL7bJX?=
 =?us-ascii?Q?ibMcc4nyqPmQ+mOm5Rd2dvXWjbroICyhINMzTrqGeOE79YyC+32kRA3tVRvf?=
 =?us-ascii?Q?M2TWAGLZysqcZiAlOl/7rNos5YeJeH2RTRl7h10oPAc0+qJKMkLTI1oH28zG?=
 =?us-ascii?Q?uU4t0HZ9jOd7rze6jjQvR9IOWgJOFuAKKyjKGAIwUmmWl9Mond665pk06mZk?=
 =?us-ascii?Q?dlNK7T9KHe7qni4V1EBMZF0x9I43umDOa3CXhQ+xduf/mDpYdZsYi2hEDP9E?=
 =?us-ascii?Q?XAoVeMUDXnEp3U1x3XZf4XTc1U7Upe+TIAm6gwWj4sCtWU4dT24+GaW3dXX2?=
 =?us-ascii?Q?uxukZWmnbkqYF4UsNzFHviLYbpaoP/LqTEtBeGGDZ8KEL2iVui5C0ZQ0ziFv?=
 =?us-ascii?Q?vZEHcS6OnUp8oyCVPi0NKzsQDmAYgaci+Mj6L6BjWQEV2m7mmlxkP2OCZY3L?=
 =?us-ascii?Q?pYpxC3mCk/3vs7P8/SlJqtMFDU0N3GIGgg10diVzxN44SAWR+PvJ5PGdVNwz?=
 =?us-ascii?Q?q0TIAD+4A0T/WP6HmhO+11M4P/LSwejisGmGXBM6ccfO65dmLdSVNRxw/S2C?=
 =?us-ascii?Q?SaTiSwhULe7tbuHZxkDCz4WBFFcKPO1Ru8ZWjKce2aXkiJTiiTZwDmIjgcSx?=
 =?us-ascii?Q?M476NYMwWNYFTqzvNqkZrnLQzW9H2lsqSyYNZWqOzg1W7Ks2xF1Lu3y2iORU?=
 =?us-ascii?Q?q+L6gIs5zcPgIVc3yC87XzpF1aN9nhiycUkzPDzGuYXSNDjAGZb2crPrCJYo?=
 =?us-ascii?Q?AVK0Kzcq63cDpnUuSrhNLPwPBhC38Kmgo2Z/6Ca5Ijzslmx/KDtb3Nj0rP/N?=
 =?us-ascii?Q?fJxvIb8ijU5eqjQLz6BZp+Y29L68UqH6fM82UqCGSmTMlwp1NeGjsPgnBAh4?=
 =?us-ascii?Q?QZq61xVles5yVj/orPB81Y1gLVWiMmZVcWykL6r8RnLSPt594ijGv3EB3cgR?=
 =?us-ascii?Q?93FxFzwg0gtS/UpD3ZJIwbLmNB1fEcsobDzpnZ13GjjMvu3NfJ3WVCW61mKc?=
 =?us-ascii?Q?wrPbKrjLasD5Tf8t9tYW2ePAHEXfmmhl40GhJD1aIoioadhrVpgVf3HL1lwx?=
 =?us-ascii?Q?nCOu4y4I6lHfKKi95FpVat/3kHVON2y/PjEz5I1nWcWeb+ofIalNw4+bTjvI?=
 =?us-ascii?Q?HZPVmj6KXrIs/ib2OpzO4u75rQThrQIy+R+DeYxQagNADzHcZoeeiW9l8y42?=
 =?us-ascii?Q?1uQhwrBiHm5A2aq67hL1LPM9Snx3PlC2qzhUhz3ea9Pw4Vn0pVqTDvm2txhc?=
 =?us-ascii?Q?hGPt0AiN5jvN8QYIRHzttgw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62318e38-9772-4c36-99f1-08dc84b9f086
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB5463.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 17:15:32.1482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pszHGD1KJMhQoelNWW/WnfZFnvC75ACuvHfBMQFjpAHS8JjWFLJcLBDF0L0o+/4H0ngr4P3n2qkshFeELmHFKyeDpdNLNJKcbkaySPLwtIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6488

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

Exclude unallocated instructions and LD64B/LDAPR instructions.

Some other architectures also have code inspection in page fault path,
for example, SPARC and x86.

Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 arch/arm64/include/asm/insn.h | 17 ++++++++++++++
 arch/arm64/mm/fault.c         | 43 +++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

v3: Exclude unallocated insns and LD64B/LDAPR per Catalin. And thanks
    for D Scott help figure out the minimum conditions.
v2: 1. Made commit log more precise per Anshuman and Catalin
    2. Made pagefault_disable/enable window narrower per Anshuman
    3. Covered CAS and CASP variants per Catalin
    4. Put instruction fetching and decoding into a helper function and
       take into account endianess per Catalin
    5. Don't fetch and decode insn for 32 bit mode (compat) per Catalin
    6. More performance tests and exec-only test per Anshuman and Catalin

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index 8c0a36f72d6f..4e0aa6738579 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -325,6 +325,7 @@ static __always_inline u32 aarch64_insn_get_##abbr##_value(void)	\
  * "-" means "don't care"
  */
 __AARCH64_INSN_FUNCS(class_branch_sys,	0x1c000000, 0x14000000)
+__AARCH64_INSN_FUNCS(class_atomic,	0x3b200c00, 0x38200000)
 
 __AARCH64_INSN_FUNCS(adr,	0x9F000000, 0x10000000)
 __AARCH64_INSN_FUNCS(adrp,	0x9F000000, 0x90000000)
@@ -345,6 +346,7 @@ __AARCH64_INSN_FUNCS(ldeor,	0x3F20FC00, 0x38202000)
 __AARCH64_INSN_FUNCS(ldset,	0x3F20FC00, 0x38203000)
 __AARCH64_INSN_FUNCS(swp,	0x3F20FC00, 0x38208000)
 __AARCH64_INSN_FUNCS(cas,	0x3FA07C00, 0x08A07C00)
+__AARCH64_INSN_FUNCS(casp,	0xBFA07C00, 0x08207C00)
 __AARCH64_INSN_FUNCS(ldr_reg,	0x3FE0EC00, 0x38606800)
 __AARCH64_INSN_FUNCS(signed_ldr_reg, 0X3FE0FC00, 0x38A0E800)
 __AARCH64_INSN_FUNCS(ldr_imm,	0x3FC00000, 0x39400000)
@@ -549,6 +551,21 @@ static __always_inline bool aarch64_insn_uses_literal(u32 insn)
 	       aarch64_insn_is_prfm_lit(insn);
 }
 
+static __always_inline bool aarch64_insn_is_class_cas(u32 insn)
+{
+	return aarch64_insn_is_cas(insn) ||
+	       aarch64_insn_is_casp(insn);
+}
+
+/* Exclude unallocated atomic instructions and LD64B/LDAPR */
+static __always_inline bool aarch64_atomic_insn_has_wr_perm(u32 insn)
+{
+	return (((insn & 0x3f207c00) == 0x38200000) |
+		((insn & 0x3f208c00) == 0x38200000) |
+		((insn & 0x7fe06c00) == 0x78202000) |
+		((insn & 0xbf204c00) == 0x38200000));
+}
+
 enum aarch64_insn_encoding_class aarch64_get_insn_class(u32 insn);
 u64 aarch64_insn_decode_immediate(enum aarch64_insn_imm_type type, u32 insn);
 u32 aarch64_insn_encode_immediate(enum aarch64_insn_imm_type type,
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 8251e2fea9c7..1ed1b061ee8f 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -519,6 +519,35 @@ static bool is_write_abort(unsigned long esr)
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
+
+	if (aarch64_insn_is_class_atomic(insn)) {
+		if (aarch64_atomic_insn_has_wr_perm(insn))
+			return true;
+	}
+
+	if (aarch64_insn_is_class_cas(insn))
+		return true;
+
+	return false;
+}
+
 static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 				   struct pt_regs *regs)
 {
@@ -529,6 +558,7 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 	unsigned int mm_flags = FAULT_FLAG_DEFAULT;
 	unsigned long addr = untagged_addr(far);
 	struct vm_area_struct *vma;
+	bool force_write = false;
 
 	if (kprobe_page_fault(regs, esr))
 		return 0;
@@ -557,6 +587,11 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
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
@@ -586,6 +621,14 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
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


