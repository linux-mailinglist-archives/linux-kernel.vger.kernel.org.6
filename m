Return-Path: <linux-kernel+bounces-352944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D25992665
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B43DD1F22B00
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 07:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6467918C90F;
	Mon,  7 Oct 2024 07:50:56 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB441534E9
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 07:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728287456; cv=none; b=IJ3hGI8KfTcjHsis29bwtnPyGiPrgvHpIaGoZVsdREELrM9Qx+O5dZQz2Xb4IoAa8MDn0yfUeM0K/HmRXF//ojQzcwlfQXezZtDhNw0YPYSPJkzmFXzBIXSuLPaVSg5vFrRabMziCskVVclDdfMI7SGwkzU0XWWpnxYHfFOu+G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728287456; c=relaxed/simple;
	bh=DxUv82Ohdth37zSpruS3Qq87fi6D52lQn0WSreNHUGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ldG5yH6Fojcrroyx8qd8KlluVTGLLI0KMkANO4/YfCQn3wYrXeUA+LCMqWNCNOO4sSPIce0ALzKTc/sDTDxGUdciG1pb1uXbxxoOkP1DDOkZIAIsvWg/Cza/ctcd+0Ycx3y5TLF5wuO6nN0MOPksWWrTYLtMnJgjcua3p4KZGyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A5FA721BF8;
	Mon,  7 Oct 2024 07:50:52 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 065B113A55;
	Mon,  7 Oct 2024 07:50:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CN9COtuSA2d6cQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 07 Oct 2024 07:50:51 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Peter Xu <peterx@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Donet Tom <donettom@linux.ibm.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Michal Hocko <mhocko@suse.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v4 2/9] arch/s390: Teach arch_get_unmapped_area{_topdown} to handle hugetlb mappings
Date: Mon,  7 Oct 2024 09:50:30 +0200
Message-ID: <20241007075037.267650-3-osalvador@suse.de>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241007075037.267650-1-osalvador@suse.de>
References: <20241007075037.267650-1-osalvador@suse.de>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: A5FA721BF8
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

We want to stop special casing hugetlb mappings and make them go
through generic channels, so teach arch_get_unmapped_area{_topdown}
to handle those.
s390 specific hugetlb function does not set info.align_offset, so do
the same here for compatibility.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 arch/s390/mm/mmap.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index 96efa061ce01..33f3504be90b 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -17,6 +17,7 @@
 #include <linux/random.h>
 #include <linux/compat.h>
 #include <linux/security.h>
+#include <linux/hugetlb.h>
 #include <asm/elf.h>
 
 static unsigned long stack_maxrandom_size(void)
@@ -73,6 +74,8 @@ static inline unsigned long mmap_base(unsigned long rnd,
 
 static int get_align_mask(struct file *filp, unsigned long flags)
 {
+	if (filp && is_file_hugepages(filp))
+		return huge_page_mask_align(filp);
 	if (!(current->flags & PF_RANDOMIZE))
 		return 0;
 	if (filp || (flags & MAP_SHARED))
@@ -106,7 +109,8 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	info.low_limit = mm->mmap_base;
 	info.high_limit = TASK_SIZE;
 	info.align_mask = get_align_mask(filp, flags);
-	info.align_offset = pgoff << PAGE_SHIFT;
+	if (!(filp && is_file_hugepages(filp)))
+		info.align_offset = pgoff << PAGE_SHIFT;
 	addr = vm_unmapped_area(&info);
 	if (offset_in_page(addr))
 		return addr;
@@ -144,7 +148,8 @@ unsigned long arch_get_unmapped_area_topdown(struct file *filp, unsigned long ad
 	info.low_limit = PAGE_SIZE;
 	info.high_limit = mm->mmap_base;
 	info.align_mask = get_align_mask(filp, flags);
-	info.align_offset = pgoff << PAGE_SHIFT;
+	if (!(filp && is_file_hugepages(filp)))
+		info.align_offset = pgoff << PAGE_SHIFT;
 	addr = vm_unmapped_area(&info);
 
 	/*
-- 
2.46.1


