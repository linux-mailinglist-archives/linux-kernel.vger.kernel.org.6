Return-Path: <linux-kernel+bounces-240493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66525926E55
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2990C284DC2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A8F29415;
	Thu,  4 Jul 2024 04:31:55 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0A7E576
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067515; cv=none; b=PyDQOYefUq0+U4V/aEGntMBlr7gosVxu78kjDcar7/g3l18VDIuelPWRzMmPGgeVzwkZWThhy+Igici1VLjM73aogebEc8mTframT+G3z32et9Kdkh8m5pLV2vnUqd5forOuWdkrRXcIgFZDz/RFVx8XsAPtSQwFOsfMtNqbgt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067515; c=relaxed/simple;
	bh=X+DjluLDjuDVWuMonHQsdMe5Vi1xaH24OGLhrKHXLUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vygf2ViCZRjLW2emMODwAxSPz2msa48DFEYUI9KECT52lg60vuZ0uMvszHjBFbRI1TDuIlG37r0HcUosfEkuqG1LPXKt57X5w6YTAx9eirHM4usALR7Ff+qms9DjPveXhzPzMJXqRWCg8ikz6JHdv0xJmr9LlmMOPKvXnxFSOmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D75C521C0D;
	Thu,  4 Jul 2024 04:31:51 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B7C9513889;
	Thu,  4 Jul 2024 04:31:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MGmJKLYlhmbnDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jul 2024 04:31:50 +0000
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
Subject: [PATCH 02/45] mm: Add {pmd,pud}_huge_lock helper
Date: Thu,  4 Jul 2024 06:30:49 +0200
Message-ID: <20240704043132.28501-3-osalvador@suse.de>
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
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: D75C521C0D
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Deep down hugetlb and thp use the same lock for pud and pmd.
Create two helpers that can be directly used by both of them,
as they will be used in the generic pagewalkers.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/mm_inline.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index f4fe593c1400..93e3eb86ef4e 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -9,6 +9,7 @@
 #include <linux/string.h>
 #include <linux/userfaultfd_k.h>
 #include <linux/swapops.h>
+#include <linux/hugetlb.h>
 
 /**
  * folio_is_file_lru - Should the folio be on a file LRU or anon LRU?
@@ -590,4 +591,30 @@ static inline bool vma_has_recency(struct vm_area_struct *vma)
 	return true;
 }
 
+static inline spinlock_t *pmd_huge_lock(pmd_t *pmd, struct vm_area_struct *vma)
+{
+	spinlock_t *ptl;
+
+	if (pmd_leaf(*pmd)) {
+		ptl = pmd_lock(vma->vm_mm, pmd);
+		if (pmd_leaf(*pmd))
+			return ptl;
+		spin_unlock(ptl);
+	}
+	return NULL;
+}
+
+static inline spinlock_t *pud_huge_lock(pud_t *pud, struct vm_area_struct *vma)
+{
+	spinlock_t *ptl = pud_lock(vma->vm_mm, pud);
+
+	if (pud_leaf(*pud)) {
+		ptl = pud_lock(vma->vm_mm, pud);
+		if (pud_leaf(*pud))
+			return ptl;
+		spin_unlock(ptl);
+	}
+	return NULL;
+}
+
 #endif
-- 
2.26.2


