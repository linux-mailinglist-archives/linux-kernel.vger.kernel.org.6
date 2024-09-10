Return-Path: <linux-kernel+bounces-322595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E626D972B56
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14F821C23EF8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D898E184535;
	Tue, 10 Sep 2024 08:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="P3HH/9Ve";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6+VaV++W";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="P3HH/9Ve";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6+VaV++W"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8A313AA32
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 08:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725955253; cv=none; b=uE0hJQe0ZlwASmWEOaWeZ9TDrRr2kGDsIyVo0+JGWfO9rHBtbuLP/X24TrgcW0BzIQm/AQJWI8dazZBnRhLYQ27HNpFpY7sXIJlSNxyVJv9u7oUw/b7r4w5JdpVbUOZVyw4+pO/Ji00AYQ6DJ6YGge0SV4WjIGznoKEbWw62gYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725955253; c=relaxed/simple;
	bh=pqoaLw1t9RK9CZsOwL8Ql0wF8GPNRmejWUcFpoXzbx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4KJoWr9uvDHGg1G+0pWDI4Qe/fHGLxhSUFyO3yrTj+0+pjQW5ZkIRAuIjzMQRADjJvZvHg3/r/QwaNiffFzI1nbhJATh6t4iA+v9d3Aj5WPpOKgcCSxdX4KWY8ThKuQ1RxvVpMRVSOqqB4qSmr3LRNCsD4MHet27lmph+2006o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=P3HH/9Ve; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6+VaV++W; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=P3HH/9Ve; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6+VaV++W; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 72B111F80A;
	Tue, 10 Sep 2024 08:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725955249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dh8ID66bUaRGXz2gnq8rzcTDLeuCZFk4H+eROj1OqJY=;
	b=P3HH/9VeO7/hs9W02KLJGbUQbz6TwJPMh5eQ2KsOessc88XZDb+B6rbkgJV7KGjJn2IK5n
	WwCZ4BHpYGeWoIN4Ie98Txw3mHCx4CHPS5VeOI1MGATKiQFg45BqH1XQVwFWME2xGaWt78
	tzuUkn6bEwf6leksfA/2wbq3i2lZctU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725955249;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dh8ID66bUaRGXz2gnq8rzcTDLeuCZFk4H+eROj1OqJY=;
	b=6+VaV++WekZwnCQTHieIrPzmnni7tH8IuusN+gNlU2UPhwMNZ6FIBnLeq4wzMa7ZyDqDBr
	Dalx+1Wzn0NIrvBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="P3HH/9Ve";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6+VaV++W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725955249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dh8ID66bUaRGXz2gnq8rzcTDLeuCZFk4H+eROj1OqJY=;
	b=P3HH/9VeO7/hs9W02KLJGbUQbz6TwJPMh5eQ2KsOessc88XZDb+B6rbkgJV7KGjJn2IK5n
	WwCZ4BHpYGeWoIN4Ie98Txw3mHCx4CHPS5VeOI1MGATKiQFg45BqH1XQVwFWME2xGaWt78
	tzuUkn6bEwf6leksfA/2wbq3i2lZctU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725955249;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dh8ID66bUaRGXz2gnq8rzcTDLeuCZFk4H+eROj1OqJY=;
	b=6+VaV++WekZwnCQTHieIrPzmnni7tH8IuusN+gNlU2UPhwMNZ6FIBnLeq4wzMa7ZyDqDBr
	Dalx+1Wzn0NIrvBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC6E113A8F;
	Tue, 10 Sep 2024 08:00:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KOYuJ7D832Y2MQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 10 Sep 2024 08:00:48 +0000
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
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v3 1/9] mm/mmap: Teach generic_get_unmapped_area{_topdown} to handle hugetlb mappings
Date: Tue, 10 Sep 2024 10:00:22 +0200
Message-ID: <20240910080030.1272373-2-osalvador@suse.de>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910080030.1272373-1-osalvador@suse.de>
References: <20240910080030.1272373-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 72B111F80A
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

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
index e4697539b665..368d552e4860 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1035,9 +1035,19 @@ void hugetlb_unregister_node(struct node *node);
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
index 270bd8d504b8..5f05df7d58f5 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -776,6 +776,8 @@ generic_get_unmapped_area(struct file *filp, unsigned long addr,
 	info.low_limit = mm->mmap_base;
 	info.high_limit = mmap_end;
 	info.start_gap = stack_guard_placement(vm_flags);
+	if (filp && is_file_hugepages(filp))
+		info.align_mask = huge_page_mask_align(filp);
 	return vm_unmapped_area(&info);
 }
 
@@ -826,6 +828,8 @@ generic_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
 	info.low_limit = PAGE_SIZE;
 	info.high_limit = arch_get_mmap_base(addr, mm->mmap_base);
 	info.start_gap = stack_guard_placement(vm_flags);
+	if (filp && is_file_hugepages(filp))
+		info.align_mask = huge_page_mask_align(filp);
 	addr = vm_unmapped_area(&info);
 
 	/*
-- 
2.46.0


