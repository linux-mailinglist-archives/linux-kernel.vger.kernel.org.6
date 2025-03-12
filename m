Return-Path: <linux-kernel+bounces-558473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9139FA5E65E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72BCC7A4433
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 21:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B531EF0A1;
	Wed, 12 Mar 2025 21:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DJ+zDR1r";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B1wUh2iA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iFASKtiO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LN8yTHuR"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B281E51EB
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 21:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741814247; cv=none; b=OVqHI3xwagw4zpzDf3usl2UpV/gffEI3zIKUKVc3DDS91FR3VeVMms+n7yg6KiPdBBFO1vkLU9/vH0us8xer0FmLkbTFFKsjs7ieTUt4wh9JOle/YMRDBh5h+0L9YTdbE3fiwf/cu5elm/DaES5C/6B+MzpEHGXkLBvXxv48v5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741814247; c=relaxed/simple;
	bh=XKX4Aucp/sBQshrMZR2LOMDydJSQWtIZFAAPJdcspIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWOd1I5X1j+tymVNVskmmNzEj0PXCoxLKu0MN/hPocyLPGruAYhc/bmWJa8aIiN+u0KkQFlBmkMq5ER2Nt/NqMS+AAVPJc210Y7gmZro6X6GktvXua1898PhaO/i/Mkekw+yyyIDm56RD2cMCawXXAijYMPGid+/852Vv5M582U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DJ+zDR1r; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B1wUh2iA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iFASKtiO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LN8yTHuR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from localhost (unknown [10.100.12.32])
	by smtp-out1.suse.de (Postfix) with ESMTP id 0056C21188;
	Wed, 12 Mar 2025 21:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741813914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AAje/oszgqXSx3kWAldq5HwVj5OdtILzxGPWJh8nXcM=;
	b=DJ+zDR1rvxpo4CFBsphteHd06ayzjJe7obkMvim5OrXFR9I3Ul13Xt7uS71jtAulaztqjz
	IdtL/aczJ3KQX2b3C1vc2UbbjYrbMfK9Z9rGeWHFi0Q6sUQzgsIKOfPjpLucZ40r7WyVRi
	Z1t412fuAUy79oGTLH6l51hVi/mdSho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741813914;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AAje/oszgqXSx3kWAldq5HwVj5OdtILzxGPWJh8nXcM=;
	b=B1wUh2iASIXFF64/lrn6XsAOnKLNePX6KsYqIwCLNDxXbdIRbe2GBjh+1LM77fZvdZ0j5Q
	MFgyxPvOfYwitFCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741813913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AAje/oszgqXSx3kWAldq5HwVj5OdtILzxGPWJh8nXcM=;
	b=iFASKtiOdXhmoGEwqN9sf3TBx4C1NZi3uIAhvwwvSdJh/q2uHIFjLDTYs22GWRTFMUbl81
	J/NMkxAnAHgTaDMkoJ1L7lnxMDBRCcWDt8aYrbYpsJSCq0Va8TZgUpCThPCRnocNEQGh/u
	E7jJWDQnuEjF0r3HjEikZgDOJnj8cjU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741813913;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AAje/oszgqXSx3kWAldq5HwVj5OdtILzxGPWJh8nXcM=;
	b=LN8yTHuR4LC6StVHbqOT31VjmZR44mWPKB4L4fIfn0JhLlOHl3ORJ4I5kfVIDhbx+hc4hp
	l6bUWtbOKhjFpMAQ==
Date: Wed, 12 Mar 2025 22:11:52 +0100
From: Jiri Bohac <jbohac@suse.cz>
To: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
Cc: Philipp Rudo <prudo@redhat.com>, Donald Dutile <ddutile@redhat.com>,
	Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>,
	linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>,
	Michal Hocko <mhocko@suse.cz>
Subject: [PATCH v3 5/5] x86: implement crashkernel cma reservation
Message-ID: <Z9H4mKXfqSP9j1rY@dwarf.suse.cz>
References: <Z9H10pYIFLBHNKpr@dwarf.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9H10pYIFLBHNKpr@dwarf.suse.cz>
X-Spam-Score: -4.29
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.19)[-0.949];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ZERO(0.00)[0];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,dwarf.suse.cz:mid,localhost:helo]
X-Spam-Flag: NO
X-Spam-Level: 

Implement the crashkernel CMA reservation for x86:
- enable parsing of the cma suffix by parse_crashkernel()
- reserve memory with reserve_crashkernel_cma()
- add the CMA-reserved ranges to the e820 map for the crash kernel
- exclude the CMA-reserved ranges from vmcore

Signed-off-by: Jiri Bohac <jbohac@suse.cz>
---
 arch/x86/kernel/crash.c | 26 ++++++++++++++++++++++----
 arch/x86/kernel/setup.c |  5 +++--
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 340af8155658..70823fa9abea 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -163,10 +163,10 @@ static struct crash_mem *fill_up_crash_elf_data(void)
 		return NULL;
 
 	/*
-	 * Exclusion of crash region and/or crashk_low_res may cause
-	 * another range split. So add extra two slots here.
+	 * Exclusion of crash region, crashk_low_res and/or crashk_cma_ranges
+	 * may cause range splits. So add extra slots here.
 	 */
-	nr_ranges += 2;
+	nr_ranges += 2 + crashk_cma_cnt;
 	cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
 	if (!cmem)
 		return NULL;
@@ -184,6 +184,7 @@ static struct crash_mem *fill_up_crash_elf_data(void)
 static int elf_header_exclude_ranges(struct crash_mem *cmem)
 {
 	int ret = 0;
+	int i;
 
 	/* Exclude the low 1M because it is always reserved */
 	ret = crash_exclude_mem_range(cmem, 0, SZ_1M - 1);
@@ -198,8 +199,17 @@ static int elf_header_exclude_ranges(struct crash_mem *cmem)
 	if (crashk_low_res.end)
 		ret = crash_exclude_mem_range(cmem, crashk_low_res.start,
 					      crashk_low_res.end);
+	if (ret)
+		return ret;
 
-	return ret;
+	for (i = 0; i < crashk_cma_cnt; ++i) {
+		ret = crash_exclude_mem_range(cmem, crashk_cma_ranges[i].start,
+					      crashk_cma_ranges[i].end);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
@@ -352,6 +362,14 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 		add_e820_entry(params, &ei);
 	}
 
+	for (i = 0; i < crashk_cma_cnt; ++i) {
+		ei.addr = crashk_cma_ranges[i].start;
+		ei.size = crashk_cma_ranges[i].end -
+			  crashk_cma_ranges[i].start + 1;
+		ei.type = E820_TYPE_RAM;
+		add_e820_entry(params, &ei);
+	}
+
 out:
 	vfree(cmem);
 	return ret;
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 853afde761a7..90e10a18f0c9 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -471,7 +471,7 @@ static void __init memblock_x86_reserve_range_setup_data(void)
 
 static void __init arch_reserve_crashkernel(void)
 {
-	unsigned long long crash_base, crash_size, low_size = 0;
+	unsigned long long crash_base, crash_size, low_size = 0, cma_size = 0;
 	char *cmdline = boot_command_line;
 	bool high = false;
 	int ret;
@@ -481,7 +481,7 @@ static void __init arch_reserve_crashkernel(void)
 
 	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
 				&crash_size, &crash_base,
-				&low_size, NULL, &high);
+				&low_size, &cma_size, &high);
 	if (ret)
 		return;
 
@@ -492,6 +492,7 @@ static void __init arch_reserve_crashkernel(void)
 
 	reserve_crashkernel_generic(cmdline, crash_size, crash_base,
 				    low_size, high);
+	reserve_crashkernel_cma(cma_size);
 }
 
 static struct resource standard_io_resources[] = {

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


