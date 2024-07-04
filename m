Return-Path: <linux-kernel+bounces-240520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 744B2926E73
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAAA3B255F4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC89146003;
	Thu,  4 Jul 2024 04:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vi5KLgdE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PNL9w7HV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vi5KLgdE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PNL9w7HV"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86443145B27
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067550; cv=none; b=ryBi5CZygoC6V4mmmvBPktk6jtTIZ4aZJdsqeNa5adnN9Hp+qaSZABwOfheKPqoU32RCFK61+WkAQ17bNPinrsEVBUzd1eluCaLwgRNeTNMOo53uySscsENCmA0E6OewPYFqnvcoFQytY7/tzdICuGXahalRL2IqTbcVyh5XOIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067550; c=relaxed/simple;
	bh=yGVKT+2M/8fGKrJ24xpO8G0WwuoeWGAspio7/eAfg+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IBDefR2KSfm4eQu1kxuCS2GFW3B4NWih94nMc6vz1biWpJgRxYyNELPyz2ehar/q//CnCJ5l7HGO9cHCzFFOOywacGFwyXQdhQeD6UJrNoC2DYtmxp4cT3DnxGeuuvlXq1YScAN9+e56/TFmOHjWaXURlP3vW0fnuKK16BuaUHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vi5KLgdE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PNL9w7HV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vi5KLgdE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PNL9w7HV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BBF8521C0D;
	Thu,  4 Jul 2024 04:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720067546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Eaq4YS+I2JMNj2PlLYmITmw1dUtdxAYyfPBt6d+VGg=;
	b=vi5KLgdENdkrnyeebmRYr1GTUMnsDQhLSyx0si8djR9aeKoZAFXDbChioD9oLU5n2WEp19
	sZ/1YXnUx4zsqmQaqBABY+2OXBM8pE0ZclE7Xl4ENMKN82fsQA0jjs9APgzard6WS/Yweg
	oOQsVALT38rdOWZXcSnlqZBgxaDhVAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720067546;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Eaq4YS+I2JMNj2PlLYmITmw1dUtdxAYyfPBt6d+VGg=;
	b=PNL9w7HV1zFYjASnMOA/fooIqae95dSIt4v71VfIDGS0e9g8E4lsal0N9CyLMaXb/wifCJ
	M4zsefGx9x+meuCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720067546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Eaq4YS+I2JMNj2PlLYmITmw1dUtdxAYyfPBt6d+VGg=;
	b=vi5KLgdENdkrnyeebmRYr1GTUMnsDQhLSyx0si8djR9aeKoZAFXDbChioD9oLU5n2WEp19
	sZ/1YXnUx4zsqmQaqBABY+2OXBM8pE0ZclE7Xl4ENMKN82fsQA0jjs9APgzard6WS/Yweg
	oOQsVALT38rdOWZXcSnlqZBgxaDhVAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720067546;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Eaq4YS+I2JMNj2PlLYmITmw1dUtdxAYyfPBt6d+VGg=;
	b=PNL9w7HV1zFYjASnMOA/fooIqae95dSIt4v71VfIDGS0e9g8E4lsal0N9CyLMaXb/wifCJ
	M4zsefGx9x+meuCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACDBD13889;
	Thu,  4 Jul 2024 04:32:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WC9sJdklhmbnDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jul 2024 04:32:25 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Peter Xu <peterx@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	SeongJae Park <sj@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Michal Hocko <mhocko@suse.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 29/45] mm/damon: Create damon_mkold_pud_entry to handle PUD-mapped hugetlb vmas
Date: Thu,  4 Jul 2024 06:31:16 +0200
Message-ID: <20240704043132.28501-30-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240704043132.28501-1-osalvador@suse.de>
References: <20240704043132.28501-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_RATELIMIT(0.00)[to_ip_from(RLghcz9uomn9ay1xnuhrww8uur)];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 

Normal THP cannot be PUD-mapped (besides devmap), but hugetlb can, so create
damon_mkold_pud_entry in order to handle PUD-mapped hugetlb vmas.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/damon/vaddr.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 47c84cdda32c..6a383ce5a775 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -329,6 +329,37 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 	return 0;
 }
 
+static int damon_mkold_pud_entry(pmd_t *pud, unsigned long addr,
+				 unsigned long next, struct mm_walk *walk)
+{
+#ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
+	spinlock_t *ptl;
+	struct folio *folio;
+	struct vm_area_struct *vma = walk->vma;
+	unsigned long size = huge_page_size(hstate_vma(vma));
+
+	ptl = pud_huge_lock(vma, pud);
+	if (!ptl)
+		return 0;
+
+	if (!pud_present(*pud))
+		goto out;
+
+	folio = pfn_folio(pud_pfn(*pud));
+	folio_get(folio);
+
+	if (pudp_test_and_clear_young(vma, addr, pud) ||
+	    mmu_notifier_clear_young(mm, addr, addr + size))
+		folio_set_young(folio);
+
+	folio_set_idle(folio);
+	folio_put(folio);
+out:
+	spin_unlock(ptl);
+#endif
+	return 0;
+}
+
 #ifdef CONFIG_HUGETLB_PAGE
 static void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
 				struct vm_area_struct *vma, unsigned long addr)
@@ -383,6 +414,7 @@ static int damon_mkold_hugetlb_entry(pte_t *pte, unsigned long hmask,
 #endif /* CONFIG_HUGETLB_PAGE */
 
 static const struct mm_walk_ops damon_mkold_ops = {
+	.pud_entry = damon_mkold_pud_entry,
 	.pmd_entry = damon_mkold_pmd_entry,
 	.hugetlb_entry = damon_mkold_hugetlb_entry,
 	.walk_lock = PGWALK_RDLOCK,
-- 
2.26.2


