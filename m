Return-Path: <linux-kernel+bounces-564701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95901A6597A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9909C3BE3F7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F2B205E0E;
	Mon, 17 Mar 2025 16:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KJy9KEfR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lynnMA2c"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6566205ABE
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742230420; cv=none; b=JmTgqjw0SwgnR4o7XOcCSFzNE/eSKk65Hzhz1Uu+TooKIgMeVDzO5FioLcPuTP2gji1bnUHDY08ZferiIsWXMtOLri08JkNgqOIm9mgfmgVSt+AS/k6mtjpATDRLN02bPI/fUuUCF9b4BJ2c0vPnbO8PBVfu6OuZZXPstUmrZMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742230420; c=relaxed/simple;
	bh=ZM3F5Y56S1zFfwUET9xCN+59OtFCyRbbWIxvPpzy/Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXY/62mVK9fOkSxb2KLrkyGck7SRxWQnglXzpU3chc1LFlw/ctci8jWdkuDl/OgMfklt0LIguqnLiayeCP6hu2qgBMu5eI4mNVWTdAx9kmL5r4Us2mJt+oz195b1ZOhkENTKF2+z64g7r4Ft2SyatsarbA+T48txab5WxbSWLgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KJy9KEfR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lynnMA2c; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742230417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3DLa4uVXuGNd/LtRAHZUCcx002lpeqqKjal5+TQvBDE=;
	b=KJy9KEfR3S60JOpmlEQuZWy68K5hwyAcgAinxY0YQildk9WdEjO4w9do0o0mHCbz2fJsao
	kWtswPsbYYC52/JLCox+5YfP0qHJzVQ3eAVt4ZN45FHv0kOhbJg2o8luXbu4GDx4DamhHz
	VeeiXtvkIxYcbF2MXWraVF6pAwPr8g1j7NAhYsWmARD0qeuA6mhcwtKEejRiIrsR+3ZTZk
	DWDY4CbdXj9cDJm2MtMi0gYF3dpuMbyfavGnexf2o3MCoLETOt0Tx0r64oUAcgL8RP7X2V
	HSGdxxKbFJmw6HBlV3hYyvU6FGdJSNiiLo3/k+tzsSpWVpcvkMUH/FDHc6Zs2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742230417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3DLa4uVXuGNd/LtRAHZUCcx002lpeqqKjal5+TQvBDE=;
	b=lynnMA2cmGBiJIB3FeFd4M9jjlCh2jC0YgCUHE6uKvjujJPvORmNQLvMJ/KXyf8gAHn653
	ZI7lkMF56HaqAcAw==
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
Subject: [PATCH v2 22/29] x86/cpu: Use consolidated leaf 0x2 descriptor table
Date: Mon, 17 Mar 2025 17:47:38 +0100
Message-ID: <20250317164745.4754-23-darwi@linutronix.de>
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
for_each_leaf_0x2_tlb_entry() accessor.

Remove the TLB-specific mapping, intel_tlb_table[], as it is now no
longer used.  Remove the <cpuid/types.h> macro, for_each_leaf_0x2_desc(),
since the converted code was its last user.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/include/asm/cpuid/types.h | 10 ++++
 arch/x86/kernel/cpu/intel.c        | 83 +++---------------------------
 2 files changed, 17 insertions(+), 76 deletions(-)

diff --git a/arch/x86/include/asm/cpuid/types.h b/arch/x86/include/asm/cpuid/types.h
index 172fc88dc685..3216d396c74d 100644
--- a/arch/x86/include/asm/cpuid/types.h
+++ b/arch/x86/include/asm/cpuid/types.h
@@ -108,4 +108,14 @@ struct leaf_0x2_table {
 
 extern const struct leaf_0x2_table cpuid_0x2_table[256];
 
+/*
+ * All of leaf 0x2's one-byte TLB descriptors implies the same number of entries
+ * for their respective TLB types.  TLB descriptor 0x63 is an exception: it
+ * implies 4 dTLB entries for 1GB pages and 32 dTLB entries for 2MB or 4MB pages.
+ *
+ * Encode that descriptor's dTLB entry count for 2MB/4MB pages here, as the entry
+ * count for dTLB 1GB pages is already encoded at the cpuid_0x2_table[]'s mapping.
+ */
+#define TLB_0x63_2M_4M_ENTRIES		32
+
 #endif /* _ASM_X86_CPUID_TYPES_H */
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index fbdc91bd1da6..001ae707dc7c 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -627,81 +627,11 @@ static unsigned int intel_size_cache(struct cpuinfo_x86 *c, unsigned int size)
 }
 #endif
 
-/*
- * All of leaf 0x2's one-byte TLB descriptors implies the same number of
- * entries for their respective TLB types.  The 0x63 descriptor is an
- * exception: it implies 4 dTLB entries for 1GB pages 32 dTLB entries
- * for 2MB or 4MB pages.  Encode descriptor 0x63 dTLB entry count for
- * 2MB/4MB pages here, as its count for dTLB 1GB pages is already at the
- * intel_tlb_table[] mapping.
- */
-#define TLB_0x63_2M_4M_ENTRIES	32
-
-struct _tlb_table {
-	unsigned char descriptor;
-	enum _tlb_table_type type;
-	unsigned int entries;
-};
-
-static const struct _tlb_table intel_tlb_table[] = {
-	{ 0x01, TLB_INST_4K,		32},	/* TLB_INST 4 KByte pages, 4-way set associative */
-	{ 0x02, TLB_INST_4M,		2},	/* TLB_INST 4 MByte pages, full associative */
-	{ 0x03, TLB_DATA_4K,		64},	/* TLB_DATA 4 KByte pages, 4-way set associative */
-	{ 0x04, TLB_DATA_4M,		8},	/* TLB_DATA 4 MByte pages, 4-way set associative */
-	{ 0x05, TLB_DATA_4M,		32},	/* TLB_DATA 4 MByte pages, 4-way set associative */
-	{ 0x0b, TLB_INST_4M,		4},	/* TLB_INST 4 MByte pages, 4-way set associative */
-	{ 0x4f, TLB_INST_4K,		32},	/* TLB_INST 4 KByte pages */
-	{ 0x50, TLB_INST_ALL,		64},	/* TLB_INST 4 KByte and 2-MByte or 4-MByte pages */
-	{ 0x51, TLB_INST_ALL,		128},	/* TLB_INST 4 KByte and 2-MByte or 4-MByte pages */
-	{ 0x52, TLB_INST_ALL,		256},	/* TLB_INST 4 KByte and 2-MByte or 4-MByte pages */
-	{ 0x55, TLB_INST_2M_4M,		7},	/* TLB_INST 2-MByte or 4-MByte pages, fully associative */
-	{ 0x56, TLB_DATA0_4M,		16},	/* TLB_DATA0 4 MByte pages, 4-way set associative */
-	{ 0x57, TLB_DATA0_4K,		16},	/* TLB_DATA0 4 KByte pages, 4-way associative */
-	{ 0x59, TLB_DATA0_4K,		16},	/* TLB_DATA0 4 KByte pages, fully associative */
-	{ 0x5a, TLB_DATA0_2M_4M,	32},	/* TLB_DATA0 2-MByte or 4 MByte pages, 4-way set associative */
-	{ 0x5b, TLB_DATA_4K_4M,		64},	/* TLB_DATA 4 KByte and 4 MByte pages */
-	{ 0x5c, TLB_DATA_4K_4M,		128},	/* TLB_DATA 4 KByte and 4 MByte pages */
-	{ 0x5d, TLB_DATA_4K_4M,		256},	/* TLB_DATA 4 KByte and 4 MByte pages */
-	{ 0x61, TLB_INST_4K,		48},	/* TLB_INST 4 KByte pages, full associative */
-	{ 0x63, TLB_DATA_1G_2M_4M,	4},	/* TLB_DATA 1 GByte pages, 4-way set associative
-						 * (plus 32 entries TLB_DATA 2 MByte or 4 MByte pages, not encoded here) */
-	{ 0x6b, TLB_DATA_4K,		256},	/* TLB_DATA 4 KByte pages, 8-way associative */
-	{ 0x6c, TLB_DATA_2M_4M,		128},	/* TLB_DATA 2 MByte or 4 MByte pages, 8-way associative */
-	{ 0x6d, TLB_DATA_1G,		16},	/* TLB_DATA 1 GByte pages, fully associative */
-	{ 0x76, TLB_INST_2M_4M,		8},	/* TLB_INST 2-MByte or 4-MByte pages, fully associative */
-	{ 0xb0, TLB_INST_4K,		128},	/* TLB_INST 4 KByte pages, 4-way set associative */
-	{ 0xb1, TLB_INST_2M_4M,		4},	/* TLB_INST 2M pages, 4-way, 8 entries or 4M pages, 4-way entries */
-	{ 0xb2, TLB_INST_4K,		64},	/* TLB_INST 4KByte pages, 4-way set associative */
-	{ 0xb3, TLB_DATA_4K,		128},	/* TLB_DATA 4 KByte pages, 4-way set associative */
-	{ 0xb4, TLB_DATA_4K,		256},	/* TLB_DATA 4 KByte pages, 4-way associative */
-	{ 0xb5, TLB_INST_4K,		64},	/* TLB_INST 4 KByte pages, 8-way set associative */
-	{ 0xb6, TLB_INST_4K,		128},	/* TLB_INST 4 KByte pages, 8-way set associative */
-	{ 0xba, TLB_DATA_4K,		64},	/* TLB_DATA 4 KByte pages, 4-way associative */
-	{ 0xc0, TLB_DATA_4K_4M,		8},	/* TLB_DATA 4 KByte and 4 MByte pages, 4-way associative */
-	{ 0xc1, STLB_4K_2M,		1024},	/* STLB 4 KByte and 2 MByte pages, 8-way associative */
-	{ 0xc2, TLB_DATA_2M_4M,		16},	/* TLB_DATA 2 MByte/4MByte pages, 4-way associative */
-	{ 0xca, STLB_4K,		512},	/* STLB 4 KByte pages, 4-way associative */
-	{ 0x00, 0, 0 }
-};
-
-static void intel_tlb_lookup(const unsigned char desc)
+static void intel_tlb_lookup(const struct leaf_0x2_table *entry)
 {
-	unsigned int entries;
-	unsigned char k;
-
-	if (desc == 0)
-		return;
-
-	/* look up this descriptor in the table */
-	for (k = 0; intel_tlb_table[k].descriptor != desc &&
-	     intel_tlb_table[k].descriptor != 0; k++)
-		;
-
-	if (intel_tlb_table[k].type == 0)
-		return;
+	short entries = entry->entries;
 
-	entries = intel_tlb_table[k].entries;
-	switch (intel_tlb_table[k].type) {
+	switch (entry->t_type) {
 	case STLB_4K:
 		tlb_lli_4k = max(tlb_lli_4k, entries);
 		tlb_lld_4k = max(tlb_lld_4k, entries);
@@ -758,15 +688,16 @@ static void intel_tlb_lookup(const unsigned char desc)
 
 static void intel_detect_tlb(struct cpuinfo_x86 *c)
 {
+	const struct leaf_0x2_table *entry;
 	union leaf_0x2_regs regs;
-	u8 *desc;
+	u8 *ptr;
 
 	if (c->cpuid_level < 2)
 		return;
 
 	cpuid_get_leaf_0x2_regs(&regs);
-	for_each_leaf_0x2_desc(regs, desc)
-		intel_tlb_lookup(*desc);
+	for_each_leaf_0x2_entry(regs, ptr, entry)
+		intel_tlb_lookup(entry);
 }
 
 static const struct cpu_dev intel_cpu_dev = {
-- 
2.48.1


