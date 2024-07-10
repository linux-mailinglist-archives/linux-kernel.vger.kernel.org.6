Return-Path: <linux-kernel+bounces-247472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F7592CFD8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B6171C225E2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA1F1922E3;
	Wed, 10 Jul 2024 10:51:35 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59707191474
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720608694; cv=none; b=gv0LvcKQw4UdtU0B3lVHvgqw2kAe6DMm9sDc2gGTNsMuWPDgGf+u84CKEsrJVmf06CdNMS7VTF851IyVOC7tfj0kKq/JeTm//HSpX7lHcTknrVqDwpwcewHiiX+6TbXY0irBRYz75ZaZzCnSay+UWyJDs+ZdHSZUXJbZlo5dNOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720608694; c=relaxed/simple;
	bh=A5w0vGjs9nXoetdRG0NWdKucvagJT0jsZ+A+FVaHA9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KpAUfYxykdRzvhNvR6vM5ASwL61kx4yU01pEULZyGcyhWTWWOBIw28NdU+CRQy3R3qY6HECacmlmfraebW+mmigd5wXAKNX6if1cLyXRUULwsXiAwVKUWcDtSJFQzORASmbJRe025wUDJrznlJrEwLDUU7prg3GKlAl75l6jTuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 78AA81F829;
	Wed, 10 Jul 2024 10:51:26 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 57AC51369A;
	Wed, 10 Jul 2024 10:51:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AIHDEK1njmazcwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 10 Jul 2024 10:51:25 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Michal Hocko <mhocko@suse.com>,
	Donet Tom <donettom@linux.ibm.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH 3/8] arch/x86: Teach arch_get_unmapped_area_vmflags to handle hugetlb mappings
Date: Wed, 10 Jul 2024 12:50:37 +0200
Message-ID: <20240710105042.30165-4-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240710105042.30165-1-osalvador@suse.de>
References: <20240710105042.30165-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 78AA81F829
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

We want to stop special casing hugetlb mappings and make them go
through generic channels, so teach arch_get_unmapped_area_{topdown_}vmflags
to handle those.
x86 specific hugetlb function does not set either info.start_gap or
info.align_offset so the same here for compatibility.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 arch/x86/kernel/sys_x86_64.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index 01d7cd85ef97..aa7491f036a7 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -18,6 +18,7 @@
 #include <linux/random.h>
 #include <linux/uaccess.h>
 #include <linux/elf.h>
+#include <linux/hugetlb.h>
 
 #include <asm/elf.h>
 #include <asm/ia32.h>
@@ -25,8 +26,10 @@
 /*
  * Align a virtual address to avoid aliasing in the I$ on AMD F15h.
  */
-static unsigned long get_align_mask(void)
+static unsigned long get_align_mask(struct file *filp)
 {
+	if (filp && is_file_hugepages(filp))
+		return huge_page_mask_align(filp);
 	/* handle 32- and 64-bit case with a single conditional */
 	if (va_align.flags < 0 || !(va_align.flags & (2 - mmap_is_ia32())))
 		return 0;
@@ -49,7 +52,7 @@ static unsigned long get_align_mask(void)
  */
 static unsigned long get_align_bits(void)
 {
-	return va_align.bits & get_align_mask();
+	return va_align.bits & get_align_mask(NULL);
 }
 
 static int __init control_va_addr_alignment(char *str)
@@ -148,12 +151,15 @@ arch_get_unmapped_area_vmflags(struct file *filp, unsigned long addr, unsigned l
 	info.length = len;
 	info.low_limit = begin;
 	info.high_limit = end;
-	info.align_offset = pgoff << PAGE_SHIFT;
-	info.start_gap = stack_guard_placement(vm_flags);
+	if (!(filp && is_file_hugepages(filp))) {
+		info.align_offset = pgoff << PAGE_SHIFT;
+		info.start_gap = stack_guard_placement(vm_flags);
+	}
 	if (filp) {
-		info.align_mask = get_align_mask();
+		info.align_mask = get_align_mask(filp);
 		info.align_offset += get_align_bits();
 	}
+
 	return vm_unmapped_area(&info);
 }
 
@@ -199,7 +205,10 @@ arch_get_unmapped_area_topdown_vmflags(struct file *filp, unsigned long addr0,
 		info.low_limit = PAGE_SIZE;
 
 	info.high_limit = get_mmap_base(0);
-	info.start_gap = stack_guard_placement(vm_flags);
+	if (!(filp && is_file_hugepages(filp))) {
+		info.start_gap = stack_guard_placement(vm_flags);
+		info.align_offset = pgoff << PAGE_SHIFT;
+	}
 
 	/*
 	 * If hint address is above DEFAULT_MAP_WINDOW, look for unmapped area
@@ -211,9 +220,8 @@ arch_get_unmapped_area_topdown_vmflags(struct file *filp, unsigned long addr0,
 	if (addr > DEFAULT_MAP_WINDOW && !in_32bit_syscall())
 		info.high_limit += TASK_SIZE_MAX - DEFAULT_MAP_WINDOW;
 
-	info.align_offset = pgoff << PAGE_SHIFT;
 	if (filp) {
-		info.align_mask = get_align_mask();
+		info.align_mask = get_align_mask(filp);
 		info.align_offset += get_align_bits();
 	}
 	addr = vm_unmapped_area(&info);
-- 
2.45.2


