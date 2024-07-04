Return-Path: <linux-kernel+bounces-240510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0757926E67
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D359F1C23721
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7C4143C56;
	Thu,  4 Jul 2024 04:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="j2uGj66F";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aF1AIMEQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="j2uGj66F";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aF1AIMEQ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C98143759
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067537; cv=none; b=A/yLQouyhxfQ7ybzBwCPuDTP0I4fpBNVyqYHJzaj9PrCg0YJBQn5u1hR3qrUyRbRvXRc3BarzBxXitzD0trk4qaDtIRt1mZwi8volmdy6V4gy4ofxNvAttN2nTF096Jyej81HUUDQbiOmOEsaHCMtS2C17Z0YTAcf3GmHdKPIhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067537; c=relaxed/simple;
	bh=3uhKxR7Ge9aSjaaOQuskOvkTvX/X/MJEsg8TVZDJwGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNWrbjo2T5S/sW4/PVUpXhfTyUcnTcFkYmq/EVCAO7vJ8w7i2NJZGgqHehu0NdQrQPdZRkXzDxiXW++2ZHUdOkleKLsMYKo/JmMzZ+HuUcTYqSg1ba6xit5YqJv0B4jJxNX5g2oh7uS0jK9DBmoWhKE1zQYbnNfyQitVdtIi/g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=j2uGj66F; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aF1AIMEQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=j2uGj66F; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aF1AIMEQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 053031FCFC;
	Thu,  4 Jul 2024 04:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720067534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wUAXkDKulvUPvsNZqyUfVRpX873YTDqHqTEgZWFzyt4=;
	b=j2uGj66FrtGxFBiwFctbDQ4OTG+w9M73dH62olOmsLGZIhnPfy8i6BSi1M1uU7Z995dm0M
	rDy3fOSDZiLRMBRFvYSwMC3MWiBIZt60dh4cyu70ITZlu4RYz92tsp3lGRkhC2d9EZ2fgM
	G1/oiZiEwG0JggCZhXJlACHwMP0ZVFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720067534;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wUAXkDKulvUPvsNZqyUfVRpX873YTDqHqTEgZWFzyt4=;
	b=aF1AIMEQj6zRqtFUbpMf5dtjXnB1Crkf8BYEYuKhtpIYT+dX14+NYfft0LEejATVkvxiN5
	/oB961ArpbntQiAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720067534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wUAXkDKulvUPvsNZqyUfVRpX873YTDqHqTEgZWFzyt4=;
	b=j2uGj66FrtGxFBiwFctbDQ4OTG+w9M73dH62olOmsLGZIhnPfy8i6BSi1M1uU7Z995dm0M
	rDy3fOSDZiLRMBRFvYSwMC3MWiBIZt60dh4cyu70ITZlu4RYz92tsp3lGRkhC2d9EZ2fgM
	G1/oiZiEwG0JggCZhXJlACHwMP0ZVFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720067534;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wUAXkDKulvUPvsNZqyUfVRpX873YTDqHqTEgZWFzyt4=;
	b=aF1AIMEQj6zRqtFUbpMf5dtjXnB1Crkf8BYEYuKhtpIYT+dX14+NYfft0LEejATVkvxiN5
	/oB961ArpbntQiAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD98813889;
	Thu,  4 Jul 2024 04:32:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WFxbMcwlhmbnDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jul 2024 04:32:12 +0000
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
Subject: [PATCH 19/45] fs/proc: Enable gather_pte_stats to handle hugetlb vmas
Date: Thu,  4 Jul 2024 06:31:06 +0200
Message-ID: <20240704043132.28501-20-osalvador@suse.de>
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

PMD-mapped hugetlb vmas will also reach gather_pte_stats.
Add the required code so it knows how to handle those there.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 fs/proc/task_mmu.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 3785a44b97fa..e13754d3246e 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -3141,7 +3141,7 @@ static struct page *can_gather_numa_stats(pte_t pte, struct vm_area_struct *vma,
 	return page;
 }
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
 static struct page *can_gather_numa_stats_pmd(pmd_t pmd,
 					      struct vm_area_struct *vma,
 					      unsigned long addr)
@@ -3176,15 +3176,21 @@ static int gather_pte_stats(pmd_t *pmd, unsigned long addr,
 	pte_t *orig_pte;
 	pte_t *pte;
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	ptl = pmd_trans_huge_lock(pmd, vma);
+#ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
+	ptl = pmd_huge_lock(pmd, vma);
 	if (ptl) {
+		unsigned long nr_pages;
 		struct page *page;
 
+		if (is_vm_hugetlb_page(vma))
+			nr_pages = 1;
+		else
+			nr_pages = HPAGE_PMD_SIZE / PAGE_SIZE;
+
 		page = can_gather_numa_stats_pmd(*pmd, vma, addr);
 		if (page)
 			gather_stats(page, md, pmd_dirty(*pmd),
-				     HPAGE_PMD_SIZE/PAGE_SIZE);
+				     nr_pages);
 		spin_unlock(ptl);
 		return 0;
 	}
-- 
2.26.2


