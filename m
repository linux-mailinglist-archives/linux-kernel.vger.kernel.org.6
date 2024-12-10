Return-Path: <linux-kernel+bounces-439394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E17F9EAEAE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7FD6161C78
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F403210F49;
	Tue, 10 Dec 2024 10:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Rmj4ptRD"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136AE2080FC
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 10:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733827714; cv=none; b=NFyxN1CqR04RjWJe96UPh0uSGN7N3SBlQnS3oFsTT4Tl1yBs2NDeMB+ZhuokPJolh8eqEovQTapJASQwqSlvJdUBEzSxy9fAen/TOcO1y99WTmnTgJS1iGtm+HZHOjeYbgOrafCWjqm95awpN3sBJsChMsRD0kbtx5OzZAxigSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733827714; c=relaxed/simple;
	bh=udFpJUt2iNXFam6frSHYMGUmPDtnLrv0YuWcLc0RN2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WN+3XAh9YNv8NC3RLHqhC/SoIEXMdXZI02cMZoBp/I2s5ZjAELMve7StLtIrTtM3N6XB7dtEc5zpV1xvLmpJhd6hElIwJ6NMg+hqhcWuJsoik5wcWTt7A2KPQQZt+eQGeWO4UG2Gm4f8RwL1jN9cJ1F+YRKwS5cMonBgZZmfsrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Rmj4ptRD; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E420C40E0289;
	Tue, 10 Dec 2024 10:48:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8SNOvJNl9D2W; Tue, 10 Dec 2024 10:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1733827705; bh=rp/HPwcOG6SHLDrX7OsCDAddOzEAQgCXp09fzFS8OpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rmj4ptRDqAAjHg3x2s5ea2gq/2aXtarJpDvj6V9NrmVIowRztDrUJfDtO/5VF1U4a
	 /fa0fq0HLLaXrnXHji2Jjs2/tHrNrK8/t1P6imruTElsA3TYgiQhzNbT21PeEWHu5K
	 fBqG3E7fAjMf7PJ48VSGt5B8SD2AlR6kHWnrwvbaBgay/ETv9ifMQ7wvBIM0MosGA8
	 FGn1ZB7Pd1n4PO9cOOG82DNRVToEpOglAbQNADE6COSGt0wZfQ/JB21kgVbiueXYiA
	 fOV364Oc85gEHZtTce4Ri8kmomna28/fYvcputHOl6EaLfNddy+OazdrON5KmBbwYo
	 46Hkf/PBUh7MY3p2McpvClmRhbv9/FOv/2I5rDANCoaHL9ZuyAeZzF3kczYRpV0ACQ
	 Q6TbXZ9//UD/OGiiGdJAxzVjGwYDv78vNVlSwUggwmtMgNmsK3QBBpLzvs5FAHkfhD
	 QroSo85rLca9XIamGN9uNO0ZPe7JY7Ic1qDEhBjgphBvwErQKar6f31cNChF/zDNI8
	 IPw/+mgo/aH5LDb+sd8ZzbDCKulAKEW97pWFUhnCe1qKtzWSvycVqSw2aufJpfIBOY
	 kqpzmE0mfJ+jQF5SlXApMDPeZSIZPzpYR6gYo9GZTa+lMaU+Q+oSToISBfurjELtqp
	 NNUR7ZvVgFAH+1LePS2zw1+Y=
Received: from zn.tnic (p200300Ea971f9307329C23FFFeA6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:9307:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 93F5B40E0277;
	Tue, 10 Dec 2024 10:48:15 +0000 (UTC)
Date: Tue, 10 Dec 2024 11:48:10 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: Re: [PATCH v6 6/8] x86/sev: Treat the contiguous RMP table as a
 single RMP segment
Message-ID: <20241210104810.GDZ1gcapB4bTh2Nf-o@fat_crate.local>
References: <cover.1733172653.git.thomas.lendacky@amd.com>
 <8c40fbc9c5217f0d79b37cf861eff03ab0330bef.1733172653.git.thomas.lendacky@amd.com>
 <20241209194320.GCZ1dIWDMPppdXgzxJ@fat_crate.local>
 <20241210102835.GCZ1gX04evsuTcS01d@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241210102835.GCZ1gX04evsuTcS01d@fat_crate.local>

Final version I have now:

From: Tom Lendacky <thomas.lendacky@amd.com>
Date: Mon, 2 Dec 2024 14:50:51 -0600
Subject: [PATCH] x86/sev: Treat the contiguous RMP table as a single RMP segment

In preparation for support of a segmented RMP table, treat the contiguous
RMP table as a segmented RMP table with a single segment covering all
of memory. By treating a contiguous RMP table as a single segment, much
of the code that initializes and accesses the RMP can be re-used.

Segmented RMP tables can have up to 512 segment entries. Each segment
will have metadata associated with it to identify the segment location,
the segment size, etc. The segment data and the physical address are used
to determine the index of the segment within the table and then the RMP
entry within the segment. For an actual segmented RMP table environment,
much of the segment information will come from a configuration MSR. For
the contiguous RMP, though, much of the information will be statically
defined.

  [ bp: Touchups, explain array_index_nospec() usage. ]

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Link: https://lore.kernel.org/r/8c40fbc9c5217f0d79b37cf861eff03ab0330bef.1733172653.git.thomas.lendacky@amd.com
---
 arch/x86/virt/svm/sev.c | 199 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 180 insertions(+), 19 deletions(-)

diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 2899c2e28db9..e50b71c67fab 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -18,6 +18,7 @@
 #include <linux/cpumask.h>
 #include <linux/iommu.h>
 #include <linux/amd-iommu.h>
+#include <linux/nospec.h>
 
 #include <asm/sev.h>
 #include <asm/processor.h>
@@ -77,12 +78,42 @@ struct rmpentry_raw {
  */
 #define RMPTABLE_CPU_BOOKKEEPING_SZ	0x4000
 
+/*
+ * For a non-segmented RMP table, use the maximum physical addressing as the
+ * segment size in order to always arrive at index 0 in the table.
+ */
+#define RMPTABLE_NON_SEGMENTED_SHIFT	52
+
+struct rmp_segment_desc {
+	struct rmpentry_raw *rmp_entry;
+	u64 max_index;
+	u64 size;
+};
+
+/*
+ * Segmented RMP Table support.
+ *   - The segment size is used for two purposes:
+ *     - Identify the amount of memory covered by an RMP segment
+ *     - Quickly locate an RMP segment table entry for a physical address
+ *
+ *   - The RMP segment table contains pointers to an RMP table that covers
+ *     a specific portion of memory. There can be up to 512 8-byte entries,
+ *     one pages worth.
+ */
+static struct rmp_segment_desc **rmp_segment_table __ro_after_init;
+static unsigned int rst_max_index __ro_after_init = 512;
+
+static unsigned int rmp_segment_shift;
+static u64 rmp_segment_size;
+static u64 rmp_segment_mask;
+
+#define RST_ENTRY_INDEX(x)	((x) >> rmp_segment_shift)
+#define RMP_ENTRY_INDEX(x)	((u64)(PHYS_PFN((x) & rmp_segment_mask)))
+
 /* Mask to apply to a PFN to get the first PFN of a 2MB page */
 #define PFN_PMD_MASK	GENMASK_ULL(63, PMD_SHIFT - PAGE_SHIFT)
 
 static u64 probed_rmp_base, probed_rmp_size;
-static struct rmpentry_raw *rmptable __ro_after_init;
-static u64 rmptable_max_pfn __ro_after_init;
 
 static LIST_HEAD(snp_leaked_pages_list);
 static DEFINE_SPINLOCK(snp_leaked_pages_list_lock);
@@ -190,6 +221,92 @@ static bool __init clear_rmptable_bookkeeping(void)
 	return true;
 }
 
+static bool __init alloc_rmp_segment_desc(u64 segment_pa, u64 segment_size, u64 pa)
+{
+	u64 rst_index, rmp_segment_size_max;
+	struct rmp_segment_desc *desc;
+	void *rmp_segment;
+
+	/* Calculate the maximum size an RMP can be (16 bytes/page mapped) */
+	rmp_segment_size_max = PHYS_PFN(rmp_segment_size) << 4;
+
+	/* Validate the RMP segment size */
+	if (segment_size > rmp_segment_size_max) {
+		pr_err("Invalid RMP size 0x%llx for configured segment size 0x%llx\n",
+		       segment_size, rmp_segment_size_max);
+		return false;
+	}
+
+	/* Validate the RMP segment table index */
+	rst_index = RST_ENTRY_INDEX(pa);
+	if (rst_index >= rst_max_index) {
+		pr_err("Invalid RMP segment base address 0x%llx for configured segment size 0x%llx\n",
+		       pa, rmp_segment_size);
+		return false;
+	}
+
+	if (rmp_segment_table[rst_index]) {
+		pr_err("RMP segment descriptor already exists at index %llu\n", rst_index);
+		return false;
+	}
+
+	rmp_segment = memremap(segment_pa, segment_size, MEMREMAP_WB);
+	if (!rmp_segment) {
+		pr_err("Failed to map RMP segment addr 0x%llx size 0x%llx\n",
+		       segment_pa, segment_size);
+		return false;
+	}
+
+	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
+	if (!desc) {
+		memunmap(rmp_segment);
+		return false;
+	}
+
+	desc->rmp_entry = rmp_segment;
+	desc->max_index = segment_size / sizeof(*desc->rmp_entry);
+	desc->size = segment_size;
+
+	rmp_segment_table[rst_index] = desc;
+
+	return true;
+}
+
+static void __init free_rmp_segment_table(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < rst_max_index; i++) {
+		struct rmp_segment_desc *desc;
+
+		desc = rmp_segment_table[i];
+		if (!desc)
+			continue;
+
+		memunmap(desc->rmp_entry);
+
+		kfree(desc);
+	}
+
+	free_page((unsigned long)rmp_segment_table);
+
+	rmp_segment_table = NULL;
+}
+
+/* Allocate the table used to index into the RMP segments */
+static bool __init alloc_rmp_segment_table(void)
+{
+	struct page *page;
+
+	page = alloc_page(__GFP_ZERO);
+	if (!page)
+		return false;
+
+	rmp_segment_table = page_address(page);
+
+	return true;
+}
+
 /*
  * Do the necessary preparations which are verified by the firmware as
  * described in the SNP_INIT_EX firmware command description in the SNP
@@ -197,8 +314,8 @@ static bool __init clear_rmptable_bookkeeping(void)
  */
 static int __init snp_rmptable_init(void)
 {
-	u64 max_rmp_pfn, calc_rmp_sz, rmptable_size, rmp_end, val;
-	void *rmptable_start;
+	u64 max_rmp_pfn, calc_rmp_sz, rmptable_segment, rmptable_size, rmp_end, val;
+	unsigned int i;
 
 	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
 		return 0;
@@ -227,17 +344,18 @@ static int __init snp_rmptable_init(void)
 		goto nosnp;
 	}
 
+	if (!alloc_rmp_segment_table())
+		goto nosnp;
+
 	/* Map only the RMP entries */
-	rmptable_start = memremap(probed_rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ,
-				  probed_rmp_size - RMPTABLE_CPU_BOOKKEEPING_SZ,
-				  MEMREMAP_WB);
-	if (!rmptable_start) {
-		pr_err("Failed to map RMP table\n");
+	rmptable_segment = probed_rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ;
+	rmptable_size    = probed_rmp_size - RMPTABLE_CPU_BOOKKEEPING_SZ;
+
+	if (!alloc_rmp_segment_desc(rmptable_segment, rmptable_size, 0)) {
+		free_rmp_segment_table();
 		goto nosnp;
 	}
 
-	rmptable_size = probed_rmp_size - RMPTABLE_CPU_BOOKKEEPING_SZ;
-
 	/*
 	 * Check if SEV-SNP is already enabled, this can happen in case of
 	 * kexec boot.
@@ -248,12 +366,20 @@ static int __init snp_rmptable_init(void)
 
 	/* Zero out the RMP bookkeeping area */
 	if (!clear_rmptable_bookkeeping()) {
-		memunmap(rmptable_start);
+		free_rmp_segment_table();
 		goto nosnp;
 	}
 
 	/* Zero out the RMP entries */
-	memset(rmptable_start, 0, rmptable_size);
+	for (i = 0; i < rst_max_index; i++) {
+		struct rmp_segment_desc *desc;
+
+		desc = rmp_segment_table[i];
+		if (!desc)
+			continue;
+
+		memset(desc->rmp_entry, 0, desc->size);
+	}
 
 	/* Flush the caches to ensure that data is written before SNP is enabled. */
 	wbinvd_on_all_cpus();
@@ -264,9 +390,6 @@ static int __init snp_rmptable_init(void)
 	on_each_cpu(snp_enable, NULL, 1);
 
 skip_enable:
-	rmptable = (struct rmpentry_raw *)rmptable_start;
-	rmptable_max_pfn = rmptable_size / sizeof(struct rmpentry_raw) - 1;
-
 	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/rmptable_init:online", __snp_enable, NULL);
 
 	/*
@@ -287,6 +410,13 @@ static int __init snp_rmptable_init(void)
  */
 device_initcall(snp_rmptable_init);
 
+static void set_rmp_segment_info(unsigned int segment_shift)
+{
+	rmp_segment_shift = segment_shift;
+	rmp_segment_size  = 1ULL << rmp_segment_shift;
+	rmp_segment_mask  = rmp_segment_size - 1;
+}
+
 #define RMP_ADDR_MASK GENMASK_ULL(51, 13)
 
 bool snp_probe_rmptable_info(void)
@@ -308,6 +438,11 @@ bool snp_probe_rmptable_info(void)
 
 	rmp_sz = rmp_end - rmp_base + 1;
 
+	/* Treat the contiguous RMP table as a single segment */
+	rst_max_index = 1;
+
+	set_rmp_segment_info(RMPTABLE_NON_SEGMENTED_SHIFT);
+
 	probed_rmp_base = rmp_base;
 	probed_rmp_size = rmp_sz;
 
@@ -317,15 +452,41 @@ bool snp_probe_rmptable_info(void)
 	return true;
 }
 
+/*
+ * About the array_index_nospec() usage below:
+ *
+ * This function can get called by exported functions like
+ * snp_lookup_rmpentry(), which is used by the KVM #PF handler, among
+ * others, and since the @pfn passed in cannot always be trusted,
+ * speculation should be stopped as a protective measure.
+ */
 static struct rmpentry_raw *get_raw_rmpentry(u64 pfn)
 {
-	if (!rmptable)
+	u64 paddr, rst_index, segment_index;
+	struct rmp_segment_desc *desc;
+
+	if (!rmp_segment_table)
 		return ERR_PTR(-ENODEV);
 
-	if (unlikely(pfn > rmptable_max_pfn))
+	paddr = pfn << PAGE_SHIFT;
+
+	rst_index = RST_ENTRY_INDEX(paddr);
+	if (unlikely(rst_index >= rst_max_index))
 		return ERR_PTR(-EFAULT);
 
-	return rmptable + pfn;
+	rst_index = array_index_nospec(rst_index, rst_max_index);
+
+	desc = rmp_segment_table[rst_index];
+	if (unlikely(!desc))
+		return ERR_PTR(-EFAULT);
+
+	segment_index = RMP_ENTRY_INDEX(paddr);
+	if (unlikely(segment_index >= desc->max_index))
+		return ERR_PTR(-EFAULT);
+
+	segment_index = array_index_nospec(segment_index, desc->max_index);
+
+	return desc->rmp_entry + segment_index;
 }
 
 static int get_rmpentry(u64 pfn, struct rmpentry *e)
-- 
2.43.0


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

