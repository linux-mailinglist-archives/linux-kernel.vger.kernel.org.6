Return-Path: <linux-kernel+bounces-322930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C98A49734B9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 12:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEB171C24FA1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D72190052;
	Tue, 10 Sep 2024 10:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="J5DMDmzr";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fXDtBABu"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900361946CA
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 10:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725964803; cv=none; b=aXfOH9edN7ASvVxjb+wCScj7h+GQOYdUHGKAYUmxZS/SANlLItCtryXQKAxZN7d6JQTpwmEgCzJJ1w8eUbjY5u0LLM7tjVV7oL5DgH1Bo890vyz8eHYefDpCABwwCui2tPzfNtDaxArR6CrWLzzJfcSAVHAxFy9OS9KvHiARBMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725964803; c=relaxed/simple;
	bh=Fe/ZpZPzIDPDKEl0nwawip7LUNdBck0LLF6McS7l9fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uk3/6PZlLd3/n12KFcE1IjbNtYme2W7WYF32qWtRSEwY3oDxAKyv5zp0uW0GDtSPH8SGrwUYwr7nSmmrr+LwQorgIMUqU5ZEnBgF0iTEpHRLzra450Cet1bUeIjhAawkJycwttLpMjpEJ00ZghJ3UMSiWAZepstwI49XXG8Smt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=J5DMDmzr; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fXDtBABu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A0C841F7D7;
	Tue, 10 Sep 2024 10:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725964799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eprW9rfhq2cX7ePF/8RtH26O1aYeQlKG+2vFrY0kNmk=;
	b=J5DMDmzrmL2q751QMJ7BvOlZX1CJFCyI65IslU9GmxO0ElFQpwhW5rFALiqJ+FR7duGafZ
	+G+XjPUahI5hxWlaiwVJZOXGn4GSdB5yF1M2e44GkKYTPKdaD0lFH1ldeUOY0p3Q/MKfQe
	CkYJPpWM2zPyhD9fgyIbkbATDrOiJ/I=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725964798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eprW9rfhq2cX7ePF/8RtH26O1aYeQlKG+2vFrY0kNmk=;
	b=fXDtBABulc8D33tnfRSRkGpzr5L9nT6W1TK8THvxsKZUVm4SFyJoAA7eHIibZlXR1/CfTf
	8I6uaJd26i5dMZJG2Y2XCh/0iQJ39tFnYuwyH9Ua773aBS5SoGWzFTXJNsIa1dsvxRP9Q3
	ly6RKLX/onc06+/gb3oK339PlWZS0pc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 454E7132CB;
	Tue, 10 Sep 2024 10:39:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Nfp0D/4h4GbUYwAAD6G6ig
	(envelope-from <jgross@suse.com>); Tue, 10 Sep 2024 10:39:58 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	xen-devel@lists.xenproject.org,
	=?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	Jan Beulich <jbeulich@suse.com>
Subject: [PATCH v3 4/7] xen: move max_pfn in xen_memory_setup() out of function scope
Date: Tue, 10 Sep 2024 12:39:29 +0200
Message-ID: <20240910103932.7634-5-jgross@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910103932.7634-1-jgross@suse.com>
References: <20240910103932.7634-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

Instead of having max_pfn as a local variable of xen_memory_setup(),
make it a static variable in setup.c instead. This avoids having to
pass it to subfunctions, which will be needed in more cases in future.

Rename it to ini_nr_pages, as the value denotes the currently usable
number of memory pages as passed from the hypervisor at boot time.

Signed-off-by: Juergen Gross <jgross@suse.com>
Tested-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
Reviewed-by: Jan Beulich <jbeulich@suse.com>
---
 arch/x86/xen/setup.c | 52 ++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/x86/xen/setup.c b/arch/x86/xen/setup.c
index dba68951ed6b..2c79bb5a9cd0 100644
--- a/arch/x86/xen/setup.c
+++ b/arch/x86/xen/setup.c
@@ -46,6 +46,9 @@ bool xen_pv_pci_possible;
 /* E820 map used during setting up memory. */
 static struct e820_table xen_e820_table __initdata;
 
+/* Number of initially usable memory pages. */
+static unsigned long ini_nr_pages __initdata;
+
 /*
  * Buffer used to remap identity mapped pages. We only need the virtual space.
  * The physical page behind this address is remapped as needed to different
@@ -212,7 +215,7 @@ static int __init xen_free_mfn(unsigned long mfn)
  * as a fallback if the remapping fails.
  */
 static void __init xen_set_identity_and_release_chunk(unsigned long start_pfn,
-			unsigned long end_pfn, unsigned long nr_pages)
+						      unsigned long end_pfn)
 {
 	unsigned long pfn, end;
 	int ret;
@@ -220,7 +223,7 @@ static void __init xen_set_identity_and_release_chunk(unsigned long start_pfn,
 	WARN_ON(start_pfn > end_pfn);
 
 	/* Release pages first. */
-	end = min(end_pfn, nr_pages);
+	end = min(end_pfn, ini_nr_pages);
 	for (pfn = start_pfn; pfn < end; pfn++) {
 		unsigned long mfn = pfn_to_mfn(pfn);
 
@@ -341,15 +344,14 @@ static void __init xen_do_set_identity_and_remap_chunk(
  * to Xen and not remapped.
  */
 static unsigned long __init xen_set_identity_and_remap_chunk(
-	unsigned long start_pfn, unsigned long end_pfn, unsigned long nr_pages,
-	unsigned long remap_pfn)
+	unsigned long start_pfn, unsigned long end_pfn, unsigned long remap_pfn)
 {
 	unsigned long pfn;
 	unsigned long i = 0;
 	unsigned long n = end_pfn - start_pfn;
 
 	if (remap_pfn == 0)
-		remap_pfn = nr_pages;
+		remap_pfn = ini_nr_pages;
 
 	while (i < n) {
 		unsigned long cur_pfn = start_pfn + i;
@@ -358,19 +360,19 @@ static unsigned long __init xen_set_identity_and_remap_chunk(
 		unsigned long remap_range_size;
 
 		/* Do not remap pages beyond the current allocation */
-		if (cur_pfn >= nr_pages) {
+		if (cur_pfn >= ini_nr_pages) {
 			/* Identity map remaining pages */
 			set_phys_range_identity(cur_pfn, cur_pfn + size);
 			break;
 		}
-		if (cur_pfn + size > nr_pages)
-			size = nr_pages - cur_pfn;
+		if (cur_pfn + size > ini_nr_pages)
+			size = ini_nr_pages - cur_pfn;
 
 		remap_range_size = xen_find_pfn_range(&remap_pfn);
 		if (!remap_range_size) {
 			pr_warn("Unable to find available pfn range, not remapping identity pages\n");
 			xen_set_identity_and_release_chunk(cur_pfn,
-						cur_pfn + left, nr_pages);
+							   cur_pfn + left);
 			break;
 		}
 		/* Adjust size to fit in current e820 RAM region */
@@ -397,18 +399,18 @@ static unsigned long __init xen_set_identity_and_remap_chunk(
 }
 
 static unsigned long __init xen_count_remap_pages(
-	unsigned long start_pfn, unsigned long end_pfn, unsigned long nr_pages,
+	unsigned long start_pfn, unsigned long end_pfn,
 	unsigned long remap_pages)
 {
-	if (start_pfn >= nr_pages)
+	if (start_pfn >= ini_nr_pages)
 		return remap_pages;
 
-	return remap_pages + min(end_pfn, nr_pages) - start_pfn;
+	return remap_pages + min(end_pfn, ini_nr_pages) - start_pfn;
 }
 
-static unsigned long __init xen_foreach_remap_area(unsigned long nr_pages,
+static unsigned long __init xen_foreach_remap_area(
 	unsigned long (*func)(unsigned long start_pfn, unsigned long end_pfn,
-			      unsigned long nr_pages, unsigned long last_val))
+			      unsigned long last_val))
 {
 	phys_addr_t start = 0;
 	unsigned long ret_val = 0;
@@ -436,8 +438,7 @@ static unsigned long __init xen_foreach_remap_area(unsigned long nr_pages,
 				end_pfn = PFN_UP(entry->addr);
 
 			if (start_pfn < end_pfn)
-				ret_val = func(start_pfn, end_pfn, nr_pages,
-					       ret_val);
+				ret_val = func(start_pfn, end_pfn, ret_val);
 			start = end;
 		}
 	}
@@ -700,7 +701,7 @@ static void __init xen_reserve_xen_mfnlist(void)
  **/
 char * __init xen_memory_setup(void)
 {
-	unsigned long max_pfn, pfn_s, n_pfns;
+	unsigned long pfn_s, n_pfns;
 	phys_addr_t mem_end, addr, size, chunk_size;
 	u32 type;
 	int rc;
@@ -712,9 +713,8 @@ char * __init xen_memory_setup(void)
 	int op;
 
 	xen_parse_512gb();
-	max_pfn = xen_get_pages_limit();
-	max_pfn = min(max_pfn, xen_start_info->nr_pages);
-	mem_end = PFN_PHYS(max_pfn);
+	ini_nr_pages = min(xen_get_pages_limit(), xen_start_info->nr_pages);
+	mem_end = PFN_PHYS(ini_nr_pages);
 
 	memmap.nr_entries = ARRAY_SIZE(xen_e820_table.entries);
 	set_xen_guest_handle(memmap.buffer, xen_e820_table.entries);
@@ -789,10 +789,10 @@ char * __init xen_memory_setup(void)
 	max_pages = xen_get_max_pages();
 
 	/* How many extra pages do we need due to remapping? */
-	max_pages += xen_foreach_remap_area(max_pfn, xen_count_remap_pages);
+	max_pages += xen_foreach_remap_area(xen_count_remap_pages);
 
-	if (max_pages > max_pfn)
-		extra_pages += max_pages - max_pfn;
+	if (max_pages > ini_nr_pages)
+		extra_pages += max_pages - ini_nr_pages;
 
 	/*
 	 * Clamp the amount of extra memory to a EXTRA_MEM_RATIO
@@ -801,8 +801,8 @@ char * __init xen_memory_setup(void)
 	 * Make sure we have no memory above max_pages, as this area
 	 * isn't handled by the p2m management.
 	 */
-	maxmem_pages = EXTRA_MEM_RATIO * min(max_pfn, PFN_DOWN(MAXMEM));
-	extra_pages = min3(maxmem_pages, extra_pages, max_pages - max_pfn);
+	maxmem_pages = EXTRA_MEM_RATIO * min(ini_nr_pages, PFN_DOWN(MAXMEM));
+	extra_pages = min3(maxmem_pages, extra_pages, max_pages - ini_nr_pages);
 	i = 0;
 	addr = xen_e820_table.entries[0].addr;
 	size = xen_e820_table.entries[0].size;
@@ -885,7 +885,7 @@ char * __init xen_memory_setup(void)
 	 * Set identity map on non-RAM pages and prepare remapping the
 	 * underlying RAM.
 	 */
-	xen_foreach_remap_area(max_pfn, xen_set_identity_and_remap_chunk);
+	xen_foreach_remap_area(xen_set_identity_and_remap_chunk);
 
 	pr_info("Released %ld page(s)\n", xen_released_pages);
 
-- 
2.43.0


