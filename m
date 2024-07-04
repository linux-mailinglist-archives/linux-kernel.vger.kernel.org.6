Return-Path: <linux-kernel+bounces-240494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E864926E56
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B09284DA6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E531642A99;
	Thu,  4 Jul 2024 04:31:56 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2CD2110E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067516; cv=none; b=PtUR4ntNL+w4htnsVO3lh0GGY7c+PHIbEag3816kBkBrvIdku11dOVG3tnksMqGbiKPo6ZhFhkAOYrKYL8Gatb9jJO2nO8ND9dR5JDDaOV2qgAW6EQNzDUU30+1SpHEwCA9EkLmROxBJpVpNDWMkB/WpbiV0J2L3Er3HMeaYtSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067516; c=relaxed/simple;
	bh=m9zPXLXTm/mgl/dYIUFDktPz6b3OWubcd5U7cMa8rxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+7MxQViVxsi6H9i+fEN1oho/w5dwc4tcid6RhpP7YsB+xjAIJWJ2o96zhj7VnqIg2zmA7ZtXuKaRAxGwaZCb7ig90YTshBgPTHa5vXUuMeCfLMWvEf47Y24JH+CnMf/J9Zn94EF4Uj0WdTwdv9RrhzXKRNd7WuKonBOcQDcpZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 359EE21180;
	Thu,  4 Jul 2024 04:31:53 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 044A513889;
	Thu,  4 Jul 2024 04:31:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4D3mN7clhmbnDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jul 2024 04:31:51 +0000
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
Subject: [PATCH 03/45] mm/pagewalk: Move vma_pgtable_walk_begin and vma_pgtable_walk_end upfront
Date: Thu,  4 Jul 2024 06:30:50 +0200
Message-ID: <20240704043132.28501-4-osalvador@suse.de>
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
X-Rspamd-Queue-Id: 359EE21180
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

In order to prepare walk_pgd_range for handling hugetlb pages, move
the hugetlb vma locking into __walk_page_range.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/pagewalk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index ae2f08ce991b..eba705def9a0 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -269,7 +269,6 @@ static int walk_hugetlb_range(unsigned long addr, unsigned long end,
 	const struct mm_walk_ops *ops = walk->ops;
 	int err = 0;
 
-	hugetlb_vma_lock_read(vma);
 	do {
 		next = hugetlb_entry_end(h, addr, end);
 		pte = hugetlb_walk(vma, addr & hmask, sz);
@@ -280,7 +279,6 @@ static int walk_hugetlb_range(unsigned long addr, unsigned long end,
 		if (err)
 			break;
 	} while (addr = next, addr != end);
-	hugetlb_vma_unlock_read(vma);
 
 	return err;
 }
@@ -339,11 +337,13 @@ static int __walk_page_range(unsigned long start, unsigned long end,
 			return err;
 	}
 
+	vma_pgtable_walk_begin(vma);
 	if (is_vm_hugetlb_page(vma)) {
 		if (ops->hugetlb_entry)
 			err = walk_hugetlb_range(start, end, walk);
 	} else
 		err = walk_pgd_range(start, end, walk);
+	vma_pgtable_walk_end(vma);
 
 	if (ops->post_vma)
 		ops->post_vma(walk);
-- 
2.26.2


