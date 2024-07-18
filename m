Return-Path: <linux-kernel+bounces-256282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D55934C13
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 12:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA46B284E24
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8890F136657;
	Thu, 18 Jul 2024 10:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nvdQENm/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9IkidMmH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nvdQENm/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9IkidMmH"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D68412D745
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 10:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721300357; cv=none; b=WgB9qa95AsBPQT4w7OoYTl2GdOC9ysZk9GYJz51VxrLN2GZ5cCbUoRc44rSOq72Xe/OW+gGvvd56YTViLKaAnZ2xrpGdw6ztwMjeMH18YeP77zrF3SlvP1ppAwzGED+BW+u4VjoAOwcX5GnhyMDTzeJGrvN8Tk4nuviQvLRfQ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721300357; c=relaxed/simple;
	bh=Pt5S5a1N4lm9BD1+YJUC1nSGEeDhZMxvgo/OZAITNd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7niQ5DjCH4LMzmYIfJwtSRCwDciD7GlAN5QQgdFDrFPgw3yeOk2MePcOegrZDwzdANzbeNGRmDDYcvY9jnWHAQXcxgNxpO7FzG+SD9qLrPq4KMTgRlnsRXkvxgS/w941XbgMTYk/3NuqByQRNfTrVAB5rnpC/zwBMmGH7x/hX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nvdQENm/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9IkidMmH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nvdQENm/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9IkidMmH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6CB0421AA9;
	Thu, 18 Jul 2024 10:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721300354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XSQhKhxsB8mJo06ul8PeKZx+ybzEA5hBxV4gU2MOqSA=;
	b=nvdQENm/WtvNG/dv2P5+3UqhZFMf2Y8s0sZ8K90ln3xgURBZ2hb1dnl4Hj6dymaS6b+jUt
	PvjWP0Yg+Do11iu40ovq8B2aGDoLjb7cksW+f3TRLsdwd1MwenIeTnL7yZwh1MuSFLdmkY
	5fA6aeMpteIKD1q8BCV2nXBFlgLpT00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721300354;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XSQhKhxsB8mJo06ul8PeKZx+ybzEA5hBxV4gU2MOqSA=;
	b=9IkidMmHNUBfTTwfSjBvZ3ED1oSXhhnLI2xazYggzQA+zDCLc87V3X7HL0YelcV/xU7nV0
	flWYiVxJq9gr/8BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721300354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XSQhKhxsB8mJo06ul8PeKZx+ybzEA5hBxV4gU2MOqSA=;
	b=nvdQENm/WtvNG/dv2P5+3UqhZFMf2Y8s0sZ8K90ln3xgURBZ2hb1dnl4Hj6dymaS6b+jUt
	PvjWP0Yg+Do11iu40ovq8B2aGDoLjb7cksW+f3TRLsdwd1MwenIeTnL7yZwh1MuSFLdmkY
	5fA6aeMpteIKD1q8BCV2nXBFlgLpT00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721300354;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XSQhKhxsB8mJo06ul8PeKZx+ybzEA5hBxV4gU2MOqSA=;
	b=9IkidMmHNUBfTTwfSjBvZ3ED1oSXhhnLI2xazYggzQA+zDCLc87V3X7HL0YelcV/xU7nV0
	flWYiVxJq9gr/8BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 69839136F7;
	Thu, 18 Jul 2024 10:59:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qBggFYH1mGbnVAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 18 Jul 2024 10:59:13 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Peter Xu <peterx@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Michal Hocko <mhocko@suse.com>,
	Donet Tom <donettom@linux.ibm.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 1/9] mm/mmap: Teach generic_get_unmapped_area{_topdown} to handle hugetlb mappings
Date: Thu, 18 Jul 2024 12:58:55 +0200
Message-ID: <20240718105903.19617-2-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240718105903.19617-1-osalvador@suse.de>
References: <20240718105903.19617-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: 1.20
X-Spamd-Result: default: False [1.20 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: *

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
index 2b3c3a404769..1c7b0b32ff7e 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1029,9 +1029,19 @@ void hugetlb_unregister_node(struct node *node);
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
index 83b4682ec85c..09131b705e7b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1743,6 +1743,8 @@ generic_get_unmapped_area(struct file *filp, unsigned long addr,
 	info.length = len;
 	info.low_limit = mm->mmap_base;
 	info.high_limit = mmap_end;
+	if (filp && is_file_hugepages(filp))
+		info.align_mask = huge_page_mask_align(filp);
 	return vm_unmapped_area(&info);
 }
 
@@ -1791,6 +1793,8 @@ generic_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
 	info.length = len;
 	info.low_limit = PAGE_SIZE;
 	info.high_limit = arch_get_mmap_base(addr, mm->mmap_base);
+	if (filp && is_file_hugepages(filp))
+		info.align_mask = huge_page_mask_align(filp);
 	addr = vm_unmapped_area(&info);
 
 	/*
-- 
2.45.2


