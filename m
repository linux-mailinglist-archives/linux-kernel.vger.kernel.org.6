Return-Path: <linux-kernel+bounces-567976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 704E5A68CBA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0648F883AD5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69A425742D;
	Wed, 19 Mar 2025 12:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1IwEPkpZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p2+nR7PM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE4A257421
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 12:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742386923; cv=none; b=EERfQNYRdicMiTUs0DjGmbe7S9U1eP+3Juq9thYJhhrvQvMv7zQdk/h2LDhUQMilTfLLHnt7nP8WvN1Ph3l7klm6C6UlPZyUfL8NoxANcRmd024dksBdksL0TOHH1qV4iGijGdmouqzzlTfOH+yiZF+qTJP3At8adyBo5yL9+Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742386923; c=relaxed/simple;
	bh=M+UjdWU1Oj03lS1BlbZCoMM+wkEo5EnfsyMkuYsbMLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBNETy4/VoWszfeSyi8COghKKiUWV8UEevk2SHVhe6QBVd7UNDCmrsudDJ0s5E5p2WLu9xOyPwXWx6QiLydy4wOGM21x/75gR4HBi4lVk70GQRLCOXTj9LPRC5zL9xVjaH3aTes8iNDqom58QmrVVumhrhYUodeKCBk37gcnQAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1IwEPkpZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p2+nR7PM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742386920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d1xoRCk3B1mA4GEq9/A/G6CTAf5k+cJfXB1LIKxQQJ4=;
	b=1IwEPkpZgnMwtsp1PYlt1UqjMlBm/dsGTJQwR548y17beRDOkkl7RC2kCva/Z0oLGofmVe
	/wIxBLcVoQpXKmC91opPFmuHI5ssGBwhS5YmE0+qlH7ZOwrSFRXhx+Wk+SohqH/MD9VtcP
	uuMVNHtgVb/IHygW/q1ePFVsh6XOxrkl9NngZWfDD4x0vO/fV/U0oSGR8v1lHHCosZBbRJ
	Eo+RzqpYWR2Dy4+aeIqPHWm/jE/BHSTj8TMdwu4oFHdrXQAsVppBShsQGK8vZ06WgOPWMm
	xULo5bJ6zKogDm0LUbaPw3zGw2VWoXltS4gBwqWlWVCEsIr+Ywk99apxK8ZXtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742386920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d1xoRCk3B1mA4GEq9/A/G6CTAf5k+cJfXB1LIKxQQJ4=;
	b=p2+nR7PM41UhljpAoDvOKuYY92TK8cEeUj4SXEtqbVm84hAbvesmgURhg9LBJ1Ibpb4jBI
	H9+/BzYS2beetUDA==
To: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v3 05/29] x86/cacheinfo: Refactor leaf 0x2 cache descriptor lookup
Date: Wed, 19 Mar 2025 13:21:13 +0100
Message-ID: <20250319122137.4004-6-darwi@linutronix.de>
In-Reply-To: <20250319122137.4004-1-darwi@linutronix.de>
References: <20250319122137.4004-1-darwi@linutronix.de>
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
 arch/x86/kernel/cpu/cacheinfo.c | 44 +++++++++++++++------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 6c610805e356..d0bfdb85b96a 100644
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
@@ -784,34 +793,21 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 
 	/* Don't use CPUID(2) if CPUID(4) is supported. */
 	if (!ci->num_leaves && c->cpuid_level > 1) {
+		const struct _cache_table *entry;
 		union leaf_0x2_regs regs;
 		u8 *desc;
 
 		cpuid_get_leaf_0x2_regs(&regs);
 		for_each_leaf_0x2_desc(regs, desc) {
-			u8 k = 0;
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
-				k++;
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


