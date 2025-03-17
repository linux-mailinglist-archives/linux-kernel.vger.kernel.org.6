Return-Path: <linux-kernel+bounces-564682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 053FDA6594E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6787F3BB293
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F391CCEC8;
	Mon, 17 Mar 2025 16:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dqsa8BB4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d+lU0vpK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015C31C84C5
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742230368; cv=none; b=u20ihMXUQ1CxXPvnuvDkMgVBBBid6O7S8HRGsOcuBdDpPWrTY4nEZfcq5M+wO4S+NawkjxuEhzaTVWCCZjMqIBaBiqKyTfH6xJlGCAc8vj2aoQi0zavyrLSIBL1btsFDgSlJbA9p+dNGa5uqRxPQZhGU4906XMZCkHayl9ElmtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742230368; c=relaxed/simple;
	bh=W2prbeleO7CZ2jyqXPaYjzTIRLUOo8EZt3Nsn6LDAvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RzwEERF3BJ22Cn0tprYs+P9FHSzCwpKUs3Azp8yYBlwgxwTYwKv6KVS5INOnuyelxV/59vULT2pV70GBFg6ZkL9OHIWHqx1jI7vzTcuT8g1uujkRUYbxEwofeSY8Siq85rAuqOl/g94aCRNdPYagEoHaqLEqXQXfckCiZ6T2ogE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dqsa8BB4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d+lU0vpK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742230365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V+eCc36ij0h2Cy4MVk4v7AsAAWFDxsm4OiZDh3DyaOY=;
	b=Dqsa8BB4qUAoql0q6IbkmmVMdHdm6tt5Eu2lYwXX/K2yOdNQY+kycH4C69KfV4Ac+6NtcU
	ZeLw5I8LZiTqyz0tZjtNQUMUOci4ARJhUClzP6D1k8YsPWMCOfu/CTzRPldj6CfXZQaJxO
	ocrm6Zs5viYTLuTChpfkanjU5sq7lsELwj3+lJGmAGrEortFTnRzm9Li/+M2eAU9N7I1nI
	DdcSDaOrF/P5q+h3BYTIsxMl+T3cfq5Q8SQ5rkLsVdQ7/LnrHlaBrcUQOmuIUhMXwtuBzU
	VXcBdxyGkaFaYPyvztlskX+/NPB213m44di8534VJZSE7MRRIYhkxcjfrVUHzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742230365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V+eCc36ij0h2Cy4MVk4v7AsAAWFDxsm4OiZDh3DyaOY=;
	b=d+lU0vpKJ2Fxgfg/+rAA2aH6g7nFjeJnrnkXxYH8PbR8R+anN5HSnvZmteAtRUerSEWlsS
	uH9R8yjJqyPe4tBQ==
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
Subject: [PATCH v2 05/29] x86/cacheinfo: Refactor leaf 0x2 cache descriptor lookup
Date: Mon, 17 Mar 2025 17:47:21 +0100
Message-ID: <20250317164745.4754-6-darwi@linutronix.de>
In-Reply-To: <20250317164745.4754-1-darwi@linutronix.de>
References: <20250317164745.4754-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

Extract the cache descriptor lookup logic out of the leaf 0x2 parsing
code and into a dedicated function.  This disentangles such lookup from
the deeply nested leaf 0x2 parsing loop.

Remove the cache table termination entry, as it is no longer needed
after the ARRAY_SIZE()-based lookup.

[ darwi: Move refactoring logic into this separate commit + commit log.
	 Remove the cache table termination entry. ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/cacheinfo.c | 45 +++++++++++++++------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 53f51acefac6..44bc044aa9a2 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -123,7 +123,6 @@ static const struct _cache_table cache_table[] =
 	{ 0xea, LVL_3,      MB(12) },	/* 24-way set assoc, 64 byte line size */
 	{ 0xeb, LVL_3,      MB(18) },	/* 24-way set assoc, 64 byte line size */
 	{ 0xec, LVL_3,      MB(24) },	/* 24-way set assoc, 64 byte line size */
-	{ 0x00, 0, 0}
 };
 
 
@@ -727,6 +726,16 @@ void init_hygon_cacheinfo(struct cpuinfo_x86 *c)
 	ci->num_leaves = find_num_cache_leaves(c);
 }
 
+static const struct _cache_table *cache_table_get(u8 desc)
+{
+	for (int i = 0; i < ARRAY_SIZE(cache_table); i++) {
+		if (cache_table[i].descriptor == desc)
+			return &cache_table[i];
+	}
+
+	return NULL;
+}
+
 void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 {
 	/* Cache sizes */
@@ -783,35 +792,21 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 
 	/* Don't use CPUID(2) if CPUID(4) is supported. */
 	if (!ci->num_leaves && c->cpuid_level > 1) {
+		const struct _cache_table *entry;
 		union leaf_0x2_regs regs;
 		u8 *desc;
 
 		cpuid_get_leaf_0x2_regs(&regs);
 		for_each_leaf_0x2_desc(regs, desc) {
-			unsigned char k = 0;
-
-			/* look up this descriptor in the table */
-			while (cache_table[k].descriptor != 0) {
-				if (cache_table[k].descriptor == *desc) {
-					switch (cache_table[k].cache_type) {
-					case LVL_1_INST:
-						l1i += cache_table[k].size;
-						break;
-					case LVL_1_DATA:
-						l1d += cache_table[k].size;
-						break;
-					case LVL_2:
-						l2 += cache_table[k].size;
-						break;
-					case LVL_3:
-						l3 += cache_table[k].size;
-						break;
-					}
-
-					break;
-				}
-
-					k++;
+			entry = cache_table_get(*desc);
+			if (!entry)
+				continue;
+
+			switch (entry->cache_type) {
+			case LVL_1_INST: l1i += entry->size; break;
+			case LVL_1_DATA: l1d += entry->size; break;
+			case LVL_2:	 l2  += entry->size; break;
+			case LVL_3:	 l3  += entry->size; break;
 			}
 		}
 	}
-- 
2.48.1


