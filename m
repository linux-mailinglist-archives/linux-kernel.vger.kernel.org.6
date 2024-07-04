Return-Path: <linux-kernel+bounces-240522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92649926E75
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5AAD1C248BA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02122145B27;
	Thu,  4 Jul 2024 04:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QpIyFU+S";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="udDCKM8V";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QpIyFU+S";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="udDCKM8V"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C6F14658A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067553; cv=none; b=kXlNGguLhShlhraBkPvdsXd+Fl6rEBmmq8SLN66+4kk6PPLCBC/gENjlH1EPpJknIsiIjl4AxdKf3/uct2s2PYcuPExpfT3UeCCR+CBjNkfViiR0X/kdDXqOI++8VlRnjdtBvO52C/TWrSsNwfk/XCFK/fdwT5+Y9yr1u3zyBms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067553; c=relaxed/simple;
	bh=IuTB4L1ipAkwfZoHCTo5/wLkUzpL+5baXkSV6FyuYB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hee+n9qf6i7KtQxR1ERse5uFgnI7QoyRlH9Mp44lzNkTrv+kExchHe5aJ/4/tIFLiYLcW4OK7Hx1qqcuTggPf8IsGCPKHU661n9dtNReLzbHGDXyz1DJMNih71U1Q2xmPlUSSYXOHCLMKLLEwLfxzA6OnWm6nEWgH46lvvFnOQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QpIyFU+S; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=udDCKM8V; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QpIyFU+S; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=udDCKM8V; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5024D21C12;
	Thu,  4 Jul 2024 04:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720067549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hlyc02hswOFBPpFjPMKLH2SPKevIA4btQnEnfz8PzX8=;
	b=QpIyFU+SNEDWpoiZMvudIRFmIbkNPlPQAdHO8szaEcTZHDv7mQap7dxr0MNsVTThx2cHcx
	jhq/PHrBd4eT+7TOlVKBNgQLFqsLoSzcymO1iD3cWeXTiS0+9wXL7guAJDapk88hwYPbsN
	UXGfJEukOZwgFWGHbc1yAGUFbMmlXQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720067549;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hlyc02hswOFBPpFjPMKLH2SPKevIA4btQnEnfz8PzX8=;
	b=udDCKM8VSh5fm40PS9NUBV30hL3Hc21Fph1pBda42Ie9OAKZOIyY5YZKKy4Vasv/sNi9T4
	b+SyyOfTIIs5xDDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720067549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hlyc02hswOFBPpFjPMKLH2SPKevIA4btQnEnfz8PzX8=;
	b=QpIyFU+SNEDWpoiZMvudIRFmIbkNPlPQAdHO8szaEcTZHDv7mQap7dxr0MNsVTThx2cHcx
	jhq/PHrBd4eT+7TOlVKBNgQLFqsLoSzcymO1iD3cWeXTiS0+9wXL7guAJDapk88hwYPbsN
	UXGfJEukOZwgFWGHbc1yAGUFbMmlXQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720067549;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hlyc02hswOFBPpFjPMKLH2SPKevIA4btQnEnfz8PzX8=;
	b=udDCKM8VSh5fm40PS9NUBV30hL3Hc21Fph1pBda42Ie9OAKZOIyY5YZKKy4Vasv/sNi9T4
	b+SyyOfTIIs5xDDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3048813889;
	Thu,  4 Jul 2024 04:32:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kBsMB9wlhmbnDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jul 2024 04:32:28 +0000
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
Subject: [PATCH 31/45] mm/mincore: Create mincore_pud_range to handle PUD-mapped hugetlb vmas
Date: Thu,  4 Jul 2024 06:31:18 +0200
Message-ID: <20240704043132.28501-32-osalvador@suse.de>
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
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spam-Flag: NO
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

Normal THP cannot be PUD-mapped (besides devmap), but hugetlb can, so create
mincore_pud_range in order to handle PUD-mapped hugetlb vmas.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/mincore.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/mm/mincore.c b/mm/mincore.c
index 5154bc705f60..786df7246899 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -98,6 +98,25 @@ static int mincore_unmapped_range(unsigned long addr, unsigned long end,
 	return 0;
 }
 
+static int mincore_pud_range(pud_t *pud, unsigned long addr, unsigned long end,
+			     struct mm_walk *walk)
+{
+#ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
+	spinlock_t *ptl;
+	unsigned char *vec = walk->private;
+	int nr = (end - addr) >> PAGE_SHIFT;
+	struct vm_area_struct *vma = walk->vma;
+
+	ptl = pud_huge_lock(pud, vma);
+	if (!ptl)
+		return 0;
+
+	memset(vec, 1, nr);
+	spin_unlock(ptl);
+#endif
+	return 0;
+}
+
 static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 			struct mm_walk *walk)
 {
@@ -175,6 +194,7 @@ static inline bool can_do_mincore(struct vm_area_struct *vma)
 }
 
 static const struct mm_walk_ops mincore_walk_ops = {
+	.pud_entry		= mincore_pud_range,
 	.pmd_entry		= mincore_pte_range,
 	.pte_hole		= mincore_unmapped_range,
 	.hugetlb_entry		= mincore_hugetlb,
-- 
2.26.2


