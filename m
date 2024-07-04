Return-Path: <linux-kernel+bounces-240498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CECDD926E5B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D824B22C63
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10C973445;
	Thu,  4 Jul 2024 04:32:01 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B5E3B782
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067521; cv=none; b=Qql6nqiR2AtuY2bNf9Oh0pX7ZOeWL1crdfRiQqVZuVFpcndb0snUK11IvakKb8toulTU6D1Of8Rq+6KsW2zYf6Bza7HEprzkIOBHXsNMrysgpeMuCQMmrU2Y+dX+9f+VPsw7KAVZHF8z+fbIwFD6OpzylXM3P5KoE1krJt5jAd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067521; c=relaxed/simple;
	bh=2G6muL+WZqZUb4vEJ8WHsrXsy6VoC9mI/aYzlVAX5uU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b5LCjTkRK4sSHavt3vyZbrOKehXO5MJehq5VCySyKxg4D6EaZH8CJ2J06JDjepVIUB62SmIVR/n+ufr+AS3u2s9TkJr13lmwQM18H8DTGd5cdQ93K5BKehOK/8+5us8UtE9yOUldCP++PJ3g1KifxNuM3hT+dXapxiSg3ofFBnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3F26421C12;
	Thu,  4 Jul 2024 04:31:58 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 270FD13889;
	Thu,  4 Jul 2024 04:31:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0IRfBb0lhmbnDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jul 2024 04:31:57 +0000
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
Subject: [PATCH 07/45] arch/s390: Enable __s390_enable_skey_pmd to handle hugetlb vmas
Date: Thu,  4 Jul 2024 06:30:54 +0200
Message-ID: <20240704043132.28501-8-osalvador@suse.de>
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
X-Rspamd-Queue-Id: 3F26421C12
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

__s390_enable_skey_pmd does nothing for THP, but will handle pmd-leafs
hugetlb vmas from now onwards, so teach it how to handle those.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 arch/s390/mm/gmap.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 474a25ca5c48..e1d098dc7f07 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2723,6 +2723,20 @@ static int __s390_enable_skey_pte(pte_t *pte, unsigned long addr,
 static int __s390_enable_skey_pmd(pmd_t *pmd, unsigned long addr,
 				  unsigned long next, struct mm_walk *walk)
 {
+	if (pmd_leaf(*pmd) && is_vm_hugetlb_page(vma))
+		unsigned long start, end;
+		struct page *page = pmd_page(*pmd);
+
+		if (pmd_val(*pmd) & _SEGMENT_ENTRY_INVALID ||
+		    !(pmd_val(*pmd) & _SEGMENT_ENTRY_WRITE))
+			return 0;
+
+		start = pmd_val(*pmd) & HPAGE_MASK;
+		end = start + HPAGE_SIZE;
+		__storage_key_init_range(start, end);
+		set_bit(PG_arch_1, &page->flags);
+	}
+
 	cond_resched();
 	return 0;
 }
-- 
2.26.2


