Return-Path: <linux-kernel+bounces-240524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A13926E77
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7CFC1F24EE1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EC4146A83;
	Thu,  4 Jul 2024 04:32:35 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDB745000
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067555; cv=none; b=USfFBnTCr/7GvtSue3lImn8TKPVpWB9+kyD/JDFmMzfs8JxMifGr29yxdCTJoWN9IcCQktvEkx0yZfaCfham8PETUDjulxZ4SGUX1js84TyTl8fIRKelYz88Kfx7nSAKoCVt2ghGqHZpHd+QhxEJhDuUf0GaiBllKF3NOmAhbLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067555; c=relaxed/simple;
	bh=b9RoC8BUyBgraGZurHs62mAW314Bvdf9N/tMXnfaIpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4sJHlLurCBtvP901lhly2e9pKIzLkNzeE7KxAA+n70Iuohx+itHSXTI5hoc+hYqpnYGPfqmjvjamQN8S3Okr8/oKElJqvs91rU+m6dbGoGQjMw4UpcMjzttq+4TvHkH4F4QAD51mU3Rr8ckwxx0eswZUTmvop844kw3HoY/H7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D6F111FCF7;
	Thu,  4 Jul 2024 04:32:31 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B441C13889;
	Thu,  4 Jul 2024 04:32:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8OBhJ94lhmbnDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jul 2024 04:32:30 +0000
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
Subject: [PATCH 33/45] mm/hmm: Enable hmm_vma_walk_pud to handle PUD-mapped hugetlb vmas
Date: Thu,  4 Jul 2024 06:31:20 +0200
Message-ID: <20240704043132.28501-34-osalvador@suse.de>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: D6F111FCF7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

Normal THP cannot be PUD-mapped (besides devmap), but hugetlb can,
so enable hmm_vma_walk_pud to handle PUD-mapped hugetlb vmas.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/hmm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index fbee08973544..2b752f703b6d 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -396,8 +396,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 	return 0;
 }
 
-#if defined(CONFIG_ARCH_HAS_PTE_DEVMAP) && \
-    defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
+#if (defined(CONFIG_ARCH_HAS_PTE_DEVMAP) || defined (CONFIG_PGTABLE_HAS_HUGE_LEAVES))
 static inline unsigned long pud_to_hmm_pfn_flags(struct hmm_range *range,
 						 pud_t pud)
 {
@@ -429,7 +428,7 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
 		return hmm_vma_walk_hole(start, end, -1, walk);
 	}
 
-	if (pud_leaf(pud) && pud_devmap(pud)) {
+	if (pud_leaf(pud)) {
 		unsigned long i, npages, pfn;
 		unsigned int required_fault;
 		unsigned long *hmm_pfns;
-- 
2.26.2


