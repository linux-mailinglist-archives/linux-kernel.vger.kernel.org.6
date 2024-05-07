Return-Path: <linux-kernel+bounces-172252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0497B8BEFD0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 00:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADCC0286591
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 22:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D667A15A;
	Tue,  7 May 2024 22:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="gj8M4uS5"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2113.outbound.protection.outlook.com [40.107.237.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F7671739
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 22:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715121380; cv=fail; b=KQL3owzYskCw2nQNz3GcafeErv1hXs2OZVfMRRKtlRqDCPlC7P/WVLhl3XCigOv7oj5TVFVI3pvZ8NaxpHMnWRsDkuL3ImW3pKoENGRuJN6uIh5a2cT5vcakvCmMiBvhFJdVD9U+kPaTiFITBNZBb+m8X+5zWC2HrVlMGuZfl8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715121380; c=relaxed/simple;
	bh=bOfj4bHndbauMDf7too9ZZGi5J5BsLZozmPHI6+ecLI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DNf951u5GML+KGT0+gMfl23fYsgQc+NMIifrq25C9gTeZsN6GJaR2sWuleHgZ9AU7i0XZPqmiWAqOtzzCbUsttzKPKEUAYlFW68WjBeWL57xpS8IjLq+uZ4DPJWmsARt75SwlvXTG5QmyaS4KPp+6sWu8UNetyc0j6CwinDQjt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=gj8M4uS5; arc=fail smtp.client-ip=40.107.237.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJz0gPl7IErgbWDaYp+yJDWcC8DQFHVMxkzYf/OvcjkDIL6Y6YDE02figyQ+SX3ykpmWryiOxea8f1sdktOIx46nS7zcCLHwvnB5/wTbwWPs+XGoHWB7rA2ozRCHrYwla9CfoYT7RudxDfK84uFgBzNDzkyDl8uwq8kCqeXJ7nbkfRXxs5gwY7r1hYtjxPSPUGb06hX59hX8KM9QUBrnT6nbeBuRS+ndikzw6we0qfAJ7sAYidkpD8nqwtSkBgSxMWh9UHHn203rE8dW4lHAgLvmv1+FMM7xv7uYVcqKDE01khhIyF7Wgv3TjTcHB28hiNdBtF8GVtNnwVobNs+wQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aW5IXZdyAjowbWzpMfxdyNKYw//HS47nxKQ2Vq0RQ2A=;
 b=dU592RymBX29ZMlfS0gcTYb9x3cLyGPBgYTsHrYogAxEiqNsavdGGnSK4AQodxodzWO1wZ2akDO/bmwnNo5GhG3jB58QwHg9jYh0exCk44Bumi19a/ov/G4obYUAWfrtXQHFb/XF35j/V5b+Sdz55P/UHuaNHwXYVY4GaZKI7ytgvC+UyBkQjf7EXh9h6i8/ox6pjtc7HTI9WHmToQHG2gBc5r7ZBdtKyuhtgvU8qR0vT+fhGvtTPM/5tpEeVMje1yXqCJyFHI+LxKY+cJ/hVFEdumJuu8MWifruCbgXcHbiGgKRi3eYBo6muypKrGvLKTjUYLs6jVe+kP4QQBvTpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aW5IXZdyAjowbWzpMfxdyNKYw//HS47nxKQ2Vq0RQ2A=;
 b=gj8M4uS5LVWLulTk2nj0a7nqxoPeNrOP+2LKcaScsDxZfyKX2PsdvYglklj3TO7gAh/MrvvNZRGPdbqbRqa7PEwiT01ADuIjh9QexUBL8Kft4sOaLY1u1G1G8A9uxbLEkIFACkInI74Jc18z7ad+tbCLlPxEzYVVzZIvid7OUIs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BYAPR01MB5463.prod.exchangelabs.com (2603:10b6:a03:11b::20) by
 CYYPR01MB8291.prod.exchangelabs.com (2603:10b6:930:c4::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.42; Tue, 7 May 2024 22:36:16 +0000
Received: from BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955]) by BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955%4]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 22:36:15 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	scott@os.amperecomputing.com,
	cl@gentwo.org
Cc: yang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: mm: force write fault for atomic RMW instructions
Date: Tue,  7 May 2024 15:35:58 -0700
Message-ID: <20240507223558.3039562-1-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5P222CA0009.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::25) To BYAPR01MB5463.prod.exchangelabs.com
 (2603:10b6:a03:11b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR01MB5463:EE_|CYYPR01MB8291:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f49a043-51b0-4da6-5666-08dc6ee61af1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|376005|1800799015|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CyIvortRt4768vBXTVoXKamfcYp+80Ti8FTefJ6lVAf1IIhKbCR5wu529gFK?=
 =?us-ascii?Q?vAbyEhLcB4MVv4cSingKVzk0ST26GzNyVNvC0qJ60Ur88aCw+Rrq3kqKduLt?=
 =?us-ascii?Q?J4f9Rt3ME9Yg0K5KXJZULqv0ks/LcIzhjzK6o571jQMQTG9/RpOSr70ZLVFz?=
 =?us-ascii?Q?bj216WBvBwH3i0CIlAbUCKl8N+mTlr4KXCgyl0X7iiJ/AwuwvyBNK4fivHS8?=
 =?us-ascii?Q?5Fr4I9JLMjZvAS6oT1a4Qflww6dHKMRGpSaodHhKUzghN8/kCO1j89SaQU55?=
 =?us-ascii?Q?zjXDqahKZDDbsxeqX1ByjyKwg1HsvXpqBbqjxgNVCqjbwt1OeoUxvqiTIfII?=
 =?us-ascii?Q?lK8Kl6yxpvSHiSQDFE2mrC8yuq3zrH7L7YLtZgWbUDUo7cqm0ZaY/+/RaX8r?=
 =?us-ascii?Q?8mjFj2rvX0JjpRVx9K7V18Wt9982YqgfTPY3Av2GIlleact22rPmvlps95GR?=
 =?us-ascii?Q?yQ9uzSHOxavTATUL18mCSpTI4g8UxdaMiFar7qYarXDVpapn0wLl5DqzOXu+?=
 =?us-ascii?Q?W/iuo/UJuylznCCRiZapDpdn/Xz42n6jyTszYXzPhIg/Jabw8qB/a2du9SPF?=
 =?us-ascii?Q?ax31MgnVslzbwr2tagJsrIGVeKtvAwFKXP0n7XHnYLxdlfeF6N5oUcVVmJms?=
 =?us-ascii?Q?KKgFvhqN1aAL14WkKdDZfjeVsGCLM9nJx5+3XLH0qYHv7DU4HCCm0ZUlFaTx?=
 =?us-ascii?Q?l3SnOyKf6YqQ4KIF8tgU281ynnybYRBhQBUMPpCYJAsgMeJn2cQsH7C1+Ytu?=
 =?us-ascii?Q?ajgycIo/5rDKssBlbNwhWAtDcT6rKiVZRvYRGRUS5EXkTPep6uRjO+WjGeuY?=
 =?us-ascii?Q?QseEdEx3Qwmyih7IlDS4NXwgSJoBzGdKR0C0MwUyEkMetrjgKluG21RiuL4G?=
 =?us-ascii?Q?Ocrsp6mpzFlTfYKV5o8WaLYzP9Okq73/HKJyrmt0EOzEPORW2tzWim4M6uC1?=
 =?us-ascii?Q?Hmf2mhNo2m/pTIP0upOeAsjts1Lt/r1tmn6k+qx8CWOGBOY5Zs9RpBNX1QTZ?=
 =?us-ascii?Q?8XQOoeuXm8+y8ywnt8GEiTbg0rjKauJeyHvYQ78i6xLqtScEuEtFoQFrfpbQ?=
 =?us-ascii?Q?shnIsFaQzUiSZV15I/iTxK1LGAujulx5dMp+YDIIJehda6g9ig9DWqUiRetU?=
 =?us-ascii?Q?VqIwWN0DqarNwvHy3cRU0xqY5lznyXVnz2/o7ZgB6qDzb9kKqodRwMtQ9x8L?=
 =?us-ascii?Q?/xCx+ocrKY4UHo0ELEjaaF3WTlW+3jYJLvC9jpS0sYTJCgBqx0KlxIiBJ1L8?=
 =?us-ascii?Q?7UkRiM94UCSQrL9M5vP5O2TEM8629ggyRH3QwRIOxUjD5/dDzuaEiZ9ppLHU?=
 =?us-ascii?Q?Ppoh6BFeavyZEIIJDHrbXOoZus0GfrppYljcQoTeTVv4nw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB5463.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GJdecM+Syvn75M+VY9URzuiA51p2E6Z8KfuS0SHlfTXFOi6Pk727pAtLwFha?=
 =?us-ascii?Q?urnCMFS6gWiXI1Mg6Z+PxAATZDT+fZICdsYdF+PuyrxjDWhxbK8trqdZfNT6?=
 =?us-ascii?Q?tHFtU/AziMtZDIVLxqPnMwe8bMcfTaYNu5+nd3bKBZyoDJPvOfNltjFOqA9U?=
 =?us-ascii?Q?JACJybNdqzxWU4eB70tV/OMg+3u8nubHcG6vkvf7TDjefQZse1YQb65fYW6D?=
 =?us-ascii?Q?f4PvgMBulcR2uhHbt+lSCpgLb/WFR0P9jt+/NFAy17eoXqn1FitVOzSAS5Rf?=
 =?us-ascii?Q?x3BYJpMeSZ3M1T1M+Ajkm7sHtjoLnbfOWscGe5jHF6fLd9JV1GurlycjGPzD?=
 =?us-ascii?Q?8KkqINct8AilXWi5rOnbuR/UOsTgSztmbM6OKQ9S2J9DbsiAQjoPpnhN8K3n?=
 =?us-ascii?Q?LnzZdtJlarOs2u+mNXa2LDKzDjST2u/0c0dsv20yCEVPqAsgWqU9tKRP4ry3?=
 =?us-ascii?Q?l+DlIA+2KSMYTgscJYk1Aih783lMbgh57MLEvUcD2g19MX4QkXwM0FiaAWbd?=
 =?us-ascii?Q?o9NL0fo+EyVQZVEzWOlCOKbaX3EQs3UD6gDdhdv1kwIPigVSDPVfMo5gWPSP?=
 =?us-ascii?Q?LqC+26aP6PNfVjUD5nyC22qrGaO+JAU1xryJVqS0zzh0CZAJUEqshfTZDEo6?=
 =?us-ascii?Q?T6BZxmClXy/Yf8mxClX+2w1qmZK610f4kuee3WhuW34KVcc8g3fmUDM3tSFk?=
 =?us-ascii?Q?Fq6+nUORwlJOm3vOG+BZyki+cCWVb7LJzOmBsiAi0ovzaAZY8SfpVdc7E4VB?=
 =?us-ascii?Q?ll/JLaeZ7HOeVzczpYceAGVS2Q5uxUxGifuG2qZZ1+nSBHk6NQkizo6IU0AU?=
 =?us-ascii?Q?H0ZbH6+gx+AEGszJS3riGchKNLr/zgTOMzFyE+dyscmp9zOkelGJILnbrDCv?=
 =?us-ascii?Q?dlGR0snKMnNmApGF9ihOB9tHWTtB2gaxlYrTkzoEgOMvu/Fb1jRSiBs3U0yy?=
 =?us-ascii?Q?UbjAznc7AVHvglMzfpZt06l3EvaPY8FgiBBIFf4xDW2DzwvPTbA3/p4Yp95k?=
 =?us-ascii?Q?1AgLyMU9XDrl3sv0kvc5Y/qJr9DxWPN7Q1t3xpH1H/pUOIL2H8qJIIV2zYpz?=
 =?us-ascii?Q?XNcladOkgpgyJ1rTFk9PWRr1F6HD19Eyyi03tzhzbnmoqW+6jjN3GUkiV68I?=
 =?us-ascii?Q?TUxsgjGoxqAGI8KRuoR7GlqXVubNORxysaP95ZJ+QP8NXfuSAHQFjPE2XM7l?=
 =?us-ascii?Q?Q7IzDmEl8CkDY0OznVDOkWh7dVhpUmHjPfiGBVR+tAlWlWS+u0eTEAy5cV0H?=
 =?us-ascii?Q?BtcOlKboEw60uzd4/oRETeWu6rOXieWsrfCFaqddvaBz/TS1y6XnDdhlOraW?=
 =?us-ascii?Q?+FDVhWTztUivb8/BZchDeWU6goC3+BgC5aRSj/yGHZhlByPJZ5q1vgAC8UK/?=
 =?us-ascii?Q?3lGStA1tVvjRRKj3F/xoTg/pTlusua0OfeEokQxtYC0pXyD/3BGvO4NX3IZz?=
 =?us-ascii?Q?vJ/PssiwG51UcNOxJTRJSmmlXNDqaZzs9DF/ecLxQ6hRAr0+pPJtBePfYmS9?=
 =?us-ascii?Q?F46UPoEe2x/gU0OxBxJD3oytE7qwL7MLamHasxNrAPmpYJ9iKRHWTOFxoDTV?=
 =?us-ascii?Q?34N8wyFiGjCfVMwz7QOiv7qHNEfchL76aOdOT0zs3fBS/b0ghQu2MoS6ZUrB?=
 =?us-ascii?Q?b5JO/LwP85NIGhO8mnOUo7c=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f49a043-51b0-4da6-5666-08dc6ee61af1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB5463.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 22:36:15.5199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P0+hMGhzOsfYDdkjReFOo/bFb7AQuT1mIScicHsKyQwA3Yad4CJg7iWmi4mha0EA/rjb1Tx8DUht0ZZvMPiwaCLSneQD6SiMuycyUcCPshw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR01MB8291

The atomic RMW instructions, for example, ldadd, actually does load +
add + store in one instruction, it may trigger two page faults, the
first fault is a read fault, the second fault is a write fault.

Some applications use atomic RMW instructions to populate memory, for
example, openjdk uses atomic-add-0 to do pretouch (populate heap memory
at launch time) between v18 and v22.

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
 arch/arm64/include/asm/insn.h |  1 +
 arch/arm64/mm/fault.c         | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index db1aeacd4cd9..5d5a3fbeecc0 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -319,6 +319,7 @@ static __always_inline u32 aarch64_insn_get_##abbr##_value(void)	\
  * "-" means "don't care"
  */
 __AARCH64_INSN_FUNCS(class_branch_sys,	0x1c000000, 0x14000000)
+__AARCH64_INSN_FUNCS(class_atomic,	0x3b200c00, 0x38200000)
 
 __AARCH64_INSN_FUNCS(adr,	0x9F000000, 0x10000000)
 __AARCH64_INSN_FUNCS(adrp,	0x9F000000, 0x90000000)
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 8251e2fea9c7..f7bceedf5ef3 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -529,6 +529,7 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 	unsigned int mm_flags = FAULT_FLAG_DEFAULT;
 	unsigned long addr = untagged_addr(far);
 	struct vm_area_struct *vma;
+	unsigned int insn;
 
 	if (kprobe_page_fault(regs, esr))
 		return 0;
@@ -586,6 +587,24 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 	if (!vma)
 		goto lock_mmap;
 
+	if (mm_flags & (FAULT_FLAG_WRITE | FAULT_FLAG_INSTRUCTION))
+		goto continue_fault;
+
+	pagefault_disable();
+
+	if (get_user(insn, (unsigned int __user *) instruction_pointer(regs))) {
+		pagefault_enable();
+		goto continue_fault;
+	}
+
+	if (aarch64_insn_is_class_atomic(insn)) {
+		vm_flags = VM_WRITE;
+		mm_flags |= FAULT_FLAG_WRITE;
+	}
+
+	pagefault_enable();
+
+continue_fault:
 	if (!(vma->vm_flags & vm_flags)) {
 		vma_end_read(vma);
 		goto lock_mmap;
-- 
2.41.0


