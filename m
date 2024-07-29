Return-Path: <linux-kernel+bounces-265397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C1493F0A1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 905FF1F22A30
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F27513DBBB;
	Mon, 29 Jul 2024 09:10:38 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B706213D63D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722244237; cv=none; b=gO0H5NzoignUYyaaoLefZBEVxeFUvS82DtuSshtC8yiZbRH8cjW3139TfUjMX/ppbGAW6hVL3QxhJ/B1Fr+F8wOf3D2SIaC4rTqzx0WF6/5cY/4mUAfOAlFCIiM6AcepRm2pqt5mFxf+tJeZXesaWO4e47revWA2TU44namu9hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722244237; c=relaxed/simple;
	bh=Mp/2trwcK9EMH6qzcEP6VbookvraI1o+FkTcFp0ey/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UcYbmigA5VyMyYf/01Xwme3Hlyw22PVYyP6JmWXtsmLD9JQuoOLAYFGsZZlPIVV+ozX8y0HPlcWCpunlfMZVSjiDaaY0c8YMuGtS/PVT3XA8uxAtoddc7O+64LWJMmU2aX8YbWUH4c/0YMLe/D8rx91N/i8hsPLpOspi42ZRuC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DAFA61F445;
	Mon, 29 Jul 2024 09:10:33 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96A1C1397F;
	Mon, 29 Jul 2024 09:10:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ADa6Hohcp2Z4BgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 29 Jul 2024 09:10:32 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Peter Xu <peterx@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Donet Tom <donettom@linux.ibm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Michal Hocko <mhocko@suse.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 1/9] mm/mmap: Teach generic_get_unmapped_area{_topdown} to handle hugetlb mappings
Date: Mon, 29 Jul 2024 11:10:10 +0200
Message-ID: <20240729091018.2152-2-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240729091018.2152-1-osalvador@suse.de>
References: <20240729091018.2152-1-osalvador@suse.de>
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
X-Rspamd-Action: no action
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DAFA61F445
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated

We want to stop special casing hugetlb mappings and make them go
through generic channels, so teach generic_get_unmapped_area{_topdown}
to handle those.
The main difference is that we set info.align_mask for huge mappings.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/hugetlb.h | 10 ++++++++++
 mm/mmap.c               |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index c9bf68c239a0..0ec14e5e0890 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1007,9 +1007,19 @@ void hugetlb_unregister_node(struct node *node);
  */
 bool is_raw_hwpoison_page_in_hugepage(struct page *page);
 
+static inline unsigned long huge_page_mask_align(struct file *file)
+{
+	return PAGE_MASK & ~huge_page_mask(hstate_file(file));
+}
+
 #else	/* CONFIG_HUGETLB_PAGE */
 struct hstate {};
 
+static inline unsigned long huge_page_mask_align(struct file *file)
+{
+	return 0;
+}
+
 static inline struct hugepage_subpool *hugetlb_folio_subpool(struct folio *folio)
 {
 	return NULL;
diff --git a/mm/mmap.c b/mm/mmap.c
index b74d2967cfc0..7b623811d82a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -732,6 +732,8 @@ generic_get_unmapped_area(struct file *filp, unsigned long addr,
 	info.length = len;
 	info.low_limit = mm->mmap_base;
 	info.high_limit = mmap_end;
+	if (filp && is_file_hugepages(filp))
+		info.align_mask = huge_page_mask_align(filp);
 	return vm_unmapped_area(&info);
 }
 
@@ -780,6 +782,8 @@ generic_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
 	info.length = len;
 	info.low_limit = PAGE_SIZE;
 	info.high_limit = arch_get_mmap_base(addr, mm->mmap_base);
+	if (filp && is_file_hugepages(filp))
+		info.align_mask = huge_page_mask_align(filp);
 	addr = vm_unmapped_area(&info);
 
 	/*
-- 
2.45.2


