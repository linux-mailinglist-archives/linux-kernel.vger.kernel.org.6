Return-Path: <linux-kernel+bounces-277755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 675CA94A617
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F41EB22087
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5FE1DF698;
	Wed,  7 Aug 2024 10:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LUYTC61W";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LUYTC61W"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4B51B32B3
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 10:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027289; cv=none; b=tJ/L5lAei6iGssL7Wnx1HBJaJCDYfZNHXlqMK9WOKNfwoWpFkyh8fUHSaLxk8Qh3C+jMdGo52W0bdvZA6/Uy/a7Rj9AzpCPR1rZ0bGS3GuIUpAtkBGArM//HOqK96dnHTdivS/kSdbktFpnO4flYiv1waGC1VRZLZcnhuVKdnqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027289; c=relaxed/simple;
	bh=KNbhg2W6TahJ4NR0/+RtR1V9sXd4o2NOeheh5cZGRcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=clKaaGbtVGd8IbfRe9UP0Nk5nPABkGzpOUguUrueL1pA2siKvgTR673YNRtfRPVJB2xzn8WHb0UfEDyCah9ZEQUgxsRBt5coHfc8xOJTNsAqPC7nXY6qhZYbodMq0g8pSbCaGAbVULS5so/sTrPU0gUeOE88w87MrNLwx0R9RWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LUYTC61W; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LUYTC61W; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6CD071F807;
	Wed,  7 Aug 2024 10:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1723027285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LEPD7L+PrX6jbrsj5UZebNb1W2NcisUaeKba9OJ0nRo=;
	b=LUYTC61WgoxQZisyGVLtQzUgwgoTf5pzPem32y7U6kp+DXDzaZOVFxGtlwzDaJE8BxxafK
	4S60ze5VkHMB3FOYNGAeiAo1WVqleWsTsCTgkB1mWESWybTjYboqFwf23EellDssAS6NCv
	EyUl3qhbXGd4fWpKjWypcJRvhYGA09Y=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1723027285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LEPD7L+PrX6jbrsj5UZebNb1W2NcisUaeKba9OJ0nRo=;
	b=LUYTC61WgoxQZisyGVLtQzUgwgoTf5pzPem32y7U6kp+DXDzaZOVFxGtlwzDaJE8BxxafK
	4S60ze5VkHMB3FOYNGAeiAo1WVqleWsTsCTgkB1mWESWybTjYboqFwf23EellDssAS6NCv
	EyUl3qhbXGd4fWpKjWypcJRvhYGA09Y=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 15AA813297;
	Wed,  7 Aug 2024 10:41:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id he/lA1VPs2YeIgAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 07 Aug 2024 10:41:25 +0000
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
	=?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
Subject: [PATCH 2/5] xen: introduce generic helper checking for memory map conflicts
Date: Wed,  7 Aug 2024 12:41:07 +0200
Message-ID: <20240807104110.18117-3-jgross@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240807104110.18117-1-jgross@suse.com>
References: <20240807104110.18117-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-7.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,invisiblethingslab.com:email]
X-Spam-Score: -7.30
X-Spam-Flag: NO
X-Spam-Level: 

When booting as a Xen PV dom0 the memory layout of the dom0 is
modified to match that of the host, as this requires less changes in
the kernel for supporting Xen.

There are some cases, though, which are problematic, as it is the Xen
hypervisor selecting the kernel's load address plus some other data,
which might conflict with the host's memory map.

These conflicts are detected at boot time and result in a boot error.
In order to support handling at least some of these conflicts in
future, introduce a generic helper function which will later gain the
ability to adapt the memory layout when possible.

Add the missing check for the xen_start_info area.

Signed-off-by: Juergen Gross <jgross@suse.com>
Tested-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
---
 arch/x86/xen/mmu_pv.c  |  5 +----
 arch/x86/xen/setup.c   | 34 ++++++++++++++++++++++++++++------
 arch/x86/xen/xen-ops.h |  3 ++-
 3 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index f1ce39d6d32c..839e6613753d 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -2018,10 +2018,7 @@ void __init xen_reserve_special_pages(void)
 
 void __init xen_pt_check_e820(void)
 {
-	if (xen_is_e820_reserved(xen_pt_base, xen_pt_size)) {
-		xen_raw_console_write("Xen hypervisor allocated page table memory conflicts with E820 map\n");
-		BUG();
-	}
+	xen_chk_is_e820_usable(xen_pt_base, xen_pt_size, "page table");
 }
 
 static unsigned char dummy_mapping[PAGE_SIZE] __page_aligned_bss;
diff --git a/arch/x86/xen/setup.c b/arch/x86/xen/setup.c
index 4bcc70a71b7d..96765180514b 100644
--- a/arch/x86/xen/setup.c
+++ b/arch/x86/xen/setup.c
@@ -567,7 +567,7 @@ static void __init xen_ignore_unusable(void)
 	}
 }
 
-bool __init xen_is_e820_reserved(phys_addr_t start, phys_addr_t size)
+static bool __init xen_is_e820_reserved(phys_addr_t start, phys_addr_t size)
 {
 	struct e820_entry *entry;
 	unsigned mapcnt;
@@ -624,6 +624,23 @@ phys_addr_t __init xen_find_free_area(phys_addr_t size)
 	return 0;
 }
 
+/*
+ * Check for an area in physical memory to be usable for non-movable purposes.
+ * An area is considered to usable if the used E820 map lists it to be RAM.
+ * In case the area is not usable, crash the system with an error message.
+ */
+void __init xen_chk_is_e820_usable(phys_addr_t start, phys_addr_t size,
+				   const char *component)
+{
+	if (!xen_is_e820_reserved(start, size))
+		return;
+
+	xen_raw_console_write("Xen hypervisor allocated ");
+	xen_raw_console_write(component);
+	xen_raw_console_write(" memory conflicts with E820 map\n");
+	BUG();
+}
+
 /*
  * Like memcpy, but with physical addresses for dest and src.
  */
@@ -824,11 +841,16 @@ char * __init xen_memory_setup(void)
 	 * Failing now is better than running into weird problems later due
 	 * to relocating (and even reusing) pages with kernel text or data.
 	 */
-	if (xen_is_e820_reserved(__pa_symbol(_text),
-				 __pa_symbol(_end) - __pa_symbol(_text))) {
-		xen_raw_console_write("Xen hypervisor allocated kernel memory conflicts with E820 map\n");
-		BUG();
-	}
+	xen_chk_is_e820_usable(__pa_symbol(_text),
+			       __pa_symbol(_end) - __pa_symbol(_text),
+			       "kernel");
+
+	/*
+	 * Check for a conflict of the xen_start_info memory with the target
+	 * E820 map.
+	 */
+	xen_chk_is_e820_usable(__pa(xen_start_info), sizeof(*xen_start_info),
+			       "xen_start_info");
 
 	/*
 	 * Check for a conflict of the hypervisor supplied page tables with
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index 0cf16fc79e0b..9a27d1d653d3 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -48,7 +48,8 @@ void xen_mm_unpin_all(void);
 void __init xen_relocate_p2m(void);
 #endif
 
-bool __init xen_is_e820_reserved(phys_addr_t start, phys_addr_t size);
+void __init xen_chk_is_e820_usable(phys_addr_t start, phys_addr_t size,
+				   const char *component);
 unsigned long __ref xen_chk_extra_mem(unsigned long pfn);
 void __init xen_inv_extra_mem(void);
 void __init xen_remap_memory(void);
-- 
2.43.0


