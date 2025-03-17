Return-Path: <linux-kernel+bounces-564700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B68A65965
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A9A716D0E7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9D41FECB6;
	Mon, 17 Mar 2025 16:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JTnQhxC8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tap8UfK+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D19205516
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742230417; cv=none; b=QHubq9r1o+4vSNaAxEnVaAXO7mZvEuQqLvjDhwM6YlRuVIoCrT/dtYmjVJHUNecKmFZtkw5LuhSBclGrJ2/7D7l/9PMWcooIWRhOt6ncRUoW10b3zmwS6v9mNKqqll9jl95rpxRqOUWD+8ZtZV0fY/TRA36O5SuCmalejg2+i1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742230417; c=relaxed/simple;
	bh=GDDw5PkTKpBPZzRTzIiG9rdPABfmnjkm77gbELpJ2Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kx+AcwEJgoj+9Unx7LW4tljlQM3RI8nHVE2VRDzLcNrFr4SgyTax/2ZjL8Jcu1HiCPAAoHXm53TPcwphPXWZMlv6OzBF1jhakmneHr0MlVrlhIhr7SlNaHa2BTBceTVcYyXmkwgXfQmqZNGVxTPTMmNkH3PiWKS0bE1Ivobu4ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JTnQhxC8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tap8UfK+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742230414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=psY58xt7nuGRsWQjqs/ux0vPkYh0Vgn7O3Dt3YI+S0w=;
	b=JTnQhxC8esKkBu928kDspU4PStSG+fLdwfw8/+dzjEDgBkkShp5DusWlOrGvrY5KdF+9Ov
	HsfRzR7G0nF5R+fpYQMERjkNKqYMtIJRS6/78OzxFGjl7A2U0ly5ZKd4MH7EuepwzGu+5c
	Ibxm48iRXTXJD/Jl1lW/xdBw4Ir6OOAhQTO6+QqxJiDU9MpsYvRQ0FTRFd/6m4bJsQ8kIS
	/wVeqm22LRmcXnYvUXULmVg+A+CwblNylpwmLlU6nXx1iSGO0CqTt8Mimf1+2auQarQ9qI
	fwMvulB2mZowVm090xghB0oz7cl/gvbjOYmxwKNOCS2RTY8i1g29tD/SwGvylQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742230414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=psY58xt7nuGRsWQjqs/ux0vPkYh0Vgn7O3Dt3YI+S0w=;
	b=Tap8UfK+6FCs0vXVQTLTz3VEM676PQBxTDdMBf3HvfMUwIHeBysl3q/4PWbP0JodyCp10W
	uqP2QfZzZqtAw6Aw==
To: Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v2 21/29] x86/cacheinfo: Use consolidated leaf 0x2 descriptor table
Date: Mon, 17 Mar 2025 17:47:37 +0100
Message-ID: <20250317164745.4754-22-darwi@linutronix.de>
In-Reply-To: <20250317164745.4754-1-darwi@linutronix.de>
References: <20250317164745.4754-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CPUID leaf 0x2 output is a stream of one-byte descriptors, each implying
certain details about the CPU's cache and TLB entries.

At previous commits, the mapping tables for such descriptors were merged
into one consolidated table.  The mapping was also transformed into a
hash lookup instead of a loop-based lookup for each descriptor.

Use the new consolidated table and its hash-based lookup through the
for_each_leaf_0x2_tlb_entry() accessor.  Remove the old cache-specific
mapping, cache_table[], as it is no longer used.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/cacheinfo.c | 114 +++-----------------------------
 1 file changed, 8 insertions(+), 106 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 9f5bf57fd4fc..0047a41d8d57 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -34,90 +34,6 @@ static cpumask_var_t cpu_cacheinfo_mask;
 /* Kernel controls MTRR and/or PAT MSRs. */
 unsigned int memory_caching_control __ro_after_init;
 
-struct _cache_table {
-	unsigned char descriptor;
-	enum _cache_table_type type;
-	short size;
-};
-
-#define MB(x)	((x) * 1024)
-
-/* All the cache descriptor types we care about (no TLB or
-   trace cache entries) */
-
-static const struct _cache_table cache_table[] =
-{
-	{ 0x06, CACHE_L1_INST,	8	},	/* 4-way set assoc, 32 byte line size */
-	{ 0x08, CACHE_L1_INST,	16	},	/* 4-way set assoc, 32 byte line size */
-	{ 0x09, CACHE_L1_INST,	32	},	/* 4-way set assoc, 64 byte line size */
-	{ 0x0a, CACHE_L1_DATA,	8	},	/* 2 way set assoc, 32 byte line size */
-	{ 0x0c, CACHE_L1_DATA,	16	},	/* 4-way set assoc, 32 byte line size */
-	{ 0x0d, CACHE_L1_DATA,	16	},	/* 4-way set assoc, 64 byte line size */
-	{ 0x0e, CACHE_L1_DATA,	24	},	/* 6-way set assoc, 64 byte line size */
-	{ 0x21, CACHE_L2,	256	},	/* 8-way set assoc, 64 byte line size */
-	{ 0x22, CACHE_L3,	512	},	/* 4-way set assoc, sectored cache, 64 byte line size */
-	{ 0x23, CACHE_L3,	MB(1)	},	/* 8-way set assoc, sectored cache, 64 byte line size */
-	{ 0x25, CACHE_L3,	MB(2)	},	/* 8-way set assoc, sectored cache, 64 byte line size */
-	{ 0x29, CACHE_L3,	MB(4)	},	/* 8-way set assoc, sectored cache, 64 byte line size */
-	{ 0x2c, CACHE_L1_DATA,	32	},	/* 8-way set assoc, 64 byte line size */
-	{ 0x30, CACHE_L1_INST,	32	},	/* 8-way set assoc, 64 byte line size */
-	{ 0x39, CACHE_L2,	128	},	/* 4-way set assoc, sectored cache, 64 byte line size */
-	{ 0x3a, CACHE_L2,	192	},	/* 6-way set assoc, sectored cache, 64 byte line size */
-	{ 0x3b, CACHE_L2,	128	},	/* 2-way set assoc, sectored cache, 64 byte line size */
-	{ 0x3c, CACHE_L2,	256	},	/* 4-way set assoc, sectored cache, 64 byte line size */
-	{ 0x3d, CACHE_L2,	384	},	/* 6-way set assoc, sectored cache, 64 byte line size */
-	{ 0x3e, CACHE_L2,	512	},	/* 4-way set assoc, sectored cache, 64 byte line size */
-	{ 0x3f, CACHE_L2,	256	},	/* 2-way set assoc, 64 byte line size */
-	{ 0x41, CACHE_L2,	128	},	/* 4-way set assoc, 32 byte line size */
-	{ 0x42, CACHE_L2,	256	},	/* 4-way set assoc, 32 byte line size */
-	{ 0x43, CACHE_L2,	512	},	/* 4-way set assoc, 32 byte line size */
-	{ 0x44, CACHE_L2,	MB(1)	},	/* 4-way set assoc, 32 byte line size */
-	{ 0x45, CACHE_L2,	MB(2)	},	/* 4-way set assoc, 32 byte line size */
-	{ 0x46, CACHE_L3,	MB(4)	},	/* 4-way set assoc, 64 byte line size */
-	{ 0x47, CACHE_L3,	MB(8)	},	/* 8-way set assoc, 64 byte line size */
-	{ 0x48, CACHE_L2,	MB(3)	},	/* 12-way set assoc, 64 byte line size */
-	{ 0x49, CACHE_L3,	MB(4)	},	/* 16-way set assoc, 64 byte line size */
-	{ 0x4a, CACHE_L3,	MB(6)	},	/* 12-way set assoc, 64 byte line size */
-	{ 0x4b, CACHE_L3,	MB(8)	},	/* 16-way set assoc, 64 byte line size */
-	{ 0x4c, CACHE_L3,	MB(12)	},	/* 12-way set assoc, 64 byte line size */
-	{ 0x4d, CACHE_L3,	MB(16)	},	/* 16-way set assoc, 64 byte line size */
-	{ 0x4e, CACHE_L2,	MB(6)	},	/* 24-way set assoc, 64 byte line size */
-	{ 0x60, CACHE_L1_DATA,	16	},	/* 8-way set assoc, sectored cache, 64 byte line size */
-	{ 0x66, CACHE_L1_DATA,	8	},	/* 4-way set assoc, sectored cache, 64 byte line size */
-	{ 0x67, CACHE_L1_DATA,	16	},	/* 4-way set assoc, sectored cache, 64 byte line size */
-	{ 0x68, CACHE_L1_DATA,	32	},	/* 4-way set assoc, sectored cache, 64 byte line size */
-	{ 0x78, CACHE_L2,	MB(1)	},	/* 4-way set assoc, 64 byte line size */
-	{ 0x79, CACHE_L2,	128	},	/* 8-way set assoc, sectored cache, 64 byte line size */
-	{ 0x7a, CACHE_L2,	256	},	/* 8-way set assoc, sectored cache, 64 byte line size */
-	{ 0x7b, CACHE_L2,	512	},	/* 8-way set assoc, sectored cache, 64 byte line size */
-	{ 0x7c, CACHE_L2,	MB(1)	},	/* 8-way set assoc, sectored cache, 64 byte line size */
-	{ 0x7d, CACHE_L2,	MB(2)	},	/* 8-way set assoc, 64 byte line size */
-	{ 0x7f, CACHE_L2,	512	},	/* 2-way set assoc, 64 byte line size */
-	{ 0x80, CACHE_L2,	512	},	/* 8-way set assoc, 64 byte line size */
-	{ 0x82, CACHE_L2,	256	},	/* 8-way set assoc, 32 byte line size */
-	{ 0x83, CACHE_L2,	512	},	/* 8-way set assoc, 32 byte line size */
-	{ 0x84, CACHE_L2,	MB(1)	},	/* 8-way set assoc, 32 byte line size */
-	{ 0x85, CACHE_L2,	MB(2)	},	/* 8-way set assoc, 32 byte line size */
-	{ 0x86, CACHE_L2,	512	},	/* 4-way set assoc, 64 byte line size */
-	{ 0x87, CACHE_L2,	MB(1)	},	/* 8-way set assoc, 64 byte line size */
-	{ 0xd0, CACHE_L3,	512	},	/* 4-way set assoc, 64 byte line size */
-	{ 0xd1, CACHE_L3,	MB(1)	},	/* 4-way set assoc, 64 byte line size */
-	{ 0xd2, CACHE_L3,	MB(2)	},	/* 4-way set assoc, 64 byte line size */
-	{ 0xd6, CACHE_L3,	MB(1)	},	/* 8-way set assoc, 64 byte line size */
-	{ 0xd7, CACHE_L3,	MB(2)	},	/* 8-way set assoc, 64 byte line size */
-	{ 0xd8, CACHE_L3,	MB(4)	},	/* 12-way set assoc, 64 byte line size */
-	{ 0xdc, CACHE_L3,	MB(2)	},	/* 12-way set assoc, 64 byte line size */
-	{ 0xdd, CACHE_L3,	MB(4)	},	/* 12-way set assoc, 64 byte line size */
-	{ 0xde, CACHE_L3,	MB(8)	},	/* 12-way set assoc, 64 byte line size */
-	{ 0xe2, CACHE_L3,	MB(2)	},	/* 16-way set assoc, 64 byte line size */
-	{ 0xe3, CACHE_L3,	MB(4)	},	/* 16-way set assoc, 64 byte line size */
-	{ 0xe4, CACHE_L3,	MB(8)	},	/* 16-way set assoc, 64 byte line size */
-	{ 0xea, CACHE_L3,	MB(12)	},	/* 24-way set assoc, 64 byte line size */
-	{ 0xeb, CACHE_L3,	MB(18)	},	/* 24-way set assoc, 64 byte line size */
-	{ 0xec, CACHE_L3,	MB(24)	},	/* 24-way set assoc, 64 byte line size */
-};
-
-
 enum _cache_type {
 	CTYPE_NULL = 0,
 	CTYPE_DATA = 1,
@@ -436,16 +352,6 @@ void init_hygon_cacheinfo(struct cpuinfo_x86 *c)
 	ci->num_leaves = find_num_cache_leaves(c);
 }
 
-static const struct _cache_table *cache_table_get(u8 desc)
-{
-	for (int i = 0; i < ARRAY_SIZE(cache_table); i++) {
-		if (cache_table[i].descriptor == desc)
-			return &cache_table[i];
-	}
-
-	return NULL;
-}
-
 void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 {
 	/* Cache sizes */
@@ -502,21 +408,17 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 
 	/* Don't use CPUID(2) if CPUID(4) is supported. */
 	if (!ci->num_leaves && c->cpuid_level > 1) {
-		const struct _cache_table *entry;
+		const struct leaf_0x2_table *entry;
 		union leaf_0x2_regs regs;
-		u8 *desc;
+		u8 *ptr;
 
 		cpuid_get_leaf_0x2_regs(&regs);
-		for_each_leaf_0x2_desc(regs, desc) {
-			entry = cache_table_get(*desc);
-			if (!entry)
-				continue;
-
-			switch (entry->type) {
-			case CACHE_L1_INST:	l1i += entry->size; break;
-			case CACHE_L1_DATA:	l1d += entry->size; break;
-			case CACHE_L2:		l2  += entry->size; break;
-			case CACHE_L3:		l3  += entry->size; break;
+		for_each_leaf_0x2_entry(regs, ptr, entry) {
+			switch (entry->c_type) {
+			case CACHE_L1_INST:	l1i += entry->c_size; break;
+			case CACHE_L1_DATA:	l1d += entry->c_size; break;
+			case CACHE_L2:		l2  += entry->c_size; break;
+			case CACHE_L3:		l3  += entry->c_size; break;
 			}
 		}
 	}
-- 
2.48.1


