Return-Path: <linux-kernel+bounces-558465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB8CA5E64E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 578203A5757
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 21:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3041EE7A7;
	Wed, 12 Mar 2025 21:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EUG4ooiJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6F2/uq17";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EUG4ooiJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6F2/uq17"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B6D192B84
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 21:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741813873; cv=none; b=u7vyeMGB93djXhhkMXIghO+0hHMJXepa90a9toSn8CyyQYqvmxhh3LV8oLu+OEZ09gVix3lu2K/BCkaFflAJXkU3PXSq6LebzJpW+ts/Cn7jYc7/ayhsK4EyAmsNGbFu75gWZVQ+eh0Utj/TbLF84WF862d68MFrx7arrMS5A9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741813873; c=relaxed/simple;
	bh=T4UMj9v4mjJgHMgJG1+867/AY0UIEQr9aLI7deO0LMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQ03GAgaD3L/m1/xCfHIUKdDZhV2Kk25s26EO8FJQU5Z/OldxexzIkkpHS0Y/2xnwMhxVSDwCLbIDMkfSm5e0oWKmyjp6HsRoBX5IKpaiUxCLLATZtUPvbD2jhQBegMwCalfNnGo6mCRORcnws0UEdeZ/SnyYLMvkRufBALKP+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EUG4ooiJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6F2/uq17; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EUG4ooiJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6F2/uq17; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from localhost (unknown [10.100.12.32])
	by smtp-out1.suse.de (Postfix) with ESMTP id A381E21188;
	Wed, 12 Mar 2025 21:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741813846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aVAkE5ITz3xbVBTsELj7FWN8tR4JCna6Us6nfaQKMwE=;
	b=EUG4ooiJzmLFhsxqLk5IfpT3zhYGrDIYMHjKo+KQDkpKV8B+cUxFdoB3PUyE6fcaO4/cBT
	pgRzJtBCjIKP48JQhiACiOje8Y62bv8045BgzZ+5DVOfZbHYgp+LfNKxLzPL3vN6uP4h7g
	kewNofBNLwARLwbU1+Xzvbo6uouUS5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741813846;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aVAkE5ITz3xbVBTsELj7FWN8tR4JCna6Us6nfaQKMwE=;
	b=6F2/uq17vUtb13lJ9QPrT49se5eI7CNvCecQPaSK3ykdNkU6wdGbJFu61uxDvO84EORj0+
	EENnbeQ2j2ejzzBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741813846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aVAkE5ITz3xbVBTsELj7FWN8tR4JCna6Us6nfaQKMwE=;
	b=EUG4ooiJzmLFhsxqLk5IfpT3zhYGrDIYMHjKo+KQDkpKV8B+cUxFdoB3PUyE6fcaO4/cBT
	pgRzJtBCjIKP48JQhiACiOje8Y62bv8045BgzZ+5DVOfZbHYgp+LfNKxLzPL3vN6uP4h7g
	kewNofBNLwARLwbU1+Xzvbo6uouUS5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741813846;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aVAkE5ITz3xbVBTsELj7FWN8tR4JCna6Us6nfaQKMwE=;
	b=6F2/uq17vUtb13lJ9QPrT49se5eI7CNvCecQPaSK3ykdNkU6wdGbJFu61uxDvO84EORj0+
	EENnbeQ2j2ejzzBw==
Date: Wed, 12 Mar 2025 22:10:46 +0100
From: Jiri Bohac <jbohac@suse.cz>
To: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
Cc: Philipp Rudo <prudo@redhat.com>, Donald Dutile <ddutile@redhat.com>,
	Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>,
	linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>,
	Michal Hocko <mhocko@suse.cz>
Subject: [PATCH v3 4/5] kdump: wait for DMA to finish when using CMA
Message-ID: <Z9H4VjqqriDNIaFA@dwarf.suse.cz>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.19)[-0.949];
	MIME_GOOD(-0.10)[text/plain];
	URIBL_BLOCKED(0.00)[localhost:helo,dwarf.suse.cz:mid,suse.cz:email];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Spam-Score: -4.29
X-Spam-Flag: NO

When re-using the CMA area for kdump there is a risk of pending DMA into
pinned user pages in the CMA area.

Pages that are pinned long-term are migrated away from CMA, so these are
not a concern. Pages pinned without FOLL_LONGTERM remain in the CMA and may
possibly be the source or destination of a pending DMA transfer.

Although there is no clear specification how long a page may be pinned
without FOLL_LONGTERM, pinning without the flag shows an intent of the
caller to only use the memory for short-lived DMA transfers, not a transfer
initiated by a device asynchronously at a random time in the future.

Add a delay of CMA_DMA_TIMEOUT_MSEC milliseconds before starting the kdump
kernel, giving such short-lived DMA transfers time to finish before the CMA
memory is re-used by the kdump kernel.

Set CMA_DMA_TIMEOUT_MSEC to 1000 (one second) - chosen arbitrarily as both
a huge margin for a DMA transfer, yet not increasing the kdump time
significantly.

Signed-off-by: Jiri Bohac <jbohac@suse.cz>
---
 include/linux/crash_core.h |  5 +++++
 kernel/crash_core.c        | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 44305336314e..543e4a71f13c 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -56,6 +56,11 @@ static inline unsigned int crash_get_elfcorehdr_size(void) { return 0; }
 /* Alignment required for elf header segment */
 #define ELF_CORE_HEADER_ALIGN   4096
 
+/* Time to wait for possible DMA to finish before starting the kdump kernel
+ * when a CMA reservation is used
+ */
+#define CMA_DMA_TIMEOUT_MSEC 1000
+
 extern int crash_exclude_mem_range(struct crash_mem *mem,
 				   unsigned long long mstart,
 				   unsigned long long mend);
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 078fe5bc5a74..ed152af08d1e 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -21,6 +21,7 @@
 #include <linux/reboot.h>
 #include <linux/btf.h>
 #include <linux/objtool.h>
+#include <linux/delay.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -97,6 +98,14 @@ int kexec_crash_loaded(void)
 }
 EXPORT_SYMBOL_GPL(kexec_crash_loaded);
 
+static void crash_cma_clear_pending_dma(void)
+{
+	if (!crashk_cma_cnt)
+		return;
+
+	mdelay(CMA_DMA_TIMEOUT_MSEC);
+}
+
 /*
  * No panic_cpu check version of crash_kexec().  This function is called
  * only when panic_cpu holds the current CPU number; this is the only CPU
@@ -119,6 +128,7 @@ void __noclone __crash_kexec(struct pt_regs *regs)
 			crash_setup_regs(&fixed_regs, regs);
 			crash_save_vmcoreinfo();
 			machine_crash_shutdown(&fixed_regs);
+			crash_cma_clear_pending_dma();
 			machine_kexec(kexec_crash_image);
 		}
 		kexec_unlock();
-- 
2.46.0

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


