Return-Path: <linux-kernel+bounces-240528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E7F926E7B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43BC51C22A6F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FECF47F46;
	Thu,  4 Jul 2024 04:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FLLFrGlR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Xn+qmriL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FLLFrGlR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Xn+qmriL"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF12B1474D9
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067560; cv=none; b=VWVi4Rlzinsz7M3qof2CWV98gqBMhE1pzWPuUw7yQJGq/jjJF9FmO3dWR0y22KOqAGLwLR2Av0RsmryPrji4JhwgacNH2FCDRuzNYTShWGOK+zgQEsnGd8YaYVkNQLzolG/QH8WhWM0Yt3pnfOkyYMPQ5dXKqKgGrq7h4iPMPnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067560; c=relaxed/simple;
	bh=sQejekRUyVvof6FFs+sGP7fR828TdGKbEu0/e+tUYR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3cIaMnaADCl5OAqqhs+dMjzBGBImc6jeIrpSdO8fn6ddymYgZys9RqSbFwk0sRYHb/NEd5d9VaCZ5rTz+/J9RcxmPYmAa0hlYlQ3g4Ox8M/TXMg3N2aHA+E1Rh28H0jdPlrzf/rBaznQwfAm2YUqayVbBH+SLRNhXgWdUF5+fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FLLFrGlR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Xn+qmriL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FLLFrGlR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Xn+qmriL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 166C121C0D;
	Thu,  4 Jul 2024 04:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720067557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Nyp1GchWN9j9DCiswMlchcq+0OOi/ydZqtxsOmg3fI=;
	b=FLLFrGlRYQvTCYxVLiVDlOvcqdI03sK7tsIHp0UaVD2y3rWv0sfPku+5j1Sb+TGxATnbIj
	2SvrEeBnu35COLNGzRhuWQiuv+d1fMu1ZxIzeBld3MHcaPV5255bX31dpcaYpS7sxPB+yj
	Wh3sG0PCXGnABuZy8kGWiY/fHIKMyn0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720067557;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Nyp1GchWN9j9DCiswMlchcq+0OOi/ydZqtxsOmg3fI=;
	b=Xn+qmriLdnNRRO+exHfJ7IQkKp73CpsQ6YRsMlGxYx0y8gyUntE4TOjbftU2SpDj9j99UM
	4IbKv/L2PFMFs+CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720067557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Nyp1GchWN9j9DCiswMlchcq+0OOi/ydZqtxsOmg3fI=;
	b=FLLFrGlRYQvTCYxVLiVDlOvcqdI03sK7tsIHp0UaVD2y3rWv0sfPku+5j1Sb+TGxATnbIj
	2SvrEeBnu35COLNGzRhuWQiuv+d1fMu1ZxIzeBld3MHcaPV5255bX31dpcaYpS7sxPB+yj
	Wh3sG0PCXGnABuZy8kGWiY/fHIKMyn0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720067557;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Nyp1GchWN9j9DCiswMlchcq+0OOi/ydZqtxsOmg3fI=;
	b=Xn+qmriLdnNRRO+exHfJ7IQkKp73CpsQ6YRsMlGxYx0y8gyUntE4TOjbftU2SpDj9j99UM
	4IbKv/L2PFMFs+CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DDB1513889;
	Thu,  4 Jul 2024 04:32:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QI6DMOMlhmbnDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jul 2024 04:32:35 +0000
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
Subject: [PATCH 37/45] mm/lock: Make mlock_test_walk skip hugetlb vmas
Date: Thu,  4 Jul 2024 06:31:24 +0200
Message-ID: <20240704043132.28501-38-osalvador@suse.de>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_RATELIMIT(0.00)[to_ip_from(RLghcz9uomn9ay1xnuhrww8uur)];
	RCVD_TLS_ALL(0.00)[]

Skip hugetlb vmas as we are not interested in those.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/mlock.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/mlock.c b/mm/mlock.c
index 52d6e401ad67..b37079b3505f 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -409,6 +409,17 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 	return 0;
 }
 
+static int mlock_test_walk(unsigned long start, unsigned long end,
+			   struct mm_walk *walk)
+{
+	struct vm_area_struct *vma = walk->vma;
+
+	if (is_vm_hugetlb_page(vma))
+		return 1;
+
+	return 0;
+}
+
 /*
  * mlock_vma_pages_range() - mlock any pages already in the range,
  *                           or munlock all pages in the range.
@@ -425,6 +436,7 @@ static void mlock_vma_pages_range(struct vm_area_struct *vma,
 {
 	static const struct mm_walk_ops mlock_walk_ops = {
 		.pmd_entry = mlock_pte_range,
+		.test_walk = mlock_test_walk,
 		.walk_lock = PGWALK_WRLOCK_VERIFY,
 	};
 
-- 
2.26.2


