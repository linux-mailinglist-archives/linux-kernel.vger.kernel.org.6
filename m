Return-Path: <linux-kernel+bounces-293521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 142A09580D4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 766EFB2312F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6649A18A6AD;
	Tue, 20 Aug 2024 08:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Wfr1kIRb";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lxdmpQlF"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DED18C018
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724142059; cv=none; b=UuMkZNPZ9eIGghl1ulfia/JftcsAiJFbztGXicTB61Uy9pZGETaf/X8Mt9N5yYwsYUYpx91Hnv79QIdK9D6M8RDJDm8wLDI65OApVDSB+z0bQA4WGAAHt7ru8pepHgP8YQfWFobui4h6uP8So0x9SlGQ0kGYS8eGPTxDWDCMHaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724142059; c=relaxed/simple;
	bh=Y514wmYHtnRZjRk6vUzh2xb3kp7DDC9fVzDLx2BIAU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eLTRwpjXjeyxuSRydldaza+BE0+w1LFscyD19KXKmVoq/WA8LTzrmUKs4RXDrlqHKxmIfaOiwi72PntWrkKOkxh6y2swLLnUqfeVVCzNEaE8r9ZZBuladZqyijGrxM53MvtALG2okJ8Mgh+8AV1qxssfO0/UIbS4PYgadHOR4tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Wfr1kIRb; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lxdmpQlF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E5FEF1FFB4;
	Tue, 20 Aug 2024 08:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724142056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uhe1/Za2Rsc+OxMtgPmnbZH7qh+wHOykK24Zu10M3lw=;
	b=Wfr1kIRbJaQ5CYghKSt4ap58FNWgVJdFxoK7j+XScPu3UcYpu+gku6jgbrS3lYhkEgKWCS
	F0Dppshvt2v/wxC1DU3c46+adTiGoCKb/osYRJQKGKoIx8J8py7s2G/jFFk8/1Vt7nJvQt
	DMZ9TnL3jErdWh0Ifj91Hcn0l3uKrMw=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=lxdmpQlF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724142055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uhe1/Za2Rsc+OxMtgPmnbZH7qh+wHOykK24Zu10M3lw=;
	b=lxdmpQlFs8jFGwiAHLsjDDuMc8HgOKwUptyIR9owTp/+pyEHSVWjSKmT8VgKaRpox8oq6d
	GsetpjmO5vB1xvdy5p7QrMNTm53rOln/XW7ZCN7r24PjpkUjynrr7+pECMFYd1hRA+0Lbn
	SPzt4Y7i2ZuizfoemRrtFeMJnN/Fp+Y=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 836BA13A17;
	Tue, 20 Aug 2024 08:20:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3yl5HudRxGbTKwAAD6G6ig
	(envelope-from <jgross@suse.com>); Tue, 20 Aug 2024 08:20:55 +0000
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
Subject: [PATCH v2 7/7] xen: tolerate ACPI NVS memory overlapping with Xen allocated memory
Date: Tue, 20 Aug 2024 10:20:12 +0200
Message-ID: <20240820082012.31316-8-jgross@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820082012.31316-1-jgross@suse.com>
References: <20240820082012.31316-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E5FEF1FFB4
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_RATELIMIT(0.00)[to_ip_from(RLkdkdrsxe9hqhhs5ask8616i6)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

In order to minimize required special handling for running as Xen PV
dom0, the memory layout is modified to match that of the host. This
requires to have only RAM at the locations where Xen allocated memory
is living. Unfortunately there seem to be some machines, where ACPI
NVS is located at 64 MB, resulting in a conflict with the loaded
kernel or the initial page tables built by Xen.

As ACPI NVS needs to be accessed by the kernel only for saving and
restoring it across suspend operations, it can be relocated in the
dom0's memory map by swapping it with unused RAM (this is possible
via modification of the dom0 P2M map).

While the E820 map can (and should) be modified right away, the P2M
map can be updated only after memory allocation is working, as the P2M
map might need to be extended.

Fixes: 808fdb71936c ("xen: check for kernel memory conflicting with memory layout")
Signed-off-by: Juergen Gross <jgross@suse.com>
Tested-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
---
V2:
- remap helpers split off into other patch
---
 arch/x86/xen/setup.c | 92 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 1 deletion(-)

diff --git a/arch/x86/xen/setup.c b/arch/x86/xen/setup.c
index 88b2ebd23da3..5697f1cdd6a0 100644
--- a/arch/x86/xen/setup.c
+++ b/arch/x86/xen/setup.c
@@ -495,6 +495,8 @@ void __init xen_remap_memory(void)
 	set_pte_mfn(buf, mfn_save, PAGE_KERNEL);
 
 	pr_info("Remapped %ld page(s)\n", remapped);
+
+	xen_do_remap_nonram();
 }
 
 static unsigned long __init xen_get_pages_limit(void)
@@ -625,14 +627,102 @@ phys_addr_t __init xen_find_free_area(phys_addr_t size)
 	return 0;
 }
 
+/*
+ * Swap a non-RAM E820 map entry with RAM above ini_nr_pages.
+ * Note that the E820 map is modified accordingly, but the P2M map isn't yet.
+ * The adaption of the P2M must be deferred until page allocation is possible.
+ */
+static void __init xen_e820_swap_entry_with_ram(struct e820_entry *swap_entry)
+{
+	struct e820_entry *entry;
+	unsigned int mapcnt;
+	phys_addr_t mem_end = PFN_PHYS(ini_nr_pages);
+	phys_addr_t swap_addr, swap_size, entry_end;
+
+	swap_addr = PAGE_ALIGN_DOWN(swap_entry->addr);
+	swap_size = PAGE_ALIGN(swap_entry->addr - swap_addr + swap_entry->size);
+	entry = xen_e820_table.entries;
+
+	for (mapcnt = 0; mapcnt < xen_e820_table.nr_entries; mapcnt++) {
+		entry_end = entry->addr + entry->size;
+		if (entry->type == E820_TYPE_RAM && entry->size >= swap_size &&
+		    entry_end - swap_size >= mem_end) {
+			/* Reduce RAM entry by needed space (whole pages). */
+			entry->size -= swap_size;
+
+			/* Add new entry at the end of E820 map. */
+			entry = xen_e820_table.entries +
+				xen_e820_table.nr_entries;
+			xen_e820_table.nr_entries++;
+
+			/* Fill new entry (keep size and page offset). */
+			entry->type = swap_entry->type;
+			entry->addr = entry_end - swap_size +
+				      swap_addr - swap_entry->addr;
+			entry->size = swap_entry->size;
+
+			/* Convert old entry to RAM, align to pages. */
+			swap_entry->type = E820_TYPE_RAM;
+			swap_entry->addr = swap_addr;
+			swap_entry->size = swap_size;
+
+			/* Remember PFN<->MFN relation for P2M update. */
+			xen_add_remap_nonram(swap_addr, entry_end - swap_size,
+					     swap_size);
+
+			/* Order E820 table and merge entries. */
+			e820__update_table(&xen_e820_table);
+
+			return;
+		}
+
+		entry++;
+	}
+
+	xen_raw_console_write("No suitable area found for required E820 entry remapping action\n");
+	BUG();
+}
+
+/*
+ * Look for non-RAM memory types in a specific guest physical area and move
+ * those away if possible (ACPI NVS only for now).
+ */
+static void __init xen_e820_resolve_conflicts(phys_addr_t start,
+					      phys_addr_t size)
+{
+	struct e820_entry *entry;
+	unsigned int mapcnt;
+	phys_addr_t end;
+
+	if (!size)
+		return;
+
+	end = start + size;
+	entry = xen_e820_table.entries;
+
+	for (mapcnt = 0; mapcnt < xen_e820_table.nr_entries; mapcnt++) {
+		if (entry->addr >= end)
+			return;
+
+		if (entry->addr + entry->size > start &&
+		    entry->type == E820_TYPE_NVS)
+			xen_e820_swap_entry_with_ram(entry);
+
+		entry++;
+	}
+}
+
 /*
  * Check for an area in physical memory to be usable for non-movable purposes.
- * An area is considered to usable if the used E820 map lists it to be RAM.
+ * An area is considered to usable if the used E820 map lists it to be RAM or
+ * some other type which can be moved to higher PFNs while keeping the MFNs.
  * In case the area is not usable, crash the system with an error message.
  */
 void __init xen_chk_is_e820_usable(phys_addr_t start, phys_addr_t size,
 				   const char *component)
 {
+	xen_e820_resolve_conflicts(start, size);
+
 	if (!xen_is_e820_reserved(start, size))
 		return;
 
-- 
2.43.0


