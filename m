Return-Path: <linux-kernel+bounces-231390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB4E919830
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 21:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B8382836C1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 19:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA66A18E767;
	Wed, 26 Jun 2024 19:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="qbKpzjeR"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2124.outbound.protection.outlook.com [40.107.92.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6711922D9
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 19:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719429534; cv=fail; b=iFHn1m0aH8IbpBVhqK6bO7TdZr24bopUayEQfLvrQT4QXSHN8W+m4S5RCrPgJIy5CJdp0J+NOn8mXRxrgxpVI75+hXYog0ndNPVn56iQ1O9/5ZPBejq0xhgAcuWf2PKnFYOz7+A3W/o41C6EWQsHss+32RnYtJ5uRykEBDLMOQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719429534; c=relaxed/simple;
	bh=PvcqlZ4csAgsesCxIFXksXmSHUxUwRuSSwYzpRAIK5I=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JfYPQqgHBkb/emB5cHc3vSe/kD7rgdUdbuRmlM4edzDXUSxsQu6AT1PH1iHPf90FbhbOB1hA+tXQK3utwDNJLoZS44Q9vwMwruPgaAx9v5sWYj5QXmeUpvq9PWLsth72/81LafiiDKHiRNZyG2XY7NByZgECVQQVjbrlRn8ZX+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=qbKpzjeR; arc=fail smtp.client-ip=40.107.92.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXD3mQZ3Qp1Opj14IMwLe8qTfXl58otfdP7neHwKXfuMh6asCQ+VsWJDNAclYtxQE4dmQ4CoGwSIfJbAiXvkXDBiBJy1+cCb5p9+i5Qf3uMqz/7WKaG0pZJuJ5LWG+4YKa36jv2OjsVh23fOfxyh8cEmCo/TcBI/F+4NFRX62R1btRbo/Xeke13j/n7drQYRIFL+QlIilkymlLf26w/h4fiBSTmaMVSE3mSQA5/v91w16iMBrJiYncR+gzKjJNl9W/rxsQ/9ed8sMCItaiy+jXMyE5MFJWDPwJ2zSzHKDqbDnhSkAW4r0NLE7+qIGXA20YVJ4G+J7E/Pk8+7fImx9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGd5jlsPHYmIvVmxkTRCdwgWBZ3QgyR8GasOPwkUHzs=;
 b=WPVqm81oUlmb8oB57qXo3tpRGuu2cw2FjcADTNHPKRT4JJViscWpL0dgE7MuNkP8OBhjdk8xK9vTLu1yrxMZW5qF/SFD9NwGFTF9NqD55nT+n0NuD6ovZHRnJ2l244tHUT4e2XFCfyuUlHesOcWNuFYuqebwHWPDW73zhRbmMw5W4fy7doqxY6m+hDuVNQ62YfuKWFGSU0OMLNbOwkfqlR0gByi0Qs5PQYtwQhoSGWRjOrEVkGZvflKibb1FiOXnoXesZ+VNYe+lSV21dI7I8Ufd+y5oitl05hj5yXjDjLyorA8POWYMFLxR+Hj39SHkPnsFav2tNLOLCag7T/Pn9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGd5jlsPHYmIvVmxkTRCdwgWBZ3QgyR8GasOPwkUHzs=;
 b=qbKpzjeRgtKkk4SfWKqlz3jXDuQuTr1VO1vQ4OFXgU2giUNOdiGIqFTl6KlNekG7uKsqAzvgxo2c4+VbT2D00uVuaFMaAE34QDO2+ws9Mjy+1/Dzct4USdR6AELcjgEb42juaCW1I+qQydfgwgveUK4+n0b3j6j33ZXS8jWOAMw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BYAPR01MB5463.prod.exchangelabs.com (2603:10b6:a03:11b::20) by
 SJ0PR01MB8108.prod.exchangelabs.com (2603:10b6:a03:4e1::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.32; Wed, 26 Jun 2024 19:18:49 +0000
Received: from BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955]) by BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955%3]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 19:18:49 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	anshuman.khandual@arm.com,
	david@redhat.com,
	scott@os.amperecomputing.com,
	cl@gentwo.org
Cc: yang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [v5 PATCH] arm64: mm: force write fault for atomic RMW instructions
Date: Wed, 26 Jun 2024 12:18:30 -0700
Message-ID: <20240626191830.3819324-1-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYXPR03CA0042.namprd03.prod.outlook.com
 (2603:10b6:930:d2::21) To BYAPR01MB5463.prod.exchangelabs.com
 (2603:10b6:a03:11b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR01MB5463:EE_|SJ0PR01MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: b739352b-4d1d-4092-861e-08dc9614cea5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|1800799022|366014|376012|52116012|38350700012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pYdWqrLAD/+U/UV5joMdJYT9a4x+uBp0E14MTlbeC321vQ+Dbg13b++K1SRv?=
 =?us-ascii?Q?/hKPJQEpPyxZYSdEQHrW+gEuX9Nu8ny7Id8/DDx/r+7WzKS7fYzgCiSnPw2X?=
 =?us-ascii?Q?OLNYrG7ZFq0SN31Swa8m/1CwVNgyTergH02jB6im1Jy631a6MYTNsh1IoJcB?=
 =?us-ascii?Q?vtXiwyHOb8k+8DIohzZlxg7+wGZ3qadxqTfEZy4RpkRFz0DHbGI2ShHB/kEf?=
 =?us-ascii?Q?i31Xun73vC+AAptmr9DbtvOpqqLaP3VMChVbytN08wR6VB3ZxSqUZrfcaK/b?=
 =?us-ascii?Q?xjNmxwfBqE5XWvP+5/ICEpEypit2+C98TokTnpakvx2JP29A9hBExOeoA/wF?=
 =?us-ascii?Q?VmysfY0fHFjZLssiSiFBZgPpOwYYI9KZtW1UxTwwu+U6m2F8dpgSrmGRc8/O?=
 =?us-ascii?Q?+LcZ+4JW0mm6nhwT0IAS3Mb6WotMrJlhDI6Ea3aqkiLX3sc03BwB2gjQxrFS?=
 =?us-ascii?Q?NV02aN1wEhBFMIo8fcaez23ZaxdL0CVWo/wFkKzeEZZQ88CCbiZCri6M1ImA?=
 =?us-ascii?Q?uT5mMk5cE1q4+nRfKtPxMC4ju8BCCfC+TqAnQZriKcwu7kQVK/UbJ45CgMfN?=
 =?us-ascii?Q?NRVWxbh0kP9hlhCjo7/e8UXTDIU/m9gpTdSiuGK7mzPYT+TKA9pwHjVdp6Jc?=
 =?us-ascii?Q?lwRX9bceiINCSQ8rXWmcKLlYnlY50y5+/6dq+0MWZEh7PQA3VgIzYXd/dwW5?=
 =?us-ascii?Q?XlyTVPHjXMrUmeeSGbH6kUmueh+y5MQZhemoF7LqyVpyR2CvXsOlE5nOPDBI?=
 =?us-ascii?Q?Tfe/6z6S9mxyViksWYipnzd5EPTdj0VxjEUZkurAe9IFkKGQ5y4G8GQ8nF1H?=
 =?us-ascii?Q?DlfdP5KbnSQLp0DDVlicFgcSq5RLLpHAUgaYL/thH4xerF2mMXMhYHlQoyJC?=
 =?us-ascii?Q?ZmZQVnVeaDUkyNhbAXhpI4npTLPxv0suobIz2HPE8Tml3d1kdL2L4ncvaYEt?=
 =?us-ascii?Q?kM7ilubRNws7lktn11aObUBjhvcwKWoWBZRjRHHWQzZUW2rXazZmBeGoWsoQ?=
 =?us-ascii?Q?S14ep++nEA/DU+eG6s7m3Sm9KeATrxLFyYXs1IfXg7mC4q8w3PSbPzm24dmu?=
 =?us-ascii?Q?u78LT9YixJHiju1JtLx8edMcP2Zf0zZ07OJiEe8qFPxjU44J+++4JoBTBOSR?=
 =?us-ascii?Q?aBtzLsnJ53ogxrDJWSglyKZy7XiggejQcsM0j7E4Pm3ycDWMoJp5P7dDAbhd?=
 =?us-ascii?Q?uj5cc8dk9S2ceLBbo6M63HF8sg+gw67r3qVgQBdJ2X8SSDa3PQ1TKp+vnW6w?=
 =?us-ascii?Q?Xp3jjEkzivy78/hBZiv9HxNn5WpePU9Pw8MuKq/MFN/bS0HllDupQITNmGwo?=
 =?us-ascii?Q?okSBUlu25R9/o8AJ26e00n8qNBD/1TPKo3UBR9mjJx0HKr+i4SsM1qnWV1CP?=
 =?us-ascii?Q?IQU3D95x9JvHxteeORqKM5A+u924UKLtGmJckr103kMV6DsYsg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB5463.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(376012)(52116012)(38350700012);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vEJg4mhnnE45oO0NA628m6xNiEYUbzw+ss4TV4r+q10fRzu/0Uw9ikWY8OVG?=
 =?us-ascii?Q?Jvj2vxXnvNayV6m0DfPW8CwQVZl8dIUkj4V+gK3QZtzYr280Y0TmFYH/b7qI?=
 =?us-ascii?Q?eprzYrWQxRso2MPgIcdiM9xUhPAutD/x1v1tN4ATlUX9QGA5KYTdUtcajrnN?=
 =?us-ascii?Q?SZ7grsFdnI+O+uTzDWXtSP/bsWCJZw4BYozT7fkwdwfc6rX4520bGqr0ilHO?=
 =?us-ascii?Q?xJKgHZDvUYKBwmu7I9nBWSvFpt0T06SIXa2fRBqekWO8h809uHYXsOcL/KpA?=
 =?us-ascii?Q?onlcrxMOM+CK98qPB2ZNNJj4G2/uEXnMXH8QfNUauU9r5lNnj0FWG4FIRFJ8?=
 =?us-ascii?Q?QQABjy+0E09F2K5qLUJBeK8JvXCNkwcYdlnZ3tGxLamFpSobCdTkj8hQACZX?=
 =?us-ascii?Q?/Kx6dR7iIvbdy8wCQziiuKFzZq5cXLPlLznMyna/FImCQorhtBPl4s5mwFDz?=
 =?us-ascii?Q?2gfCcVZyh5h5aQ3Mzd2avzqIpw9GsNQY4tNV9nFYSbeqcQKG2ZGG2MboIzkb?=
 =?us-ascii?Q?+PMORrzVP0cub34wxAEa7cy79tLOWPaBbxJ+UlOriBPyNHaYJTwFqioot6i3?=
 =?us-ascii?Q?lz5ndLzzeqx2b+OuT9HFg3xRRd9JC2dtA94L4Yvx80/JCIBIi3h7JaMa/VIV?=
 =?us-ascii?Q?q9IoIDLb2ImHY6IwUQ3Nntcslb6CSJWaxua7NsWhFyj0woquchvN08rBmvsU?=
 =?us-ascii?Q?T7Y/HR0l8H+gCS0KdplXm1dLlGGJ4HjqQ5jLJAH6GNvknUK21m8P/qUQDA+v?=
 =?us-ascii?Q?2Q9XxpQLB2CAz8F1w9SGsOrrN9SiBXINi6ytpp9DPLp7jeM5UBzjw9sCPqXs?=
 =?us-ascii?Q?KITFF2NtkPj+uGn1QgdzjH1lcXxi0NwiFcC7PlktVz5+CCsGNTyrxEc35cgX?=
 =?us-ascii?Q?UEwks3TbSX6if+pvx3GRaQjcV8yfFB3csacc02WLxtG8mx3D5D/NFIfni2Z2?=
 =?us-ascii?Q?+YUA+LQoCiz6oGEDOBc7KegaEI1AjMEXrTcfmOTp1VZg9dIfK8eamGFVmTH2?=
 =?us-ascii?Q?dZ+5lwccaOr307t2LT8bN0wG3zbKOiC/Q8o188aFyUgLXp8Otk0n2fEKjPdn?=
 =?us-ascii?Q?vJ2tcq17DA/DYd0nOS4Z0oA5DSJmXZN7/Hu7+kyytx+gYNesLLKwZ5GAr/lF?=
 =?us-ascii?Q?3So1SqTavc7JkDM4krcnitet4T/A0ml6DaZRpaL0lVjuM+5H6MG8VrOKHcPe?=
 =?us-ascii?Q?bvq0zUIpYGd0C6rH4KnY0leGHYTUY+pZ7+NQEz3gLlh1AdLdEK6VnPV6Tld3?=
 =?us-ascii?Q?ekUr7qT00wyUUGeZAaSFFe/ayiFOKkOEDg0bIwPiXeSNutK5gmpRKlX63kFN?=
 =?us-ascii?Q?+rSHVZxDN6u1HgV6ibIkfALG1V6hmXUgBdnq38muVS7Erx/N5OrpZKiAzn0L?=
 =?us-ascii?Q?oJnIyPrGLRX5eOE/U+Q7hBKMiFw1/ig9JJWBZUxZqH1Q6F8q59wz9N6tVSXp?=
 =?us-ascii?Q?rm5LIscO1g7yS5jmuc6xkY8EX//iqQAM2cyWHmCBx8wvv7a4CeAk5XT5X7gr?=
 =?us-ascii?Q?QxiRCJxW3//Y0WxIe+FJqGll0FhvrVg8OtRKRsl5eOIpZlEf6RXao+llJGln?=
 =?us-ascii?Q?L5RF2A+EddujZNya7WA997zxlfpWIUOg1ko0/gVXjYFR7ZHUGfVvCtSdKFmw?=
 =?us-ascii?Q?6xN6fuyOy9+ochpkbeoLGAw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b739352b-4d1d-4092-861e-08dc9614cea5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB5463.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 19:18:49.1366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2eejEaHV4oKEUojSvxey2NeZ7GS7hpI3+9sW8BVp46FZmrzCgBt8Q80mIbBVximJ7bCYDOkAcGDQqoWLF9OgG9rAGlT3rqRkSjsE9W9CPfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB8108

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

Reviewed-by: Christoph Lameter (Ampere) <cl@linux.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 arch/arm64/include/asm/insn.h | 20 ++++++++++++++++++++
 arch/arm64/mm/fault.c         | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

v5: 1. Used vm_flags & VM_READ per Catalin.
    2. Collected ack tag from David.
v4: 1. Fixed the comments from Catalin.
    2. Rebased to v6.10-rc2.
    3. Collected the review tag from Christopher Lameter.
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
index 8c0a36f72d6f..efcc8b2050db 100644
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
@@ -549,6 +551,24 @@ static __always_inline bool aarch64_insn_uses_literal(u32 insn)
 	       aarch64_insn_is_prfm_lit(insn);
 }
 
+static __always_inline bool aarch64_insn_is_class_cas(u32 insn)
+{
+	return aarch64_insn_is_cas(insn) ||
+	       aarch64_insn_is_casp(insn);
+}
+
+/*
+ * Exclude unallocated atomic instructions and LD64B/LDAPR.
+ * The masks and values were generated by using Python sympy module.
+ */
+static __always_inline bool aarch64_atomic_insn_has_wr_perm(u32 insn)
+{
+	return ((insn & 0x3f207c00) == 0x38200000) ||
+	       ((insn & 0x3f208c00) == 0x38200000) ||
+	       ((insn & 0x7fe06c00) == 0x78202000) ||
+	       ((insn & 0xbf204c00) == 0x38200000);
+}
+
 enum aarch64_insn_encoding_class aarch64_get_insn_class(u32 insn);
 u64 aarch64_insn_decode_immediate(enum aarch64_insn_imm_type type, u32 insn);
 u32 aarch64_insn_encode_immediate(enum aarch64_insn_imm_type type,
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 451ba7cbd5ad..6a8b71917e3b 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -500,6 +500,34 @@ static bool is_write_abort(unsigned long esr)
 	return (esr & ESR_ELx_WNR) && !(esr & ESR_ELx_CM);
 }
 
+static bool is_el0_atomic_instr(struct pt_regs *regs)
+{
+	u32 insn;
+	__le32 insn_le;
+	unsigned long pc = instruction_pointer(regs);
+
+	if (compat_user_mode(regs))
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
+	if (aarch64_insn_is_class_atomic(insn) &&
+	    aarch64_atomic_insn_has_wr_perm(insn))
+		return true;
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
@@ -568,6 +596,12 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 	if (!vma)
 		goto lock_mmap;
 
+	if ((vm_flags & VM_READ) && (vma->vm_flags & VM_WRITE) &&
+	    is_el0_atomic_instr(regs)) {
+		vm_flags = VM_WRITE;
+		mm_flags |= FAULT_FLAG_WRITE;
+	}
+
 	if (!(vma->vm_flags & vm_flags)) {
 		vma_end_read(vma);
 		fault = 0;
-- 
2.41.0


