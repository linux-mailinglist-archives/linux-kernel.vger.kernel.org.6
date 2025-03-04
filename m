Return-Path: <linux-kernel+bounces-543557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFE0A4D70A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A523AF94D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80871FF1B8;
	Tue,  4 Mar 2025 08:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CFg9Antq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3WGlTcb0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65CB1FF1CC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078378; cv=none; b=EU2miwXEr3ZBHxccLIUfSrgyWcEFO+qijPtbAqYJCzUBvgZyJ1vqlk3NRo/7W3mafxoIyO27Zd8cJBALPziIYkL9b+adW7U9j1NGegIfkOuwz1eNx3d3fgBef93BpFmjWuu4Z6pVeAYXUxhl+KqlDzoId9HtFBq8eEPjVHw5VtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078378; c=relaxed/simple;
	bh=EnEH/HxL7CFApfE2738rn4UaluGnGilQnm9yKXmH4pM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYE6ObufytM81aDXx6yKDb3k3k2JgyHOXgJhy2Pr1iYk1SS41qzheo9pYQH217wPedWHmKMdQ8XqWnNHRCGWDAYGCSbzDQvL+QAIb2pj6ehHTjfMfGZEul6Hzg+799vkHKnOYDTx3d4kljE13hoMdV6vqs+9+5d/jCqTOD/NL2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CFg9Antq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3WGlTcb0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gIkB3EWOtaCyLLbuByoHG0PeQx63B1yTmcOIalcAzmE=;
	b=CFg9Antq/UQcZuu6IrARirHs+nWuVHcFNTarQvG6e529eblIKQKundAaYXS7vyBhfMZ3lh
	iX243a0zFhI6xXfVktxAQNrqsexIrE/fQmUToOp5WbSw9QVTcqW58xhzEHzVVMm5/VRjz0
	lmV1uFMBRgAKyZ+KFHgtfBH9jSqMc5Z/O6vd/su2d9G2Sr515aa3983wugT0j4a1x9ixwQ
	rsPJOjt28mDGdvfw9BY47+m2VfLRn2N8QmJHgfUcpiB6DpHYZ8sLbXAyGDvqbiEvLWmbq9
	tzhhUBv6MrZNExxRz03HvfthnXWPVXTgSiHCxmVT7brWwrCQkUE/uLqTRLvq/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gIkB3EWOtaCyLLbuByoHG0PeQx63B1yTmcOIalcAzmE=;
	b=3WGlTcb08Zk/VlD+EYPxL7YSE+/5yDkNPktNeGTZp/kSE9SUDT8XeOOBdtN+Hq5S1+uG0e
	vNdvaHciFcQyScBA==
To: Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 14/40] x86/cacheinfo: Refactor leaf 0x2 cache descriptor lookup
Date: Tue,  4 Mar 2025 09:51:25 +0100
Message-ID: <20250304085152.51092-15-darwi@linutronix.de>
In-Reply-To: <20250304085152.51092-1-darwi@linutronix.de>
References: <20250304085152.51092-1-darwi@linutronix.de>
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

[darwi: Move refactoring logic into this separate commit + commit log.
	Remove the cache table termination entry.]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/cacheinfo.c | 45 +++++++++++++++------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index ebd72016e7a2..3be7ea8444ec 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -123,7 +123,6 @@ static const struct _cache_table cache_table[] =
 	{ 0xea, LVL_3,      MB(12) },	/* 24-way set assoc, 64 byte line size */
 	{ 0xeb, LVL_3,      MB(18) },	/* 24-way set assoc, 64 byte line size */
 	{ 0xec, LVL_3,      MB(24) },	/* 24-way set assoc, 64 byte line size */
-	{ 0x00, 0, 0}
 };
 
 
@@ -728,6 +727,16 @@ void init_hygon_cacheinfo(struct cpuinfo_x86 *c)
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
@@ -784,35 +793,21 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 
 	/* Don't use CPUID(2) if CPUID(4) is supported. */
 	if (!ci->num_leaves && c->cpuid_level > 1) {
+		const struct _cache_table *entry;
 		union leaf_0x2_regs regs;
 		u8 *desc;
 
 		get_leaf_0x2_regs(&regs);
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


